// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_storefront_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BrandStorefrontModel {
  String get id => throw _privateConstructorUsedError;
  String get brandId => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  String? get brandLogoUrl => throw _privateConstructorUsedError;
  String? get brandColor => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  String? get tagline => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  List<String> get communityIds => throw _privateConstructorUsedError;
  List<StorefrontSection> get sections => throw _privateConstructorUsedError;
  DateTime? get createdAt =>
      throw _privateConstructorUsedError; // ── Hero Section ──
  HeroStyle get heroStyle => throw _privateConstructorUsedError;
  String? get heroImageUrl => throw _privateConstructorUsedError;
  String? get heroVideoUrl => throw _privateConstructorUsedError;
  String? get accentColor => throw _privateConstructorUsedError;
  String? get secondaryColor => throw _privateConstructorUsedError;
  LogoPlacement get logoPlacement =>
      throw _privateConstructorUsedError; // ── Visual Identity ──
  StorefrontFontStyle get fontStyle => throw _privateConstructorUsedError;
  StorefrontCornerStyle get cornerStyle => throw _privateConstructorUsedError;
  StorefrontThemePreference get themePreference =>
      throw _privateConstructorUsedError; // ── Content ──
  String? get description => throw _privateConstructorUsedError;
  String? get bannerImageUrl => throw _privateConstructorUsedError;
  String? get bannerDeepLink => throw _privateConstructorUsedError;
  int? get establishedYear => throw _privateConstructorUsedError;
  Map<String, String> get socialLinks =>
      throw _privateConstructorUsedError; // ── Trust & Social Proof ──
  List<TrustBadge> get trustBadges => throw _privateConstructorUsedError;
  double? get averageRating => throw _privateConstructorUsedError;
  int? get ratingCount =>
      throw _privateConstructorUsedError; // ── Quick Actions ──
  List<QuickAction> get quickActions =>
      throw _privateConstructorUsedError; // ── Gallery ──
  List<String> get galleryImageUrls =>
      throw _privateConstructorUsedError; // ── Promotions ──
  List<StorefrontPromo> get promotions =>
      throw _privateConstructorUsedError; // ── Layout ──
  List<StorefrontSectionType> get sectionOrder =>
      throw _privateConstructorUsedError;

  /// Create a copy of BrandStorefrontModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandStorefrontModelCopyWith<BrandStorefrontModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandStorefrontModelCopyWith<$Res> {
  factory $BrandStorefrontModelCopyWith(
    BrandStorefrontModel value,
    $Res Function(BrandStorefrontModel) then,
  ) = _$BrandStorefrontModelCopyWithImpl<$Res, BrandStorefrontModel>;
  @useResult
  $Res call({
    String id,
    String brandId,
    String brandName,
    String? brandLogoUrl,
    String? brandColor,
    String? coverImageUrl,
    String? tagline,
    bool isActive,
    bool isPremium,
    List<String> communityIds,
    List<StorefrontSection> sections,
    DateTime? createdAt,
    HeroStyle heroStyle,
    String? heroImageUrl,
    String? heroVideoUrl,
    String? accentColor,
    String? secondaryColor,
    LogoPlacement logoPlacement,
    StorefrontFontStyle fontStyle,
    StorefrontCornerStyle cornerStyle,
    StorefrontThemePreference themePreference,
    String? description,
    String? bannerImageUrl,
    String? bannerDeepLink,
    int? establishedYear,
    Map<String, String> socialLinks,
    List<TrustBadge> trustBadges,
    double? averageRating,
    int? ratingCount,
    List<QuickAction> quickActions,
    List<String> galleryImageUrls,
    List<StorefrontPromo> promotions,
    List<StorefrontSectionType> sectionOrder,
  });
}

/// @nodoc
class _$BrandStorefrontModelCopyWithImpl<
  $Res,
  $Val extends BrandStorefrontModel
