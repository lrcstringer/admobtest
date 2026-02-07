import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

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

    // Listen to AdMob service state changes — route through events
    _adMobService.isAdReady.addListener(_onAdReadyChanged);
    _adMobService.isLoading.addListener(_onAdLoadingChanged);
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

  @override
  Future<void> close() {
    _adMobService.isAdReady.removeListener(_onAdReadyChanged);
    _adMobService.isLoading.removeListener(_onAdLoadingChanged);
    return super.close();
  }

  Future<void> _onLoadThreads(
    _LoadThreads event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(status: EarnStatus.loading));

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
        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: EngagementPhase.watching,
        ));
      },
    );
  }

  Future<void> _onUpdateWatchProgress(
    _UpdateWatchProgress event,
    Emitter<EarnState> emit,
  ) async {
    final result = await _earnRepository.updateEngagementProgress(
      engagementId: event.engagementId,
      watchDurationSeconds: event.watchDurationSeconds,
    );

    result.fold(
      (failure) {
        // Don't fail the engagement for progress update errors
      },
      (engagement) {
        final newPhase = engagement.watchRequirementMet
            ? EngagementPhase.surveying
            : EngagementPhase.watching;

        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: newPhase,
        ));
      },
    );
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
        emit(state.copyWith(
          currentEngagement: engagement,
          engagementPhase: EngagementPhase.completed,
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
    ));
  }

  // AdMob Event Handlers

  Future<void> _onLoadAdVideo(
    _LoadAdVideo event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(isAdLoading: true));

    final success = await _adMobService.loadAdWithRetry();

    emit(state.copyWith(
      isAdLoading: false,
      isAdReady: success,
    ));
  }

  Future<void> _onAdVideoCompleted(
    _AdVideoCompleted event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(
      adTransactionId: event.transactionId,
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

  /// Show the loaded ad and return result
  /// This is called from the UI, not through events
  Future<AdRewardResult> showAdVideo(String userId) async {
    return _adMobService.showAd(userId: userId);
  }

  /// Check if ad is ready to show
  bool get isAdReady => _adMobService.hasAdReady;
}
