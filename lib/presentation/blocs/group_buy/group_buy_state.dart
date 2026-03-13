part of 'group_buy_bloc.dart';

@freezed
class GroupBuyState with _$GroupBuyState {
  const GroupBuyState._();

  const factory GroupBuyState({
    @Default(false) bool isLoadingList,
    @Default(false) bool isLoadingDetail,
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
    @Default(false) bool isExtendingDeadline,
    String? successId,
    String? successMessage,
    @Default(false) bool shouldPopOnSuccess,
    String? errorMessage,
  }) = _GroupBuyState;

  bool get isLoading => isLoadingList || isLoadingDetail;
}
