part of 'pot_bloc.dart';

@freezed
abstract class PotEvent with _$PotEvent {
  /// Load current daily pot
  const factory PotEvent.loadDailyPot() = _LoadDailyPot;

  /// Load current weekly pot
  const factory PotEvent.loadWeeklyPot() = _LoadWeeklyPot;

  /// Watch daily pot for real-time updates
  const factory PotEvent.watchDailyPot() = _WatchDailyPot;

  /// Watch weekly pot for real-time updates
  const factory PotEvent.watchWeeklyPot() = _WatchWeeklyPot;

  /// Daily pot updated from stream
  const factory PotEvent.dailyPotUpdated(PotPool pot) = _DailyPotUpdated;

  /// Weekly pot updated from stream
  const factory PotEvent.weeklyPotUpdated(PotPool pot) = _WeeklyPotUpdated;

  /// Load leaderboard
  const factory PotEvent.loadLeaderboard({
    required PotType type,
    int? limit,
  }) = _LoadLeaderboard;

  /// Watch leaderboard for real-time updates
  const factory PotEvent.watchLeaderboard({
    required PotType type,
    int? limit,
  }) = _WatchLeaderboard;

  /// Leaderboard updated from stream
  const factory PotEvent.leaderboardUpdated(List<UserScore> scores) = _LeaderboardUpdated;

  /// Load pot history
  const factory PotEvent.loadPotHistory({
    required PotType type,
    int? limit,
  }) = _LoadPotHistory;

  /// Load current user's score
  const factory PotEvent.loadCurrentUserScore(PotType type) = _LoadCurrentUserScore;

  /// Check eligibility for pots
  const factory PotEvent.checkEligibility() = _CheckEligibility;

  /// Select pot type (daily/weekly)
  const factory PotEvent.selectPotType(PotType type) = _SelectPotType;

  /// Clear error
  const factory PotEvent.clearError() = _ClearError;
}
