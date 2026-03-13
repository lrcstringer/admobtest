part of 'community_bloc.dart';

@freezed
abstract class CommunityEvent with _$CommunityEvent {
  // =========================================================================
  // COMMUNITY LIST
  // =========================================================================

  /// Load all communities for the current user (one-shot)
  const factory CommunityEvent.loadUserCommunities() = _LoadUserCommunities;

  /// Watch communities for real-time updates
  const factory CommunityEvent.watchUserCommunities() = _WatchUserCommunities;

  /// Communities updated from stream
  const factory CommunityEvent.userCommunitiesUpdated(
    List<Community> communities,
  ) = _UserCommunitiesUpdated;

  // =========================================================================
  // COMMUNITY DETAIL
  // =========================================================================

  /// Load full community details (community + members)
  const factory CommunityEvent.loadCommunityDetails({
    required String communityId,
  }) = _LoadCommunityDetails;

  /// Watch members of the selected community
  const factory CommunityEvent.watchMembers({
    required String communityId,
  }) = _WatchMembers;

  /// Members updated from stream
  const factory CommunityEvent.membersUpdated(
    List<CommunityMember> members,
  ) = _MembersUpdated;

  /// Watch transactions of the selected community
  const factory CommunityEvent.watchTransactions({
    required String communityId,
    int? limit,
  }) = _WatchTransactions;

  /// Transactions updated from stream
  const factory CommunityEvent.transactionsUpdated(
    List<CommunityTransaction> transactions,
  ) = _TransactionsUpdated;

  /// Watch pending approvals
  const factory CommunityEvent.watchPendingApprovals({
    required String communityId,
  }) = _WatchPendingApprovals;

  /// Pending approvals updated from stream
  const factory CommunityEvent.pendingApprovalsUpdated(
    List<CommunityApproval> approvals,
  ) = _PendingApprovalsUpdated;

  // =========================================================================
  // COMMUNITY CRUD
  // =========================================================================

  /// Create a new community
  const factory CommunityEvent.createCommunity({
    required CreateCommunityParams params,
  }) = _CreateCommunity;

  /// Update a community's settings
  const factory CommunityEvent.updateCommunity({
    required String communityId,
    required UpdateCommunityParams params,
  }) = _UpdateCommunity;

  /// Delete (close) a community
  const factory CommunityEvent.deleteCommunity({
    required String communityId,
  }) = _DeleteCommunity;

  // =========================================================================
  // MEMBERSHIP
  // =========================================================================

  /// Invite a user to join a community
  const factory CommunityEvent.inviteMember({
    required String communityId,
    required String userId,
    required MemberRole role,
  }) = _InviteMember;

  /// Accept an invitation to join a community
  const factory CommunityEvent.acceptInvitation({
    required String communityId,
  }) = _AcceptInvitation;

  /// Decline an invitation to join a community
  const factory CommunityEvent.declineInvitation({
    required String communityId,
  }) = _DeclineInvitation;

  /// Remove a member from a community
  const factory CommunityEvent.removeMember({
    required String communityId,
    required String memberId,
  }) = _RemoveMember;

  /// Update a member's role
  const factory CommunityEvent.updateMemberRole({
    required String communityId,
    required String memberId,
    required MemberRole role,
  }) = _UpdateMemberRole;

  /// Leave a community (self-removal)
  const factory CommunityEvent.leaveCommunity({
    required String communityId,
  }) = _LeaveCommunity;

  /// Load pending invitations for the current user
  const factory CommunityEvent.loadPendingInvitations() =
      _LoadPendingInvitations;

  // =========================================================================
  // FINANCIAL
  // =========================================================================

  /// Contribute tokens to a community
  const factory CommunityEvent.contribute({
    required String communityId,
    required int amount,
    String? description,
  }) = _Contribute;

  /// Request a withdrawal from a community
  const factory CommunityEvent.withdraw({
    required String communityId,
    required int amount,
    String? description,
  }) = _Withdraw;

  /// Approve a pending transaction
  const factory CommunityEvent.approveTransaction({
    required String communityId,
    required String transactionId,
  }) = _ApproveTransaction;

  /// Reject a pending transaction
  const factory CommunityEvent.rejectTransaction({
    required String communityId,
    required String transactionId,
    String? reason,
  }) = _RejectTransaction;

  // =========================================================================
  // STOKVEL
  // =========================================================================

  /// Manually trigger a stokvel payout (admin only)
  const factory CommunityEvent.triggerPayout({
    required String communityId,
    String? recipientId,
  }) = _TriggerPayout;

  /// Load stokvel analytics
  const factory CommunityEvent.loadAnalytics({
    required String communityId,
    int? months,
  }) = _LoadAnalytics;

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  /// Total community unread count updated (from stream)
  const factory CommunityEvent.unreadCountUpdated(int count) =
      _UnreadCountUpdated;

  // =========================================================================
  // UTILITY
  // =========================================================================

  /// Clear selected community and cancel detail subscriptions
  const factory CommunityEvent.clearSelectedCommunity() =
      _ClearSelectedCommunity;

  /// Clear error/success messages
  const factory CommunityEvent.clearError() = _ClearError;
}
