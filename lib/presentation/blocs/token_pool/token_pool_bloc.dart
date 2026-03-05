import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/token_pool.dart';
import '../../../domain/enums/gift_style.dart';
import '../../../domain/enums/pool_mode.dart';
import '../../../domain/repositories/token_pool_repository.dart';

part 'token_pool_event.dart';
part 'token_pool_state.dart';
part 'token_pool_bloc.freezed.dart';

@injectable
class TokenPoolBloc extends Bloc<TokenPoolEvent, TokenPoolState> {
  final TokenPoolRepository _tokenPoolRepository;
  StreamSubscription? _poolSubscription;

  TokenPoolBloc(this._tokenPoolRepository) : super(const TokenPoolState()) {
    on<_CreatePool>(_onCreatePool);
    on<_Contribute>(_onContribute);
    on<_SendGroupGift>(_onSendGroupGift);
    on<_DistributePool>(_onDistributePool);
    on<_CancelPool>(_onCancelPool);
    on<_OpenGroupGift>(_onOpenGroupGift);
    on<_ClaimGroupGift>(_onClaimGroupGift);
    on<_WatchPool>(_onWatchPool);
    on<_PoolUpdated>(_onPoolUpdated);
    on<_LoadMyPools>(_onLoadMyPools);
    on<_ClearError>(_onClearError);
    on<_Reset>(_onReset);
  }

  // =========================================================================
  // POOL LIFECYCLE
  // =========================================================================

  Future<void> _onCreatePool(
    _CreatePool event,
    Emitter<TokenPoolState> emit,
  ) async {
    if (state.isCreating) return;
    emit(state.copyWith(
      isCreating: true,
      errorMessage: null,
      successMessage: null,
      activePool: null,
    ));

    final result = await _tokenPoolRepository.createPool(
      mode: event.mode,
      title: event.title,
      purpose: event.purpose,
      message: event.message,
      style: event.style,
      recipientId: event.recipientId,
      inviteeIds: event.inviteeIds,
      communityId: event.communityId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isCreating: false,
        errorMessage: failure.displayMessage,
      )),
      (pool) => emit(state.copyWith(
        isCreating: false,
        activePool: pool,
        successMessage: 'Collection room created!',
      )),
    );
  }

  Future<void> _onContribute(
    _Contribute event,
    Emitter<TokenPoolState> emit,
  ) async {
    if (state.isContributing) return;
    emit(state.copyWith(
      isContributing: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _tokenPoolRepository.contribute(
      poolId: event.poolId,
      amount: event.amount,
      anonymous: event.anonymous,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isContributing: false,
        errorMessage: failure.displayMessage,
      )),
      (pool) => emit(state.copyWith(
        isContributing: false,
        activePool: pool,
        successMessage: 'Contributed ${event.amount} tokens!',
      )),
    );
  }

  Future<void> _onSendGroupGift(
    _SendGroupGift event,
    Emitter<TokenPoolState> emit,
  ) async {
    if (state.isSending) return;
    emit(state.copyWith(
      isSending: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _tokenPoolRepository.sendGroupGift(event.poolId);

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (pool) => emit(state.copyWith(
        isSending: false,
        activePool: pool,
        successMessage: 'Group Sasaza sent!',
      )),
    );
  }

  Future<void> _onDistributePool(
    _DistributePool event,
    Emitter<TokenPoolState> emit,
  ) async {
    if (state.isDistributing) return;
    emit(state.copyWith(
      isDistributing: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _tokenPoolRepository.distributePool(
      poolId: event.poolId,
      payouts: event.payouts,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isDistributing: false,
        errorMessage: failure.displayMessage,
      )),
      (pool) => emit(state.copyWith(
        isDistributing: false,
        activePool: pool,
        successMessage: 'Pool distributed!',
      )),
    );
  }

  Future<void> _onCancelPool(
    _CancelPool event,
    Emitter<TokenPoolState> emit,
  ) async {
    if (state.isCancelling) return;
    emit(state.copyWith(
      isCancelling: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _tokenPoolRepository.cancelPool(event.poolId);

    result.fold(
      (failure) => emit(state.copyWith(
        isCancelling: false,
        errorMessage: failure.displayMessage,
      )),
      (pool) => emit(state.copyWith(
        isCancelling: false,
        activePool: pool,
        successMessage: 'Collection cancelled. Contributions refunded.',
      )),
    );
  }

  // =========================================================================
  // RECIPIENT ACTIONS
  // =========================================================================

  Future<void> _onOpenGroupGift(
    _OpenGroupGift event,
    Emitter<TokenPoolState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _tokenPoolRepository.openGroupGift(event.poolId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (pool) => emit(state.copyWith(
        isLoading: false,
        activePool: pool,
      )),
    );
  }

  Future<void> _onClaimGroupGift(
    _ClaimGroupGift event,
    Emitter<TokenPoolState> emit,
  ) async {
    if (state.isClaiming) return;
    emit(state.copyWith(
      isClaiming: true,
      errorMessage: null,
      successMessage: null,
    ));

    final result = await _tokenPoolRepository.claimGroupGift(event.poolId);

    result.fold(
      (failure) => emit(state.copyWith(
        isClaiming: false,
        errorMessage: failure.displayMessage,
      )),
      (pool) => emit(state.copyWith(
        isClaiming: false,
        activePool: pool,
        successMessage: 'Group Sasaza claimed!',
      )),
    );
  }

  // =========================================================================
  // QUERY
  // =========================================================================

  Future<void> _onWatchPool(
    _WatchPool event,
    Emitter<TokenPoolState> emit,
  ) async {
    await _poolSubscription?.cancel();
    _poolSubscription = _tokenPoolRepository.watchPool(event.poolId).listen(
      (result) {
        result.fold(
          (_) {},
          (pool) => add(TokenPoolEvent.poolUpdated(pool)),
        );
      },
    );
  }

  void _onPoolUpdated(
    _PoolUpdated event,
    Emitter<TokenPoolState> emit,
  ) {
    emit(state.copyWith(activePool: event.pool));
  }

  Future<void> _onLoadMyPools(
    _LoadMyPools event,
    Emitter<TokenPoolState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _tokenPoolRepository.getMyPools();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (pools) => emit(state.copyWith(
        isLoading: false,
        myPools: pools,
      )),
    );
  }

  // =========================================================================
  // UTILITY
  // =========================================================================

  void _onClearError(
    _ClearError event,
    Emitter<TokenPoolState> emit,
  ) {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }

  void _onReset(
    _Reset event,
    Emitter<TokenPoolState> emit,
  ) {
    emit(state.copyWith(
      activePool: null,
      errorMessage: null,
      successMessage: null,
    ));
  }

  @override
  Future<void> close() {
    _poolSubscription?.cancel();
    return super.close();
  }
}
