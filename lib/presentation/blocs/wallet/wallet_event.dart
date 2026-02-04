part of 'wallet_bloc.dart';

@freezed
class WalletEvent with _$WalletEvent {
  /// Load ledger account, journals, and engagement stats
  const factory WalletEvent.loadLedger() = _LoadLedger;

  /// Watch ledger account updates
  const factory WalletEvent.watchLedgerAccount() = _WatchLedgerAccount;
  const factory WalletEvent.ledgerAccountUpdated(LedgerAccount ledgerAccount) = _LedgerAccountUpdated;

  /// Load and watch ledger journals (transaction history)
  const factory WalletEvent.loadLedgerJournals({int? limit}) = _LoadLedgerJournals;
  const factory WalletEvent.loadMoreLedgerJournals() = _LoadMoreLedgerJournals;
  const factory WalletEvent.watchLedgerJournals({int? limit}) = _WatchLedgerJournals;
  const factory WalletEvent.ledgerJournalsUpdated(List<LedgerJournal> journals) = _LedgerJournalsUpdated;

  /// Refresh ledger account and journals (e.g., after earning tokens)
  const factory WalletEvent.refreshLedger() = _RefreshLedger;

  /// Watch engagement stats (streak tracking)
  const factory WalletEvent.watchEngagementStats() = _WatchEngagementStats;
  const factory WalletEvent.engagementStatsUpdated(UserEngagementStats stats) = _EngagementStatsUpdated;
}
