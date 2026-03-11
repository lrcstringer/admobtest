// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'privacy_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrivacySettings {

/// Who can find this user via search
 Discoverability get discoverability;/// Who can see this user's phone number
 PhoneNumberVisibility get phoneNumberVisibility;/// Who can see this user's profile photo
 ProfilePhotoVisibility get profilePhotoVisibility;/// Who can see this user's last seen / online status
 LastSeenVisibility get lastSeenVisibility;/// Whether read receipts are enabled
 bool get readReceipts;/// Who can add this user to groups/communities
 GroupAddPermission get groupAddPermission;/// Whether brands can message this user
 BrandMessaging get brandMessaging;
/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<PrivacySettings> get copyWith => _$PrivacySettingsCopyWithImpl<PrivacySettings>(this as PrivacySettings, _$identity);

  /// Serializes this PrivacySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivacySettings&&(identical(other.discoverability, discoverability) || other.discoverability == discoverability)&&(identical(other.phoneNumberVisibility, phoneNumberVisibility) || other.phoneNumberVisibility == phoneNumberVisibility)&&(identical(other.profilePhotoVisibility, profilePhotoVisibility) || other.profilePhotoVisibility == profilePhotoVisibility)&&(identical(other.lastSeenVisibility, lastSeenVisibility) || other.lastSeenVisibility == lastSeenVisibility)&&(identical(other.readReceipts, readReceipts) || other.readReceipts == readReceipts)&&(identical(other.groupAddPermission, groupAddPermission) || other.groupAddPermission == groupAddPermission)&&(identical(other.brandMessaging, brandMessaging) || other.brandMessaging == brandMessaging));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,discoverability,phoneNumberVisibility,profilePhotoVisibility,lastSeenVisibility,readReceipts,groupAddPermission,brandMessaging);

@override
String toString() {
  return 'PrivacySettings(discoverability: $discoverability, phoneNumberVisibility: $phoneNumberVisibility, profilePhotoVisibility: $profilePhotoVisibility, lastSeenVisibility: $lastSeenVisibility, readReceipts: $readReceipts, groupAddPermission: $groupAddPermission, brandMessaging: $brandMessaging)';
}


}

/// @nodoc
abstract mixin class $PrivacySettingsCopyWith<$Res>  {
  factory $PrivacySettingsCopyWith(PrivacySettings value, $Res Function(PrivacySettings) _then) = _$PrivacySettingsCopyWithImpl;
@useResult
$Res call({
 Discoverability discoverability, PhoneNumberVisibility phoneNumberVisibility, ProfilePhotoVisibility profilePhotoVisibility, LastSeenVisibility lastSeenVisibility, bool readReceipts, GroupAddPermission groupAddPermission, BrandMessaging brandMessaging
});




}
/// @nodoc
class _$PrivacySettingsCopyWithImpl<$Res>
    implements $PrivacySettingsCopyWith<$Res> {
  _$PrivacySettingsCopyWithImpl(this._self, this._then);

  final PrivacySettings _self;
  final $Res Function(PrivacySettings) _then;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? discoverability = null,Object? phoneNumberVisibility = null,Object? profilePhotoVisibility = null,Object? lastSeenVisibility = null,Object? readReceipts = null,Object? groupAddPermission = null,Object? brandMessaging = null,}) {
  return _then(_self.copyWith(
discoverability: null == discoverability ? _self.discoverability : discoverability // ignore: cast_nullable_to_non_nullable
as Discoverability,phoneNumberVisibility: null == phoneNumberVisibility ? _self.phoneNumberVisibility : phoneNumberVisibility // ignore: cast_nullable_to_non_nullable
as PhoneNumberVisibility,profilePhotoVisibility: null == profilePhotoVisibility ? _self.profilePhotoVisibility : profilePhotoVisibility // ignore: cast_nullable_to_non_nullable
as ProfilePhotoVisibility,lastSeenVisibility: null == lastSeenVisibility ? _self.lastSeenVisibility : lastSeenVisibility // ignore: cast_nullable_to_non_nullable
as LastSeenVisibility,readReceipts: null == readReceipts ? _self.readReceipts : readReceipts // ignore: cast_nullable_to_non_nullable
as bool,groupAddPermission: null == groupAddPermission ? _self.groupAddPermission : groupAddPermission // ignore: cast_nullable_to_non_nullable
as GroupAddPermission,brandMessaging: null == brandMessaging ? _self.brandMessaging : brandMessaging // ignore: cast_nullable_to_non_nullable
as BrandMessaging,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivacySettings].
extension PrivacySettingsPatterns on PrivacySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivacySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivacySettings value)  $default,){
final _that = this;
switch (_that) {
case _PrivacySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivacySettings value)?  $default,){
final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Discoverability discoverability,  PhoneNumberVisibility phoneNumberVisibility,  ProfilePhotoVisibility profilePhotoVisibility,  LastSeenVisibility lastSeenVisibility,  bool readReceipts,  GroupAddPermission groupAddPermission,  BrandMessaging brandMessaging)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.discoverability,_that.phoneNumberVisibility,_that.profilePhotoVisibility,_that.lastSeenVisibility,_that.readReceipts,_that.groupAddPermission,_that.brandMessaging);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Discoverability discoverability,  PhoneNumberVisibility phoneNumberVisibility,  ProfilePhotoVisibility profilePhotoVisibility,  LastSeenVisibility lastSeenVisibility,  bool readReceipts,  GroupAddPermission groupAddPermission,  BrandMessaging brandMessaging)  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings():
return $default(_that.discoverability,_that.phoneNumberVisibility,_that.profilePhotoVisibility,_that.lastSeenVisibility,_that.readReceipts,_that.groupAddPermission,_that.brandMessaging);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Discoverability discoverability,  PhoneNumberVisibility phoneNumberVisibility,  ProfilePhotoVisibility profilePhotoVisibility,  LastSeenVisibility lastSeenVisibility,  bool readReceipts,  GroupAddPermission groupAddPermission,  BrandMessaging brandMessaging)?  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.discoverability,_that.phoneNumberVisibility,_that.profilePhotoVisibility,_that.lastSeenVisibility,_that.readReceipts,_that.groupAddPermission,_that.brandMessaging);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivacySettings implements PrivacySettings {
  const _PrivacySettings({this.discoverability = Discoverability.everyone, this.phoneNumberVisibility = PhoneNumberVisibility.contactsOnly, this.profilePhotoVisibility = ProfilePhotoVisibility.everyone, this.lastSeenVisibility = LastSeenVisibility.everyone, this.readReceipts = true, this.groupAddPermission = GroupAddPermission.everyone, this.brandMessaging = BrandMessaging.allowAll});
  factory _PrivacySettings.fromJson(Map<String, dynamic> json) => _$PrivacySettingsFromJson(json);

/// Who can find this user via search
@override@JsonKey() final  Discoverability discoverability;
/// Who can see this user's phone number
@override@JsonKey() final  PhoneNumberVisibility phoneNumberVisibility;
/// Who can see this user's profile photo
@override@JsonKey() final  ProfilePhotoVisibility profilePhotoVisibility;
/// Who can see this user's last seen / online status
@override@JsonKey() final  LastSeenVisibility lastSeenVisibility;
/// Whether read receipts are enabled
@override@JsonKey() final  bool readReceipts;
/// Who can add this user to groups/communities
@override@JsonKey() final  GroupAddPermission groupAddPermission;
/// Whether brands can message this user
@override@JsonKey() final  BrandMessaging brandMessaging;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivacySettingsCopyWith<_PrivacySettings> get copyWith => __$PrivacySettingsCopyWithImpl<_PrivacySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivacySettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivacySettings&&(identical(other.discoverability, discoverability) || other.discoverability == discoverability)&&(identical(other.phoneNumberVisibility, phoneNumberVisibility) || other.phoneNumberVisibility == phoneNumberVisibility)&&(identical(other.profilePhotoVisibility, profilePhotoVisibility) || other.profilePhotoVisibility == profilePhotoVisibility)&&(identical(other.lastSeenVisibility, lastSeenVisibility) || other.lastSeenVisibility == lastSeenVisibility)&&(identical(other.readReceipts, readReceipts) || other.readReceipts == readReceipts)&&(identical(other.groupAddPermission, groupAddPermission) || other.groupAddPermission == groupAddPermission)&&(identical(other.brandMessaging, brandMessaging) || other.brandMessaging == brandMessaging));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,discoverability,phoneNumberVisibility,profilePhotoVisibility,lastSeenVisibility,readReceipts,groupAddPermission,brandMessaging);

