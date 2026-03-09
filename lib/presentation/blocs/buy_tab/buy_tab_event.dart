part of 'buy_tab_bloc.dart';

@freezed
class BuyTabEvent with _$BuyTabEvent {
  /// Load buy tab data (categories, feature flags)
  const factory BuyTabEvent.loadBuyTab() = _LoadBuyTab;

  /// Refresh buy tab data (pull-to-refresh)
  const factory BuyTabEvent.refreshBuyTab() = _RefreshBuyTab;
}
