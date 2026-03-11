// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trusted_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrustedDevice {

 String get deviceId; String get userId; String get publicKeyPem; String get platform; bool get trusted; bool get revoked; DateTime get registeredAt; DateTime? get lastUsedAt; String? get fcmToken; String? get deviceModel; String? get osVersion; String? get appVersion; String? get manufacturer; bool? get hardwareBacked; bool? get strongBox;
/// Create a copy of TrustedDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrustedDeviceCopyWith<TrustedDevice> get copyWith => _$TrustedDeviceCopyWithImpl<TrustedDevice>(this as TrustedDevice, _$identity);

  /// Serializes this TrustedDevice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrustedDevice&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.publicKeyPem, publicKeyPem) || other.publicKeyPem == publicKeyPem)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.trusted, trusted) || other.trusted == trusted)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.hardwareBacked, hardwareBacked) || other.hardwareBacked == hardwareBacked)&&(identical(other.strongBox, strongBox) || other.strongBox == strongBox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,userId,publicKeyPem,platform,trusted,revoked,registeredAt,lastUsedAt,fcmToken,deviceModel,osVersion,appVersion,manufacturer,hardwareBacked,strongBox);

@override
String toString() {
  return 'TrustedDevice(deviceId: $deviceId, userId: $userId, publicKeyPem: $publicKeyPem, platform: $platform, trusted: $trusted, revoked: $revoked, registeredAt: $registeredAt, lastUsedAt: $lastUsedAt, fcmToken: $fcmToken, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, manufacturer: $manufacturer, hardwareBacked: $hardwareBacked, strongBox: $strongBox)';
}


}

