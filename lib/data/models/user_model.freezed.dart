// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get userId => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get usernameLower => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get avatarColor => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get province => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName =>
      throw _privateConstructorUsedError; // Targeting fields
  List<String>? get languages => throw _privateConstructorUsedError;
  List<String>? get interests => throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;
  String? get referralCode => throw _privateConstructorUsedError;
  String? get referredBy => throw _privateConstructorUsedError;
  bool get hasAcceptedTerms => throw _privateConstructorUsedError;
  bool get hasCompletedOnboarding => throw _privateConstructorUsedError;
  bool get isPotEligible => throw _privateConstructorUsedError;
  DateTime? get potEligibleAt => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  int? get riskScore => throw _privateConstructorUsedError;
  String? get primaryDeviceId => throw _privateConstructorUsedError;
  String? get riskLevel => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  String get kycTier => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastActiveAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String userId,
    String phoneNumber,
    String displayName,
    String? username,
    String? usernameLower,
    String? avatarUrl,
    String? avatarColor,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? city,
    String? firstName,
    String? lastName,
    List<String>? languages,
    List<String>? interests,
    UserStatus status,
    String? referralCode,
    String? referredBy,
    bool hasAcceptedTerms,
    bool hasCompletedOnboarding,
    bool isPotEligible,
    DateTime? potEligibleAt,
    String? fcmToken,
    int? riskScore,
    String? primaryDeviceId,
    String? riskLevel,
    DateTime? lastLoginAt,
    String kycTier,
    DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? phoneNumber = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? usernameLower = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? province = freezed,
    Object? city = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? languages = freezed,
    Object? interests = freezed,
    Object? status = null,
    Object? referralCode = freezed,
    Object? referredBy = freezed,
    Object? hasAcceptedTerms = null,
    Object? hasCompletedOnboarding = null,
    Object? isPotEligible = null,
    Object? potEligibleAt = freezed,
    Object? fcmToken = freezed,
    Object? riskScore = freezed,
    Object? primaryDeviceId = freezed,
    Object? riskLevel = freezed,
    Object? lastLoginAt = freezed,
    Object? kycTier = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            usernameLower: freezed == usernameLower
                ? _value.usernameLower
                : usernameLower // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarColor: freezed == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateOfBirth: freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            province: freezed == province
                ? _value.province
                : province // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            languages: freezed == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            interests: freezed == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UserStatus,
            referralCode: freezed == referralCode
                ? _value.referralCode
                : referralCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            referredBy: freezed == referredBy
                ? _value.referredBy
                : referredBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasAcceptedTerms: null == hasAcceptedTerms
                ? _value.hasAcceptedTerms
                : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasCompletedOnboarding: null == hasCompletedOnboarding
                ? _value.hasCompletedOnboarding
                : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPotEligible: null == isPotEligible
                ? _value.isPotEligible
                : isPotEligible // ignore: cast_nullable_to_non_nullable
                      as bool,
            potEligibleAt: freezed == potEligibleAt
                ? _value.potEligibleAt
                : potEligibleAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            fcmToken: freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            kycTier: null == kycTier
                ? _value.kycTier
                : kycTier // ignore: cast_nullable_to_non_nullable
                      as String,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String phoneNumber,
    String displayName,
    String? username,
    String? usernameLower,
    String? avatarUrl,
    String? avatarColor,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? city,
    String? firstName,
    String? lastName,
    List<String>? languages,
    List<String>? interests,
    UserStatus status,
    String? referralCode,
    String? referredBy,
    bool hasAcceptedTerms,
    bool hasCompletedOnboarding,
    bool isPotEligible,
    DateTime? potEligibleAt,
    String? fcmToken,
    int? riskScore,
    String? primaryDeviceId,
    String? riskLevel,
    DateTime? lastLoginAt,
    String kycTier,
    DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? phoneNumber = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? usernameLower = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? province = freezed,
    Object? city = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? languages = freezed,
    Object? interests = freezed,
    Object? status = null,
    Object? referralCode = freezed,
    Object? referredBy = freezed,
    Object? hasAcceptedTerms = null,
    Object? hasCompletedOnboarding = null,
    Object? isPotEligible = null,
    Object? potEligibleAt = freezed,
    Object? fcmToken = freezed,
    Object? riskScore = freezed,
    Object? primaryDeviceId = freezed,
    Object? riskLevel = freezed,
    Object? lastLoginAt = freezed,
    Object? kycTier = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        usernameLower: freezed == usernameLower
            ? _value.usernameLower
            : usernameLower // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateOfBirth: freezed == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        province: freezed == province
            ? _value.province
            : province // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        languages: freezed == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        interests: freezed == interests
            ? _value._interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UserStatus,
        referralCode: freezed == referralCode
            ? _value.referralCode
            : referralCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        referredBy: freezed == referredBy
            ? _value.referredBy
            : referredBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasAcceptedTerms: null == hasAcceptedTerms
            ? _value.hasAcceptedTerms
            : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasCompletedOnboarding: null == hasCompletedOnboarding
            ? _value.hasCompletedOnboarding
            : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPotEligible: null == isPotEligible
            ? _value.isPotEligible
            : isPotEligible // ignore: cast_nullable_to_non_nullable
                  as bool,
        potEligibleAt: freezed == potEligibleAt
            ? _value.potEligibleAt
            : potEligibleAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        fcmToken: freezed == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        kycTier: null == kycTier
            ? _value.kycTier
            : kycTier // ignore: cast_nullable_to_non_nullable
                  as String,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl({
    required this.userId,
    required this.phoneNumber,
    required this.displayName,
    this.username,
    this.usernameLower,
    this.avatarUrl,
    this.avatarColor,
    this.gender,
    this.dateOfBirth,
    this.province,
    this.city,
    this.firstName,
    this.lastName,
    final List<String>? languages,
    final List<String>? interests,
    required this.status,
    this.referralCode,
    this.referredBy,
    required this.hasAcceptedTerms,
    required this.hasCompletedOnboarding,
    required this.isPotEligible,
    this.potEligibleAt,
    this.fcmToken,
    this.riskScore,
    this.primaryDeviceId,
    this.riskLevel,
    this.lastLoginAt,
    this.kycTier = 'none',
    required this.createdAt,
    this.updatedAt,
    this.lastActiveAt,
  }) : _languages = languages,
       _interests = interests,
       super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String phoneNumber;
  @override
  final String displayName;
  @override
  final String? username;
  @override
  final String? usernameLower;
  @override
  final String? avatarUrl;
  @override
  final String? avatarColor;
  @override
  final String? gender;
  @override
  final DateTime? dateOfBirth;
  @override
  final String? province;
  @override
  final String? city;
  @override
  final String? firstName;
  @override
  final String? lastName;
  // Targeting fields
  final List<String>? _languages;
  // Targeting fields
  @override
  List<String>? get languages {
    final value = _languages;
    if (value == null) return null;
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _interests;
  @override
  List<String>? get interests {
    final value = _interests;
    if (value == null) return null;
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UserStatus status;
  @override
  final String? referralCode;
  @override
  final String? referredBy;
  @override
  final bool hasAcceptedTerms;
  @override
  final bool hasCompletedOnboarding;
  @override
  final bool isPotEligible;
  @override
  final DateTime? potEligibleAt;
  @override
  final String? fcmToken;
  @override
  final int? riskScore;
  @override
  final String? primaryDeviceId;
  @override
  final String? riskLevel;
  @override
  final DateTime? lastLoginAt;
  @override
  @JsonKey()
  final String kycTier;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastActiveAt;

  @override
  String toString() {
    return 'UserModel(userId: $userId, phoneNumber: $phoneNumber, displayName: $displayName, username: $username, usernameLower: $usernameLower, avatarUrl: $avatarUrl, avatarColor: $avatarColor, gender: $gender, dateOfBirth: $dateOfBirth, province: $province, city: $city, firstName: $firstName, lastName: $lastName, languages: $languages, interests: $interests, status: $status, referralCode: $referralCode, referredBy: $referredBy, hasAcceptedTerms: $hasAcceptedTerms, hasCompletedOnboarding: $hasCompletedOnboarding, isPotEligible: $isPotEligible, potEligibleAt: $potEligibleAt, fcmToken: $fcmToken, riskScore: $riskScore, primaryDeviceId: $primaryDeviceId, riskLevel: $riskLevel, lastLoginAt: $lastLoginAt, kycTier: $kycTier, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.usernameLower, usernameLower) ||
                other.usernameLower == usernameLower) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.province, province) ||
                other.province == province) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            const DeepCollectionEquality().equals(
              other._interests,
              _interests,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.hasAcceptedTerms, hasAcceptedTerms) ||
                other.hasAcceptedTerms == hasAcceptedTerms) &&
            (identical(other.hasCompletedOnboarding, hasCompletedOnboarding) ||
                other.hasCompletedOnboarding == hasCompletedOnboarding) &&
            (identical(other.isPotEligible, isPotEligible) ||
                other.isPotEligible == isPotEligible) &&
            (identical(other.potEligibleAt, potEligibleAt) ||
                other.potEligibleAt == potEligibleAt) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.primaryDeviceId, primaryDeviceId) ||
                other.primaryDeviceId == primaryDeviceId) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.kycTier, kycTier) || other.kycTier == kycTier) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    userId,
    phoneNumber,
    displayName,
    username,
    usernameLower,
    avatarUrl,
    avatarColor,
    gender,
    dateOfBirth,
    province,
    city,
    firstName,
    lastName,
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_interests),
    status,
    referralCode,
    referredBy,
    hasAcceptedTerms,
    hasCompletedOnboarding,
    isPotEligible,
    potEligibleAt,
    fcmToken,
    riskScore,
    primaryDeviceId,
    riskLevel,
    lastLoginAt,
    kycTier,
    createdAt,
    updatedAt,
    lastActiveAt,
  ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel({
    required final String userId,
    required final String phoneNumber,
    required final String displayName,
    final String? username,
    final String? usernameLower,
    final String? avatarUrl,
    final String? avatarColor,
    final String? gender,
    final DateTime? dateOfBirth,
    final String? province,
    final String? city,
    final String? firstName,
    final String? lastName,
    final List<String>? languages,
    final List<String>? interests,
    required final UserStatus status,
    final String? referralCode,
    final String? referredBy,
    required final bool hasAcceptedTerms,
    required final bool hasCompletedOnboarding,
    required final bool isPotEligible,
    final DateTime? potEligibleAt,
    final String? fcmToken,
    final int? riskScore,
    final String? primaryDeviceId,
    final String? riskLevel,
    final DateTime? lastLoginAt,
    final String kycTier,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final DateTime? lastActiveAt,
  }) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get phoneNumber;
  @override
  String get displayName;
  @override
  String? get username;
  @override
  String? get usernameLower;
  @override
  String? get avatarUrl;
  @override
  String? get avatarColor;
  @override
  String? get gender;
  @override
  DateTime? get dateOfBirth;
  @override
  String? get province;
  @override
  String? get city;
  @override
  String? get firstName;
  @override
  String? get lastName; // Targeting fields
  @override
  List<String>? get languages;
  @override
  List<String>? get interests;
  @override
  UserStatus get status;
  @override
  String? get referralCode;
  @override
  String? get referredBy;
  @override
  bool get hasAcceptedTerms;
  @override
  bool get hasCompletedOnboarding;
  @override
  bool get isPotEligible;
  @override
  DateTime? get potEligibleAt;
  @override
  String? get fcmToken;
  @override
  int? get riskScore;
  @override
  String? get primaryDeviceId;
  @override
  String? get riskLevel;
  @override
  DateTime? get lastLoginAt;
  @override
  String get kycTier;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastActiveAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
