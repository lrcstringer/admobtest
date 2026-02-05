import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/pot_pool.dart';
import '../../../domain/entities/user_score.dart';
import '../../../domain/enums/pot_type.dart';
import '../../../domain/repositories/gamification_repository.dart';

part 'pot_event.dart';
part 'pot_state.dart';
part 'pot_bloc.freezed.dart';

@injectable
class PotBloc extends Bloc<PotEvent, PotState> {
  final GamificationRepository _gamificationRepository;
  StreamSubscription? _dailyPotSubscription;
  StreamSubscription? _weeklyPotSubscription;
  StreamSubscription? _leaderboardSubscription;

  PotBloc(this._gamificationRepository) : super(const PotState()) {
    on<_LoadDailyPot>(_onLoadDailyPot);
    on<_LoadWeeklyPot>(_onLoadWeeklyPot);
    on<_WatchDailyPot>(_onWatchDailyPot);
    on<_WatchWeeklyPot>(_onWatchWeeklyPot);
    on<_DailyPotUpdated>(_onDailyPotUpdated);
    on<_WeeklyPotUpdated>(_onWeeklyPotUpdated);
    on<_LoadLeaderboard>(_onLoadLeaderboard);
    on<_WatchLeaderboard>(_onWatchLeaderboard);
    on<_LeaderboardUpdated>(_onLeaderboardUpdated);
    on<_LoadPotHistory>(_onLoadPotHistory);
    on<_LoadCurrentUserScore>(_onLoadCurrentUserScore);
    on<_CheckEligibility>(_onCheckEligibility);
    on<_SelectPotType>(_onSelectPotType);
    on<_ClearError>(_onClearError);
  }

  Future<void> _onLoadDailyPot(
    _LoadDailyPot event,
    Emitter<PotState> emit,
  ) async {
    emit(state.copyWith(isLoadingDaily: true));

    final result = await _gamificationRepository.getCurrentDailyPot();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingDaily: false,
        errorMessage: failure.displayMessage,
      )),
      (pot) => emit(state.copyWith(
        isLoadingDaily: false,
        dailyPot: pot,
      )),
    );
  }

  Future<void> _onLoadWeeklyPot(
    _LoadWeeklyPot event,
    Emitter<PotState> emit,
  ) async {
    emit(state.copyWith(isLoadingWeekly: true));

    final result = await _gamificationRepository.getCurrentWeeklyPot();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingWeekly: false,
        errorMessage: failure.displayMessage,
      )),
      (pot) => emit(state.copyWith(
        isLoadingWeekly: false,
        weeklyPot: pot,
      )),
    );
  }

  Future<void> _onWatchDailyPot(
    _WatchDailyPot event,
    Emitter<PotState> emit,
  ) async {
    await _dailyPotSubscription?.cancel();
    _dailyPotSubscription = _gamificationRepository.watchPot(PotType.daily).listen(
      (result) {
        result.fold(
          (failure) {},
          (pot) => add(PotEvent.dailyPotUpdated(pot)),
        );
      },
    );
  }

  Future<void> _onWatchWeeklyPot(
    _WatchWeeklyPot event,
    Emitter<PotState> emit,
  ) async {
    await _weeklyPotSubscription?.cancel();
    _weeklyPotSubscription = _gamificationRepository.watchPot(PotType.weekly).listen(
      (result) {
        result.fold(
          (failure) {},
          (pot) => add(PotEvent.weeklyPotUpdated(pot)),
        );
      },
    );
  }

  void _onDailyPotUpdated(
    _DailyPotUpdated event,
    Emitter<PotState> emit,
  ) {
    emit(state.copyWith(dailyPot: event.pot));
  }

  void _onWeeklyPotUpdated(
    _WeeklyPotUpdated event,
    Emitter<PotState> emit,
  ) {
    emit(state.copyWith(weeklyPot: event.pot));
  }

  Future<void> _onLoadLeaderboard(
    _LoadLeaderboard event,
    Emitter<PotState> emit,
  ) async {
    emit(state.copyWith(isLoadingLeaderboard: true));

    final result = event.type == PotType.daily
        ? await _gamificationRepository.getDailyLeaderboard(limit: event.limit)
        : await _gamificationRepository.getWeeklyLeaderboard(limit: event.limit);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingLeaderboard: false,
        errorMessage: failure.displayMessage,
      )),
      (scores) => emit(state.copyWith(
        isLoadingLeaderboard: false,
        leaderboard: scores,
      )),
    );
  }

  Future<void> _onWatchLeaderboard(
    _WatchLeaderboard event,
    Emitter<PotState> emit,
  ) async {
    await _leaderboardSubscription?.cancel();
    _leaderboardSubscription = _gamificationRepository
        .watchLeaderboard(type: event.type, limit: event.limit)
        .listen(
      (result) {
        result.fold(
          (failure) {},
          (scores) => add(PotEvent.leaderboardUpdated(scores)),
        );
      },
    );
  }

  void _onLeaderboardUpdated(
    _LeaderboardUpdated event,
    Emitter<PotState> emit,
  ) {
    emit(state.copyWith(leaderboard: event.scores));
  }

  Future<void> _onLoadPotHistory(
    _LoadPotHistory event,
    Emitter<PotState> emit,
  ) async {
    emit(state.copyWith(isLoadingHistory: true));

    final result = await _gamificationRepository.getPotHistory(
      type: event.type,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingHistory: false,
        errorMessage: failure.displayMessage,
      )),
      (pots) => emit(state.copyWith(
        isLoadingHistory: false,
        potHistory: pots,
      )),
    );
  }

  Future<void> _onLoadCurrentUserScore(
    _LoadCurrentUserScore event,
    Emitter<PotState> emit,
  ) async {
    final result = await _gamificationRepository.getCurrentUserScore(event.type);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (score) {
        // Always update currentUserScore (used by pots screen / leaderboard sheet)
        var newState = state.copyWith(currentUserScore: score);
        // Also update type-specific field (used by home screen)
        if (event.type == PotType.daily) {
          newState = newState.copyWith(dailyUserScore: score);
        } else {
          newState = newState.copyWith(weeklyUserScore: score);
        }
        emit(newState);
      },
    );
  }

  Future<void> _onCheckEligibility(
    _CheckEligibility event,
    Emitter<PotState> emit,
  ) async {
    final dailyResult = await _gamificationRepository.isEligibleForPot(PotType.daily);
    final weeklyResult = await _gamificationRepository.isEligibleForPot(PotType.weekly);

    dailyResult.fold(
      (failure) {},
      (eligible) => emit(state.copyWith(isDailyEligible: eligible)),
    );

    weeklyResult.fold(
      (failure) {},
      (eligible) => emit(state.copyWith(isWeeklyEligible: eligible)),
    );
  }

  void _onSelectPotType(
    _SelectPotType event,
    Emitter<PotState> emit,
  ) {
    emit(state.copyWith(selectedPotType: event.type));
    // Load leaderboard for selected type
    add(PotEvent.loadLeaderboard(type: event.type));
    add(PotEvent.loadCurrentUserScore(event.type));
  }

  void _onClearError(
    _ClearError event,
    Emitter<PotState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _dailyPotSubscription?.cancel();
    _weeklyPotSubscription?.cancel();
    _leaderboardSubscription?.cancel();
    return super.close();
  }
}
