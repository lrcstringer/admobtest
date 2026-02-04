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
  tokenBalance: (json['tokenBalance'] as num).toInt(),
  lifetimeEarned: (json['lifetimeEarned'] as num).toInt(),
  lifetimeWithdrawn: (json['lifetimeWithdrawn'] as num).toInt(),
  canWithdraw: json['canWithdraw'] as bool,
  todayEarned: (json['todayEarned'] as num?)?.toInt() ?? 0,
  pendingBalance: (json['pendingBalance'] as num?)?.toInt() ?? 0,
  pendingWithdrawal: (json['pendingWithdrawal'] as num?)?.toInt() ?? 0,
  brandId: json['brandId'] as String?,
  color: json['color'] as String?,
  icon: json['icon'] as String?,
  description: json['description'] as String?,
  version: (json['version'] as num?)?.toInt() ?? 1,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
  streakStartedAt: json['streakStartedAt'] == null
      ? null
      : DateTime.parse(json['streakStartedAt'] as String),
  lastEarnedAt: json['lastEarnedAt'] == null
      ? null
      : DateTime.parse(json['lastEarnedAt'] as String),
);

Map<String, dynamic> _$$WalletImplToJson(_$WalletImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'type': _$WalletTypeEnumMap[instance.type]!,
      'tokenBalance': instance.tokenBalance,
      'lifetimeEarned': instance.lifetimeEarned,
      'lifetimeWithdrawn': instance.lifetimeWithdrawn,
      'canWithdraw': instance.canWithdraw,
      'todayEarned': instance.todayEarned,
      'pendingBalance': instance.pendingBalance,
      'pendingWithdrawal': instance.pendingWithdrawal,
      'brandId': instance.brandId,
      'color': instance.color,
      'icon': instance.icon,
      'description': instance.description,
      'version': instance.version,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'streakStartedAt': instance.streakStartedAt?.toIso8601String(),
      'lastEarnedAt': instance.lastEarnedAt?.toIso8601String(),
    };

const _$WalletTypeEnumMap = {
  WalletType.main: 'main',
  WalletType.brand: 'brand',
};
