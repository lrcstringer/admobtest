// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pot_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PotEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PotEvent()';
}


}

/// @nodoc
class $PotEventCopyWith<$Res>  {
$PotEventCopyWith(PotEvent _, $Res Function(PotEvent) __);
}


/// Adds pattern-matching-related methods to [PotEvent].
extension PotEventPatterns on PotEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadDailyPot value)?  loadDailyPot,TResult Function( _LoadWeeklyPot value)?  loadWeeklyPot,TResult Function( _WatchDailyPot value)?  watchDailyPot,TResult Function( _WatchWeeklyPot value)?  watchWeeklyPot,TResult Function( _DailyPotUpdated value)?  dailyPotUpdated,TResult Function( _WeeklyPotUpdated value)?  weeklyPotUpdated,TResult Function( _LoadLeaderboard value)?  loadLeaderboard,TResult Function( _WatchLeaderboard value)?  watchLeaderboard,TResult Function( _LeaderboardUpdated value)?  leaderboardUpdated,TResult Function( _LoadPotHistory value)?  loadPotHistory,TResult Function( _LoadCurrentUserScore value)?  loadCurrentUserScore,TResult Function( _CheckEligibility value)?  checkEligibility,TResult Function( _SelectPotType value)?  selectPotType,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadDailyPot() when loadDailyPot != null:
return loadDailyPot(_that);case _LoadWeeklyPot() when loadWeeklyPot != null:
return loadWeeklyPot(_that);case _WatchDailyPot() when watchDailyPot != null:
return watchDailyPot(_that);case _WatchWeeklyPot() when watchWeeklyPot != null:
return watchWeeklyPot(_that);case _DailyPotUpdated() when dailyPotUpdated != null:
return dailyPotUpdated(_that);case _WeeklyPotUpdated() when weeklyPotUpdated != null:
return weeklyPotUpdated(_that);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that);case _WatchLeaderboard() when watchLeaderboard != null:
return watchLeaderboard(_that);case _LeaderboardUpdated() when leaderboardUpdated != null:
return leaderboardUpdated(_that);case _LoadPotHistory() when loadPotHistory != null:
return loadPotHistory(_that);case _LoadCurrentUserScore() when loadCurrentUserScore != null:
return loadCurrentUserScore(_that);case _CheckEligibility() when checkEligibility != null:
return checkEligibility(_that);case _SelectPotType() when selectPotType != null:
return selectPotType(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadDailyPot value)  loadDailyPot,required TResult Function( _LoadWeeklyPot value)  loadWeeklyPot,required TResult Function( _WatchDailyPot value)  watchDailyPot,required TResult Function( _WatchWeeklyPot value)  watchWeeklyPot,required TResult Function( _DailyPotUpdated value)  dailyPotUpdated,required TResult Function( _WeeklyPotUpdated value)  weeklyPotUpdated,required TResult Function( _LoadLeaderboard value)  loadLeaderboard,required TResult Function( _WatchLeaderboard value)  watchLeaderboard,required TResult Function( _LeaderboardUpdated value)  leaderboardUpdated,required TResult Function( _LoadPotHistory value)  loadPotHistory,required TResult Function( _LoadCurrentUserScore value)  loadCurrentUserScore,required TResult Function( _CheckEligibility value)  checkEligibility,required TResult Function( _SelectPotType value)  selectPotType,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _LoadDailyPot():
return loadDailyPot(_that);case _LoadWeeklyPot():
return loadWeeklyPot(_that);case _WatchDailyPot():
return watchDailyPot(_that);case _WatchWeeklyPot():
return watchWeeklyPot(_that);case _DailyPotUpdated():
return dailyPotUpdated(_that);case _WeeklyPotUpdated():
return weeklyPotUpdated(_that);case _LoadLeaderboard():
return loadLeaderboard(_that);case _WatchLeaderboard():
return watchLeaderboard(_that);case _LeaderboardUpdated():
return leaderboardUpdated(_that);case _LoadPotHistory():
return loadPotHistory(_that);case _LoadCurrentUserScore():
return loadCurrentUserScore(_that);case _CheckEligibility():
return checkEligibility(_that);case _SelectPotType():
return selectPotType(_that);case _ClearError():
return clearError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadDailyPot value)?  loadDailyPot,TResult? Function( _LoadWeeklyPot value)?  loadWeeklyPot,TResult? Function( _WatchDailyPot value)?  watchDailyPot,TResult? Function( _WatchWeeklyPot value)?  watchWeeklyPot,TResult? Function( _DailyPotUpdated value)?  dailyPotUpdated,TResult? Function( _WeeklyPotUpdated value)?  weeklyPotUpdated,TResult? Function( _LoadLeaderboard value)?  loadLeaderboard,TResult? Function( _WatchLeaderboard value)?  watchLeaderboard,TResult? Function( _LeaderboardUpdated value)?  leaderboardUpdated,TResult? Function( _LoadPotHistory value)?  loadPotHistory,TResult? Function( _LoadCurrentUserScore value)?  loadCurrentUserScore,TResult? Function( _CheckEligibility value)?  checkEligibility,TResult? Function( _SelectPotType value)?  selectPotType,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _LoadDailyPot() when loadDailyPot != null:
return loadDailyPot(_that);case _LoadWeeklyPot() when loadWeeklyPot != null:
return loadWeeklyPot(_that);case _WatchDailyPot() when watchDailyPot != null:
return watchDailyPot(_that);case _WatchWeeklyPot() when watchWeeklyPot != null:
return watchWeeklyPot(_that);case _DailyPotUpdated() when dailyPotUpdated != null:
return dailyPotUpdated(_that);case _WeeklyPotUpdated() when weeklyPotUpdated != null:
return weeklyPotUpdated(_that);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that);case _WatchLeaderboard() when watchLeaderboard != null:
return watchLeaderboard(_that);case _LeaderboardUpdated() when leaderboardUpdated != null:
return leaderboardUpdated(_that);case _LoadPotHistory() when loadPotHistory != null:
return loadPotHistory(_that);case _LoadCurrentUserScore() when loadCurrentUserScore != null:
return loadCurrentUserScore(_that);case _CheckEligibility() when checkEligibility != null:
return checkEligibility(_that);case _SelectPotType() when selectPotType != null:
return selectPotType(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadDailyPot,TResult Function()?  loadWeeklyPot,TResult Function()?  watchDailyPot,TResult Function()?  watchWeeklyPot,TResult Function( PotPool pot)?  dailyPotUpdated,TResult Function( PotPool pot)?  weeklyPotUpdated,TResult Function( PotType type,  int? limit)?  loadLeaderboard,TResult Function( PotType type,  int? limit)?  watchLeaderboard,TResult Function( List<UserScore> scores)?  leaderboardUpdated,TResult Function( PotType type,  int? limit)?  loadPotHistory,TResult Function( PotType type)?  loadCurrentUserScore,TResult Function()?  checkEligibility,TResult Function( PotType type)?  selectPotType,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadDailyPot() when loadDailyPot != null:
return loadDailyPot();case _LoadWeeklyPot() when loadWeeklyPot != null:
return loadWeeklyPot();case _WatchDailyPot() when watchDailyPot != null:
return watchDailyPot();case _WatchWeeklyPot() when watchWeeklyPot != null:
return watchWeeklyPot();case _DailyPotUpdated() when dailyPotUpdated != null:
return dailyPotUpdated(_that.pot);case _WeeklyPotUpdated() when weeklyPotUpdated != null:
return weeklyPotUpdated(_that.pot);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that.type,_that.limit);case _WatchLeaderboard() when watchLeaderboard != null:
return watchLeaderboard(_that.type,_that.limit);case _LeaderboardUpdated() when leaderboardUpdated != null:
return leaderboardUpdated(_that.scores);case _LoadPotHistory() when loadPotHistory != null:
return loadPotHistory(_that.type,_that.limit);case _LoadCurrentUserScore() when loadCurrentUserScore != null:
return loadCurrentUserScore(_that.type);case _CheckEligibility() when checkEligibility != null:
return checkEligibility();case _SelectPotType() when selectPotType != null:
return selectPotType(_that.type);case _ClearError() when clearError != null:
return clearError();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadDailyPot,required TResult Function()  loadWeeklyPot,required TResult Function()  watchDailyPot,required TResult Function()  watchWeeklyPot,required TResult Function( PotPool pot)  dailyPotUpdated,required TResult Function( PotPool pot)  weeklyPotUpdated,required TResult Function( PotType type,  int? limit)  loadLeaderboard,required TResult Function( PotType type,  int? limit)  watchLeaderboard,required TResult Function( List<UserScore> scores)  leaderboardUpdated,required TResult Function( PotType type,  int? limit)  loadPotHistory,required TResult Function( PotType type)  loadCurrentUserScore,required TResult Function()  checkEligibility,required TResult Function( PotType type)  selectPotType,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _LoadDailyPot():
return loadDailyPot();case _LoadWeeklyPot():
return loadWeeklyPot();case _WatchDailyPot():
return watchDailyPot();case _WatchWeeklyPot():
return watchWeeklyPot();case _DailyPotUpdated():
return dailyPotUpdated(_that.pot);case _WeeklyPotUpdated():
return weeklyPotUpdated(_that.pot);case _LoadLeaderboard():
return loadLeaderboard(_that.type,_that.limit);case _WatchLeaderboard():
return watchLeaderboard(_that.type,_that.limit);case _LeaderboardUpdated():
return leaderboardUpdated(_that.scores);case _LoadPotHistory():
return loadPotHistory(_that.type,_that.limit);case _LoadCurrentUserScore():
return loadCurrentUserScore(_that.type);case _CheckEligibility():
return checkEligibility();case _SelectPotType():
return selectPotType(_that.type);case _ClearError():
return clearError();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadDailyPot,TResult? Function()?  loadWeeklyPot,TResult? Function()?  watchDailyPot,TResult? Function()?  watchWeeklyPot,TResult? Function( PotPool pot)?  dailyPotUpdated,TResult? Function( PotPool pot)?  weeklyPotUpdated,TResult? Function( PotType type,  int? limit)?  loadLeaderboard,TResult? Function( PotType type,  int? limit)?  watchLeaderboard,TResult? Function( List<UserScore> scores)?  leaderboardUpdated,TResult? Function( PotType type,  int? limit)?  loadPotHistory,TResult? Function( PotType type)?  loadCurrentUserScore,TResult? Function()?  checkEligibility,TResult? Function( PotType type)?  selectPotType,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _LoadDailyPot() when loadDailyPot != null:
return loadDailyPot();case _LoadWeeklyPot() when loadWeeklyPot != null:
return loadWeeklyPot();case _WatchDailyPot() when watchDailyPot != null:
return watchDailyPot();case _WatchWeeklyPot() when watchWeeklyPot != null:
return watchWeeklyPot();case _DailyPotUpdated() when dailyPotUpdated != null:
return dailyPotUpdated(_that.pot);case _WeeklyPotUpdated() when weeklyPotUpdated != null:
return weeklyPotUpdated(_that.pot);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that.type,_that.limit);case _WatchLeaderboard() when watchLeaderboard != null:
return watchLeaderboard(_that.type,_that.limit);case _LeaderboardUpdated() when leaderboardUpdated != null:
return leaderboardUpdated(_that.scores);case _LoadPotHistory() when loadPotHistory != null:
return loadPotHistory(_that.type,_that.limit);case _LoadCurrentUserScore() when loadCurrentUserScore != null:
return loadCurrentUserScore(_that.type);case _CheckEligibility() when checkEligibility != null:
return checkEligibility();case _SelectPotType() when selectPotType != null:
return selectPotType(_that.type);case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _LoadDailyPot implements PotEvent {
  const _LoadDailyPot();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadDailyPot);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PotEvent.loadDailyPot()';
}


}




