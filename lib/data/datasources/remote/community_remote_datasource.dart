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
  });
  Future<CommunityTransactionModel> withdraw(
    String communityId,
    int amount, {
    String? description,
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

  // =========================================================================
  // COMMUNITY CRUD
  // =========================================================================

  @override
  Future<CommunityModel> createCommunity(CreateCommunityParams params) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('createCommunity');

    final result = await callable.call<Map<String, dynamic>>({
      ...params.toJson(),
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to create community');
    }

    final communityData = sanitizeFirestoreData(
      Map<String, dynamic>.from(data['community'] as Map),
    );
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

    final callable = _functions.httpsCallable('getUserCommunities');
    final result = await callable.call<Map<String, dynamic>>({});

    final data = result.data;
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

    return _communitiesCollection
        .where('memberIds', arrayContains: userId)
        .where('status', isNotEqualTo: 'closed')
        .orderBy('status')
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommunityModel.fromFirestore(doc))
            .toList());
  }

  @override
  Future<void> updateCommunity(
      String communityId, UpdateCommunityParams params) async {
    _requireUserId();

    final callable = _functions.httpsCallable('updateCommunity');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      ...params.toJson(),
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to update community');
    }
  }

  @override
  Future<void> deleteCommunity(String communityId) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('deleteCommunity');

    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'integrityToken': integrityToken,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('inviteCommunityMember');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'userId': userId,
      'role': role.name,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to invite member');
    }
  }

  @override
  Future<void> acceptInvitation(String communityId) async {
    _requireUserId();

    final callable = _functions.httpsCallable('acceptCommunityInvitation');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to accept invitation');
    }
  }

  @override
  Future<void> declineInvitation(String communityId) async {
    _requireUserId();

    final callable = _functions.httpsCallable('removeCommunityMember');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'memberId': currentUserId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to decline invitation');
    }
  }

  @override
  Future<void> removeMember(String communityId, String memberId) async {
    _requireUserId();

    final callable = _functions.httpsCallable('removeCommunityMember');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'memberId': memberId,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('updateCommunityMemberRole');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'memberId': memberId,
      'role': role.name,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to update member role');
    }
  }

  @override
  Future<void> leaveCommunity(String communityId) async {
    _requireUserId();

    final callable = _functions.httpsCallable('leaveCommunity');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
    });

    final data = result.data;
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
        .map((snapshot) => snapshot.docs
            .map((doc) => CommunityMemberModel.fromFirestore(doc))
            .toList());
  }

  @override
  Future<List<CommunityMemberModel>> getPendingInvitations() async {
    final userId = _requireUserId();

    final snapshot = await _firestore
        .collectionGroup('members')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'invited')
        .get();

    return snapshot.docs
        .map((doc) => CommunityMemberModel.fromFirestore(doc))
        .toList();
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

    return query.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          final data = sanitizeFirestoreData(doc.data());
          return MessageModel.fromJson({...data, 'id': doc.id});
        }).toList());
  }

  @override
  Future<MessageModel> sendTextMessage({
    required String communityId,
    required String text,
    String? replyToMessageId,
  }) async {
    final userId = _requireUserId();

    final callable = _functions.httpsCallable('sendCommunityMessage');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'text': text,
      if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
    });

    final data = result.data;
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
  }) async {
    _requireUserId();

    final callable = _functions.httpsCallable('sendCommunityMessage');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'ciphertext': ciphertext,
      'e2ee': e2ee,
      if (encryptedPreviews != null) 'encryptedPreviews': encryptedPreviews,
      if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(
          message: data['error'] ?? 'Failed to send encrypted message');
    }

    return data['messageId'] as String? ?? '';
  }

  @override
  Future<MessageModel> sendMediaMessage({
    required String communityId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) async {
    final userId = _requireUserId();

    final callable = _functions.httpsCallable('sendCommunityMessage');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      if (caption != null) 'text': caption,
    });

    final data = result.data;
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
      type: mediaType.startsWith('image') ? 'image' : 'voice',
      textContent: caption,
    );
  }

  @override
  Future<void> markAsRead(String communityId) async {
    _requireUserId();

    final callable = _functions.httpsCallable('markCommunityRead');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
    });

    final data = result.data;
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
  }) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('contributeToCommunity');

    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'amount': amount,
      if (description != null) 'description': description,
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      final error = data['error'] ?? 'Failed to contribute';
      if (error.toString().contains('insufficient')) {
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
  }) async {
    _requireUserId();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('withdrawFromCommunity');

    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'amount': amount,
      if (description != null) 'description': description,
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      final error = data['error'] ?? 'Failed to withdraw';
      if (error.toString().contains('insufficient')) {
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

    final callable = _functions.httpsCallable('approveCommunityTransaction');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'transactionId': transactionId,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('rejectCommunityTransaction');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'transactionId': transactionId,
      if (reason != null) 'reason': reason,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('getCommunityPendingApprovals');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
    });

    final data = result.data;
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
    final callable = _functions.httpsCallable('triggerCommunityPayout');

    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      if (recipientId != null) 'recipientId': recipientId,
      'integrityToken': integrityToken,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('getCommunityAnalytics');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'months': months,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('toggleCommunityMessageReaction');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'messageId': messageId,
      'emoji': emoji,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('toggleCommunityMessageReaction');
    final result = await callable.call<Map<String, dynamic>>({
      'communityId': communityId,
      'messageId': messageId,
      'emoji': emoji,
    });

    final data = result.data;
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

    final callable = _functions.httpsCallable('markKeyDistributionConsumed');
    await callable.call<dynamic>({
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
