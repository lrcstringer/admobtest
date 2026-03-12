// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_cycle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiCycleModel {

 String get id; int get cycleNumber; int get rotationNumber; String? get recipientMemberId; String get recipientUserId; DateTime get dueDate; DateTime get graceCloseDate; GooiCycleStatus get status; int get totalExpected; int get totalCollected; int get reserveCollected; int get payoutAmount; int get shortfallAmount; List<String> get defaulterMemberIds; String? get triggeredBy; DateTime? get triggeredAt; DateTime? get completedAt; DateTime? get autoTriggerAt; int get graceExtendedBy; String? get graceExtensionVoteId;
/// Create a copy of GooiCycleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiCycleModelCopyWith<GooiCycleModel> get copyWith => _$GooiCycleModelCopyWithImpl<GooiCycleModel>(this as GooiCycleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiCycleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.rotationNumber, rotationNumber) || other.rotationNumber == rotationNumber)&&(identical(other.recipientMemberId, recipientMemberId) || other.recipientMemberId == recipientMemberId)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.graceCloseDate, graceCloseDate) || other.graceCloseDate == graceCloseDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalExpected, totalExpected) || other.totalExpected == totalExpected)&&(identical(other.totalCollected, totalCollected) || other.totalCollected == totalCollected)&&(identical(other.reserveCollected, reserveCollected) || other.reserveCollected == reserveCollected)&&(identical(other.payoutAmount, payoutAmount) || other.payoutAmount == payoutAmount)&&(identical(other.shortfallAmount, shortfallAmount) || other.shortfallAmount == shortfallAmount)&&const DeepCollectionEquality().equals(other.defaulterMemberIds, defaulterMemberIds)&&(identical(other.triggeredBy, triggeredBy) || other.triggeredBy == triggeredBy)&&(identical(other.triggeredAt, triggeredAt) || other.triggeredAt == triggeredAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.autoTriggerAt, autoTriggerAt) || other.autoTriggerAt == autoTriggerAt)&&(identical(other.graceExtendedBy, graceExtendedBy) || other.graceExtendedBy == graceExtendedBy)&&(identical(other.graceExtensionVoteId, graceExtensionVoteId) || other.graceExtensionVoteId == graceExtensionVoteId));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,cycleNumber,rotationNumber,recipientMemberId,recipientUserId,dueDate,graceCloseDate,status,totalExpected,totalCollected,reserveCollected,payoutAmount,shortfallAmount,const DeepCollectionEquality().hash(defaulterMemberIds),triggeredBy,triggeredAt,completedAt,autoTriggerAt,graceExtendedBy,graceExtensionVoteId]);

@override
String toString() {
  return 'GooiCycleModel(id: $id, cycleNumber: $cycleNumber, rotationNumber: $rotationNumber, recipientMemberId: $recipientMemberId, recipientUserId: $recipientUserId, dueDate: $dueDate, graceCloseDate: $graceCloseDate, status: $status, totalExpected: $totalExpected, totalCollected: $totalCollected, reserveCollected: $reserveCollected, payoutAmount: $payoutAmount, shortfallAmount: $shortfallAmount, defaulterMemberIds: $defaulterMemberIds, triggeredBy: $triggeredBy, triggeredAt: $triggeredAt, completedAt: $completedAt, autoTriggerAt: $autoTriggerAt, graceExtendedBy: $graceExtendedBy, graceExtensionVoteId: $graceExtensionVoteId)';
}


}

