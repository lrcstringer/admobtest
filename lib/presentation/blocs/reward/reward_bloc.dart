import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/reward_item.dart';
import '../../../domain/enums/reward_enums.dart';
import '../../../domain/repositories/reward_repository.dart';

part 'reward_bloc.freezed.dart';
part 'reward_event.dart';
part 'reward_state.dart';

@injectable
class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepository _rewardRepository;

  RewardBloc(this._rewardRepository) : super(const RewardState()) {
    on<_LoadItems>(_onLoadItems);
    on<_LoadItemDetail>(_onLoadItemDetail);
    on<_RedeemItem>(_onRedeemItem);
    on<_RefreshItems>(_onRefreshItems);
    on<_ClearSelectedItem>(_onClearSelectedItem);
    on<_ClearMessages>(_onClearMessages);
  }

  Future<void> _onLoadItems(
    _LoadItems event,
    Emitter<RewardState> emit,
  ) async {
    emit(state.copyWith(status: RewardLoadStatus.loading));

    final result = await _rewardRepository.getUserRewardItems();

    result.fold(
      (failure) => emit(state.copyWith(
        status: RewardLoadStatus.error,
        errorMessage: failure.displayMessage,
      )),
      (items) => emit(state.copyWith(
        status: RewardLoadStatus.loaded,
        items: items,
      )),
    );
  }

  Future<void> _onLoadItemDetail(
    _LoadItemDetail event,
    Emitter<RewardState> emit,
  ) async {
    emit(state.copyWith(detailStatus: RewardLoadStatus.loading));

    final result = await _rewardRepository.getRewardItemDetail(event.itemId);

    result.fold(
      (failure) => emit(state.copyWith(
        detailStatus: RewardLoadStatus.error,
        errorMessage: failure.displayMessage,
      )),
      (item) => emit(state.copyWith(
        detailStatus: RewardLoadStatus.loaded,
        selectedItem: item,
      )),
    );
  }

  Future<void> _onRedeemItem(
    _RedeemItem event,
    Emitter<RewardState> emit,
  ) async {
    emit(state.copyWith(redeemStatus: RewardLoadStatus.loading));

    final result = await _rewardRepository.redeemRewardItem(
      event.itemId,
      location: event.location,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        redeemStatus: RewardLoadStatus.error,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        // Update the selected item to redeemed status locally
        // Use UTC to match Firestore server timestamps
        final now = DateTime.now().toUtc();
        final updatedSelected = state.selectedItem?.copyWith(
          status: RewardItemStatus.redeemed,
          redeemedAt: now,
        );

        // Update the item in the list too
        final updatedItems = state.items.map((item) {
          if (item.id == event.itemId) {
            return item.copyWith(
              status: RewardItemStatus.redeemed,
              redeemedAt: now,
            );
          }
          return item;
        }).toList();

        emit(state.copyWith(
          redeemStatus: RewardLoadStatus.loaded,
          selectedItem: updatedSelected,
          items: updatedItems,
          successMessage: 'Reward marked as used!',
        ));
      },
    );
  }

  Future<void> _onRefreshItems(
    _RefreshItems event,
    Emitter<RewardState> emit,
  ) async {
    final result = await _rewardRepository.getUserRewardItems();

    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: failure.displayMessage,
      )),
      (items) => emit(state.copyWith(
        status: RewardLoadStatus.loaded,
        items: items,
      )),
    );
  }

  void _onClearSelectedItem(
    _ClearSelectedItem event,
    Emitter<RewardState> emit,
  ) {
    emit(state.copyWith(
      selectedItem: null,
      detailStatus: RewardLoadStatus.initial,
    ));
  }

  void _onClearMessages(
    _ClearMessages event,
    Emitter<RewardState> emit,
  ) {
    emit(state.copyWith(
      errorMessage: null,
      successMessage: null,
    ));
  }
}
