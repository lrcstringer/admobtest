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
  String? get audienceCampaignId => throw _privateConstructorUsedError;
  String get earnOpportunityId => throw _privateConstructorUsedError;
  EngagementStatus get status => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get watchDurationSeconds => throw _privateConstructorUsedError;
  int get requiredDurationSeconds => throw _privateConstructorUsedError;
  List<SurveyResponse> get answers => throw _privateConstructorUsedError;
  EngagementEvidence? get evidence => throw _privateConstructorUsedError;
  double? get tokensEarned => throw _privateConstructorUsedError;
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
    String? audienceCampaignId,
    String earnOpportunityId,
    EngagementStatus status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<SurveyResponse> answers,
    EngagementEvidence? evidence,
    double? tokensEarned,
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
    Object? audienceCampaignId = freezed,
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
            audienceCampaignId: freezed == audienceCampaignId
                ? _value.audienceCampaignId
                : audienceCampaignId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
                      as List<SurveyResponse>,
            evidence: freezed == evidence
                ? _value.evidence
                : evidence // ignore: cast_nullable_to_non_nullable
                      as EngagementEvidence?,
            tokensEarned: freezed == tokensEarned
                ? _value.tokensEarned
                : tokensEarned // ignore: cast_nullable_to_non_nullable
                      as double?,
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
    String? audienceCampaignId,
    String earnOpportunityId,
    EngagementStatus status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<SurveyResponse> answers,
    EngagementEvidence? evidence,
    double? tokensEarned,
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
    Object? audienceCampaignId = freezed,
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
        audienceCampaignId: freezed == audienceCampaignId
            ? _value.audienceCampaignId
            : audienceCampaignId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
                  as List<SurveyResponse>,
        evidence: freezed == evidence
            ? _value.evidence
            : evidence // ignore: cast_nullable_to_non_nullable
                  as EngagementEvidence?,
        tokensEarned: freezed == tokensEarned
            ? _value.tokensEarned
            : tokensEarned // ignore: cast_nullable_to_non_nullable
                  as double?,
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
    this.audienceCampaignId,
    required this.earnOpportunityId,
    required this.status,
    required this.startedAt,
    this.completedAt,
    required this.watchDurationSeconds,
    required this.requiredDurationSeconds,
    required final List<SurveyResponse> answers,
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
  final String? audienceCampaignId;
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
  final List<SurveyResponse> _answers;
  @override
  List<SurveyResponse> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final EngagementEvidence? evidence;
  @override
  final double? tokensEarned;
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
    return 'Engagement(id: $id, userId: $userId, audienceCampaignId: $audienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, threadId: $threadId, clientId: $clientId, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied, adWatched: $adWatched, adTransactionId: $adTransactionId, adCompletedAt: $adCompletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.audienceCampaignId, audienceCampaignId) ||
                other.audienceCampaignId == audienceCampaignId) &&
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
    audienceCampaignId,
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
    final String? audienceCampaignId,
    required final String earnOpportunityId,
    required final EngagementStatus status,
    required final DateTime startedAt,
    final DateTime? completedAt,
    required final int watchDurationSeconds,
    required final int requiredDurationSeconds,
    required final List<SurveyResponse> answers,
    final EngagementEvidence? evidence,
    final double? tokensEarned,
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
  String? get audienceCampaignId;
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
  List<SurveyResponse> get answers;
  @override
  EngagementEvidence? get evidence;
  @override
  double? get tokensEarned;
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

SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) {
  return _SurveyResponse.fromJson(json);
}

