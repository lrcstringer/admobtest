// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupMemberModel {

 String get id; String get groupId; String get userId; String get role; String get displayName; String? get avatarUrl; String get status; int get contributionBalance;@NullableTimestampConverter() DateTime? get joinedAt; String get invitedBy;@TimestampConverter() DateTime get invitedAt;
/// Create a copy of GroupMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMemberModelCopyWith<GroupMemberModel> get copyWith => _$GroupMemberModelCopyWithImpl<GroupMemberModel>(this as GroupMemberModel, _$identity);

  /// Serializes this GroupMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,userId,role,displayName,avatarUrl,status,contributionBalance,joinedAt,invitedBy,invitedAt);

@override
String toString() {
  return 'GroupMemberModel(id: $id, groupId: $groupId, userId: $userId, role: $role, displayName: $displayName, avatarUrl: $avatarUrl, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt)';
}


}

/// @nodoc
abstract mixin class $GroupMemberModelCopyWith<$Res>  {
  factory $GroupMemberModelCopyWith(GroupMemberModel value, $Res Function(GroupMemberModel) _then) = _$GroupMemberModelCopyWithImpl;
@useResult
$Res call({
 String id, String groupId, String userId, String role, String displayName, String? avatarUrl, String status, int contributionBalance,@NullableTimestampConverter() DateTime? joinedAt, String invitedBy,@TimestampConverter() DateTime invitedAt
});




}
/// @nodoc
class _$GroupMemberModelCopyWithImpl<$Res>
    implements $GroupMemberModelCopyWith<$Res> {
  _$GroupMemberModelCopyWithImpl(this._self, this._then);

  final GroupMemberModel _self;
  final $Res Function(GroupMemberModel) _then;

/// Create a copy of GroupMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? userId = null,Object? role = null,Object? displayName = null,Object? avatarUrl = freezed,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupMemberModel].
extension GroupMemberModelPatterns on GroupMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupId,  String userId,  String role,  String displayName,  String? avatarUrl,  String status,  int contributionBalance, @NullableTimestampConverter()  DateTime? joinedAt,  String invitedBy, @TimestampConverter()  DateTime invitedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupMemberModel() when $default != null:
return $default(_that.id,_that.groupId,_that.userId,_that.role,_that.displayName,_that.avatarUrl,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupId,  String userId,  String role,  String displayName,  String? avatarUrl,  String status,  int contributionBalance, @NullableTimestampConverter()  DateTime? joinedAt,  String invitedBy, @TimestampConverter()  DateTime invitedAt)  $default,) {final _that = this;
switch (_that) {
case _GroupMemberModel():
return $default(_that.id,_that.groupId,_that.userId,_that.role,_that.displayName,_that.avatarUrl,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupId,  String userId,  String role,  String displayName,  String? avatarUrl,  String status,  int contributionBalance, @NullableTimestampConverter()  DateTime? joinedAt,  String invitedBy, @TimestampConverter()  DateTime invitedAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupMemberModel() when $default != null:
return $default(_that.id,_that.groupId,_that.userId,_that.role,_that.displayName,_that.avatarUrl,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupMemberModel extends GroupMemberModel {
  const _GroupMemberModel({required this.id, required this.groupId, required this.userId, required this.role, required this.displayName, this.avatarUrl, required this.status, required this.contributionBalance, @NullableTimestampConverter() this.joinedAt, required this.invitedBy, @TimestampConverter() required this.invitedAt}): super._();
  factory _GroupMemberModel.fromJson(Map<String, dynamic> json) => _$GroupMemberModelFromJson(json);

@override final  String id;
@override final  String groupId;
@override final  String userId;
@override final  String role;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String status;
@override final  int contributionBalance;
@override@NullableTimestampConverter() final  DateTime? joinedAt;
@override final  String invitedBy;
@override@TimestampConverter() final  DateTime invitedAt;

/// Create a copy of GroupMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupMemberModelCopyWith<_GroupMemberModel> get copyWith => __$GroupMemberModelCopyWithImpl<_GroupMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,userId,role,displayName,avatarUrl,status,contributionBalance,joinedAt,invitedBy,invitedAt);

@override
String toString() {
  return 'GroupMemberModel(id: $id, groupId: $groupId, userId: $userId, role: $role, displayName: $displayName, avatarUrl: $avatarUrl, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupMemberModelCopyWith<$Res> implements $GroupMemberModelCopyWith<$Res> {
  factory _$GroupMemberModelCopyWith(_GroupMemberModel value, $Res Function(_GroupMemberModel) _then) = __$GroupMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupId, String userId, String role, String displayName, String? avatarUrl, String status, int contributionBalance,@NullableTimestampConverter() DateTime? joinedAt, String invitedBy,@TimestampConverter() DateTime invitedAt
});




}
/// @nodoc
class __$GroupMemberModelCopyWithImpl<$Res>
    implements _$GroupMemberModelCopyWith<$Res> {
  __$GroupMemberModelCopyWithImpl(this._self, this._then);

  final _GroupMemberModel _self;
  final $Res Function(_GroupMemberModel) _then;

/// Create a copy of GroupMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? userId = null,Object? role = null,Object? displayName = null,Object? avatarUrl = freezed,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,}) {
  return _then(_GroupMemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
