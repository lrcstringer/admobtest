// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarnNotification {

 String get id; String get type;// new_client, new_thread, new_opportunity, expiry_warning
 String get title; String get body; Map<String, dynamic> get data; bool get read; DateTime get createdAt;
/// Create a copy of EarnNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnNotificationCopyWith<EarnNotification> get copyWith => _$EarnNotificationCopyWithImpl<EarnNotification>(this as EarnNotification, _$identity);

  /// Serializes this EarnNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.read, read) || other.read == read)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,const DeepCollectionEquality().hash(data),read,createdAt);

@override
String toString() {
  return 'EarnNotification(id: $id, type: $type, title: $title, body: $body, data: $data, read: $read, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EarnNotificationCopyWith<$Res>  {
  factory $EarnNotificationCopyWith(EarnNotification value, $Res Function(EarnNotification) _then) = _$EarnNotificationCopyWithImpl;
@useResult
$Res call({
 String id, String type, String title, String body, Map<String, dynamic> data, bool read, DateTime createdAt
});




}
/// @nodoc
class _$EarnNotificationCopyWithImpl<$Res>
    implements $EarnNotificationCopyWith<$Res> {
  _$EarnNotificationCopyWithImpl(this._self, this._then);

  final EarnNotification _self;
  final $Res Function(EarnNotification) _then;

/// Create a copy of EarnNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? body = null,Object? data = null,Object? read = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EarnNotification].
extension EarnNotificationPatterns on EarnNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnNotification value)  $default,){
final _that = this;
switch (_that) {
case _EarnNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnNotification value)?  $default,){
final _that = this;
switch (_that) {
case _EarnNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String body,  Map<String, dynamic> data,  bool read,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnNotification() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.data,_that.read,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String body,  Map<String, dynamic> data,  bool read,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _EarnNotification():
return $default(_that.id,_that.type,_that.title,_that.body,_that.data,_that.read,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String title,  String body,  Map<String, dynamic> data,  bool read,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EarnNotification() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.data,_that.read,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarnNotification extends EarnNotification {
  const _EarnNotification({required this.id, required this.type, required this.title, required this.body, final  Map<String, dynamic> data = const {}, required this.read, required this.createdAt}): _data = data,super._();
  factory _EarnNotification.fromJson(Map<String, dynamic> json) => _$EarnNotificationFromJson(json);

@override final  String id;
@override final  String type;
// new_client, new_thread, new_opportunity, expiry_warning
@override final  String title;
@override final  String body;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override final  bool read;
@override final  DateTime createdAt;

/// Create a copy of EarnNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnNotificationCopyWith<_EarnNotification> get copyWith => __$EarnNotificationCopyWithImpl<_EarnNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarnNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.read, read) || other.read == read)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,const DeepCollectionEquality().hash(_data),read,createdAt);

@override
String toString() {
  return 'EarnNotification(id: $id, type: $type, title: $title, body: $body, data: $data, read: $read, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EarnNotificationCopyWith<$Res> implements $EarnNotificationCopyWith<$Res> {
  factory _$EarnNotificationCopyWith(_EarnNotification value, $Res Function(_EarnNotification) _then) = __$EarnNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String title, String body, Map<String, dynamic> data, bool read, DateTime createdAt
});




}
/// @nodoc
class __$EarnNotificationCopyWithImpl<$Res>
    implements _$EarnNotificationCopyWith<$Res> {
  __$EarnNotificationCopyWithImpl(this._self, this._then);

  final _EarnNotification _self;
  final $Res Function(_EarnNotification) _then;

/// Create a copy of EarnNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? body = null,Object? data = null,Object? read = null,Object? createdAt = null,}) {
  return _then(_EarnNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