/// @nodoc


class _LoadWeeklyPot implements PotEvent {
  const _LoadWeeklyPot();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadWeeklyPot);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PotEvent.loadWeeklyPot()';
}


}




/// @nodoc


class _WatchDailyPot implements PotEvent {
  const _WatchDailyPot();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchDailyPot);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PotEvent.watchDailyPot()';
}


}




/// @nodoc


class _WatchWeeklyPot implements PotEvent {
  const _WatchWeeklyPot();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchWeeklyPot);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PotEvent.watchWeeklyPot()';
}


}




/// @nodoc


class _DailyPotUpdated implements PotEvent {
  const _DailyPotUpdated(this.pot);
  

 final  PotPool pot;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyPotUpdatedCopyWith<_DailyPotUpdated> get copyWith => __$DailyPotUpdatedCopyWithImpl<_DailyPotUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyPotUpdated&&(identical(other.pot, pot) || other.pot == pot));
}


@override
int get hashCode => Object.hash(runtimeType,pot);

@override
String toString() {
  return 'PotEvent.dailyPotUpdated(pot: $pot)';
}


}

/// @nodoc
abstract mixin class _$DailyPotUpdatedCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$DailyPotUpdatedCopyWith(_DailyPotUpdated value, $Res Function(_DailyPotUpdated) _then) = __$DailyPotUpdatedCopyWithImpl;
@useResult
$Res call({
 PotPool pot
});


