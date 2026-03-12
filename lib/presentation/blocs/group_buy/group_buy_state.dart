part of 'group_buy_bloc.dart';

@freezed
class GroupBuyState with _$GroupBuyState {
  const factory GroupBuyState({
    @Default(false) bool isLoading,
    @Default([]) List<GroupBuy> activeGroupBuys,
    @Default([]) List<GroupBuy> myGroupBuys,
    @Default([]) List<GroupBuy> hubGroupBuys,
    GroupBuy? selectedGroupBuy,
    @Default([]) List<GroupBuyContribution> contributions,
    @Default(false) bool isCreating,
    @Default(false) bool isJoining,
    @Default(false) bool isLeaving,
    @Default(false) bool isSuggestingDeal,
    @Default(false) bool isConfirmingCollection,
    @Default(false) bool isCancelling,
    @Default(false) bool isCompleting,
    @Default(false) bool isUpdatingDelivery,
    String? successId,
    String? successMessage,
    @Default(false) bool shouldPopOnSuccess,
    String? errorMessage,
  }) = _GroupBuyState;
}
