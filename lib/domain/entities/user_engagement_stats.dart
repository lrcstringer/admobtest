import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_engagement_stats.freezed.dart';
part 'user_engagement_stats.g.dart';

/// User engagement stats entity
///
/// Tracks user's streak and engagement history.
/// Stored at userEngagementStats/{userId} in Firestore.
@freezed
abstract class UserEngagementStats with _$UserEngagementStats {
  const factory UserEngagementStats({
    required String userId,
    /// Current consecutive days with completions
    required int currentStreak,
    /// Longest streak ever achieved
    required int longestStreak,
    /// When the current streak started (null if no streak)
    DateTime? streakStartedAt,
    /// Last date user earned tokens (YYYY-MM-DD in SAST)
    String? lastEarnedDate,
    /// Total engagements completed all-time
    required int totalEngagementsCompleted,
    /// Total tokens earned all-time
    required int totalTokensEarned,
    required DateTime updatedAt,
  }) = _UserEngagementStats;

  const UserEngagementStats._();

  factory UserEngagementStats.fromJson(Map<String, dynamic> json) =>
      _$UserEngagementStatsFromJson(json);

  /// Get the current streak multiplier based on tiered system
  /// Days 1-2: ×1.00
  /// Days 3-6: ×1.20
  /// Days 7-9: ×1.35
  /// Days 10+: ×1.50
  double get streakMultiplier {
    if (currentStreak <= 0) return 1.0;
    if (currentStreak <= 2) return 1.0;
    if (currentStreak <= 6) return 1.2;
    if (currentStreak <= 9) return 1.35;
    return 1.5;
  }

  /// Check if user has an active streak
  bool get hasStreak => currentStreak > 0;

  /// Get streak tier name for display
  String get streakTierName {
    if (currentStreak <= 0) return 'No streak';
    if (currentStreak <= 2) return 'Starter';
    if (currentStreak <= 6) return 'Growing';
    if (currentStreak <= 9) return 'Strong';
    return 'Master';
  }

  /// Get multiplier as percentage string (e.g., "+20%")
  String get multiplierDisplay {
    final mult = streakMultiplier;
    if (mult <= 1.0) return '';
    final bonus = ((mult - 1.0) * 100).round();
    return '+$bonus%';
  }

  /// Create empty stats for new user
  factory UserEngagementStats.empty(String userId) => UserEngagementStats(
        userId: userId,
        currentStreak: 0,
        longestStreak: 0,
        totalEngagementsCompleted: 0,
        totalTokensEarned: 0,
        updatedAt: DateTime.now(),
      );
}
