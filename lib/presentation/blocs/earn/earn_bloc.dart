import 'dart:async';

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
    on<_SelectThreadFromInbox>(_onSelectThreadFromInbox);
    on<_LoadOpportunities>(_onLoadOpportunities);
    on<_SelectOpportunity>(_onSelectOpportunity);
    on<_SetSelectedOpportunity>(_onSetSelectedOpportunity);
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
    on<_AdShowFailed>(_onAdShowFailed);
    on<_AdReadyStateChanged>(_onAdReadyStateChanged);
    on<_AdLoadingStateChanged>(_onAdLoadingStateChanged);
    on<_AdLoadAttemptChanged>(_onAdLoadAttemptChanged);
    on<_AdLoadComplete>(_onAdLoadComplete);
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
    // Find the thread in state (null on deep-link or if not yet loaded).
    // firstWhere with wrong orElse would silently return threads[0] for
    // unrecognised IDs — use firstOrNull instead.
    final thread = state.threads.isEmpty
        ? null
        : state.threads.where((t) => t.id == event.threadId).firstOrNull;

    emit(state.copyWith(
      selectedThread: thread,
      selectedOpportunity: null,
      opportunities: [],
      opportunitiesStatus: EarnStatus.loading,
      opportunitiesThreadId: null, // clear so _buildBody guard fires correctly
    ));

    // Load opportunities for the selected thread regardless of threads list
    add(EarnEvent.loadOpportunities(threadId: event.threadId));
  }

  Future<void> _onSelectThreadFromInbox(
    _SelectThreadFromInbox event,
    Emitter<EarnState> emit,
  ) async {
    // If opportunities for this thread are already loaded, just set the
    // selectedThread stub and skip the CF round-trip entirely.
    if (state.opportunitiesThreadId == event.threadId &&
        state.opportunitiesStatus == EarnStatus.loaded &&
        state.opportunities.isNotEmpty) {
      final stub = _threadStubFromEvent(event);
      emit(state.copyWith(selectedThread: stub));
      return;
    }

    // Synchronously pre-populate the thread header so the screen renders
    // immediately without waiting for the CF response.
    final stub = _threadStubFromEvent(event);
    emit(state.copyWith(
      selectedThread: stub,
      selectedOpportunity: null,
      opportunities: [],
      opportunitiesStatus: EarnStatus.loading,
    ));

    add(EarnEvent.loadOpportunities(threadId: event.threadId));
  }

  /// Builds a minimal [EarnThread] from inline inbox data — no Firestore call.
  EarnThread _threadStubFromEvent(_SelectThreadFromInbox event) {
    return EarnThread(
      id: event.threadId,
      clientId: event.clientId,
      clientName: event.clientName,
      clientAvatarImage: event.clientAvatarImage,
      clientAvatarColor: event.clientAvatarColor,
      threadImage: event.threadImage,
      title: event.title,
      description: event.description,
      isPinned: event.isPinned,
      isFeatured: event.isFeatured,
      isActive: true,
      availableOpportunities: event.availableOpportunities,
      completedOpportunities: 0,
      createdAt: DateTime.now(),
    );
  }

  Future<void> _onLoadOpportunities(
    _LoadOpportunities event,
    Emitter<EarnState> emit,
  ) async {
    // Phase 1: serve stale cache immediately so the screen renders without
    // waiting for the CF. Skip loading indicator if we have cached data.
    final cached =
        await _earnRepository.getCachedOpportunities(event.threadId);
    if (cached != null && cached.isNotEmpty) {
      emit(state.copyWith(
        opportunities: cached,
        opportunitiesStatus: EarnStatus.loaded,
        opportunitiesThreadId: event.threadId,
      ));
    } else {
      emit(state.copyWith(opportunitiesStatus: EarnStatus.loading));
    }

    // Phase 2: always fetch fresh data in the background.
    // Pass forceRefresh=true when cache existed so the server skips its own
    // TTL check and returns up-to-date engagement status.
    final result = await _earnRepository.getEligibleOpportunities(
      threadId: event.threadId,
      forceRefresh: cached != null,
    );

    result.fold(
      (failure) {
        // If we already rendered stale data, fail silently.
        if (cached == null) {
          emit(state.copyWith(
            opportunitiesStatus: EarnStatus.error,
            errorMessage: failure.displayMessage,
          ));
        }
      },
      (opportunities) {
        // Guard: if the user navigated to a different thread while this CF was
        // in-flight, the selectThread/selectThreadFromInbox handler has already
        // cleared opportunitiesThreadId (set to null) or set it to the new
        // thread. Drop this stale result to avoid flashing A's data under B.
        final currentId = state.opportunitiesThreadId;
        if (currentId != null && currentId != event.threadId) return;

        emit(state.copyWith(
          opportunities: opportunities,
          opportunitiesStatus: EarnStatus.loaded,
          opportunitiesThreadId: event.threadId,
        ));
      },
    );
  }

  void _onSetSelectedOpportunity(
    _SetSelectedOpportunity event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(
      selectedOpportunity: event.opportunity,
      currentEngagement: null,
      engagementPhase: EngagementPhase.idle,
      errorMessage: null,
      adTransactionId: null,
      adResponseId: null,
      rewardItemId: null,
      rewardCampaignName: null,
      rewardType: null,
    ));
  }

  Future<void> _onSelectOpportunity(
    _SelectOpportunity event,
    Emitter<EarnState> emit,
  ) async {
    // Idempotent: skip the Firestore fetch if we already have this opportunity.
    // Prevents a duplicate round-trip when selectOpportunity is dispatched at
    // navigation time and again as a fallback in initState.
    if (state.selectedOpportunity?.id == event.opportunityId) return;

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
          currentEngagement: null,
          engagementPhase: EngagementPhase.idle,
          errorMessage: null,
          adTransactionId: null,
          adResponseId: null,
          rewardItemId: null,
          rewardCampaignName: null,
          rewardType: null,
        ));
      },
    );
  }

  Future<void> _onStartEngagement(
    _StartEngagement event,
    Emitter<EarnState> emit,
  ) async {
    // Guard: don't start if already in-flight or an engagement exists.
    // Prevents a queued duplicate event from firing a second CF call after
    // the first has already progressed past idle.
    if (state.engagementPhase == EngagementPhase.starting ||
        state.currentEngagement != null) {
      return;
    }

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
    // Progress is tracked locally — no repository call is made here.
    //
    // Design rationale: writing watch duration to Firestore every second would
    // generate ~3,600 writes/hour per active user. Instead, the current value
    // is held in BLoC state and submitted once as part of the evidence object
    // when processEngagement is called. The server validates the submitted
    // duration against elapsed wall-clock time (server-side M2 monotonicity
    // check in the updateEngagementProgress CF).
    //
    // EarnRepository.updateEngagementProgress exists for external / direct
    // callers and is not used by this BLoC flow.
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
    // Guard: duplicate event (double-press) must not re-submit once in-flight.
    if (state.engagementPhase == EngagementPhase.submitting ||
        state.engagementPhase == EngagementPhase.optimistic ||
        state.engagementPhase == EngagementPhase.completed) {
      return;
    }

    // Upload engagements have an unknown outcome (pending review / rejected)
    // so they wait for the CF. All other types are deterministically successful
    // once submitted — show the success screen immediately (optimistic UI).
    final isUpload =
        state.selectedOpportunity?.earningType == EarningType.upload;

    emit(state.copyWith(
      engagementPhase:
          isUpload ? EngagementPhase.submitting : EngagementPhase.optimistic,
    ));

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
        // Mark the opportunity as completed in the local list so the thread
        // screen immediately renders it as done without a full refresh.
        final updatedOpportunities = state.opportunities.map((o) {
          if (o.id == engagement.earnOpportunityId) {
            return o.copyWith(userEngagementStatus: 'completed');
          }
          return o;
        }).toList();

        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: EngagementPhase.completed,
          isPendingReview: engagement.status == EngagementStatus.pendingReview,
          rewardItemId: engagement.rewardItemId,
          rewardCampaignName: engagement.rewardCampaignName,
          rewardType: engagement.rewardType,
          opportunities: updatedOpportunities,
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
      rewardItemId: null,
      rewardCampaignName: null,
      rewardType: null,
      adShowFailureCount: 0,
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

    // Fire and forget — do NOT await. The BLoC event queue would be blocked
    // for the full ad load duration (2–5 s) if we awaited here, preventing
    // startEngagement from running in parallel.
    //
    // isAdLoading / isAdReady / adLoadAttempt are kept in sync by the
    // ValueNotifier listeners registered in the constructor. adLoadComplete
    // handles the retry-round increment when all retries are exhausted.
    // catchError ensures unexpected throws from the AdMob SDK don't produce
    // unhandled Future exceptions that leave isAdLoading stuck at true.
    unawaited(_adMobService.loadAdWithRetry().then((success) {
      if (!isClosed) add(EarnEvent.adLoadComplete(success: success));
    }).catchError((_) {
      if (!isClosed) add(const EarnEvent.adLoadComplete(success: false));
    }));
  }

  void _onAdLoadComplete(
    _AdLoadComplete event,
    Emitter<EarnState> emit,
  ) {
    if (!event.success) {
      // All automatic retries exhausted — bump retry round so the UI can
      // show the "unavailable" state and gate further manual retries.
      emit(state.copyWith(adRetryRound: state.adRetryRound + 1));
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
      adShowFailureCount: 0,
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

  void _onAdShowFailed(
    _AdShowFailed event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(
      adShowFailureCount: state.adShowFailureCount + 1,
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
    if (state.engagementPhase == EngagementPhase.submitting ||
        state.engagementPhase == EngagementPhase.completed) {
      return;
    }

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

        // Mark the opportunity as completed in the local list so the thread
        // screen immediately renders it as done without a full refresh.
        final updatedOpportunities = state.opportunities.map((o) {
          if (o.id == engagement.earnOpportunityId) {
            return o.copyWith(userEngagementStatus: 'completed');
          }
          return o;
        }).toList();

        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: EngagementPhase.completed,
          isPendingReview: isPending,
          uploadProgress: null,
          uploadBytesTransferred: null,
          uploadTotalBytes: null,
          rewardItemId: engagement.rewardItemId,
          rewardCampaignName: engagement.rewardCampaignName,
          rewardType: engagement.rewardType,
          opportunities: updatedOpportunities,
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
