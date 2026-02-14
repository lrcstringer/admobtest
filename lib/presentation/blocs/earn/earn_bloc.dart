import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/admob_constants.dart';
import '../../../core/error/failures.dart';
import '../../../data/services/admob_service.dart';
import '../../../domain/entities/earn_opportunity.dart';
import '../../../domain/entities/earn_thread.dart';
import '../../../domain/entities/engagement.dart';
import '../../../domain/enums/engagement_status.dart';
import '../../../domain/repositories/earn_repository.dart';
import '../../../domain/value_objects/engagement_evidence.dart';

part 'earn_bloc.freezed.dart';
part 'earn_event.dart';
part 'earn_state.dart';

@injectable
class EarnBloc extends Bloc<EarnEvent, EarnState> {
  final EarnRepository _earnRepository;
  final AdMobService _adMobService;

  EarnBloc(this._earnRepository, this._adMobService) : super(const EarnState()) {
    on<_LoadThreads>(_onLoadThreads);
    on<_SelectThread>(_onSelectThread);
    on<_LoadOpportunities>(_onLoadOpportunities);
    on<_SelectOpportunity>(_onSelectOpportunity);
    on<_StartEngagement>(_onStartEngagement);
    on<_UpdateWatchProgress>(_onUpdateWatchProgress);
    on<_SubmitSurvey>(_onSubmitSurvey);
    on<_AbandonEngagement>(_onAbandonEngagement);
    on<_LoadHistory>(_onLoadHistory);
    on<_LoadMoreHistory>(_onLoadMoreHistory);
    on<_Refresh>(_onRefresh);
    on<_ClearError>(_onClearError);
    on<_ResetEngagement>(_onResetEngagement);
    // AdMob event handlers
    on<_LoadAdVideo>(_onLoadAdVideo);
    on<_AdVideoCompleted>(_onAdVideoCompleted);
    on<_AdVideoFailed>(_onAdVideoFailed);
    on<_AdReadyStateChanged>(_onAdReadyStateChanged);
    on<_AdLoadingStateChanged>(_onAdLoadingStateChanged);
    on<_AdLoadAttemptChanged>(_onAdLoadAttemptChanged);
    on<_SubmitUpload>(_onSubmitUpload);
    on<_UploadProgressChanged>(_onUploadProgressChanged);

    // Listen to AdMob service state changes — route through events
    _adMobService.isAdReady.addListener(_onAdReadyChanged);
    _adMobService.isLoading.addListener(_onAdLoadingChanged);
    _adMobService.currentAttempt.addListener(_onAdAttemptChanged);
  }

  void _onAdReadyChanged() {
    if (!isClosed) {
      add(EarnEvent.adReadyStateChanged(
          isReady: _adMobService.isAdReady.value));
    }
  }

  void _onAdLoadingChanged() {
    if (!isClosed) {
      add(EarnEvent.adLoadingStateChanged(
          isLoading: _adMobService.isLoading.value));
    }
  }

  void _onAdAttemptChanged() {
    if (!isClosed) {
      add(EarnEvent.adLoadAttemptChanged(
          attempt: _adMobService.currentAttempt.value));
    }
  }

  @override
  Future<void> close() {
    _adMobService.isAdReady.removeListener(_onAdReadyChanged);
    _adMobService.isLoading.removeListener(_onAdLoadingChanged);
    _adMobService.currentAttempt.removeListener(_onAdAttemptChanged);
    return super.close();
  }

