// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_storefront.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuickAction _$QuickActionFromJson(Map<String, dynamic> json) {
  return _QuickAction.fromJson(json);
}

/// @nodoc
mixin _$QuickAction {
  String get label => throw _privateConstructorUsedError;
  String get iconEmoji => throw _privateConstructorUsedError;
  String get deepLink => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this QuickAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickActionCopyWith<QuickAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickActionCopyWith<$Res> {
  factory $QuickActionCopyWith(
    QuickAction value,
    $Res Function(QuickAction) then,
  ) = _$QuickActionCopyWithImpl<$Res, QuickAction>;
  @useResult
  $Res call({String label, String iconEmoji, String deepLink, int sortOrder});
}

/// @nodoc
class _$QuickActionCopyWithImpl<$Res, $Val extends QuickAction>
    implements $QuickActionCopyWith<$Res> {
  _$QuickActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? iconEmoji = null,
    Object? deepLink = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            iconEmoji: null == iconEmoji
                ? _value.iconEmoji
                : iconEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
            deepLink: null == deepLink
                ? _value.deepLink
                : deepLink // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuickActionImplCopyWith<$Res>
    implements $QuickActionCopyWith<$Res> {
  factory _$$QuickActionImplCopyWith(
    _$QuickActionImpl value,
    $Res Function(_$QuickActionImpl) then,
  ) = __$$QuickActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String iconEmoji, String deepLink, int sortOrder});
}

/// @nodoc
class __$$QuickActionImplCopyWithImpl<$Res>
    extends _$QuickActionCopyWithImpl<$Res, _$QuickActionImpl>
    implements _$$QuickActionImplCopyWith<$Res> {
  __$$QuickActionImplCopyWithImpl(
    _$QuickActionImpl _value,
    $Res Function(_$QuickActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuickAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? iconEmoji = null,
    Object? deepLink = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$QuickActionImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        iconEmoji: null == iconEmoji
            ? _value.iconEmoji
            : iconEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
        deepLink: null == deepLink
            ? _value.deepLink
            : deepLink // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickActionImpl implements _QuickAction {
  const _$QuickActionImpl({
    required this.label,
    required this.iconEmoji,
    required this.deepLink,
    this.sortOrder = 0,
  });

  factory _$QuickActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickActionImplFromJson(json);

  @override
  final String label;
  @override
  final String iconEmoji;
  @override
  final String deepLink;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'QuickAction(label: $label, iconEmoji: $iconEmoji, deepLink: $deepLink, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickActionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.deepLink, deepLink) ||
                other.deepLink == deepLink) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, label, iconEmoji, deepLink, sortOrder);

  /// Create a copy of QuickAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickActionImplCopyWith<_$QuickActionImpl> get copyWith =>
      __$$QuickActionImplCopyWithImpl<_$QuickActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickActionImplToJson(this);
  }
}

abstract class _QuickAction implements QuickAction {
  const factory _QuickAction({
    required final String label,
    required final String iconEmoji,
    required final String deepLink,
    final int sortOrder,
  }) = _$QuickActionImpl;

  factory _QuickAction.fromJson(Map<String, dynamic> json) =
      _$QuickActionImpl.fromJson;

  @override
  String get label;
  @override
  String get iconEmoji;
  @override
  String get deepLink;
  @override
  int get sortOrder;

  /// Create a copy of QuickAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickActionImplCopyWith<_$QuickActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StorefrontPromo _$StorefrontPromoFromJson(Map<String, dynamic> json) {
  return _StorefrontPromo.fromJson(json);
}

/// @nodoc
mixin _$StorefrontPromo {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get deepLink => throw _privateConstructorUsedError;

  /// Serializes this StorefrontPromo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorefrontPromo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorefrontPromoCopyWith<StorefrontPromo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorefrontPromoCopyWith<$Res> {
  factory $StorefrontPromoCopyWith(
    StorefrontPromo value,
    $Res Function(StorefrontPromo) then,
  ) = _$StorefrontPromoCopyWithImpl<$Res, StorefrontPromo>;
  @useResult
  $Res call({
    String title,
    String? description,
    DateTime? expiresAt,
    String? deepLink,
  });
}

