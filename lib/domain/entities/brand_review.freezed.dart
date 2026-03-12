// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandReview {

 String get id; String get brandId; String get userId; String get userName;/// Purchase that qualifies this review (uniqueness key)
 String get orderId;/// 1-5 stars
 int get qualityRating; int get valueRating; int get serviceRating;/// Computed average of the three dimensions
 double get overallRating; String? get comment;/// Auto-filter flagged this (hidden from carousel)
 bool get isFiltered;/// Admin manually removed
 bool get isRemovedByAdmin; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of BrandReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandReviewCopyWith<BrandReview> get copyWith => _$BrandReviewCopyWithImpl<BrandReview>(this as BrandReview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandReview&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.qualityRating, qualityRating) || other.qualityRating == qualityRating)&&(identical(other.valueRating, valueRating) || other.valueRating == valueRating)&&(identical(other.serviceRating, serviceRating) || other.serviceRating == serviceRating)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isFiltered, isFiltered) || other.isFiltered == isFiltered)&&(identical(other.isRemovedByAdmin, isRemovedByAdmin) || other.isRemovedByAdmin == isRemovedByAdmin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,userId,userName,orderId,qualityRating,valueRating,serviceRating,overallRating,comment,isFiltered,isRemovedByAdmin,createdAt,updatedAt);

