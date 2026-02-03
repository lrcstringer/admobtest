// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return _Wallet.fromJson(json);
}

/// @nodoc
mixin _$Wallet {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  WalletType get type => throw _privateConstructorUsedError;
  int get tokenBalance => throw _privateConstructorUsedError;
  int get lifetimeEarned => throw _privateConstructorUsedError;
  int get lifetimeWithdrawn => throw _privateConstructorUsedError;
  bool get canWithdraw => throw _privateConstructorUsedError;
  int get todayEarned => throw _privateConstructorUsedError;
  int get pendingBalance => throw _privateConstructorUsedError;
  int get pendingWithdrawal => throw _privateConstructorUsedError;
  String? get brandId => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Wallet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletCopyWith<Wallet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) then) =
      _$WalletCopyWithImpl<$Res, Wallet>;
  @useResult
  $Res call({
    String id,
    String userId,
    String name,
    WalletType type,
    int tokenBalance,
    int lifetimeEarned,
    int lifetimeWithdrawn,
    bool canWithdraw,
    int todayEarned,
    int pendingBalance,
    int pendingWithdrawal,
    String? brandId,
    String? color,
    String? icon,
    String? description,
    int version,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$WalletCopyWithImpl<$Res, $Val extends Wallet>
    implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? type = null,
    Object? tokenBalance = null,
    Object? lifetimeEarned = null,
    Object? lifetimeWithdrawn = null,
    Object? canWithdraw = null,
    Object? todayEarned = null,
    Object? pendingBalance = null,
    Object? pendingWithdrawal = null,
    Object? brandId = freezed,
    Object? color = freezed,
    Object? icon = freezed,
    Object? description = freezed,
    Object? version = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as WalletType,
            tokenBalance: null == tokenBalance
                ? _value.tokenBalance
                : tokenBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            lifetimeEarned: null == lifetimeEarned
                ? _value.lifetimeEarned
                : lifetimeEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            lifetimeWithdrawn: null == lifetimeWithdrawn
                ? _value.lifetimeWithdrawn
                : lifetimeWithdrawn // ignore: cast_nullable_to_non_nullable
                      as int,
            canWithdraw: null == canWithdraw
                ? _value.canWithdraw
                : canWithdraw // ignore: cast_nullable_to_non_nullable
                      as bool,
            todayEarned: null == todayEarned
                ? _value.todayEarned
                : todayEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingBalance: null == pendingBalance
                ? _value.pendingBalance
                : pendingBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingWithdrawal: null == pendingWithdrawal
                ? _value.pendingWithdrawal
                : pendingWithdrawal // ignore: cast_nullable_to_non_nullable
                      as int,
            brandId: freezed == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$WalletImplCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$$WalletImplCopyWith(
    _$WalletImpl value,
    $Res Function(_$WalletImpl) then,
  ) = __$$WalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String name,
    WalletType type,
    int tokenBalance,
    int lifetimeEarned,
    int lifetimeWithdrawn,
    bool canWithdraw,
    int todayEarned,
    int pendingBalance,
    int pendingWithdrawal,
    String? brandId,
    String? color,
    String? icon,
    String? description,
    int version,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$WalletImplCopyWithImpl<$Res>
    extends _$WalletCopyWithImpl<$Res, _$WalletImpl>
    implements _$$WalletImplCopyWith<$Res> {
  __$$WalletImplCopyWithImpl(
    _$WalletImpl _value,
    $Res Function(_$WalletImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? type = null,
    Object? tokenBalance = null,
    Object? lifetimeEarned = null,
    Object? lifetimeWithdrawn = null,
    Object? canWithdraw = null,
    Object? todayEarned = null,
    Object? pendingBalance = null,
    Object? pendingWithdrawal = null,
    Object? brandId = freezed,
    Object? color = freezed,
    Object? icon = freezed,
    Object? description = freezed,
    Object? version = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$WalletImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as WalletType,
        tokenBalance: null == tokenBalance
            ? _value.tokenBalance
            : tokenBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        lifetimeEarned: null == lifetimeEarned
            ? _value.lifetimeEarned
            : lifetimeEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        lifetimeWithdrawn: null == lifetimeWithdrawn
            ? _value.lifetimeWithdrawn
            : lifetimeWithdrawn // ignore: cast_nullable_to_non_nullable
                  as int,
        canWithdraw: null == canWithdraw
            ? _value.canWithdraw
            : canWithdraw // ignore: cast_nullable_to_non_nullable
                  as bool,
        todayEarned: null == todayEarned
            ? _value.todayEarned
            : todayEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingBalance: null == pendingBalance
            ? _value.pendingBalance
            : pendingBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingWithdrawal: null == pendingWithdrawal
            ? _value.pendingWithdrawal
            : pendingWithdrawal // ignore: cast_nullable_to_non_nullable
                  as int,
        brandId: freezed == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$WalletImpl extends _Wallet {
  const _$WalletImpl({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.tokenBalance,
    required this.lifetimeEarned,
    required this.lifetimeWithdrawn,
    required this.canWithdraw,
    this.todayEarned = 0,
    this.pendingBalance = 0,
    this.pendingWithdrawal = 0,
    this.brandId,
    this.color,
    this.icon,
    this.description,
    this.version = 1,
    required this.updatedAt,
  }) : super._();

  factory _$WalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final WalletType type;
  @override
  final int tokenBalance;
  @override
  final int lifetimeEarned;
  @override
  final int lifetimeWithdrawn;
  @override
  final bool canWithdraw;
  @override
  @JsonKey()
  final int todayEarned;
  @override
  @JsonKey()
  final int pendingBalance;
  @override
  @JsonKey()
  final int pendingWithdrawal;
  @override
  final String? brandId;
  @override
  final String? color;
  @override
  final String? icon;
  @override
  final String? description;
  @override
  @JsonKey()
  final int version;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Wallet(id: $id, userId: $userId, name: $name, type: $type, tokenBalance: $tokenBalance, lifetimeEarned: $lifetimeEarned, lifetimeWithdrawn: $lifetimeWithdrawn, canWithdraw: $canWithdraw, todayEarned: $todayEarned, pendingBalance: $pendingBalance, pendingWithdrawal: $pendingWithdrawal, brandId: $brandId, color: $color, icon: $icon, description: $description, version: $version, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance) &&
            (identical(other.lifetimeEarned, lifetimeEarned) ||
                other.lifetimeEarned == lifetimeEarned) &&
            (identical(other.lifetimeWithdrawn, lifetimeWithdrawn) ||
                other.lifetimeWithdrawn == lifetimeWithdrawn) &&
            (identical(other.canWithdraw, canWithdraw) ||
                other.canWithdraw == canWithdraw) &&
            (identical(other.todayEarned, todayEarned) ||
                other.todayEarned == todayEarned) &&
            (identical(other.pendingBalance, pendingBalance) ||
                other.pendingBalance == pendingBalance) &&
            (identical(other.pendingWithdrawal, pendingWithdrawal) ||
                other.pendingWithdrawal == pendingWithdrawal) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    name,
    type,
    tokenBalance,
    lifetimeEarned,
    lifetimeWithdrawn,
    canWithdraw,
    todayEarned,
    pendingBalance,
    pendingWithdrawal,
    brandId,
    color,
    icon,
    description,
    version,
    updatedAt,
  );

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      __$$WalletImplCopyWithImpl<_$WalletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletImplToJson(this);
  }
}

abstract class _Wallet extends Wallet {
  const factory _Wallet({
    required final String id,
    required final String userId,
    required final String name,
    required final WalletType type,
    required final int tokenBalance,
    required final int lifetimeEarned,
    required final int lifetimeWithdrawn,
    required final bool canWithdraw,
    final int todayEarned,
    final int pendingBalance,
    final int pendingWithdrawal,
    final String? brandId,
    final String? color,
    final String? icon,
    final String? description,
    final int version,
    required final DateTime updatedAt,
  }) = _$WalletImpl;
  const _Wallet._() : super._();

  factory _Wallet.fromJson(Map<String, dynamic> json) = _$WalletImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  WalletType get type;
  @override
  int get tokenBalance;
  @override
  int get lifetimeEarned;
  @override
  int get lifetimeWithdrawn;
  @override
  bool get canWithdraw;
  @override
  int get todayEarned;
  @override
  int get pendingBalance;
  @override
  int get pendingWithdrawal;
  @override
  String? get brandId;
  @override
  String? get color;
  @override
  String? get icon;
  @override
  String? get description;
  @override
  int get version;
  @override
  DateTime get updatedAt;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
