// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PollOption _$PollOptionFromJson(Map<String, dynamic> json) =>
    _PollOption(id: json['id'] as String, text: json['text'] as String);

Map<String, dynamic> _$PollOptionToJson(_PollOption instance) =>
    <String, dynamic>{'id': instance.id, 'text': instance.text};

_Poll _$PollFromJson(Map<String, dynamic> json) => _Poll(
  id: json['id'] as String,
  opportunityId: json['opportunityId'] as String,
  threadId: json['threadId'] as String,
  clientId: json['clientId'] as String,
  question: json['question'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => PollOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: $enumDecode(_$PollStatusEnumMap, json['status']),
  isAnonymous: json['isAnonymous'] as bool? ?? false,
  showResultsAfterVote: json['showResultsAfterVote'] as bool? ?? true,
  allowChangeVote: json['allowChangeVote'] as bool? ?? true,
  openedAt: json['openedAt'] == null
      ? null
      : DateTime.parse(json['openedAt'] as String),
  closedAt: json['closedAt'] == null
      ? null
      : DateTime.parse(json['closedAt'] as String),
  totalRespondents: (json['totalRespondents'] as num?)?.toInt() ?? 0,
  optionCounts:
      (json['optionCounts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  createdBy: json['createdBy'] as String,
);

Map<String, dynamic> _$PollToJson(_Poll instance) => <String, dynamic>{
  'id': instance.id,
  'opportunityId': instance.opportunityId,
  'threadId': instance.threadId,
  'clientId': instance.clientId,
  'question': instance.question,
  'options': instance.options,
  'status': _$PollStatusEnumMap[instance.status]!,
  'isAnonymous': instance.isAnonymous,
  'showResultsAfterVote': instance.showResultsAfterVote,
  'allowChangeVote': instance.allowChangeVote,
  'openedAt': instance.openedAt?.toIso8601String(),
  'closedAt': instance.closedAt?.toIso8601String(),
  'totalRespondents': instance.totalRespondents,
  'optionCounts': instance.optionCounts,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'createdBy': instance.createdBy,
};

const _$PollStatusEnumMap = {
  PollStatus.draft: 'draft',
  PollStatus.open: 'open',
  PollStatus.closed: 'closed',
  PollStatus.archived: 'archived',
};

_PollResponse _$PollResponseFromJson(Map<String, dynamic> json) =>
    _PollResponse(
      userId: json['userId'] as String,
      pollId: json['pollId'] as String,
      selectedOption: json['selectedOption'] as String,
      previousOption: json['previousOption'] as String?,
      voteCount: (json['voteCount'] as num?)?.toInt() ?? 1,
      respondedAt: DateTime.parse(json['respondedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as String? ?? 'valid',
      invalidatedAt: json['invalidatedAt'] == null
          ? null
          : DateTime.parse(json['invalidatedAt'] as String),
      invalidatedBy: json['invalidatedBy'] as String?,
      invalidationReason: json['invalidationReason'] as String?,
      engagementId: json['engagementId'] as String?,
      tokensAwarded: json['tokensAwarded'] as bool? ?? false,
      demographics: (json['demographics'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      ),
    );

Map<String, dynamic> _$PollResponseToJson(_PollResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'pollId': instance.pollId,
      'selectedOption': instance.selectedOption,
      'previousOption': instance.previousOption,
      'voteCount': instance.voteCount,
      'respondedAt': instance.respondedAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'invalidatedAt': instance.invalidatedAt?.toIso8601String(),
      'invalidatedBy': instance.invalidatedBy,
      'invalidationReason': instance.invalidationReason,
      'engagementId': instance.engagementId,
      'tokensAwarded': instance.tokensAwarded,
      'demographics': instance.demographics,
    };

_PollResults _$PollResultsFromJson(Map<String, dynamic> json) => _PollResults(
  totalRespondents: (json['totalRespondents'] as num).toInt(),
  optionCounts: Map<String, int>.from(json['optionCounts'] as Map),
  percentages: (json['percentages'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$PollResultsToJson(_PollResults instance) =>
    <String, dynamic>{
      'totalRespondents': instance.totalRespondents,
      'optionCounts': instance.optionCounts,
      'percentages': instance.percentages,
    };
