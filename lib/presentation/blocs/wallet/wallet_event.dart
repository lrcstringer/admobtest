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
}
