// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BrandProductModel {
  String get id => throw _privateConstructorUsedError;
  String get brandId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get priceZar => throw _privateConstructorUsedError;
  int get priceTokens => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  int? get stockCount => throw _privateConstructorUsedError;
  FulfilmentType get fulfilmentType => throw _privateConstructorUsedError;
  String? get contactMethod => throw _privateConstructorUsedError;
  String? get voucherInstructions => throw _privateConstructorUsedError;
  String? get collectionAddress => throw _privateConstructorUsedError;
  String? get deliveryInfo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of BrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandProductModelCopyWith<BrandProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandProductModelCopyWith<$Res> {
  factory $BrandProductModelCopyWith(
    BrandProductModel value,
    $Res Function(BrandProductModel) then,
  ) = _$BrandProductModelCopyWithImpl<$Res, BrandProductModel>;
  @useResult
  $Res call({
    String id,
    String brandId,
    String name,
    String? description,
    double priceZar,
    int priceTokens,
    String? imageUrl,
    String? category,
    bool isActive,
    bool isFeatured,
    int sortOrder,
    int? stockCount,
    FulfilmentType fulfilmentType,
    String? contactMethod,
    String? voucherInstructions,
    String? collectionAddress,
    String? deliveryInfo,
    DateTime createdAt,
  });
}

