import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/earn_opportunity.dart';
import '../../domain/entities/targeting_criteria.dart';

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

  Map<String, dynamic> toFirestoreJson() {
    return {
      'id': id,
      'text': text,
      'options': options,
      'orderIndex': orderIndex,
      if (isAttentionCheck != null) 'isAttentionCheck': isAttentionCheck,
      if (correctAnswer != null) 'correctAnswer': correctAnswer,
    };
  }
}

@freezed
class EarnOpportunityModel with _$EarnOpportunityModel {
  const factory EarnOpportunityModel({
    required String id,
    required String threadId,
    required String title,
    String? description,
    // Earning configuration
    required String earningType,
    required int tokenReward,
    @Default(1) int streakPoints,
    required String mediaType,
    String? mediaUrl,
    required List<SurveyQuestionModel> questions,
    required int durationSeconds,
    DateTime? expiresAt,
    required bool isActive,
    // Denormalized client info
    String? clientId,
    String? clientName,
    String? clientAvatarColor,
    // Legacy campaign reference
    String? campaignId,
    // Targeting (stored as JSON map)
    Map<String, dynamic>? targeting,
    // Bonus reward configuration
    @Default(false) bool bonusReward,
    @Default(1.0) double bonusRewardMultiplier,
    String? bonusIntervalType,
    int? bonusIntervalX,
    // User engagement status (populated by getEligibleOpportunities)
    String? userEngagementStatus,
    String? userEngagementId,
    // AdMob configuration
    String? adUnitId,
    @Default(3) int dailyLimitPerUser,
    // Budget cap fields
    @Default(false) bool budgetExhausted,
    int? tokenBudget,
    @Default(0) int tokenSpent,
  }) = _EarnOpportunityModel;

  const EarnOpportunityModel._();

