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
  trivia,
  rating,
  poll,
  adVideo,
}

/// Survey question for earn opportunity
@freezed
class SurveyQuestion with _$SurveyQuestion {
  const factory SurveyQuestion({
    required String id,
    required String text,
    required List<String> options,
    required int orderIndex,
    bool? isAttentionCheck,
    String? correctAnswer,
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
class EarnOpportunity with _$EarnOpportunity {
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
  bool get isCompletedByUser => userEngagementStatus == 'completed';

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
      case EarningType.trivia:
        return 'Trivia';
      case EarningType.rating:
        return 'Rating';
      case EarningType.poll:
        return 'Poll';
      case EarningType.adVideo:
        return 'Watch & Earn';
    }
  }

  /// Check if this is an AdMob video opportunity
  bool get isAdMobOpportunity => earningType == EarningType.adVideo;

  /// Check if ad unit ID is configured
  bool get hasAdUnitId => adUnitId != null && adUnitId!.isNotEmpty;
}
