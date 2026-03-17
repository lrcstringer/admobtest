// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityEvent()';
}


}

/// @nodoc
class $CommunityEventCopyWith<$Res>  {
$CommunityEventCopyWith(CommunityEvent _, $Res Function(CommunityEvent) __);
}


/// Adds pattern-matching-related methods to [CommunityEvent].
extension CommunityEventPatterns on CommunityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadUserCommunities value)?  loadUserCommunities,TResult Function( _WatchUserCommunities value)?  watchUserCommunities,TResult Function( _UserCommunitiesUpdated value)?  userCommunitiesUpdated,TResult Function( _LoadCommunityDetails value)?  loadCommunityDetails,TResult Function( _WatchMembers value)?  watchMembers,TResult Function( _MembersUpdated value)?  membersUpdated,TResult Function( _WatchTransactions value)?  watchTransactions,TResult Function( _TransactionsUpdated value)?  transactionsUpdated,TResult Function( _WatchPendingApprovals value)?  watchPendingApprovals,TResult Function( _PendingApprovalsUpdated value)?  pendingApprovalsUpdated,TResult Function( _CreateCommunity value)?  createCommunity,TResult Function( _UpdateCommunity value)?  updateCommunity,TResult Function( _DeleteCommunity value)?  deleteCommunity,TResult Function( _InviteMember value)?  inviteMember,TResult Function( _AcceptInvitation value)?  acceptInvitation,TResult Function( _DeclineInvitation value)?  declineInvitation,TResult Function( _RemoveMember value)?  removeMember,TResult Function( _UpdateMemberRole value)?  updateMemberRole,TResult Function( _LeaveCommunity value)?  leaveCommunity,TResult Function( _LoadPendingInvitations value)?  loadPendingInvitations,TResult Function( _Contribute value)?  contribute,TResult Function( _Withdraw value)?  withdraw,TResult Function( _ApproveTransaction value)?  approveTransaction,TResult Function( _RejectTransaction value)?  rejectTransaction,TResult Function( _TriggerPayout value)?  triggerPayout,TResult Function( _LoadAnalytics value)?  loadAnalytics,TResult Function( _UnreadCountUpdated value)?  unreadCountUpdated,TResult Function( _ClearSelectedCommunity value)?  clearSelectedCommunity,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadUserCommunities() when loadUserCommunities != null:
return loadUserCommunities(_that);case _WatchUserCommunities() when watchUserCommunities != null:
return watchUserCommunities(_that);case _UserCommunitiesUpdated() when userCommunitiesUpdated != null:
return userCommunitiesUpdated(_that);case _LoadCommunityDetails() when loadCommunityDetails != null:
return loadCommunityDetails(_that);case _WatchMembers() when watchMembers != null:
return watchMembers(_that);case _MembersUpdated() when membersUpdated != null:
return membersUpdated(_that);case _WatchTransactions() when watchTransactions != null:
return watchTransactions(_that);case _TransactionsUpdated() when transactionsUpdated != null:
return transactionsUpdated(_that);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that);case _CreateCommunity() when createCommunity != null:
return createCommunity(_that);case _UpdateCommunity() when updateCommunity != null:
return updateCommunity(_that);case _DeleteCommunity() when deleteCommunity != null:
return deleteCommunity(_that);case _InviteMember() when inviteMember != null:
return inviteMember(_that);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that);case _RemoveMember() when removeMember != null:
return removeMember(_that);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that);case _LeaveCommunity() when leaveCommunity != null:
return leaveCommunity(_that);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations(_that);case _Contribute() when contribute != null:
return contribute(_that);case _Withdraw() when withdraw != null:
return withdraw(_that);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that);case _TriggerPayout() when triggerPayout != null:
return triggerPayout(_that);case _LoadAnalytics() when loadAnalytics != null:
return loadAnalytics(_that);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that);case _ClearSelectedCommunity() when clearSelectedCommunity != null:
return clearSelectedCommunity(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadUserCommunities value)  loadUserCommunities,required TResult Function( _WatchUserCommunities value)  watchUserCommunities,required TResult Function( _UserCommunitiesUpdated value)  userCommunitiesUpdated,required TResult Function( _LoadCommunityDetails value)  loadCommunityDetails,required TResult Function( _WatchMembers value)  watchMembers,required TResult Function( _MembersUpdated value)  membersUpdated,required TResult Function( _WatchTransactions value)  watchTransactions,required TResult Function( _TransactionsUpdated value)  transactionsUpdated,required TResult Function( _WatchPendingApprovals value)  watchPendingApprovals,required TResult Function( _PendingApprovalsUpdated value)  pendingApprovalsUpdated,required TResult Function( _CreateCommunity value)  createCommunity,required TResult Function( _UpdateCommunity value)  updateCommunity,required TResult Function( _DeleteCommunity value)  deleteCommunity,required TResult Function( _InviteMember value)  inviteMember,required TResult Function( _AcceptInvitation value)  acceptInvitation,required TResult Function( _DeclineInvitation value)  declineInvitation,required TResult Function( _RemoveMember value)  removeMember,required TResult Function( _UpdateMemberRole value)  updateMemberRole,required TResult Function( _LeaveCommunity value)  leaveCommunity,required TResult Function( _LoadPendingInvitations value)  loadPendingInvitations,required TResult Function( _Contribute value)  contribute,required TResult Function( _Withdraw value)  withdraw,required TResult Function( _ApproveTransaction value)  approveTransaction,required TResult Function( _RejectTransaction value)  rejectTransaction,required TResult Function( _TriggerPayout value)  triggerPayout,required TResult Function( _LoadAnalytics value)  loadAnalytics,required TResult Function( _UnreadCountUpdated value)  unreadCountUpdated,required TResult Function( _ClearSelectedCommunity value)  clearSelectedCommunity,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _LoadUserCommunities():
return loadUserCommunities(_that);case _WatchUserCommunities():
return watchUserCommunities(_that);case _UserCommunitiesUpdated():
return userCommunitiesUpdated(_that);case _LoadCommunityDetails():
return loadCommunityDetails(_that);case _WatchMembers():
return watchMembers(_that);case _MembersUpdated():
return membersUpdated(_that);case _WatchTransactions():
return watchTransactions(_that);case _TransactionsUpdated():
return transactionsUpdated(_that);case _WatchPendingApprovals():
return watchPendingApprovals(_that);case _PendingApprovalsUpdated():
return pendingApprovalsUpdated(_that);case _CreateCommunity():
return createCommunity(_that);case _UpdateCommunity():
return updateCommunity(_that);case _DeleteCommunity():
return deleteCommunity(_that);case _InviteMember():
return inviteMember(_that);case _AcceptInvitation():
return acceptInvitation(_that);case _DeclineInvitation():
return declineInvitation(_that);case _RemoveMember():
return removeMember(_that);case _UpdateMemberRole():
return updateMemberRole(_that);case _LeaveCommunity():
return leaveCommunity(_that);case _LoadPendingInvitations():
return loadPendingInvitations(_that);case _Contribute():
return contribute(_that);case _Withdraw():
return withdraw(_that);case _ApproveTransaction():
return approveTransaction(_that);case _RejectTransaction():
return rejectTransaction(_that);case _TriggerPayout():
return triggerPayout(_that);case _LoadAnalytics():
return loadAnalytics(_that);case _UnreadCountUpdated():
return unreadCountUpdated(_that);case _ClearSelectedCommunity():
return clearSelectedCommunity(_that);case _ClearError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadUserCommunities value)?  loadUserCommunities,TResult? Function( _WatchUserCommunities value)?  watchUserCommunities,TResult? Function( _UserCommunitiesUpdated value)?  userCommunitiesUpdated,TResult? Function( _LoadCommunityDetails value)?  loadCommunityDetails,TResult? Function( _WatchMembers value)?  watchMembers,TResult? Function( _MembersUpdated value)?  membersUpdated,TResult? Function( _WatchTransactions value)?  watchTransactions,TResult? Function( _TransactionsUpdated value)?  transactionsUpdated,TResult? Function( _WatchPendingApprovals value)?  watchPendingApprovals,TResult? Function( _PendingApprovalsUpdated value)?  pendingApprovalsUpdated,TResult? Function( _CreateCommunity value)?  createCommunity,TResult? Function( _UpdateCommunity value)?  updateCommunity,TResult? Function( _DeleteCommunity value)?  deleteCommunity,TResult? Function( _InviteMember value)?  inviteMember,TResult? Function( _AcceptInvitation value)?  acceptInvitation,TResult? Function( _DeclineInvitation value)?  declineInvitation,TResult? Function( _RemoveMember value)?  removeMember,TResult? Function( _UpdateMemberRole value)?  updateMemberRole,TResult? Function( _LeaveCommunity value)?  leaveCommunity,TResult? Function( _LoadPendingInvitations value)?  loadPendingInvitations,TResult? Function( _Contribute value)?  contribute,TResult? Function( _Withdraw value)?  withdraw,TResult? Function( _ApproveTransaction value)?  approveTransaction,TResult? Function( _RejectTransaction value)?  rejectTransaction,TResult? Function( _TriggerPayout value)?  triggerPayout,TResult? Function( _LoadAnalytics value)?  loadAnalytics,TResult? Function( _UnreadCountUpdated value)?  unreadCountUpdated,TResult? Function( _ClearSelectedCommunity value)?  clearSelectedCommunity,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _LoadUserCommunities() when loadUserCommunities != null:
return loadUserCommunities(_that);case _WatchUserCommunities() when watchUserCommunities != null:
return watchUserCommunities(_that);case _UserCommunitiesUpdated() when userCommunitiesUpdated != null:
return userCommunitiesUpdated(_that);case _LoadCommunityDetails() when loadCommunityDetails != null:
return loadCommunityDetails(_that);case _WatchMembers() when watchMembers != null:
return watchMembers(_that);case _MembersUpdated() when membersUpdated != null:
return membersUpdated(_that);case _WatchTransactions() when watchTransactions != null:
return watchTransactions(_that);case _TransactionsUpdated() when transactionsUpdated != null:
return transactionsUpdated(_that);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that);case _CreateCommunity() when createCommunity != null:
return createCommunity(_that);case _UpdateCommunity() when updateCommunity != null:
return updateCommunity(_that);case _DeleteCommunity() when deleteCommunity != null:
return deleteCommunity(_that);case _InviteMember() when inviteMember != null:
return inviteMember(_that);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that);case _RemoveMember() when removeMember != null:
return removeMember(_that);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that);case _LeaveCommunity() when leaveCommunity != null:
return leaveCommunity(_that);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations(_that);case _Contribute() when contribute != null:
return contribute(_that);case _Withdraw() when withdraw != null:
return withdraw(_that);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that);case _TriggerPayout() when triggerPayout != null:
return triggerPayout(_that);case _LoadAnalytics() when loadAnalytics != null:
return loadAnalytics(_that);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that);case _ClearSelectedCommunity() when clearSelectedCommunity != null:
return clearSelectedCommunity(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadUserCommunities,TResult Function()?  watchUserCommunities,TResult Function( List<Community> communities)?  userCommunitiesUpdated,TResult Function( String communityId)?  loadCommunityDetails,TResult Function( String communityId)?  watchMembers,TResult Function( List<CommunityMember> members)?  membersUpdated,TResult Function( String communityId,  int? limit)?  watchTransactions,TResult Function( List<CommunityTransaction> transactions)?  transactionsUpdated,TResult Function( String communityId)?  watchPendingApprovals,TResult Function( List<CommunityApproval> approvals)?  pendingApprovalsUpdated,TResult Function( CreateCommunityParams params)?  createCommunity,TResult Function( String communityId,  UpdateCommunityParams params)?  updateCommunity,TResult Function( String communityId)?  deleteCommunity,TResult Function( String communityId,  String userId,  MemberRole role)?  inviteMember,TResult Function( String communityId)?  acceptInvitation,TResult Function( String communityId)?  declineInvitation,TResult Function( String communityId,  String memberId)?  removeMember,TResult Function( String communityId,  String memberId,  MemberRole role)?  updateMemberRole,TResult Function( String communityId)?  leaveCommunity,TResult Function()?  loadPendingInvitations,TResult Function( String communityId,  int amount,  String? description)?  contribute,TResult Function( String communityId,  int amount,  String? description)?  withdraw,TResult Function( String communityId,  String transactionId)?  approveTransaction,TResult Function( String communityId,  String transactionId,  String? reason)?  rejectTransaction,TResult Function( String communityId,  String? recipientId)?  triggerPayout,TResult Function( String communityId,  int? months)?  loadAnalytics,TResult Function( int count)?  unreadCountUpdated,TResult Function()?  clearSelectedCommunity,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadUserCommunities() when loadUserCommunities != null:
return loadUserCommunities();case _WatchUserCommunities() when watchUserCommunities != null:
return watchUserCommunities();case _UserCommunitiesUpdated() when userCommunitiesUpdated != null:
return userCommunitiesUpdated(_that.communities);case _LoadCommunityDetails() when loadCommunityDetails != null:
return loadCommunityDetails(_that.communityId);case _WatchMembers() when watchMembers != null:
return watchMembers(_that.communityId);case _MembersUpdated() when membersUpdated != null:
return membersUpdated(_that.members);case _WatchTransactions() when watchTransactions != null:
return watchTransactions(_that.communityId,_that.limit);case _TransactionsUpdated() when transactionsUpdated != null:
return transactionsUpdated(_that.transactions);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that.communityId);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that.approvals);case _CreateCommunity() when createCommunity != null:
return createCommunity(_that.params);case _UpdateCommunity() when updateCommunity != null:
return updateCommunity(_that.communityId,_that.params);case _DeleteCommunity() when deleteCommunity != null:
return deleteCommunity(_that.communityId);case _InviteMember() when inviteMember != null:
return inviteMember(_that.communityId,_that.userId,_that.role);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that.communityId);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that.communityId);case _RemoveMember() when removeMember != null:
return removeMember(_that.communityId,_that.memberId);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that.communityId,_that.memberId,_that.role);case _LeaveCommunity() when leaveCommunity != null:
return leaveCommunity(_that.communityId);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations();case _Contribute() when contribute != null:
return contribute(_that.communityId,_that.amount,_that.description);case _Withdraw() when withdraw != null:
return withdraw(_that.communityId,_that.amount,_that.description);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that.communityId,_that.transactionId);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that.communityId,_that.transactionId,_that.reason);case _TriggerPayout() when triggerPayout != null:
return triggerPayout(_that.communityId,_that.recipientId);case _LoadAnalytics() when loadAnalytics != null:
return loadAnalytics(_that.communityId,_that.months);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that.count);case _ClearSelectedCommunity() when clearSelectedCommunity != null:
return clearSelectedCommunity();case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadUserCommunities,required TResult Function()  watchUserCommunities,required TResult Function( List<Community> communities)  userCommunitiesUpdated,required TResult Function( String communityId)  loadCommunityDetails,required TResult Function( String communityId)  watchMembers,required TResult Function( List<CommunityMember> members)  membersUpdated,required TResult Function( String communityId,  int? limit)  watchTransactions,required TResult Function( List<CommunityTransaction> transactions)  transactionsUpdated,required TResult Function( String communityId)  watchPendingApprovals,required TResult Function( List<CommunityApproval> approvals)  pendingApprovalsUpdated,required TResult Function( CreateCommunityParams params)  createCommunity,required TResult Function( String communityId,  UpdateCommunityParams params)  updateCommunity,required TResult Function( String communityId)  deleteCommunity,required TResult Function( String communityId,  String userId,  MemberRole role)  inviteMember,required TResult Function( String communityId)  acceptInvitation,required TResult Function( String communityId)  declineInvitation,required TResult Function( String communityId,  String memberId)  removeMember,required TResult Function( String communityId,  String memberId,  MemberRole role)  updateMemberRole,required TResult Function( String communityId)  leaveCommunity,required TResult Function()  loadPendingInvitations,required TResult Function( String communityId,  int amount,  String? description)  contribute,required TResult Function( String communityId,  int amount,  String? description)  withdraw,required TResult Function( String communityId,  String transactionId)  approveTransaction,required TResult Function( String communityId,  String transactionId,  String? reason)  rejectTransaction,required TResult Function( String communityId,  String? recipientId)  triggerPayout,required TResult Function( String communityId,  int? months)  loadAnalytics,required TResult Function( int count)  unreadCountUpdated,required TResult Function()  clearSelectedCommunity,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _LoadUserCommunities():
return loadUserCommunities();case _WatchUserCommunities():
return watchUserCommunities();case _UserCommunitiesUpdated():
return userCommunitiesUpdated(_that.communities);case _LoadCommunityDetails():
return loadCommunityDetails(_that.communityId);case _WatchMembers():
return watchMembers(_that.communityId);case _MembersUpdated():
return membersUpdated(_that.members);case _WatchTransactions():
return watchTransactions(_that.communityId,_that.limit);case _TransactionsUpdated():
return transactionsUpdated(_that.transactions);case _WatchPendingApprovals():
return watchPendingApprovals(_that.communityId);case _PendingApprovalsUpdated():
return pendingApprovalsUpdated(_that.approvals);case _CreateCommunity():
return createCommunity(_that.params);case _UpdateCommunity():
return updateCommunity(_that.communityId,_that.params);case _DeleteCommunity():
return deleteCommunity(_that.communityId);case _InviteMember():
return inviteMember(_that.communityId,_that.userId,_that.role);case _AcceptInvitation():
return acceptInvitation(_that.communityId);case _DeclineInvitation():
return declineInvitation(_that.communityId);case _RemoveMember():
return removeMember(_that.communityId,_that.memberId);case _UpdateMemberRole():
return updateMemberRole(_that.communityId,_that.memberId,_that.role);case _LeaveCommunity():
return leaveCommunity(_that.communityId);case _LoadPendingInvitations():
return loadPendingInvitations();case _Contribute():
return contribute(_that.communityId,_that.amount,_that.description);case _Withdraw():
return withdraw(_that.communityId,_that.amount,_that.description);case _ApproveTransaction():
return approveTransaction(_that.communityId,_that.transactionId);case _RejectTransaction():
return rejectTransaction(_that.communityId,_that.transactionId,_that.reason);case _TriggerPayout():
return triggerPayout(_that.communityId,_that.recipientId);case _LoadAnalytics():
return loadAnalytics(_that.communityId,_that.months);case _UnreadCountUpdated():
return unreadCountUpdated(_that.count);case _ClearSelectedCommunity():
return clearSelectedCommunity();case _ClearError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadUserCommunities,TResult? Function()?  watchUserCommunities,TResult? Function( List<Community> communities)?  userCommunitiesUpdated,TResult? Function( String communityId)?  loadCommunityDetails,TResult? Function( String communityId)?  watchMembers,TResult? Function( List<CommunityMember> members)?  membersUpdated,TResult? Function( String communityId,  int? limit)?  watchTransactions,TResult? Function( List<CommunityTransaction> transactions)?  transactionsUpdated,TResult? Function( String communityId)?  watchPendingApprovals,TResult? Function( List<CommunityApproval> approvals)?  pendingApprovalsUpdated,TResult? Function( CreateCommunityParams params)?  createCommunity,TResult? Function( String communityId,  UpdateCommunityParams params)?  updateCommunity,TResult? Function( String communityId)?  deleteCommunity,TResult? Function( String communityId,  String userId,  MemberRole role)?  inviteMember,TResult? Function( String communityId)?  acceptInvitation,TResult? Function( String communityId)?  declineInvitation,TResult? Function( String communityId,  String memberId)?  removeMember,TResult? Function( String communityId,  String memberId,  MemberRole role)?  updateMemberRole,TResult? Function( String communityId)?  leaveCommunity,TResult? Function()?  loadPendingInvitations,TResult? Function( String communityId,  int amount,  String? description)?  contribute,TResult? Function( String communityId,  int amount,  String? description)?  withdraw,TResult? Function( String communityId,  String transactionId)?  approveTransaction,TResult? Function( String communityId,  String transactionId,  String? reason)?  rejectTransaction,TResult? Function( String communityId,  String? recipientId)?  triggerPayout,TResult? Function( String communityId,  int? months)?  loadAnalytics,TResult? Function( int count)?  unreadCountUpdated,TResult? Function()?  clearSelectedCommunity,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _LoadUserCommunities() when loadUserCommunities != null:
return loadUserCommunities();case _WatchUserCommunities() when watchUserCommunities != null:
return watchUserCommunities();case _UserCommunitiesUpdated() when userCommunitiesUpdated != null:
return userCommunitiesUpdated(_that.communities);case _LoadCommunityDetails() when loadCommunityDetails != null:
return loadCommunityDetails(_that.communityId);case _WatchMembers() when watchMembers != null:
return watchMembers(_that.communityId);case _MembersUpdated() when membersUpdated != null:
return membersUpdated(_that.members);case _WatchTransactions() when watchTransactions != null:
return watchTransactions(_that.communityId,_that.limit);case _TransactionsUpdated() when transactionsUpdated != null:
return transactionsUpdated(_that.transactions);case _WatchPendingApprovals() when watchPendingApprovals != null:
return watchPendingApprovals(_that.communityId);case _PendingApprovalsUpdated() when pendingApprovalsUpdated != null:
return pendingApprovalsUpdated(_that.approvals);case _CreateCommunity() when createCommunity != null:
return createCommunity(_that.params);case _UpdateCommunity() when updateCommunity != null:
return updateCommunity(_that.communityId,_that.params);case _DeleteCommunity() when deleteCommunity != null:
return deleteCommunity(_that.communityId);case _InviteMember() when inviteMember != null:
return inviteMember(_that.communityId,_that.userId,_that.role);case _AcceptInvitation() when acceptInvitation != null:
return acceptInvitation(_that.communityId);case _DeclineInvitation() when declineInvitation != null:
return declineInvitation(_that.communityId);case _RemoveMember() when removeMember != null:
return removeMember(_that.communityId,_that.memberId);case _UpdateMemberRole() when updateMemberRole != null:
return updateMemberRole(_that.communityId,_that.memberId,_that.role);case _LeaveCommunity() when leaveCommunity != null:
return leaveCommunity(_that.communityId);case _LoadPendingInvitations() when loadPendingInvitations != null:
return loadPendingInvitations();case _Contribute() when contribute != null:
return contribute(_that.communityId,_that.amount,_that.description);case _Withdraw() when withdraw != null:
return withdraw(_that.communityId,_that.amount,_that.description);case _ApproveTransaction() when approveTransaction != null:
return approveTransaction(_that.communityId,_that.transactionId);case _RejectTransaction() when rejectTransaction != null:
return rejectTransaction(_that.communityId,_that.transactionId,_that.reason);case _TriggerPayout() when triggerPayout != null:
return triggerPayout(_that.communityId,_that.recipientId);case _LoadAnalytics() when loadAnalytics != null:
return loadAnalytics(_that.communityId,_that.months);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that.count);case _ClearSelectedCommunity() when clearSelectedCommunity != null:
return clearSelectedCommunity();case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _LoadUserCommunities implements CommunityEvent {
  const _LoadUserCommunities();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadUserCommunities);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityEvent.loadUserCommunities()';
}


}




