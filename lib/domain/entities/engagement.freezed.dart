// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Engagement _$EngagementFromJson(Map<String, dynamic> json) {
  return _Engagement.fromJson(json);
}

/// @nodoc
mixin _$Engagement {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get oddienceCampaignId => throw _privateConstructorUsedError;
  String get earnOpportunityId => throw _privateConstructorUsedError;
  EngagementStatus get status => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get watchDurationSeconds => throw _privateConstructorUsedError;
  int get requiredDurationSeconds => throw _privateConstructorUsedError;
  List<EngagementAnswer> get answers => throw _privateConstructorUsedError;
  EngagementEvidence? get evidence => throw _privateConstructorUsedError;
  int? get tokensEarned => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  int get attemptNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Denormalized fields for targeting queries
  /// Thread ID denormalized from opportunity
  String? get threadId => throw _privateConstructorUsedError;

  /// Client ID denormalized from thread
  String? get clientId =>
      throw _privateConstructorUsedError; // Streak audit fields
  /// What day of streak this completion was on
  int? get streakDayAtCompletion => throw _privateConstructorUsedError;

  /// Multiplier applied at time of completion (1.0, 1.2, 1.35, or 1.5)
  double? get multiplierApplied =>
      throw _privateConstructorUsedError; // AdMob tracking fields
  /// True when ad was fully watched
  bool get adWatched => throw _privateConstructorUsedError;

  /// AdMob transaction ID for SSV verification
  String? get adTransactionId => throw _privateConstructorUsedError;

  /// Timestamp when ad completed
  DateTime? get adCompletedAt => throw _privateConstructorUsedError;

  /// Serializes this Engagement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Engagement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementCopyWith<Engagement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementCopyWith<$Res> {
  factory $EngagementCopyWith(
    Engagement value,
    $Res Function(Engagement) then,
  ) = _$EngagementCopyWithImpl<$Res, Engagement>;
  @useResult
  $Res call({
    String id,
    String userId,
    String oddienceCampaignId,
    String earnOpportunityId,
    EngagementStatus status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<EngagementAnswer> answers,
    EngagementEvidence? evidence,
    int? tokensEarned,
    String? failureReason,
    int attemptNumber,
    DateTime createdAt,
    DateTime? updatedAt,
    String? threadId,
    String? clientId,
    int? streakDayAtCompletion,
    double? multiplierApplied,
    bool adWatched,
    String? adTransactionId,
    DateTime? adCompletedAt,
  });

  $EngagementEvidenceCopyWith<$Res>? get evidence;
}

