// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  String get id => throw _privateConstructorUsedError;
  String get walletId => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get balanceAfter => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get counterpartyId => throw _privateConstructorUsedError;
  String? get counterpartyName => throw _privateConstructorUsedError;
  String? get engagementId => throw _privateConstructorUsedError;
  String? get purchaseId => throw _privateConstructorUsedError;
  String? get referralId => throw _privateConstructorUsedError;
  bool? get isBonus => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
    Transaction value,
    $Res Function(Transaction) then,
  ) = _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call({
    String id,
    String walletId,
    TransactionType type,
    int amount,
    int balanceAfter,
    DateTime createdAt,
    String? description,
    String? counterpartyId,
    String? counterpartyName,
    String? engagementId,
    String? purchaseId,
    String? referralId,
    bool? isBonus,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? walletId = null,
    Object? type = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? createdAt = null,
    Object? description = freezed,
    Object? counterpartyId = freezed,
    Object? counterpartyName = freezed,
    Object? engagementId = freezed,
    Object? purchaseId = freezed,
    Object? referralId = freezed,
    Object? isBonus = freezed,
    Object? metadata = freezed,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TransactionType,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            balanceAfter: null == balanceAfter
                ? _value.balanceAfter
                : balanceAfter // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            counterpartyId: freezed == counterpartyId
                ? _value.counterpartyId
                : counterpartyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            counterpartyName: freezed == counterpartyName
                ? _value.counterpartyName
                : counterpartyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            engagementId: freezed == engagementId
                ? _value.engagementId
                : engagementId // ignore: cast_nullable_to_non_nullable
                      as String?,
            purchaseId: freezed == purchaseId
                ? _value.purchaseId
                : purchaseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            referralId: freezed == referralId
                ? _value.referralId
                : referralId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isBonus: freezed == isBonus
                ? _value.isBonus
                : isBonus // ignore: cast_nullable_to_non_nullable
                      as bool?,
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
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
    _$TransactionImpl value,
    $Res Function(_$TransactionImpl) then,
  ) = __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String walletId,
    TransactionType type,
    int amount,
    int balanceAfter,
    DateTime createdAt,
    String? description,
    String? counterpartyId,
    String? counterpartyName,
    String? engagementId,
    String? purchaseId,
    String? referralId,
    bool? isBonus,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
    _$TransactionImpl _value,
    $Res Function(_$TransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? walletId = null,
    Object? type = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? createdAt = null,
    Object? description = freezed,
    Object? counterpartyId = freezed,
    Object? counterpartyName = freezed,
    Object? engagementId = freezed,
    Object? purchaseId = freezed,
    Object? referralId = freezed,
    Object? isBonus = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$TransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TransactionType,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        balanceAfter: null == balanceAfter
            ? _value.balanceAfter
            : balanceAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        counterpartyId: freezed == counterpartyId
            ? _value.counterpartyId
            : counterpartyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        counterpartyName: freezed == counterpartyName
            ? _value.counterpartyName
            : counterpartyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        engagementId: freezed == engagementId
            ? _value.engagementId
            : engagementId // ignore: cast_nullable_to_non_nullable
                  as String?,
        purchaseId: freezed == purchaseId
            ? _value.purchaseId
            : purchaseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        referralId: freezed == referralId
            ? _value.referralId
            : referralId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isBonus: freezed == isBonus
            ? _value.isBonus
            : isBonus // ignore: cast_nullable_to_non_nullable
                  as bool?,
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
class _$TransactionImpl extends _Transaction {
  const _$TransactionImpl({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.balanceAfter,
    required this.createdAt,
    this.description,
    this.counterpartyId,
    this.counterpartyName,
    this.engagementId,
    this.purchaseId,
    this.referralId,
    this.isBonus,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata,
       super._();

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String walletId;
  @override
  final TransactionType type;
  @override
  final int amount;
  @override
  final int balanceAfter;
  @override
  final DateTime createdAt;
  @override
  final String? description;
  @override
  final String? counterpartyId;
  @override
  final String? counterpartyName;
  @override
  final String? engagementId;
  @override
  final String? purchaseId;
  @override
  final String? referralId;
  @override
  final bool? isBonus;
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
    return 'Transaction(id: $id, walletId: $walletId, type: $type, amount: $amount, balanceAfter: $balanceAfter, createdAt: $createdAt, description: $description, counterpartyId: $counterpartyId, counterpartyName: $counterpartyName, engagementId: $engagementId, purchaseId: $purchaseId, referralId: $referralId, isBonus: $isBonus, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.counterpartyId, counterpartyId) ||
                other.counterpartyId == counterpartyId) &&
            (identical(other.counterpartyName, counterpartyName) ||
                other.counterpartyName == counterpartyName) &&
            (identical(other.engagementId, engagementId) ||
                other.engagementId == engagementId) &&
            (identical(other.purchaseId, purchaseId) ||
                other.purchaseId == purchaseId) &&
            (identical(other.referralId, referralId) ||
                other.referralId == referralId) &&
            (identical(other.isBonus, isBonus) || other.isBonus == isBonus) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    walletId,
    type,
    amount,
    balanceAfter,
    createdAt,
    description,
    counterpartyId,
    counterpartyName,
    engagementId,
    purchaseId,
    referralId,
    isBonus,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(this);
  }
}

abstract class _Transaction extends Transaction {
  const factory _Transaction({
    required final String id,
    required final String walletId,
    required final TransactionType type,
    required final int amount,
    required final int balanceAfter,
    required final DateTime createdAt,
    final String? description,
    final String? counterpartyId,
    final String? counterpartyName,
    final String? engagementId,
    final String? purchaseId,
    final String? referralId,
    final bool? isBonus,
    final Map<String, dynamic>? metadata,
  }) = _$TransactionImpl;
  const _Transaction._() : super._();

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get walletId;
  @override
  TransactionType get type;
  @override
  int get amount;
  @override
  int get balanceAfter;
  @override
  DateTime get createdAt;
  @override
  String? get description;
  @override
  String? get counterpartyId;
  @override
  String? get counterpartyName;
  @override
  String? get engagementId;
  @override
  String? get purchaseId;
  @override
  String? get referralId;
  @override
  bool? get isBonus;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
