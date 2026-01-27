import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/wallet.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
class WalletModel with _$WalletModel {
  const factory WalletModel({
    required String id,
    required String userId,
    required String name,
    required String type,
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
  }) = _WalletModel;

  const WalletModel._();

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Wallet toEntity() => Wallet(
        id: id,
        userId: userId,
        name: name,
        type: _parseWalletType(type),
        balanceTokens: balanceTokens,
        lifetimeEarned: lifetimeEarned,
        lifetimeWithdrawn: lifetimeWithdrawn,
        canWithdraw: canWithdraw,
        brandId: brandId,
        color: color,
        icon: icon,
        description: description,
        version: version,
        updatedAt: updatedAt,
      );

  factory WalletModel.fromEntity(Wallet wallet) => WalletModel(
        id: wallet.id,
        userId: wallet.userId,
        name: wallet.name,
        type: wallet.type.name,
        balanceTokens: wallet.balanceTokens,
        lifetimeEarned: wallet.lifetimeEarned,
        lifetimeWithdrawn: wallet.lifetimeWithdrawn,
        canWithdraw: wallet.canWithdraw,
        brandId: wallet.brandId,
        color: wallet.color,
        icon: wallet.icon,
        description: wallet.description,
        version: wallet.version,
        updatedAt: wallet.updatedAt,
      );

  static WalletType _parseWalletType(String type) {
    switch (type) {
      case 'main':
        return WalletType.main;
      case 'brand':
        return WalletType.brand;
      default:
        return WalletType.main;
    }
  }
}
