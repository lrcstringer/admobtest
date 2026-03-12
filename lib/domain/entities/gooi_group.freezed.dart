// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GooiGroup {

 String get id; String get name; int get contributionAmount; GooiCycleFrequency get cycleFrequency; int get memberCount; int get totalCycles; int get currentCycleNumber; GooiGroupStatus get status; GooiRosterMethod get rosterMethod; double get reserveRate; int get gracePeriodHours; bool get recipientContributes; int get lateFeePercent; String get initiatorUserId; String? get conversationId; List<String> get rosterOrder; List<String> get memberUserIds; int get biddingDiscountPool; DateTime get createdAt; DateTime? get activatedAt; DateTime? get completedAt;/// Current cycle summary (populated from query)
 GooiCycleSummary? get currentCycle;
/// Create a copy of GooiGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiGroupCopyWith<GooiGroup> get copyWith => _$GooiGroupCopyWithImpl<GooiGroup>(this as GooiGroup, _$identity);

  /// Serializes this GooiGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.cycleFrequency, cycleFrequency) || other.cycleFrequency == cycleFrequency)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.currentCycleNumber, currentCycleNumber) || other.currentCycleNumber == currentCycleNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.rosterMethod, rosterMethod) || other.rosterMethod == rosterMethod)&&(identical(other.reserveRate, reserveRate) || other.reserveRate == reserveRate)&&(identical(other.gracePeriodHours, gracePeriodHours) || other.gracePeriodHours == gracePeriodHours)&&(identical(other.recipientContributes, recipientContributes) || other.recipientContributes == recipientContributes)&&(identical(other.lateFeePercent, lateFeePercent) || other.lateFeePercent == lateFeePercent)&&(identical(other.initiatorUserId, initiatorUserId) || other.initiatorUserId == initiatorUserId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other.rosterOrder, rosterOrder)&&const DeepCollectionEquality().equals(other.memberUserIds, memberUserIds)&&(identical(other.biddingDiscountPool, biddingDiscountPool) || other.biddingDiscountPool == biddingDiscountPool)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,contributionAmount,cycleFrequency,memberCount,totalCycles,currentCycleNumber,status,rosterMethod,reserveRate,gracePeriodHours,recipientContributes,lateFeePercent,initiatorUserId,conversationId,const DeepCollectionEquality().hash(rosterOrder),const DeepCollectionEquality().hash(memberUserIds),biddingDiscountPool,createdAt,activatedAt,completedAt,currentCycle]);

@override
String toString() {
  return 'GooiGroup(id: $id, name: $name, contributionAmount: $contributionAmount, cycleFrequency: $cycleFrequency, memberCount: $memberCount, totalCycles: $totalCycles, currentCycleNumber: $currentCycleNumber, status: $status, rosterMethod: $rosterMethod, reserveRate: $reserveRate, gracePeriodHours: $gracePeriodHours, recipientContributes: $recipientContributes, lateFeePercent: $lateFeePercent, initiatorUserId: $initiatorUserId, conversationId: $conversationId, rosterOrder: $rosterOrder, memberUserIds: $memberUserIds, biddingDiscountPool: $biddingDiscountPool, createdAt: $createdAt, activatedAt: $activatedAt, completedAt: $completedAt, currentCycle: $currentCycle)';
}


}

