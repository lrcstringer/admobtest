// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletModelImpl _$$WalletModelImplFromJson(Map<String, dynamic> json) =>
    _$WalletModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
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

Map<String, dynamic> _$$WalletModelImplToJson(_$WalletModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'type': instance.type,
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
