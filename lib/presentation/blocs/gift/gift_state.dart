part of 'gift_bloc.dart';

@freezed
abstract class GiftState with _$GiftState {
  const factory GiftState({
    @Default([]) List<Gift> sentGifts,
    @Default([]) List<Gift> receivedGifts,
    Gift? activeGift,
    GiftStats? stats,
    @Default(false) bool isLoading,
    @Default(false) bool isSending,
    @Default(false) bool isClaiming,
    String? errorMessage,
  }) = _GiftState;
}
