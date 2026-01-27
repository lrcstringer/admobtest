// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as String,
      walletId: json['walletId'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
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

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
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

const _$TransactionTypeEnumMap = {
  TransactionType.earn: 'earn',
  TransactionType.potWin: 'potWin',
  TransactionType.p2pSend: 'p2pSend',
  TransactionType.p2pReceive: 'p2pReceive',
  TransactionType.cashout: 'cashout',
  TransactionType.refund: 'refund',
  TransactionType.referral: 'referral',
  TransactionType.purchase: 'purchase',
  TransactionType.adjustment: 'adjustment',
  TransactionType.reversal: 'reversal',
};
