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
  final bool isAnonymous;
  final bool showResultsAfterVote;
  final bool allowChangeVote;
  final DateTime? openedAt;
  final DateTime? closedAt;
  final int totalRespondents;
  final Map<String, int> optionCounts;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String createdBy;

  PollModel({
    required this.id,
    required this.opportunityId,
    required this.threadId,
    required this.clientId,
    required this.question,
    required this.options,
    required this.status,
    this.isAnonymous = false,
    this.showResultsAfterVote = true,
    this.allowChangeVote = true,
    this.openedAt,
    this.closedAt,
    this.totalRespondents = 0,
    this.optionCounts = const {},
    required this.createdAt,
    this.updatedAt,
    required this.createdBy,
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
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      showResultsAfterVote: json['showResultsAfterVote'] as bool? ?? true,
      allowChangeVote: json['allowChangeVote'] as bool? ?? true,
      openedAt: _parseTimestamp(json['openedAt']),
      closedAt: _parseTimestamp(json['closedAt']),
      totalRespondents: json['totalRespondents'] as int? ?? 0,
      optionCounts: (json['optionCounts'] as Map?)?.map(
              (k, v) => MapEntry(k as String, (v as num).toInt())) ??
          {},
      createdAt: _parseTimestamp(json['createdAt']) ?? DateTime.now(),
      updatedAt: _parseTimestamp(json['updatedAt']),
      createdBy: json['createdBy'] as String? ?? '',
    );
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
      isAnonymous: isAnonymous,
      showResultsAfterVote: showResultsAfterVote,
      allowChangeVote: allowChangeVote,
      openedAt: openedAt,
      closedAt: closedAt,
      totalRespondents: totalRespondents,
      optionCounts: optionCounts,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
    );
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

  PollOptionModel({required this.id, required this.text});

  factory PollOptionModel.fromJson(Map<String, dynamic> json) {
    return PollOptionModel(
      id: json['id'] as String,
      text: json['text'] as String,
    );
  }

  PollOption toEntity() {
    return PollOption(id: id, text: text);
  }
}

/// Poll response model
class PollResponseModel {
  final String userId;
  final String pollId;
  final String selectedOption;
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

  PollResponseModel({
    required this.userId,
    required this.pollId,
    required this.selectedOption,
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
  });

  factory PollResponseModel.fromJson(Map<String, dynamic> json) {
    return PollResponseModel(
      userId: json['userId'] as String,
      pollId: json['pollId'] as String,
      selectedOption: json['selectedOption'] as String,
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
    );
  }

  PollResponse toEntity() {
    return PollResponse(
      userId: userId,
      pollId: pollId,
      selectedOption: selectedOption,
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
    );
  }
}