/// @nodoc
class _$StorefrontPromoCopyWithImpl<$Res, $Val extends StorefrontPromo>
    implements $StorefrontPromoCopyWith<$Res> {
  _$StorefrontPromoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorefrontPromo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? expiresAt = freezed,
    Object? deepLink = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            deepLink: freezed == deepLink
                ? _value.deepLink
                : deepLink // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StorefrontPromoImplCopyWith<$Res>
    implements $StorefrontPromoCopyWith<$Res> {
  factory _$$StorefrontPromoImplCopyWith(
    _$StorefrontPromoImpl value,
    $Res Function(_$StorefrontPromoImpl) then,
  ) = __$$StorefrontPromoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String? description,
    DateTime? expiresAt,
    String? deepLink,
  });
}

/// @nodoc
class __$$StorefrontPromoImplCopyWithImpl<$Res>
    extends _$StorefrontPromoCopyWithImpl<$Res, _$StorefrontPromoImpl>
    implements _$$StorefrontPromoImplCopyWith<$Res> {
  __$$StorefrontPromoImplCopyWithImpl(
    _$StorefrontPromoImpl _value,
    $Res Function(_$StorefrontPromoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StorefrontPromo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? expiresAt = freezed,
    Object? deepLink = freezed,
  }) {
    return _then(
      _$StorefrontPromoImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        deepLink: freezed == deepLink
            ? _value.deepLink
            : deepLink // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StorefrontPromoImpl implements _StorefrontPromo {
  const _$StorefrontPromoImpl({
    required this.title,
    this.description,
    this.expiresAt,
    this.deepLink,
  });

  factory _$StorefrontPromoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorefrontPromoImplFromJson(json);

  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime? expiresAt;
  @override
  final String? deepLink;

  @override
  String toString() {
    return 'StorefrontPromo(title: $title, description: $description, expiresAt: $expiresAt, deepLink: $deepLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorefrontPromoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.deepLink, deepLink) ||
                other.deepLink == deepLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, description, expiresAt, deepLink);

  /// Create a copy of StorefrontPromo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorefrontPromoImplCopyWith<_$StorefrontPromoImpl> get copyWith =>
      __$$StorefrontPromoImplCopyWithImpl<_$StorefrontPromoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StorefrontPromoImplToJson(this);
  }
}

abstract class _StorefrontPromo implements StorefrontPromo {
  const factory _StorefrontPromo({
    required final String title,
    final String? description,
    final DateTime? expiresAt,
    final String? deepLink,
  }) = _$StorefrontPromoImpl;

  factory _StorefrontPromo.fromJson(Map<String, dynamic> json) =
      _$StorefrontPromoImpl.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime? get expiresAt;
  @override
  String? get deepLink;

  /// Create a copy of StorefrontPromo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorefrontPromoImplCopyWith<_$StorefrontPromoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StorefrontSection _$StorefrontSectionFromJson(Map<String, dynamic> json) {
  return _StorefrontSection.fromJson(json);
}

/// @nodoc
mixin _$StorefrontSection {
  String get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;

  /// Serializes this StorefrontSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorefrontSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorefrontSectionCopyWith<StorefrontSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorefrontSectionCopyWith<$Res> {
  factory $StorefrontSectionCopyWith(
    StorefrontSection value,
    $Res Function(StorefrontSection) then,
  ) = _$StorefrontSectionCopyWithImpl<$Res, StorefrontSection>;
  @useResult
  $Res call({
    String type,
    String? title,
    Map<String, dynamic> data,
    int sortOrder,
    bool isVisible,
  });
}

/// @nodoc
class _$StorefrontSectionCopyWithImpl<$Res, $Val extends StorefrontSection>
    implements $StorefrontSectionCopyWith<$Res> {
  _$StorefrontSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorefrontSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = freezed,
    Object? data = null,
    Object? sortOrder = null,
    Object? isVisible = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isVisible: null == isVisible
                ? _value.isVisible
                : isVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StorefrontSectionImplCopyWith<$Res>
    implements $StorefrontSectionCopyWith<$Res> {
  factory _$$StorefrontSectionImplCopyWith(
    _$StorefrontSectionImpl value,
    $Res Function(_$StorefrontSectionImpl) then,
  ) = __$$StorefrontSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String? title,
    Map<String, dynamic> data,
    int sortOrder,
    bool isVisible,
  });
}

