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
    required int balanceTokens,
    required int lifetimeEarned,
    required int lifetimeWithdrawn,
    required bool canWithdraw,
    String? brandId,
    String? color,
    String? icon,
    String? description,
    required int version,
    required DateTime updatedAt,
  }) = _Wallet;

  const Wallet._();

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  /// Get balance as TokenAmount
  TokenAmount get balance => TokenAmount(balanceTokens);

  /// Get balance in ZAR
  double get balanceZar => balanceTokens * AppConstants.tokenValueZar;

  /// Check if balance meets cashout minimum
  bool get canCashout =>
      canWithdraw && balanceTokens >= AppConstants.cashoutMinTokens;

  /// Check if this is the main wallet
  bool get isMainWallet => type == WalletType.main;
}
