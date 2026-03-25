part of 'earn_bloc.dart';

@freezed
abstract class EarnEvent with _$EarnEvent {
  /// Load eligible threads for the current user (via Cloud Function)
  const factory EarnEvent.loadThreads() = _LoadThreads;

  /// Select a thread to view opportunities
  const factory EarnEvent.selectThread(String threadId) = _SelectThread;

  /// Select a thread using data already in hand from the inbox — pre-populates
  /// the thread header synchronously so the screen renders without a CF round-trip.
  const factory EarnEvent.selectThreadFromInbox({
    required String threadId,
    required String title,
    String? description,
    required String clientId,
    required String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String? threadImage,
    required bool isPinned,
    required bool isFeatured,
    required int availableOpportunities,
  }) = _SelectThreadFromInbox;

  /// Load eligible opportunities for selected thread (via Cloud Function)
  const factory EarnEvent.loadOpportunities({
    required String threadId,
  }) = _LoadOpportunities;

  /// Select an opportunity to start engagement (fetches from Firestore by ID).
  /// Use [setSelectedOpportunity] instead when the full object is already in hand.
  const factory EarnEvent.selectOpportunity(String opportunityId) =
      _SelectOpportunity;

  /// Set the selected opportunity directly from an in-hand object — zero Firestore
  /// round-trip. Use this when navigating from a screen that already holds the
  /// full [EarnOpportunity] (e.g. the thread screen's opportunity list).
  const factory EarnEvent.setSelectedOpportunity(EarnOpportunity opportunity) =
      _SetSelectedOpportunity;

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

  // AdMob Events

  /// Load AdMob rewarded video ad
  const factory EarnEvent.loadAdVideo() = _LoadAdVideo;

  /// Called when ad video is fully watched and reward earned
  const factory EarnEvent.adVideoCompleted({
    required String transactionId,
    required int rewardAmount,
    String? responseId,
  }) = _AdVideoCompleted;

  /// Called when ad video fails to show or is dismissed early
  const factory EarnEvent.adVideoFailed({required String reason}) =
      _AdVideoFailed;

  /// Called when the ad show call fails (load reported ready but play failed).
  /// Tracked separately from load failures to detect persistent show issues.
  const factory EarnEvent.adShowFailed() = _AdShowFailed;

  /// Internal: AdMob ready state changed via ValueNotifier
  const factory EarnEvent.adReadyStateChanged({required bool isReady}) =
      _AdReadyStateChanged;

  /// Internal: AdMob loading state changed via ValueNotifier
  const factory EarnEvent.adLoadingStateChanged({required bool isLoading}) =
      _AdLoadingStateChanged;

  /// Internal: AdMob load attempt number changed (1-based during loading, 0 when idle)
  const factory EarnEvent.adLoadAttemptChanged({required int attempt}) =
      _AdLoadAttemptChanged;

  /// Internal: fired when loadAdWithRetry() resolves (success or exhausted).
  /// Used to track adRetryRound without blocking the event queue on the await.
  const factory EarnEvent.adLoadComplete({required bool success}) =
      _AdLoadComplete;

  // Upload Events

  /// Submit upload engagement (files already uploaded to Storage)
  const factory EarnEvent.submitUpload({
    required String engagementId,
    required List<UploadedFileEvidence> uploadedFiles,
    String? textResponse,
    required EngagementEvidence evidence,
  }) = _SubmitUpload;

  /// Update upload progress (for progress indicator)
  const factory EarnEvent.uploadProgressChanged({
    required double progress,
    required int bytesTransferred,
    required int totalBytes,
  }) = _UploadProgressChanged;
}