/// @nodoc


class _WatchUserCommunities implements CommunityEvent {
  const _WatchUserCommunities();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchUserCommunities);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityEvent.watchUserCommunities()';
}


}




/// @nodoc


class _UserCommunitiesUpdated implements CommunityEvent {
  const _UserCommunitiesUpdated(final  List<Community> communities): _communities = communities;
  

 final  List<Community> _communities;
 List<Community> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}


/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCommunitiesUpdatedCopyWith<_UserCommunitiesUpdated> get copyWith => __$UserCommunitiesUpdatedCopyWithImpl<_UserCommunitiesUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCommunitiesUpdated&&const DeepCollectionEquality().equals(other._communities, _communities));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_communities));

@override
String toString() {
  return 'CommunityEvent.userCommunitiesUpdated(communities: $communities)';
}


}

/// @nodoc
abstract mixin class _$UserCommunitiesUpdatedCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$UserCommunitiesUpdatedCopyWith(_UserCommunitiesUpdated value, $Res Function(_UserCommunitiesUpdated) _then) = __$UserCommunitiesUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Community> communities
});




}
/// @nodoc
class __$UserCommunitiesUpdatedCopyWithImpl<$Res>
    implements _$UserCommunitiesUpdatedCopyWith<$Res> {
  __$UserCommunitiesUpdatedCopyWithImpl(this._self, this._then);

  final _UserCommunitiesUpdated _self;
  final $Res Function(_UserCommunitiesUpdated) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communities = null,}) {
  return _then(_UserCommunitiesUpdated(
null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,
  ));
}


}

