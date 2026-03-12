part of 'gooi_dashboard_bloc.dart';

@freezed
class GooiDashboardState with _$GooiDashboardState {
  const factory GooiDashboardState({
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isActionInProgress,
    GooiGroup? group,
    GooiCycle? currentCycle,
    @Default([]) List<GooiMember> members,
    @Default([]) List<GooiContribution> contributions,
    @Default([]) List<GooiPayout> payouts,
    @Default([]) List<GooiCycle> cycles,
    String? currentUserId,
    String? errorMessage,
    String? actionError,
    String? actionSuccess,
  }) = _GooiDashboardState;
}