>
    implements $BrandStorefrontModelCopyWith<$Res> {
  _$BrandStorefrontModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandStorefrontModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? brandName = null,
    Object? brandLogoUrl = freezed,
    Object? brandColor = freezed,
    Object? coverImageUrl = freezed,
    Object? tagline = freezed,
    Object? isActive = null,
    Object? isPremium = null,
    Object? communityIds = null,
    Object? sections = null,
    Object? createdAt = freezed,
    Object? heroStyle = null,
    Object? heroImageUrl = freezed,
    Object? heroVideoUrl = freezed,
    Object? accentColor = freezed,
    Object? secondaryColor = freezed,
    Object? logoPlacement = null,
    Object? fontStyle = null,
    Object? cornerStyle = null,
    Object? themePreference = null,
    Object? description = freezed,
    Object? bannerImageUrl = freezed,
    Object? bannerDeepLink = freezed,
    Object? establishedYear = freezed,
    Object? socialLinks = null,
    Object? trustBadges = null,
    Object? averageRating = freezed,
    Object? ratingCount = freezed,
    Object? quickActions = null,
    Object? galleryImageUrls = null,
    Object? promotions = null,
    Object? sectionOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            brandId: null == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as String,
            brandName: null == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String,
            brandLogoUrl: freezed == brandLogoUrl
                ? _value.brandLogoUrl
                : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandColor: freezed == brandColor
                ? _value.brandColor
                : brandColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImageUrl: freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            tagline: freezed == tagline
                ? _value.tagline
                : tagline // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPremium: null == isPremium
                ? _value.isPremium
                : isPremium // ignore: cast_nullable_to_non_nullable
                      as bool,
            communityIds: null == communityIds
                ? _value.communityIds
                : communityIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            sections: null == sections
                ? _value.sections
                : sections // ignore: cast_nullable_to_non_nullable
                      as List<StorefrontSection>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            heroStyle: null == heroStyle
                ? _value.heroStyle
                : heroStyle // ignore: cast_nullable_to_non_nullable
                      as HeroStyle,
            heroImageUrl: freezed == heroImageUrl
                ? _value.heroImageUrl
                : heroImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            heroVideoUrl: freezed == heroVideoUrl
                ? _value.heroVideoUrl
                : heroVideoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            accentColor: freezed == accentColor
                ? _value.accentColor
                : accentColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            secondaryColor: freezed == secondaryColor
                ? _value.secondaryColor
                : secondaryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoPlacement: null == logoPlacement
                ? _value.logoPlacement
                : logoPlacement // ignore: cast_nullable_to_non_nullable
                      as LogoPlacement,
            fontStyle: null == fontStyle
                ? _value.fontStyle
                : fontStyle // ignore: cast_nullable_to_non_nullable
                      as StorefrontFontStyle,
            cornerStyle: null == cornerStyle
                ? _value.cornerStyle
                : cornerStyle // ignore: cast_nullable_to_non_nullable
                      as StorefrontCornerStyle,
            themePreference: null == themePreference
                ? _value.themePreference
                : themePreference // ignore: cast_nullable_to_non_nullable
                      as StorefrontThemePreference,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            bannerImageUrl: freezed == bannerImageUrl
                ? _value.bannerImageUrl
                : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bannerDeepLink: freezed == bannerDeepLink
                ? _value.bannerDeepLink
                : bannerDeepLink // ignore: cast_nullable_to_non_nullable
                      as String?,
            establishedYear: freezed == establishedYear
                ? _value.establishedYear
                : establishedYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            socialLinks: null == socialLinks
                ? _value.socialLinks
                : socialLinks // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            trustBadges: null == trustBadges
                ? _value.trustBadges
                : trustBadges // ignore: cast_nullable_to_non_nullable
                      as List<TrustBadge>,
            averageRating: freezed == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            ratingCount: freezed == ratingCount
                ? _value.ratingCount
                : ratingCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            quickActions: null == quickActions
                ? _value.quickActions
                : quickActions // ignore: cast_nullable_to_non_nullable
                      as List<QuickAction>,
            galleryImageUrls: null == galleryImageUrls
                ? _value.galleryImageUrls
                : galleryImageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            promotions: null == promotions
                ? _value.promotions
                : promotions // ignore: cast_nullable_to_non_nullable
                      as List<StorefrontPromo>,
            sectionOrder: null == sectionOrder
                ? _value.sectionOrder
                : sectionOrder // ignore: cast_nullable_to_non_nullable
                      as List<StorefrontSectionType>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrandStorefrontModelImplCopyWith<$Res>
    implements $BrandStorefrontModelCopyWith<$Res> {
  factory _$$BrandStorefrontModelImplCopyWith(
    _$BrandStorefrontModelImpl value,
    $Res Function(_$BrandStorefrontModelImpl) then,
  ) = __$$BrandStorefrontModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String brandId,
    String brandName,
    String? brandLogoUrl,
    String? brandColor,
    String? coverImageUrl,
    String? tagline,
    bool isActive,
    bool isPremium,
    List<String> communityIds,
    List<StorefrontSection> sections,
    DateTime? createdAt,
    HeroStyle heroStyle,
    String? heroImageUrl,
    String? heroVideoUrl,
    String? accentColor,
    String? secondaryColor,
    LogoPlacement logoPlacement,
    StorefrontFontStyle fontStyle,
    StorefrontCornerStyle cornerStyle,
    StorefrontThemePreference themePreference,
    String? description,
    String? bannerImageUrl,
    String? bannerDeepLink,
    int? establishedYear,
    Map<String, String> socialLinks,
    List<TrustBadge> trustBadges,
    double? averageRating,
    int? ratingCount,
    List<QuickAction> quickActions,
    List<String> galleryImageUrls,
    List<StorefrontPromo> promotions,
    List<StorefrontSectionType> sectionOrder,
  });
}

