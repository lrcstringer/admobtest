// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pot_distribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PotDistributionImpl _$$PotDistributionImplFromJson(
  Map<String, dynamic> json,
) => _$PotDistributionImpl(
  id: json['id'] as String,
  potPoolId: json['potPoolId'] as String,
  potType: $enumDecode(_$PotTypeEnumMap, json['potType']),
  drawDate: DateTime.parse(json['drawDate'] as String),
  totalPrizePool: (json['totalPrizePool'] as num).toInt(),
  totalParticipants: (json['totalParticipants'] as num).toInt(),
  totalEntries: (json['totalEntries'] as num).toInt(),
  winners: (json['winners'] as List<dynamic>)
      .map((e) => PotWinnerAllocation.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: $enumDecode(_$DistributionStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  processedAt: json['processedAt'] == null
      ? null
      : DateTime.parse(json['processedAt'] as String),
  transactionBatchId: json['transactionBatchId'] as String?,
);

Map<String, dynamic> _$$PotDistributionImplToJson(
  _$PotDistributionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'potPoolId': instance.potPoolId,
  'potType': _$PotTypeEnumMap[instance.potType]!,
  'drawDate': instance.drawDate.toIso8601String(),
  'totalPrizePool': instance.totalPrizePool,
  'totalParticipants': instance.totalParticipants,
  'totalEntries': instance.totalEntries,
  'winners': instance.winners,
  'status': _$DistributionStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'processedAt': instance.processedAt?.toIso8601String(),
  'transactionBatchId': instance.transactionBatchId,
};

const _$PotTypeEnumMap = {PotType.daily: 'daily', PotType.weekly: 'weekly'};

const _$DistributionStatusEnumMap = {
  DistributionStatus.pending: 'pending',
  DistributionStatus.processing: 'processing',
  DistributionStatus.completed: 'completed',
  DistributionStatus.failed: 'failed',
};

_$PotWinnerAllocationImpl _$$PotWinnerAllocationImplFromJson(
  Map<String, dynamic> json,
) => _$PotWinnerAllocationImpl(
  oddienceUserId: json['oddienceUserId'] as String,
  rank: (json['rank'] as num).toInt(),
  prizeAmount: (json['prizeAmount'] as num).toInt(),
  entryCount: (json['entryCount'] as num).toInt(),
  winProbability: (json['winProbability'] as num).toDouble(),
  transactionId: json['transactionId'] as String?,
  notificationSent: json['notificationSent'] as bool?,
);

Map<String, dynamic> _$$PotWinnerAllocationImplToJson(
  _$PotWinnerAllocationImpl instance,
) => <String, dynamic>{
  'oddienceUserId': instance.oddienceUserId,
  'rank': instance.rank,
  'prizeAmount': instance.prizeAmount,
  'entryCount': instance.entryCount,
  'winProbability': instance.winProbability,
  'transactionId': instance.transactionId,
  'notificationSent': instance.notificationSent,
};
