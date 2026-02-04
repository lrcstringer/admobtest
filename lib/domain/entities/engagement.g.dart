// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engagement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EngagementImpl _$$EngagementImplFromJson(Map<String, dynamic> json) =>
    _$EngagementImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      oddienceCampaignId: json['oddienceCampaignId'] as String,
      earnOpportunityId: json['earnOpportunityId'] as String,
      status: $enumDecode(_$EngagementStatusEnumMap, json['status']),
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      watchDurationSeconds: (json['watchDurationSeconds'] as num).toInt(),
      requiredDurationSeconds: (json['requiredDurationSeconds'] as num).toInt(),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => EngagementAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      evidence: json['evidence'] == null
          ? null
          : EngagementEvidence.fromJson(
              json['evidence'] as Map<String, dynamic>,
            ),
      tokensEarned: (json['tokensEarned'] as num?)?.toInt(),
      failureReason: json['failureReason'] as String?,
      attemptNumber: (json['attemptNumber'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      streakDayAtCompletion: (json['streakDayAtCompletion'] as num?)?.toInt(),
      multiplierApplied: (json['multiplierApplied'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$EngagementImplToJson(_$EngagementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'oddienceCampaignId': instance.oddienceCampaignId,
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
      'streakDayAtCompletion': instance.streakDayAtCompletion,
      'multiplierApplied': instance.multiplierApplied,
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
};

_$EngagementAnswerImpl _$$EngagementAnswerImplFromJson(
  Map<String, dynamic> json,
) => _$EngagementAnswerImpl(
  questionId: json['questionId'] as String,
  selectedOption: json['selectedOption'] as String,
  answeredAt: DateTime.parse(json['answeredAt'] as String),
  isCorrect: json['isCorrect'] as bool?,
);

Map<String, dynamic> _$$EngagementAnswerImplToJson(
  _$EngagementAnswerImpl instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'selectedOption': instance.selectedOption,
  'answeredAt': instance.answeredAt.toIso8601String(),
  'isCorrect': instance.isCorrect,
};
