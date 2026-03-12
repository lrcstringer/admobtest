// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gooi_cycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GooiCycle _$GooiCycleFromJson(Map<String, dynamic> json) => _GooiCycle(
  id: json['id'] as String,
  cycleNumber: (json['cycleNumber'] as num).toInt(),
  rotationNumber: (json['rotationNumber'] as num?)?.toInt() ?? 1,
  recipientMemberId: json['recipientMemberId'] as String?,
  recipientUserId: json['recipientUserId'] as String,
  dueDate: DateTime.parse(json['dueDate'] as String),
  graceCloseDate: DateTime.parse(json['graceCloseDate'] as String),
  status: $enumDecode(_$GooiCycleStatusEnumMap, json['status']),
  totalExpected: (json['totalExpected'] as num?)?.toInt() ?? 0,
  totalCollected: (json['totalCollected'] as num?)?.toInt() ?? 0,
  reserveCollected: (json['reserveCollected'] as num?)?.toInt() ?? 0,
  payoutAmount: (json['payoutAmount'] as num?)?.toInt() ?? 0,
  shortfallAmount: (json['shortfallAmount'] as num?)?.toInt() ?? 0,
  defaulterMemberIds:
      (json['defaulterMemberIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  triggeredBy: json['triggeredBy'] as String?,
  triggeredAt: json['triggeredAt'] == null
      ? null
      : DateTime.parse(json['triggeredAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  autoTriggerAt: json['autoTriggerAt'] == null
      ? null
      : DateTime.parse(json['autoTriggerAt'] as String),
  graceExtendedBy: (json['graceExtendedBy'] as num?)?.toInt() ?? 0,
  graceExtensionVoteId: json['graceExtensionVoteId'] as String?,
);

Map<String, dynamic> _$GooiCycleToJson(_GooiCycle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cycleNumber': instance.cycleNumber,
      'rotationNumber': instance.rotationNumber,
      'recipientMemberId': instance.recipientMemberId,
      'recipientUserId': instance.recipientUserId,
      'dueDate': instance.dueDate.toIso8601String(),
      'graceCloseDate': instance.graceCloseDate.toIso8601String(),
      'status': _$GooiCycleStatusEnumMap[instance.status]!,
      'totalExpected': instance.totalExpected,
      'totalCollected': instance.totalCollected,
      'reserveCollected': instance.reserveCollected,
      'payoutAmount': instance.payoutAmount,
      'shortfallAmount': instance.shortfallAmount,
      'defaulterMemberIds': instance.defaulterMemberIds,
      'triggeredBy': instance.triggeredBy,
      'triggeredAt': instance.triggeredAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'autoTriggerAt': instance.autoTriggerAt?.toIso8601String(),
      'graceExtendedBy': instance.graceExtendedBy,
      'graceExtensionVoteId': instance.graceExtensionVoteId,
    };

const _$GooiCycleStatusEnumMap = {
  GooiCycleStatus.pending: 'pending',
  GooiCycleStatus.collecting: 'collecting',
  GooiCycleStatus.awaitingTrigger: 'awaitingTrigger',
  GooiCycleStatus.payoutProcessing: 'payoutProcessing',
  GooiCycleStatus.complete: 'complete',
  GooiCycleStatus.defaulted: 'defaulted',
  GooiCycleStatus.payoutFailed: 'payoutFailed',
};
