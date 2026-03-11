// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupBuyRequestModel {

 String get id; String get userId; String get userName; String get description; String get brandOrStore; int? get estimatedPrice; String? get sourceUrl; String? get imageUrl; bool get wantsToJoin; GroupBuyRequestStatus get status; String? get adminNotes; String? get convertedGroupBuyId; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of GroupBuyRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupBuyRequestModelCopyWith<GroupBuyRequestModel> get copyWith => _$GroupBuyRequestModelCopyWithImpl<GroupBuyRequestModel>(this as GroupBuyRequestModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupBuyRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.description, description) || other.description == description)&&(identical(other.brandOrStore, brandOrStore) || other.brandOrStore == brandOrStore)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.wantsToJoin, wantsToJoin) || other.wantsToJoin == wantsToJoin)&&(identical(other.status, status) || other.status == status)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.convertedGroupBuyId, convertedGroupBuyId) || other.convertedGroupBuyId == convertedGroupBuyId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,description,brandOrStore,estimatedPrice,sourceUrl,imageUrl,wantsToJoin,status,adminNotes,convertedGroupBuyId,createdAt,updatedAt);

@override
String toString() {
  return 'GroupBuyRequestModel(id: $id, userId: $userId, userName: $userName, description: $description, brandOrStore: $brandOrStore, estimatedPrice: $estimatedPrice, sourceUrl: $sourceUrl, imageUrl: $imageUrl, wantsToJoin: $wantsToJoin, status: $status, adminNotes: $adminNotes, convertedGroupBuyId: $convertedGroupBuyId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GroupBuyRequestModelCopyWith<$Res>  {
  factory $GroupBuyRequestModelCopyWith(GroupBuyRequestModel value, $Res Function(GroupBuyRequestModel) _then) = _$GroupBuyRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userName, String description, String brandOrStore, int? estimatedPrice, String? sourceUrl, String? imageUrl, bool wantsToJoin, GroupBuyRequestStatus status, String? adminNotes, String? convertedGroupBuyId, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$GroupBuyRequestModelCopyWithImpl<$Res>
    implements $GroupBuyRequestModelCopyWith<$Res> {
  _$GroupBuyRequestModelCopyWithImpl(this._self, this._then);

  final GroupBuyRequestModel _self;
  final $Res Function(GroupBuyRequestModel) _then;

/// Create a copy of GroupBuyRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? description = null,Object? brandOrStore = null,Object? estimatedPrice = freezed,Object? sourceUrl = freezed,Object? imageUrl = freezed,Object? wantsToJoin = null,Object? status = null,Object? adminNotes = freezed,Object? convertedGroupBuyId = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,brandOrStore: null == brandOrStore ? _self.brandOrStore : brandOrStore // ignore: cast_nullable_to_non_nullable
as String,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as int?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,wantsToJoin: null == wantsToJoin ? _self.wantsToJoin : wantsToJoin // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupBuyRequestStatus,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,convertedGroupBuyId: freezed == convertedGroupBuyId ? _self.convertedGroupBuyId : convertedGroupBuyId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupBuyRequestModel].
extension GroupBuyRequestModelPatterns on GroupBuyRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupBuyRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupBuyRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupBuyRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupBuyRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupBuyRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupBuyRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  String description,  String brandOrStore,  int? estimatedPrice,  String? sourceUrl,  String? imageUrl,  bool wantsToJoin,  GroupBuyRequestStatus status,  String? adminNotes,  String? convertedGroupBuyId,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupBuyRequestModel() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.description,_that.brandOrStore,_that.estimatedPrice,_that.sourceUrl,_that.imageUrl,_that.wantsToJoin,_that.status,_that.adminNotes,_that.convertedGroupBuyId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  String description,  String brandOrStore,  int? estimatedPrice,  String? sourceUrl,  String? imageUrl,  bool wantsToJoin,  GroupBuyRequestStatus status,  String? adminNotes,  String? convertedGroupBuyId,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GroupBuyRequestModel():
return $default(_that.id,_that.userId,_that.userName,_that.description,_that.brandOrStore,_that.estimatedPrice,_that.sourceUrl,_that.imageUrl,_that.wantsToJoin,_that.status,_that.adminNotes,_that.convertedGroupBuyId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userName,  String description,  String brandOrStore,  int? estimatedPrice,  String? sourceUrl,  String? imageUrl,  bool wantsToJoin,  GroupBuyRequestStatus status,  String? adminNotes,  String? convertedGroupBuyId,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupBuyRequestModel() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.description,_that.brandOrStore,_that.estimatedPrice,_that.sourceUrl,_that.imageUrl,_that.wantsToJoin,_that.status,_that.adminNotes,_that.convertedGroupBuyId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _GroupBuyRequestModel extends GroupBuyRequestModel {
  const _GroupBuyRequestModel({required this.id, required this.userId, required this.userName, required this.description, required this.brandOrStore, this.estimatedPrice, this.sourceUrl, this.imageUrl, this.wantsToJoin = true, required this.status, this.adminNotes, this.convertedGroupBuyId, required this.createdAt, this.updatedAt}): super._();
  

@override final  String id;
@override final  String userId;
@override final  String userName;
@override final  String description;
@override final  String brandOrStore;
@override final  int? estimatedPrice;
@override final  String? sourceUrl;
@override final  String? imageUrl;
@override@JsonKey() final  bool wantsToJoin;
@override final  GroupBuyRequestStatus status;
@override final  String? adminNotes;
@override final  String? convertedGroupBuyId;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of GroupBuyRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupBuyRequestModelCopyWith<_GroupBuyRequestModel> get copyWith => __$GroupBuyRequestModelCopyWithImpl<_GroupBuyRequestModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupBuyRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.description, description) || other.description == description)&&(identical(other.brandOrStore, brandOrStore) || other.brandOrStore == brandOrStore)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.wantsToJoin, wantsToJoin) || other.wantsToJoin == wantsToJoin)&&(identical(other.status, status) || other.status == status)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.convertedGroupBuyId, convertedGroupBuyId) || other.convertedGroupBuyId == convertedGroupBuyId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,description,brandOrStore,estimatedPrice,sourceUrl,imageUrl,wantsToJoin,status,adminNotes,convertedGroupBuyId,createdAt,updatedAt);

