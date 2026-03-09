// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FeaturedItem _$FeaturedItemFromJson(Map<String, dynamic> json) {
  return _FeaturedItem.fromJson(json);
}

/// @nodoc
mixin _$FeaturedItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Type: campaign, collectible, trending, promotion
  String get type => throw _privateConstructorUsedError;

  /// GoRouter deep link path (e.g. /buy/category/airtime)
  String? get deepLinkRoute => throw _privateConstructorUsedError;
  String? get brandId => throw _privateConstructorUsedError;

  /// Community IDs this item targets (empty = global)
  List<String> get communityIds => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime? get scheduledStart => throw _privateConstructorUsedError;
  DateTime? get scheduledEnd => throw _privateConstructorUsedError;

  /// BrandGradient type name (e.g. goldOrange, cyanBlue)
  String get bgGradientType => throw _privateConstructorUsedError;

  /// Serializes this FeaturedItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedItemCopyWith<FeaturedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedItemCopyWith<$Res> {
  factory $FeaturedItemCopyWith(
    FeaturedItem value,
    $Res Function(FeaturedItem) then,
  ) = _$FeaturedItemCopyWithImpl<$Res, FeaturedItem>;
  @useResult
  $Res call({
    String id,
    String title,
    String? subtitle,
    String? imageUrl,
    String type,
    String? deepLinkRoute,
    String? brandId,
    List<String> communityIds,
    bool isActive,
    int sortOrder,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    String bgGradientType,
  });
}

/// @nodoc
class _$FeaturedItemCopyWithImpl<$Res, $Val extends FeaturedItem>
    implements $FeaturedItemCopyWith<$Res> {
  _$FeaturedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? imageUrl = freezed,
    Object? type = null,
    Object? deepLinkRoute = freezed,
    Object? brandId = freezed,
    Object? communityIds = null,
    Object? isActive = null,
    Object? sortOrder = null,
    Object? scheduledStart = freezed,
    Object? scheduledEnd = freezed,
    Object? bgGradientType = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: freezed == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            deepLinkRoute: freezed == deepLinkRoute
                ? _value.deepLinkRoute
                : deepLinkRoute // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandId: freezed == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as String?,
            communityIds: null == communityIds
                ? _value.communityIds
                : communityIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            scheduledStart: freezed == scheduledStart
                ? _value.scheduledStart
                : scheduledStart // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            scheduledEnd: freezed == scheduledEnd
                ? _value.scheduledEnd
                : scheduledEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            bgGradientType: null == bgGradientType
                ? _value.bgGradientType
                : bgGradientType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeaturedItemImplCopyWith<$Res>
    implements $FeaturedItemCopyWith<$Res> {
  factory _$$FeaturedItemImplCopyWith(
    _$FeaturedItemImpl value,
    $Res Function(_$FeaturedItemImpl) then,
  ) = __$$FeaturedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? subtitle,
    String? imageUrl,
    String type,
    String? deepLinkRoute,
    String? brandId,
    List<String> communityIds,
    bool isActive,
    int sortOrder,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    String bgGradientType,
  });
}

