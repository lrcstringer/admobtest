// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn_opportunity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BranchRule _$BranchRuleFromJson(Map<String, dynamic> json) => _BranchRule(
  optionValue: json['optionValue'] as String,
  goToQuestionId: json['goToQuestionId'] as String,
);

Map<String, dynamic> _$BranchRuleToJson(_BranchRule instance) =>
    <String, dynamic>{
      'optionValue': instance.optionValue,
      'goToQuestionId': instance.goToQuestionId,
    };

_SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) =>
    _SurveyQuestion(
      id: json['id'] as String,
      text: json['text'] as String,
      orderIndex: (json['orderIndex'] as num).toInt(),
      questionType: $enumDecode(_$QuestionTypeEnumMap, json['questionType']),
      isRequired: json['isRequired'] as bool? ?? true,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maxSelections: (json['maxSelections'] as num?)?.toInt(),
      textInputCount: (json['textInputCount'] as num?)?.toInt() ?? 1,
      textMaxLength: (json['textMaxLength'] as num?)?.toInt() ?? 50,
      likertScale: (json['likertScale'] as num?)?.toInt() ?? 5,
      likertLowLabel: json['likertLowLabel'] as String?,
      likertHighLabel: json['likertHighLabel'] as String?,
      maxStars: (json['maxStars'] as num?)?.toInt() ?? 5,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      maxTags: (json['maxTags'] as num?)?.toInt(),
      sliderMin: (json['sliderMin'] as num?)?.toInt() ?? 0,
      sliderMax: (json['sliderMax'] as num?)?.toInt() ?? 100,
      sliderStep: (json['sliderStep'] as num?)?.toInt() ?? 1,
      sliderMinLabel: json['sliderMinLabel'] as String?,
      sliderMaxLabel: json['sliderMaxLabel'] as String?,
      isAttentionCheck: json['isAttentionCheck'] as bool? ?? false,
      correctAnswer: json['correctAnswer'] as String?,
      correctGoToQuestionId: json['correctGoToQuestionId'] as String?,
      incorrectGoToQuestionId: json['incorrectGoToQuestionId'] as String?,
      correctResponseText: json['correctResponseText'] as String?,
      correctResponseMediaUrl: json['correctResponseMediaUrl'] as String?,
      correctResponseMediaType: json['correctResponseMediaType'] as String?,
      incorrectResponseText: json['incorrectResponseText'] as String?,
      incorrectResponseMediaUrl: json['incorrectResponseMediaUrl'] as String?,
      incorrectResponseMediaType: json['incorrectResponseMediaType'] as String?,
      branchRules:
          (json['branchRules'] as List<dynamic>?)
              ?.map((e) => BranchRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SurveyQuestionToJson(_SurveyQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'orderIndex': instance.orderIndex,
      'questionType': _$QuestionTypeEnumMap[instance.questionType]!,
      'isRequired': instance.isRequired,
      'options': instance.options,
      'maxSelections': instance.maxSelections,
      'textInputCount': instance.textInputCount,
      'textMaxLength': instance.textMaxLength,
      'likertScale': instance.likertScale,
      'likertLowLabel': instance.likertLowLabel,
      'likertHighLabel': instance.likertHighLabel,
      'maxStars': instance.maxStars,
      'tags': instance.tags,
      'maxTags': instance.maxTags,
      'sliderMin': instance.sliderMin,
      'sliderMax': instance.sliderMax,
      'sliderStep': instance.sliderStep,
      'sliderMinLabel': instance.sliderMinLabel,
      'sliderMaxLabel': instance.sliderMaxLabel,
      'isAttentionCheck': instance.isAttentionCheck,
      'correctAnswer': instance.correctAnswer,
      'correctGoToQuestionId': instance.correctGoToQuestionId,
      'incorrectGoToQuestionId': instance.incorrectGoToQuestionId,
      'correctResponseText': instance.correctResponseText,
      'correctResponseMediaUrl': instance.correctResponseMediaUrl,
      'correctResponseMediaType': instance.correctResponseMediaType,
      'incorrectResponseText': instance.incorrectResponseText,
      'incorrectResponseMediaUrl': instance.incorrectResponseMediaUrl,
      'incorrectResponseMediaType': instance.incorrectResponseMediaType,
      'branchRules': instance.branchRules,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleSelect: 'singleSelect',
  QuestionType.multiSelect: 'multiSelect',
  QuestionType.textInput: 'textInput',
  QuestionType.likert: 'likert',
  QuestionType.starTags: 'starTags',
  QuestionType.slider: 'slider',
};

_EarnOpportunity _$EarnOpportunityFromJson(
  Map<String, dynamic> json,
) => _EarnOpportunity(
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
  isPinned: json['isPinned'] as bool? ?? false,
  isFeatured: json['isFeatured'] as bool? ?? false,
  clientId: json['clientId'] as String?,
  clientName: json['clientName'] as String?,
  clientAvatarColor: json['clientAvatarColor'] as String?,
  clientAvatarImage: json['clientAvatarImage'] as String?,
  threadImage: json['threadImage'] as String?,
  opportunityImage: json['opportunityImage'] as String?,
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
  pollId: json['pollId'] as String?,
  uploadPrompt: json['uploadPrompt'] as String?,
  uploadContextMediaUrl: json['uploadContextMediaUrl'] as String?,
  uploadContextMediaType: json['uploadContextMediaType'] as String?,
  uploadVideoEnabled: json['uploadVideoEnabled'] as bool? ?? false,
  uploadImageEnabled: json['uploadImageEnabled'] as bool? ?? false,
  uploadTextEnabled: json['uploadTextEnabled'] as bool? ?? false,
  uploadVideoRequired: json['uploadVideoRequired'] as bool? ?? false,
  uploadImageRequired: json['uploadImageRequired'] as bool? ?? false,
  uploadTextRequired: json['uploadTextRequired'] as bool? ?? false,
  uploadVideoMaxSeconds: (json['uploadVideoMaxSeconds'] as num?)?.toInt() ?? 60,
  uploadTextMinChars: (json['uploadTextMinChars'] as num?)?.toInt() ?? 10,
  uploadTextMaxChars: (json['uploadTextMaxChars'] as num?)?.toInt() ?? 1500,
  requiresAdminReview: json['requiresAdminReview'] as bool? ?? false,
  tokenSourceAccountId: json['tokenSourceAccountId'] as String?,
  rewardCampaignId: json['rewardCampaignId'] as String?,
  rewardCampaignName: json['rewardCampaignName'] as String?,
  rewardType: json['rewardType'] as String?,
  rewardQuantity: (json['rewardQuantity'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$EarnOpportunityToJson(
  _EarnOpportunity instance,
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
  'isPinned': instance.isPinned,
  'isFeatured': instance.isFeatured,
  'clientId': instance.clientId,
  'clientName': instance.clientName,
  'clientAvatarColor': instance.clientAvatarColor,
  'clientAvatarImage': instance.clientAvatarImage,
  'threadImage': instance.threadImage,
  'opportunityImage': instance.opportunityImage,
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
  'pollId': instance.pollId,
  'uploadPrompt': instance.uploadPrompt,
  'uploadContextMediaUrl': instance.uploadContextMediaUrl,
  'uploadContextMediaType': instance.uploadContextMediaType,
  'uploadVideoEnabled': instance.uploadVideoEnabled,
  'uploadImageEnabled': instance.uploadImageEnabled,
  'uploadTextEnabled': instance.uploadTextEnabled,
  'uploadVideoRequired': instance.uploadVideoRequired,
  'uploadImageRequired': instance.uploadImageRequired,
  'uploadTextRequired': instance.uploadTextRequired,
  'uploadVideoMaxSeconds': instance.uploadVideoMaxSeconds,
  'uploadTextMinChars': instance.uploadTextMinChars,
  'uploadTextMaxChars': instance.uploadTextMaxChars,
  'requiresAdminReview': instance.requiresAdminReview,
  'tokenSourceAccountId': instance.tokenSourceAccountId,
  'rewardCampaignId': instance.rewardCampaignId,
  'rewardCampaignName': instance.rewardCampaignName,
  'rewardType': instance.rewardType,
  'rewardQuantity': instance.rewardQuantity,
};

const _$EarningTypeEnumMap = {
  EarningType.survey: 'survey',
  EarningType.video: 'video',
  EarningType.image: 'image',
  EarningType.poll: 'poll',
  EarningType.adVideo: 'adVideo',
  EarningType.upload: 'upload',
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
