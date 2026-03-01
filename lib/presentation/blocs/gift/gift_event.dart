part of 'gift_bloc.dart';

@freezed
class GiftEvent with _$GiftEvent {
  // Send
  const factory GiftEvent.sendGift({
    required String recipientId,
    required int amount,
    required String message,
    required GiftStyle style,
    String? conversationId,
    String? communityId,
  }) = _SendGift;

  // Lifecycle
  const factory GiftEvent.openGift(String giftId) = _OpenGift;
  const factory GiftEvent.claimGift(String giftId) = _ClaimGift;

  // Load
  const factory GiftEvent.loadSentGifts() = _LoadSentGifts;
  const factory GiftEvent.loadReceivedGifts() = _LoadReceivedGifts;
  const factory GiftEvent.watchGift(String giftId) = _WatchGift;
  const factory GiftEvent.giftUpdated(Gift gift) = _GiftUpdated;

  // Stats
  const factory GiftEvent.loadGiftStats() = _LoadGiftStats;

  const factory GiftEvent.clearError() = _ClearError;

  /// Reset active gift and error state (call when entering composer screen)
  const factory GiftEvent.reset() = _Reset;
}
