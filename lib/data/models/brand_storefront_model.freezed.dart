// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_storefront_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandStorefrontModel {

 String get id; String get brandId; String get brandName; String? get brandLogoUrl; String? get brandColor; String? get coverImageUrl; String? get tagline; bool get isActive; bool get isPremium; List<String> get communityIds; List<StorefrontSection> get sections; DateTime? get createdAt;// ── Hero Section ──
 HeroStyle get heroStyle; String? get heroImageUrl; String? get heroVideoUrl; String? get accentColor; String? get secondaryColor; LogoPlacement get logoPlacement;// ── Visual Identity ──
 StorefrontFontStyle get fontStyle; StorefrontCornerStyle get cornerStyle; StorefrontThemePreference get themePreference;// ── Content ──
 String? get description; String? get bannerImageUrl; String? get bannerDeepLink; int? get establishedYear; Map<String, String> get socialLinks;// ── Trust & Social Proof ──
 List<TrustBadge> get trustBadges; double? get averageRating; int? get ratingCount;// ── Quick Actions ──
 List<QuickAction> get quickActions;// ── Gallery ──
 List<String> get galleryImageUrls;// ── Promotions ──
 List<StorefrontPromo> get promotions;// ── Layout ──
 List<StorefrontSectionType> get sectionOrder;// ── New fields (Spec §4.14) ──
 bool get isDraft; DateTime? get publishedAt; String get tier; double get heroFocalPointX; double get heroFocalPointY; bool get showChatButton; String? get bannerVideoUrl;// Announcement bar
 String? get announcementText; String? get announcementDeepLink; bool get announcementDismissible;// New content sections
 List<ShowcaseVideo> get showcaseVideos; List<StorefrontCoupon> get coupons; List<FaqItem> get faqItems; List<String> get testimonialReviewIds; List<BrandLocation> get locations;// Rich text blocks keyed by section instance ID
 Map<String, String> get richTextBlocks;// Per-section settings keyed by section type or instance ID
 Map<String, SectionSettings> get sectionSettings; int get totalViews;
/// Create a copy of BrandStorefrontModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandStorefrontModelCopyWith<BrandStorefrontModel> get copyWith => _$BrandStorefrontModelCopyWithImpl<BrandStorefrontModel>(this as BrandStorefrontModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandStorefrontModel&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.brandColor, brandColor) || other.brandColor == brandColor)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&const DeepCollectionEquality().equals(other.communityIds, communityIds)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.heroStyle, heroStyle) || other.heroStyle == heroStyle)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.heroVideoUrl, heroVideoUrl) || other.heroVideoUrl == heroVideoUrl)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoPlacement, logoPlacement) || other.logoPlacement == logoPlacement)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.cornerStyle, cornerStyle) || other.cornerStyle == cornerStyle)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerImageUrl, bannerImageUrl) || other.bannerImageUrl == bannerImageUrl)&&(identical(other.bannerDeepLink, bannerDeepLink) || other.bannerDeepLink == bannerDeepLink)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&const DeepCollectionEquality().equals(other.socialLinks, socialLinks)&&const DeepCollectionEquality().equals(other.trustBadges, trustBadges)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.quickActions, quickActions)&&const DeepCollectionEquality().equals(other.galleryImageUrls, galleryImageUrls)&&const DeepCollectionEquality().equals(other.promotions, promotions)&&const DeepCollectionEquality().equals(other.sectionOrder, sectionOrder)&&(identical(other.isDraft, isDraft) || other.isDraft == isDraft)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.heroFocalPointX, heroFocalPointX) || other.heroFocalPointX == heroFocalPointX)&&(identical(other.heroFocalPointY, heroFocalPointY) || other.heroFocalPointY == heroFocalPointY)&&(identical(other.showChatButton, showChatButton) || other.showChatButton == showChatButton)&&(identical(other.bannerVideoUrl, bannerVideoUrl) || other.bannerVideoUrl == bannerVideoUrl)&&(identical(other.announcementText, announcementText) || other.announcementText == announcementText)&&(identical(other.announcementDeepLink, announcementDeepLink) || other.announcementDeepLink == announcementDeepLink)&&(identical(other.announcementDismissible, announcementDismissible) || other.announcementDismissible == announcementDismissible)&&const DeepCollectionEquality().equals(other.showcaseVideos, showcaseVideos)&&const DeepCollectionEquality().equals(other.coupons, coupons)&&const DeepCollectionEquality().equals(other.faqItems, faqItems)&&const DeepCollectionEquality().equals(other.testimonialReviewIds, testimonialReviewIds)&&const DeepCollectionEquality().equals(other.locations, locations)&&const DeepCollectionEquality().equals(other.richTextBlocks, richTextBlocks)&&const DeepCollectionEquality().equals(other.sectionSettings, sectionSettings)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,brandLogoUrl,brandColor,coverImageUrl,tagline,isActive,isPremium,const DeepCollectionEquality().hash(communityIds),const DeepCollectionEquality().hash(sections),createdAt,heroStyle,heroImageUrl,heroVideoUrl,accentColor,secondaryColor,logoPlacement,fontStyle,cornerStyle,themePreference,description,bannerImageUrl,bannerDeepLink,establishedYear,const DeepCollectionEquality().hash(socialLinks),const DeepCollectionEquality().hash(trustBadges),averageRating,ratingCount,const DeepCollectionEquality().hash(quickActions),const DeepCollectionEquality().hash(galleryImageUrls),const DeepCollectionEquality().hash(promotions),const DeepCollectionEquality().hash(sectionOrder),isDraft,publishedAt,tier,heroFocalPointX,heroFocalPointY,showChatButton,bannerVideoUrl,announcementText,announcementDeepLink,announcementDismissible,const DeepCollectionEquality().hash(showcaseVideos),const DeepCollectionEquality().hash(coupons),const DeepCollectionEquality().hash(faqItems),const DeepCollectionEquality().hash(testimonialReviewIds),const DeepCollectionEquality().hash(locations),const DeepCollectionEquality().hash(richTextBlocks),const DeepCollectionEquality().hash(sectionSettings),totalViews]);

