// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserScore {

 String get userId; String get displayName; String? get username; String? get avatarUrl; String? get avatarColor; int get totalTokensEarned; int get rank; int? get previousRank; int get engagementsCompleted; int get currentStreak; int get longestStreak; DateTime get periodStart; DateTime get periodEnd; DateTime get updatedAt;// New scoring fields
/// Base score from completed engagements (before multipliers)
 int get baseScore;/// Streak multiplier (1.0 + streak * 0.05, max 2.0)
 double get streakMultiplier;/// Score from referred users' activity in this period
 int get assistScore;/// Quality score based on active referrals
 int get referralQualityScore;/// Final calculated score with all multipliers applied
 int get finalScore;/// Timestamp of first engagement completion in this period
 DateTime? get firstCompletionAt;
/// Create a copy of UserScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserScoreCopyWith<UserScore> get copyWith => _$UserScoreCopyWithImpl<UserScore>(this as UserScore, _$identity);

  /// Serializes this UserScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserScore&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.totalTokensEarned, totalTokensEarned) || other.totalTokensEarned == totalTokensEarned)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.baseScore, baseScore) || other.baseScore == baseScore)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.referralQualityScore, referralQualityScore) || other.referralQualityScore == referralQualityScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.firstCompletionAt, firstCompletionAt) || other.firstCompletionAt == firstCompletionAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,displayName,username,avatarUrl,avatarColor,totalTokensEarned,rank,previousRank,engagementsCompleted,currentStreak,longestStreak,periodStart,periodEnd,updatedAt,baseScore,streakMultiplier,assistScore,referralQualityScore,finalScore,firstCompletionAt]);

@override
String toString() {
  return 'UserScore(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, totalTokensEarned: $totalTokensEarned, rank: $rank, previousRank: $previousRank, engagementsCompleted: $engagementsCompleted, currentStreak: $currentStreak, longestStreak: $longestStreak, periodStart: $periodStart, periodEnd: $periodEnd, updatedAt: $updatedAt, baseScore: $baseScore, streakMultiplier: $streakMultiplier, assistScore: $assistScore, referralQualityScore: $referralQualityScore, finalScore: $finalScore, firstCompletionAt: $firstCompletionAt)';
}


}