/// @nodoc
class __$$BrandStorefrontModelImplCopyWithImpl<$Res>
    extends _$BrandStorefrontModelCopyWithImpl<$Res, _$BrandStorefrontModelImpl>
    implements _$$BrandStorefrontModelImplCopyWith<$Res> {
  __$$BrandStorefrontModelImplCopyWithImpl(
    _$BrandStorefrontModelImpl _value,
    $Res Function(_$BrandStorefrontModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? brandName = null,
    Object? brandLogoUrl = freezed,
    Object? brandColor = freezed,
    Object? coverImageUrl = freezed,
    Object? tagline = freezed,
    Object? isActive = null,
    Object? isPremium = null,
    Object? communityIds = null,
    Object? sections = null,
    Object? createdAt = freezed,
    Object? heroStyle = null,
    Object? heroImageUrl = freezed,
    Object? heroVideoUrl = freezed,
    Object? accentColor = freezed,
    Object? secondaryColor = freezed,
    Object? logoPlacement = null,
    Object? fontStyle = null,
    Object? cornerStyle = null,
    Object? themePreference = null,
    Object? description = freezed,
    Object? bannerImageUrl = freezed,
    Object? bannerDeepLink = freezed,
    Object? establishedYear = freezed,
    Object? socialLinks = null,
    Object? trustBadges = null,
    Object? averageRating = freezed,
    Object? ratingCount = freezed,
    Object? quickActions = null,
    Object? galleryImageUrls = null,
    Object? promotions = null,
    Object? sectionOrder = null,
  }) {
    return _then(
      _$BrandStorefrontModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        brandId: null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
        brandName: null == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String,
        brandLogoUrl: freezed == brandLogoUrl
            ? _value.brandLogoUrl
            : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandColor: freezed == brandColor
            ? _value.brandColor
            : brandColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImageUrl: freezed == coverImageUrl
            ? _value.coverImageUrl
            : coverImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        tagline: freezed == tagline
            ? _value.tagline
            : tagline // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPremium: null == isPremium
            ? _value.isPremium
            : isPremium // ignore: cast_nullable_to_non_nullable
                  as bool,
        communityIds: null == communityIds
            ? _value._communityIds
            : communityIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        sections: null == sections
            ? _value._sections
            : sections // ignore: cast_nullable_to_non_nullable
                  as List<StorefrontSection>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        heroStyle: null == heroStyle
            ? _value.heroStyle
            : heroStyle // ignore: cast_nullable_to_non_nullable
                  as HeroStyle,
        heroImageUrl: freezed == heroImageUrl
            ? _value.heroImageUrl
            : heroImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        heroVideoUrl: freezed == heroVideoUrl
            ? _value.heroVideoUrl
            : heroVideoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        accentColor: freezed == accentColor
            ? _value.accentColor
            : accentColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        secondaryColor: freezed == secondaryColor
            ? _value.secondaryColor
            : secondaryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoPlacement: null == logoPlacement
            ? _value.logoPlacement
            : logoPlacement // ignore: cast_nullable_to_non_nullable
                  as LogoPlacement,
        fontStyle: null == fontStyle
            ? _value.fontStyle
            : fontStyle // ignore: cast_nullable_to_non_nullable
                  as StorefrontFontStyle,
        cornerStyle: null == cornerStyle
            ? _value.cornerStyle
            : cornerStyle // ignore: cast_nullable_to_non_nullable
                  as StorefrontCornerStyle,
        themePreference: null == themePreference
            ? _value.themePreference
            : themePreference // ignore: cast_nullable_to_non_nullable
                  as StorefrontThemePreference,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        bannerImageUrl: freezed == bannerImageUrl
            ? _value.bannerImageUrl
            : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bannerDeepLink: freezed == bannerDeepLink
            ? _value.bannerDeepLink
            : bannerDeepLink // ignore: cast_nullable_to_non_nullable
                  as String?,
        establishedYear: freezed == establishedYear
            ? _value.establishedYear
            : establishedYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        socialLinks: null == socialLinks
            ? _value._socialLinks
            : socialLinks // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        trustBadges: null == trustBadges
            ? _value._trustBadges
            : trustBadges // ignore: cast_nullable_to_non_nullable
                  as List<TrustBadge>,
        averageRating: freezed == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        ratingCount: freezed == ratingCount
            ? _value.ratingCount
            : ratingCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        quickActions: null == quickActions
            ? _value._quickActions
            : quickActions // ignore: cast_nullable_to_non_nullable
                  as List<QuickAction>,
        galleryImageUrls: null == galleryImageUrls
            ? _value._galleryImageUrls
            : galleryImageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        promotions: null == promotions
            ? _value._promotions
            : promotions // ignore: cast_nullable_to_non_nullable
                  as List<StorefrontPromo>,
        sectionOrder: null == sectionOrder
            ? _value._sectionOrder
            : sectionOrder // ignore: cast_nullable_to_non_nullable
                  as List<StorefrontSectionType>,
      ),
    );
  }
}

