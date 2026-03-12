// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_storefront.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuickAction _$QuickActionFromJson(Map<String, dynamic> json) => _QuickAction(
  label: json['label'] as String,
  iconEmoji: json['iconEmoji'] as String,
  deepLink: json['deepLink'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$QuickActionToJson(_QuickAction instance) =>
    <String, dynamic>{
      'label': instance.label,
      'iconEmoji': instance.iconEmoji,
      'deepLink': instance.deepLink,
      'sortOrder': instance.sortOrder,
    };

_StorefrontPromo _$StorefrontPromoFromJson(Map<String, dynamic> json) =>
    _StorefrontPromo(
      title: json['title'] as String,
      description: json['description'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      deepLink: json['deepLink'] as String?,
    );

Map<String, dynamic> _$StorefrontPromoToJson(_StorefrontPromo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'deepLink': instance.deepLink,
    };

_StorefrontSection _$StorefrontSectionFromJson(Map<String, dynamic> json) =>
    _StorefrontSection(
      type: json['type'] as String,
      title: json['title'] as String?,
      data: json['data'] as Map<String, dynamic>? ?? const {},
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$StorefrontSectionToJson(_StorefrontSection instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'data': instance.data,
      'sortOrder': instance.sortOrder,
      'isVisible': instance.isVisible,
    };

_SectionSettings _$SectionSettingsFromJson(Map<String, dynamic> json) =>
    _SectionSettings(
      colourMode:
          $enumDecodeNullable(_$SectionColourModeEnumMap, json['colourMode']) ??
          SectionColourMode.brandLight,
      customBgColor: json['customBgColor'] as String?,
      customTextColor: json['customTextColor'] as String?,
      headingOverride: json['headingOverride'] as String?,
      isVisible: json['isVisible'] as bool? ?? true,
      contentAlignment: json['contentAlignment'] as String? ?? 'center',
      paddingTop: (json['paddingTop'] as num?)?.toDouble() ?? 16.0,
      paddingBottom: (json['paddingBottom'] as num?)?.toDouble() ?? 16.0,
    );

Map<String, dynamic> _$SectionSettingsToJson(_SectionSettings instance) =>
    <String, dynamic>{
      'colourMode': _$SectionColourModeEnumMap[instance.colourMode]!,
      'customBgColor': instance.customBgColor,
      'customTextColor': instance.customTextColor,
      'headingOverride': instance.headingOverride,
      'isVisible': instance.isVisible,
      'contentAlignment': instance.contentAlignment,
      'paddingTop': instance.paddingTop,
      'paddingBottom': instance.paddingBottom,
    };

const _$SectionColourModeEnumMap = {
  SectionColourMode.brandLight: 'brandLight',
  SectionColourMode.brandDark: 'brandDark',
  SectionColourMode.brandAccent: 'brandAccent',
  SectionColourMode.custom: 'custom',
};

_ShowcaseVideo _$ShowcaseVideoFromJson(Map<String, dynamic> json) =>
    _ShowcaseVideo(
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      title: json['title'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ShowcaseVideoToJson(_ShowcaseVideo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'title': instance.title,
      'sortOrder': instance.sortOrder,
    };

_StorefrontCoupon _$StorefrontCouponFromJson(Map<String, dynamic> json) =>
    _StorefrontCoupon(
      id: json['id'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      maxClaims: (json['maxClaims'] as num?)?.toInt(),
      claimCount: (json['claimCount'] as num?)?.toInt() ?? 0,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$StorefrontCouponToJson(_StorefrontCoupon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'description': instance.description,
      'maxClaims': instance.maxClaims,
      'claimCount': instance.claimCount,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'isActive': instance.isActive,
    };

_FaqItem _$FaqItemFromJson(Map<String, dynamic> json) => _FaqItem(
  question: json['question'] as String,
  answer: json['answer'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FaqItemToJson(_FaqItem instance) => <String, dynamic>{
  'question': instance.question,
  'answer': instance.answer,
  'sortOrder': instance.sortOrder,
};

_BrandLocation _$BrandLocationFromJson(Map<String, dynamic> json) =>
    _BrandLocation(
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      phone: json['phone'] as String?,
      hours: json['hours'] as String?,
    );

Map<String, dynamic> _$BrandLocationToJson(_BrandLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'phone': instance.phone,
      'hours': instance.hours,
    };

_BrandStorefront _$BrandStorefrontFromJson(
  Map<String, dynamic> json,
) => _BrandStorefront(
  id: json['id'] as String,
  brandId: json['brandId'] as String,
  brandName: json['brandName'] as String,
  brandLogoUrl: json['brandLogoUrl'] as String?,
  brandColor: json['brandColor'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  tagline: json['tagline'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  isPremium: json['isPremium'] as bool? ?? false,
  communityIds:
      (json['communityIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sections:
      (json['sections'] as List<dynamic>?)
          ?.map((e) => StorefrontSection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  heroStyle:
      $enumDecodeNullable(_$HeroStyleEnumMap, json['heroStyle']) ??
      HeroStyle.gradient,
  heroImageUrl: json['heroImageUrl'] as String?,
  heroVideoUrl: json['heroVideoUrl'] as String?,
  accentColor: json['accentColor'] as String?,
  secondaryColor: json['secondaryColor'] as String?,
  logoPlacement:
      $enumDecodeNullable(_$LogoPlacementEnumMap, json['logoPlacement']) ??
      LogoPlacement.centered,
  fontStyle:
      $enumDecodeNullable(_$StorefrontFontStyleEnumMap, json['fontStyle']) ??
      StorefrontFontStyle.modern,
  cornerStyle:
      $enumDecodeNullable(
        _$StorefrontCornerStyleEnumMap,
        json['cornerStyle'],
      ) ??
      StorefrontCornerStyle.rounded,
  themePreference:
      $enumDecodeNullable(
        _$StorefrontThemePreferenceEnumMap,
        json['themePreference'],
      ) ??
      StorefrontThemePreference.auto,
  description: json['description'] as String?,
  bannerImageUrl: json['bannerImageUrl'] as String?,
  bannerDeepLink: json['bannerDeepLink'] as String?,
  establishedYear: (json['establishedYear'] as num?)?.toInt(),
  socialLinks:
      (json['socialLinks'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  trustBadges:
      (json['trustBadges'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TrustBadgeEnumMap, e))
          .toList() ??
      const [],
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  ratingCount: (json['ratingCount'] as num?)?.toInt(),
  quickActions:
      (json['quickActions'] as List<dynamic>?)
          ?.map((e) => QuickAction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  galleryImageUrls:
      (json['galleryImageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  promotions:
      (json['promotions'] as List<dynamic>?)
          ?.map((e) => StorefrontPromo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  sectionOrder:
      (json['sectionOrder'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$StorefrontSectionTypeEnumMap, e))
          .toList() ??
      const [],
  isDraft: json['isDraft'] as bool? ?? true,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  tier: json['tier'] as String? ?? 'standard',
  heroFocalPointX: (json['heroFocalPointX'] as num?)?.toDouble() ?? 0.5,
  heroFocalPointY: (json['heroFocalPointY'] as num?)?.toDouble() ?? 0.5,
  showChatButton: json['showChatButton'] as bool? ?? false,
  bannerVideoUrl: json['bannerVideoUrl'] as String?,
  announcementText: json['announcementText'] as String?,
  announcementDeepLink: json['announcementDeepLink'] as String?,
  announcementDismissible: json['announcementDismissible'] as bool? ?? true,
  showcaseVideos:
      (json['showcaseVideos'] as List<dynamic>?)
          ?.map((e) => ShowcaseVideo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  coupons:
      (json['coupons'] as List<dynamic>?)
          ?.map((e) => StorefrontCoupon.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  faqItems:
      (json['faqItems'] as List<dynamic>?)
          ?.map((e) => FaqItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  testimonialReviewIds:
      (json['testimonialReviewIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => BrandLocation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  richTextBlocks:
      (json['richTextBlocks'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  sectionSettings:
      (json['sectionSettings'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, SectionSettings.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  totalViews: (json['totalViews'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BrandStorefrontToJson(_BrandStorefront instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'brandName': instance.brandName,
      'brandLogoUrl': instance.brandLogoUrl,
      'brandColor': instance.brandColor,
      'coverImageUrl': instance.coverImageUrl,
      'tagline': instance.tagline,
      'isActive': instance.isActive,
      'isPremium': instance.isPremium,
      'communityIds': instance.communityIds,
      'sections': instance.sections,
      'createdAt': instance.createdAt?.toIso8601String(),
      'heroStyle': _$HeroStyleEnumMap[instance.heroStyle]!,
      'heroImageUrl': instance.heroImageUrl,
      'heroVideoUrl': instance.heroVideoUrl,
      'accentColor': instance.accentColor,
      'secondaryColor': instance.secondaryColor,
      'logoPlacement': _$LogoPlacementEnumMap[instance.logoPlacement]!,
      'fontStyle': _$StorefrontFontStyleEnumMap[instance.fontStyle]!,
      'cornerStyle': _$StorefrontCornerStyleEnumMap[instance.cornerStyle]!,
      'themePreference':
          _$StorefrontThemePreferenceEnumMap[instance.themePreference]!,
      'description': instance.description,
      'bannerImageUrl': instance.bannerImageUrl,
      'bannerDeepLink': instance.bannerDeepLink,
      'establishedYear': instance.establishedYear,
      'socialLinks': instance.socialLinks,
      'trustBadges': instance.trustBadges
          .map((e) => _$TrustBadgeEnumMap[e]!)
          .toList(),
      'averageRating': instance.averageRating,
      'ratingCount': instance.ratingCount,
      'quickActions': instance.quickActions,
      'galleryImageUrls': instance.galleryImageUrls,
      'promotions': instance.promotions,
      'sectionOrder': instance.sectionOrder
          .map((e) => _$StorefrontSectionTypeEnumMap[e]!)
          .toList(),
      'isDraft': instance.isDraft,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'tier': instance.tier,
      'heroFocalPointX': instance.heroFocalPointX,
      'heroFocalPointY': instance.heroFocalPointY,
      'showChatButton': instance.showChatButton,
      'bannerVideoUrl': instance.bannerVideoUrl,
      'announcementText': instance.announcementText,
      'announcementDeepLink': instance.announcementDeepLink,
      'announcementDismissible': instance.announcementDismissible,
      'showcaseVideos': instance.showcaseVideos,
      'coupons': instance.coupons,
      'faqItems': instance.faqItems,
      'testimonialReviewIds': instance.testimonialReviewIds,
      'locations': instance.locations,
      'richTextBlocks': instance.richTextBlocks,
      'sectionSettings': instance.sectionSettings,
      'totalViews': instance.totalViews,
    };

const _$HeroStyleEnumMap = {
  HeroStyle.gradient: 'gradient',
  HeroStyle.fullBleedImage: 'fullBleedImage',
  HeroStyle.videoThumbnail: 'videoThumbnail',
};

const _$LogoPlacementEnumMap = {
  LogoPlacement.centered: 'centered',
  LogoPlacement.left: 'left',
};

const _$StorefrontFontStyleEnumMap = {
  StorefrontFontStyle.modern: 'modern',
  StorefrontFontStyle.classic: 'classic',
  StorefrontFontStyle.bold: 'bold',
};

const _$StorefrontCornerStyleEnumMap = {
  StorefrontCornerStyle.rounded: 'rounded',
  StorefrontCornerStyle.sharp: 'sharp',
  StorefrontCornerStyle.pill: 'pill',
};

const _$StorefrontThemePreferenceEnumMap = {
  StorefrontThemePreference.light: 'light',
  StorefrontThemePreference.dark: 'dark',
  StorefrontThemePreference.auto: 'auto',
};

const _$TrustBadgeEnumMap = {
  TrustBadge.verified: 'verified',
  TrustBadge.topSeller: 'topSeller',
  TrustBadge.localBusiness: 'localBusiness',
  TrustBadge.newBrand: 'newBrand',
};

const _$StorefrontSectionTypeEnumMap = {
  StorefrontSectionType.quickActions: 'quickActions',
  StorefrontSectionType.featuredProducts: 'featuredProducts',
  StorefrontSectionType.products: 'products',
  StorefrontSectionType.banner: 'banner',
  StorefrontSectionType.promotions: 'promotions',
  StorefrontSectionType.gallery: 'gallery',
  StorefrontSectionType.reviews: 'reviews',
  StorefrontSectionType.about: 'about',
  StorefrontSectionType.socialLinks: 'socialLinks',
  StorefrontSectionType.announcementBar: 'announcementBar',
  StorefrontSectionType.videoShowcase: 'videoShowcase',
  StorefrontSectionType.couponCenter: 'couponCenter',
  StorefrontSectionType.faq: 'faq',
  StorefrontSectionType.testimonials: 'testimonials',
  StorefrontSectionType.locationCard: 'locationCard',
  StorefrontSectionType.divider: 'divider',
  StorefrontSectionType.richText: 'richText',
};
