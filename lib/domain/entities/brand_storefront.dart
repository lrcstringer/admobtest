import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_storefront.freezed.dart';

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
  // Original 9 sections
  quickActions,
  featuredProducts,
  products,
  banner,
  promotions,
  gallery,
  reviews,
  about,
  socialLinks,
  // 8 new sections (Spec §4.8)
  announcementBar,
  videoShowcase,
  couponCenter,
  faq,
  testimonials,
  locationCard,
  divider,
  richText,
}

/// Colour mode for per-section styling (Spec §4.7.6)
enum SectionColourMode { brandLight, brandDark, brandAccent, custom }

// ─── Sub-entities ───────────────────────────────────────

@freezed
class QuickAction with _$QuickAction {
  const factory QuickAction({
    required String label,
    required String iconEmoji,
    required String deepLink,
    @Default(0) int sortOrder,
  }) = _QuickAction;

}

@freezed
class StorefrontPromo with _$StorefrontPromo {
  const factory StorefrontPromo({
    required String title,
    String? description,
    DateTime? expiresAt,
    String? deepLink,
  }) = _StorefrontPromo;

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

}

/// Per-section display settings (Spec §4.7.6)
@freezed
class SectionSettings with _$SectionSettings {
  const factory SectionSettings({
    @Default(SectionColourMode.brandLight) SectionColourMode colourMode,
    String? customBgColor,
    String? customTextColor,
    String? headingOverride,
    @Default(true) bool isVisible,
    @Default('center') String contentAlignment,
    @Default(16.0) double paddingTop,
    @Default(16.0) double paddingBottom,
  }) = _SectionSettings;

}

/// Showcase video entry (Spec §4.8)
@freezed
class ShowcaseVideo with _$ShowcaseVideo {
  const factory ShowcaseVideo({
    required String url,
    String? thumbnailUrl,
    String? title,
    @Default(0) int sortOrder,
  }) = _ShowcaseVideo;

}

/// Storefront coupon (Spec §4.8.3)
@freezed
class StorefrontCoupon with _$StorefrontCoupon {
  const factory StorefrontCoupon({
    required String id,
    required String code,
    required String title,
    String? description,
    int? maxClaims,
    @Default(0) int claimCount,
    DateTime? expiresAt,
    @Default(true) bool isActive,
  }) = _StorefrontCoupon;

}

/// FAQ item (Spec §4.8)
@freezed
class FaqItem with _$FaqItem {
  const factory FaqItem({
    required String question,
    required String answer,
    @Default(0) int sortOrder,
  }) = _FaqItem;

}

/// Brand physical location (Spec §4.8)
@freezed
class BrandLocation with _$BrandLocation {
  const factory BrandLocation({
    required String name,
    required String address,
    double? latitude,
    double? longitude,
    String? phone,
    String? hours,
  }) = _BrandLocation;

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

    // ── New fields (Spec §4.14) ──
    @Default(true) bool isDraft,
    DateTime? publishedAt,
    @Default('standard') String tier,
    @Default(0.5) double heroFocalPointX,
    @Default(0.5) double heroFocalPointY,
    @Default(false) bool showChatButton,
    String? bannerVideoUrl,

    // Announcement bar
    String? announcementText,
    String? announcementDeepLink,
    @Default(true) bool announcementDismissible,

    // New content sections
    @Default([]) List<ShowcaseVideo> showcaseVideos,
    @Default([]) List<StorefrontCoupon> coupons,
    @Default([]) List<FaqItem> faqItems,
    @Default([]) List<String> testimonialReviewIds,
    @Default([]) List<BrandLocation> locations,

    // Rich text blocks keyed by section instance ID
    @Default({}) Map<String, String> richTextBlocks,

    // Per-section settings keyed by section type or instance ID
    @Default({}) Map<String, SectionSettings> sectionSettings,

    @Default(0) int totalViews,
  }) = _BrandStorefront;

  const BrandStorefront._();

}
