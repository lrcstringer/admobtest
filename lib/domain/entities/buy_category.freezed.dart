// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BuySubcategory _$BuySubcategoryFromJson(Map<String, dynamic> json) {
  return _BuySubcategory.fromJson(json);
}

/// @nodoc
mixin _$BuySubcategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get iconEmoji => throw _privateConstructorUsedError;

  /// Serializes this BuySubcategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BuySubcategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuySubcategoryCopyWith<BuySubcategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuySubcategoryCopyWith<$Res> {
  factory $BuySubcategoryCopyWith(
    BuySubcategory value,
    $Res Function(BuySubcategory) then,
  ) = _$BuySubcategoryCopyWithImpl<$Res, BuySubcategory>;
  @useResult
  $Res call({String id, String name, String iconEmoji});
}

/// @nodoc
class _$BuySubcategoryCopyWithImpl<$Res, $Val extends BuySubcategory>
    implements $BuySubcategoryCopyWith<$Res> {
  _$BuySubcategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuySubcategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconEmoji = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            iconEmoji: null == iconEmoji
                ? _value.iconEmoji
                : iconEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BuySubcategoryImplCopyWith<$Res>
    implements $BuySubcategoryCopyWith<$Res> {
  factory _$$BuySubcategoryImplCopyWith(
    _$BuySubcategoryImpl value,
    $Res Function(_$BuySubcategoryImpl) then,
  ) = __$$BuySubcategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String iconEmoji});
}