/// @nodoc
class _$EngagementCopyWithImpl<$Res, $Val extends Engagement>
    implements $EngagementCopyWith<$Res> {
  _$EngagementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Engagement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? oddienceCampaignId = null,
    Object? earnOpportunityId = null,
    Object? status = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? watchDurationSeconds = null,
    Object? requiredDurationSeconds = null,
    Object? answers = null,
    Object? evidence = freezed,
    Object? tokensEarned = freezed,
    Object? failureReason = freezed,
    Object? attemptNumber = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? threadId = freezed,
    Object? clientId = freezed,
    Object? streakDayAtCompletion = freezed,
    Object? multiplierApplied = freezed,
    Object? adWatched = null,
    Object? adTransactionId = freezed,
    Object? adCompletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            oddienceCampaignId: null == oddienceCampaignId
                ? _value.oddienceCampaignId
                : oddienceCampaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            earnOpportunityId: null == earnOpportunityId
                ? _value.earnOpportunityId
                : earnOpportunityId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as EngagementStatus,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            watchDurationSeconds: null == watchDurationSeconds
                ? _value.watchDurationSeconds
                : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredDurationSeconds: null == requiredDurationSeconds
                ? _value.requiredDurationSeconds
                : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            answers: null == answers
                ? _value.answers
                : answers // ignore: cast_nullable_to_non_nullable
                      as List<EngagementAnswer>,
            evidence: freezed == evidence
                ? _value.evidence
                : evidence // ignore: cast_nullable_to_non_nullable
                      as EngagementEvidence?,
            tokensEarned: freezed == tokensEarned
                ? _value.tokensEarned
                : tokensEarned // ignore: cast_nullable_to_non_nullable
                      as int?,
            failureReason: freezed == failureReason
                ? _value.failureReason
                : failureReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            attemptNumber: null == attemptNumber
                ? _value.attemptNumber
                : attemptNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            threadId: freezed == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientId: freezed == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            streakDayAtCompletion: freezed == streakDayAtCompletion
                ? _value.streakDayAtCompletion
                : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
                      as int?,
            multiplierApplied: freezed == multiplierApplied
                ? _value.multiplierApplied
                : multiplierApplied // ignore: cast_nullable_to_non_nullable
                      as double?,
            adWatched: null == adWatched
                ? _value.adWatched
                : adWatched // ignore: cast_nullable_to_non_nullable
                      as bool,
            adTransactionId: freezed == adTransactionId
                ? _value.adTransactionId
                : adTransactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            adCompletedAt: freezed == adCompletedAt
                ? _value.adCompletedAt
                : adCompletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of Engagement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EngagementEvidenceCopyWith<$Res>? get evidence {
    if (_value.evidence == null) {
      return null;
    }

    return $EngagementEvidenceCopyWith<$Res>(_value.evidence!, (value) {
      return _then(_value.copyWith(evidence: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EngagementImplCopyWith<$Res>
    implements $EngagementCopyWith<$Res> {
  factory _$$EngagementImplCopyWith(
    _$EngagementImpl value,
    $Res Function(_$EngagementImpl) then,
  ) = __$$EngagementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String oddienceCampaignId,
    String earnOpportunityId,
    EngagementStatus status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<EngagementAnswer> answers,
    EngagementEvidence? evidence,
    int? tokensEarned,
    String? failureReason,
    int attemptNumber,
    DateTime createdAt,
    DateTime? updatedAt,
    String? threadId,
    String? clientId,
    int? streakDayAtCompletion,
    double? multiplierApplied,
    bool adWatched,
    String? adTransactionId,
    DateTime? adCompletedAt,
  });

  @override
  $EngagementEvidenceCopyWith<$Res>? get evidence;
}

/// @nodoc
class __$$EngagementImplCopyWithImpl<$Res>
    extends _$EngagementCopyWithImpl<$Res, _$EngagementImpl>
    implements _$$EngagementImplCopyWith<$Res> {
  __$$EngagementImplCopyWithImpl(
    _$EngagementImpl _value,
    $Res Function(_$EngagementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Engagement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? oddienceCampaignId = null,
    Object? earnOpportunityId = null,
    Object? status = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? watchDurationSeconds = null,
    Object? requiredDurationSeconds = null,
    Object? answers = null,
    Object? evidence = freezed,
    Object? tokensEarned = freezed,
    Object? failureReason = freezed,
    Object? attemptNumber = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? threadId = freezed,
    Object? clientId = freezed,
    Object? streakDayAtCompletion = freezed,
    Object? multiplierApplied = freezed,
    Object? adWatched = null,
    Object? adTransactionId = freezed,
    Object? adCompletedAt = freezed,
  }) {
    return _then(
      _$EngagementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        oddienceCampaignId: null == oddienceCampaignId
            ? _value.oddienceCampaignId
            : oddienceCampaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        earnOpportunityId: null == earnOpportunityId
            ? _value.earnOpportunityId
            : earnOpportunityId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as EngagementStatus,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        watchDurationSeconds: null == watchDurationSeconds
            ? _value.watchDurationSeconds
            : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredDurationSeconds: null == requiredDurationSeconds
            ? _value.requiredDurationSeconds
            : requiredDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        answers: null == answers
            ? _value._answers
            : answers // ignore: cast_nullable_to_non_nullable
                  as List<EngagementAnswer>,
        evidence: freezed == evidence
            ? _value.evidence
            : evidence // ignore: cast_nullable_to_non_nullable
                  as EngagementEvidence?,
        tokensEarned: freezed == tokensEarned
            ? _value.tokensEarned
            : tokensEarned // ignore: cast_nullable_to_non_nullable
                  as int?,
        failureReason: freezed == failureReason
            ? _value.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        attemptNumber: null == attemptNumber
            ? _value.attemptNumber
            : attemptNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        threadId: freezed == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        streakDayAtCompletion: freezed == streakDayAtCompletion
            ? _value.streakDayAtCompletion
            : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
                  as int?,
        multiplierApplied: freezed == multiplierApplied
            ? _value.multiplierApplied
            : multiplierApplied // ignore: cast_nullable_to_non_nullable
                  as double?,
        adWatched: null == adWatched
            ? _value.adWatched
            : adWatched // ignore: cast_nullable_to_non_nullable
                  as bool,
        adTransactionId: freezed == adTransactionId
            ? _value.adTransactionId
            : adTransactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        adCompletedAt: freezed == adCompletedAt
            ? _value.adCompletedAt
            : adCompletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EngagementImpl extends _Engagement {
  const _$EngagementImpl({
    required this.id,
    required this.userId,
    required this.oddienceCampaignId,
    required this.earnOpportunityId,
    required this.status,
    required this.startedAt,
    this.completedAt,
    required this.watchDurationSeconds,
    required this.requiredDurationSeconds,
    required final List<EngagementAnswer> answers,
    this.evidence,
    this.tokensEarned,
    this.failureReason,
    required this.attemptNumber,
    required this.createdAt,
    this.updatedAt,
    this.threadId,
    this.clientId,
    this.streakDayAtCompletion,
    this.multiplierApplied,
    this.adWatched = false,
    this.adTransactionId,
    this.adCompletedAt,
  }) : _answers = answers,
       super._();

  factory _$EngagementImpl.fromJson(Map<String, dynamic> json) =>
      _$$EngagementImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String oddienceCampaignId;
  @override
  final String earnOpportunityId;
  @override
  final EngagementStatus status;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int watchDurationSeconds;
  @override
  final int requiredDurationSeconds;
  final List<EngagementAnswer> _answers;
  @override
  List<EngagementAnswer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final EngagementEvidence? evidence;
  @override
  final int? tokensEarned;
  @override
  final String? failureReason;
  @override
  final int attemptNumber;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  // Denormalized fields for targeting queries
  /// Thread ID denormalized from opportunity
  @override
  final String? threadId;

  /// Client ID denormalized from thread
  @override
  final String? clientId;
  // Streak audit fields
  /// What day of streak this completion was on
  @override
  final int? streakDayAtCompletion;

  /// Multiplier applied at time of completion (1.0, 1.2, 1.35, or 1.5)
  @override
  final double? multiplierApplied;
  // AdMob tracking fields
  /// True when ad was fully watched
  @override
  @JsonKey()
  final bool adWatched;

  /// AdMob transaction ID for SSV verification
  @override
  final String? adTransactionId;

  /// Timestamp when ad completed
  @override
  final DateTime? adCompletedAt;

  @override
  String toString() {
    return 'Engagement(id: $id, userId: $userId, oddienceCampaignId: $oddienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, threadId: $threadId, clientId: $clientId, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied, adWatched: $adWatched, adTransactionId: $adTransactionId, adCompletedAt: $adCompletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.oddienceCampaignId, oddienceCampaignId) ||
                other.oddienceCampaignId == oddienceCampaignId) &&
            (identical(other.earnOpportunityId, earnOpportunityId) ||
                other.earnOpportunityId == earnOpportunityId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.watchDurationSeconds, watchDurationSeconds) ||
                other.watchDurationSeconds == watchDurationSeconds) &&
            (identical(
                  other.requiredDurationSeconds,
                  requiredDurationSeconds,
                ) ||
                other.requiredDurationSeconds == requiredDurationSeconds) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.evidence, evidence) ||
                other.evidence == evidence) &&
            (identical(other.tokensEarned, tokensEarned) ||
                other.tokensEarned == tokensEarned) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.attemptNumber, attemptNumber) ||
                other.attemptNumber == attemptNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.streakDayAtCompletion, streakDayAtCompletion) ||
                other.streakDayAtCompletion == streakDayAtCompletion) &&
            (identical(other.multiplierApplied, multiplierApplied) ||
                other.multiplierApplied == multiplierApplied) &&
            (identical(other.adWatched, adWatched) ||
                other.adWatched == adWatched) &&
            (identical(other.adTransactionId, adTransactionId) ||
                other.adTransactionId == adTransactionId) &&
            (identical(other.adCompletedAt, adCompletedAt) ||
                other.adCompletedAt == adCompletedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    oddienceCampaignId,
    earnOpportunityId,
    status,
    startedAt,
    completedAt,
    watchDurationSeconds,
    requiredDurationSeconds,
    const DeepCollectionEquality().hash(_answers),
    evidence,
    tokensEarned,
    failureReason,
    attemptNumber,
    createdAt,
    updatedAt,
    threadId,
    clientId,
    streakDayAtCompletion,
    multiplierApplied,
    adWatched,
    adTransactionId,
    adCompletedAt,
  ]);

  /// Create a copy of Engagement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementImplCopyWith<_$EngagementImpl> get copyWith =>
      __$$EngagementImplCopyWithImpl<_$EngagementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EngagementImplToJson(this);
  }
}

