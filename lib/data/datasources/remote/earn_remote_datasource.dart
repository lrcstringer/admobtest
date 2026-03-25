import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../../domain/entities/earn_notification.dart';
import '../../../domain/entities/engagement.dart';
import '../../../domain/entities/inbox_client.dart';
import '../../../domain/value_objects/engagement_evidence.dart';
import '../../models/earn_thread_model.dart';
import '../../models/earn_opportunity_model.dart';
import '../../models/engagement_model.dart';

/// Response from getEligibleThreads including daily limit info
class EligibleThreadsResponse {
  final List<EarnThreadModel> threads;
  final int dailyCompletions;
  final int dailyEarnCap;
  final bool dailyLimitReached;

  EligibleThreadsResponse({
    required this.threads,
    required this.dailyCompletions,
    required this.dailyEarnCap,
    required this.dailyLimitReached,
  });
}

/// Response from getEligibleInbox with client-grouped threads
class EligibleInboxResponse {
  final List<InboxClient> clients;
  final int dailyCompletions;
  final int dailyEarnCap;
  final bool dailyLimitReached;

  EligibleInboxResponse({
    required this.clients,
    required this.dailyCompletions,
    required this.dailyEarnCap,
    required this.dailyLimitReached,
  });
}

/// Response from getEarnNotifications
class EarnNotificationsResponse {
  final List<EarnNotification> notifications;
  final int unreadCount;

  EarnNotificationsResponse({
    required this.notifications,
    required this.unreadCount,
  });
}

abstract class EarnRemoteDataSource {
  String? get currentUserId;

  /// Get eligible threads via Cloud Function (server-side targeting)
  /// Returns threads and daily limit info
  Future<EligibleThreadsResponse> getEligibleThreads();

  /// Get thread by ID
  Future<EarnThreadModel?> getEarnThread(String threadId);

  /// Get eligible opportunities via Cloud Function (server-side targeting)
  Future<List<EarnOpportunityModel>> getEligibleOpportunities({
    required String threadId,
    bool forceRefresh = false,
  });

  /// Get opportunity by ID
  Future<EarnOpportunityModel?> getOpportunity(String opportunityId);

  /// Start engagement via Cloud Function
  Future<EngagementModel> startEngagement({required String opportunityId});

  /// Update engagement progress
  Future<EngagementModel> updateEngagementProgress({
    required String engagementId,
    required int watchDurationSeconds,
  });

  /// Submit survey via Cloud Function
  Future<EngagementModel> submitSurvey({
    required String engagementId,
    required List<EngagementAnswer> answers,
    required EngagementEvidence evidence,
  });

  /// Get engagement by ID
  Future<EngagementModel?> getEngagement(String engagementId);

  /// Get user's engagement history
  Future<List<EngagementModel>> getEngagementHistory({
    int? limit,
    DateTime? startAfter,
  });

  /// Get active engagement for opportunity
  Future<EngagementModel?> getActiveEngagement(String opportunityId);

  /// Abandon engagement
  Future<void> abandonEngagement(String engagementId);

  /// Get available opportunities count for user
  Future<int> getAvailableOpportunitiesCount();

  /// Get eligible inbox grouped by client (server-side targeting).
  /// Pass [forceRefresh] to bypass the server-side cache.
  Future<EligibleInboxResponse> getEligibleInbox({bool forceRefresh = false});

  /// Get user's earn notifications
  Future<EarnNotificationsResponse> getEarnNotifications();

  /// Mark a single notification as read
  Future<void> markNotificationRead(String notificationId);

  /// Mark all notifications as read
  Future<void> markAllNotificationsRead();
}

