// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GroupEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupEventCopyWith<$Res> {
  factory $GroupEventCopyWith(
    GroupEvent value,
    $Res Function(GroupEvent) then,
  ) = _$GroupEventCopyWithImpl<$Res, GroupEvent>;
}

/// @nodoc
class _$GroupEventCopyWithImpl<$Res, $Val extends GroupEvent>
    implements $GroupEventCopyWith<$Res> {
  _$GroupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadUserGroupsImplCopyWith<$Res> {
  factory _$$LoadUserGroupsImplCopyWith(
    _$LoadUserGroupsImpl value,
    $Res Function(_$LoadUserGroupsImpl) then,
  ) = __$$LoadUserGroupsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadUserGroupsImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$LoadUserGroupsImpl>
    implements _$$LoadUserGroupsImplCopyWith<$Res> {
  __$$LoadUserGroupsImplCopyWithImpl(
    _$LoadUserGroupsImpl _value,
    $Res Function(_$LoadUserGroupsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadUserGroupsImpl implements _LoadUserGroups {
  const _$LoadUserGroupsImpl();

  @override
  String toString() {
    return 'GroupEvent.loadUserGroups()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadUserGroupsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return loadUserGroups();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return loadUserGroups?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadUserGroups != null) {
      return loadUserGroups();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadUserGroups(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadUserGroups?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadUserGroups != null) {
      return loadUserGroups(this);
    }
    return orElse();
  }
}

abstract class _LoadUserGroups implements GroupEvent {
  const factory _LoadUserGroups() = _$LoadUserGroupsImpl;
}

/// @nodoc
abstract class _$$WatchUserGroupsImplCopyWith<$Res> {
  factory _$$WatchUserGroupsImplCopyWith(
    _$WatchUserGroupsImpl value,
    $Res Function(_$WatchUserGroupsImpl) then,
  ) = __$$WatchUserGroupsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchUserGroupsImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$WatchUserGroupsImpl>
    implements _$$WatchUserGroupsImplCopyWith<$Res> {
  __$$WatchUserGroupsImplCopyWithImpl(
    _$WatchUserGroupsImpl _value,
    $Res Function(_$WatchUserGroupsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchUserGroupsImpl implements _WatchUserGroups {
  const _$WatchUserGroupsImpl();

  @override
  String toString() {
    return 'GroupEvent.watchUserGroups()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchUserGroupsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return watchUserGroups();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return watchUserGroups?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchUserGroups != null) {
      return watchUserGroups();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchUserGroups(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchUserGroups?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchUserGroups != null) {
      return watchUserGroups(this);
    }
    return orElse();
  }
}

abstract class _WatchUserGroups implements GroupEvent {
  const factory _WatchUserGroups() = _$WatchUserGroupsImpl;
}

/// @nodoc
abstract class _$$UserGroupsUpdatedImplCopyWith<$Res> {
  factory _$$UserGroupsUpdatedImplCopyWith(
    _$UserGroupsUpdatedImpl value,
    $Res Function(_$UserGroupsUpdatedImpl) then,
  ) = __$$UserGroupsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Group> groups});
}

/// @nodoc
class __$$UserGroupsUpdatedImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$UserGroupsUpdatedImpl>
    implements _$$UserGroupsUpdatedImplCopyWith<$Res> {
  __$$UserGroupsUpdatedImplCopyWithImpl(
    _$UserGroupsUpdatedImpl _value,
    $Res Function(_$UserGroupsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groups = null}) {
    return _then(
      _$UserGroupsUpdatedImpl(
        null == groups
            ? _value._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<Group>,
      ),
    );
  }
}

/// @nodoc

class _$UserGroupsUpdatedImpl implements _UserGroupsUpdated {
  const _$UserGroupsUpdatedImpl(final List<Group> groups) : _groups = groups;

  final List<Group> _groups;
  @override
  List<Group> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  String toString() {
    return 'GroupEvent.userGroupsUpdated(groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserGroupsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_groups));

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserGroupsUpdatedImplCopyWith<_$UserGroupsUpdatedImpl> get copyWith =>
      __$$UserGroupsUpdatedImplCopyWithImpl<_$UserGroupsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return userGroupsUpdated(groups);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return userGroupsUpdated?.call(groups);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (userGroupsUpdated != null) {
      return userGroupsUpdated(groups);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return userGroupsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return userGroupsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (userGroupsUpdated != null) {
      return userGroupsUpdated(this);
    }
    return orElse();
  }
}

abstract class _UserGroupsUpdated implements GroupEvent {
  const factory _UserGroupsUpdated(final List<Group> groups) =
      _$UserGroupsUpdatedImpl;

  List<Group> get groups;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserGroupsUpdatedImplCopyWith<_$UserGroupsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadGroupDetailsImplCopyWith<$Res> {
  factory _$$LoadGroupDetailsImplCopyWith(
    _$LoadGroupDetailsImpl value,
    $Res Function(_$LoadGroupDetailsImpl) then,
  ) = __$$LoadGroupDetailsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId});
}

/// @nodoc
class __$$LoadGroupDetailsImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$LoadGroupDetailsImpl>
    implements _$$LoadGroupDetailsImplCopyWith<$Res> {
  __$$LoadGroupDetailsImplCopyWithImpl(
    _$LoadGroupDetailsImpl _value,
    $Res Function(_$LoadGroupDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null}) {
    return _then(
      _$LoadGroupDetailsImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadGroupDetailsImpl implements _LoadGroupDetails {
  const _$LoadGroupDetailsImpl({required this.groupId});

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEvent.loadGroupDetails(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadGroupDetailsImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadGroupDetailsImplCopyWith<_$LoadGroupDetailsImpl> get copyWith =>
      __$$LoadGroupDetailsImplCopyWithImpl<_$LoadGroupDetailsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return loadGroupDetails(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return loadGroupDetails?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadGroupDetails != null) {
      return loadGroupDetails(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadGroupDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadGroupDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadGroupDetails != null) {
      return loadGroupDetails(this);
    }
    return orElse();
  }
}

abstract class _LoadGroupDetails implements GroupEvent {
  const factory _LoadGroupDetails({required final String groupId}) =
      _$LoadGroupDetailsImpl;

  String get groupId;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadGroupDetailsImplCopyWith<_$LoadGroupDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchGroupMembersImplCopyWith<$Res> {
  factory _$$WatchGroupMembersImplCopyWith(
    _$WatchGroupMembersImpl value,
    $Res Function(_$WatchGroupMembersImpl) then,
  ) = __$$WatchGroupMembersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId});
}

/// @nodoc
class __$$WatchGroupMembersImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$WatchGroupMembersImpl>
    implements _$$WatchGroupMembersImplCopyWith<$Res> {
  __$$WatchGroupMembersImplCopyWithImpl(
    _$WatchGroupMembersImpl _value,
    $Res Function(_$WatchGroupMembersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null}) {
    return _then(
      _$WatchGroupMembersImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchGroupMembersImpl implements _WatchGroupMembers {
  const _$WatchGroupMembersImpl({required this.groupId});

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEvent.watchGroupMembers(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchGroupMembersImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchGroupMembersImplCopyWith<_$WatchGroupMembersImpl> get copyWith =>
      __$$WatchGroupMembersImplCopyWithImpl<_$WatchGroupMembersImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return watchGroupMembers(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return watchGroupMembers?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchGroupMembers != null) {
      return watchGroupMembers(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchGroupMembers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchGroupMembers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchGroupMembers != null) {
      return watchGroupMembers(this);
    }
    return orElse();
  }
}

abstract class _WatchGroupMembers implements GroupEvent {
  const factory _WatchGroupMembers({required final String groupId}) =
      _$WatchGroupMembersImpl;

  String get groupId;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchGroupMembersImplCopyWith<_$WatchGroupMembersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupMembersUpdatedImplCopyWith<$Res> {
  factory _$$GroupMembersUpdatedImplCopyWith(
    _$GroupMembersUpdatedImpl value,
    $Res Function(_$GroupMembersUpdatedImpl) then,
  ) = __$$GroupMembersUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GroupMember> members});
}

/// @nodoc
class __$$GroupMembersUpdatedImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$GroupMembersUpdatedImpl>
    implements _$$GroupMembersUpdatedImplCopyWith<$Res> {
  __$$GroupMembersUpdatedImplCopyWithImpl(
    _$GroupMembersUpdatedImpl _value,
    $Res Function(_$GroupMembersUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? members = null}) {
    return _then(
      _$GroupMembersUpdatedImpl(
        null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<GroupMember>,
      ),
    );
  }
}

/// @nodoc

class _$GroupMembersUpdatedImpl implements _GroupMembersUpdated {
  const _$GroupMembersUpdatedImpl(final List<GroupMember> members)
    : _members = members;

  final List<GroupMember> _members;
  @override
  List<GroupMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'GroupEvent.groupMembersUpdated(members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupMembersUpdatedImpl &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_members));

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupMembersUpdatedImplCopyWith<_$GroupMembersUpdatedImpl> get copyWith =>
      __$$GroupMembersUpdatedImplCopyWithImpl<_$GroupMembersUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return groupMembersUpdated(members);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return groupMembersUpdated?.call(members);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (groupMembersUpdated != null) {
      return groupMembersUpdated(members);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return groupMembersUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return groupMembersUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (groupMembersUpdated != null) {
      return groupMembersUpdated(this);
    }
    return orElse();
  }
}

abstract class _GroupMembersUpdated implements GroupEvent {
  const factory _GroupMembersUpdated(final List<GroupMember> members) =
      _$GroupMembersUpdatedImpl;

  List<GroupMember> get members;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupMembersUpdatedImplCopyWith<_$GroupMembersUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchGroupTransactionsImplCopyWith<$Res> {
  factory _$$WatchGroupTransactionsImplCopyWith(
    _$WatchGroupTransactionsImpl value,
    $Res Function(_$WatchGroupTransactionsImpl) then,
  ) = __$$WatchGroupTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, int? limit});
}

/// @nodoc
class __$$WatchGroupTransactionsImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$WatchGroupTransactionsImpl>
    implements _$$WatchGroupTransactionsImplCopyWith<$Res> {
  __$$WatchGroupTransactionsImplCopyWithImpl(
    _$WatchGroupTransactionsImpl _value,
    $Res Function(_$WatchGroupTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null, Object? limit = freezed}) {
    return _then(
      _$WatchGroupTransactionsImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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

class _$WatchGroupTransactionsImpl implements _WatchGroupTransactions {
  const _$WatchGroupTransactionsImpl({required this.groupId, this.limit});

  @override
  final String groupId;
  @override
  final int? limit;

  @override
  String toString() {
    return 'GroupEvent.watchGroupTransactions(groupId: $groupId, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchGroupTransactionsImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, limit);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchGroupTransactionsImplCopyWith<_$WatchGroupTransactionsImpl>
  get copyWith =>
      __$$WatchGroupTransactionsImplCopyWithImpl<_$WatchGroupTransactionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return watchGroupTransactions(groupId, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return watchGroupTransactions?.call(groupId, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchGroupTransactions != null) {
      return watchGroupTransactions(groupId, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchGroupTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchGroupTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchGroupTransactions != null) {
      return watchGroupTransactions(this);
    }
    return orElse();
  }
}

abstract class _WatchGroupTransactions implements GroupEvent {
  const factory _WatchGroupTransactions({
    required final String groupId,
    final int? limit,
  }) = _$WatchGroupTransactionsImpl;

  String get groupId;
  int? get limit;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchGroupTransactionsImplCopyWith<_$WatchGroupTransactionsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupTransactionsUpdatedImplCopyWith<$Res> {
  factory _$$GroupTransactionsUpdatedImplCopyWith(
    _$GroupTransactionsUpdatedImpl value,
    $Res Function(_$GroupTransactionsUpdatedImpl) then,
  ) = __$$GroupTransactionsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GroupTransaction> transactions});
}

/// @nodoc
class __$$GroupTransactionsUpdatedImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$GroupTransactionsUpdatedImpl>
    implements _$$GroupTransactionsUpdatedImplCopyWith<$Res> {
  __$$GroupTransactionsUpdatedImplCopyWithImpl(
    _$GroupTransactionsUpdatedImpl _value,
    $Res Function(_$GroupTransactionsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transactions = null}) {
    return _then(
      _$GroupTransactionsUpdatedImpl(
        null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<GroupTransaction>,
      ),
    );
  }
}

/// @nodoc

class _$GroupTransactionsUpdatedImpl implements _GroupTransactionsUpdated {
  const _$GroupTransactionsUpdatedImpl(
    final List<GroupTransaction> transactions,
  ) : _transactions = transactions;

  final List<GroupTransaction> _transactions;
  @override
  List<GroupTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  String toString() {
    return 'GroupEvent.groupTransactionsUpdated(transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupTransactionsUpdatedImpl &&
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

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupTransactionsUpdatedImplCopyWith<_$GroupTransactionsUpdatedImpl>
  get copyWith =>
      __$$GroupTransactionsUpdatedImplCopyWithImpl<
        _$GroupTransactionsUpdatedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return groupTransactionsUpdated(transactions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return groupTransactionsUpdated?.call(transactions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (groupTransactionsUpdated != null) {
      return groupTransactionsUpdated(transactions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return groupTransactionsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return groupTransactionsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (groupTransactionsUpdated != null) {
      return groupTransactionsUpdated(this);
    }
    return orElse();
  }
}

abstract class _GroupTransactionsUpdated implements GroupEvent {
  const factory _GroupTransactionsUpdated(
    final List<GroupTransaction> transactions,
  ) = _$GroupTransactionsUpdatedImpl;

  List<GroupTransaction> get transactions;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupTransactionsUpdatedImplCopyWith<_$GroupTransactionsUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchPendingApprovalsImplCopyWith<$Res> {
  factory _$$WatchPendingApprovalsImplCopyWith(
    _$WatchPendingApprovalsImpl value,
    $Res Function(_$WatchPendingApprovalsImpl) then,
  ) = __$$WatchPendingApprovalsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId});
}

/// @nodoc
class __$$WatchPendingApprovalsImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$WatchPendingApprovalsImpl>
    implements _$$WatchPendingApprovalsImplCopyWith<$Res> {
  __$$WatchPendingApprovalsImplCopyWithImpl(
    _$WatchPendingApprovalsImpl _value,
    $Res Function(_$WatchPendingApprovalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null}) {
    return _then(
      _$WatchPendingApprovalsImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchPendingApprovalsImpl implements _WatchPendingApprovals {
  const _$WatchPendingApprovalsImpl({required this.groupId});

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEvent.watchPendingApprovals(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchPendingApprovalsImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  /// Create a copy of GroupEvent
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return watchPendingApprovals(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return watchPendingApprovals?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchPendingApprovals != null) {
      return watchPendingApprovals(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchPendingApprovals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchPendingApprovals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchPendingApprovals != null) {
      return watchPendingApprovals(this);
    }
    return orElse();
  }
}

abstract class _WatchPendingApprovals implements GroupEvent {
  const factory _WatchPendingApprovals({required final String groupId}) =
      _$WatchPendingApprovalsImpl;

  String get groupId;

  /// Create a copy of GroupEvent
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
  $Res call({List<PendingApproval> approvals});
}

/// @nodoc
class __$$PendingApprovalsUpdatedImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$PendingApprovalsUpdatedImpl>
    implements _$$PendingApprovalsUpdatedImplCopyWith<$Res> {
  __$$PendingApprovalsUpdatedImplCopyWithImpl(
    _$PendingApprovalsUpdatedImpl _value,
    $Res Function(_$PendingApprovalsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? approvals = null}) {
    return _then(
      _$PendingApprovalsUpdatedImpl(
        null == approvals
            ? _value._approvals
            : approvals // ignore: cast_nullable_to_non_nullable
                  as List<PendingApproval>,
      ),
    );
  }
}

/// @nodoc

class _$PendingApprovalsUpdatedImpl implements _PendingApprovalsUpdated {
  const _$PendingApprovalsUpdatedImpl(final List<PendingApproval> approvals)
    : _approvals = approvals;

  final List<PendingApproval> _approvals;
  @override
  List<PendingApproval> get approvals {
    if (_approvals is EqualUnmodifiableListView) return _approvals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_approvals);
  }

  @override
  String toString() {
    return 'GroupEvent.pendingApprovalsUpdated(approvals: $approvals)';
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

  /// Create a copy of GroupEvent
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return pendingApprovalsUpdated(approvals);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return pendingApprovalsUpdated?.call(approvals);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
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
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return pendingApprovalsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return pendingApprovalsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (pendingApprovalsUpdated != null) {
      return pendingApprovalsUpdated(this);
    }
    return orElse();
  }
}

abstract class _PendingApprovalsUpdated implements GroupEvent {
  const factory _PendingApprovalsUpdated(
    final List<PendingApproval> approvals,
  ) = _$PendingApprovalsUpdatedImpl;

  List<PendingApproval> get approvals;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingApprovalsUpdatedImplCopyWith<_$PendingApprovalsUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateGroupImplCopyWith<$Res> {
  factory _$$CreateGroupImplCopyWith(
    _$CreateGroupImpl value,
    $Res Function(_$CreateGroupImpl) then,
  ) = __$$CreateGroupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CreateGroupParams params});
}

/// @nodoc
class __$$CreateGroupImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$CreateGroupImpl>
    implements _$$CreateGroupImplCopyWith<$Res> {
  __$$CreateGroupImplCopyWithImpl(
    _$CreateGroupImpl _value,
    $Res Function(_$CreateGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? params = null}) {
    return _then(
      _$CreateGroupImpl(
        params: null == params
            ? _value.params
            : params // ignore: cast_nullable_to_non_nullable
                  as CreateGroupParams,
      ),
    );
  }
}

/// @nodoc

class _$CreateGroupImpl implements _CreateGroup {
  const _$CreateGroupImpl({required this.params});

  @override
  final CreateGroupParams params;

  @override
  String toString() {
    return 'GroupEvent.createGroup(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateGroupImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateGroupImplCopyWith<_$CreateGroupImpl> get copyWith =>
      __$$CreateGroupImplCopyWithImpl<_$CreateGroupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return createGroup(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return createGroup?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (createGroup != null) {
      return createGroup(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return createGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return createGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (createGroup != null) {
      return createGroup(this);
    }
    return orElse();
  }
}

abstract class _CreateGroup implements GroupEvent {
  const factory _CreateGroup({required final CreateGroupParams params}) =
      _$CreateGroupImpl;

  CreateGroupParams get params;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateGroupImplCopyWith<_$CreateGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateGroupImplCopyWith<$Res> {
  factory _$$UpdateGroupImplCopyWith(
    _$UpdateGroupImpl value,
    $Res Function(_$UpdateGroupImpl) then,
  ) = __$$UpdateGroupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, UpdateGroupParams params});
}

/// @nodoc
class __$$UpdateGroupImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$UpdateGroupImpl>
    implements _$$UpdateGroupImplCopyWith<$Res> {
  __$$UpdateGroupImplCopyWithImpl(
    _$UpdateGroupImpl _value,
    $Res Function(_$UpdateGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null, Object? params = null}) {
    return _then(
      _$UpdateGroupImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        params: null == params
            ? _value.params
            : params // ignore: cast_nullable_to_non_nullable
                  as UpdateGroupParams,
      ),
    );
  }
}

/// @nodoc

class _$UpdateGroupImpl implements _UpdateGroup {
  const _$UpdateGroupImpl({required this.groupId, required this.params});

  @override
  final String groupId;
  @override
  final UpdateGroupParams params;

  @override
  String toString() {
    return 'GroupEvent.updateGroup(groupId: $groupId, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateGroupImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, params);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateGroupImplCopyWith<_$UpdateGroupImpl> get copyWith =>
      __$$UpdateGroupImplCopyWithImpl<_$UpdateGroupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return updateGroup(groupId, params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return updateGroup?.call(groupId, params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (updateGroup != null) {
      return updateGroup(groupId, params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return updateGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return updateGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (updateGroup != null) {
      return updateGroup(this);
    }
    return orElse();
  }
}

abstract class _UpdateGroup implements GroupEvent {
  const factory _UpdateGroup({
    required final String groupId,
    required final UpdateGroupParams params,
  }) = _$UpdateGroupImpl;

  String get groupId;
  UpdateGroupParams get params;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateGroupImplCopyWith<_$UpdateGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteGroupImplCopyWith<$Res> {
  factory _$$DeleteGroupImplCopyWith(
    _$DeleteGroupImpl value,
    $Res Function(_$DeleteGroupImpl) then,
  ) = __$$DeleteGroupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId});
}

/// @nodoc
class __$$DeleteGroupImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$DeleteGroupImpl>
    implements _$$DeleteGroupImplCopyWith<$Res> {
  __$$DeleteGroupImplCopyWithImpl(
    _$DeleteGroupImpl _value,
    $Res Function(_$DeleteGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null}) {
    return _then(
      _$DeleteGroupImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteGroupImpl implements _DeleteGroup {
  const _$DeleteGroupImpl({required this.groupId});

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEvent.deleteGroup(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteGroupImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteGroupImplCopyWith<_$DeleteGroupImpl> get copyWith =>
      __$$DeleteGroupImplCopyWithImpl<_$DeleteGroupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return deleteGroup(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return deleteGroup?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (deleteGroup != null) {
      return deleteGroup(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return deleteGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return deleteGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (deleteGroup != null) {
      return deleteGroup(this);
    }
    return orElse();
  }
}

abstract class _DeleteGroup implements GroupEvent {
  const factory _DeleteGroup({required final String groupId}) =
      _$DeleteGroupImpl;

  String get groupId;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteGroupImplCopyWith<_$DeleteGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InviteMemberImplCopyWith<$Res> {
  factory _$$InviteMemberImplCopyWith(
    _$InviteMemberImpl value,
    $Res Function(_$InviteMemberImpl) then,
  ) = __$$InviteMemberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, String userId, GroupRole role});
}

/// @nodoc
class __$$InviteMemberImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$InviteMemberImpl>
    implements _$$InviteMemberImplCopyWith<$Res> {
  __$$InviteMemberImplCopyWithImpl(
    _$InviteMemberImpl _value,
    $Res Function(_$InviteMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
  }) {
    return _then(
      _$InviteMemberImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as GroupRole,
      ),
    );
  }
}

/// @nodoc

class _$InviteMemberImpl implements _InviteMember {
  const _$InviteMemberImpl({
    required this.groupId,
    required this.userId,
    required this.role,
  });

  @override
  final String groupId;
  @override
  final String userId;
  @override
  final GroupRole role;

  @override
  String toString() {
    return 'GroupEvent.inviteMember(groupId: $groupId, userId: $userId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InviteMemberImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, userId, role);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InviteMemberImplCopyWith<_$InviteMemberImpl> get copyWith =>
      __$$InviteMemberImplCopyWithImpl<_$InviteMemberImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return inviteMember(groupId, userId, role);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return inviteMember?.call(groupId, userId, role);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (inviteMember != null) {
      return inviteMember(groupId, userId, role);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return inviteMember(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return inviteMember?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (inviteMember != null) {
      return inviteMember(this);
    }
    return orElse();
  }
}

abstract class _InviteMember implements GroupEvent {
  const factory _InviteMember({
    required final String groupId,
    required final String userId,
    required final GroupRole role,
  }) = _$InviteMemberImpl;

  String get groupId;
  String get userId;
  GroupRole get role;

  /// Create a copy of GroupEvent
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
  $Res call({String groupId});
}

/// @nodoc
class __$$AcceptInvitationImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$AcceptInvitationImpl>
    implements _$$AcceptInvitationImplCopyWith<$Res> {
  __$$AcceptInvitationImplCopyWithImpl(
    _$AcceptInvitationImpl _value,
    $Res Function(_$AcceptInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null}) {
    return _then(
      _$AcceptInvitationImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AcceptInvitationImpl implements _AcceptInvitation {
  const _$AcceptInvitationImpl({required this.groupId});

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEvent.acceptInvitation(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptInvitationImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  /// Create a copy of GroupEvent
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return acceptInvitation(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return acceptInvitation?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (acceptInvitation != null) {
      return acceptInvitation(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return acceptInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return acceptInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (acceptInvitation != null) {
      return acceptInvitation(this);
    }
    return orElse();
  }
}

abstract class _AcceptInvitation implements GroupEvent {
  const factory _AcceptInvitation({required final String groupId}) =
      _$AcceptInvitationImpl;

  String get groupId;

  /// Create a copy of GroupEvent
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
  $Res call({String groupId});
}

/// @nodoc
class __$$DeclineInvitationImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$DeclineInvitationImpl>
    implements _$$DeclineInvitationImplCopyWith<$Res> {
  __$$DeclineInvitationImplCopyWithImpl(
    _$DeclineInvitationImpl _value,
    $Res Function(_$DeclineInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null}) {
    return _then(
      _$DeclineInvitationImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeclineInvitationImpl implements _DeclineInvitation {
  const _$DeclineInvitationImpl({required this.groupId});

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEvent.declineInvitation(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeclineInvitationImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  /// Create a copy of GroupEvent
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return declineInvitation(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return declineInvitation?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (declineInvitation != null) {
      return declineInvitation(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return declineInvitation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return declineInvitation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (declineInvitation != null) {
      return declineInvitation(this);
    }
    return orElse();
  }
}

abstract class _DeclineInvitation implements GroupEvent {
  const factory _DeclineInvitation({required final String groupId}) =
      _$DeclineInvitationImpl;

  String get groupId;

  /// Create a copy of GroupEvent
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
  $Res call({String groupId, String memberId});
}

/// @nodoc
class __$$RemoveMemberImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$RemoveMemberImpl>
    implements _$$RemoveMemberImplCopyWith<$Res> {
  __$$RemoveMemberImplCopyWithImpl(
    _$RemoveMemberImpl _value,
    $Res Function(_$RemoveMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null, Object? memberId = null}) {
    return _then(
      _$RemoveMemberImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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
  const _$RemoveMemberImpl({required this.groupId, required this.memberId});

  @override
  final String groupId;
  @override
  final String memberId;

  @override
  String toString() {
    return 'GroupEvent.removeMember(groupId: $groupId, memberId: $memberId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveMemberImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, memberId);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveMemberImplCopyWith<_$RemoveMemberImpl> get copyWith =>
      __$$RemoveMemberImplCopyWithImpl<_$RemoveMemberImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return removeMember(groupId, memberId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return removeMember?.call(groupId, memberId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (removeMember != null) {
      return removeMember(groupId, memberId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return removeMember(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return removeMember?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (removeMember != null) {
      return removeMember(this);
    }
    return orElse();
  }
}

abstract class _RemoveMember implements GroupEvent {
  const factory _RemoveMember({
    required final String groupId,
    required final String memberId,
  }) = _$RemoveMemberImpl;

  String get groupId;
  String get memberId;

  /// Create a copy of GroupEvent
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
  $Res call({String groupId, String memberId, GroupRole role});
}

/// @nodoc
class __$$UpdateMemberRoleImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$UpdateMemberRoleImpl>
    implements _$$UpdateMemberRoleImplCopyWith<$Res> {
  __$$UpdateMemberRoleImplCopyWithImpl(
    _$UpdateMemberRoleImpl _value,
    $Res Function(_$UpdateMemberRoleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? memberId = null,
    Object? role = null,
  }) {
    return _then(
      _$UpdateMemberRoleImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        memberId: null == memberId
            ? _value.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as GroupRole,
      ),
    );
  }
}

/// @nodoc

class _$UpdateMemberRoleImpl implements _UpdateMemberRole {
  const _$UpdateMemberRoleImpl({
    required this.groupId,
    required this.memberId,
    required this.role,
  });

  @override
  final String groupId;
  @override
  final String memberId;
  @override
  final GroupRole role;

  @override
  String toString() {
    return 'GroupEvent.updateMemberRole(groupId: $groupId, memberId: $memberId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMemberRoleImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.role, role) || other.role == role));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, memberId, role);

  /// Create a copy of GroupEvent
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return updateMemberRole(groupId, memberId, role);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return updateMemberRole?.call(groupId, memberId, role);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (updateMemberRole != null) {
      return updateMemberRole(groupId, memberId, role);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return updateMemberRole(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return updateMemberRole?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (updateMemberRole != null) {
      return updateMemberRole(this);
    }
    return orElse();
  }
}

abstract class _UpdateMemberRole implements GroupEvent {
  const factory _UpdateMemberRole({
    required final String groupId,
    required final String memberId,
    required final GroupRole role,
  }) = _$UpdateMemberRoleImpl;

  String get groupId;
  String get memberId;
  GroupRole get role;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMemberRoleImplCopyWith<_$UpdateMemberRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LeaveGroupImplCopyWith<$Res> {
  factory _$$LeaveGroupImplCopyWith(
    _$LeaveGroupImpl value,
    $Res Function(_$LeaveGroupImpl) then,
  ) = __$$LeaveGroupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId});
}

/// @nodoc
class __$$LeaveGroupImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$LeaveGroupImpl>
    implements _$$LeaveGroupImplCopyWith<$Res> {
  __$$LeaveGroupImplCopyWithImpl(
    _$LeaveGroupImpl _value,
    $Res Function(_$LeaveGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null}) {
    return _then(
      _$LeaveGroupImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LeaveGroupImpl implements _LeaveGroup {
  const _$LeaveGroupImpl({required this.groupId});

  @override
  final String groupId;

  @override
  String toString() {
    return 'GroupEvent.leaveGroup(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveGroupImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveGroupImplCopyWith<_$LeaveGroupImpl> get copyWith =>
      __$$LeaveGroupImplCopyWithImpl<_$LeaveGroupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return leaveGroup(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return leaveGroup?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (leaveGroup != null) {
      return leaveGroup(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return leaveGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return leaveGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (leaveGroup != null) {
      return leaveGroup(this);
    }
    return orElse();
  }
}

abstract class _LeaveGroup implements GroupEvent {
  const factory _LeaveGroup({required final String groupId}) = _$LeaveGroupImpl;

  String get groupId;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveGroupImplCopyWith<_$LeaveGroupImpl> get copyWith =>
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
    extends _$GroupEventCopyWithImpl<$Res, _$LoadPendingInvitationsImpl>
    implements _$$LoadPendingInvitationsImplCopyWith<$Res> {
  __$$LoadPendingInvitationsImplCopyWithImpl(
    _$LoadPendingInvitationsImpl _value,
    $Res Function(_$LoadPendingInvitationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadPendingInvitationsImpl implements _LoadPendingInvitations {
  const _$LoadPendingInvitationsImpl();

  @override
  String toString() {
    return 'GroupEvent.loadPendingInvitations()';
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return loadPendingInvitations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return loadPendingInvitations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
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
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadPendingInvitations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadPendingInvitations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadPendingInvitations != null) {
      return loadPendingInvitations(this);
    }
    return orElse();
  }
}

abstract class _LoadPendingInvitations implements GroupEvent {
  const factory _LoadPendingInvitations() = _$LoadPendingInvitationsImpl;
}

/// @nodoc
abstract class _$$ContributeToGroupImplCopyWith<$Res> {
  factory _$$ContributeToGroupImplCopyWith(
    _$ContributeToGroupImpl value,
    $Res Function(_$ContributeToGroupImpl) then,
  ) = __$$ContributeToGroupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, int amount, String? description});
}

/// @nodoc
class __$$ContributeToGroupImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$ContributeToGroupImpl>
    implements _$$ContributeToGroupImplCopyWith<$Res> {
  __$$ContributeToGroupImplCopyWithImpl(
    _$ContributeToGroupImpl _value,
    $Res Function(_$ContributeToGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? amount = null,
    Object? description = freezed,
  }) {
    return _then(
      _$ContributeToGroupImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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

class _$ContributeToGroupImpl implements _ContributeToGroup {
  const _$ContributeToGroupImpl({
    required this.groupId,
    required this.amount,
    this.description,
  });

  @override
  final String groupId;
  @override
  final int amount;
  @override
  final String? description;

  @override
  String toString() {
    return 'GroupEvent.contributeToGroup(groupId: $groupId, amount: $amount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributeToGroupImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, amount, description);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributeToGroupImplCopyWith<_$ContributeToGroupImpl> get copyWith =>
      __$$ContributeToGroupImplCopyWithImpl<_$ContributeToGroupImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return contributeToGroup(groupId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return contributeToGroup?.call(groupId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (contributeToGroup != null) {
      return contributeToGroup(groupId, amount, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return contributeToGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return contributeToGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (contributeToGroup != null) {
      return contributeToGroup(this);
    }
    return orElse();
  }
}

abstract class _ContributeToGroup implements GroupEvent {
  const factory _ContributeToGroup({
    required final String groupId,
    required final int amount,
    final String? description,
  }) = _$ContributeToGroupImpl;

  String get groupId;
  int get amount;
  String? get description;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContributeToGroupImplCopyWith<_$ContributeToGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WithdrawFromGroupImplCopyWith<$Res> {
  factory _$$WithdrawFromGroupImplCopyWith(
    _$WithdrawFromGroupImpl value,
    $Res Function(_$WithdrawFromGroupImpl) then,
  ) = __$$WithdrawFromGroupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, int amount, String? description});
}

/// @nodoc
class __$$WithdrawFromGroupImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$WithdrawFromGroupImpl>
    implements _$$WithdrawFromGroupImplCopyWith<$Res> {
  __$$WithdrawFromGroupImplCopyWithImpl(
    _$WithdrawFromGroupImpl _value,
    $Res Function(_$WithdrawFromGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? amount = null,
    Object? description = freezed,
  }) {
    return _then(
      _$WithdrawFromGroupImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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

class _$WithdrawFromGroupImpl implements _WithdrawFromGroup {
  const _$WithdrawFromGroupImpl({
    required this.groupId,
    required this.amount,
    this.description,
  });

  @override
  final String groupId;
  @override
  final int amount;
  @override
  final String? description;

  @override
  String toString() {
    return 'GroupEvent.withdrawFromGroup(groupId: $groupId, amount: $amount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawFromGroupImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, amount, description);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawFromGroupImplCopyWith<_$WithdrawFromGroupImpl> get copyWith =>
      __$$WithdrawFromGroupImplCopyWithImpl<_$WithdrawFromGroupImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return withdrawFromGroup(groupId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return withdrawFromGroup?.call(groupId, amount, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (withdrawFromGroup != null) {
      return withdrawFromGroup(groupId, amount, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return withdrawFromGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return withdrawFromGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (withdrawFromGroup != null) {
      return withdrawFromGroup(this);
    }
    return orElse();
  }
}

abstract class _WithdrawFromGroup implements GroupEvent {
  const factory _WithdrawFromGroup({
    required final String groupId,
    required final int amount,
    final String? description,
  }) = _$WithdrawFromGroupImpl;

  String get groupId;
  int get amount;
  String? get description;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawFromGroupImplCopyWith<_$WithdrawFromGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApproveTransactionImplCopyWith<$Res> {
  factory _$$ApproveTransactionImplCopyWith(
    _$ApproveTransactionImpl value,
    $Res Function(_$ApproveTransactionImpl) then,
  ) = __$$ApproveTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, String transactionId});
}

/// @nodoc
class __$$ApproveTransactionImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$ApproveTransactionImpl>
    implements _$$ApproveTransactionImplCopyWith<$Res> {
  __$$ApproveTransactionImplCopyWithImpl(
    _$ApproveTransactionImpl _value,
    $Res Function(_$ApproveTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null, Object? transactionId = null}) {
    return _then(
      _$ApproveTransactionImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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
    required this.groupId,
    required this.transactionId,
  });

  @override
  final String groupId;
  @override
  final String transactionId;

  @override
  String toString() {
    return 'GroupEvent.approveTransaction(groupId: $groupId, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApproveTransactionImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, transactionId);

  /// Create a copy of GroupEvent
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return approveTransaction(groupId, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return approveTransaction?.call(groupId, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (approveTransaction != null) {
      return approveTransaction(groupId, transactionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return approveTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return approveTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (approveTransaction != null) {
      return approveTransaction(this);
    }
    return orElse();
  }
}

abstract class _ApproveTransaction implements GroupEvent {
  const factory _ApproveTransaction({
    required final String groupId,
    required final String transactionId,
  }) = _$ApproveTransactionImpl;

  String get groupId;
  String get transactionId;

  /// Create a copy of GroupEvent
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
  $Res call({String groupId, String transactionId, String? reason});
}

/// @nodoc
class __$$RejectTransactionImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$RejectTransactionImpl>
    implements _$$RejectTransactionImplCopyWith<$Res> {
  __$$RejectTransactionImplCopyWithImpl(
    _$RejectTransactionImpl _value,
    $Res Function(_$RejectTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? transactionId = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$RejectTransactionImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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
    required this.groupId,
    required this.transactionId,
    this.reason,
  });

  @override
  final String groupId;
  @override
  final String transactionId;
  @override
  final String? reason;

  @override
  String toString() {
    return 'GroupEvent.rejectTransaction(groupId: $groupId, transactionId: $transactionId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RejectTransactionImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, transactionId, reason);

  /// Create a copy of GroupEvent
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return rejectTransaction(groupId, transactionId, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return rejectTransaction?.call(groupId, transactionId, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (rejectTransaction != null) {
      return rejectTransaction(groupId, transactionId, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return rejectTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return rejectTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (rejectTransaction != null) {
      return rejectTransaction(this);
    }
    return orElse();
  }
}

abstract class _RejectTransaction implements GroupEvent {
  const factory _RejectTransaction({
    required final String groupId,
    required final String transactionId,
    final String? reason,
  }) = _$RejectTransactionImpl;

  String get groupId;
  String get transactionId;
  String? get reason;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RejectTransactionImplCopyWith<_$RejectTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TriggerStokvelPayoutImplCopyWith<$Res> {
  factory _$$TriggerStokvelPayoutImplCopyWith(
    _$TriggerStokvelPayoutImpl value,
    $Res Function(_$TriggerStokvelPayoutImpl) then,
  ) = __$$TriggerStokvelPayoutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, String? recipientId});
}

/// @nodoc
class __$$TriggerStokvelPayoutImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$TriggerStokvelPayoutImpl>
    implements _$$TriggerStokvelPayoutImplCopyWith<$Res> {
  __$$TriggerStokvelPayoutImplCopyWithImpl(
    _$TriggerStokvelPayoutImpl _value,
    $Res Function(_$TriggerStokvelPayoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null, Object? recipientId = freezed}) {
    return _then(
      _$TriggerStokvelPayoutImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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

class _$TriggerStokvelPayoutImpl implements _TriggerStokvelPayout {
  const _$TriggerStokvelPayoutImpl({required this.groupId, this.recipientId});

  @override
  final String groupId;
  @override
  final String? recipientId;

  @override
  String toString() {
    return 'GroupEvent.triggerStokvelPayout(groupId: $groupId, recipientId: $recipientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriggerStokvelPayoutImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, recipientId);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriggerStokvelPayoutImplCopyWith<_$TriggerStokvelPayoutImpl>
  get copyWith =>
      __$$TriggerStokvelPayoutImplCopyWithImpl<_$TriggerStokvelPayoutImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return triggerStokvelPayout(groupId, recipientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return triggerStokvelPayout?.call(groupId, recipientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (triggerStokvelPayout != null) {
      return triggerStokvelPayout(groupId, recipientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return triggerStokvelPayout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return triggerStokvelPayout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (triggerStokvelPayout != null) {
      return triggerStokvelPayout(this);
    }
    return orElse();
  }
}

abstract class _TriggerStokvelPayout implements GroupEvent {
  const factory _TriggerStokvelPayout({
    required final String groupId,
    final String? recipientId,
  }) = _$TriggerStokvelPayoutImpl;

  String get groupId;
  String? get recipientId;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriggerStokvelPayoutImplCopyWith<_$TriggerStokvelPayoutImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadStokvelAnalyticsImplCopyWith<$Res> {
  factory _$$LoadStokvelAnalyticsImplCopyWith(
    _$LoadStokvelAnalyticsImpl value,
    $Res Function(_$LoadStokvelAnalyticsImpl) then,
  ) = __$$LoadStokvelAnalyticsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupId, int? months});
}

/// @nodoc
class __$$LoadStokvelAnalyticsImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$LoadStokvelAnalyticsImpl>
    implements _$$LoadStokvelAnalyticsImplCopyWith<$Res> {
  __$$LoadStokvelAnalyticsImplCopyWithImpl(
    _$LoadStokvelAnalyticsImpl _value,
    $Res Function(_$LoadStokvelAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? groupId = null, Object? months = freezed}) {
    return _then(
      _$LoadStokvelAnalyticsImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
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

class _$LoadStokvelAnalyticsImpl implements _LoadStokvelAnalytics {
  const _$LoadStokvelAnalyticsImpl({required this.groupId, this.months});

  @override
  final String groupId;
  @override
  final int? months;

  @override
  String toString() {
    return 'GroupEvent.loadStokvelAnalytics(groupId: $groupId, months: $months)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadStokvelAnalyticsImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.months, months) || other.months == months));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, months);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadStokvelAnalyticsImplCopyWith<_$LoadStokvelAnalyticsImpl>
  get copyWith =>
      __$$LoadStokvelAnalyticsImplCopyWithImpl<_$LoadStokvelAnalyticsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return loadStokvelAnalytics(groupId, months);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return loadStokvelAnalytics?.call(groupId, months);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadStokvelAnalytics != null) {
      return loadStokvelAnalytics(groupId, months);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadStokvelAnalytics(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadStokvelAnalytics?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadStokvelAnalytics != null) {
      return loadStokvelAnalytics(this);
    }
    return orElse();
  }
}

abstract class _LoadStokvelAnalytics implements GroupEvent {
  const factory _LoadStokvelAnalytics({
    required final String groupId,
    final int? months,
  }) = _$LoadStokvelAnalyticsImpl;

  String get groupId;
  int? get months;

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadStokvelAnalyticsImplCopyWith<_$LoadStokvelAnalyticsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSelectedGroupImplCopyWith<$Res> {
  factory _$$ClearSelectedGroupImplCopyWith(
    _$ClearSelectedGroupImpl value,
    $Res Function(_$ClearSelectedGroupImpl) then,
  ) = __$$ClearSelectedGroupImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSelectedGroupImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$ClearSelectedGroupImpl>
    implements _$$ClearSelectedGroupImplCopyWith<$Res> {
  __$$ClearSelectedGroupImplCopyWithImpl(
    _$ClearSelectedGroupImpl _value,
    $Res Function(_$ClearSelectedGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSelectedGroupImpl implements _ClearSelectedGroup {
  const _$ClearSelectedGroupImpl();

  @override
  String toString() {
    return 'GroupEvent.clearSelectedGroup()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSelectedGroupImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return clearSelectedGroup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return clearSelectedGroup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearSelectedGroup != null) {
      return clearSelectedGroup();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearSelectedGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearSelectedGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearSelectedGroup != null) {
      return clearSelectedGroup(this);
    }
    return orElse();
  }
}

abstract class _ClearSelectedGroup implements GroupEvent {
  const factory _ClearSelectedGroup() = _$ClearSelectedGroupImpl;
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
    extends _$GroupEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'GroupEvent.clearError()';
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
    required TResult Function() loadUserGroups,
    required TResult Function() watchUserGroups,
    required TResult Function(List<Group> groups) userGroupsUpdated,
    required TResult Function(String groupId) loadGroupDetails,
    required TResult Function(String groupId) watchGroupMembers,
    required TResult Function(List<GroupMember> members) groupMembersUpdated,
    required TResult Function(String groupId, int? limit)
    watchGroupTransactions,
    required TResult Function(List<GroupTransaction> transactions)
    groupTransactionsUpdated,
    required TResult Function(String groupId) watchPendingApprovals,
    required TResult Function(List<PendingApproval> approvals)
    pendingApprovalsUpdated,
    required TResult Function(CreateGroupParams params) createGroup,
    required TResult Function(String groupId, UpdateGroupParams params)
    updateGroup,
    required TResult Function(String groupId) deleteGroup,
    required TResult Function(String groupId, String userId, GroupRole role)
    inviteMember,
    required TResult Function(String groupId) acceptInvitation,
    required TResult Function(String groupId) declineInvitation,
    required TResult Function(String groupId, String memberId) removeMember,
    required TResult Function(String groupId, String memberId, GroupRole role)
    updateMemberRole,
    required TResult Function(String groupId) leaveGroup,
    required TResult Function() loadPendingInvitations,
    required TResult Function(String groupId, int amount, String? description)
    contributeToGroup,
    required TResult Function(String groupId, int amount, String? description)
    withdrawFromGroup,
    required TResult Function(String groupId, String transactionId)
    approveTransaction,
    required TResult Function(
      String groupId,
      String transactionId,
      String? reason,
    )
    rejectTransaction,
    required TResult Function(String groupId, String? recipientId)
    triggerStokvelPayout,
    required TResult Function(String groupId, int? months) loadStokvelAnalytics,
    required TResult Function() clearSelectedGroup,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadUserGroups,
    TResult? Function()? watchUserGroups,
    TResult? Function(List<Group> groups)? userGroupsUpdated,
    TResult? Function(String groupId)? loadGroupDetails,
    TResult? Function(String groupId)? watchGroupMembers,
    TResult? Function(List<GroupMember> members)? groupMembersUpdated,
    TResult? Function(String groupId, int? limit)? watchGroupTransactions,
    TResult? Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult? Function(String groupId)? watchPendingApprovals,
    TResult? Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult? Function(CreateGroupParams params)? createGroup,
    TResult? Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult? Function(String groupId)? deleteGroup,
    TResult? Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult? Function(String groupId)? acceptInvitation,
    TResult? Function(String groupId)? declineInvitation,
    TResult? Function(String groupId, String memberId)? removeMember,
    TResult? Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult? Function(String groupId)? leaveGroup,
    TResult? Function()? loadPendingInvitations,
    TResult? Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult? Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult? Function(String groupId, String transactionId)? approveTransaction,
    TResult? Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult? Function(String groupId, String? recipientId)?
    triggerStokvelPayout,
    TResult? Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult? Function()? clearSelectedGroup,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadUserGroups,
    TResult Function()? watchUserGroups,
    TResult Function(List<Group> groups)? userGroupsUpdated,
    TResult Function(String groupId)? loadGroupDetails,
    TResult Function(String groupId)? watchGroupMembers,
    TResult Function(List<GroupMember> members)? groupMembersUpdated,
    TResult Function(String groupId, int? limit)? watchGroupTransactions,
    TResult Function(List<GroupTransaction> transactions)?
    groupTransactionsUpdated,
    TResult Function(String groupId)? watchPendingApprovals,
    TResult Function(List<PendingApproval> approvals)? pendingApprovalsUpdated,
    TResult Function(CreateGroupParams params)? createGroup,
    TResult Function(String groupId, UpdateGroupParams params)? updateGroup,
    TResult Function(String groupId)? deleteGroup,
    TResult Function(String groupId, String userId, GroupRole role)?
    inviteMember,
    TResult Function(String groupId)? acceptInvitation,
    TResult Function(String groupId)? declineInvitation,
    TResult Function(String groupId, String memberId)? removeMember,
    TResult Function(String groupId, String memberId, GroupRole role)?
    updateMemberRole,
    TResult Function(String groupId)? leaveGroup,
    TResult Function()? loadPendingInvitations,
    TResult Function(String groupId, int amount, String? description)?
    contributeToGroup,
    TResult Function(String groupId, int amount, String? description)?
    withdrawFromGroup,
    TResult Function(String groupId, String transactionId)? approveTransaction,
    TResult Function(String groupId, String transactionId, String? reason)?
    rejectTransaction,
    TResult Function(String groupId, String? recipientId)? triggerStokvelPayout,
    TResult Function(String groupId, int? months)? loadStokvelAnalytics,
    TResult Function()? clearSelectedGroup,
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
    required TResult Function(_LoadUserGroups value) loadUserGroups,
    required TResult Function(_WatchUserGroups value) watchUserGroups,
    required TResult Function(_UserGroupsUpdated value) userGroupsUpdated,
    required TResult Function(_LoadGroupDetails value) loadGroupDetails,
    required TResult Function(_WatchGroupMembers value) watchGroupMembers,
    required TResult Function(_GroupMembersUpdated value) groupMembersUpdated,
    required TResult Function(_WatchGroupTransactions value)
    watchGroupTransactions,
    required TResult Function(_GroupTransactionsUpdated value)
    groupTransactionsUpdated,
    required TResult Function(_WatchPendingApprovals value)
    watchPendingApprovals,
    required TResult Function(_PendingApprovalsUpdated value)
    pendingApprovalsUpdated,
    required TResult Function(_CreateGroup value) createGroup,
    required TResult Function(_UpdateGroup value) updateGroup,
    required TResult Function(_DeleteGroup value) deleteGroup,
    required TResult Function(_InviteMember value) inviteMember,
    required TResult Function(_AcceptInvitation value) acceptInvitation,
    required TResult Function(_DeclineInvitation value) declineInvitation,
    required TResult Function(_RemoveMember value) removeMember,
    required TResult Function(_UpdateMemberRole value) updateMemberRole,
    required TResult Function(_LeaveGroup value) leaveGroup,
    required TResult Function(_LoadPendingInvitations value)
    loadPendingInvitations,
    required TResult Function(_ContributeToGroup value) contributeToGroup,
    required TResult Function(_WithdrawFromGroup value) withdrawFromGroup,
    required TResult Function(_ApproveTransaction value) approveTransaction,
    required TResult Function(_RejectTransaction value) rejectTransaction,
    required TResult Function(_TriggerStokvelPayout value) triggerStokvelPayout,
    required TResult Function(_LoadStokvelAnalytics value) loadStokvelAnalytics,
    required TResult Function(_ClearSelectedGroup value) clearSelectedGroup,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadUserGroups value)? loadUserGroups,
    TResult? Function(_WatchUserGroups value)? watchUserGroups,
    TResult? Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult? Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult? Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult? Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult? Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult? Function(_GroupTransactionsUpdated value)?
    groupTransactionsUpdated,
    TResult? Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult? Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult? Function(_CreateGroup value)? createGroup,
    TResult? Function(_UpdateGroup value)? updateGroup,
    TResult? Function(_DeleteGroup value)? deleteGroup,
    TResult? Function(_InviteMember value)? inviteMember,
    TResult? Function(_AcceptInvitation value)? acceptInvitation,
    TResult? Function(_DeclineInvitation value)? declineInvitation,
    TResult? Function(_RemoveMember value)? removeMember,
    TResult? Function(_UpdateMemberRole value)? updateMemberRole,
    TResult? Function(_LeaveGroup value)? leaveGroup,
    TResult? Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult? Function(_ContributeToGroup value)? contributeToGroup,
    TResult? Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult? Function(_ApproveTransaction value)? approveTransaction,
    TResult? Function(_RejectTransaction value)? rejectTransaction,
    TResult? Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult? Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult? Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadUserGroups value)? loadUserGroups,
    TResult Function(_WatchUserGroups value)? watchUserGroups,
    TResult Function(_UserGroupsUpdated value)? userGroupsUpdated,
    TResult Function(_LoadGroupDetails value)? loadGroupDetails,
    TResult Function(_WatchGroupMembers value)? watchGroupMembers,
    TResult Function(_GroupMembersUpdated value)? groupMembersUpdated,
    TResult Function(_WatchGroupTransactions value)? watchGroupTransactions,
    TResult Function(_GroupTransactionsUpdated value)? groupTransactionsUpdated,
    TResult Function(_WatchPendingApprovals value)? watchPendingApprovals,
    TResult Function(_PendingApprovalsUpdated value)? pendingApprovalsUpdated,
    TResult Function(_CreateGroup value)? createGroup,
    TResult Function(_UpdateGroup value)? updateGroup,
    TResult Function(_DeleteGroup value)? deleteGroup,
    TResult Function(_InviteMember value)? inviteMember,
    TResult Function(_AcceptInvitation value)? acceptInvitation,
    TResult Function(_DeclineInvitation value)? declineInvitation,
    TResult Function(_RemoveMember value)? removeMember,
    TResult Function(_UpdateMemberRole value)? updateMemberRole,
    TResult Function(_LeaveGroup value)? leaveGroup,
    TResult Function(_LoadPendingInvitations value)? loadPendingInvitations,
    TResult Function(_ContributeToGroup value)? contributeToGroup,
    TResult Function(_WithdrawFromGroup value)? withdrawFromGroup,
    TResult Function(_ApproveTransaction value)? approveTransaction,
    TResult Function(_RejectTransaction value)? rejectTransaction,
    TResult Function(_TriggerStokvelPayout value)? triggerStokvelPayout,
    TResult Function(_LoadStokvelAnalytics value)? loadStokvelAnalytics,
    TResult Function(_ClearSelectedGroup value)? clearSelectedGroup,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements GroupEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
mixin _$GroupState {
  // Status
  GroupLoadingStatus get status => throw _privateConstructorUsedError;
  GroupOperationStatus get operationStatus =>
      throw _privateConstructorUsedError; // Groups list
  List<Group> get groups => throw _privateConstructorUsedError;
  List<GroupMember> get pendingInvitations =>
      throw _privateConstructorUsedError; // Selected group details
  Group? get selectedGroup => throw _privateConstructorUsedError;
  List<GroupMember> get selectedGroupMembers =>
      throw _privateConstructorUsedError;
  List<GroupTransaction> get selectedGroupTransactions =>
      throw _privateConstructorUsedError;
  List<PendingApproval> get selectedGroupApprovals =>
      throw _privateConstructorUsedError; // Loading states
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMoreTransactions =>
      throw _privateConstructorUsedError; // Stokvel analytics
  StokvelAnalytics? get stokvelAnalytics => throw _privateConstructorUsedError;
  bool get isLoadingAnalytics =>
      throw _privateConstructorUsedError; // Error handling
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of GroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupStateCopyWith<GroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupStateCopyWith<$Res> {
  factory $GroupStateCopyWith(
    GroupState value,
    $Res Function(GroupState) then,
  ) = _$GroupStateCopyWithImpl<$Res, GroupState>;
  @useResult
  $Res call({
    GroupLoadingStatus status,
    GroupOperationStatus operationStatus,
    List<Group> groups,
    List<GroupMember> pendingInvitations,
    Group? selectedGroup,
    List<GroupMember> selectedGroupMembers,
    List<GroupTransaction> selectedGroupTransactions,
    List<PendingApproval> selectedGroupApprovals,
    bool isLoadingMore,
    bool hasMoreTransactions,
    StokvelAnalytics? stokvelAnalytics,
    bool isLoadingAnalytics,
    String? errorMessage,
    String? successMessage,
  });

  $GroupCopyWith<$Res>? get selectedGroup;
}

/// @nodoc
class _$GroupStateCopyWithImpl<$Res, $Val extends GroupState>
    implements $GroupStateCopyWith<$Res> {
  _$GroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? operationStatus = null,
    Object? groups = null,
    Object? pendingInvitations = null,
    Object? selectedGroup = freezed,
    Object? selectedGroupMembers = null,
    Object? selectedGroupTransactions = null,
    Object? selectedGroupApprovals = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? stokvelAnalytics = freezed,
    Object? isLoadingAnalytics = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GroupLoadingStatus,
            operationStatus: null == operationStatus
                ? _value.operationStatus
                : operationStatus // ignore: cast_nullable_to_non_nullable
                      as GroupOperationStatus,
            groups: null == groups
                ? _value.groups
                : groups // ignore: cast_nullable_to_non_nullable
                      as List<Group>,
            pendingInvitations: null == pendingInvitations
                ? _value.pendingInvitations
                : pendingInvitations // ignore: cast_nullable_to_non_nullable
                      as List<GroupMember>,
            selectedGroup: freezed == selectedGroup
                ? _value.selectedGroup
                : selectedGroup // ignore: cast_nullable_to_non_nullable
                      as Group?,
            selectedGroupMembers: null == selectedGroupMembers
                ? _value.selectedGroupMembers
                : selectedGroupMembers // ignore: cast_nullable_to_non_nullable
                      as List<GroupMember>,
            selectedGroupTransactions: null == selectedGroupTransactions
                ? _value.selectedGroupTransactions
                : selectedGroupTransactions // ignore: cast_nullable_to_non_nullable
                      as List<GroupTransaction>,
            selectedGroupApprovals: null == selectedGroupApprovals
                ? _value.selectedGroupApprovals
                : selectedGroupApprovals // ignore: cast_nullable_to_non_nullable
                      as List<PendingApproval>,
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

  /// Create a copy of GroupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res>? get selectedGroup {
    if (_value.selectedGroup == null) {
      return null;
    }

    return $GroupCopyWith<$Res>(_value.selectedGroup!, (value) {
      return _then(_value.copyWith(selectedGroup: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupStateImplCopyWith<$Res>
    implements $GroupStateCopyWith<$Res> {
  factory _$$GroupStateImplCopyWith(
    _$GroupStateImpl value,
    $Res Function(_$GroupStateImpl) then,
  ) = __$$GroupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GroupLoadingStatus status,
    GroupOperationStatus operationStatus,
    List<Group> groups,
    List<GroupMember> pendingInvitations,
    Group? selectedGroup,
    List<GroupMember> selectedGroupMembers,
    List<GroupTransaction> selectedGroupTransactions,
    List<PendingApproval> selectedGroupApprovals,
    bool isLoadingMore,
    bool hasMoreTransactions,
    StokvelAnalytics? stokvelAnalytics,
    bool isLoadingAnalytics,
    String? errorMessage,
    String? successMessage,
  });

  @override
  $GroupCopyWith<$Res>? get selectedGroup;
}

/// @nodoc
class __$$GroupStateImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$GroupStateImpl>
    implements _$$GroupStateImplCopyWith<$Res> {
  __$$GroupStateImplCopyWithImpl(
    _$GroupStateImpl _value,
    $Res Function(_$GroupStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? operationStatus = null,
    Object? groups = null,
    Object? pendingInvitations = null,
    Object? selectedGroup = freezed,
    Object? selectedGroupMembers = null,
    Object? selectedGroupTransactions = null,
    Object? selectedGroupApprovals = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? stokvelAnalytics = freezed,
    Object? isLoadingAnalytics = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$GroupStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GroupLoadingStatus,
        operationStatus: null == operationStatus
            ? _value.operationStatus
            : operationStatus // ignore: cast_nullable_to_non_nullable
                  as GroupOperationStatus,
        groups: null == groups
            ? _value._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<Group>,
        pendingInvitations: null == pendingInvitations
            ? _value._pendingInvitations
            : pendingInvitations // ignore: cast_nullable_to_non_nullable
                  as List<GroupMember>,
        selectedGroup: freezed == selectedGroup
            ? _value.selectedGroup
            : selectedGroup // ignore: cast_nullable_to_non_nullable
                  as Group?,
        selectedGroupMembers: null == selectedGroupMembers
            ? _value._selectedGroupMembers
            : selectedGroupMembers // ignore: cast_nullable_to_non_nullable
                  as List<GroupMember>,
        selectedGroupTransactions: null == selectedGroupTransactions
            ? _value._selectedGroupTransactions
            : selectedGroupTransactions // ignore: cast_nullable_to_non_nullable
                  as List<GroupTransaction>,
        selectedGroupApprovals: null == selectedGroupApprovals
            ? _value._selectedGroupApprovals
            : selectedGroupApprovals // ignore: cast_nullable_to_non_nullable
                  as List<PendingApproval>,
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

class _$GroupStateImpl extends _GroupState {
  const _$GroupStateImpl({
    this.status = GroupLoadingStatus.initial,
    this.operationStatus = GroupOperationStatus.idle,
    final List<Group> groups = const [],
    final List<GroupMember> pendingInvitations = const [],
    this.selectedGroup,
    final List<GroupMember> selectedGroupMembers = const [],
    final List<GroupTransaction> selectedGroupTransactions = const [],
    final List<PendingApproval> selectedGroupApprovals = const [],
    this.isLoadingMore = false,
    this.hasMoreTransactions = false,
    this.stokvelAnalytics,
    this.isLoadingAnalytics = false,
    this.errorMessage,
    this.successMessage,
  }) : _groups = groups,
       _pendingInvitations = pendingInvitations,
       _selectedGroupMembers = selectedGroupMembers,
       _selectedGroupTransactions = selectedGroupTransactions,
       _selectedGroupApprovals = selectedGroupApprovals,
       super._();

  // Status
  @override
  @JsonKey()
  final GroupLoadingStatus status;
  @override
  @JsonKey()
  final GroupOperationStatus operationStatus;
  // Groups list
  final List<Group> _groups;
  // Groups list
  @override
  @JsonKey()
  List<Group> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  final List<GroupMember> _pendingInvitations;
  @override
  @JsonKey()
  List<GroupMember> get pendingInvitations {
    if (_pendingInvitations is EqualUnmodifiableListView)
      return _pendingInvitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingInvitations);
  }

  // Selected group details
  @override
  final Group? selectedGroup;
  final List<GroupMember> _selectedGroupMembers;
  @override
  @JsonKey()
  List<GroupMember> get selectedGroupMembers {
    if (_selectedGroupMembers is EqualUnmodifiableListView)
      return _selectedGroupMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedGroupMembers);
  }

  final List<GroupTransaction> _selectedGroupTransactions;
  @override
  @JsonKey()
  List<GroupTransaction> get selectedGroupTransactions {
    if (_selectedGroupTransactions is EqualUnmodifiableListView)
      return _selectedGroupTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedGroupTransactions);
  }

  final List<PendingApproval> _selectedGroupApprovals;
  @override
  @JsonKey()
  List<PendingApproval> get selectedGroupApprovals {
    if (_selectedGroupApprovals is EqualUnmodifiableListView)
      return _selectedGroupApprovals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedGroupApprovals);
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
  // Error handling
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'GroupState(status: $status, operationStatus: $operationStatus, groups: $groups, pendingInvitations: $pendingInvitations, selectedGroup: $selectedGroup, selectedGroupMembers: $selectedGroupMembers, selectedGroupTransactions: $selectedGroupTransactions, selectedGroupApprovals: $selectedGroupApprovals, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, stokvelAnalytics: $stokvelAnalytics, isLoadingAnalytics: $isLoadingAnalytics, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.operationStatus, operationStatus) ||
                other.operationStatus == operationStatus) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality().equals(
              other._pendingInvitations,
              _pendingInvitations,
            ) &&
            (identical(other.selectedGroup, selectedGroup) ||
                other.selectedGroup == selectedGroup) &&
            const DeepCollectionEquality().equals(
              other._selectedGroupMembers,
              _selectedGroupMembers,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedGroupTransactions,
              _selectedGroupTransactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedGroupApprovals,
              _selectedGroupApprovals,
            ) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMoreTransactions, hasMoreTransactions) ||
                other.hasMoreTransactions == hasMoreTransactions) &&
            (identical(other.stokvelAnalytics, stokvelAnalytics) ||
                other.stokvelAnalytics == stokvelAnalytics) &&
            (identical(other.isLoadingAnalytics, isLoadingAnalytics) ||
                other.isLoadingAnalytics == isLoadingAnalytics) &&
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
    const DeepCollectionEquality().hash(_groups),
    const DeepCollectionEquality().hash(_pendingInvitations),
    selectedGroup,
    const DeepCollectionEquality().hash(_selectedGroupMembers),
    const DeepCollectionEquality().hash(_selectedGroupTransactions),
    const DeepCollectionEquality().hash(_selectedGroupApprovals),
    isLoadingMore,
    hasMoreTransactions,
    stokvelAnalytics,
    isLoadingAnalytics,
    errorMessage,
    successMessage,
  );

  /// Create a copy of GroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupStateImplCopyWith<_$GroupStateImpl> get copyWith =>
      __$$GroupStateImplCopyWithImpl<_$GroupStateImpl>(this, _$identity);
}

abstract class _GroupState extends GroupState {
  const factory _GroupState({
    final GroupLoadingStatus status,
    final GroupOperationStatus operationStatus,
    final List<Group> groups,
    final List<GroupMember> pendingInvitations,
    final Group? selectedGroup,
    final List<GroupMember> selectedGroupMembers,
    final List<GroupTransaction> selectedGroupTransactions,
    final List<PendingApproval> selectedGroupApprovals,
    final bool isLoadingMore,
    final bool hasMoreTransactions,
    final StokvelAnalytics? stokvelAnalytics,
    final bool isLoadingAnalytics,
    final String? errorMessage,
    final String? successMessage,
  }) = _$GroupStateImpl;
  const _GroupState._() : super._();

  // Status
  @override
  GroupLoadingStatus get status;
  @override
  GroupOperationStatus get operationStatus; // Groups list
  @override
  List<Group> get groups;
  @override
  List<GroupMember> get pendingInvitations; // Selected group details
  @override
  Group? get selectedGroup;
  @override
  List<GroupMember> get selectedGroupMembers;
  @override
  List<GroupTransaction> get selectedGroupTransactions;
  @override
  List<PendingApproval> get selectedGroupApprovals; // Loading states
  @override
  bool get isLoadingMore;
  @override
  bool get hasMoreTransactions; // Stokvel analytics
  @override
  StokvelAnalytics? get stokvelAnalytics;
  @override
  bool get isLoadingAnalytics; // Error handling
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of GroupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupStateImplCopyWith<_$GroupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
