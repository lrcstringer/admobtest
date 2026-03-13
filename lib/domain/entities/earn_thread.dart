import 'package:freezed_annotation/freezed_annotation.dart';

import 'targeting_criteria.dart';

part 'earn_thread.freezed.dart';
part 'earn_thread.g.dart';

/// Earn thread representing a campaign/brand's earn messages
@freezed
abstract class EarnThread with _$EarnThread {
  const factory EarnThread({
    required String id,
    // Client fields (renamed from brand)
    required String clientId,
    required String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String? threadImage,
    // Thread display
    required String title,
    String? description,
    // Flags
    required bool isPinned,
    required bool isFeatured,
    required bool isActive,
    @Default(false) bool budgetExhausted,
    // Scheduling
    DateTime? activeFrom,
    DateTime? activeTo,
    // Token configuration
    String? tokenSourceAccountId,
    String? tokenDestAccountTypeId,
    // Counts
    required int availableOpportunities,
    required int completedOpportunities,
    @Default(0) int completedUniqueUsers,
    // Timestamps
    required DateTime createdAt,
    DateTime? lastActivityAt,
    // Targeting
    TargetingCriteria? targeting,
  }) = _EarnThread;

  const EarnThread._();

  factory EarnThread.fromJson(Map<String, dynamic> json) =>
      _$EarnThreadFromJson(json);

  /// Get client initials for avatar fallback
  String get clientInitials {
    if (clientName.isEmpty) return '??';
    final words = clientName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return clientName.substring(0, clientName.length.clamp(0, 2)).toUpperCase();
  }

  /// Legacy alias for backwards compatibility
  String get brandInitials => clientInitials;

  /// Check if thread has available opportunities
  bool get hasAvailable => availableOpportunities > 0;

  /// Check if thread is currently active (considering scheduling and budget)
  bool get isCurrentlyActive {
    if (!isActive) return false;
    if (budgetExhausted) return false;
    final now = DateTime.now();
    if (activeFrom != null && now.isBefore(activeFrom!)) return false;
    if (activeTo != null && now.isAfter(activeTo!)) return false;
    return true;
  }

  /// Check if targeting is enabled
  bool get hasTargeting => targeting != null && !targeting!.isEmpty;

  /// Get targeting summary for display
  String get targetingSummary => targeting?.summary ?? 'All users';
}
