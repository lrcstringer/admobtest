import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/provider_status.dart';
import '../enums/seller_level.dart';
import 'location_data.dart';

part 'marketplace_provider.freezed.dart';

@freezed
class MarketplaceProvider with _$MarketplaceProvider {
  const factory MarketplaceProvider({
    required String id,
    required String userId,
    required String displayName,
    String? bio,
    String? photoUrl,
    String? communityId,
    required ProviderStatus status,
    @Default(0.0) double trustScore,
    @Default(0) int vouchCount,
    @Default(0) int completedOrders,
    @Default(false) bool isVerified,
    bool? isVerifiedOverride,
    @Default([]) List<String> customerIds,
    required DateTime createdAt,
    // ── New fields (Spec §8.25) ──
    @Default([]) List<String> categories,
    List<String>? subCategories,
    @Default(SellerLevel.newSeller) SellerLevel sellerLevel,
    double? avgResponseTimeHrs,
    @Default(0) int warningCount,
    @Default(0) int reportCount,
    @Default(0.0) double disputeRate,
    @Default(0.0) double cancellationRate,
    String? suspensionReason,
    String? suspensionTrigger,
    DateTime? suspendedAt,
    DateTime? bannedAt,
    LocationData? profileLocation,
    @Default(0) double ratingSum,
    String? servicesDescription,
  }) = _MarketplaceProvider;

  const MarketplaceProvider._();


  /// Computed verified status (admin override takes precedence)
  bool get effectiveVerified =>
      isVerifiedOverride ?? (vouchCount >= 5 && trustScore >= 4.0);

  /// Whether provider is active and can create listings
  bool get isActive => status == ProviderStatus.active;

  /// Whether provider is banned permanently
  bool get isBanned => status == ProviderStatus.banned;

  /// Whether provider is suspended
  bool get isSuspended => status == ProviderStatus.suspended;
}
