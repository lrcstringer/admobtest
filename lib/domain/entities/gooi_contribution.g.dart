// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gooi_contribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GooiContribution _$GooiContributionFromJson(Map<String, dynamic> json) =>
    _GooiContribution(
      id: json['id'] as String,
      cycleId: json['cycleId'] as String,
      cycleNumber: (json['cycleNumber'] as num).toInt(),
      memberId: json['memberId'] as String,
      userId: json['userId'] as String,
      amountBase: (json['amountBase'] as num?)?.toInt() ?? 0,
      amountReserve: (json['amountReserve'] as num?)?.toInt() ?? 0,
      amountTotal: (json['amountTotal'] as num?)?.toInt() ?? 0,
      lateFee: (json['lateFee'] as num?)?.toInt(),
      lateFeeWaived: json['lateFeeWaived'] as bool? ?? false,
      status: $enumDecode(_$GooiContributionStatusEnumMap, json['status']),
      journalId: json['journalId'] as String?,
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GooiContributionToJson(_GooiContribution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cycleId': instance.cycleId,
      'cycleNumber': instance.cycleNumber,
      'memberId': instance.memberId,
      'userId': instance.userId,
      'amountBase': instance.amountBase,
      'amountReserve': instance.amountReserve,
      'amountTotal': instance.amountTotal,
      'lateFee': instance.lateFee,
      'lateFeeWaived': instance.lateFeeWaived,
      'status': _$GooiContributionStatusEnumMap[instance.status]!,
      'journalId': instance.journalId,
      'paidAt': instance.paidAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$GooiContributionStatusEnumMap = {
  GooiContributionStatus.pending: 'pending',
  GooiContributionStatus.paid: 'paid',
  GooiContributionStatus.late_: 'late_',
  GooiContributionStatus.missed: 'missed',
};
