part of 'wallet_bloc.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletStatus.initial) WalletStatus status,
    Wallet? wallet,
    LedgerAccount? ledgerAccount,
    @Default([]) List<Transaction> transactions,
    @Default([]) List<LedgerJournal> ledgerJournals,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMoreTransactions,
    @Default(false) bool hasMoreLedgerJournals,
    String? errorMessage,
  }) = _WalletState;

  const WalletState._();

  /// Get balance from ledger account (primary source of truth)
  /// Falls back to wallet balance if ledger not loaded
  int get balance => ledgerAccount?.balance ?? wallet?.tokenBalance ?? 0;

  /// Get balance in ZAR (100 tokens = R1)
  double get balanceZar => balance / 100;

  /// Check if can cashout - ledger balance must meet minimum
  bool get canCashout => wallet?.canWithdraw == true && balance >= 5000;
}

enum WalletStatus {
  initial,
  loading,
  loaded,
  error,
}
