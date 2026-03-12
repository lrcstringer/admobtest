// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sa_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaLocation {

 String get id; String get name; String get type;// 'province', 'city', 'suburb'
 String? get parentId; String? get province; String? get city; String? get postalCode; double? get latitude; double? get longitude;
/// Create a copy of SaLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaLocationCopyWith<SaLocation> get copyWith => _$SaLocationCopyWithImpl<SaLocation>(this as SaLocation, _$identity);

  /// Serializes this SaLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,parentId,province,city,postalCode,latitude,longitude);

@override
String toString() {
  return 'SaLocation(id: $id, name: $name, type: $type, parentId: $parentId, province: $province, city: $city, postalCode: $postalCode, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $SaLocationCopyWith<$Res>  {
  factory $SaLocationCopyWith(SaLocation value, $Res Function(SaLocation) _then) = _$SaLocationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String? parentId, String? province, String? city, String? postalCode, double? latitude, double? longitude
});




}
/// @nodoc
class _$SaLocationCopyWithImpl<$Res>
    implements $SaLocationCopyWith<$Res> {
  _$SaLocationCopyWithImpl(this._self, this._then);

  final SaLocation _self;
  final $Res Function(SaLocation) _then;

/// Create a copy of SaLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? parentId = freezed,Object? province = freezed,Object? city = freezed,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaLocation].
extension SaLocationPatterns on SaLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaLocation value)  $default,){
final _that = this;
switch (_that) {
case _SaLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaLocation value)?  $default,){
final _that = this;
switch (_that) {
case _SaLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? parentId,  String? province,  String? city,  String? postalCode,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaLocation() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.parentId,_that.province,_that.city,_that.postalCode,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? parentId,  String? province,  String? city,  String? postalCode,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _SaLocation():
return $default(_that.id,_that.name,_that.type,_that.parentId,_that.province,_that.city,_that.postalCode,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String? parentId,  String? province,  String? city,  String? postalCode,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _SaLocation() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.parentId,_that.province,_that.city,_that.postalCode,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaLocation extends SaLocation {
  const _SaLocation({required this.id, required this.name, required this.type, this.parentId, this.province, this.city, this.postalCode, this.latitude, this.longitude}): super._();
  factory _SaLocation.fromJson(Map<String, dynamic> json) => _$SaLocationFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
// 'province', 'city', 'suburb'
@override final  String? parentId;
@override final  String? province;
@override final  String? city;
@override final  String? postalCode;
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of SaLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaLocationCopyWith<_SaLocation> get copyWith => __$SaLocationCopyWithImpl<_SaLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,parentId,province,city,postalCode,latitude,longitude);

@override
String toString() {
  return 'SaLocation(id: $id, name: $name, type: $type, parentId: $parentId, province: $province, city: $city, postalCode: $postalCode, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$SaLocationCopyWith<$Res> implements $SaLocationCopyWith<$Res> {
  factory _$SaLocationCopyWith(_SaLocation value, $Res Function(_SaLocation) _then) = __$SaLocationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String? parentId, String? province, String? city, String? postalCode, double? latitude, double? longitude
});




}
/// @nodoc
class __$SaLocationCopyWithImpl<$Res>
    implements _$SaLocationCopyWith<$Res> {
  __$SaLocationCopyWithImpl(this._self, this._then);

  final _SaLocation _self;
  final $Res Function(_SaLocation) _then;

/// Create a copy of SaLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? parentId = freezed,Object? province = freezed,Object? city = freezed,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_SaLocation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