$PotPoolCopyWith<$Res> get pot;

}
/// @nodoc
class __$DailyPotUpdatedCopyWithImpl<$Res>
    implements _$DailyPotUpdatedCopyWith<$Res> {
  __$DailyPotUpdatedCopyWithImpl(this._self, this._then);

  final _DailyPotUpdated _self;
  final $Res Function(_DailyPotUpdated) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pot = null,}) {
  return _then(_DailyPotUpdated(
null == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as PotPool,
  ));
}

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PotPoolCopyWith<$Res> get pot {
  
  return $PotPoolCopyWith<$Res>(_self.pot, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}

/// @nodoc


class _WeeklyPotUpdated implements PotEvent {
  const _WeeklyPotUpdated(this.pot);
  

 final  PotPool pot;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyPotUpdatedCopyWith<_WeeklyPotUpdated> get copyWith => __$WeeklyPotUpdatedCopyWithImpl<_WeeklyPotUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyPotUpdated&&(identical(other.pot, pot) || other.pot == pot));
}


@override
int get hashCode => Object.hash(runtimeType,pot);

@override
String toString() {
  return 'PotEvent.weeklyPotUpdated(pot: $pot)';
}


}

/// @nodoc
abstract mixin class _$WeeklyPotUpdatedCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$WeeklyPotUpdatedCopyWith(_WeeklyPotUpdated value, $Res Function(_WeeklyPotUpdated) _then) = __$WeeklyPotUpdatedCopyWithImpl;
@useResult
$Res call({
 PotPool pot
});


