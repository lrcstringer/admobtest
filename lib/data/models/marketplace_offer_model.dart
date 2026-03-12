import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/marketplace_offer.dart';
import '../../domain/enums/offer_status.dart';

part 'marketplace_offer_model.freezed.dart';

@freezed
class MarketplaceOfferModel with _$MarketplaceOfferModel {
  const factory MarketplaceOfferModel({
    required String id,
    required String listingId,
    required String buyerId,
    required String sellerId,
    required int offerAmount,
    required int originalPrice,
    required OfferStatus status,
    int? counterAmount,
    String? chatConversationId,
    DateTime? expiresAt,
    required DateTime createdAt,
    DateTime? respondedAt,
  }) = _MarketplaceOfferModel;

  const MarketplaceOfferModel._();

  factory MarketplaceOfferModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceOfferModel(
      id: json['id'] as String? ?? '',
      listingId: json['listingId'] as String? ?? '',
      buyerId: json['buyerId'] as String? ?? '',
      sellerId: json['sellerId'] as String? ?? '',
      offerAmount: (json['offerAmount'] as num?)?.toInt() ?? 0,
      originalPrice: (json['originalPrice'] as num?)?.toInt() ?? 0,
      status: _parseOfferStatus(json['status'] as String?),
      counterAmount: (json['counterAmount'] as num?)?.toInt(),
      chatConversationId: json['chatConversationId'] as String?,
      expiresAt: _parseDateTimeNullable(json['expiresAt']),
      createdAt: _parseDateTime(json['createdAt']),
      respondedAt: _parseDateTimeNullable(json['respondedAt']),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'listingId': listingId,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'offerAmount': offerAmount,
      'originalPrice': originalPrice,
      'status': status.name,
      if (counterAmount != null) 'counterAmount': counterAmount,
      if (chatConversationId != null)
        'chatConversationId': chatConversationId,
      if (expiresAt != null) 'expiresAt': Timestamp.fromDate(expiresAt!),
      'createdAt': Timestamp.fromDate(createdAt),
      if (respondedAt != null)
        'respondedAt': Timestamp.fromDate(respondedAt!),
    };
  }

  MarketplaceOffer toEntity() {
    return MarketplaceOffer(
      id: id,
      listingId: listingId,
      buyerId: buyerId,
      sellerId: sellerId,
      offerAmount: offerAmount,
      originalPrice: originalPrice,
      status: status,
      counterAmount: counterAmount,
      chatConversationId: chatConversationId,
      expiresAt: expiresAt,
      createdAt: createdAt,
      respondedAt: respondedAt,
    );
  }

  factory MarketplaceOfferModel.fromEntity(MarketplaceOffer entity) {
    return MarketplaceOfferModel(
      id: entity.id,
      listingId: entity.listingId,
      buyerId: entity.buyerId,
      sellerId: entity.sellerId,
      offerAmount: entity.offerAmount,
      originalPrice: entity.originalPrice,
      status: entity.status,
      counterAmount: entity.counterAmount,
      chatConversationId: entity.chatConversationId,
      expiresAt: entity.expiresAt,
      createdAt: entity.createdAt,
      respondedAt: entity.respondedAt,
    );
  }
}

OfferStatus _parseOfferStatus(String? value) {
  if (value == null) return OfferStatus.pending;
  return OfferStatus.values.firstWhere(
    (e) => e.name == value,
    orElse: () => OfferStatus.pending,
  );
}

DateTime _parseDateTime(dynamic value) {
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}

DateTime? _parseDateTimeNullable(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}
