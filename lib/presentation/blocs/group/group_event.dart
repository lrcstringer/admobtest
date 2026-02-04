part of 'group_bloc.dart';

@freezed
class GroupEvent with _$GroupEvent {
  // Group loading events
  const factory GroupEvent.loadUserGroups() = _LoadUserGroups;
  const factory GroupEvent.watchUserGroups() = _WatchUserGroups;
  const factory GroupEvent.userGroupsUpdated(List<Group> groups) = _UserGroupsUpdated;

  // Single group events
  const factory GroupEvent.loadGroupDetails({required String groupId}) = _LoadGroupDetails;
  const factory GroupEvent.watchGroupMembers({required String groupId}) = _WatchGroupMembers;
  const factory GroupEvent.groupMembersUpdated(List<GroupMember> members) = _GroupMembersUpdated;
  const factory GroupEvent.watchGroupTransactions({required String groupId, int? limit}) = _WatchGroupTransactions;
  const factory GroupEvent.groupTransactionsUpdated(List<GroupTransaction> transactions) = _GroupTransactionsUpdated;
  const factory GroupEvent.watchPendingApprovals({required String groupId}) = _WatchPendingApprovals;
  const factory GroupEvent.pendingApprovalsUpdated(List<PendingApproval> approvals) = _PendingApprovalsUpdated;

  // Group CRUD events
  const factory GroupEvent.createGroup({required CreateGroupParams params}) = _CreateGroup;
  const factory GroupEvent.updateGroup({required String groupId, required UpdateGroupParams params}) = _UpdateGroup;
  const factory GroupEvent.deleteGroup({required String groupId}) = _DeleteGroup;

  // Membership events
  const factory GroupEvent.inviteMember({
    required String groupId,
    required String userId,
    required GroupRole role,
  }) = _InviteMember;
  const factory GroupEvent.acceptInvitation({required String groupId}) = _AcceptInvitation;
  const factory GroupEvent.declineInvitation({required String groupId}) = _DeclineInvitation;
  const factory GroupEvent.removeMember({required String groupId, required String memberId}) = _RemoveMember;
  const factory GroupEvent.updateMemberRole({
    required String groupId,
    required String memberId,
    required GroupRole role,
  }) = _UpdateMemberRole;
  const factory GroupEvent.leaveGroup({required String groupId}) = _LeaveGroup;
  const factory GroupEvent.loadPendingInvitations() = _LoadPendingInvitations;

  // Transaction events
  const factory GroupEvent.contributeToGroup({
    required String groupId,
    required int amount,
    String? description,
  }) = _ContributeToGroup;
  const factory GroupEvent.withdrawFromGroup({
    required String groupId,
    required int amount,
    String? description,
  }) = _WithdrawFromGroup;
  const factory GroupEvent.approveTransaction({
    required String groupId,
    required String transactionId,
  }) = _ApproveTransaction;
  const factory GroupEvent.rejectTransaction({
    required String groupId,
    required String transactionId,
    String? reason,
  }) = _RejectTransaction;

  // Stokvel-specific events
  const factory GroupEvent.triggerStokvelPayout({
    required String groupId,
    String? recipientId,
  }) = _TriggerStokvelPayout;
  const factory GroupEvent.loadStokvelAnalytics({
    required String groupId,
    int? months,
  }) = _LoadStokvelAnalytics;

  // Clear state
  const factory GroupEvent.clearSelectedGroup() = _ClearSelectedGroup;
  const factory GroupEvent.clearError() = _ClearError;
}
