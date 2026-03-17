// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityMemberModel {

 String get id; String get communityId; String get userId; String get displayName; String? get avatarUrl; String get role; String get status; int get contributionBalance;@NullableTimestampConverter() DateTime? get joinedAt; String get invitedBy;@TimestampConverter() DateTime get invitedAt;@NullableTimestampConverter() DateTime? get lastReadAt; String? get communityName;
/// Create a copy of CommunityMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityMemberModelCopyWith<CommunityMemberModel> get copyWith => _$CommunityMemberModelCopyWithImpl<CommunityMemberModel>(this as CommunityMemberModel, _$identity);

  /// Serializes this CommunityMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt)&&(identical(other.communityName, communityName) || other.communityName == communityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,userId,displayName,avatarUrl,role,status,contributionBalance,joinedAt,invitedBy,invitedAt,lastReadAt,communityName);

@override
String toString() {
  return 'CommunityMemberModel(id: $id, communityId: $communityId, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, role: $role, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt, lastReadAt: $lastReadAt, communityName: $communityName)';
}


}

/// @nodoc
abstract mixin class $CommunityMemberModelCopyWith<$Res>  {
  factory $CommunityMemberModelCopyWith(CommunityMemberModel value, $Res Function(CommunityMemberModel) _then) = _$CommunityMemberModelCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String userId, String displayName, String? avatarUrl, String role, String status, int contributionBalance,@NullableTimestampConverter() DateTime? joinedAt, String invitedBy,@TimestampConverter() DateTime invitedAt,@NullableTimestampConverter() DateTime? lastReadAt, String? communityName
});




}
/// @nodoc
class _$CommunityMemberModelCopyWithImpl<$Res>
    implements $CommunityMemberModelCopyWith<$Res> {
  _$CommunityMemberModelCopyWithImpl(this._self, this._then);

  final CommunityMemberModel _self;
  final $Res Function(CommunityMemberModel) _then;

/// Create a copy of CommunityMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? role = null,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,Object? lastReadAt = freezed,Object? communityName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,communityName: freezed == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityMemberModel].
extension CommunityMemberModelPatterns on CommunityMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _CommunityMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String userId,  String displayName,  String? avatarUrl,  String role,  String status,  int contributionBalance, @NullableTimestampConverter()  DateTime? joinedAt,  String invitedBy, @TimestampConverter()  DateTime invitedAt, @NullableTimestampConverter()  DateTime? lastReadAt,  String? communityName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityMemberModel() when $default != null:
return $default(_that.id,_that.communityId,_that.userId,_that.displayName,_that.avatarUrl,_that.role,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt,_that.lastReadAt,_that.communityName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String userId,  String displayName,  String? avatarUrl,  String role,  String status,  int contributionBalance, @NullableTimestampConverter()  DateTime? joinedAt,  String invitedBy, @TimestampConverter()  DateTime invitedAt, @NullableTimestampConverter()  DateTime? lastReadAt,  String? communityName)  $default,) {final _that = this;
switch (_that) {
case _CommunityMemberModel():
return $default(_that.id,_that.communityId,_that.userId,_that.displayName,_that.avatarUrl,_that.role,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt,_that.lastReadAt,_that.communityName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String userId,  String displayName,  String? avatarUrl,  String role,  String status,  int contributionBalance, @NullableTimestampConverter()  DateTime? joinedAt,  String invitedBy, @TimestampConverter()  DateTime invitedAt, @NullableTimestampConverter()  DateTime? lastReadAt,  String? communityName)?  $default,) {final _that = this;
switch (_that) {
case _CommunityMemberModel() when $default != null:
return $default(_that.id,_that.communityId,_that.userId,_that.displayName,_that.avatarUrl,_that.role,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt,_that.lastReadAt,_that.communityName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityMemberModel extends CommunityMemberModel {
  const _CommunityMemberModel({required this.id, required this.communityId, required this.userId, required this.displayName, this.avatarUrl, required this.role, required this.status, this.contributionBalance = 0, @NullableTimestampConverter() this.joinedAt, required this.invitedBy, @TimestampConverter() required this.invitedAt, @NullableTimestampConverter() this.lastReadAt, this.communityName}): super._();
  factory _CommunityMemberModel.fromJson(Map<String, dynamic> json) => _$CommunityMemberModelFromJson(json);

@override final  String id;
@override final  String communityId;
@override final  String userId;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String role;
@override final  String status;
@override@JsonKey() final  int contributionBalance;
@override@NullableTimestampConverter() final  DateTime? joinedAt;
@override final  String invitedBy;
@override@TimestampConverter() final  DateTime invitedAt;
@override@NullableTimestampConverter() final  DateTime? lastReadAt;
@override final  String? communityName;

/// Create a copy of CommunityMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityMemberModelCopyWith<_CommunityMemberModel> get copyWith => __$CommunityMemberModelCopyWithImpl<_CommunityMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt)&&(identical(other.communityName, communityName) || other.communityName == communityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,userId,displayName,avatarUrl,role,status,contributionBalance,joinedAt,invitedBy,invitedAt,lastReadAt,communityName);

@override
String toString() {
  return 'CommunityMemberModel(id: $id, communityId: $communityId, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, role: $role, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt, lastReadAt: $lastReadAt, communityName: $communityName)';
}


}

/// @nodoc
abstract mixin class _$CommunityMemberModelCopyWith<$Res> implements $CommunityMemberModelCopyWith<$Res> {
  factory _$CommunityMemberModelCopyWith(_CommunityMemberModel value, $Res Function(_CommunityMemberModel) _then) = __$CommunityMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String userId, String displayName, String? avatarUrl, String role, String status, int contributionBalance,@NullableTimestampConverter() DateTime? joinedAt, String invitedBy,@TimestampConverter() DateTime invitedAt,@NullableTimestampConverter() DateTime? lastReadAt, String? communityName
});




}
/// @nodoc
class __$CommunityMemberModelCopyWithImpl<$Res>
    implements _$CommunityMemberModelCopyWith<$Res> {
  __$CommunityMemberModelCopyWithImpl(this._self, this._then);

  final _CommunityMemberModel _self;
  final $Res Function(_CommunityMemberModel) _then;

/// Create a copy of CommunityMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? role = null,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,Object? lastReadAt = freezed,Object? communityName = freezed,}) {
  return _then(_CommunityMemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,communityName: freezed == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
