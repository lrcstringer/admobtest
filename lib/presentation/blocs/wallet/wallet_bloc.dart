import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/repositories/wallet_repository.dart';

part 'wallet_bloc.freezed.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

@injectable
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _walletRepository;
  StreamSubscription? _walletSubscription;
  StreamSubscription? _transactionsSubscription;

  WalletBloc(this._walletRepository) : super(const WalletState()) {
    on<_LoadWallet>(_onLoadWallet);
    on<_WatchWallet>(_onWatchWallet);
    on<_LoadTransactions>(_onLoadTransactions);
    on<_LoadMoreTransactions>(_onLoadMoreTransactions);
    on<_WalletUpdated>(_onWalletUpdated);
    on<_TransactionsUpdated>(_onTransactionsUpdated);
  }

  Future<void> _onLoadWallet(
    _LoadWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(status: WalletStatus.loading));

    final result = await _walletRepository.getMainWallet();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: WalletStatus.error,
          errorMessage: failure.displayMessage,
        ));
      },
      (wallet) {
        emit(state.copyWith(
          status: WalletStatus.loaded,
          wallet: wallet,
        ));
        // Start watching wallet updates
        add(WalletEvent.watchWallet(walletId: wallet.id));
        // Load transactions after wallet loads
        add(WalletEvent.loadTransactions(walletId: wallet.id));
      },
    );
  }

  void _onWatchWallet(
    _WatchWallet event,
    Emitter<WalletState> emit,
  ) {
    _walletSubscription?.cancel();
    _walletSubscription = _walletRepository.watchWallet(event.walletId).listen(
      (result) {
        result.fold(
          (failure) {
            // Don't emit error for stream failures, just log
          },
          (wallet) {
            add(WalletEvent.walletUpdated(wallet));
          },
        );
      },
    );
  }

  Future<void> _onLoadTransactions(
    _LoadTransactions event,
    Emitter<WalletState> emit,
  ) async {
    final result = await _walletRepository.getTransactions(
      walletId: event.walletId,
      limit: event.limit ?? 20,
    );

    result.fold(
      (failure) {
        // Don't fail the whole state for transactions error
      },
      (transactions) {
        emit(state.copyWith(
          transactions: transactions,
          hasMoreTransactions: transactions.length >= (event.limit ?? 20),
        ));
      },
    );
  }

  Future<void> _onLoadMoreTransactions(
    _LoadMoreTransactions event,
    Emitter<WalletState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMoreTransactions || state.wallet == null) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final lastTransaction = state.transactions.isNotEmpty
        ? state.transactions.last
        : null;

    final result = await _walletRepository.getTransactions(
      walletId: state.wallet!.id,
      limit: 20,
      startAfter: lastTransaction?.createdAt,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoadingMore: false));
      },
      (transactions) {
        emit(state.copyWith(
          isLoadingMore: false,
          transactions: [...state.transactions, ...transactions],
          hasMoreTransactions: transactions.length >= 20,
        ));
      },
    );
  }

  void _onWalletUpdated(
    _WalletUpdated event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(
      status: WalletStatus.loaded,
      wallet: event.wallet,
    ));
  }

  void _onTransactionsUpdated(
    _TransactionsUpdated event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(transactions: event.transactions));
  }

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    _transactionsSubscription?.cancel();
    return super.close();
  }
}
