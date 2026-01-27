import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/earn_thread.dart';
import '../../../domain/entities/pot_pool.dart';
import '../../../domain/repositories/wallet_repository.dart';
import '../../../domain/repositories/earn_repository.dart';
import '../../../domain/repositories/gamification_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WalletRepository _walletRepository;
  final EarnRepository _earnRepository;
  final GamificationRepository _gamificationRepository;

  StreamSubscription? _walletSubscription;

  HomeBloc(
    this._walletRepository,
    this._earnRepository,
    this._gamificationRepository,
  ) : super(const HomeState()) {
    on<_LoadDashboard>(_onLoadDashboard);
    on<_RefreshDashboard>(_onRefreshDashboard);
    on<_WatchWallet>(_onWatchWallet);
    on<_WalletUpdated>(_onWalletUpdated);
    on<_StopWatching>(_onStopWatching);
  }

  Future<void> _onLoadDashboard(
    _LoadDashboard event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      // Load wallet first
      final walletResult = await _walletRepository.getMainWallet();

      await walletResult.fold(
        (failure) async {
          emit(state.copyWith(
            status: HomeStatus.error,
            errorMessage: failure.displayMessage,
          ));
        },
        (wallet) async {
          emit(state.copyWith(wallet: wallet));

          // Start watching wallet
          add(const HomeEvent.watchWallet());

          // Load earn threads and pots in parallel
          final earnResult = await _earnRepository.getEarnThreads();
          final dailyPotResult = await _gamificationRepository.getCurrentDailyPot();
          final weeklyPotResult = await _gamificationRepository.getCurrentWeeklyPot();

          List<EarnThread> earnThreads = [];
          List<PotPool> activePots = [];

          earnResult.fold(
            (failure) => null,
            (threads) => earnThreads = threads,
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
            wallet: wallet,
            earnOpportunities: earnThreads,
            activePots: activePots,
            lastRefresh: DateTime.now(),
          ));
        },
      );
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
      // Refresh all data
      final walletResult = await _walletRepository.getMainWallet();

      Wallet? wallet;
      walletResult.fold(
        (failure) => null,
        (w) => wallet = w,
      );

      if (wallet != null) {
        final earnResult = await _earnRepository.getEarnThreads();
        final dailyPotResult = await _gamificationRepository.getCurrentDailyPot();
        final weeklyPotResult = await _gamificationRepository.getCurrentWeeklyPot();

        List<EarnThread> earnThreads = state.earnOpportunities;
        List<PotPool> activePots = [];

        earnResult.fold(
          (failure) => null,
          (threads) => earnThreads = threads,
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
          wallet: wallet,
          earnOpportunities: earnThreads,
          activePots: activePots,
          lastRefresh: DateTime.now(),
        ));
      } else {
        emit(state.copyWith(isRefreshing: false));
      }
    } catch (e) {
      emit(state.copyWith(isRefreshing: false));
    }
  }

  void _onWatchWallet(
    _WatchWallet event,
    Emitter<HomeState> emit,
  ) {
    _walletSubscription?.cancel();

    if (state.wallet == null) return;

    _walletSubscription = _walletRepository.watchWallet(state.wallet!.id).listen(
      (result) {
        result.fold(
          (failure) => null,
          (wallet) => add(HomeEvent.walletUpdated(wallet)),
        );
      },
    );
  }

  void _onWalletUpdated(
    _WalletUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(wallet: event.wallet));
  }

  void _onStopWatching(
    _StopWatching event,
    Emitter<HomeState> emit,
  ) {
    _walletSubscription?.cancel();
    _walletSubscription = null;
  }

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    return super.close();
  }
}
