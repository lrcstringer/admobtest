import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_score.freezed.dart';
part 'user_score.g.dart';

/// User score for leaderboard
@freezed
class UserScore with _$UserScore {
  const factory UserScore({
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
    /// Base score from completed engagements (before multipliers)
    @Default(0) int baseScore,
    /// Streak multiplier (1.0 + streak * 0.05, max 2.0)
    @Default(1.0) double streakMultiplier,
    /// Score from referred users' activity in this period
    @Default(0) int assistScore,
    /// Quality score based on active referrals
    @Default(0) int referralQualityScore,
    /// Final calculated score with all multipliers applied
    @Default(0) int finalScore,
    /// Timestamp of first engagement completion in this period
    DateTime? firstCompletionAt,
  }) = _UserScore;

  const UserScore._();

  factory UserScore.fromJson(Map<String, dynamic> json) =>
      _$UserScoreFromJson(json);

  /// Get rank change from previous
  int? get rankChange {
    if (previousRank == null) return null;
    return previousRank! - rank; // Positive = moved up, negative = moved down
  }

  /// Check if rank improved
  bool get rankImproved => rankChange != null && rankChange! > 0;

  /// Check if rank dropped
  bool get rankDropped => rankChange != null && rankChange! < 0;

  /// Get initials for avatar
  String get initials {
    if (displayName.isEmpty) return '??';
    final words = displayName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return displayName.substring(0, displayName.length.clamp(0, 2)).toUpperCase();
  }
}
