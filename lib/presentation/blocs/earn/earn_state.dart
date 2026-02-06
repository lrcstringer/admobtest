part of 'earn_bloc.dart';

enum EarnStatus {
  initial,
  loading,
  loaded,
  error,
}

enum EngagementPhase {
  idle,
  starting,
  watching,
  surveying,
  submitting,
  completed,
  failed,
  abandoned,
}

@freezed
class EarnState with _$EarnState {
  const factory EarnState({
    @Default(EarnStatus.initial) EarnStatus status,
    @Default([]) List<EarnThread> threads,
    EarnThread? selectedThread,
    @Default(EarnStatus.initial) EarnStatus opportunitiesStatus,
    @Default([]) List<EarnOpportunity> opportunities,
    EarnOpportunity? selectedOpportunity,
    Engagement? currentEngagement,
    @Default(EngagementPhase.idle) EngagementPhase engagementPhase,
    @Default([]) List<Engagement> history,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool hasMoreHistory,
    DateTime? lastHistoryTimestamp,
    String? errorMessage,
    @Default(0) int totalAvailableOpportunities,
    // Daily completion limit
    @Default(0) int dailyCompletions,
    @Default(30) int dailyEarnCap,
    @Default(false) bool dailyLimitReached,
  }) = _EarnState;

  const EarnState._();

  /// Check if currently in an active engagement
  bool get hasActiveEngagement =>
      currentEngagement != null &&
      (engagementPhase == EngagementPhase.watching ||
          engagementPhase == EngagementPhase.surveying);

  /// Get total tokens earned today (from history)
  int get tokensEarnedToday {
    final today = DateTime.now();
    return history
        .where((e) =>
            e.completedAt != null &&
            e.completedAt!.year == today.year &&
            e.completedAt!.month == today.month &&
            e.completedAt!.day == today.day &&
            e.tokensEarned != null)
        .fold(0, (sum, e) => sum + (e.tokensEarned ?? 0));
  }

  /// Get completed engagements count
  int get completedCount =>
      history.where((e) => e.status == EngagementStatus.completed).length;
}
