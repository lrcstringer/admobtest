import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/provider_status.dart';
import '../enums/seller_level.dart';
import 'location_data.dart';

part 'marketplace_provider.freezed.dart';

@freezed
abstract class MarketplaceProvider with _$MarketplaceProvider {
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
    // ── Seller registration fields ──
    @Default({'chat': true, 'phone': false})
    Map<String, bool> contactPreferences,
    @Default(3) int maxActiveListings,
    DateTime? acceptedTermsAt,
    DateTime? deregistrationRequestedAt,
    DateTime? deregistrationEffectiveAt,
  }) = _MarketplaceProvider;

  const MarketplaceProvider._();

  /// Computed verified status (admin override takes precedence)
  bool get effectiveVerified =>
      isVerifiedOverride ?? (vouchCount >= 5 && trustScore >= 4.0);

  /// Whether provider is active and can create listings
  bool get isActive =>
      status == ProviderStatus.active || status == ProviderStatus.approved;

  /// Whether provider is banned permanently
  bool get isBanned => status == ProviderStatus.banned;

  /// Whether provider is suspended
  bool get isSuspended => status == ProviderStatus.suspended;

  /// Whether provider is in the 7-day de-registration cooling-off period
  bool get isDeregistering =>
      status == ProviderStatus.deregisteredPending;

  /// Days remaining until de-registration takes effect (clamped to 0)
  int get daysUntilDeregistration {
    if (deregistrationEffectiveAt == null) return 0;
    final days = deregistrationEffectiveAt!.difference(DateTime.now()).inDays;
    return days < 0 ? 0 : days;
  }
}
