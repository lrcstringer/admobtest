// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pot_distribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PotDistribution {

 String get id; String get potPoolId; PotType get potType; DateTime get drawDate; int get totalPrizePool; int get totalParticipants; int get totalEntries; List<PotWinnerAllocation> get winners; DistributionStatus get status; DateTime get createdAt; DateTime? get processedAt; String? get transactionBatchId;
/// Create a copy of PotDistribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotDistributionCopyWith<PotDistribution> get copyWith => _$PotDistributionCopyWithImpl<PotDistribution>(this as PotDistribution, _$identity);

  /// Serializes this PotDistribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotDistribution&&(identical(other.id, id) || other.id == id)&&(identical(other.potPoolId, potPoolId) || other.potPoolId == potPoolId)&&(identical(other.potType, potType) || other.potType == potType)&&(identical(other.drawDate, drawDate) || other.drawDate == drawDate)&&(identical(other.totalPrizePool, totalPrizePool) || other.totalPrizePool == totalPrizePool)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.totalEntries, totalEntries) || other.totalEntries == totalEntries)&&const DeepCollectionEquality().equals(other.winners, winners)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.transactionBatchId, transactionBatchId) || other.transactionBatchId == transactionBatchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,potPoolId,potType,drawDate,totalPrizePool,totalParticipants,totalEntries,const DeepCollectionEquality().hash(winners),status,createdAt,processedAt,transactionBatchId);

@override
String toString() {
  return 'PotDistribution(id: $id, potPoolId: $potPoolId, potType: $potType, drawDate: $drawDate, totalPrizePool: $totalPrizePool, totalParticipants: $totalParticipants, totalEntries: $totalEntries, winners: $winners, status: $status, createdAt: $createdAt, processedAt: $processedAt, transactionBatchId: $transactionBatchId)';
}


}