/// @nodoc
abstract mixin class $GooiCycleModelCopyWith<$Res>  {
  factory $GooiCycleModelCopyWith(GooiCycleModel value, $Res Function(GooiCycleModel) _then) = _$GooiCycleModelCopyWithImpl;
@useResult
$Res call({
 String id, int cycleNumber, int rotationNumber, String? recipientMemberId, String recipientUserId, DateTime dueDate, DateTime graceCloseDate, GooiCycleStatus status, int totalExpected, int totalCollected, int reserveCollected, int payoutAmount, int shortfallAmount, List<String> defaulterMemberIds, String? triggeredBy, DateTime? triggeredAt, DateTime? completedAt, DateTime? autoTriggerAt, int graceExtendedBy, String? graceExtensionVoteId
});




}
/// @nodoc
class _$GooiCycleModelCopyWithImpl<$Res>
    implements $GooiCycleModelCopyWith<$Res> {
  _$GooiCycleModelCopyWithImpl(this._self, this._then);

  final GooiCycleModel _self;
  final $Res Function(GooiCycleModel) _then;

/// Create a copy of GooiCycleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cycleNumber = null,Object? rotationNumber = null,Object? recipientMemberId = freezed,Object? recipientUserId = null,Object? dueDate = null,Object? graceCloseDate = null,Object? status = null,Object? totalExpected = null,Object? totalCollected = null,Object? reserveCollected = null,Object? payoutAmount = null,Object? shortfallAmount = null,Object? defaulterMemberIds = null,Object? triggeredBy = freezed,Object? triggeredAt = freezed,Object? completedAt = freezed,Object? autoTriggerAt = freezed,Object? graceExtendedBy = null,Object? graceExtensionVoteId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,rotationNumber: null == rotationNumber ? _self.rotationNumber : rotationNumber // ignore: cast_nullable_to_non_nullable
as int,recipientMemberId: freezed == recipientMemberId ? _self.recipientMemberId : recipientMemberId // ignore: cast_nullable_to_non_nullable
as String?,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,graceCloseDate: null == graceCloseDate ? _self.graceCloseDate : graceCloseDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiCycleStatus,totalExpected: null == totalExpected ? _self.totalExpected : totalExpected // ignore: cast_nullable_to_non_nullable
as int,totalCollected: null == totalCollected ? _self.totalCollected : totalCollected // ignore: cast_nullable_to_non_nullable
as int,reserveCollected: null == reserveCollected ? _self.reserveCollected : reserveCollected // ignore: cast_nullable_to_non_nullable
as int,payoutAmount: null == payoutAmount ? _self.payoutAmount : payoutAmount // ignore: cast_nullable_to_non_nullable
as int,shortfallAmount: null == shortfallAmount ? _self.shortfallAmount : shortfallAmount // ignore: cast_nullable_to_non_nullable
as int,defaulterMemberIds: null == defaulterMemberIds ? _self.defaulterMemberIds : defaulterMemberIds // ignore: cast_nullable_to_non_nullable
as List<String>,triggeredBy: freezed == triggeredBy ? _self.triggeredBy : triggeredBy // ignore: cast_nullable_to_non_nullable
as String?,triggeredAt: freezed == triggeredAt ? _self.triggeredAt : triggeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,autoTriggerAt: freezed == autoTriggerAt ? _self.autoTriggerAt : autoTriggerAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graceExtendedBy: null == graceExtendedBy ? _self.graceExtendedBy : graceExtendedBy // ignore: cast_nullable_to_non_nullable
as int,graceExtensionVoteId: freezed == graceExtensionVoteId ? _self.graceExtensionVoteId : graceExtensionVoteId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GooiCycleModel].
extension GooiCycleModelPatterns on GooiCycleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiCycleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiCycleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiCycleModel value)  $default,){
final _that = this;
switch (_that) {
case _GooiCycleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiCycleModel value)?  $default,){
final _that = this;
switch (_that) {
case _GooiCycleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int cycleNumber,  int rotationNumber,  String? recipientMemberId,  String recipientUserId,  DateTime dueDate,  DateTime graceCloseDate,  GooiCycleStatus status,  int totalExpected,  int totalCollected,  int reserveCollected,  int payoutAmount,  int shortfallAmount,  List<String> defaulterMemberIds,  String? triggeredBy,  DateTime? triggeredAt,  DateTime? completedAt,  DateTime? autoTriggerAt,  int graceExtendedBy,  String? graceExtensionVoteId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiCycleModel() when $default != null:
return $default(_that.id,_that.cycleNumber,_that.rotationNumber,_that.recipientMemberId,_that.recipientUserId,_that.dueDate,_that.graceCloseDate,_that.status,_that.totalExpected,_that.totalCollected,_that.reserveCollected,_that.payoutAmount,_that.shortfallAmount,_that.defaulterMemberIds,_that.triggeredBy,_that.triggeredAt,_that.completedAt,_that.autoTriggerAt,_that.graceExtendedBy,_that.graceExtensionVoteId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int cycleNumber,  int rotationNumber,  String? recipientMemberId,  String recipientUserId,  DateTime dueDate,  DateTime graceCloseDate,  GooiCycleStatus status,  int totalExpected,  int totalCollected,  int reserveCollected,  int payoutAmount,  int shortfallAmount,  List<String> defaulterMemberIds,  String? triggeredBy,  DateTime? triggeredAt,  DateTime? completedAt,  DateTime? autoTriggerAt,  int graceExtendedBy,  String? graceExtensionVoteId)  $default,) {final _that = this;
switch (_that) {
case _GooiCycleModel():
return $default(_that.id,_that.cycleNumber,_that.rotationNumber,_that.recipientMemberId,_that.recipientUserId,_that.dueDate,_that.graceCloseDate,_that.status,_that.totalExpected,_that.totalCollected,_that.reserveCollected,_that.payoutAmount,_that.shortfallAmount,_that.defaulterMemberIds,_that.triggeredBy,_that.triggeredAt,_that.completedAt,_that.autoTriggerAt,_that.graceExtendedBy,_that.graceExtensionVoteId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int cycleNumber,  int rotationNumber,  String? recipientMemberId,  String recipientUserId,  DateTime dueDate,  DateTime graceCloseDate,  GooiCycleStatus status,  int totalExpected,  int totalCollected,  int reserveCollected,  int payoutAmount,  int shortfallAmount,  List<String> defaulterMemberIds,  String? triggeredBy,  DateTime? triggeredAt,  DateTime? completedAt,  DateTime? autoTriggerAt,  int graceExtendedBy,  String? graceExtensionVoteId)?  $default,) {final _that = this;
switch (_that) {
case _GooiCycleModel() when $default != null:
return $default(_that.id,_that.cycleNumber,_that.rotationNumber,_that.recipientMemberId,_that.recipientUserId,_that.dueDate,_that.graceCloseDate,_that.status,_that.totalExpected,_that.totalCollected,_that.reserveCollected,_that.payoutAmount,_that.shortfallAmount,_that.defaulterMemberIds,_that.triggeredBy,_that.triggeredAt,_that.completedAt,_that.autoTriggerAt,_that.graceExtendedBy,_that.graceExtensionVoteId);case _:
  return null;

}
}

}

/// @nodoc


class _GooiCycleModel extends GooiCycleModel {
  const _GooiCycleModel({required this.id, required this.cycleNumber, this.rotationNumber = 1, this.recipientMemberId, required this.recipientUserId, required this.dueDate, required this.graceCloseDate, required this.status, this.totalExpected = 0, this.totalCollected = 0, this.reserveCollected = 0, this.payoutAmount = 0, this.shortfallAmount = 0, final  List<String> defaulterMemberIds = const [], this.triggeredBy, this.triggeredAt, this.completedAt, this.autoTriggerAt, this.graceExtendedBy = 0, this.graceExtensionVoteId}): _defaulterMemberIds = defaulterMemberIds,super._();
  

@override final  String id;
@override final  int cycleNumber;
@override@JsonKey() final  int rotationNumber;
@override final  String? recipientMemberId;
@override final  String recipientUserId;
@override final  DateTime dueDate;
@override final  DateTime graceCloseDate;
@override final  GooiCycleStatus status;
@override@JsonKey() final  int totalExpected;
@override@JsonKey() final  int totalCollected;
@override@JsonKey() final  int reserveCollected;
@override@JsonKey() final  int payoutAmount;
@override@JsonKey() final  int shortfallAmount;
 final  List<String> _defaulterMemberIds;
@override@JsonKey() List<String> get defaulterMemberIds {
  if (_defaulterMemberIds is EqualUnmodifiableListView) return _defaulterMemberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_defaulterMemberIds);
}

@override final  String? triggeredBy;
@override final  DateTime? triggeredAt;
@override final  DateTime? completedAt;
@override final  DateTime? autoTriggerAt;
@override@JsonKey() final  int graceExtendedBy;
@override final  String? graceExtensionVoteId;

/// Create a copy of GooiCycleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiCycleModelCopyWith<_GooiCycleModel> get copyWith => __$GooiCycleModelCopyWithImpl<_GooiCycleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiCycleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.rotationNumber, rotationNumber) || other.rotationNumber == rotationNumber)&&(identical(other.recipientMemberId, recipientMemberId) || other.recipientMemberId == recipientMemberId)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.graceCloseDate, graceCloseDate) || other.graceCloseDate == graceCloseDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalExpected, totalExpected) || other.totalExpected == totalExpected)&&(identical(other.totalCollected, totalCollected) || other.totalCollected == totalCollected)&&(identical(other.reserveCollected, reserveCollected) || other.reserveCollected == reserveCollected)&&(identical(other.payoutAmount, payoutAmount) || other.payoutAmount == payoutAmount)&&(identical(other.shortfallAmount, shortfallAmount) || other.shortfallAmount == shortfallAmount)&&const DeepCollectionEquality().equals(other._defaulterMemberIds, _defaulterMemberIds)&&(identical(other.triggeredBy, triggeredBy) || other.triggeredBy == triggeredBy)&&(identical(other.triggeredAt, triggeredAt) || other.triggeredAt == triggeredAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.autoTriggerAt, autoTriggerAt) || other.autoTriggerAt == autoTriggerAt)&&(identical(other.graceExtendedBy, graceExtendedBy) || other.graceExtendedBy == graceExtendedBy)&&(identical(other.graceExtensionVoteId, graceExtensionVoteId) || other.graceExtensionVoteId == graceExtensionVoteId));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,cycleNumber,rotationNumber,recipientMemberId,recipientUserId,dueDate,graceCloseDate,status,totalExpected,totalCollected,reserveCollected,payoutAmount,shortfallAmount,const DeepCollectionEquality().hash(_defaulterMemberIds),triggeredBy,triggeredAt,completedAt,autoTriggerAt,graceExtendedBy,graceExtensionVoteId]);

@override
String toString() {
  return 'GooiCycleModel(id: $id, cycleNumber: $cycleNumber, rotationNumber: $rotationNumber, recipientMemberId: $recipientMemberId, recipientUserId: $recipientUserId, dueDate: $dueDate, graceCloseDate: $graceCloseDate, status: $status, totalExpected: $totalExpected, totalCollected: $totalCollected, reserveCollected: $reserveCollected, payoutAmount: $payoutAmount, shortfallAmount: $shortfallAmount, defaulterMemberIds: $defaulterMemberIds, triggeredBy: $triggeredBy, triggeredAt: $triggeredAt, completedAt: $completedAt, autoTriggerAt: $autoTriggerAt, graceExtendedBy: $graceExtendedBy, graceExtensionVoteId: $graceExtensionVoteId)';
}


}

