import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll.freezed.dart';
part 'poll.g.dart';

/// Poll lifecycle status
enum PollStatus {
  draft,
  open,
  closed,
  archived,
}

/// Controls when poll results are visible to voters
enum ResultVisibility {
  /// Results shown immediately after voting
  immediate,

  /// Results only shown after poll is closed
  afterClose,

  /// Results shown after minimum response threshold is met
  afterThreshold,
}

/// A single poll option
@freezed
abstract class PollOption with _$PollOption {
  const factory PollOption({
    required String id,
    required String text,
    String? mediaUrl,
    String? mediaType, // 'image' or 'video'
  }) = _PollOption;

  factory PollOption.fromJson(Map<String, dynamic> json) =>
      _$PollOptionFromJson(json);
}

/// First-class poll entity with atomic counters
@freezed
abstract class Poll with _$Poll {
  const factory Poll({
    required String id,
    required String opportunityId,
    required String threadId,
    required String clientId,
    required String question,
    required List<PollOption> options,
    required PollStatus status,
    @Default(false) bool isAnonymous,
    @Default(true) bool allowChangeVote,
    // Multi-select support
    @Default(false) bool allowMultipleSelections,
    int? maxSelections,
    // Poll expiry/deadline (stored as UTC)
    DateTime? closesAt,
    // Minimum responses before results are visible (for afterThreshold)
    int? minResponsesForResults,
    // Result visibility control (replaces showResultsAfterVote)
    @Default(ResultVisibility.immediate) ResultVisibility resultVisibility,
    // "Other" free-text option
    @Default(false) bool allowOtherOption,
    DateTime? openedAt,
    DateTime? closedAt,
    @Default(0) int totalRespondents,
    @Default({}) Map<String, int> optionCounts,
    required DateTime createdAt,
    DateTime? updatedAt,
    required String createdBy,
    // Legacy field — kept for backward compat reads, not used for new logic
    @Default(true) bool showResultsAfterVote,
  }) = _Poll;

  const Poll._();

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  /// Get percentage for a given option
  double getOptionPercentage(String optionId) {
    if (totalRespondents == 0) return 0.0;
    final count = optionCounts[optionId] ?? 0;
    return (count / totalRespondents) * 100;
  }

  /// Check if poll is votable
  bool get isVotable => status == PollStatus.open;

  /// Check if results are visible (admin always sees, users depend on config)
  bool canSeeResults({required bool hasVoted, required bool isAdmin}) {
    if (isAdmin) return true;
    if (status == PollStatus.closed || status == PollStatus.archived) {
      return true;
    }
    if (!hasVoted) return false;
    switch (resultVisibility) {
      case ResultVisibility.immediate:
        return true;
      case ResultVisibility.afterClose:
        return false; // Only visible after close (handled above)
      case ResultVisibility.afterThreshold:
        final threshold = minResponsesForResults ?? 0;
        return totalRespondents >= threshold;
    }
  }

  /// Get the leading option ID
  String? get leadingOptionId {
    if (optionCounts.isEmpty) return null;
    return optionCounts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }
}

/// User's response to a poll
@freezed
abstract class PollResponse with _$PollResponse {
  const factory PollResponse({
    required String userId,
    required String pollId,
    required String selectedOption,
    // Multi-select: all selected option IDs
    @Default([]) List<String> selectedOptions,
    String? previousOption,
    @Default(1) int voteCount,
    required DateTime respondedAt,
    DateTime? updatedAt,
    @Default('valid') String status,
    DateTime? invalidatedAt,
    String? invalidatedBy,
    String? invalidationReason,
    String? engagementId,
    @Default(false) bool tokensAwarded,
    Map<String, String?>? demographics,
    // "Other" free-text response (max 200 chars)
    String? otherText,
  }) = _PollResponse;

  const PollResponse._();

  factory PollResponse.fromJson(Map<String, dynamic> json) =>
      _$PollResponseFromJson(json);

  bool get isValid => status == 'valid';
  bool get hasChangedVote => voteCount > 1;
}

/// Aggregated poll results
@freezed
abstract class PollResults with _$PollResults {
  const factory PollResults({
    required int totalRespondents,
    required Map<String, int> optionCounts,
    required Map<String, double> percentages,
  }) = _PollResults;

  factory PollResults.fromJson(Map<String, dynamic> json) =>
      _$PollResultsFromJson(json);
}
