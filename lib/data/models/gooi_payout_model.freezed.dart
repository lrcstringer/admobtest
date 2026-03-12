// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_payout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiPayoutModel {

 String get id; String get cycleId; int get cycleNumber; String? get recipientMemberId; String get recipientUserId; int get amountFromContributions; int get amountFromReserve; int get totalPayoutAmount; int get shortfallAmount; GooiPayoutStatus get status; int get retryCount; String? get journalId; String? get triggeredBy; DateTime? get triggeredAt; DateTime? get completedAt; List<String> get defaulterMemberIds;
/// Create a copy of GooiPayoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiPayoutModelCopyWith<GooiPayoutModel> get copyWith => _$GooiPayoutModelCopyWithImpl<GooiPayoutModel>(this as GooiPayoutModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiPayoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleId, cycleId) || other.cycleId == cycleId)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.recipientMemberId, recipientMemberId) || other.recipientMemberId == recipientMemberId)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.amountFromContributions, amountFromContributions) || other.amountFromContributions == amountFromContributions)&&(identical(other.amountFromReserve, amountFromReserve) || other.amountFromReserve == amountFromReserve)&&(identical(other.totalPayoutAmount, totalPayoutAmount) || other.totalPayoutAmount == totalPayoutAmount)&&(identical(other.shortfallAmount, shortfallAmount) || other.shortfallAmount == shortfallAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.triggeredBy, triggeredBy) || other.triggeredBy == triggeredBy)&&(identical(other.triggeredAt, triggeredAt) || other.triggeredAt == triggeredAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.defaulterMemberIds, defaulterMemberIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,cycleId,cycleNumber,recipientMemberId,recipientUserId,amountFromContributions,amountFromReserve,totalPayoutAmount,shortfallAmount,status,retryCount,journalId,triggeredBy,triggeredAt,completedAt,const DeepCollectionEquality().hash(defaulterMemberIds));

@override
String toString() {
  return 'GooiPayoutModel(id: $id, cycleId: $cycleId, cycleNumber: $cycleNumber, recipientMemberId: $recipientMemberId, recipientUserId: $recipientUserId, amountFromContributions: $amountFromContributions, amountFromReserve: $amountFromReserve, totalPayoutAmount: $totalPayoutAmount, shortfallAmount: $shortfallAmount, status: $status, retryCount: $retryCount, journalId: $journalId, triggeredBy: $triggeredBy, triggeredAt: $triggeredAt, completedAt: $completedAt, defaulterMemberIds: $defaulterMemberIds)';
}


}

