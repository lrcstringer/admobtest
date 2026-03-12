// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiGroupModel {

 String get id; String get name; int get contributionAmount; GooiCycleFrequency get cycleFrequency; int get memberCount; int get totalCycles; int get currentCycleNumber; GooiGroupStatus get status; GooiRosterMethod get rosterMethod; double get reserveRate; int get gracePeriodHours; bool get recipientContributes; int get lateFeePercent; String get initiatorUserId; String? get conversationId; List<String> get rosterOrder; List<String> get memberUserIds; int get biddingDiscountPool; DateTime get createdAt; DateTime? get activatedAt; DateTime? get completedAt; GooiCycleSummary? get currentCycle;
/// Create a copy of GooiGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiGroupModelCopyWith<GooiGroupModel> get copyWith => _$GooiGroupModelCopyWithImpl<GooiGroupModel>(this as GooiGroupModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.cycleFrequency, cycleFrequency) || other.cycleFrequency == cycleFrequency)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.currentCycleNumber, currentCycleNumber) || other.currentCycleNumber == currentCycleNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.rosterMethod, rosterMethod) || other.rosterMethod == rosterMethod)&&(identical(other.reserveRate, reserveRate) || other.reserveRate == reserveRate)&&(identical(other.gracePeriodHours, gracePeriodHours) || other.gracePeriodHours == gracePeriodHours)&&(identical(other.recipientContributes, recipientContributes) || other.recipientContributes == recipientContributes)&&(identical(other.lateFeePercent, lateFeePercent) || other.lateFeePercent == lateFeePercent)&&(identical(other.initiatorUserId, initiatorUserId) || other.initiatorUserId == initiatorUserId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other.rosterOrder, rosterOrder)&&const DeepCollectionEquality().equals(other.memberUserIds, memberUserIds)&&(identical(other.biddingDiscountPool, biddingDiscountPool) || other.biddingDiscountPool == biddingDiscountPool)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,contributionAmount,cycleFrequency,memberCount,totalCycles,currentCycleNumber,status,rosterMethod,reserveRate,gracePeriodHours,recipientContributes,lateFeePercent,initiatorUserId,conversationId,const DeepCollectionEquality().hash(rosterOrder),const DeepCollectionEquality().hash(memberUserIds),biddingDiscountPool,createdAt,activatedAt,completedAt,currentCycle]);

@override
String toString() {
  return 'GooiGroupModel(id: $id, name: $name, contributionAmount: $contributionAmount, cycleFrequency: $cycleFrequency, memberCount: $memberCount, totalCycles: $totalCycles, currentCycleNumber: $currentCycleNumber, status: $status, rosterMethod: $rosterMethod, reserveRate: $reserveRate, gracePeriodHours: $gracePeriodHours, recipientContributes: $recipientContributes, lateFeePercent: $lateFeePercent, initiatorUserId: $initiatorUserId, conversationId: $conversationId, rosterOrder: $rosterOrder, memberUserIds: $memberUserIds, biddingDiscountPool: $biddingDiscountPool, createdAt: $createdAt, activatedAt: $activatedAt, completedAt: $completedAt, currentCycle: $currentCycle)';
}


}

/// @nodoc
abstract mixin class $GooiGroupModelCopyWith<$Res>  {
  factory $GooiGroupModelCopyWith(GooiGroupModel value, $Res Function(GooiGroupModel) _then) = _$GooiGroupModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, int contributionAmount, GooiCycleFrequency cycleFrequency, int memberCount, int totalCycles, int currentCycleNumber, GooiGroupStatus status, GooiRosterMethod rosterMethod, double reserveRate, int gracePeriodHours, bool recipientContributes, int lateFeePercent, String initiatorUserId, String? conversationId, List<String> rosterOrder, List<String> memberUserIds, int biddingDiscountPool, DateTime createdAt, DateTime? activatedAt, DateTime? completedAt, GooiCycleSummary? currentCycle
});