/// @nodoc

class _$BrandStorefrontModelImpl extends _BrandStorefrontModel {
  const _$BrandStorefrontModelImpl({
    required this.id,
    required this.brandId,
    required this.brandName,
    this.brandLogoUrl,
    this.brandColor,
    this.coverImageUrl,
    this.tagline,
    this.isActive = true,
    this.isPremium = false,
    final List<String> communityIds = const [],
    final List<StorefrontSection> sections = const [],
    this.createdAt,
    this.heroStyle = HeroStyle.gradient,
    this.heroImageUrl,
    this.heroVideoUrl,
    this.accentColor,
    this.secondaryColor,
    this.logoPlacement = LogoPlacement.centered,
    this.fontStyle = StorefrontFontStyle.modern,
    this.cornerStyle = StorefrontCornerStyle.rounded,
    this.themePreference = StorefrontThemePreference.auto,
    this.description,
    this.bannerImageUrl,
    this.bannerDeepLink,
    this.establishedYear,
    final Map<String, String> socialLinks = const {},
    final List<TrustBadge> trustBadges = const [],
    this.averageRating,
    this.ratingCount,
    final List<QuickAction> quickActions = const [],
    final List<String> galleryImageUrls = const [],
    final List<StorefrontPromo> promotions = const [],
    final List<StorefrontSectionType> sectionOrder = const [],
  }) : _communityIds = communityIds,
       _sections = sections,
       _socialLinks = socialLinks,
       _trustBadges = trustBadges,
       _quickActions = quickActions,
       _galleryImageUrls = galleryImageUrls,
       _promotions = promotions,
       _sectionOrder = sectionOrder,
       super._();

