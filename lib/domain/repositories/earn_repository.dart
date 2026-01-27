import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/earn_thread.dart';
import '../entities/earn_opportunity.dart';
import '../entities/engagement.dart';
import '../value_objects/engagement_evidence.dart';

/// Earn repository interface
abstract class EarnRepository {
  /// Get all earn threads
  Future<Either<Failure, List<EarnThread>>> getEarnThreads();

  /// Stream earn threads
  Stream<Either<Failure, List<EarnThread>>> watchEarnThreads();

  /// Get earn thread by ID
  Future<Either<Failure, EarnThread>> getEarnThreadById(String threadId);

  /// Get opportunities for a thread
  Future<Either<Failure, List<EarnOpportunity>>> getOpportunities({
    required String threadId,
    bool activeOnly = true,
  });

  /// Stream opportunities for a thread
  Stream<Either<Failure, List<EarnOpportunity>>> watchOpportunities({
    required String threadId,
    bool activeOnly = true,
  });

  /// Get opportunity by ID
  Future<Either<Failure, EarnOpportunity>> getOpportunityById(
    String opportunityId,
  );

  /// Start engagement with an opportunity
  Future<Either<Failure, Engagement>> startEngagement({
    required String opportunityId,
  });

  /// Update engagement progress (video watch time)
  Future<Either<Failure, Engagement>> updateEngagementProgress({
    required String engagementId,
    required int watchDurationSeconds,
  });

  /// Submit survey answers
  Future<Either<Failure, Engagement>> submitSurvey({
    required String engagementId,
    required List<EngagementAnswer> answers,
    required EngagementEvidence evidence,
  });

  /// Get engagement by ID
  Future<Either<Failure, Engagement>> getEngagementById(String engagementId);

  /// Get user's engagement history
  Future<Either<Failure, List<Engagement>>> getEngagementHistory({
    int? limit,
    DateTime? startAfter,
  });

  /// Get active engagement for opportunity
  Future<Either<Failure, Engagement?>> getActiveEngagement(
    String opportunityId,
  );

  /// Abandon engagement
  Future<Either<Failure, void>> abandonEngagement(String engagementId);

  /// Get total available opportunities count
  Future<Either<Failure, int>> getAvailableOpportunitiesCount();
}
