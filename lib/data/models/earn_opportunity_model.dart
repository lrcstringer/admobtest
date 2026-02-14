import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/earn_opportunity.dart';
import '../../domain/entities/targeting_criteria.dart';

part 'earn_opportunity_model.freezed.dart';

@freezed
class BranchRuleModel with _$BranchRuleModel {
  const factory BranchRuleModel({
    required String optionValue,
    required String goToQuestionId,
  }) = _BranchRuleModel;

  const BranchRuleModel._();

  factory BranchRuleModel.fromJson(Map<String, dynamic> json) {
    return BranchRuleModel(
      optionValue: json['optionValue'] as String,
      goToQuestionId: json['goToQuestionId'] as String,
    );
  }

  BranchRule toEntity() {
    return BranchRule(
      optionValue: optionValue,
      goToQuestionId: goToQuestionId,
    );
  }

  factory BranchRuleModel.fromEntity(BranchRule entity) {
    return BranchRuleModel(
      optionValue: entity.optionValue,
      goToQuestionId: entity.goToQuestionId,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'optionValue': optionValue,
      'goToQuestionId': goToQuestionId,
    };
  }
}

@freezed
class SurveyQuestionModel with _$SurveyQuestionModel {
  const factory SurveyQuestionModel({
    required String id,
    required String text,
    required int orderIndex,
    required String questionType,
    @Default(true) bool isRequired,

    // single_select + multi_select
    @Default([]) List<String> options,
    int? maxSelections,

    // text_input
    @Default(1) int textInputCount,
    @Default(50) int textMaxLength,

    // likert
    @Default(5) int likertScale,
    String? likertLowLabel,
    String? likertHighLabel,

    // star_tags
    @Default(5) int maxStars,
    @Default([]) List<String> tags,
    int? maxTags,

    // slider
    @Default(0) int sliderMin,
    @Default(100) int sliderMax,
    @Default(1) int sliderStep,
    String? sliderMinLabel,
    String? sliderMaxLabel,

    // attention check
    @Default(false) bool isAttentionCheck,
    String? correctAnswer,

    // branching
    @Default([]) List<BranchRuleModel> branchRules,
  }) = _SurveyQuestionModel;

