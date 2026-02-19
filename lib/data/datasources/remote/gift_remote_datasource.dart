import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../models/gift_model.dart';

/// Abstract interface for gift data operations
abstract class GiftRemoteDataSource {
  String? get currentUserId;

  // Send
  Future<GiftModel> sendGift({
    required String recipientId,
    required int amount,
    required String message,
    required String style,
    String? conversationId,
    String? communityId,
  });

  // Lifecycle
  Future<GiftModel> openGift(String giftId);
  Future<GiftModel> claimGift(String giftId);

  // Query
  Future<List<GiftModel>> getSentGifts({int? limit});
  Future<List<GiftModel>> getReceivedGifts({int? limit});
  Future<GiftModel?> getGift(String giftId);
  Stream<GiftModel> watchGift(String giftId);

  // Stats
  Future<GiftStatsModel> getGiftStats();
}

@LazySingleton(as: GiftRemoteDataSource)
class GiftRemoteDataSourceImpl implements GiftRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  GiftRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _giftsCollection =>
      _firestore.collection('gifts');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  String _requireUserId() {
    final uid = currentUserId;
    if (uid == null) {
      throw const AuthException(message: 'User not authenticated');
    }
    return uid;
  }

  // =========================================================================
  // SEND
  // =========================================================================

  @override
  Future<GiftModel> sendGift({
    required String recipientId,
    required int amount,
    required String message,
    required String style,
    String? conversationId,
    String? communityId,
  }) async {
    _requireUserId();
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('sendGift');
      final result = await callable.call<Map<String, dynamic>>({
        'recipientId': recipientId,
        'amount': amount,
        'message': message,
        'style': style,
        if (conversationId != null) 'conversationId': conversationId,
        if (communityId != null) 'communityId': communityId,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      return GiftModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to send gift');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  @override
  Future<GiftModel> openGift(String giftId) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('openGift');
      final result = await callable.call<Map<String, dynamic>>({
        'giftId': giftId,
      });

      final data = deepConvertMap(result.data);
      return GiftModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to open gift');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<GiftModel> claimGift(String giftId) async {
    _requireUserId();
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('claimGift');
      final result = await callable.call<Map<String, dynamic>>({
        'giftId': giftId,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      return GiftModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to claim gift');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // QUERY
  // =========================================================================

  @override
  Future<List<GiftModel>> getSentGifts({int? limit}) async {
    final userId = _requireUserId();
    try {
      Query<Map<String, dynamic>> query = _giftsCollection
          .where('senderId', isEqualTo: userId)
          .orderBy('createdAt', descending: true);

      if (limit != null) query = query.limit(limit);

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => GiftModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<GiftModel>> getReceivedGifts({int? limit}) async {
    final userId = _requireUserId();
    try {
      Query<Map<String, dynamic>> query = _giftsCollection
          .where('recipientId', isEqualTo: userId)
          .orderBy('createdAt', descending: true);

      if (limit != null) query = query.limit(limit);

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => GiftModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<GiftModel?> getGift(String giftId) async {
    _requireUserId();
    try {
      final doc = await _giftsCollection.doc(giftId).get();
      if (!doc.exists) return null;
      return GiftModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<GiftModel> watchGift(String giftId) {
    _requireUserId();
    return _giftsCollection.doc(giftId).snapshots().where((doc) => doc.exists).map(
      (doc) => GiftModel.fromFirestore(doc),
    );
  }

  // =========================================================================
  // STATS
  // =========================================================================

  @override
  Future<GiftStatsModel> getGiftStats() async {
    final userId = _requireUserId();
    try {
      // Run sent and received queries in parallel
      final sentFuture = _giftsCollection
          .where('senderId', isEqualTo: userId)
          .get();
      final receivedFuture = _giftsCollection
          .where('recipientId', isEqualTo: userId)
          .get();

      final results = await Future.wait([sentFuture, receivedFuture]);
      final sentDocs = results[0].docs;
      final receivedDocs = results[1].docs;

      int totalAmountSent = 0;
      for (final doc in sentDocs) {
        totalAmountSent += (doc.data()['amount'] as int?) ?? 0;
      }

      int totalAmountReceived = 0;
      for (final doc in receivedDocs) {
        final status = doc.data()['status'] as String?;
        if (status == 'claimed') {
          totalAmountReceived += (doc.data()['amount'] as int?) ?? 0;
        }
      }

      return GiftStatsModel(
        totalSent: sentDocs.length,
        totalReceived: receivedDocs.length,
        totalAmountSent: totalAmountSent,
        totalAmountReceived: totalAmountReceived,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
