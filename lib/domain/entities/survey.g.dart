// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurveyImpl _$$SurveyImplFromJson(Map<String, dynamic> json) => _$SurveyImpl(
  id: json['id'] as String,
  campaignId: json['campaignId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => SurveyQuestion.fromJson(e as Map<String, dynamic>))
      .toList(),
  tokenReward: (json['tokenReward'] as num).toInt(),
  estimatedMinutes: (json['estimatedMinutes'] as num).toInt(),
  status: $enumDecode(_$SurveyStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  maxResponses: (json['maxResponses'] as num?)?.toInt(),
  currentResponses: (json['currentResponses'] as num?)?.toInt(),
  targetingCriteria: json['targetingCriteria'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$SurveyImplToJson(_$SurveyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaignId': instance.campaignId,
      'title': instance.title,
      'description': instance.description,
      'questions': instance.questions,
      'tokenReward': instance.tokenReward,
      'estimatedMinutes': instance.estimatedMinutes,
      'status': _$SurveyStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'maxResponses': instance.maxResponses,
      'currentResponses': instance.currentResponses,
      'targetingCriteria': instance.targetingCriteria,
    };

const _$SurveyStatusEnumMap = {
  SurveyStatus.draft: 'draft',
  SurveyStatus.active: 'active',
  SurveyStatus.paused: 'paused',
  SurveyStatus.completed: 'completed',
  SurveyStatus.expired: 'expired',
};

_$SurveyQuestionImpl _$$SurveyQuestionImplFromJson(Map<String, dynamic> json) =>
    _$SurveyQuestionImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      type: $enumDecode(_$QuestionTypeEnumMap, json['type']),
      isRequired: json['isRequired'] as bool,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      minValue: (json['minValue'] as num?)?.toInt(),
      maxValue: (json['maxValue'] as num?)?.toInt(),
      placeholder: json['placeholder'] as String?,
    );

Map<String, dynamic> _$$SurveyQuestionImplToJson(
  _$SurveyQuestionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'type': _$QuestionTypeEnumMap[instance.type]!,
  'isRequired': instance.isRequired,
  'options': instance.options,
  'minValue': instance.minValue,
  'maxValue': instance.maxValue,
  'placeholder': instance.placeholder,
};

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'single_choice',
  QuestionType.multipleChoice: 'multiple_choice',
  QuestionType.text: 'text',
  QuestionType.rating: 'rating',
  QuestionType.scale: 'scale',
  QuestionType.yesNo: 'yes_no',
};
