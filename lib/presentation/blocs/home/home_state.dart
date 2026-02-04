part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial) HomeStatus status,
    @Default([]) List<EarnThread> earnOpportunities,
    @Default([]) List<PotPool> activePots,
    @Default(false) bool isRefreshing,
    DateTime? lastRefresh,
    String? errorMessage,
  }) = _HomeState;
}

extension HomeStateX on HomeState {
  bool get isLoading => status == HomeStatus.loading;
  bool get isLoaded => status == HomeStatus.loaded;
  bool get hasError => status == HomeStatus.error;

  /// Get greeting based on time of day
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  /// Get number of available earn opportunities
  int get availableOpportunities => earnOpportunities.length;

  /// Check if there are active pots
  bool get hasActivePots => activePots.isNotEmpty;
}
