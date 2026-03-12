import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/gooi_contribution.dart';
import '../../../domain/entities/gooi_cycle.dart';
import '../../../domain/entities/gooi_group.dart';
import '../../../domain/entities/gooi_member.dart';
import '../../../domain/entities/gooi_payout.dart';
import '../../../domain/enums/gooi_cycle_status.dart';
import '../../../domain/repositories/gooi_repository.dart';

part 'gooi_dashboard_event.dart';
part 'gooi_dashboard_state.dart';
part 'gooi_dashboard_bloc.freezed.dart';

@injectable
class GooiDashboardBloc extends Bloc<GooiDashboardEvent, GooiDashboardState> {
  final GooiRepository _repository;
  final FirebaseAuth _auth;
  bool _isProcessing = false;
  String? _groupId;

  GooiDashboardBloc(this._repository, this._auth)
      : super(const GooiDashboardState()) {
    on<_LoadGroup>(_onLoadGroup);
    on<_RefreshGroup>(_onRefreshGroup);
    on<_Contribute>(_onContribute);
    on<_TriggerPayout>(_onTriggerPayout);
    on<_ToggleAutoContribute>(_onToggleAutoContribute);
    on<_DelegateTrigger>(_onDelegateTrigger);
    on<_RevokeDelegation>(_onRevokeDelegation);
    on<_ExtendGracePeriod>(_onExtendGracePeriod);
    on<_ApplyLateFee>(_onApplyLateFee);
    on<_WaiveLateFee>(_onWaiveLateFee);
    on<_ApplyPenalty>(_onApplyPenalty);
    on<_RequestWithdrawal>(_onRequestWithdrawal);
    on<_VoteWithdrawal>(_onVoteWithdrawal);
    on<_VoteGraceExtension>(_onVoteGraceExtension);
    on<_DissolveGroup>(_onDissolveGroup);
    on<_WriteOffBadDebt>(_onWriteOffBadDebt);
  }

  Future<void> _onLoadGroup(
    _LoadGroup event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_isProcessing) return;
    _isProcessing = true;
    _groupId = event.groupId;

