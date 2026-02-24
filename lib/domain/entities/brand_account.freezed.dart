// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BrandAccount _$BrandAccountFromJson(Map<String, dynamic> json) {
  return _BrandAccount.fromJson(json);
}

/// @nodoc
mixin _$BrandAccount {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get avatarColor => throw _privateConstructorUsedError;
  bool get isFollowed => throw _privateConstructorUsedError;
  DateTime? get followedAt => throw _privateConstructorUsedError;
  int get followerCount => throw _privateConstructorUsedError;

  /// Serializes this BrandAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrandAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandAccountCopyWith<BrandAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandAccountCopyWith<$Res> {
  factory $BrandAccountCopyWith(
    BrandAccount value,
    $Res Function(BrandAccount) then,
  ) = _$BrandAccountCopyWithImpl<$Res, BrandAccount>;
  @useResult
  $Res call({
    String id,
    String name,
    String? logoUrl,
    String? description,
    String? avatarColor,
    bool isFollowed,
    DateTime? followedAt,
    int followerCount,
  });
}

/// @nodoc
class _$BrandAccountCopyWithImpl<$Res, $Val extends BrandAccount>
    implements $BrandAccountCopyWith<$Res> {
  _$BrandAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? avatarColor = freezed,
    Object? isFollowed = null,
    Object? followedAt = freezed,
    Object? followerCount = null,
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
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarColor: freezed == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            isFollowed: null == isFollowed
                ? _value.isFollowed
                : isFollowed // ignore: cast_nullable_to_non_nullable
                      as bool,
            followedAt: freezed == followedAt
                ? _value.followedAt
                : followedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            followerCount: null == followerCount
                ? _value.followerCount
                : followerCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrandAccountImplCopyWith<$Res>
    implements $BrandAccountCopyWith<$Res> {
  factory _$$BrandAccountImplCopyWith(
    _$BrandAccountImpl value,
    $Res Function(_$BrandAccountImpl) then,
  ) = __$$BrandAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? logoUrl,
    String? description,
    String? avatarColor,
    bool isFollowed,
    DateTime? followedAt,
    int followerCount,
  });
}

/// @nodoc
class __$$BrandAccountImplCopyWithImpl<$Res>
    extends _$BrandAccountCopyWithImpl<$Res, _$BrandAccountImpl>
    implements _$$BrandAccountImplCopyWith<$Res> {
  __$$BrandAccountImplCopyWithImpl(
    _$BrandAccountImpl _value,
    $Res Function(_$BrandAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? avatarColor = freezed,
    Object? isFollowed = null,
    Object? followedAt = freezed,
    Object? followerCount = null,
  }) {
    return _then(
      _$BrandAccountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        isFollowed: null == isFollowed
            ? _value.isFollowed
            : isFollowed // ignore: cast_nullable_to_non_nullable
                  as bool,
        followedAt: freezed == followedAt
            ? _value.followedAt
            : followedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        followerCount: null == followerCount
            ? _value.followerCount
            : followerCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BrandAccountImpl extends _BrandAccount {
  const _$BrandAccountImpl({
    required this.id,
    required this.name,
    this.logoUrl,
    this.description,
    this.avatarColor,
    required this.isFollowed,
    this.followedAt,
    this.followerCount = 0,
  }) : super._();

  factory _$BrandAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrandAccountImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? logoUrl;
  @override
  final String? description;
  @override
  final String? avatarColor;
  @override
  final bool isFollowed;
  @override
  final DateTime? followedAt;
  @override
  @JsonKey()
  final int followerCount;

  @override
  String toString() {
    return 'BrandAccount(id: $id, name: $name, logoUrl: $logoUrl, description: $description, avatarColor: $avatarColor, isFollowed: $isFollowed, followedAt: $followedAt, followerCount: $followerCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.isFollowed, isFollowed) ||
                other.isFollowed == isFollowed) &&
            (identical(other.followedAt, followedAt) ||
                other.followedAt == followedAt) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    logoUrl,
    description,
    avatarColor,
    isFollowed,
    followedAt,
    followerCount,
  );

  /// Create a copy of BrandAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandAccountImplCopyWith<_$BrandAccountImpl> get copyWith =>
      __$$BrandAccountImplCopyWithImpl<_$BrandAccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrandAccountImplToJson(this);
  }
}

abstract class _BrandAccount extends BrandAccount {
  const factory _BrandAccount({
    required final String id,
    required final String name,
    final String? logoUrl,
    final String? description,
    final String? avatarColor,
    required final bool isFollowed,
    final DateTime? followedAt,
    final int followerCount,
  }) = _$BrandAccountImpl;
  const _BrandAccount._() : super._();

  factory _BrandAccount.fromJson(Map<String, dynamic> json) =
      _$BrandAccountImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get logoUrl;
  @override
  String? get description;
  @override
  String? get avatarColor;
  @override
  bool get isFollowed;
  @override
  DateTime? get followedAt;
  @override
  int get followerCount;

  /// Create a copy of BrandAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandAccountImplCopyWith<_$BrandAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
