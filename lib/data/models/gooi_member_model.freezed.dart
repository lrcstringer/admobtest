// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiMemberModel {

 String get id; String get userId; String get displayName; String? get avatarUrl; int get position; GooiMemberRole get role; GooiMemberStatus get status; int get contributedCycles; int get missedCycles; int get outstandingDebt; bool get autoContribute; String? get autoContributeSubAccountId; String? get preferredSubAccountId; DateTime? get delegationExpiresAt; DateTime? get joinedAt; DateTime get invitedAt;
/// Create a copy of GooiMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiMemberModelCopyWith<GooiMemberModel> get copyWith => _$GooiMemberModelCopyWithImpl<GooiMemberModel>(this as GooiMemberModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.position, position) || other.position == position)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributedCycles, contributedCycles) || other.contributedCycles == contributedCycles)&&(identical(other.missedCycles, missedCycles) || other.missedCycles == missedCycles)&&(identical(other.outstandingDebt, outstandingDebt) || other.outstandingDebt == outstandingDebt)&&(identical(other.autoContribute, autoContribute) || other.autoContribute == autoContribute)&&(identical(other.autoContributeSubAccountId, autoContributeSubAccountId) || other.autoContributeSubAccountId == autoContributeSubAccountId)&&(identical(other.preferredSubAccountId, preferredSubAccountId) || other.preferredSubAccountId == preferredSubAccountId)&&(identical(other.delegationExpiresAt, delegationExpiresAt) || other.delegationExpiresAt == delegationExpiresAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,displayName,avatarUrl,position,role,status,contributedCycles,missedCycles,outstandingDebt,autoContribute,autoContributeSubAccountId,preferredSubAccountId,delegationExpiresAt,joinedAt,invitedAt);

@override
String toString() {
  return 'GooiMemberModel(id: $id, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, position: $position, role: $role, status: $status, contributedCycles: $contributedCycles, missedCycles: $missedCycles, outstandingDebt: $outstandingDebt, autoContribute: $autoContribute, autoContributeSubAccountId: $autoContributeSubAccountId, preferredSubAccountId: $preferredSubAccountId, delegationExpiresAt: $delegationExpiresAt, joinedAt: $joinedAt, invitedAt: $invitedAt)';
}


}