@override
String toString() {
  return 'PrivacySettings(discoverability: $discoverability, phoneNumberVisibility: $phoneNumberVisibility, profilePhotoVisibility: $profilePhotoVisibility, lastSeenVisibility: $lastSeenVisibility, readReceipts: $readReceipts, groupAddPermission: $groupAddPermission, brandMessaging: $brandMessaging)';
}


}

/// @nodoc
abstract mixin class _$PrivacySettingsCopyWith<$Res> implements $PrivacySettingsCopyWith<$Res> {
  factory _$PrivacySettingsCopyWith(_PrivacySettings value, $Res Function(_PrivacySettings) _then) = __$PrivacySettingsCopyWithImpl;
@override @useResult
$Res call({
 Discoverability discoverability, PhoneNumberVisibility phoneNumberVisibility, ProfilePhotoVisibility profilePhotoVisibility, LastSeenVisibility lastSeenVisibility, bool readReceipts, GroupAddPermission groupAddPermission, BrandMessaging brandMessaging
});




}
/// @nodoc
class __$PrivacySettingsCopyWithImpl<$Res>
    implements _$PrivacySettingsCopyWith<$Res> {
  __$PrivacySettingsCopyWithImpl(this._self, this._then);

  final _PrivacySettings _self;
  final $Res Function(_PrivacySettings) _then;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? discoverability = null,Object? phoneNumberVisibility = null,Object? profilePhotoVisibility = null,Object? lastSeenVisibility = null,Object? readReceipts = null,Object? groupAddPermission = null,Object? brandMessaging = null,}) {
  return _then(_PrivacySettings(
discoverability: null == discoverability ? _self.discoverability : discoverability // ignore: cast_nullable_to_non_nullable
as Discoverability,phoneNumberVisibility: null == phoneNumberVisibility ? _self.phoneNumberVisibility : phoneNumberVisibility // ignore: cast_nullable_to_non_nullable
as PhoneNumberVisibility,profilePhotoVisibility: null == profilePhotoVisibility ? _self.profilePhotoVisibility : profilePhotoVisibility // ignore: cast_nullable_to_non_nullable
as ProfilePhotoVisibility,lastSeenVisibility: null == lastSeenVisibility ? _self.lastSeenVisibility : lastSeenVisibility // ignore: cast_nullable_to_non_nullable
as LastSeenVisibility,readReceipts: null == readReceipts ? _self.readReceipts : readReceipts // ignore: cast_nullable_to_non_nullable
as bool,groupAddPermission: null == groupAddPermission ? _self.groupAddPermission : groupAddPermission // ignore: cast_nullable_to_non_nullable
as GroupAddPermission,brandMessaging: null == brandMessaging ? _self.brandMessaging : brandMessaging // ignore: cast_nullable_to_non_nullable
as BrandMessaging,
  ));
}


}

// dart format on
