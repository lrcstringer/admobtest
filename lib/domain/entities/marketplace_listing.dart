import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/delivery_method.dart';
import '../enums/listing_status.dart';
import '../enums/marketplace_category.dart';
import '../enums/service_area_type.dart';
import 'location_data.dart';

part 'marketplace_listing.freezed.dart';

@freezed
abstract class MarketplaceListing with _$MarketplaceListing {
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
    // ── New fields (Spec §8.25) ──
    LocationData? locationData,
    @Default(ServiceAreaType.myLocationOnly) ServiceAreaType serviceAreaType,
    @Default(DeliveryMethod.collection) DeliveryMethod deliveryMethod,
    int? deliveryFee,
    String? geohash,
    @Default(0) int favouriteCount,
    @Default(0) int renewalCount,
    @Default(0) int totalPausedDays,
    DateTime? pausedAt,
  }) = _MarketplaceListing;

  const MarketplaceListing._();


  /// Whether the listing is available for purchase
  bool get isAvailable => status == ListingStatus.active;

  /// Whether listing is paused
  bool get isPaused => status == ListingStatus.paused;

  /// Days until listing expires (null if no expiry set).
  /// Accepts optional [now] for testability.
  int? daysUntilExpiry([DateTime? now]) {
    if (expiresAt == null) return null;
    return expiresAt!.difference(now ?? DateTime.now()).inDays;
  }

  /// Whether listing expires within 7 days.
  /// Accepts optional [now] for testability.
  bool isExpiringSoon([DateTime? now]) {
    final days = daysUntilExpiry(now);
    return days != null && days <= 7 && days >= 0;
  }

  /// Whether listing has been renewed more than 3 times without fresh images
  bool get isStaleRenewal => renewalCount >= 3;

  /// Formatted token price
  String get formattedPrice => '$priceTokens tokens';

  /// Formatted ZAR price
  String get formattedZarPrice => 'R${priceZar.toStringAsFixed(2)}';
}
