import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/earn_notification.dart';
import '../../domain/entities/earn_opportunity.dart';
import '../../domain/entities/earn_thread.dart';
import '../../domain/entities/engagement.dart';
import '../../domain/repositories/earn_repository.dart';
import '../../domain/value_objects/engagement_evidence.dart';
import '../datasources/remote/earn_remote_datasource.dart';

@LazySingleton(as: EarnRepository)
class EarnRepositoryImpl implements EarnRepository {
  final EarnRemoteDataSource _remoteDataSource;

  /// In-memory cache for eligible threads to avoid redundant Cloud Function
  /// calls when navigating between tabs.
  EligibleThreadsResult? _cachedThreadsResult;
  DateTime? _cachedAt;
  static const _cacheTtl = Duration(seconds: 30);

  EarnRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, EligibleThreadsResult>> getEligibleThreads() async {
    // Return cache if fresh (< 30s old)
    if (_cachedThreadsResult != null &&
        _cachedAt != null &&
        DateTime.now().difference(_cachedAt!) < _cacheTtl) {
      return Right(_cachedThreadsResult!);
    }

    try {
      final response = await _remoteDataSource.getEligibleThreads();
      final result = EligibleThreadsResult(
        threads: response.threads.map((t) => t.toEntity()).toList(),
        dailyCompletions: response.dailyCompletions,
        dailyEarnCap: response.dailyEarnCap,
        dailyLimitReached: response.dailyLimitReached,
      );

      _cachedThreadsResult = result;
      _cachedAt = DateTime.now();

      return Right(result);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EarnThread>> getEarnThreadById(String threadId) async {
    try {
      final thread = await _remoteDataSource.getEarnThread(threadId);
      if (thread == null) {
        return Left(Failure.serverError(message: 'Thread not found'));
      }
      return Right(thread.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EarnOpportunity>>> getEligibleOpportunities({
    required String threadId,
  }) async {
    try {
      final opportunities = await _remoteDataSource.getEligibleOpportunities(
        threadId: threadId,
      );
      return Right(opportunities.map((o) => o.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EarnOpportunity>> getOpportunityById(
    String opportunityId,
  ) async {
    try {
      final opportunity = await _remoteDataSource.getOpportunity(opportunityId);
      if (opportunity == null) {
        return Left(Failure.serverError(message: 'Opportunity not found'));
      }
      return Right(opportunity.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Engagement>> startEngagement({
    required String opportunityId,
  }) async {
    try {
      final engagement = await _remoteDataSource.startEngagement(
        opportunityId: opportunityId,
      );
      return Right(engagement.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Engagement>> updateEngagementProgress({
    required String engagementId,
    required int watchDurationSeconds,
  }) async {
    try {
      final engagement = await _remoteDataSource.updateEngagementProgress(
        engagementId: engagementId,
        watchDurationSeconds: watchDurationSeconds,
      );
      return Right(engagement.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Engagement>> submitSurvey({
    required String engagementId,
    required List<EngagementAnswer> answers,
    required EngagementEvidence evidence,
  }) async {
    try {
      final engagement = await _remoteDataSource.submitSurvey(
        engagementId: engagementId,
        answers: answers,
        evidence: evidence,
      );
      return Right(engagement.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Engagement>> getEngagementById(
    String engagementId,
  ) async {
    try {
      final engagement = await _remoteDataSource.getEngagement(engagementId);
      if (engagement == null) {
        return Left(Failure.serverError(message: 'Engagement not found'));
      }
      return Right(engagement.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Engagement>>> getEngagementHistory({
    int? limit,
    DateTime? startAfter,
  }) async {
    try {
      final engagements = await _remoteDataSource.getEngagementHistory(
        limit: limit,
        startAfter: startAfter,
      );
      return Right(engagements.map((e) => e.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Engagement?>> getActiveEngagement(
    String opportunityId,
  ) async {
    try {
      final engagement =
          await _remoteDataSource.getActiveEngagement(opportunityId);
      return Right(engagement?.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> abandonEngagement(String engagementId) async {
    try {
      await _remoteDataSource.abandonEngagement(engagementId);
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getAvailableOpportunitiesCount() async {
    try {
      final count = await _remoteDataSource.getAvailableOpportunitiesCount();
      return Right(count);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ===========================================================================
  // Inbox & Notifications
  // ===========================================================================

  /// In-memory cache for eligible inbox to avoid redundant calls.
  EligibleInboxResult? _cachedInboxResult;
  DateTime? _cachedInboxAt;

  @override
  Future<Either<Failure, EligibleInboxResult>> getEligibleInbox({bool forceRefresh = false}) async {
    // Return cache if fresh (< 30s old) unless force refresh requested
    if (!forceRefresh &&
        _cachedInboxResult != null &&
        _cachedInboxAt != null &&
        DateTime.now().difference(_cachedInboxAt!) < _cacheTtl) {
      return Right(_cachedInboxResult!);
    }

    try {
      final response = await _remoteDataSource.getEligibleInbox();
      final result = EligibleInboxResult(
        clients: response.clients,
        dailyCompletions: response.dailyCompletions,
        dailyEarnCap: response.dailyEarnCap,
        dailyLimitReached: response.dailyLimitReached,
      );

      _cachedInboxResult = result;
      _cachedInboxAt = DateTime.now();

      return Right(result);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EarnNotification>>> getEarnNotifications() async {
    try {
      final response = await _remoteDataSource.getEarnNotifications();
      return Right(response.notifications);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markNotificationRead(
    String notificationId,
  ) async {
    try {
      await _remoteDataSource.markNotificationRead(notificationId);
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllNotificationsRead() async {
    try {
      await _remoteDataSource.markAllNotificationsRead();
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }
}
