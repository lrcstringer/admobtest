import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/gift.dart';
import '../../../domain/enums/gift_style.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/gift_repository.dart';

part 'gift_event.dart';
part 'gift_state.dart';
part 'gift_bloc.freezed.dart';

@injectable
class GiftBloc extends Bloc<GiftEvent, GiftState> {
  final GiftRepository _giftRepository;
  StreamSubscription? _giftSubscription;

  GiftBloc(this._giftRepository) : super(const GiftState()) {
    on<_SendGift>(_onSendGift);
    on<_OpenGift>(_onOpenGift);
    on<_ClaimGift>(_onClaimGift);
    on<_LoadSentGifts>(_onLoadSentGifts);
    on<_LoadReceivedGifts>(_onLoadReceivedGifts);
    on<_WatchGift>(_onWatchGift);
    on<_GiftUpdated>(_onGiftUpdated);
    on<_LoadGiftStats>(_onLoadGiftStats);
    on<_ClearError>(_onClearError);
    on<_Reset>(_onReset);
  }

  // =========================================================================
  // SEND
  // =========================================================================

  Future<void> _onSendGift(
    _SendGift event,
    Emitter<GiftState> emit,
  ) async {
    // Guard against duplicate sends
    if (state.isSending) return;
    emit(state.copyWith(isSending: true, errorMessage: null, activeGift: null));

    final result = await _giftRepository.sendGift(
      recipientId: event.recipientId,
      amount: event.amount,
      message: event.message,
      style: event.style,
      conversationId: event.conversationId,
      communityId: event.communityId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (gift) => emit(state.copyWith(
        isSending: false,
        activeGift: gift,
      )),
    );
  }

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  Future<void> _onOpenGift(
    _OpenGift event,
    Emitter<GiftState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null, activeGift: null));

    final result = await _giftRepository.openGift(event.giftId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (gift) => emit(state.copyWith(
        isLoading: false,
        activeGift: gift,
      )),
    );
  }

  Future<void> _onClaimGift(
    _ClaimGift event,
    Emitter<GiftState> emit,
  ) async {
    if (state.isClaiming) return;
    emit(state.copyWith(isClaiming: true, errorMessage: null, activeGift: null));

    final result = await _giftRepository.claimGift(event.giftId);

    result.fold(
      (failure) => emit(state.copyWith(
        isClaiming: false,
        errorMessage: failure.displayMessage,
      )),
      (gift) => emit(state.copyWith(
        isClaiming: false,
        activeGift: gift,
      )),
    );
  }

  // =========================================================================
  // LOAD
  // =========================================================================

  Future<void> _onLoadSentGifts(
    _LoadSentGifts event,
    Emitter<GiftState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _giftRepository.getSentGifts();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (gifts) => emit(state.copyWith(
        isLoading: false,
        sentGifts: gifts,
      )),
    );
  }

  Future<void> _onLoadReceivedGifts(
    _LoadReceivedGifts event,
    Emitter<GiftState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _giftRepository.getReceivedGifts();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (gifts) => emit(state.copyWith(
        isLoading: false,
        receivedGifts: gifts,
      )),
    );
  }

  Future<void> _onWatchGift(
    _WatchGift event,
    Emitter<GiftState> emit,
  ) async {
    await _giftSubscription?.cancel();
    _giftSubscription = _giftRepository.watchGift(event.giftId).listen(
      (result) {
        result.fold(
          (_) {},
          (gift) => add(GiftEvent.giftUpdated(gift)),
        );
      },
    );
  }

  void _onGiftUpdated(
    _GiftUpdated event,
    Emitter<GiftState> emit,
  ) {
    // Only update if the incoming gift matches the current activeGift.
    // Prevents stale stream events from overwriting a different active gift.
    if (state.activeGift == null || state.activeGift!.id == event.gift.id) {
      emit(state.copyWith(activeGift: event.gift));
    }
  }

  // =========================================================================
  // STATS
  // =========================================================================

  Future<void> _onLoadGiftStats(
    _LoadGiftStats event,
    Emitter<GiftState> emit,
  ) async {
    final result = await _giftRepository.getGiftStats();

    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: failure.displayMessage,
      )),
      (stats) => emit(state.copyWith(stats: stats)),
    );
  }

  // =========================================================================
  // UTILITY
  // =========================================================================

  void _onClearError(
    _ClearError event,
    Emitter<GiftState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  void _onReset(
    _Reset event,
    Emitter<GiftState> emit,
  ) {
    emit(state.copyWith(activeGift: null, errorMessage: null));
  }

  @override
  Future<void> close() {
    _giftSubscription?.cancel();
    return super.close();
  }
}