/// @nodoc


class _LoadCommunityDetails implements CommunityEvent {
  const _LoadCommunityDetails({required this.communityId});
  

 final  String communityId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCommunityDetailsCopyWith<_LoadCommunityDetails> get copyWith => __$LoadCommunityDetailsCopyWithImpl<_LoadCommunityDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadCommunityDetails&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'CommunityEvent.loadCommunityDetails(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$LoadCommunityDetailsCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$LoadCommunityDetailsCopyWith(_LoadCommunityDetails value, $Res Function(_LoadCommunityDetails) _then) = __$LoadCommunityDetailsCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$LoadCommunityDetailsCopyWithImpl<$Res>
    implements _$LoadCommunityDetailsCopyWith<$Res> {
  __$LoadCommunityDetailsCopyWithImpl(this._self, this._then);

  final _LoadCommunityDetails _self;
  final $Res Function(_LoadCommunityDetails) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_LoadCommunityDetails(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WatchMembers implements CommunityEvent {
  const _WatchMembers({required this.communityId});
  

 final  String communityId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchMembersCopyWith<_WatchMembers> get copyWith => __$WatchMembersCopyWithImpl<_WatchMembers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchMembers&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'CommunityEvent.watchMembers(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$WatchMembersCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$WatchMembersCopyWith(_WatchMembers value, $Res Function(_WatchMembers) _then) = __$WatchMembersCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$WatchMembersCopyWithImpl<$Res>
    implements _$WatchMembersCopyWith<$Res> {
  __$WatchMembersCopyWithImpl(this._self, this._then);

  final _WatchMembers _self;
  final $Res Function(_WatchMembers) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_WatchMembers(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MembersUpdated implements CommunityEvent {
  const _MembersUpdated(final  List<CommunityMember> members): _members = members;
  

 final  List<CommunityMember> _members;
 List<CommunityMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembersUpdatedCopyWith<_MembersUpdated> get copyWith => __$MembersUpdatedCopyWithImpl<_MembersUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembersUpdated&&const DeepCollectionEquality().equals(other._members, _members));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'CommunityEvent.membersUpdated(members: $members)';
}


}

/// @nodoc
abstract mixin class _$MembersUpdatedCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$MembersUpdatedCopyWith(_MembersUpdated value, $Res Function(_MembersUpdated) _then) = __$MembersUpdatedCopyWithImpl;
@useResult
$Res call({
 List<CommunityMember> members
});




}
/// @nodoc
class __$MembersUpdatedCopyWithImpl<$Res>
    implements _$MembersUpdatedCopyWith<$Res> {
  __$MembersUpdatedCopyWithImpl(this._self, this._then);

  final _MembersUpdated _self;
  final $Res Function(_MembersUpdated) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? members = null,}) {
  return _then(_MembersUpdated(
null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<CommunityMember>,
  ));
}


}

/// @nodoc


class _WatchTransactions implements CommunityEvent {
  const _WatchTransactions({required this.communityId, this.limit});
  

