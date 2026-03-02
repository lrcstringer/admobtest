import 'dart:async';

import 'package:flutter/foundation.dart';
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
  // HELPERS — auto-reset operationStatus to idle after success/failure (4.1)
  // ===========================================================================

  void _emitSuccess(
    Emitter<CommunityState> emit,
    String message, {
    CommunityState? base,
  }) {
    final s = base ?? state;
    emit(s.copyWith(
      operationStatus: CommunityOperationStatus.success,
      successMessage: message,
    ));
    emit(state.copyWith(
      operationStatus: CommunityOperationStatus.idle,
      successMessage: null,
      errorMessage: null,
    ));
  }

  void _emitFailure(Emitter<CommunityState> emit, Failure failure) {
    emit(state.copyWith(
      operationStatus: CommunityOperationStatus.failure,
      errorMessage: failure.displayMessage,
    ));
    emit(state.copyWith(
      operationStatus: CommunityOperationStatus.idle,
      errorMessage: null,
      successMessage: null,
    ));
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
        // Start watching for updates — guard against duplicate (4.3)
        if (_communitiesSubscription == null) {
          add(const CommunityEvent.watchUserCommunities());
        }
      },
    );
  }

  Future<void> _onWatchUserCommunities(
    _WatchUserCommunities event,
    Emitter<CommunityState> emit,
  ) async {
    // Await cancellation before re-listen (4.5)
    await _communitiesSubscription?.cancel();
    _communitiesSubscription =
        _communityRepository.watchUserCommunities().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => debugPrint(
                'CommunityBloc: community stream error: ${failure.displayMessage}'),
            (communities) =>
                add(CommunityEvent.userCommunitiesUpdated(communities)),
          );
        }
      },
    );

    // Also watch total unread count for tab badge
    await _unreadSubscription?.cancel();
    _unreadSubscription =
        _communityRepository.watchTotalCommunityUnreadCount().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => debugPrint(
                'CommunityBloc: unread count stream error: ${failure.displayMessage}'),
            (count) => add(CommunityEvent.unreadCountUpdated(count)),
          );
        }
      },
    );
  }

  void _onUserCommunitiesUpdated(
    _UserCommunitiesUpdated event,
    Emitter<CommunityState> emit,
  ) {
    // Invalidate selectedCommunity if it no longer exists in the list (4.8)
    final stillExists = state.selectedCommunity != null &&
        event.communities.any((c) => c.id == state.selectedCommunity!.id);

    emit(state.copyWith(
      status: CommunityLoadingStatus.loaded,
      communities: event.communities,
      selectedCommunity: stillExists ? state.selectedCommunity : null,
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
      (failure) => _emitFailure(emit, failure),
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

  Future<void> _onWatchMembers(
    _WatchMembers event,
    Emitter<CommunityState> emit,
  ) async {
    await _membersSubscription?.cancel();
    _membersSubscription =
        _communityRepository.watchMembers(event.communityId).listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => debugPrint(
                'CommunityBloc: members stream error: ${failure.displayMessage}'),
            (members) => add(CommunityEvent.membersUpdated(members)),
          );
        }
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

  Future<void> _onWatchTransactions(
    _WatchTransactions event,
    Emitter<CommunityState> emit,
  ) async {
    await _transactionsSubscription?.cancel();
    _transactionsSubscription =
        _communityRepository.watchTransactions(event.communityId).listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => debugPrint(
                'CommunityBloc: transactions stream error: ${failure.displayMessage}'),
            (transactions) =>
                add(CommunityEvent.transactionsUpdated(transactions)),
          );
        }
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

  Future<void> _onWatchPendingApprovals(
    _WatchPendingApprovals event,
    Emitter<CommunityState> emit,
  ) async {
    await _approvalsSubscription?.cancel();
    _approvalsSubscription =
        _communityRepository.watchPendingApprovals(event.communityId).listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => debugPrint(
                'CommunityBloc: approvals stream error: ${failure.displayMessage}'),
            (approvals) =>
                add(CommunityEvent.pendingApprovalsUpdated(approvals)),
          );
        }
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
      (failure) => _emitFailure(emit, failure),
      (community) => _emitSuccess(
        emit,
        '"${community.name}" created successfully',
        base: state.copyWith(
          communities: [...state.communities, community],
        ),
      ),
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
      (failure) => _emitFailure(emit, failure),
      (_) {
        _emitSuccess(emit, 'Community updated successfully');
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
      (failure) => _emitFailure(emit, failure),
      (_) => _emitSuccess(
        emit,
        'Community deleted successfully',
        base: state.copyWith(
          communities: state.communities
              .where((c) => c.id != event.communityId)
              .toList(),
          selectedCommunity: null,
          selectedCommunityMembers: [],
          selectedCommunityTransactions: [],
          selectedCommunityApprovals: [],
          totalUnreadCount: 0, // 4.7 reset unread count
        ),
      ),
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
      (failure) => _emitFailure(emit, failure),
      (_) => _emitSuccess(emit, 'Invitation sent successfully'),
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
      (failure) => _emitFailure(emit, failure),
      (_) {
        _emitSuccess(emit, 'You have joined the community');
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
      (failure) => _emitFailure(emit, failure),
      (_) => _emitSuccess(
        emit,
        'Invitation declined',
        base: state.copyWith(
          pendingInvitations: state.pendingInvitations
              .where((i) => i.communityId != event.communityId)
              .toList(),
        ),
      ),
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
      (failure) => _emitFailure(emit, failure),
      // 4.10 Optimistic: remove from members list immediately
      (_) => _emitSuccess(
        emit,
        'Member removed successfully',
        base: state.copyWith(
          selectedCommunityMembers: state.selectedCommunityMembers
              .where((m) => m.id != event.memberId)
              .toList(),
        ),
      ),
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
      (failure) => _emitFailure(emit, failure),
      // 4.10 Optimistic: update role in members list immediately
      (_) => _emitSuccess(
        emit,
        'Member role updated',
        base: state.copyWith(
          selectedCommunityMembers: state.selectedCommunityMembers.map((m) {
            if (m.id == event.memberId) {
              return CommunityMember(
                id: m.id,
                communityId: m.communityId,
                userId: m.userId,
                displayName: m.displayName,
                avatarUrl: m.avatarUrl,
                role: event.role,
                status: m.status,
                contributionBalance: m.contributionBalance,
                joinedAt: m.joinedAt,
                invitedBy: m.invitedBy,
                invitedAt: m.invitedAt,
                lastReadAt: m.lastReadAt,
                communityName: m.communityName,
              );
            }
            return m;
          }).toList(),
        ),
      ),
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
      (failure) => _emitFailure(emit, failure),
      (_) => _emitSuccess(
        emit,
        'You have left the community',
        base: state.copyWith(
          communities: state.communities
              .where((c) => c.id != event.communityId)
              .toList(),
          selectedCommunity: null,
          selectedCommunityMembers: [],
          selectedCommunityTransactions: [],
          selectedCommunityApprovals: [],
        ),
      ),
    );
  }

  Future<void> _onLoadPendingInvitations(
    _LoadPendingInvitations event,
    Emitter<CommunityState> emit,
  ) async {
    final result = await _communityRepository.getPendingInvitations();

    result.fold(
      // 4.9 Emit error state instead of only logging
      (failure) => emit(state.copyWith(
        errorMessage:
            'Failed to load invitations: ${failure.displayMessage}',
      )),
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
      (failure) => _emitFailure(emit, failure),
      (transaction) => _emitSuccess(
        emit,
        'Contribution of ${event.amount} tokens successful',
      ),
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
      (failure) => _emitFailure(emit, failure),
      (transaction) {
        final message = transaction.isPending
            ? 'Withdrawal request submitted for approval'
            : 'Withdrawal of ${event.amount} tokens successful';
        _emitSuccess(emit, message);
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
      (failure) => _emitFailure(emit, failure),
      // 4.10 Optimistic: remove from approvals list immediately
      (_) => _emitSuccess(
        emit,
        'Transaction approved',
        base: state.copyWith(
          selectedCommunityApprovals: state.selectedCommunityApprovals
              .where((a) => a.transactionId != event.transactionId)
              .toList(),
        ),
      ),
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
      (failure) => _emitFailure(emit, failure),
      // 4.10 Optimistic: remove from approvals list immediately
      (_) => _emitSuccess(
        emit,
        'Transaction rejected',
        base: state.copyWith(
          selectedCommunityApprovals: state.selectedCommunityApprovals
              .where((a) => a.transactionId != event.transactionId)
              .toList(),
        ),
      ),
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
      (failure) => _emitFailure(emit, failure),
      (payoutResult) {
        _emitSuccess(
          emit,
          'Payout of ${payoutResult.amount} tokens completed successfully',
        );
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

  Future<void> _onClearSelectedCommunity(
    _ClearSelectedCommunity event,
    Emitter<CommunityState> emit,
  ) async {
    await _membersSubscription?.cancel();
    _membersSubscription = null;
    await _transactionsSubscription?.cancel();
    _transactionsSubscription = null;
    await _approvalsSubscription?.cancel();
    _approvalsSubscription = null;

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

  // 4.6 Await all subscriptions in close()
  @override
  Future<void> close() async {
    await _communitiesSubscription?.cancel();
    await _membersSubscription?.cancel();
    await _transactionsSubscription?.cancel();
    await _approvalsSubscription?.cancel();
    await _unreadSubscription?.cancel();
    return super.close();
  }
}
