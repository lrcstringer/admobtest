// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityMember {

 String get id; String get communityId; String get userId; String get displayName; String? get avatarUrl; MemberRole get role; MemberStatus get status; int get contributionBalance; DateTime? get joinedAt; String get invitedBy; DateTime get invitedAt; DateTime? get lastReadAt;/// Name of the community this member belongs to (denormalized for invitations).
 String? get communityName;
/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityMemberCopyWith<CommunityMember> get copyWith => _$CommunityMemberCopyWithImpl<CommunityMember>(this as CommunityMember, _$identity);

  /// Serializes this CommunityMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMember&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt)&&(identical(other.communityName, communityName) || other.communityName == communityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,userId,displayName,avatarUrl,role,status,contributionBalance,joinedAt,invitedBy,invitedAt,lastReadAt,communityName);

@override
String toString() {
  return 'CommunityMember(id: $id, communityId: $communityId, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, role: $role, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt, lastReadAt: $lastReadAt, communityName: $communityName)';
}


}

/// @nodoc
abstract mixin class $CommunityMemberCopyWith<$Res>  {
  factory $CommunityMemberCopyWith(CommunityMember value, $Res Function(CommunityMember) _then) = _$CommunityMemberCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String userId, String displayName, String? avatarUrl, MemberRole role, MemberStatus status, int contributionBalance, DateTime? joinedAt, String invitedBy, DateTime invitedAt, DateTime? lastReadAt, String? communityName
});




}
/// @nodoc
class _$CommunityMemberCopyWithImpl<$Res>
    implements $CommunityMemberCopyWith<$Res> {
  _$CommunityMemberCopyWithImpl(this._self, this._then);

  final CommunityMember _self;
  final $Res Function(CommunityMember) _then;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? role = null,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,Object? lastReadAt = freezed,Object? communityName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MemberStatus,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,communityName: freezed == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityMember].
extension CommunityMemberPatterns on CommunityMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityMember value)  $default,){
final _that = this;
switch (_that) {
case _CommunityMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityMember value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String userId,  String displayName,  String? avatarUrl,  MemberRole role,  MemberStatus status,  int contributionBalance,  DateTime? joinedAt,  String invitedBy,  DateTime invitedAt,  DateTime? lastReadAt,  String? communityName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String userId,  String displayName,  String? avatarUrl,  MemberRole role,  MemberStatus status,  int contributionBalance,  DateTime? joinedAt,  String invitedBy,  DateTime invitedAt,  DateTime? lastReadAt,  String? communityName)  $default,) {final _that = this;
switch (_that) {
case _CommunityMember():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String userId,  String displayName,  String? avatarUrl,  MemberRole role,  MemberStatus status,  int contributionBalance,  DateTime? joinedAt,  String invitedBy,  DateTime invitedAt,  DateTime? lastReadAt,  String? communityName)?  $default,) {final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
return $default(_that.id,_that.communityId,_that.userId,_that.displayName,_that.avatarUrl,_that.role,_that.status,_that.contributionBalance,_that.joinedAt,_that.invitedBy,_that.invitedAt,_that.lastReadAt,_that.communityName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityMember extends CommunityMember {
  const _CommunityMember({required this.id, required this.communityId, required this.userId, required this.displayName, this.avatarUrl, required this.role, required this.status, this.contributionBalance = 0, this.joinedAt, required this.invitedBy, required this.invitedAt, this.lastReadAt, this.communityName}): super._();
  factory _CommunityMember.fromJson(Map<String, dynamic> json) => _$CommunityMemberFromJson(json);

@override final  String id;
@override final  String communityId;
@override final  String userId;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  MemberRole role;
@override final  MemberStatus status;
@override@JsonKey() final  int contributionBalance;
@override final  DateTime? joinedAt;
@override final  String invitedBy;
@override final  DateTime invitedAt;
@override final  DateTime? lastReadAt;
/// Name of the community this member belongs to (denormalized for invitations).
@override final  String? communityName;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityMemberCopyWith<_CommunityMember> get copyWith => __$CommunityMemberCopyWithImpl<_CommunityMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityMember&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributionBalance, contributionBalance) || other.contributionBalance == contributionBalance)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt)&&(identical(other.communityName, communityName) || other.communityName == communityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,userId,displayName,avatarUrl,role,status,contributionBalance,joinedAt,invitedBy,invitedAt,lastReadAt,communityName);

@override
String toString() {
  return 'CommunityMember(id: $id, communityId: $communityId, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, role: $role, status: $status, contributionBalance: $contributionBalance, joinedAt: $joinedAt, invitedBy: $invitedBy, invitedAt: $invitedAt, lastReadAt: $lastReadAt, communityName: $communityName)';
}


}

/// @nodoc
abstract mixin class _$CommunityMemberCopyWith<$Res> implements $CommunityMemberCopyWith<$Res> {
  factory _$CommunityMemberCopyWith(_CommunityMember value, $Res Function(_CommunityMember) _then) = __$CommunityMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String userId, String displayName, String? avatarUrl, MemberRole role, MemberStatus status, int contributionBalance, DateTime? joinedAt, String invitedBy, DateTime invitedAt, DateTime? lastReadAt, String? communityName
});




}
/// @nodoc
class __$CommunityMemberCopyWithImpl<$Res>
    implements _$CommunityMemberCopyWith<$Res> {
  __$CommunityMemberCopyWithImpl(this._self, this._then);

  final _CommunityMember _self;
  final $Res Function(_CommunityMember) _then;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? role = null,Object? status = null,Object? contributionBalance = null,Object? joinedAt = freezed,Object? invitedBy = null,Object? invitedAt = null,Object? lastReadAt = freezed,Object? communityName = freezed,}) {
  return _then(_CommunityMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MemberStatus,contributionBalance: null == contributionBalance ? _self.contributionBalance : contributionBalance // ignore: cast_nullable_to_non_nullable
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