/// @nodoc
class __$$BuySubcategoryImplCopyWithImpl<$Res>
    extends _$BuySubcategoryCopyWithImpl<$Res, _$BuySubcategoryImpl>
    implements _$$BuySubcategoryImplCopyWith<$Res> {
  __$$BuySubcategoryImplCopyWithImpl(
    _$BuySubcategoryImpl _value,
    $Res Function(_$BuySubcategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BuySubcategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconEmoji = null,
  }) {
    return _then(
      _$BuySubcategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        iconEmoji: null == iconEmoji
            ? _value.iconEmoji
            : iconEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BuySubcategoryImpl implements _BuySubcategory {
  const _$BuySubcategoryImpl({
    required this.id,
    required this.name,
    this.iconEmoji = '',
  });

  factory _$BuySubcategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuySubcategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String iconEmoji;

  @override
  String toString() {
    return 'BuySubcategory(id: $id, name: $name, iconEmoji: $iconEmoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuySubcategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, iconEmoji);

  /// Create a copy of BuySubcategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuySubcategoryImplCopyWith<_$BuySubcategoryImpl> get copyWith =>
      __$$BuySubcategoryImplCopyWithImpl<_$BuySubcategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BuySubcategoryImplToJson(this);
  }
}

abstract class _BuySubcategory implements BuySubcategory {
  const factory _BuySubcategory({
    required final String id,
    required final String name,
    final String iconEmoji,
  }) = _$BuySubcategoryImpl;

  factory _BuySubcategory.fromJson(Map<String, dynamic> json) =
      _$BuySubcategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get iconEmoji;

  /// Create a copy of BuySubcategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuySubcategoryImplCopyWith<_$BuySubcategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BuyCategory _$BuyCategoryFromJson(Map<String, dynamic> json) {
  return _BuyCategory.fromJson(json);
}

/// @nodoc
mixin _$BuyCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get iconEmoji => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isComingSoon => throw _privateConstructorUsedError;
  String? get purchaseCategoryMapping => throw _privateConstructorUsedError;
  String? get featureFlagKey => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get backgroundColor => throw _privateConstructorUsedError;
  List<BuySubcategory> get subcategories => throw _privateConstructorUsedError;

  /// Serializes this BuyCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BuyCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuyCategoryCopyWith<BuyCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyCategoryCopyWith<$Res> {
  factory $BuyCategoryCopyWith(
    BuyCategory value,
    $Res Function(BuyCategory) then,
  ) = _$BuyCategoryCopyWithImpl<$Res, BuyCategory>;
  @useResult
  $Res call({
    String id,
    String name,
    String iconEmoji,
    int sortOrder,
    bool isActive,
    bool isComingSoon,
    String? purchaseCategoryMapping,
    String? featureFlagKey,
    String? logoUrl,
    String? backgroundColor,
    List<BuySubcategory> subcategories,
  });
}

/// @nodoc
class _$BuyCategoryCopyWithImpl<$Res, $Val extends BuyCategory>
    implements $BuyCategoryCopyWith<$Res> {
  _$BuyCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuyCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconEmoji = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? isComingSoon = null,
    Object? purchaseCategoryMapping = freezed,
    Object? featureFlagKey = freezed,
    Object? logoUrl = freezed,
    Object? backgroundColor = freezed,
    Object? subcategories = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            iconEmoji: null == iconEmoji
                ? _value.iconEmoji
                : iconEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isComingSoon: null == isComingSoon
                ? _value.isComingSoon
                : isComingSoon // ignore: cast_nullable_to_non_nullable
                      as bool,
            purchaseCategoryMapping: freezed == purchaseCategoryMapping
                ? _value.purchaseCategoryMapping
                : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
                      as String?,
            featureFlagKey: freezed == featureFlagKey
                ? _value.featureFlagKey
                : featureFlagKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            backgroundColor: freezed == backgroundColor
                ? _value.backgroundColor
                : backgroundColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            subcategories: null == subcategories
                ? _value.subcategories
                : subcategories // ignore: cast_nullable_to_non_nullable
                      as List<BuySubcategory>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BuyCategoryImplCopyWith<$Res>
    implements $BuyCategoryCopyWith<$Res> {
  factory _$$BuyCategoryImplCopyWith(
    _$BuyCategoryImpl value,
    $Res Function(_$BuyCategoryImpl) then,
  ) = __$$BuyCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String iconEmoji,
    int sortOrder,
    bool isActive,
    bool isComingSoon,
    String? purchaseCategoryMapping,
    String? featureFlagKey,
    String? logoUrl,
    String? backgroundColor,
    List<BuySubcategory> subcategories,
  });
}

/// @nodoc
class __$$BuyCategoryImplCopyWithImpl<$Res>
    extends _$BuyCategoryCopyWithImpl<$Res, _$BuyCategoryImpl>
    implements _$$BuyCategoryImplCopyWith<$Res> {
  __$$BuyCategoryImplCopyWithImpl(
    _$BuyCategoryImpl _value,
    $Res Function(_$BuyCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BuyCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconEmoji = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? isComingSoon = null,
    Object? purchaseCategoryMapping = freezed,
    Object? featureFlagKey = freezed,
    Object? logoUrl = freezed,
    Object? backgroundColor = freezed,
    Object? subcategories = null,
  }) {
    return _then(
      _$BuyCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        iconEmoji: null == iconEmoji
            ? _value.iconEmoji
            : iconEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isComingSoon: null == isComingSoon
            ? _value.isComingSoon
            : isComingSoon // ignore: cast_nullable_to_non_nullable
                  as bool,
        purchaseCategoryMapping: freezed == purchaseCategoryMapping
            ? _value.purchaseCategoryMapping
            : purchaseCategoryMapping // ignore: cast_nullable_to_non_nullable
                  as String?,
        featureFlagKey: freezed == featureFlagKey
            ? _value.featureFlagKey
            : featureFlagKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        backgroundColor: freezed == backgroundColor
            ? _value.backgroundColor
            : backgroundColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        subcategories: null == subcategories
            ? _value._subcategories
            : subcategories // ignore: cast_nullable_to_non_nullable
                  as List<BuySubcategory>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BuyCategoryImpl extends _BuyCategory {
  const _$BuyCategoryImpl({
    required this.id,
    required this.name,
    required this.iconEmoji,
    required this.sortOrder,
    required this.isActive,
    this.isComingSoon = false,
    this.purchaseCategoryMapping,
    this.featureFlagKey,
    this.logoUrl,
    this.backgroundColor,
    final List<BuySubcategory> subcategories = const [],
  }) : _subcategories = subcategories,
       super._();

  factory _$BuyCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuyCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String iconEmoji;
  @override
  final int sortOrder;
  @override
  final bool isActive;
  @override
  @JsonKey()
  final bool isComingSoon;
  @override
  final String? purchaseCategoryMapping;
  @override
  final String? featureFlagKey;
  @override
  final String? logoUrl;
  @override
  final String? backgroundColor;
  final List<BuySubcategory> _subcategories;
  @override
  @JsonKey()
  List<BuySubcategory> get subcategories {
    if (_subcategories is EqualUnmodifiableListView) return _subcategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subcategories);
  }

  @override
  String toString() {
    return 'BuyCategory(id: $id, name: $name, iconEmoji: $iconEmoji, sortOrder: $sortOrder, isActive: $isActive, isComingSoon: $isComingSoon, purchaseCategoryMapping: $purchaseCategoryMapping, featureFlagKey: $featureFlagKey, logoUrl: $logoUrl, backgroundColor: $backgroundColor, subcategories: $subcategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isComingSoon, isComingSoon) ||
                other.isComingSoon == isComingSoon) &&
            (identical(
                  other.purchaseCategoryMapping,
                  purchaseCategoryMapping,
                ) ||
                other.purchaseCategoryMapping == purchaseCategoryMapping) &&
            (identical(other.featureFlagKey, featureFlagKey) ||
                other.featureFlagKey == featureFlagKey) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            const DeepCollectionEquality().equals(
              other._subcategories,
              _subcategories,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    iconEmoji,
    sortOrder,
    isActive,
    isComingSoon,
    purchaseCategoryMapping,
    featureFlagKey,
    logoUrl,
    backgroundColor,
    const DeepCollectionEquality().hash(_subcategories),
  );

  /// Create a copy of BuyCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyCategoryImplCopyWith<_$BuyCategoryImpl> get copyWith =>
      __$$BuyCategoryImplCopyWithImpl<_$BuyCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuyCategoryImplToJson(this);
  }
}

abstract class _BuyCategory extends BuyCategory {
  const factory _BuyCategory({
    required final String id,
    required final String name,
    required final String iconEmoji,
    required final int sortOrder,
    required final bool isActive,
    final bool isComingSoon,
    final String? purchaseCategoryMapping,
    final String? featureFlagKey,
    final String? logoUrl,
    final String? backgroundColor,
    final List<BuySubcategory> subcategories,
  }) = _$BuyCategoryImpl;
  const _BuyCategory._() : super._();

  factory _BuyCategory.fromJson(Map<String, dynamic> json) =
      _$BuyCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get iconEmoji;
  @override
  int get sortOrder;
  @override
  bool get isActive;
  @override
  bool get isComingSoon;
  @override
  String? get purchaseCategoryMapping;
  @override
  String? get featureFlagKey;
  @override
  String? get logoUrl;
  @override
  String? get backgroundColor;
  @override
  List<BuySubcategory> get subcategories;

  /// Create a copy of BuyCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyCategoryImplCopyWith<_$BuyCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
