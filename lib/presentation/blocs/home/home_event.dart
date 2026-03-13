part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent {
  /// Load dashboard data (earn opportunities and pots)
  const factory HomeEvent.loadDashboard() = _LoadDashboard;

  /// Refresh all dashboard data
  const factory HomeEvent.refreshDashboard() = _RefreshDashboard;
}
