import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_score.freezed.dart';
part 'daily_score.g.dart';

/// Daily score entity
///
/// Tracks user's score for a specific day for pot draw rankings.
/// Stored at users/{userId}/dailyScores/{YYYY-MM-DD} in Firestore.
///
/// Score Formula:
/// finalScore = (engagementsCompleted × streakMultiplier) + assistScore
@freezed
class DailyScore with _$DailyScore {
  const factory DailyScore({
    /// Date in YYYY-MM-DD format (SAST timezone)
    required String date,
    /// Number of engagements completed this day
    required int engagementsCompleted,
    /// Total tokens earned this day
    required int tokensEarned,
    /// What day of streak this was (1, 2, 3, etc.)
    required int streakDay,
    /// Streak multiplier applied (1.0, 1.2, 1.35, or 1.5)
    required double streakMultiplier,
    /// Assist score from referrals (10% of referee earnings)
    required int assistScore,
    /// Final calculated score for ranking
    required int finalScore,
    /// Cached display name for leaderboard
    required String displayName,
    /// Cached username for leaderboard
    String? username,
    /// Cached avatar URL for leaderboard
    String? avatarUrl,
    required DateTime updatedAt,
  }) = _DailyScore;

  const DailyScore._();

  factory DailyScore.fromJson(Map<String, dynamic> json) =>
      _$DailyScoreFromJson(json);

  /// Get multiplier as percentage string (e.g., "+20%")
  String get multiplierDisplay {
    if (streakMultiplier <= 1.0) return '';
    final bonus = ((streakMultiplier - 1.0) * 100).round();
    return '+$bonus%';
  }

  /// Check if user has any activity this day
  bool get hasActivity => engagementsCompleted > 0 || assistScore > 0;

  /// Get the base score before multiplier and assist
  int get baseScore => engagementsCompleted;

  /// Get the multiplied score (before assist)
  int get multipliedScore => (engagementsCompleted * streakMultiplier).floor();
}
