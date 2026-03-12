// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_contribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GooiContribution {

 String get id; String get cycleId; int get cycleNumber; String get memberId; String get userId; int get amountBase; int get amountReserve; int get amountTotal; int? get lateFee; bool get lateFeeWaived; GooiContributionStatus get status; String? get journalId; DateTime? get paidAt; DateTime get createdAt;
/// Create a copy of GooiContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiContributionCopyWith<GooiContribution> get copyWith => _$GooiContributionCopyWithImpl<GooiContribution>(this as GooiContribution, _$identity);

  /// Serializes this GooiContribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiContribution&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleId, cycleId) || other.cycleId == cycleId)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amountBase, amountBase) || other.amountBase == amountBase)&&(identical(other.amountReserve, amountReserve) || other.amountReserve == amountReserve)&&(identical(other.amountTotal, amountTotal) || other.amountTotal == amountTotal)&&(identical(other.lateFee, lateFee) || other.lateFee == lateFee)&&(identical(other.lateFeeWaived, lateFeeWaived) || other.lateFeeWaived == lateFeeWaived)&&(identical(other.status, status) || other.status == status)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cycleId,cycleNumber,memberId,userId,amountBase,amountReserve,amountTotal,lateFee,lateFeeWaived,status,journalId,paidAt,createdAt);

