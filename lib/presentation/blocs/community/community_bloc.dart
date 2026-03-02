import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/community.dart';
import '../../../domain/entities/community_member.dart';
import '../../../domain/entities/community_transaction.dart';
import '../../../domain/entities/stokvel_analytics.dart';
import '../../../domain/enums/community_type.dart';
import '../../../domain/enums/member_role.dart';
import '../../../domain/repositories/community_repository.dart';

part 'community_bloc.freezed.dart';
part 'community_event.dart';
part 'community_state.dart';

@injectable
class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final CommunityRepository _communityRepository;
  StreamSubscription? _communitiesSubscription;
  StreamSubscription? _membersSubscription;
  StreamSubscription? _transactionsSubscription;
  StreamSubscription? _approvalsSubscription;
  StreamSubscription? _unreadSubscription;

  CommunityBloc(this._communityRepository) : super(const CommunityState()) {
    // Community list
    on<_LoadUserCommunities>(_onLoadUserCommunities);
    on<_WatchUserCommunities>(_onWatchUserCommunities);
    on<_UserCommunitiesUpdated>(_onUserCommunitiesUpdated);

    // Community detail
    on<_LoadCommunityDetails>(_onLoadCommunityDetails);
    on<_WatchMembers>(_onWatchMembers);
    on<_MembersUpdated>(_onMembersUpdated);
    on<_WatchTransactions>(_onWatchTransactions);
    on<_TransactionsUpdated>(_onTransactionsUpdated);
    on<_WatchPendingApprovals>(_onWatchPendingApprovals);
    on<_PendingApprovalsUpdated>(_onPendingApprovalsUpdated);

    // CRUD
    on<_CreateCommunity>(_onCreateCommunity);
    on<_UpdateCommunity>(_onUpdateCommunity);
    on<_DeleteCommunity>(_onDeleteCommunity);

    // Membership
    on<_InviteMember>(_onInviteMember);
    on<_AcceptInvitation>(_onAcceptInvitation);
    on<_DeclineInvitation>(_onDeclineInvitation);
    on<_RemoveMember>(_onRemoveMember);
    on<_UpdateMemberRole>(_onUpdateMemberRole);
    on<_LeaveCommunity>(_onLeaveCommunity);
    on<_LoadPendingInvitations>(_onLoadPendingInvitations);

    // Financial
    on<_Contribute>(_onContribute);
    on<_Withdraw>(_onWithdraw);
    on<_ApproveTransaction>(_onApproveTransaction);
    on<_RejectTransaction>(_onRejectTransaction);

    // Stokvel
    on<_TriggerPayout>(_onTriggerPayout);
    on<_LoadAnalytics>(_onLoadAnalytics);

    // Unread
    on<_UnreadCountUpdated>(_onUnreadCountUpdated);

    // Utility
    on<_ClearSelectedCommunity>(_onClearSelectedCommunity);
    on<_ClearError>(_onClearError);
  }

  // ===========================================================================
  // COMMUNITY LIST HANDLERS
  // ===========================================================================

  Future<void> _onLoadUserCommunities(
    _LoadUserCommunities event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(status: CommunityLoadingStatus.loading));

    final result = await _communityRepository.getUserCommunities();

    result.fold(
      (failure) => emit(state.copyWith(
        status: CommunityLoadingStatus.error,
        errorMessage: failure.displayMessage,
      )),
      (communities) {
        emit(state.copyWith(
          status: CommunityLoadingStatus.loaded,
          communities: communities,
        ));
        // Start watching for updates
        add(const CommunityEvent.watchUserCommunities());
      },
    );
  }

  void _onWatchUserCommunities(
    _WatchUserCommunities event,
    Emitter<CommunityState> emit,
  ) {
    _communitiesSubscription?.cancel();
    _communitiesSubscription =
        _communityRepository.watchUserCommunities().listen(
      (result) {
        result.fold(
          (failure) {},
          (communities) =>
              add(CommunityEvent.userCommunitiesUpdated(communities)),
        );
      },
    );

    // Also watch total unread count for tab badge
    _unreadSubscription?.cancel();
    _unreadSubscription =
        _communityRepository.watchTotalCommunityUnreadCount().listen(
      (result) {
        result.fold(
          (failure) {},
          (count) => add(CommunityEvent.unreadCountUpdated(count)),
        );
      },
    );
  }

  void _onUserCommunitiesUpdated(
    _UserCommunitiesUpdated event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(
      status: CommunityLoadingStatus.loaded,
      communities: event.communities,
    ));
  }

  void _onUnreadCountUpdated(
    _UnreadCountUpdated event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(totalUnreadCount: event.count));
  }

  // ===========================================================================
  // COMMUNITY DETAIL HANDLERS
  // ===========================================================================

  Future<void> _onLoadCommunityDetails(
    _LoadCommunityDetails event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result =
        await _communityRepository.getCommunity(event.communityId);

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (community) {
        emit(state.copyWith(
          operationStatus: CommunityOperationStatus.idle,
          selectedCommunity: community,
        ));
        // Start watching subcollection streams
        add(CommunityEvent.watchMembers(communityId: event.communityId));
        add(CommunityEvent.watchTransactions(communityId: event.communityId));
        add(CommunityEvent.watchPendingApprovals(
            communityId: event.communityId));
      },
    );
  }

  void _onWatchMembers(
    _WatchMembers event,
    Emitter<CommunityState> emit,
  ) {
    _membersSubscription?.cancel();
    _membersSubscription =
        _communityRepository.watchMembers(event.communityId).listen(
      (result) {
        result.fold(
          (failure) {},
          (members) => add(CommunityEvent.membersUpdated(members)),
        );
      },
    );
    // Seed the local DB from Firestore so the stream fires immediately.
    // CommunitySyncService may not have synced this community's members yet.
    _communityRepository.refreshMembers(event.communityId);
  }

  void _onMembersUpdated(
    _MembersUpdated event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(selectedCommunityMembers: event.members));
  }

  void _onWatchTransactions(
    _WatchTransactions event,
    Emitter<CommunityState> emit,
  ) {
    _transactionsSubscription?.cancel();
    _transactionsSubscription =
        _communityRepository.watchTransactions(event.communityId).listen(
      (result) {
        result.fold(
          (failure) {},
          (transactions) =>
              add(CommunityEvent.transactionsUpdated(transactions)),
        );
      },
    );
  }

  void _onTransactionsUpdated(
    _TransactionsUpdated event,
    Emitter<CommunityState> emit,
  ) {
    emit(
        state.copyWith(selectedCommunityTransactions: event.transactions));
  }

  void _onWatchPendingApprovals(
    _WatchPendingApprovals event,
    Emitter<CommunityState> emit,
  ) {
    _approvalsSubscription?.cancel();
    _approvalsSubscription =
        _communityRepository.watchPendingApprovals(event.communityId).listen(
      (result) {
        result.fold(
          (failure) {},
          (approvals) =>
              add(CommunityEvent.pendingApprovalsUpdated(approvals)),
        );
      },
    );
  }

  void _onPendingApprovalsUpdated(
    _PendingApprovalsUpdated event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(selectedCommunityApprovals: event.approvals));
  }

  // ===========================================================================
  // CRUD HANDLERS
  // ===========================================================================

  Future<void> _onCreateCommunity(
    _CreateCommunity event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.createCommunity(event.params);

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (community) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: '"${community.name}" created successfully',
        communities: [...state.communities, community],
      )),
    );
  }

  Future<void> _onUpdateCommunity(
    _UpdateCommunity event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.updateCommunity(
      event.communityId,
      event.params,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          operationStatus: CommunityOperationStatus.success,
          successMessage: 'Community updated successfully',
        ));
        // Refresh community details
        add(CommunityEvent.loadCommunityDetails(
            communityId: event.communityId));
      },
    );
  }

  Future<void> _onDeleteCommunity(
    _DeleteCommunity event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result =
        await _communityRepository.deleteCommunity(event.communityId);

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Community deleted successfully',
        communities: state.communities
            .where((c) => c.id != event.communityId)
            .toList(),
        selectedCommunity: null,
        selectedCommunityMembers: [],
        selectedCommunityTransactions: [],
        selectedCommunityApprovals: [],
      )),
    );
  }

  // ===========================================================================
  // MEMBERSHIP HANDLERS
  // ===========================================================================

  Future<void> _onInviteMember(
    _InviteMember event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.inviteMember(
      event.communityId,
      event.userId,
      event.role,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Invitation sent successfully',
      )),
    );
  }

  Future<void> _onAcceptInvitation(
    _AcceptInvitation event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result =
        await _communityRepository.acceptInvitation(event.communityId);

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          operationStatus: CommunityOperationStatus.success,
          successMessage: 'You have joined the community',
        ));
        // Refresh lists
        add(const CommunityEvent.loadUserCommunities());
        add(const CommunityEvent.loadPendingInvitations());
      },
    );
  }

  Future<void> _onDeclineInvitation(
    _DeclineInvitation event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result =
        await _communityRepository.declineInvitation(event.communityId);

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Invitation declined',
        pendingInvitations: state.pendingInvitations
            .where((i) => i.communityId != event.communityId)
            .toList(),
      )),
    );
  }

  Future<void> _onRemoveMember(
    _RemoveMember event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.removeMember(
      event.communityId,
      event.memberId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Member removed successfully',
      )),
    );
  }

  Future<void> _onUpdateMemberRole(
    _UpdateMemberRole event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.updateMemberRole(
      event.communityId,
      event.memberId,
      event.role,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Member role updated',
      )),
    );
  }

  Future<void> _onLeaveCommunity(
    _LeaveCommunity event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result =
        await _communityRepository.leaveCommunity(event.communityId);

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'You have left the community',
        communities: state.communities
            .where((c) => c.id != event.communityId)
            .toList(),
        selectedCommunity: null,
        selectedCommunityMembers: [],
        selectedCommunityTransactions: [],
        selectedCommunityApprovals: [],
      )),
    );
  }

  Future<void> _onLoadPendingInvitations(
    _LoadPendingInvitations event,
    Emitter<CommunityState> emit,
  ) async {
    final result = await _communityRepository.getPendingInvitations();

    result.fold(
      (failure) {},
      (invitations) => emit(state.copyWith(pendingInvitations: invitations)),
    );
  }

  // ===========================================================================
  // FINANCIAL HANDLERS
  // ===========================================================================

  Future<void> _onContribute(
    _Contribute event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.contribute(
      event.communityId,
      event.amount,
      description: event.description,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (transaction) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Contribution of ${event.amount} tokens successful',
      )),
    );
  }

  Future<void> _onWithdraw(
    _Withdraw event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.withdraw(
      event.communityId,
      event.amount,
      description: event.description,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (transaction) {
        final message = transaction.isPending
            ? 'Withdrawal request submitted for approval'
            : 'Withdrawal of ${event.amount} tokens successful';
        emit(state.copyWith(
          operationStatus: CommunityOperationStatus.success,
          successMessage: message,
        ));
      },
    );
  }

  Future<void> _onApproveTransaction(
    _ApproveTransaction event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.approveTransaction(
      event.communityId,
      event.transactionId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Transaction approved',
      )),
    );
  }

  Future<void> _onRejectTransaction(
    _RejectTransaction event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.rejectTransaction(
      event.communityId,
      event.transactionId,
      reason: event.reason,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.success,
        successMessage: 'Transaction rejected',
      )),
    );
  }

  // ===========================================================================
  // STOKVEL HANDLERS
  // ===========================================================================

  Future<void> _onTriggerPayout(
    _TriggerPayout event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(operationStatus: CommunityOperationStatus.processing));

    final result = await _communityRepository.triggerPayout(
      event.communityId,
      recipientId: event.recipientId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (payoutResult) {
        emit(state.copyWith(
          operationStatus: CommunityOperationStatus.success,
          successMessage:
              'Payout of ${payoutResult.amount} tokens completed successfully',
        ));
        // Refresh community details to show updated balance
        add(CommunityEvent.loadCommunityDetails(
            communityId: event.communityId));
      },
    );
  }

  Future<void> _onLoadAnalytics(
    _LoadAnalytics event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(isLoadingAnalytics: true));

    final result = await _communityRepository.getAnalytics(
      event.communityId,
      months: event.months ?? 6,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingAnalytics: false,
        errorMessage: failure.displayMessage,
      )),
      (analytics) => emit(state.copyWith(
        isLoadingAnalytics: false,
        stokvelAnalytics: analytics,
      )),
    );
  }

  // ===========================================================================
  // UTILITY HANDLERS
  // ===========================================================================

  void _onClearSelectedCommunity(
    _ClearSelectedCommunity event,
    Emitter<CommunityState> emit,
  ) {
    _membersSubscription?.cancel();
    _transactionsSubscription?.cancel();
    _approvalsSubscription?.cancel();

    emit(state.copyWith(
      selectedCommunity: null,
      selectedCommunityMembers: [],
      selectedCommunityTransactions: [],
      selectedCommunityApprovals: [],
    ));
  }

  void _onClearError(
    _ClearError event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(
      operationStatus: CommunityOperationStatus.idle,
      errorMessage: null,
      successMessage: null,
    ));
  }

  @override
  Future<void> close() {
    _communitiesSubscription?.cancel();
    _membersSubscription?.cancel();
    _transactionsSubscription?.cancel();
    _approvalsSubscription?.cancel();
    _unreadSubscription?.cancel();
    return super.close();
  }
}
