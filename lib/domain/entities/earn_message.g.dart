// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarnMessage _$EarnMessageFromJson(Map<String, dynamic> json) => _EarnMessage(
  id: json['id'] as String,
  threadId: json['threadId'] as String,
  userId: json['userId'] as String,
  type: $enumDecode(_$EarnMessageTypeEnumMap, json['type']),
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: $enumDecodeNullable(_$EarnMessageStatusEnumMap, json['status']),
  metadata: json['metadata'] as Map<String, dynamic>?,
  questionId: json['questionId'] as String?,
  response: json['response'],
  adId: json['adId'] as String?,
  watchDurationSeconds: (json['watchDurationSeconds'] as num?)?.toInt(),
  tokensEarned: (json['tokensEarned'] as num?)?.toInt(),
);

Map<String, dynamic> _$EarnMessageToJson(_EarnMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'threadId': instance.threadId,
      'userId': instance.userId,
      'type': _$EarnMessageTypeEnumMap[instance.type]!,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$EarnMessageStatusEnumMap[instance.status],
      'metadata': instance.metadata,
      'questionId': instance.questionId,
      'response': instance.response,
      'adId': instance.adId,
      'watchDurationSeconds': instance.watchDurationSeconds,
      'tokensEarned': instance.tokensEarned,
    };

const _$EarnMessageTypeEnumMap = {
  EarnMessageType.adStarted: 'ad_started',
  EarnMessageType.adCompleted: 'ad_completed',
  EarnMessageType.adSkipped: 'ad_skipped',
  EarnMessageType.surveyStarted: 'survey_started',
  EarnMessageType.surveyQuestionAnswered: 'survey_question_answered',
  EarnMessageType.surveyCompleted: 'survey_completed',
  EarnMessageType.surveyAbandoned: 'survey_abandoned',
  EarnMessageType.rewardCredited: 'reward_credited',
  EarnMessageType.systemMessage: 'system_message',
};

const _$EarnMessageStatusEnumMap = {
  EarnMessageStatus.pending: 'pending',
  EarnMessageStatus.processed: 'processed',
  EarnMessageStatus.failed: 'failed',
  EarnMessageStatus.cancelled: 'cancelled',
};
