// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;
  bool get isPotEligible => throw _privateConstructorUsedError;
  bool get hasAcceptedTerms => throw _privateConstructorUsedError;
  bool get hasCompletedOnboarding => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastActiveAt => throw _privateConstructorUsedError;
  DateTime? get potEligibleAt => throw _privateConstructorUsedError;
  String? get referralCode => throw _privateConstructorUsedError;
  String? get currentVisitorId => throw _privateConstructorUsedError;
  UserProfile? get profile => throw _privateConstructorUsedError;
  int? get riskScore => throw _privateConstructorUsedError;
  String? get primaryDeviceId => throw _privateConstructorUsedError;
  String? get riskLevel => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String phoneNumber,
    UserStatus status,
    bool isPotEligible,
    bool hasAcceptedTerms,
    bool hasCompletedOnboarding,
    DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
    DateTime? potEligibleAt,
    String? referralCode,
    String? currentVisitorId,
    UserProfile? profile,
    int? riskScore,
    String? primaryDeviceId,
    String? riskLevel,
    DateTime? lastLoginAt,
  });

  $UserProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? status = null,
    Object? isPotEligible = null,
    Object? hasAcceptedTerms = null,
    Object? hasCompletedOnboarding = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
    Object? potEligibleAt = freezed,
    Object? referralCode = freezed,
    Object? currentVisitorId = freezed,
    Object? profile = freezed,
    Object? riskScore = freezed,
    Object? primaryDeviceId = freezed,
    Object? riskLevel = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UserStatus,
            isPotEligible: null == isPotEligible
                ? _value.isPotEligible
                : isPotEligible // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasAcceptedTerms: null == hasAcceptedTerms
                ? _value.hasAcceptedTerms
                : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasCompletedOnboarding: null == hasCompletedOnboarding
                ? _value.hasCompletedOnboarding
                : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastActiveAt: freezed == lastActiveAt
                ? _value.lastActiveAt
                : lastActiveAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            potEligibleAt: freezed == potEligibleAt
                ? _value.potEligibleAt
                : potEligibleAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            referralCode: freezed == referralCode
                ? _value.referralCode
                : referralCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentVisitorId: freezed == currentVisitorId
                ? _value.currentVisitorId
                : currentVisitorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as UserProfile?,
            riskScore: freezed == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as int?,
            primaryDeviceId: freezed == primaryDeviceId
                ? _value.primaryDeviceId
                : primaryDeviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            riskLevel: freezed == riskLevel
                ? _value.riskLevel
                : riskLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastLoginAt: freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phoneNumber,
    UserStatus status,
    bool isPotEligible,
    bool hasAcceptedTerms,
    bool hasCompletedOnboarding,
    DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
    DateTime? potEligibleAt,
    String? referralCode,
    String? currentVisitorId,
    UserProfile? profile,
    int? riskScore,
    String? primaryDeviceId,
    String? riskLevel,
    DateTime? lastLoginAt,
  });

  @override
  $UserProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? status = null,
    Object? isPotEligible = null,
    Object? hasAcceptedTerms = null,
    Object? hasCompletedOnboarding = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
    Object? potEligibleAt = freezed,
    Object? referralCode = freezed,
    Object? currentVisitorId = freezed,
    Object? profile = freezed,
    Object? riskScore = freezed,
    Object? primaryDeviceId = freezed,
    Object? riskLevel = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UserStatus,
        isPotEligible: null == isPotEligible
            ? _value.isPotEligible
            : isPotEligible // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasAcceptedTerms: null == hasAcceptedTerms
            ? _value.hasAcceptedTerms
            : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasCompletedOnboarding: null == hasCompletedOnboarding
            ? _value.hasCompletedOnboarding
            : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastActiveAt: freezed == lastActiveAt
            ? _value.lastActiveAt
            : lastActiveAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        potEligibleAt: freezed == potEligibleAt
            ? _value.potEligibleAt
            : potEligibleAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        referralCode: freezed == referralCode
            ? _value.referralCode
            : referralCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentVisitorId: freezed == currentVisitorId
            ? _value.currentVisitorId
            : currentVisitorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfile?,
        riskScore: freezed == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as int?,
        primaryDeviceId: freezed == primaryDeviceId
            ? _value.primaryDeviceId
            : primaryDeviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        riskLevel: freezed == riskLevel
            ? _value.riskLevel
            : riskLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastLoginAt: freezed == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl({
    required this.id,
    required this.phoneNumber,
    required this.status,
    required this.isPotEligible,
    required this.hasAcceptedTerms,
    required this.hasCompletedOnboarding,
    required this.createdAt,
    this.updatedAt,
    this.lastActiveAt,
    this.potEligibleAt,
    this.referralCode,
    this.currentVisitorId,
    this.profile,
    this.riskScore,
    this.primaryDeviceId,
    this.riskLevel,
    this.lastLoginAt,
  }) : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String phoneNumber;
  @override
  final UserStatus status;
  @override
  final bool isPotEligible;
  @override
  final bool hasAcceptedTerms;
  @override
  final bool hasCompletedOnboarding;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastActiveAt;
  @override
  final DateTime? potEligibleAt;
  @override
  final String? referralCode;
  @override
  final String? currentVisitorId;
  @override
  final UserProfile? profile;
  @override
  final int? riskScore;
  @override
  final String? primaryDeviceId;
  @override
  final String? riskLevel;
  @override
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'User(id: $id, phoneNumber: $phoneNumber, status: $status, isPotEligible: $isPotEligible, hasAcceptedTerms: $hasAcceptedTerms, hasCompletedOnboarding: $hasCompletedOnboarding, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt, potEligibleAt: $potEligibleAt, referralCode: $referralCode, currentVisitorId: $currentVisitorId, profile: $profile, riskScore: $riskScore, primaryDeviceId: $primaryDeviceId, riskLevel: $riskLevel, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isPotEligible, isPotEligible) ||
                other.isPotEligible == isPotEligible) &&
            (identical(other.hasAcceptedTerms, hasAcceptedTerms) ||
                other.hasAcceptedTerms == hasAcceptedTerms) &&
            (identical(other.hasCompletedOnboarding, hasCompletedOnboarding) ||
                other.hasCompletedOnboarding == hasCompletedOnboarding) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt) &&
            (identical(other.potEligibleAt, potEligibleAt) ||
                other.potEligibleAt == potEligibleAt) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.currentVisitorId, currentVisitorId) ||
                other.currentVisitorId == currentVisitorId) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.primaryDeviceId, primaryDeviceId) ||
                other.primaryDeviceId == primaryDeviceId) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phoneNumber,
    status,
    isPotEligible,
    hasAcceptedTerms,
    hasCompletedOnboarding,
    createdAt,
    updatedAt,
    lastActiveAt,
    potEligibleAt,
    referralCode,
    currentVisitorId,
    profile,
    riskScore,
    primaryDeviceId,
    riskLevel,
    lastLoginAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User extends User {
  const factory _User({
    required final String id,
    required final String phoneNumber,
    required final UserStatus status,
    required final bool isPotEligible,
    required final bool hasAcceptedTerms,
    required final bool hasCompletedOnboarding,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final DateTime? lastActiveAt,
    final DateTime? potEligibleAt,
    final String? referralCode,
    final String? currentVisitorId,
    final UserProfile? profile,
    final int? riskScore,
    final String? primaryDeviceId,
    final String? riskLevel,
    final DateTime? lastLoginAt,
  }) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get phoneNumber;
  @override
  UserStatus get status;
  @override
  bool get isPotEligible;
  @override
  bool get hasAcceptedTerms;
  @override
  bool get hasCompletedOnboarding;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastActiveAt;
  @override
  DateTime? get potEligibleAt;
  @override
  String? get referralCode;
  @override
  String? get currentVisitorId;
  @override
  UserProfile? get profile;
  @override
  int? get riskScore;
  @override
  String? get primaryDeviceId;
  @override
  String? get riskLevel;
  @override
  DateTime? get lastLoginAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
