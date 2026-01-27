// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
  id: json['id'] as String,
  campaignId: json['campaignId'] as String,
  title: json['title'] as String,
  videoUrl: json['videoUrl'] as String,
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  requiredWatchSeconds: (json['requiredWatchSeconds'] as num).toInt(),
  tokenReward: (json['tokenReward'] as num).toInt(),
  status: $enumDecode(_$VideoStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  thumbnailUrl: json['thumbnailUrl'] as String?,
  description: json['description'] as String?,
  callToActionText: json['callToActionText'] as String?,
  callToActionUrl: json['callToActionUrl'] as String?,
  totalViews: (json['totalViews'] as num?)?.toInt(),
  completedViews: (json['completedViews'] as num?)?.toInt(),
  averageWatchPercentage: (json['averageWatchPercentage'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaignId': instance.campaignId,
      'title': instance.title,
      'videoUrl': instance.videoUrl,
      'durationSeconds': instance.durationSeconds,
      'requiredWatchSeconds': instance.requiredWatchSeconds,
      'tokenReward': instance.tokenReward,
      'status': _$VideoStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'callToActionText': instance.callToActionText,
      'callToActionUrl': instance.callToActionUrl,
      'totalViews': instance.totalViews,
      'completedViews': instance.completedViews,
      'averageWatchPercentage': instance.averageWatchPercentage,
    };

const _$VideoStatusEnumMap = {
  VideoStatus.active: 'active',
  VideoStatus.paused: 'paused',
  VideoStatus.expired: 'expired',
  VideoStatus.deleted: 'deleted',
};
