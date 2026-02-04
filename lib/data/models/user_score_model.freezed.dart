// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserScoreModel {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get avatarColor => throw _privateConstructorUsedError;
  int get totalTokensEarned => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  int? get previousRank => throw _privateConstructorUsedError;
  int get engagementsCompleted => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // New scoring fields
  int get baseScore => throw _privateConstructorUsedError;
  double get streakMultiplier => throw _privateConstructorUsedError;
  int get assistScore => throw _privateConstructorUsedError;
  int get referralQualityScore => throw _privateConstructorUsedError;
  int get finalScore => throw _privateConstructorUsedError;
  DateTime? get firstCompletionAt => throw _privateConstructorUsedError;

  /// Create a copy of UserScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserScoreModelCopyWith<UserScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserScoreModelCopyWith<$Res> {
  factory $UserScoreModelCopyWith(
    UserScoreModel value,
    $Res Function(UserScoreModel) then,
  ) = _$UserScoreModelCopyWithImpl<$Res, UserScoreModel>;
  @useResult
  $Res call({
    String userId,
    String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    int totalTokensEarned,
    int rank,
    int? previousRank,
    int engagementsCompleted,
    int currentStreak,
    int longestStreak,
    DateTime periodStart,
    DateTime periodEnd,
    DateTime updatedAt,
    int baseScore,
    double streakMultiplier,
    int assistScore,
    int referralQualityScore,
    int finalScore,
    DateTime? firstCompletionAt,
  });
}

/// @nodoc
class _$UserScoreModelCopyWithImpl<$Res, $Val extends UserScoreModel>
    implements $UserScoreModelCopyWith<$Res> {
  _$UserScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? totalTokensEarned = null,
    Object? rank = null,
    Object? previousRank = freezed,
    Object? engagementsCompleted = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? updatedAt = null,
    Object? baseScore = null,
    Object? streakMultiplier = null,
    Object? assistScore = null,
    Object? referralQualityScore = null,
    Object? finalScore = null,
    Object? firstCompletionAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
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
            avatarColor: freezed == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalTokensEarned: null == totalTokensEarned
                ? _value.totalTokensEarned
                : totalTokensEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            previousRank: freezed == previousRank
                ? _value.previousRank
                : previousRank // ignore: cast_nullable_to_non_nullable
                      as int?,
            engagementsCompleted: null == engagementsCompleted
                ? _value.engagementsCompleted
                : engagementsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            periodStart: null == periodStart
                ? _value.periodStart
                : periodStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            periodEnd: null == periodEnd
                ? _value.periodEnd
                : periodEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            baseScore: null == baseScore
                ? _value.baseScore
                : baseScore // ignore: cast_nullable_to_non_nullable
                      as int,
            streakMultiplier: null == streakMultiplier
                ? _value.streakMultiplier
                : streakMultiplier // ignore: cast_nullable_to_non_nullable
                      as double,
            assistScore: null == assistScore
                ? _value.assistScore
                : assistScore // ignore: cast_nullable_to_non_nullable
                      as int,
            referralQualityScore: null == referralQualityScore
                ? _value.referralQualityScore
                : referralQualityScore // ignore: cast_nullable_to_non_nullable
                      as int,
            finalScore: null == finalScore
                ? _value.finalScore
                : finalScore // ignore: cast_nullable_to_non_nullable
                      as int,
            firstCompletionAt: freezed == firstCompletionAt
                ? _value.firstCompletionAt
                : firstCompletionAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserScoreModelImplCopyWith<$Res>
    implements $UserScoreModelCopyWith<$Res> {
  factory _$$UserScoreModelImplCopyWith(
    _$UserScoreModelImpl value,
    $Res Function(_$UserScoreModelImpl) then,
  ) = __$$UserScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    int totalTokensEarned,
    int rank,
    int? previousRank,
    int engagementsCompleted,
    int currentStreak,
    int longestStreak,
    DateTime periodStart,
    DateTime periodEnd,
    DateTime updatedAt,
    int baseScore,
    double streakMultiplier,
    int assistScore,
    int referralQualityScore,
    int finalScore,
    DateTime? firstCompletionAt,
  });
}

