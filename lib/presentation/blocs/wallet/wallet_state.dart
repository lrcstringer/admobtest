part of 'wallet_bloc.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletStatus.initial) WalletStatus status,
    Wallet? wallet,
    @Default([]) List<Transaction> transactions,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMoreTransactions,
    String? errorMessage,
  }) = _WalletState;

  const WalletState._();

  int get balance => wallet?.balanceTokens ?? 0;
  double get balanceZar => wallet?.balanceZar ?? 0.0;
  bool get canCashout => wallet?.canCashout ?? false;
}

enum WalletStatus {
  initial,
  loading,
  loaded,
  error,
}