/// @nodoc
abstract mixin class $GooiPayoutModelCopyWith<$Res>  {
  factory $GooiPayoutModelCopyWith(GooiPayoutModel value, $Res Function(GooiPayoutModel) _then) = _$GooiPayoutModelCopyWithImpl;
@useResult
$Res call({
 String id, String cycleId, int cycleNumber, String? recipientMemberId, String recipientUserId, int amountFromContributions, int amountFromReserve, int totalPayoutAmount, int shortfallAmount, GooiPayoutStatus status, int retryCount, String? journalId, String? triggeredBy, DateTime? triggeredAt, DateTime? completedAt, List<String> defaulterMemberIds
});




}
/// @nodoc
class _$GooiPayoutModelCopyWithImpl<$Res>
    implements $GooiPayoutModelCopyWith<$Res> {
  _$GooiPayoutModelCopyWithImpl(this._self, this._then);

  final GooiPayoutModel _self;
  final $Res Function(GooiPayoutModel) _then;

/// Create a copy of GooiPayoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cycleId = null,Object? cycleNumber = null,Object? recipientMemberId = freezed,Object? recipientUserId = null,Object? amountFromContributions = null,Object? amountFromReserve = null,Object? totalPayoutAmount = null,Object? shortfallAmount = null,Object? status = null,Object? retryCount = null,Object? journalId = freezed,Object? triggeredBy = freezed,Object? triggeredAt = freezed,Object? completedAt = freezed,Object? defaulterMemberIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cycleId: null == cycleId ? _self.cycleId : cycleId // ignore: cast_nullable_to_non_nullable
as String,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,recipientMemberId: freezed == recipientMemberId ? _self.recipientMemberId : recipientMemberId // ignore: cast_nullable_to_non_nullable
as String?,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,amountFromContributions: null == amountFromContributions ? _self.amountFromContributions : amountFromContributions // ignore: cast_nullable_to_non_nullable
as int,amountFromReserve: null == amountFromReserve ? _self.amountFromReserve : amountFromReserve // ignore: cast_nullable_to_non_nullable
as int,totalPayoutAmount: null == totalPayoutAmount ? _self.totalPayoutAmount : totalPayoutAmount // ignore: cast_nullable_to_non_nullable
as int,shortfallAmount: null == shortfallAmount ? _self.shortfallAmount : shortfallAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiPayoutStatus,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,triggeredBy: freezed == triggeredBy ? _self.triggeredBy : triggeredBy // ignore: cast_nullable_to_non_nullable
as String?,triggeredAt: freezed == triggeredAt ? _self.triggeredAt : triggeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,defaulterMemberIds: null == defaulterMemberIds ? _self.defaulterMemberIds : defaulterMemberIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GooiPayoutModel].
extension GooiPayoutModelPatterns on GooiPayoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiPayoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiPayoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiPayoutModel value)  $default,){
final _that = this;
switch (_that) {
case _GooiPayoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiPayoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _GooiPayoutModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String cycleId,  int cycleNumber,  String? recipientMemberId,  String recipientUserId,  int amountFromContributions,  int amountFromReserve,  int totalPayoutAmount,  int shortfallAmount,  GooiPayoutStatus status,  int retryCount,  String? journalId,  String? triggeredBy,  DateTime? triggeredAt,  DateTime? completedAt,  List<String> defaulterMemberIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiPayoutModel() when $default != null:
return $default(_that.id,_that.cycleId,_that.cycleNumber,_that.recipientMemberId,_that.recipientUserId,_that.amountFromContributions,_that.amountFromReserve,_that.totalPayoutAmount,_that.shortfallAmount,_that.status,_that.retryCount,_that.journalId,_that.triggeredBy,_that.triggeredAt,_that.completedAt,_that.defaulterMemberIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String cycleId,  int cycleNumber,  String? recipientMemberId,  String recipientUserId,  int amountFromContributions,  int amountFromReserve,  int totalPayoutAmount,  int shortfallAmount,  GooiPayoutStatus status,  int retryCount,  String? journalId,  String? triggeredBy,  DateTime? triggeredAt,  DateTime? completedAt,  List<String> defaulterMemberIds)  $default,) {final _that = this;
switch (_that) {
case _GooiPayoutModel():
return $default(_that.id,_that.cycleId,_that.cycleNumber,_that.recipientMemberId,_that.recipientUserId,_that.amountFromContributions,_that.amountFromReserve,_that.totalPayoutAmount,_that.shortfallAmount,_that.status,_that.retryCount,_that.journalId,_that.triggeredBy,_that.triggeredAt,_that.completedAt,_that.defaulterMemberIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String cycleId,  int cycleNumber,  String? recipientMemberId,  String recipientUserId,  int amountFromContributions,  int amountFromReserve,  int totalPayoutAmount,  int shortfallAmount,  GooiPayoutStatus status,  int retryCount,  String? journalId,  String? triggeredBy,  DateTime? triggeredAt,  DateTime? completedAt,  List<String> defaulterMemberIds)?  $default,) {final _that = this;
switch (_that) {
case _GooiPayoutModel() when $default != null:
return $default(_that.id,_that.cycleId,_that.cycleNumber,_that.recipientMemberId,_that.recipientUserId,_that.amountFromContributions,_that.amountFromReserve,_that.totalPayoutAmount,_that.shortfallAmount,_that.status,_that.retryCount,_that.journalId,_that.triggeredBy,_that.triggeredAt,_that.completedAt,_that.defaulterMemberIds);case _:
  return null;

}
}

}

/// @nodoc


class _GooiPayoutModel extends GooiPayoutModel {
  const _GooiPayoutModel({required this.id, required this.cycleId, required this.cycleNumber, this.recipientMemberId, required this.recipientUserId, this.amountFromContributions = 0, this.amountFromReserve = 0, this.totalPayoutAmount = 0, this.shortfallAmount = 0, required this.status, this.retryCount = 0, this.journalId, this.triggeredBy, this.triggeredAt, this.completedAt, final  List<String> defaulterMemberIds = const []}): _defaulterMemberIds = defaulterMemberIds,super._();
  

@override final  String id;
@override final  String cycleId;
@override final  int cycleNumber;
@override final  String? recipientMemberId;
@override final  String recipientUserId;
@override@JsonKey() final  int amountFromContributions;
@override@JsonKey() final  int amountFromReserve;
@override@JsonKey() final  int totalPayoutAmount;
@override@JsonKey() final  int shortfallAmount;
@override final  GooiPayoutStatus status;
@override@JsonKey() final  int retryCount;
@override final  String? journalId;
@override final  String? triggeredBy;
@override final  DateTime? triggeredAt;
@override final  DateTime? completedAt;
 final  List<String> _defaulterMemberIds;
@override@JsonKey() List<String> get defaulterMemberIds {
  if (_defaulterMemberIds is EqualUnmodifiableListView) return _defaulterMemberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_defaulterMemberIds);
}


/// Create a copy of GooiPayoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiPayoutModelCopyWith<_GooiPayoutModel> get copyWith => __$GooiPayoutModelCopyWithImpl<_GooiPayoutModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiPayoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleId, cycleId) || other.cycleId == cycleId)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.recipientMemberId, recipientMemberId) || other.recipientMemberId == recipientMemberId)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.amountFromContributions, amountFromContributions) || other.amountFromContributions == amountFromContributions)&&(identical(other.amountFromReserve, amountFromReserve) || other.amountFromReserve == amountFromReserve)&&(identical(other.totalPayoutAmount, totalPayoutAmount) || other.totalPayoutAmount == totalPayoutAmount)&&(identical(other.shortfallAmount, shortfallAmount) || other.shortfallAmount == shortfallAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.triggeredBy, triggeredBy) || other.triggeredBy == triggeredBy)&&(identical(other.triggeredAt, triggeredAt) || other.triggeredAt == triggeredAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other._defaulterMemberIds, _defaulterMemberIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,cycleId,cycleNumber,recipientMemberId,recipientUserId,amountFromContributions,amountFromReserve,totalPayoutAmount,shortfallAmount,status,retryCount,journalId,triggeredBy,triggeredAt,completedAt,const DeepCollectionEquality().hash(_defaulterMemberIds));

@override
String toString() {
  return 'GooiPayoutModel(id: $id, cycleId: $cycleId, cycleNumber: $cycleNumber, recipientMemberId: $recipientMemberId, recipientUserId: $recipientUserId, amountFromContributions: $amountFromContributions, amountFromReserve: $amountFromReserve, totalPayoutAmount: $totalPayoutAmount, shortfallAmount: $shortfallAmount, status: $status, retryCount: $retryCount, journalId: $journalId, triggeredBy: $triggeredBy, triggeredAt: $triggeredAt, completedAt: $completedAt, defaulterMemberIds: $defaulterMemberIds)';
}


}

