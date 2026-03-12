// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gooi_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GooiGroup _$GooiGroupFromJson(Map<String, dynamic> json) => _GooiGroup(
  id: json['id'] as String,
  name: json['name'] as String,
  contributionAmount: (json['contributionAmount'] as num).toInt(),
  cycleFrequency: $enumDecode(
    _$GooiCycleFrequencyEnumMap,
    json['cycleFrequency'],
  ),
  memberCount: (json['memberCount'] as num).toInt(),
  totalCycles: (json['totalCycles'] as num).toInt(),
  currentCycleNumber: (json['currentCycleNumber'] as num?)?.toInt() ?? 0,
  status: $enumDecode(_$GooiGroupStatusEnumMap, json['status']),
  rosterMethod: $enumDecode(_$GooiRosterMethodEnumMap, json['rosterMethod']),
  reserveRate: (json['reserveRate'] as num?)?.toDouble() ?? 0.03,
  gracePeriodHours: (json['gracePeriodHours'] as num?)?.toInt() ?? 48,
  recipientContributes: json['recipientContributes'] as bool? ?? true,
  lateFeePercent: (json['lateFeePercent'] as num?)?.toInt() ?? 5,
  initiatorUserId: json['initiatorUserId'] as String,
  conversationId: json['conversationId'] as String?,
  rosterOrder:
      (json['rosterOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  memberUserIds:
      (json['memberUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  biddingDiscountPool: (json['biddingDiscountPool'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  activatedAt: json['activatedAt'] == null
      ? null
      : DateTime.parse(json['activatedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  currentCycle: json['currentCycle'] == null
      ? null
      : GooiCycleSummary.fromJson(json['currentCycle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GooiGroupToJson(_GooiGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contributionAmount': instance.contributionAmount,
      'cycleFrequency': _$GooiCycleFrequencyEnumMap[instance.cycleFrequency]!,
      'memberCount': instance.memberCount,
      'totalCycles': instance.totalCycles,
      'currentCycleNumber': instance.currentCycleNumber,
      'status': _$GooiGroupStatusEnumMap[instance.status]!,
      'rosterMethod': _$GooiRosterMethodEnumMap[instance.rosterMethod]!,
      'reserveRate': instance.reserveRate,
      'gracePeriodHours': instance.gracePeriodHours,
      'recipientContributes': instance.recipientContributes,
      'lateFeePercent': instance.lateFeePercent,
      'initiatorUserId': instance.initiatorUserId,
      'conversationId': instance.conversationId,
      'rosterOrder': instance.rosterOrder,
      'memberUserIds': instance.memberUserIds,
      'biddingDiscountPool': instance.biddingDiscountPool,
      'createdAt': instance.createdAt.toIso8601String(),
      'activatedAt': instance.activatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'currentCycle': instance.currentCycle,
    };

const _$GooiCycleFrequencyEnumMap = {
  GooiCycleFrequency.weekly: 'weekly',
  GooiCycleFrequency.biweekly: 'biweekly',
  GooiCycleFrequency.monthly: 'monthly',
};

const _$GooiGroupStatusEnumMap = {
  GooiGroupStatus.forming: 'forming',
  GooiGroupStatus.active: 'active',
  GooiGroupStatus.completed: 'completed',
  GooiGroupStatus.dissolved: 'dissolved',
};

const _$GooiRosterMethodEnumMap = {
  GooiRosterMethod.agreed: 'agreed',
  GooiRosterMethod.random: 'random',
  GooiRosterMethod.bidding: 'bidding',
};

_GooiCycleSummary _$GooiCycleSummaryFromJson(Map<String, dynamic> json) =>
    _GooiCycleSummary(
      cycleNumber: (json['cycleNumber'] as num).toInt(),
      status: $enumDecode(_$GooiCycleStatusEnumMap, json['status']),
      recipientUserId: json['recipientUserId'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      totalCollected: (json['totalCollected'] as num?)?.toInt() ?? 0,
      totalExpected: (json['totalExpected'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GooiCycleSummaryToJson(_GooiCycleSummary instance) =>
    <String, dynamic>{
      'cycleNumber': instance.cycleNumber,
      'status': _$GooiCycleStatusEnumMap[instance.status]!,
      'recipientUserId': instance.recipientUserId,
      'dueDate': instance.dueDate.toIso8601String(),
      'totalCollected': instance.totalCollected,
      'totalExpected': instance.totalExpected,
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
