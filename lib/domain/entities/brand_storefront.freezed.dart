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

StorefrontSection _$StorefrontSectionFromJson(Map<String, dynamic> json) {
  return _StorefrontSection.fromJson(json);
}

/// @nodoc
mixin _$StorefrontSection {
  /// Section type: hero, quick_actions, product_grid, about
  String get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  /// Type-specific configuration data
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

  /// Section type: hero, quick_actions, product_grid, about
  @override
  final String type;
  @override
  final String? title;

  /// Type-specific configuration data
  final Map<String, dynamic> _data;

  /// Type-specific configuration data
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

  /// Section type: hero, quick_actions, product_grid, about
  @override
  String get type;
  @override
  String? get title;

  /// Type-specific configuration data
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
  List<StorefrontSection> get sections => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

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
  }) : _communityIds = communityIds,
       _sections = sections,
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

  @override
  String toString() {
    return 'BrandStorefront(id: $id, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, brandColor: $brandColor, coverImageUrl: $coverImageUrl, tagline: $tagline, isActive: $isActive, isPremium: $isPremium, communityIds: $communityIds, sections: $sections, createdAt: $createdAt)';
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
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
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
  );

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
  @override
  List<StorefrontSection> get sections;
  @override
  DateTime? get createdAt;

  /// Create a copy of BrandStorefront
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandStorefrontImplCopyWith<_$BrandStorefrontImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
