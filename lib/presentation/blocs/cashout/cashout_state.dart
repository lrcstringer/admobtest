part of 'cashout_bloc.dart';

enum CashoutRequestStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
abstract class CashoutState with _$CashoutState {
  const factory CashoutState({
    @Default([]) List<Cashout> history,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool hasMoreHistory,
    DateTime? lastHistoryTimestamp,
    @Default(CashoutRequestStatus.initial) CashoutRequestStatus requestStatus,
    Cashout? lastCashout,
    String? errorMessage,
  }) = _CashoutState;

  const CashoutState._();

  /// Get total pending cashouts
  int get pendingCount => history.where((c) => c.isPending).length;

  /// Get total completed cashouts
  int get completedCount => history.where((c) => c.isComplete).length;
}
