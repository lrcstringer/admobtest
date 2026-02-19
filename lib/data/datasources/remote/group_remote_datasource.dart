import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../../domain/entities/group_member.dart';
import '../../../domain/entities/stokvel_analytics.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../models/group_model.dart';
import '../../models/group_member_model.dart';
import '../../models/group_transaction_model.dart';

/// @deprecated Use CommunityRemoteDatasource instead. Will be removed in a future cleanup PR.
abstract class GroupRemoteDataSource {
  String? get currentUserId;

  // Group operations
  Future<GroupModel> createGroup(CreateGroupParams params);
  Future<GroupModel?> getGroup(String groupId);
  Future<List<GroupModel>> getUserGroups();
  Stream<List<GroupModel>> watchUserGroups();
  Future<void> updateGroup(String groupId, UpdateGroupParams params);
  Future<void> deleteGroup(String groupId);

  // Membership operations
  Future<void> inviteMember(String groupId, String userId, GroupRole role);
  Future<void> acceptInvitation(String groupId);
  Future<void> declineInvitation(String groupId);
  Future<void> removeMember(String groupId, String memberId);
  Future<void> updateMemberRole(String groupId, String memberId, GroupRole role);
  Future<void> leaveGroup(String groupId);
  Future<List<GroupMemberModel>> getGroupMembers(String groupId);
  Stream<List<GroupMemberModel>> watchGroupMembers(String groupId);
  Future<List<GroupMemberModel>> getPendingInvitations();

  // Transaction operations
  Future<GroupTransactionModel> contributeToGroup(
    String groupId,
    int amount, {
    String? description,
  });
  Future<GroupTransactionModel> withdrawFromGroup(
    String groupId,
    int amount, {
    String? description,
  });
  Future<void> approveTransaction(String groupId, String transactionId);
  Future<void> rejectTransaction(String groupId, String transactionId, {String? reason});
  Future<List<GroupTransactionModel>> getGroupTransactions(String groupId, {int? limit});
  Stream<List<GroupTransactionModel>> watchGroupTransactions(String groupId, {int? limit});
  Future<List<PendingApprovalModel>> getPendingApprovals(String groupId);
  Stream<List<PendingApprovalModel>> watchPendingApprovals(String groupId);

  // Balance operations
  Future<int> getGroupBalance(String groupId);
  Future<({GroupModel group, List<GroupMemberModel> members})> getGroupDetails(String groupId);

  // Stokvel-specific operations
  Future<StokvelPayoutResult> triggerStokvelPayout(String groupId, {String? recipientId});
  Future<StokvelAnalytics> getStokvelAnalytics(String groupId, {int months = 6});
}

