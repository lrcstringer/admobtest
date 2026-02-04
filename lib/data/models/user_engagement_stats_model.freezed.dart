// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_engagement_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserEngagementStatsModel _$UserEngagementStatsModelFromJson(
  Map<String, dynamic> json,
) {
  return _UserEngagementStatsModel.fromJson(json);
}

/// @nodoc
mixin _$UserEngagementStatsModel {
  String get userId => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get streakStartedAt => throw _privateConstructorUsedError;
  String? get lastEarnedDate => throw _privateConstructorUsedError;
  int get totalEngagementsCompleted => throw _privateConstructorUsedError;
  int get totalTokensEarned => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserEngagementStatsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserEngagementStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserEngagementStatsModelCopyWith<UserEngagementStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEngagementStatsModelCopyWith<$Res> {
  factory $UserEngagementStatsModelCopyWith(
    UserEngagementStatsModel value,
    $Res Function(UserEngagementStatsModel) then,
  ) = _$UserEngagementStatsModelCopyWithImpl<$Res, UserEngagementStatsModel>;
  @useResult
  $Res call({
    String userId,
    int currentStreak,
    int longestStreak,
    @NullableTimestampConverter() DateTime? streakStartedAt,
    String? lastEarnedDate,
    int totalEngagementsCompleted,
    int totalTokensEarned,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$UserEngagementStatsModelCopyWithImpl<
  $Res,
  $Val extends UserEngagementStatsModel
>
    implements $UserEngagementStatsModelCopyWith<$Res> {
  _$UserEngagementStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEngagementStatsModel
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
abstract class _$$UserEngagementStatsModelImplCopyWith<$Res>
    implements $UserEngagementStatsModelCopyWith<$Res> {
  factory _$$UserEngagementStatsModelImplCopyWith(
    _$UserEngagementStatsModelImpl value,
    $Res Function(_$UserEngagementStatsModelImpl) then,
  ) = __$$UserEngagementStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    int currentStreak,
    int longestStreak,
    @NullableTimestampConverter() DateTime? streakStartedAt,
    String? lastEarnedDate,
    int totalEngagementsCompleted,
    int totalTokensEarned,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserEngagementStatsModelImplCopyWithImpl<$Res>
    extends
        _$UserEngagementStatsModelCopyWithImpl<
          $Res,
          _$UserEngagementStatsModelImpl
        >
    implements _$$UserEngagementStatsModelImplCopyWith<$Res> {
  __$$UserEngagementStatsModelImplCopyWithImpl(
    _$UserEngagementStatsModelImpl _value,
    $Res Function(_$UserEngagementStatsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEngagementStatsModel
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
      _$UserEngagementStatsModelImpl(
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
class _$UserEngagementStatsModelImpl extends _UserEngagementStatsModel {
  const _$UserEngagementStatsModelImpl({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    @NullableTimestampConverter() this.streakStartedAt,
    this.lastEarnedDate,
    required this.totalEngagementsCompleted,
    required this.totalTokensEarned,
    @TimestampConverter() required this.updatedAt,
  }) : super._();

  factory _$UserEngagementStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserEngagementStatsModelImplFromJson(json);

  @override
  final String userId;
  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  @NullableTimestampConverter()
  final DateTime? streakStartedAt;
  @override
  final String? lastEarnedDate;
  @override
  final int totalEngagementsCompleted;
  @override
  final int totalTokensEarned;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserEngagementStatsModel(userId: $userId, currentStreak: $currentStreak, longestStreak: $longestStreak, streakStartedAt: $streakStartedAt, lastEarnedDate: $lastEarnedDate, totalEngagementsCompleted: $totalEngagementsCompleted, totalTokensEarned: $totalTokensEarned, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEngagementStatsModelImpl &&
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

  /// Create a copy of UserEngagementStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEngagementStatsModelImplCopyWith<_$UserEngagementStatsModelImpl>
  get copyWith =>
      __$$UserEngagementStatsModelImplCopyWithImpl<
        _$UserEngagementStatsModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserEngagementStatsModelImplToJson(this);
  }
}

abstract class _UserEngagementStatsModel extends UserEngagementStatsModel {
  const factory _UserEngagementStatsModel({
    required final String userId,
    required final int currentStreak,
    required final int longestStreak,
    @NullableTimestampConverter() final DateTime? streakStartedAt,
    final String? lastEarnedDate,
    required final int totalEngagementsCompleted,
    required final int totalTokensEarned,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$UserEngagementStatsModelImpl;
  const _UserEngagementStatsModel._() : super._();

  factory _UserEngagementStatsModel.fromJson(Map<String, dynamic> json) =
      _$UserEngagementStatsModelImpl.fromJson;

  @override
  String get userId;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  @NullableTimestampConverter()
  DateTime? get streakStartedAt;
  @override
  String? get lastEarnedDate;
  @override
  int get totalEngagementsCompleted;
  @override
  int get totalTokensEarned;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of UserEngagementStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserEngagementStatsModelImplCopyWith<_$UserEngagementStatsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
