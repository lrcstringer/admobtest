// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 String get id; String get phoneNumber; UserStatus get status; bool get isPotEligible; bool get hasAcceptedTerms; bool get hasCompletedOnboarding; DateTime get createdAt; DateTime? get updatedAt; DateTime? get lastActiveAt; DateTime? get potEligibleAt; String? get referralCode; String? get referredBy; String? get currentVisitorId; UserProfile? get profile; int? get riskScore; String? get primaryDeviceId; String? get riskLevel; DateTime? get lastLoginAt; String get kycTier;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.isPotEligible, isPotEligible) || other.isPotEligible == isPotEligible)&&(identical(other.hasAcceptedTerms, hasAcceptedTerms) || other.hasAcceptedTerms == hasAcceptedTerms)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.potEligibleAt, potEligibleAt) || other.potEligibleAt == potEligibleAt)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy)&&(identical(other.currentVisitorId, currentVisitorId) || other.currentVisitorId == currentVisitorId)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.primaryDeviceId, primaryDeviceId) || other.primaryDeviceId == primaryDeviceId)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.kycTier, kycTier) || other.kycTier == kycTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,phoneNumber,status,isPotEligible,hasAcceptedTerms,hasCompletedOnboarding,createdAt,updatedAt,lastActiveAt,potEligibleAt,referralCode,referredBy,currentVisitorId,profile,riskScore,primaryDeviceId,riskLevel,lastLoginAt,kycTier]);

@override
String toString() {
  return 'User(id: $id, phoneNumber: $phoneNumber, status: $status, isPotEligible: $isPotEligible, hasAcceptedTerms: $hasAcceptedTerms, hasCompletedOnboarding: $hasCompletedOnboarding, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt, potEligibleAt: $potEligibleAt, referralCode: $referralCode, referredBy: $referredBy, currentVisitorId: $currentVisitorId, profile: $profile, riskScore: $riskScore, primaryDeviceId: $primaryDeviceId, riskLevel: $riskLevel, lastLoginAt: $lastLoginAt, kycTier: $kycTier)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, UserStatus status, bool isPotEligible, bool hasAcceptedTerms, bool hasCompletedOnboarding, DateTime createdAt, DateTime? updatedAt, DateTime? lastActiveAt, DateTime? potEligibleAt, String? referralCode, String? referredBy, String? currentVisitorId, UserProfile? profile, int? riskScore, String? primaryDeviceId, String? riskLevel, DateTime? lastLoginAt, String kycTier
});


$UserProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? status = null,Object? isPotEligible = null,Object? hasAcceptedTerms = null,Object? hasCompletedOnboarding = null,Object? createdAt = null,Object? updatedAt = freezed,Object? lastActiveAt = freezed,Object? potEligibleAt = freezed,Object? referralCode = freezed,Object? referredBy = freezed,Object? currentVisitorId = freezed,Object? profile = freezed,Object? riskScore = freezed,Object? primaryDeviceId = freezed,Object? riskLevel = freezed,Object? lastLoginAt = freezed,Object? kycTier = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,isPotEligible: null == isPotEligible ? _self.isPotEligible : isPotEligible // ignore: cast_nullable_to_non_nullable
as bool,hasAcceptedTerms: null == hasAcceptedTerms ? _self.hasAcceptedTerms : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,potEligibleAt: freezed == potEligibleAt ? _self.potEligibleAt : potEligibleAt // ignore: cast_nullable_to_non_nullable
as DateTime?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,currentVisitorId: freezed == currentVisitorId ? _self.currentVisitorId : currentVisitorId // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,riskScore: freezed == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int?,primaryDeviceId: freezed == primaryDeviceId ? _self.primaryDeviceId : primaryDeviceId // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,kycTier: null == kycTier ? _self.kycTier : kycTier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  UserStatus status,  bool isPotEligible,  bool hasAcceptedTerms,  bool hasCompletedOnboarding,  DateTime createdAt,  DateTime? updatedAt,  DateTime? lastActiveAt,  DateTime? potEligibleAt,  String? referralCode,  String? referredBy,  String? currentVisitorId,  UserProfile? profile,  int? riskScore,  String? primaryDeviceId,  String? riskLevel,  DateTime? lastLoginAt,  String kycTier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.status,_that.isPotEligible,_that.hasAcceptedTerms,_that.hasCompletedOnboarding,_that.createdAt,_that.updatedAt,_that.lastActiveAt,_that.potEligibleAt,_that.referralCode,_that.referredBy,_that.currentVisitorId,_that.profile,_that.riskScore,_that.primaryDeviceId,_that.riskLevel,_that.lastLoginAt,_that.kycTier);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  UserStatus status,  bool isPotEligible,  bool hasAcceptedTerms,  bool hasCompletedOnboarding,  DateTime createdAt,  DateTime? updatedAt,  DateTime? lastActiveAt,  DateTime? potEligibleAt,  String? referralCode,  String? referredBy,  String? currentVisitorId,  UserProfile? profile,  int? riskScore,  String? primaryDeviceId,  String? riskLevel,  DateTime? lastLoginAt,  String kycTier)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.phoneNumber,_that.status,_that.isPotEligible,_that.hasAcceptedTerms,_that.hasCompletedOnboarding,_that.createdAt,_that.updatedAt,_that.lastActiveAt,_that.potEligibleAt,_that.referralCode,_that.referredBy,_that.currentVisitorId,_that.profile,_that.riskScore,_that.primaryDeviceId,_that.riskLevel,_that.lastLoginAt,_that.kycTier);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  UserStatus status,  bool isPotEligible,  bool hasAcceptedTerms,  bool hasCompletedOnboarding,  DateTime createdAt,  DateTime? updatedAt,  DateTime? lastActiveAt,  DateTime? potEligibleAt,  String? referralCode,  String? referredBy,  String? currentVisitorId,  UserProfile? profile,  int? riskScore,  String? primaryDeviceId,  String? riskLevel,  DateTime? lastLoginAt,  String kycTier)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.status,_that.isPotEligible,_that.hasAcceptedTerms,_that.hasCompletedOnboarding,_that.createdAt,_that.updatedAt,_that.lastActiveAt,_that.potEligibleAt,_that.referralCode,_that.referredBy,_that.currentVisitorId,_that.profile,_that.riskScore,_that.primaryDeviceId,_that.riskLevel,_that.lastLoginAt,_that.kycTier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({required this.id, required this.phoneNumber, required this.status, required this.isPotEligible, required this.hasAcceptedTerms, required this.hasCompletedOnboarding, required this.createdAt, this.updatedAt, this.lastActiveAt, this.potEligibleAt, this.referralCode, this.referredBy, this.currentVisitorId, this.profile, this.riskScore, this.primaryDeviceId, this.riskLevel, this.lastLoginAt, this.kycTier = 'none'}): super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  UserStatus status;
@override final  bool isPotEligible;
@override final  bool hasAcceptedTerms;
@override final  bool hasCompletedOnboarding;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? lastActiveAt;
@override final  DateTime? potEligibleAt;
@override final  String? referralCode;
@override final  String? referredBy;
@override final  String? currentVisitorId;
@override final  UserProfile? profile;
@override final  int? riskScore;
@override final  String? primaryDeviceId;
@override final  String? riskLevel;
@override final  DateTime? lastLoginAt;
@override@JsonKey() final  String kycTier;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.isPotEligible, isPotEligible) || other.isPotEligible == isPotEligible)&&(identical(other.hasAcceptedTerms, hasAcceptedTerms) || other.hasAcceptedTerms == hasAcceptedTerms)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.potEligibleAt, potEligibleAt) || other.potEligibleAt == potEligibleAt)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy)&&(identical(other.currentVisitorId, currentVisitorId) || other.currentVisitorId == currentVisitorId)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.primaryDeviceId, primaryDeviceId) || other.primaryDeviceId == primaryDeviceId)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.kycTier, kycTier) || other.kycTier == kycTier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,phoneNumber,status,isPotEligible,hasAcceptedTerms,hasCompletedOnboarding,createdAt,updatedAt,lastActiveAt,potEligibleAt,referralCode,referredBy,currentVisitorId,profile,riskScore,primaryDeviceId,riskLevel,lastLoginAt,kycTier]);

@override
String toString() {
  return 'User(id: $id, phoneNumber: $phoneNumber, status: $status, isPotEligible: $isPotEligible, hasAcceptedTerms: $hasAcceptedTerms, hasCompletedOnboarding: $hasCompletedOnboarding, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt, potEligibleAt: $potEligibleAt, referralCode: $referralCode, referredBy: $referredBy, currentVisitorId: $currentVisitorId, profile: $profile, riskScore: $riskScore, primaryDeviceId: $primaryDeviceId, riskLevel: $riskLevel, lastLoginAt: $lastLoginAt, kycTier: $kycTier)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, UserStatus status, bool isPotEligible, bool hasAcceptedTerms, bool hasCompletedOnboarding, DateTime createdAt, DateTime? updatedAt, DateTime? lastActiveAt, DateTime? potEligibleAt, String? referralCode, String? referredBy, String? currentVisitorId, UserProfile? profile, int? riskScore, String? primaryDeviceId, String? riskLevel, DateTime? lastLoginAt, String kycTier
});


@override $UserProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? status = null,Object? isPotEligible = null,Object? hasAcceptedTerms = null,Object? hasCompletedOnboarding = null,Object? createdAt = null,Object? updatedAt = freezed,Object? lastActiveAt = freezed,Object? potEligibleAt = freezed,Object? referralCode = freezed,Object? referredBy = freezed,Object? currentVisitorId = freezed,Object? profile = freezed,Object? riskScore = freezed,Object? primaryDeviceId = freezed,Object? riskLevel = freezed,Object? lastLoginAt = freezed,Object? kycTier = null,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,isPotEligible: null == isPotEligible ? _self.isPotEligible : isPotEligible // ignore: cast_nullable_to_non_nullable
as bool,hasAcceptedTerms: null == hasAcceptedTerms ? _self.hasAcceptedTerms : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,potEligibleAt: freezed == potEligibleAt ? _self.potEligibleAt : potEligibleAt // ignore: cast_nullable_to_non_nullable
as DateTime?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,currentVisitorId: freezed == currentVisitorId ? _self.currentVisitorId : currentVisitorId // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,riskScore: freezed == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int?,primaryDeviceId: freezed == primaryDeviceId ? _self.primaryDeviceId : primaryDeviceId // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,kycTier: null == kycTier ? _self.kycTier : kycTier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