@override
String toString() {
  return 'BrandStorefrontModel(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder, isDraft: $isDraft, publishedAt: $publishedAt, tier: $tier, heroFocalPointX: $heroFocalPointX, heroFocalPointY: $heroFocalPointY, showChatButton: $showChatButton, bannerVideoUrl: $bannerVideoUrl, announcementText: $announcementText, announcementDeepLink: $announcementDeepLink, announcementDismissible: $announcementDismissible, showcaseVideos: $showcaseVideos, coupons: $coupons, faqItems: $faqItems, testimonialReviewIds: $testimonialReviewIds, locations: $locations, richTextBlocks: $richTextBlocks, sectionSettings: $sectionSettings, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class $BrandStorefrontModelCopyWith<$Res>  {
  factory $BrandStorefrontModelCopyWith(BrandStorefrontModel value, $Res Function(BrandStorefrontModel) _then) = _$BrandStorefrontModelCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String brandName, String? brandLogoUrl, String? brandColor, String? coverImageUrl, String? tagline, bool isActive, bool isPremium, List<String> communityIds, List<StorefrontSection> sections, DateTime? createdAt, HeroStyle heroStyle, String? heroImageUrl, String? heroVideoUrl, String? accentColor, String? secondaryColor, LogoPlacement logoPlacement, StorefrontFontStyle fontStyle, StorefrontCornerStyle cornerStyle, StorefrontThemePreference themePreference, String? description, String? bannerImageUrl, String? bannerDeepLink, int? establishedYear, Map<String, String> socialLinks, List<TrustBadge> trustBadges, double? averageRating, int? ratingCount, List<QuickAction> quickActions, List<String> galleryImageUrls, List<StorefrontPromo> promotions, List<StorefrontSectionType> sectionOrder, bool isDraft, DateTime? publishedAt, String tier, double heroFocalPointX, double heroFocalPointY, bool showChatButton, String? bannerVideoUrl, String? announcementText, String? announcementDeepLink, bool announcementDismissible, List<ShowcaseVideo> showcaseVideos, List<StorefrontCoupon> coupons, List<FaqItem> faqItems, List<String> testimonialReviewIds, List<BrandLocation> locations, Map<String, String> richTextBlocks, Map<String, SectionSettings> sectionSettings, int totalViews
});




}
/// @nodoc
class _$BrandStorefrontModelCopyWithImpl<$Res>
    implements $BrandStorefrontModelCopyWith<$Res> {
  _$BrandStorefrontModelCopyWithImpl(this._self, this._then);

  final BrandStorefrontModel _self;
  final $Res Function(BrandStorefrontModel) _then;

/// Create a copy of BrandStorefrontModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? brandColor = freezed,Object? coverImageUrl = freezed,Object? tagline = freezed,Object? isActive = null,Object? isPremium = null,Object? communityIds = null,Object? sections = null,Object? createdAt = freezed,Object? heroStyle = null,Object? heroImageUrl = freezed,Object? heroVideoUrl = freezed,Object? accentColor = freezed,Object? secondaryColor = freezed,Object? logoPlacement = null,Object? fontStyle = null,Object? cornerStyle = null,Object? themePreference = null,Object? description = freezed,Object? bannerImageUrl = freezed,Object? bannerDeepLink = freezed,Object? establishedYear = freezed,Object? socialLinks = null,Object? trustBadges = null,Object? averageRating = freezed,Object? ratingCount = freezed,Object? quickActions = null,Object? galleryImageUrls = null,Object? promotions = null,Object? sectionOrder = null,Object? isDraft = null,Object? publishedAt = freezed,Object? tier = null,Object? heroFocalPointX = null,Object? heroFocalPointY = null,Object? showChatButton = null,Object? bannerVideoUrl = freezed,Object? announcementText = freezed,Object? announcementDeepLink = freezed,Object? announcementDismissible = null,Object? showcaseVideos = null,Object? coupons = null,Object? faqItems = null,Object? testimonialReviewIds = null,Object? locations = null,Object? richTextBlocks = null,Object? sectionSettings = null,Object? totalViews = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,brandColor: freezed == brandColor ? _self.brandColor : brandColor // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,communityIds: null == communityIds ? _self.communityIds : communityIds // ignore: cast_nullable_to_non_nullable
as List<String>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<StorefrontSection>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,heroStyle: null == heroStyle ? _self.heroStyle : heroStyle // ignore: cast_nullable_to_non_nullable
as HeroStyle,heroImageUrl: freezed == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String?,heroVideoUrl: freezed == heroVideoUrl ? _self.heroVideoUrl : heroVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,accentColor: freezed == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String?,secondaryColor: freezed == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String?,logoPlacement: null == logoPlacement ? _self.logoPlacement : logoPlacement // ignore: cast_nullable_to_non_nullable
as LogoPlacement,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as StorefrontFontStyle,cornerStyle: null == cornerStyle ? _self.cornerStyle : cornerStyle // ignore: cast_nullable_to_non_nullable
as StorefrontCornerStyle,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as StorefrontThemePreference,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bannerImageUrl: freezed == bannerImageUrl ? _self.bannerImageUrl : bannerImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerDeepLink: freezed == bannerDeepLink ? _self.bannerDeepLink : bannerDeepLink // ignore: cast_nullable_to_non_nullable
as String?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,socialLinks: null == socialLinks ? _self.socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustBadges: null == trustBadges ? _self.trustBadges : trustBadges // ignore: cast_nullable_to_non_nullable
as List<TrustBadge>,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,quickActions: null == quickActions ? _self.quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,galleryImageUrls: null == galleryImageUrls ? _self.galleryImageUrls : galleryImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,promotions: null == promotions ? _self.promotions : promotions // ignore: cast_nullable_to_non_nullable
as List<StorefrontPromo>,sectionOrder: null == sectionOrder ? _self.sectionOrder : sectionOrder // ignore: cast_nullable_to_non_nullable
as List<StorefrontSectionType>,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,heroFocalPointX: null == heroFocalPointX ? _self.heroFocalPointX : heroFocalPointX // ignore: cast_nullable_to_non_nullable
as double,heroFocalPointY: null == heroFocalPointY ? _self.heroFocalPointY : heroFocalPointY // ignore: cast_nullable_to_non_nullable
as double,showChatButton: null == showChatButton ? _self.showChatButton : showChatButton // ignore: cast_nullable_to_non_nullable
as bool,bannerVideoUrl: freezed == bannerVideoUrl ? _self.bannerVideoUrl : bannerVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,announcementText: freezed == announcementText ? _self.announcementText : announcementText // ignore: cast_nullable_to_non_nullable
as String?,announcementDeepLink: freezed == announcementDeepLink ? _self.announcementDeepLink : announcementDeepLink // ignore: cast_nullable_to_non_nullable
as String?,announcementDismissible: null == announcementDismissible ? _self.announcementDismissible : announcementDismissible // ignore: cast_nullable_to_non_nullable
as bool,showcaseVideos: null == showcaseVideos ? _self.showcaseVideos : showcaseVideos // ignore: cast_nullable_to_non_nullable
as List<ShowcaseVideo>,coupons: null == coupons ? _self.coupons : coupons // ignore: cast_nullable_to_non_nullable
as List<StorefrontCoupon>,faqItems: null == faqItems ? _self.faqItems : faqItems // ignore: cast_nullable_to_non_nullable
as List<FaqItem>,testimonialReviewIds: null == testimonialReviewIds ? _self.testimonialReviewIds : testimonialReviewIds // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<BrandLocation>,richTextBlocks: null == richTextBlocks ? _self.richTextBlocks : richTextBlocks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,sectionSettings: null == sectionSettings ? _self.sectionSettings : sectionSettings // ignore: cast_nullable_to_non_nullable
as Map<String, SectionSettings>,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandStorefrontModel].
extension BrandStorefrontModelPatterns on BrandStorefrontModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandStorefrontModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandStorefrontModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandStorefrontModel value)  $default,){
final _that = this;
switch (_that) {
case _BrandStorefrontModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandStorefrontModel value)?  $default,){
final _that = this;
switch (_that) {
case _BrandStorefrontModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder,  bool isDraft,  DateTime? publishedAt,  String tier,  double heroFocalPointX,  double heroFocalPointY,  bool showChatButton,  String? bannerVideoUrl,  String? announcementText,  String? announcementDeepLink,  bool announcementDismissible,  List<ShowcaseVideo> showcaseVideos,  List<StorefrontCoupon> coupons,  List<FaqItem> faqItems,  List<String> testimonialReviewIds,  List<BrandLocation> locations,  Map<String, String> richTextBlocks,  Map<String, SectionSettings> sectionSettings,  int totalViews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandStorefrontModel() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder,_that.isDraft,_that.publishedAt,_that.tier,_that.heroFocalPointX,_that.heroFocalPointY,_that.showChatButton,_that.bannerVideoUrl,_that.announcementText,_that.announcementDeepLink,_that.announcementDismissible,_that.showcaseVideos,_that.coupons,_that.faqItems,_that.testimonialReviewIds,_that.locations,_that.richTextBlocks,_that.sectionSettings,_that.totalViews);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder,  bool isDraft,  DateTime? publishedAt,  String tier,  double heroFocalPointX,  double heroFocalPointY,  bool showChatButton,  String? bannerVideoUrl,  String? announcementText,  String? announcementDeepLink,  bool announcementDismissible,  List<ShowcaseVideo> showcaseVideos,  List<StorefrontCoupon> coupons,  List<FaqItem> faqItems,  List<String> testimonialReviewIds,  List<BrandLocation> locations,  Map<String, String> richTextBlocks,  Map<String, SectionSettings> sectionSettings,  int totalViews)  $default,) {final _that = this;
switch (_that) {
case _BrandStorefrontModel():
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder,_that.isDraft,_that.publishedAt,_that.tier,_that.heroFocalPointX,_that.heroFocalPointY,_that.showChatButton,_that.bannerVideoUrl,_that.announcementText,_that.announcementDeepLink,_that.announcementDismissible,_that.showcaseVideos,_that.coupons,_that.faqItems,_that.testimonialReviewIds,_that.locations,_that.richTextBlocks,_that.sectionSettings,_that.totalViews);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandId,  String brandName,  String? brandLogoUrl,  String? brandColor,  String? coverImageUrl,  String? tagline,  bool isActive,  bool isPremium,  List<String> communityIds,  List<StorefrontSection> sections,  DateTime? createdAt,  HeroStyle heroStyle,  String? heroImageUrl,  String? heroVideoUrl,  String? accentColor,  String? secondaryColor,  LogoPlacement logoPlacement,  StorefrontFontStyle fontStyle,  StorefrontCornerStyle cornerStyle,  StorefrontThemePreference themePreference,  String? description,  String? bannerImageUrl,  String? bannerDeepLink,  int? establishedYear,  Map<String, String> socialLinks,  List<TrustBadge> trustBadges,  double? averageRating,  int? ratingCount,  List<QuickAction> quickActions,  List<String> galleryImageUrls,  List<StorefrontPromo> promotions,  List<StorefrontSectionType> sectionOrder,  bool isDraft,  DateTime? publishedAt,  String tier,  double heroFocalPointX,  double heroFocalPointY,  bool showChatButton,  String? bannerVideoUrl,  String? announcementText,  String? announcementDeepLink,  bool announcementDismissible,  List<ShowcaseVideo> showcaseVideos,  List<StorefrontCoupon> coupons,  List<FaqItem> faqItems,  List<String> testimonialReviewIds,  List<BrandLocation> locations,  Map<String, String> richTextBlocks,  Map<String, SectionSettings> sectionSettings,  int totalViews)?  $default,) {final _that = this;
switch (_that) {
case _BrandStorefrontModel() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandLogoUrl,_that.brandColor,_that.coverImageUrl,_that.tagline,_that.isActive,_that.isPremium,_that.communityIds,_that.sections,_that.createdAt,_that.heroStyle,_that.heroImageUrl,_that.heroVideoUrl,_that.accentColor,_that.secondaryColor,_that.logoPlacement,_that.fontStyle,_that.cornerStyle,_that.themePreference,_that.description,_that.bannerImageUrl,_that.bannerDeepLink,_that.establishedYear,_that.socialLinks,_that.trustBadges,_that.averageRating,_that.ratingCount,_that.quickActions,_that.galleryImageUrls,_that.promotions,_that.sectionOrder,_that.isDraft,_that.publishedAt,_that.tier,_that.heroFocalPointX,_that.heroFocalPointY,_that.showChatButton,_that.bannerVideoUrl,_that.announcementText,_that.announcementDeepLink,_that.announcementDismissible,_that.showcaseVideos,_that.coupons,_that.faqItems,_that.testimonialReviewIds,_that.locations,_that.richTextBlocks,_that.sectionSettings,_that.totalViews);case _:
  return null;

}
}

}

