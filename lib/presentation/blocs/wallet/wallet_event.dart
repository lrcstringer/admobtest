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

  /// Sub-account (multi-wallet) events
  const factory WalletEvent.loadSubAccounts() = _LoadSubAccounts;
  const factory WalletEvent.watchSubAccounts() = _WatchSubAccounts;
  const factory WalletEvent.subAccountsUpdated(List<SubAccount> subAccounts) = _SubAccountsUpdated;
  const factory WalletEvent.selectSubAccount(String subAccountId) = _SelectSubAccount;
  const factory WalletEvent.createUserWallet({required String name}) = _CreateUserWallet;
  const factory WalletEvent.transferBetweenWallets({
    required String fromSubAccountId,
    required String toSubAccountId,
    required int amount,
  }) = _TransferBetweenWallets;
  const factory WalletEvent.sendP2PTransfer({
    required String recipientUserId,
    required int amount,
    required String subAccountId,
    String? note,
  }) = _SendP2PTransfer;
  const factory WalletEvent.clearMessages() = _ClearMessages;
}