$GooiCycleSummaryCopyWith<$Res>? get currentCycle;

}
/// @nodoc
class _$GooiGroupModelCopyWithImpl<$Res>
    implements $GooiGroupModelCopyWith<$Res> {
  _$GooiGroupModelCopyWithImpl(this._self, this._then);

  final GooiGroupModel _self;
  final $Res Function(GooiGroupModel) _then;

/// Create a copy of GooiGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? contributionAmount = null,Object? cycleFrequency = null,Object? memberCount = null,Object? totalCycles = null,Object? currentCycleNumber = null,Object? status = null,Object? rosterMethod = null,Object? reserveRate = null,Object? gracePeriodHours = null,Object? recipientContributes = null,Object? lateFeePercent = null,Object? initiatorUserId = null,Object? conversationId = freezed,Object? rosterOrder = null,Object? memberUserIds = null,Object? biddingDiscountPool = null,Object? createdAt = null,Object? activatedAt = freezed,Object? completedAt = freezed,Object? currentCycle = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,cycleFrequency: null == cycleFrequency ? _self.cycleFrequency : cycleFrequency // ignore: cast_nullable_to_non_nullable
as GooiCycleFrequency,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalCycles: null == totalCycles ? _self.totalCycles : totalCycles // ignore: cast_nullable_to_non_nullable
as int,currentCycleNumber: null == currentCycleNumber ? _self.currentCycleNumber : currentCycleNumber // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiGroupStatus,rosterMethod: null == rosterMethod ? _self.rosterMethod : rosterMethod // ignore: cast_nullable_to_non_nullable
as GooiRosterMethod,reserveRate: null == reserveRate ? _self.reserveRate : reserveRate // ignore: cast_nullable_to_non_nullable
as double,gracePeriodHours: null == gracePeriodHours ? _self.gracePeriodHours : gracePeriodHours // ignore: cast_nullable_to_non_nullable
as int,recipientContributes: null == recipientContributes ? _self.recipientContributes : recipientContributes // ignore: cast_nullable_to_non_nullable
as bool,lateFeePercent: null == lateFeePercent ? _self.lateFeePercent : lateFeePercent // ignore: cast_nullable_to_non_nullable
as int,initiatorUserId: null == initiatorUserId ? _self.initiatorUserId : initiatorUserId // ignore: cast_nullable_to_non_nullable
as String,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,rosterOrder: null == rosterOrder ? _self.rosterOrder : rosterOrder // ignore: cast_nullable_to_non_nullable
as List<String>,memberUserIds: null == memberUserIds ? _self.memberUserIds : memberUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,biddingDiscountPool: null == biddingDiscountPool ? _self.biddingDiscountPool : biddingDiscountPool // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentCycle: freezed == currentCycle ? _self.currentCycle : currentCycle // ignore: cast_nullable_to_non_nullable
as GooiCycleSummary?,
  ));
}
/// Create a copy of GooiGroupModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GooiCycleSummaryCopyWith<$Res>? get currentCycle {
    if (_self.currentCycle == null) {
    return null;
  }

  return $GooiCycleSummaryCopyWith<$Res>(_self.currentCycle!, (value) {
    return _then(_self.copyWith(currentCycle: value));
  });
}
}


/// Adds pattern-matching-related methods to [GooiGroupModel].
extension GooiGroupModelPatterns on GooiGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _GooiGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _GooiGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int contributionAmount,  GooiCycleFrequency cycleFrequency,  int memberCount,  int totalCycles,  int currentCycleNumber,  GooiGroupStatus status,  GooiRosterMethod rosterMethod,  double reserveRate,  int gracePeriodHours,  bool recipientContributes,  int lateFeePercent,  String initiatorUserId,  String? conversationId,  List<String> rosterOrder,  List<String> memberUserIds,  int biddingDiscountPool,  DateTime createdAt,  DateTime? activatedAt,  DateTime? completedAt,  GooiCycleSummary? currentCycle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.contributionAmount,_that.cycleFrequency,_that.memberCount,_that.totalCycles,_that.currentCycleNumber,_that.status,_that.rosterMethod,_that.reserveRate,_that.gracePeriodHours,_that.recipientContributes,_that.lateFeePercent,_that.initiatorUserId,_that.conversationId,_that.rosterOrder,_that.memberUserIds,_that.biddingDiscountPool,_that.createdAt,_that.activatedAt,_that.completedAt,_that.currentCycle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int contributionAmount,  GooiCycleFrequency cycleFrequency,  int memberCount,  int totalCycles,  int currentCycleNumber,  GooiGroupStatus status,  GooiRosterMethod rosterMethod,  double reserveRate,  int gracePeriodHours,  bool recipientContributes,  int lateFeePercent,  String initiatorUserId,  String? conversationId,  List<String> rosterOrder,  List<String> memberUserIds,  int biddingDiscountPool,  DateTime createdAt,  DateTime? activatedAt,  DateTime? completedAt,  GooiCycleSummary? currentCycle)  $default,) {final _that = this;
switch (_that) {
case _GooiGroupModel():
return $default(_that.id,_that.name,_that.contributionAmount,_that.cycleFrequency,_that.memberCount,_that.totalCycles,_that.currentCycleNumber,_that.status,_that.rosterMethod,_that.reserveRate,_that.gracePeriodHours,_that.recipientContributes,_that.lateFeePercent,_that.initiatorUserId,_that.conversationId,_that.rosterOrder,_that.memberUserIds,_that.biddingDiscountPool,_that.createdAt,_that.activatedAt,_that.completedAt,_that.currentCycle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int contributionAmount,  GooiCycleFrequency cycleFrequency,  int memberCount,  int totalCycles,  int currentCycleNumber,  GooiGroupStatus status,  GooiRosterMethod rosterMethod,  double reserveRate,  int gracePeriodHours,  bool recipientContributes,  int lateFeePercent,  String initiatorUserId,  String? conversationId,  List<String> rosterOrder,  List<String> memberUserIds,  int biddingDiscountPool,  DateTime createdAt,  DateTime? activatedAt,  DateTime? completedAt,  GooiCycleSummary? currentCycle)?  $default,) {final _that = this;
switch (_that) {
case _GooiGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.contributionAmount,_that.cycleFrequency,_that.memberCount,_that.totalCycles,_that.currentCycleNumber,_that.status,_that.rosterMethod,_that.reserveRate,_that.gracePeriodHours,_that.recipientContributes,_that.lateFeePercent,_that.initiatorUserId,_that.conversationId,_that.rosterOrder,_that.memberUserIds,_that.biddingDiscountPool,_that.createdAt,_that.activatedAt,_that.completedAt,_that.currentCycle);case _:
  return null;

}
}

}

