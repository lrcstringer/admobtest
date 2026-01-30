// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthChallenge {
  String get challengeId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  ChallengeStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Create a copy of AuthChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthChallengeCopyWith<AuthChallenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthChallengeCopyWith<$Res> {
  factory $AuthChallengeCopyWith(
    AuthChallenge value,
    $Res Function(AuthChallenge) then,
  ) = _$AuthChallengeCopyWithImpl<$Res, AuthChallenge>;
  @useResult
  $Res call({
    String challengeId,
    String userId,
    String nonce,
    ChallengeStatus status,
    DateTime createdAt,
    DateTime expiresAt,
    String? deviceId,
    DateTime? respondedAt,
  });
}

/// @nodoc
class _$AuthChallengeCopyWithImpl<$Res, $Val extends AuthChallenge>
    implements $AuthChallengeCopyWith<$Res> {
  _$AuthChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? userId = null,
    Object? nonce = null,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? deviceId = freezed,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            challengeId: null == challengeId
                ? _value.challengeId
                : challengeId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            nonce: null == nonce
                ? _value.nonce
                : nonce // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ChallengeStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            deviceId: freezed == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthChallengeImplCopyWith<$Res>
    implements $AuthChallengeCopyWith<$Res> {
  factory _$$AuthChallengeImplCopyWith(
    _$AuthChallengeImpl value,
    $Res Function(_$AuthChallengeImpl) then,
  ) = __$$AuthChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String challengeId,
    String userId,
    String nonce,
    ChallengeStatus status,
    DateTime createdAt,
    DateTime expiresAt,
    String? deviceId,
    DateTime? respondedAt,
  });
}

/// @nodoc
class __$$AuthChallengeImplCopyWithImpl<$Res>
    extends _$AuthChallengeCopyWithImpl<$Res, _$AuthChallengeImpl>
    implements _$$AuthChallengeImplCopyWith<$Res> {
  __$$AuthChallengeImplCopyWithImpl(
    _$AuthChallengeImpl _value,
    $Res Function(_$AuthChallengeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? userId = null,
    Object? nonce = null,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? deviceId = freezed,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _$AuthChallengeImpl(
        challengeId: null == challengeId
            ? _value.challengeId
            : challengeId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        nonce: null == nonce
            ? _value.nonce
            : nonce // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ChallengeStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        deviceId: freezed == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$AuthChallengeImpl extends _AuthChallenge {
  const _$AuthChallengeImpl({
    required this.challengeId,
    required this.userId,
    required this.nonce,
    required this.status,
    required this.createdAt,
    required this.expiresAt,
    this.deviceId,
    this.respondedAt,
  }) : super._();

  @override
  final String challengeId;
  @override
  final String userId;
  @override
  final String nonce;
  @override
  final ChallengeStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime expiresAt;
  @override
  final String? deviceId;
  @override
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'AuthChallenge(challengeId: $challengeId, userId: $userId, nonce: $nonce, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, deviceId: $deviceId, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthChallengeImpl &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    challengeId,
    userId,
    nonce,
    status,
    createdAt,
    expiresAt,
    deviceId,
    respondedAt,
  );

  /// Create a copy of AuthChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthChallengeImplCopyWith<_$AuthChallengeImpl> get copyWith =>
      __$$AuthChallengeImplCopyWithImpl<_$AuthChallengeImpl>(this, _$identity);
}

abstract class _AuthChallenge extends AuthChallenge {
  const factory _AuthChallenge({
    required final String challengeId,
    required final String userId,
    required final String nonce,
    required final ChallengeStatus status,
    required final DateTime createdAt,
    required final DateTime expiresAt,
    final String? deviceId,
    final DateTime? respondedAt,
  }) = _$AuthChallengeImpl;
  const _AuthChallenge._() : super._();

  @override
  String get challengeId;
  @override
  String get userId;
  @override
  String get nonce;
  @override
  ChallengeStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get expiresAt;
  @override
  String? get deviceId;
  @override
  DateTime? get respondedAt;

  /// Create a copy of AuthChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthChallengeImplCopyWith<_$AuthChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
