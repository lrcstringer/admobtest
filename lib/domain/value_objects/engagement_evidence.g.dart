// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engagement_evidence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UploadedFileEvidenceImpl _$$UploadedFileEvidenceImplFromJson(
  Map<String, dynamic> json,
) => _$UploadedFileEvidenceImpl(
  url: json['url'] as String,
  type: json['type'] as String,
  sizeBytes: (json['sizeBytes'] as num).toInt(),
  mimeType: json['mimeType'] as String?,
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$$UploadedFileEvidenceImplToJson(
  _$UploadedFileEvidenceImpl instance,
) => <String, dynamic>{
  'url': instance.url,
  'type': instance.type,
  'sizeBytes': instance.sizeBytes,
  'mimeType': instance.mimeType,
  'durationSeconds': instance.durationSeconds,
  'width': instance.width,
  'height': instance.height,
};

_$EngagementEvidenceImpl _$$EngagementEvidenceImplFromJson(
  Map<String, dynamic> json,
) => _$EngagementEvidenceImpl(
  deviceFingerprint: json['deviceFingerprint'] as String,
  integrityToken: json['integrityToken'] as String?,
  watchDurationMs: (json['watchDurationMs'] as num).toInt(),
  videoSeeked: json['videoSeeked'] as bool,
  screenVisible: json['screenVisible'] as bool,
  appInForeground: json['appInForeground'] as bool,
  surveyResponseTimesMs: (json['surveyResponseTimesMs'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  videoStartedAt: DateTime.parse(json['videoStartedAt'] as String),
  surveySubmittedAt: DateTime.parse(json['surveySubmittedAt'] as String),
  clientAttentionScore: (json['clientAttentionScore'] as num?)?.toDouble(),
  adTransactionId: json['adTransactionId'] as String?,
  adFullyWatched: json['adFullyWatched'] as bool?,
  adResponseId: json['adResponseId'] as String?,
  uploadedFiles: (json['uploadedFiles'] as List<dynamic>?)
      ?.map((e) => UploadedFileEvidence.fromJson(e as Map<String, dynamic>))
      .toList(),
  uploadTextResponse: json['uploadTextResponse'] as String?,
  uploadStartedAt: json['uploadStartedAt'] == null
      ? null
      : DateTime.parse(json['uploadStartedAt'] as String),
  uploadCompletedAt: json['uploadCompletedAt'] == null
      ? null
      : DateTime.parse(json['uploadCompletedAt'] as String),
);

Map<String, dynamic> _$$EngagementEvidenceImplToJson(
  _$EngagementEvidenceImpl instance,
) => <String, dynamic>{
  'deviceFingerprint': instance.deviceFingerprint,
  'integrityToken': instance.integrityToken,
  'watchDurationMs': instance.watchDurationMs,
  'videoSeeked': instance.videoSeeked,
  'screenVisible': instance.screenVisible,
  'appInForeground': instance.appInForeground,
  'surveyResponseTimesMs': instance.surveyResponseTimesMs,
  'videoStartedAt': instance.videoStartedAt.toIso8601String(),
  'surveySubmittedAt': instance.surveySubmittedAt.toIso8601String(),
  'clientAttentionScore': instance.clientAttentionScore,
  'adTransactionId': instance.adTransactionId,
  'adFullyWatched': instance.adFullyWatched,
  'adResponseId': instance.adResponseId,
  'uploadedFiles': instance.uploadedFiles,
  'uploadTextResponse': instance.uploadTextResponse,
  'uploadStartedAt': instance.uploadStartedAt?.toIso8601String(),
  'uploadCompletedAt': instance.uploadCompletedAt?.toIso8601String(),
};
