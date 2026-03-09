part of 'group_buy_bloc.dart';

@freezed
class GroupBuyEvent with _$GroupBuyEvent {
  /// Load active group buys (optionally filtered by community)
  const factory GroupBuyEvent.loadActiveGroupBuys({String? communityId}) =
      _LoadActiveGroupBuys;

  /// Load a single group buy with contributions
  const factory GroupBuyEvent.loadGroupBuy(String id) = _LoadGroupBuy;

  /// Load group buys the current user has joined
  const factory GroupBuyEvent.loadMyGroupBuys() = _LoadMyGroupBuys;

  /// Create a new group buy
  const factory GroupBuyEvent.createGroupBuy({
    required String title,
    required String description,
    required int targetAmount,
    required DateTime deadline,
    String? linkedListingId,
    @Default(2) int minParticipants,
    int? maxParticipants,
  }) = _CreateGroupBuy;

  /// Join a group buy with a contribution
  const factory GroupBuyEvent.joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
  }) = _JoinGroupBuy;

  /// Clear success/error messages
  const factory GroupBuyEvent.clearMessages() = _ClearMessages;
}
