// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadProfile value)?  loadProfile,TResult Function( _WatchProfile value)?  watchProfile,TResult Function( _UserUpdated value)?  userUpdated,TResult Function( _UpdateProfile value)?  updateProfile,TResult Function( _UpdateUsername value)?  updateUsername,TResult Function( _CheckUsername value)?  checkUsername,TResult Function( _AcceptTerms value)?  acceptTerms,TResult Function( _UpdatePrivacySetting value)?  updatePrivacySetting,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadProfile() when loadProfile != null:
return loadProfile(_that);case _WatchProfile() when watchProfile != null:
return watchProfile(_that);case _UserUpdated() when userUpdated != null:
return userUpdated(_that);case _UpdateProfile() when updateProfile != null:
return updateProfile(_that);case _UpdateUsername() when updateUsername != null:
return updateUsername(_that);case _CheckUsername() when checkUsername != null:
return checkUsername(_that);case _AcceptTerms() when acceptTerms != null:
return acceptTerms(_that);case _UpdatePrivacySetting() when updatePrivacySetting != null:
return updatePrivacySetting(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadProfile value)  loadProfile,required TResult Function( _WatchProfile value)  watchProfile,required TResult Function( _UserUpdated value)  userUpdated,required TResult Function( _UpdateProfile value)  updateProfile,required TResult Function( _UpdateUsername value)  updateUsername,required TResult Function( _CheckUsername value)  checkUsername,required TResult Function( _AcceptTerms value)  acceptTerms,required TResult Function( _UpdatePrivacySetting value)  updatePrivacySetting,}){
final _that = this;
switch (_that) {
case _LoadProfile():
return loadProfile(_that);case _WatchProfile():
return watchProfile(_that);case _UserUpdated():
return userUpdated(_that);case _UpdateProfile():
return updateProfile(_that);case _UpdateUsername():
return updateUsername(_that);case _CheckUsername():
return checkUsername(_that);case _AcceptTerms():
return acceptTerms(_that);case _UpdatePrivacySetting():
return updatePrivacySetting(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadProfile value)?  loadProfile,TResult? Function( _WatchProfile value)?  watchProfile,TResult? Function( _UserUpdated value)?  userUpdated,TResult? Function( _UpdateProfile value)?  updateProfile,TResult? Function( _UpdateUsername value)?  updateUsername,TResult? Function( _CheckUsername value)?  checkUsername,TResult? Function( _AcceptTerms value)?  acceptTerms,TResult? Function( _UpdatePrivacySetting value)?  updatePrivacySetting,}){
final _that = this;
switch (_that) {
case _LoadProfile() when loadProfile != null:
return loadProfile(_that);case _WatchProfile() when watchProfile != null:
return watchProfile(_that);case _UserUpdated() when userUpdated != null:
return userUpdated(_that);case _UpdateProfile() when updateProfile != null:
return updateProfile(_that);case _UpdateUsername() when updateUsername != null:
return updateUsername(_that);case _CheckUsername() when checkUsername != null:
return checkUsername(_that);case _AcceptTerms() when acceptTerms != null:
return acceptTerms(_that);case _UpdatePrivacySetting() when updatePrivacySetting != null:
return updatePrivacySetting(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadProfile,TResult Function()?  watchProfile,TResult Function( User user)?  userUpdated,TResult Function( String? displayName,  String? firstName,  String? lastName,  String? gender,  DateTime? dateOfBirth,  String? province,  String? avatarUrl,  List<String>? selectedClusters)?  updateProfile,TResult Function( String username)?  updateUsername,TResult Function( String username)?  checkUsername,TResult Function()?  acceptTerms,TResult Function( String key,  dynamic value)?  updatePrivacySetting,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadProfile() when loadProfile != null:
return loadProfile();case _WatchProfile() when watchProfile != null:
return watchProfile();case _UserUpdated() when userUpdated != null:
return userUpdated(_that.user);case _UpdateProfile() when updateProfile != null:
return updateProfile(_that.displayName,_that.firstName,_that.lastName,_that.gender,_that.dateOfBirth,_that.province,_that.avatarUrl,_that.selectedClusters);case _UpdateUsername() when updateUsername != null:
return updateUsername(_that.username);case _CheckUsername() when checkUsername != null:
return checkUsername(_that.username);case _AcceptTerms() when acceptTerms != null:
return acceptTerms();case _UpdatePrivacySetting() when updatePrivacySetting != null:
return updatePrivacySetting(_that.key,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadProfile,required TResult Function()  watchProfile,required TResult Function( User user)  userUpdated,required TResult Function( String? displayName,  String? firstName,  String? lastName,  String? gender,  DateTime? dateOfBirth,  String? province,  String? avatarUrl,  List<String>? selectedClusters)  updateProfile,required TResult Function( String username)  updateUsername,required TResult Function( String username)  checkUsername,required TResult Function()  acceptTerms,required TResult Function( String key,  dynamic value)  updatePrivacySetting,}) {final _that = this;
switch (_that) {
case _LoadProfile():
return loadProfile();case _WatchProfile():
return watchProfile();case _UserUpdated():
return userUpdated(_that.user);case _UpdateProfile():
return updateProfile(_that.displayName,_that.firstName,_that.lastName,_that.gender,_that.dateOfBirth,_that.province,_that.avatarUrl,_that.selectedClusters);case _UpdateUsername():
return updateUsername(_that.username);case _CheckUsername():
return checkUsername(_that.username);case _AcceptTerms():
return acceptTerms();case _UpdatePrivacySetting():
return updatePrivacySetting(_that.key,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadProfile,TResult? Function()?  watchProfile,TResult? Function( User user)?  userUpdated,TResult? Function( String? displayName,  String? firstName,  String? lastName,  String? gender,  DateTime? dateOfBirth,  String? province,  String? avatarUrl,  List<String>? selectedClusters)?  updateProfile,TResult? Function( String username)?  updateUsername,TResult? Function( String username)?  checkUsername,TResult? Function()?  acceptTerms,TResult? Function( String key,  dynamic value)?  updatePrivacySetting,}) {final _that = this;
switch (_that) {
case _LoadProfile() when loadProfile != null:
return loadProfile();case _WatchProfile() when watchProfile != null:
return watchProfile();case _UserUpdated() when userUpdated != null:
return userUpdated(_that.user);case _UpdateProfile() when updateProfile != null:
return updateProfile(_that.displayName,_that.firstName,_that.lastName,_that.gender,_that.dateOfBirth,_that.province,_that.avatarUrl,_that.selectedClusters);case _UpdateUsername() when updateUsername != null:
return updateUsername(_that.username);case _CheckUsername() when checkUsername != null:
return checkUsername(_that.username);case _AcceptTerms() when acceptTerms != null:
return acceptTerms();case _UpdatePrivacySetting() when updatePrivacySetting != null:
return updatePrivacySetting(_that.key,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _LoadProfile implements ProfileEvent {
  const _LoadProfile();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.loadProfile()';
}


}




/// @nodoc


class _WatchProfile implements ProfileEvent {
  const _WatchProfile();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.watchProfile()';
}


}




/// @nodoc


class _UserUpdated implements ProfileEvent {
  const _UserUpdated(this.user);
  

 final  User user;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserUpdatedCopyWith<_UserUpdated> get copyWith => __$UserUpdatedCopyWithImpl<_UserUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserUpdated&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'ProfileEvent.userUpdated(user: $user)';
}


}

/// @nodoc
abstract mixin class _$UserUpdatedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$UserUpdatedCopyWith(_UserUpdated value, $Res Function(_UserUpdated) _then) = __$UserUpdatedCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class __$UserUpdatedCopyWithImpl<$Res>
    implements _$UserUpdatedCopyWith<$Res> {
  __$UserUpdatedCopyWithImpl(this._self, this._then);

  final _UserUpdated _self;
  final $Res Function(_UserUpdated) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_UserUpdated(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _UpdateProfile implements ProfileEvent {
  const _UpdateProfile({this.displayName, this.firstName, this.lastName, this.gender, this.dateOfBirth, this.province, this.avatarUrl, final  List<String>? selectedClusters}): _selectedClusters = selectedClusters;
  

 final  String? displayName;
 final  String? firstName;
 final  String? lastName;
 final  String? gender;
 final  DateTime? dateOfBirth;
 final  String? province;
 final  String? avatarUrl;
 final  List<String>? _selectedClusters;
 List<String>? get selectedClusters {
  final value = _selectedClusters;
  if (value == null) return null;
  if (_selectedClusters is EqualUnmodifiableListView) return _selectedClusters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProfileCopyWith<_UpdateProfile> get copyWith => __$UpdateProfileCopyWithImpl<_UpdateProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProfile&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.province, province) || other.province == province)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&const DeepCollectionEquality().equals(other._selectedClusters, _selectedClusters));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,firstName,lastName,gender,dateOfBirth,province,avatarUrl,const DeepCollectionEquality().hash(_selectedClusters));

@override
String toString() {
  return 'ProfileEvent.updateProfile(displayName: $displayName, firstName: $firstName, lastName: $lastName, gender: $gender, dateOfBirth: $dateOfBirth, province: $province, avatarUrl: $avatarUrl, selectedClusters: $selectedClusters)';
}


}

/// @nodoc
abstract mixin class _$UpdateProfileCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$UpdateProfileCopyWith(_UpdateProfile value, $Res Function(_UpdateProfile) _then) = __$UpdateProfileCopyWithImpl;
@useResult
$Res call({
 String? displayName, String? firstName, String? lastName, String? gender, DateTime? dateOfBirth, String? province, String? avatarUrl, List<String>? selectedClusters
});




}
/// @nodoc
class __$UpdateProfileCopyWithImpl<$Res>
    implements _$UpdateProfileCopyWith<$Res> {
  __$UpdateProfileCopyWithImpl(this._self, this._then);

  final _UpdateProfile _self;
  final $Res Function(_UpdateProfile) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? province = freezed,Object? avatarUrl = freezed,Object? selectedClusters = freezed,}) {
  return _then(_UpdateProfile(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,selectedClusters: freezed == selectedClusters ? _self._selectedClusters : selectedClusters // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc


class _UpdateUsername implements ProfileEvent {
  const _UpdateUsername(this.username);
  

 final  String username;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUsernameCopyWith<_UpdateUsername> get copyWith => __$UpdateUsernameCopyWithImpl<_UpdateUsername>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUsername&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'ProfileEvent.updateUsername(username: $username)';
}


}

/// @nodoc
abstract mixin class _$UpdateUsernameCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$UpdateUsernameCopyWith(_UpdateUsername value, $Res Function(_UpdateUsername) _then) = __$UpdateUsernameCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class __$UpdateUsernameCopyWithImpl<$Res>
    implements _$UpdateUsernameCopyWith<$Res> {
  __$UpdateUsernameCopyWithImpl(this._self, this._then);

  final _UpdateUsername _self;
  final $Res Function(_UpdateUsername) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_UpdateUsername(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CheckUsername implements ProfileEvent {
  const _CheckUsername(this.username);
  

 final  String username;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckUsernameCopyWith<_CheckUsername> get copyWith => __$CheckUsernameCopyWithImpl<_CheckUsername>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckUsername&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'ProfileEvent.checkUsername(username: $username)';
}


}

/// @nodoc
abstract mixin class _$CheckUsernameCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$CheckUsernameCopyWith(_CheckUsername value, $Res Function(_CheckUsername) _then) = __$CheckUsernameCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class __$CheckUsernameCopyWithImpl<$Res>
    implements _$CheckUsernameCopyWith<$Res> {
  __$CheckUsernameCopyWithImpl(this._self, this._then);

  final _CheckUsername _self;
  final $Res Function(_CheckUsername) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_CheckUsername(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AcceptTerms implements ProfileEvent {
  const _AcceptTerms();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptTerms);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.acceptTerms()';
}


}




/// @nodoc


class _UpdatePrivacySetting implements ProfileEvent {
  const _UpdatePrivacySetting({required this.key, required this.value});
  

 final  String key;
 final  dynamic value;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePrivacySettingCopyWith<_UpdatePrivacySetting> get copyWith => __$UpdatePrivacySettingCopyWithImpl<_UpdatePrivacySetting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePrivacySetting&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'ProfileEvent.updatePrivacySetting(key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class _$UpdatePrivacySettingCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$UpdatePrivacySettingCopyWith(_UpdatePrivacySetting value, $Res Function(_UpdatePrivacySetting) _then) = __$UpdatePrivacySettingCopyWithImpl;
@useResult
$Res call({
 String key, dynamic value
});




}
/// @nodoc
class __$UpdatePrivacySettingCopyWithImpl<$Res>
    implements _$UpdatePrivacySettingCopyWith<$Res> {
  __$UpdatePrivacySettingCopyWithImpl(this._self, this._then);

  final _UpdatePrivacySetting _self;
  final $Res Function(_UpdatePrivacySetting) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? key = null,Object? value = freezed,}) {
  return _then(_UpdatePrivacySetting(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc
mixin _$ProfileState {

 ProfileStatus get status; User? get user; int get lifetimeEarned; int get lifetimeWithdrawn; bool get isUpdating; bool get isCheckingUsername; bool? get usernameAvailable; bool get updateSuccess; String? get updateError; String? get errorMessage;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.lifetimeEarned, lifetimeEarned) || other.lifetimeEarned == lifetimeEarned)&&(identical(other.lifetimeWithdrawn, lifetimeWithdrawn) || other.lifetimeWithdrawn == lifetimeWithdrawn)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.isCheckingUsername, isCheckingUsername) || other.isCheckingUsername == isCheckingUsername)&&(identical(other.usernameAvailable, usernameAvailable) || other.usernameAvailable == usernameAvailable)&&(identical(other.updateSuccess, updateSuccess) || other.updateSuccess == updateSuccess)&&(identical(other.updateError, updateError) || other.updateError == updateError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,lifetimeEarned,lifetimeWithdrawn,isUpdating,isCheckingUsername,usernameAvailable,updateSuccess,updateError,errorMessage);

@override
String toString() {
  return 'ProfileState(status: $status, user: $user, lifetimeEarned: $lifetimeEarned, lifetimeWithdrawn: $lifetimeWithdrawn, isUpdating: $isUpdating, isCheckingUsername: $isCheckingUsername, usernameAvailable: $usernameAvailable, updateSuccess: $updateSuccess, updateError: $updateError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 ProfileStatus status, User? user, int lifetimeEarned, int lifetimeWithdrawn, bool isUpdating, bool isCheckingUsername, bool? usernameAvailable, bool updateSuccess, String? updateError, String? errorMessage
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? lifetimeEarned = null,Object? lifetimeWithdrawn = null,Object? isUpdating = null,Object? isCheckingUsername = null,Object? usernameAvailable = freezed,Object? updateSuccess = null,Object? updateError = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,lifetimeEarned: null == lifetimeEarned ? _self.lifetimeEarned : lifetimeEarned // ignore: cast_nullable_to_non_nullable
as int,lifetimeWithdrawn: null == lifetimeWithdrawn ? _self.lifetimeWithdrawn : lifetimeWithdrawn // ignore: cast_nullable_to_non_nullable
as int,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,isCheckingUsername: null == isCheckingUsername ? _self.isCheckingUsername : isCheckingUsername // ignore: cast_nullable_to_non_nullable
as bool,usernameAvailable: freezed == usernameAvailable ? _self.usernameAvailable : usernameAvailable // ignore: cast_nullable_to_non_nullable
as bool?,updateSuccess: null == updateSuccess ? _self.updateSuccess : updateSuccess // ignore: cast_nullable_to_non_nullable
as bool,updateError: freezed == updateError ? _self.updateError : updateError // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileStatus status,  User? user,  int lifetimeEarned,  int lifetimeWithdrawn,  bool isUpdating,  bool isCheckingUsername,  bool? usernameAvailable,  bool updateSuccess,  String? updateError,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.user,_that.lifetimeEarned,_that.lifetimeWithdrawn,_that.isUpdating,_that.isCheckingUsername,_that.usernameAvailable,_that.updateSuccess,_that.updateError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileStatus status,  User? user,  int lifetimeEarned,  int lifetimeWithdrawn,  bool isUpdating,  bool isCheckingUsername,  bool? usernameAvailable,  bool updateSuccess,  String? updateError,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.status,_that.user,_that.lifetimeEarned,_that.lifetimeWithdrawn,_that.isUpdating,_that.isCheckingUsername,_that.usernameAvailable,_that.updateSuccess,_that.updateError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileStatus status,  User? user,  int lifetimeEarned,  int lifetimeWithdrawn,  bool isUpdating,  bool isCheckingUsername,  bool? usernameAvailable,  bool updateSuccess,  String? updateError,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.user,_that.lifetimeEarned,_that.lifetimeWithdrawn,_that.isUpdating,_that.isCheckingUsername,_that.usernameAvailable,_that.updateSuccess,_that.updateError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState implements ProfileState {
  const _ProfileState({this.status = ProfileStatus.initial, this.user, this.lifetimeEarned = 0, this.lifetimeWithdrawn = 0, this.isUpdating = false, this.isCheckingUsername = false, this.usernameAvailable, this.updateSuccess = false, this.updateError, this.errorMessage});
  

@override@JsonKey() final  ProfileStatus status;
@override final  User? user;
@override@JsonKey() final  int lifetimeEarned;
@override@JsonKey() final  int lifetimeWithdrawn;
@override@JsonKey() final  bool isUpdating;
@override@JsonKey() final  bool isCheckingUsername;
@override final  bool? usernameAvailable;
@override@JsonKey() final  bool updateSuccess;
@override final  String? updateError;
@override final  String? errorMessage;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.lifetimeEarned, lifetimeEarned) || other.lifetimeEarned == lifetimeEarned)&&(identical(other.lifetimeWithdrawn, lifetimeWithdrawn) || other.lifetimeWithdrawn == lifetimeWithdrawn)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.isCheckingUsername, isCheckingUsername) || other.isCheckingUsername == isCheckingUsername)&&(identical(other.usernameAvailable, usernameAvailable) || other.usernameAvailable == usernameAvailable)&&(identical(other.updateSuccess, updateSuccess) || other.updateSuccess == updateSuccess)&&(identical(other.updateError, updateError) || other.updateError == updateError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,lifetimeEarned,lifetimeWithdrawn,isUpdating,isCheckingUsername,usernameAvailable,updateSuccess,updateError,errorMessage);

