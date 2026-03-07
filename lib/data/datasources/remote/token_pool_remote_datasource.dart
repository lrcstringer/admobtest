import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../models/token_pool_model.dart';

/// Abstract interface for token pool data operations
abstract class TokenPoolRemoteDataSource {
  String? get currentUserId;

  // Pool lifecycle
  Future<TokenPoolModel> createPool({
    required String mode,
    required String title,
    String? purpose,
    required String message,
    required String style,
    String? recipientId,
    required List<String> inviteeIds,
    String? communityId,
  });

  Future<TokenPoolModel> contribute({
    required String poolId,
    required int amount,
    required bool anonymous,
  });

  Future<TokenPoolModel> sendGroupGift(String poolId);

  Future<TokenPoolModel> distributePool({
    required String poolId,
    required List<Map<String, dynamic>> payouts,
    bool keepOpen = false,
  });

  Future<TokenPoolModel> requestWithdrawal({
    required String poolId,
    required int amount,
  });

  Future<TokenPoolModel> cancelPool(String poolId);

  // Recipient actions
  Future<TokenPoolModel> openGroupGift(String poolId);
  Future<TokenPoolModel> claimGroupGift(String poolId);

  // Query
  Future<TokenPoolModel?> getPool(String poolId);
  Stream<TokenPoolModel> watchPool(String poolId);
  Future<List<TokenPoolModel>> getMyPools();
}

@LazySingleton(as: TokenPoolRemoteDataSource)
class TokenPoolRemoteDataSourceImpl implements TokenPoolRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  TokenPoolRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _poolsCollection =>
      _firestore.collection('tokenPools');

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
  // POOL LIFECYCLE
  // =========================================================================

  @override
  Future<TokenPoolModel> createPool({
    required String mode,
    required String title,
    String? purpose,
    required String message,
    required String style,
    String? recipientId,
    required List<String> inviteeIds,
    String? communityId,
  }) async {
    // No _requireUserId() — CF validates auth via requireAuth(request).
    try {
      final callable = _functions.httpsCallable('createTokenPool');
      final result = await callable.call<Map<String, dynamic>>({
        'mode': mode,
        'title': title,
        if (purpose != null && purpose.isNotEmpty) 'purpose': purpose,
        'message': message,
        'style': style,
        if (recipientId != null) 'recipientId': recipientId,
        'inviteeIds': inviteeIds,
        if (communityId != null) 'communityId': communityId,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to create pool');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenPoolModel> contribute({
    required String poolId,
    required int amount,
    required bool anonymous,
  }) async {
    // No _requireUserId() — CF validates auth via requireAuth(request).
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('contributeToPool');
      final result = await callable.call<Map<String, dynamic>>({
        'poolId': poolId,
        'amount': amount,
        'anonymous': anonymous,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to contribute');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenPoolModel> sendGroupGift(String poolId) async {
    // No _requireUserId() — CF validates auth via requireAuth(request).
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('sendGroupGift');
      final result = await callable.call<Map<String, dynamic>>({
        'poolId': poolId,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to send group gift');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenPoolModel> distributePool({
    required String poolId,
    required List<Map<String, dynamic>> payouts,
    bool keepOpen = false,
  }) async {
    // No _requireUserId() — CF validates auth via requireAuth(request).
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('distributePool');
      final result = await callable.call<Map<String, dynamic>>({
        'poolId': poolId,
        'payouts': payouts,
        'keepOpen': keepOpen,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to distribute pool');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenPoolModel> requestWithdrawal({
    required String poolId,
    required int amount,
  }) async {
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('requestPoolWithdrawal');
      final result = await callable.call<Map<String, dynamic>>({
        'poolId': poolId,
        'amount': amount,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to process withdrawal');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenPoolModel> cancelPool(String poolId) async {
    // No _requireUserId() — CF validates auth via requireAuth(request).
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('cancelPool');
      final result = await callable.call<Map<String, dynamic>>({
        'poolId': poolId,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to cancel pool');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // RECIPIENT ACTIONS
  // =========================================================================

  @override
  Future<TokenPoolModel> openGroupGift(String poolId) async {
    // No _requireUserId() — CF validates auth via requireAuth(request).
    try {
      final callable = _functions.httpsCallable('openGroupGift');
      final result = await callable.call<Map<String, dynamic>>({
        'poolId': poolId,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to open group gift');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenPoolModel> claimGroupGift(String poolId) async {
    // No _requireUserId() — CF validates auth via requireAuth(request).
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('claimGroupGift');
      final result = await callable.call<Map<String, dynamic>>({
        'poolId': poolId,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      final pool = data['pool'] as Map<String, dynamic>? ?? data;
      return TokenPoolModel.fromJson(pool);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to claim group gift');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // QUERY
  // =========================================================================

  @override
  Future<TokenPoolModel?> getPool(String poolId) async {
    _requireUserId();
    try {
      final doc = await _poolsCollection.doc(poolId).get();
      if (!doc.exists) return null;
      return TokenPoolModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<TokenPoolModel> watchPool(String poolId) {
    _requireUserId();
    return _poolsCollection
        .doc(poolId)
        .snapshots()
        .where((doc) => doc.exists)
        .map((doc) => TokenPoolModel.fromFirestore(doc));
  }

  @override
  Future<List<TokenPoolModel>> getMyPools() async {
    final userId = _requireUserId();
    try {
      // Query pools where user is organizer, invitee, or recipient.
      // Firestore limitation: can't OR different field conditions in one query,
      // so we run three queries in parallel and merge results.
      final organizerFuture = _poolsCollection
          .where('organizerId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      final inviteeFuture = _poolsCollection
          .where('inviteeIds', arrayContains: userId)
          .orderBy('createdAt', descending: true)
          .get();

      final recipientFuture = _poolsCollection
          .where('recipientId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      final results = await Future.wait([
        organizerFuture,
        inviteeFuture,
        recipientFuture,
      ]);

      // Merge and deduplicate by ID
      final poolMap = <String, TokenPoolModel>{};
      for (final snapshot in results) {
        for (final doc in snapshot.docs) {
          poolMap.putIfAbsent(doc.id, () => TokenPoolModel.fromFirestore(doc));
        }
      }

      // Sort by createdAt descending
      final pools = poolMap.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return pools;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
