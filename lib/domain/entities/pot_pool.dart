import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/pot_type.dart';

part 'pot_pool.freezed.dart';
part 'pot_pool.g.dart';

/// Pot pool entity representing a daily/weekly jackpot
@freezed
class PotPool with _$PotPool {
  const factory PotPool({
    required String id,
    required PotType type,
    required int totalTokens,
    required int participantCount,
    required DateTime periodStart,
    required DateTime periodEnd,
    required bool isActive,
    required bool isDistributed,
    DateTime? distributedAt,
    List<PotWinner>? winners,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _PotPool;

  const PotPool._();

  factory PotPool.fromJson(Map<String, dynamic> json) =>
      _$PotPoolFromJson(json);

  /// Get time remaining until distribution
  Duration get timeRemaining {
    final now = DateTime.now();
    if (now.isAfter(periodEnd)) return Duration.zero;
    return periodEnd.difference(now);
  }

  /// Check if pot is about to close (within 1 hour)
  bool get isClosingSoon => timeRemaining.inHours < 1 && timeRemaining.inSeconds > 0;

  /// Get formatted pot value
  String get formattedTotal => '${totalTokens.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )} tokens';

  /// Get period label
  String get periodLabel {
    switch (type) {
      case PotType.daily:
        return 'Daily Pot';
      case PotType.weekly:
        return 'Weekly Pot';
    }
  }
}

/// Winner of a pot distribution
@freezed
class PotWinner with _$PotWinner {
  const factory PotWinner({
    required String oddienceUserId,
    required String displayName,
    String? username,
    required int rank,
    required int tokensWon,
    required double percentage,
  }) = _PotWinner;

  factory PotWinner.fromJson(Map<String, dynamic> json) =>
      _$PotWinnerFromJson(json);
}