/// @nodoc
abstract mixin class $GooiMemberModelCopyWith<$Res>  {
  factory $GooiMemberModelCopyWith(GooiMemberModel value, $Res Function(GooiMemberModel) _then) = _$GooiMemberModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String displayName, String? avatarUrl, int position, GooiMemberRole role, GooiMemberStatus status, int contributedCycles, int missedCycles, int outstandingDebt, bool autoContribute, String? autoContributeSubAccountId, String? preferredSubAccountId, DateTime? delegationExpiresAt, DateTime? joinedAt, DateTime invitedAt
});




}
/// @nodoc
class _$GooiMemberModelCopyWithImpl<$Res>
    implements $GooiMemberModelCopyWith<$Res> {
  _$GooiMemberModelCopyWithImpl(this._self, this._then);

  final GooiMemberModel _self;
  final $Res Function(GooiMemberModel) _then;

/// Create a copy of GooiMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? position = null,Object? role = null,Object? status = null,Object? contributedCycles = null,Object? missedCycles = null,Object? outstandingDebt = null,Object? autoContribute = null,Object? autoContributeSubAccountId = freezed,Object? preferredSubAccountId = freezed,Object? delegationExpiresAt = freezed,Object? joinedAt = freezed,Object? invitedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as GooiMemberRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiMemberStatus,contributedCycles: null == contributedCycles ? _self.contributedCycles : contributedCycles // ignore: cast_nullable_to_non_nullable
as int,missedCycles: null == missedCycles ? _self.missedCycles : missedCycles // ignore: cast_nullable_to_non_nullable
as int,outstandingDebt: null == outstandingDebt ? _self.outstandingDebt : outstandingDebt // ignore: cast_nullable_to_non_nullable
as int,autoContribute: null == autoContribute ? _self.autoContribute : autoContribute // ignore: cast_nullable_to_non_nullable
as bool,autoContributeSubAccountId: freezed == autoContributeSubAccountId ? _self.autoContributeSubAccountId : autoContributeSubAccountId // ignore: cast_nullable_to_non_nullable
as String?,preferredSubAccountId: freezed == preferredSubAccountId ? _self.preferredSubAccountId : preferredSubAccountId // ignore: cast_nullable_to_non_nullable
as String?,delegationExpiresAt: freezed == delegationExpiresAt ? _self.delegationExpiresAt : delegationExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GooiMemberModel].
extension GooiMemberModelPatterns on GooiMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _GooiMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _GooiMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? avatarUrl,  int position,  GooiMemberRole role,  GooiMemberStatus status,  int contributedCycles,  int missedCycles,  int outstandingDebt,  bool autoContribute,  String? autoContributeSubAccountId,  String? preferredSubAccountId,  DateTime? delegationExpiresAt,  DateTime? joinedAt,  DateTime invitedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiMemberModel() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.avatarUrl,_that.position,_that.role,_that.status,_that.contributedCycles,_that.missedCycles,_that.outstandingDebt,_that.autoContribute,_that.autoContributeSubAccountId,_that.preferredSubAccountId,_that.delegationExpiresAt,_that.joinedAt,_that.invitedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? avatarUrl,  int position,  GooiMemberRole role,  GooiMemberStatus status,  int contributedCycles,  int missedCycles,  int outstandingDebt,  bool autoContribute,  String? autoContributeSubAccountId,  String? preferredSubAccountId,  DateTime? delegationExpiresAt,  DateTime? joinedAt,  DateTime invitedAt)  $default,) {final _that = this;
switch (_that) {
case _GooiMemberModel():
return $default(_that.id,_that.userId,_that.displayName,_that.avatarUrl,_that.position,_that.role,_that.status,_that.contributedCycles,_that.missedCycles,_that.outstandingDebt,_that.autoContribute,_that.autoContributeSubAccountId,_that.preferredSubAccountId,_that.delegationExpiresAt,_that.joinedAt,_that.invitedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String displayName,  String? avatarUrl,  int position,  GooiMemberRole role,  GooiMemberStatus status,  int contributedCycles,  int missedCycles,  int outstandingDebt,  bool autoContribute,  String? autoContributeSubAccountId,  String? preferredSubAccountId,  DateTime? delegationExpiresAt,  DateTime? joinedAt,  DateTime invitedAt)?  $default,) {final _that = this;
switch (_that) {
case _GooiMemberModel() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.avatarUrl,_that.position,_that.role,_that.status,_that.contributedCycles,_that.missedCycles,_that.outstandingDebt,_that.autoContribute,_that.autoContributeSubAccountId,_that.preferredSubAccountId,_that.delegationExpiresAt,_that.joinedAt,_that.invitedAt);case _:
  return null;

}
}

}

/// @nodoc


