// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupEvent()';
}


}

/// @nodoc
class $GroupEventCopyWith<$Res>  {
$GroupEventCopyWith(GroupEvent _, $Res Function(GroupEvent) __);
}


/// Adds pattern-matching-related methods to [GroupEvent].
extension GroupEventPatterns on GroupEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadUserGroups value)?  loadUserGroups,TResult Function( _WatchUserGroups value)?  watchUserGroups,TResult Function( _UserGroupsUpdated value)?  userGroupsUpdated,TResult Function( _LoadGroupDetails value)?  loadGroupDetails,TResult Function( _WatchGroupMembers value)?  watchGroupMembers,TResult Function( _GroupMembersUpdated value)?  groupMembersUpdated,TResult Function( _WatchGroupTransactions value)?  watchGroupTransactions,TResult Function( _GroupTransactionsUpdated value)?  groupTransactionsUpdated,TResult Function( _WatchPendingApprovals value)?  watchPendingApprovals,TResult Function( _PendingApprovalsUpdated value)?  pendingApprovalsUpdated,TResult Function( _CreateGroup value)?  createGroup,TResult Function( _UpdateGroup value)?  updateGroup,TResult Function( _DeleteGroup value)?  deleteGroup,TResult Function( _InviteMember value)?  inviteMember,TResult Function( _AcceptInvitation value)?  acceptInvitation,TResult Function( _DeclineInvitation value)?  declineInvitation,TResult Function( _RemoveMember value)?  removeMember,TResult Function( _UpdateMemberRole value)?  updateMemberRole,TResult Function( _LeaveGroup value)?  leaveGroup,TResult Function( _LoadPendingInvitations value)?  loadPendingInvitations,TResult Function( _ContributeToGroup value)?  contributeToGroup,TResult Function( _WithdrawFromGroup value)?  withdrawFromGroup,TResult Function( _ApproveTransaction value)?  approveTransaction,TResult Function( _RejectTransaction value)?  rejectTransaction,TResult Function( _TriggerStokvelPayout value)?  triggerStokvelPayout,TResult Function( _LoadStokvelAnalytics value)?  loadStokvelAnalytics,TResult Function( _ClearSelectedGroup value)?  clearSelectedGroup,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadUserGroups() when loadUserGroups != null:
return loadUserGroups(_that);case _WatchUserGroups() when watchUserGroups != null:
return watchUserGroups(_that);case _UserGroupsUpdated() when userGroupsUpdated != null:
return userGroupsUpdated(_that);case _LoadGroupDetails() when loadGroupDetails != null:
return loadGroupDetails(_that);case _WatchGroupMembers() when watchGroupMembers != null:
return watchGroupMembers(_that);case _GroupMembersUpdated() when groupMembersUpdated != null:
return groupMembersUpdated(_that);case _WatchGroupTransactions() when watchGroupTransactions != null:
return watchGroupTransactions(_that);case _GroupTransactionsUpdated() when groupTransactionsUpdated != null:
return groupTransactionsUpdated(_that);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that);case _CreateGroup() when createGroup != null:
return createGroup(_that);case _UpdateGroup() when updateGroup != null:
return updateGroup(_that);case _DeleteGroup() when deleteGroup != null:
return deleteGroup(_that);case _InviteMember() when inviteMember != null:
return inviteMember(_that);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that);case _RemoveMember() when removeMember != null:
return removeMember(_that);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that);case _LeaveGroup() when leaveGroup != null:
return leaveGroup(_that);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations(_that);case _ContributeToGroup() when contributeToGroup != null:
return contributeToGroup(_that);case _WithdrawFromGroup() when withdrawFromGroup != null:
return withdrawFromGroup(_that);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that);case _TriggerStokvelPayout() when triggerStokvelPayout != null:
return triggerStokvelPayout(_that);case _LoadStokvelAnalytics() when loadStokvelAnalytics != null:
return loadStokvelAnalytics(_that);case _ClearSelectedGroup() when clearSelectedGroup != null:
return clearSelectedGroup(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadUserGroups value)  loadUserGroups,required TResult Function( _WatchUserGroups value)  watchUserGroups,required TResult Function( _UserGroupsUpdated value)  userGroupsUpdated,required TResult Function( _LoadGroupDetails value)  loadGroupDetails,required TResult Function( _WatchGroupMembers value)  watchGroupMembers,required TResult Function( _GroupMembersUpdated value)  groupMembersUpdated,required TResult Function( _WatchGroupTransactions value)  watchGroupTransactions,required TResult Function( _GroupTransactionsUpdated value)  groupTransactionsUpdated,required TResult Function( _WatchPendingApprovals value)  watchPendingApprovals,required TResult Function( _PendingApprovalsUpdated value)  pendingApprovalsUpdated,required TResult Function( _CreateGroup value)  createGroup,required TResult Function( _UpdateGroup value)  updateGroup,required TResult Function( _DeleteGroup value)  deleteGroup,required TResult Function( _InviteMember value)  inviteMember,required TResult Function( _AcceptInvitation value)  acceptInvitation,required TResult Function( _DeclineInvitation value)  declineInvitation,required TResult Function( _RemoveMember value)  removeMember,required TResult Function( _UpdateMemberRole value)  updateMemberRole,required TResult Function( _LeaveGroup value)  leaveGroup,required TResult Function( _LoadPendingInvitations value)  loadPendingInvitations,required TResult Function( _ContributeToGroup value)  contributeToGroup,required TResult Function( _WithdrawFromGroup value)  withdrawFromGroup,required TResult Function( _ApproveTransaction value)  approveTransaction,required TResult Function( _RejectTransaction value)  rejectTransaction,required TResult Function( _TriggerStokvelPayout value)  triggerStokvelPayout,required TResult Function( _LoadStokvelAnalytics value)  loadStokvelAnalytics,required TResult Function( _ClearSelectedGroup value)  clearSelectedGroup,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _LoadUserGroups():
return loadUserGroups(_that);case _WatchUserGroups():
return watchUserGroups(_that);case _UserGroupsUpdated():
return userGroupsUpdated(_that);case _LoadGroupDetails():
return loadGroupDetails(_that);case _WatchGroupMembers():
return watchGroupMembers(_that);case _GroupMembersUpdated():
return groupMembersUpdated(_that);case _WatchGroupTransactions():
return watchGroupTransactions(_that);case _GroupTransactionsUpdated():
return groupTransactionsUpdated(_that);case _WatchPendingApprovals():
return watchPendingApprovals(_that);case _PendingApprovalsUpdated():
return pendingApprovalsUpdated(_that);case _CreateGroup():
return createGroup(_that);case _UpdateGroup():
return updateGroup(_that);case _DeleteGroup():
return deleteGroup(_that);case _InviteMember():
return inviteMember(_that);case _AcceptInvitation():
return acceptInvitation(_that);case _DeclineInvitation():
return declineInvitation(_that);case _RemoveMember():
return removeMember(_that);case _UpdateMemberRole():
return updateMemberRole(_that);case _LeaveGroup():
return leaveGroup(_that);case _LoadPendingInvitations():
return loadPendingInvitations(_that);case _ContributeToGroup():
return contributeToGroup(_that);case _WithdrawFromGroup():
return withdrawFromGroup(_that);case _ApproveTransaction():
return approveTransaction(_that);case _RejectTransaction():
return rejectTransaction(_that);case _TriggerStokvelPayout():
return triggerStokvelPayout(_that);case _LoadStokvelAnalytics():
return loadStokvelAnalytics(_that);case _ClearSelectedGroup():
return clearSelectedGroup(_that);case _ClearError():
return clearError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadUserGroups value)?  loadUserGroups,TResult? Function( _WatchUserGroups value)?  watchUserGroups,TResult? Function( _UserGroupsUpdated value)?  userGroupsUpdated,TResult? Function( _LoadGroupDetails value)?  loadGroupDetails,TResult? Function( _WatchGroupMembers value)?  watchGroupMembers,TResult? Function( _GroupMembersUpdated value)?  groupMembersUpdated,TResult? Function( _WatchGroupTransactions value)?  watchGroupTransactions,TResult? Function( _GroupTransactionsUpdated value)?  groupTransactionsUpdated,TResult? Function( _WatchPendingApprovals value)?  watchPendingApprovals,TResult? Function( _PendingApprovalsUpdated value)?  pendingApprovalsUpdated,TResult? Function( _CreateGroup value)?  createGroup,TResult? Function( _UpdateGroup value)?  updateGroup,TResult? Function( _DeleteGroup value)?  deleteGroup,TResult? Function( _InviteMember value)?  inviteMember,TResult? Function( _AcceptInvitation value)?  acceptInvitation,TResult? Function( _DeclineInvitation value)?  declineInvitation,TResult? Function( _RemoveMember value)?  removeMember,TResult? Function( _UpdateMemberRole value)?  updateMemberRole,TResult? Function( _LeaveGroup value)?  leaveGroup,TResult? Function( _LoadPendingInvitations value)?  loadPendingInvitations,TResult? Function( _ContributeToGroup value)?  contributeToGroup,TResult? Function( _WithdrawFromGroup value)?  withdrawFromGroup,TResult? Function( _ApproveTransaction value)?  approveTransaction,TResult? Function( _RejectTransaction value)?  rejectTransaction,TResult? Function( _TriggerStokvelPayout value)?  triggerStokvelPayout,TResult? Function( _LoadStokvelAnalytics value)?  loadStokvelAnalytics,TResult? Function( _ClearSelectedGroup value)?  clearSelectedGroup,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _LoadUserGroups() when loadUserGroups != null:
return loadUserGroups(_that);case _WatchUserGroups() when watchUserGroups != null:
return watchUserGroups(_that);case _UserGroupsUpdated() when userGroupsUpdated != null:
return userGroupsUpdated(_that);case _LoadGroupDetails() when loadGroupDetails != null:
return loadGroupDetails(_that);case _WatchGroupMembers() when watchGroupMembers != null:
return watchGroupMembers(_that);case _GroupMembersUpdated() when groupMembersUpdated != null:
return groupMembersUpdated(_that);case _WatchGroupTransactions() when watchGroupTransactions != null:
return watchGroupTransactions(_that);case _GroupTransactionsUpdated() when groupTransactionsUpdated != null:
return groupTransactionsUpdated(_that);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that);case _CreateGroup() when createGroup != null:
return createGroup(_that);case _UpdateGroup() when updateGroup != null:
return updateGroup(_that);case _DeleteGroup() when deleteGroup != null:
return deleteGroup(_that);case _InviteMember() when inviteMember != null:
return inviteMember(_that);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that);case _RemoveMember() when removeMember != null:
return removeMember(_that);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that);case _LeaveGroup() when leaveGroup != null:
return leaveGroup(_that);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations(_that);case _ContributeToGroup() when contributeToGroup != null:
return contributeToGroup(_that);case _WithdrawFromGroup() when withdrawFromGroup != null:
return withdrawFromGroup(_that);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that);case _TriggerStokvelPayout() when triggerStokvelPayout != null:
return triggerStokvelPayout(_that);case _LoadStokvelAnalytics() when loadStokvelAnalytics != null:
return loadStokvelAnalytics(_that);case _ClearSelectedGroup() when clearSelectedGroup != null:
return clearSelectedGroup(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadUserGroups,TResult Function()?  watchUserGroups,TResult Function( List<Group> groups)?  userGroupsUpdated,TResult Function( String groupId)?  loadGroupDetails,TResult Function( String groupId)?  watchGroupMembers,TResult Function( List<GroupMember> members)?  groupMembersUpdated,TResult Function( String groupId,  int? limit)?  watchGroupTransactions,TResult Function( List<GroupTransaction> transactions)?  groupTransactionsUpdated,TResult Function( String groupId)?  watchPendingApprovals,TResult Function( List<PendingApproval> approvals)?  pendingApprovalsUpdated,TResult Function( CreateGroupParams params)?  createGroup,TResult Function( String groupId,  UpdateGroupParams params)?  updateGroup,TResult Function( String groupId)?  deleteGroup,TResult Function( String groupId,  String userId,  GroupRole role)?  inviteMember,TResult Function( String groupId)?  acceptInvitation,TResult Function( String groupId)?  declineInvitation,TResult Function( String groupId,  String memberId)?  removeMember,TResult Function( String groupId,  String memberId,  GroupRole role)?  updateMemberRole,TResult Function( String groupId)?  leaveGroup,TResult Function()?  loadPendingInvitations,TResult Function( String groupId,  int amount,  String? description)?  contributeToGroup,TResult Function( String groupId,  int amount,  String? description)?  withdrawFromGroup,TResult Function( String groupId,  String transactionId)?  approveTransaction,TResult Function( String groupId,  String transactionId,  String? reason)?  rejectTransaction,TResult Function( String groupId,  String? recipientId)?  triggerStokvelPayout,TResult Function( String groupId,  int? months)?  loadStokvelAnalytics,TResult Function()?  clearSelectedGroup,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadUserGroups() when loadUserGroups != null:
return loadUserGroups();case _WatchUserGroups() when watchUserGroups != null:
return watchUserGroups();case _UserGroupsUpdated() when userGroupsUpdated != null:
return userGroupsUpdated(_that.groups);case _LoadGroupDetails() when loadGroupDetails != null:
return loadGroupDetails(_that.groupId);case _WatchGroupMembers() when watchGroupMembers != null:
return watchGroupMembers(_that.groupId);case _GroupMembersUpdated() when groupMembersUpdated != null:
return groupMembersUpdated(_that.members);case _WatchGroupTransactions() when watchGroupTransactions != null:
return watchGroupTransactions(_that.groupId,_that.limit);case _GroupTransactionsUpdated() when groupTransactionsUpdated != null:
return groupTransactionsUpdated(_that.transactions);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that.groupId);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that.approvals);case _CreateGroup() when createGroup != null:
return createGroup(_that.params);case _UpdateGroup() when updateGroup != null:
return updateGroup(_that.groupId,_that.params);case _DeleteGroup() when deleteGroup != null:
return deleteGroup(_that.groupId);case _InviteMember() when inviteMember != null:
return inviteMember(_that.groupId,_that.userId,_that.role);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that.groupId);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that.groupId);case _RemoveMember() when removeMember != null:
return removeMember(_that.groupId,_that.memberId);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that.groupId,_that.memberId,_that.role);case _LeaveGroup() when leaveGroup != null:
return leaveGroup(_that.groupId);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations();case _ContributeToGroup() when contributeToGroup != null:
return contributeToGroup(_that.groupId,_that.amount,_that.description);case _WithdrawFromGroup() when withdrawFromGroup != null:
return withdrawFromGroup(_that.groupId,_that.amount,_that.description);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that.groupId,_that.transactionId);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that.groupId,_that.transactionId,_that.reason);case _TriggerStokvelPayout() when triggerStokvelPayout != null:
return triggerStokvelPayout(_that.groupId,_that.recipientId);case _LoadStokvelAnalytics() when loadStokvelAnalytics != null:
return loadStokvelAnalytics(_that.groupId,_that.months);case _ClearSelectedGroup() when clearSelectedGroup != null:
return clearSelectedGroup();case _ClearError() when clearError != null:
return clearError();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadUserGroups,required TResult Function()  watchUserGroups,required TResult Function( List<Group> groups)  userGroupsUpdated,required TResult Function( String groupId)  loadGroupDetails,required TResult Function( String groupId)  watchGroupMembers,required TResult Function( List<GroupMember> members)  groupMembersUpdated,required TResult Function( String groupId,  int? limit)  watchGroupTransactions,required TResult Function( List<GroupTransaction> transactions)  groupTransactionsUpdated,required TResult Function( String groupId)  watchPendingApprovals,required TResult Function( List<PendingApproval> approvals)  pendingApprovalsUpdated,required TResult Function( CreateGroupParams params)  createGroup,required TResult Function( String groupId,  UpdateGroupParams params)  updateGroup,required TResult Function( String groupId)  deleteGroup,required TResult Function( String groupId,  String userId,  GroupRole role)  inviteMember,required TResult Function( String groupId)  acceptInvitation,required TResult Function( String groupId)  declineInvitation,required TResult Function( String groupId,  String memberId)  removeMember,required TResult Function( String groupId,  String memberId,  GroupRole role)  updateMemberRole,required TResult Function( String groupId)  leaveGroup,required TResult Function()  loadPendingInvitations,required TResult Function( String groupId,  int amount,  String? description)  contributeToGroup,required TResult Function( String groupId,  int amount,  String? description)  withdrawFromGroup,required TResult Function( String groupId,  String transactionId)  approveTransaction,required TResult Function( String groupId,  String transactionId,  String? reason)  rejectTransaction,required TResult Function( String groupId,  String? recipientId)  triggerStokvelPayout,required TResult Function( String groupId,  int? months)  loadStokvelAnalytics,required TResult Function()  clearSelectedGroup,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _LoadUserGroups():
return loadUserGroups();case _WatchUserGroups():
return watchUserGroups();case _UserGroupsUpdated():
return userGroupsUpdated(_that.groups);case _LoadGroupDetails():
return loadGroupDetails(_that.groupId);case _WatchGroupMembers():
return watchGroupMembers(_that.groupId);case _GroupMembersUpdated():
return groupMembersUpdated(_that.members);case _WatchGroupTransactions():
return watchGroupTransactions(_that.groupId,_that.limit);case _GroupTransactionsUpdated():
return groupTransactionsUpdated(_that.transactions);case _WatchPendingApprovals():
return watchPendingApprovals(_that.groupId);case _PendingApprovalsUpdated():
return pendingApprovalsUpdated(_that.approvals);case _CreateGroup():
return createGroup(_that.params);case _UpdateGroup():
return updateGroup(_that.groupId,_that.params);case _DeleteGroup():
return deleteGroup(_that.groupId);case _InviteMember():
return inviteMember(_that.groupId,_that.userId,_that.role);case _AcceptInvitation():
return acceptInvitation(_that.groupId);case _DeclineInvitation():
return declineInvitation(_that.groupId);case _RemoveMember():
return removeMember(_that.groupId,_that.memberId);case _UpdateMemberRole():
return updateMemberRole(_that.groupId,_that.memberId,_that.role);case _LeaveGroup():
return leaveGroup(_that.groupId);case _LoadPendingInvitations():
return loadPendingInvitations();case _ContributeToGroup():
return contributeToGroup(_that.groupId,_that.amount,_that.description);case _WithdrawFromGroup():
return withdrawFromGroup(_that.groupId,_that.amount,_that.description);case _ApproveTransaction():
return approveTransaction(_that.groupId,_that.transactionId);case _RejectTransaction():
return rejectTransaction(_that.groupId,_that.transactionId,_that.reason);case _TriggerStokvelPayout():
return triggerStokvelPayout(_that.groupId,_that.recipientId);case _LoadStokvelAnalytics():
return loadStokvelAnalytics(_that.groupId,_that.months);case _ClearSelectedGroup():
return clearSelectedGroup();case _ClearError():
return clearError();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadUserGroups,TResult? Function()?  watchUserGroups,TResult? Function( List<Group> groups)?  userGroupsUpdated,TResult? Function( String groupId)?  loadGroupDetails,TResult? Function( String groupId)?  watchGroupMembers,TResult? Function( List<GroupMember> members)?  groupMembersUpdated,TResult? Function( String groupId,  int? limit)?  watchGroupTransactions,TResult? Function( List<GroupTransaction> transactions)?  groupTransactionsUpdated,TResult? Function( String groupId)?  watchPendingApprovals,TResult? Function( List<PendingApproval> approvals)?  pendingApprovalsUpdated,TResult? Function( CreateGroupParams params)?  createGroup,TResult? Function( String groupId,  UpdateGroupParams params)?  updateGroup,TResult? Function( String groupId)?  deleteGroup,TResult? Function( String groupId,  String userId,  GroupRole role)?  inviteMember,TResult? Function( String groupId)?  acceptInvitation,TResult? Function( String groupId)?  declineInvitation,TResult? Function( String groupId,  String memberId)?  removeMember,TResult? Function( String groupId,  String memberId,  GroupRole role)?  updateMemberRole,TResult? Function( String groupId)?  leaveGroup,TResult? Function()?  loadPendingInvitations,TResult? Function( String groupId,  int amount,  String? description)?  contributeToGroup,TResult? Function( String groupId,  int amount,  String? description)?  withdrawFromGroup,TResult? Function( String groupId,  String transactionId)?  approveTransaction,TResult? Function( String groupId,  String transactionId,  String? reason)?  rejectTransaction,TResult? Function( String groupId,  String? recipientId)?  triggerStokvelPayout,TResult? Function( String groupId,  int? months)?  loadStokvelAnalytics,TResult? Function()?  clearSelectedGroup,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _LoadUserGroups() when loadUserGroups != null:
return loadUserGroups();case _WatchUserGroups() when watchUserGroups != null:
return watchUserGroups();case _UserGroupsUpdated() when userGroupsUpdated != null:
return userGroupsUpdated(_that.groups);case _LoadGroupDetails() when loadGroupDetails != null:
return loadGroupDetails(_that.groupId);case _WatchGroupMembers() when watchGroupMembers != null:
return watchGroupMembers(_that.groupId);case _GroupMembersUpdated() when groupMembersUpdated != null:
return groupMembersUpdated(_that.members);case _WatchGroupTransactions() when watchGroupTransactions != null:
return watchGroupTransactions(_that.groupId,_that.limit);case _GroupTransactionsUpdated() when groupTransactionsUpdated != null:
return groupTransactionsUpdated(_that.transactions);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that.groupId);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that.approvals);case _CreateGroup() when createGroup != null:
return createGroup(_that.params);case _UpdateGroup() when updateGroup != null:
return updateGroup(_that.groupId,_that.params);case _DeleteGroup() when deleteGroup != null:
return deleteGroup(_that.groupId);case _InviteMember() when inviteMember != null:
return inviteMember(_that.groupId,_that.userId,_that.role);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that.groupId);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that.groupId);case _RemoveMember() when removeMember != null:
return removeMember(_that.groupId,_that.memberId);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that.groupId,_that.memberId,_that.role);case _LeaveGroup() when leaveGroup != null:
return leaveGroup(_that.groupId);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations();case _ContributeToGroup() when contributeToGroup != null:
return contributeToGroup(_that.groupId,_that.amount,_that.description);case _WithdrawFromGroup() when withdrawFromGroup != null:
return withdrawFromGroup(_that.groupId,_that.amount,_that.description);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that.groupId,_that.transactionId);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that.groupId,_that.transactionId,_that.reason);case _TriggerStokvelPayout() when triggerStokvelPayout != null:
return triggerStokvelPayout(_that.groupId,_that.recipientId);case _LoadStokvelAnalytics() when loadStokvelAnalytics != null:
return loadStokvelAnalytics(_that.groupId,_that.months);case _ClearSelectedGroup() when clearSelectedGroup != null:
return clearSelectedGroup();case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _LoadUserGroups implements GroupEvent {
  const _LoadUserGroups();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadUserGroups);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupEvent.loadUserGroups()';
}


}