/// @nodoc


class _BrandStorefrontModel extends BrandStorefrontModel {
  const _BrandStorefrontModel({required this.id, required this.brandId, required this.brandName, this.brandLogoUrl, this.brandColor, this.coverImageUrl, this.tagline, this.isActive = true, this.isPremium = false, final  List<String> communityIds = const [], final  List<StorefrontSection> sections = const [], this.createdAt, this.heroStyle = HeroStyle.gradient, this.heroImageUrl, this.heroVideoUrl, this.accentColor, this.secondaryColor, this.logoPlacement = LogoPlacement.centered, this.fontStyle = StorefrontFontStyle.modern, this.cornerStyle = StorefrontCornerStyle.rounded, this.themePreference = StorefrontThemePreference.auto, this.description, this.bannerImageUrl, this.bannerDeepLink, this.establishedYear, final  Map<String, String> socialLinks = const {}, final  List<TrustBadge> trustBadges = const [], this.averageRating, this.ratingCount, final  List<QuickAction> quickActions = const [], final  List<String> galleryImageUrls = const [], final  List<StorefrontPromo> promotions = const [], final  List<StorefrontSectionType> sectionOrder = const [], this.isDraft = true, this.publishedAt, this.tier = 'standard', this.heroFocalPointX = 0.5, this.heroFocalPointY = 0.5, this.showChatButton = false, this.bannerVideoUrl, this.announcementText, this.announcementDeepLink, this.announcementDismissible = true, final  List<ShowcaseVideo> showcaseVideos = const [], final  List<StorefrontCoupon> coupons = const [], final  List<FaqItem> faqItems = const [], final  List<String> testimonialReviewIds = const [], final  List<BrandLocation> locations = const [], final  Map<String, String> richTextBlocks = const {}, final  Map<String, SectionSettings> sectionSettings = const {}, this.totalViews = 0}): _communityIds = communityIds,_sections = sections,_socialLinks = socialLinks,_trustBadges = trustBadges,_quickActions = quickActions,_galleryImageUrls = galleryImageUrls,_promotions = promotions,_sectionOrder = sectionOrder,_showcaseVideos = showcaseVideos,_coupons = coupons,_faqItems = faqItems,_testimonialReviewIds = testimonialReviewIds,_locations = locations,_richTextBlocks = richTextBlocks,_sectionSettings = sectionSettings,super._();
  

@override final  String id;
@override final  String brandId;
@override final  String brandName;
@override final  String? brandLogoUrl;
@override final  String? brandColor;
@override final  String? coverImageUrl;
@override final  String? tagline;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isPremium;
 final  List<String> _communityIds;
@override@JsonKey() List<String> get communityIds {
  if (_communityIds is EqualUnmodifiableListView) return _communityIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communityIds);
}

 final  List<StorefrontSection> _sections;