/// @nodoc
mixin _$SurveyResponse {
  String get questionId => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  DateTime get answeredAt =>
      throw _privateConstructorUsedError; // single_select
  String? get selectedOption =>
      throw _privateConstructorUsedError; // multi_select
  List<String>? get selectedOptions =>
      throw _privateConstructorUsedError; // text_input
  List<String>? get textResponses =>
      throw _privateConstructorUsedError; // likert
  int? get likertValue => throw _privateConstructorUsedError; // star_tags
  int? get starRating => throw _privateConstructorUsedError;
  List<String>? get selectedTags =>
      throw _privateConstructorUsedError; // slider
  double? get sliderValue =>
      throw _privateConstructorUsedError; // attention check result
  bool? get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this SurveyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyResponseCopyWith<SurveyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyResponseCopyWith<$Res> {
  factory $SurveyResponseCopyWith(
    SurveyResponse value,
    $Res Function(SurveyResponse) then,
  ) = _$SurveyResponseCopyWithImpl<$Res, SurveyResponse>;
  @useResult
  $Res call({
    String questionId,
    String questionType,
    DateTime answeredAt,
    String? selectedOption,
    List<String>? selectedOptions,
    List<String>? textResponses,
    int? likertValue,
    int? starRating,
    List<String>? selectedTags,
    double? sliderValue,
    bool? isCorrect,
  });
}

/// @nodoc
class _$SurveyResponseCopyWithImpl<$Res, $Val extends SurveyResponse>
    implements $SurveyResponseCopyWith<$Res> {
  _$SurveyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? questionType = null,
    Object? answeredAt = null,
    Object? selectedOption = freezed,
    Object? selectedOptions = freezed,
    Object? textResponses = freezed,
    Object? likertValue = freezed,
    Object? starRating = freezed,
    Object? selectedTags = freezed,
    Object? sliderValue = freezed,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionType: null == questionType
                ? _value.questionType
                : questionType // ignore: cast_nullable_to_non_nullable
                      as String,
            answeredAt: null == answeredAt
                ? _value.answeredAt
                : answeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            selectedOption: freezed == selectedOption
                ? _value.selectedOption
                : selectedOption // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedOptions: freezed == selectedOptions
                ? _value.selectedOptions
                : selectedOptions // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            textResponses: freezed == textResponses
                ? _value.textResponses
                : textResponses // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            likertValue: freezed == likertValue
                ? _value.likertValue
                : likertValue // ignore: cast_nullable_to_non_nullable
                      as int?,
            starRating: freezed == starRating
                ? _value.starRating
                : starRating // ignore: cast_nullable_to_non_nullable
                      as int?,
            selectedTags: freezed == selectedTags
                ? _value.selectedTags
                : selectedTags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            sliderValue: freezed == sliderValue
                ? _value.sliderValue
                : sliderValue // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$SurveyResponseImplCopyWith<$Res>
    implements $SurveyResponseCopyWith<$Res> {
  factory _$$SurveyResponseImplCopyWith(
    _$SurveyResponseImpl value,
    $Res Function(_$SurveyResponseImpl) then,
  ) = __$$SurveyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    String questionType,
    DateTime answeredAt,
    String? selectedOption,
    List<String>? selectedOptions,
    List<String>? textResponses,
    int? likertValue,
    int? starRating,
    List<String>? selectedTags,
    double? sliderValue,
    bool? isCorrect,
  });
}

