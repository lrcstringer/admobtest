import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_score.dart';

part 'user_score_model.freezed.dart';

@freezed
class UserScoreModel with _$UserScoreModel {
  const factory UserScoreModel({
    required String userId,
    required String displayName,
    String? username,
    String? avatarUrl,
    String? avatarColor,
    required int totalTokensEarned,
    required int rank,
    int? previousRank,
    required int engagementsCompleted,
    required int currentStreak,
    required int longestStreak,
    required DateTime periodStart,
    required DateTime periodEnd,
    required DateTime updatedAt,
    // New scoring fields
    @Default(0) int baseScore,
    @Default(1.0) double streakMultiplier,
    @Default(0) int assistScore,
    @Default(0) int referralQualityScore,
    @Default(0) int finalScore,
    DateTime? firstCompletionAt,
  }) = _UserScoreModel;

  const UserScoreModel._();

  factory UserScoreModel.fromJson(Map<String, dynamic> json) {
    final periodStart = json['periodStart'];
    final periodEnd = json['periodEnd'];
    final updatedAt = json['updatedAt'];
    final firstCompletionAt = json['firstCompletionAt'];

    return UserScoreModel(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String? ?? 'User',
      username: json['username'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
      totalTokensEarned: json['totalTokensEarned'] as int? ?? 0,
      rank: json['rank'] as int? ?? 0,
      previousRank: json['previousRank'] as int?,
      engagementsCompleted: json['engagementsCompleted'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      periodStart: periodStart is Timestamp
          ? periodStart.toDate()
          : DateTime.parse(periodStart as String),
      periodEnd: periodEnd is Timestamp
          ? periodEnd.toDate()
          : DateTime.parse(periodEnd as String),
      updatedAt: updatedAt is Timestamp
          ? updatedAt.toDate()
          : DateTime.parse(updatedAt as String),
      // New scoring fields
      baseScore: json['baseScore'] as int? ?? 0,
      streakMultiplier: (json['streakMultiplier'] as num?)?.toDouble() ?? 1.0,
      assistScore: json['assistScore'] as int? ?? 0,
      referralQualityScore: json['referralQualityScore'] as int? ?? 0,
      finalScore: json['finalScore'] as int? ?? 0,
      firstCompletionAt: firstCompletionAt == null
          ? null
          : firstCompletionAt is Timestamp
              ? firstCompletionAt.toDate()
              : DateTime.parse(firstCompletionAt as String),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'username': username,
      'avatarUrl': avatarUrl,
      'avatarColor': avatarColor,
      'totalTokensEarned': totalTokensEarned,
      'rank': rank,
      'previousRank': previousRank,
      'engagementsCompleted': engagementsCompleted,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'periodStart': Timestamp.fromDate(periodStart),
      'periodEnd': Timestamp.fromDate(periodEnd),
      'updatedAt': Timestamp.fromDate(updatedAt),
      // New scoring fields
      'baseScore': baseScore,
      'streakMultiplier': streakMultiplier,
      'assistScore': assistScore,
      'referralQualityScore': referralQualityScore,
      'finalScore': finalScore,
      if (firstCompletionAt != null)
        'firstCompletionAt': Timestamp.fromDate(firstCompletionAt!),
    };
  }

  UserScore toEntity() {
    return UserScore(
      userId: userId,
      displayName: displayName,
      username: username,
      avatarUrl: avatarUrl,
      avatarColor: avatarColor,
      totalTokensEarned: totalTokensEarned,
      rank: rank,
      previousRank: previousRank,
      engagementsCompleted: engagementsCompleted,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      periodStart: periodStart,
      periodEnd: periodEnd,
      updatedAt: updatedAt,
      // New scoring fields
      baseScore: baseScore,
      streakMultiplier: streakMultiplier,
      assistScore: assistScore,
      referralQualityScore: referralQualityScore,
      finalScore: finalScore,
      firstCompletionAt: firstCompletionAt,
    );
  }

  factory UserScoreModel.fromEntity(UserScore entity) {
    return UserScoreModel(
      userId: entity.userId,
      displayName: entity.displayName,
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      avatarColor: entity.avatarColor,
      totalTokensEarned: entity.totalTokensEarned,
      rank: entity.rank,
      previousRank: entity.previousRank,
      engagementsCompleted: entity.engagementsCompleted,
      currentStreak: entity.currentStreak,
      longestStreak: entity.longestStreak,
      periodStart: entity.periodStart,
      periodEnd: entity.periodEnd,
      updatedAt: entity.updatedAt,
      // New scoring fields
      baseScore: entity.baseScore,
      streakMultiplier: entity.streakMultiplier,
      assistScore: entity.assistScore,
      referralQualityScore: entity.referralQualityScore,
      finalScore: entity.finalScore,
      firstCompletionAt: entity.firstCompletionAt,
    );
  }
}
