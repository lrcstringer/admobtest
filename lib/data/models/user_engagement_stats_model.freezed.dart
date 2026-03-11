// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_engagement_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserEngagementStatsModel {

 String get userId; int get currentStreak; int get longestStreak;@NullableTimestampConverter() DateTime? get streakStartedAt; String? get lastEarnedDate; int get totalEngagementsCompleted; int get totalTokensEarned;@TimestampConverter() DateTime get updatedAt;
/// Create a copy of UserEngagementStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEngagementStatsModelCopyWith<UserEngagementStatsModel> get copyWith => _$UserEngagementStatsModelCopyWithImpl<UserEngagementStatsModel>(this as UserEngagementStatsModel, _$identity);

  /// Serializes this UserEngagementStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEngagementStatsModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.streakStartedAt, streakStartedAt) || other.streakStartedAt == streakStartedAt)&&(identical(other.lastEarnedDate, lastEarnedDate) || other.lastEarnedDate == lastEarnedDate)&&(identical(other.totalEngagementsCompleted, totalEngagementsCompleted) || other.totalEngagementsCompleted == totalEngagementsCompleted)&&(identical(other.totalTokensEarned, totalTokensEarned) || other.totalTokensEarned == totalTokensEarned)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,currentStreak,longestStreak,streakStartedAt,lastEarnedDate,totalEngagementsCompleted,totalTokensEarned,updatedAt);