@override@JsonKey() List<StorefrontSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  DateTime? createdAt;
// ── Hero Section ──
@override@JsonKey() final  HeroStyle heroStyle;
@override final  String? heroImageUrl;
@override final  String? heroVideoUrl;
@override final  String? accentColor;
@override final  String? secondaryColor;
@override@JsonKey() final  LogoPlacement logoPlacement;
// ── Visual Identity ──
@override@JsonKey() final  StorefrontFontStyle fontStyle;
@override@JsonKey() final  StorefrontCornerStyle cornerStyle;
@override@JsonKey() final  StorefrontThemePreference themePreference;
// ── Content ──
@override final  String? description;
@override final  String? bannerImageUrl;
@override final  String? bannerDeepLink;
@override final  int? establishedYear;
 final  Map<String, String> _socialLinks;
@override@JsonKey() Map<String, String> get socialLinks {
  if (_socialLinks is EqualUnmodifiableMapView) return _socialLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_socialLinks);
}

// ── Trust & Social Proof ──
 final  List<TrustBadge> _trustBadges;
// ── Trust & Social Proof ──
@override@JsonKey() List<TrustBadge> get trustBadges {
  if (_trustBadges is EqualUnmodifiableListView) return _trustBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trustBadges);
}

@override final  double? averageRating;
@override final  int? ratingCount;
// ── Quick Actions ──
 final  List<QuickAction> _quickActions;