/// @nodoc
abstract mixin class $TrustedDeviceCopyWith<$Res>  {
  factory $TrustedDeviceCopyWith(TrustedDevice value, $Res Function(TrustedDevice) _then) = _$TrustedDeviceCopyWithImpl;
@useResult
$Res call({
 String deviceId, String userId, String publicKeyPem, String platform, bool trusted, bool revoked, DateTime registeredAt, DateTime? lastUsedAt, String? fcmToken, String? deviceModel, String? osVersion, String? appVersion, String? manufacturer, bool? hardwareBacked, bool? strongBox
});




}
/// @nodoc
class _$TrustedDeviceCopyWithImpl<$Res>
    implements $TrustedDeviceCopyWith<$Res> {
  _$TrustedDeviceCopyWithImpl(this._self, this._then);

  final TrustedDevice _self;
  final $Res Function(TrustedDevice) _then;

/// Create a copy of TrustedDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? userId = null,Object? publicKeyPem = null,Object? platform = null,Object? trusted = null,Object? revoked = null,Object? registeredAt = null,Object? lastUsedAt = freezed,Object? fcmToken = freezed,Object? deviceModel = freezed,Object? osVersion = freezed,Object? appVersion = freezed,Object? manufacturer = freezed,Object? hardwareBacked = freezed,Object? strongBox = freezed,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,publicKeyPem: null == publicKeyPem ? _self.publicKeyPem : publicKeyPem // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,trusted: null == trusted ? _self.trusted : trusted // ignore: cast_nullable_to_non_nullable
as bool,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,deviceModel: freezed == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String?,osVersion: freezed == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,manufacturer: freezed == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as String?,hardwareBacked: freezed == hardwareBacked ? _self.hardwareBacked : hardwareBacked // ignore: cast_nullable_to_non_nullable
as bool?,strongBox: freezed == strongBox ? _self.strongBox : strongBox // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrustedDevice].
extension TrustedDevicePatterns on TrustedDevice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrustedDevice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrustedDevice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrustedDevice value)  $default,){
final _that = this;
switch (_that) {
case _TrustedDevice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrustedDevice value)?  $default,){
final _that = this;
switch (_that) {
case _TrustedDevice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String userId,  String publicKeyPem,  String platform,  bool trusted,  bool revoked,  DateTime registeredAt,  DateTime? lastUsedAt,  String? fcmToken,  String? deviceModel,  String? osVersion,  String? appVersion,  String? manufacturer,  bool? hardwareBacked,  bool? strongBox)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrustedDevice() when $default != null:
return $default(_that.deviceId,_that.userId,_that.publicKeyPem,_that.platform,_that.trusted,_that.revoked,_that.registeredAt,_that.lastUsedAt,_that.fcmToken,_that.deviceModel,_that.osVersion,_that.appVersion,_that.manufacturer,_that.hardwareBacked,_that.strongBox);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String userId,  String publicKeyPem,  String platform,  bool trusted,  bool revoked,  DateTime registeredAt,  DateTime? lastUsedAt,  String? fcmToken,  String? deviceModel,  String? osVersion,  String? appVersion,  String? manufacturer,  bool? hardwareBacked,  bool? strongBox)  $default,) {final _that = this;
switch (_that) {
case _TrustedDevice():
return $default(_that.deviceId,_that.userId,_that.publicKeyPem,_that.platform,_that.trusted,_that.revoked,_that.registeredAt,_that.lastUsedAt,_that.fcmToken,_that.deviceModel,_that.osVersion,_that.appVersion,_that.manufacturer,_that.hardwareBacked,_that.strongBox);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String userId,  String publicKeyPem,  String platform,  bool trusted,  bool revoked,  DateTime registeredAt,  DateTime? lastUsedAt,  String? fcmToken,  String? deviceModel,  String? osVersion,  String? appVersion,  String? manufacturer,  bool? hardwareBacked,  bool? strongBox)?  $default,) {final _that = this;
switch (_that) {
case _TrustedDevice() when $default != null:
return $default(_that.deviceId,_that.userId,_that.publicKeyPem,_that.platform,_that.trusted,_that.revoked,_that.registeredAt,_that.lastUsedAt,_that.fcmToken,_that.deviceModel,_that.osVersion,_that.appVersion,_that.manufacturer,_that.hardwareBacked,_that.strongBox);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrustedDevice extends TrustedDevice {
  const _TrustedDevice({required this.deviceId, required this.userId, required this.publicKeyPem, required this.platform, required this.trusted, required this.revoked, required this.registeredAt, this.lastUsedAt, this.fcmToken, this.deviceModel, this.osVersion, this.appVersion, this.manufacturer, this.hardwareBacked, this.strongBox}): super._();
  factory _TrustedDevice.fromJson(Map<String, dynamic> json) => _$TrustedDeviceFromJson(json);

@override final  String deviceId;
@override final  String userId;
@override final  String publicKeyPem;
@override final  String platform;
@override final  bool trusted;
@override final  bool revoked;
@override final  DateTime registeredAt;
@override final  DateTime? lastUsedAt;
@override final  String? fcmToken;
@override final  String? deviceModel;
@override final  String? osVersion;
@override final  String? appVersion;
@override final  String? manufacturer;
@override final  bool? hardwareBacked;
@override final  bool? strongBox;

/// Create a copy of TrustedDevice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrustedDeviceCopyWith<_TrustedDevice> get copyWith => __$TrustedDeviceCopyWithImpl<_TrustedDevice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrustedDeviceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrustedDevice&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.publicKeyPem, publicKeyPem) || other.publicKeyPem == publicKeyPem)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.trusted, trusted) || other.trusted == trusted)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.hardwareBacked, hardwareBacked) || other.hardwareBacked == hardwareBacked)&&(identical(other.strongBox, strongBox) || other.strongBox == strongBox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,userId,publicKeyPem,platform,trusted,revoked,registeredAt,lastUsedAt,fcmToken,deviceModel,osVersion,appVersion,manufacturer,hardwareBacked,strongBox);

@override
String toString() {
  return 'TrustedDevice(deviceId: $deviceId, userId: $userId, publicKeyPem: $publicKeyPem, platform: $platform, trusted: $trusted, revoked: $revoked, registeredAt: $registeredAt, lastUsedAt: $lastUsedAt, fcmToken: $fcmToken, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, manufacturer: $manufacturer, hardwareBacked: $hardwareBacked, strongBox: $strongBox)';
}


}

/// @nodoc
abstract mixin class _$TrustedDeviceCopyWith<$Res> implements $TrustedDeviceCopyWith<$Res> {
  factory _$TrustedDeviceCopyWith(_TrustedDevice value, $Res Function(_TrustedDevice) _then) = __$TrustedDeviceCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String userId, String publicKeyPem, String platform, bool trusted, bool revoked, DateTime registeredAt, DateTime? lastUsedAt, String? fcmToken, String? deviceModel, String? osVersion, String? appVersion, String? manufacturer, bool? hardwareBacked, bool? strongBox
});




}
/// @nodoc
class __$TrustedDeviceCopyWithImpl<$Res>
    implements _$TrustedDeviceCopyWith<$Res> {
  __$TrustedDeviceCopyWithImpl(this._self, this._then);

  final _TrustedDevice _self;
  final $Res Function(_TrustedDevice) _then;

/// Create a copy of TrustedDevice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? userId = null,Object? publicKeyPem = null,Object? platform = null,Object? trusted = null,Object? revoked = null,Object? registeredAt = null,Object? lastUsedAt = freezed,Object? fcmToken = freezed,Object? deviceModel = freezed,Object? osVersion = freezed,Object? appVersion = freezed,Object? manufacturer = freezed,Object? hardwareBacked = freezed,Object? strongBox = freezed,}) {
  return _then(_TrustedDevice(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,publicKeyPem: null == publicKeyPem ? _self.publicKeyPem : publicKeyPem // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,trusted: null == trusted ? _self.trusted : trusted // ignore: cast_nullable_to_non_nullable
as bool,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,deviceModel: freezed == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String?,osVersion: freezed == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,manufacturer: freezed == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as String?,hardwareBacked: freezed == hardwareBacked ? _self.hardwareBacked : hardwareBacked // ignore: cast_nullable_to_non_nullable
as bool?,strongBox: freezed == strongBox ? _self.strongBox : strongBox // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
