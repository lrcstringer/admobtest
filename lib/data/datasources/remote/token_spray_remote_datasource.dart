import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../models/token_spray_model.dart';

/// Abstract interface for token spray data operations
abstract class TokenSprayRemoteDataSource {
  String? get currentUserId;

  // Create
  Future<TokenSprayModel> createSpray({
    required String communityId,
    required String recipientId,
    required String occasion,
    required String message,
    int? targetAmount,
  });

  // Contribute
  Future<TokenSprayModel> contributeToSpray({
    required String sprayId,
    required int amount,
    String? message,
  });

  // Lifecycle
  Future<TokenSprayModel> closeSpray(String sprayId);
  Future<TokenSprayModel> claimSpray(String sprayId);

  // Query
  Future<TokenSprayModel?> getSpray(String sprayId);
  Stream<TokenSprayModel> watchSpray(String sprayId);
  Future<List<TokenSprayModel>> getCommunitySprayHistory(
    String communityId, {
    int? limit,
  });
}

@LazySingleton(as: TokenSprayRemoteDataSource)
class TokenSprayRemoteDataSourceImpl implements TokenSprayRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  TokenSprayRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _spraysCollection =>
      _firestore.collection('tokenSprays');

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
  // CREATE
  // =========================================================================

  @override
  Future<TokenSprayModel> createSpray({
    required String communityId,
    required String recipientId,
    required String occasion,
    required String message,
    int? targetAmount,
  }) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('createTokenSpray');
      final result = await callable.call<Map<String, dynamic>>({
        'communityId': communityId,
        'recipientId': recipientId,
        'occasion': occasion,
        'message': message,
        if (targetAmount != null) 'targetAmount': targetAmount,
      });

      final data = deepConvertMap(result.data);
      return TokenSprayModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to create spray');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // CONTRIBUTE
  // =========================================================================

  @override
  Future<TokenSprayModel> contributeToSpray({
    required String sprayId,
    required int amount,
    String? message,
  }) async {
    _requireUserId();
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('contributeToSpray');
      final result = await callable.call<Map<String, dynamic>>({
        'sprayId': sprayId,
        'amount': amount,
        if (message != null) 'message': message,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      return TokenSprayModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to contribute');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  @override
  Future<TokenSprayModel> closeSpray(String sprayId) async {
    _requireUserId();
    try {
      final callable = _functions.httpsCallable('closeTokenSpray');
      final result = await callable.call<Map<String, dynamic>>({
        'sprayId': sprayId,
      });

      final data = deepConvertMap(result.data);
      return TokenSprayModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to close spray');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenSprayModel> claimSpray(String sprayId) async {
    _requireUserId();
    try {
      final integrityToken = await _playIntegrity.getIntegrityToken();
      final callable = _functions.httpsCallable('claimTokenSpray');
      final result = await callable.call<Map<String, dynamic>>({
        'sprayId': sprayId,
        if (integrityToken != null) 'integrityToken': integrityToken,
      });

      final data = deepConvertMap(result.data);
      return TokenSprayModel.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to claim spray');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // =========================================================================
  // QUERY
  // =========================================================================

  @override
  Future<TokenSprayModel?> getSpray(String sprayId) async {
    _requireUserId();
    try {
      final doc = await _spraysCollection.doc(sprayId).get();
      if (!doc.exists) return null;
      return TokenSprayModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<TokenSprayModel> watchSpray(String sprayId) {
    _requireUserId();
    return _spraysCollection.doc(sprayId).snapshots().where((doc) => doc.exists).map(
      (doc) => TokenSprayModel.fromFirestore(doc),
    );
  }

  @override
  Future<List<TokenSprayModel>> getCommunitySprayHistory(
    String communityId, {
    int? limit,
  }) async {
    _requireUserId();
    try {
      Query<Map<String, dynamic>> query = _spraysCollection
          .where('communityId', isEqualTo: communityId)
          .orderBy('createdAt', descending: true);

      if (limit != null) query = query.limit(limit);

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => TokenSprayModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
