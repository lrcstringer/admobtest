// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_engagement_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserEngagementStats _$UserEngagementStatsFromJson(Map<String, dynamic> json) {
  return _UserEngagementStats.fromJson(json);
}

/// @nodoc
mixin _$UserEngagementStats {
  String get userId => throw _privateConstructorUsedError;

  /// Current consecutive days with completions
  int get currentStreak => throw _privateConstructorUsedError;

  /// Longest streak ever achieved
  int get longestStreak => throw _privateConstructorUsedError;

  /// When the current streak started (null if no streak)
  DateTime? get streakStartedAt => throw _privateConstructorUsedError;

  /// Last date user earned tokens (YYYY-MM-DD in SAST)
  String? get lastEarnedDate => throw _privateConstructorUsedError;

  /// Total engagements completed all-time
  int get totalEngagementsCompleted => throw _privateConstructorUsedError;

  /// Total tokens earned all-time
  int get totalTokensEarned => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserEngagementStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserEngagementStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserEngagementStatsCopyWith<UserEngagementStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEngagementStatsCopyWith<$Res> {
  factory $UserEngagementStatsCopyWith(
    UserEngagementStats value,
    $Res Function(UserEngagementStats) then,
  ) = _$UserEngagementStatsCopyWithImpl<$Res, UserEngagementStats>;
  @useResult
  $Res call({
    String userId,
    int currentStreak,
    int longestStreak,
    DateTime? streakStartedAt,
    String? lastEarnedDate,
    int totalEngagementsCompleted,
    int totalTokensEarned,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$UserEngagementStatsCopyWithImpl<$Res, $Val extends UserEngagementStats>
    implements $UserEngagementStatsCopyWith<$Res> {
  _$UserEngagementStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEngagementStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? streakStartedAt = freezed,
    Object? lastEarnedDate = freezed,
    Object? totalEngagementsCompleted = null,
    Object? totalTokensEarned = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            streakStartedAt: freezed == streakStartedAt
                ? _value.streakStartedAt
                : streakStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastEarnedDate: freezed == lastEarnedDate
                ? _value.lastEarnedDate
                : lastEarnedDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalEngagementsCompleted: null == totalEngagementsCompleted
                ? _value.totalEngagementsCompleted
                : totalEngagementsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTokensEarned: null == totalTokensEarned
                ? _value.totalTokensEarned
                : totalTokensEarned // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$UserEngagementStatsImplCopyWith<$Res>
    implements $UserEngagementStatsCopyWith<$Res> {
  factory _$$UserEngagementStatsImplCopyWith(
    _$UserEngagementStatsImpl value,
    $Res Function(_$UserEngagementStatsImpl) then,
  ) = __$$UserEngagementStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    int currentStreak,
    int longestStreak,
    DateTime? streakStartedAt,
    String? lastEarnedDate,
    int totalEngagementsCompleted,
    int totalTokensEarned,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserEngagementStatsImplCopyWithImpl<$Res>
    extends _$UserEngagementStatsCopyWithImpl<$Res, _$UserEngagementStatsImpl>
    implements _$$UserEngagementStatsImplCopyWith<$Res> {
  __$$UserEngagementStatsImplCopyWithImpl(
    _$UserEngagementStatsImpl _value,
    $Res Function(_$UserEngagementStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEngagementStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? streakStartedAt = freezed,
    Object? lastEarnedDate = freezed,
    Object? totalEngagementsCompleted = null,
    Object? totalTokensEarned = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserEngagementStatsImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        streakStartedAt: freezed == streakStartedAt
            ? _value.streakStartedAt
            : streakStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastEarnedDate: freezed == lastEarnedDate
            ? _value.lastEarnedDate
            : lastEarnedDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalEngagementsCompleted: null == totalEngagementsCompleted
            ? _value.totalEngagementsCompleted
            : totalEngagementsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTokensEarned: null == totalTokensEarned
            ? _value.totalTokensEarned
            : totalTokensEarned // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$UserEngagementStatsImpl extends _UserEngagementStats {
  const _$UserEngagementStatsImpl({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    this.streakStartedAt,
    this.lastEarnedDate,
    required this.totalEngagementsCompleted,
    required this.totalTokensEarned,
    required this.updatedAt,
  }) : super._();

  factory _$UserEngagementStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserEngagementStatsImplFromJson(json);

  @override
  final String userId;

  /// Current consecutive days with completions
  @override
  final int currentStreak;

  /// Longest streak ever achieved
  @override
  final int longestStreak;

  /// When the current streak started (null if no streak)
  @override
  final DateTime? streakStartedAt;

  /// Last date user earned tokens (YYYY-MM-DD in SAST)
  @override
  final String? lastEarnedDate;

  /// Total engagements completed all-time
  @override
  final int totalEngagementsCompleted;

  /// Total tokens earned all-time
  @override
  final int totalTokensEarned;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserEngagementStats(userId: $userId, currentStreak: $currentStreak, longestStreak: $longestStreak, streakStartedAt: $streakStartedAt, lastEarnedDate: $lastEarnedDate, totalEngagementsCompleted: $totalEngagementsCompleted, totalTokensEarned: $totalTokensEarned, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEngagementStatsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.streakStartedAt, streakStartedAt) ||
                other.streakStartedAt == streakStartedAt) &&
            (identical(other.lastEarnedDate, lastEarnedDate) ||
                other.lastEarnedDate == lastEarnedDate) &&
            (identical(
                  other.totalEngagementsCompleted,
                  totalEngagementsCompleted,
                ) ||
                other.totalEngagementsCompleted == totalEngagementsCompleted) &&
            (identical(other.totalTokensEarned, totalTokensEarned) ||
                other.totalTokensEarned == totalTokensEarned) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    currentStreak,
    longestStreak,
    streakStartedAt,
    lastEarnedDate,
    totalEngagementsCompleted,
    totalTokensEarned,
    updatedAt,
  );

  /// Create a copy of UserEngagementStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEngagementStatsImplCopyWith<_$UserEngagementStatsImpl> get copyWith =>
      __$$UserEngagementStatsImplCopyWithImpl<_$UserEngagementStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserEngagementStatsImplToJson(this);
  }
}

abstract class _UserEngagementStats extends UserEngagementStats {
  const factory _UserEngagementStats({
    required final String userId,
    required final int currentStreak,
    required final int longestStreak,
    final DateTime? streakStartedAt,
    final String? lastEarnedDate,
    required final int totalEngagementsCompleted,
    required final int totalTokensEarned,
    required final DateTime updatedAt,
  }) = _$UserEngagementStatsImpl;
  const _UserEngagementStats._() : super._();

  factory _UserEngagementStats.fromJson(Map<String, dynamic> json) =
      _$UserEngagementStatsImpl.fromJson;

  @override
  String get userId;

  /// Current consecutive days with completions
  @override
  int get currentStreak;

  /// Longest streak ever achieved
  @override
  int get longestStreak;

  /// When the current streak started (null if no streak)
  @override
  DateTime? get streakStartedAt;

  /// Last date user earned tokens (YYYY-MM-DD in SAST)
  @override
  String? get lastEarnedDate;

  /// Total engagements completed all-time
  @override
  int get totalEngagementsCompleted;

  /// Total tokens earned all-time
  @override
  int get totalTokensEarned;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserEngagementStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserEngagementStatsImplCopyWith<_$UserEngagementStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