    try {
      emit(state.copyWith(
        isLoading: true,
        errorMessage: null,
        currentUserId: _auth.currentUser?.uid,
      ));

      await _loadGroupData(emit);
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _onRefreshGroup(
    _RefreshGroup event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_isProcessing || _groupId == null) return;
    _isProcessing = true;

    try {
      emit(state.copyWith(isRefreshing: true));
      await _loadGroupData(emit);
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _loadGroupData(Emitter<GooiDashboardState> emit) async {
    final groupId = _groupId!;

    final results = await Future.wait([
      _repository.getGroup(groupId),
      _repository.getMembers(groupId),
      _repository.getCycles(groupId),
      _repository.getPayouts(groupId),
    ]);

    final groupResult = results[0] as dynamic;
    final membersResult = results[1] as dynamic;
    final cyclesResult = results[2] as dynamic;
    final payoutsResult = results[3] as dynamic;

    var newState = state.copyWith(isLoading: false, isRefreshing: false);

    groupResult.fold(
      (failure) => newState = newState.copyWith(
        errorMessage: (failure as Failure).displayMessage,
      ),
      (group) => newState = newState.copyWith(group: group),
    );

    membersResult.fold(
      (_) {},
      (members) => newState = newState.copyWith(members: members),
    );

    cyclesResult.fold(
      (_) {},
      (cycles) {
        newState = newState.copyWith(cycles: cycles);
        // Find the current active cycle
        final activeCycle = (cycles as List<GooiCycle>).cast<GooiCycle>().where(
          (c) => c.status.isActive,
        );
        if (activeCycle.isNotEmpty) {
          newState = newState.copyWith(currentCycle: activeCycle.first);
        }
      },
    );

    payoutsResult.fold(
      (_) {},
      (payouts) => newState = newState.copyWith(payouts: payouts),
    );

    emit(newState);

    // Load contributions for current cycle if available
    if (newState.currentCycle != null) {
      final contribResult = await _repository.getContributions(
        groupId: groupId,
        cycleId: newState.currentCycle!.id,
      );
      contribResult.fold(
        (_) {},
        (contributions) => emit(
          state.copyWith(
            isLoading: false,
            isRefreshing: false,
            group: newState.group,
            members: newState.members,
            cycles: newState.cycles,
            currentCycle: newState.currentCycle,
            payouts: newState.payouts,
            contributions: contributions,
          ),
        ),
      );
    }
  }

  Future<void> _onContribute(
    _Contribute event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null || state.currentCycle == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.contribute(
      groupId: _groupId!,
      cycleId: state.currentCycle!.id,
      subAccountId: event.subAccountId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Contribution successful!',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onTriggerPayout(
    _TriggerPayout event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null || state.currentCycle == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.triggerPayout(
      groupId: _groupId!,
      cycleId: state.currentCycle!.id,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Payout triggered!',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onToggleAutoContribute(
    _ToggleAutoContribute event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.toggleAutoContribute(
      groupId: _groupId!,
      enabled: event.enabled,
      walletSubAccountId: event.walletSubAccountId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: event.enabled ? 'Auto-contribute enabled' : 'Auto-contribute disabled',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onDelegateTrigger(
    _DelegateTrigger event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.delegateTrigger(
      groupId: _groupId!,
      delegateUserId: event.delegateUserId,
      durationDays: event.durationDays,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Trigger delegated',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onRevokeDelegation(
    _RevokeDelegation event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.revokeDelegation(_groupId!);

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Delegation revoked',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onExtendGracePeriod(
    _ExtendGracePeriod event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null || state.currentCycle == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.extendGracePeriod(
      groupId: _groupId!,
      cycleId: state.currentCycle!.id,
      extensionHours: event.extensionHours,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Grace period extended by ${event.extensionHours}h',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onApplyLateFee(
    _ApplyLateFee event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.applyLateFee(
      groupId: _groupId!,
      contributionId: event.contributionId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (amount) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Late fee of R${(amount / 100).toStringAsFixed(2)} applied',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onWaiveLateFee(
    _WaiveLateFee event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.waiveLateFee(
      groupId: _groupId!,
      contributionId: event.contributionId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Late fee waived',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  // ===========================================================================
  // Phase 2 handlers
  // ===========================================================================

  Future<void> _onApplyPenalty(
    _ApplyPenalty event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.applyPenalty(
      groupId: _groupId!,
      targetUserId: event.targetUserId,
      action: event.action,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Penalty applied',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onRequestWithdrawal(
    _RequestWithdrawal event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.requestWithdrawal(
      groupId: _groupId!,
      reason: event.reason,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (withdrawalId) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Withdrawal request submitted',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onVoteWithdrawal(
    _VoteWithdrawal event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.voteWithdrawal(
      groupId: _groupId!,
      withdrawalId: event.withdrawalId,
      approve: event.approve,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: event.approve ? 'Vote: approved' : 'Vote: rejected',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onVoteGraceExtension(
    _VoteGraceExtension event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null || state.currentCycle == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.voteGraceExtension(
      groupId: _groupId!,
      cycleId: state.currentCycle!.id,
      voteId: event.voteId,
      approve: event.approve,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: event.approve ? 'Vote: extend grace' : 'Vote: no extension',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }

  Future<void> _onDissolveGroup(
    _DissolveGroup event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.dissolveGroup(_groupId!);

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Group dissolved',
        ));
      },
    );
  }

  Future<void> _onWriteOffBadDebt(
    _WriteOffBadDebt event,
    Emitter<GooiDashboardState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.writeOffBadDebt(_groupId!);

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (amount) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Bad debt of R${(amount / 100).toStringAsFixed(2)} written off',
        ));
        add(const GooiDashboardEvent.refreshGroup());
      },
    );
  }
}
