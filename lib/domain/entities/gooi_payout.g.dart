// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gooi_payout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GooiPayout _$GooiPayoutFromJson(Map<String, dynamic> json) => _GooiPayout(
  id: json['id'] as String,
  cycleId: json['cycleId'] as String,
  cycleNumber: (json['cycleNumber'] as num).toInt(),
  recipientMemberId: json['recipientMemberId'] as String?,
  recipientUserId: json['recipientUserId'] as String,
  amountFromContributions:
      (json['amountFromContributions'] as num?)?.toInt() ?? 0,
  amountFromReserve: (json['amountFromReserve'] as num?)?.toInt() ?? 0,
  totalPayoutAmount: (json['totalPayoutAmount'] as num?)?.toInt() ?? 0,
  shortfallAmount: (json['shortfallAmount'] as num?)?.toInt() ?? 0,
  status: $enumDecode(_$GooiPayoutStatusEnumMap, json['status']),
  retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
  journalId: json['journalId'] as String?,
  triggeredBy: json['triggeredBy'] as String?,
  triggeredAt: json['triggeredAt'] == null
      ? null
      : DateTime.parse(json['triggeredAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  defaulterMemberIds:
      (json['defaulterMemberIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$GooiPayoutToJson(_GooiPayout instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cycleId': instance.cycleId,
      'cycleNumber': instance.cycleNumber,
      'recipientMemberId': instance.recipientMemberId,
      'recipientUserId': instance.recipientUserId,
      'amountFromContributions': instance.amountFromContributions,
      'amountFromReserve': instance.amountFromReserve,
      'totalPayoutAmount': instance.totalPayoutAmount,
      'shortfallAmount': instance.shortfallAmount,
      'status': _$GooiPayoutStatusEnumMap[instance.status]!,
      'retryCount': instance.retryCount,
      'journalId': instance.journalId,
      'triggeredBy': instance.triggeredBy,
      'triggeredAt': instance.triggeredAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'defaulterMemberIds': instance.defaulterMemberIds,
    };

const _$GooiPayoutStatusEnumMap = {
  GooiPayoutStatus.pending: 'pending',
  GooiPayoutStatus.triggered: 'triggered',
  GooiPayoutStatus.processing: 'processing',
  GooiPayoutStatus.completed: 'completed',
  GooiPayoutStatus.failed: 'failed',
};
