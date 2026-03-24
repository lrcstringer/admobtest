import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/poll.dart';

/// Poll model for Firestore serialization
class PollModel {
  final String id;
  final String opportunityId;
  final String threadId;
  final String clientId;
  final String question;
  final List<PollOptionModel> options;
  final String status;
  final String questionType; // 'multipleChoice', 'ranking', 'text', 'scale'
  final bool isAnonymous;
  final bool allowChangeVote;
  final bool allowMultipleSelections;
  final int? maxSelections;
  final DateTime? closesAt;
  final int? minResponsesForResults;
  final String resultVisibility; // 'immediate', 'afterClose', 'afterThreshold'
  final bool allowOtherOption;
  final DateTime? openedAt;
  final DateTime? closedAt;
  final int totalRespondents;
  final Map<String, int> optionCounts;
  // Scale question config
  final int scaleMin;
  final int scaleMax;
  final String? scaleMinLabel;
  final String? scaleMaxLabel;
  final List<String> scaleIntermediateLabels;
  // Text question config
  final int textMinLength;
  final int textMaxLength;
  // Type-specific aggregation
  final Map<String, double> averageRanks;
  final Map<String, double> averageRatings;
  final Map<String, Map<String, int>> ratingDistribution;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String createdBy;
  final bool showResultsAfterVote; // Legacy field

  PollModel({
    required this.id,
    required this.opportunityId,
    required this.threadId,
    required this.clientId,
    required this.question,
    required this.options,
    required this.status,
    this.questionType = 'multipleChoice',
    this.isAnonymous = false,
    this.allowChangeVote = true,
    this.allowMultipleSelections = false,
    this.maxSelections,
    this.closesAt,
    this.minResponsesForResults,
    this.resultVisibility = 'immediate',
    this.allowOtherOption = false,
    this.openedAt,
    this.closedAt,
    this.totalRespondents = 0,
    this.optionCounts = const {},
    this.scaleMin = 1,
    this.scaleMax = 10,
    this.scaleMinLabel,
    this.scaleMaxLabel,
    this.scaleIntermediateLabels = const [],
    this.textMinLength = 1,
    this.textMaxLength = 500,
    this.averageRanks = const {},
    this.averageRatings = const {},
    this.ratingDistribution = const {},
    required this.createdAt,
    this.updatedAt,
    required this.createdBy,
    this.showResultsAfterVote = true,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'] as String,
      opportunityId: json['opportunityId'] as String,
      threadId: json['threadId'] as String,
      clientId: json['clientId'] as String,
      question: json['question'] as String,
      options: (json['options'] as List?)
              ?.map((e) =>
                  PollOptionModel.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      status: json['status'] as String? ?? 'draft',
      questionType: json['questionType'] as String? ?? 'multipleChoice',
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      allowChangeVote: json['allowChangeVote'] as bool? ?? true,
      allowMultipleSelections:
          json['allowMultipleSelections'] as bool? ?? false,
      maxSelections: json['maxSelections'] as int?,
      closesAt: _parseTimestamp(json['closesAt']),
      minResponsesForResults: json['minResponsesForResults'] as int?,
      resultVisibility: json['resultVisibility'] as String? ?? 'immediate',
      allowOtherOption: json['allowOtherOption'] as bool? ?? false,
      openedAt: _parseTimestamp(json['openedAt']),
      closedAt: _parseTimestamp(json['closedAt']),
      totalRespondents: json['totalRespondents'] as int? ?? 0,
      optionCounts: (json['optionCounts'] as Map?)?.map(
              (k, v) => MapEntry(k as String, (v as num).toInt())) ??
          {},
      scaleMin: json['scaleMin'] as int? ?? 1,
      scaleMax: json['scaleMax'] as int? ?? 10,
      scaleMinLabel: json['scaleMinLabel'] as String?,
      scaleMaxLabel: json['scaleMaxLabel'] as String?,
      scaleIntermediateLabels: (json['scaleIntermediateLabels'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      textMinLength: json['textMinLength'] as int? ?? 1,
      textMaxLength: json['textMaxLength'] as int? ?? 500,
      averageRanks: (json['averageRanks'] as Map?)?.map(
              (k, v) => MapEntry(k as String, (v as num).toDouble())) ??
          {},
      averageRatings: (json['averageRatings'] as Map?)?.map(
              (k, v) => MapEntry(k as String, (v as num).toDouble())) ??
          {},
      ratingDistribution: _parseRatingDistribution(json['ratingDistribution']),
      createdAt: _parseTimestamp(json['createdAt']) ?? DateTime.now(),
      updatedAt: _parseTimestamp(json['updatedAt']),
      createdBy: json['createdBy'] as String? ?? '',
      showResultsAfterVote: json['showResultsAfterVote'] as bool? ?? true,
    );
  }

  static Map<String, Map<String, int>> _parseRatingDistribution(dynamic value) {
    if (value == null || value is! Map) return {};
    return value.map((optId, dist) {
      final inner = (dist as Map?)?.map(
              (k, v) => MapEntry(k.toString(), (v as num).toInt())) ??
          <String, int>{};
      return MapEntry(optId as String, inner);
    });
  }

  static PollQuestionType _parsePollQuestionType(String value) {
    switch (value) {
      case 'ranking':
        return PollQuestionType.ranking;
      case 'text':
        return PollQuestionType.text;
      case 'scale':
        return PollQuestionType.scale;
      default:
        return PollQuestionType.multipleChoice;
    }
  }

  static DateTime? _parseTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    return null;
  }

  Poll toEntity() {
    return Poll(
      id: id,
      opportunityId: opportunityId,
      threadId: threadId,
      clientId: clientId,
      question: question,
      options: options.map((o) => o.toEntity()).toList(),
      status: _parsePollStatus(status),
      questionType: _parsePollQuestionType(questionType),
      isAnonymous: isAnonymous,
      allowChangeVote: allowChangeVote,
      allowMultipleSelections: allowMultipleSelections,
      maxSelections: maxSelections,
      closesAt: closesAt,
      minResponsesForResults: minResponsesForResults,
      resultVisibility: _parseResultVisibility(resultVisibility),
      allowOtherOption: allowOtherOption,
      openedAt: openedAt,
      closedAt: closedAt,
      totalRespondents: totalRespondents,
      optionCounts: optionCounts,
      scaleMin: scaleMin,
      scaleMax: scaleMax,
      scaleMinLabel: scaleMinLabel,
      scaleMaxLabel: scaleMaxLabel,
      scaleIntermediateLabels: scaleIntermediateLabels,
      textMinLength: textMinLength,
      textMaxLength: textMaxLength,
      averageRanks: averageRanks,
      averageRatings: averageRatings,
      ratingDistribution: ratingDistribution,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      showResultsAfterVote: showResultsAfterVote,
    );
  }

  static ResultVisibility _parseResultVisibility(String value) {
    switch (value) {
      case 'afterClose':
        return ResultVisibility.afterClose;
      case 'afterThreshold':
        return ResultVisibility.afterThreshold;
      default:
        return ResultVisibility.immediate;
    }
  }

  static PollStatus _parsePollStatus(String status) {
    switch (status) {
      case 'draft':
        return PollStatus.draft;
      case 'open':
        return PollStatus.open;
      case 'closed':
        return PollStatus.closed;
      case 'archived':
        return PollStatus.archived;
      default:
        return PollStatus.draft;
    }
  }
}

class PollOptionModel {
  final String id;
  final String text;
  final String? mediaUrl;
  final String? mediaType; // 'image' or 'video'

  PollOptionModel({
    required this.id,
    required this.text,
    this.mediaUrl,
    this.mediaType,
  });

  factory PollOptionModel.fromJson(Map<String, dynamic> json) {
    return PollOptionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: json['mediaType'] as String?,
    );
  }

  PollOption toEntity() {
    return PollOption(
      id: id,
      text: text,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
    );
  }
}

/// Poll response model
class PollResponseModel {
  final String userId;
  final String pollId;
  final String selectedOption;
  final List<String> selectedOptions;
  final String? previousOption;
  final int voteCount;
  final DateTime respondedAt;
  final DateTime? updatedAt;
  final String status;
  final DateTime? invalidatedAt;
  final String? invalidatedBy;
  final String? invalidationReason;
  final String? engagementId;
  final bool tokensAwarded;
  final Map<String, String?>? demographics;
  final String? otherText;
  // Ranking response
  final List<String> rankedOptions;
  // Text response
  final String? textResponse;
  // Scale response
  final Map<String, int> scaleRatings;

