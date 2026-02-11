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

UploadedFileEvidence _$UploadedFileEvidenceFromJson(Map<String, dynamic> json) {
  return _UploadedFileEvidence.fromJson(json);
}

/// @nodoc
mixin _$UploadedFileEvidence {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; // 'video' or 'image'
  int get sizeBytes => throw _privateConstructorUsedError;
  String? get mimeType => throw _privateConstructorUsedError;
  int? get durationSeconds => throw _privateConstructorUsedError; // video only
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  /// Serializes this UploadedFileEvidence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UploadedFileEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UploadedFileEvidenceCopyWith<UploadedFileEvidence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadedFileEvidenceCopyWith<$Res> {
  factory $UploadedFileEvidenceCopyWith(
    UploadedFileEvidence value,
    $Res Function(UploadedFileEvidence) then,
  ) = _$UploadedFileEvidenceCopyWithImpl<$Res, UploadedFileEvidence>;
  @useResult
  $Res call({
    String url,
    String type,
    int sizeBytes,
    String? mimeType,
    int? durationSeconds,
    int? width,
    int? height,
  });
}

/// @nodoc
class _$UploadedFileEvidenceCopyWithImpl<
  $Res,
  $Val extends UploadedFileEvidence
>
    implements $UploadedFileEvidenceCopyWith<$Res> {
  _$UploadedFileEvidenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UploadedFileEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? sizeBytes = null,
    Object? mimeType = freezed,
    Object? durationSeconds = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            sizeBytes: null == sizeBytes
                ? _value.sizeBytes
                : sizeBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            mimeType: freezed == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationSeconds: freezed == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            width: freezed == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int?,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UploadedFileEvidenceImplCopyWith<$Res>
    implements $UploadedFileEvidenceCopyWith<$Res> {
  factory _$$UploadedFileEvidenceImplCopyWith(
    _$UploadedFileEvidenceImpl value,
    $Res Function(_$UploadedFileEvidenceImpl) then,
  ) = __$$UploadedFileEvidenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String url,
    String type,
    int sizeBytes,
    String? mimeType,
    int? durationSeconds,
    int? width,
    int? height,
  });
}

