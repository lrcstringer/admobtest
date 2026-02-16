import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/earn_notification.dart';
import '../entities/earn_thread.dart';
import '../entities/earn_opportunity.dart';
import '../entities/engagement.dart';
import '../entities/inbox_client.dart';
import '../value_objects/engagement_evidence.dart';

/// Result from getEligibleThreads including daily limit info
class EligibleThreadsResult {
  final List<EarnThread> threads;
  final int dailyCompletions;
  final int dailyEarnCap;
  final bool dailyLimitReached;

  const EligibleThreadsResult({
    required this.threads,
    required this.dailyCompletions,
    required this.dailyEarnCap,
    required this.dailyLimitReached,
  });
}

/// Result from getEligibleInbox — clients grouped with threads
class EligibleInboxResult {
  final List<InboxClient> clients;
  final int dailyCompletions;
  final int dailyEarnCap;
  final bool dailyLimitReached;

  const EligibleInboxResult({
    required this.clients,
    required this.dailyCompletions,
    required this.dailyEarnCap,
    required this.dailyLimitReached,
  });
}

/// Earn repository interface
abstract class EarnRepository {
  /// Get eligible earn threads for the current user (server-side targeting)
  /// Returns threads and daily limit info
  Future<Either<Failure, EligibleThreadsResult>> getEligibleThreads();

  /// Get earn thread by ID
  Future<Either<Failure, EarnThread>> getEarnThreadById(String threadId);

  /// Get eligible opportunities for a thread (server-side targeting)
  Future<Either<Failure, List<EarnOpportunity>>> getEligibleOpportunities({
    required String threadId,
  });

  /// Get opportunity by ID
  Future<Either<Failure, EarnOpportunity>> getOpportunityById(
    String opportunityId,
  );

  /// Start engagement with an opportunity (via Cloud Function)
  Future<Either<Failure, Engagement>> startEngagement({
    required String opportunityId,
  });

  /// Update engagement progress (video watch time)
  Future<Either<Failure, Engagement>> updateEngagementProgress({
    required String engagementId,
    required int watchDurationSeconds,
  });

  /// Submit survey answers (via Cloud Function)
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

  /// Get total available opportunities count for the user
  Future<Either<Failure, int>> getAvailableOpportunitiesCount();

  // =========================================================================
  // Inbox & Notifications
  // =========================================================================

  /// Get eligible inbox grouped by client (server-side targeting)
  Future<Either<Failure, EligibleInboxResult>> getEligibleInbox({bool forceRefresh = false});

  /// Get user's earn notifications
  Future<Either<Failure, List<EarnNotification>>> getEarnNotifications();

  /// Mark a single notification as read
  Future<Either<Failure, void>> markNotificationRead(String notificationId);

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllNotificationsRead();
}
