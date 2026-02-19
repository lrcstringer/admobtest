import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/token_spray.dart';
import '../../../domain/enums/spray_occasion.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/token_spray_repository.dart';

part 'token_spray_event.dart';
part 'token_spray_state.dart';
part 'token_spray_bloc.freezed.dart';

/// TokenSprayBloc is scoped per community — created with a communityId.
/// Use `@factoryMethod` so Injectable doesn't try to auto-create it.
@injectable
class TokenSprayBloc extends Bloc<TokenSprayEvent, TokenSprayState> {
  final TokenSprayRepository _sprayRepository;
  final String _communityId;
  StreamSubscription? _spraySubscription;

  @factoryMethod
  TokenSprayBloc(
    this._sprayRepository,
    @factoryParam this._communityId,
  ) : super(TokenSprayState(communityId: _communityId)) {
    on<_CreateSpray>(_onCreateSpray);
    on<_Contribute>(_onContribute);
    on<_CloseSpray>(_onCloseSpray);
    on<_ClaimSpray>(_onClaimSpray);
    on<_WatchSpray>(_onWatchSpray);
    on<_SprayUpdated>(_onSprayUpdated);
    on<_LoadHistory>(_onLoadHistory);
    on<_ClearError>(_onClearError);
  }

  // =========================================================================
  // CREATE
  // =========================================================================

  Future<void> _onCreateSpray(
    _CreateSpray event,
    Emitter<TokenSprayState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _sprayRepository.createSpray(
      communityId: _communityId,
      recipientId: event.recipientId,
      occasion: event.occasion,
      message: event.message,
      targetAmount: event.targetAmount,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (spray) => emit(state.copyWith(
        isLoading: false,
        activeSpray: spray,
      )),
    );
  }

  // =========================================================================
  // CONTRIBUTE
  // =========================================================================

  Future<void> _onContribute(
    _Contribute event,
    Emitter<TokenSprayState> emit,
  ) async {
    emit(state.copyWith(isContributing: true, errorMessage: null));

    final result = await _sprayRepository.contributeToSpray(
      sprayId: event.sprayId,
      amount: event.amount,
      message: event.message,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isContributing: false,
        errorMessage: failure.displayMessage,
      )),
      (spray) => emit(state.copyWith(
        isContributing: false,
        activeSpray: spray,
      )),
    );
  }

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  Future<void> _onCloseSpray(
    _CloseSpray event,
    Emitter<TokenSprayState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _sprayRepository.closeSpray(event.sprayId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (spray) => emit(state.copyWith(
        isLoading: false,
        activeSpray: spray,
      )),
    );
  }

  Future<void> _onClaimSpray(
    _ClaimSpray event,
    Emitter<TokenSprayState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _sprayRepository.claimSpray(event.sprayId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (spray) => emit(state.copyWith(
        isLoading: false,
        activeSpray: spray,
      )),
    );
  }

  // =========================================================================
  // WATCH
  // =========================================================================

  Future<void> _onWatchSpray(
    _WatchSpray event,
    Emitter<TokenSprayState> emit,
  ) async {
    await _spraySubscription?.cancel();
    _spraySubscription = _sprayRepository.watchSpray(event.sprayId).listen(
      (result) {
        result.fold(
          (_) {},
          (spray) => add(TokenSprayEvent.sprayUpdated(spray)),
        );
      },
    );
  }

  void _onSprayUpdated(
    _SprayUpdated event,
    Emitter<TokenSprayState> emit,
  ) {
    emit(state.copyWith(activeSpray: event.spray));
  }

  // =========================================================================
  // HISTORY
  // =========================================================================

  Future<void> _onLoadHistory(
    _LoadHistory event,
    Emitter<TokenSprayState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _sprayRepository.getCommunitySprayHistory(_communityId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (sprays) => emit(state.copyWith(
        isLoading: false,
        history: sprays,
      )),
    );
  }

  // =========================================================================
  // UTILITY
  // =========================================================================

  void _onClearError(
    _ClearError event,
    Emitter<TokenSprayState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _spraySubscription?.cancel();
    return super.close();
  }
}