/// @nodoc
class __$$StorefrontSectionImplCopyWithImpl<$Res>
    extends _$StorefrontSectionCopyWithImpl<$Res, _$StorefrontSectionImpl>
    implements _$$StorefrontSectionImplCopyWith<$Res> {
  __$$StorefrontSectionImplCopyWithImpl(
    _$StorefrontSectionImpl _value,
    $Res Function(_$StorefrontSectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StorefrontSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = freezed,
    Object? data = null,
    Object? sortOrder = null,
    Object? isVisible = null,
  }) {
    return _then(
      _$StorefrontSectionImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isVisible: null == isVisible
            ? _value.isVisible
            : isVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StorefrontSectionImpl implements _StorefrontSection {
  const _$StorefrontSectionImpl({
    required this.type,
    this.title,
    final Map<String, dynamic> data = const {},
    this.sortOrder = 0,
    this.isVisible = true,
  }) : _data = data;

  factory _$StorefrontSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorefrontSectionImplFromJson(json);

  @override
  final String type;
  @override
  final String? title;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final bool isVisible;

  @override
  String toString() {
    return 'StorefrontSection(type: $type, title: $title, data: $data, sortOrder: $sortOrder, isVisible: $isVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorefrontSectionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    title,
    const DeepCollectionEquality().hash(_data),
    sortOrder,
    isVisible,
  );

  /// Create a copy of StorefrontSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorefrontSectionImplCopyWith<_$StorefrontSectionImpl> get copyWith =>
      __$$StorefrontSectionImplCopyWithImpl<_$StorefrontSectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StorefrontSectionImplToJson(this);
  }
}

abstract class _StorefrontSection implements StorefrontSection {
  const factory _StorefrontSection({
    required final String type,
    final String? title,
    final Map<String, dynamic> data,
    final int sortOrder,
    final bool isVisible,
  }) = _$StorefrontSectionImpl;

  factory _StorefrontSection.fromJson(Map<String, dynamic> json) =
      _$StorefrontSectionImpl.fromJson;

  @override
  String get type;
  @override
  String? get title;
  @override
  Map<String, dynamic> get data;
  @override
  int get sortOrder;
  @override
  bool get isVisible;

  /// Create a copy of StorefrontSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorefrontSectionImplCopyWith<_$StorefrontSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BrandStorefront _$BrandStorefrontFromJson(Map<String, dynamic> json) {
  return _BrandStorefront.fromJson(json);
}

/// @nodoc
mixin _$BrandStorefront {
  String get id => throw _privateConstructorUsedError;
  String get brandId => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  String? get brandLogoUrl => throw _privateConstructorUsedError;

  /// Hex color for brand tinting (e.g. "#E60000" for Vodacom red)
  String? get brandColor => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  String? get tagline => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;

  /// Community IDs this storefront targets (empty = global)
  List<String> get communityIds => throw _privateConstructorUsedError;

  /// Legacy sections (old format — read for migration)
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

  /// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
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
  /// Ordered list of section types to display. Sections not in list are hidden.
  List<StorefrontSectionType> get sectionOrder =>
      throw _privateConstructorUsedError;

  /// Serializes this BrandStorefront to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrandStorefront
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandStorefrontCopyWith<BrandStorefront> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandStorefrontCopyWith<$Res> {
  factory $BrandStorefrontCopyWith(
    BrandStorefront value,
    $Res Function(BrandStorefront) then,
  ) = _$BrandStorefrontCopyWithImpl<$Res, BrandStorefront>;
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
class _$BrandStorefrontCopyWithImpl<$Res, $Val extends BrandStorefront>
    implements $BrandStorefrontCopyWith<$Res> {
  _$BrandStorefrontCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandStorefront
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
abstract class _$$BrandStorefrontImplCopyWith<$Res>
    implements $BrandStorefrontCopyWith<$Res> {
  factory _$$BrandStorefrontImplCopyWith(
    _$BrandStorefrontImpl value,
    $Res Function(_$BrandStorefrontImpl) then,
  ) = __$$BrandStorefrontImplCopyWithImpl<$Res>;
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
class __$$BrandStorefrontImplCopyWithImpl<$Res>
    extends _$BrandStorefrontCopyWithImpl<$Res, _$BrandStorefrontImpl>
    implements _$$BrandStorefrontImplCopyWith<$Res> {
  __$$BrandStorefrontImplCopyWithImpl(
    _$BrandStorefrontImpl _value,
    $Res Function(_$BrandStorefrontImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefront
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
      _$BrandStorefrontImpl(
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
@JsonSerializable()
class _$BrandStorefrontImpl extends _BrandStorefront {
  const _$BrandStorefrontImpl({
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

  factory _$BrandStorefrontImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrandStorefrontImplFromJson(json);

  @override
  final String id;
  @override
  final String brandId;
  @override
  final String brandName;
  @override
  final String? brandLogoUrl;

  /// Hex color for brand tinting (e.g. "#E60000" for Vodacom red)
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

  /// Community IDs this storefront targets (empty = global)
  final List<String> _communityIds;

  /// Community IDs this storefront targets (empty = global)
  @override
  @JsonKey()
  List<String> get communityIds {
    if (_communityIds is EqualUnmodifiableListView) return _communityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_communityIds);
  }

  /// Legacy sections (old format — read for migration)
  final List<StorefrontSection> _sections;

  /// Legacy sections (old format — read for migration)
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

  /// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
  final Map<String, String> _socialLinks;

  /// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
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
  /// Ordered list of section types to display. Sections not in list are hidden.
  final List<StorefrontSectionType> _sectionOrder;
  // ── Layout ──
  /// Ordered list of section types to display. Sections not in list are hidden.
  @override
  @JsonKey()
  List<StorefrontSectionType> get sectionOrder {
    if (_sectionOrder is EqualUnmodifiableListView) return _sectionOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sectionOrder);
  }

  @override
  String toString() {
    return 'BrandStorefront(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt, heroStyle: $heroStyle, heroImageUrl: $heroImageUrl, heroVideoUrl: $heroVideoUrl, accentColor: $accentColor, secondaryColor: $secondaryColor, logoPlacement: $logoPlacement, fontStyle: $fontStyle, cornerStyle: $cornerStyle, themePreference: $themePreference, description: $description, bannerImageUrl: $bannerImageUrl, bannerDeepLink: $bannerDeepLink, establishedYear: $establishedYear, socialLinks: $socialLinks, trustBadges: $trustBadges, averageRating: $averageRating, ratingCount: $ratingCount, quickActions: $quickActions, galleryImageUrls: $galleryImageUrls, promotions: $promotions, sectionOrder: $sectionOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandStorefrontImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of BrandStorefront
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandStorefrontImplCopyWith<_$BrandStorefrontImpl> get copyWith =>
      __$$BrandStorefrontImplCopyWithImpl<_$BrandStorefrontImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BrandStorefrontImplToJson(this);
  }
}

abstract class _BrandStorefront extends BrandStorefront {
  const factory _BrandStorefront({
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
  }) = _$BrandStorefrontImpl;
  const _BrandStorefront._() : super._();

  factory _BrandStorefront.fromJson(Map<String, dynamic> json) =
      _$BrandStorefrontImpl.fromJson;

  @override
  String get id;
  @override
  String get brandId;
  @override
  String get brandName;
  @override
  String? get brandLogoUrl;

  /// Hex color for brand tinting (e.g. "#E60000" for Vodacom red)
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

  /// Community IDs this storefront targets (empty = global)
  @override
  List<String> get communityIds;

  /// Legacy sections (old format — read for migration)
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

  /// 7 platforms: whatsapp, instagram, facebook, website, tiktok, x, youtube
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
  /// Ordered list of section types to display. Sections not in list are hidden.
  @override
  List<StorefrontSectionType> get sectionOrder;

  /// Create a copy of BrandStorefront
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandStorefrontImplCopyWith<_$BrandStorefrontImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