// ── Quick Actions ──
@override@JsonKey() List<QuickAction> get quickActions {
  if (_quickActions is EqualUnmodifiableListView) return _quickActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quickActions);
}

// ── Gallery ──
 final  List<String> _galleryImageUrls;
// ── Gallery ──
@override@JsonKey() List<String> get galleryImageUrls {
  if (_galleryImageUrls is EqualUnmodifiableListView) return _galleryImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_galleryImageUrls);
}

// ── Promotions ──
 final  List<StorefrontPromo> _promotions;
// ── Promotions ──
@override@JsonKey() List<StorefrontPromo> get promotions {
  if (_promotions is EqualUnmodifiableListView) return _promotions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_promotions);
}

// ── Layout ──
 final  List<StorefrontSectionType> _sectionOrder;
// ── Layout ──
@override@JsonKey() List<StorefrontSectionType> get sectionOrder {
  if (_sectionOrder is EqualUnmodifiableListView) return _sectionOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectionOrder);
}

// ── New fields (Spec §4.14) ──
@override@JsonKey() final  bool isDraft;
@override final  DateTime? publishedAt;
@override@JsonKey() final  String tier;
@override@JsonKey() final  double heroFocalPointX;
@override@JsonKey() final  double heroFocalPointY;
@override@JsonKey() final  bool showChatButton;
@override final  String? bannerVideoUrl;
// Announcement bar
@override final  String? announcementText;
@override final  String? announcementDeepLink;
@override@JsonKey() final  bool announcementDismissible;
// New content sections
 final  List<ShowcaseVideo> _showcaseVideos;
