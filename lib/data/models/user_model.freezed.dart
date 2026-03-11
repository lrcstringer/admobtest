// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get userId; String get phoneNumber; String get displayName; String? get displayNameLower; String? get username; String? get usernameLower; String? get avatarUrl; String? get avatarColor; String? get gender; DateTime? get dateOfBirth; String? get province; String? get city; String? get firstName; String? get lastName;// Targeting fields
 List<String>? get languages; List<String>? get interests; List<String>? get selectedClusters; UserStatus get status; String? get referralCode; String? get referredBy; bool get hasAcceptedTerms; bool get hasCompletedOnboarding; bool get isPotEligible; DateTime? get potEligibleAt; String? get fcmToken; int? get riskScore; String? get primaryDeviceId; String? get riskLevel; DateTime? get lastLoginAt; String get kycTier;// Privacy settings (nested map from Firestore)
 PrivacySettings? get privacy; DateTime get createdAt; DateTime? get updatedAt; DateTime? get lastActiveAt;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.displayNameLower, displayNameLower) || other.displayNameLower == displayNameLower)&&(identical(other.username, username) || other.username == username)&&(identical(other.usernameLower, usernameLower) || other.usernameLower == usernameLower)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.selectedClusters, selectedClusters)&&(identical(other.status, status) || other.status == status)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy)&&(identical(other.hasAcceptedTerms, hasAcceptedTerms) || other.hasAcceptedTerms == hasAcceptedTerms)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.isPotEligible, isPotEligible) || other.isPotEligible == isPotEligible)&&(identical(other.potEligibleAt, potEligibleAt) || other.potEligibleAt == potEligibleAt)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.primaryDeviceId, primaryDeviceId) || other.primaryDeviceId == primaryDeviceId)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.kycTier, kycTier) || other.kycTier == kycTier)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,phoneNumber,displayName,displayNameLower,username,usernameLower,avatarUrl,avatarColor,gender,dateOfBirth,province,city,firstName,lastName,const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(selectedClusters),status,referralCode,referredBy,hasAcceptedTerms,hasCompletedOnboarding,isPotEligible,potEligibleAt,fcmToken,riskScore,primaryDeviceId,riskLevel,lastLoginAt,kycTier,privacy,createdAt,updatedAt,lastActiveAt]);

@override
String toString() {
  return 'UserModel(userId: $userId, phoneNumber: $phoneNumber, displayName: $displayName, displayNameLower: $displayNameLower, username: $username, usernameLower: $usernameLower, avatarUrl: $avatarUrl, avatarColor: $avatarColor, gender: $gender, dateOfBirth: $dateOfBirth, province: $province, city: $city, firstName: $firstName, lastName: $lastName, languages: $languages, interests: $interests, selectedClusters: $selectedClusters, status: $status, referralCode: $referralCode, referredBy: $referredBy, hasAcceptedTerms: $hasAcceptedTerms, hasCompletedOnboarding: $hasCompletedOnboarding, isPotEligible: $isPotEligible, potEligibleAt: $potEligibleAt, fcmToken: $fcmToken, riskScore: $riskScore, primaryDeviceId: $primaryDeviceId, riskLevel: $riskLevel, lastLoginAt: $lastLoginAt, kycTier: $kycTier, privacy: $privacy, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String userId, String phoneNumber, String displayName, String? displayNameLower, String? username, String? usernameLower, String? avatarUrl, String? avatarColor, String? gender, DateTime? dateOfBirth, String? province, String? city, String? firstName, String? lastName, List<String>? languages, List<String>? interests, List<String>? selectedClusters, UserStatus status, String? referralCode, String? referredBy, bool hasAcceptedTerms, bool hasCompletedOnboarding, bool isPotEligible, DateTime? potEligibleAt, String? fcmToken, int? riskScore, String? primaryDeviceId, String? riskLevel, DateTime? lastLoginAt, String kycTier, PrivacySettings? privacy, DateTime createdAt, DateTime? updatedAt, DateTime? lastActiveAt
});