/// @nodoc


class _GooiGroupModel extends GooiGroupModel {
  const _GooiGroupModel({required this.id, required this.name, required this.contributionAmount, required this.cycleFrequency, required this.memberCount, required this.totalCycles, this.currentCycleNumber = 0, required this.status, required this.rosterMethod, this.reserveRate = 0.03, this.gracePeriodHours = 48, this.recipientContributes = true, this.lateFeePercent = 5, required this.initiatorUserId, this.conversationId, final  List<String> rosterOrder = const [], final  List<String> memberUserIds = const [], this.biddingDiscountPool = 0, required this.createdAt, this.activatedAt, this.completedAt, this.currentCycle}): _rosterOrder = rosterOrder,_memberUserIds = memberUserIds,super._();
  

@override final  String id;
@override final  String name;
@override final  int contributionAmount;
@override final  GooiCycleFrequency cycleFrequency;
@override final  int memberCount;
@override final  int totalCycles;
@override@JsonKey() final  int currentCycleNumber;
@override final  GooiGroupStatus status;
@override final  GooiRosterMethod rosterMethod;
@override@JsonKey() final  double reserveRate;
@override@JsonKey() final  int gracePeriodHours;
@override@JsonKey() final  bool recipientContributes;
@override@JsonKey() final  int lateFeePercent;
@override final  String initiatorUserId;
@override final  String? conversationId;
 final  List<String> _rosterOrder;
@override@JsonKey() List<String> get rosterOrder {
  if (_rosterOrder is EqualUnmodifiableListView) return _rosterOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rosterOrder);
}

 final  List<String> _memberUserIds;
@override@JsonKey() List<String> get memberUserIds {
  if (_memberUserIds is EqualUnmodifiableListView) return _memberUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberUserIds);
}

@override@JsonKey() final  int biddingDiscountPool;
@override final  DateTime createdAt;
@override final  DateTime? activatedAt;
@override final  DateTime? completedAt;
@override final  GooiCycleSummary? currentCycle;

/// Create a copy of GooiGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiGroupModelCopyWith<_GooiGroupModel> get copyWith => __$GooiGroupModelCopyWithImpl<_GooiGroupModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.cycleFrequency, cycleFrequency) || other.cycleFrequency == cycleFrequency)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.currentCycleNumber, currentCycleNumber) || other.currentCycleNumber == currentCycleNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.rosterMethod, rosterMethod) || other.rosterMethod == rosterMethod)&&(identical(other.reserveRate, reserveRate) || other.reserveRate == reserveRate)&&(identical(other.gracePeriodHours, gracePeriodHours) || other.gracePeriodHours == gracePeriodHours)&&(identical(other.recipientContributes, recipientContributes) || other.recipientContributes == recipientContributes)&&(identical(other.lateFeePercent, lateFeePercent) || other.lateFeePercent == lateFeePercent)&&(identical(other.initiatorUserId, initiatorUserId) || other.initiatorUserId == initiatorUserId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other._rosterOrder, _rosterOrder)&&const DeepCollectionEquality().equals(other._memberUserIds, _memberUserIds)&&(identical(other.biddingDiscountPool, biddingDiscountPool) || other.biddingDiscountPool == biddingDiscountPool)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,contributionAmount,cycleFrequency,memberCount,totalCycles,currentCycleNumber,status,rosterMethod,reserveRate,gracePeriodHours,recipientContributes,lateFeePercent,initiatorUserId,conversationId,const DeepCollectionEquality().hash(_rosterOrder),const DeepCollectionEquality().hash(_memberUserIds),biddingDiscountPool,createdAt,activatedAt,completedAt,currentCycle]);

