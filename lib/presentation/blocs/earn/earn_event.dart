part of 'earn_bloc.dart';

@freezed
class EarnEvent with _$EarnEvent {
  /// Load eligible threads for the current user (via Cloud Function)
  const factory EarnEvent.loadThreads() = _LoadThreads;

  /// Select a thread to view opportunities
  const factory EarnEvent.selectThread(String threadId) = _SelectThread;

  /// Load eligible opportunities for selected thread (via Cloud Function)
  const factory EarnEvent.loadOpportunities({
    required String threadId,
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

  /// Refresh threads and opportunities (pull to refresh)
  const factory EarnEvent.refresh() = _Refresh;

  /// Clear error
  const factory EarnEvent.clearError() = _ClearError;

  /// Reset engagement state (after completion or abandon)
  const factory EarnEvent.resetEngagement() = _ResetEngagement;
}