$PrivacySettingsCopyWith<$Res>? get privacy;

}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? phoneNumber = null,Object? displayName = null,Object? displayNameLower = freezed,Object? username = freezed,Object? usernameLower = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? province = freezed,Object? city = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? languages = freezed,Object? interests = freezed,Object? selectedClusters = freezed,Object? status = null,Object? referralCode = freezed,Object? referredBy = freezed,Object? hasAcceptedTerms = null,Object? hasCompletedOnboarding = null,Object? isPotEligible = null,Object? potEligibleAt = freezed,Object? fcmToken = freezed,Object? riskScore = freezed,Object? primaryDeviceId = freezed,Object? riskLevel = freezed,Object? lastLoginAt = freezed,Object? kycTier = null,Object? privacy = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? lastActiveAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,displayNameLower: freezed == displayNameLower ? _self.displayNameLower : displayNameLower // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,usernameLower: freezed == usernameLower ? _self.usernameLower : usernameLower // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,selectedClusters: freezed == selectedClusters ? _self.selectedClusters : selectedClusters // ignore: cast_nullable_to_non_nullable
as List<String>?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,hasAcceptedTerms: null == hasAcceptedTerms ? _self.hasAcceptedTerms : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,isPotEligible: null == isPotEligible ? _self.isPotEligible : isPotEligible // ignore: cast_nullable_to_non_nullable
as bool,potEligibleAt: freezed == potEligibleAt ? _self.potEligibleAt : potEligibleAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,riskScore: freezed == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int?,primaryDeviceId: freezed == primaryDeviceId ? _self.primaryDeviceId : primaryDeviceId // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,kycTier: null == kycTier ? _self.kycTier : kycTier // ignore: cast_nullable_to_non_nullable
as String,privacy: freezed == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<$Res>? get privacy {
    if (_self.privacy == null) {
    return null;
  }

  return $PrivacySettingsCopyWith<$Res>(_self.privacy!, (value) {
    return _then(_self.copyWith(privacy: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String phoneNumber,  String displayName,  String? displayNameLower,  String? username,  String? usernameLower,  String? avatarUrl,  String? avatarColor,  String? gender,  DateTime? dateOfBirth,  String? province,  String? city,  String? firstName,  String? lastName,  List<String>? languages,  List<String>? interests,  List<String>? selectedClusters,  UserStatus status,  String? referralCode,  String? referredBy,  bool hasAcceptedTerms,  bool hasCompletedOnboarding,  bool isPotEligible,  DateTime? potEligibleAt,  String? fcmToken,  int? riskScore,  String? primaryDeviceId,  String? riskLevel,  DateTime? lastLoginAt,  String kycTier,  PrivacySettings? privacy,  DateTime createdAt,  DateTime? updatedAt,  DateTime? lastActiveAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.userId,_that.phoneNumber,_that.displayName,_that.displayNameLower,_that.username,_that.usernameLower,_that.avatarUrl,_that.avatarColor,_that.gender,_that.dateOfBirth,_that.province,_that.city,_that.firstName,_that.lastName,_that.languages,_that.interests,_that.selectedClusters,_that.status,_that.referralCode,_that.referredBy,_that.hasAcceptedTerms,_that.hasCompletedOnboarding,_that.isPotEligible,_that.potEligibleAt,_that.fcmToken,_that.riskScore,_that.primaryDeviceId,_that.riskLevel,_that.lastLoginAt,_that.kycTier,_that.privacy,_that.createdAt,_that.updatedAt,_that.lastActiveAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String phoneNumber,  String displayName,  String? displayNameLower,  String? username,  String? usernameLower,  String? avatarUrl,  String? avatarColor,  String? gender,  DateTime? dateOfBirth,  String? province,  String? city,  String? firstName,  String? lastName,  List<String>? languages,  List<String>? interests,  List<String>? selectedClusters,  UserStatus status,  String? referralCode,  String? referredBy,  bool hasAcceptedTerms,  bool hasCompletedOnboarding,  bool isPotEligible,  DateTime? potEligibleAt,  String? fcmToken,  int? riskScore,  String? primaryDeviceId,  String? riskLevel,  DateTime? lastLoginAt,  String kycTier,  PrivacySettings? privacy,  DateTime createdAt,  DateTime? updatedAt,  DateTime? lastActiveAt)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.userId,_that.phoneNumber,_that.displayName,_that.displayNameLower,_that.username,_that.usernameLower,_that.avatarUrl,_that.avatarColor,_that.gender,_that.dateOfBirth,_that.province,_that.city,_that.firstName,_that.lastName,_that.languages,_that.interests,_that.selectedClusters,_that.status,_that.referralCode,_that.referredBy,_that.hasAcceptedTerms,_that.hasCompletedOnboarding,_that.isPotEligible,_that.potEligibleAt,_that.fcmToken,_that.riskScore,_that.primaryDeviceId,_that.riskLevel,_that.lastLoginAt,_that.kycTier,_that.privacy,_that.createdAt,_that.updatedAt,_that.lastActiveAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String phoneNumber,  String displayName,  String? displayNameLower,  String? username,  String? usernameLower,  String? avatarUrl,  String? avatarColor,  String? gender,  DateTime? dateOfBirth,  String? province,  String? city,  String? firstName,  String? lastName,  List<String>? languages,  List<String>? interests,  List<String>? selectedClusters,  UserStatus status,  String? referralCode,  String? referredBy,  bool hasAcceptedTerms,  bool hasCompletedOnboarding,  bool isPotEligible,  DateTime? potEligibleAt,  String? fcmToken,  int? riskScore,  String? primaryDeviceId,  String? riskLevel,  DateTime? lastLoginAt,  String kycTier,  PrivacySettings? privacy,  DateTime createdAt,  DateTime? updatedAt,  DateTime? lastActiveAt)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.userId,_that.phoneNumber,_that.displayName,_that.displayNameLower,_that.username,_that.usernameLower,_that.avatarUrl,_that.avatarColor,_that.gender,_that.dateOfBirth,_that.province,_that.city,_that.firstName,_that.lastName,_that.languages,_that.interests,_that.selectedClusters,_that.status,_that.referralCode,_that.referredBy,_that.hasAcceptedTerms,_that.hasCompletedOnboarding,_that.isPotEligible,_that.potEligibleAt,_that.fcmToken,_that.riskScore,_that.primaryDeviceId,_that.riskLevel,_that.lastLoginAt,_that.kycTier,_that.privacy,_that.createdAt,_that.updatedAt,_that.lastActiveAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
  const _UserModel({required this.userId, required this.phoneNumber, required this.displayName, this.displayNameLower, this.username, this.usernameLower, this.avatarUrl, this.avatarColor, this.gender, this.dateOfBirth, this.province, this.city, this.firstName, this.lastName, final  List<String>? languages, final  List<String>? interests, final  List<String>? selectedClusters, required this.status, this.referralCode, this.referredBy, required this.hasAcceptedTerms, required this.hasCompletedOnboarding, required this.isPotEligible, this.potEligibleAt, this.fcmToken, this.riskScore, this.primaryDeviceId, this.riskLevel, this.lastLoginAt, this.kycTier = 'none', this.privacy, required this.createdAt, this.updatedAt, this.lastActiveAt}): _languages = languages,_interests = interests,_selectedClusters = selectedClusters,super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String userId;
@override final  String phoneNumber;
@override final  String displayName;
@override final  String? displayNameLower;
@override final  String? username;
@override final  String? usernameLower;
@override final  String? avatarUrl;
@override final  String? avatarColor;
@override final  String? gender;
@override final  DateTime? dateOfBirth;
@override final  String? province;
@override final  String? city;
@override final  String? firstName;
@override final  String? lastName;
// Targeting fields
 final  List<String>? _languages;
// Targeting fields
@override List<String>? get languages {
  final value = _languages;
  if (value == null) return null;
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _interests;
@override List<String>? get interests {
  final value = _interests;
  if (value == null) return null;
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _selectedClusters;
@override List<String>? get selectedClusters {
  final value = _selectedClusters;
  if (value == null) return null;
  if (_selectedClusters is EqualUnmodifiableListView) return _selectedClusters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  UserStatus status;
@override final  String? referralCode;
@override final  String? referredBy;
@override final  bool hasAcceptedTerms;
@override final  bool hasCompletedOnboarding;
@override final  bool isPotEligible;
@override final  DateTime? potEligibleAt;
@override final  String? fcmToken;
@override final  int? riskScore;
@override final  String? primaryDeviceId;
@override final  String? riskLevel;
@override final  DateTime? lastLoginAt;
@override@JsonKey() final  String kycTier;
// Privacy settings (nested map from Firestore)
@override final  PrivacySettings? privacy;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? lastActiveAt;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.displayNameLower, displayNameLower) || other.displayNameLower == displayNameLower)&&(identical(other.username, username) || other.username == username)&&(identical(other.usernameLower, usernameLower) || other.usernameLower == usernameLower)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._selectedClusters, _selectedClusters)&&(identical(other.status, status) || other.status == status)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy)&&(identical(other.hasAcceptedTerms, hasAcceptedTerms) || other.hasAcceptedTerms == hasAcceptedTerms)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.isPotEligible, isPotEligible) || other.isPotEligible == isPotEligible)&&(identical(other.potEligibleAt, potEligibleAt) || other.potEligibleAt == potEligibleAt)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.primaryDeviceId, primaryDeviceId) || other.primaryDeviceId == primaryDeviceId)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.kycTier, kycTier) || other.kycTier == kycTier)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,phoneNumber,displayName,displayNameLower,username,usernameLower,avatarUrl,avatarColor,gender,dateOfBirth,province,city,firstName,lastName,const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_selectedClusters),status,referralCode,referredBy,hasAcceptedTerms,hasCompletedOnboarding,isPotEligible,potEligibleAt,fcmToken,riskScore,primaryDeviceId,riskLevel,lastLoginAt,kycTier,privacy,createdAt,updatedAt,lastActiveAt]);

