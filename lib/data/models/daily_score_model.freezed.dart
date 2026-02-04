// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyScoreModel _$DailyScoreModelFromJson(Map<String, dynamic> json) {
  return _DailyScoreModel.fromJson(json);
}

/// @nodoc
mixin _$DailyScoreModel {
  String get date => throw _privateConstructorUsedError;
  int get engagementsCompleted => throw _privateConstructorUsedError;
  int get tokensEarned => throw _privateConstructorUsedError;
  int get streakDay => throw _privateConstructorUsedError;
  double get streakMultiplier => throw _privateConstructorUsedError;
  int get assistScore => throw _privateConstructorUsedError;
  int get finalScore => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DailyScoreModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyScoreModelCopyWith<DailyScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyScoreModelCopyWith<$Res> {
  factory $DailyScoreModelCopyWith(
    DailyScoreModel value,
    $Res Function(DailyScoreModel) then,
  ) = _$DailyScoreModelCopyWithImpl<$Res, DailyScoreModel>;
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
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$DailyScoreModelCopyWithImpl<$Res, $Val extends DailyScoreModel>
    implements $DailyScoreModelCopyWith<$Res> {
  _$DailyScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyScoreModel
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
abstract class _$$DailyScoreModelImplCopyWith<$Res>
    implements $DailyScoreModelCopyWith<$Res> {
  factory _$$DailyScoreModelImplCopyWith(
    _$DailyScoreModelImpl value,
    $Res Function(_$DailyScoreModelImpl) then,
  ) = __$$DailyScoreModelImplCopyWithImpl<$Res>;
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
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$DailyScoreModelImplCopyWithImpl<$Res>
    extends _$DailyScoreModelCopyWithImpl<$Res, _$DailyScoreModelImpl>
    implements _$$DailyScoreModelImplCopyWith<$Res> {
  __$$DailyScoreModelImplCopyWithImpl(
    _$DailyScoreModelImpl _value,
    $Res Function(_$DailyScoreModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyScoreModel
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
      _$DailyScoreModelImpl(
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
class _$DailyScoreModelImpl extends _DailyScoreModel {
  const _$DailyScoreModelImpl({
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
    @TimestampConverter() required this.updatedAt,
  }) : super._();

  factory _$DailyScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyScoreModelImplFromJson(json);

  @override
  final String date;
  @override
  final int engagementsCompleted;
  @override
  final int tokensEarned;
  @override
  final int streakDay;
  @override
  final double streakMultiplier;
  @override
  final int assistScore;
  @override
  final int finalScore;
  @override
  final String displayName;
  @override
  final String? username;
  @override
  final String? avatarUrl;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DailyScoreModel(date: $date, engagementsCompleted: $engagementsCompleted, tokensEarned: $tokensEarned, streakDay: $streakDay, streakMultiplier: $streakMultiplier, assistScore: $assistScore, finalScore: $finalScore, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyScoreModelImpl &&
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

  /// Create a copy of DailyScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyScoreModelImplCopyWith<_$DailyScoreModelImpl> get copyWith =>
      __$$DailyScoreModelImplCopyWithImpl<_$DailyScoreModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyScoreModelImplToJson(this);
  }
}

abstract class _DailyScoreModel extends DailyScoreModel {
  const factory _DailyScoreModel({
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
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$DailyScoreModelImpl;
  const _DailyScoreModel._() : super._();

  factory _DailyScoreModel.fromJson(Map<String, dynamic> json) =
      _$DailyScoreModelImpl.fromJson;

  @override
  String get date;
  @override
  int get engagementsCompleted;
  @override
  int get tokensEarned;
  @override
  int get streakDay;
  @override
  double get streakMultiplier;
  @override
  int get assistScore;
  @override
  int get finalScore;
  @override
  String get displayName;
  @override
  String? get username;
  @override
  String? get avatarUrl;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of DailyScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyScoreModelImplCopyWith<_$DailyScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
