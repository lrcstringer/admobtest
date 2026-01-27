import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey.freezed.dart';
part 'survey.g.dart';

/// Represents a survey that users can complete to earn tokens
@freezed
class Survey with _$Survey {
  const factory Survey({
    required String id,
    required String campaignId,
    required String title,
    required String description,
    required List<SurveyQuestion> questions,
    required int tokenReward,
    required int estimatedMinutes,
    required SurveyStatus status,
    required DateTime createdAt,
    DateTime? expiresAt,
    int? maxResponses,
    int? currentResponses,
    Map<String, dynamic>? targetingCriteria,
  }) = _Survey;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
}

/// Represents a single question within a survey
@freezed
class SurveyQuestion with _$SurveyQuestion {
  const factory SurveyQuestion({
    required String id,
    required String text,
    required QuestionType type,
    required bool isRequired,
    List<String>? options,
    int? minValue,
    int? maxValue,
    String? placeholder,
  }) = _SurveyQuestion;

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionFromJson(json);
}

/// Status of a survey
enum SurveyStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('completed')
  completed,
  @JsonValue('expired')
  expired,
}

/// Type of survey question
enum QuestionType {
  @JsonValue('single_choice')
  singleChoice,
  @JsonValue('multiple_choice')
  multipleChoice,
  @JsonValue('text')
  text,
  @JsonValue('rating')
  rating,
  @JsonValue('scale')
  scale,
  @JsonValue('yes_no')
  yesNo,
}
