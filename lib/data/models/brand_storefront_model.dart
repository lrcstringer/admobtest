import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/brand_storefront.dart';

part 'brand_storefront_model.freezed.dart';

@freezed
class BrandStorefrontModel with _$BrandStorefrontModel {
  const factory BrandStorefrontModel({
    required String id,
    required String brandId,
    required String brandName,
    String? brandLogoUrl,
    String? brandColor,
    String? coverImageUrl,
    String? tagline,
    @Default(true) bool isActive,
    @Default(false) bool isPremium,
    @Default([]) List<String> communityIds,
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
    @Default([]) List<StorefrontSectionType> sectionOrder,
  }) = _BrandStorefrontModel;

  const BrandStorefrontModel._();

  factory BrandStorefrontModel.fromJson(Map<String, dynamic> json) {
    return BrandStorefrontModel(
      id: json['id'] as String? ?? '',
      brandId: json['brandId'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      brandLogoUrl: json['brandLogoUrl'] as String?,
      brandColor: json['brandColor'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      tagline: json['tagline'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isPremium: json['isPremium'] as bool? ?? false,
      communityIds: (json['communityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) =>
                  StorefrontSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : null,

      // Hero
      heroStyle: _parseEnum(
          json['heroStyle'] as String?, HeroStyle.values, HeroStyle.gradient),
      heroImageUrl: json['heroImageUrl'] as String?,
      heroVideoUrl: json['heroVideoUrl'] as String?,
      accentColor: json['accentColor'] as String?,
      secondaryColor: json['secondaryColor'] as String?,
      logoPlacement: _parseEnum(json['logoPlacement'] as String?,
          LogoPlacement.values, LogoPlacement.centered),

      // Visual Identity
      fontStyle: _parseEnum(json['fontStyle'] as String?,
          StorefrontFontStyle.values, StorefrontFontStyle.modern),
      cornerStyle: _parseEnum(json['cornerStyle'] as String?,
          StorefrontCornerStyle.values, StorefrontCornerStyle.rounded),
      themePreference: _parseEnum(json['themePreference'] as String?,
          StorefrontThemePreference.values, StorefrontThemePreference.auto),

      // Content
      description: json['description'] as String?,
      bannerImageUrl: json['bannerImageUrl'] as String?,
      bannerDeepLink: json['bannerDeepLink'] as String?,
      establishedYear: (json['establishedYear'] as num?)?.toInt(),
      socialLinks: (json['socialLinks'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as String)) ??
          {},

      // Trust
      trustBadges: (json['trustBadges'] as List<dynamic>?)
              ?.map((e) =>
                  _parseEnum(e as String?, TrustBadge.values, TrustBadge.newBrand))
              .toList() ??
          [],
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),

      // Quick Actions
      quickActions: (json['quickActions'] as List<dynamic>?)
              ?.map(
                  (e) => QuickAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],

      // Gallery
      galleryImageUrls: (json['galleryImageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],

      // Promotions
      promotions: (json['promotions'] as List<dynamic>?)
              ?.map((e) =>
                  StorefrontPromo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],

      // Layout
      sectionOrder: (json['sectionOrder'] as List<dynamic>?)
              ?.map((e) => _parseEnum(e as String?,
                  StorefrontSectionType.values, StorefrontSectionType.about))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'brandId': brandId,
      'brandName': brandName,
      if (brandLogoUrl != null) 'brandLogoUrl': brandLogoUrl,
      if (brandColor != null) 'brandColor': brandColor,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl,
      if (tagline != null) 'tagline': tagline,
      'isActive': isActive,
      'isPremium': isPremium,
      'communityIds': communityIds,

      // Hero
      'heroStyle': heroStyle.name,
      if (heroImageUrl != null) 'heroImageUrl': heroImageUrl,
      if (heroVideoUrl != null) 'heroVideoUrl': heroVideoUrl,
      if (accentColor != null) 'accentColor': accentColor,
      if (secondaryColor != null) 'secondaryColor': secondaryColor,
      'logoPlacement': logoPlacement.name,

      // Visual Identity
      'fontStyle': fontStyle.name,
      'cornerStyle': cornerStyle.name,
      'themePreference': themePreference.name,

      // Content
      if (description != null) 'description': description,
      if (bannerImageUrl != null) 'bannerImageUrl': bannerImageUrl,
      if (bannerDeepLink != null) 'bannerDeepLink': bannerDeepLink,
      if (establishedYear != null) 'establishedYear': establishedYear,
      if (socialLinks.isNotEmpty) 'socialLinks': socialLinks,

      // Trust
      if (trustBadges.isNotEmpty)
        'trustBadges': trustBadges.map((b) => b.name).toList(),
      if (averageRating != null) 'averageRating': averageRating,
      if (ratingCount != null) 'ratingCount': ratingCount,

      // Quick Actions
      if (quickActions.isNotEmpty)
        'quickActions': quickActions
            .map((a) => {
                  'label': a.label,
                  'iconEmoji': a.iconEmoji,
                  'deepLink': a.deepLink,
                  'sortOrder': a.sortOrder,
                })
            .toList(),

      // Gallery
      if (galleryImageUrls.isNotEmpty) 'galleryImageUrls': galleryImageUrls,

      // Promotions
      if (promotions.isNotEmpty)
        'promotions': promotions
            .map((p) => {
                  'title': p.title,
                  if (p.description != null) 'description': p.description,
                  if (p.expiresAt != null)
                    'expiresAt': Timestamp.fromDate(p.expiresAt!),
                  if (p.deepLink != null) 'deepLink': p.deepLink,
                })
            .toList(),

      // Layout
      if (sectionOrder.isNotEmpty)
        'sectionOrder': sectionOrder.map((s) => s.name).toList(),

      // Preserve createdAt when writing back
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
    };
  }

  BrandStorefront toEntity() {
    return BrandStorefront(
      id: id,
      brandId: brandId,
      brandName: brandName,
      brandLogoUrl: brandLogoUrl,
      brandColor: brandColor,
      coverImageUrl: coverImageUrl,
      tagline: tagline,
      isActive: isActive,
      isPremium: isPremium,
      communityIds: communityIds,
      sections: sections,
      createdAt: createdAt,
      heroStyle: heroStyle,
      heroImageUrl: heroImageUrl,
      heroVideoUrl: heroVideoUrl,
      accentColor: accentColor,
      secondaryColor: secondaryColor,
      logoPlacement: logoPlacement,
      fontStyle: fontStyle,
      cornerStyle: cornerStyle,
      themePreference: themePreference,
      description: description,
      bannerImageUrl: bannerImageUrl,
      bannerDeepLink: bannerDeepLink,
      establishedYear: establishedYear,
      socialLinks: socialLinks,
      trustBadges: trustBadges,
      averageRating: averageRating,
      ratingCount: ratingCount,
      quickActions: quickActions,
      galleryImageUrls: galleryImageUrls,
      promotions: promotions,
      sectionOrder: sectionOrder,
    );
  }

  factory BrandStorefrontModel.fromEntity(BrandStorefront entity) {
    return BrandStorefrontModel(
      id: entity.id,
      brandId: entity.brandId,
      brandName: entity.brandName,
      brandLogoUrl: entity.brandLogoUrl,
      brandColor: entity.brandColor,
      coverImageUrl: entity.coverImageUrl,
      tagline: entity.tagline,
      isActive: entity.isActive,
      isPremium: entity.isPremium,
      communityIds: entity.communityIds,
      sections: entity.sections,
      createdAt: entity.createdAt,
      heroStyle: entity.heroStyle,
      heroImageUrl: entity.heroImageUrl,
      heroVideoUrl: entity.heroVideoUrl,
      accentColor: entity.accentColor,
      secondaryColor: entity.secondaryColor,
      logoPlacement: entity.logoPlacement,
      fontStyle: entity.fontStyle,
      cornerStyle: entity.cornerStyle,
      themePreference: entity.themePreference,
      description: entity.description,
      bannerImageUrl: entity.bannerImageUrl,
      bannerDeepLink: entity.bannerDeepLink,
      establishedYear: entity.establishedYear,
      socialLinks: entity.socialLinks,
      trustBadges: entity.trustBadges,
      averageRating: entity.averageRating,
      ratingCount: entity.ratingCount,
      quickActions: entity.quickActions,
      galleryImageUrls: entity.galleryImageUrls,
      promotions: entity.promotions,
      sectionOrder: entity.sectionOrder,
    );
  }

  /// Safe enum parser — returns [fallback] if value doesn't match.
  static T _parseEnum<T extends Enum>(
      String? value, List<T> values, T fallback) {
    if (value == null) return fallback;
    return values.firstWhere(
      (e) => e.name == value,
      orElse: () => fallback,
    );
  }
}