/// @nodoc
abstract mixin class $PotDistributionCopyWith<$Res>  {
  factory $PotDistributionCopyWith(PotDistribution value, $Res Function(PotDistribution) _then) = _$PotDistributionCopyWithImpl;
@useResult
$Res call({
 String id, String potPoolId, PotType potType, DateTime drawDate, int totalPrizePool, int totalParticipants, int totalEntries, List<PotWinnerAllocation> winners, DistributionStatus status, DateTime createdAt, DateTime? processedAt, String? transactionBatchId
});




}
/// @nodoc
class _$PotDistributionCopyWithImpl<$Res>
    implements $PotDistributionCopyWith<$Res> {
  _$PotDistributionCopyWithImpl(this._self, this._then);

  final PotDistribution _self;
  final $Res Function(PotDistribution) _then;

/// Create a copy of PotDistribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? potPoolId = null,Object? potType = null,Object? drawDate = null,Object? totalPrizePool = null,Object? totalParticipants = null,Object? totalEntries = null,Object? winners = null,Object? status = null,Object? createdAt = null,Object? processedAt = freezed,Object? transactionBatchId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,potPoolId: null == potPoolId ? _self.potPoolId : potPoolId // ignore: cast_nullable_to_non_nullable
as String,potType: null == potType ? _self.potType : potType // ignore: cast_nullable_to_non_nullable
as PotType,drawDate: null == drawDate ? _self.drawDate : drawDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalPrizePool: null == totalPrizePool ? _self.totalPrizePool : totalPrizePool // ignore: cast_nullable_to_non_nullable
as int,totalParticipants: null == totalParticipants ? _self.totalParticipants : totalParticipants // ignore: cast_nullable_to_non_nullable
as int,totalEntries: null == totalEntries ? _self.totalEntries : totalEntries // ignore: cast_nullable_to_non_nullable
as int,winners: null == winners ? _self.winners : winners // ignore: cast_nullable_to_non_nullable
as List<PotWinnerAllocation>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DistributionStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionBatchId: freezed == transactionBatchId ? _self.transactionBatchId : transactionBatchId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PotDistribution].
extension PotDistributionPatterns on PotDistribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotDistribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotDistribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotDistribution value)  $default,){
final _that = this;
switch (_that) {
case _PotDistribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotDistribution value)?  $default,){
final _that = this;
switch (_that) {
case _PotDistribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String potPoolId,  PotType potType,  DateTime drawDate,  int totalPrizePool,  int totalParticipants,  int totalEntries,  List<PotWinnerAllocation> winners,  DistributionStatus status,  DateTime createdAt,  DateTime? processedAt,  String? transactionBatchId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PotDistribution() when $default != null:
return $default(_that.id,_that.potPoolId,_that.potType,_that.drawDate,_that.totalPrizePool,_that.totalParticipants,_that.totalEntries,_that.winners,_that.status,_that.createdAt,_that.processedAt,_that.transactionBatchId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String potPoolId,  PotType potType,  DateTime drawDate,  int totalPrizePool,  int totalParticipants,  int totalEntries,  List<PotWinnerAllocation> winners,  DistributionStatus status,  DateTime createdAt,  DateTime? processedAt,  String? transactionBatchId)  $default,) {final _that = this;
switch (_that) {
case _PotDistribution():
return $default(_that.id,_that.potPoolId,_that.potType,_that.drawDate,_that.totalPrizePool,_that.totalParticipants,_that.totalEntries,_that.winners,_that.status,_that.createdAt,_that.processedAt,_that.transactionBatchId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String potPoolId,  PotType potType,  DateTime drawDate,  int totalPrizePool,  int totalParticipants,  int totalEntries,  List<PotWinnerAllocation> winners,  DistributionStatus status,  DateTime createdAt,  DateTime? processedAt,  String? transactionBatchId)?  $default,) {final _that = this;
switch (_that) {
case _PotDistribution() when $default != null:
return $default(_that.id,_that.potPoolId,_that.potType,_that.drawDate,_that.totalPrizePool,_that.totalParticipants,_that.totalEntries,_that.winners,_that.status,_that.createdAt,_that.processedAt,_that.transactionBatchId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PotDistribution implements PotDistribution {
  const _PotDistribution({required this.id, required this.potPoolId, required this.potType, required this.drawDate, required this.totalPrizePool, required this.totalParticipants, required this.totalEntries, required final  List<PotWinnerAllocation> winners, required this.status, required this.createdAt, this.processedAt, this.transactionBatchId}): _winners = winners;
  factory _PotDistribution.fromJson(Map<String, dynamic> json) => _$PotDistributionFromJson(json);

@override final  String id;
@override final  String potPoolId;
@override final  PotType potType;
@override final  DateTime drawDate;
@override final  int totalPrizePool;
@override final  int totalParticipants;
@override final  int totalEntries;
 final  List<PotWinnerAllocation> _winners;
@override List<PotWinnerAllocation> get winners {
  if (_winners is EqualUnmodifiableListView) return _winners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_winners);
}

@override final  DistributionStatus status;
@override final  DateTime createdAt;
@override final  DateTime? processedAt;
@override final  String? transactionBatchId;

/// Create a copy of PotDistribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotDistributionCopyWith<_PotDistribution> get copyWith => __$PotDistributionCopyWithImpl<_PotDistribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PotDistributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotDistribution&&(identical(other.id, id) || other.id == id)&&(identical(other.potPoolId, potPoolId) || other.potPoolId == potPoolId)&&(identical(other.potType, potType) || other.potType == potType)&&(identical(other.drawDate, drawDate) || other.drawDate == drawDate)&&(identical(other.totalPrizePool, totalPrizePool) || other.totalPrizePool == totalPrizePool)&&(identical(other.totalParticipants, totalParticipants) || other.totalParticipants == totalParticipants)&&(identical(other.totalEntries, totalEntries) || other.totalEntries == totalEntries)&&const DeepCollectionEquality().equals(other._winners, _winners)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.transactionBatchId, transactionBatchId) || other.transactionBatchId == transactionBatchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,potPoolId,potType,drawDate,totalPrizePool,totalParticipants,totalEntries,const DeepCollectionEquality().hash(_winners),status,createdAt,processedAt,transactionBatchId);

@override
String toString() {
  return 'PotDistribution(id: $id, potPoolId: $potPoolId, potType: $potType, drawDate: $drawDate, totalPrizePool: $totalPrizePool, totalParticipants: $totalParticipants, totalEntries: $totalEntries, winners: $winners, status: $status, createdAt: $createdAt, processedAt: $processedAt, transactionBatchId: $transactionBatchId)';
}


}

/// @nodoc
abstract mixin class _$PotDistributionCopyWith<$Res> implements $PotDistributionCopyWith<$Res> {
  factory _$PotDistributionCopyWith(_PotDistribution value, $Res Function(_PotDistribution) _then) = __$PotDistributionCopyWithImpl;
@override @useResult
$Res call({
 String id, String potPoolId, PotType potType, DateTime drawDate, int totalPrizePool, int totalParticipants, int totalEntries, List<PotWinnerAllocation> winners, DistributionStatus status, DateTime createdAt, DateTime? processedAt, String? transactionBatchId
});




}
/// @nodoc
class __$PotDistributionCopyWithImpl<$Res>
    implements _$PotDistributionCopyWith<$Res> {
  __$PotDistributionCopyWithImpl(this._self, this._then);

  final _PotDistribution _self;
  final $Res Function(_PotDistribution) _then;

/// Create a copy of PotDistribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? potPoolId = null,Object? potType = null,Object? drawDate = null,Object? totalPrizePool = null,Object? totalParticipants = null,Object? totalEntries = null,Object? winners = null,Object? status = null,Object? createdAt = null,Object? processedAt = freezed,Object? transactionBatchId = freezed,}) {
  return _then(_PotDistribution(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,potPoolId: null == potPoolId ? _self.potPoolId : potPoolId // ignore: cast_nullable_to_non_nullable
as String,potType: null == potType ? _self.potType : potType // ignore: cast_nullable_to_non_nullable
as PotType,drawDate: null == drawDate ? _self.drawDate : drawDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalPrizePool: null == totalPrizePool ? _self.totalPrizePool : totalPrizePool // ignore: cast_nullable_to_non_nullable
as int,totalParticipants: null == totalParticipants ? _self.totalParticipants : totalParticipants // ignore: cast_nullable_to_non_nullable
as int,totalEntries: null == totalEntries ? _self.totalEntries : totalEntries // ignore: cast_nullable_to_non_nullable
as int,winners: null == winners ? _self._winners : winners // ignore: cast_nullable_to_non_nullable
as List<PotWinnerAllocation>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DistributionStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionBatchId: freezed == transactionBatchId ? _self.transactionBatchId : transactionBatchId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PotWinnerAllocation {

 String get userId; int get rank; int get prizeAmount; int get entryCount; double get winProbability; String? get transactionId; bool? get notificationSent;
/// Create a copy of PotWinnerAllocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotWinnerAllocationCopyWith<PotWinnerAllocation> get copyWith => _$PotWinnerAllocationCopyWithImpl<PotWinnerAllocation>(this as PotWinnerAllocation, _$identity);

  /// Serializes this PotWinnerAllocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotWinnerAllocation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.prizeAmount, prizeAmount) || other.prizeAmount == prizeAmount)&&(identical(other.entryCount, entryCount) || other.entryCount == entryCount)&&(identical(other.winProbability, winProbability) || other.winProbability == winProbability)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.notificationSent, notificationSent) || other.notificationSent == notificationSent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,rank,prizeAmount,entryCount,winProbability,transactionId,notificationSent);

@override
String toString() {
  return 'PotWinnerAllocation(userId: $userId, rank: $rank, prizeAmount: $prizeAmount, entryCount: $entryCount, winProbability: $winProbability, transactionId: $transactionId, notificationSent: $notificationSent)';
}


}

/// @nodoc
abstract mixin class $PotWinnerAllocationCopyWith<$Res>  {
  factory $PotWinnerAllocationCopyWith(PotWinnerAllocation value, $Res Function(PotWinnerAllocation) _then) = _$PotWinnerAllocationCopyWithImpl;
@useResult
$Res call({
 String userId, int rank, int prizeAmount, int entryCount, double winProbability, String? transactionId, bool? notificationSent
});




}
/// @nodoc
class _$PotWinnerAllocationCopyWithImpl<$Res>
    implements $PotWinnerAllocationCopyWith<$Res> {
  _$PotWinnerAllocationCopyWithImpl(this._self, this._then);

  final PotWinnerAllocation _self;
  final $Res Function(PotWinnerAllocation) _then;

/// Create a copy of PotWinnerAllocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rank = null,Object? prizeAmount = null,Object? entryCount = null,Object? winProbability = null,Object? transactionId = freezed,Object? notificationSent = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,prizeAmount: null == prizeAmount ? _self.prizeAmount : prizeAmount // ignore: cast_nullable_to_non_nullable
as int,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,winProbability: null == winProbability ? _self.winProbability : winProbability // ignore: cast_nullable_to_non_nullable
as double,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,notificationSent: freezed == notificationSent ? _self.notificationSent : notificationSent // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PotWinnerAllocation].
extension PotWinnerAllocationPatterns on PotWinnerAllocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotWinnerAllocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotWinnerAllocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotWinnerAllocation value)  $default,){
final _that = this;
switch (_that) {
case _PotWinnerAllocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotWinnerAllocation value)?  $default,){
final _that = this;
switch (_that) {
case _PotWinnerAllocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int rank,  int prizeAmount,  int entryCount,  double winProbability,  String? transactionId,  bool? notificationSent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PotWinnerAllocation() when $default != null:
return $default(_that.userId,_that.rank,_that.prizeAmount,_that.entryCount,_that.winProbability,_that.transactionId,_that.notificationSent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int rank,  int prizeAmount,  int entryCount,  double winProbability,  String? transactionId,  bool? notificationSent)  $default,) {final _that = this;
switch (_that) {
case _PotWinnerAllocation():
return $default(_that.userId,_that.rank,_that.prizeAmount,_that.entryCount,_that.winProbability,_that.transactionId,_that.notificationSent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int rank,  int prizeAmount,  int entryCount,  double winProbability,  String? transactionId,  bool? notificationSent)?  $default,) {final _that = this;
switch (_that) {
case _PotWinnerAllocation() when $default != null:
return $default(_that.userId,_that.rank,_that.prizeAmount,_that.entryCount,_that.winProbability,_that.transactionId,_that.notificationSent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PotWinnerAllocation implements PotWinnerAllocation {
  const _PotWinnerAllocation({required this.userId, required this.rank, required this.prizeAmount, required this.entryCount, required this.winProbability, this.transactionId, this.notificationSent});
  factory _PotWinnerAllocation.fromJson(Map<String, dynamic> json) => _$PotWinnerAllocationFromJson(json);

@override final  String userId;
@override final  int rank;
@override final  int prizeAmount;
@override final  int entryCount;
@override final  double winProbability;
@override final  String? transactionId;
@override final  bool? notificationSent;

/// Create a copy of PotWinnerAllocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotWinnerAllocationCopyWith<_PotWinnerAllocation> get copyWith => __$PotWinnerAllocationCopyWithImpl<_PotWinnerAllocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PotWinnerAllocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotWinnerAllocation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.prizeAmount, prizeAmount) || other.prizeAmount == prizeAmount)&&(identical(other.entryCount, entryCount) || other.entryCount == entryCount)&&(identical(other.winProbability, winProbability) || other.winProbability == winProbability)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.notificationSent, notificationSent) || other.notificationSent == notificationSent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,rank,prizeAmount,entryCount,winProbability,transactionId,notificationSent);

@override
String toString() {
  return 'PotWinnerAllocation(userId: $userId, rank: $rank, prizeAmount: $prizeAmount, entryCount: $entryCount, winProbability: $winProbability, transactionId: $transactionId, notificationSent: $notificationSent)';
}


}

/// @nodoc
abstract mixin class _$PotWinnerAllocationCopyWith<$Res> implements $PotWinnerAllocationCopyWith<$Res> {
  factory _$PotWinnerAllocationCopyWith(_PotWinnerAllocation value, $Res Function(_PotWinnerAllocation) _then) = __$PotWinnerAllocationCopyWithImpl;
@override @useResult
$Res call({
 String userId, int rank, int prizeAmount, int entryCount, double winProbability, String? transactionId, bool? notificationSent
});




}
/// @nodoc
class __$PotWinnerAllocationCopyWithImpl<$Res>
    implements _$PotWinnerAllocationCopyWith<$Res> {
  __$PotWinnerAllocationCopyWithImpl(this._self, this._then);

  final _PotWinnerAllocation _self;
  final $Res Function(_PotWinnerAllocation) _then;

/// Create a copy of PotWinnerAllocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rank = null,Object? prizeAmount = null,Object? entryCount = null,Object? winProbability = null,Object? transactionId = freezed,Object? notificationSent = freezed,}) {
  return _then(_PotWinnerAllocation(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,prizeAmount: null == prizeAmount ? _self.prizeAmount : prizeAmount // ignore: cast_nullable_to_non_nullable
as int,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,winProbability: null == winProbability ? _self.winProbability : winProbability // ignore: cast_nullable_to_non_nullable
as double,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,notificationSent: freezed == notificationSent ? _self.notificationSent : notificationSent // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