@override
String toString() {
  return 'ProfileState(status: $status, user: $user, lifetimeEarned: $lifetimeEarned, lifetimeWithdrawn: $lifetimeWithdrawn, isUpdating: $isUpdating, isCheckingUsername: $isCheckingUsername, usernameAvailable: $usernameAvailable, updateSuccess: $updateSuccess, updateError: $updateError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileStatus status, User? user, int lifetimeEarned, int lifetimeWithdrawn, bool isUpdating, bool isCheckingUsername, bool? usernameAvailable, bool updateSuccess, String? updateError, String? errorMessage
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? lifetimeEarned = null,Object? lifetimeWithdrawn = null,Object? isUpdating = null,Object? isCheckingUsername = null,Object? usernameAvailable = freezed,Object? updateSuccess = null,Object? updateError = freezed,Object? errorMessage = freezed,}) {
  return _then(_ProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,lifetimeEarned: null == lifetimeEarned ? _self.lifetimeEarned : lifetimeEarned // ignore: cast_nullable_to_non_nullable
as int,lifetimeWithdrawn: null == lifetimeWithdrawn ? _self.lifetimeWithdrawn : lifetimeWithdrawn // ignore: cast_nullable_to_non_nullable
as int,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,isCheckingUsername: null == isCheckingUsername ? _self.isCheckingUsername : isCheckingUsername // ignore: cast_nullable_to_non_nullable
as bool,usernameAvailable: freezed == usernameAvailable ? _self.usernameAvailable : usernameAvailable // ignore: cast_nullable_to_non_nullable
as bool?,updateSuccess: null == updateSuccess ? _self.updateSuccess : updateSuccess // ignore: cast_nullable_to_non_nullable
as bool,updateError: freezed == updateError ? _self.updateError : updateError // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
