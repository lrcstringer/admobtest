import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/security/play_integrity_service.dart';
import '../../../core/utils/firestore_helpers.dart';
import '../../../domain/entities/engagement.dart';
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
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final callable = _functions.httpsCallable('getEligibleOpportunities');
      final result = await callable.call<Map<String, dynamic>>({
        'threadId': threadId,
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

      // Cloud Function returns { success, engagementId, rewardAmount }
      // Fetch the full engagement document by ID
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

      final requiredDuration = data['requiredDurationSeconds'] as int;
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
      final doc = await _engagementsCollection.doc(engagementId).get();
      if (!doc.exists) {
        throw const ServerException(message: 'Engagement not found');
      }

      final data = doc.data()!;
      if (data['userId'] != userId) {
        throw const ServerException(message: 'Not authorized');
      }

      final answersModels =
          answers.map((a) => EngagementAnswerModel.fromEntity(a)).toList();
      final evidenceModel = EngagementEvidenceModel.fromEntity(evidence);

      // Get Play Integrity token for this sensitive operation
      final nonce = _playIntegrity.generateNonce();
      final integrityToken =
          await _playIntegrity.getIntegrityToken(nonce: nonce);

      // sanitizeFirestoreData converts Timestamp → ISO 8601 strings;
      // callable.call() only accepts JSON-serializable data, not Timestamp.
      final evidenceData = sanitizeFirestoreData({
        'responses': answersModels.map((a) => a.toFirestoreJson()).toList(),
        ...evidenceModel.toFirestoreJson(),
      });

      final callable = _functions.httpsCallable('processEngagement');
      await callable.call<Map<String, dynamic>>({
        'engagementId': engagementId,
        'evidence': evidenceData,
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final now = DateTime.now();

      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(data),
        'id': doc.id,
        'answers': evidenceData['responses'] as List,
        'evidence': evidenceData,
        'status': 'completed',
        'completedAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
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
      final doc = await _engagementsCollection.doc(engagementId).get();
      if (!doc.exists) {
        throw const ServerException(message: 'Engagement not found');
      }

      final data = doc.data()!;
      if (data['userId'] != userId) {
        throw const ServerException(message: 'Not authorized');
      }

      await _engagementsCollection.doc(engagementId).update({
        'status': 'abandoned',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (e is ServerException || e is AuthException) rethrow;
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
}
