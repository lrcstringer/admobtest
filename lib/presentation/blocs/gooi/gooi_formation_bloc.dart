import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/gooi_group.dart';
import '../../../domain/entities/gooi_member.dart';
import '../../../domain/enums/gooi_cycle_frequency.dart';
import '../../../domain/enums/gooi_roster_method.dart';
import '../../../domain/repositories/gooi_repository.dart';

part 'gooi_formation_event.dart';
part 'gooi_formation_state.dart';
part 'gooi_formation_bloc.freezed.dart';

@injectable
class GooiFormationBloc extends Bloc<GooiFormationEvent, GooiFormationState> {
  final GooiRepository _repository;
  bool _isProcessing = false;
  String? _groupId;

  GooiFormationBloc(this._repository) : super(const GooiFormationState()) {
    on<_CreateGroup>(_onCreateGroup);
    on<_LoadFormationGroup>(_onLoadGroup);
    on<_InviteMember>(_onInviteMember);
    on<_RespondInvitation>(_onRespondInvitation);
    on<_LockRoster>(_onLockRoster);
    on<_SubmitBid>(_onSubmitBid);
    on<_ConfirmActivation>(_onConfirmActivation);
    on<_DissolveGroup>(_onDissolveGroup);
  }

  Future<void> _onCreateGroup(
    _CreateGroup event,
    Emitter<GooiFormationState> emit,
  ) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      emit(state.copyWith(
        isActionInProgress: true,
        actionError: null,
        actionSuccess: null,
      ));

      final result = await _repository.createGroup(
        name: event.name,
        contributionAmount: event.contributionAmount,
        cycleFrequency: event.cycleFrequency,
        totalCycles: event.totalCycles,
        rosterMethod: event.rosterMethod,
        gracePeriodHours: event.gracePeriodHours,
        lateFeePercent: event.lateFeePercent,
        recipientContributes: event.recipientContributes,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          isActionInProgress: false,
          actionError: failure.displayMessage,
        )),
        (groupId) {
          _groupId = groupId;
          emit(state.copyWith(
            isActionInProgress: false,
            createdGroupId: groupId,
            actionSuccess: 'Group created! Now invite members.',
          ));
        },
      );
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _onLoadGroup(
    _LoadFormationGroup event,
    Emitter<GooiFormationState> emit,
  ) async {
    if (_isProcessing) return;
    _isProcessing = true;
    _groupId = event.groupId;

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final results = await Future.wait([
        _repository.getGroup(event.groupId),
        _repository.getMembers(event.groupId),
      ]);

      final groupResult = results[0] as dynamic;
      final membersResult = results[1] as dynamic;

      var newState = state.copyWith(isLoading: false);

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

      emit(newState);
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _onInviteMember(
    _InviteMember event,
    Emitter<GooiFormationState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.inviteMember(
      groupId: _groupId!,
      inviteeUserId: event.inviteeUserId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: 'Invitation sent!',
        ));
        add(GooiFormationEvent.loadGroup(_groupId!));
      },
    );
  }

  Future<void> _onRespondInvitation(
    _RespondInvitation event,
    Emitter<GooiFormationState> emit,
  ) async {
    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.respondInvitation(
      groupId: event.groupId,
      accept: event.accept,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isActionInProgress: false,
        actionSuccess: event.accept ? 'Invitation accepted!' : 'Invitation declined',
      )),
    );
  }

  Future<void> _onLockRoster(
    _LockRoster event,
    Emitter<GooiFormationState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.lockRoster(
      groupId: _groupId!,
      proposedOrder: event.proposedOrder,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (order) {
        emit(state.copyWith(
          isActionInProgress: false,
          rosterOrder: order,
          actionSuccess: 'Roster locked!',
        ));
        add(GooiFormationEvent.loadGroup(_groupId!));
      },
    );
  }

  Future<void> _onSubmitBid(
    _SubmitBid event,
    Emitter<GooiFormationState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.submitBid(
      groupId: _groupId!,
      targetPosition: event.targetPosition,
      bidPercent: event.bidPercent,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isActionInProgress: false,
        actionSuccess: 'Bid submitted!',
      )),
    );
  }

  Future<void> _onConfirmActivation(
    _ConfirmActivation event,
    Emitter<GooiFormationState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.confirmActivation(_groupId!);

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (activated) {
        emit(state.copyWith(
          isActionInProgress: false,
          actionSuccess: activated
              ? 'Group is now ACTIVE! First cycle begins.'
              : 'Confirmation recorded. Waiting for other members.',
        ));
        if (activated) {
          add(GooiFormationEvent.loadGroup(_groupId!));
        }
      },
    );
  }

  Future<void> _onDissolveGroup(
    _DissolveGroup event,
    Emitter<GooiFormationState> emit,
  ) async {
    if (_groupId == null) return;

    emit(state.copyWith(isActionInProgress: true, actionError: null, actionSuccess: null));

    final result = await _repository.dissolveGroup(_groupId!);

    result.fold(
      (failure) => emit(state.copyWith(
        isActionInProgress: false,
        actionError: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isActionInProgress: false,
        actionSuccess: 'Group dissolved',
      )),
    );
  }
}