// New content sections
@override@JsonKey() List<ShowcaseVideo> get showcaseVideos {
  if (_showcaseVideos is EqualUnmodifiableListView) return _showcaseVideos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_showcaseVideos);
}

 final  List<StorefrontCoupon> _coupons;
@override@JsonKey() List<StorefrontCoupon> get coupons {
  if (_coupons is EqualUnmodifiableListView) return _coupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coupons);
}

 final  List<FaqItem> _faqItems;
@override@JsonKey() List<FaqItem> get faqItems {
  if (_faqItems is EqualUnmodifiableListView) return _faqItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faqItems);
}

 final  List<String> _testimonialReviewIds;
@override@JsonKey() List<String> get testimonialReviewIds {
  if (_testimonialReviewIds is EqualUnmodifiableListView) return _testimonialReviewIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_testimonialReviewIds);
}

 final  List<BrandLocation> _locations;
@override@JsonKey() List<BrandLocation> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

// Rich text blocks keyed by section instance ID
 final  Map<String, String> _richTextBlocks;
// Rich text blocks keyed by section instance ID
@override@JsonKey() Map<String, String> get richTextBlocks {
  if (_richTextBlocks is EqualUnmodifiableMapView) return _richTextBlocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_richTextBlocks);
}

// Per-section settings keyed by section type or instance ID
 final  Map<String, SectionSettings> _sectionSettings;
// Per-section settings keyed by section type or instance ID
@override@JsonKey() Map<String, SectionSettings> get sectionSettings {
  if (_sectionSettings is EqualUnmodifiableMapView) return _sectionSettings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sectionSettings);
}

@override@JsonKey() final  int totalViews;

/// Create a copy of BrandStorefrontModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandStorefrontModelCopyWith<_BrandStorefrontModel> get copyWith => __$BrandStorefrontModelCopyWithImpl<_BrandStorefrontModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandStorefrontModel&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandLogoUrl, brandLogoUrl) || other.brandLogoUrl == brandLogoUrl)&&(identical(other.brandColor, brandColor) || other.brandColor == brandColor)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&const DeepCollectionEquality().equals(other._communityIds, _communityIds)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.heroStyle, heroStyle) || other.heroStyle == heroStyle)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.heroVideoUrl, heroVideoUrl) || other.heroVideoUrl == heroVideoUrl)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.logoPlacement, logoPlacement) || other.logoPlacement == logoPlacement)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.cornerStyle, cornerStyle) || other.cornerStyle == cornerStyle)&&(identical(other.themePreference, themePreference) || other.themePreference == themePreference)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerImageUrl, bannerImageUrl) || other.bannerImageUrl == bannerImageUrl)&&(identical(other.bannerDeepLink, bannerDeepLink) || other.bannerDeepLink == bannerDeepLink)&&(identical(other.establishedYear, establishedYear) || other.establishedYear == establishedYear)&&const DeepCollectionEquality().equals(other._socialLinks, _socialLinks)&&const DeepCollectionEquality().equals(other._trustBadges, _trustBadges)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other._quickActions, _quickActions)&&const DeepCollectionEquality().equals(other._galleryImageUrls, _galleryImageUrls)&&const DeepCollectionEquality().equals(other._promotions, _promotions)&&const DeepCollectionEquality().equals(other._sectionOrder, _sectionOrder)&&(identical(other.isDraft, isDraft) || other.isDraft == isDraft)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.heroFocalPointX, heroFocalPointX) || other.heroFocalPointX == heroFocalPointX)&&(identical(other.heroFocalPointY, heroFocalPointY) || other.heroFocalPointY == heroFocalPointY)&&(identical(other.showChatButton, showChatButton) || other.showChatButton == showChatButton)&&(identical(other.bannerVideoUrl, bannerVideoUrl) || other.bannerVideoUrl == bannerVideoUrl)&&(identical(other.announcementText, announcementText) || other.announcementText == announcementText)&&(identical(other.announcementDeepLink, announcementDeepLink) || other.announcementDeepLink == announcementDeepLink)&&(identical(other.announcementDismissible, announcementDismissible) || other.announcementDismissible == announcementDismissible)&&const DeepCollectionEquality().equals(other._showcaseVideos, _showcaseVideos)&&const DeepCollectionEquality().equals(other._coupons, _coupons)&&const DeepCollectionEquality().equals(other._faqItems, _faqItems)&&const DeepCollectionEquality().equals(other._testimonialReviewIds, _testimonialReviewIds)&&const DeepCollectionEquality().equals(other._locations, _locations)&&const DeepCollectionEquality().equals(other._richTextBlocks, _richTextBlocks)&&const DeepCollectionEquality().equals(other._sectionSettings, _sectionSettings)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,brandId,brandName,brandLogoUrl,brandColor,coverImageUrl,tagline,isActive,isPremium,const DeepCollectionEquality().hash(_communityIds),const DeepCollectionEquality().hash(_sections),createdAt,heroStyle,heroImageUrl,heroVideoUrl,accentColor,secondaryColor,logoPlacement,fontStyle,cornerStyle,themePreference,description,bannerImageUrl,bannerDeepLink,establishedYear,const DeepCollectionEquality().hash(_socialLinks),const DeepCollectionEquality().hash(_trustBadges),averageRating,ratingCount,const DeepCollectionEquality().hash(_quickActions),const DeepCollectionEquality().hash(_galleryImageUrls),const DeepCollectionEquality().hash(_promotions),const DeepCollectionEquality().hash(_sectionOrder),isDraft,publishedAt,tier,heroFocalPointX,heroFocalPointY,showChatButton,bannerVideoUrl,announcementText,announcementDeepLink,announcementDismissible,const DeepCollectionEquality().hash(_showcaseVideos),const DeepCollectionEquality().hash(_coupons),const DeepCollectionEquality().hash(_faqItems),const DeepCollectionEquality().hash(_testimonialReviewIds),const DeepCollectionEquality().hash(_locations),const DeepCollectionEquality().hash(_richTextBlocks),const DeepCollectionEquality().hash(_sectionSettings),totalViews]);

