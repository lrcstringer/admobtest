import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/provider_status.dart';

part 'marketplace_provider.freezed.dart';
part 'marketplace_provider.g.dart';

@freezed
class MarketplaceProvider with _$MarketplaceProvider {
  const factory MarketplaceProvider({
    required String id,
    required String userId,
    required String displayName,
    String? bio,
    String? photoUrl,
    String? communityId,
    String? servicesDescription,
    required ProviderStatus status,
    @Default(0.0) double trustScore,
    @Default(0) int vouchCount,
    @Default(0) int completedOrders,
    @Default(false) bool isVerified,
    bool? isVerifiedOverride,
    @Default([]) List<String> customerIds,
    required DateTime createdAt,
  }) = _MarketplaceProvider;

  const MarketplaceProvider._();

  factory MarketplaceProvider.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceProviderFromJson(json);

  /// Computed verified status (admin override takes precedence)
  bool get effectiveVerified =>
      isVerifiedOverride ?? (vouchCount >= 5 && trustScore >= 4.0);

  /// Whether provider is active and can create listings
  bool get isActive => status == ProviderStatus.approved;
}
