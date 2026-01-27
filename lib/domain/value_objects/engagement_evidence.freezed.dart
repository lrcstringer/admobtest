// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement_evidence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EngagementEvidence _$EngagementEvidenceFromJson(Map<String, dynamic> json) {
  return _EngagementEvidence.fromJson(json);
}

/// @nodoc
mixin _$EngagementEvidence {
  /// Device fingerprint hash
  String get deviceFingerprint => throw _privateConstructorUsedError;

  /// Play Integrity token (Android) or Device Check token (iOS)
  String? get integrityToken => throw _privateConstructorUsedError;

  /// Watch duration in milliseconds
  int get watchDurationMs => throw _privateConstructorUsedError;

  /// Video seeked (indicates skipping)
  bool get videoSeeked => throw _privateConstructorUsedError;

  /// Screen was visible during watch
  bool get screenVisible => throw _privateConstructorUsedError;

  /// App was in foreground
  bool get appInForeground => throw _privateConstructorUsedError;

  /// Response time for survey questions (ms per question)
  List<int> get surveyResponseTimesMs => throw _privateConstructorUsedError;

  /// Timestamp when video playback started
  DateTime get videoStartedAt => throw _privateConstructorUsedError;

  /// Timestamp when survey was submitted
  DateTime get surveySubmittedAt => throw _privateConstructorUsedError;

  /// Client-side calculated attention score (0-100)
  double? get clientAttentionScore => throw _privateConstructorUsedError;

  /// Serializes this EngagementEvidence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EngagementEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementEvidenceCopyWith<EngagementEvidence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementEvidenceCopyWith<$Res> {
  factory $EngagementEvidenceCopyWith(
    EngagementEvidence value,
    $Res Function(EngagementEvidence) then,
  ) = _$EngagementEvidenceCopyWithImpl<$Res, EngagementEvidence>;
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
class _$EngagementEvidenceCopyWithImpl<$Res, $Val extends EngagementEvidence>
    implements $EngagementEvidenceCopyWith<$Res> {
  _$EngagementEvidenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementEvidence
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
abstract class _$$EngagementEvidenceImplCopyWith<$Res>
    implements $EngagementEvidenceCopyWith<$Res> {
  factory _$$EngagementEvidenceImplCopyWith(
    _$EngagementEvidenceImpl value,
    $Res Function(_$EngagementEvidenceImpl) then,
  ) = __$$EngagementEvidenceImplCopyWithImpl<$Res>;
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
class __$$EngagementEvidenceImplCopyWithImpl<$Res>
    extends _$EngagementEvidenceCopyWithImpl<$Res, _$EngagementEvidenceImpl>
    implements _$$EngagementEvidenceImplCopyWith<$Res> {
  __$$EngagementEvidenceImplCopyWithImpl(
    _$EngagementEvidenceImpl _value,
    $Res Function(_$EngagementEvidenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementEvidence
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
      _$EngagementEvidenceImpl(
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
@JsonSerializable()
class _$EngagementEvidenceImpl extends _EngagementEvidence {
  const _$EngagementEvidenceImpl({
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

  factory _$EngagementEvidenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$EngagementEvidenceImplFromJson(json);

  /// Device fingerprint hash
  @override
  final String deviceFingerprint;

  /// Play Integrity token (Android) or Device Check token (iOS)
  @override
  final String? integrityToken;

  /// Watch duration in milliseconds
  @override
  final int watchDurationMs;

  /// Video seeked (indicates skipping)
  @override
  final bool videoSeeked;

  /// Screen was visible during watch
  @override
  final bool screenVisible;

  /// App was in foreground
  @override
  final bool appInForeground;

  /// Response time for survey questions (ms per question)
  final List<int> _surveyResponseTimesMs;

  /// Response time for survey questions (ms per question)
  @override
  List<int> get surveyResponseTimesMs {
    if (_surveyResponseTimesMs is EqualUnmodifiableListView)
      return _surveyResponseTimesMs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_surveyResponseTimesMs);
  }

  /// Timestamp when video playback started
  @override
  final DateTime videoStartedAt;

  /// Timestamp when survey was submitted
  @override
  final DateTime surveySubmittedAt;

  /// Client-side calculated attention score (0-100)
  @override
  final double? clientAttentionScore;

  @override
  String toString() {
    return 'EngagementEvidence(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementEvidenceImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of EngagementEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementEvidenceImplCopyWith<_$EngagementEvidenceImpl> get copyWith =>
      __$$EngagementEvidenceImplCopyWithImpl<_$EngagementEvidenceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EngagementEvidenceImplToJson(this);
  }
}

abstract class _EngagementEvidence extends EngagementEvidence {
  const factory _EngagementEvidence({
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
  }) = _$EngagementEvidenceImpl;
  const _EngagementEvidence._() : super._();

  factory _EngagementEvidence.fromJson(Map<String, dynamic> json) =
      _$EngagementEvidenceImpl.fromJson;

  /// Device fingerprint hash
  @override
  String get deviceFingerprint;

  /// Play Integrity token (Android) or Device Check token (iOS)
  @override
  String? get integrityToken;

  /// Watch duration in milliseconds
  @override
  int get watchDurationMs;

  /// Video seeked (indicates skipping)
  @override
  bool get videoSeeked;

  /// Screen was visible during watch
  @override
  bool get screenVisible;

  /// App was in foreground
  @override
  bool get appInForeground;

  /// Response time for survey questions (ms per question)
  @override
  List<int> get surveyResponseTimesMs;

  /// Timestamp when video playback started
  @override
  DateTime get videoStartedAt;

  /// Timestamp when survey was submitted
  @override
  DateTime get surveySubmittedAt;

  /// Client-side calculated attention score (0-100)
  @override
  double? get clientAttentionScore;

  /// Create a copy of EngagementEvidence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementEvidenceImplCopyWith<_$EngagementEvidenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
