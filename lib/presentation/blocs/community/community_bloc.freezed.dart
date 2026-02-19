// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommunityEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityEventCopyWith<$Res> {
  factory $CommunityEventCopyWith(
    CommunityEvent value,
    $Res Function(CommunityEvent) then,
  ) = _$CommunityEventCopyWithImpl<$Res, CommunityEvent>;
}

/// @nodoc
class _$CommunityEventCopyWithImpl<$Res, $Val extends CommunityEvent>
    implements $CommunityEventCopyWith<$Res> {
  _$CommunityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadUserCommunitiesImplCopyWith<$Res> {
  factory _$$LoadUserCommunitiesImplCopyWith(
    _$LoadUserCommunitiesImpl value,
    $Res Function(_$LoadUserCommunitiesImpl) then,
  ) = __$$LoadUserCommunitiesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadUserCommunitiesImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$LoadUserCommunitiesImpl>
    implements _$$LoadUserCommunitiesImplCopyWith<$Res> {
  __$$LoadUserCommunitiesImplCopyWithImpl(
    _$LoadUserCommunitiesImpl _value,
    $Res Function(_$LoadUserCommunitiesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadUserCommunitiesImpl implements _LoadUserCommunities {
  const _$LoadUserCommunitiesImpl();

  @override
  String toString() {
    return 'CommunityEvent.loadUserCommunities()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadUserCommunitiesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return loadUserCommunities();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return loadUserCommunities?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadUserCommunities != null) {
      return loadUserCommunities();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadUserCommunities(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadUserCommunities?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadUserCommunities != null) {
      return loadUserCommunities(this);
    }
    return orElse();
  }
}

abstract class _LoadUserCommunities implements CommunityEvent {
  const factory _LoadUserCommunities() = _$LoadUserCommunitiesImpl;
}

/// @nodoc
abstract class _$$WatchUserCommunitiesImplCopyWith<$Res> {
  factory _$$WatchUserCommunitiesImplCopyWith(
    _$WatchUserCommunitiesImpl value,
    $Res Function(_$WatchUserCommunitiesImpl) then,
  ) = __$$WatchUserCommunitiesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchUserCommunitiesImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$WatchUserCommunitiesImpl>
    implements _$$WatchUserCommunitiesImplCopyWith<$Res> {
  __$$WatchUserCommunitiesImplCopyWithImpl(
    _$WatchUserCommunitiesImpl _value,
    $Res Function(_$WatchUserCommunitiesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchUserCommunitiesImpl implements _WatchUserCommunities {
  const _$WatchUserCommunitiesImpl();

  @override
  String toString() {
    return 'CommunityEvent.watchUserCommunities()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchUserCommunitiesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return watchUserCommunities();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return watchUserCommunities?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchUserCommunities != null) {
      return watchUserCommunities();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchUserCommunities(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchUserCommunities?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchUserCommunities != null) {
      return watchUserCommunities(this);
    }
    return orElse();
  }
}

abstract class _WatchUserCommunities implements CommunityEvent {
  const factory _WatchUserCommunities() = _$WatchUserCommunitiesImpl;
}

/// @nodoc
abstract class _$$UserCommunitiesUpdatedImplCopyWith<$Res> {
  factory _$$UserCommunitiesUpdatedImplCopyWith(
    _$UserCommunitiesUpdatedImpl value,
    $Res Function(_$UserCommunitiesUpdatedImpl) then,
  ) = __$$UserCommunitiesUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Community> communities});
}

/// @nodoc
class __$$UserCommunitiesUpdatedImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$UserCommunitiesUpdatedImpl>
    implements _$$UserCommunitiesUpdatedImplCopyWith<$Res> {
  __$$UserCommunitiesUpdatedImplCopyWithImpl(
    _$UserCommunitiesUpdatedImpl _value,
    $Res Function(_$UserCommunitiesUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communities = null}) {
    return _then(
      _$UserCommunitiesUpdatedImpl(
        null == communities
            ? _value._communities
            : communities // ignore: cast_nullable_to_non_nullable
                  as List<Community>,
      ),
    );
  }
}

/// @nodoc

class _$UserCommunitiesUpdatedImpl implements _UserCommunitiesUpdated {
  const _$UserCommunitiesUpdatedImpl(final List<Community> communities)
    : _communities = communities;

  final List<Community> _communities;
  @override
  List<Community> get communities {
    if (_communities is EqualUnmodifiableListView) return _communities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_communities);
  }

  @override
  String toString() {
    return 'CommunityEvent.userCommunitiesUpdated(communities: $communities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCommunitiesUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._communities,
              _communities,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_communities),
  );

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCommunitiesUpdatedImplCopyWith<_$UserCommunitiesUpdatedImpl>
  get copyWith =>
      __$$UserCommunitiesUpdatedImplCopyWithImpl<_$UserCommunitiesUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return userCommunitiesUpdated(communities);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return userCommunitiesUpdated?.call(communities);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (userCommunitiesUpdated != null) {
      return userCommunitiesUpdated(communities);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return userCommunitiesUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return userCommunitiesUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (userCommunitiesUpdated != null) {
      return userCommunitiesUpdated(this);
    }
    return orElse();
  }
}

abstract class _UserCommunitiesUpdated implements CommunityEvent {
  const factory _UserCommunitiesUpdated(final List<Community> communities) =
      _$UserCommunitiesUpdatedImpl;

  List<Community> get communities;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserCommunitiesUpdatedImplCopyWith<_$UserCommunitiesUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadCommunityDetailsImplCopyWith<$Res> {
  factory _$$LoadCommunityDetailsImplCopyWith(
    _$LoadCommunityDetailsImpl value,
    $Res Function(_$LoadCommunityDetailsImpl) then,
  ) = __$$LoadCommunityDetailsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId});
}

/// @nodoc
class __$$LoadCommunityDetailsImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$LoadCommunityDetailsImpl>
    implements _$$LoadCommunityDetailsImplCopyWith<$Res> {
  __$$LoadCommunityDetailsImplCopyWithImpl(
    _$LoadCommunityDetailsImpl _value,
    $Res Function(_$LoadCommunityDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null}) {
    return _then(
      _$LoadCommunityDetailsImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadCommunityDetailsImpl implements _LoadCommunityDetails {
  const _$LoadCommunityDetailsImpl({required this.communityId});

  @override
  final String communityId;

  @override
  String toString() {
    return 'CommunityEvent.loadCommunityDetails(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadCommunityDetailsImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadCommunityDetailsImplCopyWith<_$LoadCommunityDetailsImpl>
  get copyWith =>
      __$$LoadCommunityDetailsImplCopyWithImpl<_$LoadCommunityDetailsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return loadCommunityDetails(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return loadCommunityDetails?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadCommunityDetails != null) {
      return loadCommunityDetails(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadCommunityDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadCommunityDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadCommunityDetails != null) {
      return loadCommunityDetails(this);
    }
    return orElse();
  }
}

abstract class _LoadCommunityDetails implements CommunityEvent {
  const factory _LoadCommunityDetails({required final String communityId}) =
      _$LoadCommunityDetailsImpl;

  String get communityId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadCommunityDetailsImplCopyWith<_$LoadCommunityDetailsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchMembersImplCopyWith<$Res> {
  factory _$$WatchMembersImplCopyWith(
    _$WatchMembersImpl value,
    $Res Function(_$WatchMembersImpl) then,
  ) = __$$WatchMembersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId});
}

/// @nodoc
class __$$WatchMembersImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$WatchMembersImpl>
    implements _$$WatchMembersImplCopyWith<$Res> {
  __$$WatchMembersImplCopyWithImpl(
    _$WatchMembersImpl _value,
    $Res Function(_$WatchMembersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null}) {
    return _then(
      _$WatchMembersImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchMembersImpl implements _WatchMembers {
  const _$WatchMembersImpl({required this.communityId});

  @override
  final String communityId;

  @override
  String toString() {
    return 'CommunityEvent.watchMembers(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchMembersImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchMembersImplCopyWith<_$WatchMembersImpl> get copyWith =>
      __$$WatchMembersImplCopyWithImpl<_$WatchMembersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return watchMembers(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return watchMembers?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchMembers != null) {
      return watchMembers(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchMembers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchMembers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchMembers != null) {
      return watchMembers(this);
    }
    return orElse();
  }
}

abstract class _WatchMembers implements CommunityEvent {
  const factory _WatchMembers({required final String communityId}) =
      _$WatchMembersImpl;

  String get communityId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchMembersImplCopyWith<_$WatchMembersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MembersUpdatedImplCopyWith<$Res> {
  factory _$$MembersUpdatedImplCopyWith(
    _$MembersUpdatedImpl value,
    $Res Function(_$MembersUpdatedImpl) then,
  ) = __$$MembersUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CommunityMember> members});
}

/// @nodoc
class __$$MembersUpdatedImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$MembersUpdatedImpl>
    implements _$$MembersUpdatedImplCopyWith<$Res> {
  __$$MembersUpdatedImplCopyWithImpl(
    _$MembersUpdatedImpl _value,
    $Res Function(_$MembersUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? members = null}) {
    return _then(
      _$MembersUpdatedImpl(
        null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<CommunityMember>,
      ),
    );
  }
}

/// @nodoc

class _$MembersUpdatedImpl implements _MembersUpdated {
  const _$MembersUpdatedImpl(final List<CommunityMember> members)
    : _members = members;

  final List<CommunityMember> _members;
  @override
  List<CommunityMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'CommunityEvent.membersUpdated(members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembersUpdatedImpl &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_members));

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MembersUpdatedImplCopyWith<_$MembersUpdatedImpl> get copyWith =>
      __$$MembersUpdatedImplCopyWithImpl<_$MembersUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return membersUpdated(members);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return membersUpdated?.call(members);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (membersUpdated != null) {
      return membersUpdated(members);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return membersUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return membersUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (membersUpdated != null) {
      return membersUpdated(this);
    }
    return orElse();
  }
}

abstract class _MembersUpdated implements CommunityEvent {
  const factory _MembersUpdated(final List<CommunityMember> members) =
      _$MembersUpdatedImpl;

  List<CommunityMember> get members;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MembersUpdatedImplCopyWith<_$MembersUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchTransactionsImplCopyWith<$Res> {
  factory _$$WatchTransactionsImplCopyWith(
    _$WatchTransactionsImpl value,
    $Res Function(_$WatchTransactionsImpl) then,
  ) = __$$WatchTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, int? limit});
}

/// @nodoc
class __$$WatchTransactionsImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$WatchTransactionsImpl>
    implements _$$WatchTransactionsImplCopyWith<$Res> {
  __$$WatchTransactionsImplCopyWithImpl(
    _$WatchTransactionsImpl _value,
    $Res Function(_$WatchTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null, Object? limit = freezed}) {
    return _then(
      _$WatchTransactionsImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$WatchTransactionsImpl implements _WatchTransactions {
  const _$WatchTransactionsImpl({required this.communityId, this.limit});

  @override
  final String communityId;
  @override
  final int? limit;

  @override
  String toString() {
    return 'CommunityEvent.watchTransactions(communityId: $communityId, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchTransactionsImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, limit);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchTransactionsImplCopyWith<_$WatchTransactionsImpl> get copyWith =>
      __$$WatchTransactionsImplCopyWithImpl<_$WatchTransactionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return watchTransactions(communityId, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return watchTransactions?.call(communityId, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchTransactions != null) {
      return watchTransactions(communityId, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchTransactions != null) {
      return watchTransactions(this);
    }
    return orElse();
  }
}

abstract class _WatchTransactions implements CommunityEvent {
  const factory _WatchTransactions({
    required final String communityId,
    final int? limit,
  }) = _$WatchTransactionsImpl;

  String get communityId;
  int? get limit;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchTransactionsImplCopyWith<_$WatchTransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionsUpdatedImplCopyWith<$Res> {
  factory _$$TransactionsUpdatedImplCopyWith(
    _$TransactionsUpdatedImpl value,
    $Res Function(_$TransactionsUpdatedImpl) then,
  ) = __$$TransactionsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CommunityTransaction> transactions});
}

/// @nodoc
class __$$TransactionsUpdatedImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$TransactionsUpdatedImpl>
    implements _$$TransactionsUpdatedImplCopyWith<$Res> {
  __$$TransactionsUpdatedImplCopyWithImpl(
    _$TransactionsUpdatedImpl _value,
    $Res Function(_$TransactionsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transactions = null}) {
    return _then(
      _$TransactionsUpdatedImpl(
        null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<CommunityTransaction>,
      ),
    );
  }
}

/// @nodoc

class _$TransactionsUpdatedImpl implements _TransactionsUpdated {
  const _$TransactionsUpdatedImpl(final List<CommunityTransaction> transactions)
    : _transactions = transactions;

  final List<CommunityTransaction> _transactions;
  @override
  List<CommunityTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  String toString() {
    return 'CommunityEvent.transactionsUpdated(transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_transactions),
  );

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsUpdatedImplCopyWith<_$TransactionsUpdatedImpl> get copyWith =>
      __$$TransactionsUpdatedImplCopyWithImpl<_$TransactionsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return transactionsUpdated(transactions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return transactionsUpdated?.call(transactions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (transactionsUpdated != null) {
      return transactionsUpdated(transactions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return transactionsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return transactionsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (transactionsUpdated != null) {
      return transactionsUpdated(this);
    }
    return orElse();
  }
}

abstract class _TransactionsUpdated implements CommunityEvent {
  const factory _TransactionsUpdated(
    final List<CommunityTransaction> transactions,
  ) = _$TransactionsUpdatedImpl;

  List<CommunityTransaction> get transactions;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsUpdatedImplCopyWith<_$TransactionsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchPendingApprovalsImplCopyWith<$Res> {
  factory _$$WatchPendingApprovalsImplCopyWith(
    _$WatchPendingApprovalsImpl value,
    $Res Function(_$WatchPendingApprovalsImpl) then,
  ) = __$$WatchPendingApprovalsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId});
}

/// @nodoc
class __$$WatchPendingApprovalsImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$WatchPendingApprovalsImpl>
    implements _$$WatchPendingApprovalsImplCopyWith<$Res> {
  __$$WatchPendingApprovalsImplCopyWithImpl(
    _$WatchPendingApprovalsImpl _value,
    $Res Function(_$WatchPendingApprovalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null}) {
    return _then(
      _$WatchPendingApprovalsImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchPendingApprovalsImpl implements _WatchPendingApprovals {
  const _$WatchPendingApprovalsImpl({required this.communityId});

  @override
  final String communityId;

  @override
  String toString() {
    return 'CommunityEvent.watchPendingApprovals(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchPendingApprovalsImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchPendingApprovalsImplCopyWith<_$WatchPendingApprovalsImpl>
  get copyWith =>
      __$$WatchPendingApprovalsImplCopyWithImpl<_$WatchPendingApprovalsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return watchPendingApprovals(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return watchPendingApprovals?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchPendingApprovals != null) {
      return watchPendingApprovals(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchPendingApprovals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchPendingApprovals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchPendingApprovals != null) {
      return watchPendingApprovals(this);
    }
    return orElse();
  }
}

abstract class _WatchPendingApprovals implements CommunityEvent {
  const factory _WatchPendingApprovals({required final String communityId}) =
      _$WatchPendingApprovalsImpl;

  String get communityId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchPendingApprovalsImplCopyWith<_$WatchPendingApprovalsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PendingApprovalsUpdatedImplCopyWith<$Res> {
  factory _$$PendingApprovalsUpdatedImplCopyWith(
    _$PendingApprovalsUpdatedImpl value,
    $Res Function(_$PendingApprovalsUpdatedImpl) then,
  ) = __$$PendingApprovalsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CommunityApproval> approvals});
}

/// @nodoc
class __$$PendingApprovalsUpdatedImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$PendingApprovalsUpdatedImpl>
    implements _$$PendingApprovalsUpdatedImplCopyWith<$Res> {
  __$$PendingApprovalsUpdatedImplCopyWithImpl(
    _$PendingApprovalsUpdatedImpl _value,
    $Res Function(_$PendingApprovalsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? approvals = null}) {
    return _then(
      _$PendingApprovalsUpdatedImpl(
        null == approvals
            ? _value._approvals
            : approvals // ignore: cast_nullable_to_non_nullable
                  as List<CommunityApproval>,
      ),
    );
  }
}

/// @nodoc

class _$PendingApprovalsUpdatedImpl implements _PendingApprovalsUpdated {
  const _$PendingApprovalsUpdatedImpl(final List<CommunityApproval> approvals)
    : _approvals = approvals;

  final List<CommunityApproval> _approvals;
  @override
  List<CommunityApproval> get approvals {
    if (_approvals is EqualUnmodifiableListView) return _approvals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_approvals);
  }

  @override
  String toString() {
    return 'CommunityEvent.pendingApprovalsUpdated(approvals: $approvals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingApprovalsUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._approvals,
              _approvals,
            ));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_approvals));

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingApprovalsUpdatedImplCopyWith<_$PendingApprovalsUpdatedImpl>
  get copyWith =>
      __$$PendingApprovalsUpdatedImplCopyWithImpl<
        _$PendingApprovalsUpdatedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return pendingApprovalsUpdated(approvals);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return pendingApprovalsUpdated?.call(approvals);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (pendingApprovalsUpdated != null) {
      return pendingApprovalsUpdated(approvals);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return pendingApprovalsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return pendingApprovalsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (pendingApprovalsUpdated != null) {
      return pendingApprovalsUpdated(this);
    }
    return orElse();
  }
}

abstract class _PendingApprovalsUpdated implements CommunityEvent {
  const factory _PendingApprovalsUpdated(
    final List<CommunityApproval> approvals,
  ) = _$PendingApprovalsUpdatedImpl;

  List<CommunityApproval> get approvals;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingApprovalsUpdatedImplCopyWith<_$PendingApprovalsUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateCommunityImplCopyWith<$Res> {
  factory _$$CreateCommunityImplCopyWith(
    _$CreateCommunityImpl value,
    $Res Function(_$CreateCommunityImpl) then,
  ) = __$$CreateCommunityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CreateCommunityParams params});
}

/// @nodoc
class __$$CreateCommunityImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$CreateCommunityImpl>
    implements _$$CreateCommunityImplCopyWith<$Res> {
  __$$CreateCommunityImplCopyWithImpl(
    _$CreateCommunityImpl _value,
    $Res Function(_$CreateCommunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? params = null}) {
    return _then(
      _$CreateCommunityImpl(
        params: null == params
            ? _value.params
            : params // ignore: cast_nullable_to_non_nullable
                  as CreateCommunityParams,
      ),
    );
  }
}

/// @nodoc

class _$CreateCommunityImpl implements _CreateCommunity {
  const _$CreateCommunityImpl({required this.params});

  @override
  final CreateCommunityParams params;

  @override
  String toString() {
    return 'CommunityEvent.createCommunity(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCommunityImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCommunityImplCopyWith<_$CreateCommunityImpl> get copyWith =>
      __$$CreateCommunityImplCopyWithImpl<_$CreateCommunityImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return createCommunity(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return createCommunity?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (createCommunity != null) {
      return createCommunity(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return createCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return createCommunity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (createCommunity != null) {
      return createCommunity(this);
    }
    return orElse();
  }
}

abstract class _CreateCommunity implements CommunityEvent {
  const factory _CreateCommunity({
    required final CreateCommunityParams params,
  }) = _$CreateCommunityImpl;

  CreateCommunityParams get params;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCommunityImplCopyWith<_$CreateCommunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCommunityImplCopyWith<$Res> {
  factory _$$UpdateCommunityImplCopyWith(
    _$UpdateCommunityImpl value,
    $Res Function(_$UpdateCommunityImpl) then,
  ) = __$$UpdateCommunityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, UpdateCommunityParams params});
}

/// @nodoc
class __$$UpdateCommunityImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$UpdateCommunityImpl>
    implements _$$UpdateCommunityImplCopyWith<$Res> {
  __$$UpdateCommunityImplCopyWithImpl(
    _$UpdateCommunityImpl _value,
    $Res Function(_$UpdateCommunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null, Object? params = null}) {
    return _then(
      _$UpdateCommunityImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        params: null == params
            ? _value.params
            : params // ignore: cast_nullable_to_non_nullable
                  as UpdateCommunityParams,
      ),
    );
  }
}

/// @nodoc

class _$UpdateCommunityImpl implements _UpdateCommunity {
  const _$UpdateCommunityImpl({
    required this.communityId,
    required this.params,
  });

  @override
  final String communityId;
  @override
  final UpdateCommunityParams params;

  @override
  String toString() {
    return 'CommunityEvent.updateCommunity(communityId: $communityId, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCommunityImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, params);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCommunityImplCopyWith<_$UpdateCommunityImpl> get copyWith =>
      __$$UpdateCommunityImplCopyWithImpl<_$UpdateCommunityImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return updateCommunity(communityId, params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return updateCommunity?.call(communityId, params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (updateCommunity != null) {
      return updateCommunity(communityId, params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return updateCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return updateCommunity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (updateCommunity != null) {
      return updateCommunity(this);
    }
    return orElse();
  }
}

abstract class _UpdateCommunity implements CommunityEvent {
  const factory _UpdateCommunity({
    required final String communityId,
    required final UpdateCommunityParams params,
  }) = _$UpdateCommunityImpl;

  String get communityId;
  UpdateCommunityParams get params;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCommunityImplCopyWith<_$UpdateCommunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCommunityImplCopyWith<$Res> {
  factory _$$DeleteCommunityImplCopyWith(
    _$DeleteCommunityImpl value,
    $Res Function(_$DeleteCommunityImpl) then,
  ) = __$$DeleteCommunityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId});
}

/// @nodoc
class __$$DeleteCommunityImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$DeleteCommunityImpl>
    implements _$$DeleteCommunityImplCopyWith<$Res> {
  __$$DeleteCommunityImplCopyWithImpl(
    _$DeleteCommunityImpl _value,
    $Res Function(_$DeleteCommunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null}) {
    return _then(
      _$DeleteCommunityImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteCommunityImpl implements _DeleteCommunity {
  const _$DeleteCommunityImpl({required this.communityId});

  @override
  final String communityId;

  @override
  String toString() {
    return 'CommunityEvent.deleteCommunity(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommunityImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCommunityImplCopyWith<_$DeleteCommunityImpl> get copyWith =>
      __$$DeleteCommunityImplCopyWithImpl<_$DeleteCommunityImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return deleteCommunity(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return deleteCommunity?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (deleteCommunity != null) {
      return deleteCommunity(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return deleteCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return deleteCommunity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (deleteCommunity != null) {
      return deleteCommunity(this);
    }
    return orElse();
  }
}

abstract class _DeleteCommunity implements CommunityEvent {
  const factory _DeleteCommunity({required final String communityId}) =
      _$DeleteCommunityImpl;

  String get communityId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteCommunityImplCopyWith<_$DeleteCommunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InviteMemberImplCopyWith<$Res> {
  factory _$$InviteMemberImplCopyWith(
    _$InviteMemberImpl value,
    $Res Function(_$InviteMemberImpl) then,
  ) = __$$InviteMemberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, String userId, MemberRole role});
}

/// @nodoc
class __$$InviteMemberImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$InviteMemberImpl>
    implements _$$InviteMemberImplCopyWith<$Res> {
  __$$InviteMemberImplCopyWithImpl(
    _$InviteMemberImpl _value,
    $Res Function(_$InviteMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? userId = null,
    Object? role = null,
  }) {
    return _then(
      _$InviteMemberImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as MemberRole,
      ),
    );
  }
}

/// @nodoc

class _$InviteMemberImpl implements _InviteMember {
  const _$InviteMemberImpl({
    required this.communityId,
    required this.userId,
    required this.role,
  });

  @override
  final String communityId;
  @override
  final String userId;
  @override
  final MemberRole role;

  @override
  String toString() {
    return 'CommunityEvent.inviteMember(communityId: $communityId, userId: $userId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InviteMemberImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, userId, role);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InviteMemberImplCopyWith<_$InviteMemberImpl> get copyWith =>
      __$$InviteMemberImplCopyWithImpl<_$InviteMemberImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return inviteMember(communityId, userId, role);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return inviteMember?.call(communityId, userId, role);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (inviteMember != null) {
      return inviteMember(communityId, userId, role);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return inviteMember(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return inviteMember?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (inviteMember != null) {
      return inviteMember(this);
    }
    return orElse();
  }
}

abstract class _InviteMember implements CommunityEvent {
  const factory _InviteMember({
    required final String communityId,
    required final String userId,
    required final MemberRole role,
  }) = _$InviteMemberImpl;

  String get communityId;
  String get userId;
  MemberRole get role;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InviteMemberImplCopyWith<_$InviteMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptInvitationImplCopyWith<$Res> {
  factory _$$AcceptInvitationImplCopyWith(
    _$AcceptInvitationImpl value,
    $Res Function(_$AcceptInvitationImpl) then,
  ) = __$$AcceptInvitationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId});
}

/// @nodoc
class __$$AcceptInvitationImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$AcceptInvitationImpl>
    implements _$$AcceptInvitationImplCopyWith<$Res> {
  __$$AcceptInvitationImplCopyWithImpl(
    _$AcceptInvitationImpl _value,
    $Res Function(_$AcceptInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null}) {
    return _then(
      _$AcceptInvitationImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AcceptInvitationImpl implements _AcceptInvitation {
  const _$AcceptInvitationImpl({required this.communityId});

  @override
  final String communityId;

  @override
  String toString() {
    return 'CommunityEvent.acceptInvitation(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptInvitationImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptInvitationImplCopyWith<_$AcceptInvitationImpl> get copyWith =>
      __$$AcceptInvitationImplCopyWithImpl<_$AcceptInvitationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return acceptInvitation(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return acceptInvitation?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (acceptInvitation != null) {
      return acceptInvitation(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return acceptInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return acceptInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (acceptInvitation != null) {
      return acceptInvitation(this);
    }
    return orElse();
  }
}

abstract class _AcceptInvitation implements CommunityEvent {
  const factory _AcceptInvitation({required final String communityId}) =
      _$AcceptInvitationImpl;

  String get communityId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptInvitationImplCopyWith<_$AcceptInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeclineInvitationImplCopyWith<$Res> {
  factory _$$DeclineInvitationImplCopyWith(
    _$DeclineInvitationImpl value,
    $Res Function(_$DeclineInvitationImpl) then,
  ) = __$$DeclineInvitationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId});
}

/// @nodoc
class __$$DeclineInvitationImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$DeclineInvitationImpl>
    implements _$$DeclineInvitationImplCopyWith<$Res> {
  __$$DeclineInvitationImplCopyWithImpl(
    _$DeclineInvitationImpl _value,
    $Res Function(_$DeclineInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null}) {
    return _then(
      _$DeclineInvitationImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeclineInvitationImpl implements _DeclineInvitation {
  const _$DeclineInvitationImpl({required this.communityId});

  @override
  final String communityId;

  @override
  String toString() {
    return 'CommunityEvent.declineInvitation(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeclineInvitationImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeclineInvitationImplCopyWith<_$DeclineInvitationImpl> get copyWith =>
      __$$DeclineInvitationImplCopyWithImpl<_$DeclineInvitationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return declineInvitation(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return declineInvitation?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (declineInvitation != null) {
      return declineInvitation(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return declineInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return declineInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (declineInvitation != null) {
      return declineInvitation(this);
    }
    return orElse();
  }
}

abstract class _DeclineInvitation implements CommunityEvent {
  const factory _DeclineInvitation({required final String communityId}) =
      _$DeclineInvitationImpl;

  String get communityId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeclineInvitationImplCopyWith<_$DeclineInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveMemberImplCopyWith<$Res> {
  factory _$$RemoveMemberImplCopyWith(
    _$RemoveMemberImpl value,
    $Res Function(_$RemoveMemberImpl) then,
  ) = __$$RemoveMemberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, String memberId});
}

/// @nodoc
class __$$RemoveMemberImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$RemoveMemberImpl>
    implements _$$RemoveMemberImplCopyWith<$Res> {
  __$$RemoveMemberImplCopyWithImpl(
    _$RemoveMemberImpl _value,
    $Res Function(_$RemoveMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null, Object? memberId = null}) {
    return _then(
      _$RemoveMemberImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        memberId: null == memberId
            ? _value.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveMemberImpl implements _RemoveMember {
  const _$RemoveMemberImpl({required this.communityId, required this.memberId});

  @override
  final String communityId;
  @override
  final String memberId;

  @override
  String toString() {
    return 'CommunityEvent.removeMember(communityId: $communityId, memberId: $memberId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveMemberImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, memberId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveMemberImplCopyWith<_$RemoveMemberImpl> get copyWith =>
      __$$RemoveMemberImplCopyWithImpl<_$RemoveMemberImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return removeMember(communityId, memberId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return removeMember?.call(communityId, memberId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (removeMember != null) {
      return removeMember(communityId, memberId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return removeMember(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return removeMember?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (removeMember != null) {
      return removeMember(this);
    }
    return orElse();
  }
}

abstract class _RemoveMember implements CommunityEvent {
  const factory _RemoveMember({
    required final String communityId,
    required final String memberId,
  }) = _$RemoveMemberImpl;

  String get communityId;
  String get memberId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveMemberImplCopyWith<_$RemoveMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateMemberRoleImplCopyWith<$Res> {
  factory _$$UpdateMemberRoleImplCopyWith(
    _$UpdateMemberRoleImpl value,
    $Res Function(_$UpdateMemberRoleImpl) then,
  ) = __$$UpdateMemberRoleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, String memberId, MemberRole role});
}

/// @nodoc
class __$$UpdateMemberRoleImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$UpdateMemberRoleImpl>
    implements _$$UpdateMemberRoleImplCopyWith<$Res> {
  __$$UpdateMemberRoleImplCopyWithImpl(
    _$UpdateMemberRoleImpl _value,
    $Res Function(_$UpdateMemberRoleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? memberId = null,
    Object? role = null,
  }) {
    return _then(
      _$UpdateMemberRoleImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        memberId: null == memberId
            ? _value.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as MemberRole,
      ),
    );
  }
}

/// @nodoc

class _$UpdateMemberRoleImpl implements _UpdateMemberRole {
  const _$UpdateMemberRoleImpl({
    required this.communityId,
    required this.memberId,
    required this.role,
  });

  @override
  final String communityId;
  @override
  final String memberId;
  @override
  final MemberRole role;

  @override
  String toString() {
    return 'CommunityEvent.updateMemberRole(communityId: $communityId, memberId: $memberId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMemberRoleImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.role, role) || other.role == role));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, memberId, role);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMemberRoleImplCopyWith<_$UpdateMemberRoleImpl> get copyWith =>
      __$$UpdateMemberRoleImplCopyWithImpl<_$UpdateMemberRoleImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return updateMemberRole(communityId, memberId, role);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return updateMemberRole?.call(communityId, memberId, role);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (updateMemberRole != null) {
      return updateMemberRole(communityId, memberId, role);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return updateMemberRole(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return updateMemberRole?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (updateMemberRole != null) {
      return updateMemberRole(this);
    }
    return orElse();
  }
}

abstract class _UpdateMemberRole implements CommunityEvent {
  const factory _UpdateMemberRole({
    required final String communityId,
    required final String memberId,
    required final MemberRole role,
  }) = _$UpdateMemberRoleImpl;

  String get communityId;
  String get memberId;
  MemberRole get role;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMemberRoleImplCopyWith<_$UpdateMemberRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LeaveCommunityImplCopyWith<$Res> {
  factory _$$LeaveCommunityImplCopyWith(
    _$LeaveCommunityImpl value,
    $Res Function(_$LeaveCommunityImpl) then,
  ) = __$$LeaveCommunityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId});
}

/// @nodoc
class __$$LeaveCommunityImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$LeaveCommunityImpl>
    implements _$$LeaveCommunityImplCopyWith<$Res> {
  __$$LeaveCommunityImplCopyWithImpl(
    _$LeaveCommunityImpl _value,
    $Res Function(_$LeaveCommunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null}) {
    return _then(
      _$LeaveCommunityImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LeaveCommunityImpl implements _LeaveCommunity {
  const _$LeaveCommunityImpl({required this.communityId});

  @override
  final String communityId;

  @override
  String toString() {
    return 'CommunityEvent.leaveCommunity(communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveCommunityImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveCommunityImplCopyWith<_$LeaveCommunityImpl> get copyWith =>
      __$$LeaveCommunityImplCopyWithImpl<_$LeaveCommunityImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return leaveCommunity(communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return leaveCommunity?.call(communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (leaveCommunity != null) {
      return leaveCommunity(communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return leaveCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return leaveCommunity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (leaveCommunity != null) {
      return leaveCommunity(this);
    }
    return orElse();
  }
}

abstract class _LeaveCommunity implements CommunityEvent {
  const factory _LeaveCommunity({required final String communityId}) =
      _$LeaveCommunityImpl;

  String get communityId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveCommunityImplCopyWith<_$LeaveCommunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadPendingInvitationsImplCopyWith<$Res> {
  factory _$$LoadPendingInvitationsImplCopyWith(
    _$LoadPendingInvitationsImpl value,
    $Res Function(_$LoadPendingInvitationsImpl) then,
  ) = __$$LoadPendingInvitationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadPendingInvitationsImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$LoadPendingInvitationsImpl>
    implements _$$LoadPendingInvitationsImplCopyWith<$Res> {
  __$$LoadPendingInvitationsImplCopyWithImpl(
    _$LoadPendingInvitationsImpl _value,
    $Res Function(_$LoadPendingInvitationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadPendingInvitationsImpl implements _LoadPendingInvitations {
  const _$LoadPendingInvitationsImpl();

  @override
  String toString() {
    return 'CommunityEvent.loadPendingInvitations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPendingInvitationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return loadPendingInvitations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return loadPendingInvitations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadPendingInvitations != null) {
      return loadPendingInvitations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadPendingInvitations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadPendingInvitations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadPendingInvitations != null) {
      return loadPendingInvitations(this);
    }
    return orElse();
  }
}

abstract class _LoadPendingInvitations implements CommunityEvent {
  const factory _LoadPendingInvitations() = _$LoadPendingInvitationsImpl;
}

/// @nodoc
abstract class _$$ContributeImplCopyWith<$Res> {
  factory _$$ContributeImplCopyWith(
    _$ContributeImpl value,
    $Res Function(_$ContributeImpl) then,
  ) = __$$ContributeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, int amount, String? description});
}

/// @nodoc
class __$$ContributeImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$ContributeImpl>
    implements _$$ContributeImplCopyWith<$Res> {
  __$$ContributeImplCopyWithImpl(
    _$ContributeImpl _value,
    $Res Function(_$ContributeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? amount = null,
    Object? description = freezed,
  }) {
    return _then(
      _$ContributeImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ContributeImpl implements _Contribute {
  const _$ContributeImpl({
    required this.communityId,
    required this.amount,
    this.description,
  });

  @override
  final String communityId;
  @override
  final int amount;
  @override
  final String? description;

  @override
  String toString() {
    return 'CommunityEvent.contribute(communityId: $communityId, amount: $amount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributeImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, communityId, amount, description);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributeImplCopyWith<_$ContributeImpl> get copyWith =>
      __$$ContributeImplCopyWithImpl<_$ContributeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return contribute(communityId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return contribute?.call(communityId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (contribute != null) {
      return contribute(communityId, amount, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return contribute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return contribute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (contribute != null) {
      return contribute(this);
    }
    return orElse();
  }
}

abstract class _Contribute implements CommunityEvent {
  const factory _Contribute({
    required final String communityId,
    required final int amount,
    final String? description,
  }) = _$ContributeImpl;

  String get communityId;
  int get amount;
  String? get description;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContributeImplCopyWith<_$ContributeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WithdrawImplCopyWith<$Res> {
  factory _$$WithdrawImplCopyWith(
    _$WithdrawImpl value,
    $Res Function(_$WithdrawImpl) then,
  ) = __$$WithdrawImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, int amount, String? description});
}

/// @nodoc
class __$$WithdrawImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$WithdrawImpl>
    implements _$$WithdrawImplCopyWith<$Res> {
  __$$WithdrawImplCopyWithImpl(
    _$WithdrawImpl _value,
    $Res Function(_$WithdrawImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? amount = null,
    Object? description = freezed,
  }) {
    return _then(
      _$WithdrawImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WithdrawImpl implements _Withdraw {
  const _$WithdrawImpl({
    required this.communityId,
    required this.amount,
    this.description,
  });

  @override
  final String communityId;
  @override
  final int amount;
  @override
  final String? description;

  @override
  String toString() {
    return 'CommunityEvent.withdraw(communityId: $communityId, amount: $amount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, communityId, amount, description);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawImplCopyWith<_$WithdrawImpl> get copyWith =>
      __$$WithdrawImplCopyWithImpl<_$WithdrawImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return withdraw(communityId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return withdraw?.call(communityId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (withdraw != null) {
      return withdraw(communityId, amount, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return withdraw(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return withdraw?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (withdraw != null) {
      return withdraw(this);
    }
    return orElse();
  }
}

abstract class _Withdraw implements CommunityEvent {
  const factory _Withdraw({
    required final String communityId,
    required final int amount,
    final String? description,
  }) = _$WithdrawImpl;

  String get communityId;
  int get amount;
  String? get description;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawImplCopyWith<_$WithdrawImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApproveTransactionImplCopyWith<$Res> {
  factory _$$ApproveTransactionImplCopyWith(
    _$ApproveTransactionImpl value,
    $Res Function(_$ApproveTransactionImpl) then,
  ) = __$$ApproveTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, String transactionId});
}

/// @nodoc
class __$$ApproveTransactionImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$ApproveTransactionImpl>
    implements _$$ApproveTransactionImplCopyWith<$Res> {
  __$$ApproveTransactionImplCopyWithImpl(
    _$ApproveTransactionImpl _value,
    $Res Function(_$ApproveTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null, Object? transactionId = null}) {
    return _then(
      _$ApproveTransactionImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ApproveTransactionImpl implements _ApproveTransaction {
  const _$ApproveTransactionImpl({
    required this.communityId,
    required this.transactionId,
  });

  @override
  final String communityId;
  @override
  final String transactionId;

  @override
  String toString() {
    return 'CommunityEvent.approveTransaction(communityId: $communityId, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApproveTransactionImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, transactionId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApproveTransactionImplCopyWith<_$ApproveTransactionImpl> get copyWith =>
      __$$ApproveTransactionImplCopyWithImpl<_$ApproveTransactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return approveTransaction(communityId, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return approveTransaction?.call(communityId, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (approveTransaction != null) {
      return approveTransaction(communityId, transactionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return approveTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return approveTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (approveTransaction != null) {
      return approveTransaction(this);
    }
    return orElse();
  }
}

abstract class _ApproveTransaction implements CommunityEvent {
  const factory _ApproveTransaction({
    required final String communityId,
    required final String transactionId,
  }) = _$ApproveTransactionImpl;

  String get communityId;
  String get transactionId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApproveTransactionImplCopyWith<_$ApproveTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RejectTransactionImplCopyWith<$Res> {
  factory _$$RejectTransactionImplCopyWith(
    _$RejectTransactionImpl value,
    $Res Function(_$RejectTransactionImpl) then,
  ) = __$$RejectTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, String transactionId, String? reason});
}

/// @nodoc
class __$$RejectTransactionImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$RejectTransactionImpl>
    implements _$$RejectTransactionImplCopyWith<$Res> {
  __$$RejectTransactionImplCopyWithImpl(
    _$RejectTransactionImpl _value,
    $Res Function(_$RejectTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? transactionId = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$RejectTransactionImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RejectTransactionImpl implements _RejectTransaction {
  const _$RejectTransactionImpl({
    required this.communityId,
    required this.transactionId,
    this.reason,
  });

  @override
  final String communityId;
  @override
  final String transactionId;
  @override
  final String? reason;

  @override
  String toString() {
    return 'CommunityEvent.rejectTransaction(communityId: $communityId, transactionId: $transactionId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RejectTransactionImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, communityId, transactionId, reason);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RejectTransactionImplCopyWith<_$RejectTransactionImpl> get copyWith =>
      __$$RejectTransactionImplCopyWithImpl<_$RejectTransactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return rejectTransaction(communityId, transactionId, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return rejectTransaction?.call(communityId, transactionId, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (rejectTransaction != null) {
      return rejectTransaction(communityId, transactionId, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return rejectTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return rejectTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (rejectTransaction != null) {
      return rejectTransaction(this);
    }
    return orElse();
  }
}

abstract class _RejectTransaction implements CommunityEvent {
  const factory _RejectTransaction({
    required final String communityId,
    required final String transactionId,
    final String? reason,
  }) = _$RejectTransactionImpl;

  String get communityId;
  String get transactionId;
  String? get reason;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RejectTransactionImplCopyWith<_$RejectTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TriggerPayoutImplCopyWith<$Res> {
  factory _$$TriggerPayoutImplCopyWith(
    _$TriggerPayoutImpl value,
    $Res Function(_$TriggerPayoutImpl) then,
  ) = __$$TriggerPayoutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, String? recipientId});
}

/// @nodoc
class __$$TriggerPayoutImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$TriggerPayoutImpl>
    implements _$$TriggerPayoutImplCopyWith<$Res> {
  __$$TriggerPayoutImplCopyWithImpl(
    _$TriggerPayoutImpl _value,
    $Res Function(_$TriggerPayoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null, Object? recipientId = freezed}) {
    return _then(
      _$TriggerPayoutImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: freezed == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TriggerPayoutImpl implements _TriggerPayout {
  const _$TriggerPayoutImpl({required this.communityId, this.recipientId});

  @override
  final String communityId;
  @override
  final String? recipientId;

  @override
  String toString() {
    return 'CommunityEvent.triggerPayout(communityId: $communityId, recipientId: $recipientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriggerPayoutImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, recipientId);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriggerPayoutImplCopyWith<_$TriggerPayoutImpl> get copyWith =>
      __$$TriggerPayoutImplCopyWithImpl<_$TriggerPayoutImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return triggerPayout(communityId, recipientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return triggerPayout?.call(communityId, recipientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (triggerPayout != null) {
      return triggerPayout(communityId, recipientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return triggerPayout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return triggerPayout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (triggerPayout != null) {
      return triggerPayout(this);
    }
    return orElse();
  }
}

abstract class _TriggerPayout implements CommunityEvent {
  const factory _TriggerPayout({
    required final String communityId,
    final String? recipientId,
  }) = _$TriggerPayoutImpl;

  String get communityId;
  String? get recipientId;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriggerPayoutImplCopyWith<_$TriggerPayoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadAnalyticsImplCopyWith<$Res> {
  factory _$$LoadAnalyticsImplCopyWith(
    _$LoadAnalyticsImpl value,
    $Res Function(_$LoadAnalyticsImpl) then,
  ) = __$$LoadAnalyticsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String communityId, int? months});
}

/// @nodoc
class __$$LoadAnalyticsImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$LoadAnalyticsImpl>
    implements _$$LoadAnalyticsImplCopyWith<$Res> {
  __$$LoadAnalyticsImplCopyWithImpl(
    _$LoadAnalyticsImpl _value,
    $Res Function(_$LoadAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? communityId = null, Object? months = freezed}) {
    return _then(
      _$LoadAnalyticsImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        months: freezed == months
            ? _value.months
            : months // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadAnalyticsImpl implements _LoadAnalytics {
  const _$LoadAnalyticsImpl({required this.communityId, this.months});

  @override
  final String communityId;
  @override
  final int? months;

  @override
  String toString() {
    return 'CommunityEvent.loadAnalytics(communityId: $communityId, months: $months)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadAnalyticsImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.months, months) || other.months == months));
  }

  @override
  int get hashCode => Object.hash(runtimeType, communityId, months);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadAnalyticsImplCopyWith<_$LoadAnalyticsImpl> get copyWith =>
      __$$LoadAnalyticsImplCopyWithImpl<_$LoadAnalyticsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return loadAnalytics(communityId, months);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return loadAnalytics?.call(communityId, months);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadAnalytics != null) {
      return loadAnalytics(communityId, months);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadAnalytics(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadAnalytics?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadAnalytics != null) {
      return loadAnalytics(this);
    }
    return orElse();
  }
}

abstract class _LoadAnalytics implements CommunityEvent {
  const factory _LoadAnalytics({
    required final String communityId,
    final int? months,
  }) = _$LoadAnalyticsImpl;

  String get communityId;
  int? get months;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadAnalyticsImplCopyWith<_$LoadAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnreadCountUpdatedImplCopyWith<$Res> {
  factory _$$UnreadCountUpdatedImplCopyWith(
    _$UnreadCountUpdatedImpl value,
    $Res Function(_$UnreadCountUpdatedImpl) then,
  ) = __$$UnreadCountUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int count});
}

/// @nodoc
class __$$UnreadCountUpdatedImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$UnreadCountUpdatedImpl>
    implements _$$UnreadCountUpdatedImplCopyWith<$Res> {
  __$$UnreadCountUpdatedImplCopyWithImpl(
    _$UnreadCountUpdatedImpl _value,
    $Res Function(_$UnreadCountUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? count = null}) {
    return _then(
      _$UnreadCountUpdatedImpl(
        null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$UnreadCountUpdatedImpl implements _UnreadCountUpdated {
  const _$UnreadCountUpdatedImpl(this.count);

  @override
  final int count;

  @override
  String toString() {
    return 'CommunityEvent.unreadCountUpdated(count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnreadCountUpdatedImpl &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnreadCountUpdatedImplCopyWith<_$UnreadCountUpdatedImpl> get copyWith =>
      __$$UnreadCountUpdatedImplCopyWithImpl<_$UnreadCountUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return unreadCountUpdated(count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return unreadCountUpdated?.call(count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (unreadCountUpdated != null) {
      return unreadCountUpdated(count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return unreadCountUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return unreadCountUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (unreadCountUpdated != null) {
      return unreadCountUpdated(this);
    }
    return orElse();
  }
}

abstract class _UnreadCountUpdated implements CommunityEvent {
  const factory _UnreadCountUpdated(final int count) = _$UnreadCountUpdatedImpl;

  int get count;

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnreadCountUpdatedImplCopyWith<_$UnreadCountUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSelectedCommunityImplCopyWith<$Res> {
  factory _$$ClearSelectedCommunityImplCopyWith(
    _$ClearSelectedCommunityImpl value,
    $Res Function(_$ClearSelectedCommunityImpl) then,
  ) = __$$ClearSelectedCommunityImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSelectedCommunityImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$ClearSelectedCommunityImpl>
    implements _$$ClearSelectedCommunityImplCopyWith<$Res> {
  __$$ClearSelectedCommunityImplCopyWithImpl(
    _$ClearSelectedCommunityImpl _value,
    $Res Function(_$ClearSelectedCommunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSelectedCommunityImpl implements _ClearSelectedCommunity {
  const _$ClearSelectedCommunityImpl();

  @override
  String toString() {
    return 'CommunityEvent.clearSelectedCommunity()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClearSelectedCommunityImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return clearSelectedCommunity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return clearSelectedCommunity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearSelectedCommunity != null) {
      return clearSelectedCommunity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearSelectedCommunity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearSelectedCommunity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearSelectedCommunity != null) {
      return clearSelectedCommunity(this);
    }
    return orElse();
  }
}

abstract class _ClearSelectedCommunity implements CommunityEvent {
  const factory _ClearSelectedCommunity() = _$ClearSelectedCommunityImpl;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$CommunityEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'CommunityEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserCommunities,
    required TResult Function() watchUserCommunities,
    required TResult Function(List<Community> communities)
    userCommunitiesUpdated,
    required TResult Function(String communityId) loadCommunityDetails,
    required TResult Function(String communityId) watchMembers,
    required TResult Function(List<CommunityMember> members) membersUpdated,
    required TResult Function(String communityId, int? limit) watchTransactions,
    required TResult Function(List<CommunityTransaction> transactions)
    transactionsUpdated,
    required TResult Function(String communityId) watchPendingApprovals,
    required TResult Function(List<CommunityApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateCommunityParams params) createCommunity,
    required TResult Function(String communityId, UpdateCommunityParams params)
    updateCommunity,
    required TResult Function(String communityId) deleteCommunity,
    required TResult Function(
      String communityId,
      String userId,
      MemberRole role,
    )
    inviteMember,
    required TResult Function(String communityId) acceptInvitation,
    required TResult Function(String communityId) declineInvitation,
    required TResult Function(String communityId, String memberId) removeMember,
    required TResult Function(
      String communityId,
      String memberId,
      MemberRole role,
    )
    updateMemberRole,
    required TResult Function(String communityId) leaveCommunity,
    required TResult Function() loadPendingInvitations,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    contribute,
    required TResult Function(
      String communityId,
      int amount,
      String? description,
    )
    withdraw,
    required TResult Function(String communityId, String transactionId)
    approveTransaction,
    required TResult Function(
      String communityId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String communityId, String? recipientId)
    triggerPayout,
    required TResult Function(String communityId, int? months) loadAnalytics,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function() clearSelectedCommunity,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserCommunities,
    TResult? Function()? watchUserCommunities,
    TResult? Function(List<Community> communities)? userCommunitiesUpdated,
    TResult? Function(String communityId)? loadCommunityDetails,
    TResult? Function(String communityId)? watchMembers,
    TResult? Function(List<CommunityMember> members)? membersUpdated,
    TResult? Function(String communityId, int? limit)? watchTransactions,
    TResult? Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult? Function(String communityId)? watchPendingApprovals,
    TResult? Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult? Function(CreateCommunityParams params)? createCommunity,
    TResult? Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult? Function(String communityId)? deleteCommunity,
    TResult? Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult? Function(String communityId)? acceptInvitation,
    TResult? Function(String communityId)? declineInvitation,
    TResult? Function(String communityId, String memberId)? removeMember,
    TResult? Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult? Function(String communityId)? leaveCommunity,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String communityId, int amount, String? description)?
    contribute,
    TResult? Function(String communityId, int amount, String? description)?
    withdraw,
    TResult? Function(String communityId, String transactionId)?
    approveTransaction,
    TResult? Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String communityId, String? recipientId)? triggerPayout,
    TResult? Function(String communityId, int? months)? loadAnalytics,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function()? clearSelectedCommunity,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserCommunities,
    TResult Function()? watchUserCommunities,
    TResult Function(List<Community> communities)? userCommunitiesUpdated,
    TResult Function(String communityId)? loadCommunityDetails,
    TResult Function(String communityId)? watchMembers,
    TResult Function(List<CommunityMember> members)? membersUpdated,
    TResult Function(String communityId, int? limit)? watchTransactions,
    TResult Function(List<CommunityTransaction> transactions)?
    transactionsUpdated,
    TResult Function(String communityId)? watchPendingApprovals,
    TResult Function(List<CommunityApproval> approvals)?
    pendingApprovalsUpdated,
    TResult Function(CreateCommunityParams params)? createCommunity,
    TResult Function(String communityId, UpdateCommunityParams params)?
    updateCommunity,
    TResult Function(String communityId)? deleteCommunity,
    TResult Function(String communityId, String userId, MemberRole role)?
    inviteMember,
    TResult Function(String communityId)? acceptInvitation,
    TResult Function(String communityId)? declineInvitation,
    TResult Function(String communityId, String memberId)? removeMember,
    TResult Function(String communityId, String memberId, MemberRole role)?
    updateMemberRole,
    TResult Function(String communityId)? leaveCommunity,
    TResult Function()? loadPendingInvitations,
    TResult Function(String communityId, int amount, String? description)?
    contribute,
    TResult Function(String communityId, int amount, String? description)?
    withdraw,
    TResult Function(String communityId, String transactionId)?
    approveTransaction,
    TResult Function(String communityId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String communityId, String? recipientId)? triggerPayout,
    TResult Function(String communityId, int? months)? loadAnalytics,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function()? clearSelectedCommunity,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserCommunities value) loadUserCommunities,
    required TResult Function(_WatchUserCommunities value) watchUserCommunities,
    required TResult Function(_UserCommunitiesUpdated value)
    userCommunitiesUpdated,
    required TResult Function(_LoadCommunityDetails value) loadCommunityDetails,
    required TResult Function(_WatchMembers value) watchMembers,
    required TResult Function(_MembersUpdated value) membersUpdated,
    required TResult Function(_WatchTransactions value) watchTransactions,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateCommunity value) createCommunity,
    required TResult Function(_UpdateCommunity value) updateCommunity,
    required TResult Function(_DeleteCommunity value) deleteCommunity,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveCommunity value) leaveCommunity,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_Withdraw value) withdraw,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerPayout value) triggerPayout,
    required TResult Function(_LoadAnalytics value) loadAnalytics,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearSelectedCommunity value)
    clearSelectedCommunity,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult? Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult? Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult? Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult? Function(_WatchMembers value)? watchMembers,
    TResult? Function(_MembersUpdated value)? membersUpdated,
    TResult? Function(_WatchTransactions value)? watchTransactions,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateCommunity value)? createCommunity,
    TResult? Function(_UpdateCommunity value)? updateCommunity,
    TResult? Function(_DeleteCommunity value)? deleteCommunity,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveCommunity value)? leaveCommunity,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_Withdraw value)? withdraw,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerPayout value)? triggerPayout,
    TResult? Function(_LoadAnalytics value)? loadAnalytics,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserCommunities value)? loadUserCommunities,
    TResult Function(_WatchUserCommunities value)? watchUserCommunities,
    TResult Function(_UserCommunitiesUpdated value)? userCommunitiesUpdated,
    TResult Function(_LoadCommunityDetails value)? loadCommunityDetails,
    TResult Function(_WatchMembers value)? watchMembers,
    TResult Function(_MembersUpdated value)? membersUpdated,
    TResult Function(_WatchTransactions value)? watchTransactions,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateCommunity value)? createCommunity,
    TResult Function(_UpdateCommunity value)? updateCommunity,
    TResult Function(_DeleteCommunity value)? deleteCommunity,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveCommunity value)? leaveCommunity,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_Withdraw value)? withdraw,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerPayout value)? triggerPayout,
    TResult Function(_LoadAnalytics value)? loadAnalytics,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearSelectedCommunity value)? clearSelectedCommunity,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements CommunityEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
mixin _$CommunityState {
  // Status
  CommunityLoadingStatus get status => throw _privateConstructorUsedError;
  CommunityOperationStatus get operationStatus =>
      throw _privateConstructorUsedError; // Communities list
  List<Community> get communities => throw _privateConstructorUsedError;
  List<CommunityMember> get pendingInvitations =>
      throw _privateConstructorUsedError; // Selected community details
  Community? get selectedCommunity => throw _privateConstructorUsedError;
  List<CommunityMember> get selectedCommunityMembers =>
      throw _privateConstructorUsedError;
  List<CommunityTransaction> get selectedCommunityTransactions =>
      throw _privateConstructorUsedError;
  List<CommunityApproval> get selectedCommunityApprovals =>
      throw _privateConstructorUsedError; // Loading states
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMoreTransactions =>
      throw _privateConstructorUsedError; // Stokvel analytics
  StokvelAnalytics? get stokvelAnalytics => throw _privateConstructorUsedError;
  bool get isLoadingAnalytics => throw _privateConstructorUsedError; // Unread
  int get totalUnreadCount =>
      throw _privateConstructorUsedError; // Error handling
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityStateCopyWith<CommunityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityStateCopyWith<$Res> {
  factory $CommunityStateCopyWith(
    CommunityState value,
    $Res Function(CommunityState) then,
  ) = _$CommunityStateCopyWithImpl<$Res, CommunityState>;
  @useResult
  $Res call({
    CommunityLoadingStatus status,
    CommunityOperationStatus operationStatus,
    List<Community> communities,
    List<CommunityMember> pendingInvitations,
    Community? selectedCommunity,
    List<CommunityMember> selectedCommunityMembers,
    List<CommunityTransaction> selectedCommunityTransactions,
    List<CommunityApproval> selectedCommunityApprovals,
    bool isLoadingMore,
    bool hasMoreTransactions,
    StokvelAnalytics? stokvelAnalytics,
    bool isLoadingAnalytics,
    int totalUnreadCount,
    String? errorMessage,
    String? successMessage,
  });

  $CommunityCopyWith<$Res>? get selectedCommunity;
}

/// @nodoc
class _$CommunityStateCopyWithImpl<$Res, $Val extends CommunityState>
    implements $CommunityStateCopyWith<$Res> {
  _$CommunityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? operationStatus = null,
    Object? communities = null,
    Object? pendingInvitations = null,
    Object? selectedCommunity = freezed,
    Object? selectedCommunityMembers = null,
    Object? selectedCommunityTransactions = null,
    Object? selectedCommunityApprovals = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? stokvelAnalytics = freezed,
    Object? isLoadingAnalytics = null,
    Object? totalUnreadCount = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CommunityLoadingStatus,
            operationStatus: null == operationStatus
                ? _value.operationStatus
                : operationStatus // ignore: cast_nullable_to_non_nullable
                      as CommunityOperationStatus,
            communities: null == communities
                ? _value.communities
                : communities // ignore: cast_nullable_to_non_nullable
                      as List<Community>,
            pendingInvitations: null == pendingInvitations
                ? _value.pendingInvitations
                : pendingInvitations // ignore: cast_nullable_to_non_nullable
                      as List<CommunityMember>,
            selectedCommunity: freezed == selectedCommunity
                ? _value.selectedCommunity
                : selectedCommunity // ignore: cast_nullable_to_non_nullable
                      as Community?,
            selectedCommunityMembers: null == selectedCommunityMembers
                ? _value.selectedCommunityMembers
                : selectedCommunityMembers // ignore: cast_nullable_to_non_nullable
                      as List<CommunityMember>,
            selectedCommunityTransactions: null == selectedCommunityTransactions
                ? _value.selectedCommunityTransactions
                : selectedCommunityTransactions // ignore: cast_nullable_to_non_nullable
                      as List<CommunityTransaction>,
            selectedCommunityApprovals: null == selectedCommunityApprovals
                ? _value.selectedCommunityApprovals
                : selectedCommunityApprovals // ignore: cast_nullable_to_non_nullable
                      as List<CommunityApproval>,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreTransactions: null == hasMoreTransactions
                ? _value.hasMoreTransactions
                : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
                      as bool,
            stokvelAnalytics: freezed == stokvelAnalytics
                ? _value.stokvelAnalytics
                : stokvelAnalytics // ignore: cast_nullable_to_non_nullable
                      as StokvelAnalytics?,
            isLoadingAnalytics: null == isLoadingAnalytics
                ? _value.isLoadingAnalytics
                : isLoadingAnalytics // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalUnreadCount: null == totalUnreadCount
                ? _value.totalUnreadCount
                : totalUnreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommunityCopyWith<$Res>? get selectedCommunity {
    if (_value.selectedCommunity == null) {
      return null;
    }

    return $CommunityCopyWith<$Res>(_value.selectedCommunity!, (value) {
      return _then(_value.copyWith(selectedCommunity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommunityStateImplCopyWith<$Res>
    implements $CommunityStateCopyWith<$Res> {
  factory _$$CommunityStateImplCopyWith(
    _$CommunityStateImpl value,
    $Res Function(_$CommunityStateImpl) then,
  ) = __$$CommunityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CommunityLoadingStatus status,
    CommunityOperationStatus operationStatus,
    List<Community> communities,
    List<CommunityMember> pendingInvitations,
    Community? selectedCommunity,
    List<CommunityMember> selectedCommunityMembers,
    List<CommunityTransaction> selectedCommunityTransactions,
    List<CommunityApproval> selectedCommunityApprovals,
    bool isLoadingMore,
    bool hasMoreTransactions,
    StokvelAnalytics? stokvelAnalytics,
    bool isLoadingAnalytics,
    int totalUnreadCount,
    String? errorMessage,
    String? successMessage,
  });

  @override
  $CommunityCopyWith<$Res>? get selectedCommunity;
}

/// @nodoc
class __$$CommunityStateImplCopyWithImpl<$Res>
    extends _$CommunityStateCopyWithImpl<$Res, _$CommunityStateImpl>
    implements _$$CommunityStateImplCopyWith<$Res> {
  __$$CommunityStateImplCopyWithImpl(
    _$CommunityStateImpl _value,
    $Res Function(_$CommunityStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? operationStatus = null,
    Object? communities = null,
    Object? pendingInvitations = null,
    Object? selectedCommunity = freezed,
    Object? selectedCommunityMembers = null,
    Object? selectedCommunityTransactions = null,
    Object? selectedCommunityApprovals = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? stokvelAnalytics = freezed,
    Object? isLoadingAnalytics = null,
    Object? totalUnreadCount = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$CommunityStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CommunityLoadingStatus,
        operationStatus: null == operationStatus
            ? _value.operationStatus
            : operationStatus // ignore: cast_nullable_to_non_nullable
                  as CommunityOperationStatus,
        communities: null == communities
            ? _value._communities
            : communities // ignore: cast_nullable_to_non_nullable
                  as List<Community>,
        pendingInvitations: null == pendingInvitations
            ? _value._pendingInvitations
            : pendingInvitations // ignore: cast_nullable_to_non_nullable
                  as List<CommunityMember>,
        selectedCommunity: freezed == selectedCommunity
            ? _value.selectedCommunity
            : selectedCommunity // ignore: cast_nullable_to_non_nullable
                  as Community?,
        selectedCommunityMembers: null == selectedCommunityMembers
            ? _value._selectedCommunityMembers
            : selectedCommunityMembers // ignore: cast_nullable_to_non_nullable
                  as List<CommunityMember>,
        selectedCommunityTransactions: null == selectedCommunityTransactions
            ? _value._selectedCommunityTransactions
            : selectedCommunityTransactions // ignore: cast_nullable_to_non_nullable
                  as List<CommunityTransaction>,
        selectedCommunityApprovals: null == selectedCommunityApprovals
            ? _value._selectedCommunityApprovals
            : selectedCommunityApprovals // ignore: cast_nullable_to_non_nullable
                  as List<CommunityApproval>,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreTransactions: null == hasMoreTransactions
            ? _value.hasMoreTransactions
            : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
                  as bool,
        stokvelAnalytics: freezed == stokvelAnalytics
            ? _value.stokvelAnalytics
            : stokvelAnalytics // ignore: cast_nullable_to_non_nullable
                  as StokvelAnalytics?,
        isLoadingAnalytics: null == isLoadingAnalytics
            ? _value.isLoadingAnalytics
            : isLoadingAnalytics // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalUnreadCount: null == totalUnreadCount
            ? _value.totalUnreadCount
            : totalUnreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CommunityStateImpl extends _CommunityState {
  const _$CommunityStateImpl({
    this.status = CommunityLoadingStatus.initial,
    this.operationStatus = CommunityOperationStatus.idle,
    final List<Community> communities = const [],
    final List<CommunityMember> pendingInvitations = const [],
    this.selectedCommunity,
    final List<CommunityMember> selectedCommunityMembers = const [],
    final List<CommunityTransaction> selectedCommunityTransactions = const [],
    final List<CommunityApproval> selectedCommunityApprovals = const [],
    this.isLoadingMore = false,
    this.hasMoreTransactions = false,
    this.stokvelAnalytics,
    this.isLoadingAnalytics = false,
    this.totalUnreadCount = 0,
    this.errorMessage,
    this.successMessage,
  }) : _communities = communities,
       _pendingInvitations = pendingInvitations,
       _selectedCommunityMembers = selectedCommunityMembers,
       _selectedCommunityTransactions = selectedCommunityTransactions,
       _selectedCommunityApprovals = selectedCommunityApprovals,
       super._();

  // Status
  @override
  @JsonKey()
  final CommunityLoadingStatus status;
  @override
  @JsonKey()
  final CommunityOperationStatus operationStatus;
  // Communities list
  final List<Community> _communities;
  // Communities list
  @override
  @JsonKey()
  List<Community> get communities {
    if (_communities is EqualUnmodifiableListView) return _communities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_communities);
  }

  final List<CommunityMember> _pendingInvitations;
  @override
  @JsonKey()
  List<CommunityMember> get pendingInvitations {
    if (_pendingInvitations is EqualUnmodifiableListView)
      return _pendingInvitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingInvitations);
  }

  // Selected community details
  @override
  final Community? selectedCommunity;
  final List<CommunityMember> _selectedCommunityMembers;
  @override
  @JsonKey()
  List<CommunityMember> get selectedCommunityMembers {
    if (_selectedCommunityMembers is EqualUnmodifiableListView)
      return _selectedCommunityMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedCommunityMembers);
  }

  final List<CommunityTransaction> _selectedCommunityTransactions;
  @override
  @JsonKey()
  List<CommunityTransaction> get selectedCommunityTransactions {
    if (_selectedCommunityTransactions is EqualUnmodifiableListView)
      return _selectedCommunityTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedCommunityTransactions);
  }

  final List<CommunityApproval> _selectedCommunityApprovals;
  @override
  @JsonKey()
  List<CommunityApproval> get selectedCommunityApprovals {
    if (_selectedCommunityApprovals is EqualUnmodifiableListView)
      return _selectedCommunityApprovals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedCommunityApprovals);
  }

  // Loading states
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMoreTransactions;
  // Stokvel analytics
  @override
  final StokvelAnalytics? stokvelAnalytics;
  @override
  @JsonKey()
  final bool isLoadingAnalytics;
  // Unread
  @override
  @JsonKey()
  final int totalUnreadCount;
  // Error handling
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'CommunityState(status: $status, operationStatus: $operationStatus, communities: $communities, pendingInvitations: $pendingInvitations, selectedCommunity: $selectedCommunity, selectedCommunityMembers: $selectedCommunityMembers, selectedCommunityTransactions: $selectedCommunityTransactions, selectedCommunityApprovals: $selectedCommunityApprovals, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, stokvelAnalytics: $stokvelAnalytics, isLoadingAnalytics: $isLoadingAnalytics, totalUnreadCount: $totalUnreadCount, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.operationStatus, operationStatus) ||
                other.operationStatus == operationStatus) &&
            const DeepCollectionEquality().equals(
              other._communities,
              _communities,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingInvitations,
              _pendingInvitations,
            ) &&
            (identical(other.selectedCommunity, selectedCommunity) ||
                other.selectedCommunity == selectedCommunity) &&
            const DeepCollectionEquality().equals(
              other._selectedCommunityMembers,
              _selectedCommunityMembers,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedCommunityTransactions,
              _selectedCommunityTransactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedCommunityApprovals,
              _selectedCommunityApprovals,
            ) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMoreTransactions, hasMoreTransactions) ||
                other.hasMoreTransactions == hasMoreTransactions) &&
            (identical(other.stokvelAnalytics, stokvelAnalytics) ||
                other.stokvelAnalytics == stokvelAnalytics) &&
            (identical(other.isLoadingAnalytics, isLoadingAnalytics) ||
                other.isLoadingAnalytics == isLoadingAnalytics) &&
            (identical(other.totalUnreadCount, totalUnreadCount) ||
                other.totalUnreadCount == totalUnreadCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    operationStatus,
    const DeepCollectionEquality().hash(_communities),
    const DeepCollectionEquality().hash(_pendingInvitations),
    selectedCommunity,
    const DeepCollectionEquality().hash(_selectedCommunityMembers),
    const DeepCollectionEquality().hash(_selectedCommunityTransactions),
    const DeepCollectionEquality().hash(_selectedCommunityApprovals),
    isLoadingMore,
    hasMoreTransactions,
    stokvelAnalytics,
    isLoadingAnalytics,
    totalUnreadCount,
    errorMessage,
    successMessage,
  );

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityStateImplCopyWith<_$CommunityStateImpl> get copyWith =>
      __$$CommunityStateImplCopyWithImpl<_$CommunityStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CommunityState extends CommunityState {
  const factory _CommunityState({
    final CommunityLoadingStatus status,
    final CommunityOperationStatus operationStatus,
    final List<Community> communities,
    final List<CommunityMember> pendingInvitations,
    final Community? selectedCommunity,
    final List<CommunityMember> selectedCommunityMembers,
    final List<CommunityTransaction> selectedCommunityTransactions,
    final List<CommunityApproval> selectedCommunityApprovals,
    final bool isLoadingMore,
    final bool hasMoreTransactions,
    final StokvelAnalytics? stokvelAnalytics,
    final bool isLoadingAnalytics,
    final int totalUnreadCount,
    final String? errorMessage,
    final String? successMessage,
  }) = _$CommunityStateImpl;
  const _CommunityState._() : super._();

  // Status
  @override
  CommunityLoadingStatus get status;
  @override
  CommunityOperationStatus get operationStatus; // Communities list
  @override
  List<Community> get communities;
  @override
  List<CommunityMember> get pendingInvitations; // Selected community details
  @override
  Community? get selectedCommunity;
  @override
  List<CommunityMember> get selectedCommunityMembers;
  @override
  List<CommunityTransaction> get selectedCommunityTransactions;
  @override
  List<CommunityApproval> get selectedCommunityApprovals; // Loading states
  @override
  bool get isLoadingMore;
  @override
  bool get hasMoreTransactions; // Stokvel analytics
  @override
  StokvelAnalytics? get stokvelAnalytics;
  @override
  bool get isLoadingAnalytics; // Unread
  @override
  int get totalUnreadCount; // Error handling
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of CommunityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityStateImplCopyWith<_$CommunityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
