// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyScore _$DailyScoreFromJson(Map<String, dynamic> json) {
  return _DailyScore.fromJson(json);
}

/// @nodoc
mixin _$DailyScore {
  /// Date in YYYY-MM-DD format (SAST timezone)
  String get date => throw _privateConstructorUsedError;

  /// Number of engagements completed this day
  int get engagementsCompleted => throw _privateConstructorUsedError;

  /// Total tokens earned this day
  int get tokensEarned => throw _privateConstructorUsedError;

  /// What day of streak this was (1, 2, 3, etc.)
  int get streakDay => throw _privateConstructorUsedError;

  /// Streak multiplier applied (1.0, 1.2, 1.35, or 1.5)
  double get streakMultiplier => throw _privateConstructorUsedError;

  /// Assist score from referrals (10% of referee earnings)
  int get assistScore => throw _privateConstructorUsedError;

  /// Final calculated score for ranking
  int get finalScore => throw _privateConstructorUsedError;

  /// Cached display name for leaderboard
  String get displayName => throw _privateConstructorUsedError;

  /// Cached username for leaderboard
  String? get username => throw _privateConstructorUsedError;

  /// Cached avatar URL for leaderboard
  String? get avatarUrl => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DailyScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyScoreCopyWith<DailyScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyScoreCopyWith<$Res> {
  factory $DailyScoreCopyWith(
    DailyScore value,
    $Res Function(DailyScore) then,
  ) = _$DailyScoreCopyWithImpl<$Res, DailyScore>;
  @useResult
  $Res call({
    String date,
    int engagementsCompleted,
    int tokensEarned,
    int streakDay,
    double streakMultiplier,
    int assistScore,
    int finalScore,
    String displayName,
    String? username,
    String? avatarUrl,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$DailyScoreCopyWithImpl<$Res, $Val extends DailyScore>
    implements $DailyScoreCopyWith<$Res> {
  _$DailyScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? engagementsCompleted = null,
    Object? tokensEarned = null,
    Object? streakDay = null,
    Object? streakMultiplier = null,
    Object? assistScore = null,
    Object? finalScore = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            engagementsCompleted: null == engagementsCompleted
                ? _value.engagementsCompleted
                : engagementsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            tokensEarned: null == tokensEarned
                ? _value.tokensEarned
                : tokensEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            streakDay: null == streakDay
                ? _value.streakDay
                : streakDay // ignore: cast_nullable_to_non_nullable
                      as int,
            streakMultiplier: null == streakMultiplier
                ? _value.streakMultiplier
                : streakMultiplier // ignore: cast_nullable_to_non_nullable
                      as double,
            assistScore: null == assistScore
                ? _value.assistScore
                : assistScore // ignore: cast_nullable_to_non_nullable
                      as int,
            finalScore: null == finalScore
                ? _value.finalScore
                : finalScore // ignore: cast_nullable_to_non_nullable
                      as int,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyScoreImplCopyWith<$Res>
    implements $DailyScoreCopyWith<$Res> {
  factory _$$DailyScoreImplCopyWith(
    _$DailyScoreImpl value,
    $Res Function(_$DailyScoreImpl) then,
  ) = __$$DailyScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    int engagementsCompleted,
    int tokensEarned,
    int streakDay,
    double streakMultiplier,
    int assistScore,
    int finalScore,
    String displayName,
    String? username,
    String? avatarUrl,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$DailyScoreImplCopyWithImpl<$Res>
    extends _$DailyScoreCopyWithImpl<$Res, _$DailyScoreImpl>
    implements _$$DailyScoreImplCopyWith<$Res> {
  __$$DailyScoreImplCopyWithImpl(
    _$DailyScoreImpl _value,
    $Res Function(_$DailyScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? engagementsCompleted = null,
    Object? tokensEarned = null,
    Object? streakDay = null,
    Object? streakMultiplier = null,
    Object? assistScore = null,
    Object? finalScore = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _$DailyScoreImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        engagementsCompleted: null == engagementsCompleted
            ? _value.engagementsCompleted
            : engagementsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        tokensEarned: null == tokensEarned
            ? _value.tokensEarned
            : tokensEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        streakDay: null == streakDay
            ? _value.streakDay
            : streakDay // ignore: cast_nullable_to_non_nullable
                  as int,
        streakMultiplier: null == streakMultiplier
            ? _value.streakMultiplier
            : streakMultiplier // ignore: cast_nullable_to_non_nullable
                  as double,
        assistScore: null == assistScore
            ? _value.assistScore
            : assistScore // ignore: cast_nullable_to_non_nullable
                  as int,
        finalScore: null == finalScore
            ? _value.finalScore
            : finalScore // ignore: cast_nullable_to_non_nullable
                  as int,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyScoreImpl extends _DailyScore {
  const _$DailyScoreImpl({
    required this.date,
    required this.engagementsCompleted,
    required this.tokensEarned,
    required this.streakDay,
    required this.streakMultiplier,
    required this.assistScore,
    required this.finalScore,
    required this.displayName,
    this.username,
    this.avatarUrl,
    required this.updatedAt,
  }) : super._();

  factory _$DailyScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyScoreImplFromJson(json);

  /// Date in YYYY-MM-DD format (SAST timezone)
  @override
  final String date;

  /// Number of engagements completed this day
  @override
  final int engagementsCompleted;

  /// Total tokens earned this day
  @override
  final int tokensEarned;

  /// What day of streak this was (1, 2, 3, etc.)
  @override
  final int streakDay;

  /// Streak multiplier applied (1.0, 1.2, 1.35, or 1.5)
  @override
  final double streakMultiplier;

  /// Assist score from referrals (10% of referee earnings)
  @override
  final int assistScore;

  /// Final calculated score for ranking
  @override
  final int finalScore;

  /// Cached display name for leaderboard
  @override
  final String displayName;

  /// Cached username for leaderboard
  @override
  final String? username;

  /// Cached avatar URL for leaderboard
  @override
  final String? avatarUrl;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DailyScore(date: $date, engagementsCompleted: $engagementsCompleted, tokensEarned: $tokensEarned, streakDay: $streakDay, streakMultiplier: $streakMultiplier, assistScore: $assistScore, finalScore: $finalScore, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyScoreImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.engagementsCompleted, engagementsCompleted) ||
                other.engagementsCompleted == engagementsCompleted) &&
            (identical(other.tokensEarned, tokensEarned) ||
                other.tokensEarned == tokensEarned) &&
            (identical(other.streakDay, streakDay) ||
                other.streakDay == streakDay) &&
            (identical(other.streakMultiplier, streakMultiplier) ||
                other.streakMultiplier == streakMultiplier) &&
            (identical(other.assistScore, assistScore) ||
                other.assistScore == assistScore) &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    engagementsCompleted,
    tokensEarned,
    streakDay,
    streakMultiplier,
    assistScore,
    finalScore,
    displayName,
    username,
    avatarUrl,
    updatedAt,
  );

  /// Create a copy of DailyScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyScoreImplCopyWith<_$DailyScoreImpl> get copyWith =>
      __$$DailyScoreImplCopyWithImpl<_$DailyScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyScoreImplToJson(this);
  }
}

abstract class _DailyScore extends DailyScore {
  const factory _DailyScore({
    required final String date,
    required final int engagementsCompleted,
    required final int tokensEarned,
    required final int streakDay,
    required final double streakMultiplier,
    required final int assistScore,
    required final int finalScore,
    required final String displayName,
    final String? username,
    final String? avatarUrl,
    required final DateTime updatedAt,
  }) = _$DailyScoreImpl;
  const _DailyScore._() : super._();

  factory _DailyScore.fromJson(Map<String, dynamic> json) =
      _$DailyScoreImpl.fromJson;

  /// Date in YYYY-MM-DD format (SAST timezone)
  @override
  String get date;

  /// Number of engagements completed this day
  @override
  int get engagementsCompleted;

  /// Total tokens earned this day
  @override
  int get tokensEarned;

  /// What day of streak this was (1, 2, 3, etc.)
  @override
  int get streakDay;

  /// Streak multiplier applied (1.0, 1.2, 1.35, or 1.5)
  @override
  double get streakMultiplier;

  /// Assist score from referrals (10% of referee earnings)
  @override
  int get assistScore;

  /// Final calculated score for ranking
  @override
  int get finalScore;

  /// Cached display name for leaderboard
  @override
  String get displayName;

  /// Cached username for leaderboard
  @override
  String? get username;

  /// Cached avatar URL for leaderboard
  @override
  String? get avatarUrl;
  @override
  DateTime get updatedAt;

  /// Create a copy of DailyScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyScoreImplCopyWith<_$DailyScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
