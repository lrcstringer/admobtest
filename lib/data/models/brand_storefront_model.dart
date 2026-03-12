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
      sections: _safeParseList(
          json['sections'], StorefrontSection.fromJson),
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
      quickActions: _safeParseList(json['quickActions'], QuickAction.fromJson),

      // Gallery
      galleryImageUrls: (json['galleryImageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],

      // Promotions
      promotions: _safeParseList(json['promotions'], StorefrontPromo.fromJson),

      // Layout
      sectionOrder: (json['sectionOrder'] as List<dynamic>?)
              ?.map((e) => _parseEnum(e as String?,
                  StorefrontSectionType.values, StorefrontSectionType.about))
              .toList() ??
          [],

      // New fields (Spec §4.14)
      isDraft: json['isDraft'] as bool? ?? true,
      publishedAt: json['publishedAt'] is Timestamp
          ? (json['publishedAt'] as Timestamp).toDate()
          : null,
      tier: json['tier'] as String? ?? 'standard',
      heroFocalPointX: (json['heroFocalPointX'] as num?)?.toDouble() ?? 0.5,
      heroFocalPointY: (json['heroFocalPointY'] as num?)?.toDouble() ?? 0.5,
      showChatButton: json['showChatButton'] as bool? ?? false,
      bannerVideoUrl: json['bannerVideoUrl'] as String?,

      // Announcement bar
      announcementText: json['announcementText'] as String?,
      announcementDeepLink: json['announcementDeepLink'] as String?,
      announcementDismissible:
          json['announcementDismissible'] as bool? ?? true,

      // New content sections
      showcaseVideos:
          _safeParseList(json['showcaseVideos'], ShowcaseVideo.fromJson),
      coupons: _safeParseList(json['coupons'], StorefrontCoupon.fromJson),
      faqItems: _safeParseList(json['faqItems'], FaqItem.fromJson),
      testimonialReviewIds: (json['testimonialReviewIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      locations: _safeParseList(json['locations'], BrandLocation.fromJson),
      richTextBlocks: (json['richTextBlocks'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as String)) ??
          {},
      sectionSettings: (json['sectionSettings'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(
                  k, SectionSettings.fromJson(v as Map<String, dynamic>))) ??
          {},
      totalViews: (json['totalViews'] as num?)?.toInt() ?? 0,
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

      // New fields (Spec §4.14)
      'isDraft': isDraft,
      if (publishedAt != null) 'publishedAt': Timestamp.fromDate(publishedAt!),
      'tier': tier,
      'heroFocalPointX': heroFocalPointX,
      'heroFocalPointY': heroFocalPointY,
      'showChatButton': showChatButton,
      if (bannerVideoUrl != null) 'bannerVideoUrl': bannerVideoUrl,

      // Announcement bar
      if (announcementText != null) 'announcementText': announcementText,
      if (announcementDeepLink != null)
        'announcementDeepLink': announcementDeepLink,
      'announcementDismissible': announcementDismissible,

      // New content sections
      if (showcaseVideos.isNotEmpty)
        'showcaseVideos': showcaseVideos
            .map((v) => {
                  'url': v.url,
                  if (v.thumbnailUrl != null) 'thumbnailUrl': v.thumbnailUrl,
                  if (v.title != null) 'title': v.title,
                  'sortOrder': v.sortOrder,
                })
            .toList(),
      if (coupons.isNotEmpty)
        'coupons': coupons
            .map((c) => {
                  'id': c.id,
                  'code': c.code,
                  'title': c.title,
                  if (c.description != null) 'description': c.description,
                  if (c.maxClaims != null) 'maxClaims': c.maxClaims,
                  'claimCount': c.claimCount,
                  if (c.expiresAt != null)
                    'expiresAt': Timestamp.fromDate(c.expiresAt!),
                  'isActive': c.isActive,
                })
            .toList(),
      if (faqItems.isNotEmpty)
        'faqItems': faqItems
            .map((f) => {
                  'question': f.question,
                  'answer': f.answer,
                  'sortOrder': f.sortOrder,
                })
            .toList(),
      if (testimonialReviewIds.isNotEmpty)
        'testimonialReviewIds': testimonialReviewIds,
      if (locations.isNotEmpty)
        'locations': locations
            .map((l) => {
                  'name': l.name,
                  'address': l.address,
                  if (l.latitude != null) 'latitude': l.latitude,
                  if (l.longitude != null) 'longitude': l.longitude,
                  if (l.phone != null) 'phone': l.phone,
                  if (l.hours != null) 'hours': l.hours,
                })
            .toList(),
      if (richTextBlocks.isNotEmpty) 'richTextBlocks': richTextBlocks,
      if (sectionSettings.isNotEmpty)
        'sectionSettings': sectionSettings.map((k, v) => MapEntry(k, {
              'colourMode': v.colourMode.name,
              if (v.customBgColor != null) 'customBgColor': v.customBgColor,
              if (v.customTextColor != null)
                'customTextColor': v.customTextColor,
              if (v.headingOverride != null)
                'headingOverride': v.headingOverride,
              'isVisible': v.isVisible,
              'contentAlignment': v.contentAlignment,
              'paddingTop': v.paddingTop,
              'paddingBottom': v.paddingBottom,
            })),
      'totalViews': totalViews,

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
      isDraft: isDraft,
      publishedAt: publishedAt,
      tier: tier,
      heroFocalPointX: heroFocalPointX,
      heroFocalPointY: heroFocalPointY,
      showChatButton: showChatButton,
      bannerVideoUrl: bannerVideoUrl,
      announcementText: announcementText,
      announcementDeepLink: announcementDeepLink,
      announcementDismissible: announcementDismissible,
      showcaseVideos: showcaseVideos,
      coupons: coupons,
      faqItems: faqItems,
      testimonialReviewIds: testimonialReviewIds,
      locations: locations,
      richTextBlocks: richTextBlocks,
      sectionSettings: sectionSettings,
      totalViews: totalViews,
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
      isDraft: entity.isDraft,
      publishedAt: entity.publishedAt,
      tier: entity.tier,
      heroFocalPointX: entity.heroFocalPointX,
      heroFocalPointY: entity.heroFocalPointY,
      showChatButton: entity.showChatButton,
      bannerVideoUrl: entity.bannerVideoUrl,
      announcementText: entity.announcementText,
      announcementDeepLink: entity.announcementDeepLink,
      announcementDismissible: entity.announcementDismissible,
      showcaseVideos: entity.showcaseVideos,
      coupons: entity.coupons,
      faqItems: entity.faqItems,
      testimonialReviewIds: entity.testimonialReviewIds,
      locations: entity.locations,
      richTextBlocks: entity.richTextBlocks,
      sectionSettings: entity.sectionSettings,
      totalViews: entity.totalViews,
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

  /// Safely parse a JSON list of sub-entities, skipping malformed entries.
  static List<T> _safeParseList<T>(
      dynamic jsonList, T Function(Map<String, dynamic>) parser) {
    if (jsonList is! List) return [];
    final result = <T>[];
    for (final item in jsonList) {
      if (item is Map<String, dynamic>) {
        try {
          result.add(parser(item));
        } catch (_) {
          // Skip malformed entries rather than crashing the entire model
        }
      }
    }
    return result;
  }
}
