// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerAccount _$LedgerAccountFromJson(Map<String, dynamic> json) {
  return _LedgerAccount.fromJson(json);
}

/// @nodoc
mixin _$LedgerAccount {
  String get id => throw _privateConstructorUsedError;
  LedgerAccountType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  int get balance => throw _privateConstructorUsedError;
  int get allocatedBalance => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  LedgerAccountStatus get status => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  /// Serializes this LedgerAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerAccountCopyWith<LedgerAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerAccountCopyWith<$Res> {
  factory $LedgerAccountCopyWith(
    LedgerAccount value,
    $Res Function(LedgerAccount) then,
  ) = _$LedgerAccountCopyWithImpl<$Res, LedgerAccount>;
  @useResult
  $Res call({
    String id,
    LedgerAccountType type,
    String name,
    String? ownerId,
    int balance,
    int allocatedBalance,
    String currency,
    LedgerAccountStatus status,
    Map<String, dynamic> metadata,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  });
}

/// @nodoc
class _$LedgerAccountCopyWithImpl<$Res, $Val extends LedgerAccount>
    implements $LedgerAccountCopyWith<$Res> {
  _$LedgerAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? ownerId = freezed,
    Object? balance = null,
    Object? allocatedBalance = null,
    Object? currency = null,
    Object? status = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? version = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as LedgerAccountType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerId: freezed == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as int,
            allocatedBalance: null == allocatedBalance
                ? _value.allocatedBalance
                : allocatedBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as LedgerAccountStatus,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerAccountImplCopyWith<$Res>
    implements $LedgerAccountCopyWith<$Res> {
  factory _$$LedgerAccountImplCopyWith(
    _$LedgerAccountImpl value,
    $Res Function(_$LedgerAccountImpl) then,
  ) = __$$LedgerAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    LedgerAccountType type,
    String name,
    String? ownerId,
    int balance,
    int allocatedBalance,
    String currency,
    LedgerAccountStatus status,
    Map<String, dynamic> metadata,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  });
}

/// @nodoc
class __$$LedgerAccountImplCopyWithImpl<$Res>
    extends _$LedgerAccountCopyWithImpl<$Res, _$LedgerAccountImpl>
    implements _$$LedgerAccountImplCopyWith<$Res> {
  __$$LedgerAccountImplCopyWithImpl(
    _$LedgerAccountImpl _value,
    $Res Function(_$LedgerAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? ownerId = freezed,
    Object? balance = null,
    Object? allocatedBalance = null,
    Object? currency = null,
    Object? status = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? version = null,
  }) {
    return _then(
      _$LedgerAccountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as LedgerAccountType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerId: freezed == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as int,
        allocatedBalance: null == allocatedBalance
            ? _value.allocatedBalance
            : allocatedBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as LedgerAccountStatus,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerAccountImpl extends _LedgerAccount {
  const _$LedgerAccountImpl({
    required this.id,
    required this.type,
    required this.name,
    this.ownerId,
    required this.balance,
    this.allocatedBalance = 0,
    this.currency = 'TOKEN',
    required this.status,
    final Map<String, dynamic> metadata = const {},
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
  }) : _metadata = metadata,
       super._();

  factory _$LedgerAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerAccountImplFromJson(json);

  @override
  final String id;
  @override
  final LedgerAccountType type;
  @override
  final String name;
  @override
  final String? ownerId;
  @override
  final int balance;
  @override
  @JsonKey()
  final int allocatedBalance;
  @override
  @JsonKey()
  final String currency;
  @override
  final LedgerAccountStatus status;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'LedgerAccount(id: $id, type: $type, name: $name, ownerId: $ownerId, balance: $balance, allocatedBalance: $allocatedBalance, currency: $currency, status: $status, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.allocatedBalance, allocatedBalance) ||
                other.allocatedBalance == allocatedBalance) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    name,
    ownerId,
    balance,
    allocatedBalance,
    currency,
    status,
    const DeepCollectionEquality().hash(_metadata),
    createdAt,
    updatedAt,
    version,
  );

  /// Create a copy of LedgerAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerAccountImplCopyWith<_$LedgerAccountImpl> get copyWith =>
      __$$LedgerAccountImplCopyWithImpl<_$LedgerAccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerAccountImplToJson(this);
  }
}

abstract class _LedgerAccount extends LedgerAccount {
  const factory _LedgerAccount({
    required final String id,
    required final LedgerAccountType type,
    required final String name,
    final String? ownerId,
    required final int balance,
    final int allocatedBalance,
    final String currency,
    required final LedgerAccountStatus status,
    final Map<String, dynamic> metadata,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final int version,
  }) = _$LedgerAccountImpl;
  const _LedgerAccount._() : super._();

  factory _LedgerAccount.fromJson(Map<String, dynamic> json) =
      _$LedgerAccountImpl.fromJson;

  @override
  String get id;
  @override
  LedgerAccountType get type;
  @override
  String get name;
  @override
  String? get ownerId;
  @override
  int get balance;
  @override
  int get allocatedBalance;
  @override
  String get currency;
  @override
  LedgerAccountStatus get status;
  @override
  Map<String, dynamic> get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  int get version;

  /// Create a copy of LedgerAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerAccountImplCopyWith<_$LedgerAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