/// @nodoc
class __$$UserScoreModelImplCopyWithImpl<$Res>
    extends _$UserScoreModelCopyWithImpl<$Res, _$UserScoreModelImpl>
    implements _$$UserScoreModelImplCopyWith<$Res> {
  __$$UserScoreModelImplCopyWithImpl(
    _$UserScoreModelImpl _value,
    $Res Function(_$UserScoreModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? totalTokensEarned = null,
    Object? rank = null,
    Object? previousRank = freezed,
    Object? engagementsCompleted = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? updatedAt = null,
    Object? baseScore = null,
    Object? streakMultiplier = null,
    Object? assistScore = null,
    Object? referralQualityScore = null,
    Object? finalScore = null,
    Object? firstCompletionAt = freezed,
  }) {
    return _then(
      _$UserScoreModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
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
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalTokensEarned: null == totalTokensEarned
            ? _value.totalTokensEarned
            : totalTokensEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        previousRank: freezed == previousRank
            ? _value.previousRank
            : previousRank // ignore: cast_nullable_to_non_nullable
                  as int?,
        engagementsCompleted: null == engagementsCompleted
            ? _value.engagementsCompleted
            : engagementsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        periodStart: null == periodStart
            ? _value.periodStart
            : periodStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        periodEnd: null == periodEnd
            ? _value.periodEnd
            : periodEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        baseScore: null == baseScore
            ? _value.baseScore
            : baseScore // ignore: cast_nullable_to_non_nullable
                  as int,
        streakMultiplier: null == streakMultiplier
            ? _value.streakMultiplier
            : streakMultiplier // ignore: cast_nullable_to_non_nullable
                  as double,
        assistScore: null == assistScore
            ? _value.assistScore
            : assistScore // ignore: cast_nullable_to_non_nullable
                  as int,
        referralQualityScore: null == referralQualityScore
            ? _value.referralQualityScore
            : referralQualityScore // ignore: cast_nullable_to_non_nullable
                  as int,
        finalScore: null == finalScore
            ? _value.finalScore
            : finalScore // ignore: cast_nullable_to_non_nullable
                  as int,
        firstCompletionAt: freezed == firstCompletionAt
            ? _value.firstCompletionAt
            : firstCompletionAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$UserScoreModelImpl extends _UserScoreModel {
  const _$UserScoreModelImpl({
    required this.userId,
    required this.displayName,
    this.username,
    this.avatarUrl,
    this.avatarColor,
    required this.totalTokensEarned,
    required this.rank,
    this.previousRank,
    required this.engagementsCompleted,
    required this.currentStreak,
    required this.longestStreak,
    required this.periodStart,
    required this.periodEnd,
    required this.updatedAt,
    this.baseScore = 0,
    this.streakMultiplier = 1.0,
    this.assistScore = 0,
    this.referralQualityScore = 0,
    this.finalScore = 0,
    this.firstCompletionAt,
  }) : super._();

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? username;
  @override
  final String? avatarUrl;
  @override
  final String? avatarColor;
  @override
  final int totalTokensEarned;
  @override
  final int rank;
  @override
  final int? previousRank;
  @override
  final int engagementsCompleted;
  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  @override
  final DateTime updatedAt;
  // New scoring fields
  @override
  @JsonKey()
  final int baseScore;
  @override
  @JsonKey()
  final double streakMultiplier;
  @override
  @JsonKey()
  final int assistScore;
  @override
  @JsonKey()
  final int referralQualityScore;
  @override
  @JsonKey()
  final int finalScore;
  @override
  final DateTime? firstCompletionAt;

  @override
  String toString() {
    return 'UserScoreModel(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, avatarColor: $avatarColor, totalTokensEarned: $totalTokensEarned, rank: $rank, previousRank: $previousRank, engagementsCompleted: $engagementsCompleted, currentStreak: $currentStreak, longestStreak: $longestStreak, periodStart: $periodStart, periodEnd: $periodEnd, updatedAt: $updatedAt, baseScore: $baseScore, streakMultiplier: $streakMultiplier, assistScore: $assistScore, referralQualityScore: $referralQualityScore, finalScore: $finalScore, firstCompletionAt: $firstCompletionAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserScoreModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.totalTokensEarned, totalTokensEarned) ||
                other.totalTokensEarned == totalTokensEarned) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.previousRank, previousRank) ||
                other.previousRank == previousRank) &&
            (identical(other.engagementsCompleted, engagementsCompleted) ||
                other.engagementsCompleted == engagementsCompleted) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.baseScore, baseScore) ||
                other.baseScore == baseScore) &&
            (identical(other.streakMultiplier, streakMultiplier) ||
                other.streakMultiplier == streakMultiplier) &&
            (identical(other.assistScore, assistScore) ||
                other.assistScore == assistScore) &&
            (identical(other.referralQualityScore, referralQualityScore) ||
                other.referralQualityScore == referralQualityScore) &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.firstCompletionAt, firstCompletionAt) ||
                other.firstCompletionAt == firstCompletionAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    userId,
    displayName,
    username,
    avatarUrl,
    avatarColor,
    totalTokensEarned,
    rank,
    previousRank,
    engagementsCompleted,
    currentStreak,
    longestStreak,
    periodStart,
    periodEnd,
    updatedAt,
    baseScore,
    streakMultiplier,
    assistScore,
    referralQualityScore,
    finalScore,
    firstCompletionAt,
  ]);

  /// Create a copy of UserScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserScoreModelImplCopyWith<_$UserScoreModelImpl> get copyWith =>
      __$$UserScoreModelImplCopyWithImpl<_$UserScoreModelImpl>(
        this,
        _$identity,
      );
}

abstract class _UserScoreModel extends UserScoreModel {
  const factory _UserScoreModel({
    required final String userId,
    required final String displayName,
    final String? username,
    final String? avatarUrl,
    final String? avatarColor,
    required final int totalTokensEarned,
    required final int rank,
    final int? previousRank,
    required final int engagementsCompleted,
    required final int currentStreak,
    required final int longestStreak,
    required final DateTime periodStart,
    required final DateTime periodEnd,
    required final DateTime updatedAt,
    final int baseScore,
    final double streakMultiplier,
    final int assistScore,
    final int referralQualityScore,
    final int finalScore,
    final DateTime? firstCompletionAt,
  }) = _$UserScoreModelImpl;
  const _UserScoreModel._() : super._();

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get username;
  @override
  String? get avatarUrl;
  @override
  String? get avatarColor;
  @override
  int get totalTokensEarned;
  @override
  int get rank;
  @override
  int? get previousRank;
  @override
  int get engagementsCompleted;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  DateTime get updatedAt; // New scoring fields
  @override
  int get baseScore;
  @override
  double get streakMultiplier;
  @override
  int get assistScore;
  @override
  int get referralQualityScore;
  @override
  int get finalScore;
  @override
  DateTime? get firstCompletionAt;

  /// Create a copy of UserScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserScoreModelImplCopyWith<_$UserScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
