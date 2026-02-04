// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EngagementAnswerModel {
  String get questionId => throw _privateConstructorUsedError;
  String get selectedOption => throw _privateConstructorUsedError;
  DateTime get answeredAt => throw _privateConstructorUsedError;
  bool? get isCorrect => throw _privateConstructorUsedError;

  /// Create a copy of EngagementAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementAnswerModelCopyWith<EngagementAnswerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementAnswerModelCopyWith<$Res> {
  factory $EngagementAnswerModelCopyWith(
    EngagementAnswerModel value,
    $Res Function(EngagementAnswerModel) then,
  ) = _$EngagementAnswerModelCopyWithImpl<$Res, EngagementAnswerModel>;
  @useResult
  $Res call({
    String questionId,
    String selectedOption,
    DateTime answeredAt,
    bool? isCorrect,
  });
}

/// @nodoc
class _$EngagementAnswerModelCopyWithImpl<
  $Res,
  $Val extends EngagementAnswerModel
>
    implements $EngagementAnswerModelCopyWith<$Res> {
  _$EngagementAnswerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementAnswerModel
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
abstract class _$$EngagementAnswerModelImplCopyWith<$Res>
    implements $EngagementAnswerModelCopyWith<$Res> {
  factory _$$EngagementAnswerModelImplCopyWith(
    _$EngagementAnswerModelImpl value,
    $Res Function(_$EngagementAnswerModelImpl) then,
  ) = __$$EngagementAnswerModelImplCopyWithImpl<$Res>;
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
class __$$EngagementAnswerModelImplCopyWithImpl<$Res>
    extends
        _$EngagementAnswerModelCopyWithImpl<$Res, _$EngagementAnswerModelImpl>
    implements _$$EngagementAnswerModelImplCopyWith<$Res> {
  __$$EngagementAnswerModelImplCopyWithImpl(
    _$EngagementAnswerModelImpl _value,
    $Res Function(_$EngagementAnswerModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementAnswerModel
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
      _$EngagementAnswerModelImpl(
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

class _$EngagementAnswerModelImpl extends _EngagementAnswerModel {
  const _$EngagementAnswerModelImpl({
    required this.questionId,
    required this.selectedOption,
    required this.answeredAt,
    this.isCorrect,
  }) : super._();

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
    return 'EngagementAnswerModel(questionId: $questionId, selectedOption: $selectedOption, answeredAt: $answeredAt, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementAnswerModelImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOption, selectedOption) ||
                other.selectedOption == selectedOption) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    selectedOption,
    answeredAt,
    isCorrect,
  );

  /// Create a copy of EngagementAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementAnswerModelImplCopyWith<_$EngagementAnswerModelImpl>
  get copyWith =>
      __$$EngagementAnswerModelImplCopyWithImpl<_$EngagementAnswerModelImpl>(
        this,
        _$identity,
      );
}

abstract class _EngagementAnswerModel extends EngagementAnswerModel {
  const factory _EngagementAnswerModel({
    required final String questionId,
    required final String selectedOption,
    required final DateTime answeredAt,
    final bool? isCorrect,
  }) = _$EngagementAnswerModelImpl;
  const _EngagementAnswerModel._() : super._();

  @override
  String get questionId;
  @override
  String get selectedOption;
  @override
  DateTime get answeredAt;
  @override
  bool? get isCorrect;

  /// Create a copy of EngagementAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementAnswerModelImplCopyWith<_$EngagementAnswerModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EngagementEvidenceModel {
  String get deviceFingerprint => throw _privateConstructorUsedError;
  String? get integrityToken => throw _privateConstructorUsedError;
  int get watchDurationMs => throw _privateConstructorUsedError;
  bool get videoSeeked => throw _privateConstructorUsedError;
  bool get screenVisible => throw _privateConstructorUsedError;
  bool get appInForeground => throw _privateConstructorUsedError;
  List<int> get surveyResponseTimesMs => throw _privateConstructorUsedError;
  DateTime get videoStartedAt => throw _privateConstructorUsedError;
  DateTime get surveySubmittedAt => throw _privateConstructorUsedError;
  double? get clientAttentionScore => throw _privateConstructorUsedError;

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementEvidenceModelCopyWith<EngagementEvidenceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementEvidenceModelCopyWith<$Res> {
  factory $EngagementEvidenceModelCopyWith(
    EngagementEvidenceModel value,
    $Res Function(EngagementEvidenceModel) then,
  ) = _$EngagementEvidenceModelCopyWithImpl<$Res, EngagementEvidenceModel>;
  @useResult
  $Res call({
    String deviceFingerprint,
    String? integrityToken,
    int watchDurationMs,
    bool videoSeeked,
    bool screenVisible,
    bool appInForeground,
    List<int> surveyResponseTimesMs,
    DateTime videoStartedAt,
    DateTime surveySubmittedAt,
    double? clientAttentionScore,
  });
}

/// @nodoc
class _$EngagementEvidenceModelCopyWithImpl<
  $Res,
  $Val extends EngagementEvidenceModel
>
    implements $EngagementEvidenceModelCopyWith<$Res> {
  _$EngagementEvidenceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceFingerprint = null,
    Object? integrityToken = freezed,
    Object? watchDurationMs = null,
    Object? videoSeeked = null,
    Object? screenVisible = null,
    Object? appInForeground = null,
    Object? surveyResponseTimesMs = null,
    Object? videoStartedAt = null,
    Object? surveySubmittedAt = null,
    Object? clientAttentionScore = freezed,
  }) {
    return _then(
      _value.copyWith(
            deviceFingerprint: null == deviceFingerprint
                ? _value.deviceFingerprint
                : deviceFingerprint // ignore: cast_nullable_to_non_nullable
                      as String,
            integrityToken: freezed == integrityToken
                ? _value.integrityToken
                : integrityToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            watchDurationMs: null == watchDurationMs
                ? _value.watchDurationMs
                : watchDurationMs // ignore: cast_nullable_to_non_nullable
                      as int,
            videoSeeked: null == videoSeeked
                ? _value.videoSeeked
                : videoSeeked // ignore: cast_nullable_to_non_nullable
                      as bool,
            screenVisible: null == screenVisible
                ? _value.screenVisible
                : screenVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            appInForeground: null == appInForeground
                ? _value.appInForeground
                : appInForeground // ignore: cast_nullable_to_non_nullable
                      as bool,
            surveyResponseTimesMs: null == surveyResponseTimesMs
                ? _value.surveyResponseTimesMs
                : surveyResponseTimesMs // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            videoStartedAt: null == videoStartedAt
                ? _value.videoStartedAt
                : videoStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            surveySubmittedAt: null == surveySubmittedAt
                ? _value.surveySubmittedAt
                : surveySubmittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            clientAttentionScore: freezed == clientAttentionScore
                ? _value.clientAttentionScore
                : clientAttentionScore // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EngagementEvidenceModelImplCopyWith<$Res>
    implements $EngagementEvidenceModelCopyWith<$Res> {
  factory _$$EngagementEvidenceModelImplCopyWith(
    _$EngagementEvidenceModelImpl value,
    $Res Function(_$EngagementEvidenceModelImpl) then,
  ) = __$$EngagementEvidenceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String deviceFingerprint,
    String? integrityToken,
    int watchDurationMs,
    bool videoSeeked,
    bool screenVisible,
    bool appInForeground,
    List<int> surveyResponseTimesMs,
    DateTime videoStartedAt,
    DateTime surveySubmittedAt,
    double? clientAttentionScore,
  });
}

/// @nodoc
class __$$EngagementEvidenceModelImplCopyWithImpl<$Res>
    extends
        _$EngagementEvidenceModelCopyWithImpl<
          $Res,
          _$EngagementEvidenceModelImpl
        >
    implements _$$EngagementEvidenceModelImplCopyWith<$Res> {
  __$$EngagementEvidenceModelImplCopyWithImpl(
    _$EngagementEvidenceModelImpl _value,
    $Res Function(_$EngagementEvidenceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceFingerprint = null,
    Object? integrityToken = freezed,
    Object? watchDurationMs = null,
    Object? videoSeeked = null,
    Object? screenVisible = null,
    Object? appInForeground = null,
    Object? surveyResponseTimesMs = null,
    Object? videoStartedAt = null,
    Object? surveySubmittedAt = null,
    Object? clientAttentionScore = freezed,
  }) {
    return _then(
      _$EngagementEvidenceModelImpl(
        deviceFingerprint: null == deviceFingerprint
            ? _value.deviceFingerprint
            : deviceFingerprint // ignore: cast_nullable_to_non_nullable
                  as String,
        integrityToken: freezed == integrityToken
            ? _value.integrityToken
            : integrityToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        watchDurationMs: null == watchDurationMs
            ? _value.watchDurationMs
            : watchDurationMs // ignore: cast_nullable_to_non_nullable
                  as int,
        videoSeeked: null == videoSeeked
            ? _value.videoSeeked
            : videoSeeked // ignore: cast_nullable_to_non_nullable
                  as bool,
        screenVisible: null == screenVisible
            ? _value.screenVisible
            : screenVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        appInForeground: null == appInForeground
            ? _value.appInForeground
            : appInForeground // ignore: cast_nullable_to_non_nullable
                  as bool,
        surveyResponseTimesMs: null == surveyResponseTimesMs
            ? _value._surveyResponseTimesMs
            : surveyResponseTimesMs // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        videoStartedAt: null == videoStartedAt
            ? _value.videoStartedAt
            : videoStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        surveySubmittedAt: null == surveySubmittedAt
            ? _value.surveySubmittedAt
            : surveySubmittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        clientAttentionScore: freezed == clientAttentionScore
            ? _value.clientAttentionScore
            : clientAttentionScore // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$EngagementEvidenceModelImpl extends _EngagementEvidenceModel {
  const _$EngagementEvidenceModelImpl({
    required this.deviceFingerprint,
    this.integrityToken,
    required this.watchDurationMs,
    required this.videoSeeked,
    required this.screenVisible,
    required this.appInForeground,
    required final List<int> surveyResponseTimesMs,
    required this.videoStartedAt,
    required this.surveySubmittedAt,
    this.clientAttentionScore,
  }) : _surveyResponseTimesMs = surveyResponseTimesMs,
       super._();

  @override
  final String deviceFingerprint;
  @override
  final String? integrityToken;
  @override
  final int watchDurationMs;
  @override
  final bool videoSeeked;
  @override
  final bool screenVisible;
  @override
  final bool appInForeground;
  final List<int> _surveyResponseTimesMs;
  @override
  List<int> get surveyResponseTimesMs {
    if (_surveyResponseTimesMs is EqualUnmodifiableListView)
      return _surveyResponseTimesMs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_surveyResponseTimesMs);
  }

  @override
  final DateTime videoStartedAt;
  @override
  final DateTime surveySubmittedAt;
  @override
  final double? clientAttentionScore;

  @override
  String toString() {
    return 'EngagementEvidenceModel(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementEvidenceModelImpl &&
            (identical(other.deviceFingerprint, deviceFingerprint) ||
                other.deviceFingerprint == deviceFingerprint) &&
            (identical(other.integrityToken, integrityToken) ||
                other.integrityToken == integrityToken) &&
            (identical(other.watchDurationMs, watchDurationMs) ||
                other.watchDurationMs == watchDurationMs) &&
            (identical(other.videoSeeked, videoSeeked) ||
                other.videoSeeked == videoSeeked) &&
            (identical(other.screenVisible, screenVisible) ||
                other.screenVisible == screenVisible) &&
            (identical(other.appInForeground, appInForeground) ||
                other.appInForeground == appInForeground) &&
            const DeepCollectionEquality().equals(
              other._surveyResponseTimesMs,
              _surveyResponseTimesMs,
            ) &&
            (identical(other.videoStartedAt, videoStartedAt) ||
                other.videoStartedAt == videoStartedAt) &&
            (identical(other.surveySubmittedAt, surveySubmittedAt) ||
                other.surveySubmittedAt == surveySubmittedAt) &&
            (identical(other.clientAttentionScore, clientAttentionScore) ||
                other.clientAttentionScore == clientAttentionScore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    deviceFingerprint,
    integrityToken,
    watchDurationMs,
    videoSeeked,
    screenVisible,
    appInForeground,
    const DeepCollectionEquality().hash(_surveyResponseTimesMs),
    videoStartedAt,
    surveySubmittedAt,
    clientAttentionScore,
  );

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementEvidenceModelImplCopyWith<_$EngagementEvidenceModelImpl>
  get copyWith =>
      __$$EngagementEvidenceModelImplCopyWithImpl<
        _$EngagementEvidenceModelImpl
      >(this, _$identity);
}

abstract class _EngagementEvidenceModel extends EngagementEvidenceModel {
  const factory _EngagementEvidenceModel({
    required final String deviceFingerprint,
    final String? integrityToken,
    required final int watchDurationMs,
    required final bool videoSeeked,
    required final bool screenVisible,
    required final bool appInForeground,
    required final List<int> surveyResponseTimesMs,
    required final DateTime videoStartedAt,
    required final DateTime surveySubmittedAt,
    final double? clientAttentionScore,
  }) = _$EngagementEvidenceModelImpl;
  const _EngagementEvidenceModel._() : super._();

  @override
  String get deviceFingerprint;
  @override
  String? get integrityToken;
  @override
  int get watchDurationMs;
  @override
  bool get videoSeeked;
  @override
  bool get screenVisible;
  @override
  bool get appInForeground;
  @override
  List<int> get surveyResponseTimesMs;
  @override
  DateTime get videoStartedAt;
  @override
  DateTime get surveySubmittedAt;
  @override
  double? get clientAttentionScore;

  /// Create a copy of EngagementEvidenceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementEvidenceModelImplCopyWith<_$EngagementEvidenceModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EngagementModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get oddienceCampaignId => throw _privateConstructorUsedError;
  String get earnOpportunityId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get watchDurationSeconds => throw _privateConstructorUsedError;
  int get requiredDurationSeconds => throw _privateConstructorUsedError;
  List<EngagementAnswerModel> get answers => throw _privateConstructorUsedError;
  EngagementEvidenceModel? get evidence => throw _privateConstructorUsedError;
  int? get tokensEarned => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  int get attemptNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Streak audit fields
  int? get streakDayAtCompletion => throw _privateConstructorUsedError;
  double? get multiplierApplied => throw _privateConstructorUsedError;

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementModelCopyWith<EngagementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementModelCopyWith<$Res> {
  factory $EngagementModelCopyWith(
    EngagementModel value,
    $Res Function(EngagementModel) then,
  ) = _$EngagementModelCopyWithImpl<$Res, EngagementModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String oddienceCampaignId,
    String earnOpportunityId,
    String status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<EngagementAnswerModel> answers,
    EngagementEvidenceModel? evidence,
    int? tokensEarned,
    String? failureReason,
    int attemptNumber,
    DateTime createdAt,
    DateTime? updatedAt,
    int? streakDayAtCompletion,
    double? multiplierApplied,
  });

  $EngagementEvidenceModelCopyWith<$Res>? get evidence;
}

/// @nodoc
class _$EngagementModelCopyWithImpl<$Res, $Val extends EngagementModel>
    implements $EngagementModelCopyWith<$Res> {
  _$EngagementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementModel
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
    Object? streakDayAtCompletion = freezed,
    Object? multiplierApplied = freezed,
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
                      as String,
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
                      as List<EngagementAnswerModel>,
            evidence: freezed == evidence
                ? _value.evidence
                : evidence // ignore: cast_nullable_to_non_nullable
                      as EngagementEvidenceModel?,
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
            streakDayAtCompletion: freezed == streakDayAtCompletion
                ? _value.streakDayAtCompletion
                : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
                      as int?,
            multiplierApplied: freezed == multiplierApplied
                ? _value.multiplierApplied
                : multiplierApplied // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EngagementEvidenceModelCopyWith<$Res>? get evidence {
    if (_value.evidence == null) {
      return null;
    }

    return $EngagementEvidenceModelCopyWith<$Res>(_value.evidence!, (value) {
      return _then(_value.copyWith(evidence: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EngagementModelImplCopyWith<$Res>
    implements $EngagementModelCopyWith<$Res> {
  factory _$$EngagementModelImplCopyWith(
    _$EngagementModelImpl value,
    $Res Function(_$EngagementModelImpl) then,
  ) = __$$EngagementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String oddienceCampaignId,
    String earnOpportunityId,
    String status,
    DateTime startedAt,
    DateTime? completedAt,
    int watchDurationSeconds,
    int requiredDurationSeconds,
    List<EngagementAnswerModel> answers,
    EngagementEvidenceModel? evidence,
    int? tokensEarned,
    String? failureReason,
    int attemptNumber,
    DateTime createdAt,
    DateTime? updatedAt,
    int? streakDayAtCompletion,
    double? multiplierApplied,
  });

  @override
  $EngagementEvidenceModelCopyWith<$Res>? get evidence;
}

/// @nodoc
class __$$EngagementModelImplCopyWithImpl<$Res>
    extends _$EngagementModelCopyWithImpl<$Res, _$EngagementModelImpl>
    implements _$$EngagementModelImplCopyWith<$Res> {
  __$$EngagementModelImplCopyWithImpl(
    _$EngagementModelImpl _value,
    $Res Function(_$EngagementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementModel
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
    Object? streakDayAtCompletion = freezed,
    Object? multiplierApplied = freezed,
  }) {
    return _then(
      _$EngagementModelImpl(
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
                  as String,
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
                  as List<EngagementAnswerModel>,
        evidence: freezed == evidence
            ? _value.evidence
            : evidence // ignore: cast_nullable_to_non_nullable
                  as EngagementEvidenceModel?,
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
        streakDayAtCompletion: freezed == streakDayAtCompletion
            ? _value.streakDayAtCompletion
            : streakDayAtCompletion // ignore: cast_nullable_to_non_nullable
                  as int?,
        multiplierApplied: freezed == multiplierApplied
            ? _value.multiplierApplied
            : multiplierApplied // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$EngagementModelImpl extends _EngagementModel {
  const _$EngagementModelImpl({
    required this.id,
    required this.userId,
    required this.oddienceCampaignId,
    required this.earnOpportunityId,
    required this.status,
    required this.startedAt,
    this.completedAt,
    required this.watchDurationSeconds,
    required this.requiredDurationSeconds,
    required final List<EngagementAnswerModel> answers,
    this.evidence,
    this.tokensEarned,
    this.failureReason,
    required this.attemptNumber,
    required this.createdAt,
    this.updatedAt,
    this.streakDayAtCompletion,
    this.multiplierApplied,
  }) : _answers = answers,
       super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String oddienceCampaignId;
  @override
  final String earnOpportunityId;
  @override
  final String status;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int watchDurationSeconds;
  @override
  final int requiredDurationSeconds;
  final List<EngagementAnswerModel> _answers;
  @override
  List<EngagementAnswerModel> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final EngagementEvidenceModel? evidence;
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
  // Streak audit fields
  @override
  final int? streakDayAtCompletion;
  @override
  final double? multiplierApplied;

  @override
  String toString() {
    return 'EngagementModel(id: $id, userId: $userId, oddienceCampaignId: $oddienceCampaignId, earnOpportunityId: $earnOpportunityId, status: $status, startedAt: $startedAt, completedAt: $completedAt, watchDurationSeconds: $watchDurationSeconds, requiredDurationSeconds: $requiredDurationSeconds, answers: $answers, evidence: $evidence, tokensEarned: $tokensEarned, failureReason: $failureReason, attemptNumber: $attemptNumber, createdAt: $createdAt, updatedAt: $updatedAt, streakDayAtCompletion: $streakDayAtCompletion, multiplierApplied: $multiplierApplied)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementModelImpl &&
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
            (identical(other.streakDayAtCompletion, streakDayAtCompletion) ||
                other.streakDayAtCompletion == streakDayAtCompletion) &&
            (identical(other.multiplierApplied, multiplierApplied) ||
                other.multiplierApplied == multiplierApplied));
  }

  @override
  int get hashCode => Object.hash(
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
    streakDayAtCompletion,
    multiplierApplied,
  );

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementModelImplCopyWith<_$EngagementModelImpl> get copyWith =>
      __$$EngagementModelImplCopyWithImpl<_$EngagementModelImpl>(
        this,
        _$identity,
      );
}

abstract class _EngagementModel extends EngagementModel {
  const factory _EngagementModel({
    required final String id,
    required final String userId,
    required final String oddienceCampaignId,
    required final String earnOpportunityId,
    required final String status,
    required final DateTime startedAt,
    final DateTime? completedAt,
    required final int watchDurationSeconds,
    required final int requiredDurationSeconds,
    required final List<EngagementAnswerModel> answers,
    final EngagementEvidenceModel? evidence,
    final int? tokensEarned,
    final String? failureReason,
    required final int attemptNumber,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final int? streakDayAtCompletion,
    final double? multiplierApplied,
  }) = _$EngagementModelImpl;
  const _EngagementModel._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get oddienceCampaignId;
  @override
  String get earnOpportunityId;
  @override
  String get status;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  int get watchDurationSeconds;
  @override
  int get requiredDurationSeconds;
  @override
  List<EngagementAnswerModel> get answers;
  @override
  EngagementEvidenceModel? get evidence;
  @override
  int? get tokensEarned;
  @override
  String? get failureReason;
  @override
  int get attemptNumber;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt; // Streak audit fields
  @override
  int? get streakDayAtCompletion;
  @override
  double? get multiplierApplied;

  /// Create a copy of EngagementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementModelImplCopyWith<_$EngagementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