@override
String toString() {
  return 'UserModel(userId: $userId, phoneNumber: $phoneNumber, displayName: $displayName, displayNameLower: $displayNameLower, username: $username, usernameLower: $usernameLower, avatarUrl: $avatarUrl, avatarColor: $avatarColor, gender: $gender, dateOfBirth: $dateOfBirth, province: $province, city: $city, firstName: $firstName, lastName: $lastName, languages: $languages, interests: $interests, selectedClusters: $selectedClusters, status: $status, referralCode: $referralCode, referredBy: $referredBy, hasAcceptedTerms: $hasAcceptedTerms, hasCompletedOnboarding: $hasCompletedOnboarding, isPotEligible: $isPotEligible, potEligibleAt: $potEligibleAt, fcmToken: $fcmToken, riskScore: $riskScore, primaryDeviceId: $primaryDeviceId, riskLevel: $riskLevel, lastLoginAt: $lastLoginAt, kycTier: $kycTier, privacy: $privacy, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String phoneNumber, String displayName, String? displayNameLower, String? username, String? usernameLower, String? avatarUrl, String? avatarColor, String? gender, DateTime? dateOfBirth, String? province, String? city, String? firstName, String? lastName, List<String>? languages, List<String>? interests, List<String>? selectedClusters, UserStatus status, String? referralCode, String? referredBy, bool hasAcceptedTerms, bool hasCompletedOnboarding, bool isPotEligible, DateTime? potEligibleAt, String? fcmToken, int? riskScore, String? primaryDeviceId, String? riskLevel, DateTime? lastLoginAt, String kycTier, PrivacySettings? privacy, DateTime createdAt, DateTime? updatedAt, DateTime? lastActiveAt
});