abstract class _Engagement extends Engagement {
  const factory _Engagement({
    required final String id,
    required final String userId,
    required final String oddienceCampaignId,
    required final String earnOpportunityId,
    required final EngagementStatus status,
    required final DateTime startedAt,
    final DateTime? completedAt,
    required final int watchDurationSeconds,
    required final int requiredDurationSeconds,
    required final List<EngagementAnswer> answers,
    final EngagementEvidence? evidence,
    final int? tokensEarned,
    final String? failureReason,
    required final int attemptNumber,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final String? threadId,
    final String? clientId,
    final int? streakDayAtCompletion,
    final double? multiplierApplied,
    final bool adWatched,
    final String? adTransactionId,
    final DateTime? adCompletedAt,
  }) = _$EngagementImpl;
  const _Engagement._() : super._();

  factory _Engagement.fromJson(Map<String, dynamic> json) =
      _$EngagementImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get oddienceCampaignId;
  @override
  String get earnOpportunityId;
  @override
  EngagementStatus get status;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  int get watchDurationSeconds;
  @override
  int get requiredDurationSeconds;
  @override
  List<EngagementAnswer> get answers;
  @override
  EngagementEvidence? get evidence;
  @override
  int? get tokensEarned;
  @override
  String? get failureReason;
  @override
  int get attemptNumber;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt; // Denormalized fields for targeting queries
  /// Thread ID denormalized from opportunity
  @override
  String? get threadId;