/// @nodoc
class _$BrandProductModelCopyWithImpl<$Res, $Val extends BrandProductModel>
    implements $BrandProductModelCopyWith<$Res> {
  _$BrandProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceZar = null,
    Object? priceTokens = null,
    Object? imageUrl = freezed,
    Object? category = freezed,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? sortOrder = null,
    Object? stockCount = freezed,
    Object? fulfilmentType = null,
    Object? contactMethod = freezed,
    Object? voucherInstructions = freezed,
    Object? collectionAddress = freezed,
    Object? deliveryInfo = freezed,
    Object? createdAt = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceZar: null == priceZar
                ? _value.priceZar
                : priceZar // ignore: cast_nullable_to_non_nullable
                      as double,
            priceTokens: null == priceTokens
                ? _value.priceTokens
                : priceTokens // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            stockCount: freezed == stockCount
                ? _value.stockCount
                : stockCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            fulfilmentType: null == fulfilmentType
                ? _value.fulfilmentType
                : fulfilmentType // ignore: cast_nullable_to_non_nullable
                      as FulfilmentType,
            contactMethod: freezed == contactMethod
                ? _value.contactMethod
                : contactMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            voucherInstructions: freezed == voucherInstructions
                ? _value.voucherInstructions
                : voucherInstructions // ignore: cast_nullable_to_non_nullable
                      as String?,
            collectionAddress: freezed == collectionAddress
                ? _value.collectionAddress
                : collectionAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            deliveryInfo: freezed == deliveryInfo
                ? _value.deliveryInfo
                : deliveryInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrandProductModelImplCopyWith<$Res>
    implements $BrandProductModelCopyWith<$Res> {
  factory _$$BrandProductModelImplCopyWith(
    _$BrandProductModelImpl value,
    $Res Function(_$BrandProductModelImpl) then,
  ) = __$$BrandProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String brandId,
    String name,
    String? description,
    double priceZar,
    int priceTokens,
    String? imageUrl,
    String? category,
    bool isActive,
    bool isFeatured,
    int sortOrder,
    int? stockCount,
    FulfilmentType fulfilmentType,
    String? contactMethod,
    String? voucherInstructions,
    String? collectionAddress,
    String? deliveryInfo,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$BrandProductModelImplCopyWithImpl<$Res>
    extends _$BrandProductModelCopyWithImpl<$Res, _$BrandProductModelImpl>
    implements _$$BrandProductModelImplCopyWith<$Res> {
  __$$BrandProductModelImplCopyWithImpl(
    _$BrandProductModelImpl _value,
    $Res Function(_$BrandProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceZar = null,
    Object? priceTokens = null,
    Object? imageUrl = freezed,
    Object? category = freezed,
    Object? isActive = null,
    Object? isFeatured = null,
    Object? sortOrder = null,
    Object? stockCount = freezed,
    Object? fulfilmentType = null,
    Object? contactMethod = freezed,
    Object? voucherInstructions = freezed,
    Object? collectionAddress = freezed,
    Object? deliveryInfo = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$BrandProductModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        brandId: null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceZar: null == priceZar
            ? _value.priceZar
            : priceZar // ignore: cast_nullable_to_non_nullable
                  as double,
        priceTokens: null == priceTokens
            ? _value.priceTokens
            : priceTokens // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        stockCount: freezed == stockCount
            ? _value.stockCount
            : stockCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        fulfilmentType: null == fulfilmentType
            ? _value.fulfilmentType
            : fulfilmentType // ignore: cast_nullable_to_non_nullable
                  as FulfilmentType,
        contactMethod: freezed == contactMethod
            ? _value.contactMethod
            : contactMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        voucherInstructions: freezed == voucherInstructions
            ? _value.voucherInstructions
            : voucherInstructions // ignore: cast_nullable_to_non_nullable
                  as String?,
        collectionAddress: freezed == collectionAddress
            ? _value.collectionAddress
            : collectionAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        deliveryInfo: freezed == deliveryInfo
            ? _value.deliveryInfo
            : deliveryInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$BrandProductModelImpl extends _BrandProductModel {
  const _$BrandProductModelImpl({
    required this.id,
    required this.brandId,
    required this.name,
    this.description,
    required this.priceZar,
    required this.priceTokens,
    this.imageUrl,
    this.category,
    this.isActive = true,
    this.isFeatured = false,
    this.sortOrder = 0,
    this.stockCount,
    required this.fulfilmentType,
    this.contactMethod,
    this.voucherInstructions,
    this.collectionAddress,
    this.deliveryInfo,
    required this.createdAt,
  }) : super._();

  @override
  final String id;
  @override
  final String brandId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final double priceZar;
  @override
  final int priceTokens;
  @override
  final String? imageUrl;
  @override
  final String? category;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  final int? stockCount;
  @override
  final FulfilmentType fulfilmentType;
  @override
  final String? contactMethod;
  @override
  final String? voucherInstructions;
  @override
  final String? collectionAddress;
  @override
  final String? deliveryInfo;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'BrandProductModel(id: $id, brandId: $brandId, name: $name, description: $description, priceZar: $priceZar, priceTokens: $priceTokens, imageUrl: $imageUrl, category: $category, isActive: $isActive, isFeatured: $isFeatured, sortOrder: $sortOrder, stockCount: $stockCount, fulfilmentType: $fulfilmentType, contactMethod: $contactMethod, voucherInstructions: $voucherInstructions, collectionAddress: $collectionAddress, deliveryInfo: $deliveryInfo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceZar, priceZar) ||
                other.priceZar == priceZar) &&
            (identical(other.priceTokens, priceTokens) ||
                other.priceTokens == priceTokens) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.stockCount, stockCount) ||
                other.stockCount == stockCount) &&
            (identical(other.fulfilmentType, fulfilmentType) ||
                other.fulfilmentType == fulfilmentType) &&
            (identical(other.contactMethod, contactMethod) ||
                other.contactMethod == contactMethod) &&
            (identical(other.voucherInstructions, voucherInstructions) ||
                other.voucherInstructions == voucherInstructions) &&
            (identical(other.collectionAddress, collectionAddress) ||
                other.collectionAddress == collectionAddress) &&
            (identical(other.deliveryInfo, deliveryInfo) ||
                other.deliveryInfo == deliveryInfo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    brandId,
    name,
    description,
    priceZar,
    priceTokens,
    imageUrl,
    category,
    isActive,
    isFeatured,
    sortOrder,
    stockCount,
    fulfilmentType,
    contactMethod,
    voucherInstructions,
    collectionAddress,
    deliveryInfo,
    createdAt,
  );

  /// Create a copy of BrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandProductModelImplCopyWith<_$BrandProductModelImpl> get copyWith =>
      __$$BrandProductModelImplCopyWithImpl<_$BrandProductModelImpl>(
        this,
        _$identity,
      );
}

abstract class _BrandProductModel extends BrandProductModel {
  const factory _BrandProductModel({
    required final String id,
    required final String brandId,
    required final String name,
    final String? description,
    required final double priceZar,
    required final int priceTokens,
    final String? imageUrl,
    final String? category,
    final bool isActive,
    final bool isFeatured,
    final int sortOrder,
    final int? stockCount,
    required final FulfilmentType fulfilmentType,
    final String? contactMethod,
    final String? voucherInstructions,
    final String? collectionAddress,
    final String? deliveryInfo,
    required final DateTime createdAt,
  }) = _$BrandProductModelImpl;
  const _BrandProductModel._() : super._();

  @override
  String get id;
  @override
  String get brandId;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get priceZar;
  @override
  int get priceTokens;
  @override
  String? get imageUrl;
  @override
  String? get category;
  @override
  bool get isActive;
  @override
  bool get isFeatured;
  @override
  int get sortOrder;
  @override
  int? get stockCount;
  @override
  FulfilmentType get fulfilmentType;
  @override
  String? get contactMethod;
  @override
  String? get voucherInstructions;
  @override
  String? get collectionAddress;
  @override
  String? get deliveryInfo;
  @override
  DateTime get createdAt;

  /// Create a copy of BrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandProductModelImplCopyWith<_$BrandProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
