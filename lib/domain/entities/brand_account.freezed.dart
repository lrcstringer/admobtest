// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandAccount {

 String get id; String get name; String? get logoUrl; String? get description; String? get avatarColor; bool get isFollowed; DateTime? get followedAt; int get followerCount;
/// Create a copy of BrandAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandAccountCopyWith<BrandAccount> get copyWith => _$BrandAccountCopyWithImpl<BrandAccount>(this as BrandAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,logoUrl,description,avatarColor,isFollowed,followedAt,followerCount);

@override
String toString() {
  return 'BrandAccount(id: $id, name: $name, logoUrl: $logoUrl, description: $description, avatarColor: $avatarColor, isFollowed: $isFollowed, followedAt: $followedAt, followerCount: $followerCount)';
}


}

/// @nodoc
abstract mixin class $BrandAccountCopyWith<$Res>  {
  factory $BrandAccountCopyWith(BrandAccount value, $Res Function(BrandAccount) _then) = _$BrandAccountCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? logoUrl, String? description, String? avatarColor, bool isFollowed, DateTime? followedAt, int followerCount
});




}
/// @nodoc
class _$BrandAccountCopyWithImpl<$Res>
    implements $BrandAccountCopyWith<$Res> {
  _$BrandAccountCopyWithImpl(this._self, this._then);

  final BrandAccount _self;
  final $Res Function(BrandAccount) _then;

/// Create a copy of BrandAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? logoUrl = freezed,Object? description = freezed,Object? avatarColor = freezed,Object? isFollowed = null,Object? followedAt = freezed,Object? followerCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,followedAt: freezed == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandAccount].
extension BrandAccountPatterns on BrandAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandAccount value)  $default,){
final _that = this;
switch (_that) {
case _BrandAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandAccount value)?  $default,){
final _that = this;
switch (_that) {
case _BrandAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? logoUrl,  String? description,  String? avatarColor,  bool isFollowed,  DateTime? followedAt,  int followerCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandAccount() when $default != null:
return $default(_that.id,_that.name,_that.logoUrl,_that.description,_that.avatarColor,_that.isFollowed,_that.followedAt,_that.followerCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? logoUrl,  String? description,  String? avatarColor,  bool isFollowed,  DateTime? followedAt,  int followerCount)  $default,) {final _that = this;
switch (_that) {
case _BrandAccount():
return $default(_that.id,_that.name,_that.logoUrl,_that.description,_that.avatarColor,_that.isFollowed,_that.followedAt,_that.followerCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? logoUrl,  String? description,  String? avatarColor,  bool isFollowed,  DateTime? followedAt,  int followerCount)?  $default,) {final _that = this;
switch (_that) {
case _BrandAccount() when $default != null:
return $default(_that.id,_that.name,_that.logoUrl,_that.description,_that.avatarColor,_that.isFollowed,_that.followedAt,_that.followerCount);case _:
  return null;

}
}

}

/// @nodoc


class _BrandAccount extends BrandAccount {
  const _BrandAccount({required this.id, required this.name, this.logoUrl, this.description, this.avatarColor, required this.isFollowed, this.followedAt, this.followerCount = 0}): super._();
  

@override final  String id;
@override final  String name;
@override final  String? logoUrl;
@override final  String? description;
@override final  String? avatarColor;
@override final  bool isFollowed;
@override final  DateTime? followedAt;
@override@JsonKey() final  int followerCount;

/// Create a copy of BrandAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandAccountCopyWith<_BrandAccount> get copyWith => __$BrandAccountCopyWithImpl<_BrandAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed)&&(identical(other.followedAt, followedAt) || other.followedAt == followedAt)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,logoUrl,description,avatarColor,isFollowed,followedAt,followerCount);

@override
String toString() {
  return 'BrandAccount(id: $id, name: $name, logoUrl: $logoUrl, description: $description, avatarColor: $avatarColor, isFollowed: $isFollowed, followedAt: $followedAt, followerCount: $followerCount)';
}


}

/// @nodoc
abstract mixin class _$BrandAccountCopyWith<$Res> implements $BrandAccountCopyWith<$Res> {
  factory _$BrandAccountCopyWith(_BrandAccount value, $Res Function(_BrandAccount) _then) = __$BrandAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? logoUrl, String? description, String? avatarColor, bool isFollowed, DateTime? followedAt, int followerCount
});




}
/// @nodoc
class __$BrandAccountCopyWithImpl<$Res>
    implements _$BrandAccountCopyWith<$Res> {
  __$BrandAccountCopyWithImpl(this._self, this._then);

  final _BrandAccount _self;
  final $Res Function(_BrandAccount) _then;

/// Create a copy of BrandAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? logoUrl = freezed,Object? description = freezed,Object? avatarColor = freezed,Object? isFollowed = null,Object? followedAt = freezed,Object? followerCount = null,}) {
  return _then(_BrandAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,followedAt: freezed == followedAt ? _self.followedAt : followedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