 final  String communityId;
 final  int? limit;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchTransactionsCopyWith<_WatchTransactions> get copyWith => __$WatchTransactionsCopyWithImpl<_WatchTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchTransactions&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,limit);

@override
String toString() {
  return 'CommunityEvent.watchTransactions(communityId: $communityId, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$WatchTransactionsCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$WatchTransactionsCopyWith(_WatchTransactions value, $Res Function(_WatchTransactions) _then) = __$WatchTransactionsCopyWithImpl;
@useResult
$Res call({
 String communityId, int? limit
});




}
/// @nodoc
class __$WatchTransactionsCopyWithImpl<$Res>
    implements _$WatchTransactionsCopyWith<$Res> {
  __$WatchTransactionsCopyWithImpl(this._self, this._then);

  final _WatchTransactions _self;
  final $Res Function(_WatchTransactions) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? limit = freezed,}) {
  return _then(_WatchTransactions(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _TransactionsUpdated implements CommunityEvent {
  const _TransactionsUpdated(final  List<CommunityTransaction> transactions): _transactions = transactions;
  

 final  List<CommunityTransaction> _transactions;
 List<CommunityTransaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionsUpdatedCopyWith<_TransactionsUpdated> get copyWith => __$TransactionsUpdatedCopyWithImpl<_TransactionsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionsUpdated&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'CommunityEvent.transactionsUpdated(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$TransactionsUpdatedCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$TransactionsUpdatedCopyWith(_TransactionsUpdated value, $Res Function(_TransactionsUpdated) _then) = __$TransactionsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<CommunityTransaction> transactions
});




}
/// @nodoc
class __$TransactionsUpdatedCopyWithImpl<$Res>
    implements _$TransactionsUpdatedCopyWith<$Res> {
  __$TransactionsUpdatedCopyWithImpl(this._self, this._then);

  final _TransactionsUpdated _self;
  final $Res Function(_TransactionsUpdated) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(_TransactionsUpdated(
null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<CommunityTransaction>,
  ));
}


}

/// @nodoc


class _WatchPendingApprovals implements CommunityEvent {
  const _WatchPendingApprovals({required this.communityId});
  

 final  String communityId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchPendingApprovalsCopyWith<_WatchPendingApprovals> get copyWith => __$WatchPendingApprovalsCopyWithImpl<_WatchPendingApprovals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchPendingApprovals&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'CommunityEvent.watchPendingApprovals(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$WatchPendingApprovalsCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$WatchPendingApprovalsCopyWith(_WatchPendingApprovals value, $Res Function(_WatchPendingApprovals) _then) = __$WatchPendingApprovalsCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$WatchPendingApprovalsCopyWithImpl<$Res>
    implements _$WatchPendingApprovalsCopyWith<$Res> {
  __$WatchPendingApprovalsCopyWithImpl(this._self, this._then);

  final _WatchPendingApprovals _self;
  final $Res Function(_WatchPendingApprovals) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_WatchPendingApprovals(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PendingApprovalsUpdated implements CommunityEvent {
  const _PendingApprovalsUpdated(final  List<CommunityApproval> approvals): _approvals = approvals;
  

 final  List<CommunityApproval> _approvals;
 List<CommunityApproval> get approvals {
  if (_approvals is EqualUnmodifiableListView) return _approvals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvals);
}


/// Create a copy of CommunityEvent
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
  return 'CommunityEvent.pendingApprovalsUpdated(approvals: $approvals)';
}


}

/// @nodoc
abstract mixin class _$PendingApprovalsUpdatedCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$PendingApprovalsUpdatedCopyWith(_PendingApprovalsUpdated value, $Res Function(_PendingApprovalsUpdated) _then) = __$PendingApprovalsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<CommunityApproval> approvals
});




}
/// @nodoc
class __$PendingApprovalsUpdatedCopyWithImpl<$Res>
    implements _$PendingApprovalsUpdatedCopyWith<$Res> {
  __$PendingApprovalsUpdatedCopyWithImpl(this._self, this._then);

  final _PendingApprovalsUpdated _self;
  final $Res Function(_PendingApprovalsUpdated) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? approvals = null,}) {
  return _then(_PendingApprovalsUpdated(
null == approvals ? _self._approvals : approvals // ignore: cast_nullable_to_non_nullable
as List<CommunityApproval>,
  ));
}


}

/// @nodoc


class _CreateCommunity implements CommunityEvent {
  const _CreateCommunity({required this.params});
  

 final  CreateCommunityParams params;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCommunityCopyWith<_CreateCommunity> get copyWith => __$CreateCommunityCopyWithImpl<_CreateCommunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateCommunity&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'CommunityEvent.createCommunity(params: $params)';
}


}

/// @nodoc
abstract mixin class _$CreateCommunityCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$CreateCommunityCopyWith(_CreateCommunity value, $Res Function(_CreateCommunity) _then) = __$CreateCommunityCopyWithImpl;
@useResult
$Res call({
 CreateCommunityParams params
});




}
/// @nodoc
class __$CreateCommunityCopyWithImpl<$Res>
    implements _$CreateCommunityCopyWith<$Res> {
  __$CreateCommunityCopyWithImpl(this._self, this._then);

  final _CreateCommunity _self;
  final $Res Function(_CreateCommunity) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(_CreateCommunity(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as CreateCommunityParams,
  ));
}


}

/// @nodoc


class _UpdateCommunity implements CommunityEvent {
  const _UpdateCommunity({required this.communityId, required this.params});
  

 final  String communityId;
 final  UpdateCommunityParams params;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCommunityCopyWith<_UpdateCommunity> get copyWith => __$UpdateCommunityCopyWithImpl<_UpdateCommunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCommunity&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,params);