@override
String toString() {
  return 'GooiContribution(id: $id, cycleId: $cycleId, cycleNumber: $cycleNumber, memberId: $memberId, userId: $userId, amountBase: $amountBase, amountReserve: $amountReserve, amountTotal: $amountTotal, lateFee: $lateFee, lateFeeWaived: $lateFeeWaived, status: $status, journalId: $journalId, paidAt: $paidAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GooiContributionCopyWith<$Res>  {
  factory $GooiContributionCopyWith(GooiContribution value, $Res Function(GooiContribution) _then) = _$GooiContributionCopyWithImpl;
@useResult
$Res call({
 String id, String cycleId, int cycleNumber, String memberId, String userId, int amountBase, int amountReserve, int amountTotal, int? lateFee, bool lateFeeWaived, GooiContributionStatus status, String? journalId, DateTime? paidAt, DateTime createdAt
});




}
/// @nodoc
class _$GooiContributionCopyWithImpl<$Res>
    implements $GooiContributionCopyWith<$Res> {
  _$GooiContributionCopyWithImpl(this._self, this._then);

  final GooiContribution _self;
  final $Res Function(GooiContribution) _then;

/// Create a copy of GooiContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cycleId = null,Object? cycleNumber = null,Object? memberId = null,Object? userId = null,Object? amountBase = null,Object? amountReserve = null,Object? amountTotal = null,Object? lateFee = freezed,Object? lateFeeWaived = null,Object? status = null,Object? journalId = freezed,Object? paidAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cycleId: null == cycleId ? _self.cycleId : cycleId // ignore: cast_nullable_to_non_nullable
as String,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amountBase: null == amountBase ? _self.amountBase : amountBase // ignore: cast_nullable_to_non_nullable
as int,amountReserve: null == amountReserve ? _self.amountReserve : amountReserve // ignore: cast_nullable_to_non_nullable
as int,amountTotal: null == amountTotal ? _self.amountTotal : amountTotal // ignore: cast_nullable_to_non_nullable
as int,lateFee: freezed == lateFee ? _self.lateFee : lateFee // ignore: cast_nullable_to_non_nullable
as int?,lateFeeWaived: null == lateFeeWaived ? _self.lateFeeWaived : lateFeeWaived // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiContributionStatus,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GooiContribution].
extension GooiContributionPatterns on GooiContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiContribution value)  $default,){
final _that = this;
switch (_that) {
case _GooiContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiContribution value)?  $default,){
final _that = this;
switch (_that) {
case _GooiContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String cycleId,  int cycleNumber,  String memberId,  String userId,  int amountBase,  int amountReserve,  int amountTotal,  int? lateFee,  bool lateFeeWaived,  GooiContributionStatus status,  String? journalId,  DateTime? paidAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiContribution() when $default != null:
return $default(_that.id,_that.cycleId,_that.cycleNumber,_that.memberId,_that.userId,_that.amountBase,_that.amountReserve,_that.amountTotal,_that.lateFee,_that.lateFeeWaived,_that.status,_that.journalId,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String cycleId,  int cycleNumber,  String memberId,  String userId,  int amountBase,  int amountReserve,  int amountTotal,  int? lateFee,  bool lateFeeWaived,  GooiContributionStatus status,  String? journalId,  DateTime? paidAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _GooiContribution():
return $default(_that.id,_that.cycleId,_that.cycleNumber,_that.memberId,_that.userId,_that.amountBase,_that.amountReserve,_that.amountTotal,_that.lateFee,_that.lateFeeWaived,_that.status,_that.journalId,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String cycleId,  int cycleNumber,  String memberId,  String userId,  int amountBase,  int amountReserve,  int amountTotal,  int? lateFee,  bool lateFeeWaived,  GooiContributionStatus status,  String? journalId,  DateTime? paidAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GooiContribution() when $default != null:
return $default(_that.id,_that.cycleId,_that.cycleNumber,_that.memberId,_that.userId,_that.amountBase,_that.amountReserve,_that.amountTotal,_that.lateFee,_that.lateFeeWaived,_that.status,_that.journalId,_that.paidAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GooiContribution extends GooiContribution {
  const _GooiContribution({required this.id, required this.cycleId, required this.cycleNumber, required this.memberId, required this.userId, this.amountBase = 0, this.amountReserve = 0, this.amountTotal = 0, this.lateFee, this.lateFeeWaived = false, required this.status, this.journalId, this.paidAt, required this.createdAt}): super._();
  factory _GooiContribution.fromJson(Map<String, dynamic> json) => _$GooiContributionFromJson(json);

@override final  String id;
@override final  String cycleId;
@override final  int cycleNumber;
@override final  String memberId;
@override final  String userId;
@override@JsonKey() final  int amountBase;
@override@JsonKey() final  int amountReserve;
@override@JsonKey() final  int amountTotal;
@override final  int? lateFee;
@override@JsonKey() final  bool lateFeeWaived;
@override final  GooiContributionStatus status;
@override final  String? journalId;
@override final  DateTime? paidAt;
@override final  DateTime createdAt;

/// Create a copy of GooiContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiContributionCopyWith<_GooiContribution> get copyWith => __$GooiContributionCopyWithImpl<_GooiContribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GooiContributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiContribution&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleId, cycleId) || other.cycleId == cycleId)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amountBase, amountBase) || other.amountBase == amountBase)&&(identical(other.amountReserve, amountReserve) || other.amountReserve == amountReserve)&&(identical(other.amountTotal, amountTotal) || other.amountTotal == amountTotal)&&(identical(other.lateFee, lateFee) || other.lateFee == lateFee)&&(identical(other.lateFeeWaived, lateFeeWaived) || other.lateFeeWaived == lateFeeWaived)&&(identical(other.status, status) || other.status == status)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cycleId,cycleNumber,memberId,userId,amountBase,amountReserve,amountTotal,lateFee,lateFeeWaived,status,journalId,paidAt,createdAt);

@override
String toString() {
  return 'GooiContribution(id: $id, cycleId: $cycleId, cycleNumber: $cycleNumber, memberId: $memberId, userId: $userId, amountBase: $amountBase, amountReserve: $amountReserve, amountTotal: $amountTotal, lateFee: $lateFee, lateFeeWaived: $lateFeeWaived, status: $status, journalId: $journalId, paidAt: $paidAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GooiContributionCopyWith<$Res> implements $GooiContributionCopyWith<$Res> {
  factory _$GooiContributionCopyWith(_GooiContribution value, $Res Function(_GooiContribution) _then) = __$GooiContributionCopyWithImpl;
@override @useResult
$Res call({
 String id, String cycleId, int cycleNumber, String memberId, String userId, int amountBase, int amountReserve, int amountTotal, int? lateFee, bool lateFeeWaived, GooiContributionStatus status, String? journalId, DateTime? paidAt, DateTime createdAt
});




}
/// @nodoc
class __$GooiContributionCopyWithImpl<$Res>
    implements _$GooiContributionCopyWith<$Res> {
  __$GooiContributionCopyWithImpl(this._self, this._then);

  final _GooiContribution _self;
  final $Res Function(_GooiContribution) _then;

/// Create a copy of GooiContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cycleId = null,Object? cycleNumber = null,Object? memberId = null,Object? userId = null,Object? amountBase = null,Object? amountReserve = null,Object? amountTotal = null,Object? lateFee = freezed,Object? lateFeeWaived = null,Object? status = null,Object? journalId = freezed,Object? paidAt = freezed,Object? createdAt = null,}) {
  return _then(_GooiContribution(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cycleId: null == cycleId ? _self.cycleId : cycleId // ignore: cast_nullable_to_non_nullable
as String,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amountBase: null == amountBase ? _self.amountBase : amountBase // ignore: cast_nullable_to_non_nullable
as int,amountReserve: null == amountReserve ? _self.amountReserve : amountReserve // ignore: cast_nullable_to_non_nullable
as int,amountTotal: null == amountTotal ? _self.amountTotal : amountTotal // ignore: cast_nullable_to_non_nullable
as int,lateFee: freezed == lateFee ? _self.lateFee : lateFee // ignore: cast_nullable_to_non_nullable
as int?,lateFeeWaived: null == lateFeeWaived ? _self.lateFeeWaived : lateFeeWaived // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiContributionStatus,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
