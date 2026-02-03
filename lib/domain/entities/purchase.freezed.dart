// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return _Purchase.fromJson(json);
}

/// @nodoc
mixin _$Purchase {
  String get id => throw _privateConstructorUsedError;
  String get walletId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  PurchaseCategory get category => throw _privateConstructorUsedError;
  int get tokenAmount => throw _privateConstructorUsedError;
  double get zarAmount => throw _privateConstructorUsedError;
  PurchaseStatus get status => throw _privateConstructorUsedError;
  String get productCode => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String? get recipientNumber => throw _privateConstructorUsedError;
  String? get voucherCode => throw _privateConstructorUsedError;
  String? get voucherPin => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get processedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this Purchase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseCopyWith<Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseCopyWith<$Res> {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) then) =
      _$PurchaseCopyWithImpl<$Res, Purchase>;
  @useResult
  $Res call({
    String id,
    String walletId,
    String userId,
    String providerId,
    String providerName,
    PurchaseCategory category,
    int tokenAmount,
    double zarAmount,
    PurchaseStatus status,
    String productCode,
    String productName,
    String? recipientNumber,
    String? voucherCode,
    String? voucherPin,
    String? reference,
    String? failureReason,
    Map<String, dynamic>? metadata,
    DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$PurchaseCopyWithImpl<$Res, $Val extends Purchase>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? walletId = null,
    Object? userId = null,
    Object? providerId = null,
    Object? providerName = null,
    Object? category = null,
    Object? tokenAmount = null,
    Object? zarAmount = null,
    Object? status = null,
    Object? productCode = null,
    Object? productName = null,
    Object? recipientNumber = freezed,
    Object? voucherCode = freezed,
    Object? voucherPin = freezed,
    Object? reference = freezed,
    Object? failureReason = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? processedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            walletId: null == walletId
                ? _value.walletId
                : walletId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            providerId: null == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                      as String,
            providerName: null == providerName
                ? _value.providerName
                : providerName // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as PurchaseCategory,
            tokenAmount: null == tokenAmount
                ? _value.tokenAmount
                : tokenAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            zarAmount: null == zarAmount
                ? _value.zarAmount
                : zarAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PurchaseStatus,
            productCode: null == productCode
                ? _value.productCode
                : productCode // ignore: cast_nullable_to_non_nullable
                      as String,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientNumber: freezed == recipientNumber
                ? _value.recipientNumber
                : recipientNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            voucherCode: freezed == voucherCode
                ? _value.voucherCode
                : voucherCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            voucherPin: freezed == voucherPin
                ? _value.voucherPin
                : voucherPin // ignore: cast_nullable_to_non_nullable
                      as String?,
            reference: freezed == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                      as String?,
            failureReason: freezed == failureReason
                ? _value.failureReason
                : failureReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            processedAt: freezed == processedAt
                ? _value.processedAt
                : processedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchaseImplCopyWith<$Res>
    implements $PurchaseCopyWith<$Res> {
  factory _$$PurchaseImplCopyWith(
    _$PurchaseImpl value,
    $Res Function(_$PurchaseImpl) then,
  ) = __$$PurchaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String walletId,
    String userId,
    String providerId,
    String providerName,
    PurchaseCategory category,
    int tokenAmount,
    double zarAmount,
    PurchaseStatus status,
    String productCode,
    String productName,
    String? recipientNumber,
    String? voucherCode,
    String? voucherPin,
    String? reference,
    String? failureReason,
    Map<String, dynamic>? metadata,
    DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$PurchaseImplCopyWithImpl<$Res>
    extends _$PurchaseCopyWithImpl<$Res, _$PurchaseImpl>
    implements _$$PurchaseImplCopyWith<$Res> {
  __$$PurchaseImplCopyWithImpl(
    _$PurchaseImpl _value,
    $Res Function(_$PurchaseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? walletId = null,
    Object? userId = null,
    Object? providerId = null,
    Object? providerName = null,
    Object? category = null,
    Object? tokenAmount = null,
    Object? zarAmount = null,
    Object? status = null,
    Object? productCode = null,
    Object? productName = null,
    Object? recipientNumber = freezed,
    Object? voucherCode = freezed,
    Object? voucherPin = freezed,
    Object? reference = freezed,
    Object? failureReason = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? processedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$PurchaseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerName: null == providerName
            ? _value.providerName
            : providerName // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PurchaseCategory,
        tokenAmount: null == tokenAmount
            ? _value.tokenAmount
            : tokenAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        zarAmount: null == zarAmount
            ? _value.zarAmount
            : zarAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PurchaseStatus,
        productCode: null == productCode
            ? _value.productCode
            : productCode // ignore: cast_nullable_to_non_nullable
                  as String,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientNumber: freezed == recipientNumber
            ? _value.recipientNumber
            : recipientNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        voucherCode: freezed == voucherCode
            ? _value.voucherCode
            : voucherCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        voucherPin: freezed == voucherPin
            ? _value.voucherPin
            : voucherPin // ignore: cast_nullable_to_non_nullable
                  as String?,
        reference: freezed == reference
            ? _value.reference
            : reference // ignore: cast_nullable_to_non_nullable
                  as String?,
        failureReason: freezed == failureReason
            ? _value.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        processedAt: freezed == processedAt
            ? _value.processedAt
            : processedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseImpl extends _Purchase {
  const _$PurchaseImpl({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.providerId,
    required this.providerName,
    required this.category,
    required this.tokenAmount,
    required this.zarAmount,
    required this.status,
    required this.productCode,
    required this.productName,
    this.recipientNumber,
    this.voucherCode,
    this.voucherPin,
    this.reference,
    this.failureReason,
    final Map<String, dynamic>? metadata,
    required this.createdAt,
    this.processedAt,
    this.completedAt,
  }) : _metadata = metadata,
       super._();

  factory _$PurchaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseImplFromJson(json);

  @override
  final String id;
  @override
  final String walletId;
  @override
  final String userId;
  @override
  final String providerId;
  @override
  final String providerName;
  @override
  final PurchaseCategory category;
  @override
  final int tokenAmount;
  @override
  final double zarAmount;
  @override
  final PurchaseStatus status;
  @override
  final String productCode;
  @override
  final String productName;
  @override
  final String? recipientNumber;
  @override
  final String? voucherCode;
  @override
  final String? voucherPin;
  @override
  final String? reference;
  @override
  final String? failureReason;
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
  final DateTime createdAt;
  @override
  final DateTime? processedAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'Purchase(id: $id, walletId: $walletId, userId: $userId, providerId: $providerId, providerName: $providerName, category: $category, tokenAmount: $tokenAmount, zarAmount: $zarAmount, status: $status, productCode: $productCode, productName: $productName, recipientNumber: $recipientNumber, voucherCode: $voucherCode, voucherPin: $voucherPin, reference: $reference, failureReason: $failureReason, metadata: $metadata, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.tokenAmount, tokenAmount) ||
                other.tokenAmount == tokenAmount) &&
            (identical(other.zarAmount, zarAmount) ||
                other.zarAmount == zarAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.productCode, productCode) ||
                other.productCode == productCode) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.recipientNumber, recipientNumber) ||
                other.recipientNumber == recipientNumber) &&
            (identical(other.voucherCode, voucherCode) ||
                other.voucherCode == voucherCode) &&
            (identical(other.voucherPin, voucherPin) ||
                other.voucherPin == voucherPin) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    walletId,
    userId,
    providerId,
    providerName,
    category,
    tokenAmount,
    zarAmount,
    status,
    productCode,
    productName,
    recipientNumber,
    voucherCode,
    voucherPin,
    reference,
    failureReason,
    const DeepCollectionEquality().hash(_metadata),
    createdAt,
    processedAt,
    completedAt,
  ]);

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      __$$PurchaseImplCopyWithImpl<_$PurchaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseImplToJson(this);
  }
}

