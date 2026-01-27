// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseImpl _$$PurchaseImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseImpl(
      id: json['id'] as String,
      walletId: json['walletId'] as String,
      oddienceUserId: json['oddienceUserId'] as String,
      providerId: json['providerId'] as String,
      providerName: json['providerName'] as String,
      category: $enumDecode(_$PurchaseCategoryEnumMap, json['category']),
      tokenAmount: (json['tokenAmount'] as num).toInt(),
      zarAmount: (json['zarAmount'] as num).toDouble(),
      status: $enumDecode(_$PurchaseStatusEnumMap, json['status']),
      productCode: json['productCode'] as String,
      productName: json['productName'] as String,
      recipientNumber: json['recipientNumber'] as String?,
      voucherCode: json['voucherCode'] as String?,
      voucherPin: json['voucherPin'] as String?,
      reference: json['reference'] as String?,
      failureReason: json['failureReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$PurchaseImplToJson(_$PurchaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'oddienceUserId': instance.oddienceUserId,
      'providerId': instance.providerId,
      'providerName': instance.providerName,
      'category': _$PurchaseCategoryEnumMap[instance.category]!,
      'tokenAmount': instance.tokenAmount,
      'zarAmount': instance.zarAmount,
      'status': _$PurchaseStatusEnumMap[instance.status]!,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'recipientNumber': instance.recipientNumber,
      'voucherCode': instance.voucherCode,
      'voucherPin': instance.voucherPin,
      'reference': instance.reference,
      'failureReason': instance.failureReason,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'processedAt': instance.processedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$PurchaseCategoryEnumMap = {
  PurchaseCategory.airtime: 'airtime',
  PurchaseCategory.data: 'data',
  PurchaseCategory.electricity: 'electricity',
  PurchaseCategory.voucher: 'voucher',
  PurchaseCategory.other: 'other',
};

const _$PurchaseStatusEnumMap = {
  PurchaseStatus.pending: 'pending',
  PurchaseStatus.processing: 'processing',
  PurchaseStatus.completed: 'completed',
  PurchaseStatus.failed: 'failed',
  PurchaseStatus.refunded: 'refunded',
};
