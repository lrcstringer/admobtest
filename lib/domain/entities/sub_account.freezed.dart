// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sub_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubAccount _$SubAccountFromJson(Map<String, dynamic> json) {
  return _SubAccount.fromJson(json);
}

/// @nodoc
mixin _$SubAccount {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// null = unrestricted default account
  String? get accountTypeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get balance => throw _privateConstructorUsedError;
  int get lifetimeCredits => throw _privateConstructorUsedError;
  int get lifetimeDebits => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SubAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubAccountCopyWith<SubAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubAccountCopyWith<$Res> {
  factory $SubAccountCopyWith(
    SubAccount value,
    $Res Function(SubAccount) then,
  ) = _$SubAccountCopyWithImpl<$Res, SubAccount>;
  @useResult
  $Res call({
    String id,
    String userId,
    String? accountTypeId,
    String name,
    int balance,
    int lifetimeCredits,
    int lifetimeDebits,
    bool isActive,
    bool isDefault,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$SubAccountCopyWithImpl<$Res, $Val extends SubAccount>
    implements $SubAccountCopyWith<$Res> {
  _$SubAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? accountTypeId = freezed,
    Object? name = null,
    Object? balance = null,
    Object? lifetimeCredits = null,
    Object? lifetimeDebits = null,
    Object? isActive = null,
    Object? isDefault = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            accountTypeId: freezed == accountTypeId
                ? _value.accountTypeId
                : accountTypeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as int,
            lifetimeCredits: null == lifetimeCredits
                ? _value.lifetimeCredits
                : lifetimeCredits // ignore: cast_nullable_to_non_nullable
                      as int,
            lifetimeDebits: null == lifetimeDebits
                ? _value.lifetimeDebits
                : lifetimeDebits // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubAccountImplCopyWith<$Res>
    implements $SubAccountCopyWith<$Res> {
  factory _$$SubAccountImplCopyWith(
    _$SubAccountImpl value,
    $Res Function(_$SubAccountImpl) then,
  ) = __$$SubAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String? accountTypeId,
    String name,
    int balance,
    int lifetimeCredits,
    int lifetimeDebits,
    bool isActive,
    bool isDefault,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$SubAccountImplCopyWithImpl<$Res>
    extends _$SubAccountCopyWithImpl<$Res, _$SubAccountImpl>
    implements _$$SubAccountImplCopyWith<$Res> {
  __$$SubAccountImplCopyWithImpl(
    _$SubAccountImpl _value,
    $Res Function(_$SubAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? accountTypeId = freezed,
    Object? name = null,
    Object? balance = null,
    Object? lifetimeCredits = null,
    Object? lifetimeDebits = null,
    Object? isActive = null,
    Object? isDefault = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SubAccountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        accountTypeId: freezed == accountTypeId
            ? _value.accountTypeId
            : accountTypeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as int,
        lifetimeCredits: null == lifetimeCredits
            ? _value.lifetimeCredits
            : lifetimeCredits // ignore: cast_nullable_to_non_nullable
                  as int,
        lifetimeDebits: null == lifetimeDebits
            ? _value.lifetimeDebits
            : lifetimeDebits // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubAccountImpl extends _SubAccount {
  const _$SubAccountImpl({
    required this.id,
    required this.userId,
    this.accountTypeId,
    required this.name,
    required this.balance,
    required this.lifetimeCredits,
    required this.lifetimeDebits,
    required this.isActive,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();

  factory _$SubAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubAccountImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;

  /// null = unrestricted default account
  @override
  final String? accountTypeId;
  @override
  final String name;
  @override
  final int balance;
  @override
  final int lifetimeCredits;
  @override
  final int lifetimeDebits;
  @override
  final bool isActive;
  @override
  final bool isDefault;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SubAccount(id: $id, userId: $userId, accountTypeId: $accountTypeId, name: $name, balance: $balance, lifetimeCredits: $lifetimeCredits, lifetimeDebits: $lifetimeDebits, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.accountTypeId, accountTypeId) ||
                other.accountTypeId == accountTypeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.lifetimeCredits, lifetimeCredits) ||
                other.lifetimeCredits == lifetimeCredits) &&
            (identical(other.lifetimeDebits, lifetimeDebits) ||
                other.lifetimeDebits == lifetimeDebits) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
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
    userId,
    accountTypeId,
    name,
    balance,
    lifetimeCredits,
    lifetimeDebits,
    isActive,
    isDefault,
    createdAt,
    updatedAt,
  );

  /// Create a copy of SubAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubAccountImplCopyWith<_$SubAccountImpl> get copyWith =>
      __$$SubAccountImplCopyWithImpl<_$SubAccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubAccountImplToJson(this);
  }
}

abstract class _SubAccount extends SubAccount {
  const factory _SubAccount({
    required final String id,
    required final String userId,
    final String? accountTypeId,
    required final String name,
    required final int balance,
    required final int lifetimeCredits,
    required final int lifetimeDebits,
    required final bool isActive,
    required final bool isDefault,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$SubAccountImpl;
  const _SubAccount._() : super._();

  factory _SubAccount.fromJson(Map<String, dynamic> json) =
      _$SubAccountImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;

  /// null = unrestricted default account
  @override
  String? get accountTypeId;
  @override
  String get name;
  @override
  int get balance;
  @override
  int get lifetimeCredits;
  @override
  int get lifetimeDebits;
  @override
  bool get isActive;
  @override
  bool get isDefault;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of SubAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubAccountImplCopyWith<_$SubAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
