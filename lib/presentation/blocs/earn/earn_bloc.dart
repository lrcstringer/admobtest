import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
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
  StreamSubscription? _threadsSubscription;

  EarnBloc(this._earnRepository) : super(const EarnState()) {
    on<_LoadThreads>(_onLoadThreads);
    on<_WatchThreads>(_onWatchThreads);
    on<_SelectThread>(_onSelectThread);
    on<_LoadOpportunities>(_onLoadOpportunities);
    on<_SelectOpportunity>(_onSelectOpportunity);
    on<_StartEngagement>(_onStartEngagement);
    on<_UpdateWatchProgress>(_onUpdateWatchProgress);
    on<_SubmitSurvey>(_onSubmitSurvey);
    on<_AbandonEngagement>(_onAbandonEngagement);
    on<_LoadHistory>(_onLoadHistory);
    on<_LoadMoreHistory>(_onLoadMoreHistory);
    on<_ThreadsUpdated>(_onThreadsUpdated);
    on<_ClearError>(_onClearError);
    on<_ResetEngagement>(_onResetEngagement);
  }

  Future<void> _onLoadThreads(
    _LoadThreads event,
    Emitter<EarnState> emit,
  ) async {
    emit(state.copyWith(status: EarnStatus.loading));

    final result = await _earnRepository.getEarnThreads();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: EarnStatus.error,
          errorMessage: failure.displayMessage,
        ));
      },
      (threads) {
        emit(state.copyWith(
          status: EarnStatus.loaded,
          threads: threads,
        ));
        // Start watching for real-time updates
        add(const EarnEvent.watchThreads());
      },
    );
  }

  void _onWatchThreads(
    _WatchThreads event,
    Emitter<EarnState> emit,
  ) {
    _threadsSubscription?.cancel();
    _threadsSubscription = _earnRepository.watchEarnThreads().listen(
      (result) {
        result.fold(
          (failure) {
            // Don't emit error for stream failures
          },
          (threads) {
            add(EarnEvent.threadsUpdated(threads));
          },
        );
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
      opportunities: [],
    ));

    // Load opportunities for the selected thread
    add(EarnEvent.loadOpportunities(threadId: event.threadId));
  }

  Future<void> _onLoadOpportunities(
    _LoadOpportunities event,
    Emitter<EarnState> emit,
  ) async {
    final result = await _earnRepository.getOpportunities(
      threadId: event.threadId,
      activeOnly: event.activeOnly,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          errorMessage: failure.displayMessage,
        ));
      },
      (opportunities) {
        emit(state.copyWith(
          opportunities: opportunities,
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

  void _onThreadsUpdated(
    _ThreadsUpdated event,
    Emitter<EarnState> emit,
  ) {
    emit(state.copyWith(threads: event.threads));
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
    ));
  }

  @override
  Future<void> close() {
    _threadsSubscription?.cancel();
    return super.close();
  }
}