$PotPoolCopyWith<$Res> get pot;

}
/// @nodoc
class __$WeeklyPotUpdatedCopyWithImpl<$Res>
    implements _$WeeklyPotUpdatedCopyWith<$Res> {
  __$WeeklyPotUpdatedCopyWithImpl(this._self, this._then);

  final _WeeklyPotUpdated _self;
  final $Res Function(_WeeklyPotUpdated) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pot = null,}) {
  return _then(_WeeklyPotUpdated(
null == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as PotPool,
  ));
}

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PotPoolCopyWith<$Res> get pot {
  
  return $PotPoolCopyWith<$Res>(_self.pot, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}

/// @nodoc


class _LoadLeaderboard implements PotEvent {
  const _LoadLeaderboard({required this.type, this.limit});
  

 final  PotType type;
 final  int? limit;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadLeaderboardCopyWith<_LoadLeaderboard> get copyWith => __$LoadLeaderboardCopyWithImpl<_LoadLeaderboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLeaderboard&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,type,limit);

@override
String toString() {
  return 'PotEvent.loadLeaderboard(type: $type, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$LoadLeaderboardCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$LoadLeaderboardCopyWith(_LoadLeaderboard value, $Res Function(_LoadLeaderboard) _then) = __$LoadLeaderboardCopyWithImpl;
@useResult
$Res call({
 PotType type, int? limit
});




}
/// @nodoc
class __$LoadLeaderboardCopyWithImpl<$Res>
    implements _$LoadLeaderboardCopyWith<$Res> {
  __$LoadLeaderboardCopyWithImpl(this._self, this._then);

  final _LoadLeaderboard _self;
  final $Res Function(_LoadLeaderboard) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,Object? limit = freezed,}) {
  return _then(_LoadLeaderboard(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PotType,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _WatchLeaderboard implements PotEvent {
  const _WatchLeaderboard({required this.type, this.limit});
  

 final  PotType type;
 final  int? limit;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchLeaderboardCopyWith<_WatchLeaderboard> get copyWith => __$WatchLeaderboardCopyWithImpl<_WatchLeaderboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchLeaderboard&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,type,limit);

@override
String toString() {
  return 'PotEvent.watchLeaderboard(type: $type, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$WatchLeaderboardCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$WatchLeaderboardCopyWith(_WatchLeaderboard value, $Res Function(_WatchLeaderboard) _then) = __$WatchLeaderboardCopyWithImpl;
@useResult
$Res call({
 PotType type, int? limit
});




}
/// @nodoc
class __$WatchLeaderboardCopyWithImpl<$Res>
    implements _$WatchLeaderboardCopyWith<$Res> {
  __$WatchLeaderboardCopyWithImpl(this._self, this._then);

  final _WatchLeaderboard _self;
  final $Res Function(_WatchLeaderboard) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,Object? limit = freezed,}) {
  return _then(_WatchLeaderboard(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PotType,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _LeaderboardUpdated implements PotEvent {
  const _LeaderboardUpdated(final  List<UserScore> scores): _scores = scores;
  

 final  List<UserScore> _scores;
 List<UserScore> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}


/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderboardUpdatedCopyWith<_LeaderboardUpdated> get copyWith => __$LeaderboardUpdatedCopyWithImpl<_LeaderboardUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderboardUpdated&&const DeepCollectionEquality().equals(other._scores, _scores));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_scores));

@override
String toString() {
  return 'PotEvent.leaderboardUpdated(scores: $scores)';
}


}

/// @nodoc
abstract mixin class _$LeaderboardUpdatedCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$LeaderboardUpdatedCopyWith(_LeaderboardUpdated value, $Res Function(_LeaderboardUpdated) _then) = __$LeaderboardUpdatedCopyWithImpl;
@useResult
$Res call({
 List<UserScore> scores
});




}
/// @nodoc
class __$LeaderboardUpdatedCopyWithImpl<$Res>
    implements _$LeaderboardUpdatedCopyWith<$Res> {
  __$LeaderboardUpdatedCopyWithImpl(this._self, this._then);

  final _LeaderboardUpdated _self;
  final $Res Function(_LeaderboardUpdated) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scores = null,}) {
  return _then(_LeaderboardUpdated(
null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<UserScore>,
  ));
}


}

/// @nodoc


class _LoadPotHistory implements PotEvent {
  const _LoadPotHistory({required this.type, this.limit});
  

 final  PotType type;
 final  int? limit;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadPotHistoryCopyWith<_LoadPotHistory> get copyWith => __$LoadPotHistoryCopyWithImpl<_LoadPotHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadPotHistory&&(identical(other.type, type) || other.type == type)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,type,limit);

@override
String toString() {
  return 'PotEvent.loadPotHistory(type: $type, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$LoadPotHistoryCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$LoadPotHistoryCopyWith(_LoadPotHistory value, $Res Function(_LoadPotHistory) _then) = __$LoadPotHistoryCopyWithImpl;
@useResult
$Res call({
 PotType type, int? limit
});




}
/// @nodoc
class __$LoadPotHistoryCopyWithImpl<$Res>
    implements _$LoadPotHistoryCopyWith<$Res> {
  __$LoadPotHistoryCopyWithImpl(this._self, this._then);

  final _LoadPotHistory _self;
  final $Res Function(_LoadPotHistory) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,Object? limit = freezed,}) {
  return _then(_LoadPotHistory(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PotType,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _LoadCurrentUserScore implements PotEvent {
  const _LoadCurrentUserScore(this.type);
  

 final  PotType type;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCurrentUserScoreCopyWith<_LoadCurrentUserScore> get copyWith => __$LoadCurrentUserScoreCopyWithImpl<_LoadCurrentUserScore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadCurrentUserScore&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'PotEvent.loadCurrentUserScore(type: $type)';
}


}

/// @nodoc
abstract mixin class _$LoadCurrentUserScoreCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$LoadCurrentUserScoreCopyWith(_LoadCurrentUserScore value, $Res Function(_LoadCurrentUserScore) _then) = __$LoadCurrentUserScoreCopyWithImpl;
@useResult
$Res call({
 PotType type
});




}
/// @nodoc
class __$LoadCurrentUserScoreCopyWithImpl<$Res>
    implements _$LoadCurrentUserScoreCopyWith<$Res> {
  __$LoadCurrentUserScoreCopyWithImpl(this._self, this._then);

  final _LoadCurrentUserScore _self;
  final $Res Function(_LoadCurrentUserScore) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_LoadCurrentUserScore(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PotType,
  ));
}


}

/// @nodoc


class _CheckEligibility implements PotEvent {
  const _CheckEligibility();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckEligibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PotEvent.checkEligibility()';
}


}




/// @nodoc


class _SelectPotType implements PotEvent {
  const _SelectPotType(this.type);
  

