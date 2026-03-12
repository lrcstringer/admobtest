// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_debt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiDebtModel {

 String get id; String get userId; String get groupId; int get amount; String get reason; GooiDebtStatus get status; DateTime get createdAt; DateTime? get resolvedAt;
/// Create a copy of GooiDebtModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiDebtModelCopyWith<GooiDebtModel> get copyWith => _$GooiDebtModelCopyWithImpl<GooiDebtModel>(this as GooiDebtModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiDebtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,groupId,amount,reason,status,createdAt,resolvedAt);

@override
String toString() {
  return 'GooiDebtModel(id: $id, userId: $userId, groupId: $groupId, amount: $amount, reason: $reason, status: $status, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $GooiDebtModelCopyWith<$Res>  {
  factory $GooiDebtModelCopyWith(GooiDebtModel value, $Res Function(GooiDebtModel) _then) = _$GooiDebtModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String groupId, int amount, String reason, GooiDebtStatus status, DateTime createdAt, DateTime? resolvedAt
});




}
/// @nodoc
class _$GooiDebtModelCopyWithImpl<$Res>
    implements $GooiDebtModelCopyWith<$Res> {
  _$GooiDebtModelCopyWithImpl(this._self, this._then);

  final GooiDebtModel _self;
  final $Res Function(GooiDebtModel) _then;

/// Create a copy of GooiDebtModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? groupId = null,Object? amount = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiDebtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GooiDebtModel].
extension GooiDebtModelPatterns on GooiDebtModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiDebtModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiDebtModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiDebtModel value)  $default,){
final _that = this;
switch (_that) {
case _GooiDebtModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiDebtModel value)?  $default,){
final _that = this;
switch (_that) {
case _GooiDebtModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String groupId,  int amount,  String reason,  GooiDebtStatus status,  DateTime createdAt,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiDebtModel() when $default != null:
return $default(_that.id,_that.userId,_that.groupId,_that.amount,_that.reason,_that.status,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String groupId,  int amount,  String reason,  GooiDebtStatus status,  DateTime createdAt,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _GooiDebtModel():
return $default(_that.id,_that.userId,_that.groupId,_that.amount,_that.reason,_that.status,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String groupId,  int amount,  String reason,  GooiDebtStatus status,  DateTime createdAt,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _GooiDebtModel() when $default != null:
return $default(_that.id,_that.userId,_that.groupId,_that.amount,_that.reason,_that.status,_that.createdAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc


class _GooiDebtModel extends GooiDebtModel {
  const _GooiDebtModel({required this.id, required this.userId, required this.groupId, required this.amount, required this.reason, required this.status, required this.createdAt, this.resolvedAt}): super._();
  

@override final  String id;
@override final  String userId;
@override final  String groupId;
@override final  int amount;
@override final  String reason;
@override final  GooiDebtStatus status;
@override final  DateTime createdAt;
@override final  DateTime? resolvedAt;

/// Create a copy of GooiDebtModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiDebtModelCopyWith<_GooiDebtModel> get copyWith => __$GooiDebtModelCopyWithImpl<_GooiDebtModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiDebtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,groupId,amount,reason,status,createdAt,resolvedAt);

@override
String toString() {
  return 'GooiDebtModel(id: $id, userId: $userId, groupId: $groupId, amount: $amount, reason: $reason, status: $status, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$GooiDebtModelCopyWith<$Res> implements $GooiDebtModelCopyWith<$Res> {
  factory _$GooiDebtModelCopyWith(_GooiDebtModel value, $Res Function(_GooiDebtModel) _then) = __$GooiDebtModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String groupId, int amount, String reason, GooiDebtStatus status, DateTime createdAt, DateTime? resolvedAt
});




}
/// @nodoc
class __$GooiDebtModelCopyWithImpl<$Res>
    implements _$GooiDebtModelCopyWith<$Res> {
  __$GooiDebtModelCopyWithImpl(this._self, this._then);

  final _GooiDebtModel _self;
  final $Res Function(_GooiDebtModel) _then;

/// Create a copy of GooiDebtModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? groupId = null,Object? amount = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? resolvedAt = freezed,}) {
  return _then(_GooiDebtModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiDebtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
