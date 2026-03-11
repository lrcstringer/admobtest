// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyScore {

/// Date in YYYY-MM-DD format (SAST timezone)
 String get date;/// Number of engagements completed this day
 int get engagementsCompleted;/// Total tokens earned this day
 int get tokensEarned;/// What day of streak this was (1, 2, 3, etc.)
 int get streakDay;/// Streak multiplier applied (1.0, 1.2, 1.35, or 1.5)
 double get streakMultiplier;/// Assist score from referrals (10% of referee earnings)
 int get assistScore;/// Final calculated score for ranking
 int get finalScore;/// Cached display name for leaderboard
 String get displayName;/// Cached username for leaderboard
 String? get username;/// Cached avatar URL for leaderboard
 String? get avatarUrl; DateTime get updatedAt;
/// Create a copy of DailyScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyScoreCopyWith<DailyScore> get copyWith => _$DailyScoreCopyWithImpl<DailyScore>(this as DailyScore, _$identity);

  /// Serializes this DailyScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyScore&&(identical(other.date, date) || other.date == date)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.streakDay, streakDay) || other.streakDay == streakDay)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,engagementsCompleted,tokensEarned,streakDay,streakMultiplier,assistScore,finalScore,displayName,username,avatarUrl,updatedAt);

@override
String toString() {
  return 'DailyScore(date: $date, engagementsCompleted: $engagementsCompleted, tokensEarned: $tokensEarned, streakDay: $streakDay, streakMultiplier: $streakMultiplier, assistScore: $assistScore, finalScore: $finalScore, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DailyScoreCopyWith<$Res>  {
  factory $DailyScoreCopyWith(DailyScore value, $Res Function(DailyScore) _then) = _$DailyScoreCopyWithImpl;
@useResult
$Res call({
 String date, int engagementsCompleted, int tokensEarned, int streakDay, double streakMultiplier, int assistScore, int finalScore, String displayName, String? username, String? avatarUrl, DateTime updatedAt
});




}
/// @nodoc
class _$DailyScoreCopyWithImpl<$Res>
    implements $DailyScoreCopyWith<$Res> {
  _$DailyScoreCopyWithImpl(this._self, this._then);

  final DailyScore _self;
  final $Res Function(DailyScore) _then;

/// Create a copy of DailyScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? engagementsCompleted = null,Object? tokensEarned = null,Object? streakDay = null,Object? streakMultiplier = null,Object? assistScore = null,Object? finalScore = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,engagementsCompleted: null == engagementsCompleted ? _self.engagementsCompleted : engagementsCompleted // ignore: cast_nullable_to_non_nullable
as int,tokensEarned: null == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as int,streakDay: null == streakDay ? _self.streakDay : streakDay // ignore: cast_nullable_to_non_nullable
as int,streakMultiplier: null == streakMultiplier ? _self.streakMultiplier : streakMultiplier // ignore: cast_nullable_to_non_nullable
as double,assistScore: null == assistScore ? _self.assistScore : assistScore // ignore: cast_nullable_to_non_nullable
as int,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyScore].
extension DailyScorePatterns on DailyScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyScore value)  $default,){
final _that = this;
switch (_that) {
case _DailyScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyScore value)?  $default,){
final _that = this;
switch (_that) {
case _DailyScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int engagementsCompleted,  int tokensEarned,  int streakDay,  double streakMultiplier,  int assistScore,  int finalScore,  String displayName,  String? username,  String? avatarUrl,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyScore() when $default != null:
return $default(_that.date,_that.engagementsCompleted,_that.tokensEarned,_that.streakDay,_that.streakMultiplier,_that.assistScore,_that.finalScore,_that.displayName,_that.username,_that.avatarUrl,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int engagementsCompleted,  int tokensEarned,  int streakDay,  double streakMultiplier,  int assistScore,  int finalScore,  String displayName,  String? username,  String? avatarUrl,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DailyScore():
return $default(_that.date,_that.engagementsCompleted,_that.tokensEarned,_that.streakDay,_that.streakMultiplier,_that.assistScore,_that.finalScore,_that.displayName,_that.username,_that.avatarUrl,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int engagementsCompleted,  int tokensEarned,  int streakDay,  double streakMultiplier,  int assistScore,  int finalScore,  String displayName,  String? username,  String? avatarUrl,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DailyScore() when $default != null:
return $default(_that.date,_that.engagementsCompleted,_that.tokensEarned,_that.streakDay,_that.streakMultiplier,_that.assistScore,_that.finalScore,_that.displayName,_that.username,_that.avatarUrl,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyScore extends DailyScore {
  const _DailyScore({required this.date, required this.engagementsCompleted, required this.tokensEarned, required this.streakDay, required this.streakMultiplier, required this.assistScore, required this.finalScore, required this.displayName, this.username, this.avatarUrl, required this.updatedAt}): super._();
  factory _DailyScore.fromJson(Map<String, dynamic> json) => _$DailyScoreFromJson(json);

/// Date in YYYY-MM-DD format (SAST timezone)
@override final  String date;
/// Number of engagements completed this day
@override final  int engagementsCompleted;
/// Total tokens earned this day
@override final  int tokensEarned;
/// What day of streak this was (1, 2, 3, etc.)
@override final  int streakDay;
/// Streak multiplier applied (1.0, 1.2, 1.35, or 1.5)
@override final  double streakMultiplier;
/// Assist score from referrals (10% of referee earnings)
@override final  int assistScore;
/// Final calculated score for ranking
@override final  int finalScore;
/// Cached display name for leaderboard
@override final  String displayName;
/// Cached username for leaderboard
@override final  String? username;
/// Cached avatar URL for leaderboard
@override final  String? avatarUrl;
@override final  DateTime updatedAt;

/// Create a copy of DailyScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyScoreCopyWith<_DailyScore> get copyWith => __$DailyScoreCopyWithImpl<_DailyScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyScore&&(identical(other.date, date) || other.date == date)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.streakDay, streakDay) || other.streakDay == streakDay)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,engagementsCompleted,tokensEarned,streakDay,streakMultiplier,assistScore,finalScore,displayName,username,avatarUrl,updatedAt);

@override
String toString() {
  return 'DailyScore(date: $date, engagementsCompleted: $engagementsCompleted, tokensEarned: $tokensEarned, streakDay: $streakDay, streakMultiplier: $streakMultiplier, assistScore: $assistScore, finalScore: $finalScore, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DailyScoreCopyWith<$Res> implements $DailyScoreCopyWith<$Res> {
  factory _$DailyScoreCopyWith(_DailyScore value, $Res Function(_DailyScore) _then) = __$DailyScoreCopyWithImpl;
@override @useResult
$Res call({
 String date, int engagementsCompleted, int tokensEarned, int streakDay, double streakMultiplier, int assistScore, int finalScore, String displayName, String? username, String? avatarUrl, DateTime updatedAt
});




}
/// @nodoc
class __$DailyScoreCopyWithImpl<$Res>
    implements _$DailyScoreCopyWith<$Res> {
  __$DailyScoreCopyWithImpl(this._self, this._then);

  final _DailyScore _self;
  final $Res Function(_DailyScore) _then;

/// Create a copy of DailyScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? engagementsCompleted = null,Object? tokensEarned = null,Object? streakDay = null,Object? streakMultiplier = null,Object? assistScore = null,Object? finalScore = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? updatedAt = null,}) {
  return _then(_DailyScore(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,engagementsCompleted: null == engagementsCompleted ? _self.engagementsCompleted : engagementsCompleted // ignore: cast_nullable_to_non_nullable
as int,tokensEarned: null == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as int,streakDay: null == streakDay ? _self.streakDay : streakDay // ignore: cast_nullable_to_non_nullable
as int,streakMultiplier: null == streakMultiplier ? _self.streakMultiplier : streakMultiplier // ignore: cast_nullable_to_non_nullable
as double,assistScore: null == assistScore ? _self.assistScore : assistScore // ignore: cast_nullable_to_non_nullable
as int,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
