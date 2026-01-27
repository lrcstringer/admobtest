part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  /// Load dashboard data
  const factory HomeEvent.loadDashboard() = _LoadDashboard;

  /// Refresh all dashboard data
  const factory HomeEvent.refreshDashboard() = _RefreshDashboard;

  /// Start watching wallet updates
  const factory HomeEvent.watchWallet() = _WatchWallet;

  /// Wallet was updated
  const factory HomeEvent.walletUpdated(Wallet wallet) = _WalletUpdated;

  /// Stop watching updates
  const factory HomeEvent.stopWatching() = _StopWatching;
}