  @override
  final String id;
  @override
  final String brandId;
  @override
  final String brandName;
  @override
  final String? brandLogoUrl;
  @override
  final String? brandColor;
  @override
  final String? coverImageUrl;
  @override
  final String? tagline;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isPremium;
  final List<String> _communityIds;
  @override
  @JsonKey()
  List<String> get communityIds {
    if (_communityIds is EqualUnmodifiableListView) return _communityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_communityIds);
  }

  final List<StorefrontSection> _sections;
  @override
  @JsonKey()
  List<StorefrontSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  final DateTime? createdAt;
  // ── Hero Section ──
  @override
  @JsonKey()
  final HeroStyle heroStyle;
  @override
  final String? heroImageUrl;
  @override
  final String? heroVideoUrl;
  @override
  final String? accentColor;
  @override
  final String? secondaryColor;
  @override
  @JsonKey()
  final LogoPlacement logoPlacement;
  // ── Visual Identity ──
  @override
  @JsonKey()
  final StorefrontFontStyle fontStyle;
  @override
  @JsonKey()
  final StorefrontCornerStyle cornerStyle;
  @override
  @JsonKey()
  final StorefrontThemePreference themePreference;
  // ── Content ──
  @override
  final String? description;
  @override
  final String? bannerImageUrl;
  @override
  final String? bannerDeepLink;
  @override
  final int? establishedYear;
  final Map<String, String> _socialLinks;
  @override
  @JsonKey()
  Map<String, String> get socialLinks {
    if (_socialLinks is EqualUnmodifiableMapView) return _socialLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_socialLinks);
  }

  // ── Trust & Social Proof ──
  final List<TrustBadge> _trustBadges;
  // ── Trust & Social Proof ──
  @override
  @JsonKey()
  List<TrustBadge> get trustBadges {
    if (_trustBadges is EqualUnmodifiableListView) return _trustBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trustBadges);
  }

  @override
  final double? averageRating;
  @override
  final int? ratingCount;
  // ── Quick Actions ──
  final List<QuickAction> _quickActions;
  // ── Quick Actions ──
  @override
  @JsonKey()
  List<QuickAction> get quickActions {
    if (_quickActions is EqualUnmodifiableListView) return _quickActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickActions);
  }

  // ── Gallery ──
  final List<String> _galleryImageUrls;
  // ── Gallery ──
  @override
  @JsonKey()
  List<String> get galleryImageUrls {
    if (_galleryImageUrls is EqualUnmodifiableListView)
      return _galleryImageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryImageUrls);
  }

  // ── Promotions ──
  final List<StorefrontPromo> _promotions;
  // ── Promotions ──
  @override
  @JsonKey()
  List<StorefrontPromo> get promotions {
    if (_promotions is EqualUnmodifiableListView) return _promotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_promotions);
  }

  // ── Layout ──
  final List<StorefrontSectionType> _sectionOrder;
  // ── Layout ──
  @override
  @JsonKey()
  List<StorefrontSectionType> get sectionOrder {
    if (_sectionOrder is EqualUnmodifiableListView) return _sectionOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sectionOrder);
  }

  @override
  String toString() {
    return 'BrandStorefrontModel(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandStorefrontModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandLogoUrl, brandLogoUrl) ||
                other.brandLogoUrl == brandLogoUrl) &&
            (identical(other.brandColor, brandColor) ||
                other.brandColor == brandColor) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            const DeepCollectionEquality().equals(
              other._communityIds,
              _communityIds,
            ) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.heroStyle, heroStyle) ||
                other.heroStyle == heroStyle) &&
            (identical(other.heroImageUrl, heroImageUrl) ||
                other.heroImageUrl == heroImageUrl) &&
            (identical(other.heroVideoUrl, heroVideoUrl) ||
                other.heroVideoUrl == heroVideoUrl) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.logoPlacement, logoPlacement) ||
                other.logoPlacement == logoPlacement) &&
            (identical(other.fontStyle, fontStyle) ||
                other.fontStyle == fontStyle) &&
            (identical(other.cornerStyle, cornerStyle) ||
                other.cornerStyle == cornerStyle) &&
            (identical(other.themePreference, themePreference) ||
                other.themePreference == themePreference) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.bannerImageUrl, bannerImageUrl) ||
                other.bannerImageUrl == bannerImageUrl) &&
            (identical(other.bannerDeepLink, bannerDeepLink) ||
                other.bannerDeepLink == bannerDeepLink) &&
            (identical(other.establishedYear, establishedYear) ||
                other.establishedYear == establishedYear) &&
            const DeepCollectionEquality().equals(
              other._socialLinks,
              _socialLinks,
            ) &&
            const DeepCollectionEquality().equals(
              other._trustBadges,
              _trustBadges,
            ) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.ratingCount, ratingCount) ||
                other.ratingCount == ratingCount) &&
            const DeepCollectionEquality().equals(
              other._quickActions,
              _quickActions,
            ) &&
            const DeepCollectionEquality().equals(
              other._galleryImageUrls,
              _galleryImageUrls,
            ) &&
            const DeepCollectionEquality().equals(
              other._promotions,
              _promotions,
            ) &&
            const DeepCollectionEquality().equals(
              other._sectionOrder,
              _sectionOrder,
            ));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    brandId,
    brandName,
    brandLogoUrl,
    brandColor,
    coverImageUrl,
    tagline,
    isActive,
    isPremium,
    const DeepCollectionEquality().hash(_communityIds),
    const DeepCollectionEquality().hash(_sections),
    createdAt,
    heroStyle,
    heroImageUrl,
    heroVideoUrl,
    accentColor,
    secondaryColor,
    logoPlacement,
    fontStyle,
    cornerStyle,
    themePreference,
    description,
    bannerImageUrl,
    bannerDeepLink,
    establishedYear,
    const DeepCollectionEquality().hash(_socialLinks),
    const DeepCollectionEquality().hash(_trustBadges),
    averageRating,
    ratingCount,
    const DeepCollectionEquality().hash(_quickActions),
    const DeepCollectionEquality().hash(_galleryImageUrls),
    const DeepCollectionEquality().hash(_promotions),
    const DeepCollectionEquality().hash(_sectionOrder),
  ]);

  /// Create a copy of BrandStorefrontModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandStorefrontModelImplCopyWith<_$BrandStorefrontModelImpl>
  get copyWith =>
      __$$BrandStorefrontModelImplCopyWithImpl<_$BrandStorefrontModelImpl>(
        this,
        _$identity,
      );
}