  const SurveyQuestionModel._();

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) {
    return SurveyQuestionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      orderIndex: json['orderIndex'] as int? ?? 0,
      questionType: json['questionType'] as String? ?? 'single_select',
      isRequired: json['required'] as bool? ?? true,
      options: (json['options'] as List?)?.map((e) => e as String).toList() ?? [],
      maxSelections: json['maxSelections'] as int?,
      textInputCount: json['textInputCount'] as int? ?? 1,
      textMaxLength: json['textMaxLength'] as int? ?? 50,
      likertScale: json['likertScale'] as int? ?? 5,
      likertLowLabel: json['likertLowLabel'] as String?,
      likertHighLabel: json['likertHighLabel'] as String?,
      maxStars: json['maxStars'] as int? ?? 5,
      tags: (json['tags'] as List?)?.map((e) => e as String).toList() ?? [],
      maxTags: json['maxTags'] as int?,
      sliderMin: json['sliderMin'] as int? ?? 0,
      sliderMax: json['sliderMax'] as int? ?? 100,
      sliderStep: json['sliderStep'] as int? ?? 1,
      sliderMinLabel: json['sliderMinLabel'] as String?,
      sliderMaxLabel: json['sliderMaxLabel'] as String?,
      isAttentionCheck: json['isAttentionCheck'] as bool? ?? false,
      correctAnswer: json['correctAnswer'] as String?,
      branchRules: (json['branchRules'] as List?)
              ?.map((e) => BranchRuleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  SurveyQuestion toEntity() {
    return SurveyQuestion(
      id: id,
      text: text,
      orderIndex: orderIndex,
      questionType: _parseQuestionType(questionType),
      isRequired: isRequired,
      options: options,
      maxSelections: maxSelections,
      textInputCount: textInputCount,
      textMaxLength: textMaxLength,
      likertScale: likertScale,
      likertLowLabel: likertLowLabel,
      likertHighLabel: likertHighLabel,
      maxStars: maxStars,
      tags: tags,
      maxTags: maxTags,
      sliderMin: sliderMin,
      sliderMax: sliderMax,
      sliderStep: sliderStep,
      sliderMinLabel: sliderMinLabel,
      sliderMaxLabel: sliderMaxLabel,
      isAttentionCheck: isAttentionCheck,
      correctAnswer: correctAnswer,
      branchRules: branchRules.map((r) => r.toEntity()).toList(),
    );
  }

  factory SurveyQuestionModel.fromEntity(SurveyQuestion entity) {
    return SurveyQuestionModel(
      id: entity.id,
      text: entity.text,
      orderIndex: entity.orderIndex,
      questionType: entity.questionType.name,
      isRequired: entity.isRequired,
      options: entity.options,
      maxSelections: entity.maxSelections,
      textInputCount: entity.textInputCount,
      textMaxLength: entity.textMaxLength,
      likertScale: entity.likertScale,
      likertLowLabel: entity.likertLowLabel,
      likertHighLabel: entity.likertHighLabel,
      maxStars: entity.maxStars,
      tags: entity.tags,
      maxTags: entity.maxTags,
      sliderMin: entity.sliderMin,
      sliderMax: entity.sliderMax,
      sliderStep: entity.sliderStep,
      sliderMinLabel: entity.sliderMinLabel,
      sliderMaxLabel: entity.sliderMaxLabel,
      isAttentionCheck: entity.isAttentionCheck,
      correctAnswer: entity.correctAnswer,
      branchRules: entity.branchRules
          .map((r) => BranchRuleModel.fromEntity(r))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'id': id,
      'text': text,
      'orderIndex': orderIndex,
      'questionType': questionType,
      'required': isRequired,
      if (options.isNotEmpty) 'options': options,
      if (maxSelections != null) 'maxSelections': maxSelections,
      'textInputCount': textInputCount,
      'textMaxLength': textMaxLength,
      'likertScale': likertScale,
      if (likertLowLabel != null) 'likertLowLabel': likertLowLabel,
      if (likertHighLabel != null) 'likertHighLabel': likertHighLabel,
      'maxStars': maxStars,
      if (tags.isNotEmpty) 'tags': tags,
      if (maxTags != null) 'maxTags': maxTags,
      'sliderMin': sliderMin,
      'sliderMax': sliderMax,
      'sliderStep': sliderStep,
      if (sliderMinLabel != null) 'sliderMinLabel': sliderMinLabel,
      if (sliderMaxLabel != null) 'sliderMaxLabel': sliderMaxLabel,
      if (isAttentionCheck) 'isAttentionCheck': isAttentionCheck,
      if (correctAnswer != null) 'correctAnswer': correctAnswer,
      if (branchRules.isNotEmpty)
        'branchRules': branchRules.map((r) => r.toFirestoreJson()).toList(),
    };
  }

  static QuestionType _parseQuestionType(String type) {
    switch (type) {
      case 'single_select':
      case 'singleSelect':
        return QuestionType.singleSelect;
      case 'multi_select':
      case 'multiSelect':
        return QuestionType.multiSelect;
      case 'text_input':
      case 'textInput':
        return QuestionType.textInput;
      case 'likert':
        return QuestionType.likert;
      case 'star_tags':
      case 'starTags':
        return QuestionType.starTags;
      case 'slider':
        return QuestionType.slider;
      default:
        return QuestionType.singleSelect;
    }
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
    // Pin/feature flags for ordering
    @Default(false) bool isPinned,
    @Default(false) bool isFeatured,
    // Denormalized client info
    String? clientId,
    String? clientName,
    String? clientAvatarColor,
    String? clientAvatarImage,
    String? threadImage,
    String? opportunityImage,
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
    // Poll link
    String? pollId,
    // Upload configuration
    String? uploadPrompt,
    String? uploadContextMediaUrl,
    String? uploadContextMediaType,
    @Default(false) bool uploadVideoEnabled,
    @Default(false) bool uploadImageEnabled,
    @Default(false) bool uploadTextEnabled,
    @Default(false) bool uploadVideoRequired,
    @Default(false) bool uploadImageRequired,
    @Default(false) bool uploadTextRequired,
    @Default(60) int uploadVideoMaxSeconds,
    @Default(10) int uploadTextMinChars,
    @Default(1500) int uploadTextMaxChars,
    @Default(false) bool requiresAdminReview,
    // Reward campaign linkage
    String? rewardCampaignId,
    String? rewardCampaignName,
    String? rewardType,
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
      isPinned: json['isPinned'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      // Client info (with legacy brandName fallback)
      clientId: json['clientId'] as String?,
      clientName: json['clientName'] as String? ?? json['brandName'] as String?,
      clientAvatarColor: json['clientAvatarColor'] as String? ??
          json['brandAvatarColor'] as String?,
      clientAvatarImage: json['clientAvatarImage'] as String?,
      threadImage: json['threadImage'] as String?,
      opportunityImage: json['opportunityImage'] as String?,
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
      // Poll link
      pollId: json['pollId'] as String?,
      // Upload configuration
      uploadPrompt: json['uploadPrompt'] as String?,
      uploadContextMediaUrl: json['uploadContextMediaUrl'] as String?,
      uploadContextMediaType: json['uploadContextMediaType'] as String?,
      uploadVideoEnabled: json['uploadVideoEnabled'] as bool? ?? false,
      uploadImageEnabled: json['uploadImageEnabled'] as bool? ?? false,
      uploadTextEnabled: json['uploadTextEnabled'] as bool? ?? false,
      uploadVideoRequired: json['uploadVideoRequired'] as bool? ?? false,
      uploadImageRequired: json['uploadImageRequired'] as bool? ?? false,
      uploadTextRequired: json['uploadTextRequired'] as bool? ?? false,
      uploadVideoMaxSeconds: json['uploadVideoMaxSeconds'] as int? ?? 60,
      uploadTextMinChars: json['uploadTextMinChars'] as int? ?? 10,
      uploadTextMaxChars: json['uploadTextMaxChars'] as int? ?? 1500,
      requiresAdminReview: json['requiresAdminReview'] as bool? ?? false,
      // Reward campaign linkage
      rewardCampaignId: json['rewardCampaignId'] as String?,
      rewardCampaignName: json['rewardCampaignName'] as String?,
      rewardType: json['rewardType'] as String?,
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
      isPinned: isPinned,
      isFeatured: isFeatured,
      clientId: clientId,
      clientName: clientName,
      clientAvatarColor: clientAvatarColor,
      clientAvatarImage: clientAvatarImage,
      threadImage: threadImage,
      opportunityImage: opportunityImage,
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
      // Poll link
      pollId: pollId,
      // Upload configuration
      uploadPrompt: uploadPrompt,
      uploadContextMediaUrl: uploadContextMediaUrl,
      uploadContextMediaType: uploadContextMediaType,
      uploadVideoEnabled: uploadVideoEnabled,
      uploadImageEnabled: uploadImageEnabled,
      uploadTextEnabled: uploadTextEnabled,
      uploadVideoRequired: uploadVideoRequired,
      uploadImageRequired: uploadImageRequired,
      uploadTextRequired: uploadTextRequired,
      uploadVideoMaxSeconds: uploadVideoMaxSeconds,
      uploadTextMinChars: uploadTextMinChars,
      uploadTextMaxChars: uploadTextMaxChars,
      requiresAdminReview: requiresAdminReview,
      // Reward campaign linkage
      rewardCampaignId: rewardCampaignId,
      rewardCampaignName: rewardCampaignName,
      rewardType: rewardType,
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
      isPinned: entity.isPinned,
      isFeatured: entity.isFeatured,
      clientId: entity.clientId,
      clientName: entity.clientName,
      clientAvatarColor: entity.clientAvatarColor,
      clientAvatarImage: entity.clientAvatarImage,
      threadImage: entity.threadImage,
      opportunityImage: entity.opportunityImage,
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
      // Poll link
      pollId: entity.pollId,
      // Upload configuration
      uploadPrompt: entity.uploadPrompt,
      uploadContextMediaUrl: entity.uploadContextMediaUrl,
      uploadContextMediaType: entity.uploadContextMediaType,
      uploadVideoEnabled: entity.uploadVideoEnabled,
      uploadImageEnabled: entity.uploadImageEnabled,
      uploadTextEnabled: entity.uploadTextEnabled,
      uploadVideoRequired: entity.uploadVideoRequired,
      uploadImageRequired: entity.uploadImageRequired,
      uploadTextRequired: entity.uploadTextRequired,
      uploadVideoMaxSeconds: entity.uploadVideoMaxSeconds,
      uploadTextMinChars: entity.uploadTextMinChars,
      uploadTextMaxChars: entity.uploadTextMaxChars,
      requiresAdminReview: entity.requiresAdminReview,
      // Reward campaign linkage
      rewardCampaignId: entity.rewardCampaignId,
      rewardCampaignName: entity.rewardCampaignName,
      rewardType: entity.rewardType,
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
      'clientAvatarImage': clientAvatarImage,
      'threadImage': threadImage,
      'opportunityImage': opportunityImage,
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
      // Poll link
      if (pollId != null) 'pollId': pollId,
      // Upload configuration
      if (uploadPrompt != null) 'uploadPrompt': uploadPrompt,
      if (uploadContextMediaUrl != null)
        'uploadContextMediaUrl': uploadContextMediaUrl,
      if (uploadContextMediaType != null)
        'uploadContextMediaType': uploadContextMediaType,
      'uploadVideoEnabled': uploadVideoEnabled,
      'uploadImageEnabled': uploadImageEnabled,
      'uploadTextEnabled': uploadTextEnabled,
      'uploadVideoRequired': uploadVideoRequired,
      'uploadImageRequired': uploadImageRequired,
      'uploadTextRequired': uploadTextRequired,
      'uploadVideoMaxSeconds': uploadVideoMaxSeconds,
      'uploadTextMinChars': uploadTextMinChars,
      'uploadTextMaxChars': uploadTextMaxChars,
      'requiresAdminReview': requiresAdminReview,
      // Reward campaign linkage
      if (rewardCampaignId != null) 'rewardCampaignId': rewardCampaignId,
      if (rewardCampaignName != null) 'rewardCampaignName': rewardCampaignName,
      if (rewardType != null) 'rewardType': rewardType,
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
      case 'image':
        return EarningType.image;
      case 'poll':
        return EarningType.poll;
      case 'adVideo':
        return EarningType.adVideo;
      case 'upload':
        return EarningType.upload;
      // Map legacy types to survey
      case 'trivia':
      case 'rating':
        return EarningType.survey;
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
