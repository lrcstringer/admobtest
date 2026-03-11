// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Campaign _$CampaignFromJson(Map<String, dynamic> json) => _Campaign(
  id: json['id'] as String,
  brandId: json['brandId'] as String,
  brandName: json['brandName'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$CampaignTypeEnumMap, json['type']),
  status: $enumDecode(_$CampaignStatusEnumMap, json['status']),
  totalBudgetTokens: (json['totalBudgetTokens'] as num).toInt(),
  remainingBudgetTokens: (json['remainingBudgetTokens'] as num).toInt(),
  rewardPerEngagement: (json['rewardPerEngagement'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  imageUrl: json['imageUrl'] as String?,
  videoUrl: json['videoUrl'] as String?,
  targetingCriteria: json['targetingCriteria'] as Map<String, dynamic>?,
  maxEngagementsPerUser: (json['maxEngagementsPerUser'] as num?)?.toInt(),
  totalEngagements: (json['totalEngagements'] as num?)?.toInt(),
  uniqueUsers: (json['uniqueUsers'] as num?)?.toInt(),
  averageCompletionRate: (json['averageCompletionRate'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CampaignToJson(_Campaign instance) => <String, dynamic>{
  'id': instance.id,
  'brandId': instance.brandId,
  'brandName': instance.brandName,
  'title': instance.title,
  'description': instance.description,
  'type': _$CampaignTypeEnumMap[instance.type]!,
  'status': _$CampaignStatusEnumMap[instance.status]!,
  'totalBudgetTokens': instance.totalBudgetTokens,
  'remainingBudgetTokens': instance.remainingBudgetTokens,
  'rewardPerEngagement': instance.rewardPerEngagement,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'imageUrl': instance.imageUrl,
  'videoUrl': instance.videoUrl,
  'targetingCriteria': instance.targetingCriteria,
  'maxEngagementsPerUser': instance.maxEngagementsPerUser,
  'totalEngagements': instance.totalEngagements,
  'uniqueUsers': instance.uniqueUsers,
  'averageCompletionRate': instance.averageCompletionRate,
};

const _$CampaignTypeEnumMap = {
  CampaignType.videoAd: 'video_ad',
  CampaignType.survey: 'survey',
  CampaignType.pollQuestion: 'poll_question',
  CampaignType.brandedContent: 'branded_content',
  CampaignType.appInstall: 'app_install',
  CampaignType.websiteVisit: 'website_visit',
};

const _$CampaignStatusEnumMap = {
  CampaignStatus.draft: 'draft',
  CampaignStatus.pendingApproval: 'pending_approval',
  CampaignStatus.active: 'active',
  CampaignStatus.paused: 'paused',
  CampaignStatus.completed: 'completed',
  CampaignStatus.cancelled: 'cancelled',
  CampaignStatus.expired: 'expired',
};
