import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../../domain/entities/stokvel_analytics.dart';
import '../../../domain/enums/member_role.dart';
import '../../../domain/repositories/community_repository.dart';
import '../../models/community_model.dart';
import '../../models/community_member_model.dart';
import '../../models/community_transaction_model.dart';
import '../../models/message_model.dart';

/// Abstract interface for community data operations
abstract class CommunityRemoteDataSource {
  String? get currentUserId;

  // Community CRUD
  Future<CommunityModel> createCommunity(CreateCommunityParams params);
  Future<CommunityModel?> getCommunity(String communityId);
  Future<List<CommunityModel>> getUserCommunities();
  Stream<List<CommunityModel>> watchUserCommunities();
  Future<void> updateCommunity(
      String communityId, UpdateCommunityParams params);
  Future<void> deleteCommunity(String communityId);

  // Membership
  Future<void> inviteMember(
      String communityId, String userId, MemberRole role);
  Future<void> acceptInvitation(String communityId);
  Future<void> declineInvitation(String communityId);
  Future<void> removeMember(String communityId, String memberId);
  Future<void> updateMemberRole(
      String communityId, String memberId, MemberRole role);
  Future<void> leaveCommunity(String communityId);
  Future<List<CommunityMemberModel>> getMembers(String communityId);
  Stream<List<CommunityMemberModel>> watchMembers(String communityId);
  Future<List<CommunityMemberModel>> getPendingInvitations();

  // Messaging (read from subcollection, write via Cloud Functions)
  Future<List<MessageModel>> getMessages({
    required String communityId,
    int? limit,
    DateTime? before,
  });
  Stream<List<MessageModel>> watchMessages({
    required String communityId,
    int? limit,
  });
  Future<MessageModel> sendTextMessage({
    required String communityId,
    required String text,
    String? replyToMessageId,
  });
  Future<String> sendEncryptedCommunityMessage({
    required String communityId,
    required String ciphertext,
    required Map<String, dynamic> e2ee,
    Map<String, String>? encryptedPreviews,
    String? replyToMessageId,
    String? idempotencyKey,
  });
  Future<MessageModel> sendMediaMessage({
    required String communityId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  });
  Future<void> markAsRead(String communityId);

  // Financial
  Future<CommunityTransactionModel> contribute(
    String communityId,
    int amount, {
    String? description,
    String? idempotencyKey,
  });
  Future<CommunityTransactionModel> withdraw(
    String communityId,
    int amount, {
    String? description,
    String? idempotencyKey,
  });
  Future<void> approveTransaction(String communityId, String transactionId);
  Future<void> rejectTransaction(String communityId, String transactionId,
      {String? reason});
  Future<List<CommunityTransactionModel>> getTransactions(String communityId,
      {int? limit});
  Stream<List<CommunityTransactionModel>> watchTransactions(
      String communityId);
  Future<List<CommunityApprovalModel>> getPendingApprovals(
      String communityId);
  Stream<List<CommunityApprovalModel>> watchPendingApprovals(
      String communityId);
  Future<int> getBalance(String communityId);

  // Stokvel
  Future<StokvelPayoutResult> triggerPayout(String communityId,
      {String? recipientId});
  Future<StokvelAnalytics> getAnalytics(String communityId, {int months = 6});

  // Reactions
  Future<void> addReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  });
  Future<void> removeReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  });

  // E2EE key distribution
  Future<List<Map<String, dynamic>>> fetchPendingKeyDistributions(
      String communityId);
  Future<void> markKeyDistributionConsumed(
      String communityId, String distributionId);

  // Unread
  Stream<int> watchTotalCommunityUnreadCount();
}

