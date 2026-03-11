// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContactSuggestion {

 String get userId; String get displayName; String? get username; String? get avatarUrl; String? get avatarColor; String get reason; SuggestionSource get source;
/// Create a copy of ContactSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactSuggestionCopyWith<ContactSuggestion> get copyWith => _$ContactSuggestionCopyWithImpl<ContactSuggestion>(this as ContactSuggestion, _$identity);

  /// Serializes this ContactSuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactSuggestion&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,avatarUrl,avatarColor,reason,source);

@override
String toString() {
  return 'ContactSuggestion(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, reason: $reason, source: $source)';
}


}

/// @nodoc
abstract mixin class $ContactSuggestionCopyWith<$Res>  {
  factory $ContactSuggestionCopyWith(ContactSuggestion value, $Res Function(ContactSuggestion) _then) = _$ContactSuggestionCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? username, String? avatarUrl, String? avatarColor, String reason, SuggestionSource source
});




}
/// @nodoc
class _$ContactSuggestionCopyWithImpl<$Res>
    implements $ContactSuggestionCopyWith<$Res> {
  _$ContactSuggestionCopyWithImpl(this._self, this._then);

  final ContactSuggestion _self;
  final $Res Function(ContactSuggestion) _then;

/// Create a copy of ContactSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? reason = null,Object? source = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SuggestionSource,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactSuggestion].
extension ContactSuggestionPatterns on ContactSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _ContactSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _ContactSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String reason,  SuggestionSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactSuggestion() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.reason,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String reason,  SuggestionSource source)  $default,) {final _that = this;
switch (_that) {
case _ContactSuggestion():
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.reason,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  String reason,  SuggestionSource source)?  $default,) {final _that = this;
switch (_that) {
case _ContactSuggestion() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.reason,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactSuggestion implements ContactSuggestion {
  const _ContactSuggestion({required this.userId, required this.displayName, this.username, this.avatarUrl, this.avatarColor, required this.reason, required this.source});
  factory _ContactSuggestion.fromJson(Map<String, dynamic> json) => _$ContactSuggestionFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? username;
@override final  String? avatarUrl;
@override final  String? avatarColor;
@override final  String reason;
@override final  SuggestionSource source;

/// Create a copy of ContactSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactSuggestionCopyWith<_ContactSuggestion> get copyWith => __$ContactSuggestionCopyWithImpl<_ContactSuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactSuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactSuggestion&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,avatarUrl,avatarColor,reason,source);

@override
String toString() {
  return 'ContactSuggestion(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, reason: $reason, source: $source)';
}


}

/// @nodoc
abstract mixin class _$ContactSuggestionCopyWith<$Res> implements $ContactSuggestionCopyWith<$Res> {
  factory _$ContactSuggestionCopyWith(_ContactSuggestion value, $Res Function(_ContactSuggestion) _then) = __$ContactSuggestionCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? username, String? avatarUrl, String? avatarColor, String reason, SuggestionSource source
});




}
/// @nodoc
class __$ContactSuggestionCopyWithImpl<$Res>
    implements _$ContactSuggestionCopyWith<$Res> {
  __$ContactSuggestionCopyWithImpl(this._self, this._then);

  final _ContactSuggestion _self;
  final $Res Function(_ContactSuggestion) _then;

/// Create a copy of ContactSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? reason = null,Object? source = null,}) {
  return _then(_ContactSuggestion(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SuggestionSource,
  ));
}


}

// dart format on
