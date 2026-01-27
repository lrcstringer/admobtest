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
  tokenReward: (json['tokenReward'] as num).toInt(),
  mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
  mediaUrl: json['mediaUrl'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => SurveyQuestion.fromJson(e as Map<String, dynamic>))
      .toList(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  isActive: json['isActive'] as bool,
  brandName: json['brandName'] as String?,
  brandAvatarColor: json['brandAvatarColor'] as String?,
  campaignId: json['campaignId'] as String?,
);

Map<String, dynamic> _$$EarnOpportunityImplToJson(
  _$EarnOpportunityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'threadId': instance.threadId,
  'title': instance.title,
  'description': instance.description,
  'tokenReward': instance.tokenReward,
  'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
  'mediaUrl': instance.mediaUrl,
  'questions': instance.questions,
  'durationSeconds': instance.durationSeconds,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'isActive': instance.isActive,
  'brandName': instance.brandName,
  'brandAvatarColor': instance.brandAvatarColor,
  'campaignId': instance.campaignId,
};

const _$MediaTypeEnumMap = {
  MediaType.video: 'video',
  MediaType.image: 'image',
  MediaType.text: 'text',
};