abstract class _BrandStorefrontModel extends BrandStorefrontModel {
  const factory _BrandStorefrontModel({
    required final String id,
    required final String brandId,
    required final String brandName,
    final String? brandLogoUrl,
    final String? brandColor,
    final String? coverImageUrl,
    final String? tagline,
    final bool isActive,
    final bool isPremium,
    final List<String> communityIds,
    final List<StorefrontSection> sections,
    final DateTime? createdAt,
    final HeroStyle heroStyle,
    final String? heroImageUrl,
    final String? heroVideoUrl,
    final String? accentColor,
    final String? secondaryColor,
    final LogoPlacement logoPlacement,
    final StorefrontFontStyle fontStyle,
    final StorefrontCornerStyle cornerStyle,
    final StorefrontThemePreference themePreference,
    final String? description,
    final String? bannerImageUrl,
    final String? bannerDeepLink,
    final int? establishedYear,
    final Map<String, String> socialLinks,
    final List<TrustBadge> trustBadges,
    final double? averageRating,
    final int? ratingCount,
    final List<QuickAction> quickActions,
    final List<String> galleryImageUrls,
    final List<StorefrontPromo> promotions,
    final List<StorefrontSectionType> sectionOrder,
  }) = _$BrandStorefrontModelImpl;
  const _BrandStorefrontModel._() : super._();

  @override
  String get id;
  @override
  String get brandId;
  @override
  String get brandName;
  @override
  String? get brandLogoUrl;
  @override
  String? get brandColor;
  @override
  String? get coverImageUrl;
  @override
  String? get tagline;
  @override
  bool get isActive;
  @override
  bool get isPremium;
  @override
  List<String> get communityIds;
  @override
  List<StorefrontSection> get sections;
  @override
  DateTime? get createdAt; // ── Hero Section ──
  @override
  HeroStyle get heroStyle;
  @override
  String? get heroImageUrl;
  @override
  String? get heroVideoUrl;
  @override
  String? get accentColor;
  @override
  String? get secondaryColor;
  @override
  LogoPlacement get logoPlacement; // ── Visual Identity ──
  @override
  StorefrontFontStyle get fontStyle;
  @override
  StorefrontCornerStyle get cornerStyle;
  @override
  StorefrontThemePreference get themePreference; // ── Content ──
  @override
  String? get description;
  @override
  String? get bannerImageUrl;
  @override
  String? get bannerDeepLink;
  @override
  int? get establishedYear;
  @override
  Map<String, String> get socialLinks; // ── Trust & Social Proof ──
  @override
  List<TrustBadge> get trustBadges;
  @override
  double? get averageRating;
  @override
  int? get ratingCount; // ── Quick Actions ──
  @override
  List<QuickAction> get quickActions; // ── Gallery ──
  @override
  List<String> get galleryImageUrls; // ── Promotions ──
  @override
  List<StorefrontPromo> get promotions; // ── Layout ──
  @override
  List<StorefrontSectionType> get sectionOrder;

  /// Create a copy of BrandStorefrontModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandStorefrontModelImplCopyWith<_$BrandStorefrontModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