/// @nodoc


class _WatchUserGroups implements GroupEvent {
  const _WatchUserGroups();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchUserGroups);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupEvent.watchUserGroups()';
}


}




/// @nodoc


class _UserGroupsUpdated implements GroupEvent {
  const _UserGroupsUpdated(final  List<Group> groups): _groups = groups;
  

 final  List<Group> _groups;
 List<Group> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserGroupsUpdatedCopyWith<_UserGroupsUpdated> get copyWith => __$UserGroupsUpdatedCopyWithImpl<_UserGroupsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserGroupsUpdated&&const DeepCollectionEquality().equals(other._groups, _groups));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'GroupEvent.userGroupsUpdated(groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$UserGroupsUpdatedCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$UserGroupsUpdatedCopyWith(_UserGroupsUpdated value, $Res Function(_UserGroupsUpdated) _then) = __$UserGroupsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Group> groups
});




}
/// @nodoc
class __$UserGroupsUpdatedCopyWithImpl<$Res>
    implements _$UserGroupsUpdatedCopyWith<$Res> {
  __$UserGroupsUpdatedCopyWithImpl(this._self, this._then);

  final _UserGroupsUpdated _self;
  final $Res Function(_UserGroupsUpdated) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groups = null,}) {
  return _then(_UserGroupsUpdated(
null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}


}

/// @nodoc


class _LoadGroupDetails implements GroupEvent {
  const _LoadGroupDetails({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadGroupDetailsCopyWith<_LoadGroupDetails> get copyWith => __$LoadGroupDetailsCopyWithImpl<_LoadGroupDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadGroupDetails&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupEvent.loadGroupDetails(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$LoadGroupDetailsCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$LoadGroupDetailsCopyWith(_LoadGroupDetails value, $Res Function(_LoadGroupDetails) _then) = __$LoadGroupDetailsCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$LoadGroupDetailsCopyWithImpl<$Res>
    implements _$LoadGroupDetailsCopyWith<$Res> {
  __$LoadGroupDetailsCopyWithImpl(this._self, this._then);

  final _LoadGroupDetails _self;
  final $Res Function(_LoadGroupDetails) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_LoadGroupDetails(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WatchGroupMembers implements GroupEvent {
  const _WatchGroupMembers({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchGroupMembersCopyWith<_WatchGroupMembers> get copyWith => __$WatchGroupMembersCopyWithImpl<_WatchGroupMembers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchGroupMembers&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupEvent.watchGroupMembers(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$WatchGroupMembersCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$WatchGroupMembersCopyWith(_WatchGroupMembers value, $Res Function(_WatchGroupMembers) _then) = __$WatchGroupMembersCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$WatchGroupMembersCopyWithImpl<$Res>
    implements _$WatchGroupMembersCopyWith<$Res> {
  __$WatchGroupMembersCopyWithImpl(this._self, this._then);

  final _WatchGroupMembers _self;
  final $Res Function(_WatchGroupMembers) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_WatchGroupMembers(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GroupMembersUpdated implements GroupEvent {
  const _GroupMembersUpdated(final  List<GroupMember> members): _members = members;
  

 final  List<GroupMember> _members;
 List<GroupMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupMembersUpdatedCopyWith<_GroupMembersUpdated> get copyWith => __$GroupMembersUpdatedCopyWithImpl<_GroupMembersUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupMembersUpdated&&const DeepCollectionEquality().equals(other._members, _members));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'GroupEvent.groupMembersUpdated(members: $members)';
}


}

/// @nodoc
abstract mixin class _$GroupMembersUpdatedCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$GroupMembersUpdatedCopyWith(_GroupMembersUpdated value, $Res Function(_GroupMembersUpdated) _then) = __$GroupMembersUpdatedCopyWithImpl;
@useResult
$Res call({
 List<GroupMember> members
});




}
/// @nodoc
class __$GroupMembersUpdatedCopyWithImpl<$Res>
    implements _$GroupMembersUpdatedCopyWith<$Res> {
  __$GroupMembersUpdatedCopyWithImpl(this._self, this._then);

  final _GroupMembersUpdated _self;
  final $Res Function(_GroupMembersUpdated) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? members = null,}) {
  return _then(_GroupMembersUpdated(
null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<GroupMember>,
  ));
}


}

/// @nodoc


class _WatchGroupTransactions implements GroupEvent {
  const _WatchGroupTransactions({required this.groupId, this.limit});
  

 final  String groupId;
 final  int? limit;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchGroupTransactionsCopyWith<_WatchGroupTransactions> get copyWith => __$WatchGroupTransactionsCopyWithImpl<_WatchGroupTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchGroupTransactions&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,limit);

@override
String toString() {
  return 'GroupEvent.watchGroupTransactions(groupId: $groupId, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$WatchGroupTransactionsCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$WatchGroupTransactionsCopyWith(_WatchGroupTransactions value, $Res Function(_WatchGroupTransactions) _then) = __$WatchGroupTransactionsCopyWithImpl;
@useResult
$Res call({
 String groupId, int? limit
});




}
/// @nodoc
class __$WatchGroupTransactionsCopyWithImpl<$Res>
    implements _$WatchGroupTransactionsCopyWith<$Res> {
  __$WatchGroupTransactionsCopyWithImpl(this._self, this._then);

  final _WatchGroupTransactions _self;
  final $Res Function(_WatchGroupTransactions) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? limit = freezed,}) {
  return _then(_WatchGroupTransactions(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _GroupTransactionsUpdated implements GroupEvent {
  const _GroupTransactionsUpdated(final  List<GroupTransaction> transactions): _transactions = transactions;
  

 final  List<GroupTransaction> _transactions;
 List<GroupTransaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupTransactionsUpdatedCopyWith<_GroupTransactionsUpdated> get copyWith => __$GroupTransactionsUpdatedCopyWithImpl<_GroupTransactionsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupTransactionsUpdated&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'GroupEvent.groupTransactionsUpdated(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$GroupTransactionsUpdatedCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$GroupTransactionsUpdatedCopyWith(_GroupTransactionsUpdated value, $Res Function(_GroupTransactionsUpdated) _then) = __$GroupTransactionsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<GroupTransaction> transactions
});




}
/// @nodoc
class __$GroupTransactionsUpdatedCopyWithImpl<$Res>
    implements _$GroupTransactionsUpdatedCopyWith<$Res> {
  __$GroupTransactionsUpdatedCopyWithImpl(this._self, this._then);

  final _GroupTransactionsUpdated _self;
  final $Res Function(_GroupTransactionsUpdated) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(_GroupTransactionsUpdated(
null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<GroupTransaction>,
  ));
}


}

/// @nodoc


class _WatchPendingApprovals implements GroupEvent {
  const _WatchPendingApprovals({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchPendingApprovalsCopyWith<_WatchPendingApprovals> get copyWith => __$WatchPendingApprovalsCopyWithImpl<_WatchPendingApprovals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchPendingApprovals&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupEvent.watchPendingApprovals(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$WatchPendingApprovalsCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$WatchPendingApprovalsCopyWith(_WatchPendingApprovals value, $Res Function(_WatchPendingApprovals) _then) = __$WatchPendingApprovalsCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$WatchPendingApprovalsCopyWithImpl<$Res>
    implements _$WatchPendingApprovalsCopyWith<$Res> {
  __$WatchPendingApprovalsCopyWithImpl(this._self, this._then);

  final _WatchPendingApprovals _self;
  final $Res Function(_WatchPendingApprovals) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_WatchPendingApprovals(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PendingApprovalsUpdated implements GroupEvent {
  const _PendingApprovalsUpdated(final  List<PendingApproval> approvals): _approvals = approvals;
  

 final  List<PendingApproval> _approvals;
 List<PendingApproval> get approvals {
  if (_approvals is EqualUnmodifiableListView) return _approvals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvals);
}


/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingApprovalsUpdatedCopyWith<_PendingApprovalsUpdated> get copyWith => __$PendingApprovalsUpdatedCopyWithImpl<_PendingApprovalsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingApprovalsUpdated&&const DeepCollectionEquality().equals(other._approvals, _approvals));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_approvals));

@override
String toString() {
  return 'GroupEvent.pendingApprovalsUpdated(approvals: $approvals)';
}


}

/// @nodoc
abstract mixin class _$PendingApprovalsUpdatedCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$PendingApprovalsUpdatedCopyWith(_PendingApprovalsUpdated value, $Res Function(_PendingApprovalsUpdated) _then) = __$PendingApprovalsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<PendingApproval> approvals
});




}
/// @nodoc
class __$PendingApprovalsUpdatedCopyWithImpl<$Res>
    implements _$PendingApprovalsUpdatedCopyWith<$Res> {
  __$PendingApprovalsUpdatedCopyWithImpl(this._self, this._then);

  final _PendingApprovalsUpdated _self;
  final $Res Function(_PendingApprovalsUpdated) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? approvals = null,}) {
  return _then(_PendingApprovalsUpdated(
null == approvals ? _self._approvals : approvals // ignore: cast_nullable_to_non_nullable
as List<PendingApproval>,
  ));
}


}

/// @nodoc


class _CreateGroup implements GroupEvent {
  const _CreateGroup({required this.params});
  

 final  CreateGroupParams params;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateGroupCopyWith<_CreateGroup> get copyWith => __$CreateGroupCopyWithImpl<_CreateGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateGroup&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'GroupEvent.createGroup(params: $params)';
}


}

/// @nodoc
abstract mixin class _$CreateGroupCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$CreateGroupCopyWith(_CreateGroup value, $Res Function(_CreateGroup) _then) = __$CreateGroupCopyWithImpl;
@useResult
$Res call({
 CreateGroupParams params
});




}
/// @nodoc
class __$CreateGroupCopyWithImpl<$Res>
    implements _$CreateGroupCopyWith<$Res> {
  __$CreateGroupCopyWithImpl(this._self, this._then);

  final _CreateGroup _self;
  final $Res Function(_CreateGroup) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(_CreateGroup(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as CreateGroupParams,
  ));
}


}

/// @nodoc


class _UpdateGroup implements GroupEvent {
  const _UpdateGroup({required this.groupId, required this.params});
  

 final  String groupId;
 final  UpdateGroupParams params;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateGroupCopyWith<_UpdateGroup> get copyWith => __$UpdateGroupCopyWithImpl<_UpdateGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateGroup&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,params);

@override
String toString() {
  return 'GroupEvent.updateGroup(groupId: $groupId, params: $params)';
}


}

