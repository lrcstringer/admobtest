import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/enums/pot_type.dart';
import '../../models/pot_pool_model.dart';
import '../../models/user_score_model.dart';

abstract class GamificationRemoteDataSource {
  /// Get current daily pot
  Future<PotPoolModel> getCurrentDailyPot();

  /// Get current weekly pot
  Future<PotPoolModel> getCurrentWeeklyPot();

  /// Stream pot updates
  Stream<PotPoolModel> watchPot(PotType type);

  /// Get pot history
  Future<List<PotPoolModel>> getPotHistory({
    required PotType type,
    int? limit,
  });

  /// Get pot by ID
  Future<PotPoolModel> getPotById(String potId);

  /// Get daily leaderboard
  Future<List<UserScoreModel>> getDailyLeaderboard({int? limit});

  /// Get weekly leaderboard
  Future<List<UserScoreModel>> getWeeklyLeaderboard({int? limit});

  /// Get all-time leaderboard
  Future<List<UserScoreModel>> getAllTimeLeaderboard({int? limit});

  /// Stream leaderboard updates
  Stream<List<UserScoreModel>> watchLeaderboard({
    required PotType type,
    int? limit,
  });

  /// Get current user's score
  Future<UserScoreModel> getCurrentUserScore(PotType type);

  /// Get current user's rank
  Future<int> getCurrentUserRank(PotType type);

  /// Check if user is eligible for pot
  Future<bool> isEligibleForPot(PotType type);

  /// Get pot distribution preview
  Future<List<PotWinnerModel>> getPotDistributionPreview(String potId);
}

