// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn_opportunity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurveyQuestionImpl _$$SurveyQuestionImplFromJson(Map<String, dynamic> json) =>
    _$SurveyQuestionImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      orderIndex: (json['orderIndex'] as num).toInt(),
      isAttentionCheck: json['isAttentionCheck'] as bool?,
      correctAnswer: json['correctAnswer'] as String?,
    );

Map<String, dynamic> _$$SurveyQuestionImplToJson(
  _$SurveyQuestionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'options': instance.options,
  'orderIndex': instance.orderIndex,
  'isAttentionCheck': instance.isAttentionCheck,
  'correctAnswer': instance.correctAnswer,
};

_$EarnOpportunityImpl _$$EarnOpportunityImplFromJson(
  Map<String, dynamic> json,
) => _$EarnOpportunityImpl(
  id: json['id'] as String,
  threadId: json['threadId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  earningType: $enumDecode(_$EarningTypeEnumMap, json['earningType']),
  tokenReward: (json['tokenReward'] as num).toInt(),
  streakPoints: (json['streakPoints'] as num?)?.toInt() ?? 1,
  mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
  mediaUrl: json['mediaUrl'] as String?,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => SurveyQuestion.fromJson(e as Map<String, dynamic>))
      .toList(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  isActive: json['isActive'] as bool,
  clientId: json['clientId'] as String?,
  clientName: json['clientName'] as String?,
  clientAvatarColor: json['clientAvatarColor'] as String?,
  campaignId: json['campaignId'] as String?,
  targeting: json['targeting'] == null
      ? null
      : TargetingCriteria.fromJson(json['targeting'] as Map<String, dynamic>),
  bonusReward: json['bonusReward'] as bool? ?? false,
  bonusRewardMultiplier:
      (json['bonusRewardMultiplier'] as num?)?.toDouble() ?? 1.0,
  bonusIntervalType: $enumDecodeNullable(
    _$BonusIntervalTypeEnumMap,
    json['bonusIntervalType'],
  ),
  bonusIntervalX: (json['bonusIntervalX'] as num?)?.toInt(),
  userEngagementStatus: json['userEngagementStatus'] as String?,
  userEngagementId: json['userEngagementId'] as String?,
  adUnitId: json['adUnitId'] as String?,
  dailyLimitPerUser: (json['dailyLimitPerUser'] as num?)?.toInt() ?? 3,
  budgetExhausted: json['budgetExhausted'] as bool? ?? false,
  tokenBudget: (json['tokenBudget'] as num?)?.toInt(),
  tokenSpent: (json['tokenSpent'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$EarnOpportunityImplToJson(
  _$EarnOpportunityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'threadId': instance.threadId,
  'title': instance.title,
  'description': instance.description,
  'earningType': _$EarningTypeEnumMap[instance.earningType]!,
  'tokenReward': instance.tokenReward,
  'streakPoints': instance.streakPoints,
  'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
  'mediaUrl': instance.mediaUrl,
  'questions': instance.questions,
  'durationSeconds': instance.durationSeconds,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'isActive': instance.isActive,
  'clientId': instance.clientId,
  'clientName': instance.clientName,
  'clientAvatarColor': instance.clientAvatarColor,
  'campaignId': instance.campaignId,
  'targeting': instance.targeting,
  'bonusReward': instance.bonusReward,
  'bonusRewardMultiplier': instance.bonusRewardMultiplier,
  'bonusIntervalType': _$BonusIntervalTypeEnumMap[instance.bonusIntervalType],
  'bonusIntervalX': instance.bonusIntervalX,
  'userEngagementStatus': instance.userEngagementStatus,
  'userEngagementId': instance.userEngagementId,
  'adUnitId': instance.adUnitId,
  'dailyLimitPerUser': instance.dailyLimitPerUser,
  'budgetExhausted': instance.budgetExhausted,
  'tokenBudget': instance.tokenBudget,
  'tokenSpent': instance.tokenSpent,
};

const _$EarningTypeEnumMap = {
  EarningType.survey: 'survey',
  EarningType.video: 'video',
  EarningType.trivia: 'trivia',
  EarningType.rating: 'rating',
  EarningType.poll: 'poll',
  EarningType.adVideo: 'adVideo',
};

const _$MediaTypeEnumMap = {
  MediaType.video: 'video',
  MediaType.image: 'image',
  MediaType.text: 'text',
  MediaType.adMob: 'adMob',
};

const _$BonusIntervalTypeEnumMap = {
  BonusIntervalType.random: 'random',
  BonusIntervalType.everyX: 'everyX',
};
