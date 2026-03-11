// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyScoreModel {

 String get date; int get engagementsCompleted; int get tokensEarned; int get streakDay; double get streakMultiplier; int get assistScore; int get finalScore; String get displayName; String? get username; String? get avatarUrl;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of DailyScoreModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyScoreModelCopyWith<DailyScoreModel> get copyWith => _$DailyScoreModelCopyWithImpl<DailyScoreModel>(this as DailyScoreModel, _$identity);

  /// Serializes this DailyScoreModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyScoreModel&&(identical(other.date, date) || other.date == date)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.streakDay, streakDay) || other.streakDay == streakDay)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,engagementsCompleted,tokensEarned,streakDay,streakMultiplier,assistScore,finalScore,displayName,username,avatarUrl,updatedAt);

@override
String toString() {
  return 'DailyScoreModel(date: $date, engagementsCompleted: $engagementsCompleted, tokensEarned: $tokensEarned, streakDay: $streakDay, streakMultiplier: $streakMultiplier, assistScore: $assistScore, finalScore: $finalScore, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DailyScoreModelCopyWith<$Res>  {
  factory $DailyScoreModelCopyWith(DailyScoreModel value, $Res Function(DailyScoreModel) _then) = _$DailyScoreModelCopyWithImpl;
@useResult
$Res call({
 String date, int engagementsCompleted, int tokensEarned, int streakDay, double streakMultiplier, int assistScore, int finalScore, String displayName, String? username, String? avatarUrl,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$DailyScoreModelCopyWithImpl<$Res>
    implements $DailyScoreModelCopyWith<$Res> {
  _$DailyScoreModelCopyWithImpl(this._self, this._then);

  final DailyScoreModel _self;
  final $Res Function(DailyScoreModel) _then;

/// Create a copy of DailyScoreModel
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


/// Adds pattern-matching-related methods to [DailyScoreModel].
extension DailyScoreModelPatterns on DailyScoreModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyScoreModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyScoreModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyScoreModel value)  $default,){
final _that = this;
switch (_that) {
case _DailyScoreModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyScoreModel value)?  $default,){
final _that = this;
switch (_that) {
case _DailyScoreModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int engagementsCompleted,  int tokensEarned,  int streakDay,  double streakMultiplier,  int assistScore,  int finalScore,  String displayName,  String? username,  String? avatarUrl, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyScoreModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int engagementsCompleted,  int tokensEarned,  int streakDay,  double streakMultiplier,  int assistScore,  int finalScore,  String displayName,  String? username,  String? avatarUrl, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DailyScoreModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int engagementsCompleted,  int tokensEarned,  int streakDay,  double streakMultiplier,  int assistScore,  int finalScore,  String displayName,  String? username,  String? avatarUrl, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DailyScoreModel() when $default != null:
return $default(_that.date,_that.engagementsCompleted,_that.tokensEarned,_that.streakDay,_that.streakMultiplier,_that.assistScore,_that.finalScore,_that.displayName,_that.username,_that.avatarUrl,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyScoreModel extends DailyScoreModel {
  const _DailyScoreModel({required this.date, required this.engagementsCompleted, required this.tokensEarned, required this.streakDay, required this.streakMultiplier, required this.assistScore, required this.finalScore, required this.displayName, this.username, this.avatarUrl, @TimestampConverter() required this.updatedAt}): super._();
  factory _DailyScoreModel.fromJson(Map<String, dynamic> json) => _$DailyScoreModelFromJson(json);

@override final  String date;
@override final  int engagementsCompleted;
@override final  int tokensEarned;
@override final  int streakDay;
@override final  double streakMultiplier;
@override final  int assistScore;
@override final  int finalScore;
@override final  String displayName;
@override final  String? username;
@override final  String? avatarUrl;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of DailyScoreModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyScoreModelCopyWith<_DailyScoreModel> get copyWith => __$DailyScoreModelCopyWithImpl<_DailyScoreModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyScoreModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyScoreModel&&(identical(other.date, date) || other.date == date)&&(identical(other.engagementsCompleted, engagementsCompleted) || other.engagementsCompleted == engagementsCompleted)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned)&&(identical(other.streakDay, streakDay) || other.streakDay == streakDay)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.assistScore, assistScore) || other.assistScore == assistScore)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,engagementsCompleted,tokensEarned,streakDay,streakMultiplier,assistScore,finalScore,displayName,username,avatarUrl,updatedAt);

@override
String toString() {
  return 'DailyScoreModel(date: $date, engagementsCompleted: $engagementsCompleted, tokensEarned: $tokensEarned, streakDay: $streakDay, streakMultiplier: $streakMultiplier, assistScore: $assistScore, finalScore: $finalScore, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DailyScoreModelCopyWith<$Res> implements $DailyScoreModelCopyWith<$Res> {
  factory _$DailyScoreModelCopyWith(_DailyScoreModel value, $Res Function(_DailyScoreModel) _then) = __$DailyScoreModelCopyWithImpl;
@override @useResult
$Res call({
 String date, int engagementsCompleted, int tokensEarned, int streakDay, double streakMultiplier, int assistScore, int finalScore, String displayName, String? username, String? avatarUrl,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$DailyScoreModelCopyWithImpl<$Res>
    implements _$DailyScoreModelCopyWith<$Res> {
  __$DailyScoreModelCopyWithImpl(this._self, this._then);

  final _DailyScoreModel _self;
  final $Res Function(_DailyScoreModel) _then;

/// Create a copy of DailyScoreModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? engagementsCompleted = null,Object? tokensEarned = null,Object? streakDay = null,Object? streakMultiplier = null,Object? assistScore = null,Object? finalScore = null,Object? displayName = null,Object? username = freezed,Object? avatarUrl = freezed,Object? updatedAt = null,}) {
  return _then(_DailyScoreModel(
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
