// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get displayName; String? get username; String? get avatarUrl; String? get avatarColor; String? get gender; DateTime? get dateOfBirth; String? get province; String? get city; String? get firstName; String? get lastName;// Targeting fields
/// Preferred languages (e.g. ['en', 'zu'])
 List<String>? get languages;/// Interest categories (e.g. ['sports', 'tech'])
 List<String>? get interests;/// Regional clusters the user has opted into (for group buy matching)
 List<String>? get selectedClusters;// POPIA consent
/// Whether user has consented to receiving reward items
 bool get rewardConsent;// Privacy settings
/// User's privacy configuration (null = use defaults)
 PrivacySettings? get privacySettings;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.selectedClusters, selectedClusters)&&(identical(other.rewardConsent, rewardConsent) || other.rewardConsent == rewardConsent)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,username,avatarUrl,avatarColor,gender,dateOfBirth,province,city,firstName,lastName,const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(selectedClusters),rewardConsent,privacySettings);

@override
String toString() {
  return 'UserProfile(displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, gender: $gender, dateOfBirth: $dateOfBirth, province: $province, city: $city, firstName: $firstName, lastName: $lastName, languages: $languages, interests: $interests, selectedClusters: $selectedClusters, rewardConsent: $rewardConsent, privacySettings: $privacySettings)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String displayName, String? username, String? avatarUrl, String? avatarColor, String? gender, DateTime? dateOfBirth, String? province, String? city, String? firstName, String? lastName, List<String>? languages, List<String>? interests, List<String>? selectedClusters, bool rewardConsent, PrivacySettings? privacySettings
});


$PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? province = freezed,Object? city = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? languages = freezed,Object? interests = freezed,Object? selectedClusters = freezed,Object? rewardConsent = null,Object? privacySettings = freezed,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
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
as List<String>?,rewardConsent: null == rewardConsent ? _self.rewardConsent : rewardConsent // ignore: cast_nullable_to_non_nullable
as bool,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,
  ));
}
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<$Res>? get privacySettings {
    if (_self.privacySettings == null) {
    return null;
  }

  return $PrivacySettingsCopyWith<$Res>(_self.privacySettings!, (value) {
    return _then(_self.copyWith(privacySettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String? gender,  DateTime? dateOfBirth,  String? province,  String? city,  String? firstName,  String? lastName,  List<String>? languages,  List<String>? interests,  List<String>? selectedClusters,  bool rewardConsent,  PrivacySettings? privacySettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.gender,_that.dateOfBirth,_that.province,_that.city,_that.firstName,_that.lastName,_that.languages,_that.interests,_that.selectedClusters,_that.rewardConsent,_that.privacySettings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String? gender,  DateTime? dateOfBirth,  String? province,  String? city,  String? firstName,  String? lastName,  List<String>? languages,  List<String>? interests,  List<String>? selectedClusters,  bool rewardConsent,  PrivacySettings? privacySettings)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.gender,_that.dateOfBirth,_that.province,_that.city,_that.firstName,_that.lastName,_that.languages,_that.interests,_that.selectedClusters,_that.rewardConsent,_that.privacySettings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String? gender,  DateTime? dateOfBirth,  String? province,  String? city,  String? firstName,  String? lastName,  List<String>? languages,  List<String>? interests,  List<String>? selectedClusters,  bool rewardConsent,  PrivacySettings? privacySettings)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.gender,_that.dateOfBirth,_that.province,_that.city,_that.firstName,_that.lastName,_that.languages,_that.interests,_that.selectedClusters,_that.rewardConsent,_that.privacySettings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile extends UserProfile {
  const _UserProfile({required this.displayName, this.username, this.avatarUrl, this.avatarColor, this.gender, this.dateOfBirth, this.province, this.city, this.firstName, this.lastName, final  List<String>? languages, final  List<String>? interests, final  List<String>? selectedClusters, this.rewardConsent = false, this.privacySettings}): _languages = languages,_interests = interests,_selectedClusters = selectedClusters,super._();
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String displayName;
@override final  String? username;
@override final  String? avatarUrl;
@override final  String? avatarColor;
@override final  String? gender;
@override final  DateTime? dateOfBirth;
@override final  String? province;
@override final  String? city;
@override final  String? firstName;
@override final  String? lastName;
// Targeting fields
/// Preferred languages (e.g. ['en', 'zu'])
 final  List<String>? _languages;
// Targeting fields
/// Preferred languages (e.g. ['en', 'zu'])
@override List<String>? get languages {
  final value = _languages;
  if (value == null) return null;
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Interest categories (e.g. ['sports', 'tech'])
 final  List<String>? _interests;
/// Interest categories (e.g. ['sports', 'tech'])
@override List<String>? get interests {
  final value = _interests;
  if (value == null) return null;
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Regional clusters the user has opted into (for group buy matching)
 final  List<String>? _selectedClusters;
/// Regional clusters the user has opted into (for group buy matching)
@override List<String>? get selectedClusters {
  final value = _selectedClusters;
  if (value == null) return null;
  if (_selectedClusters is EqualUnmodifiableListView) return _selectedClusters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// POPIA consent
/// Whether user has consented to receiving reward items
@override@JsonKey() final  bool rewardConsent;
// Privacy settings
/// User's privacy configuration (null = use defaults)
@override final  PrivacySettings? privacySettings;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other._languages, _languages)&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._selectedClusters, _selectedClusters)&&(identical(other.rewardConsent, rewardConsent) || other.rewardConsent == rewardConsent)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,username,avatarUrl,avatarColor,gender,dateOfBirth,province,city,firstName,lastName,const DeepCollectionEquality().hash(_languages),const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_selectedClusters),rewardConsent,privacySettings);

@override
String toString() {
  return 'UserProfile(displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, gender: $gender, dateOfBirth: $dateOfBirth, province: $province, city: $city, firstName: $firstName, lastName: $lastName, languages: $languages, interests: $interests, selectedClusters: $selectedClusters, rewardConsent: $rewardConsent, privacySettings: $privacySettings)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String? username, String? avatarUrl, String? avatarColor, String? gender, DateTime? dateOfBirth, String? province, String? city, String? firstName, String? lastName, List<String>? languages, List<String>? interests, List<String>? selectedClusters, bool rewardConsent, PrivacySettings? privacySettings
});


@override $PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? province = freezed,Object? city = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? languages = freezed,Object? interests = freezed,Object? selectedClusters = freezed,Object? rewardConsent = null,Object? privacySettings = freezed,}) {
  return _then(_UserProfile(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
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
as List<String>?,rewardConsent: null == rewardConsent ? _self.rewardConsent : rewardConsent // ignore: cast_nullable_to_non_nullable
as bool,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,
  ));
}

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<$Res>? get privacySettings {
    if (_self.privacySettings == null) {
    return null;
  }

  return $PrivacySettingsCopyWith<$Res>(_self.privacySettings!, (value) {
    return _then(_self.copyWith(privacySettings: value));
  });
}
}

// dart format on
