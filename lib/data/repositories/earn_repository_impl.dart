import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/earn_notification.dart';
import '../../domain/entities/earn_opportunity.dart';
import '../../domain/entities/earn_thread.dart';
import '../../domain/entities/engagement.dart';
import '../../domain/entities/inbox_client.dart';
import '../../domain/repositories/earn_repository.dart';
import '../../domain/value_objects/engagement_evidence.dart';
import '../datasources/remote/earn_remote_datasource.dart';
import '../models/earn_opportunity_model.dart';

@LazySingleton(as: EarnRepository)
class EarnRepositoryImpl implements EarnRepository {
  final EarnRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;

  /// SharedPreferences key for the persistent inbox cache.
  static const _inboxCacheKey = 'earn_inbox_cache_v1';

  /// SharedPreferences key prefix for per-thread opportunities cache.
  static const _oppsCacheKeyPrefix = 'earn_opps_cache_v1_';

  /// In-memory cache for eligible threads to avoid redundant Cloud Function
  /// calls when navigating between tabs.
  EligibleThreadsResult? _cachedThreadsResult;
  DateTime? _cachedAt;
  static const _cacheTtl = Duration(seconds: 30);

  EarnRepositoryImpl(this._remoteDataSource, this._prefs);

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
    bool forceRefresh = false,
  }) async {
    try {
      final opportunities = await _remoteDataSource.getEligibleOpportunities(
        threadId: threadId,
        forceRefresh: forceRefresh,
      );
      final entities = opportunities.map((o) => o.toEntity()).toList();
      _persistOpportunities(threadId, opportunities);
      return Right(entities);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<List<EarnOpportunity>?> getCachedOpportunities(
      String threadId) async {
    try {
      final json = _prefs.getString('$_oppsCacheKeyPrefix$threadId');
      if (json == null) return null;
      final list = jsonDecode(json) as List<dynamic>;
      return list
          .map((e) => EarnOpportunityModel.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .map((m) => m.toEntity())
          .toList();
    } catch (_) {
      return null;
    }
  }

  void _persistOpportunities(
      String threadId, List<EarnOpportunityModel> models) {
    try {
      // Build JSON-safe maps. Uses field access directly to avoid Firestore
      // Timestamp objects that jsonEncode cannot serialise.
      final list = models.map((m) => <String, dynamic>{
            'id': m.id,
            'threadId': m.threadId,
            'title': m.title,
            'description': m.description,
            'earningType': m.earningType,
            'tokenReward': m.tokenReward,
            'streakPoints': m.streakPoints,
            'mediaType': m.mediaType,
            'mediaUrl': m.mediaUrl,
            'questions':
                m.questions.map((q) => q.toFirestoreJson()).toList(),
            'durationSeconds': m.durationSeconds,
            'expiresAt': m.expiresAt?.toIso8601String(),
            'isActive': m.isActive,
            'isPinned': m.isPinned,
            'isFeatured': m.isFeatured,
            'clientId': m.clientId,
            'clientName': m.clientName,
            'clientAvatarColor': m.clientAvatarColor,
            'clientAvatarImage': m.clientAvatarImage,
            'threadImage': m.threadImage,
            'opportunityImage': m.opportunityImage,
            'campaignId': m.campaignId,
            'targeting': m.targeting,
            'bonusReward': m.bonusReward,
            'bonusRewardMultiplier': m.bonusRewardMultiplier,
            'bonusIntervalType': m.bonusIntervalType,
            'bonusIntervalX': m.bonusIntervalX,
            'userEngagementStatus': m.userEngagementStatus,
            'userEngagementId': m.userEngagementId,
            'adUnitId': m.adUnitId,
            'dailyLimitPerUser': m.dailyLimitPerUser,
            'budgetExhausted': m.budgetExhausted,
            'tokenBudget': m.tokenBudget,
            'tokenSpent': m.tokenSpent,
            'pollId': m.pollId,
            'uploadPrompt': m.uploadPrompt,
            'uploadContextMediaUrl': m.uploadContextMediaUrl,
            'uploadContextMediaType': m.uploadContextMediaType,
            'uploadVideoEnabled': m.uploadVideoEnabled,
            'uploadImageEnabled': m.uploadImageEnabled,
            'uploadTextEnabled': m.uploadTextEnabled,
            'uploadVideoRequired': m.uploadVideoRequired,
            'uploadImageRequired': m.uploadImageRequired,
            'uploadTextRequired': m.uploadTextRequired,
            'uploadVideoMaxSeconds': m.uploadVideoMaxSeconds,
            'uploadTextMinChars': m.uploadTextMinChars,
            'uploadTextMaxChars': m.uploadTextMaxChars,
            'requiresAdminReview': m.requiresAdminReview,
            'tokenSourceAccountId': m.tokenSourceAccountId,
            'rewardCampaignId': m.rewardCampaignId,
            'rewardCampaignName': m.rewardCampaignName,
            'rewardType': m.rewardType,
            'rewardQuantity': m.rewardQuantity,
          }).toList();
      _prefs.setString('$_oppsCacheKeyPrefix$threadId', jsonEncode(list));
    } catch (_) {
      // Cache write failures are non-fatal
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
  Future<EligibleInboxResult?> getCachedInboxResult() async {
    try {
      final raw = _prefs.getString(_inboxCacheKey);
      if (raw == null) return null;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final clientsList = map['clients'] as List<dynamic>;
      final clients =
          clientsList.map((c) => InboxClient.fromJson(c as Map<String, dynamic>)).toList();
      return EligibleInboxResult(
        clients: clients,
        dailyCompletions: map['dailyCompletions'] as int? ?? 0,
        dailyEarnCap: map['dailyEarnCap'] as int? ?? 30,
        dailyLimitReached: map['dailyLimitReached'] as bool? ?? false,
      );
    } catch (_) {
      // Corrupt or incompatible cache — discard silently
      _prefs.remove(_inboxCacheKey);
      return null;
    }
  }

  void _persistInboxResult(EligibleInboxResult result) {
    try {
      final map = {
        'clients': result.clients.map((c) => c.toJson()).toList(),
        'dailyCompletions': result.dailyCompletions,
        'dailyEarnCap': result.dailyEarnCap,
        'dailyLimitReached': result.dailyLimitReached,
      };
      _prefs.setString(_inboxCacheKey, jsonEncode(map));
    } catch (_) {
      // Non-critical — swallow silently
    }
  }

  @override
  Future<Either<Failure, EligibleInboxResult>> getEligibleInbox({bool forceRefresh = false}) async {
    // Return in-memory cache if fresh (< 30s) and not a forced refresh.
    if (!forceRefresh &&
        _cachedInboxResult != null &&
        _cachedInboxAt != null &&
        DateTime.now().difference(_cachedInboxAt!) < _cacheTtl) {
      return Right(_cachedInboxResult!);
    }

    try {
      final response = await _remoteDataSource.getEligibleInbox(forceRefresh: forceRefresh);
      final result = EligibleInboxResult(
        clients: response.clients,
        dailyCompletions: response.dailyCompletions,
        dailyEarnCap: response.dailyEarnCap,
        dailyLimitReached: response.dailyLimitReached,
      );

      _cachedInboxResult = result;
      _cachedInboxAt = DateTime.now();
      _persistInboxResult(result);

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
