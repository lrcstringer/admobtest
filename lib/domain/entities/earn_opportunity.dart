import 'package:freezed_annotation/freezed_annotation.dart';

part 'earn_opportunity.freezed.dart';
part 'earn_opportunity.g.dart';

/// Media type for earn opportunity
enum MediaType {
  video,
  image,
  text,
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

/// Earn opportunity (ad + survey combo)
@freezed
class EarnOpportunity with _$EarnOpportunity {
  const factory EarnOpportunity({
    required String id,
    required String threadId,
    required String title,
    String? description,
    required int tokenReward,
    required MediaType mediaType,
    required String mediaUrl,
    required List<SurveyQuestion> questions,
    required int durationSeconds,
    DateTime? expiresAt,
    required bool isActive,
    String? brandName,
    String? brandAvatarColor,
    String? campaignId,
  }) = _EarnOpportunity;

  const EarnOpportunity._();

  factory EarnOpportunity.fromJson(Map<String, dynamic> json) =>
      _$EarnOpportunityFromJson(json);

  /// Check if opportunity is expired
  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  /// Check if opportunity is available
  bool get isAvailable => isActive && !isExpired;

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
}