  PollResponseModel({
    required this.userId,
    required this.pollId,
    required this.selectedOption,
    this.selectedOptions = const [],
    this.previousOption,
    this.voteCount = 1,
    required this.respondedAt,
    this.updatedAt,
    this.status = 'valid',
    this.invalidatedAt,
    this.invalidatedBy,
    this.invalidationReason,
    this.engagementId,
    this.tokensAwarded = false,
    this.demographics,
    this.otherText,
    this.rankedOptions = const [],
    this.textResponse,
    this.scaleRatings = const {},
  });

  factory PollResponseModel.fromJson(Map<String, dynamic> json) {
    return PollResponseModel(
      userId: json['userId'] as String,
      pollId: json['pollId'] as String,
      selectedOption: json['selectedOption'] as String,
      selectedOptions: (json['selectedOptions'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      previousOption: json['previousOption'] as String?,
      voteCount: json['voteCount'] as int? ?? 1,
      respondedAt: PollModel._parseTimestamp(json['respondedAt']) ??
          DateTime.now(),
      updatedAt: PollModel._parseTimestamp(json['updatedAt']),
      status: json['status'] as String? ?? 'valid',
      invalidatedAt: PollModel._parseTimestamp(json['invalidatedAt']),
      invalidatedBy: json['invalidatedBy'] as String?,
      invalidationReason: json['invalidationReason'] as String?,
      engagementId: json['engagementId'] as String?,
      tokensAwarded: json['tokensAwarded'] as bool? ?? false,
      demographics: (json['demographics'] as Map?)?.map(
          (k, v) => MapEntry(k as String, v as String?)),
      otherText: json['otherText'] as String?,
      rankedOptions: (json['rankedOptions'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      textResponse: json['textResponse'] as String?,
      scaleRatings: (json['scaleRatings'] as Map?)?.map(
              (k, v) => MapEntry(k as String, (v as num).toInt())) ??
          {},
    );
  }

  PollResponse toEntity() {
    return PollResponse(
      userId: userId,
      pollId: pollId,
      selectedOption: selectedOption,
      selectedOptions: selectedOptions,
      previousOption: previousOption,
      voteCount: voteCount,
      respondedAt: respondedAt,
      updatedAt: updatedAt,
      status: status,
      invalidatedAt: invalidatedAt,
      invalidatedBy: invalidatedBy,
      invalidationReason: invalidationReason,
      engagementId: engagementId,
      tokensAwarded: tokensAwarded,
      demographics: demographics,
      otherText: otherText,
      rankedOptions: rankedOptions,
      textResponse: textResponse,
      scaleRatings: scaleRatings,
    );
  }
}