/// @nodoc
abstract mixin class _$GooiPayoutModelCopyWith<$Res> implements $GooiPayoutModelCopyWith<$Res> {
  factory _$GooiPayoutModelCopyWith(_GooiPayoutModel value, $Res Function(_GooiPayoutModel) _then) = __$GooiPayoutModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String cycleId, int cycleNumber, String? recipientMemberId, String recipientUserId, int amountFromContributions, int amountFromReserve, int totalPayoutAmount, int shortfallAmount, GooiPayoutStatus status, int retryCount, String? journalId, String? triggeredBy, DateTime? triggeredAt, DateTime? completedAt, List<String> defaulterMemberIds
});




}
/// @nodoc
class __$GooiPayoutModelCopyWithImpl<$Res>
    implements _$GooiPayoutModelCopyWith<$Res> {
  __$GooiPayoutModelCopyWithImpl(this._self, this._then);

  final _GooiPayoutModel _self;
  final $Res Function(_GooiPayoutModel) _then;

/// Create a copy of GooiPayoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cycleId = null,Object? cycleNumber = null,Object? recipientMemberId = freezed,Object? recipientUserId = null,Object? amountFromContributions = null,Object? amountFromReserve = null,Object? totalPayoutAmount = null,Object? shortfallAmount = null,Object? status = null,Object? retryCount = null,Object? journalId = freezed,Object? triggeredBy = freezed,Object? triggeredAt = freezed,Object? completedAt = freezed,Object? defaulterMemberIds = null,}) {
  return _then(_GooiPayoutModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cycleId: null == cycleId ? _self.cycleId : cycleId // ignore: cast_nullable_to_non_nullable
as String,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,recipientMemberId: freezed == recipientMemberId ? _self.recipientMemberId : recipientMemberId // ignore: cast_nullable_to_non_nullable
as String?,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,amountFromContributions: null == amountFromContributions ? _self.amountFromContributions : amountFromContributions // ignore: cast_nullable_to_non_nullable
as int,amountFromReserve: null == amountFromReserve ? _self.amountFromReserve : amountFromReserve // ignore: cast_nullable_to_non_nullable
as int,totalPayoutAmount: null == totalPayoutAmount ? _self.totalPayoutAmount : totalPayoutAmount // ignore: cast_nullable_to_non_nullable
as int,shortfallAmount: null == shortfallAmount ? _self.shortfallAmount : shortfallAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GooiPayoutStatus,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,triggeredBy: freezed == triggeredBy ? _self.triggeredBy : triggeredBy // ignore: cast_nullable_to_non_nullable
as String?,triggeredAt: freezed == triggeredAt ? _self.triggeredAt : triggeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,defaulterMemberIds: null == defaulterMemberIds ? _self._defaulterMemberIds : defaulterMemberIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
