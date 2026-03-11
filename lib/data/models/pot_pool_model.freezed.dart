// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pot_pool_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PotPoolModel {

 String get id; String get type; int get totalTokens; int get participantCount; DateTime get periodStart; DateTime get periodEnd; bool get isActive; bool get isDistributed; DateTime? get distributedAt; List<PotWinnerModel>? get winners; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of PotPoolModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotPoolModelCopyWith<PotPoolModel> get copyWith => _$PotPoolModelCopyWithImpl<PotPoolModel>(this as PotPoolModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotPoolModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDistributed, isDistributed) || other.isDistributed == isDistributed)&&(identical(other.distributedAt, distributedAt) || other.distributedAt == distributedAt)&&const DeepCollectionEquality().equals(other.winners, winners)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,totalTokens,participantCount,periodStart,periodEnd,isActive,isDistributed,distributedAt,const DeepCollectionEquality().hash(winners),createdAt,updatedAt);

@override
String toString() {
  return 'PotPoolModel(id: $id, type: $type, totalTokens: $totalTokens, participantCount: $participantCount, periodStart: $periodStart, periodEnd: $periodEnd, isActive: $isActive, isDistributed: $isDistributed, distributedAt: $distributedAt, winners: $winners, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PotPoolModelCopyWith<$Res>  {
  factory $PotPoolModelCopyWith(PotPoolModel value, $Res Function(PotPoolModel) _then) = _$PotPoolModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, int totalTokens, int participantCount, DateTime periodStart, DateTime periodEnd, bool isActive, bool isDistributed, DateTime? distributedAt, List<PotWinnerModel>? winners, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PotPoolModelCopyWithImpl<$Res>
    implements $PotPoolModelCopyWith<$Res> {
  _$PotPoolModelCopyWithImpl(this._self, this._then);

  final PotPoolModel _self;
  final $Res Function(PotPoolModel) _then;

/// Create a copy of PotPoolModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? totalTokens = null,Object? participantCount = null,Object? periodStart = null,Object? periodEnd = null,Object? isActive = null,Object? isDistributed = null,Object? distributedAt = freezed,Object? winners = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDistributed: null == isDistributed ? _self.isDistributed : isDistributed // ignore: cast_nullable_to_non_nullable
as bool,distributedAt: freezed == distributedAt ? _self.distributedAt : distributedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winners: freezed == winners ? _self.winners : winners // ignore: cast_nullable_to_non_nullable
as List<PotWinnerModel>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PotPoolModel].
extension PotPoolModelPatterns on PotPoolModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotPoolModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotPoolModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotPoolModel value)  $default,){
final _that = this;
switch (_that) {
case _PotPoolModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotPoolModel value)?  $default,){
final _that = this;
switch (_that) {
case _PotPoolModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  int totalTokens,  int participantCount,  DateTime periodStart,  DateTime periodEnd,  bool isActive,  bool isDistributed,  DateTime? distributedAt,  List<PotWinnerModel>? winners,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PotPoolModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  int totalTokens,  int participantCount,  DateTime periodStart,  DateTime periodEnd,  bool isActive,  bool isDistributed,  DateTime? distributedAt,  List<PotWinnerModel>? winners,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PotPoolModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  int totalTokens,  int participantCount,  DateTime periodStart,  DateTime periodEnd,  bool isActive,  bool isDistributed,  DateTime? distributedAt,  List<PotWinnerModel>? winners,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PotPoolModel() when $default != null:
return $default(_that.id,_that.type,_that.totalTokens,_that.participantCount,_that.periodStart,_that.periodEnd,_that.isActive,_that.isDistributed,_that.distributedAt,_that.winners,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PotPoolModel extends PotPoolModel {
  const _PotPoolModel({required this.id, required this.type, required this.totalTokens, required this.participantCount, required this.periodStart, required this.periodEnd, required this.isActive, required this.isDistributed, this.distributedAt, final  List<PotWinnerModel>? winners, required this.createdAt, this.updatedAt}): _winners = winners,super._();
  

@override final  String id;
@override final  String type;
@override final  int totalTokens;
@override final  int participantCount;
@override final  DateTime periodStart;
@override final  DateTime periodEnd;
@override final  bool isActive;
@override final  bool isDistributed;
@override final  DateTime? distributedAt;
 final  List<PotWinnerModel>? _winners;
@override List<PotWinnerModel>? get winners {
  final value = _winners;
  if (value == null) return null;
  if (_winners is EqualUnmodifiableListView) return _winners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of PotPoolModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotPoolModelCopyWith<_PotPoolModel> get copyWith => __$PotPoolModelCopyWithImpl<_PotPoolModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotPoolModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDistributed, isDistributed) || other.isDistributed == isDistributed)&&(identical(other.distributedAt, distributedAt) || other.distributedAt == distributedAt)&&const DeepCollectionEquality().equals(other._winners, _winners)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,totalTokens,participantCount,periodStart,periodEnd,isActive,isDistributed,distributedAt,const DeepCollectionEquality().hash(_winners),createdAt,updatedAt);

@override
String toString() {
  return 'PotPoolModel(id: $id, type: $type, totalTokens: $totalTokens, participantCount: $participantCount, periodStart: $periodStart, periodEnd: $periodEnd, isActive: $isActive, isDistributed: $isDistributed, distributedAt: $distributedAt, winners: $winners, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PotPoolModelCopyWith<$Res> implements $PotPoolModelCopyWith<$Res> {
  factory _$PotPoolModelCopyWith(_PotPoolModel value, $Res Function(_PotPoolModel) _then) = __$PotPoolModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, int totalTokens, int participantCount, DateTime periodStart, DateTime periodEnd, bool isActive, bool isDistributed, DateTime? distributedAt, List<PotWinnerModel>? winners, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PotPoolModelCopyWithImpl<$Res>
    implements _$PotPoolModelCopyWith<$Res> {
  __$PotPoolModelCopyWithImpl(this._self, this._then);

  final _PotPoolModel _self;
  final $Res Function(_PotPoolModel) _then;

/// Create a copy of PotPoolModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? totalTokens = null,Object? participantCount = null,Object? periodStart = null,Object? periodEnd = null,Object? isActive = null,Object? isDistributed = null,Object? distributedAt = freezed,Object? winners = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_PotPoolModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,totalTokens: null == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDistributed: null == isDistributed ? _self.isDistributed : isDistributed // ignore: cast_nullable_to_non_nullable
as bool,distributedAt: freezed == distributedAt ? _self.distributedAt : distributedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winners: freezed == winners ? _self._winners : winners // ignore: cast_nullable_to_non_nullable
as List<PotWinnerModel>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$PotWinnerModel {

 String get userId; String get displayName; String? get username; int get rank; int get tokensWon; double get percentage;
/// Create a copy of PotWinnerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotWinnerModelCopyWith<PotWinnerModel> get copyWith => _$PotWinnerModelCopyWithImpl<PotWinnerModel>(this as PotWinnerModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotWinnerModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.tokensWon, tokensWon) || other.tokensWon == tokensWon)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,rank,tokensWon,percentage);

@override
String toString() {
  return 'PotWinnerModel(userId: $userId, displayName: $displayName, username: $username, rank: $rank, tokensWon: $tokensWon, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $PotWinnerModelCopyWith<$Res>  {
  factory $PotWinnerModelCopyWith(PotWinnerModel value, $Res Function(PotWinnerModel) _then) = _$PotWinnerModelCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? username, int rank, int tokensWon, double percentage
});




}
/// @nodoc
class _$PotWinnerModelCopyWithImpl<$Res>
    implements $PotWinnerModelCopyWith<$Res> {
  _$PotWinnerModelCopyWithImpl(this._self, this._then);

  final PotWinnerModel _self;
  final $Res Function(PotWinnerModel) _then;

/// Create a copy of PotWinnerModel
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


/// Adds pattern-matching-related methods to [PotWinnerModel].
extension PotWinnerModelPatterns on PotWinnerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotWinnerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotWinnerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotWinnerModel value)  $default,){
final _that = this;
switch (_that) {
case _PotWinnerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotWinnerModel value)?  $default,){
final _that = this;
switch (_that) {
case _PotWinnerModel() when $default != null:
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
case _PotWinnerModel() when $default != null:
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
case _PotWinnerModel():
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
case _PotWinnerModel() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.rank,_that.tokensWon,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc


class _PotWinnerModel extends PotWinnerModel {
  const _PotWinnerModel({required this.userId, required this.displayName, this.username, required this.rank, required this.tokensWon, required this.percentage}): super._();
  

@override final  String userId;
@override final  String displayName;
@override final  String? username;
@override final  int rank;
@override final  int tokensWon;
@override final  double percentage;

/// Create a copy of PotWinnerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotWinnerModelCopyWith<_PotWinnerModel> get copyWith => __$PotWinnerModelCopyWithImpl<_PotWinnerModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotWinnerModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.tokensWon, tokensWon) || other.tokensWon == tokensWon)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,userId,displayName,username,rank,tokensWon,percentage);

@override
String toString() {
  return 'PotWinnerModel(userId: $userId, displayName: $displayName, username: $username, rank: $rank, tokensWon: $tokensWon, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$PotWinnerModelCopyWith<$Res> implements $PotWinnerModelCopyWith<$Res> {
  factory _$PotWinnerModelCopyWith(_PotWinnerModel value, $Res Function(_PotWinnerModel) _then) = __$PotWinnerModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? username, int rank, int tokensWon, double percentage
});




}
/// @nodoc
class __$PotWinnerModelCopyWithImpl<$Res>
    implements _$PotWinnerModelCopyWith<$Res> {
  __$PotWinnerModelCopyWithImpl(this._self, this._then);

  final _PotWinnerModel _self;
  final $Res Function(_PotWinnerModel) _then;

/// Create a copy of PotWinnerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? rank = null,Object? tokensWon = null,Object? percentage = null,}) {
  return _then(_PotWinnerModel(
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