  factory EarnOpportunityModel.fromJson(Map<String, dynamic> json) {
    final expiresAt = json['expiresAt'];

    return EarnOpportunityModel(
      id: json['id'] as String,
      threadId: json['threadId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      earningType: json['earningType'] as String? ?? 'video',
      tokenReward: json['tokenReward'] as int,
      streakPoints: json['streakPoints'] as int? ?? 1,
      mediaType: json['mediaType'] as String? ?? 'video',
      mediaUrl: json['mediaUrl'] as String?,
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
      // Client info (with legacy brandName fallback)
      clientId: json['clientId'] as String?,
      clientName: json['clientName'] as String? ?? json['brandName'] as String?,
      clientAvatarColor: json['clientAvatarColor'] as String? ??
          json['brandAvatarColor'] as String?,
      campaignId: json['campaignId'] as String?,
      targeting: json['targeting'] as Map<String, dynamic>?,
      // Bonus reward configuration
      bonusReward: json['bonusReward'] as bool? ?? false,
      bonusRewardMultiplier:
          (json['bonusRewardMultiplier'] as num?)?.toDouble() ?? 1.0,
      bonusIntervalType: json['bonusIntervalType'] as String?,
      bonusIntervalX: json['bonusIntervalX'] as int?,
      userEngagementStatus: json['userEngagementStatus'] as String?,
      userEngagementId: json['userEngagementId'] as String?,
      // AdMob configuration
      adUnitId: json['adUnitId'] as String?,
      dailyLimitPerUser: json['dailyLimitPerUser'] as int? ?? 3,
      // Budget cap fields
      budgetExhausted: json['budgetExhausted'] as bool? ?? false,
      tokenBudget: json['tokenBudget'] as int?,
      tokenSpent: json['tokenSpent'] as int? ?? 0,
    );
  }

  EarnOpportunity toEntity() {
    return EarnOpportunity(
      id: id,
      threadId: threadId,
      title: title,
      description: description,
      earningType: _parseEarningType(earningType),
      tokenReward: tokenReward,
      streakPoints: streakPoints,
      mediaType: _parseMediaType(mediaType),
      mediaUrl: mediaUrl,
      questions: questions.map((q) => q.toEntity()).toList(),
      durationSeconds: durationSeconds,
      expiresAt: expiresAt,
      isActive: isActive,
      clientId: clientId,
      clientName: clientName,
      clientAvatarColor: clientAvatarColor,
      campaignId: campaignId,
      targeting:
          targeting != null ? TargetingCriteria.fromJson(targeting!) : null,
      // Bonus reward configuration
      bonusReward: bonusReward,
      bonusRewardMultiplier: bonusRewardMultiplier,
      bonusIntervalType: _parseBonusIntervalType(bonusIntervalType),
      bonusIntervalX: bonusIntervalX,
      userEngagementStatus: userEngagementStatus,
      userEngagementId: userEngagementId,
      // AdMob configuration
      adUnitId: adUnitId,
      dailyLimitPerUser: dailyLimitPerUser,
      // Budget cap fields
      budgetExhausted: budgetExhausted,
      tokenBudget: tokenBudget,
      tokenSpent: tokenSpent,
    );
  }

  factory EarnOpportunityModel.fromEntity(EarnOpportunity entity) {
    return EarnOpportunityModel(
      id: entity.id,
      threadId: entity.threadId,
      title: entity.title,
      description: entity.description,
      earningType: entity.earningType.name,
      tokenReward: entity.tokenReward,
      streakPoints: entity.streakPoints,
      mediaType: entity.mediaType.name,
      mediaUrl: entity.mediaUrl,
      questions: entity.questions
          .map((q) => SurveyQuestionModel.fromEntity(q))
          .toList(),
      durationSeconds: entity.durationSeconds,
      expiresAt: entity.expiresAt,
      isActive: entity.isActive,
      clientId: entity.clientId,
      clientName: entity.clientName,
      clientAvatarColor: entity.clientAvatarColor,
      campaignId: entity.campaignId,
      targeting: entity.targeting?.toJson(),
      // Bonus reward configuration
      bonusReward: entity.bonusReward,
      bonusRewardMultiplier: entity.bonusRewardMultiplier,
      bonusIntervalType: entity.bonusIntervalType != null
          ? _bonusIntervalTypeToString(entity.bonusIntervalType!)
          : null,
      bonusIntervalX: entity.bonusIntervalX,
      userEngagementStatus: entity.userEngagementStatus,
      userEngagementId: entity.userEngagementId,
      // AdMob configuration
      adUnitId: entity.adUnitId,
      dailyLimitPerUser: entity.dailyLimitPerUser,
      // Budget cap fields
      budgetExhausted: entity.budgetExhausted,
      tokenBudget: entity.tokenBudget,
      tokenSpent: entity.tokenSpent,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'id': id,
      'threadId': threadId,
      'title': title,
      'description': description,
      'earningType': earningType,
      'tokenReward': tokenReward,
      'streakPoints': streakPoints,
      'mediaType': mediaType,
      'mediaUrl': mediaUrl,
      'questions': questions.map((q) => q.toFirestoreJson()).toList(),
      'durationSeconds': durationSeconds,
      'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
      'isActive': isActive,
      'clientId': clientId,
      'clientName': clientName,
      'clientAvatarColor': clientAvatarColor,
      'campaignId': campaignId,
      'targeting': targeting,
      // Bonus reward configuration
      'bonusReward': bonusReward,
      'bonusRewardMultiplier': bonusRewardMultiplier,
      'bonusIntervalType': bonusIntervalType,
      'bonusIntervalX': bonusIntervalX,
      // AdMob configuration
      if (adUnitId != null) 'adUnitId': adUnitId,
      'dailyLimitPerUser': dailyLimitPerUser,
      // Budget cap fields
      'budgetExhausted': budgetExhausted,
      if (tokenBudget != null) 'tokenBudget': tokenBudget,
      'tokenSpent': tokenSpent,
    };
  }

  static MediaType _parseMediaType(String type) {
    switch (type) {
      case 'video':
        return MediaType.video;
      case 'image':
        return MediaType.image;
      case 'text':
        return MediaType.text;
      case 'adMob':
        return MediaType.adMob;
      default:
        return MediaType.video;
    }
  }

  static EarningType _parseEarningType(String type) {
    switch (type) {
      case 'survey':
        return EarningType.survey;
      case 'video':
        return EarningType.video;
      case 'trivia':
        return EarningType.trivia;
      case 'rating':
        return EarningType.rating;
      case 'poll':
        return EarningType.poll;
      case 'adVideo':
        return EarningType.adVideo;
      default:
        return EarningType.video;
    }
  }

  static BonusIntervalType? _parseBonusIntervalType(String? type) {
    if (type == null) return null;
    switch (type) {
      case 'random':
        return BonusIntervalType.random;
      case 'every_x':
        return BonusIntervalType.everyX;
      default:
        return null;
    }
  }

  static String? _bonusIntervalTypeToString(BonusIntervalType type) {
    switch (type) {
      case BonusIntervalType.random:
        return 'random';
      case BonusIntervalType.everyX:
        return 'every_x';
    }
  }
}
