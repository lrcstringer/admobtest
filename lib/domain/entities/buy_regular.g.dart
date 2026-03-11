// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_regular.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BuyRegular _$BuyRegularFromJson(Map<String, dynamic> json) => _BuyRegular(
  id: json['id'] as String,
  providerId: json['providerId'] as String,
  productId: json['productId'] as String,
  providerName: json['providerName'] as String,
  productName: json['productName'] as String,
  recipientNumber: json['recipientNumber'] as String,
  recipientLabel: json['recipientLabel'] as String?,
  isPinned: json['isPinned'] as bool? ?? false,
  usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
  lastUsedAt: DateTime.parse(json['lastUsedAt'] as String),
  categoryEmoji: json['categoryEmoji'] as String?,
  purchaseCategoryMapping: json['purchaseCategoryMapping'] as String?,
);

Map<String, dynamic> _$BuyRegularToJson(_BuyRegular instance) =>
    <String, dynamic>{
      'id': instance.id,
      'providerId': instance.providerId,
      'productId': instance.productId,
      'providerName': instance.providerName,
      'productName': instance.productName,
      'recipientNumber': instance.recipientNumber,
      'recipientLabel': instance.recipientLabel,
      'isPinned': instance.isPinned,
      'usageCount': instance.usageCount,
      'lastUsedAt': instance.lastUsedAt.toIso8601String(),
      'categoryEmoji': instance.categoryEmoji,
      'purchaseCategoryMapping': instance.purchaseCategoryMapping,
    };
