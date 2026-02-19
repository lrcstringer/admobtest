import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/group.dart';
import '../../../domain/entities/stokvel_analytics.dart';
import '../../../domain/entities/group_member.dart';
import '../../../domain/entities/group_transaction.dart';
import '../../../domain/repositories/group_repository.dart';

part 'group_bloc.freezed.dart';
part 'group_event.dart';
part 'group_state.dart';

@Deprecated('Use CommunityBloc instead. Will be removed in a future cleanup PR.')
@injectable
class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository _groupRepository;
  StreamSubscription? _groupsSubscription;
  StreamSubscription? _membersSubscription;
  StreamSubscription? _transactionsSubscription;
  StreamSubscription? _approvalsSubscription;

  GroupBloc(this._groupRepository) : super(const GroupState()) {
    // Group list events
    on<_LoadUserGroups>(_onLoadUserGroups);
    on<_WatchUserGroups>(_onWatchUserGroups);
    on<_UserGroupsUpdated>(_onUserGroupsUpdated);

    // Group detail events
    on<_LoadGroupDetails>(_onLoadGroupDetails);
    on<_WatchGroupMembers>(_onWatchGroupMembers);
    on<_GroupMembersUpdated>(_onGroupMembersUpdated);
    on<_WatchGroupTransactions>(_onWatchGroupTransactions);
    on<_GroupTransactionsUpdated>(_onGroupTransactionsUpdated);
    on<_WatchPendingApprovals>(_onWatchPendingApprovals);
    on<_PendingApprovalsUpdated>(_onPendingApprovalsUpdated);

    // CRUD events
    on<_CreateGroup>(_onCreateGroup);
    on<_UpdateGroup>(_onUpdateGroup);
    on<_DeleteGroup>(_onDeleteGroup);

    // Membership events
    on<_InviteMember>(_onInviteMember);
    on<_AcceptInvitation>(_onAcceptInvitation);
    on<_DeclineInvitation>(_onDeclineInvitation);
    on<_RemoveMember>(_onRemoveMember);
    on<_UpdateMemberRole>(_onUpdateMemberRole);
    on<_LeaveGroup>(_onLeaveGroup);
    on<_LoadPendingInvitations>(_onLoadPendingInvitations);

    // Transaction events
    on<_ContributeToGroup>(_onContributeToGroup);
    on<_WithdrawFromGroup>(_onWithdrawFromGroup);
    on<_ApproveTransaction>(_onApproveTransaction);
    on<_RejectTransaction>(_onRejectTransaction);

    // Stokvel events
    on<_TriggerStokvelPayout>(_onTriggerStokvelPayout);
    on<_LoadStokvelAnalytics>(_onLoadStokvelAnalytics);

    // Utility events
    on<_ClearSelectedGroup>(_onClearSelectedGroup);
    on<_ClearError>(_onClearError);
  }

  // ===========================================================================
  // GROUP LIST HANDLERS
  // ===========================================================================

  Future<void> _onLoadUserGroups(
    _LoadUserGroups event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(status: GroupLoadingStatus.loading));

    final result = await _groupRepository.getUserGroups();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: GroupLoadingStatus.error,
          errorMessage: failure.displayMessage,
        ));
      },
      (groups) {
        emit(state.copyWith(
          status: GroupLoadingStatus.loaded,
          groups: groups,
        ));
        // Start watching for updates
        add(const GroupEvent.watchUserGroups());
      },
    );
  }

  void _onWatchUserGroups(
    _WatchUserGroups event,
    Emitter<GroupState> emit,
  ) {
    _groupsSubscription?.cancel();
    _groupsSubscription = _groupRepository.watchUserGroups().listen(
      (result) {
        result.fold(
          (failure) {
            // Don't emit error for stream failures
          },
          (groups) {
            add(GroupEvent.userGroupsUpdated(groups));
          },
        );
      },
    );
  }

  void _onUserGroupsUpdated(
    _UserGroupsUpdated event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(
      status: GroupLoadingStatus.loaded,
      groups: event.groups,
    ));
  }

  // ===========================================================================
  // GROUP DETAIL HANDLERS
  // ===========================================================================

  Future<void> _onLoadGroupDetails(
    _LoadGroupDetails event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.getGroupDetails(event.groupId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (details) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.idle,
          selectedGroup: details.group,
          selectedGroupMembers: details.members,
        ));
        // Start watching for real-time updates
        add(GroupEvent.watchGroupMembers(groupId: event.groupId));
        add(GroupEvent.watchGroupTransactions(groupId: event.groupId));
        add(GroupEvent.watchPendingApprovals(groupId: event.groupId));
      },
    );
  }

  void _onWatchGroupMembers(
    _WatchGroupMembers event,
    Emitter<GroupState> emit,
  ) {
    _membersSubscription?.cancel();
    _membersSubscription = _groupRepository.watchGroupMembers(event.groupId).listen(
      (result) {
        result.fold(
          (failure) {},
          (members) {
            add(GroupEvent.groupMembersUpdated(members));
          },
        );
      },
    );
  }

  void _onGroupMembersUpdated(
    _GroupMembersUpdated event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(selectedGroupMembers: event.members));
  }

  void _onWatchGroupTransactions(
    _WatchGroupTransactions event,
    Emitter<GroupState> emit,
  ) {
    _transactionsSubscription?.cancel();
    _transactionsSubscription = _groupRepository
        .watchGroupTransactions(event.groupId, limit: event.limit ?? 50)
        .listen(
      (result) {
        result.fold(
          (failure) {},
          (transactions) {
            add(GroupEvent.groupTransactionsUpdated(transactions));
          },
        );
      },
    );
  }

  void _onGroupTransactionsUpdated(
    _GroupTransactionsUpdated event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(selectedGroupTransactions: event.transactions));
  }

  void _onWatchPendingApprovals(
    _WatchPendingApprovals event,
    Emitter<GroupState> emit,
  ) {
    _approvalsSubscription?.cancel();
    _approvalsSubscription = _groupRepository.watchPendingApprovals(event.groupId).listen(
      (result) {
        result.fold(
          (failure) {},
          (approvals) {
            add(GroupEvent.pendingApprovalsUpdated(approvals));
          },
        );
      },
    );
  }

  void _onPendingApprovalsUpdated(
    _PendingApprovalsUpdated event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(selectedGroupApprovals: event.approvals));
  }

  // ===========================================================================
  // GROUP CRUD HANDLERS
  // ===========================================================================

  Future<void> _onCreateGroup(
    _CreateGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.createGroup(event.params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (group) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Group "${group.name}" created successfully',
          groups: [...state.groups, group],
        ));
      },
    );
  }

  Future<void> _onUpdateGroup(
    _UpdateGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.updateGroup(event.groupId, event.params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Group updated successfully',
        ));
        // Refresh group details
        add(GroupEvent.loadGroupDetails(groupId: event.groupId));
      },
    );
  }

  Future<void> _onDeleteGroup(
    _DeleteGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.deleteGroup(event.groupId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Group deleted successfully',
          groups: state.groups.where((g) => g.id != event.groupId).toList(),
          selectedGroup: null,
          selectedGroupMembers: [],
          selectedGroupTransactions: [],
          selectedGroupApprovals: [],
        ));
      },
    );
  }

  // ===========================================================================
  // MEMBERSHIP HANDLERS
  // ===========================================================================

  Future<void> _onInviteMember(
    _InviteMember event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.inviteMember(
      event.groupId,
      event.userId,
      event.role,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Invitation sent successfully',
        ));
      },
    );
  }

  Future<void> _onAcceptInvitation(
    _AcceptInvitation event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.acceptInvitation(event.groupId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'You have joined the group',
        ));
        // Refresh groups list
        add(const GroupEvent.loadUserGroups());
        add(const GroupEvent.loadPendingInvitations());
      },
    );
  }

  Future<void> _onDeclineInvitation(
    _DeclineInvitation event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.declineInvitation(event.groupId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Invitation declined',
          pendingInvitations: state.pendingInvitations
              .where((i) => i.groupId != event.groupId)
              .toList(),
        ));
      },
    );
  }

  Future<void> _onRemoveMember(
    _RemoveMember event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.removeMember(event.groupId, event.memberId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Member removed successfully',
        ));
      },
    );
  }

  Future<void> _onUpdateMemberRole(
    _UpdateMemberRole event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.updateMemberRole(
      event.groupId,
      event.memberId,
      event.role,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Member role updated',
        ));
      },
    );
  }

  Future<void> _onLeaveGroup(
    _LeaveGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.leaveGroup(event.groupId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'You have left the group',
          groups: state.groups.where((g) => g.id != event.groupId).toList(),
          selectedGroup: null,
          selectedGroupMembers: [],
          selectedGroupTransactions: [],
          selectedGroupApprovals: [],
        ));
      },
    );
  }

  Future<void> _onLoadPendingInvitations(
    _LoadPendingInvitations event,
    Emitter<GroupState> emit,
  ) async {
    final result = await _groupRepository.getPendingInvitations();

    result.fold(
      (failure) {
        // Don't fail entirely for this
      },
      (invitations) {
        emit(state.copyWith(pendingInvitations: invitations));
      },
    );
  }

  // ===========================================================================
  // TRANSACTION HANDLERS
  // ===========================================================================

  Future<void> _onContributeToGroup(
    _ContributeToGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.contributeToGroup(
      event.groupId,
      event.amount,
      description: event.description,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (transaction) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Contribution of ${event.amount} tokens successful',
        ));
      },
    );
  }

  Future<void> _onWithdrawFromGroup(
    _WithdrawFromGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.withdrawFromGroup(
      event.groupId,
      event.amount,
      description: event.description,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (transaction) {
        final message = transaction.status == GroupTransactionStatus.pending
            ? 'Withdrawal request submitted for approval'
            : 'Withdrawal of ${event.amount} tokens successful';
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: message,
        ));
      },
    );
  }

  Future<void> _onApproveTransaction(
    _ApproveTransaction event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.approveTransaction(
      event.groupId,
      event.transactionId,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Transaction approved',
        ));
      },
    );
  }

  Future<void> _onRejectTransaction(
    _RejectTransaction event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.rejectTransaction(
      event.groupId,
      event.transactionId,
      reason: event.reason,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage: 'Transaction rejected',
        ));
      },
    );
  }

  // ===========================================================================
  // UTILITY HANDLERS
  // ===========================================================================

  void _onClearSelectedGroup(
    _ClearSelectedGroup event,
    Emitter<GroupState> emit,
  ) {
    _membersSubscription?.cancel();
    _transactionsSubscription?.cancel();
    _approvalsSubscription?.cancel();

    emit(state.copyWith(
      selectedGroup: null,
      selectedGroupMembers: [],
      selectedGroupTransactions: [],
      selectedGroupApprovals: [],
    ));
  }

  void _onClearError(
    _ClearError event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(
      operationStatus: GroupOperationStatus.idle,
      errorMessage: null,
      successMessage: null,
    ));
  }

  // ===========================================================================
  // STOKVEL HANDLERS
  // ===========================================================================

  Future<void> _onTriggerStokvelPayout(
    _TriggerStokvelPayout event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(operationStatus: GroupOperationStatus.processing));

    final result = await _groupRepository.triggerStokvelPayout(
      event.groupId,
      recipientId: event.recipientId,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.failure,
          errorMessage: failure.displayMessage,
        ));
      },
      (payoutResult) {
        emit(state.copyWith(
          operationStatus: GroupOperationStatus.success,
          successMessage:
              'Payout of ${payoutResult.amount} tokens completed successfully',
        ));
        // Refresh group details to show updated balance
        add(GroupEvent.loadGroupDetails(groupId: event.groupId));
      },
    );
  }

  Future<void> _onLoadStokvelAnalytics(
    _LoadStokvelAnalytics event,
    Emitter<GroupState> emit,
  ) async {
    emit(state.copyWith(isLoadingAnalytics: true));

    final result = await _groupRepository.getStokvelAnalytics(
      event.groupId,
      months: event.months ?? 6,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingAnalytics: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (analytics) {
        emit(state.copyWith(
          isLoadingAnalytics: false,
          stokvelAnalytics: analytics,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _groupsSubscription?.cancel();
    _membersSubscription?.cancel();
    _transactionsSubscription?.cancel();
    _approvalsSubscription?.cancel();
    return super.close();
  }
}
