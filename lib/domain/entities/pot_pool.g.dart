// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pot_pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PotPoolImpl _$$PotPoolImplFromJson(Map<String, dynamic> json) =>
    _$PotPoolImpl(
      id: json['id'] as String,
      type: $enumDecode(_$PotTypeEnumMap, json['type']),
      totalTokens: (json['totalTokens'] as num).toInt(),
      participantCount: (json['participantCount'] as num).toInt(),
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      isActive: json['isActive'] as bool,
      isDistributed: json['isDistributed'] as bool,
      distributedAt: json['distributedAt'] == null
          ? null
          : DateTime.parse(json['distributedAt'] as String),
      winners: (json['winners'] as List<dynamic>?)
          ?.map((e) => PotWinner.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PotPoolImplToJson(_$PotPoolImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$PotTypeEnumMap[instance.type]!,
      'totalTokens': instance.totalTokens,
      'participantCount': instance.participantCount,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'isActive': instance.isActive,
      'isDistributed': instance.isDistributed,
      'distributedAt': instance.distributedAt?.toIso8601String(),
      'winners': instance.winners,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PotTypeEnumMap = {PotType.daily: 'daily', PotType.weekly: 'weekly'};

_$PotWinnerImpl _$$PotWinnerImplFromJson(Map<String, dynamic> json) =>
    _$PotWinnerImpl(
      oddienceUserId: json['oddienceUserId'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String?,
      rank: (json['rank'] as num).toInt(),
      tokensWon: (json['tokensWon'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$PotWinnerImplToJson(_$PotWinnerImpl instance) =>
    <String, dynamic>{
      'oddienceUserId': instance.oddienceUserId,
      'displayName': instance.displayName,
      'username': instance.username,
      'rank': instance.rank,
      'tokensWon': instance.tokensWon,
      'percentage': instance.percentage,
    };
