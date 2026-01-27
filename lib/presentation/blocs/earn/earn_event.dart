part of 'earn_bloc.dart';

@freezed
class EarnEvent with _$EarnEvent {
  /// Load earn threads
  const factory EarnEvent.loadThreads() = _LoadThreads;

  /// Watch earn threads (real-time updates)
  const factory EarnEvent.watchThreads() = _WatchThreads;

  /// Select a thread to view opportunities
  const factory EarnEvent.selectThread(String threadId) = _SelectThread;

  /// Load opportunities for selected thread
  const factory EarnEvent.loadOpportunities({
    required String threadId,
    @Default(true) bool activeOnly,
  }) = _LoadOpportunities;

  /// Select an opportunity to start engagement
  const factory EarnEvent.selectOpportunity(String opportunityId) =
      _SelectOpportunity;

  /// Start engagement with an opportunity
  const factory EarnEvent.startEngagement({required String opportunityId}) =
      _StartEngagement;

  /// Update video watch progress
  const factory EarnEvent.updateWatchProgress({
    required String engagementId,
    required int watchDurationSeconds,
  }) = _UpdateWatchProgress;

  /// Submit survey answers
  const factory EarnEvent.submitSurvey({
    required String engagementId,
    required List<EngagementAnswer> answers,
    required EngagementEvidence evidence,
  }) = _SubmitSurvey;

  /// Abandon current engagement
  const factory EarnEvent.abandonEngagement(String engagementId) =
      _AbandonEngagement;

  /// Load engagement history
  const factory EarnEvent.loadHistory({int? limit}) = _LoadHistory;

  /// Load more history (pagination)
  const factory EarnEvent.loadMoreHistory() = _LoadMoreHistory;

  /// Internal: threads updated from stream
  const factory EarnEvent.threadsUpdated(List<EarnThread> threads) =
      _ThreadsUpdated;

  /// Clear error
  const factory EarnEvent.clearError() = _ClearError;

  /// Reset engagement state (after completion or abandon)
  const factory EarnEvent.resetEngagement() = _ResetEngagement;
}
