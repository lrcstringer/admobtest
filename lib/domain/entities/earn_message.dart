import 'package:freezed_annotation/freezed_annotation.dart';

part 'earn_message.freezed.dart';
part 'earn_message.g.dart';

/// Represents a message within an earn thread (ad viewing, survey response, etc.)
@freezed
abstract class EarnMessage with _$EarnMessage {
  const factory EarnMessage({
    required String id,
    required String threadId,
    required String userId,
    required EarnMessageType type,
    required String content,
    required DateTime createdAt,
    EarnMessageStatus? status,
    Map<String, dynamic>? metadata,
    /// For survey responses
    String? questionId,
    dynamic response,
    /// For ad interactions
    String? adId,
    int? watchDurationSeconds,
    /// Token amount earned from this message/action
    int? tokensEarned,
  }) = _EarnMessage;

  factory EarnMessage.fromJson(Map<String, dynamic> json) =>
      _$EarnMessageFromJson(json);
}

/// Type of earn message
enum EarnMessageType {
  @JsonValue('ad_started')
  adStarted,
  @JsonValue('ad_completed')
  adCompleted,
  @JsonValue('ad_skipped')
  adSkipped,
  @JsonValue('survey_started')
  surveyStarted,
  @JsonValue('survey_question_answered')
  surveyQuestionAnswered,
  @JsonValue('survey_completed')
  surveyCompleted,
  @JsonValue('survey_abandoned')
  surveyAbandoned,
  @JsonValue('reward_credited')
  rewardCredited,
  @JsonValue('system_message')
  systemMessage,
}

/// Status of an earn message
enum EarnMessageStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processed')
  processed,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
}
