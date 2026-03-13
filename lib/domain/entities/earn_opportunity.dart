import 'package:freezed_annotation/freezed_annotation.dart';

import 'targeting_criteria.dart';

part 'earn_opportunity.freezed.dart';
part 'earn_opportunity.g.dart';

/// Media type for earn opportunity
enum MediaType {
  video,
  image,
  text,
  adMob,
}

/// Earning type for opportunity classification
enum EarningType {
  survey,
  video,
  image,
  poll,
  adVideo,
  upload,
}

/// Question type for survey engine
enum QuestionType {
  singleSelect,
  multiSelect,
  textInput,
  likert,
  starTags,
  slider,
}

/// Branch rule: if user selects [optionValue], skip to [goToQuestionId]
@freezed
abstract class BranchRule with _$BranchRule {
  const factory BranchRule({
    required String optionValue,
    required String goToQuestionId,
  }) = _BranchRule;

  factory BranchRule.fromJson(Map<String, dynamic> json) =>
      _$BranchRuleFromJson(json);
}

/// Survey question for earn opportunity — supports 6 question types + branching
@freezed
abstract class SurveyQuestion with _$SurveyQuestion {
  const factory SurveyQuestion({
    required String id,
    required String text,
    required int orderIndex,
    required QuestionType questionType,
    @Default(true) bool isRequired,

    // --- single_select + multi_select ---
    @Default([]) List<String> options,
    int? maxSelections, // multi_select only

    // --- text_input ---
    @Default(1) int textInputCount,
    @Default(50) int textMaxLength,

    // --- likert ---
    @Default(5) int likertScale,
    String? likertLowLabel,
    String? likertHighLabel,

    // --- star_tags ---
    @Default(5) int maxStars,
    @Default([]) List<String> tags,
    int? maxTags,

    // --- slider ---
    @Default(0) int sliderMin,
    @Default(100) int sliderMax,
    @Default(1) int sliderStep,
    String? sliderMinLabel,
    String? sliderMaxLabel,

    // --- Attention check (single_select only) ---
    @Default(false) bool isAttentionCheck,
    String? correctAnswer,

    // --- Branching (single_select only) ---
    @Default([]) List<BranchRule> branchRules,
  }) = _SurveyQuestion;

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionFromJson(json);
}

/// Bonus interval type for opportunities
enum BonusIntervalType {
  random,
  everyX,
}

/// Earn opportunity (ad + survey combo)
@freezed
abstract class EarnOpportunity with _$EarnOpportunity {
  const factory EarnOpportunity({
    required String id,
    required String threadId,
    required String title,
    String? description,
    // Earning configuration
    required EarningType earningType,
    required int tokenReward,
    @Default(1) int streakPoints,
    required MediaType mediaType,
    String? mediaUrl,
    required List<SurveyQuestion> questions,
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
    // Targeting
    TargetingCriteria? targeting,
    // Bonus reward configuration
    @Default(false) bool bonusReward,
    @Default(1.0) double bonusRewardMultiplier,
    BonusIntervalType? bonusIntervalType,
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
    // Upload configuration (earningType == upload)
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
    // Token source (opportunity-level override; falls back to thread-level)
    String? tokenSourceAccountId,
    // Reward campaign linkage
    String? rewardCampaignId,
    String? rewardCampaignName,
    String? rewardType,
    @Default(1) int rewardQuantity,
  }) = _EarnOpportunity;

  const EarnOpportunity._();

  factory EarnOpportunity.fromJson(Map<String, dynamic> json) =>
      _$EarnOpportunityFromJson(json);

  /// Check if opportunity is expired
  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  /// Check if opportunity is available
  bool get isAvailable => isActive && !isExpired && !budgetExhausted;

  /// Check if user has completed this opportunity
  bool get isCompletedByUser =>
      userEngagementStatus == 'completed' ||
      userEngagementStatus == 'pending_review' ||
      userEngagementStatus == 'rewarded';

  /// Check if user has an in-progress engagement
  bool get isInProgressByUser =>
      userEngagementStatus == 'started' ||
      userEngagementStatus == 'watching' ||
      userEngagementStatus == 'surveying';

  /// Get days until expiry
  int? get daysUntilExpiry {
    if (expiresAt == null) return null;
    return expiresAt!.difference(DateTime.now()).inDays;
  }

  /// Get formatted duration
  String get formattedDuration {
    if (durationSeconds < 60) {
      return '${durationSeconds}s';
    }
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    if (seconds == 0) {
      return '${minutes}m';
    }
    return '${minutes}m ${seconds}s';
  }

  /// Get earning type display label
  String get earningTypeLabel {
    switch (earningType) {
      case EarningType.survey:
        return 'Survey';
      case EarningType.video:
        return 'Video';
      case EarningType.image:
        return 'Image';
      case EarningType.poll:
        return 'Poll';
      case EarningType.adVideo:
        return 'Watch & Earn';
      case EarningType.upload:
        return 'Upload';
    }
  }

  /// Check if this is an AdMob video opportunity
  bool get isAdMobOpportunity => earningType == EarningType.adVideo;

  /// Check if ad unit ID is configured
  bool get hasAdUnitId => adUnitId != null && adUnitId!.isNotEmpty;

  /// Check if this is a poll opportunity
  bool get isPollOpportunity =>
      earningType == EarningType.poll && pollId != null;

  /// Check if this opportunity has a linked reward campaign
  bool get hasRewardCampaign =>
      rewardCampaignId != null && rewardCampaignId!.isNotEmpty;
}
