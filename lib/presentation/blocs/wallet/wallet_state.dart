part of 'wallet_bloc.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletStatus.initial) WalletStatus status,
    LedgerAccount? ledgerAccount,
    UserEngagementStats? engagementStats,
    @Default([]) List<LedgerJournal> ledgerJournals,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMoreLedgerJournals,
    @Default([]) List<SubAccount> subAccounts,
    String? selectedSubAccountId,
    @Default(false) bool isTransferring,
    String? errorMessage,
    String? successMessage,
  }) = _WalletState;

  const WalletState._();

  /// Get balance from ledger account (primary source of truth)
  int get balance => ledgerAccount?.balance ?? 0;

  /// Get balance in ZAR (100 tokens = R1)
  double get balanceZar => AppConstants.tokensToZar(balance);

  /// Check if can cashout - ledger balance must meet minimum and account active
  bool get canCashout => ledgerAccount?.isActive == true && balance >= 5000;

  /// Get current streak from engagement stats
  int get currentStreak => engagementStats?.currentStreak ?? 0;

  /// Get longest streak from engagement stats
  int get longestStreak => engagementStats?.longestStreak ?? 0;

  /// Get streak multiplier from engagement stats
  double get streakMultiplier => engagementStats?.streakMultiplier ?? 1.0;

  /// Get total tokens earned from engagement stats
  int get totalTokensEarned => engagementStats?.totalTokensEarned ?? 0;

  /// Total portfolio value in tokens (sub-account sum, falls back to ledger balance)
  int get portfolioBalance {
    final subTotal = subAccounts.fold(0, (sum, sa) => sum + sa.balance);
    return subTotal > 0 ? subTotal : balance;
  }

  /// Total portfolio value in ZAR
  double get portfolioBalanceZar => AppConstants.tokensToZar(portfolioBalance);

  /// Get the default (iMaliChat) sub-account
  SubAccount? get defaultSubAccount =>
      subAccounts.where((sa) => sa.isDefault).firstOrNull;

  /// Get the currently selected sub-account
  SubAccount? get selectedSubAccount => selectedSubAccountId != null
      ? subAccounts.where((sa) => sa.id == selectedSubAccountId).firstOrNull
      : null;

  /// Brand (restricted) sub-accounts only
  List<SubAccount> get brandSubAccounts =>
      subAccounts.where((sa) => sa.isRestricted).toList();
}

enum WalletStatus {
  initial,
  loading,
  loaded,
  error,
}