 final  PotType type;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectPotTypeCopyWith<_SelectPotType> get copyWith => __$SelectPotTypeCopyWithImpl<_SelectPotType>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectPotType&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'PotEvent.selectPotType(type: $type)';
}


}

/// @nodoc
abstract mixin class _$SelectPotTypeCopyWith<$Res> implements $PotEventCopyWith<$Res> {
  factory _$SelectPotTypeCopyWith(_SelectPotType value, $Res Function(_SelectPotType) _then) = __$SelectPotTypeCopyWithImpl;
@useResult
$Res call({
 PotType type
});




}
/// @nodoc
class __$SelectPotTypeCopyWithImpl<$Res>
    implements _$SelectPotTypeCopyWith<$Res> {
  __$SelectPotTypeCopyWithImpl(this._self, this._then);

  final _SelectPotType _self;
  final $Res Function(_SelectPotType) _then;

/// Create a copy of PotEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_SelectPotType(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PotType,
  ));
}


}

/// @nodoc


class _ClearError implements PotEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PotEvent.clearError()';
}


}




/// @nodoc
mixin _$PotState {

 PotStatus get status; PotPool? get dailyPot; PotPool? get weeklyPot; List<UserScore> get leaderboard; List<PotPool> get potHistory; UserScore? get currentUserScore; UserScore? get dailyUserScore; UserScore? get weeklyUserScore; PotType get selectedPotType; bool get isLoadingDaily; bool get isLoadingWeekly; bool get isLoadingLeaderboard; bool get isLoadingHistory; bool get isDailyEligible; bool get isWeeklyEligible; String? get errorMessage;
/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotStateCopyWith<PotState> get copyWith => _$PotStateCopyWithImpl<PotState>(this as PotState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotState&&(identical(other.status, status) || other.status == status)&&(identical(other.dailyPot, dailyPot) || other.dailyPot == dailyPot)&&(identical(other.weeklyPot, weeklyPot) || other.weeklyPot == weeklyPot)&&const DeepCollectionEquality().equals(other.leaderboard, leaderboard)&&const DeepCollectionEquality().equals(other.potHistory, potHistory)&&(identical(other.currentUserScore, currentUserScore) || other.currentUserScore == currentUserScore)&&(identical(other.dailyUserScore, dailyUserScore) || other.dailyUserScore == dailyUserScore)&&(identical(other.weeklyUserScore, weeklyUserScore) || other.weeklyUserScore == weeklyUserScore)&&(identical(other.selectedPotType, selectedPotType) || other.selectedPotType == selectedPotType)&&(identical(other.isLoadingDaily, isLoadingDaily) || other.isLoadingDaily == isLoadingDaily)&&(identical(other.isLoadingWeekly, isLoadingWeekly) || other.isLoadingWeekly == isLoadingWeekly)&&(identical(other.isLoadingLeaderboard, isLoadingLeaderboard) || other.isLoadingLeaderboard == isLoadingLeaderboard)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.isDailyEligible, isDailyEligible) || other.isDailyEligible == isDailyEligible)&&(identical(other.isWeeklyEligible, isWeeklyEligible) || other.isWeeklyEligible == isWeeklyEligible)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,dailyPot,weeklyPot,const DeepCollectionEquality().hash(leaderboard),const DeepCollectionEquality().hash(potHistory),currentUserScore,dailyUserScore,weeklyUserScore,selectedPotType,isLoadingDaily,isLoadingWeekly,isLoadingLeaderboard,isLoadingHistory,isDailyEligible,isWeeklyEligible,errorMessage);