@LazySingleton(as: CommunityRemoteDataSource)
class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  CommunityRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _communitiesCollection =>
      _firestore.collection('communities');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  String _requireUserId() {
    final uid = currentUserId;
    if (uid == null) {
      throw const AuthException(message: 'User not authenticated');
    }
    return uid;
  }

  /// Map Cloud Function errors to typed exceptions so the repository layer
  /// can return the correct [Failure] variant.
  Exception _mapFunctionsError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return AuthException(
            message: e.message ?? 'Please sign in to continue');
      case 'permission-denied':
        return AuthException(
            message: e.message ?? 'You don\'t have permission');
      default:
        return ServerException(
            message: e.message ?? 'Operation failed');
    }
  }

  /// Centralized Cloud Function caller with [FirebaseFunctionsException]
  /// handling. All callable invocations go through here so transport-level
  /// errors (unauthenticated, permission-denied, etc.) are mapped to typed
  /// exceptions the repository layer understands.
  Future<Map<String, dynamic>> _callFunction(
    String name,
    Map<String, dynamic> params,
  ) async {
    try {
      final callable = _functions.httpsCallable(name);
      final result = await callable.call(params);
      return sanitizeFirestoreData(result.data as Map);
    } on FirebaseFunctionsException catch (e) {
      throw _mapFunctionsError(e);
    }
  }

  // =========================================================================
  // COMMUNITY CRUD
  // =========================================================================

  @override
  Future<CommunityModel> createCommunity(CreateCommunityParams params) async {
    // No _requireUserId() — the Cloud Function validates auth via
    // requireAuth(request). The local check was failing transiently on
    // Play Store builds when Firebase Auth hadn't refreshed the token yet,
    // blocking the user with "Please sign in to continue" even though
    // they were authenticated.
    final integrityToken = await _playIntegrity.getIntegrityToken();
    final data = await _callFunction('createCommunity', {
      ...params.toJson(),
      'integrityToken': integrityToken,
    });

    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to create community');
    }

    final communityData =
        data['community'] as Map<String, dynamic>? ?? <String, dynamic>{};
    return CommunityModel.fromJson({
      ...communityData,
      'id': data['communityId'] ?? communityData['id'],
    });
  }

  @override
  Future<CommunityModel?> getCommunity(String communityId) async {
    _requireUserId();

    final doc = await _communitiesCollection.doc(communityId).get();
    if (!doc.exists) return null;

    return CommunityModel.fromFirestore(doc);
  }

  @override
  Future<List<CommunityModel>> getUserCommunities() async {
    _requireUserId();

    final data = await _callFunction('getUserCommunities', {});
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to get communities');
    }

    final communities = (data['communities'] as List)
        .map((c) => CommunityModel.fromJson(
              sanitizeFirestoreData(Map<String, dynamic>.from(c as Map)),
            ))
        .toList();

    return communities;
  }

  @override
  Stream<List<CommunityModel>> watchUserCommunities() {
    final userId = _requireUserId();

    // Simplified query: only array-contains + single orderBy.
    // Avoids the != decomposition + dual orderBy that requires a complex
    // composite index and silently fails if the index is missing or the
    // status field is null. Closed communities are filtered client-side
    // in CommunitySyncService._startCommunityListSync (line 114).
    return _communitiesCollection
        .where('memberIds', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final communities = <CommunityModel>[];
      for (final doc in snapshot.docs) {
        try {
          communities.add(CommunityModel.fromFirestore(doc));
        } catch (_) {
          // Skip malformed community document
        }
      }
      return communities;
    });
  }

  @override
  Future<void> updateCommunity(
      String communityId, UpdateCommunityParams params) async {
    _requireUserId();

    final data = await _callFunction('updateCommunity', {
      'communityId': communityId,
      ...params.toJson(),
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to update community');
    }
  }

  @override
  Future<void> deleteCommunity(String communityId) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final data = await _callFunction('deleteCommunity', {
      'communityId': communityId,
      'integrityToken': integrityToken,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to delete community');
    }
  }

  // =========================================================================
  // MEMBERSHIP
  // =========================================================================

  @override
  Future<void> inviteMember(
      String communityId, String userId, MemberRole role) async {
    _requireUserId();

    final data = await _callFunction('inviteCommunityMember', {
      'communityId': communityId,
      'userId': userId,
      'role': role.name,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to invite member');
    }
  }

  @override
  Future<void> acceptInvitation(String communityId) async {
    _requireUserId();

    final data = await _callFunction('acceptCommunityInvitation', {
      'communityId': communityId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to accept invitation');
    }
  }

  @override
  Future<void> declineInvitation(String communityId) async {
    _requireUserId();

    final data = await _callFunction('removeCommunityMember', {
      'communityId': communityId,
      'memberId': currentUserId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to decline invitation');
    }
  }

  @override
  Future<void> removeMember(String communityId, String memberId) async {
    _requireUserId();

    final data = await _callFunction('removeCommunityMember', {
      'communityId': communityId,
      'memberId': memberId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to remove member');
    }
  }

  @override
  Future<void> updateMemberRole(
    String communityId,
    String memberId,
    MemberRole role,
  ) async {
    _requireUserId();

    final data = await _callFunction('updateCommunityMemberRole', {
      'communityId': communityId,
      'memberId': memberId,
      'role': role.name,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to update member role');
    }
  }

  @override
  Future<void> leaveCommunity(String communityId) async {
    _requireUserId();

    final data = await _callFunction('leaveCommunity', {
      'communityId': communityId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to leave community');
    }
  }

  @override
  Future<List<CommunityMemberModel>> getMembers(String communityId) async {
    _requireUserId();

    final snapshot = await _communitiesCollection
        .doc(communityId)
        .collection('members')
        .orderBy('role')
        .get();

    return snapshot.docs
        .map((doc) => CommunityMemberModel.fromFirestore(doc))
        .toList();
  }

  @override
  Stream<List<CommunityMemberModel>> watchMembers(String communityId) {
    _requireUserId();

    return _communitiesCollection
        .doc(communityId)
        .collection('members')
        .orderBy('role')
        .snapshots()
        .map((snapshot) {
      final members = <CommunityMemberModel>[];
      for (final doc in snapshot.docs) {
        try {
          members.add(CommunityMemberModel.fromFirestore(doc));
        } catch (_) {
          // Skip malformed member document
        }
      }
      return members;
    });
  }

  @override
  Future<List<CommunityMemberModel>> getPendingInvitations() async {
    final userId = _requireUserId();

    final snapshot = await _firestore
        .collectionGroup('members')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'invited')
        .get();

    final members = snapshot.docs
        .map((doc) => CommunityMemberModel.fromFirestore(doc))
        .toList();

    // Enrich each invitation with the community name from the parent doc.
    // The member doc may already have communityName (new invites), but
    // older invitations won't — batch-fetch from parent community docs.
    final needsFetch = <int, String>{};
    for (int i = 0; i < members.length; i++) {
      final m = members[i];
      if (m.communityName == null || m.communityName!.isEmpty) {
        needsFetch[i] = m.communityId;
      }
    }

    // Batch read all community docs that need enrichment (single round-trip)
    Map<String, String?> communityNames = {};
    if (needsFetch.isNotEmpty) {
      final uniqueIds = needsFetch.values.toSet();
      try {
        final futures = uniqueIds.map((id) =>
            _communitiesCollection.doc(id).get());
        final docs = await Future.wait(futures);
        for (final doc in docs) {
          communityNames[doc.id] = doc.data()?['name'] as String?;
        }
      } catch (_) {
        // Best-effort enrichment; continue without community names
      }
    }

    final enriched = <CommunityMemberModel>[];
    for (int i = 0; i < members.length; i++) {
      final member = members[i];
      if (needsFetch.containsKey(i)) {
        final name = communityNames[member.communityId];
        enriched.add(name != null ? member.copyWith(communityName: name) : member);
      } else {
        enriched.add(member);
      }
    }

    return enriched;
  }

  // =========================================================================
  // MESSAGING
  // =========================================================================

  @override
  Future<List<MessageModel>> getMessages({
    required String communityId,
    int? limit,
    DateTime? before,
  }) async {
    _requireUserId();

    var query = _communitiesCollection
        .doc(communityId)
        .collection('messages')
        .orderBy('createdAt', descending: true);

    if (before != null) {
      query = query.where('createdAt', isLessThan: Timestamp.fromDate(before));
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = sanitizeFirestoreData(doc.data());
      return MessageModel.fromJson({...data, 'id': doc.id});
    }).toList();
  }

  @override
  Stream<List<MessageModel>> watchMessages({
    required String communityId,
    int? limit,
  }) {
    _requireUserId();

    var query = _communitiesCollection
        .doc(communityId)
        .collection('messages')
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final messages = <MessageModel>[];
      for (final doc in snapshot.docs) {
        try {
          final data = sanitizeFirestoreData(doc.data());
          messages.add(MessageModel.fromJson({...data, 'id': doc.id}));
        } catch (_) {
          // Skip malformed message document
        }
      }
      return messages;
    });
  }

  /// @deprecated Use [OutgoingMessageQueue] for E2EE message sending instead.
  /// This method bypasses encryption and is only kept for backward compatibility.
  @Deprecated('Use OutgoingMessageQueue for E2EE message sending instead')
  @override
  Future<MessageModel> sendTextMessage({
    required String communityId,
    required String text,
    String? replyToMessageId,
  }) async {
    final userId = _requireUserId();

    final data = await _callFunction('sendCommunityMessage', {
      'communityId': communityId,
      'text': text,
      if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to send message');
    }

    final messageId = data['messageId'] as String;
    final userName =
        _firebaseAuth.currentUser?.displayName ?? 'Unknown';

    return MessageModel.optimistic(
      localId: messageId,
      senderId: userId,
      senderName: userName,
      type: 'text',
      textContent: text,
    );
  }

  @override
  Future<String> sendEncryptedCommunityMessage({
    required String communityId,
    required String ciphertext,
    required Map<String, dynamic> e2ee,
    Map<String, String>? encryptedPreviews,
    String? replyToMessageId,
    String? idempotencyKey,
  }) async {
    _requireUserId();

    final data = await _callFunction('sendCommunityMessage', {
      'communityId': communityId,
      'ciphertext': ciphertext,
      'e2ee': e2ee,
      if (encryptedPreviews != null) 'encryptedPreviews': encryptedPreviews,
      if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      if (idempotencyKey != null) 'idempotencyKey': idempotencyKey,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to send encrypted message');
    }

    // HIGH-7: Throw on empty/missing messageId — the caller uses this for
    // tracking (vault storage, preview updates, status transitions). An empty
    // ID would corrupt downstream state.
    final messageId = data['messageId'] as String?;
    if (messageId == null || messageId.isEmpty) {
      throw ServerException(
          message: 'Server returned success but no messageId');
    }
    return messageId;
  }

  /// @deprecated Use [OutgoingMessageQueue] for E2EE message sending instead.
  /// This method bypasses encryption and is only kept for backward compatibility.
  @Deprecated('Use OutgoingMessageQueue for E2EE message sending instead')
  @override
  Future<MessageModel> sendMediaMessage({
    required String communityId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) async {
    final userId = _requireUserId();

    final data = await _callFunction('sendCommunityMessage', {
      'communityId': communityId,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      if (caption != null) 'text': caption,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to send media message');
    }

    final messageId = data['messageId'] as String;
    final userName =
        _firebaseAuth.currentUser?.displayName ?? 'Unknown';

    return MessageModel.optimistic(
      localId: messageId,
      senderId: userId,
      senderName: userName,
      type: _inferMessageType(mediaType),
      textContent: caption,
    );
  }

  String _inferMessageType(String mediaType) {
    if (mediaType.startsWith('image')) return 'image';
    if (mediaType.startsWith('video')) return 'video';
    if (mediaType.startsWith('audio')) return 'voice';
    return 'document';
  }

  @override
  Future<void> markAsRead(String communityId) async {
    _requireUserId();

    final data = await _callFunction('markCommunityRead', {
      'communityId': communityId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to mark as read');
    }
  }

  // =========================================================================
  // FINANCIAL
  // =========================================================================

  @override
  Future<CommunityTransactionModel> contribute(
    String communityId,
    int amount, {
    String? description,
    String? idempotencyKey,
  }) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final data = await _callFunction('contributeToCommunity', {
      'communityId': communityId,
      'amount': amount,
      if (description != null) 'description': description,
      if (idempotencyKey != null) 'idempotencyKey': idempotencyKey,
      'integrityToken': integrityToken,
    });
    if (data['success'] != true) {
      final error = data['error']?.toString() ?? 'Failed to contribute';
      final code = data['code']?.toString() ?? '';
      if (code == 'failed-precondition' || code == 'resource-exhausted') {
        throw InsufficientBalanceException();
      }
      throw ServerException(message: error);
    }

    final transactionDoc = await _communitiesCollection
        .doc(communityId)
        .collection('transactions')
        .doc(data['transactionId'] as String)
        .get();

    return CommunityTransactionModel.fromFirestore(transactionDoc);
  }

  @override
  Future<CommunityTransactionModel> withdraw(
    String communityId,
    int amount, {
    String? description,
    String? idempotencyKey,
  }) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final data = await _callFunction('withdrawFromCommunity', {
      'communityId': communityId,
      'amount': amount,
      if (description != null) 'description': description,
      if (idempotencyKey != null) 'idempotencyKey': idempotencyKey,
      'integrityToken': integrityToken,
    });
    if (data['success'] != true) {
      final error = data['error']?.toString() ?? 'Failed to withdraw';
      final code = data['code']?.toString() ?? '';
      if (code == 'failed-precondition' || code == 'resource-exhausted') {
        throw InsufficientBalanceException();
      }
      throw ServerException(message: error);
    }

    final transactionDoc = await _communitiesCollection
        .doc(communityId)
        .collection('transactions')
        .doc(data['transactionId'] as String)
        .get();

    return CommunityTransactionModel.fromFirestore(transactionDoc);
  }

  @override
  Future<void> approveTransaction(
      String communityId, String transactionId) async {
    _requireUserId();

    final data = await _callFunction('approveCommunityTransaction', {
      'communityId': communityId,
      'transactionId': transactionId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to approve transaction');
    }
  }

  @override
  Future<void> rejectTransaction(
    String communityId,
    String transactionId, {
    String? reason,
  }) async {
    _requireUserId();

    final data = await _callFunction('rejectCommunityTransaction', {
      'communityId': communityId,
      'transactionId': transactionId,
      if (reason != null) 'reason': reason,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to reject transaction');
    }
  }

  @override
  Future<List<CommunityTransactionModel>> getTransactions(
    String communityId, {
    int? limit,
  }) async {
    _requireUserId();

    var query = _communitiesCollection
        .doc(communityId)
        .collection('transactions')
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => CommunityTransactionModel.fromFirestore(doc))
        .toList();
  }

  @override
  Stream<List<CommunityTransactionModel>> watchTransactions(
      String communityId) {
    _requireUserId();

    return _communitiesCollection
        .doc(communityId)
        .collection('transactions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommunityTransactionModel.fromFirestore(doc))
            .toList());
  }

  @override
  Future<List<CommunityApprovalModel>> getPendingApprovals(
      String communityId) async {
    _requireUserId();

    final data = await _callFunction('getCommunityPendingApprovals', {
      'communityId': communityId,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to get pending approvals');
    }

    final approvals = (data['approvals'] as List)
        .map((a) => CommunityApprovalModel.fromJson(
              sanitizeFirestoreData(Map<String, dynamic>.from(a as Map)),
            ))
        .toList();

    return approvals;
  }

  @override
  Stream<List<CommunityApprovalModel>> watchPendingApprovals(
      String communityId) {
    _requireUserId();

    return _communitiesCollection
        .doc(communityId)
        .collection('pendingApprovals')
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommunityApprovalModel.fromFirestore(doc))
            .toList());
  }

  @override
  Future<int> getBalance(String communityId) async {
    _requireUserId();

    final doc = await _communitiesCollection.doc(communityId).get();
    if (!doc.exists) {
      throw const ServerException(
          message: 'Community not found', code: 'NOT_FOUND');
    }

    final data = doc.data();
    return (data?['totalBalance'] as int?) ?? 0;
  }

  // =========================================================================
  // STOKVEL
  // =========================================================================

  @override
  Future<StokvelPayoutResult> triggerPayout(
    String communityId, {
    String? recipientId,
  }) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final data = await _callFunction('triggerCommunityPayout', {
      'communityId': communityId,
      if (recipientId != null) 'recipientId': recipientId,
      'integrityToken': integrityToken,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to trigger payout');
    }

    return StokvelPayoutResult.fromJson(data);
  }

  @override
  Future<StokvelAnalytics> getAnalytics(
    String communityId, {
    int months = 6,
  }) async {
    _requireUserId();

    final data = await _callFunction('getCommunityAnalytics', {
      'communityId': communityId,
      'months': months,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to get analytics');
    }

    return StokvelAnalytics.fromJson(data);
  }

  // =========================================================================
  // REACTIONS
  // =========================================================================

  @override
  Future<void> addReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  }) async {
    _requireUserId();

    final data = await _callFunction('toggleCommunityMessageReaction', {
      'communityId': communityId,
      'messageId': messageId,
      'emoji': emoji,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to add reaction');
    }
  }

  @override
  Future<void> removeReaction({
    required String communityId,
    required String messageId,
    required String emoji,
  }) async {
    _requireUserId();

    final data = await _callFunction('toggleCommunityMessageReaction', {
      'communityId': communityId,
      'messageId': messageId,
      'emoji': emoji,
    });
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to remove reaction');
    }
  }

  // =========================================================================
  // E2EE KEY DISTRIBUTION
  // =========================================================================

  @override
  Future<List<Map<String, dynamic>>> fetchPendingKeyDistributions(
      String communityId) async {
    final userId = _requireUserId();

    final snapshot = await _communitiesCollection
        .doc(communityId)
        .collection('keyDistribution')
        .where('toUserId', isEqualTo: userId)
        .where('consumed', isEqualTo: false)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        ...data,
        'distributionId': doc.id,
      };
    }).toList();
  }

  @override
  Future<void> markKeyDistributionConsumed(
      String communityId, String distributionId) async {
    _requireUserId();

    await _callFunction('markKeyDistributionConsumed', {
      'communityId': communityId,
      'distributionId': distributionId,
    });
  }

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  @override
  Stream<int> watchTotalCommunityUnreadCount() {
    final userId = _requireUserId();

    return _communitiesCollection
        .where('memberIds', arrayContains: userId)
        .where('status', isNotEqualTo: 'closed')
        .snapshots()
        .map((snapshot) {
      int total = 0;
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final unreadCounts = data['unreadCounts'];
        if (unreadCounts is Map) {
          final count = unreadCounts[userId];
          if (count is num) {
            total += count.toInt();
          }
        }
      }
      return total;
    });
  }
}