@LazySingleton(as: GamificationRemoteDataSource)
class GamificationRemoteDataSourceImpl implements GamificationRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  GamificationRemoteDataSourceImpl(this._firestore, this._auth);

  String? get _currentUserId => _auth.currentUser?.uid;

  CollectionReference get _potsCollection => _firestore.collection('pots');
  CollectionReference get _leaderboardsCollection =>
      _firestore.collection('leaderboards');

  @override
  Future<PotPoolModel> getCurrentDailyPot() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final snapshot = await _potsCollection
        .where('type', isEqualTo: 'daily')
        .where('isActive', isEqualTo: true)
        .where('periodStart', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .where('periodStart', isLessThan: Timestamp.fromDate(todayEnd))
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      // Return empty pot if none exists
      return PotPoolModel(
        id: 'daily_${todayStart.millisecondsSinceEpoch}',
        type: 'daily',
        totalTokens: 0,
        participantCount: 0,
        periodStart: todayStart,
        periodEnd: todayEnd,
        isActive: true,
        isDistributed: false,
        createdAt: now,
      );
    }

    final doc = snapshot.docs.first;
    return PotPoolModel.fromJson({
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>,
    });
  }

  @override
  Future<PotPoolModel> getCurrentWeeklyPot() async {
    final now = DateTime.now();
    // Week starts on Monday
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartDate = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final weekEnd = weekStartDate.add(const Duration(days: 7));

    final snapshot = await _potsCollection
        .where('type', isEqualTo: 'weekly')
        .where('isActive', isEqualTo: true)
        .where('periodStart', isGreaterThanOrEqualTo: Timestamp.fromDate(weekStartDate))
        .where('periodStart', isLessThan: Timestamp.fromDate(weekEnd))
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return PotPoolModel(
        id: 'weekly_${weekStartDate.millisecondsSinceEpoch}',
        type: 'weekly',
        totalTokens: 0,
        participantCount: 0,
        periodStart: weekStartDate,
        periodEnd: weekEnd,
        isActive: true,
        isDistributed: false,
        createdAt: now,
      );
    }

    final doc = snapshot.docs.first;
    return PotPoolModel.fromJson({
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>,
    });
  }

  @override
  Stream<PotPoolModel> watchPot(PotType type) {
    final typeStr = type == PotType.daily ? 'daily' : 'weekly';

    return _potsCollection
        .where('type', isEqualTo: typeStr)
        .where('isActive', isEqualTo: true)
        .orderBy('periodStart', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        final now = DateTime.now();
        DateTime periodStart;
        DateTime periodEnd;

        if (type == PotType.daily) {
          periodStart = DateTime(now.year, now.month, now.day);
          periodEnd = periodStart.add(const Duration(days: 1));
        } else {
          final weekStart = now.subtract(Duration(days: now.weekday - 1));
          periodStart = DateTime(weekStart.year, weekStart.month, weekStart.day);
          periodEnd = periodStart.add(const Duration(days: 7));
        }

        return PotPoolModel(
          id: '${typeStr}_${periodStart.millisecondsSinceEpoch}',
          type: typeStr,
          totalTokens: 0,
          participantCount: 0,
          periodStart: periodStart,
          periodEnd: periodEnd,
          isActive: true,
          isDistributed: false,
          createdAt: now,
        );
      }

      final doc = snapshot.docs.first;
      return PotPoolModel.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    });
  }

  @override
  Future<List<PotPoolModel>> getPotHistory({
    required PotType type,
    int? limit,
  }) async {
    final typeStr = type == PotType.daily ? 'daily' : 'weekly';

    var query = _potsCollection
        .where('type', isEqualTo: typeStr)
        .where('isDistributed', isEqualTo: true)
        .orderBy('periodEnd', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      return PotPoolModel.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    }).toList();
  }

  @override
  Future<PotPoolModel> getPotById(String potId) async {
    final doc = await _potsCollection.doc(potId).get();

    if (!doc.exists) {
      throw Exception('Pot not found');
    }

    return PotPoolModel.fromJson({
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>,
    });
  }

  @override
  Future<List<UserScoreModel>> getDailyLeaderboard({int? limit}) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    var query = _leaderboardsCollection
        .doc('daily')
        .collection('scores')
        .where('periodStart', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
        .where('periodStart', isLessThan: Timestamp.fromDate(todayEnd))
        .orderBy('periodStart')
        .orderBy('totalTokensEarned', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs.asMap().entries.map((entry) {
      final doc = entry.value;
      return UserScoreModel.fromJson({
        ...doc.data(),
        'rank': entry.key + 1,
      });
    }).toList();
  }

  @override
  Future<List<UserScoreModel>> getWeeklyLeaderboard({int? limit}) async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartDate = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final weekEnd = weekStartDate.add(const Duration(days: 7));

    var query = _leaderboardsCollection
        .doc('weekly')
        .collection('scores')
        .where('periodStart', isGreaterThanOrEqualTo: Timestamp.fromDate(weekStartDate))
        .where('periodStart', isLessThan: Timestamp.fromDate(weekEnd))
        .orderBy('periodStart')
        .orderBy('totalTokensEarned', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs.asMap().entries.map((entry) {
      final doc = entry.value;
      return UserScoreModel.fromJson({
        ...doc.data(),
        'rank': entry.key + 1,
      });
    }).toList();
  }

  @override
  Future<List<UserScoreModel>> getAllTimeLeaderboard({int? limit}) async {
    var query = _leaderboardsCollection
        .doc('allTime')
        .collection('scores')
        .orderBy('totalTokensEarned', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();

    return snapshot.docs.asMap().entries.map((entry) {
      final doc = entry.value;
      final data = doc.data();
      return UserScoreModel.fromJson({
        ...data,
        'rank': entry.key + 1,
        'periodStart': data['periodStart'] ?? Timestamp.now(),
        'periodEnd': data['periodEnd'] ?? Timestamp.now(),
        'updatedAt': data['updatedAt'] ?? Timestamp.now(),
      });
    }).toList();
  }

  @override
  Stream<List<UserScoreModel>> watchLeaderboard({
    required PotType type,
    int? limit,
  }) {
    final typeStr = type == PotType.daily ? 'daily' : 'weekly';
    final now = DateTime.now();

    DateTime periodStart;
    DateTime periodEnd;

    if (type == PotType.daily) {
      periodStart = DateTime(now.year, now.month, now.day);
      periodEnd = periodStart.add(const Duration(days: 1));
    } else {
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      periodStart = DateTime(weekStart.year, weekStart.month, weekStart.day);
      periodEnd = periodStart.add(const Duration(days: 7));
    }

    var query = _leaderboardsCollection
        .doc(typeStr)
        .collection('scores')
        .where('periodStart', isGreaterThanOrEqualTo: Timestamp.fromDate(periodStart))
        .where('periodStart', isLessThan: Timestamp.fromDate(periodEnd))
        .orderBy('periodStart')
        .orderBy('totalTokensEarned', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.asMap().entries.map((entry) {
        final doc = entry.value;
        return UserScoreModel.fromJson({
          ...doc.data(),
          'rank': entry.key + 1,
        });
      }).toList();
    });
  }

  @override
  Future<UserScoreModel> getCurrentUserScore(PotType type) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final typeStr = type == PotType.daily ? 'daily' : 'weekly';
    final now = DateTime.now();

    DateTime periodStart;
    DateTime periodEnd;

    if (type == PotType.daily) {
      periodStart = DateTime(now.year, now.month, now.day);
      periodEnd = periodStart.add(const Duration(days: 1));
    } else {
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      periodStart = DateTime(weekStart.year, weekStart.month, weekStart.day);
      periodEnd = periodStart.add(const Duration(days: 7));
    }

    final doc = await _leaderboardsCollection
        .doc(typeStr)
        .collection('scores')
        .doc(userId)
        .get();

    if (!doc.exists) {
      // Return default score
      return UserScoreModel(
        oddienceUserId: userId,
        displayName: 'You',
        totalTokensEarned: 0,
        rank: 0,
        engagementsCompleted: 0,
        currentStreak: 0,
        longestStreak: 0,
        periodStart: periodStart,
        periodEnd: periodEnd,
        updatedAt: now,
      );
    }

    final data = doc.data()!;
    // Get rank by querying users with higher scores
    final higherScoresCount = await _leaderboardsCollection
        .doc(typeStr)
        .collection('scores')
        .where('totalTokensEarned', isGreaterThan: data['totalTokensEarned'])
        .count()
        .get();

    return UserScoreModel.fromJson({
      ...data,
      'rank': (higherScoresCount.count ?? 0) + 1,
    });
  }

  @override
  Future<int> getCurrentUserRank(PotType type) async {
    final score = await getCurrentUserScore(type);
    return score.rank;
  }

  @override
  Future<bool> isEligibleForPot(PotType type) async {
    final userId = _currentUserId;
    if (userId == null) {
      return false;
    }

    try {
      final score = await getCurrentUserScore(type);
      // User is eligible if they have completed at least 1 engagement
      return score.engagementsCompleted > 0;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<PotWinnerModel>> getPotDistributionPreview(String potId) async {
    final potDoc = await _potsCollection.doc(potId).get();

    if (!potDoc.exists) {
      return [];
    }

    final potData = potDoc.data() as Map<String, dynamic>;
    final totalTokens = potData['totalTokens'] as int? ?? 0;

    if (totalTokens == 0) {
      return [];
    }

    // Get top 10 for preview
    final type = potData['type'] as String? ?? 'daily';
    final periodStart = potData['periodStart'] as Timestamp;
    // ignore: unused_local_variable
    final periodEnd = potData['periodEnd'] as Timestamp;

    final leaderboard = await _leaderboardsCollection
        .doc(type)
        .collection('scores')
        .where('periodStart', isEqualTo: periodStart)
        .orderBy('totalTokensEarned', descending: true)
        .limit(10)
        .get();

    // Distribution percentages for top 10
    const percentages = [30.0, 20.0, 15.0, 10.0, 8.0, 6.0, 5.0, 3.0, 2.0, 1.0];

    return leaderboard.docs.asMap().entries.map((entry) {
      final index = entry.key;
      final doc = entry.value;
      final data = doc.data();
      final percentage = index < percentages.length ? percentages[index] : 0.0;
      final tokensWon = (totalTokens * percentage / 100).round();

      return PotWinnerModel(
        oddienceUserId: data['oddienceUserId'] as String,
        displayName: data['displayName'] as String? ?? 'User',
        username: data['username'] as String?,
        rank: index + 1,
        tokensWon: tokensWon,
        percentage: percentage,
      );
    }).toList();
  }
}
