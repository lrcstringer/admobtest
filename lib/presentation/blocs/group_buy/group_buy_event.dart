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
    String? imageUrl,
    int? pricePerPerson,
  }) = _CreateGroupBuy;

  /// Join a group buy with a contribution
  const factory GroupBuyEvent.joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
    String? deliveryAddress,
  }) = _JoinGroupBuy;

  /// Load admin-curated group buys for the hub (Buy tab)
  const factory GroupBuyEvent.loadHubGroupBuys({
    @Default([]) List<String> userClusters,
  }) = _LoadHubGroupBuys;

  /// Leave a group buy (refund contribution)
  const factory GroupBuyEvent.leaveGroupBuy({
    required String groupBuyId,
  }) = _LeaveGroupBuy;

  /// Submit a deal suggestion for admin review
  const factory GroupBuyEvent.suggestDeal({
    required String description,
    required String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    @Default(true) bool wantsToJoin,
  }) = _SuggestDeal;

  /// Complete a group buy (organizer only, releases escrow)
  const factory GroupBuyEvent.completeGroupBuy({
    required String groupBuyId,
  }) = _CompleteGroupBuy;

  /// Clear success/error messages
  const factory GroupBuyEvent.clearMessages() = _ClearMessages;

  /// Confirm collection of a physical item
  const factory GroupBuyEvent.confirmCollection({
    required String groupBuyId,
    required String contributionId,
  }) = _ConfirmCollection;

  /// Cancel a community group buy (organizer only)
  const factory GroupBuyEvent.cancelGroupBuy({
    required String groupBuyId,
    String? reason,
  }) = _CancelGroupBuy;

  /// Update delivery status (organizer only)
  const factory GroupBuyEvent.updateDeliveryStatus({
    required String groupBuyId,
    required String deliveryStatus,
    String? trackingInfo,
  }) = _UpdateDeliveryStatus;

  /// Extend the deadline of an open group buy (organizer only)
  const factory GroupBuyEvent.extendDeadline({
    required String groupBuyId,
    required DateTime newDeadline,
  }) = _ExtendDeadline;
}