abstract class _Purchase extends Purchase {
  const factory _Purchase({
    required final String id,
    required final String walletId,
    required final String userId,
    required final String providerId,
    required final String providerName,
    required final PurchaseCategory category,
    required final int tokenAmount,
    required final double zarAmount,
    required final PurchaseStatus status,
    required final String productCode,
    required final String productName,
    final String? recipientNumber,
    final String? voucherCode,
    final String? voucherPin,
    final String? reference,
    final String? failureReason,
    final Map<String, dynamic>? metadata,
    required final DateTime createdAt,
    final DateTime? processedAt,
    final DateTime? completedAt,
  }) = _$PurchaseImpl;
  const _Purchase._() : super._();

  factory _Purchase.fromJson(Map<String, dynamic> json) =
      _$PurchaseImpl.fromJson;

  @override
  String get id;
  @override
  String get walletId;
  @override
  String get userId;
  @override
  String get providerId;
  @override
  String get providerName;
  @override
  PurchaseCategory get category;
  @override
  int get tokenAmount;
  @override
  double get zarAmount;
  @override
  PurchaseStatus get status;
  @override
  String get productCode;
  @override
  String get productName;
  @override
  String? get recipientNumber;
  @override
  String? get voucherCode;
  @override
  String? get voucherPin;
  @override
  String? get reference;
  @override
  String? get failureReason;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime? get processedAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