@override
String toString() {
  return 'GroupBuyRequestModel(id: $id, userId: $userId, userName: $userName, description: $description, brandOrStore: $brandOrStore, estimatedPrice: $estimatedPrice, sourceUrl: $sourceUrl, imageUrl: $imageUrl, wantsToJoin: $wantsToJoin, status: $status, adminNotes: $adminNotes, convertedGroupBuyId: $convertedGroupBuyId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupBuyRequestModelCopyWith<$Res> implements $GroupBuyRequestModelCopyWith<$Res> {
  factory _$GroupBuyRequestModelCopyWith(_GroupBuyRequestModel value, $Res Function(_GroupBuyRequestModel) _then) = __$GroupBuyRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userName, String description, String brandOrStore, int? estimatedPrice, String? sourceUrl, String? imageUrl, bool wantsToJoin, GroupBuyRequestStatus status, String? adminNotes, String? convertedGroupBuyId, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$GroupBuyRequestModelCopyWithImpl<$Res>
    implements _$GroupBuyRequestModelCopyWith<$Res> {
  __$GroupBuyRequestModelCopyWithImpl(this._self, this._then);

  final _GroupBuyRequestModel _self;
  final $Res Function(_GroupBuyRequestModel) _then;

/// Create a copy of GroupBuyRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? description = null,Object? brandOrStore = null,Object? estimatedPrice = freezed,Object? sourceUrl = freezed,Object? imageUrl = freezed,Object? wantsToJoin = null,Object? status = null,Object? adminNotes = freezed,Object? convertedGroupBuyId = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_GroupBuyRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,brandOrStore: null == brandOrStore ? _self.brandOrStore : brandOrStore // ignore: cast_nullable_to_non_nullable
as String,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as int?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,wantsToJoin: null == wantsToJoin ? _self.wantsToJoin : wantsToJoin // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupBuyRequestStatus,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,convertedGroupBuyId: freezed == convertedGroupBuyId ? _self.convertedGroupBuyId : convertedGroupBuyId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
