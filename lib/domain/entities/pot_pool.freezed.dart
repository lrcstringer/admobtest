// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pot_pool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PotPool {

 String get id; PotType get type; int get totalTokens; int get participantCount; DateTime get periodStart; DateTime get periodEnd; bool get isActive; bool get isDistributed; DateTime? get distributedAt; List<PotWinner>? get winners; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of PotPool
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotPoolCopyWith<PotPool> get copyWith => _$PotPoolCopyWithImpl<PotPool>(this as PotPool, _$identity);

  /// Serializes this PotPool to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotPool&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDistributed, isDistributed) || other.isDistributed == isDistributed)&&(identical(other.distributedAt, distributedAt) || other.distributedAt == distributedAt)&&const DeepCollectionEquality().equals(other.winners, winners)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,totalTokens,participantCount,periodStart,periodEnd,isActive,isDistributed,distributedAt,const DeepCollectionEquality().hash(winners),createdAt,updatedAt);

@override
String toString() {
  return 'PotPool(id: $id, type: $type, totalTokens: $totalTokens, participantCount: $participantCount, periodStart: $periodStart, periodEnd: $periodEnd, isActive: $isActive, isDistributed: $isDistributed, distributedAt: $distributedAt, winners: $winners, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PotPoolCopyWith<$Res>  {
  factory $PotPoolCopyWith(PotPool value, $Res Function(PotPool) _then) = _$PotPoolCopyWithImpl;
@useResult
$Res call({
 String id, PotType type, int totalTokens, int participantCount, DateTime periodStart, DateTime periodEnd, bool isActive, bool isDistributed, DateTime? distributedAt, List<PotWinner>? winners, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PotPoolCopyWithImpl<$Res>
    implements $PotPoolCopyWith<$Res> {
  _$PotPoolCopyWithImpl(this._self, this._then);

  final PotPool _self;
  final $Res Function(PotPool) _then;

/// Create a copy of PotPool
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? totalTokens = null,Object? participantCount = null,Object? periodStart = null,Object? periodEnd = null,Object? isActive = null,Object? isDistributed = null,Object? distributedAt = freezed,Object? winners = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PotType,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDistributed: null == isDistributed ? _self.isDistributed : isDistributed // ignore: cast_nullable_to_non_nullable
as bool,distributedAt: freezed == distributedAt ? _self.distributedAt : distributedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winners: freezed == winners ? _self.winners : winners // ignore: cast_nullable_to_non_nullable
as List<PotWinner>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PotPool].
extension PotPoolPatterns on PotPool {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotPool value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotPool() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotPool value)  $default,){
final _that = this;
switch (_that) {
case _PotPool():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotPool value)?  $default,){
final _that = this;
switch (_that) {
case _PotPool() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PotType type,  int totalTokens,  int participantCount,  DateTime periodStart,  DateTime periodEnd,  bool isActive,  bool isDistributed,  DateTime? distributedAt,  List<PotWinner>? winners,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PotPool() when $default != null:
return $default(_that.id,_that.type,_that.totalTokens,_that.participantCount,_that.periodStart,_that.periodEnd,_that.isActive,_that.isDistributed,_that.distributedAt,_that.winners,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PotType type,  int totalTokens,  int participantCount,  DateTime periodStart,  DateTime periodEnd,  bool isActive,  bool isDistributed,  DateTime? distributedAt,  List<PotWinner>? winners,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PotPool():
return $default(_that.id,_that.type,_that.totalTokens,_that.participantCount,_that.periodStart,_that.periodEnd,_that.isActive,_that.isDistributed,_that.distributedAt,_that.winners,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PotType type,  int totalTokens,  int participantCount,  DateTime periodStart,  DateTime periodEnd,  bool isActive,  bool isDistributed,  DateTime? distributedAt,  List<PotWinner>? winners,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PotPool() when $default != null:
return $default(_that.id,_that.type,_that.totalTokens,_that.participantCount,_that.periodStart,_that.periodEnd,_that.isActive,_that.isDistributed,_that.distributedAt,_that.winners,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PotPool extends PotPool {
  const _PotPool({required this.id, required this.type, required this.totalTokens, required this.participantCount, required this.periodStart, required this.periodEnd, required this.isActive, required this.isDistributed, this.distributedAt, final  List<PotWinner>? winners, required this.createdAt, this.updatedAt}): _winners = winners,super._();
  factory _PotPool.fromJson(Map<String, dynamic> json) => _$PotPoolFromJson(json);

@override final  String id;
@override final  PotType type;
@override final  int totalTokens;
@override final  int participantCount;
@override final  DateTime periodStart;
@override final  DateTime periodEnd;
@override final  bool isActive;
@override final  bool isDistributed;
@override final  DateTime? distributedAt;
 final  List<PotWinner>? _winners;
@override List<PotWinner>? get winners {
  final value = _winners;
  if (value == null) return null;
  if (_winners is EqualUnmodifiableListView) return _winners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of PotPool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotPoolCopyWith<_PotPool> get copyWith => __$PotPoolCopyWithImpl<_PotPool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PotPoolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotPool&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDistributed, isDistributed) || other.isDistributed == isDistributed)&&(identical(other.distributedAt, distributedAt) || other.distributedAt == distributedAt)&&const DeepCollectionEquality().equals(other._winners, _winners)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,totalTokens,participantCount,periodStart,periodEnd,isActive,isDistributed,distributedAt,const DeepCollectionEquality().hash(_winners),createdAt,updatedAt);

@override
String toString() {
  return 'PotPool(id: $id, type: $type, totalTokens: $totalTokens, participantCount: $participantCount, periodStart: $periodStart, periodEnd: $periodEnd, isActive: $isActive, isDistributed: $isDistributed, distributedAt: $distributedAt, winners: $winners, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PotPoolCopyWith<$Res> implements $PotPoolCopyWith<$Res> {
  factory _$PotPoolCopyWith(_PotPool value, $Res Function(_PotPool) _then) = __$PotPoolCopyWithImpl;
@override @useResult
$Res call({
 String id, PotType type, int totalTokens, int participantCount, DateTime periodStart, DateTime periodEnd, bool isActive, bool isDistributed, DateTime? distributedAt, List<PotWinner>? winners, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PotPoolCopyWithImpl<$Res>
    implements _$PotPoolCopyWith<$Res> {
  __$PotPoolCopyWithImpl(this._self, this._then);

  final _PotPool _self;
  final $Res Function(_PotPool) _then;

/// Create a copy of PotPool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? totalTokens = null,Object? participantCount = null,Object? periodStart = null,Object? periodEnd = null,Object? isActive = null,Object? isDistributed = null,Object? distributedAt = freezed,Object? winners = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_PotPool(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PotType,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDistributed: null == isDistributed ? _self.isDistributed : isDistributed // ignore: cast_nullable_to_non_nullable
as bool,distributedAt: freezed == distributedAt ? _self.distributedAt : distributedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winners: freezed == winners ? _self._winners : winners // ignore: cast_nullable_to_non_nullable
as List<PotWinner>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PotWinner {

 String get userId; String get displayName; String? get username; int get rank; int get tokensWon; double get percentage;
/// Create a copy of PotWinner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotWinnerCopyWith<PotWinner> get copyWith => _$PotWinnerCopyWithImpl<PotWinner>(this as PotWinner, _$identity);

  /// Serializes this PotWinner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotWinner&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.tokensWon, tokensWon) || other.tokensWon == tokensWon)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,rank,tokensWon,percentage);

@override
String toString() {
  return 'PotWinner(userId: $userId, displayName: $displayName, username: $username, rank: $rank, tokensWon: $tokensWon, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $PotWinnerCopyWith<$Res>  {
  factory $PotWinnerCopyWith(PotWinner value, $Res Function(PotWinner) _then) = _$PotWinnerCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? username, int rank, int tokensWon, double percentage
});




}
/// @nodoc
class _$PotWinnerCopyWithImpl<$Res>
    implements $PotWinnerCopyWith<$Res> {
  _$PotWinnerCopyWithImpl(this._self, this._then);

  final PotWinner _self;
  final $Res Function(PotWinner) _then;

/// Create a copy of PotWinner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? rank = null,Object? tokensWon = null,Object? percentage = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,tokensWon: null == tokensWon ? _self.tokensWon : tokensWon // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PotWinner].
extension PotWinnerPatterns on PotWinner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotWinner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotWinner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotWinner value)  $default,){
final _that = this;
switch (_that) {
case _PotWinner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotWinner value)?  $default,){
final _that = this;
switch (_that) {
case _PotWinner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? username,  int rank,  int tokensWon,  double percentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PotWinner() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.rank,_that.tokensWon,_that.percentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? username,  int rank,  int tokensWon,  double percentage)  $default,) {final _that = this;
switch (_that) {
case _PotWinner():
return $default(_that.userId,_that.displayName,_that.username,_that.rank,_that.tokensWon,_that.percentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? username,  int rank,  int tokensWon,  double percentage)?  $default,) {final _that = this;
switch (_that) {
case _PotWinner() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.rank,_that.tokensWon,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PotWinner implements PotWinner {
  const _PotWinner({required this.userId, required this.displayName, this.username, required this.rank, required this.tokensWon, required this.percentage});
  factory _PotWinner.fromJson(Map<String, dynamic> json) => _$PotWinnerFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? username;
@override final  int rank;
@override final  int tokensWon;
@override final  double percentage;

/// Create a copy of PotWinner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotWinnerCopyWith<_PotWinner> get copyWith => __$PotWinnerCopyWithImpl<_PotWinner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PotWinnerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotWinner&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.tokensWon, tokensWon) || other.tokensWon == tokensWon)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,rank,tokensWon,percentage);

@override
String toString() {
  return 'PotWinner(userId: $userId, displayName: $displayName, username: $username, rank: $rank, tokensWon: $tokensWon, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$PotWinnerCopyWith<$Res> implements $PotWinnerCopyWith<$Res> {
  factory _$PotWinnerCopyWith(_PotWinner value, $Res Function(_PotWinner) _then) = __$PotWinnerCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? username, int rank, int tokensWon, double percentage
});




}
/// @nodoc
class __$PotWinnerCopyWithImpl<$Res>
    implements _$PotWinnerCopyWith<$Res> {
  __$PotWinnerCopyWithImpl(this._self, this._then);

  final _PotWinner _self;
  final $Res Function(_PotWinner) _then;

/// Create a copy of PotWinner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? rank = null,Object? tokensWon = null,Object? percentage = null,}) {
  return _then(_PotWinner(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,tokensWon: null == tokensWon ? _self.tokensWon : tokensWon // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
