import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_storefront.freezed.dart';
part 'brand_storefront.g.dart';

// ─── Enums ──────────────────────────────────────────────

enum HeroStyle { gradient, fullBleedImage, videoThumbnail }

enum LogoPlacement { centered, left }

enum StorefrontFontStyle { modern, classic, bold }

enum StorefrontCornerStyle { rounded, sharp, pill }

enum StorefrontThemePreference { light, dark, auto }

enum TrustBadge { verified, topSeller, localBusiness, newBrand }

/// Sections available on a storefront page.
/// Visibility + ordering controlled by the `sectionOrder` list.
enum StorefrontSectionType {
  quickActions,
  featuredProducts,
  products,
  banner,
  promotions,
  gallery,
  reviews,
  about,
  socialLinks,
}

// ─── Sub-entities ───────────────────────────────────────

@freezed
class QuickAction with _$QuickAction {
  const factory QuickAction({
    required String label,
    required String iconEmoji,
    required String deepLink,
    @Default(0) int sortOrder,
  }) = _QuickAction;

  factory QuickAction.fromJson(Map<String, dynamic> json) =>
      _$QuickActionFromJson(json);
}

@freezed
class StorefrontPromo with _$StorefrontPromo {
  const factory StorefrontPromo({
    required String title,
    String? description,
    DateTime? expiresAt,
    String? deepLink,
  }) = _StorefrontPromo;

  factory StorefrontPromo.fromJson(Map<String, dynamic> json) =>
      _$StorefrontPromoFromJson(json);
}

/// Legacy section model — kept for backward compat reads only.
@freezed
class StorefrontSection with _$StorefrontSection {
  const factory StorefrontSection({
    required String type,
    String? title,
    @Default({}) Map<String, dynamic> data,
    @Default(0) int sortOrder,
    @Default(true) bool isVisible,
  }) = _StorefrontSection;

  factory StorefrontSection.fromJson(Map<String, dynamic> json) =>
      _$StorefrontSectionFromJson(json);
}

// ─── Main Entity ────────────────────────────────────────

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

    /// Legacy sections (old format — read for migration)
    @Default([]) List<StorefrontSection> sections,

    DateTime? createdAt,

    // ── Hero Section ──
    @Default(HeroStyle.gradient) HeroStyle heroStyle,
    String? heroImageUrl,
    String? heroVideoUrl,
    String? accentColor,
    String? secondaryColor,
    @Default(LogoPlacement.centered) LogoPlacement logoPlacement,

    // ── Visual Identity ──
    @Default(StorefrontFontStyle.modern) StorefrontFontStyle fontStyle,
    @Default(StorefrontCornerStyle.rounded) StorefrontCornerStyle cornerStyle,
    @Default(StorefrontThemePreference.auto)
    StorefrontThemePreference themePreference,

    // ── Content ──
    String? description,
    String? bannerImageUrl,
    String? bannerDeepLink,
    int? establishedYear,

    /// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
    @Default({}) Map<String, String> socialLinks,

    // ── Trust & Social Proof ──
    @Default([]) List<TrustBadge> trustBadges,
    double? averageRating,
    int? ratingCount,

    // ── Quick Actions ──
    @Default([]) List<QuickAction> quickActions,

    // ── Gallery ──
    @Default([]) List<String> galleryImageUrls,

    // ── Promotions ──
    @Default([]) List<StorefrontPromo> promotions,

    // ── Layout ──
    /// Ordered list of section types to display. Sections not in list are hidden.
    @Default([]) List<StorefrontSectionType> sectionOrder,
  }) = _BrandStorefront;

  const BrandStorefront._();

  factory BrandStorefront.fromJson(Map<String, dynamic> json) =>
      _$BrandStorefrontFromJson(json);
}
