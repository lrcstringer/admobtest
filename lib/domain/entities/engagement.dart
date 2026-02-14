import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/engagement_status.dart';
import '../value_objects/engagement_evidence.dart';

part 'engagement.freezed.dart';
part 'engagement.g.dart';

/// Engagement entity representing a user's interaction with an earn opportunity
@freezed
class Engagement with _$Engagement {
  const factory Engagement({
    required String id,
    required String userId,
    String? audienceCampaignId,
    required String earnOpportunityId,
    required EngagementStatus status,
    required DateTime startedAt,
    DateTime? completedAt,
    required int watchDurationSeconds,
    required int requiredDurationSeconds,
    required List<SurveyResponse> answers,
    EngagementEvidence? evidence,
    double? tokensEarned,
    String? failureReason,
    required int attemptNumber,
    required DateTime createdAt,
    DateTime? updatedAt,
    // Denormalized fields for targeting queries
    /// Thread ID denormalized from opportunity
    String? threadId,
    /// Client ID denormalized from thread
    String? clientId,
    // Streak audit fields
    /// What day of streak this completion was on
    int? streakDayAtCompletion,
    /// Multiplier applied at time of completion (1.0, 1.2, 1.35, or 1.5)
    double? multiplierApplied,
    // AdMob tracking fields
    /// True when ad was fully watched
    @Default(false) bool adWatched,
    /// AdMob transaction ID for SSV verification
    String? adTransactionId,
    /// Timestamp when ad completed
    DateTime? adCompletedAt,
  }) = _Engagement;

  const Engagement._();

  factory Engagement.fromJson(Map<String, dynamic> json) =>
      _$EngagementFromJson(json);

  /// Check if engagement is complete
  bool get isComplete => status == EngagementStatus.completed;

  /// Check if engagement is in progress
  bool get isInProgress =>
      status == EngagementStatus.started ||
      status == EngagementStatus.watching ||
      status == EngagementStatus.surveying;

  /// Check if engagement failed
  bool get isFailed => status == EngagementStatus.failed;

  /// Get progress percentage (0.0 to 1.0)
  double get watchProgress {
    if (requiredDurationSeconds == 0) return 1.0;
    return (watchDurationSeconds / requiredDurationSeconds).clamp(0.0, 1.0);
  }

  /// Check if watch requirement is met
  bool get watchRequirementMet =>
      watchDurationSeconds >= requiredDurationSeconds;

  /// Check if ad was watched (for adVideo type)
  bool get hasWatchedAd => adWatched == true;
}

/// Type-discriminated survey response — supports all 6 question types
@freezed
class SurveyResponse with _$SurveyResponse {
  const factory SurveyResponse({
    required String questionId,
    required String questionType,
    required DateTime answeredAt,

    // single_select
    String? selectedOption,

    // multi_select
    List<String>? selectedOptions,

    // text_input
    List<String>? textResponses,

    // likert
    int? likertValue,

    // star_tags
    int? starRating,
    List<String>? selectedTags,

    // slider
    double? sliderValue,

    // attention check result
    bool? isCorrect,
  }) = _SurveyResponse;

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);
}

/// Legacy alias for code that still references EngagementAnswer
typedef EngagementAnswer = SurveyResponse;