@override
String toString() {
  return 'BrandReview(id: $id, brandId: $brandId, userId: $userId, userName: $userName, orderId: $orderId, qualityRating: $qualityRating, valueRating: $valueRating, serviceRating: $serviceRating, overallRating: $overallRating, comment: $comment, isFiltered: $isFiltered, isRemovedByAdmin: $isRemovedByAdmin, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BrandReviewCopyWith<$Res>  {
  factory $BrandReviewCopyWith(BrandReview value, $Res Function(BrandReview) _then) = _$BrandReviewCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String userId, String userName, String orderId, int qualityRating, int valueRating, int serviceRating, double overallRating, String? comment, bool isFiltered, bool isRemovedByAdmin, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$BrandReviewCopyWithImpl<$Res>
    implements $BrandReviewCopyWith<$Res> {
  _$BrandReviewCopyWithImpl(this._self, this._then);

  final BrandReview _self;
  final $Res Function(BrandReview) _then;

/// Create a copy of BrandReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandId = null,Object? userId = null,Object? userName = null,Object? orderId = null,Object? qualityRating = null,Object? valueRating = null,Object? serviceRating = null,Object? overallRating = null,Object? comment = freezed,Object? isFiltered = null,Object? isRemovedByAdmin = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,qualityRating: null == qualityRating ? _self.qualityRating : qualityRating // ignore: cast_nullable_to_non_nullable
as int,valueRating: null == valueRating ? _self.valueRating : valueRating // ignore: cast_nullable_to_non_nullable
as int,serviceRating: null == serviceRating ? _self.serviceRating : serviceRating // ignore: cast_nullable_to_non_nullable
as int,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,isFiltered: null == isFiltered ? _self.isFiltered : isFiltered // ignore: cast_nullable_to_non_nullable
as bool,isRemovedByAdmin: null == isRemovedByAdmin ? _self.isRemovedByAdmin : isRemovedByAdmin // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandReview].
extension BrandReviewPatterns on BrandReview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandReview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandReview value)  $default,){
final _that = this;
switch (_that) {
case _BrandReview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandReview value)?  $default,){
final _that = this;
switch (_that) {
case _BrandReview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandId,  String userId,  String userName,  String orderId,  int qualityRating,  int valueRating,  int serviceRating,  double overallRating,  String? comment,  bool isFiltered,  bool isRemovedByAdmin,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandReview() when $default != null:
return $default(_that.id,_that.brandId,_that.userId,_that.userName,_that.orderId,_that.qualityRating,_that.valueRating,_that.serviceRating,_that.overallRating,_that.comment,_that.isFiltered,_that.isRemovedByAdmin,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandId,  String userId,  String userName,  String orderId,  int qualityRating,  int valueRating,  int serviceRating,  double overallRating,  String? comment,  bool isFiltered,  bool isRemovedByAdmin,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BrandReview():
return $default(_that.id,_that.brandId,_that.userId,_that.userName,_that.orderId,_that.qualityRating,_that.valueRating,_that.serviceRating,_that.overallRating,_that.comment,_that.isFiltered,_that.isRemovedByAdmin,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandId,  String userId,  String userName,  String orderId,  int qualityRating,  int valueRating,  int serviceRating,  double overallRating,  String? comment,  bool isFiltered,  bool isRemovedByAdmin,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BrandReview() when $default != null:
return $default(_that.id,_that.brandId,_that.userId,_that.userName,_that.orderId,_that.qualityRating,_that.valueRating,_that.serviceRating,_that.overallRating,_that.comment,_that.isFiltered,_that.isRemovedByAdmin,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _BrandReview extends BrandReview {
  const _BrandReview({required this.id, required this.brandId, required this.userId, required this.userName, required this.orderId, required this.qualityRating, required this.valueRating, required this.serviceRating, required this.overallRating, this.comment, this.isFiltered = false, this.isRemovedByAdmin = false, required this.createdAt, this.updatedAt}): super._();
  

@override final  String id;
@override final  String brandId;
@override final  String userId;
@override final  String userName;
/// Purchase that qualifies this review (uniqueness key)
@override final  String orderId;
/// 1-5 stars
@override final  int qualityRating;
@override final  int valueRating;
@override final  int serviceRating;
/// Computed average of the three dimensions
@override final  double overallRating;
@override final  String? comment;
/// Auto-filter flagged this (hidden from carousel)
@override@JsonKey() final  bool isFiltered;
/// Admin manually removed
@override@JsonKey() final  bool isRemovedByAdmin;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of BrandReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandReviewCopyWith<_BrandReview> get copyWith => __$BrandReviewCopyWithImpl<_BrandReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandReview&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.qualityRating, qualityRating) || other.qualityRating == qualityRating)&&(identical(other.valueRating, valueRating) || other.valueRating == valueRating)&&(identical(other.serviceRating, serviceRating) || other.serviceRating == serviceRating)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isFiltered, isFiltered) || other.isFiltered == isFiltered)&&(identical(other.isRemovedByAdmin, isRemovedByAdmin) || other.isRemovedByAdmin == isRemovedByAdmin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,userId,userName,orderId,qualityRating,valueRating,serviceRating,overallRating,comment,isFiltered,isRemovedByAdmin,createdAt,updatedAt);

@override
String toString() {
  return 'BrandReview(id: $id, brandId: $brandId, userId: $userId, userName: $userName, orderId: $orderId, qualityRating: $qualityRating, valueRating: $valueRating, serviceRating: $serviceRating, overallRating: $overallRating, comment: $comment, isFiltered: $isFiltered, isRemovedByAdmin: $isRemovedByAdmin, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BrandReviewCopyWith<$Res> implements $BrandReviewCopyWith<$Res> {
  factory _$BrandReviewCopyWith(_BrandReview value, $Res Function(_BrandReview) _then) = __$BrandReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String userId, String userName, String orderId, int qualityRating, int valueRating, int serviceRating, double overallRating, String? comment, bool isFiltered, bool isRemovedByAdmin, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$BrandReviewCopyWithImpl<$Res>
    implements _$BrandReviewCopyWith<$Res> {
  __$BrandReviewCopyWithImpl(this._self, this._then);

  final _BrandReview _self;
  final $Res Function(_BrandReview) _then;

/// Create a copy of BrandReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? userId = null,Object? userName = null,Object? orderId = null,Object? qualityRating = null,Object? valueRating = null,Object? serviceRating = null,Object? overallRating = null,Object? comment = freezed,Object? isFiltered = null,Object? isRemovedByAdmin = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_BrandReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,qualityRating: null == qualityRating ? _self.qualityRating : qualityRating // ignore: cast_nullable_to_non_nullable
as int,valueRating: null == valueRating ? _self.valueRating : valueRating // ignore: cast_nullable_to_non_nullable
as int,serviceRating: null == serviceRating ? _self.serviceRating : serviceRating // ignore: cast_nullable_to_non_nullable
as int,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,isFiltered: null == isFiltered ? _self.isFiltered : isFiltered // ignore: cast_nullable_to_non_nullable
as bool,isRemovedByAdmin: null == isRemovedByAdmin ? _self.isRemovedByAdmin : isRemovedByAdmin // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
