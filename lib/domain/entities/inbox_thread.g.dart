// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InboxThread _$InboxThreadFromJson(Map<String, dynamic> json) => _InboxThread(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  threadImage: json['threadImage'] as String?,
  isPinned: json['isPinned'] as bool,
  isFeatured: json['isFeatured'] as bool,
  activeTo: json['activeTo'] == null
      ? null
      : DateTime.parse(json['activeTo'] as String),
  availableOpportunities: (json['availableOpportunities'] as num).toInt(),
  completedByUser: (json['completedByUser'] as num?)?.toInt() ?? 0,
  totalTokenReward: (json['totalTokenReward'] as num).toInt(),
  rewardTypes:
      (json['rewardTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  earningTypes:
      (json['earningTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  estimatedDurationSeconds:
      (json['estimatedDurationSeconds'] as num?)?.toInt() ?? 0,
  opportunityIds:
      (json['opportunityIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  hasRewardCampaign: json['hasRewardCampaign'] as bool? ?? false,
  soonestExpiry: json['soonestExpiry'] == null
      ? null
      : DateTime.parse(json['soonestExpiry'] as String),
);

Map<String, dynamic> _$InboxThreadToJson(_InboxThread instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'threadImage': instance.threadImage,
      'isPinned': instance.isPinned,
      'isFeatured': instance.isFeatured,
      'activeTo': instance.activeTo?.toIso8601String(),
      'availableOpportunities': instance.availableOpportunities,
      'completedByUser': instance.completedByUser,
      'totalTokenReward': instance.totalTokenReward,
      'rewardTypes': instance.rewardTypes,
      'earningTypes': instance.earningTypes,
      'estimatedDurationSeconds': instance.estimatedDurationSeconds,
      'opportunityIds': instance.opportunityIds,
      'hasRewardCampaign': instance.hasRewardCampaign,
      'soonestExpiry': instance.soonestExpiry?.toIso8601String(),
    };
