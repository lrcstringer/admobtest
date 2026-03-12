// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketplaceOffer _$MarketplaceOfferFromJson(Map<String, dynamic> json) =>
    _MarketplaceOffer(
      id: json['id'] as String,
      listingId: json['listingId'] as String,
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      offerAmount: (json['offerAmount'] as num).toInt(),
      originalPrice: (json['originalPrice'] as num).toInt(),
      status: $enumDecode(_$OfferStatusEnumMap, json['status']),
      counterAmount: (json['counterAmount'] as num?)?.toInt(),
      chatConversationId: json['chatConversationId'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
    );

Map<String, dynamic> _$MarketplaceOfferToJson(_MarketplaceOffer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listingId': instance.listingId,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'offerAmount': instance.offerAmount,
      'originalPrice': instance.originalPrice,
      'status': _$OfferStatusEnumMap[instance.status]!,
      'counterAmount': instance.counterAmount,
      'chatConversationId': instance.chatConversationId,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
    };

const _$OfferStatusEnumMap = {
  OfferStatus.pending: 'pending',
  OfferStatus.accepted: 'accepted',
  OfferStatus.declined: 'declined',
  OfferStatus.countered: 'countered',
  OfferStatus.expired: 'expired',
  OfferStatus.withdrawn: 'withdrawn',
};
