import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/token_amount.dart';
import '../../core/constants/app_constants.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

/// Wallet type enum
enum WalletType {
  main,
  brand,
}

/// Wallet entity
@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required String id,
    required String userId,
    required String name,
    required WalletType type,
    required int tokenBalance,
    required int lifetimeEarned,
    required int lifetimeWithdrawn,
    required bool canWithdraw,
    @Default(0) int todayEarned,
    @Default(0) int pendingBalance,
    @Default(0) int pendingWithdrawal,
    String? brandId,
    String? color,
    String? icon,
    String? description,
    @Default(1) int version,
    required DateTime updatedAt,
  }) = _Wallet;

  const Wallet._();

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  /// Get balance as TokenAmount
  TokenAmount get balance => TokenAmount(tokenBalance);

  /// Get balance in ZAR
  double get balanceZar => tokenBalance * AppConstants.tokenValueZar;

  /// Check if balance meets cashout minimum
  bool get canCashout =>
      canWithdraw && tokenBalance >= AppConstants.cashoutMinTokens;

  /// Check if this is the main wallet
  bool get isMainWallet => type == WalletType.main;
}
