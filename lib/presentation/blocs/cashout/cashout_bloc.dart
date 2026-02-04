import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/cashout.dart';
import '../../../domain/repositories/wallet_repository.dart';

part 'cashout_bloc.freezed.dart';
part 'cashout_event.dart';
part 'cashout_state.dart';

@injectable
class CashoutBloc extends Bloc<CashoutEvent, CashoutState> {
  final WalletRepository _walletRepository;

  CashoutBloc(this._walletRepository) : super(const CashoutState()) {
    on<_LoadHistory>(_onLoadHistory);
    on<_LoadMoreHistory>(_onLoadMoreHistory);
    on<_RequestCashout>(_onRequestCashout);
    on<_CancelCashout>(_onCancelCashout);
    on<_ClearError>(_onClearError);
    on<_Reset>(_onReset);
  }

  Future<void> _onLoadHistory(
    _LoadHistory event,
    Emitter<CashoutState> emit,
  ) async {
    emit(state.copyWith(isLoadingHistory: true));

    final result = await _walletRepository.getCashoutHistory(
      limit: event.limit ?? 20,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingHistory: false,
          errorMessage: failure.displayMessage,
        ));
      },
      (cashouts) {
        emit(state.copyWith(
          isLoadingHistory: false,
          history: cashouts,
          hasMoreHistory: cashouts.length >= (event.limit ?? 20),
          lastHistoryTimestamp:
              cashouts.isNotEmpty ? cashouts.last.createdAt : null,
        ));
      },
    );
  }

  Future<void> _onLoadMoreHistory(
    _LoadMoreHistory event,
    Emitter<CashoutState> emit,
  ) async {
    if (state.isLoadingHistory || !state.hasMoreHistory) {
      return;
    }

    emit(state.copyWith(isLoadingHistory: true));

    final result = await _walletRepository.getCashoutHistory(
      limit: 20,
      startAfter: state.lastHistoryTimestamp,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoadingHistory: false));
      },
      (cashouts) {
        emit(state.copyWith(
          isLoadingHistory: false,
          history: [...state.history, ...cashouts],
          hasMoreHistory: cashouts.length >= 20,
          lastHistoryTimestamp:
              cashouts.isNotEmpty ? cashouts.last.createdAt : null,
        ));
      },
    );
  }

  Future<void> _onRequestCashout(
    _RequestCashout event,
    Emitter<CashoutState> emit,
  ) async {
    emit(state.copyWith(requestStatus: CashoutRequestStatus.loading));

    final result = await _walletRepository.requestCashout(
      tokenAmount: event.tokenAmount,
      method: event.method,
      destinationDetails: event.destinationDetails,
      bankName: event.bankName,
      accountNumber: event.accountNumber,
      accountHolderName: event.accountHolderName,
      mobileNumber: event.mobileNumber,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          requestStatus: CashoutRequestStatus.error,
          errorMessage: failure.displayMessage,
        ));
      },
      (cashout) {
        emit(state.copyWith(
          requestStatus: CashoutRequestStatus.success,
          lastCashout: cashout,
          history: [cashout, ...state.history],
        ));
      },
    );
  }

  Future<void> _onCancelCashout(
    _CancelCashout event,
    Emitter<CashoutState> emit,
  ) async {
    final result = await _walletRepository.cancelCashout(event.cashoutId);

    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.displayMessage));
      },
      (_) {
        // Update history to reflect cancelled status
        final updatedHistory = state.history.map((c) {
          if (c.id == event.cashoutId) {
            // We don't have a way to update the status directly with freezed,
            // so we'll reload the history
            add(const CashoutEvent.loadHistory());
          }
          return c;
        }).toList();

        emit(state.copyWith(history: updatedHistory));
      },
    );
  }

  void _onClearError(
    _ClearError event,
    Emitter<CashoutState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  void _onReset(
    _Reset event,
    Emitter<CashoutState> emit,
  ) {
    emit(state.copyWith(
      requestStatus: CashoutRequestStatus.initial,
      lastCashout: null,
    ));
  }
}
