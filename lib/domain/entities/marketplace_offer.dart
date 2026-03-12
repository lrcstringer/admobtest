import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/offer_status.dart';

part 'marketplace_offer.freezed.dart';

/// An offer made on a marketplace listing.
/// Lifecycle: pending → accepted/declined/countered/expired/withdrawn.
@freezed
class MarketplaceOffer with _$MarketplaceOffer {
  const factory MarketplaceOffer({
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
  }) = _MarketplaceOffer;

  const MarketplaceOffer._();


  bool get isActive => status.isActive;
  bool get isTerminal => status.isTerminal;
  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  /// Discount percentage relative to the original listing price.
  int get discountPercent =>
      originalPrice > 0
          ? ((1 - offerAmount / originalPrice) * 100).round()
          : 0;
}
