import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/earn_thread.dart';
import '../../../domain/entities/pot_pool.dart';
import '../../../domain/repositories/earn_repository.dart';
import '../../../domain/repositories/gamification_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

/// HomeBloc manages earn opportunities and pots for the dashboard.
/// Wallet/ledger data is managed by WalletBloc.
@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EarnRepository _earnRepository;
  final GamificationRepository _gamificationRepository;

  HomeBloc(
    this._earnRepository,
    this._gamificationRepository,
  ) : super(const HomeState()) {
    on<_LoadDashboard>(_onLoadDashboard);
    on<_RefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    _LoadDashboard event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      // Load earn threads and pots in parallel
      final earnResult = await _earnRepository.getEligibleThreads();
      final dailyPotResult = await _gamificationRepository.getCurrentDailyPot();
      final weeklyPotResult = await _gamificationRepository.getCurrentWeeklyPot();

      List<EarnThread> earnThreads = [];
      List<PotPool> activePots = [];

      earnResult.fold(
        (failure) => null,
        (result) => earnThreads = result.threads,
      );

      dailyPotResult.fold(
        (failure) => null,
        (pot) => activePots.add(pot),
      );

      weeklyPotResult.fold(
        (failure) => null,
        (pot) => activePots.add(pot),
      );

      emit(state.copyWith(
        status: HomeStatus.loaded,
        earnOpportunities: earnThreads,
        activePots: activePots,
        lastRefresh: DateTime.now(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshDashboard(
    _RefreshDashboard event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));

    try {
      final earnResult = await _earnRepository.getEligibleThreads();
      final dailyPotResult = await _gamificationRepository.getCurrentDailyPot();
      final weeklyPotResult = await _gamificationRepository.getCurrentWeeklyPot();

      List<EarnThread> earnThreads = state.earnOpportunities;
      List<PotPool> activePots = [];

      earnResult.fold(
        (failure) => null,
        (result) => earnThreads = result.threads,
      );

      dailyPotResult.fold(
        (failure) => null,
        (pot) => activePots.add(pot),
      );

      weeklyPotResult.fold(
        (failure) => null,
        (pot) => activePots.add(pot),
      );

      emit(state.copyWith(
        isRefreshing: false,
        earnOpportunities: earnThreads,
        activePots: activePots,
        lastRefresh: DateTime.now(),
      ));
    } catch (e) {
      emit(state.copyWith(isRefreshing: false));
    }
  }
}
