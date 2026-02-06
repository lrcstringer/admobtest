// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engagement_evidence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
};
