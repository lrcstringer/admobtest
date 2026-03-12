// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gooi_debt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GooiDebt _$GooiDebtFromJson(Map<String, dynamic> json) => _GooiDebt(
  id: json['id'] as String,
  userId: json['userId'] as String,
  groupId: json['groupId'] as String,
  amount: (json['amount'] as num).toInt(),
  reason: json['reason'] as String,
  status: $enumDecode(_$GooiDebtStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  resolvedAt: json['resolvedAt'] == null
      ? null
      : DateTime.parse(json['resolvedAt'] as String),
);

Map<String, dynamic> _$GooiDebtToJson(_GooiDebt instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'groupId': instance.groupId,
  'amount': instance.amount,
  'reason': instance.reason,
  'status': _$GooiDebtStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'resolvedAt': instance.resolvedAt?.toIso8601String(),
};

const _$GooiDebtStatusEnumMap = {
  GooiDebtStatus.outstanding: 'outstanding',
  GooiDebtStatus.recovered: 'recovered',
  GooiDebtStatus.writtenOff: 'writtenOff',
};
