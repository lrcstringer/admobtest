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
    String? errorMessage,
  }) = _WalletState;

  const WalletState._();

  /// Get balance from ledger account (primary source of truth)
  int get balance => ledgerAccount?.balance ?? 0;

  /// Get balance in ZAR (100 tokens = R1)
  double get balanceZar => balance / 100;

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
}

enum WalletStatus {
  initial,
  loading,
  loaded,
  error,
}
