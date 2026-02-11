part of 'reward_bloc.dart';

@freezed
class RewardEvent with _$RewardEvent {
  /// Load all user reward items
  const factory RewardEvent.loadItems() = _LoadItems;

  /// Load single item detail (with decrypted code)
  const factory RewardEvent.loadItemDetail(String itemId) = _LoadItemDetail;

  /// Redeem (mark as used) a reward item
  const factory RewardEvent.redeemItem(String itemId, {String? location}) =
      _RedeemItem;

  /// Refresh items list
  const factory RewardEvent.refreshItems() = _RefreshItems;

  /// Clear the selected item detail
  const factory RewardEvent.clearSelectedItem() = _ClearSelectedItem;

  /// Clear error/success messages
  const factory RewardEvent.clearMessages() = _ClearMessages;
}
