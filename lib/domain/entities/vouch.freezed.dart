// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vouch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Vouch {

 String get id; String get voucherId; String get voucherName; String? get voucherPhotoUrl; String get providerId; String? get orderId; int get rating; String? get comment; DateTime get createdAt;
/// Create a copy of Vouch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VouchCopyWith<Vouch> get copyWith => _$VouchCopyWithImpl<Vouch>(this as Vouch, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vouch&&(identical(other.id, id) || other.id == id)&&(identical(other.voucherId, voucherId) || other.voucherId == voucherId)&&(identical(other.voucherName, voucherName) || other.voucherName == voucherName)&&(identical(other.voucherPhotoUrl, voucherPhotoUrl) || other.voucherPhotoUrl == voucherPhotoUrl)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,voucherId,voucherName,voucherPhotoUrl,providerId,orderId,rating,comment,createdAt);

@override
String toString() {
  return 'Vouch(id: $id, voucherId: $voucherId, voucherName: $voucherName, voucherPhotoUrl: $voucherPhotoUrl, providerId: $providerId, orderId: $orderId, rating: $rating, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $VouchCopyWith<$Res>  {
  factory $VouchCopyWith(Vouch value, $Res Function(Vouch) _then) = _$VouchCopyWithImpl;
@useResult
$Res call({
 String id, String voucherId, String voucherName, String? voucherPhotoUrl, String providerId, String? orderId, int rating, String? comment, DateTime createdAt
});




}
/// @nodoc
class _$VouchCopyWithImpl<$Res>
    implements $VouchCopyWith<$Res> {
  _$VouchCopyWithImpl(this._self, this._then);

  final Vouch _self;
  final $Res Function(Vouch) _then;

/// Create a copy of Vouch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? voucherId = null,Object? voucherName = null,Object? voucherPhotoUrl = freezed,Object? providerId = null,Object? orderId = freezed,Object? rating = null,Object? comment = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,voucherId: null == voucherId ? _self.voucherId : voucherId // ignore: cast_nullable_to_non_nullable
as String,voucherName: null == voucherName ? _self.voucherName : voucherName // ignore: cast_nullable_to_non_nullable
as String,voucherPhotoUrl: freezed == voucherPhotoUrl ? _self.voucherPhotoUrl : voucherPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Vouch].
extension VouchPatterns on Vouch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vouch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vouch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vouch value)  $default,){
final _that = this;
switch (_that) {
case _Vouch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vouch value)?  $default,){
final _that = this;
switch (_that) {
case _Vouch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String voucherId,  String voucherName,  String? voucherPhotoUrl,  String providerId,  String? orderId,  int rating,  String? comment,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vouch() when $default != null:
return $default(_that.id,_that.voucherId,_that.voucherName,_that.voucherPhotoUrl,_that.providerId,_that.orderId,_that.rating,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String voucherId,  String voucherName,  String? voucherPhotoUrl,  String providerId,  String? orderId,  int rating,  String? comment,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Vouch():
return $default(_that.id,_that.voucherId,_that.voucherName,_that.voucherPhotoUrl,_that.providerId,_that.orderId,_that.rating,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String voucherId,  String voucherName,  String? voucherPhotoUrl,  String providerId,  String? orderId,  int rating,  String? comment,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Vouch() when $default != null:
return $default(_that.id,_that.voucherId,_that.voucherName,_that.voucherPhotoUrl,_that.providerId,_that.orderId,_that.rating,_that.comment,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Vouch extends Vouch {
  const _Vouch({required this.id, required this.voucherId, required this.voucherName, this.voucherPhotoUrl, required this.providerId, this.orderId, required this.rating, this.comment, required this.createdAt}): super._();
  

@override final  String id;
@override final  String voucherId;
@override final  String voucherName;
@override final  String? voucherPhotoUrl;
@override final  String providerId;
@override final  String? orderId;
@override final  int rating;
@override final  String? comment;
@override final  DateTime createdAt;

/// Create a copy of Vouch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VouchCopyWith<_Vouch> get copyWith => __$VouchCopyWithImpl<_Vouch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vouch&&(identical(other.id, id) || other.id == id)&&(identical(other.voucherId, voucherId) || other.voucherId == voucherId)&&(identical(other.voucherName, voucherName) || other.voucherName == voucherName)&&(identical(other.voucherPhotoUrl, voucherPhotoUrl) || other.voucherPhotoUrl == voucherPhotoUrl)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,voucherId,voucherName,voucherPhotoUrl,providerId,orderId,rating,comment,createdAt);

@override
String toString() {
  return 'Vouch(id: $id, voucherId: $voucherId, voucherName: $voucherName, voucherPhotoUrl: $voucherPhotoUrl, providerId: $providerId, orderId: $orderId, rating: $rating, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$VouchCopyWith<$Res> implements $VouchCopyWith<$Res> {
  factory _$VouchCopyWith(_Vouch value, $Res Function(_Vouch) _then) = __$VouchCopyWithImpl;
@override @useResult
$Res call({
 String id, String voucherId, String voucherName, String? voucherPhotoUrl, String providerId, String? orderId, int rating, String? comment, DateTime createdAt
});




}
/// @nodoc
class __$VouchCopyWithImpl<$Res>
    implements _$VouchCopyWith<$Res> {
  __$VouchCopyWithImpl(this._self, this._then);

  final _Vouch _self;
  final $Res Function(_Vouch) _then;

/// Create a copy of Vouch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? voucherId = null,Object? voucherName = null,Object? voucherPhotoUrl = freezed,Object? providerId = null,Object? orderId = freezed,Object? rating = null,Object? comment = freezed,Object? createdAt = null,}) {
  return _then(_Vouch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,voucherId: null == voucherId ? _self.voucherId : voucherId // ignore: cast_nullable_to_non_nullable
as String,voucherName: null == voucherName ? _self.voucherName : voucherName // ignore: cast_nullable_to_non_nullable
as String,voucherPhotoUrl: freezed == voucherPhotoUrl ? _self.voucherPhotoUrl : voucherPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
