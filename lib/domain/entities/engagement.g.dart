// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engagement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Engagement _$EngagementFromJson(Map<String, dynamic> json) => _Engagement(
  id: json['id'] as String,
  userId: json['userId'] as String,
  audienceCampaignId: json['audienceCampaignId'] as String?,
  earnOpportunityId: json['earnOpportunityId'] as String,
  status: $enumDecode(_$EngagementStatusEnumMap, json['status']),
  startedAt: DateTime.parse(json['startedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  watchDurationSeconds: (json['watchDurationSeconds'] as num).toInt(),
  requiredDurationSeconds: (json['requiredDurationSeconds'] as num).toInt(),
  answers: (json['answers'] as List<dynamic>)
      .map((e) => SurveyResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  evidence: json['evidence'] == null
      ? null
      : EngagementEvidence.fromJson(json['evidence'] as Map<String, dynamic>),
  tokensEarned: (json['tokensEarned'] as num?)?.toDouble(),
  failureReason: json['failureReason'] as String?,
  attemptNumber: (json['attemptNumber'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  threadId: json['threadId'] as String?,
  clientId: json['clientId'] as String?,
  streakDayAtCompletion: (json['streakDayAtCompletion'] as num?)?.toInt(),
  multiplierApplied: (json['multiplierApplied'] as num?)?.toDouble(),
  adWatched: json['adWatched'] as bool? ?? false,
  adTransactionId: json['adTransactionId'] as String?,
  adCompletedAt: json['adCompletedAt'] == null
      ? null
      : DateTime.parse(json['adCompletedAt'] as String),
  rewardItemId: json['rewardItemId'] as String?,
  rewardCampaignName: json['rewardCampaignName'] as String?,
  rewardType: json['rewardType'] as String?,
);

Map<String, dynamic> _$EngagementToJson(_Engagement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'audienceCampaignId': instance.audienceCampaignId,
      'earnOpportunityId': instance.earnOpportunityId,
      'status': _$EngagementStatusEnumMap[instance.status]!,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'watchDurationSeconds': instance.watchDurationSeconds,
      'requiredDurationSeconds': instance.requiredDurationSeconds,
      'answers': instance.answers,
      'evidence': instance.evidence,
      'tokensEarned': instance.tokensEarned,
      'failureReason': instance.failureReason,
      'attemptNumber': instance.attemptNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'threadId': instance.threadId,
      'clientId': instance.clientId,
      'streakDayAtCompletion': instance.streakDayAtCompletion,
      'multiplierApplied': instance.multiplierApplied,
      'adWatched': instance.adWatched,
      'adTransactionId': instance.adTransactionId,
      'adCompletedAt': instance.adCompletedAt?.toIso8601String(),
      'rewardItemId': instance.rewardItemId,
      'rewardCampaignName': instance.rewardCampaignName,
      'rewardType': instance.rewardType,
    };

const _$EngagementStatusEnumMap = {
  EngagementStatus.started: 'started',
  EngagementStatus.watching: 'watching',
  EngagementStatus.surveying: 'surveying',
  EngagementStatus.completed: 'completed',
  EngagementStatus.failed: 'failed',
  EngagementStatus.abandoned: 'abandoned',
  EngagementStatus.rewarded: 'rewarded',
  EngagementStatus.rejected: 'rejected',
  EngagementStatus.pendingReview: 'pendingReview',
};

_SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) =>
    _SurveyResponse(
      questionId: json['questionId'] as String,
      questionType: json['questionType'] as String,
      answeredAt: DateTime.parse(json['answeredAt'] as String),
      selectedOption: json['selectedOption'] as String?,
      selectedOptions: (json['selectedOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      textResponses: (json['textResponses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      likertValue: (json['likertValue'] as num?)?.toInt(),
      starRating: (json['starRating'] as num?)?.toInt(),
      selectedTags: (json['selectedTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sliderValue: (json['sliderValue'] as num?)?.toDouble(),
      isCorrect: json['isCorrect'] as bool?,
    );

Map<String, dynamic> _$SurveyResponseToJson(_SurveyResponse instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'questionType': instance.questionType,
      'answeredAt': instance.answeredAt.toIso8601String(),
      'selectedOption': instance.selectedOption,
      'selectedOptions': instance.selectedOptions,
      'textResponses': instance.textResponses,
      'likertValue': instance.likertValue,
      'starRating': instance.starRating,
      'selectedTags': instance.selectedTags,
      'sliderValue': instance.sliderValue,
      'isCorrect': instance.isCorrect,
    };