/// @nodoc
class __$$UploadedFileEvidenceImplCopyWithImpl<$Res>
    extends _$UploadedFileEvidenceCopyWithImpl<$Res, _$UploadedFileEvidenceImpl>
    implements _$$UploadedFileEvidenceImplCopyWith<$Res> {
  __$$UploadedFileEvidenceImplCopyWithImpl(
    _$UploadedFileEvidenceImpl _value,
    $Res Function(_$UploadedFileEvidenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UploadedFileEvidence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? sizeBytes = null,
    Object? mimeType = freezed,
    Object? durationSeconds = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(
      _$UploadedFileEvidenceImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _value.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        mimeType: freezed == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationSeconds: freezed == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        width: freezed == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UploadedFileEvidenceImpl implements _UploadedFileEvidence {
  const _$UploadedFileEvidenceImpl({
    required this.url,
    required this.type,
    required this.sizeBytes,
    this.mimeType,
    this.durationSeconds,
    this.width,
    this.height,
  });

  factory _$UploadedFileEvidenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$UploadedFileEvidenceImplFromJson(json);

  @override
  final String url;
  @override
  final String type;
  // 'video' or 'image'
  @override
  final int sizeBytes;
  @override
  final String? mimeType;
  @override
  final int? durationSeconds;
  // video only
  @override
  final int? width;
  @override
  final int? height;

  @override
  String toString() {
    return 'UploadedFileEvidence(url: $url, type: $type, sizeBytes: $sizeBytes, mimeType: $mimeType, durationSeconds: $durationSeconds, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadedFileEvidenceImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    url,
    type,
    sizeBytes,
    mimeType,
    durationSeconds,
    width,
    height,
  );

  /// Create a copy of UploadedFileEvidence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadedFileEvidenceImplCopyWith<_$UploadedFileEvidenceImpl>
  get copyWith =>
      __$$UploadedFileEvidenceImplCopyWithImpl<_$UploadedFileEvidenceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UploadedFileEvidenceImplToJson(this);
  }
}

abstract class _UploadedFileEvidence implements UploadedFileEvidence {
  const factory _UploadedFileEvidence({
    required final String url,
    required final String type,
    required final int sizeBytes,
    final String? mimeType,
    final int? durationSeconds,
    final int? width,
    final int? height,
  }) = _$UploadedFileEvidenceImpl;

  factory _UploadedFileEvidence.fromJson(Map<String, dynamic> json) =
      _$UploadedFileEvidenceImpl.fromJson;

  @override
  String get url;
  @override
  String get type; // 'video' or 'image'
  @override
  int get sizeBytes;
  @override
  String? get mimeType;
  @override
  int? get durationSeconds; // video only
  @override
  int? get width;
  @override
  int? get height;

  /// Create a copy of UploadedFileEvidence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadedFileEvidenceImplCopyWith<_$UploadedFileEvidenceImpl>
  get copyWith => throw _privateConstructorUsedError;
}

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

  /// AdMob transaction ID for server-side verification
  String? get adTransactionId => throw _privateConstructorUsedError;

  /// Client-side flag indicating ad was fully watched
  bool? get adFullyWatched => throw _privateConstructorUsedError;

  /// AdMob response ID — uniquely identifies the ad impression for debugging
  String? get adResponseId => throw _privateConstructorUsedError;

  /// Upload evidence fields
  List<UploadedFileEvidence>? get uploadedFiles =>
      throw _privateConstructorUsedError;
  String? get uploadTextResponse => throw _privateConstructorUsedError;
  DateTime? get uploadStartedAt => throw _privateConstructorUsedError;
  DateTime? get uploadCompletedAt => throw _privateConstructorUsedError;

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
    String? adTransactionId,
    bool? adFullyWatched,
    String? adResponseId,
    List<UploadedFileEvidence>? uploadedFiles,
    String? uploadTextResponse,
    DateTime? uploadStartedAt,
    DateTime? uploadCompletedAt,
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
    Object? adTransactionId = freezed,
    Object? adFullyWatched = freezed,
    Object? adResponseId = freezed,
    Object? uploadedFiles = freezed,
    Object? uploadTextResponse = freezed,
    Object? uploadStartedAt = freezed,
    Object? uploadCompletedAt = freezed,
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
            adTransactionId: freezed == adTransactionId
                ? _value.adTransactionId
                : adTransactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            adFullyWatched: freezed == adFullyWatched
                ? _value.adFullyWatched
                : adFullyWatched // ignore: cast_nullable_to_non_nullable
                      as bool?,
            adResponseId: freezed == adResponseId
                ? _value.adResponseId
                : adResponseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadedFiles: freezed == uploadedFiles
                ? _value.uploadedFiles
                : uploadedFiles // ignore: cast_nullable_to_non_nullable
                      as List<UploadedFileEvidence>?,
            uploadTextResponse: freezed == uploadTextResponse
                ? _value.uploadTextResponse
                : uploadTextResponse // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadStartedAt: freezed == uploadStartedAt
                ? _value.uploadStartedAt
                : uploadStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            uploadCompletedAt: freezed == uploadCompletedAt
                ? _value.uploadCompletedAt
                : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
    String? adTransactionId,
    bool? adFullyWatched,
    String? adResponseId,
    List<UploadedFileEvidence>? uploadedFiles,
    String? uploadTextResponse,
    DateTime? uploadStartedAt,
    DateTime? uploadCompletedAt,
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
    Object? adTransactionId = freezed,
    Object? adFullyWatched = freezed,
    Object? adResponseId = freezed,
    Object? uploadedFiles = freezed,
    Object? uploadTextResponse = freezed,
    Object? uploadStartedAt = freezed,
    Object? uploadCompletedAt = freezed,
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
        adTransactionId: freezed == adTransactionId
            ? _value.adTransactionId
            : adTransactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        adFullyWatched: freezed == adFullyWatched
            ? _value.adFullyWatched
            : adFullyWatched // ignore: cast_nullable_to_non_nullable
                  as bool?,
        adResponseId: freezed == adResponseId
            ? _value.adResponseId
            : adResponseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadedFiles: freezed == uploadedFiles
            ? _value._uploadedFiles
            : uploadedFiles // ignore: cast_nullable_to_non_nullable
                  as List<UploadedFileEvidence>?,
        uploadTextResponse: freezed == uploadTextResponse
            ? _value.uploadTextResponse
            : uploadTextResponse // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadStartedAt: freezed == uploadStartedAt
            ? _value.uploadStartedAt
            : uploadStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        uploadCompletedAt: freezed == uploadCompletedAt
            ? _value.uploadCompletedAt
            : uploadCompletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
    this.adTransactionId,
    this.adFullyWatched,
    this.adResponseId,
    final List<UploadedFileEvidence>? uploadedFiles,
    this.uploadTextResponse,
    this.uploadStartedAt,
    this.uploadCompletedAt,
  }) : _surveyResponseTimesMs = surveyResponseTimesMs,
       _uploadedFiles = uploadedFiles,
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

  /// AdMob transaction ID for server-side verification
  @override
  final String? adTransactionId;

  /// Client-side flag indicating ad was fully watched
  @override
  final bool? adFullyWatched;

  /// AdMob response ID — uniquely identifies the ad impression for debugging
  @override
  final String? adResponseId;

  /// Upload evidence fields
  final List<UploadedFileEvidence>? _uploadedFiles;

  /// Upload evidence fields
  @override
  List<UploadedFileEvidence>? get uploadedFiles {
    final value = _uploadedFiles;
    if (value == null) return null;
    if (_uploadedFiles is EqualUnmodifiableListView) return _uploadedFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? uploadTextResponse;
  @override
  final DateTime? uploadStartedAt;
  @override
  final DateTime? uploadCompletedAt;

  @override
  String toString() {
    return 'EngagementEvidence(deviceFingerprint: $deviceFingerprint, integrityToken: $integrityToken, watchDurationMs: $watchDurationMs, videoSeeked: $videoSeeked, screenVisible: $screenVisible, appInForeground: $appInForeground, surveyResponseTimesMs: $surveyResponseTimesMs, videoStartedAt: $videoStartedAt, surveySubmittedAt: $surveySubmittedAt, clientAttentionScore: $clientAttentionScore, adTransactionId: $adTransactionId, adFullyWatched: $adFullyWatched, adResponseId: $adResponseId, uploadedFiles: $uploadedFiles, uploadTextResponse: $uploadTextResponse, uploadStartedAt: $uploadStartedAt, uploadCompletedAt: $uploadCompletedAt)';
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
                other.clientAttentionScore == clientAttentionScore) &&
            (identical(other.adTransactionId, adTransactionId) ||
                other.adTransactionId == adTransactionId) &&
            (identical(other.adFullyWatched, adFullyWatched) ||
                other.adFullyWatched == adFullyWatched) &&
            (identical(other.adResponseId, adResponseId) ||
                other.adResponseId == adResponseId) &&
            const DeepCollectionEquality().equals(
              other._uploadedFiles,
              _uploadedFiles,
            ) &&
            (identical(other.uploadTextResponse, uploadTextResponse) ||
                other.uploadTextResponse == uploadTextResponse) &&
            (identical(other.uploadStartedAt, uploadStartedAt) ||
                other.uploadStartedAt == uploadStartedAt) &&
            (identical(other.uploadCompletedAt, uploadCompletedAt) ||
                other.uploadCompletedAt == uploadCompletedAt));
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
    adTransactionId,
    adFullyWatched,
    adResponseId,
    const DeepCollectionEquality().hash(_uploadedFiles),
    uploadTextResponse,
    uploadStartedAt,
    uploadCompletedAt,
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
    final String? adTransactionId,
    final bool? adFullyWatched,
    final String? adResponseId,
    final List<UploadedFileEvidence>? uploadedFiles,
    final String? uploadTextResponse,
    final DateTime? uploadStartedAt,
    final DateTime? uploadCompletedAt,
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

  /// AdMob transaction ID for server-side verification
  @override
  String? get adTransactionId;

  /// Client-side flag indicating ad was fully watched
  @override
  bool? get adFullyWatched;

  /// AdMob response ID — uniquely identifies the ad impression for debugging
  @override
  String? get adResponseId;

  /// Upload evidence fields
  @override
  List<UploadedFileEvidence>? get uploadedFiles;
  @override
  String? get uploadTextResponse;
  @override
  DateTime? get uploadStartedAt;
  @override
  DateTime? get uploadCompletedAt;

  /// Create a copy of EngagementEvidence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementEvidenceImplCopyWith<_$EngagementEvidenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