/// @nodoc
class __$$SurveyResponseImplCopyWithImpl<$Res>
    extends _$SurveyResponseCopyWithImpl<$Res, _$SurveyResponseImpl>
    implements _$$SurveyResponseImplCopyWith<$Res> {
  __$$SurveyResponseImplCopyWithImpl(
    _$SurveyResponseImpl _value,
    $Res Function(_$SurveyResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? questionType = null,
    Object? answeredAt = null,
    Object? selectedOption = freezed,
    Object? selectedOptions = freezed,
    Object? textResponses = freezed,
    Object? likertValue = freezed,
    Object? starRating = freezed,
    Object? selectedTags = freezed,
    Object? sliderValue = freezed,
    Object? isCorrect = freezed,
  }) {
    return _then(
      _$SurveyResponseImpl(
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionType: null == questionType
            ? _value.questionType
            : questionType // ignore: cast_nullable_to_non_nullable
                  as String,
        answeredAt: null == answeredAt
            ? _value.answeredAt
            : answeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        selectedOption: freezed == selectedOption
            ? _value.selectedOption
            : selectedOption // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedOptions: freezed == selectedOptions
            ? _value._selectedOptions
            : selectedOptions // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        textResponses: freezed == textResponses
            ? _value._textResponses
            : textResponses // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        likertValue: freezed == likertValue
            ? _value.likertValue
            : likertValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        starRating: freezed == starRating
            ? _value.starRating
            : starRating // ignore: cast_nullable_to_non_nullable
                  as int?,
        selectedTags: freezed == selectedTags
            ? _value._selectedTags
            : selectedTags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        sliderValue: freezed == sliderValue
            ? _value.sliderValue
            : sliderValue // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$SurveyResponseImpl implements _SurveyResponse {
  const _$SurveyResponseImpl({
    required this.questionId,
    required this.questionType,
    required this.answeredAt,
    this.selectedOption,
    final List<String>? selectedOptions,
    final List<String>? textResponses,
    this.likertValue,
    this.starRating,
    final List<String>? selectedTags,
    this.sliderValue,
    this.isCorrect,
  }) : _selectedOptions = selectedOptions,
       _textResponses = textResponses,
       _selectedTags = selectedTags;

  factory _$SurveyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyResponseImplFromJson(json);

  @override
  final String questionId;
  @override
  final String questionType;
  @override
  final DateTime answeredAt;
  // single_select
  @override
  final String? selectedOption;
  // multi_select
  final List<String>? _selectedOptions;
  // multi_select
  @override
  List<String>? get selectedOptions {
    final value = _selectedOptions;
    if (value == null) return null;
    if (_selectedOptions is EqualUnmodifiableListView) return _selectedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // text_input
  final List<String>? _textResponses;
  // text_input
  @override
  List<String>? get textResponses {
    final value = _textResponses;
    if (value == null) return null;
    if (_textResponses is EqualUnmodifiableListView) return _textResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // likert
  @override
  final int? likertValue;
  // star_tags
  @override
  final int? starRating;
  final List<String>? _selectedTags;
  @override
  List<String>? get selectedTags {
    final value = _selectedTags;
    if (value == null) return null;
    if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // slider
  @override
  final double? sliderValue;
  // attention check result
  @override
  final bool? isCorrect;

  @override
  String toString() {
    return 'SurveyResponse(questionId: $questionId, questionType: $questionType, answeredAt: $answeredAt, selectedOption: $selectedOption, selectedOptions: $selectedOptions, textResponses: $textResponses, likertValue: $likertValue, starRating: $starRating, selectedTags: $selectedTags, sliderValue: $sliderValue, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyResponseImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption) &&
            const DeepCollectionEquality().equals(
              other._selectedOptions,
              _selectedOptions,
            ) &&
            const DeepCollectionEquality().equals(
              other._textResponses,
              _textResponses,
            ) &&
            (identical(other.likertValue, likertValue) ||
                other.likertValue == likertValue) &&
            (identical(other.starRating, starRating) ||
                other.starRating == starRating) &&
            const DeepCollectionEquality().equals(
              other._selectedTags,
              _selectedTags,
            ) &&
            (identical(other.sliderValue, sliderValue) ||
                other.sliderValue == sliderValue) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    questionType,
    answeredAt,
    selectedOption,
    const DeepCollectionEquality().hash(_selectedOptions),
    const DeepCollectionEquality().hash(_textResponses),
    likertValue,
    starRating,
    const DeepCollectionEquality().hash(_selectedTags),
    sliderValue,
    isCorrect,
  );

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyResponseImplCopyWith<_$SurveyResponseImpl> get copyWith =>
      __$$SurveyResponseImplCopyWithImpl<_$SurveyResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyResponseImplToJson(this);
  }
}

abstract class _SurveyResponse implements SurveyResponse {
  const factory _SurveyResponse({
    required final String questionId,
    required final String questionType,
    required final DateTime answeredAt,
    final String? selectedOption,
    final List<String>? selectedOptions,
    final List<String>? textResponses,
    final int? likertValue,
    final int? starRating,
    final List<String>? selectedTags,
    final double? sliderValue,
    final bool? isCorrect,
  }) = _$SurveyResponseImpl;

  factory _SurveyResponse.fromJson(Map<String, dynamic> json) =
      _$SurveyResponseImpl.fromJson;

  @override
  String get questionId;
  @override
  String get questionType;
  @override
  DateTime get answeredAt; // single_select
  @override
  String? get selectedOption; // multi_select
  @override
  List<String>? get selectedOptions; // text_input
  @override
  List<String>? get textResponses; // likert
  @override
  int? get likertValue; // star_tags
  @override
  int? get starRating;
  @override
  List<String>? get selectedTags; // slider
  @override
  double? get sliderValue; // attention check result
  @override
  bool? get isCorrect;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyResponseImplCopyWith<_$SurveyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