@LazySingleton(as: GroupRemoteDataSource)
class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  GroupRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _groupsCollection =>
      _firestore.collection('groups');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  void _requireAuth() {
    if (currentUserId == null) {
      throw const AuthException(message: 'User not authenticated');
    }
  }

  // =========================================================================
  // GROUP OPERATIONS
  // =========================================================================

  @override
  Future<GroupModel> createGroup(CreateGroupParams params) async {
    _requireAuth();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('createGroup');

    final result = await callable.call<Map<String, dynamic>>({
      ...params.toJson(),
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to create group');
    }

    final groupData = sanitizeFirestoreData(
      Map<String, dynamic>.from(data['group'] as Map),
    );
    return GroupModel.fromJson(groupData);
  }

  @override
  Future<GroupModel?> getGroup(String groupId) async {
    _requireAuth();

    final doc = await _groupsCollection.doc(groupId).get();
    if (!doc.exists) return null;

    return GroupModel.fromFirestore(doc);
  }

  @override
  Future<List<GroupModel>> getUserGroups() async {
    _requireAuth();

    final callable = _functions.httpsCallable('getUserGroups');
    final result = await callable.call<Map<String, dynamic>>({});

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to get groups');
    }

    final groups = (data['groups'] as List)
        .map((g) => GroupModel.fromJson(
              sanitizeFirestoreData(Map<String, dynamic>.from(g as Map)),
            ))
        .toList();

    return groups;
  }

  @override
  Stream<List<GroupModel>> watchUserGroups() {
    _requireAuth();
    final userId = currentUserId!;

    return _groupsCollection
        .where('memberIds', arrayContains: userId)
        .where('status', isNotEqualTo: 'closed')
        .orderBy('status')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => GroupModel.fromFirestore(doc)).toList());
  }

  @override
  Future<void> updateGroup(String groupId, UpdateGroupParams params) async {
    _requireAuth();

    final callable = _functions.httpsCallable('updateGroup');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      ...params.toJson(),
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to update group');
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    _requireAuth();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('deleteGroup');

    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to delete group');
    }
  }

  // =========================================================================
  // MEMBERSHIP OPERATIONS
  // =========================================================================

  @override
  Future<void> inviteMember(String groupId, String userId, GroupRole role) async {
    _requireAuth();

    final callable = _functions.httpsCallable('inviteMember');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'userId': userId,
      'role': role.name,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to invite member');
    }
  }

  @override
  Future<void> acceptInvitation(String groupId) async {
    _requireAuth();

    final callable = _functions.httpsCallable('acceptInvitation');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to accept invitation');
    }
  }

  @override
  Future<void> declineInvitation(String groupId) async {
    _requireAuth();

    // Decline is the same as remove for invited status
    final callable = _functions.httpsCallable('removeMember');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'memberId': currentUserId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to decline invitation');
    }
  }

  @override
  Future<void> removeMember(String groupId, String memberId) async {
    _requireAuth();

    final callable = _functions.httpsCallable('removeMember');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'memberId': memberId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to remove member');
    }
  }

  @override
  Future<void> updateMemberRole(
    String groupId,
    String memberId,
    GroupRole role,
  ) async {
    _requireAuth();

    final callable = _functions.httpsCallable('updateMemberRole');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'memberId': memberId,
      'role': role.name,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to update member role');
    }
  }

  @override
  Future<void> leaveGroup(String groupId) async {
    _requireAuth();

    final callable = _functions.httpsCallable('leaveGroup');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to leave group');
    }
  }

  @override
  Future<List<GroupMemberModel>> getGroupMembers(String groupId) async {
    _requireAuth();

    final snapshot = await _groupsCollection
        .doc(groupId)
        .collection('members')
        .orderBy('role')
        .get();

    return snapshot.docs
        .map((doc) => GroupMemberModel.fromFirestore(doc))
        .toList();
  }

  @override
  Stream<List<GroupMemberModel>> watchGroupMembers(String groupId) {
    _requireAuth();

    return _groupsCollection
        .doc(groupId)
        .collection('members')
        .orderBy('role')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GroupMemberModel.fromFirestore(doc))
            .toList());
  }

  @override
  Future<List<GroupMemberModel>> getPendingInvitations() async {
    _requireAuth();
    final userId = currentUserId!;

    // Query all groups to find invitations for this user
    // This is a collection group query
    final snapshot = await _firestore
        .collectionGroup('members')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'invited')
        .get();

    return snapshot.docs
        .map((doc) => GroupMemberModel.fromFirestore(doc))
        .toList();
  }

  // =========================================================================
  // TRANSACTION OPERATIONS
  // =========================================================================

  @override
  Future<GroupTransactionModel> contributeToGroup(
    String groupId,
    int amount, {
    String? description,
  }) async {
    _requireAuth();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('contributeToGroup');

    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'amount': amount,
      if (description != null) 'description': description,
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to contribute to group');
    }

    // Fetch the created transaction
    final transactionDoc = await _groupsCollection
        .doc(groupId)
        .collection('transactions')
        .doc(data['transactionId'] as String)
        .get();

    return GroupTransactionModel.fromFirestore(transactionDoc);
  }

  @override
  Future<GroupTransactionModel> withdrawFromGroup(
    String groupId,
    int amount, {
    String? description,
  }) async {
    _requireAuth();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('withdrawFromGroup');

    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'amount': amount,
      if (description != null) 'description': description,
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to withdraw from group');
    }

    // Fetch the created transaction
    final transactionDoc = await _groupsCollection
        .doc(groupId)
        .collection('transactions')
        .doc(data['transactionId'] as String)
        .get();

    return GroupTransactionModel.fromFirestore(transactionDoc);
  }

  @override
  Future<void> approveTransaction(String groupId, String transactionId) async {
    _requireAuth();

    final callable = _functions.httpsCallable('approveTransaction');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'transactionId': transactionId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to approve transaction');
    }
  }

  @override
  Future<void> rejectTransaction(
    String groupId,
    String transactionId, {
    String? reason,
  }) async {
    _requireAuth();

    final callable = _functions.httpsCallable('rejectTransaction');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'transactionId': transactionId,
      if (reason != null) 'reason': reason,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to reject transaction');
    }
  }

  @override
  Future<List<GroupTransactionModel>> getGroupTransactions(
    String groupId, {
    int? limit,
  }) async {
    _requireAuth();

    var query = _groupsCollection
        .doc(groupId)
        .collection('transactions')
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => GroupTransactionModel.fromFirestore(doc))
        .toList();
  }

  @override
  Stream<List<GroupTransactionModel>> watchGroupTransactions(
    String groupId, {
    int? limit,
  }) {
    _requireAuth();

    var query = _groupsCollection
        .doc(groupId)
        .collection('transactions')
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => GroupTransactionModel.fromFirestore(doc)).toList());
  }

  @override
  Future<List<PendingApprovalModel>> getPendingApprovals(String groupId) async {
    _requireAuth();

    final callable = _functions.httpsCallable('getPendingApprovals');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to get pending approvals');
    }

    final approvals = (data['approvals'] as List)
        .map((a) => PendingApprovalModel.fromJson(
              sanitizeFirestoreData(Map<String, dynamic>.from(a as Map)),
            ))
        .toList();

    return approvals;
  }

  @override
  Stream<List<PendingApprovalModel>> watchPendingApprovals(String groupId) {
    _requireAuth();

    return _groupsCollection
        .doc(groupId)
        .collection('pendingApprovals')
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PendingApprovalModel.fromFirestore(doc))
            .toList());
  }

  // =========================================================================
  // BALANCE OPERATIONS
  // =========================================================================

  @override
  Future<int> getGroupBalance(String groupId) async {
    _requireAuth();

    final doc = await _groupsCollection.doc(groupId).get();
    if (!doc.exists) {
      throw const ServerException(message: 'Group not found', code: 'NOT_FOUND');
    }

    final data = doc.data();
    return (data?['totalBalance'] as int?) ?? 0;
  }

  @override
  Future<({GroupModel group, List<GroupMemberModel> members})> getGroupDetails(
    String groupId,
  ) async {
    _requireAuth();

    final callable = _functions.httpsCallable('getGroupDetails');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to get group details');
    }

    final group = GroupModel.fromJson(
      sanitizeFirestoreData(Map<String, dynamic>.from(data['group'] as Map)),
    );

    final members = (data['members'] as List)
        .map((m) => GroupMemberModel.fromJson(
              sanitizeFirestoreData(Map<String, dynamic>.from(m as Map)),
            ))
        .toList();

    return (group: group, members: members);
  }

  // =========================================================================
  // STOKVEL-SPECIFIC OPERATIONS
  // =========================================================================

  @override
  Future<StokvelPayoutResult> triggerStokvelPayout(
    String groupId, {
    String? recipientId,
  }) async {
    _requireAuth();

    final integrityToken = await _playIntegrity.getIntegrityToken();
    final callable = _functions.httpsCallable('triggerStokvelPayout');

    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      if (recipientId != null) 'recipientId': recipientId,
      'integrityToken': integrityToken,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to trigger payout');
    }

    return StokvelPayoutResult.fromJson(data);
  }

  @override
  Future<StokvelAnalytics> getStokvelAnalytics(
    String groupId, {
    int months = 6,
  }) async {
    _requireAuth();

    final callable = _functions.httpsCallable('getStokvelAnalytics');
    final result = await callable.call<Map<String, dynamic>>({
      'groupId': groupId,
      'months': months,
    });

    final data = result.data;
    if (data['success'] != true) {
      throw ServerException(message: data['error'] ?? 'Failed to get analytics');
    }

    return StokvelAnalytics.fromJson(data);
  }
}
