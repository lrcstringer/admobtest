part of 'group_buy_bloc.dart';

@freezed
class GroupBuyState with _$GroupBuyState {
  const factory GroupBuyState({
    @Default(false) bool isLoading,
    @Default([]) List<GroupBuy> activeGroupBuys,
    @Default([]) List<GroupBuy> myGroupBuys,
    GroupBuy? selectedGroupBuy,
    @Default([]) List<GroupBuyContribution> contributions,
    @Default(false) bool isCreating,
    @Default(false) bool isJoining,
    String? createSuccessId,
    String? joinSuccessMessage,
    String? errorMessage,
  }) = _GroupBuyState;
}