@override
String toString() {
  return 'BrandStorefrontModel(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder, isDraft: $isDraft, publishedAt: $publishedAt, tier: $tier, heroFocalPointX: $heroFocalPointX, heroFocalPointY: $heroFocalPointY, showChatButton: $showChatButton, bannerVideoUrl: $bannerVideoUrl, announcementText: $announcementText, announcementDeepLink: $announcementDeepLink, announcementDismissible: $announcementDismissible, showcaseVideos: $showcaseVideos, coupons: $coupons, faqItems: $faqItems, testimonialReviewIds: $testimonialReviewIds, locations: $locations, richTextBlocks: $richTextBlocks, sectionSettings: $sectionSettings, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class _$BrandStorefrontModelCopyWith<$Res> implements $BrandStorefrontModelCopyWith<$Res> {
  factory _$BrandStorefrontModelCopyWith(_BrandStorefrontModel value, $Res Function(_BrandStorefrontModel) _then) = __$BrandStorefrontModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String brandName, String? brandLogoUrl, String? brandColor, String? coverImageUrl, String? tagline, bool isActive, bool isPremium, List<String> communityIds, List<StorefrontSection> sections, DateTime? createdAt, HeroStyle heroStyle, String? heroImageUrl, String? heroVideoUrl, String? accentColor, String? secondaryColor, LogoPlacement logoPlacement, StorefrontFontStyle fontStyle, StorefrontCornerStyle cornerStyle, StorefrontThemePreference themePreference, String? description, String? bannerImageUrl, String? bannerDeepLink, int? establishedYear, Map<String, String> socialLinks, List<TrustBadge> trustBadges, double? averageRating, int? ratingCount, List<QuickAction> quickActions, List<String> galleryImageUrls, List<StorefrontPromo> promotions, List<StorefrontSectionType> sectionOrder, bool isDraft, DateTime? publishedAt, String tier, double heroFocalPointX, double heroFocalPointY, bool showChatButton, String? bannerVideoUrl, String? announcementText, String? announcementDeepLink, bool announcementDismissible, List<ShowcaseVideo> showcaseVideos, List<StorefrontCoupon> coupons, List<FaqItem> faqItems, List<String> testimonialReviewIds, List<BrandLocation> locations, Map<String, String> richTextBlocks, Map<String, SectionSettings> sectionSettings, int totalViews
});




}
/// @nodoc
class __$BrandStorefrontModelCopyWithImpl<$Res>
    implements _$BrandStorefrontModelCopyWith<$Res> {
  __$BrandStorefrontModelCopyWithImpl(this._self, this._then);

  final _BrandStorefrontModel _self;
  final $Res Function(_BrandStorefrontModel) _then;

/// Create a copy of BrandStorefrontModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandLogoUrl = freezed,Object? brandColor = freezed,Object? coverImageUrl = freezed,Object? tagline = freezed,Object? isActive = null,Object? isPremium = null,Object? communityIds = null,Object? sections = null,Object? createdAt = freezed,Object? heroStyle = null,Object? heroImageUrl = freezed,Object? heroVideoUrl = freezed,Object? accentColor = freezed,Object? secondaryColor = freezed,Object? logoPlacement = null,Object? fontStyle = null,Object? cornerStyle = null,Object? themePreference = null,Object? description = freezed,Object? bannerImageUrl = freezed,Object? bannerDeepLink = freezed,Object? establishedYear = freezed,Object? socialLinks = null,Object? trustBadges = null,Object? averageRating = freezed,Object? ratingCount = freezed,Object? quickActions = null,Object? galleryImageUrls = null,Object? promotions = null,Object? sectionOrder = null,Object? isDraft = null,Object? publishedAt = freezed,Object? tier = null,Object? heroFocalPointX = null,Object? heroFocalPointY = null,Object? showChatButton = null,Object? bannerVideoUrl = freezed,Object? announcementText = freezed,Object? announcementDeepLink = freezed,Object? announcementDismissible = null,Object? showcaseVideos = null,Object? coupons = null,Object? faqItems = null,Object? testimonialReviewIds = null,Object? locations = null,Object? richTextBlocks = null,Object? sectionSettings = null,Object? totalViews = null,}) {
  return _then(_BrandStorefrontModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandLogoUrl: freezed == brandLogoUrl ? _self.brandLogoUrl : brandLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,brandColor: freezed == brandColor ? _self.brandColor : brandColor // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,communityIds: null == communityIds ? _self._communityIds : communityIds // ignore: cast_nullable_to_non_nullable
as List<String>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<StorefrontSection>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,heroStyle: null == heroStyle ? _self.heroStyle : heroStyle // ignore: cast_nullable_to_non_nullable
as HeroStyle,heroImageUrl: freezed == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String?,heroVideoUrl: freezed == heroVideoUrl ? _self.heroVideoUrl : heroVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,accentColor: freezed == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String?,secondaryColor: freezed == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String?,logoPlacement: null == logoPlacement ? _self.logoPlacement : logoPlacement // ignore: cast_nullable_to_non_nullable
as LogoPlacement,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as StorefrontFontStyle,cornerStyle: null == cornerStyle ? _self.cornerStyle : cornerStyle // ignore: cast_nullable_to_non_nullable
as StorefrontCornerStyle,themePreference: null == themePreference ? _self.themePreference : themePreference // ignore: cast_nullable_to_non_nullable
as StorefrontThemePreference,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bannerImageUrl: freezed == bannerImageUrl ? _self.bannerImageUrl : bannerImageUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerDeepLink: freezed == bannerDeepLink ? _self.bannerDeepLink : bannerDeepLink // ignore: cast_nullable_to_non_nullable
as String?,establishedYear: freezed == establishedYear ? _self.establishedYear : establishedYear // ignore: cast_nullable_to_non_nullable
as int?,socialLinks: null == socialLinks ? _self._socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustBadges: null == trustBadges ? _self._trustBadges : trustBadges // ignore: cast_nullable_to_non_nullable
as List<TrustBadge>,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,quickActions: null == quickActions ? _self._quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>,galleryImageUrls: null == galleryImageUrls ? _self._galleryImageUrls : galleryImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,promotions: null == promotions ? _self._promotions : promotions // ignore: cast_nullable_to_non_nullable
as List<StorefrontPromo>,sectionOrder: null == sectionOrder ? _self._sectionOrder : sectionOrder // ignore: cast_nullable_to_non_nullable
as List<StorefrontSectionType>,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String,heroFocalPointX: null == heroFocalPointX ? _self.heroFocalPointX : heroFocalPointX // ignore: cast_nullable_to_non_nullable
as double,heroFocalPointY: null == heroFocalPointY ? _self.heroFocalPointY : heroFocalPointY // ignore: cast_nullable_to_non_nullable
as double,showChatButton: null == showChatButton ? _self.showChatButton : showChatButton // ignore: cast_nullable_to_non_nullable
as bool,bannerVideoUrl: freezed == bannerVideoUrl ? _self.bannerVideoUrl : bannerVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,announcementText: freezed == announcementText ? _self.announcementText : announcementText // ignore: cast_nullable_to_non_nullable
as String?,announcementDeepLink: freezed == announcementDeepLink ? _self.announcementDeepLink : announcementDeepLink // ignore: cast_nullable_to_non_nullable
as String?,announcementDismissible: null == announcementDismissible ? _self.announcementDismissible : announcementDismissible // ignore: cast_nullable_to_non_nullable
as bool,showcaseVideos: null == showcaseVideos ? _self._showcaseVideos : showcaseVideos // ignore: cast_nullable_to_non_nullable
as List<ShowcaseVideo>,coupons: null == coupons ? _self._coupons : coupons // ignore: cast_nullable_to_non_nullable
as List<StorefrontCoupon>,faqItems: null == faqItems ? _self._faqItems : faqItems // ignore: cast_nullable_to_non_nullable
as List<FaqItem>,testimonialReviewIds: null == testimonialReviewIds ? _self._testimonialReviewIds : testimonialReviewIds // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<BrandLocation>,richTextBlocks: null == richTextBlocks ? _self._richTextBlocks : richTextBlocks // ignore: cast_nullable_to_non_nullable
as Map<String, String>,sectionSettings: null == sectionSettings ? _self._sectionSettings : sectionSettings // ignore: cast_nullable_to_non_nullable
as Map<String, SectionSettings>,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
