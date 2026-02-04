part of 'wallet_bloc.dart';

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.loadWallet() = _LoadWallet;
  const factory WalletEvent.watchWallet({required String walletId}) = _WatchWallet;
  const factory WalletEvent.loadTransactions({
    required String walletId,
    int? limit,
  }) = _LoadTransactions;
  const factory WalletEvent.loadMoreTransactions() = _LoadMoreTransactions;
  const factory WalletEvent.walletUpdated(Wallet wallet) = _WalletUpdated;
  const factory WalletEvent.transactionsUpdated(List<Transaction> transactions) = _TransactionsUpdated;
  const factory WalletEvent.watchLedgerAccount() = _WatchLedgerAccount;
  const factory WalletEvent.ledgerAccountUpdated(LedgerAccount ledgerAccount) = _LedgerAccountUpdated;
  const factory WalletEvent.loadLedgerJournals({int? limit}) = _LoadLedgerJournals;
  const factory WalletEvent.loadMoreLedgerJournals() = _LoadMoreLedgerJournals;
  const factory WalletEvent.watchLedgerJournals({int? limit}) = _WatchLedgerJournals;
  const factory WalletEvent.ledgerJournalsUpdated(List<LedgerJournal> journals) = _LedgerJournalsUpdated;

  /// Refresh ledger account and journals (e.g., after earning tokens)
  const factory WalletEvent.refreshLedger() = _RefreshLedger;
}
