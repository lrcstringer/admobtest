// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ServiceProvider _$ServiceProviderFromJson(Map<String, dynamic> json) {
  return _ServiceProvider.fromJson(json);
}

/// @nodoc
mixin _$ServiceProvider {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  PurchaseCategory get category => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  List<ServiceProduct> get products => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ServiceProvider to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceProviderCopyWith<ServiceProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceProviderCopyWith<$Res> {
  factory $ServiceProviderCopyWith(
    ServiceProvider value,
    $Res Function(ServiceProvider) then,
  ) = _$ServiceProviderCopyWithImpl<$Res, ServiceProvider>;
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    PurchaseCategory category,
    String? logoUrl,
    String? description,
    bool isActive,
    List<ServiceProduct> products,
    int? sortOrder,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ServiceProviderCopyWithImpl<$Res, $Val extends ServiceProvider>
    implements $ServiceProviderCopyWith<$Res> {
  _$ServiceProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? category = null,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? isActive = null,
    Object? products = null,
    Object? sortOrder = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as PurchaseCategory,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<ServiceProduct>,
            sortOrder: freezed == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceProviderImplCopyWith<$Res>
    implements $ServiceProviderCopyWith<$Res> {
  factory _$$ServiceProviderImplCopyWith(
    _$ServiceProviderImpl value,
    $Res Function(_$ServiceProviderImpl) then,
  ) = __$$ServiceProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    PurchaseCategory category,
    String? logoUrl,
    String? description,
    bool isActive,
    List<ServiceProduct> products,
    int? sortOrder,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ServiceProviderImplCopyWithImpl<$Res>
    extends _$ServiceProviderCopyWithImpl<$Res, _$ServiceProviderImpl>
    implements _$$ServiceProviderImplCopyWith<$Res> {
  __$$ServiceProviderImplCopyWithImpl(
    _$ServiceProviderImpl _value,
    $Res Function(_$ServiceProviderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? category = null,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? isActive = null,
    Object? products = null,
    Object? sortOrder = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ServiceProviderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PurchaseCategory,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<ServiceProduct>,
        sortOrder: freezed == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceProviderImpl extends _ServiceProvider {
  const _$ServiceProviderImpl({
    required this.id,
    required this.name,
    required this.code,
    required this.category,
    this.logoUrl,
    this.description,
    required this.isActive,
    required final List<ServiceProduct> products,
    this.sortOrder,
    required this.createdAt,
    this.updatedAt,
  }) : _products = products,
       super._();

  factory _$ServiceProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceProviderImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final PurchaseCategory category;
  @override
  final String? logoUrl;
  @override
  final String? description;
  @override
  final bool isActive;
  final List<ServiceProduct> _products;
  @override
  List<ServiceProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final int? sortOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ServiceProvider(id: $id, name: $name, code: $code, category: $category, logoUrl: $logoUrl, description: $description, isActive: $isActive, products: $products, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceProviderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    code,
    category,
    logoUrl,
    description,
    isActive,
    const DeepCollectionEquality().hash(_products),
    sortOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ServiceProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceProviderImplCopyWith<_$ServiceProviderImpl> get copyWith =>
      __$$ServiceProviderImplCopyWithImpl<_$ServiceProviderImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceProviderImplToJson(this);
  }
}

abstract class _ServiceProvider extends ServiceProvider {
  const factory _ServiceProvider({
    required final String id,
    required final String name,
    required final String code,
    required final PurchaseCategory category,
    final String? logoUrl,
    final String? description,
    required final bool isActive,
    required final List<ServiceProduct> products,
    final int? sortOrder,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$ServiceProviderImpl;
  const _ServiceProvider._() : super._();

  factory _ServiceProvider.fromJson(Map<String, dynamic> json) =
      _$ServiceProviderImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  PurchaseCategory get category;
  @override
  String? get logoUrl;
  @override
  String? get description;
  @override
  bool get isActive;
  @override
  List<ServiceProduct> get products;
  @override
  int? get sortOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ServiceProvider
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceProviderImplCopyWith<_$ServiceProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceProduct _$ServiceProductFromJson(Map<String, dynamic> json) {
  return _ServiceProduct.fromJson(json);
}

/// @nodoc
mixin _$ServiceProduct {
  String get id => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  int get priceTokens => throw _privateConstructorUsedError;
  double get priceZar => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get validity => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ServiceProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceProductCopyWith<ServiceProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceProductCopyWith<$Res> {
  factory $ServiceProductCopyWith(
    ServiceProduct value,
    $Res Function(ServiceProduct) then,
  ) = _$ServiceProductCopyWithImpl<$Res, ServiceProduct>;
  @useResult
  $Res call({
    String id,
    String providerId,
    String name,
    String code,
    int priceTokens,
    double priceZar,
    String? description,
    String? validity,
    bool isActive,
    int? sortOrder,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$ServiceProductCopyWithImpl<$Res, $Val extends ServiceProduct>
    implements $ServiceProductCopyWith<$Res> {
  _$ServiceProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? providerId = null,
    Object? name = null,
    Object? code = null,
    Object? priceTokens = null,
    Object? priceZar = null,
    Object? description = freezed,
    Object? validity = freezed,
    Object? isActive = null,
    Object? sortOrder = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            providerId: null == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            priceTokens: null == priceTokens
                ? _value.priceTokens
                : priceTokens // ignore: cast_nullable_to_non_nullable
                      as int,
            priceZar: null == priceZar
                ? _value.priceZar
                : priceZar // ignore: cast_nullable_to_non_nullable
                      as double,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            validity: freezed == validity
                ? _value.validity
                : validity // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: freezed == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceProductImplCopyWith<$Res>
    implements $ServiceProductCopyWith<$Res> {
  factory _$$ServiceProductImplCopyWith(
    _$ServiceProductImpl value,
    $Res Function(_$ServiceProductImpl) then,
  ) = __$$ServiceProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String providerId,
    String name,
    String code,
    int priceTokens,
    double priceZar,
    String? description,
    String? validity,
    bool isActive,
    int? sortOrder,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$ServiceProductImplCopyWithImpl<$Res>
    extends _$ServiceProductCopyWithImpl<$Res, _$ServiceProductImpl>
    implements _$$ServiceProductImplCopyWith<$Res> {
  __$$ServiceProductImplCopyWithImpl(
    _$ServiceProductImpl _value,
    $Res Function(_$ServiceProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? providerId = null,
    Object? name = null,
    Object? code = null,
    Object? priceTokens = null,
    Object? priceZar = null,
    Object? description = freezed,
    Object? validity = freezed,
    Object? isActive = null,
    Object? sortOrder = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$ServiceProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        priceTokens: null == priceTokens
            ? _value.priceTokens
            : priceTokens // ignore: cast_nullable_to_non_nullable
                  as int,
        priceZar: null == priceZar
            ? _value.priceZar
            : priceZar // ignore: cast_nullable_to_non_nullable
                  as double,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        validity: freezed == validity
            ? _value.validity
            : validity // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: freezed == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceProductImpl extends _ServiceProduct {
  const _$ServiceProductImpl({
    required this.id,
    required this.providerId,
    required this.name,
    required this.code,
    required this.priceTokens,
    required this.priceZar,
    this.description,
    this.validity,
    required this.isActive,
    this.sortOrder,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata,
       super._();

  factory _$ServiceProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceProductImplFromJson(json);

  @override
  final String id;
  @override
  final String providerId;
  @override
  final String name;
  @override
  final String code;
  @override
  final int priceTokens;
  @override
  final double priceZar;
  @override
  final String? description;
  @override
  final String? validity;
  @override
  final bool isActive;
  @override
  final int? sortOrder;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ServiceProduct(id: $id, providerId: $providerId, name: $name, code: $code, priceTokens: $priceTokens, priceZar: $priceZar, description: $description, validity: $validity, isActive: $isActive, sortOrder: $sortOrder, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.priceTokens, priceTokens) ||
                other.priceTokens == priceTokens) &&
            (identical(other.priceZar, priceZar) ||
                other.priceZar == priceZar) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.validity, validity) ||
                other.validity == validity) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    providerId,
    name,
    code,
    priceTokens,
    priceZar,
    description,
    validity,
    isActive,
    sortOrder,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of ServiceProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceProductImplCopyWith<_$ServiceProductImpl> get copyWith =>
      __$$ServiceProductImplCopyWithImpl<_$ServiceProductImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceProductImplToJson(this);
  }
}

abstract class _ServiceProduct extends ServiceProduct {
  const factory _ServiceProduct({
    required final String id,
    required final String providerId,
    required final String name,
    required final String code,
    required final int priceTokens,
    required final double priceZar,
    final String? description,
    final String? validity,
    required final bool isActive,
    final int? sortOrder,
    final Map<String, dynamic>? metadata,
  }) = _$ServiceProductImpl;
  const _ServiceProduct._() : super._();

  factory _ServiceProduct.fromJson(Map<String, dynamic> json) =
      _$ServiceProductImpl.fromJson;

  @override
  String get id;
  @override
  String get providerId;
  @override
  String get name;
  @override
  String get code;
  @override
  int get priceTokens;
  @override
  double get priceZar;
  @override
  String? get description;
  @override
  String? get validity;
  @override
  bool get isActive;
  @override
  int? get sortOrder;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ServiceProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceProductImplCopyWith<_$ServiceProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
