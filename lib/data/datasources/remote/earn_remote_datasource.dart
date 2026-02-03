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

abstract class EarnRemoteDataSource {
  String? get currentUserId;
  Future<List<EarnThreadModel>> getEarnThreads();
  Stream<List<EarnThreadModel>> watchEarnThreads();
  Future<EarnThreadModel?> getEarnThread(String threadId);
  Future<List<EarnOpportunityModel>> getOpportunities({
    required String threadId,
    bool activeOnly = true,
  });
  Stream<List<EarnOpportunityModel>> watchOpportunities({
    required String threadId,
    bool activeOnly = true,
  });
  Future<EarnOpportunityModel?> getOpportunity(String opportunityId);
  Future<EngagementModel> startEngagement({required String opportunityId});
  Future<EngagementModel> updateEngagementProgress({
    required String engagementId,
    required int watchDurationSeconds,
  });
  Future<EngagementModel> submitSurvey({
    required String engagementId,
    required List<EngagementAnswer> answers,
    required EngagementEvidence evidence,
  });
  Future<EngagementModel?> getEngagement(String engagementId);
  Future<List<EngagementModel>> getEngagementHistory({
    int? limit,
    DateTime? startAfter,
  });
  Future<EngagementModel?> getActiveEngagement(String opportunityId);
  Future<void> abandonEngagement(String engagementId);
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
  Future<List<EarnThreadModel>> getEarnThreads() async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      final snapshot = await _threadsCollection
          .where('isActive', isEqualTo: true)
          .orderBy('isPinned', descending: true)
          .orderBy('lastActivityAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return EarnThreadModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<EarnThreadModel>> watchEarnThreads() {
    final userId = currentUserId;
    if (userId == null) {
      return Stream.error(const AuthException(message: 'User not authenticated'));
    }

    return _threadsCollection
        .where('isActive', isEqualTo: true)
        .orderBy('isPinned', descending: true)
        .orderBy('lastActivityAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return EarnThreadModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    });
  }

  @override
  Future<EarnThreadModel?> getEarnThread(String threadId) async {
    try {
      final doc = await _threadsCollection.doc(threadId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return EarnThreadModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EarnOpportunityModel>> getOpportunities({
    required String threadId,
    bool activeOnly = true,
  }) async {
    try {
      var query = _opportunitiesCollection.where('threadId', isEqualTo: threadId);

      if (activeOnly) {
        query = query.where('isActive', isEqualTo: true);
      }

      final snapshot = await query.orderBy('createdAt', descending: true).get();

      return snapshot.docs.map((doc) {
        return EarnOpportunityModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<EarnOpportunityModel>> watchOpportunities({
    required String threadId,
    bool activeOnly = true,
  }) {
    var query = _opportunitiesCollection.where('threadId', isEqualTo: threadId);

    if (activeOnly) {
      query = query.where('isActive', isEqualTo: true);
    }

    return query.orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EarnOpportunityModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
      }).toList();
    });
  }

  @override
  Future<EarnOpportunityModel?> getOpportunity(String opportunityId) async {
    try {
      final doc = await _opportunitiesCollection.doc(opportunityId).get();
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return EarnOpportunityModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EngagementModel> startEngagement({required String opportunityId}) async {
    final userId = currentUserId;
    if (userId == null) {
      throw const AuthException(message: 'User not authenticated');
    }

    try {
      // Get opportunity details
      final opportunity = await getOpportunity(opportunityId);
      if (opportunity == null) {
        throw const ServerException(message: 'Opportunity not found');
      }

      // Check for existing active engagement
      final existing = await getActiveEngagement(opportunityId);
      if (existing != null) {
        return existing;
      }

      // Get attempt count for this user/opportunity
      final previousAttempts = await _engagementsCollection
          .where('userId', isEqualTo: userId)
          .where('earnOpportunityId', isEqualTo: opportunityId)
          .get();

      final now = DateTime.now();
      final engagement = EngagementModel(
        id: '',
        userId: userId,
        oddienceCampaignId: opportunity.campaignId ?? '',
        earnOpportunityId: opportunityId,
        status: 'started',
        startedAt: now,
        watchDurationSeconds: 0,
        requiredDurationSeconds: opportunity.durationSeconds,
        answers: [],
        attemptNumber: previousAttempts.docs.length + 1,
        createdAt: now,
      );

      final docRef = await _engagementsCollection.add(engagement.toFirestoreJson());

      return EngagementModel(
        id: docRef.id,
        userId: userId,
        oddienceCampaignId: opportunity.campaignId ?? '',
        earnOpportunityId: opportunityId,
        status: 'started',
        startedAt: now,
        watchDurationSeconds: 0,
        requiredDurationSeconds: opportunity.durationSeconds,
        answers: [],
        attemptNumber: previousAttempts.docs.length + 1,
        createdAt: now,
      );
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

      final requiredDuration = data['requiredDurationSeconds'] as int;
      final newStatus = watchDurationSeconds >= requiredDuration ? 'surveying' : 'watching';

      await _engagementsCollection.doc(engagementId).update({
        'watchDurationSeconds': watchDurationSeconds,
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(data),
        'id': doc.id,
        'watchDurationSeconds': watchDurationSeconds,
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

      final answersModels = answers
          .map((a) => EngagementAnswerModel.fromEntity(a))
          .toList();
      final evidenceModel = EngagementEvidenceModel.fromEntity(evidence);

      // Get Play Integrity token for this sensitive operation
      final nonce = _playIntegrity.generateNonce();
      final integrityToken = await _playIntegrity.getIntegrityToken(nonce: nonce);

      final callable = _functions.httpsCallable('processEngagement');
      await callable.call<Map<String, dynamic>>({
        'engagementId': engagementId,
        'evidence': {
          'responses': answersModels.map((a) => a.toFirestoreJson()).toList(),
          ...evidenceModel.toFirestoreJson(),
        },
        if (integrityToken != null) 'integrityToken': integrityToken,
        if (integrityToken != null) 'integrityNonce': nonce,
      });

      final now = DateTime.now();

      return EngagementModel.fromJson({
        ...sanitizeFirestoreData(data),
        'id': doc.id,
        'answers': answersModels.map((a) => a.toFirestoreJson()).toList(),
        'evidence': evidenceModel.toFirestoreJson(),
        'status': 'completed',
        'completedAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      });
    } on FirebaseFunctionsException catch (e) {
      throw ServerException(message: e.message ?? 'Engagement submission failed');
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
      return EngagementModel.fromJson({...sanitizeFirestoreData(doc.data()!), 'id': doc.id});
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
        return EngagementModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
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
      return EngagementModel.fromJson({...sanitizeFirestoreData(doc.data()), 'id': doc.id});
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
      final snapshot = await _opportunitiesCollection
          .where('isActive', isEqualTo: true)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
