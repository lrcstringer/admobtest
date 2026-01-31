import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../domain/entities/referral.dart';
import '../../models/referral_model.dart';

abstract class ReferralRemoteDataSource {
  /// Get user's referral code
  Future<String> getReferralCode();

  /// Get referral stats
  Future<ReferralStatsModel> getReferralStats();

  /// Get referral list
  Future<List<ReferralModel>> getReferrals({
    ReferralStatus? status,
    int? limit,
    DateTime? startAfter,
  });

  /// Stream referrals
  Stream<List<ReferralModel>> watchReferrals();

  /// Get referral by ID
  Future<ReferralModel> getReferralById(String referralId);

  /// Apply referral code (as referee)
  Future<ReferralModel> applyReferralCode(String code);

  /// Generate shareable referral link
  Future<String> generateShareableLink();

  /// Share referral via platform
  Future<void> shareReferral({
    required String platform,
    String? customMessage,
  });

  /// Check if referral code is valid
  Future<bool> isValidReferralCode(String code);

  /// Get referral leaderboard
  Future<List<ReferralStatsModel>> getReferralLeaderboard({int? limit});
}

@LazySingleton(as: ReferralRemoteDataSource)
class ReferralRemoteDataSourceImpl implements ReferralRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  ReferralRemoteDataSourceImpl(
    this._firestore,
    this._auth,
    this._functions,
    this._playIntegrity,
  );

  String? get _currentUserId => _auth.currentUser?.uid;

  CollectionReference get _referralsCollection =>
      _firestore.collection('referrals');
  CollectionReference get _usersCollection => _firestore.collection('users');

  @override
  Future<String> getReferralCode() async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final userDoc = await _usersCollection.doc(userId).get();
    if (!userDoc.exists) {
      throw Exception('User not found');
    }

    final userData = userDoc.data() as Map<String, dynamic>;
    String? referralCode = userData['referralCode'] as String?;

    if (referralCode == null || referralCode.isEmpty) {
      // Generate a new referral code
      referralCode = _generateReferralCode(userId);
      await _usersCollection.doc(userId).update({'referralCode': referralCode});
    }

    return referralCode;
  }

  @override
  Future<ReferralStatsModel> getReferralStats() async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final referralCode = await getReferralCode();
    final referralLink = await generateShareableLink();

    // Get all referrals where this user is the referrer
    final referralsSnapshot = await _referralsCollection
        .where('referrerUserId', isEqualTo: userId)
        .get();

    int totalReferrals = referralsSnapshot.docs.length;
    int pendingReferrals = 0;
    int completedReferrals = 0;
    int totalEarned = 0;

    for (final doc in referralsSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final status = data['status'] as String?;
      final reward = data['referrerReward'] as int? ?? 0;

      if (status == 'pending' || status == 'registered') {
        pendingReferrals++;
      } else if (status == 'rewarded') {
        completedReferrals++;
        totalEarned += reward;
      }
    }

    return ReferralStatsModel(
      totalReferrals: totalReferrals,
      pendingReferrals: pendingReferrals,
      completedReferrals: completedReferrals,
      totalEarned: totalEarned,
      referralCode: referralCode,
      referralLink: referralLink,
    );
  }

  @override
  Future<List<ReferralModel>> getReferrals({
    ReferralStatus? status,
    int? limit,
    DateTime? startAfter,
  }) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    var query = _referralsCollection
        .where('referrerUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true);

    if (status != null) {
      query = query.where('status', isEqualTo: status.name);
    }

    if (startAfter != null) {
      query = query.startAfter([Timestamp.fromDate(startAfter)]);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      return ReferralModel.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    }).toList();
  }

  @override
  Stream<List<ReferralModel>> watchReferrals() {
    final userId = _currentUserId;
    if (userId == null) {
      return Stream.error(Exception('User not authenticated'));
    }

    return _referralsCollection
        .where('referrerUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ReferralModel.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }).toList();
    });
  }

  @override
  Future<ReferralModel> getReferralById(String referralId) async {
    final doc = await _referralsCollection.doc(referralId).get();

    if (!doc.exists) {
      throw Exception('Referral not found');
    }

    return ReferralModel.fromJson({
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>,
    });
  }

  @override
  Future<ReferralModel> applyReferralCode(String code) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Get Play Integrity token for this sensitive operation
      final nonce = _playIntegrity.generateNonce();
      final integrityToken = await _playIntegrity.getIntegrityToken(nonce: nonce);

      final callable = _functions.httpsCallable('applyReferralCode');
      final result = await callable.call<Map<String, dynamic>>({
        'code': code.toUpperCase(),
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final data = result.data;
      final now = DateTime.now();

      return ReferralModel.fromJson({
        'id': '',
        'referrerUserId': '',
        'refereeUserId': userId,
        'status': 'completed',
        'referralCode': code.toUpperCase(),
        'referrerReward': data['referrerReward'] as int? ?? 100,
        'refereeReward': data['refereeReward'] as int? ?? 50,
        'createdAt': Timestamp.fromDate(now),
        'registeredAt': Timestamp.fromDate(now),
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to apply referral code');
    }
  }

  @override
  Future<String> generateShareableLink() async {
    final referralCode = await getReferralCode();
    // In production, this would be a dynamic link
    return 'https://imali.app/r/$referralCode';
  }

  @override
  Future<void> shareReferral({
    required String platform,
    String? customMessage,
  }) async {
    final referralLink = await generateShareableLink();
    final referralCode = await getReferralCode();

    final defaultMessage = '''
Join iMali and start earning! Use my referral code: $referralCode

Download now: $referralLink

You'll get 50 tokens when you sign up and I'll get 100 tokens when you complete your first engagement!
''';

    final message = customMessage ?? defaultMessage;

    await Share.share(message, subject: 'Join iMali and earn tokens!');
  }

  @override
  Future<bool> isValidReferralCode(String code) async {
    final snapshot = await _usersCollection
        .where('referralCode', isEqualTo: code.toUpperCase())
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  @override
  Future<List<ReferralStatsModel>> getReferralLeaderboard({int? limit}) async {
    // Get users with most completed referrals
    final usersSnapshot = await _usersCollection
        .orderBy('completedReferrals', descending: true)
        .limit(limit ?? 20)
        .get();

    final List<ReferralStatsModel> leaderboard = [];

    for (final doc in usersSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final referralCode = data['referralCode'] as String? ?? '';

      if (referralCode.isEmpty) continue;

      leaderboard.add(ReferralStatsModel(
        totalReferrals: data['totalReferrals'] as int? ?? 0,
        pendingReferrals: data['pendingReferrals'] as int? ?? 0,
        completedReferrals: data['completedReferrals'] as int? ?? 0,
        totalEarned: data['referralEarnings'] as int? ?? 0,
        referralCode: referralCode,
        referralLink: 'https://imali.app/r/$referralCode',
      ));
    }

    return leaderboard;
  }

  String _generateReferralCode(String userId) {
    // Generate a 6-character alphanumeric code
    final chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // Excluding confusing chars
    final random = DateTime.now().millisecondsSinceEpoch;
    final buffer = StringBuffer();

    for (int i = 0; i < 6; i++) {
      final index = (random + i * 7 + userId.codeUnitAt(i % userId.length)) %
          chars.length;
      buffer.write(chars[index]);
    }

    return buffer.toString();
  }
}
