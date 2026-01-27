import 'package:freezed_annotation/freezed_annotation.dart';

part 'earn_thread.freezed.dart';
part 'earn_thread.g.dart';

/// Earn thread representing a brand's earn messages
@freezed
class EarnThread with _$EarnThread {
  const factory EarnThread({
    required String id,
    required String brandId,
    required String brandName,
    String? avatarColor,
    String? avatarImage,
    required bool isPinned,
    required bool isActive,
    required int availableOpportunities,
    required int completedOpportunities,
    required DateTime createdAt,
    DateTime? lastActivityAt,
  }) = _EarnThread;

  const EarnThread._();

  factory EarnThread.fromJson(Map<String, dynamic> json) =>
      _$EarnThreadFromJson(json);

  /// Get brand initials for avatar fallback
  String get brandInitials {
    if (brandName.isEmpty) return '??';
    final words = brandName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return brandName.substring(0, brandName.length.clamp(0, 2)).toUpperCase();
  }

  /// Check if thread has available opportunities
  bool get hasAvailable => availableOpportunities > 0;
}