  /// Client ID denormalized from thread
  @override
  String? get clientId; // Streak audit fields
  /// What day of streak this completion was on
  @override
  int? get streakDayAtCompletion;

  /// Multiplier applied at time of completion (1.0, 1.2, 1.35, or 1.5)
  @override
  double? get multiplierApplied; // AdMob tracking fields
  /// True when ad was fully watched
  @override
  bool get adWatched;

  /// AdMob transaction ID for SSV verification
  @override
  String? get adTransactionId;

  /// Timestamp when ad completed
  @override
  DateTime? get adCompletedAt;

  /// Create a copy of Engagement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementImplCopyWith<_$EngagementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EngagementAnswer _$EngagementAnswerFromJson(Map<String, dynamic> json) {
  return _EngagementAnswer.fromJson(json);
}

/// @nodoc
mixin _$EngagementAnswer {
  String get questionId => throw _privateConstructorUsedError;
  String get selectedOption => throw _privateConstructorUsedError;
  DateTime get answeredAt => throw _privateConstructorUsedError;
  bool? get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this EngagementAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EngagementAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementAnswerCopyWith<EngagementAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementAnswerCopyWith<$Res> {
  factory $EngagementAnswerCopyWith(
    EngagementAnswer value,
    $Res Function(EngagementAnswer) then,
  ) = _$EngagementAnswerCopyWithImpl<$Res, EngagementAnswer>;
  @useResult
  $Res call({
    String questionId,
    String selectedOption,
    DateTime answeredAt,
    bool? isCorrect,
  });
}

/// @nodoc
class _$EngagementAnswerCopyWithImpl<$Res, $Val extends EngagementAnswer>
    implements $EngagementAnswerCopyWith<$Res> {
  _$EngagementAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedOption = null,
    Object? answeredAt = null,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedOption: null == selectedOption
                ? _value.selectedOption
                : selectedOption // ignore: cast_nullable_to_non_nullable
                      as String,
            answeredAt: null == answeredAt
                ? _value.answeredAt
                : answeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isCorrect: freezed == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EngagementAnswerImplCopyWith<$Res>
    implements $EngagementAnswerCopyWith<$Res> {
  factory _$$EngagementAnswerImplCopyWith(
    _$EngagementAnswerImpl value,
    $Res Function(_$EngagementAnswerImpl) then,
  ) = __$$EngagementAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    String selectedOption,
    DateTime answeredAt,
    bool? isCorrect,
  });
}

