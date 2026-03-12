// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationData {

 String? get provinceId; String? get province; String? get cityId; String? get city; String? get suburbId; String? get suburb; String? get postalCode; double? get latitude; double? get longitude;
/// Create a copy of LocationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationDataCopyWith<LocationData> get copyWith => _$LocationDataCopyWithImpl<LocationData>(this as LocationData, _$identity);

  /// Serializes this LocationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationData&&(identical(other.provinceId, provinceId) || other.provinceId == provinceId)&&(identical(other.province, province) || other.province == province)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.city, city) || other.city == city)&&(identical(other.suburbId, suburbId) || other.suburbId == suburbId)&&(identical(other.suburb, suburb) || other.suburb == suburb)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provinceId,province,cityId,city,suburbId,suburb,postalCode,latitude,longitude);

@override
String toString() {
  return 'LocationData(provinceId: $provinceId, province: $province, cityId: $cityId, city: $city, suburbId: $suburbId, suburb: $suburb, postalCode: $postalCode, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $LocationDataCopyWith<$Res>  {
  factory $LocationDataCopyWith(LocationData value, $Res Function(LocationData) _then) = _$LocationDataCopyWithImpl;
@useResult
$Res call({
 String? provinceId, String? province, String? cityId, String? city, String? suburbId, String? suburb, String? postalCode, double? latitude, double? longitude
});




}
/// @nodoc
class _$LocationDataCopyWithImpl<$Res>
    implements $LocationDataCopyWith<$Res> {
  _$LocationDataCopyWithImpl(this._self, this._then);

  final LocationData _self;
  final $Res Function(LocationData) _then;

/// Create a copy of LocationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provinceId = freezed,Object? province = freezed,Object? cityId = freezed,Object? city = freezed,Object? suburbId = freezed,Object? suburb = freezed,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
provinceId: freezed == provinceId ? _self.provinceId : provinceId // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,suburbId: freezed == suburbId ? _self.suburbId : suburbId // ignore: cast_nullable_to_non_nullable
as String?,suburb: freezed == suburb ? _self.suburb : suburb // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationData].
extension LocationDataPatterns on LocationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationData value)  $default,){
final _that = this;
switch (_that) {
case _LocationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationData value)?  $default,){
final _that = this;
switch (_that) {
case _LocationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? provinceId,  String? province,  String? cityId,  String? city,  String? suburbId,  String? suburb,  String? postalCode,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationData() when $default != null:
return $default(_that.provinceId,_that.province,_that.cityId,_that.city,_that.suburbId,_that.suburb,_that.postalCode,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? provinceId,  String? province,  String? cityId,  String? city,  String? suburbId,  String? suburb,  String? postalCode,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _LocationData():
return $default(_that.provinceId,_that.province,_that.cityId,_that.city,_that.suburbId,_that.suburb,_that.postalCode,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? provinceId,  String? province,  String? cityId,  String? city,  String? suburbId,  String? suburb,  String? postalCode,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _LocationData() when $default != null:
return $default(_that.provinceId,_that.province,_that.cityId,_that.city,_that.suburbId,_that.suburb,_that.postalCode,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationData extends LocationData {
  const _LocationData({this.provinceId, this.province, this.cityId, this.city, this.suburbId, this.suburb, this.postalCode, this.latitude, this.longitude}): super._();
  factory _LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);

@override final  String? provinceId;
@override final  String? province;
@override final  String? cityId;
@override final  String? city;
@override final  String? suburbId;
@override final  String? suburb;
@override final  String? postalCode;
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of LocationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationDataCopyWith<_LocationData> get copyWith => __$LocationDataCopyWithImpl<_LocationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationData&&(identical(other.provinceId, provinceId) || other.provinceId == provinceId)&&(identical(other.province, province) || other.province == province)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.city, city) || other.city == city)&&(identical(other.suburbId, suburbId) || other.suburbId == suburbId)&&(identical(other.suburb, suburb) || other.suburb == suburb)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provinceId,province,cityId,city,suburbId,suburb,postalCode,latitude,longitude);

@override
String toString() {
  return 'LocationData(provinceId: $provinceId, province: $province, cityId: $cityId, city: $city, suburbId: $suburbId, suburb: $suburb, postalCode: $postalCode, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$LocationDataCopyWith<$Res> implements $LocationDataCopyWith<$Res> {
  factory _$LocationDataCopyWith(_LocationData value, $Res Function(_LocationData) _then) = __$LocationDataCopyWithImpl;
@override @useResult
$Res call({
 String? provinceId, String? province, String? cityId, String? city, String? suburbId, String? suburb, String? postalCode, double? latitude, double? longitude
});




}
/// @nodoc
class __$LocationDataCopyWithImpl<$Res>
    implements _$LocationDataCopyWith<$Res> {
  __$LocationDataCopyWithImpl(this._self, this._then);

  final _LocationData _self;
  final $Res Function(_LocationData) _then;

/// Create a copy of LocationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provinceId = freezed,Object? province = freezed,Object? cityId = freezed,Object? city = freezed,Object? suburbId = freezed,Object? suburb = freezed,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_LocationData(
provinceId: freezed == provinceId ? _self.provinceId : provinceId // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,suburbId: freezed == suburbId ? _self.suburbId : suburbId // ignore: cast_nullable_to_non_nullable
as String?,suburb: freezed == suburb ? _self.suburb : suburb // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
