// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserScoreModel {

 String get userId; String get displayName; String? get username; String? get avatarUrl; String? get avatarColor; int get totalTokensEarned; int get rank; int? get previousRank; int get engagementsCompleted; int get currentStreak; int get longestStreak; DateTime get periodStart; DateTime get periodEnd; DateTime get updatedAt;// New scoring fields
 int get baseScore; double get streakMultiplier; int get assistScore; int get referralQualityScore; int get finalScore; DateTime? get firstCompletionAt;
/// Create a copy of UserScoreModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserScoreModelCopyWith<UserScoreModel> get copyWith => _$UserScoreModelCopyWithImpl<UserScoreModel>(this as UserScoreModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserScoreModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.totalTokensEarned, totalTokensEarned) || other.totalTokensEarned == totalTokensEarned)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.baseScore, baseScore) || other.baseScore == baseScore)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.referralQualityScore, referralQualityScore) || other.referralQualityScore == referralQualityScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.firstCompletionAt, firstCompletionAt) || other.firstCompletionAt == firstCompletionAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,userId,displayName,username,avatarUrl,avatarColor,totalTokensEarned,rank,previousRank,engagementsCompleted,currentStreak,longestStreak,periodStart,periodEnd,updatedAt,baseScore,streakMultiplier,assistScore,referralQualityScore,finalScore,firstCompletionAt]);

@override
String toString() {
  return 'UserScoreModel(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, totalTokensEarned: $totalTokensEarned, rank: $rank, previousRank: $previousRank, engagementsCompleted: $engagementsCompleted, currentStreak: $currentStreak, longestStreak: $longestStreak, periodStart: $periodStart, periodEnd: $periodEnd, updatedAt: $updatedAt, baseScore: $baseScore, streakMultiplier: $streakMultiplier, assistScore: $assistScore, referralQualityScore: $referralQualityScore, finalScore: $finalScore, firstCompletionAt: $firstCompletionAt)';
}


}

/// @nodoc
abstract mixin class $UserScoreModelCopyWith<$Res>  {
  factory $UserScoreModelCopyWith(UserScoreModel value, $Res Function(UserScoreModel) _then) = _$UserScoreModelCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? username, String? avatarUrl, String? avatarColor, int totalTokensEarned, int rank, int? previousRank, int engagementsCompleted, int currentStreak, int longestStreak, DateTime periodStart, DateTime periodEnd, DateTime updatedAt, int baseScore, double streakMultiplier, int assistScore, int referralQualityScore, int finalScore, DateTime? firstCompletionAt
});




}
/// @nodoc
class _$UserScoreModelCopyWithImpl<$Res>
    implements $UserScoreModelCopyWith<$Res> {
  _$UserScoreModelCopyWithImpl(this._self, this._then);

  final UserScoreModel _self;
  final $Res Function(UserScoreModel) _then;

/// Create a copy of UserScoreModel
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


/// Adds pattern-matching-related methods to [UserScoreModel].
extension UserScoreModelPatterns on UserScoreModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserScoreModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserScoreModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserScoreModel value)  $default,){
final _that = this;
switch (_that) {
case _UserScoreModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserScoreModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserScoreModel() when $default != null:
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
case _UserScoreModel() when $default != null:
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
case _UserScoreModel():
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
case _UserScoreModel() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.avatarColor,_that.totalTokensEarned,_that.rank,_that.previousRank,_that.engagementsCompleted,_that.currentStreak,_that.longestStreak,_that.periodStart,_that.periodEnd,_that.updatedAt,_that.baseScore,_that.streakMultiplier,_that.assistScore,_that.referralQualityScore,_that.finalScore,_that.firstCompletionAt);case _:
  return null;

}
}

}

/// @nodoc


class _UserScoreModel extends UserScoreModel {
  const _UserScoreModel({required this.userId, required this.displayName, this.username, this.avatarUrl, this.avatarColor, required this.totalTokensEarned, required this.rank, this.previousRank, required this.engagementsCompleted, required this.currentStreak, required this.longestStreak, required this.periodStart, required this.periodEnd, required this.updatedAt, this.baseScore = 0, this.streakMultiplier = 1.0, this.assistScore = 0, this.referralQualityScore = 0, this.finalScore = 0, this.firstCompletionAt}): super._();
  

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
@override@JsonKey() final  int baseScore;
@override@JsonKey() final  double streakMultiplier;
@override@JsonKey() final  int assistScore;
@override@JsonKey() final  int referralQualityScore;
@override@JsonKey() final  int finalScore;
@override final  DateTime? firstCompletionAt;

/// Create a copy of UserScoreModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserScoreModelCopyWith<_UserScoreModel> get copyWith => __$UserScoreModelCopyWithImpl<_UserScoreModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserScoreModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.totalTokensEarned, totalTokensEarned) || other.totalTokensEarned == totalTokensEarned)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.previousRank, previousRank) || other.previousRank == previousRank)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.baseScore, baseScore) || other.baseScore == baseScore)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.referralQualityScore, referralQualityScore) || other.referralQualityScore == referralQualityScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.firstCompletionAt, firstCompletionAt) || other.firstCompletionAt == firstCompletionAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,userId,displayName,username,avatarUrl,avatarColor,totalTokensEarned,rank,previousRank,engagementsCompleted,currentStreak,longestStreak,periodStart,periodEnd,updatedAt,baseScore,streakMultiplier,assistScore,referralQualityScore,finalScore,firstCompletionAt]);

@override
String toString() {
  return 'UserScoreModel(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, totalTokensEarned: $totalTokensEarned, rank: $rank, previousRank: $previousRank, engagementsCompleted: $engagementsCompleted, currentStreak: $currentStreak, longestStreak: $longestStreak, periodStart: $periodStart, periodEnd: $periodEnd, updatedAt: $updatedAt, baseScore: $baseScore, streakMultiplier: $streakMultiplier, assistScore: $assistScore, referralQualityScore: $referralQualityScore, finalScore: $finalScore, firstCompletionAt: $firstCompletionAt)';
}


}

/// @nodoc
abstract mixin class _$UserScoreModelCopyWith<$Res> implements $UserScoreModelCopyWith<$Res> {
  factory _$UserScoreModelCopyWith(_UserScoreModel value, $Res Function(_UserScoreModel) _then) = __$UserScoreModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? username, String? avatarUrl, String? avatarColor, int totalTokensEarned, int rank, int? previousRank, int engagementsCompleted, int currentStreak, int longestStreak, DateTime periodStart, DateTime periodEnd, DateTime updatedAt, int baseScore, double streakMultiplier, int assistScore, int referralQualityScore, int finalScore, DateTime? firstCompletionAt
});




}
/// @nodoc
class __$UserScoreModelCopyWithImpl<$Res>
    implements _$UserScoreModelCopyWith<$Res> {
  __$UserScoreModelCopyWithImpl(this._self, this._then);

  final _UserScoreModel _self;
  final $Res Function(_UserScoreModel) _then;

/// Create a copy of UserScoreModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? avatarColor = freezed,Object? totalTokensEarned = null,Object? rank = null,Object? previousRank = freezed,Object? engagementsCompleted = null,Object? currentStreak = null,Object? longestStreak = null,Object? periodStart = null,Object? periodEnd = null,Object? updatedAt = null,Object? baseScore = null,Object? streakMultiplier = null,Object? assistScore = null,Object? referralQualityScore = null,Object? finalScore = null,Object? firstCompletionAt = freezed,}) {
  return _then(_UserScoreModel(
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