class _GooiMemberModel extends GooiMemberModel {
  const _GooiMemberModel({required this.id, required this.userId, required this.displayName, this.avatarUrl, this.position = 0, required this.role, required this.status, this.contributedCycles = 0, this.missedCycles = 0, this.outstandingDebt = 0, this.autoContribute = false, this.autoContributeSubAccountId, this.preferredSubAccountId, this.delegationExpiresAt, this.joinedAt, required this.invitedAt}): super._();
  

@override final  String id;
@override final  String userId;
@override final  String displayName;
@override final  String? avatarUrl;
@override@JsonKey() final  int position;
@override final  GooiMemberRole role;
@override final  GooiMemberStatus status;
@override@JsonKey() final  int contributedCycles;
@override@JsonKey() final  int missedCycles;
@override@JsonKey() final  int outstandingDebt;
@override@JsonKey() final  bool autoContribute;
@override final  String? autoContributeSubAccountId;
@override final  String? preferredSubAccountId;
@override final  DateTime? delegationExpiresAt;
@override final  DateTime? joinedAt;
@override final  DateTime invitedAt;

/// Create a copy of GooiMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiMemberModelCopyWith<_GooiMemberModel> get copyWith => __$GooiMemberModelCopyWithImpl<_GooiMemberModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.position, position) || other.position == position)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.contributedCycles, contributedCycles) || other.contributedCycles == contributedCycles)&&(identical(other.missedCycles, missedCycles) || other.missedCycles == missedCycles)&&(identical(other.outstandingDebt, outstandingDebt) || other.outstandingDebt == outstandingDebt)&&(identical(other.autoContribute, autoContribute) || other.autoContribute == autoContribute)&&(identical(other.autoContributeSubAccountId, autoContributeSubAccountId) || other.autoContributeSubAccountId == autoContributeSubAccountId)&&(identical(other.preferredSubAccountId, preferredSubAccountId) || other.preferredSubAccountId == preferredSubAccountId)&&(identical(other.delegationExpiresAt, delegationExpiresAt) || other.delegationExpiresAt == delegationExpiresAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,displayName,avatarUrl,position,role,status,contributedCycles,missedCycles,outstandingDebt,autoContribute,autoContributeSubAccountId,preferredSubAccountId,delegationExpiresAt,joinedAt,invitedAt);

@override
String toString() {
  return 'GooiMemberModel(id: $id, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, position: $position, role: $role, status: $status, contributedCycles: $contributedCycles, missedCycles: $missedCycles, outstandingDebt: $outstandingDebt, autoContribute: $autoContribute, autoContributeSubAccountId: $autoContributeSubAccountId, preferredSubAccountId: $preferredSubAccountId, delegationExpiresAt: $delegationExpiresAt, joinedAt: $joinedAt, invitedAt: $invitedAt)';
}


}

/// @nodoc
abstract mixin class _$GooiMemberModelCopyWith<$Res> implements $GooiMemberModelCopyWith<$Res> {
  factory _$GooiMemberModelCopyWith(_GooiMemberModel value, $Res Function(_GooiMemberModel) _then) = __$GooiMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String displayName, String? avatarUrl, int position, GooiMemberRole role, GooiMemberStatus status, int contributedCycles, int missedCycles, int outstandingDebt, bool autoContribute, String? autoContributeSubAccountId, String? preferredSubAccountId, DateTime? delegationExpiresAt, DateTime? joinedAt, DateTime invitedAt
});




}
/// @nodoc
class __$GooiMemberModelCopyWithImpl<$Res>
    implements _$GooiMemberModelCopyWith<$Res> {
  __$GooiMemberModelCopyWithImpl(this._self, this._then);

  final _GooiMemberModel _self;
  final $Res Function(_GooiMemberModel) _then;

/// Create a copy of GooiMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? position = null,Object? role = null,Object? status = null,Object? contributedCycles = null,Object? missedCycles = null,Object? outstandingDebt = null,Object? autoContribute = null,Object? autoContributeSubAccountId = freezed,Object? preferredSubAccountId = freezed,Object? delegationExpiresAt = freezed,Object? joinedAt = freezed,Object? invitedAt = null,}) {
  return _then(_GooiMemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as GooiMemberRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiMemberStatus,contributedCycles: null == contributedCycles ? _self.contributedCycles : contributedCycles // ignore: cast_nullable_to_non_nullable
as int,missedCycles: null == missedCycles ? _self.missedCycles : missedCycles // ignore: cast_nullable_to_non_nullable
as int,outstandingDebt: null == outstandingDebt ? _self.outstandingDebt : outstandingDebt // ignore: cast_nullable_to_non_nullable
as int,autoContribute: null == autoContribute ? _self.autoContribute : autoContribute // ignore: cast_nullable_to_non_nullable
as bool,autoContributeSubAccountId: freezed == autoContributeSubAccountId ? _self.autoContributeSubAccountId : autoContributeSubAccountId // ignore: cast_nullable_to_non_nullable
as String?,preferredSubAccountId: freezed == preferredSubAccountId ? _self.preferredSubAccountId : preferredSubAccountId // ignore: cast_nullable_to_non_nullable
as String?,delegationExpiresAt: freezed == delegationExpiresAt ? _self.delegationExpiresAt : delegationExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedAt: null == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
