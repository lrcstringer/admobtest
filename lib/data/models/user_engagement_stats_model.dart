import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_engagement_stats.dart';
import '../../core/utils/firestore_helpers.dart';

part 'user_engagement_stats_model.freezed.dart';
part 'user_engagement_stats_model.g.dart';

/// Data model for UserEngagementStats
///
/// Maps between Firestore document and UserEngagementStats entity.
/// Collection: userEngagementStats/{userId}
@freezed
abstract class UserEngagementStatsModel with _$UserEngagementStatsModel {
  const factory UserEngagementStatsModel({
    required String userId,
    required int currentStreak,
    required int longestStreak,
    @NullableTimestampConverter() DateTime? streakStartedAt,
    String? lastEarnedDate,
    required int totalEngagementsCompleted,
    required int totalTokensEarned,
    @TimestampConverter() required DateTime updatedAt,
  }) = _UserEngagementStatsModel;

  const UserEngagementStatsModel._();

  factory UserEngagementStatsModel.fromJson(Map<String, dynamic> json) =>
      _$UserEngagementStatsModelFromJson(json);

  /// Create from Firestore document
  factory UserEngagementStatsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    return UserEngagementStatsModel.fromJson({
      ...data,
      'userId': doc.id,
    });
  }

  /// Convert to domain entity
  UserEngagementStats toEntity() => UserEngagementStats(
        userId: userId,
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        streakStartedAt: streakStartedAt,
        lastEarnedDate: lastEarnedDate,
        totalEngagementsCompleted: totalEngagementsCompleted,
        totalTokensEarned: totalTokensEarned,
        updatedAt: updatedAt,
      );

  /// Create from domain entity
  factory UserEngagementStatsModel.fromEntity(UserEngagementStats entity) =>
      UserEngagementStatsModel(
        userId: entity.userId,
        currentStreak: entity.currentStreak,
        longestStreak: entity.longestStreak,
        streakStartedAt: entity.streakStartedAt,
        lastEarnedDate: entity.lastEarnedDate,
        totalEngagementsCompleted: entity.totalEngagementsCompleted,
        totalTokensEarned: entity.totalTokensEarned,
        updatedAt: entity.updatedAt,
      );
}