/// @nodoc
abstract mixin class $GooiGroupCopyWith<$Res>  {
  factory $GooiGroupCopyWith(GooiGroup value, $Res Function(GooiGroup) _then) = _$GooiGroupCopyWithImpl;
@useResult
$Res call({
 String id, String name, int contributionAmount, GooiCycleFrequency cycleFrequency, int memberCount, int totalCycles, int currentCycleNumber, GooiGroupStatus status, GooiRosterMethod rosterMethod, double reserveRate, int gracePeriodHours, bool recipientContributes, int lateFeePercent, String initiatorUserId, String? conversationId, List<String> rosterOrder, List<String> memberUserIds, int biddingDiscountPool, DateTime createdAt, DateTime? activatedAt, DateTime? completedAt, GooiCycleSummary? currentCycle
});


$GooiCycleSummaryCopyWith<$Res>? get currentCycle;

}
/// @nodoc
class _$GooiGroupCopyWithImpl<$Res>
    implements $GooiGroupCopyWith<$Res> {
  _$GooiGroupCopyWithImpl(this._self, this._then);

  final GooiGroup _self;
  final $Res Function(GooiGroup) _then;

/// Create a copy of GooiGroup
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
/// Create a copy of GooiGroup
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


/// Adds pattern-matching-related methods to [GooiGroup].
extension GooiGroupPatterns on GooiGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiGroup value)  $default,){
final _that = this;
switch (_that) {
case _GooiGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiGroup value)?  $default,){
final _that = this;
switch (_that) {
case _GooiGroup() when $default != null:
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
case _GooiGroup() when $default != null:
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
case _GooiGroup():
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
case _GooiGroup() when $default != null:
return $default(_that.id,_that.name,_that.contributionAmount,_that.cycleFrequency,_that.memberCount,_that.totalCycles,_that.currentCycleNumber,_that.status,_that.rosterMethod,_that.reserveRate,_that.gracePeriodHours,_that.recipientContributes,_that.lateFeePercent,_that.initiatorUserId,_that.conversationId,_that.rosterOrder,_that.memberUserIds,_that.biddingDiscountPool,_that.createdAt,_that.activatedAt,_that.completedAt,_that.currentCycle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GooiGroup extends GooiGroup {
  const _GooiGroup({required this.id, required this.name, required this.contributionAmount, required this.cycleFrequency, required this.memberCount, required this.totalCycles, this.currentCycleNumber = 0, required this.status, required this.rosterMethod, this.reserveRate = 0.03, this.gracePeriodHours = 48, this.recipientContributes = true, this.lateFeePercent = 5, required this.initiatorUserId, this.conversationId, final  List<String> rosterOrder = const [], final  List<String> memberUserIds = const [], this.biddingDiscountPool = 0, required this.createdAt, this.activatedAt, this.completedAt, this.currentCycle}): _rosterOrder = rosterOrder,_memberUserIds = memberUserIds,super._();
  factory _GooiGroup.fromJson(Map<String, dynamic> json) => _$GooiGroupFromJson(json);

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
/// Current cycle summary (populated from query)
@override final  GooiCycleSummary? currentCycle;

/// Create a copy of GooiGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiGroupCopyWith<_GooiGroup> get copyWith => __$GooiGroupCopyWithImpl<_GooiGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GooiGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.cycleFrequency, cycleFrequency) || other.cycleFrequency == cycleFrequency)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.currentCycleNumber, currentCycleNumber) || other.currentCycleNumber == currentCycleNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.rosterMethod, rosterMethod) || other.rosterMethod == rosterMethod)&&(identical(other.reserveRate, reserveRate) || other.reserveRate == reserveRate)&&(identical(other.gracePeriodHours, gracePeriodHours) || other.gracePeriodHours == gracePeriodHours)&&(identical(other.recipientContributes, recipientContributes) || other.recipientContributes == recipientContributes)&&(identical(other.lateFeePercent, lateFeePercent) || other.lateFeePercent == lateFeePercent)&&(identical(other.initiatorUserId, initiatorUserId) || other.initiatorUserId == initiatorUserId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other._rosterOrder, _rosterOrder)&&const DeepCollectionEquality().equals(other._memberUserIds, _memberUserIds)&&(identical(other.biddingDiscountPool, biddingDiscountPool) || other.biddingDiscountPool == biddingDiscountPool)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,contributionAmount,cycleFrequency,memberCount,totalCycles,currentCycleNumber,status,rosterMethod,reserveRate,gracePeriodHours,recipientContributes,lateFeePercent,initiatorUserId,conversationId,const DeepCollectionEquality().hash(_rosterOrder),const DeepCollectionEquality().hash(_memberUserIds),biddingDiscountPool,createdAt,activatedAt,completedAt,currentCycle]);

@override
String toString() {
  return 'GooiGroup(id: $id, name: $name, contributionAmount: $contributionAmount, cycleFrequency: $cycleFrequency, memberCount: $memberCount, totalCycles: $totalCycles, currentCycleNumber: $currentCycleNumber, status: $status, rosterMethod: $rosterMethod, reserveRate: $reserveRate, gracePeriodHours: $gracePeriodHours, recipientContributes: $recipientContributes, lateFeePercent: $lateFeePercent, initiatorUserId: $initiatorUserId, conversationId: $conversationId, rosterOrder: $rosterOrder, memberUserIds: $memberUserIds, biddingDiscountPool: $biddingDiscountPool, createdAt: $createdAt, activatedAt: $activatedAt, completedAt: $completedAt, currentCycle: $currentCycle)';
}


}

/// @nodoc
abstract mixin class _$GooiGroupCopyWith<$Res> implements $GooiGroupCopyWith<$Res> {
  factory _$GooiGroupCopyWith(_GooiGroup value, $Res Function(_GooiGroup) _then) = __$GooiGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int contributionAmount, GooiCycleFrequency cycleFrequency, int memberCount, int totalCycles, int currentCycleNumber, GooiGroupStatus status, GooiRosterMethod rosterMethod, double reserveRate, int gracePeriodHours, bool recipientContributes, int lateFeePercent, String initiatorUserId, String? conversationId, List<String> rosterOrder, List<String> memberUserIds, int biddingDiscountPool, DateTime createdAt, DateTime? activatedAt, DateTime? completedAt, GooiCycleSummary? currentCycle
});


@override $GooiCycleSummaryCopyWith<$Res>? get currentCycle;

}
/// @nodoc
class __$GooiGroupCopyWithImpl<$Res>
    implements _$GooiGroupCopyWith<$Res> {
  __$GooiGroupCopyWithImpl(this._self, this._then);

  final _GooiGroup _self;
  final $Res Function(_GooiGroup) _then;

/// Create a copy of GooiGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? contributionAmount = null,Object? cycleFrequency = null,Object? memberCount = null,Object? totalCycles = null,Object? currentCycleNumber = null,Object? status = null,Object? rosterMethod = null,Object? reserveRate = null,Object? gracePeriodHours = null,Object? recipientContributes = null,Object? lateFeePercent = null,Object? initiatorUserId = null,Object? conversationId = freezed,Object? rosterOrder = null,Object? memberUserIds = null,Object? biddingDiscountPool = null,Object? createdAt = null,Object? activatedAt = freezed,Object? completedAt = freezed,Object? currentCycle = freezed,}) {
  return _then(_GooiGroup(
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

/// Create a copy of GooiGroup
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


/// @nodoc
mixin _$GooiCycleSummary {

 int get cycleNumber; GooiCycleStatus get status; String get recipientUserId; DateTime get dueDate; int get totalCollected; int get totalExpected;
/// Create a copy of GooiCycleSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiCycleSummaryCopyWith<GooiCycleSummary> get copyWith => _$GooiCycleSummaryCopyWithImpl<GooiCycleSummary>(this as GooiCycleSummary, _$identity);

  /// Serializes this GooiCycleSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiCycleSummary&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.totalCollected, totalCollected) || other.totalCollected == totalCollected)&&(identical(other.totalExpected, totalExpected) || other.totalExpected == totalExpected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cycleNumber,status,recipientUserId,dueDate,totalCollected,totalExpected);

@override
String toString() {
  return 'GooiCycleSummary(cycleNumber: $cycleNumber, status: $status, recipientUserId: $recipientUserId, dueDate: $dueDate, totalCollected: $totalCollected, totalExpected: $totalExpected)';
}


}

/// @nodoc
abstract mixin class $GooiCycleSummaryCopyWith<$Res>  {
  factory $GooiCycleSummaryCopyWith(GooiCycleSummary value, $Res Function(GooiCycleSummary) _then) = _$GooiCycleSummaryCopyWithImpl;
@useResult
$Res call({
 int cycleNumber, GooiCycleStatus status, String recipientUserId, DateTime dueDate, int totalCollected, int totalExpected
});




}
/// @nodoc
class _$GooiCycleSummaryCopyWithImpl<$Res>
    implements $GooiCycleSummaryCopyWith<$Res> {
  _$GooiCycleSummaryCopyWithImpl(this._self, this._then);

  final GooiCycleSummary _self;
  final $Res Function(GooiCycleSummary) _then;

/// Create a copy of GooiCycleSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cycleNumber = null,Object? status = null,Object? recipientUserId = null,Object? dueDate = null,Object? totalCollected = null,Object? totalExpected = null,}) {
  return _then(_self.copyWith(
cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiCycleStatus,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalCollected: null == totalCollected ? _self.totalCollected : totalCollected // ignore: cast_nullable_to_non_nullable
as int,totalExpected: null == totalExpected ? _self.totalExpected : totalExpected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GooiCycleSummary].
extension GooiCycleSummaryPatterns on GooiCycleSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiCycleSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiCycleSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiCycleSummary value)  $default,){
final _that = this;
switch (_that) {
case _GooiCycleSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiCycleSummary value)?  $default,){
final _that = this;
switch (_that) {
case _GooiCycleSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cycleNumber,  GooiCycleStatus status,  String recipientUserId,  DateTime dueDate,  int totalCollected,  int totalExpected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiCycleSummary() when $default != null:
return $default(_that.cycleNumber,_that.status,_that.recipientUserId,_that.dueDate,_that.totalCollected,_that.totalExpected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cycleNumber,  GooiCycleStatus status,  String recipientUserId,  DateTime dueDate,  int totalCollected,  int totalExpected)  $default,) {final _that = this;
switch (_that) {
case _GooiCycleSummary():
return $default(_that.cycleNumber,_that.status,_that.recipientUserId,_that.dueDate,_that.totalCollected,_that.totalExpected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cycleNumber,  GooiCycleStatus status,  String recipientUserId,  DateTime dueDate,  int totalCollected,  int totalExpected)?  $default,) {final _that = this;
switch (_that) {
case _GooiCycleSummary() when $default != null:
return $default(_that.cycleNumber,_that.status,_that.recipientUserId,_that.dueDate,_that.totalCollected,_that.totalExpected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GooiCycleSummary implements GooiCycleSummary {
  const _GooiCycleSummary({required this.cycleNumber, required this.status, required this.recipientUserId, required this.dueDate, this.totalCollected = 0, this.totalExpected = 0});
  factory _GooiCycleSummary.fromJson(Map<String, dynamic> json) => _$GooiCycleSummaryFromJson(json);

@override final  int cycleNumber;
@override final  GooiCycleStatus status;
@override final  String recipientUserId;
@override final  DateTime dueDate;
@override@JsonKey() final  int totalCollected;
@override@JsonKey() final  int totalExpected;

/// Create a copy of GooiCycleSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiCycleSummaryCopyWith<_GooiCycleSummary> get copyWith => __$GooiCycleSummaryCopyWithImpl<_GooiCycleSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GooiCycleSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiCycleSummary&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.totalCollected, totalCollected) || other.totalCollected == totalCollected)&&(identical(other.totalExpected, totalExpected) || other.totalExpected == totalExpected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cycleNumber,status,recipientUserId,dueDate,totalCollected,totalExpected);

@override
String toString() {
  return 'GooiCycleSummary(cycleNumber: $cycleNumber, status: $status, recipientUserId: $recipientUserId, dueDate: $dueDate, totalCollected: $totalCollected, totalExpected: $totalExpected)';
}


}

/// @nodoc
abstract mixin class _$GooiCycleSummaryCopyWith<$Res> implements $GooiCycleSummaryCopyWith<$Res> {
  factory _$GooiCycleSummaryCopyWith(_GooiCycleSummary value, $Res Function(_GooiCycleSummary) _then) = __$GooiCycleSummaryCopyWithImpl;
@override @useResult
$Res call({
 int cycleNumber, GooiCycleStatus status, String recipientUserId, DateTime dueDate, int totalCollected, int totalExpected
});




}
/// @nodoc
class __$GooiCycleSummaryCopyWithImpl<$Res>
    implements _$GooiCycleSummaryCopyWith<$Res> {
  __$GooiCycleSummaryCopyWithImpl(this._self, this._then);

  final _GooiCycleSummary _self;
  final $Res Function(_GooiCycleSummary) _then;

/// Create a copy of GooiCycleSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cycleNumber = null,Object? status = null,Object? recipientUserId = null,Object? dueDate = null,Object? totalCollected = null,Object? totalExpected = null,}) {
  return _then(_GooiCycleSummary(
cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiCycleStatus,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalCollected: null == totalCollected ? _self.totalCollected : totalCollected // ignore: cast_nullable_to_non_nullable
as int,totalExpected: null == totalExpected ? _self.totalExpected : totalExpected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