@override
String toString() {
  return 'PotState(status: $status, dailyPot: $dailyPot, weeklyPot: $weeklyPot, leaderboard: $leaderboard, potHistory: $potHistory, currentUserScore: $currentUserScore, dailyUserScore: $dailyUserScore, weeklyUserScore: $weeklyUserScore, selectedPotType: $selectedPotType, isLoadingDaily: $isLoadingDaily, isLoadingWeekly: $isLoadingWeekly, isLoadingLeaderboard: $isLoadingLeaderboard, isLoadingHistory: $isLoadingHistory, isDailyEligible: $isDailyEligible, isWeeklyEligible: $isWeeklyEligible, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PotStateCopyWith<$Res>  {
  factory $PotStateCopyWith(PotState value, $Res Function(PotState) _then) = _$PotStateCopyWithImpl;
@useResult
$Res call({
 PotStatus status, PotPool? dailyPot, PotPool? weeklyPot, List<UserScore> leaderboard, List<PotPool> potHistory, UserScore? currentUserScore, UserScore? dailyUserScore, UserScore? weeklyUserScore, PotType selectedPotType, bool isLoadingDaily, bool isLoadingWeekly, bool isLoadingLeaderboard, bool isLoadingHistory, bool isDailyEligible, bool isWeeklyEligible, String? errorMessage
});


$PotPoolCopyWith<$Res>? get dailyPot;$PotPoolCopyWith<$Res>? get weeklyPot;$UserScoreCopyWith<$Res>? get currentUserScore;$UserScoreCopyWith<$Res>? get dailyUserScore;$UserScoreCopyWith<$Res>? get weeklyUserScore;

}
/// @nodoc
class _$PotStateCopyWithImpl<$Res>
    implements $PotStateCopyWith<$Res> {
  _$PotStateCopyWithImpl(this._self, this._then);

  final PotState _self;
  final $Res Function(PotState) _then;

/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? dailyPot = freezed,Object? weeklyPot = freezed,Object? leaderboard = null,Object? potHistory = null,Object? currentUserScore = freezed,Object? dailyUserScore = freezed,Object? weeklyUserScore = freezed,Object? selectedPotType = null,Object? isLoadingDaily = null,Object? isLoadingWeekly = null,Object? isLoadingLeaderboard = null,Object? isLoadingHistory = null,Object? isDailyEligible = null,Object? isWeeklyEligible = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PotStatus,dailyPot: freezed == dailyPot ? _self.dailyPot : dailyPot // ignore: cast_nullable_to_non_nullable
as PotPool?,weeklyPot: freezed == weeklyPot ? _self.weeklyPot : weeklyPot // ignore: cast_nullable_to_non_nullable
as PotPool?,leaderboard: null == leaderboard ? _self.leaderboard : leaderboard // ignore: cast_nullable_to_non_nullable
as List<UserScore>,potHistory: null == potHistory ? _self.potHistory : potHistory // ignore: cast_nullable_to_non_nullable
as List<PotPool>,currentUserScore: freezed == currentUserScore ? _self.currentUserScore : currentUserScore // ignore: cast_nullable_to_non_nullable
as UserScore?,dailyUserScore: freezed == dailyUserScore ? _self.dailyUserScore : dailyUserScore // ignore: cast_nullable_to_non_nullable
as UserScore?,weeklyUserScore: freezed == weeklyUserScore ? _self.weeklyUserScore : weeklyUserScore // ignore: cast_nullable_to_non_nullable
as UserScore?,selectedPotType: null == selectedPotType ? _self.selectedPotType : selectedPotType // ignore: cast_nullable_to_non_nullable
as PotType,isLoadingDaily: null == isLoadingDaily ? _self.isLoadingDaily : isLoadingDaily // ignore: cast_nullable_to_non_nullable
as bool,isLoadingWeekly: null == isLoadingWeekly ? _self.isLoadingWeekly : isLoadingWeekly // ignore: cast_nullable_to_non_nullable
as bool,isLoadingLeaderboard: null == isLoadingLeaderboard ? _self.isLoadingLeaderboard : isLoadingLeaderboard // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,isDailyEligible: null == isDailyEligible ? _self.isDailyEligible : isDailyEligible // ignore: cast_nullable_to_non_nullable
as bool,isWeeklyEligible: null == isWeeklyEligible ? _self.isWeeklyEligible : isWeeklyEligible // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PotPoolCopyWith<$Res>? get dailyPot {
    if (_self.dailyPot == null) {
    return null;
  }

  return $PotPoolCopyWith<$Res>(_self.dailyPot!, (value) {
    return _then(_self.copyWith(dailyPot: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PotPoolCopyWith<$Res>? get weeklyPot {
    if (_self.weeklyPot == null) {
    return null;
  }

  return $PotPoolCopyWith<$Res>(_self.weeklyPot!, (value) {
    return _then(_self.copyWith(weeklyPot: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserScoreCopyWith<$Res>? get currentUserScore {
    if (_self.currentUserScore == null) {
    return null;
  }

  return $UserScoreCopyWith<$Res>(_self.currentUserScore!, (value) {
    return _then(_self.copyWith(currentUserScore: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserScoreCopyWith<$Res>? get dailyUserScore {
    if (_self.dailyUserScore == null) {
    return null;
  }

  return $UserScoreCopyWith<$Res>(_self.dailyUserScore!, (value) {
    return _then(_self.copyWith(dailyUserScore: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserScoreCopyWith<$Res>? get weeklyUserScore {
    if (_self.weeklyUserScore == null) {
    return null;
  }

  return $UserScoreCopyWith<$Res>(_self.weeklyUserScore!, (value) {
    return _then(_self.copyWith(weeklyUserScore: value));
  });
}
}


/// Adds pattern-matching-related methods to [PotState].
extension PotStatePatterns on PotState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotState value)  $default,){
final _that = this;
switch (_that) {
case _PotState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotState value)?  $default,){
final _that = this;
switch (_that) {
case _PotState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PotStatus status,  PotPool? dailyPot,  PotPool? weeklyPot,  List<UserScore> leaderboard,  List<PotPool> potHistory,  UserScore? currentUserScore,  UserScore? dailyUserScore,  UserScore? weeklyUserScore,  PotType selectedPotType,  bool isLoadingDaily,  bool isLoadingWeekly,  bool isLoadingLeaderboard,  bool isLoadingHistory,  bool isDailyEligible,  bool isWeeklyEligible,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PotState() when $default != null:
return $default(_that.status,_that.dailyPot,_that.weeklyPot,_that.leaderboard,_that.potHistory,_that.currentUserScore,_that.dailyUserScore,_that.weeklyUserScore,_that.selectedPotType,_that.isLoadingDaily,_that.isLoadingWeekly,_that.isLoadingLeaderboard,_that.isLoadingHistory,_that.isDailyEligible,_that.isWeeklyEligible,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PotStatus status,  PotPool? dailyPot,  PotPool? weeklyPot,  List<UserScore> leaderboard,  List<PotPool> potHistory,  UserScore? currentUserScore,  UserScore? dailyUserScore,  UserScore? weeklyUserScore,  PotType selectedPotType,  bool isLoadingDaily,  bool isLoadingWeekly,  bool isLoadingLeaderboard,  bool isLoadingHistory,  bool isDailyEligible,  bool isWeeklyEligible,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PotState():
return $default(_that.status,_that.dailyPot,_that.weeklyPot,_that.leaderboard,_that.potHistory,_that.currentUserScore,_that.dailyUserScore,_that.weeklyUserScore,_that.selectedPotType,_that.isLoadingDaily,_that.isLoadingWeekly,_that.isLoadingLeaderboard,_that.isLoadingHistory,_that.isDailyEligible,_that.isWeeklyEligible,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PotStatus status,  PotPool? dailyPot,  PotPool? weeklyPot,  List<UserScore> leaderboard,  List<PotPool> potHistory,  UserScore? currentUserScore,  UserScore? dailyUserScore,  UserScore? weeklyUserScore,  PotType selectedPotType,  bool isLoadingDaily,  bool isLoadingWeekly,  bool isLoadingLeaderboard,  bool isLoadingHistory,  bool isDailyEligible,  bool isWeeklyEligible,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PotState() when $default != null:
return $default(_that.status,_that.dailyPot,_that.weeklyPot,_that.leaderboard,_that.potHistory,_that.currentUserScore,_that.dailyUserScore,_that.weeklyUserScore,_that.selectedPotType,_that.isLoadingDaily,_that.isLoadingWeekly,_that.isLoadingLeaderboard,_that.isLoadingHistory,_that.isDailyEligible,_that.isWeeklyEligible,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PotState implements PotState {
  const _PotState({this.status = PotStatus.initial, this.dailyPot, this.weeklyPot, final  List<UserScore> leaderboard = const [], final  List<PotPool> potHistory = const [], this.currentUserScore, this.dailyUserScore, this.weeklyUserScore, this.selectedPotType = PotType.daily, this.isLoadingDaily = false, this.isLoadingWeekly = false, this.isLoadingLeaderboard = false, this.isLoadingHistory = false, this.isDailyEligible = false, this.isWeeklyEligible = false, this.errorMessage}): _leaderboard = leaderboard,_potHistory = potHistory;
  

@override@JsonKey() final  PotStatus status;
@override final  PotPool? dailyPot;
@override final  PotPool? weeklyPot;
 final  List<UserScore> _leaderboard;
@override@JsonKey() List<UserScore> get leaderboard {
  if (_leaderboard is EqualUnmodifiableListView) return _leaderboard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leaderboard);
}

 final  List<PotPool> _potHistory;
@override@JsonKey() List<PotPool> get potHistory {
  if (_potHistory is EqualUnmodifiableListView) return _potHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_potHistory);
}

@override final  UserScore? currentUserScore;
@override final  UserScore? dailyUserScore;
@override final  UserScore? weeklyUserScore;
@override@JsonKey() final  PotType selectedPotType;
@override@JsonKey() final  bool isLoadingDaily;
@override@JsonKey() final  bool isLoadingWeekly;
@override@JsonKey() final  bool isLoadingLeaderboard;
@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  bool isDailyEligible;
@override@JsonKey() final  bool isWeeklyEligible;
@override final  String? errorMessage;

/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotStateCopyWith<_PotState> get copyWith => __$PotStateCopyWithImpl<_PotState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotState&&(identical(other.status, status) || other.status == status)&&(identical(other.dailyPot, dailyPot) || other.dailyPot == dailyPot)&&(identical(other.weeklyPot, weeklyPot) || other.weeklyPot == weeklyPot)&&const DeepCollectionEquality().equals(other._leaderboard, _leaderboard)&&const DeepCollectionEquality().equals(other._potHistory, _potHistory)&&(identical(other.currentUserScore, currentUserScore) || other.currentUserScore == currentUserScore)&&(identical(other.dailyUserScore, dailyUserScore) || other.dailyUserScore == dailyUserScore)&&(identical(other.weeklyUserScore, weeklyUserScore) || other.weeklyUserScore == weeklyUserScore)&&(identical(other.selectedPotType, selectedPotType) || other.selectedPotType == selectedPotType)&&(identical(other.isLoadingDaily, isLoadingDaily) || other.isLoadingDaily == isLoadingDaily)&&(identical(other.isLoadingWeekly, isLoadingWeekly) || other.isLoadingWeekly == isLoadingWeekly)&&(identical(other.isLoadingLeaderboard, isLoadingLeaderboard) || other.isLoadingLeaderboard == isLoadingLeaderboard)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.isDailyEligible, isDailyEligible) || other.isDailyEligible == isDailyEligible)&&(identical(other.isWeeklyEligible, isWeeklyEligible) || other.isWeeklyEligible == isWeeklyEligible)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,dailyPot,weeklyPot,const DeepCollectionEquality().hash(_leaderboard),const DeepCollectionEquality().hash(_potHistory),currentUserScore,dailyUserScore,weeklyUserScore,selectedPotType,isLoadingDaily,isLoadingWeekly,isLoadingLeaderboard,isLoadingHistory,isDailyEligible,isWeeklyEligible,errorMessage);

@override
String toString() {
  return 'PotState(status: $status, dailyPot: $dailyPot, weeklyPot: $weeklyPot, leaderboard: $leaderboard, potHistory: $potHistory, currentUserScore: $currentUserScore, dailyUserScore: $dailyUserScore, weeklyUserScore: $weeklyUserScore, selectedPotType: $selectedPotType, isLoadingDaily: $isLoadingDaily, isLoadingWeekly: $isLoadingWeekly, isLoadingLeaderboard: $isLoadingLeaderboard, isLoadingHistory: $isLoadingHistory, isDailyEligible: $isDailyEligible, isWeeklyEligible: $isWeeklyEligible, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PotStateCopyWith<$Res> implements $PotStateCopyWith<$Res> {
  factory _$PotStateCopyWith(_PotState value, $Res Function(_PotState) _then) = __$PotStateCopyWithImpl;
@override @useResult
$Res call({
 PotStatus status, PotPool? dailyPot, PotPool? weeklyPot, List<UserScore> leaderboard, List<PotPool> potHistory, UserScore? currentUserScore, UserScore? dailyUserScore, UserScore? weeklyUserScore, PotType selectedPotType, bool isLoadingDaily, bool isLoadingWeekly, bool isLoadingLeaderboard, bool isLoadingHistory, bool isDailyEligible, bool isWeeklyEligible, String? errorMessage
});


@override $PotPoolCopyWith<$Res>? get dailyPot;@override $PotPoolCopyWith<$Res>? get weeklyPot;@override $UserScoreCopyWith<$Res>? get currentUserScore;@override $UserScoreCopyWith<$Res>? get dailyUserScore;@override $UserScoreCopyWith<$Res>? get weeklyUserScore;

}
/// @nodoc
class __$PotStateCopyWithImpl<$Res>
    implements _$PotStateCopyWith<$Res> {
  __$PotStateCopyWithImpl(this._self, this._then);

  final _PotState _self;
  final $Res Function(_PotState) _then;

/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? dailyPot = freezed,Object? weeklyPot = freezed,Object? leaderboard = null,Object? potHistory = null,Object? currentUserScore = freezed,Object? dailyUserScore = freezed,Object? weeklyUserScore = freezed,Object? selectedPotType = null,Object? isLoadingDaily = null,Object? isLoadingWeekly = null,Object? isLoadingLeaderboard = null,Object? isLoadingHistory = null,Object? isDailyEligible = null,Object? isWeeklyEligible = null,Object? errorMessage = freezed,}) {
  return _then(_PotState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PotStatus,dailyPot: freezed == dailyPot ? _self.dailyPot : dailyPot // ignore: cast_nullable_to_non_nullable
as PotPool?,weeklyPot: freezed == weeklyPot ? _self.weeklyPot : weeklyPot // ignore: cast_nullable_to_non_nullable
as PotPool?,leaderboard: null == leaderboard ? _self._leaderboard : leaderboard // ignore: cast_nullable_to_non_nullable
as List<UserScore>,potHistory: null == potHistory ? _self._potHistory : potHistory // ignore: cast_nullable_to_non_nullable
as List<PotPool>,currentUserScore: freezed == currentUserScore ? _self.currentUserScore : currentUserScore // ignore: cast_nullable_to_non_nullable
as UserScore?,dailyUserScore: freezed == dailyUserScore ? _self.dailyUserScore : dailyUserScore // ignore: cast_nullable_to_non_nullable
as UserScore?,weeklyUserScore: freezed == weeklyUserScore ? _self.weeklyUserScore : weeklyUserScore // ignore: cast_nullable_to_non_nullable
as UserScore?,selectedPotType: null == selectedPotType ? _self.selectedPotType : selectedPotType // ignore: cast_nullable_to_non_nullable
as PotType,isLoadingDaily: null == isLoadingDaily ? _self.isLoadingDaily : isLoadingDaily // ignore: cast_nullable_to_non_nullable
as bool,isLoadingWeekly: null == isLoadingWeekly ? _self.isLoadingWeekly : isLoadingWeekly // ignore: cast_nullable_to_non_nullable
as bool,isLoadingLeaderboard: null == isLoadingLeaderboard ? _self.isLoadingLeaderboard : isLoadingLeaderboard // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,isDailyEligible: null == isDailyEligible ? _self.isDailyEligible : isDailyEligible // ignore: cast_nullable_to_non_nullable
as bool,isWeeklyEligible: null == isWeeklyEligible ? _self.isWeeklyEligible : isWeeklyEligible // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PotPoolCopyWith<$Res>? get dailyPot {
    if (_self.dailyPot == null) {
    return null;
  }

  return $PotPoolCopyWith<$Res>(_self.dailyPot!, (value) {
    return _then(_self.copyWith(dailyPot: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PotPoolCopyWith<$Res>? get weeklyPot {
    if (_self.weeklyPot == null) {
    return null;
  }

  return $PotPoolCopyWith<$Res>(_self.weeklyPot!, (value) {
    return _then(_self.copyWith(weeklyPot: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserScoreCopyWith<$Res>? get currentUserScore {
    if (_self.currentUserScore == null) {
    return null;
  }

  return $UserScoreCopyWith<$Res>(_self.currentUserScore!, (value) {
    return _then(_self.copyWith(currentUserScore: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserScoreCopyWith<$Res>? get dailyUserScore {
    if (_self.dailyUserScore == null) {
    return null;
  }

  return $UserScoreCopyWith<$Res>(_self.dailyUserScore!, (value) {
    return _then(_self.copyWith(dailyUserScore: value));
  });
}/// Create a copy of PotState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserScoreCopyWith<$Res>? get weeklyUserScore {
    if (_self.weeklyUserScore == null) {
    return null;
  }

  return $UserScoreCopyWith<$Res>(_self.weeklyUserScore!, (value) {
    return _then(_self.copyWith(weeklyUserScore: value));
  });
}
}

// dart format on
