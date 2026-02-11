part of 'reward_bloc.dart';

enum RewardLoadStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class RewardState with _$RewardState {
  const factory RewardState({
    @Default([]) List<RewardItem> items,
    RewardItem? selectedItem,
    @Default(RewardLoadStatus.initial) RewardLoadStatus status,
    @Default(RewardLoadStatus.initial) RewardLoadStatus detailStatus,
    @Default(RewardLoadStatus.initial) RewardLoadStatus redeemStatus,
    String? errorMessage,
    String? successMessage,
  }) = _RewardState;

  const RewardState._();

  /// Active (allocated) items that can still be used
  List<RewardItem> get activeItems =>
      items.where((i) => i.status == RewardItemStatus.allocated).toList();

  /// Redeemed items
  List<RewardItem> get redeemedItems =>
      items.where((i) => i.status == RewardItemStatus.redeemed).toList();

  /// Expired items
  List<RewardItem> get expiredItems =>
      items.where((i) => i.status == RewardItemStatus.expired).toList();

  /// Count of active reward items
  int get activeCount => activeItems.length;

  /// Whether user has any reward items at all
  bool get hasItems => items.isNotEmpty;

  /// Whether user has any active reward items
  bool get hasActiveItems => activeItems.isNotEmpty;
}