@override
String toString() {
  return 'GooiGroupModel(id: $id, name: $name, contributionAmount: $contributionAmount, cycleFrequency: $cycleFrequency, memberCount: $memberCount, totalCycles: $totalCycles, currentCycleNumber: $currentCycleNumber, status: $status, rosterMethod: $rosterMethod, reserveRate: $reserveRate, gracePeriodHours: $gracePeriodHours, recipientContributes: $recipientContributes, lateFeePercent: $lateFeePercent, initiatorUserId: $initiatorUserId, conversationId: $conversationId, rosterOrder: $rosterOrder, memberUserIds: $memberUserIds, biddingDiscountPool: $biddingDiscountPool, createdAt: $createdAt, activatedAt: $activatedAt, completedAt: $completedAt, currentCycle: $currentCycle)';
}


}

/// @nodoc
abstract mixin class _$GooiGroupModelCopyWith<$Res> implements $GooiGroupModelCopyWith<$Res> {
  factory _$GooiGroupModelCopyWith(_GooiGroupModel value, $Res Function(_GooiGroupModel) _then) = __$GooiGroupModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int contributionAmount, GooiCycleFrequency cycleFrequency, int memberCount, int totalCycles, int currentCycleNumber, GooiGroupStatus status, GooiRosterMethod rosterMethod, double reserveRate, int gracePeriodHours, bool recipientContributes, int lateFeePercent, String initiatorUserId, String? conversationId, List<String> rosterOrder, List<String> memberUserIds, int biddingDiscountPool, DateTime createdAt, DateTime? activatedAt, DateTime? completedAt, GooiCycleSummary? currentCycle
});


@override $GooiCycleSummaryCopyWith<$Res>? get currentCycle;

}
/// @nodoc
class __$GooiGroupModelCopyWithImpl<$Res>
    implements _$GooiGroupModelCopyWith<$Res> {
  __$GooiGroupModelCopyWithImpl(this._self, this._then);

  final _GooiGroupModel _self;
  final $Res Function(_GooiGroupModel) _then;

/// Create a copy of GooiGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? contributionAmount = null,Object? cycleFrequency = null,Object? memberCount = null,Object? totalCycles = null,Object? currentCycleNumber = null,Object? status = null,Object? rosterMethod = null,Object? reserveRate = null,Object? gracePeriodHours = null,Object? recipientContributes = null,Object? lateFeePercent = null,Object? initiatorUserId = null,Object? conversationId = freezed,Object? rosterOrder = null,Object? memberUserIds = null,Object? biddingDiscountPool = null,Object? createdAt = null,Object? activatedAt = freezed,Object? completedAt = freezed,Object? currentCycle = freezed,}) {
  return _then(_GooiGroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,cycleFrequency: null == cycleFrequency ? _self.cycleFrequency : cycleFrequency // ignore: cast_nullable_to_non_nullable
as GooiCycleFrequency,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalCycles: null == totalCycles ? _self.totalCycles : totalCycles // ignore: cast_nullable_to_non_nullable
as int,currentCycleNumber: null == currentCycleNumber ? _self.currentCycleNumber : currentCycleNumber // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiGroupStatus,rosterMethod: null == rosterMethod ? _self.rosterMethod : rosterMethod // ignore: cast_nullable_to_non_nullable
as GooiRosterMethod,reserveRate: null == reserveRate ? _self.reserveRate : reserveRate // ignore: cast_nullable_to_non_nullable
as double,gracePeriodHours: null == gracePeriodHours ? _self.gracePeriodHours : gracePeriodHours // ignore: cast_nullable_to_non_nullable
as int,recipientContributes: null == recipientContributes ? _self.recipientContributes : recipientContributes // ignore: cast_nullable_to_non_nullable
as bool,lateFeePercent: null == lateFeePercent ? _self.lateFeePercent : lateFeePercent // ignore: cast_nullable_to_non_nullable
as int,initiatorUserId: null == initiatorUserId ? _self.initiatorUserId : initiatorUserId // ignore: cast_nullable_to_non_nullable
as String,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,rosterOrder: null == rosterOrder ? _self._rosterOrder : rosterOrder // ignore: cast_nullable_to_non_nullable
as List<String>,memberUserIds: null == memberUserIds ? _self._memberUserIds : memberUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,biddingDiscountPool: null == biddingDiscountPool ? _self.biddingDiscountPool : biddingDiscountPool // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentCycle: freezed == currentCycle ? _self.currentCycle : currentCycle // ignore: cast_nullable_to_non_nullable
as GooiCycleSummary?,
  ));
}

/// Create a copy of GooiGroupModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GooiCycleSummaryCopyWith<$Res>? get currentCycle {
    if (_self.currentCycle == null) {
    return null;
  }

  return $GooiCycleSummaryCopyWith<$Res>(_self.currentCycle!, (value) {
    return _then(_self.copyWith(currentCycle: value));
  });
}
}

// dart format on
