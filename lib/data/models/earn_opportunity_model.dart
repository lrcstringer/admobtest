import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/earn_opportunity.dart';

part 'earn_opportunity_model.freezed.dart';

@freezed
class SurveyQuestionModel with _$SurveyQuestionModel {
  const factory SurveyQuestionModel({
    required String id,
    required String text,
    required List<String> options,
    required int orderIndex,
    bool? isAttentionCheck,
    String? correctAnswer,
  }) = _SurveyQuestionModel;

  const SurveyQuestionModel._();

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) {
    return SurveyQuestionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      options: (json['options'] as List).map((e) => e as String).toList(),
      orderIndex: json['orderIndex'] as int,
      isAttentionCheck: json['isAttentionCheck'] as bool?,
      correctAnswer: json['correctAnswer'] as String?,
    );
  }

  SurveyQuestion toEntity() {
    return SurveyQuestion(
      id: id,
      text: text,
      options: options,
      orderIndex: orderIndex,
      isAttentionCheck: isAttentionCheck,
      correctAnswer: correctAnswer,
    );
  }

  factory SurveyQuestionModel.fromEntity(SurveyQuestion entity) {
    return SurveyQuestionModel(
      id: entity.id,
      text: entity.text,
      options: entity.options,
      orderIndex: entity.orderIndex,
      isAttentionCheck: entity.isAttentionCheck,
      correctAnswer: entity.correctAnswer,
    );
  }
}

@freezed
class EarnOpportunityModel with _$EarnOpportunityModel {
  const factory EarnOpportunityModel({
    required String id,
    required String threadId,
    required String title,
    String? description,
    required int tokenReward,
    required String mediaType,
    required String mediaUrl,
    required List<SurveyQuestionModel> questions,
    required int durationSeconds,
    DateTime? expiresAt,
    required bool isActive,
    String? brandName,
    String? brandAvatarColor,
    String? campaignId,
  }) = _EarnOpportunityModel;

  const EarnOpportunityModel._();

  factory EarnOpportunityModel.fromJson(Map<String, dynamic> json) {
    final expiresAt = json['expiresAt'];

    return EarnOpportunityModel(
      id: json['id'] as String,
      threadId: json['threadId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      tokenReward: json['tokenReward'] as int,
      mediaType: json['mediaType'] as String? ?? 'video',
      mediaUrl: json['mediaUrl'] as String,
      questions: (json['questions'] as List?)
              ?.map((e) =>
                  SurveyQuestionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      durationSeconds: json['durationSeconds'] as int,
      expiresAt: expiresAt == null
          ? null
          : expiresAt is Timestamp
              ? expiresAt.toDate()
              : DateTime.parse(expiresAt as String),
      isActive: json['isActive'] as bool? ?? true,
      brandName: json['brandName'] as String?,
      brandAvatarColor: json['brandAvatarColor'] as String?,
      campaignId: json['campaignId'] as String?,
    );
  }

  EarnOpportunity toEntity() {
    return EarnOpportunity(
      id: id,
      threadId: threadId,
      title: title,
      description: description,
      tokenReward: tokenReward,
      mediaType: _parseMediaType(mediaType),
      mediaUrl: mediaUrl,
      questions: questions.map((q) => q.toEntity()).toList(),
      durationSeconds: durationSeconds,
      expiresAt: expiresAt,
      isActive: isActive,
      brandName: brandName,
      brandAvatarColor: brandAvatarColor,
      campaignId: campaignId,
    );
  }

  factory EarnOpportunityModel.fromEntity(EarnOpportunity entity) {
    return EarnOpportunityModel(
      id: entity.id,
      threadId: entity.threadId,
      title: entity.title,
      description: entity.description,
      tokenReward: entity.tokenReward,
      mediaType: entity.mediaType.name,
      mediaUrl: entity.mediaUrl,
      questions: entity.questions
          .map((q) => SurveyQuestionModel.fromEntity(q))
          .toList(),
      durationSeconds: entity.durationSeconds,
      expiresAt: entity.expiresAt,
      isActive: entity.isActive,
      brandName: entity.brandName,
      brandAvatarColor: entity.brandAvatarColor,
      campaignId: entity.campaignId,
    );
  }

  static MediaType _parseMediaType(String type) {
    switch (type) {
      case 'video':
        return MediaType.video;
      case 'image':
        return MediaType.image;
      case 'text':
        return MediaType.text;
      default:
        return MediaType.video;
    }
  }
}
