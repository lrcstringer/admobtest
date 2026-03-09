import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_storefront.freezed.dart';
part 'brand_storefront.g.dart';

/// A storefront section within a brand's page.
@freezed
class StorefrontSection with _$StorefrontSection {
  const factory StorefrontSection({
    /// Section type: hero, quick_actions, product_grid, about
    required String type,
    String? title,
    /// Type-specific configuration data
    @Default({}) Map<String, dynamic> data,
    @Default(0) int sortOrder,
    @Default(true) bool isVisible,
  }) = _StorefrontSection;

  factory StorefrontSection.fromJson(Map<String, dynamic> json) =>
      _$StorefrontSectionFromJson(json);
}

/// A brand's storefront page in the Buy tab.
@freezed
class BrandStorefront with _$BrandStorefront {
  const factory BrandStorefront({
    required String id,
    required String brandId,
    required String brandName,
    String? brandLogoUrl,
    /// Hex color for brand tinting (e.g. "#E60000" for Vodacom red)
    String? brandColor,
    String? coverImageUrl,
    String? tagline,
    @Default(true) bool isActive,
    @Default(false) bool isPremium,
    /// Community IDs this storefront targets (empty = global)
    @Default([]) List<String> communityIds,
    @Default([]) List<StorefrontSection> sections,
    DateTime? createdAt,
  }) = _BrandStorefront;

  const BrandStorefront._();

  factory BrandStorefront.fromJson(Map<String, dynamic> json) =>
      _$BrandStorefrontFromJson(json);
}