@override $PrivacySettingsCopyWith<$Res>? get privacy;

}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? phoneNumber = null,Object? displayName = null,Object? displayNameLower = freezed,Object? username = freezed,Object? usernameLower = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? province = freezed,Object? city = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? languages = freezed,Object? interests = freezed,Object? selectedClusters = freezed,Object? status = null,Object? referralCode = freezed,Object? referredBy = freezed,Object? hasAcceptedTerms = null,Object? hasCompletedOnboarding = null,Object? isPotEligible = null,Object? potEligibleAt = freezed,Object? fcmToken = freezed,Object? riskScore = freezed,Object? primaryDeviceId = freezed,Object? riskLevel = freezed,Object? lastLoginAt = freezed,Object? kycTier = null,Object? privacy = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? lastActiveAt = freezed,}) {
  return _then(_UserModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,displayNameLower: freezed == displayNameLower ? _self.displayNameLower : displayNameLower // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,usernameLower: freezed == usernameLower ? _self.usernameLower : usernameLower // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,interests: freezed == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,selectedClusters: freezed == selectedClusters ? _self._selectedClusters : selectedClusters // ignore: cast_nullable_to_non_nullable
as List<String>?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,hasAcceptedTerms: null == hasAcceptedTerms ? _self.hasAcceptedTerms : hasAcceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,isPotEligible: null == isPotEligible ? _self.isPotEligible : isPotEligible // ignore: cast_nullable_to_non_nullable
as bool,potEligibleAt: freezed == potEligibleAt ? _self.potEligibleAt : potEligibleAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,riskScore: freezed == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int?,primaryDeviceId: freezed == primaryDeviceId ? _self.primaryDeviceId : primaryDeviceId // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,kycTier: null == kycTier ? _self.kycTier : kycTier // ignore: cast_nullable_to_non_nullable
as String,privacy: freezed == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<$Res>? get privacy {
    if (_self.privacy == null) {
    return null;
  }

  return $PrivacySettingsCopyWith<$Res>(_self.privacy!, (value) {
    return _then(_self.copyWith(privacy: value));
  });
}
}

// dart format on
