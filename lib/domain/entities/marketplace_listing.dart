import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/listing_status.dart';
import '../enums/marketplace_category.dart';

part 'marketplace_listing.freezed.dart';
part 'marketplace_listing.g.dart';

@freezed
class MarketplaceListing with _$MarketplaceListing {
  const factory MarketplaceListing({
    required String id,
    required String title,
    required String description,
    required MarketplaceCategory category,
    String? subCategory,
    required int priceTokens,
    required double priceZar,
    @Default([]) List<String> images,
    String? thumbnailUrl,
    required String providerId,
    required String providerName,
    String? providerPhotoUrl,
    double? providerTrustScore,
    bool? providerIsVerified,
    String? communityId,
    String? location,
    required ListingStatus status,
    @Default(0) int viewCount,
    @Default(0) int reportCount,
    DateTime? expiresAt,
    required DateTime createdAt,
  }) = _MarketplaceListing;

  const MarketplaceListing._();

  factory MarketplaceListing.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceListingFromJson(json);

  /// Whether the listing is available for purchase
  bool get isAvailable => status == ListingStatus.active;

  /// Formatted token price
  String get formattedPrice => '$priceTokens tokens';

  /// Formatted ZAR price
  String get formattedZarPrice => 'R${priceZar.toStringAsFixed(2)}';
}
