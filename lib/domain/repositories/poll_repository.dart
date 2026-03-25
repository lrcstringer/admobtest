import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/poll.dart';

/// Poll repository interface
abstract class PollRepository {
  /// Submit a vote on a poll (polymorphic: data shape depends on questionType)
  Future<Either<Failure, PollResponse>> submitVote({
    required String pollId,
    required Map<String, dynamic> voteData,
  });

  /// Change an existing vote (polymorphic: data shape depends on questionType)
  Future<Either<Failure, PollResponse>> changeVote({
    required String pollId,
    required Map<String, dynamic> voteData,
  });

  /// Get poll results (counts + percentages)
  Future<Either<Failure, PollResults>> getPollResults(String pollId);

  /// Get the full raw poll data map returned by the CF (includes questionType,
  /// options, resultVisibility, hasVoted, etc.). Used by the interaction screen
  /// where the typed PollResults entity is too narrow.
  Future<Either<Failure, Map<String, dynamic>>> getRawPollData(String pollId);

  /// Get poll by ID
  Future<Either<Failure, Poll>> getPollById(String pollId);

  /// Get user's response for a poll (null if not voted)
  Future<Either<Failure, PollResponse?>> getUserResponse(String pollId);

  // --- Admin functions ---

  /// Create a new poll with linked opportunity
  Future<Either<Failure, Poll>> createPoll({
    required String threadId,
    required String question,
    required List<String> options,
    bool isAnonymous,
    bool showResultsAfterVote,
    bool allowChangeVote,
    int tokenReward,
    int durationSeconds,
    Map<String, dynamic>? targeting,
    int? tokenBudget,
    int? dailyLimitPerUser,
    String? opportunityImage,
  });

  /// Update poll (draft/open only)
  Future<Either<Failure, void>> updatePoll({
    required String pollId,
    String? question,
    List<String>? options,
    bool? isAnonymous,
    bool? showResultsAfterVote,
    bool? allowChangeVote,
  });

  /// Open a poll (draft -> open)
  Future<Either<Failure, void>> openPoll(String pollId);

  /// Close a poll (open -> closed)
  Future<Either<Failure, void>> closePoll(String pollId);

  /// Get admin details (poll + all responses + segmented counts)
  Future<Either<Failure, Map<String, dynamic>>> getPollAdminDetails(
      String pollId);

  /// Invalidate a poll response (admin fraud rollback)
  Future<Either<Failure, void>> invalidatePollResponse({
    required String pollId,
    required String userId,
    required String reason,
  });
}