@override
String toString() {
  return 'CommunityEvent.updateCommunity(communityId: $communityId, params: $params)';
}


}

/// @nodoc
abstract mixin class _$UpdateCommunityCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$UpdateCommunityCopyWith(_UpdateCommunity value, $Res Function(_UpdateCommunity) _then) = __$UpdateCommunityCopyWithImpl;
@useResult
$Res call({
 String communityId, UpdateCommunityParams params
});




}
/// @nodoc
class __$UpdateCommunityCopyWithImpl<$Res>
    implements _$UpdateCommunityCopyWith<$Res> {
  __$UpdateCommunityCopyWithImpl(this._self, this._then);

  final _UpdateCommunity _self;
  final $Res Function(_UpdateCommunity) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? params = null,}) {
  return _then(_UpdateCommunity(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as UpdateCommunityParams,
  ));
}


}

/// @nodoc


class _DeleteCommunity implements CommunityEvent {
  const _DeleteCommunity({required this.communityId});
  

 final  String communityId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteCommunityCopyWith<_DeleteCommunity> get copyWith => __$DeleteCommunityCopyWithImpl<_DeleteCommunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteCommunity&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'CommunityEvent.deleteCommunity(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$DeleteCommunityCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$DeleteCommunityCopyWith(_DeleteCommunity value, $Res Function(_DeleteCommunity) _then) = __$DeleteCommunityCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$DeleteCommunityCopyWithImpl<$Res>
    implements _$DeleteCommunityCopyWith<$Res> {
  __$DeleteCommunityCopyWithImpl(this._self, this._then);

  final _DeleteCommunity _self;
  final $Res Function(_DeleteCommunity) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_DeleteCommunity(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _InviteMember implements CommunityEvent {
  const _InviteMember({required this.communityId, required this.userId, required this.role});
  

 final  String communityId;
 final  String userId;
 final  MemberRole role;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteMemberCopyWith<_InviteMember> get copyWith => __$InviteMemberCopyWithImpl<_InviteMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteMember&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,userId,role);

@override
String toString() {
  return 'CommunityEvent.inviteMember(communityId: $communityId, userId: $userId, role: $role)';
}


}

/// @nodoc
abstract mixin class _$InviteMemberCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$InviteMemberCopyWith(_InviteMember value, $Res Function(_InviteMember) _then) = __$InviteMemberCopyWithImpl;
@useResult
$Res call({
 String communityId, String userId, MemberRole role
});




}
/// @nodoc
class __$InviteMemberCopyWithImpl<$Res>
    implements _$InviteMemberCopyWith<$Res> {
  __$InviteMemberCopyWithImpl(this._self, this._then);

  final _InviteMember _self;
  final $Res Function(_InviteMember) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? userId = null,Object? role = null,}) {
  return _then(_InviteMember(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,
  ));
}


}

/// @nodoc


class _AcceptInvitation implements CommunityEvent {
  const _AcceptInvitation({required this.communityId});
  

