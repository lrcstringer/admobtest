// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletImpl _$$WalletImplFromJson(Map<String, dynamic> json) => _$WalletImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$WalletTypeEnumMap, json['type']),
  balanceTokens: (json['balanceTokens'] as num).toInt(),
  lifetimeEarned: (json['lifetimeEarned'] as num).toInt(),
  lifetimeWithdrawn: (json['lifetimeWithdrawn'] as num).toInt(),
  canWithdraw: json['canWithdraw'] as bool,
  brandId: json['brandId'] as String?,
  color: json['color'] as String?,
  icon: json['icon'] as String?,
  description: json['description'] as String?,
  version: (json['version'] as num).toInt(),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$WalletImplToJson(_$WalletImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'type': _$WalletTypeEnumMap[instance.type]!,
      'balanceTokens': instance.balanceTokens,
      'lifetimeEarned': instance.lifetimeEarned,
      'lifetimeWithdrawn': instance.lifetimeWithdrawn,
      'canWithdraw': instance.canWithdraw,
      'brandId': instance.brandId,
      'color': instance.color,
      'icon': instance.icon,
      'description': instance.description,
      'version': instance.version,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$WalletTypeEnumMap = {
  WalletType.main: 'main',
  WalletType.brand: 'brand',
};