@override
String toString() {
  return 'UserEngagementStatsModel(userId: $userId, currentStreak: $currentStreak, longestStreak: $longestStreak, streakStartedAt: $streakStartedAt, lastEarnedDate: $lastEarnedDate, totalEngagementsCompleted: $totalEngagementsCompleted, totalTokensEarned: $totalTokensEarned, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserEngagementStatsModelCopyWith<$Res>  {
  factory $UserEngagementStatsModelCopyWith(UserEngagementStatsModel value, $Res Function(UserEngagementStatsModel) _then) = _$UserEngagementStatsModelCopyWithImpl;
@useResult
$Res call({
 String userId, int currentStreak, int longestStreak,@NullableTimestampConverter() DateTime? streakStartedAt, String? lastEarnedDate, int totalEngagementsCompleted, int totalTokensEarned,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class _$UserEngagementStatsModelCopyWithImpl<$Res>
    implements $UserEngagementStatsModelCopyWith<$Res> {
  _$UserEngagementStatsModelCopyWithImpl(this._self, this._then);

  final UserEngagementStatsModel _self;
  final $Res Function(UserEngagementStatsModel) _then;

/// Create a copy of UserEngagementStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? currentStreak = null,Object? longestStreak = null,Object? streakStartedAt = freezed,Object? lastEarnedDate = freezed,Object? totalEngagementsCompleted = null,Object? totalTokensEarned = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,streakStartedAt: freezed == streakStartedAt ? _self.streakStartedAt : streakStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastEarnedDate: freezed == lastEarnedDate ? _self.lastEarnedDate : lastEarnedDate // ignore: cast_nullable_to_non_nullable
as String?,totalEngagementsCompleted: null == totalEngagementsCompleted ? _self.totalEngagementsCompleted : totalEngagementsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalTokensEarned: null == totalTokensEarned ? _self.totalTokensEarned : totalTokensEarned // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEngagementStatsModel].
extension UserEngagementStatsModelPatterns on UserEngagementStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEngagementStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEngagementStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEngagementStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _UserEngagementStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEngagementStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserEngagementStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int currentStreak,  int longestStreak, @NullableTimestampConverter()  DateTime? streakStartedAt,  String? lastEarnedDate,  int totalEngagementsCompleted,  int totalTokensEarned, @TimestampConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEngagementStatsModel() when $default != null:
return $default(_that.userId,_that.currentStreak,_that.longestStreak,_that.streakStartedAt,_that.lastEarnedDate,_that.totalEngagementsCompleted,_that.totalTokensEarned,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int currentStreak,  int longestStreak, @NullableTimestampConverter()  DateTime? streakStartedAt,  String? lastEarnedDate,  int totalEngagementsCompleted,  int totalTokensEarned, @TimestampConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserEngagementStatsModel():
return $default(_that.userId,_that.currentStreak,_that.longestStreak,_that.streakStartedAt,_that.lastEarnedDate,_that.totalEngagementsCompleted,_that.totalTokensEarned,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int currentStreak,  int longestStreak, @NullableTimestampConverter()  DateTime? streakStartedAt,  String? lastEarnedDate,  int totalEngagementsCompleted,  int totalTokensEarned, @TimestampConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserEngagementStatsModel() when $default != null:
return $default(_that.userId,_that.currentStreak,_that.longestStreak,_that.streakStartedAt,_that.lastEarnedDate,_that.totalEngagementsCompleted,_that.totalTokensEarned,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserEngagementStatsModel extends UserEngagementStatsModel {
  const _UserEngagementStatsModel({required this.userId, required this.currentStreak, required this.longestStreak, @NullableTimestampConverter() this.streakStartedAt, this.lastEarnedDate, required this.totalEngagementsCompleted, required this.totalTokensEarned, @TimestampConverter() required this.updatedAt}): super._();
  factory _UserEngagementStatsModel.fromJson(Map<String, dynamic> json) => _$UserEngagementStatsModelFromJson(json);

@override final  String userId;
@override final  int currentStreak;
@override final  int longestStreak;
@override@NullableTimestampConverter() final  DateTime? streakStartedAt;
@override final  String? lastEarnedDate;
@override final  int totalEngagementsCompleted;
@override final  int totalTokensEarned;
@override@TimestampConverter() final  DateTime updatedAt;

/// Create a copy of UserEngagementStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEngagementStatsModelCopyWith<_UserEngagementStatsModel> get copyWith => __$UserEngagementStatsModelCopyWithImpl<_UserEngagementStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEngagementStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEngagementStatsModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.streakStartedAt, streakStartedAt) || other.streakStartedAt == streakStartedAt)&&(identical(other.lastEarnedDate, lastEarnedDate) || other.lastEarnedDate == lastEarnedDate)&&(identical(other.totalEngagementsCompleted, totalEngagementsCompleted) || other.totalEngagementsCompleted == totalEngagementsCompleted)&&(identical(other.totalTokensEarned, totalTokensEarned) || other.totalTokensEarned == totalTokensEarned)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,currentStreak,longestStreak,streakStartedAt,lastEarnedDate,totalEngagementsCompleted,totalTokensEarned,updatedAt);

@override
String toString() {
  return 'UserEngagementStatsModel(userId: $userId, currentStreak: $currentStreak, longestStreak: $longestStreak, streakStartedAt: $streakStartedAt, lastEarnedDate: $lastEarnedDate, totalEngagementsCompleted: $totalEngagementsCompleted, totalTokensEarned: $totalTokensEarned, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserEngagementStatsModelCopyWith<$Res> implements $UserEngagementStatsModelCopyWith<$Res> {
  factory _$UserEngagementStatsModelCopyWith(_UserEngagementStatsModel value, $Res Function(_UserEngagementStatsModel) _then) = __$UserEngagementStatsModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, int currentStreak, int longestStreak,@NullableTimestampConverter() DateTime? streakStartedAt, String? lastEarnedDate, int totalEngagementsCompleted, int totalTokensEarned,@TimestampConverter() DateTime updatedAt
});




}
/// @nodoc
class __$UserEngagementStatsModelCopyWithImpl<$Res>
    implements _$UserEngagementStatsModelCopyWith<$Res> {
  __$UserEngagementStatsModelCopyWithImpl(this._self, this._then);

  final _UserEngagementStatsModel _self;
  final $Res Function(_UserEngagementStatsModel) _then;

/// Create a copy of UserEngagementStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? currentStreak = null,Object? longestStreak = null,Object? streakStartedAt = freezed,Object? lastEarnedDate = freezed,Object? totalEngagementsCompleted = null,Object? totalTokensEarned = null,Object? updatedAt = null,}) {
  return _then(_UserEngagementStatsModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,streakStartedAt: freezed == streakStartedAt ? _self.streakStartedAt : streakStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastEarnedDate: freezed == lastEarnedDate ? _self.lastEarnedDate : lastEarnedDate // ignore: cast_nullable_to_non_nullable
as String?,totalEngagementsCompleted: null == totalEngagementsCompleted ? _self.totalEngagementsCompleted : totalEngagementsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalTokensEarned: null == totalTokensEarned ? _self.totalTokensEarned : totalTokensEarned // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