 final  String communityId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptInvitationCopyWith<_AcceptInvitation> get copyWith => __$AcceptInvitationCopyWithImpl<_AcceptInvitation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptInvitation&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'CommunityEvent.acceptInvitation(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$AcceptInvitationCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$AcceptInvitationCopyWith(_AcceptInvitation value, $Res Function(_AcceptInvitation) _then) = __$AcceptInvitationCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$AcceptInvitationCopyWithImpl<$Res>
    implements _$AcceptInvitationCopyWith<$Res> {
  __$AcceptInvitationCopyWithImpl(this._self, this._then);

  final _AcceptInvitation _self;
  final $Res Function(_AcceptInvitation) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_AcceptInvitation(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeclineInvitation implements CommunityEvent {
  const _DeclineInvitation({required this.communityId});
  

 final  String communityId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclineInvitationCopyWith<_DeclineInvitation> get copyWith => __$DeclineInvitationCopyWithImpl<_DeclineInvitation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclineInvitation&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'CommunityEvent.declineInvitation(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$DeclineInvitationCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$DeclineInvitationCopyWith(_DeclineInvitation value, $Res Function(_DeclineInvitation) _then) = __$DeclineInvitationCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$DeclineInvitationCopyWithImpl<$Res>
    implements _$DeclineInvitationCopyWith<$Res> {
  __$DeclineInvitationCopyWithImpl(this._self, this._then);

  final _DeclineInvitation _self;
  final $Res Function(_DeclineInvitation) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_DeclineInvitation(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RemoveMember implements CommunityEvent {
  const _RemoveMember({required this.communityId, required this.memberId});
  

 final  String communityId;
 final  String memberId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveMemberCopyWith<_RemoveMember> get copyWith => __$RemoveMemberCopyWithImpl<_RemoveMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveMember&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.memberId, memberId) || other.memberId == memberId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,memberId);

@override
String toString() {
  return 'CommunityEvent.removeMember(communityId: $communityId, memberId: $memberId)';
}


}

/// @nodoc
abstract mixin class _$RemoveMemberCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$RemoveMemberCopyWith(_RemoveMember value, $Res Function(_RemoveMember) _then) = __$RemoveMemberCopyWithImpl;
@useResult
$Res call({
 String communityId, String memberId
});




}
/// @nodoc
class __$RemoveMemberCopyWithImpl<$Res>
    implements _$RemoveMemberCopyWith<$Res> {
  __$RemoveMemberCopyWithImpl(this._self, this._then);

  final _RemoveMember _self;
  final $Res Function(_RemoveMember) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? memberId = null,}) {
  return _then(_RemoveMember(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateMemberRole implements CommunityEvent {
  const _UpdateMemberRole({required this.communityId, required this.memberId, required this.role});
  

 final  String communityId;
 final  String memberId;
 final  MemberRole role;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateMemberRoleCopyWith<_UpdateMemberRole> get copyWith => __$UpdateMemberRoleCopyWithImpl<_UpdateMemberRole>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateMemberRole&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,memberId,role);

@override
String toString() {
  return 'CommunityEvent.updateMemberRole(communityId: $communityId, memberId: $memberId, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UpdateMemberRoleCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$UpdateMemberRoleCopyWith(_UpdateMemberRole value, $Res Function(_UpdateMemberRole) _then) = __$UpdateMemberRoleCopyWithImpl;
@useResult
$Res call({
 String communityId, String memberId, MemberRole role
});




}
/// @nodoc
class __$UpdateMemberRoleCopyWithImpl<$Res>
    implements _$UpdateMemberRoleCopyWith<$Res> {
  __$UpdateMemberRoleCopyWithImpl(this._self, this._then);

  final _UpdateMemberRole _self;
  final $Res Function(_UpdateMemberRole) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? memberId = null,Object? role = null,}) {
  return _then(_UpdateMemberRole(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,
  ));
}


}

/// @nodoc


class _LeaveCommunity implements CommunityEvent {
  const _LeaveCommunity({required this.communityId});
  

 final  String communityId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveCommunityCopyWith<_LeaveCommunity> get copyWith => __$LeaveCommunityCopyWithImpl<_LeaveCommunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveCommunity&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'CommunityEvent.leaveCommunity(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$LeaveCommunityCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$LeaveCommunityCopyWith(_LeaveCommunity value, $Res Function(_LeaveCommunity) _then) = __$LeaveCommunityCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$LeaveCommunityCopyWithImpl<$Res>
    implements _$LeaveCommunityCopyWith<$Res> {
  __$LeaveCommunityCopyWithImpl(this._self, this._then);

  final _LeaveCommunity _self;
  final $Res Function(_LeaveCommunity) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_LeaveCommunity(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadPendingInvitations implements CommunityEvent {
  const _LoadPendingInvitations();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadPendingInvitations);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityEvent.loadPendingInvitations()';
}


}




/// @nodoc


class _Contribute implements CommunityEvent {
  const _Contribute({required this.communityId, required this.amount, this.description});
  

 final  String communityId;
 final  int amount;
 final  String? description;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContributeCopyWith<_Contribute> get copyWith => __$ContributeCopyWithImpl<_Contribute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contribute&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,amount,description);

@override
String toString() {
  return 'CommunityEvent.contribute(communityId: $communityId, amount: $amount, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ContributeCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$ContributeCopyWith(_Contribute value, $Res Function(_Contribute) _then) = __$ContributeCopyWithImpl;
@useResult
$Res call({
 String communityId, int amount, String? description
});




}
/// @nodoc
class __$ContributeCopyWithImpl<$Res>
    implements _$ContributeCopyWith<$Res> {
  __$ContributeCopyWithImpl(this._self, this._then);

  final _Contribute _self;
  final $Res Function(_Contribute) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? amount = null,Object? description = freezed,}) {
  return _then(_Contribute(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Withdraw implements CommunityEvent {
  const _Withdraw({required this.communityId, required this.amount, this.description});
  

 final  String communityId;
 final  int amount;
 final  String? description;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawCopyWith<_Withdraw> get copyWith => __$WithdrawCopyWithImpl<_Withdraw>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Withdraw&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,amount,description);

@override
String toString() {
  return 'CommunityEvent.withdraw(communityId: $communityId, amount: $amount, description: $description)';
}


}

/// @nodoc
abstract mixin class _$WithdrawCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$WithdrawCopyWith(_Withdraw value, $Res Function(_Withdraw) _then) = __$WithdrawCopyWithImpl;
@useResult
$Res call({
 String communityId, int amount, String? description
});




}
/// @nodoc
class __$WithdrawCopyWithImpl<$Res>
    implements _$WithdrawCopyWith<$Res> {
  __$WithdrawCopyWithImpl(this._self, this._then);

  final _Withdraw _self;
  final $Res Function(_Withdraw) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? amount = null,Object? description = freezed,}) {
  return _then(_Withdraw(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ApproveTransaction implements CommunityEvent {
  const _ApproveTransaction({required this.communityId, required this.transactionId});
  

 final  String communityId;
 final  String transactionId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApproveTransactionCopyWith<_ApproveTransaction> get copyWith => __$ApproveTransactionCopyWithImpl<_ApproveTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApproveTransaction&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,transactionId);

@override
String toString() {
  return 'CommunityEvent.approveTransaction(communityId: $communityId, transactionId: $transactionId)';
}


}

/// @nodoc
abstract mixin class _$ApproveTransactionCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$ApproveTransactionCopyWith(_ApproveTransaction value, $Res Function(_ApproveTransaction) _then) = __$ApproveTransactionCopyWithImpl;
@useResult
$Res call({
 String communityId, String transactionId
});




}
/// @nodoc
class __$ApproveTransactionCopyWithImpl<$Res>
    implements _$ApproveTransactionCopyWith<$Res> {
  __$ApproveTransactionCopyWithImpl(this._self, this._then);

  final _ApproveTransaction _self;
  final $Res Function(_ApproveTransaction) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? transactionId = null,}) {
  return _then(_ApproveTransaction(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RejectTransaction implements CommunityEvent {
  const _RejectTransaction({required this.communityId, required this.transactionId, this.reason});
  

 final  String communityId;
 final  String transactionId;
 final  String? reason;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RejectTransactionCopyWith<_RejectTransaction> get copyWith => __$RejectTransactionCopyWithImpl<_RejectTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RejectTransaction&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,transactionId,reason);

@override
String toString() {
  return 'CommunityEvent.rejectTransaction(communityId: $communityId, transactionId: $transactionId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RejectTransactionCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$RejectTransactionCopyWith(_RejectTransaction value, $Res Function(_RejectTransaction) _then) = __$RejectTransactionCopyWithImpl;
@useResult
$Res call({
 String communityId, String transactionId, String? reason
});




}
/// @nodoc
class __$RejectTransactionCopyWithImpl<$Res>
    implements _$RejectTransactionCopyWith<$Res> {
  __$RejectTransactionCopyWithImpl(this._self, this._then);

  final _RejectTransaction _self;
  final $Res Function(_RejectTransaction) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? transactionId = null,Object? reason = freezed,}) {
  return _then(_RejectTransaction(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _TriggerPayout implements CommunityEvent {
  const _TriggerPayout({required this.communityId, this.recipientId});
  

 final  String communityId;
 final  String? recipientId;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TriggerPayoutCopyWith<_TriggerPayout> get copyWith => __$TriggerPayoutCopyWithImpl<_TriggerPayout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TriggerPayout&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,recipientId);

@override
String toString() {
  return 'CommunityEvent.triggerPayout(communityId: $communityId, recipientId: $recipientId)';
}


}

/// @nodoc
abstract mixin class _$TriggerPayoutCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$TriggerPayoutCopyWith(_TriggerPayout value, $Res Function(_TriggerPayout) _then) = __$TriggerPayoutCopyWithImpl;
@useResult
$Res call({
 String communityId, String? recipientId
});




}
/// @nodoc
class __$TriggerPayoutCopyWithImpl<$Res>
    implements _$TriggerPayoutCopyWith<$Res> {
  __$TriggerPayoutCopyWithImpl(this._self, this._then);

  final _TriggerPayout _self;
  final $Res Function(_TriggerPayout) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? recipientId = freezed,}) {
  return _then(_TriggerPayout(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadAnalytics implements CommunityEvent {
  const _LoadAnalytics({required this.communityId, this.months});
  

 final  String communityId;
 final  int? months;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadAnalyticsCopyWith<_LoadAnalytics> get copyWith => __$LoadAnalyticsCopyWithImpl<_LoadAnalytics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadAnalytics&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.months, months) || other.months == months));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,months);

@override
String toString() {
  return 'CommunityEvent.loadAnalytics(communityId: $communityId, months: $months)';
}


}

/// @nodoc
abstract mixin class _$LoadAnalyticsCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$LoadAnalyticsCopyWith(_LoadAnalytics value, $Res Function(_LoadAnalytics) _then) = __$LoadAnalyticsCopyWithImpl;
@useResult
$Res call({
 String communityId, int? months
});




}
/// @nodoc
class __$LoadAnalyticsCopyWithImpl<$Res>
    implements _$LoadAnalyticsCopyWith<$Res> {
  __$LoadAnalyticsCopyWithImpl(this._self, this._then);

  final _LoadAnalytics _self;
  final $Res Function(_LoadAnalytics) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? months = freezed,}) {
  return _then(_LoadAnalytics(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,months: freezed == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _UnreadCountUpdated implements CommunityEvent {
  const _UnreadCountUpdated(this.count);
  

 final  int count;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnreadCountUpdatedCopyWith<_UnreadCountUpdated> get copyWith => __$UnreadCountUpdatedCopyWithImpl<_UnreadCountUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnreadCountUpdated&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'CommunityEvent.unreadCountUpdated(count: $count)';
}


}

/// @nodoc
abstract mixin class _$UnreadCountUpdatedCopyWith<$Res> implements $CommunityEventCopyWith<$Res> {
  factory _$UnreadCountUpdatedCopyWith(_UnreadCountUpdated value, $Res Function(_UnreadCountUpdated) _then) = __$UnreadCountUpdatedCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class __$UnreadCountUpdatedCopyWithImpl<$Res>
    implements _$UnreadCountUpdatedCopyWith<$Res> {
  __$UnreadCountUpdatedCopyWithImpl(this._self, this._then);

  final _UnreadCountUpdated _self;
  final $Res Function(_UnreadCountUpdated) _then;

/// Create a copy of CommunityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_UnreadCountUpdated(
null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ClearSelectedCommunity implements CommunityEvent {
  const _ClearSelectedCommunity();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSelectedCommunity);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityEvent.clearSelectedCommunity()';
}


}




/// @nodoc


class _ClearError implements CommunityEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommunityEvent.clearError()';
}


}




/// @nodoc
mixin _$CommunityState {

// Status
 CommunityLoadingStatus get status; CommunityOperationStatus get operationStatus;// Communities list
 List<Community> get communities; List<CommunityMember> get pendingInvitations;// Selected community details
 Community? get selectedCommunity; List<CommunityMember> get selectedCommunityMembers; List<CommunityTransaction> get selectedCommunityTransactions; List<CommunityApproval> get selectedCommunityApprovals;// Loading states
 bool get isLoadingMore; bool get hasMoreTransactions;// Stokvel analytics
 StokvelAnalytics? get stokvelAnalytics; bool get isLoadingAnalytics;// Unread
 int get totalUnreadCount;// Error handling
 String? get errorMessage; String? get successMessage;
/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityStateCopyWith<CommunityState> get copyWith => _$CommunityStateCopyWithImpl<CommunityState>(this as CommunityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityState&&(identical(other.status, status) || other.status == status)&&(identical(other.operationStatus, operationStatus) || other.operationStatus == operationStatus)&&const DeepCollectionEquality().equals(other.communities, communities)&&const DeepCollectionEquality().equals(other.pendingInvitations, pendingInvitations)&&(identical(other.selectedCommunity, selectedCommunity) || other.selectedCommunity == selectedCommunity)&&const DeepCollectionEquality().equals(other.selectedCommunityMembers, selectedCommunityMembers)&&const DeepCollectionEquality().equals(other.selectedCommunityTransactions, selectedCommunityTransactions)&&const DeepCollectionEquality().equals(other.selectedCommunityApprovals, selectedCommunityApprovals)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMoreTransactions, hasMoreTransactions) || other.hasMoreTransactions == hasMoreTransactions)&&(identical(other.stokvelAnalytics, stokvelAnalytics) || other.stokvelAnalytics == stokvelAnalytics)&&(identical(other.isLoadingAnalytics, isLoadingAnalytics) || other.isLoadingAnalytics == isLoadingAnalytics)&&(identical(other.totalUnreadCount, totalUnreadCount) || other.totalUnreadCount == totalUnreadCount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,operationStatus,const DeepCollectionEquality().hash(communities),const DeepCollectionEquality().hash(pendingInvitations),selectedCommunity,const DeepCollectionEquality().hash(selectedCommunityMembers),const DeepCollectionEquality().hash(selectedCommunityTransactions),const DeepCollectionEquality().hash(selectedCommunityApprovals),isLoadingMore,hasMoreTransactions,stokvelAnalytics,isLoadingAnalytics,totalUnreadCount,errorMessage,successMessage);

@override
String toString() {
  return 'CommunityState(status: $status, operationStatus: $operationStatus, communities: $communities, pendingInvitations: $pendingInvitations, selectedCommunity: $selectedCommunity, selectedCommunityMembers: $selectedCommunityMembers, selectedCommunityTransactions: $selectedCommunityTransactions, selectedCommunityApprovals: $selectedCommunityApprovals, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, stokvelAnalytics: $stokvelAnalytics, isLoadingAnalytics: $isLoadingAnalytics, totalUnreadCount: $totalUnreadCount, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $CommunityStateCopyWith<$Res>  {
  factory $CommunityStateCopyWith(CommunityState value, $Res Function(CommunityState) _then) = _$CommunityStateCopyWithImpl;
@useResult
$Res call({
 CommunityLoadingStatus status, CommunityOperationStatus operationStatus, List<Community> communities, List<CommunityMember> pendingInvitations, Community? selectedCommunity, List<CommunityMember> selectedCommunityMembers, List<CommunityTransaction> selectedCommunityTransactions, List<CommunityApproval> selectedCommunityApprovals, bool isLoadingMore, bool hasMoreTransactions, StokvelAnalytics? stokvelAnalytics, bool isLoadingAnalytics, int totalUnreadCount, String? errorMessage, String? successMessage
});


$CommunityCopyWith<$Res>? get selectedCommunity;

}
/// @nodoc
class _$CommunityStateCopyWithImpl<$Res>
    implements $CommunityStateCopyWith<$Res> {
  _$CommunityStateCopyWithImpl(this._self, this._then);

  final CommunityState _self;
  final $Res Function(CommunityState) _then;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? operationStatus = null,Object? communities = null,Object? pendingInvitations = null,Object? selectedCommunity = freezed,Object? selectedCommunityMembers = null,Object? selectedCommunityTransactions = null,Object? selectedCommunityApprovals = null,Object? isLoadingMore = null,Object? hasMoreTransactions = null,Object? stokvelAnalytics = freezed,Object? isLoadingAnalytics = null,Object? totalUnreadCount = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommunityLoadingStatus,operationStatus: null == operationStatus ? _self.operationStatus : operationStatus // ignore: cast_nullable_to_non_nullable
as CommunityOperationStatus,communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,pendingInvitations: null == pendingInvitations ? _self.pendingInvitations : pendingInvitations // ignore: cast_nullable_to_non_nullable
as List<CommunityMember>,selectedCommunity: freezed == selectedCommunity ? _self.selectedCommunity : selectedCommunity // ignore: cast_nullable_to_non_nullable
as Community?,selectedCommunityMembers: null == selectedCommunityMembers ? _self.selectedCommunityMembers : selectedCommunityMembers // ignore: cast_nullable_to_non_nullable
as List<CommunityMember>,selectedCommunityTransactions: null == selectedCommunityTransactions ? _self.selectedCommunityTransactions : selectedCommunityTransactions // ignore: cast_nullable_to_non_nullable
as List<CommunityTransaction>,selectedCommunityApprovals: null == selectedCommunityApprovals ? _self.selectedCommunityApprovals : selectedCommunityApprovals // ignore: cast_nullable_to_non_nullable
as List<CommunityApproval>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMoreTransactions: null == hasMoreTransactions ? _self.hasMoreTransactions : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
as bool,stokvelAnalytics: freezed == stokvelAnalytics ? _self.stokvelAnalytics : stokvelAnalytics // ignore: cast_nullable_to_non_nullable
as StokvelAnalytics?,isLoadingAnalytics: null == isLoadingAnalytics ? _self.isLoadingAnalytics : isLoadingAnalytics // ignore: cast_nullable_to_non_nullable
as bool,totalUnreadCount: null == totalUnreadCount ? _self.totalUnreadCount : totalUnreadCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityCopyWith<$Res>? get selectedCommunity {
    if (_self.selectedCommunity == null) {
    return null;
  }

  return $CommunityCopyWith<$Res>(_self.selectedCommunity!, (value) {
    return _then(_self.copyWith(selectedCommunity: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityState].
extension CommunityStatePatterns on CommunityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommunityLoadingStatus status,  CommunityOperationStatus operationStatus,  List<Community> communities,  List<CommunityMember> pendingInvitations,  Community? selectedCommunity,  List<CommunityMember> selectedCommunityMembers,  List<CommunityTransaction> selectedCommunityTransactions,  List<CommunityApproval> selectedCommunityApprovals,  bool isLoadingMore,  bool hasMoreTransactions,  StokvelAnalytics? stokvelAnalytics,  bool isLoadingAnalytics,  int totalUnreadCount,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
return $default(_that.status,_that.operationStatus,_that.communities,_that.pendingInvitations,_that.selectedCommunity,_that.selectedCommunityMembers,_that.selectedCommunityTransactions,_that.selectedCommunityApprovals,_that.isLoadingMore,_that.hasMoreTransactions,_that.stokvelAnalytics,_that.isLoadingAnalytics,_that.totalUnreadCount,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommunityLoadingStatus status,  CommunityOperationStatus operationStatus,  List<Community> communities,  List<CommunityMember> pendingInvitations,  Community? selectedCommunity,  List<CommunityMember> selectedCommunityMembers,  List<CommunityTransaction> selectedCommunityTransactions,  List<CommunityApproval> selectedCommunityApprovals,  bool isLoadingMore,  bool hasMoreTransactions,  StokvelAnalytics? stokvelAnalytics,  bool isLoadingAnalytics,  int totalUnreadCount,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _CommunityState():
return $default(_that.status,_that.operationStatus,_that.communities,_that.pendingInvitations,_that.selectedCommunity,_that.selectedCommunityMembers,_that.selectedCommunityTransactions,_that.selectedCommunityApprovals,_that.isLoadingMore,_that.hasMoreTransactions,_that.stokvelAnalytics,_that.isLoadingAnalytics,_that.totalUnreadCount,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommunityLoadingStatus status,  CommunityOperationStatus operationStatus,  List<Community> communities,  List<CommunityMember> pendingInvitations,  Community? selectedCommunity,  List<CommunityMember> selectedCommunityMembers,  List<CommunityTransaction> selectedCommunityTransactions,  List<CommunityApproval> selectedCommunityApprovals,  bool isLoadingMore,  bool hasMoreTransactions,  StokvelAnalytics? stokvelAnalytics,  bool isLoadingAnalytics,  int totalUnreadCount,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
return $default(_that.status,_that.operationStatus,_that.communities,_that.pendingInvitations,_that.selectedCommunity,_that.selectedCommunityMembers,_that.selectedCommunityTransactions,_that.selectedCommunityApprovals,_that.isLoadingMore,_that.hasMoreTransactions,_that.stokvelAnalytics,_that.isLoadingAnalytics,_that.totalUnreadCount,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityState extends CommunityState {
  const _CommunityState({this.status = CommunityLoadingStatus.initial, this.operationStatus = CommunityOperationStatus.idle, final  List<Community> communities = const [], final  List<CommunityMember> pendingInvitations = const [], this.selectedCommunity, final  List<CommunityMember> selectedCommunityMembers = const [], final  List<CommunityTransaction> selectedCommunityTransactions = const [], final  List<CommunityApproval> selectedCommunityApprovals = const [], this.isLoadingMore = false, this.hasMoreTransactions = false, this.stokvelAnalytics, this.isLoadingAnalytics = false, this.totalUnreadCount = 0, this.errorMessage, this.successMessage}): _communities = communities,_pendingInvitations = pendingInvitations,_selectedCommunityMembers = selectedCommunityMembers,_selectedCommunityTransactions = selectedCommunityTransactions,_selectedCommunityApprovals = selectedCommunityApprovals,super._();
  

// Status
@override@JsonKey() final  CommunityLoadingStatus status;
@override@JsonKey() final  CommunityOperationStatus operationStatus;
// Communities list
 final  List<Community> _communities;
// Communities list
@override@JsonKey() List<Community> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}

 final  List<CommunityMember> _pendingInvitations;
@override@JsonKey() List<CommunityMember> get pendingInvitations {
  if (_pendingInvitations is EqualUnmodifiableListView) return _pendingInvitations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingInvitations);
}

// Selected community details
@override final  Community? selectedCommunity;
 final  List<CommunityMember> _selectedCommunityMembers;
@override@JsonKey() List<CommunityMember> get selectedCommunityMembers {
  if (_selectedCommunityMembers is EqualUnmodifiableListView) return _selectedCommunityMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedCommunityMembers);
}

 final  List<CommunityTransaction> _selectedCommunityTransactions;
@override@JsonKey() List<CommunityTransaction> get selectedCommunityTransactions {
  if (_selectedCommunityTransactions is EqualUnmodifiableListView) return _selectedCommunityTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedCommunityTransactions);
}

 final  List<CommunityApproval> _selectedCommunityApprovals;
@override@JsonKey() List<CommunityApproval> get selectedCommunityApprovals {
  if (_selectedCommunityApprovals is EqualUnmodifiableListView) return _selectedCommunityApprovals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedCommunityApprovals);
}

// Loading states
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMoreTransactions;
// Stokvel analytics
@override final  StokvelAnalytics? stokvelAnalytics;
@override@JsonKey() final  bool isLoadingAnalytics;
// Unread
@override@JsonKey() final  int totalUnreadCount;
// Error handling
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityStateCopyWith<_CommunityState> get copyWith => __$CommunityStateCopyWithImpl<_CommunityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityState&&(identical(other.status, status) || other.status == status)&&(identical(other.operationStatus, operationStatus) || other.operationStatus == operationStatus)&&const DeepCollectionEquality().equals(other._communities, _communities)&&const DeepCollectionEquality().equals(other._pendingInvitations, _pendingInvitations)&&(identical(other.selectedCommunity, selectedCommunity) || other.selectedCommunity == selectedCommunity)&&const DeepCollectionEquality().equals(other._selectedCommunityMembers, _selectedCommunityMembers)&&const DeepCollectionEquality().equals(other._selectedCommunityTransactions, _selectedCommunityTransactions)&&const DeepCollectionEquality().equals(other._selectedCommunityApprovals, _selectedCommunityApprovals)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMoreTransactions, hasMoreTransactions) || other.hasMoreTransactions == hasMoreTransactions)&&(identical(other.stokvelAnalytics, stokvelAnalytics) || other.stokvelAnalytics == stokvelAnalytics)&&(identical(other.isLoadingAnalytics, isLoadingAnalytics) || other.isLoadingAnalytics == isLoadingAnalytics)&&(identical(other.totalUnreadCount, totalUnreadCount) || other.totalUnreadCount == totalUnreadCount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,operationStatus,const DeepCollectionEquality().hash(_communities),const DeepCollectionEquality().hash(_pendingInvitations),selectedCommunity,const DeepCollectionEquality().hash(_selectedCommunityMembers),const DeepCollectionEquality().hash(_selectedCommunityTransactions),const DeepCollectionEquality().hash(_selectedCommunityApprovals),isLoadingMore,hasMoreTransactions,stokvelAnalytics,isLoadingAnalytics,totalUnreadCount,errorMessage,successMessage);

@override
String toString() {
  return 'CommunityState(status: $status, operationStatus: $operationStatus, communities: $communities, pendingInvitations: $pendingInvitations, selectedCommunity: $selectedCommunity, selectedCommunityMembers: $selectedCommunityMembers, selectedCommunityTransactions: $selectedCommunityTransactions, selectedCommunityApprovals: $selectedCommunityApprovals, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, stokvelAnalytics: $stokvelAnalytics, isLoadingAnalytics: $isLoadingAnalytics, totalUnreadCount: $totalUnreadCount, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$CommunityStateCopyWith<$Res> implements $CommunityStateCopyWith<$Res> {
  factory _$CommunityStateCopyWith(_CommunityState value, $Res Function(_CommunityState) _then) = __$CommunityStateCopyWithImpl;
@override @useResult
$Res call({
 CommunityLoadingStatus status, CommunityOperationStatus operationStatus, List<Community> communities, List<CommunityMember> pendingInvitations, Community? selectedCommunity, List<CommunityMember> selectedCommunityMembers, List<CommunityTransaction> selectedCommunityTransactions, List<CommunityApproval> selectedCommunityApprovals, bool isLoadingMore, bool hasMoreTransactions, StokvelAnalytics? stokvelAnalytics, bool isLoadingAnalytics, int totalUnreadCount, String? errorMessage, String? successMessage
});


@override $CommunityCopyWith<$Res>? get selectedCommunity;

}
/// @nodoc
class __$CommunityStateCopyWithImpl<$Res>
    implements _$CommunityStateCopyWith<$Res> {
  __$CommunityStateCopyWithImpl(this._self, this._then);

  final _CommunityState _self;
  final $Res Function(_CommunityState) _then;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? operationStatus = null,Object? communities = null,Object? pendingInvitations = null,Object? selectedCommunity = freezed,Object? selectedCommunityMembers = null,Object? selectedCommunityTransactions = null,Object? selectedCommunityApprovals = null,Object? isLoadingMore = null,Object? hasMoreTransactions = null,Object? stokvelAnalytics = freezed,Object? isLoadingAnalytics = null,Object? totalUnreadCount = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_CommunityState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommunityLoadingStatus,operationStatus: null == operationStatus ? _self.operationStatus : operationStatus // ignore: cast_nullable_to_non_nullable
as CommunityOperationStatus,communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<Community>,pendingInvitations: null == pendingInvitations ? _self._pendingInvitations : pendingInvitations // ignore: cast_nullable_to_non_nullable
as List<CommunityMember>,selectedCommunity: freezed == selectedCommunity ? _self.selectedCommunity : selectedCommunity // ignore: cast_nullable_to_non_nullable
as Community?,selectedCommunityMembers: null == selectedCommunityMembers ? _self._selectedCommunityMembers : selectedCommunityMembers // ignore: cast_nullable_to_non_nullable
as List<CommunityMember>,selectedCommunityTransactions: null == selectedCommunityTransactions ? _self._selectedCommunityTransactions : selectedCommunityTransactions // ignore: cast_nullable_to_non_nullable
as List<CommunityTransaction>,selectedCommunityApprovals: null == selectedCommunityApprovals ? _self._selectedCommunityApprovals : selectedCommunityApprovals // ignore: cast_nullable_to_non_nullable
as List<CommunityApproval>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMoreTransactions: null == hasMoreTransactions ? _self.hasMoreTransactions : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
as bool,stokvelAnalytics: freezed == stokvelAnalytics ? _self.stokvelAnalytics : stokvelAnalytics // ignore: cast_nullable_to_non_nullable
as StokvelAnalytics?,isLoadingAnalytics: null == isLoadingAnalytics ? _self.isLoadingAnalytics : isLoadingAnalytics // ignore: cast_nullable_to_non_nullable
as bool,totalUnreadCount: null == totalUnreadCount ? _self.totalUnreadCount : totalUnreadCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityCopyWith<$Res>? get selectedCommunity {
    if (_self.selectedCommunity == null) {
    return null;
  }

  return $CommunityCopyWith<$Res>(_self.selectedCommunity!, (value) {
    return _then(_self.copyWith(selectedCommunity: value));
  });
}
}

// dart format on
