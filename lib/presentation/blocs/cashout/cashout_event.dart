part of 'cashout_bloc.dart';

@freezed
class CashoutEvent with _$CashoutEvent {
  /// Load cashout history
  const factory CashoutEvent.loadHistory({int? limit}) = _LoadHistory;

  /// Load more history (pagination)
  const factory CashoutEvent.loadMoreHistory() = _LoadMoreHistory;

  /// Request a new cashout
  const factory CashoutEvent.requestCashout({
    required int tokenAmount,
    required CashoutMethod method,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
  }) = _RequestCashout;

  /// Cancel a pending cashout
  const factory CashoutEvent.cancelCashout(String cashoutId) = _CancelCashout;

  /// Clear error
  const factory CashoutEvent.clearError() = _ClearError;

  /// Reset state after successful cashout
  const factory CashoutEvent.reset() = _Reset;
}
