import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/ledger_account.dart';
import '../../../domain/entities/ledger_journal.dart';
import '../../../domain/entities/user_engagement_stats.dart';
import '../../../domain/repositories/wallet_repository.dart';

part 'wallet_bloc.freezed.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

@injectable
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _walletRepository;
  StreamSubscription? _ledgerAccountSubscription;
  StreamSubscription? _ledgerJournalsSubscription;
  StreamSubscription? _engagementStatsSubscription;

  WalletBloc(this._walletRepository) : super(const WalletState()) {
    on<_LoadLedger>(_onLoadLedger);
    on<_WatchLedgerAccount>(_onWatchLedgerAccount);
    on<_LedgerAccountUpdated>(_onLedgerAccountUpdated);
    on<_LoadLedgerJournals>(_onLoadLedgerJournals);
    on<_LoadMoreLedgerJournals>(_onLoadMoreLedgerJournals);
    on<_WatchLedgerJournals>(_onWatchLedgerJournals);
    on<_LedgerJournalsUpdated>(_onLedgerJournalsUpdated);
    on<_RefreshLedger>(_onRefreshLedger);
    on<_WatchEngagementStats>(_onWatchEngagementStats);
    on<_EngagementStatsUpdated>(_onEngagementStatsUpdated);
  }

  Future<void> _onLoadLedger(
    _LoadLedger event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(status: WalletStatus.loading));

    // Load ledger account
    final accountResult = await _walletRepository.getLedgerAccount();

    await accountResult.fold(
      (failure) async {
        emit(state.copyWith(
          status: WalletStatus.error,
          errorMessage: failure.displayMessage,
        ));
      },
      (ledgerAccount) async {
        emit(state.copyWith(
          status: WalletStatus.loaded,
          ledgerAccount: ledgerAccount,
        ));
        // Start watching ledger account updates
        add(const WalletEvent.watchLedgerAccount());
        // Start watching ledger journals (transaction history)
        add(const WalletEvent.watchLedgerJournals());
        // Start watching engagement stats (streak tracking)
        add(const WalletEvent.watchEngagementStats());
        // Load initial journals
        add(const WalletEvent.loadLedgerJournals());
      },
    );
  }

  void _onWatchLedgerAccount(
    _WatchLedgerAccount event,
    Emitter<WalletState> emit,
  ) {
    _ledgerAccountSubscription?.cancel();
    _ledgerAccountSubscription = _walletRepository.watchLedgerAccount().listen(
      (result) {
        result.fold(
          (failure) {
            // Don't emit error for stream failures, ledger account may not exist yet
          },
          (ledgerAccount) {
            add(WalletEvent.ledgerAccountUpdated(ledgerAccount));
          },
        );
      },
    );
  }

  void _onLedgerAccountUpdated(
    _LedgerAccountUpdated event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(ledgerAccount: event.ledgerAccount));
  }

  Future<void> _onLoadLedgerJournals(
    _LoadLedgerJournals event,
    Emitter<WalletState> emit,
  ) async {
    final result = await _walletRepository.getLedgerJournals(
      limit: event.limit ?? 20,
    );

    result.fold(
      (failure) {
        // Don't fail the whole state for journals error
      },
      (journals) {
        emit(state.copyWith(
          ledgerJournals: journals,
          hasMoreLedgerJournals: journals.length >= (event.limit ?? 20),
        ));
      },
    );
  }

  Future<void> _onLoadMoreLedgerJournals(
    _LoadMoreLedgerJournals event,
    Emitter<WalletState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMoreLedgerJournals) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final lastJournal = state.ledgerJournals.isNotEmpty
        ? state.ledgerJournals.last
        : null;

    final result = await _walletRepository.getLedgerJournals(
      limit: 20,
      startAfter: lastJournal?.postedAt ?? lastJournal?.createdAt,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoadingMore: false));
      },
      (journals) {
        emit(state.copyWith(
          isLoadingMore: false,
          ledgerJournals: [...state.ledgerJournals, ...journals],
          hasMoreLedgerJournals: journals.length >= 20,
        ));
      },
    );
  }

  void _onWatchLedgerJournals(
    _WatchLedgerJournals event,
    Emitter<WalletState> emit,
  ) {
    _ledgerJournalsSubscription?.cancel();
    _ledgerJournalsSubscription = _walletRepository
        .watchLedgerJournals(limit: event.limit ?? 20)
        .listen(
      (result) {
        result.fold(
          (failure) {
            // Don't emit error for stream failures
          },
          (journals) {
            add(WalletEvent.ledgerJournalsUpdated(journals));
          },
        );
      },
    );
  }

  void _onLedgerJournalsUpdated(
    _LedgerJournalsUpdated event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(ledgerJournals: event.journals));
  }

  void _onWatchEngagementStats(
    _WatchEngagementStats event,
    Emitter<WalletState> emit,
  ) {
    _engagementStatsSubscription?.cancel();
    _engagementStatsSubscription = _walletRepository.watchEngagementStats().listen(
      (result) {
        result.fold(
          (failure) {
            // Don't emit error for stream failures, stats may not exist yet
          },
          (stats) {
            add(WalletEvent.engagementStatsUpdated(stats));
          },
        );
      },
    );
  }

  void _onEngagementStatsUpdated(
    _EngagementStatsUpdated event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(engagementStats: event.stats));
  }

  Future<void> _onRefreshLedger(
    _RefreshLedger event,
    Emitter<WalletState> emit,
  ) async {
    // Fetch latest ledger account balance
    final accountResult = await _walletRepository.getLedgerAccount();
    accountResult.fold(
      (failure) {
        // Silent fail - watchers will eventually update
      },
      (ledgerAccount) {
        emit(state.copyWith(ledgerAccount: ledgerAccount));
      },
    );

    // Refresh ledger journals
    final journalsResult = await _walletRepository.getLedgerJournals(limit: 20);
    journalsResult.fold(
      (failure) {
        // Silent fail - watchers will eventually update
      },
      (journals) {
        emit(state.copyWith(
          ledgerJournals: journals,
          hasMoreLedgerJournals: journals.length >= 20,
        ));
      },
    );

    // Refresh engagement stats (streak)
    final statsResult = await _walletRepository.getEngagementStats();
    statsResult.fold(
      (failure) {
        // Silent fail - watchers will eventually update
      },
      (stats) {
        emit(state.copyWith(engagementStats: stats));
      },
    );
  }

  @override
  Future<void> close() {
    _ledgerAccountSubscription?.cancel();
    _ledgerJournalsSubscription?.cancel();
    _engagementStatsSubscription?.cancel();
    return super.close();
  }
}