@LazySingleton(as: EarnRemoteDataSource)
class EarnRemoteDataSourceImpl implements EarnRemoteDataSource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _functions;
  final PlayIntegrityService _playIntegrity;

  EarnRemoteDataSourceImpl(
    this._firestore,
    this._firebaseAuth,
    this._functions,
    this._playIntegrity,
  );

  CollectionReference<Map<String, dynamic>> get _threadsCollection =>
      _firestore.collection('earnThreads');

  CollectionReference<Map<String, dynamic>> get _opportunitiesCollection =>
      _firestore.collection('earnOpportunities');

  CollectionReference<Map<String, dynamic>> get _engagementsCollection =>
      _firestore.collection('engagements');

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<EligibleThreadsResponse> getEligibleThreads() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getEligibleThreads');
      final result = await callable.call<Map<String, dynamic>>({});

      final data = result.data;
      final threads = (data['threads'] as List?) ?? [];

      // Parse daily limit info
      final dailyLimit = data['dailyLimit'] != null
          ? Map<String, dynamic>.from(data['dailyLimit'] as Map)
          : null;
      final dailyCompletions = dailyLimit?['completions'] as int? ?? 0;
      final dailyEarnCap = dailyLimit?['cap'] as int? ?? 30;
      final dailyLimitReached = dailyLimit?['limitReached'] as bool? ?? false;

      final threadModels = threads.map((thread) {
        final threadMap = deepConvertMap(thread as Map);
        return EarnThreadModel.fromJson(threadMap);
      }).toList();

      return EligibleThreadsResponse(
        threads: threadModels,
        dailyCompletions: dailyCompletions,
        dailyEarnCap: dailyEarnCap,
        dailyLimitReached: dailyLimitReached,
      );
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to fetch threads');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EarnThreadModel?> getEarnThread(String threadId) async {
    try {
      final doc = await _threadsCollection.doc(threadId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return EarnThreadModel.fromJson({
        ...sanitizeFirestoreData(doc.data()!),
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EarnOpportunityModel>> getEligibleOpportunities({
    required String threadId,
    bool forceRefresh = false,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getEligibleOpportunities');
      final result = await callable.call<Map<String, dynamic>>({
        'threadId': threadId,
        if (forceRefresh) 'forceRefresh': true,
      });

      final data = result.data;
      final opportunities = (data['opportunities'] as List?) ?? [];

      return opportunities.map((opp) {
        final oppMap = deepConvertMap(opp as Map);
        return EarnOpportunityModel.fromJson(oppMap);
      }).toList();
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to fetch opportunities');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EarnOpportunityModel?> getOpportunity(String opportunityId) async {
    try {
      final doc = await _opportunitiesCollection.doc(opportunityId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return EarnOpportunityModel.fromJson({
        ...sanitizeFirestoreData(doc.data()!),
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EngagementModel> startEngagement({
    required String opportunityId,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('startEngagement');
      final result = await callable.call<Map<String, dynamic>>({
        'earnOpportunityId': opportunityId,
      });

      final data = result.data;
      if (data['success'] != true) {
        throw ServerException(
            message: data['error'] as String? ?? 'Failed to start engagement');
      }

      // If the CF returned embedded engagement data use it directly — no
      // extra Firestore read needed (eliminates ~150ms serial latency).
      final embeddedEngagement = data['engagement'] as Map?;
      if (embeddedEngagement != null) {
        return EngagementModel.fromJson(
            Map<String, dynamic>.from(embeddedEngagement));
      }

      // Fallback for idempotency path or legacy CF versions that don't embed
      // engagement data: read the full doc by ID.
      final engagementId = data['engagementId'] as String;
      final engagementDoc =
          await _engagementsCollection.doc(engagementId).get();

      if (!engagementDoc.exists || engagementDoc.data() == null) {
        throw const ServerException(
            message: 'Engagement created but not found');
      }

      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(engagementDoc.data()!),
        'id': engagementDoc.id,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to start engagement');
    } catch (e) {
      if (e is ServerException || e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  // NOTE: This method is NOT called by the main EarnBloc flow.
  // EarnBloc._onUpdateWatchProgress tracks progress locally (no Firestore write
  // per second) and submits the final duration as part of the evidence object
  // when processEngagement is called. This method is kept for external callers
  // and direct API use; the client-side monotonicity validation here mirrors
  // the server-side validation in the updateEngagementProgress Cloud Function.
  @override
  Future<EngagementModel> updateEngagementProgress({
    required String engagementId,
    required int watchDurationSeconds,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final doc = await _engagementsCollection.doc(engagementId).get();
      if (!doc.exists) {
        throw const ServerException(message: 'Engagement not found');
      }

      final data = doc.data()!;
      if (data['userId'] != userId) {
        throw const ServerException(message: 'Not authorized');
      }

      // Guard: duration must be positive and monotonically increasing
      final previousDuration = (data['watchDurationSeconds'] as int?) ?? 0;
      if (watchDurationSeconds < 0 || watchDurationSeconds < previousDuration) {
        throw const ServerException(
            message: 'Invalid watch duration');
      }

      // Guard: cap duration to max possible elapsed time since engagement started
      final startedAt = data['startedAt'];
      int clampedDuration = watchDurationSeconds;
      if (startedAt != null) {
        final startTime = startedAt is Timestamp
            ? startedAt.toDate()
            : DateTime.parse(startedAt.toString());
        final maxElapsed =
            DateTime.now().difference(startTime).inSeconds + 5; // 5s buffer
        clampedDuration = clampedDuration.clamp(0, maxElapsed);
      }

      final requiredDuration = (data['requiredDurationSeconds'] as num?)?.toInt() ?? 0;
      final newStatus =
          clampedDuration >= requiredDuration ? 'surveying' : 'watching';

      await _engagementsCollection.doc(engagementId).update({
        'watchDurationSeconds': clampedDuration,
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(data),
        'id': doc.id,
        'watchDurationSeconds': clampedDuration,
        'status': newStatus,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      if (e is ServerException || e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EngagementModel> submitSurvey({
    required String engagementId,
    required List<EngagementAnswer> answers,
    required EngagementEvidence evidence,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final answersModels =
          answers.map((a) => EngagementAnswerModel.fromEntity(a)).toList();
      final evidenceModel = EngagementEvidenceModel.fromEntity(evidence);

      // Use the pre-generated nonce+token from the screen if available (started
      // during surveying to eliminate the 3–10s native fetch at submit time).
      // Fall back to a fresh fetch when not pre-generated (e.g. adVideo, upload).
      final nonce = evidence.integrityNonce ?? _playIntegrity.generateNonce();
      final docFuture = _engagementsCollection.doc(engagementId).get();
      final integrityFuture =
          (evidence.integrityToken != null && evidence.integrityNonce != null)
              ? Future.value(evidence.integrityToken)
              : _playIntegrity.getIntegrityToken(nonce: nonce);

      // Await both concurrently
      final doc = await docFuture;
      final integrityToken = await integrityFuture;

      if (!doc.exists) {
        throw const ServerException(message: 'Engagement not found');
      }

      final data = doc.data()!;
      if (data['userId'] != userId) {
        throw const ServerException(message: 'Not authorized');
      }

      // sanitizeFirestoreData converts Timestamp → ISO 8601 strings;
      // callable.call() only accepts JSON-serializable data, not Timestamp.
      final evidenceData = sanitizeFirestoreData({
        'responses': answersModels.map((a) => a.toFirestoreJson()).toList(),
        ...evidenceModel.toFirestoreJson(),
      });

      final callable = _functions.httpsCallable('processEngagement');
      final result = await callable.call<Map<String, dynamic>>({
        'engagementId': engagementId,
        'evidence': evidenceData,
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final now = DateTime.now();
      // Use status from CF response (may be 'pending_review' for uploads)
      final resultData = result.data;
      final returnedStatus =
          resultData['status'] as String? ?? 'completed';

      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(data),
        'id': doc.id,
        'answers': evidenceData['responses'] as List,
        'evidence': evidenceData,
        'status': returnedStatus,
        'completedAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
        // Include token data from CF response (pre-call doc doesn't have it)
        'tokensEarned': (resultData['tokensEarned'] as num?)?.toDouble() ?? 0.0,
        // M2 fix: capture the actual gross total so the confirm screen can
        // show the correct breakdown when a bonus multiplier was applied.
        // processEngagement returns 'totalGenerated' = actual rewardAmount
        // after bonus (the figure that was split 90/5/5).
        'totalTokensGenerated':
            (resultData['totalGenerated'] as num?)?.toDouble(),
        'streakDayAtCompletion': resultData['streakDay'] as int?,
        'multiplierApplied':
            (resultData['multiplierApplied'] as num?)?.toDouble(),
        // Reward escrow fields from CF response
        'rewardItemId': resultData['rewardItemId'] as String?,
        'rewardCampaignName': resultData['rewardCampaignName'] as String?,
        'rewardType': resultData['rewardType'] as String?,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Engagement submission failed');
    } catch (e) {
      if (e is ServerException || e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EngagementModel?> getEngagement(String engagementId) async {
    try {
      final doc = await _engagementsCollection.doc(engagementId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(doc.data()!),
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EngagementModel>> getEngagementHistory({
    int? limit,
    DateTime? startAfter,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      var query = _engagementsCollection
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true);

      if (startAfter != null) {
        query = query.startAfter([Timestamp.fromDate(startAfter)]);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        return EngagementModel.fromJson({
          ...sanitizeFirestoreData(doc.data()),
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EngagementModel?> getActiveEngagement(String opportunityId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final snapshot = await _engagementsCollection
          .where('userId', isEqualTo: userId)
          .where('earnOpportunityId', isEqualTo: opportunityId)
          .where('status', whereIn: ['started', 'watching', 'surveying'])
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      final doc = snapshot.docs.first;
      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(doc.data()),
        'id': doc.id,
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> abandonEngagement(String engagementId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      // Call the CF so it can reverse the escrow reservation and release
      // any reward item reservation — a direct Firestore write skips both.
      final callable = _functions.httpsCallable('abandonEngagement');
      await callable.call<Map<String, dynamic>>({
        'engagementId': engagementId,
      });
    } on FirebaseFunctionsException catch (e) {
      // 'failed-precondition' means the engagement was already in a terminal
      // state (completed/abandoned/rejected). Treat that as a no-op so that
      // back-navigation after a completed engagement never surfaces an error.
      if (e.code == 'failed-precondition') return;
      throw ServerException(message: e.message ?? 'Failed to abandon engagement');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<int> getAvailableOpportunitiesCount() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      // Call getEligibleThreads and sum up available opportunities
      final response = await getEligibleThreads();
      return response.threads.fold<int>(
          0, (total, thread) => total + thread.availableOpportunities);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EligibleInboxResponse> getEligibleInbox({bool forceRefresh = false}) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getEligibleInbox');
      final result = await callable.call<Map<String, dynamic>>(
        forceRefresh ? {'forceRefresh': true} : {},
      );

      final data = result.data;
      final clientsList = (data['clients'] as List?) ?? [];

      final dailyLimit = data['dailyLimit'] != null
          ? Map<String, dynamic>.from(data['dailyLimit'] as Map)
          : null;

      final clients = clientsList.map((clientData) {
        final clientMap = deepConvertMap(clientData as Map);
        return InboxClient.fromJson(clientMap);
      }).toList();

      return EligibleInboxResponse(
        clients: clients,
        dailyCompletions: dailyLimit?['completions'] as int? ?? 0,
        dailyEarnCap: dailyLimit?['cap'] as int? ?? 30,
        dailyLimitReached: dailyLimit?['limitReached'] as bool? ?? false,
      );
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to fetch inbox');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EarnNotificationsResponse> getEarnNotifications() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getEarnNotifications');
      final result = await callable.call<Map<String, dynamic>>({});

      final data = result.data;
      final notifList = (data['notifications'] as List?) ?? [];

      final notifications = notifList.map((n) {
        final notifMap = deepConvertMap(n as Map);
        return EarnNotification.fromJson(notifMap);
      }).toList();

      return EarnNotificationsResponse(
        notifications: notifications,
        unreadCount: data['unreadCount'] as int? ?? 0,
      );
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to fetch notifications');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> markNotificationRead(String notificationId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('markEarnNotificationRead');
      await callable.call<Map<String, dynamic>>({
        'notificationId': notificationId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to mark notification read');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> markAllNotificationsRead() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('markEarnNotificationRead');
      await callable.call<Map<String, dynamic>>({
        'markAllRead': true,
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(
          message: e.message ?? 'Failed to mark all notifications read');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
