// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_provider_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ServiceProviderModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  List<ServiceProductModel> get products => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ServiceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceProviderModelCopyWith<ServiceProviderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceProviderModelCopyWith<$Res> {
  factory $ServiceProviderModelCopyWith(
    ServiceProviderModel value,
    $Res Function(ServiceProviderModel) then,
  ) = _$ServiceProviderModelCopyWithImpl<$Res, ServiceProviderModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String category,
    String? logoUrl,
    String? description,
    bool isActive,
    List<ServiceProductModel> products,
    int? sortOrder,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ServiceProviderModelCopyWithImpl<
  $Res,
  $Val extends ServiceProviderModel
>
    implements $ServiceProviderModelCopyWith<$Res> {
  _$ServiceProviderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceProviderModel
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
                      as String,
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
                      as List<ServiceProductModel>,
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
abstract class _$$ServiceProviderModelImplCopyWith<$Res>
    implements $ServiceProviderModelCopyWith<$Res> {
  factory _$$ServiceProviderModelImplCopyWith(
    _$ServiceProviderModelImpl value,
    $Res Function(_$ServiceProviderModelImpl) then,
  ) = __$$ServiceProviderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String category,
    String? logoUrl,
    String? description,
    bool isActive,
    List<ServiceProductModel> products,
    int? sortOrder,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ServiceProviderModelImplCopyWithImpl<$Res>
    extends _$ServiceProviderModelCopyWithImpl<$Res, _$ServiceProviderModelImpl>
    implements _$$ServiceProviderModelImplCopyWith<$Res> {
  __$$ServiceProviderModelImplCopyWithImpl(
    _$ServiceProviderModelImpl _value,
    $Res Function(_$ServiceProviderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceProviderModel
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
      _$ServiceProviderModelImpl(
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
                  as String,
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
                  as List<ServiceProductModel>,
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

class _$ServiceProviderModelImpl extends _ServiceProviderModel {
  const _$ServiceProviderModelImpl({
    required this.id,
    required this.name,
    required this.code,
    required this.category,
    this.logoUrl,
    this.description,
    required this.isActive,
    required final List<ServiceProductModel> products,
    this.sortOrder,
    required this.createdAt,
    this.updatedAt,
  }) : _products = products,
       super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final String category;
  @override
  final String? logoUrl;
  @override
  final String? description;
  @override
  final bool isActive;
  final List<ServiceProductModel> _products;
  @override
  List<ServiceProductModel> get products {
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
    return 'ServiceProviderModel(id: $id, name: $name, code: $code, category: $category, logoUrl: $logoUrl, description: $description, isActive: $isActive, products: $products, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceProviderModelImpl &&
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

  /// Create a copy of ServiceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceProviderModelImplCopyWith<_$ServiceProviderModelImpl>
  get copyWith =>
      __$$ServiceProviderModelImplCopyWithImpl<_$ServiceProviderModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ServiceProviderModel extends ServiceProviderModel {
  const factory _ServiceProviderModel({
    required final String id,
    required final String name,
    required final String code,
    required final String category,
    final String? logoUrl,
    final String? description,
    required final bool isActive,
    required final List<ServiceProductModel> products,
    final int? sortOrder,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$ServiceProviderModelImpl;
  const _ServiceProviderModel._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String get category;
  @override
  String? get logoUrl;
  @override
  String? get description;
  @override
  bool get isActive;
  @override
  List<ServiceProductModel> get products;
  @override
  int? get sortOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ServiceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceProviderModelImplCopyWith<_$ServiceProviderModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ServiceProductModel {
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

  /// Create a copy of ServiceProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceProductModelCopyWith<ServiceProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceProductModelCopyWith<$Res> {
  factory $ServiceProductModelCopyWith(
    ServiceProductModel value,
    $Res Function(ServiceProductModel) then,
  ) = _$ServiceProductModelCopyWithImpl<$Res, ServiceProductModel>;
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
class _$ServiceProductModelCopyWithImpl<$Res, $Val extends ServiceProductModel>
    implements $ServiceProductModelCopyWith<$Res> {
  _$ServiceProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceProductModel
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
abstract class _$$ServiceProductModelImplCopyWith<$Res>
    implements $ServiceProductModelCopyWith<$Res> {
  factory _$$ServiceProductModelImplCopyWith(
    _$ServiceProductModelImpl value,
    $Res Function(_$ServiceProductModelImpl) then,
  ) = __$$ServiceProductModelImplCopyWithImpl<$Res>;
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
class __$$ServiceProductModelImplCopyWithImpl<$Res>
    extends _$ServiceProductModelCopyWithImpl<$Res, _$ServiceProductModelImpl>
    implements _$$ServiceProductModelImplCopyWith<$Res> {
  __$$ServiceProductModelImplCopyWithImpl(
    _$ServiceProductModelImpl _value,
    $Res Function(_$ServiceProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceProductModel
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
      _$ServiceProductModelImpl(
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

class _$ServiceProductModelImpl extends _ServiceProductModel {
  const _$ServiceProductModelImpl({
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
    return 'ServiceProductModel(id: $id, providerId: $providerId, name: $name, code: $code, priceTokens: $priceTokens, priceZar: $priceZar, description: $description, validity: $validity, isActive: $isActive, sortOrder: $sortOrder, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceProductModelImpl &&
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

  /// Create a copy of ServiceProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceProductModelImplCopyWith<_$ServiceProductModelImpl> get copyWith =>
      __$$ServiceProductModelImplCopyWithImpl<_$ServiceProductModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ServiceProductModel extends ServiceProductModel {
  const factory _ServiceProductModel({
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
  }) = _$ServiceProductModelImpl;
  const _ServiceProductModel._() : super._();

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

  /// Create a copy of ServiceProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceProductModelImplCopyWith<_$ServiceProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
