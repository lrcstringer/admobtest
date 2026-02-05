part of 'pot_bloc.dart';

enum PotStatus { initial, loading, success, failure }

@freezed
class PotState with _$PotState {
  const factory PotState({
    @Default(PotStatus.initial) PotStatus status,
    PotPool? dailyPot,
    PotPool? weeklyPot,
    @Default([]) List<UserScore> leaderboard,
    @Default([]) List<PotPool> potHistory,
    UserScore? currentUserScore,
    UserScore? dailyUserScore,
    UserScore? weeklyUserScore,
    @Default(PotType.daily) PotType selectedPotType,
    @Default(false) bool isLoadingDaily,
    @Default(false) bool isLoadingWeekly,
    @Default(false) bool isLoadingLeaderboard,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool isDailyEligible,
    @Default(false) bool isWeeklyEligible,
    String? errorMessage,
  }) = _PotState;
}