/// @nodoc
abstract mixin class _$GooiCycleModelCopyWith<$Res> implements $GooiCycleModelCopyWith<$Res> {
  factory _$GooiCycleModelCopyWith(_GooiCycleModel value, $Res Function(_GooiCycleModel) _then) = __$GooiCycleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, int cycleNumber, int rotationNumber, String? recipientMemberId, String recipientUserId, DateTime dueDate, DateTime graceCloseDate, GooiCycleStatus status, int totalExpected, int totalCollected, int reserveCollected, int payoutAmount, int shortfallAmount, List<String> defaulterMemberIds, String? triggeredBy, DateTime? triggeredAt, DateTime? completedAt, DateTime? autoTriggerAt, int graceExtendedBy, String? graceExtensionVoteId
});




}
/// @nodoc
class __$GooiCycleModelCopyWithImpl<$Res>
    implements _$GooiCycleModelCopyWith<$Res> {
  __$GooiCycleModelCopyWithImpl(this._self, this._then);

  final _GooiCycleModel _self;
  final $Res Function(_GooiCycleModel) _then;

/// Create a copy of GooiCycleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cycleNumber = null,Object? rotationNumber = null,Object? recipientMemberId = freezed,Object? recipientUserId = null,Object? dueDate = null,Object? graceCloseDate = null,Object? status = null,Object? totalExpected = null,Object? totalCollected = null,Object? reserveCollected = null,Object? payoutAmount = null,Object? shortfallAmount = null,Object? defaulterMemberIds = null,Object? triggeredBy = freezed,Object? triggeredAt = freezed,Object? completedAt = freezed,Object? autoTriggerAt = freezed,Object? graceExtendedBy = null,Object? graceExtensionVoteId = freezed,}) {
  return _then(_GooiCycleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,rotationNumber: null == rotationNumber ? _self.rotationNumber : rotationNumber // ignore: cast_nullable_to_non_nullable
as int,recipientMemberId: freezed == recipientMemberId ? _self.recipientMemberId : recipientMemberId // ignore: cast_nullable_to_non_nullable
as String?,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,graceCloseDate: null == graceCloseDate ? _self.graceCloseDate : graceCloseDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiCycleStatus,totalExpected: null == totalExpected ? _self.totalExpected : totalExpected // ignore: cast_nullable_to_non_nullable
as int,totalCollected: null == totalCollected ? _self.totalCollected : totalCollected // ignore: cast_nullable_to_non_nullable
as int,reserveCollected: null == reserveCollected ? _self.reserveCollected : reserveCollected // ignore: cast_nullable_to_non_nullable
as int,payoutAmount: null == payoutAmount ? _self.payoutAmount : payoutAmount // ignore: cast_nullable_to_non_nullable
as int,shortfallAmount: null == shortfallAmount ? _self.shortfallAmount : shortfallAmount // ignore: cast_nullable_to_non_nullable
as int,defaulterMemberIds: null == defaulterMemberIds ? _self._defaulterMemberIds : defaulterMemberIds // ignore: cast_nullable_to_non_nullable
as List<String>,triggeredBy: freezed == triggeredBy ? _self.triggeredBy : triggeredBy // ignore: cast_nullable_to_non_nullable
as String?,triggeredAt: freezed == triggeredAt ? _self.triggeredAt : triggeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,autoTriggerAt: freezed == autoTriggerAt ? _self.autoTriggerAt : autoTriggerAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graceExtendedBy: null == graceExtendedBy ? _self.graceExtendedBy : graceExtendedBy // ignore: cast_nullable_to_non_nullable
as int,graceExtensionVoteId: freezed == graceExtensionVoteId ? _self.graceExtensionVoteId : graceExtensionVoteId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