/// @nodoc
class __$$FeaturedItemImplCopyWithImpl<$Res>
    extends _$FeaturedItemCopyWithImpl<$Res, _$FeaturedItemImpl>
    implements _$$FeaturedItemImplCopyWith<$Res> {
  __$$FeaturedItemImplCopyWithImpl(
    _$FeaturedItemImpl _value,
    $Res Function(_$FeaturedItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? imageUrl = freezed,
    Object? type = null,
    Object? deepLinkRoute = freezed,
    Object? brandId = freezed,
    Object? communityIds = null,
    Object? isActive = null,
    Object? sortOrder = null,
    Object? scheduledStart = freezed,
    Object? scheduledEnd = freezed,
    Object? bgGradientType = null,
  }) {
    return _then(
      _$FeaturedItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: freezed == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        deepLinkRoute: freezed == deepLinkRoute
            ? _value.deepLinkRoute
            : deepLinkRoute // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandId: freezed == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String?,
        communityIds: null == communityIds
            ? _value._communityIds
            : communityIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduledStart: freezed == scheduledStart
            ? _value.scheduledStart
            : scheduledStart // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        scheduledEnd: freezed == scheduledEnd
            ? _value.scheduledEnd
            : scheduledEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        bgGradientType: null == bgGradientType
            ? _value.bgGradientType
            : bgGradientType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedItemImpl extends _FeaturedItem {
  const _$FeaturedItemImpl({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.type = 'campaign',
    this.deepLinkRoute,
    this.brandId,
    final List<String> communityIds = const [],
    this.isActive = true,
    this.sortOrder = 0,
    this.scheduledStart,
    this.scheduledEnd,
    this.bgGradientType = 'goldOrange',
  }) : _communityIds = communityIds,
       super._();

  factory _$FeaturedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String? imageUrl;

  /// Type: campaign, collectible, trending, promotion
  @override
  @JsonKey()
  final String type;

  /// GoRouter deep link path (e.g. /buy/category/airtime)
  @override
  final String? deepLinkRoute;
  @override
  final String? brandId;

  /// Community IDs this item targets (empty = global)
  final List<String> _communityIds;

  /// Community IDs this item targets (empty = global)
  @override
  @JsonKey()
  List<String> get communityIds {
    if (_communityIds is EqualUnmodifiableListView) return _communityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_communityIds);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  final DateTime? scheduledStart;
  @override
  final DateTime? scheduledEnd;

  /// BrandGradient type name (e.g. goldOrange, cyanBlue)
  @override
  @JsonKey()
  final String bgGradientType;

  @override
  String toString() {
    return 'FeaturedItem(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, type: $type, deepLinkRoute: $deepLinkRoute, brandId: $brandId, communityIds: $communityIds, isActive: $isActive, sortOrder: $sortOrder, scheduledStart: $scheduledStart, scheduledEnd: $scheduledEnd, bgGradientType: $bgGradientType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.deepLinkRoute, deepLinkRoute) ||
                other.deepLinkRoute == deepLinkRoute) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            const DeepCollectionEquality().equals(
              other._communityIds,
              _communityIds,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.scheduledStart, scheduledStart) ||
                other.scheduledStart == scheduledStart) &&
            (identical(other.scheduledEnd, scheduledEnd) ||
                other.scheduledEnd == scheduledEnd) &&
            (identical(other.bgGradientType, bgGradientType) ||
                other.bgGradientType == bgGradientType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subtitle,
    imageUrl,
    type,
    deepLinkRoute,
    brandId,
    const DeepCollectionEquality().hash(_communityIds),
    isActive,
    sortOrder,
    scheduledStart,
    scheduledEnd,
    bgGradientType,
  );

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedItemImplCopyWith<_$FeaturedItemImpl> get copyWith =>
      __$$FeaturedItemImplCopyWithImpl<_$FeaturedItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedItemImplToJson(this);
  }
}

abstract class _FeaturedItem extends FeaturedItem {
  const factory _FeaturedItem({
    required final String id,
    required final String title,
    final String? subtitle,
    final String? imageUrl,
    final String type,
    final String? deepLinkRoute,
    final String? brandId,
    final List<String> communityIds,
    final bool isActive,
    final int sortOrder,
    final DateTime? scheduledStart,
    final DateTime? scheduledEnd,
    final String bgGradientType,
  }) = _$FeaturedItemImpl;
  const _FeaturedItem._() : super._();

  factory _FeaturedItem.fromJson(Map<String, dynamic> json) =
      _$FeaturedItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String? get imageUrl;

  /// Type: campaign, collectible, trending, promotion
  @override
  String get type;

  /// GoRouter deep link path (e.g. /buy/category/airtime)
  @override
  String? get deepLinkRoute;
  @override
  String? get brandId;

  /// Community IDs this item targets (empty = global)
  @override
  List<String> get communityIds;
  @override
  bool get isActive;
  @override
  int get sortOrder;
  @override
  DateTime? get scheduledStart;
  @override
  DateTime? get scheduledEnd;

  /// BrandGradient type name (e.g. goldOrange, cyanBlue)
  @override
  String get bgGradientType;

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedItemImplCopyWith<_$FeaturedItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