/// @nodoc
abstract mixin class _$UpdateGroupCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$UpdateGroupCopyWith(_UpdateGroup value, $Res Function(_UpdateGroup) _then) = __$UpdateGroupCopyWithImpl;
@useResult
$Res call({
 String groupId, UpdateGroupParams params
});




}
/// @nodoc
class __$UpdateGroupCopyWithImpl<$Res>
    implements _$UpdateGroupCopyWith<$Res> {
  __$UpdateGroupCopyWithImpl(this._self, this._then);

  final _UpdateGroup _self;
  final $Res Function(_UpdateGroup) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? params = null,}) {
  return _then(_UpdateGroup(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as UpdateGroupParams,
  ));
}


}

/// @nodoc


class _DeleteGroup implements GroupEvent {
  const _DeleteGroup({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteGroupCopyWith<_DeleteGroup> get copyWith => __$DeleteGroupCopyWithImpl<_DeleteGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteGroup&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupEvent.deleteGroup(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$DeleteGroupCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$DeleteGroupCopyWith(_DeleteGroup value, $Res Function(_DeleteGroup) _then) = __$DeleteGroupCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$DeleteGroupCopyWithImpl<$Res>
    implements _$DeleteGroupCopyWith<$Res> {
  __$DeleteGroupCopyWithImpl(this._self, this._then);

  final _DeleteGroup _self;
  final $Res Function(_DeleteGroup) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_DeleteGroup(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _InviteMember implements GroupEvent {
  const _InviteMember({required this.groupId, required this.userId, required this.role});
  

 final  String groupId;
 final  String userId;
 final  GroupRole role;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteMemberCopyWith<_InviteMember> get copyWith => __$InviteMemberCopyWithImpl<_InviteMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteMember&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,userId,role);

@override
String toString() {
  return 'GroupEvent.inviteMember(groupId: $groupId, userId: $userId, role: $role)';
}


}

/// @nodoc
abstract mixin class _$InviteMemberCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$InviteMemberCopyWith(_InviteMember value, $Res Function(_InviteMember) _then) = __$InviteMemberCopyWithImpl;
@useResult
$Res call({
 String groupId, String userId, GroupRole role
});




}
/// @nodoc
class __$InviteMemberCopyWithImpl<$Res>
    implements _$InviteMemberCopyWith<$Res> {
  __$InviteMemberCopyWithImpl(this._self, this._then);

  final _InviteMember _self;
  final $Res Function(_InviteMember) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? userId = null,Object? role = null,}) {
  return _then(_InviteMember(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as GroupRole,
  ));
}


}

/// @nodoc


class _AcceptInvitation implements GroupEvent {
  const _AcceptInvitation({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptInvitationCopyWith<_AcceptInvitation> get copyWith => __$AcceptInvitationCopyWithImpl<_AcceptInvitation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptInvitation&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupEvent.acceptInvitation(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$AcceptInvitationCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$AcceptInvitationCopyWith(_AcceptInvitation value, $Res Function(_AcceptInvitation) _then) = __$AcceptInvitationCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$AcceptInvitationCopyWithImpl<$Res>
    implements _$AcceptInvitationCopyWith<$Res> {
  __$AcceptInvitationCopyWithImpl(this._self, this._then);

  final _AcceptInvitation _self;
  final $Res Function(_AcceptInvitation) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_AcceptInvitation(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeclineInvitation implements GroupEvent {
  const _DeclineInvitation({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclineInvitationCopyWith<_DeclineInvitation> get copyWith => __$DeclineInvitationCopyWithImpl<_DeclineInvitation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclineInvitation&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupEvent.declineInvitation(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$DeclineInvitationCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$DeclineInvitationCopyWith(_DeclineInvitation value, $Res Function(_DeclineInvitation) _then) = __$DeclineInvitationCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$DeclineInvitationCopyWithImpl<$Res>
    implements _$DeclineInvitationCopyWith<$Res> {
  __$DeclineInvitationCopyWithImpl(this._self, this._then);

  final _DeclineInvitation _self;
  final $Res Function(_DeclineInvitation) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_DeclineInvitation(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RemoveMember implements GroupEvent {
  const _RemoveMember({required this.groupId, required this.memberId});
  

 final  String groupId;
 final  String memberId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveMemberCopyWith<_RemoveMember> get copyWith => __$RemoveMemberCopyWithImpl<_RemoveMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveMember&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.memberId, memberId) || other.memberId == memberId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,memberId);

@override
String toString() {
  return 'GroupEvent.removeMember(groupId: $groupId, memberId: $memberId)';
}


}

/// @nodoc
abstract mixin class _$RemoveMemberCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$RemoveMemberCopyWith(_RemoveMember value, $Res Function(_RemoveMember) _then) = __$RemoveMemberCopyWithImpl;
@useResult
$Res call({
 String groupId, String memberId
});




}
/// @nodoc
class __$RemoveMemberCopyWithImpl<$Res>
    implements _$RemoveMemberCopyWith<$Res> {
  __$RemoveMemberCopyWithImpl(this._self, this._then);

  final _RemoveMember _self;
  final $Res Function(_RemoveMember) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? memberId = null,}) {
  return _then(_RemoveMember(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateMemberRole implements GroupEvent {
  const _UpdateMemberRole({required this.groupId, required this.memberId, required this.role});
  

 final  String groupId;
 final  String memberId;
 final  GroupRole role;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateMemberRoleCopyWith<_UpdateMemberRole> get copyWith => __$UpdateMemberRoleCopyWithImpl<_UpdateMemberRole>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateMemberRole&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,memberId,role);

@override
String toString() {
  return 'GroupEvent.updateMemberRole(groupId: $groupId, memberId: $memberId, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UpdateMemberRoleCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$UpdateMemberRoleCopyWith(_UpdateMemberRole value, $Res Function(_UpdateMemberRole) _then) = __$UpdateMemberRoleCopyWithImpl;
@useResult
$Res call({
 String groupId, String memberId, GroupRole role
});




}
/// @nodoc
class __$UpdateMemberRoleCopyWithImpl<$Res>
    implements _$UpdateMemberRoleCopyWith<$Res> {
  __$UpdateMemberRoleCopyWithImpl(this._self, this._then);

  final _UpdateMemberRole _self;
  final $Res Function(_UpdateMemberRole) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? memberId = null,Object? role = null,}) {
  return _then(_UpdateMemberRole(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as GroupRole,
  ));
}


}

/// @nodoc


class _LeaveGroup implements GroupEvent {
  const _LeaveGroup({required this.groupId});
  

 final  String groupId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveGroupCopyWith<_LeaveGroup> get copyWith => __$LeaveGroupCopyWithImpl<_LeaveGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveGroup&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GroupEvent.leaveGroup(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$LeaveGroupCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$LeaveGroupCopyWith(_LeaveGroup value, $Res Function(_LeaveGroup) _then) = __$LeaveGroupCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$LeaveGroupCopyWithImpl<$Res>
    implements _$LeaveGroupCopyWith<$Res> {
  __$LeaveGroupCopyWithImpl(this._self, this._then);

  final _LeaveGroup _self;
  final $Res Function(_LeaveGroup) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_LeaveGroup(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadPendingInvitations implements GroupEvent {
  const _LoadPendingInvitations();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadPendingInvitations);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupEvent.loadPendingInvitations()';
}


}




/// @nodoc


class _ContributeToGroup implements GroupEvent {
  const _ContributeToGroup({required this.groupId, required this.amount, this.description});
  

 final  String groupId;
 final  int amount;
 final  String? description;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContributeToGroupCopyWith<_ContributeToGroup> get copyWith => __$ContributeToGroupCopyWithImpl<_ContributeToGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContributeToGroup&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,amount,description);

@override
String toString() {
  return 'GroupEvent.contributeToGroup(groupId: $groupId, amount: $amount, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ContributeToGroupCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$ContributeToGroupCopyWith(_ContributeToGroup value, $Res Function(_ContributeToGroup) _then) = __$ContributeToGroupCopyWithImpl;
@useResult
$Res call({
 String groupId, int amount, String? description
});




}
/// @nodoc
class __$ContributeToGroupCopyWithImpl<$Res>
    implements _$ContributeToGroupCopyWith<$Res> {
  __$ContributeToGroupCopyWithImpl(this._self, this._then);

  final _ContributeToGroup _self;
  final $Res Function(_ContributeToGroup) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? amount = null,Object? description = freezed,}) {
  return _then(_ContributeToGroup(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _WithdrawFromGroup implements GroupEvent {
  const _WithdrawFromGroup({required this.groupId, required this.amount, this.description});
  

 final  String groupId;
 final  int amount;
 final  String? description;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawFromGroupCopyWith<_WithdrawFromGroup> get copyWith => __$WithdrawFromGroupCopyWithImpl<_WithdrawFromGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawFromGroup&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,amount,description);

@override
String toString() {
  return 'GroupEvent.withdrawFromGroup(groupId: $groupId, amount: $amount, description: $description)';
}


}

/// @nodoc
abstract mixin class _$WithdrawFromGroupCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$WithdrawFromGroupCopyWith(_WithdrawFromGroup value, $Res Function(_WithdrawFromGroup) _then) = __$WithdrawFromGroupCopyWithImpl;
@useResult
$Res call({
 String groupId, int amount, String? description
});




}
/// @nodoc
class __$WithdrawFromGroupCopyWithImpl<$Res>
    implements _$WithdrawFromGroupCopyWith<$Res> {
  __$WithdrawFromGroupCopyWithImpl(this._self, this._then);

  final _WithdrawFromGroup _self;
  final $Res Function(_WithdrawFromGroup) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? amount = null,Object? description = freezed,}) {
  return _then(_WithdrawFromGroup(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ApproveTransaction implements GroupEvent {
  const _ApproveTransaction({required this.groupId, required this.transactionId});
  

 final  String groupId;
 final  String transactionId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApproveTransactionCopyWith<_ApproveTransaction> get copyWith => __$ApproveTransactionCopyWithImpl<_ApproveTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApproveTransaction&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,transactionId);

@override
String toString() {
  return 'GroupEvent.approveTransaction(groupId: $groupId, transactionId: $transactionId)';
}


}

/// @nodoc
abstract mixin class _$ApproveTransactionCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$ApproveTransactionCopyWith(_ApproveTransaction value, $Res Function(_ApproveTransaction) _then) = __$ApproveTransactionCopyWithImpl;
@useResult
$Res call({
 String groupId, String transactionId
});




}
/// @nodoc
class __$ApproveTransactionCopyWithImpl<$Res>
    implements _$ApproveTransactionCopyWith<$Res> {
  __$ApproveTransactionCopyWithImpl(this._self, this._then);

  final _ApproveTransaction _self;
  final $Res Function(_ApproveTransaction) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? transactionId = null,}) {
  return _then(_ApproveTransaction(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RejectTransaction implements GroupEvent {
  const _RejectTransaction({required this.groupId, required this.transactionId, this.reason});
  

 final  String groupId;
 final  String transactionId;
 final  String? reason;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RejectTransactionCopyWith<_RejectTransaction> get copyWith => __$RejectTransactionCopyWithImpl<_RejectTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RejectTransaction&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,transactionId,reason);

@override
String toString() {
  return 'GroupEvent.rejectTransaction(groupId: $groupId, transactionId: $transactionId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RejectTransactionCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$RejectTransactionCopyWith(_RejectTransaction value, $Res Function(_RejectTransaction) _then) = __$RejectTransactionCopyWithImpl;
@useResult
$Res call({
 String groupId, String transactionId, String? reason
});




}
/// @nodoc
class __$RejectTransactionCopyWithImpl<$Res>
    implements _$RejectTransactionCopyWith<$Res> {
  __$RejectTransactionCopyWithImpl(this._self, this._then);

  final _RejectTransaction _self;
  final $Res Function(_RejectTransaction) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? transactionId = null,Object? reason = freezed,}) {
  return _then(_RejectTransaction(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _TriggerStokvelPayout implements GroupEvent {
  const _TriggerStokvelPayout({required this.groupId, this.recipientId});
  

 final  String groupId;
 final  String? recipientId;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TriggerStokvelPayoutCopyWith<_TriggerStokvelPayout> get copyWith => __$TriggerStokvelPayoutCopyWithImpl<_TriggerStokvelPayout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TriggerStokvelPayout&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,recipientId);

@override
String toString() {
  return 'GroupEvent.triggerStokvelPayout(groupId: $groupId, recipientId: $recipientId)';
}


}

/// @nodoc
abstract mixin class _$TriggerStokvelPayoutCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$TriggerStokvelPayoutCopyWith(_TriggerStokvelPayout value, $Res Function(_TriggerStokvelPayout) _then) = __$TriggerStokvelPayoutCopyWithImpl;
@useResult
$Res call({
 String groupId, String? recipientId
});




}
/// @nodoc
class __$TriggerStokvelPayoutCopyWithImpl<$Res>
    implements _$TriggerStokvelPayoutCopyWith<$Res> {
  __$TriggerStokvelPayoutCopyWithImpl(this._self, this._then);

  final _TriggerStokvelPayout _self;
  final $Res Function(_TriggerStokvelPayout) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? recipientId = freezed,}) {
  return _then(_TriggerStokvelPayout(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadStokvelAnalytics implements GroupEvent {
  const _LoadStokvelAnalytics({required this.groupId, this.months});
  

 final  String groupId;
 final  int? months;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadStokvelAnalyticsCopyWith<_LoadStokvelAnalytics> get copyWith => __$LoadStokvelAnalyticsCopyWithImpl<_LoadStokvelAnalytics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadStokvelAnalytics&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.months, months) || other.months == months));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,months);

@override
String toString() {
  return 'GroupEvent.loadStokvelAnalytics(groupId: $groupId, months: $months)';
}


}

/// @nodoc
abstract mixin class _$LoadStokvelAnalyticsCopyWith<$Res> implements $GroupEventCopyWith<$Res> {
  factory _$LoadStokvelAnalyticsCopyWith(_LoadStokvelAnalytics value, $Res Function(_LoadStokvelAnalytics) _then) = __$LoadStokvelAnalyticsCopyWithImpl;
@useResult
$Res call({
 String groupId, int? months
});




}
/// @nodoc
class __$LoadStokvelAnalyticsCopyWithImpl<$Res>
    implements _$LoadStokvelAnalyticsCopyWith<$Res> {
  __$LoadStokvelAnalyticsCopyWithImpl(this._self, this._then);

  final _LoadStokvelAnalytics _self;
  final $Res Function(_LoadStokvelAnalytics) _then;

/// Create a copy of GroupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? months = freezed,}) {
  return _then(_LoadStokvelAnalytics(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,months: freezed == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _ClearSelectedGroup implements GroupEvent {
  const _ClearSelectedGroup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSelectedGroup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupEvent.clearSelectedGroup()';
}


}




/// @nodoc


class _ClearError implements GroupEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupEvent.clearError()';
}


}




/// @nodoc
mixin _$GroupState {

// Status
 GroupLoadingStatus get status; GroupOperationStatus get operationStatus;// Groups list
 List<Group> get groups; List<GroupMember> get pendingInvitations;// Selected group details
 Group? get selectedGroup; List<GroupMember> get selectedGroupMembers; List<GroupTransaction> get selectedGroupTransactions; List<PendingApproval> get selectedGroupApprovals;// Loading states
 bool get isLoadingMore; bool get hasMoreTransactions;// Stokvel analytics
 StokvelAnalytics? get stokvelAnalytics; bool get isLoadingAnalytics;// Error handling
 String? get errorMessage; String? get successMessage;
/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupStateCopyWith<GroupState> get copyWith => _$GroupStateCopyWithImpl<GroupState>(this as GroupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupState&&(identical(other.status, status) || other.status == status)&&(identical(other.operationStatus, operationStatus) || other.operationStatus == operationStatus)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.pendingInvitations, pendingInvitations)&&(identical(other.selectedGroup, selectedGroup) || other.selectedGroup == selectedGroup)&&const DeepCollectionEquality().equals(other.selectedGroupMembers, selectedGroupMembers)&&const DeepCollectionEquality().equals(other.selectedGroupTransactions, selectedGroupTransactions)&&const DeepCollectionEquality().equals(other.selectedGroupApprovals, selectedGroupApprovals)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMoreTransactions, hasMoreTransactions) || other.hasMoreTransactions == hasMoreTransactions)&&(identical(other.stokvelAnalytics, stokvelAnalytics) || other.stokvelAnalytics == stokvelAnalytics)&&(identical(other.isLoadingAnalytics, isLoadingAnalytics) || other.isLoadingAnalytics == isLoadingAnalytics)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,operationStatus,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(pendingInvitations),selectedGroup,const DeepCollectionEquality().hash(selectedGroupMembers),const DeepCollectionEquality().hash(selectedGroupTransactions),const DeepCollectionEquality().hash(selectedGroupApprovals),isLoadingMore,hasMoreTransactions,stokvelAnalytics,isLoadingAnalytics,errorMessage,successMessage);

@override
String toString() {
  return 'GroupState(status: $status, operationStatus: $operationStatus, groups: $groups, pendingInvitations: $pendingInvitations, selectedGroup: $selectedGroup, selectedGroupMembers: $selectedGroupMembers, selectedGroupTransactions: $selectedGroupTransactions, selectedGroupApprovals: $selectedGroupApprovals, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, stokvelAnalytics: $stokvelAnalytics, isLoadingAnalytics: $isLoadingAnalytics, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $GroupStateCopyWith<$Res>  {
  factory $GroupStateCopyWith(GroupState value, $Res Function(GroupState) _then) = _$GroupStateCopyWithImpl;
@useResult
$Res call({
 GroupLoadingStatus status, GroupOperationStatus operationStatus, List<Group> groups, List<GroupMember> pendingInvitations, Group? selectedGroup, List<GroupMember> selectedGroupMembers, List<GroupTransaction> selectedGroupTransactions, List<PendingApproval> selectedGroupApprovals, bool isLoadingMore, bool hasMoreTransactions, StokvelAnalytics? stokvelAnalytics, bool isLoadingAnalytics, String? errorMessage, String? successMessage
});


$GroupCopyWith<$Res>? get selectedGroup;

}
/// @nodoc
class _$GroupStateCopyWithImpl<$Res>
    implements $GroupStateCopyWith<$Res> {
  _$GroupStateCopyWithImpl(this._self, this._then);

  final GroupState _self;
  final $Res Function(GroupState) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? operationStatus = null,Object? groups = null,Object? pendingInvitations = null,Object? selectedGroup = freezed,Object? selectedGroupMembers = null,Object? selectedGroupTransactions = null,Object? selectedGroupApprovals = null,Object? isLoadingMore = null,Object? hasMoreTransactions = null,Object? stokvelAnalytics = freezed,Object? isLoadingAnalytics = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupLoadingStatus,operationStatus: null == operationStatus ? _self.operationStatus : operationStatus // ignore: cast_nullable_to_non_nullable
as GroupOperationStatus,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,pendingInvitations: null == pendingInvitations ? _self.pendingInvitations : pendingInvitations // ignore: cast_nullable_to_non_nullable
as List<GroupMember>,selectedGroup: freezed == selectedGroup ? _self.selectedGroup : selectedGroup // ignore: cast_nullable_to_non_nullable
as Group?,selectedGroupMembers: null == selectedGroupMembers ? _self.selectedGroupMembers : selectedGroupMembers // ignore: cast_nullable_to_non_nullable
as List<GroupMember>,selectedGroupTransactions: null == selectedGroupTransactions ? _self.selectedGroupTransactions : selectedGroupTransactions // ignore: cast_nullable_to_non_nullable
as List<GroupTransaction>,selectedGroupApprovals: null == selectedGroupApprovals ? _self.selectedGroupApprovals : selectedGroupApprovals // ignore: cast_nullable_to_non_nullable
as List<PendingApproval>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMoreTransactions: null == hasMoreTransactions ? _self.hasMoreTransactions : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
as bool,stokvelAnalytics: freezed == stokvelAnalytics ? _self.stokvelAnalytics : stokvelAnalytics // ignore: cast_nullable_to_non_nullable
as StokvelAnalytics?,isLoadingAnalytics: null == isLoadingAnalytics ? _self.isLoadingAnalytics : isLoadingAnalytics // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res>? get selectedGroup {
    if (_self.selectedGroup == null) {
    return null;
  }

  return $GroupCopyWith<$Res>(_self.selectedGroup!, (value) {
    return _then(_self.copyWith(selectedGroup: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupState].
extension GroupStatePatterns on GroupState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupState value)  $default,){
final _that = this;
switch (_that) {
case _GroupState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GroupLoadingStatus status,  GroupOperationStatus operationStatus,  List<Group> groups,  List<GroupMember> pendingInvitations,  Group? selectedGroup,  List<GroupMember> selectedGroupMembers,  List<GroupTransaction> selectedGroupTransactions,  List<PendingApproval> selectedGroupApprovals,  bool isLoadingMore,  bool hasMoreTransactions,  StokvelAnalytics? stokvelAnalytics,  bool isLoadingAnalytics,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that.status,_that.operationStatus,_that.groups,_that.pendingInvitations,_that.selectedGroup,_that.selectedGroupMembers,_that.selectedGroupTransactions,_that.selectedGroupApprovals,_that.isLoadingMore,_that.hasMoreTransactions,_that.stokvelAnalytics,_that.isLoadingAnalytics,_that.errorMessage,_that.successMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GroupLoadingStatus status,  GroupOperationStatus operationStatus,  List<Group> groups,  List<GroupMember> pendingInvitations,  Group? selectedGroup,  List<GroupMember> selectedGroupMembers,  List<GroupTransaction> selectedGroupTransactions,  List<PendingApproval> selectedGroupApprovals,  bool isLoadingMore,  bool hasMoreTransactions,  StokvelAnalytics? stokvelAnalytics,  bool isLoadingAnalytics,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _GroupState():
return $default(_that.status,_that.operationStatus,_that.groups,_that.pendingInvitations,_that.selectedGroup,_that.selectedGroupMembers,_that.selectedGroupTransactions,_that.selectedGroupApprovals,_that.isLoadingMore,_that.hasMoreTransactions,_that.stokvelAnalytics,_that.isLoadingAnalytics,_that.errorMessage,_that.successMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GroupLoadingStatus status,  GroupOperationStatus operationStatus,  List<Group> groups,  List<GroupMember> pendingInvitations,  Group? selectedGroup,  List<GroupMember> selectedGroupMembers,  List<GroupTransaction> selectedGroupTransactions,  List<PendingApproval> selectedGroupApprovals,  bool isLoadingMore,  bool hasMoreTransactions,  StokvelAnalytics? stokvelAnalytics,  bool isLoadingAnalytics,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that.status,_that.operationStatus,_that.groups,_that.pendingInvitations,_that.selectedGroup,_that.selectedGroupMembers,_that.selectedGroupTransactions,_that.selectedGroupApprovals,_that.isLoadingMore,_that.hasMoreTransactions,_that.stokvelAnalytics,_that.isLoadingAnalytics,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GroupState extends GroupState {
  const _GroupState({this.status = GroupLoadingStatus.initial, this.operationStatus = GroupOperationStatus.idle, final  List<Group> groups = const [], final  List<GroupMember> pendingInvitations = const [], this.selectedGroup, final  List<GroupMember> selectedGroupMembers = const [], final  List<GroupTransaction> selectedGroupTransactions = const [], final  List<PendingApproval> selectedGroupApprovals = const [], this.isLoadingMore = false, this.hasMoreTransactions = false, this.stokvelAnalytics, this.isLoadingAnalytics = false, this.errorMessage, this.successMessage}): _groups = groups,_pendingInvitations = pendingInvitations,_selectedGroupMembers = selectedGroupMembers,_selectedGroupTransactions = selectedGroupTransactions,_selectedGroupApprovals = selectedGroupApprovals,super._();
  

// Status
@override@JsonKey() final  GroupLoadingStatus status;
@override@JsonKey() final  GroupOperationStatus operationStatus;
// Groups list
 final  List<Group> _groups;
// Groups list
@override@JsonKey() List<Group> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<GroupMember> _pendingInvitations;
@override@JsonKey() List<GroupMember> get pendingInvitations {
  if (_pendingInvitations is EqualUnmodifiableListView) return _pendingInvitations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingInvitations);
}

// Selected group details
@override final  Group? selectedGroup;
 final  List<GroupMember> _selectedGroupMembers;
@override@JsonKey() List<GroupMember> get selectedGroupMembers {
  if (_selectedGroupMembers is EqualUnmodifiableListView) return _selectedGroupMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedGroupMembers);
}

 final  List<GroupTransaction> _selectedGroupTransactions;
@override@JsonKey() List<GroupTransaction> get selectedGroupTransactions {
  if (_selectedGroupTransactions is EqualUnmodifiableListView) return _selectedGroupTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedGroupTransactions);
}

 final  List<PendingApproval> _selectedGroupApprovals;
@override@JsonKey() List<PendingApproval> get selectedGroupApprovals {
  if (_selectedGroupApprovals is EqualUnmodifiableListView) return _selectedGroupApprovals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedGroupApprovals);
}

// Loading states
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMoreTransactions;
// Stokvel analytics
@override final  StokvelAnalytics? stokvelAnalytics;
@override@JsonKey() final  bool isLoadingAnalytics;
// Error handling
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupStateCopyWith<_GroupState> get copyWith => __$GroupStateCopyWithImpl<_GroupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupState&&(identical(other.status, status) || other.status == status)&&(identical(other.operationStatus, operationStatus) || other.operationStatus == operationStatus)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._pendingInvitations, _pendingInvitations)&&(identical(other.selectedGroup, selectedGroup) || other.selectedGroup == selectedGroup)&&const DeepCollectionEquality().equals(other._selectedGroupMembers, _selectedGroupMembers)&&const DeepCollectionEquality().equals(other._selectedGroupTransactions, _selectedGroupTransactions)&&const DeepCollectionEquality().equals(other._selectedGroupApprovals, _selectedGroupApprovals)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMoreTransactions, hasMoreTransactions) || other.hasMoreTransactions == hasMoreTransactions)&&(identical(other.stokvelAnalytics, stokvelAnalytics) || other.stokvelAnalytics == stokvelAnalytics)&&(identical(other.isLoadingAnalytics, isLoadingAnalytics) || other.isLoadingAnalytics == isLoadingAnalytics)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,operationStatus,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_pendingInvitations),selectedGroup,const DeepCollectionEquality().hash(_selectedGroupMembers),const DeepCollectionEquality().hash(_selectedGroupTransactions),const DeepCollectionEquality().hash(_selectedGroupApprovals),isLoadingMore,hasMoreTransactions,stokvelAnalytics,isLoadingAnalytics,errorMessage,successMessage);

@override
String toString() {
  return 'GroupState(status: $status, operationStatus: $operationStatus, groups: $groups, pendingInvitations: $pendingInvitations, selectedGroup: $selectedGroup, selectedGroupMembers: $selectedGroupMembers, selectedGroupTransactions: $selectedGroupTransactions, selectedGroupApprovals: $selectedGroupApprovals, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, stokvelAnalytics: $stokvelAnalytics, isLoadingAnalytics: $isLoadingAnalytics, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$GroupStateCopyWith<$Res> implements $GroupStateCopyWith<$Res> {
  factory _$GroupStateCopyWith(_GroupState value, $Res Function(_GroupState) _then) = __$GroupStateCopyWithImpl;
@override @useResult
$Res call({
 GroupLoadingStatus status, GroupOperationStatus operationStatus, List<Group> groups, List<GroupMember> pendingInvitations, Group? selectedGroup, List<GroupMember> selectedGroupMembers, List<GroupTransaction> selectedGroupTransactions, List<PendingApproval> selectedGroupApprovals, bool isLoadingMore, bool hasMoreTransactions, StokvelAnalytics? stokvelAnalytics, bool isLoadingAnalytics, String? errorMessage, String? successMessage
});


@override $GroupCopyWith<$Res>? get selectedGroup;

}
/// @nodoc
class __$GroupStateCopyWithImpl<$Res>
    implements _$GroupStateCopyWith<$Res> {
  __$GroupStateCopyWithImpl(this._self, this._then);

  final _GroupState _self;
  final $Res Function(_GroupState) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? operationStatus = null,Object? groups = null,Object? pendingInvitations = null,Object? selectedGroup = freezed,Object? selectedGroupMembers = null,Object? selectedGroupTransactions = null,Object? selectedGroupApprovals = null,Object? isLoadingMore = null,Object? hasMoreTransactions = null,Object? stokvelAnalytics = freezed,Object? isLoadingAnalytics = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_GroupState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupLoadingStatus,operationStatus: null == operationStatus ? _self.operationStatus : operationStatus // ignore: cast_nullable_to_non_nullable
as GroupOperationStatus,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,pendingInvitations: null == pendingInvitations ? _self._pendingInvitations : pendingInvitations // ignore: cast_nullable_to_non_nullable
as List<GroupMember>,selectedGroup: freezed == selectedGroup ? _self.selectedGroup : selectedGroup // ignore: cast_nullable_to_non_nullable
as Group?,selectedGroupMembers: null == selectedGroupMembers ? _self._selectedGroupMembers : selectedGroupMembers // ignore: cast_nullable_to_non_nullable
as List<GroupMember>,selectedGroupTransactions: null == selectedGroupTransactions ? _self._selectedGroupTransactions : selectedGroupTransactions // ignore: cast_nullable_to_non_nullable
as List<GroupTransaction>,selectedGroupApprovals: null == selectedGroupApprovals ? _self._selectedGroupApprovals : selectedGroupApprovals // ignore: cast_nullable_to_non_nullable
as List<PendingApproval>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMoreTransactions: null == hasMoreTransactions ? _self.hasMoreTransactions : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
as bool,stokvelAnalytics: freezed == stokvelAnalytics ? _self.stokvelAnalytics : stokvelAnalytics // ignore: cast_nullable_to_non_nullable
as StokvelAnalytics?,isLoadingAnalytics: null == isLoadingAnalytics ? _self.isLoadingAnalytics : isLoadingAnalytics // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res>? get selectedGroup {
    if (_self.selectedGroup == null) {
    return null;
  }

  return $GroupCopyWith<$Res>(_self.selectedGroup!, (value) {
    return _then(_self.copyWith(selectedGroup: value));
  });
}
}

// dart format on
