import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/ledger_account.dart';
import '../../../domain/entities/ledger_journal.dart';
import '../../../domain/entities/sub_account.dart';
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
  StreamSubscription? _subAccountsSubscription;

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
    on<_LoadSubAccounts>(_onLoadSubAccounts);
    on<_WatchSubAccounts>(_onWatchSubAccounts);
    on<_SubAccountsUpdated>(_onSubAccountsUpdated);
    on<_SelectSubAccount>(_onSelectSubAccount);
    on<_CreateUserWallet>(_onCreateUserWallet);
    on<_TransferBetweenWallets>(_onTransferBetweenWallets);
    on<_SendP2PTransfer>(_onSendP2PTransfer);
    on<_ClearMessages>(_onClearMessages);
  }

  Future<void> _onLoadLedger(
    _LoadLedger event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(status: WalletStatus.loading));

    // Load ledger account
    final accountResult = await _walletRepository.getLedgerAccount();

    accountResult.fold(
      (failure) {
        emit(state.copyWith(
          status: WalletStatus.loaded,
          errorMessage: failure.displayMessage,
        ));
      },
      (ledgerAccount) {
        emit(state.copyWith(
          status: WalletStatus.loaded,
          ledgerAccount: ledgerAccount,
        ));
        // Start watching ledger account updates
        add(const WalletEvent.watchLedgerAccount());
      },
    );

    // Always load sub-accounts, journals, and stats regardless of ledger account result
    add(const WalletEvent.watchLedgerJournals());
    add(const WalletEvent.watchEngagementStats());
    add(const WalletEvent.loadLedgerJournals());
    add(const WalletEvent.loadSubAccounts());
    add(const WalletEvent.watchSubAccounts());
  }

  void _onWatchLedgerAccount(
    _WatchLedgerAccount event,
    Emitter<WalletState> emit,
  ) {
    _ledgerAccountSubscription?.cancel();
    _ledgerAccountSubscription = _walletRepository.watchLedgerAccount().listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (failure) {},
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
      (failure) {},
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
      startAfter: lastJournal?.postedAt,
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
        if (isClosed) return;
        result.fold(
          (failure) {},
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
        if (isClosed) return;
        result.fold(
          (failure) {},
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
      (failure) {},
      (ledgerAccount) {
        emit(state.copyWith(ledgerAccount: ledgerAccount));
      },
    );

    // Refresh ledger journals
    final journalsResult = await _walletRepository.getLedgerJournals(limit: 20);
    journalsResult.fold(
      (failure) {},
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
      (failure) {},
      (stats) {
        emit(state.copyWith(engagementStats: stats));
      },
    );

    // Refresh sub-accounts
    final subAccountsResult = await _walletRepository.getSubAccounts();
    subAccountsResult.fold(
      (failure) {},
      (subAccounts) {
        emit(state.copyWith(subAccounts: subAccounts));
      },
    );
  }

  // ============================================================
  // Sub-Account Handlers
  // ============================================================

  Future<void> _onLoadSubAccounts(
    _LoadSubAccounts event,
    Emitter<WalletState> emit,
  ) async {
    final result = await _walletRepository.getSubAccounts();
    result.fold(
      (failure) {},
      (subAccounts) => emit(state.copyWith(subAccounts: subAccounts)),
    );
  }

  void _onWatchSubAccounts(
    _WatchSubAccounts event,
    Emitter<WalletState> emit,
  ) {
    _subAccountsSubscription?.cancel();
    _subAccountsSubscription = _walletRepository.watchSubAccounts().listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (failure) {},
          (subAccounts) => add(WalletEvent.subAccountsUpdated(subAccounts)),
        );
      },
    );
  }

  void _onSubAccountsUpdated(
    _SubAccountsUpdated event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(subAccounts: event.subAccounts));
  }

  void _onSelectSubAccount(
    _SelectSubAccount event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(selectedSubAccountId: event.subAccountId));
  }

  Future<void> _onCreateUserWallet(
    _CreateUserWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(isTransferring: true, errorMessage: null));

    final result = await _walletRepository.createUserWallet(name: event.name);

    result.fold(
      (failure) => emit(state.copyWith(
        isTransferring: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        emit(state.copyWith(
          isTransferring: false,
          successMessage: 'Wallet "${event.name}" created',
        ));
        // Refresh sub-accounts to show the new wallet
        add(const WalletEvent.loadSubAccounts());
      },
    );
  }

  Future<void> _onTransferBetweenWallets(
    _TransferBetweenWallets event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(isTransferring: true));

    final result = await _walletRepository.transferBetweenWallets(
      fromSubAccountId: event.fromSubAccountId,
      toSubAccountId: event.toSubAccountId,
      amount: event.amount,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isTransferring: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isTransferring: false,
        successMessage: 'Transfer complete',
      )),
    );
  }

  Future<void> _onSendP2PTransfer(
    _SendP2PTransfer event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(isTransferring: true));

    final result = await _walletRepository.sendP2PTransfer(
      recipientUserId: event.recipientUserId,
      amount: event.amount,
      subAccountId: event.subAccountId,
      note: event.note,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isTransferring: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isTransferring: false,
        successMessage: 'Transfer sent successfully',
      )),
    );
  }

  void _onClearMessages(
    _ClearMessages event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }

  @override
  Future<void> close() {
    _ledgerAccountSubscription?.cancel();
    _ledgerJournalsSubscription?.cancel();
    _engagementStatsSubscription?.cancel();
    _subAccountsSubscription?.cancel();
    return super.close();
  }
}
