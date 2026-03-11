// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupMember {

 String get id; String get groupId; String get userId; GroupRole get role; String get displayName; String? get avatarUrl; GroupMemberStatus get status; int get contributionBalance; DateTime? get joinedAt; String get invitedBy; DateTime get invitedAt;
/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMemberCopyWith<GroupMember> get copyWith => _$GroupMemberCopyWithImpl<GroupMember>(this as GroupMember, _$identity);

  /// Serializes this GroupMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMember&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,userId,role,displayName,avatarUrl,status,contributionBalance,joinedAt,invitedBy,invitedAt);

@override
String toString() {
  return 'GroupMember(id: $id, groupId: $groupId, userId: $userId, role: $role, displayName: $displayName, avatarUrl: $avatarUrl, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt)';
}


}

/// @nodoc
abstract mixin class $GroupMemberCopyWith<$Res>  {
  factory $GroupMemberCopyWith(GroupMember value, $Res Function(GroupMember) _then) = _$GroupMemberCopyWithImpl;
@useResult
$Res call({
 String id, String groupId, String userId, GroupRole role, String displayName, String? avatarUrl, GroupMemberStatus status, int contributionBalance, DateTime? joinedAt, String invitedBy, DateTime invitedAt
});




}
/// @nodoc
class _$GroupMemberCopyWithImpl<$Res>
    implements $GroupMemberCopyWith<$Res> {
  _$GroupMemberCopyWithImpl(this._self, this._then);

  final GroupMember _self;
  final $Res Function(GroupMember) _then;

/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? userId = null,Object? role = null,Object? displayName = null,Object? avatarUrl = freezed,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as GroupRole,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupMemberStatus,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupMember].
extension GroupMemberPatterns on GroupMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupMember value)  $default,){
final _that = this;
switch (_that) {
case _GroupMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupMember value)?  $default,){
final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupId,  String userId,  GroupRole role,  String displayName,  String? avatarUrl,  GroupMemberStatus status,  int contributionBalance,  DateTime? joinedAt,  String invitedBy,  DateTime invitedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupId,  String userId,  GroupRole role,  String displayName,  String? avatarUrl,  GroupMemberStatus status,  int contributionBalance,  DateTime? joinedAt,  String invitedBy,  DateTime invitedAt)  $default,) {final _that = this;
switch (_that) {
case _GroupMember():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupId,  String userId,  GroupRole role,  String displayName,  String? avatarUrl,  GroupMemberStatus status,  int contributionBalance,  DateTime? joinedAt,  String invitedBy,  DateTime invitedAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
return $default(_that.id,_that.groupId,_that.userId,_that.role,_that.displayName,_that.avatarUrl,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupMember extends GroupMember {
  const _GroupMember({required this.id, required this.groupId, required this.userId, required this.role, required this.displayName, this.avatarUrl, required this.status, required this.contributionBalance, this.joinedAt, required this.invitedBy, required this.invitedAt}): super._();
  factory _GroupMember.fromJson(Map<String, dynamic> json) => _$GroupMemberFromJson(json);

@override final  String id;
@override final  String groupId;
@override final  String userId;
@override final  GroupRole role;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  GroupMemberStatus status;
@override final  int contributionBalance;
@override final  DateTime? joinedAt;
@override final  String invitedBy;
@override final  DateTime invitedAt;

/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupMemberCopyWith<_GroupMember> get copyWith => __$GroupMemberCopyWithImpl<_GroupMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupMember&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,userId,role,displayName,avatarUrl,status,contributionBalance,joinedAt,invitedBy,invitedAt);

@override
String toString() {
  return 'GroupMember(id: $id, groupId: $groupId, userId: $userId, role: $role, displayName: $displayName, avatarUrl: $avatarUrl, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt)';
}


}

/// @nodoc
abstract mixin class _$GroupMemberCopyWith<$Res> implements $GroupMemberCopyWith<$Res> {
  factory _$GroupMemberCopyWith(_GroupMember value, $Res Function(_GroupMember) _then) = __$GroupMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupId, String userId, GroupRole role, String displayName, String? avatarUrl, GroupMemberStatus status, int contributionBalance, DateTime? joinedAt, String invitedBy, DateTime invitedAt
});




}
/// @nodoc
class __$GroupMemberCopyWithImpl<$Res>
    implements _$GroupMemberCopyWith<$Res> {
  __$GroupMemberCopyWithImpl(this._self, this._then);

  final _GroupMember _self;
  final $Res Function(_GroupMember) _then;

/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? userId = null,Object? role = null,Object? displayName = null,Object? avatarUrl = freezed,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,}) {
  return _then(_GroupMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as GroupRole,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GroupMemberStatus,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