  Future<void> _onLoadThreads(
    _LoadThreads event,
    Emitter<EarnState> emit,
  ) async {
    // Only show loading spinner on first load (no cached threads).
    // On subsequent loads, keep stale data visible while refreshing.
    if (state.threads.isEmpty) {
      emit(state.copyWith(status: EarnStatus.loading));
    }

    final result = await _earnRepository.getEligibleThreads();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: EarnStatus.error,
          errorMessage: failure.displayMessage,
        ));
      },
      (threadsResult) {
        // Calculate total available opportunities
        final totalOpportunities = threadsResult.threads.fold<int>(
          0,
          (total, thread) => total + thread.availableOpportunities,
        );

        emit(state.copyWith(
          status: EarnStatus.loaded,
          threads: threadsResult.threads,
          totalAvailableOpportunities: totalOpportunities,
          dailyCompletions: threadsResult.dailyCompletions,
          dailyEarnCap: threadsResult.dailyEarnCap,
          dailyLimitReached: threadsResult.dailyLimitReached,
        ));
      },
    );
  }

  Future<void> _onSelectThread(
    _SelectThread event,
    Emitter<EarnState> emit,
  ) async {
    if (state.threads.isEmpty) return;

    final thread = state.threads.firstWhere(
      (t) => t.id == event.threadId,
      orElse: () => state.threads.first,
    );

    emit(state.copyWith(
      selectedThread: thread,
      selectedOpportunity: null,
      opportunities: [],
      opportunitiesStatus: EarnStatus.loading,
    ));

    // Load opportunities for the selected thread
    add(EarnEvent.loadOpportunities(threadId: event.threadId));
  }

  Future<void> _onLoadOpportunities(
    _LoadOpportunities event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(opportunitiesStatus: EarnStatus.loading));

    final result = await _earnRepository.getEligibleOpportunities(
      threadId: event.threadId,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          opportunitiesStatus: EarnStatus.error,
          errorMessage: failure.displayMessage,
        ));
      },
      (opportunities) {
        emit(state.copyWith(
          opportunities: opportunities,
          opportunitiesStatus: EarnStatus.loaded,
        ));
      },
    );
  }

  Future<void> _onSelectOpportunity(
    _SelectOpportunity event,
    Emitter<EarnState> emit,
  ) async {
    final result = await _earnRepository.getOpportunityById(event.opportunityId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          errorMessage: failure.displayMessage,
        ));
      },
      (opportunity) {
        emit(state.copyWith(
          selectedOpportunity: opportunity,
        ));
      },
    );
  }

  Future<void> _onStartEngagement(
    _StartEngagement event,
    Emitter<EarnState> emit,
  ) async {
    // Guard: don't start if already completed
    final opp = state.selectedOpportunity;
    if (opp != null && opp.id == event.opportunityId && opp.isCompletedByUser) {
      emit(state.copyWith(
        engagementPhase: EngagementPhase.failed,
        errorMessage: 'Already completed this opportunity',
      ));
      return;
    }

    emit(state.copyWith(engagementPhase: EngagementPhase.starting));

    final result = await _earnRepository.startEngagement(
      opportunityId: event.opportunityId,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          engagementPhase: EngagementPhase.failed,
          errorMessage: failure.displayMessage,
        ));
      },
      (engagement) {
        // Determine phase based on earning type.
        // Prefer the opportunities list (fresh from current thread) over
        // selectedOpportunity which may be stale from a previous interaction.
        final earningType =
            state.opportunities
                .where((o) => o.id == event.opportunityId)
                .map((o) => o.earningType)
                .firstOrNull ??
            (state.selectedOpportunity?.id == event.opportunityId
                ? state.selectedOpportunity?.earningType
                : null);

        final EngagementPhase phase;
        switch (earningType) {
          case EarningType.adVideo:
            phase = EngagementPhase.watchingAd;
          case EarningType.upload:
            phase = EngagementPhase.uploading;
          case EarningType.survey:
          case EarningType.poll:
            phase = EngagementPhase.surveying;
          default:
            phase = EngagementPhase.watching;
        }

        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: phase,
        ));
      },
    );
  }

  Future<void> _onUpdateWatchProgress(
    _UpdateWatchProgress event,
    Emitter<EarnState> emit,
  ) async {
    // Progress is tracked locally — no Firestore write needed.
    // The completeEngagement Cloud Function persists the final state.
    final current = state.currentEngagement;
    if (current == null || current.id != event.engagementId) return;

    final updated = current.copyWith(
      watchDurationSeconds: event.watchDurationSeconds,
    );

    final newPhase = updated.watchRequirementMet
        ? EngagementPhase.surveying
        : EngagementPhase.watching;

    emit(state.copyWith(
      currentEngagement: updated,
      engagementPhase: newPhase,
    ));
  }

  Future<void> _onSubmitSurvey(
    _SubmitSurvey event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(engagementPhase: EngagementPhase.submitting));

    final result = await _earnRepository.submitSurvey(
      engagementId: event.engagementId,
      answers: event.answers,
      evidence: event.evidence,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          engagementPhase: EngagementPhase.failed,
          errorMessage: failure.displayMessage,
        ));
      },
      (engagement) {
        // Check if the opportunity has a linked reward campaign
        final opp = state.selectedOpportunity;
        final hasReward = opp?.hasRewardCampaign ?? false;

        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: EngagementPhase.completed,
          rewardPending: hasReward,
          rewardCampaignName: hasReward ? opp?.rewardCampaignName : null,
          rewardType: hasReward ? opp?.rewardType : null,
        ));
      },
    );
  }

  Future<void> _onAbandonEngagement(
    _AbandonEngagement event,
    Emitter<EarnState> emit,
  ) async {
    final result = await _earnRepository.abandonEngagement(event.engagementId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {
        emit(state.copyWith(
          currentEngagement: null,
          engagementPhase: EngagementPhase.abandoned,
        ));
      },
    );
  }

  Future<void> _onLoadHistory(
    _LoadHistory event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(isLoadingHistory: true));

    final result = await _earnRepository.getEngagementHistory(
      limit: event.limit ?? 20,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingHistory: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (engagements) {
        emit(state.copyWith(
          isLoadingHistory: false,
          history: engagements,
          hasMoreHistory: engagements.length >= (event.limit ?? 20),
          lastHistoryTimestamp:
              engagements.isNotEmpty ? engagements.last.createdAt : null,
        ));
      },
    );
  }

  Future<void> _onLoadMoreHistory(
    _LoadMoreHistory event,
    Emitter<EarnState> emit,
  ) async {
    if (state.isLoadingHistory || !state.hasMoreHistory) {
      return;
    }

    emit(state.copyWith(isLoadingHistory: true));

    final result = await _earnRepository.getEngagementHistory(
      limit: 20,
      startAfter: state.lastHistoryTimestamp,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoadingHistory: false));
      },
      (engagements) {
        emit(state.copyWith(
          isLoadingHistory: false,
          history: [...state.history, ...engagements],
          hasMoreHistory: engagements.length >= 20,
          lastHistoryTimestamp:
              engagements.isNotEmpty ? engagements.last.createdAt : null,
        ));
      },
    );
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<EarnState> emit,
  ) async {
    // Reload threads
    final result = await _earnRepository.getEligibleThreads();

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          errorMessage: failure.displayMessage,
        ));
      },
      (threadsResult) async {
        final totalOpportunities = threadsResult.threads.fold<int>(
          0,
          (total, thread) => total + thread.availableOpportunities,
        );

        emit(state.copyWith(
          threads: threadsResult.threads,
          totalAvailableOpportunities: totalOpportunities,
          dailyCompletions: threadsResult.dailyCompletions,
          dailyEarnCap: threadsResult.dailyEarnCap,
          dailyLimitReached: threadsResult.dailyLimitReached,
        ));

        // If a thread was selected, reload its opportunities
        if (state.selectedThread != null) {
          final oppsResult = await _earnRepository.getEligibleOpportunities(
            threadId: state.selectedThread!.id,
          );

          oppsResult.fold(
            (failure) {
              // Ignore opportunity refresh failures
            },
            (opportunities) {
              emit(state.copyWith(
                opportunities: opportunities,
              ));
            },
          );
        }
      },
    );
  }

  void _onClearError(
    _ClearError event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  void _onResetEngagement(
    _ResetEngagement event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(
      currentEngagement: null,
      selectedOpportunity: null,
      engagementPhase: EngagementPhase.idle,
      adTransactionId: null,
      adResponseId: null,
      rewardPending: false,
      rewardCampaignName: null,
      rewardType: null,
    ));
  }

  // AdMob Event Handlers

  Future<void> _onLoadAdVideo(
    _LoadAdVideo event,
    Emitter<EarnState> emit,
  ) async {
    // Guard against concurrent loads (but allow retry when ad failed)
    if (state.isAdLoading) return;

    // Check if manual retry rounds are exhausted
    if (state.adRetryRound >= AdMobConstants.maxManualRetryRounds + 1) return;

    emit(state.copyWith(isAdLoading: true, adLoadAttempt: 1));

    final success = await _adMobService.loadAdWithRetry();

    if (success) {
      emit(state.copyWith(
        isAdLoading: false,
        isAdReady: true,
        adLoadAttempt: 0,
      ));
    } else {
      // All automatic retries exhausted — bump retry round
      emit(state.copyWith(
        isAdLoading: false,
        isAdReady: false,
        adLoadAttempt: 0,
        adRetryRound: state.adRetryRound + 1,
      ));
    }
  }

  Future<void> _onAdVideoCompleted(
    _AdVideoCompleted event,
    Emitter<EarnState> emit,
  ) async {
    // Update engagement with ad completion data
    final updatedEngagement = state.currentEngagement?.copyWith(
      adWatched: true,
      adTransactionId: event.transactionId,
      adCompletedAt: DateTime.now(),
    );

    emit(state.copyWith(
      currentEngagement: updatedEngagement,
      adTransactionId: event.transactionId,
      adResponseId: event.responseId,
      engagementPhase: EngagementPhase.surveying,
    ));
  }

  void _onAdVideoFailed(
    _AdVideoFailed event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(
      engagementPhase: EngagementPhase.failed,
      errorMessage: event.reason,
      adTransactionId: null,
    ));
  }

  void _onAdReadyStateChanged(
    _AdReadyStateChanged event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(isAdReady: event.isReady));
  }

  void _onAdLoadingStateChanged(
    _AdLoadingStateChanged event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(isAdLoading: event.isLoading));
  }

  void _onAdLoadAttemptChanged(
    _AdLoadAttemptChanged event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(adLoadAttempt: event.attempt));
  }

  // =========================================================================
  // Upload handlers
  // =========================================================================

  Future<void> _onSubmitUpload(
    _SubmitUpload event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(engagementPhase: EngagementPhase.submitting));

    final result = await _earnRepository.submitSurvey(
      engagementId: event.engagementId,
      answers: const [], // No survey answers for upload
      evidence: event.evidence,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          engagementPhase: EngagementPhase.failed,
          errorMessage: failure.displayMessage,
        ));
      },
      (engagement) {
        // Check if engagement is pending review
        final isPending =
            engagement.status == EngagementStatus.pendingReview;

        // Check if the opportunity has a linked reward campaign
        final opp = state.selectedOpportunity;
        final hasReward = opp?.hasRewardCampaign ?? false;

        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: EngagementPhase.completed,
          isPendingReview: isPending,
          uploadProgress: null,
          uploadBytesTransferred: null,
          uploadTotalBytes: null,
          rewardPending: hasReward,
          rewardCampaignName: hasReward ? opp?.rewardCampaignName : null,
          rewardType: hasReward ? opp?.rewardType : null,
        ));
      },
    );
  }

  void _onUploadProgressChanged(
    _UploadProgressChanged event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(
      uploadProgress: event.progress,
      uploadBytesTransferred: event.bytesTransferred,
      uploadTotalBytes: event.totalBytes,
    ));
  }

  /// Show the loaded ad and return result
  /// This is called from the UI, not through events
  Future<AdRewardResult> showAdVideo(String userId,
      {String? engagementId}) async {
    return _adMobService.showAd(
      userId: userId,
      engagementId: engagementId,
    );
  }
}
