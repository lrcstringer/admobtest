import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_score.dart';

part 'user_score_model.freezed.dart';

@freezed
class UserScoreModel with _$UserScoreModel {
  const factory UserScoreModel({
    required String oddienceUserId,
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
  }) = _UserScoreModel;

  const UserScoreModel._();

  factory UserScoreModel.fromJson(Map<String, dynamic> json) {
    final periodStart = json['periodStart'];
    final periodEnd = json['periodEnd'];
    final updatedAt = json['updatedAt'];

    return UserScoreModel(
      oddienceUserId: json['oddienceUserId'] as String,
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
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'oddienceUserId': oddienceUserId,
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
    };
  }

  UserScore toEntity() {
    return UserScore(
      oddienceUserId: oddienceUserId,
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
    );
  }

  factory UserScoreModel.fromEntity(UserScore entity) {
    return UserScoreModel(
      oddienceUserId: entity.oddienceUserId,
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
    );
  }
}