/// @nodoc
class __$$EngagementAnswerImplCopyWithImpl<$Res>
    extends _$EngagementAnswerCopyWithImpl<$Res, _$EngagementAnswerImpl>
    implements _$$EngagementAnswerImplCopyWith<$Res> {
  __$$EngagementAnswerImplCopyWithImpl(
    _$EngagementAnswerImpl _value,
    $Res Function(_$EngagementAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedOption = null,
    Object? answeredAt = null,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _$EngagementAnswerImpl(
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedOption: null == selectedOption
            ? _value.selectedOption
            : selectedOption // ignore: cast_nullable_to_non_nullable
                  as String,
        answeredAt: null == answeredAt
            ? _value.answeredAt
            : answeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isCorrect: freezed == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EngagementAnswerImpl implements _EngagementAnswer {
  const _$EngagementAnswerImpl({
    required this.questionId,
    required this.selectedOption,
    required this.answeredAt,
    this.isCorrect,
  });

  factory _$EngagementAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$EngagementAnswerImplFromJson(json);

  @override
  final String questionId;
  @override
  final String selectedOption;
  @override
  final DateTime answeredAt;
  @override
  final bool? isCorrect;

  @override
  String toString() {
    return 'EngagementAnswer(questionId: $questionId, selectedOption: $selectedOption, answeredAt: $answeredAt, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementAnswerImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    selectedOption,
    answeredAt,
    isCorrect,
  );

  /// Create a copy of EngagementAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementAnswerImplCopyWith<_$EngagementAnswerImpl> get copyWith =>
      __$$EngagementAnswerImplCopyWithImpl<_$EngagementAnswerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EngagementAnswerImplToJson(this);
  }
}

abstract class _EngagementAnswer implements EngagementAnswer {
  const factory _EngagementAnswer({
    required final String questionId,
    required final String selectedOption,
    required final DateTime answeredAt,
    final bool? isCorrect,
  }) = _$EngagementAnswerImpl;

  factory _EngagementAnswer.fromJson(Map<String, dynamic> json) =
      _$EngagementAnswerImpl.fromJson;

  @override
  String get questionId;
  @override
  String get selectedOption;
  @override
  DateTime get answeredAt;
  @override
  bool? get isCorrect;

  /// Create a copy of EngagementAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementAnswerImplCopyWith<_$EngagementAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