/// @nodoc
abstract mixin class $UserScoreCopyWith<$Res>  {
  factory $UserScoreCopyWith(UserScore value, $Res Function(UserScore) _then) = _$UserScoreCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? username, String? avatarUrl, String? avatarColor, int totalTokensEarned, int rank, int? previousRank, int engagementsCompleted, int currentStreak, int longestStreak, DateTime periodStart, DateTime periodEnd, DateTime updatedAt, int baseScore, double streakMultiplier, int assistScore, int referralQualityScore, int finalScore, DateTime? firstCompletionAt
});




}
/// @nodoc
class _$UserScoreCopyWithImpl<$Res>
    implements $UserScoreCopyWith<$Res> {
  _$UserScoreCopyWithImpl(this._self, this._then);

  final UserScore _self;
  final $Res Function(UserScore) _then;

/// Create a copy of UserScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? totalTokensEarned = null,Object? rank = null,Object? previousRank = freezed,Object? engagementsCompleted = null,Object? currentStreak = null,Object? longestStreak = null,Object? periodStart = null,Object? periodEnd = null,Object? updatedAt = null,Object? baseScore = null,Object? streakMultiplier = null,Object? assistScore = null,Object? referralQualityScore = null,Object? finalScore = null,Object? firstCompletionAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,totalTokensEarned: null == totalTokensEarned ? _self.totalTokensEarned : totalTokensEarned // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,previousRank: freezed == previousRank ? _self.previousRank : previousRank // ignore: cast_nullable_to_non_nullable
as int?,engagementsCompleted: null == engagementsCompleted ? _self.engagementsCompleted : engagementsCompleted // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,baseScore: null == baseScore ? _self.baseScore : baseScore // ignore: cast_nullable_to_non_nullable
as int,streakMultiplier: null == streakMultiplier ? _self.streakMultiplier : streakMultiplier // ignore: cast_nullable_to_non_nullable
as double,assistScore: null == assistScore ? _self.assistScore : assistScore // ignore: cast_nullable_to_non_nullable
as int,referralQualityScore: null == referralQualityScore ? _self.referralQualityScore : referralQualityScore // ignore: cast_nullable_to_non_nullable
as int,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int,firstCompletionAt: freezed == firstCompletionAt ? _self.firstCompletionAt : firstCompletionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserScore].
extension UserScorePatterns on UserScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserScore value)  $default,){
final _that = this;
switch (_that) {
case _UserScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserScore value)?  $default,){
final _that = this;
switch (_that) {
case _UserScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  int totalTokensEarned,  int rank,  int? previousRank,  int engagementsCompleted,  int currentStreak,  int longestStreak,  DateTime periodStart,  DateTime periodEnd,  DateTime updatedAt,  int baseScore,  double streakMultiplier,  int assistScore,  int referralQualityScore,  int finalScore,  DateTime? firstCompletionAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserScore() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.totalTokensEarned,_that.rank,_that.previousRank,_that.engagementsCompleted,_that.currentStreak,_that.longestStreak,_that.periodStart,_that.periodEnd,_that.updatedAt,_that.baseScore,_that.streakMultiplier,_that.assistScore,_that.referralQualityScore,_that.finalScore,_that.firstCompletionAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  int totalTokensEarned,  int rank,  int? previousRank,  int engagementsCompleted,  int currentStreak,  int longestStreak,  DateTime periodStart,  DateTime periodEnd,  DateTime updatedAt,  int baseScore,  double streakMultiplier,  int assistScore,  int referralQualityScore,  int finalScore,  DateTime? firstCompletionAt)  $default,) {final _that = this;
switch (_that) {
case _UserScore():
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.totalTokensEarned,_that.rank,_that.previousRank,_that.engagementsCompleted,_that.currentStreak,_that.longestStreak,_that.periodStart,_that.periodEnd,_that.updatedAt,_that.baseScore,_that.streakMultiplier,_that.assistScore,_that.referralQualityScore,_that.finalScore,_that.firstCompletionAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? username,  String? avatarUrl,  String? avatarColor,  int totalTokensEarned,  int rank,  int? previousRank,  int engagementsCompleted,  int currentStreak,  int longestStreak,  DateTime periodStart,  DateTime periodEnd,  DateTime updatedAt,  int baseScore,  double streakMultiplier,  int assistScore,  int referralQualityScore,  int finalScore,  DateTime? firstCompletionAt)?  $default,) {final _that = this;
switch (_that) {
case _UserScore() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.totalTokensEarned,_that.rank,_that.previousRank,_that.engagementsCompleted,_that.currentStreak,_that.longestStreak,_that.periodStart,_that.periodEnd,_that.updatedAt,_that.baseScore,_that.streakMultiplier,_that.assistScore,_that.referralQualityScore,_that.finalScore,_that.firstCompletionAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserScore extends UserScore {
  const _UserScore({required this.userId, required this.displayName, this.username, this.avatarUrl, this.avatarColor, required this.totalTokensEarned, required this.rank, this.previousRank, required this.engagementsCompleted, required this.currentStreak, required this.longestStreak, required this.periodStart, required this.periodEnd, required this.updatedAt, this.baseScore = 0, this.streakMultiplier = 1.0, this.assistScore = 0, this.referralQualityScore = 0, this.finalScore = 0, this.firstCompletionAt}): super._();
  factory _UserScore.fromJson(Map<String, dynamic> json) => _$UserScoreFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? username;
@override final  String? avatarUrl;
@override final  String? avatarColor;
@override final  int totalTokensEarned;
@override final  int rank;
@override final  int? previousRank;
@override final  int engagementsCompleted;
@override final  int currentStreak;
@override final  int longestStreak;
@override final  DateTime periodStart;
@override final  DateTime periodEnd;
@override final  DateTime updatedAt;
// New scoring fields
/// Base score from completed engagements (before multipliers)
@override@JsonKey() final  int baseScore;
/// Streak multiplier (1.0 + streak * 0.05, max 2.0)
@override@JsonKey() final  double streakMultiplier;
/// Score from referred users' activity in this period
@override@JsonKey() final  int assistScore;
/// Quality score based on active referrals
@override@JsonKey() final  int referralQualityScore;
/// Final calculated score with all multipliers applied
@override@JsonKey() final  int finalScore;
/// Timestamp of first engagement completion in this period
@override final  DateTime? firstCompletionAt;

/// Create a copy of UserScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserScoreCopyWith<_UserScore> get copyWith => __$UserScoreCopyWithImpl<_UserScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserScore&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.totalTokensEarned, totalTokensEarned) || other.totalTokensEarned == totalTokensEarned)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.baseScore, baseScore) || other.baseScore == baseScore)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.referralQualityScore, referralQualityScore) || other.referralQualityScore == referralQualityScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.firstCompletionAt, firstCompletionAt) || other.firstCompletionAt == firstCompletionAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,displayName,username,avatarUrl,avatarColor,totalTokensEarned,rank,previousRank,engagementsCompleted,currentStreak,longestStreak,periodStart,periodEnd,updatedAt,baseScore,streakMultiplier,assistScore,referralQualityScore,finalScore,firstCompletionAt]);

@override
String toString() {
  return 'UserScore(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, totalTokensEarned: $totalTokensEarned, rank: $rank, previousRank: $previousRank, engagementsCompleted: $engagementsCompleted, currentStreak: $currentStreak, longestStreak: $longestStreak, periodStart: $periodStart, periodEnd: $periodEnd, updatedAt: $updatedAt, baseScore: $baseScore, streakMultiplier: $streakMultiplier, assistScore: $assistScore, referralQualityScore: $referralQualityScore, finalScore: $finalScore, firstCompletionAt: $firstCompletionAt)';
}


}

/// @nodoc
abstract mixin class _$UserScoreCopyWith<$Res> implements $UserScoreCopyWith<$Res> {
  factory _$UserScoreCopyWith(_UserScore value, $Res Function(_UserScore) _then) = __$UserScoreCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? username, String? avatarUrl, String? avatarColor, int totalTokensEarned, int rank, int? previousRank, int engagementsCompleted, int currentStreak, int longestStreak, DateTime periodStart, DateTime periodEnd, DateTime updatedAt, int baseScore, double streakMultiplier, int assistScore, int referralQualityScore, int finalScore, DateTime? firstCompletionAt
});




}
/// @nodoc
class __$UserScoreCopyWithImpl<$Res>
    implements _$UserScoreCopyWith<$Res> {
  __$UserScoreCopyWithImpl(this._self, this._then);

  final _UserScore _self;
  final $Res Function(_UserScore) _then;

/// Create a copy of UserScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? totalTokensEarned = null,Object? rank = null,Object? previousRank = freezed,Object? engagementsCompleted = null,Object? currentStreak = null,Object? longestStreak = null,Object? periodStart = null,Object? periodEnd = null,Object? updatedAt = null,Object? baseScore = null,Object? streakMultiplier = null,Object? assistScore = null,Object? referralQualityScore = null,Object? finalScore = null,Object? firstCompletionAt = freezed,}) {
  return _then(_UserScore(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,avatarColor: freezed == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String?,totalTokensEarned: null == totalTokensEarned ? _self.totalTokensEarned : totalTokensEarned // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,previousRank: freezed == previousRank ? _self.previousRank : previousRank // ignore: cast_nullable_to_non_nullable
as int?,engagementsCompleted: null == engagementsCompleted ? _self.engagementsCompleted : engagementsCompleted // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,baseScore: null == baseScore ? _self.baseScore : baseScore // ignore: cast_nullable_to_non_nullable
as int,streakMultiplier: null == streakMultiplier ? _self.streakMultiplier : streakMultiplier // ignore: cast_nullable_to_non_nullable
as double,assistScore: null == assistScore ? _self.assistScore : assistScore // ignore: cast_nullable_to_non_nullable
as int,referralQualityScore: null == referralQualityScore ? _self.referralQualityScore : referralQualityScore // ignore: cast_nullable_to_non_nullable
as int,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int,firstCompletionAt: freezed == firstCompletionAt ? _self.firstCompletionAt : firstCompletionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
