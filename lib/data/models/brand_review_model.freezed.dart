// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandReviewModel {

 String get id; String get brandId; String get userId; String get userName; String get orderId; int get qualityRating; int get valueRating; int get serviceRating; double get overallRating; String? get comment; bool get isFiltered; bool get isRemovedByAdmin; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of BrandReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandReviewModelCopyWith<BrandReviewModel> get copyWith => _$BrandReviewModelCopyWithImpl<BrandReviewModel>(this as BrandReviewModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.qualityRating, qualityRating) || other.qualityRating == qualityRating)&&(identical(other.valueRating, valueRating) || other.valueRating == valueRating)&&(identical(other.serviceRating, serviceRating) || other.serviceRating == serviceRating)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isFiltered, isFiltered) || other.isFiltered == isFiltered)&&(identical(other.isRemovedByAdmin, isRemovedByAdmin) || other.isRemovedByAdmin == isRemovedByAdmin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,userId,userName,orderId,qualityRating,valueRating,serviceRating,overallRating,comment,isFiltered,isRemovedByAdmin,createdAt,updatedAt);

@override
String toString() {
  return 'BrandReviewModel(id: $id, brandId: $brandId, userId: $userId, userName: $userName, orderId: $orderId, qualityRating: $qualityRating, valueRating: $valueRating, serviceRating: $serviceRating, overallRating: $overallRating, comment: $comment, isFiltered: $isFiltered, isRemovedByAdmin: $isRemovedByAdmin, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BrandReviewModelCopyWith<$Res>  {
  factory $BrandReviewModelCopyWith(BrandReviewModel value, $Res Function(BrandReviewModel) _then) = _$BrandReviewModelCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String userId, String userName, String orderId, int qualityRating, int valueRating, int serviceRating, double overallRating, String? comment, bool isFiltered, bool isRemovedByAdmin, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$BrandReviewModelCopyWithImpl<$Res>
    implements $BrandReviewModelCopyWith<$Res> {
  _$BrandReviewModelCopyWithImpl(this._self, this._then);

  final BrandReviewModel _self;
  final $Res Function(BrandReviewModel) _then;

/// Create a copy of BrandReviewModel
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


/// Adds pattern-matching-related methods to [BrandReviewModel].
extension BrandReviewModelPatterns on BrandReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _BrandReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _BrandReviewModel() when $default != null:
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
case _BrandReviewModel() when $default != null:
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
case _BrandReviewModel():
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
case _BrandReviewModel() when $default != null:
return $default(_that.id,_that.brandId,_that.userId,_that.userName,_that.orderId,_that.qualityRating,_that.valueRating,_that.serviceRating,_that.overallRating,_that.comment,_that.isFiltered,_that.isRemovedByAdmin,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _BrandReviewModel extends BrandReviewModel {
  const _BrandReviewModel({required this.id, required this.brandId, required this.userId, required this.userName, required this.orderId, required this.qualityRating, required this.valueRating, required this.serviceRating, required this.overallRating, this.comment, this.isFiltered = false, this.isRemovedByAdmin = false, required this.createdAt, this.updatedAt}): super._();
  

@override final  String id;
@override final  String brandId;
@override final  String userId;
@override final  String userName;
@override final  String orderId;
@override final  int qualityRating;
@override final  int valueRating;
@override final  int serviceRating;
@override final  double overallRating;
@override final  String? comment;
@override@JsonKey() final  bool isFiltered;
@override@JsonKey() final  bool isRemovedByAdmin;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of BrandReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandReviewModelCopyWith<_BrandReviewModel> get copyWith => __$BrandReviewModelCopyWithImpl<_BrandReviewModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.qualityRating, qualityRating) || other.qualityRating == qualityRating)&&(identical(other.valueRating, valueRating) || other.valueRating == valueRating)&&(identical(other.serviceRating, serviceRating) || other.serviceRating == serviceRating)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isFiltered, isFiltered) || other.isFiltered == isFiltered)&&(identical(other.isRemovedByAdmin, isRemovedByAdmin) || other.isRemovedByAdmin == isRemovedByAdmin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,userId,userName,orderId,qualityRating,valueRating,serviceRating,overallRating,comment,isFiltered,isRemovedByAdmin,createdAt,updatedAt);

@override
String toString() {
  return 'BrandReviewModel(id: $id, brandId: $brandId, userId: $userId, userName: $userName, orderId: $orderId, qualityRating: $qualityRating, valueRating: $valueRating, serviceRating: $serviceRating, overallRating: $overallRating, comment: $comment, isFiltered: $isFiltered, isRemovedByAdmin: $isRemovedByAdmin, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BrandReviewModelCopyWith<$Res> implements $BrandReviewModelCopyWith<$Res> {
  factory _$BrandReviewModelCopyWith(_BrandReviewModel value, $Res Function(_BrandReviewModel) _then) = __$BrandReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String userId, String userName, String orderId, int qualityRating, int valueRating, int serviceRating, double overallRating, String? comment, bool isFiltered, bool isRemovedByAdmin, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$BrandReviewModelCopyWithImpl<$Res>
    implements _$BrandReviewModelCopyWith<$Res> {
  __$BrandReviewModelCopyWithImpl(this._self, this._then);

  final _BrandReviewModel _self;
  final $Res Function(_BrandReviewModel) _then;

/// Create a copy of BrandReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? userId = null,Object? userName = null,Object? orderId = null,Object? qualityRating = null,Object? valueRating = null,Object? serviceRating = null,Object? overallRating = null,Object? comment = freezed,Object? isFiltered = null,Object? isRemovedByAdmin = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_BrandReviewModel(
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
