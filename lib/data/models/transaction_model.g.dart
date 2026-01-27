// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: json['id'] as String,
  walletId: json['walletId'] as String,
  type: json['type'] as String,
  amount: (json['amount'] as num).toInt(),
  balanceAfter: (json['balanceAfter'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  description: json['description'] as String?,
  counterpartyId: json['counterpartyId'] as String?,
  counterpartyName: json['counterpartyName'] as String?,
  engagementId: json['engagementId'] as String?,
  purchaseId: json['purchaseId'] as String?,
  referralId: json['referralId'] as String?,
  isBonus: json['isBonus'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'walletId': instance.walletId,
  'type': instance.type,
  'amount': instance.amount,
  'balanceAfter': instance.balanceAfter,
  'createdAt': instance.createdAt.toIso8601String(),
  'description': instance.description,
  'counterpartyId': instance.counterpartyId,
  'counterpartyName': instance.counterpartyName,
  'engagementId': instance.engagementId,
  'purchaseId': instance.purchaseId,
  'referralId': instance.referralId,
  'isBonus': instance.isBonus,
  'metadata': instance.metadata,
};
