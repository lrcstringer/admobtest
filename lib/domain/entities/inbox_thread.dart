import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox_thread.freezed.dart';
part 'inbox_thread.g.dart';

/// Thread within a client group in the earn inbox
@freezed
abstract class InboxThread with _$InboxThread {
  const factory InboxThread({
    required String id,
    required String title,
    String? description,
    String? threadImage,
    required bool isPinned,
    required bool isFeatured,
    DateTime? activeTo,
    required int availableOpportunities,
    @Default(0) int completedByUser,
    required int totalTokenReward,
    @Default([]) List<String> rewardTypes,
    @Default([]) List<String> earningTypes,
    @Default(0) int estimatedDurationSeconds,
    @Default([]) List<String> opportunityIds,
    @Default(false) bool hasRewardCampaign,
    DateTime? soonestExpiry,
  }) = _InboxThread;

  const InboxThread._();

  factory InboxThread.fromJson(Map<String, dynamic> json) =>
      _$InboxThreadFromJson(json);

  /// Days until the soonest expiry (thread or opportunity)
  int? get daysUntilExpiry {
    if (soonestExpiry == null) return null;
    return soonestExpiry!.difference(DateTime.now()).inDays;
  }

  /// Whether the user has completed all opportunities in this thread
  bool get allCompleted =>
      availableOpportunities > 0 && completedByUser >= availableOpportunities;

  /// Whether this thread is expiring within 5 days
  bool get isExpiringSoon {
    final days = daysUntilExpiry;
    return days != null && days <= 5;
  }

  /// Whether this thread has exactly one opportunity (skip intermediate screen)
  bool get isSingleOpportunity =>
      opportunityIds.length == 1 && opportunityIds.first.isNotEmpty;

  /// The single opportunity ID (only valid when isSingleOpportunity is true)
  String? get singleOpportunityId =>
      isSingleOpportunity ? opportunityIds.first : null;

  /// Human-readable earning type label
  String get earningTypeLabel {
    if (earningTypes.isEmpty) return 'Earn';
    if (earningTypes.length == 1) return _earningTypeDisplayName(earningTypes.first);
    return 'Multiple';
  }

  /// Formatted estimated duration
  String get formattedDuration {
    if (estimatedDurationSeconds <= 0) return '';
    if (estimatedDurationSeconds < 60) return '${estimatedDurationSeconds}s';
    final minutes = estimatedDurationSeconds ~/ 60;
    final seconds = estimatedDurationSeconds % 60;
    if (seconds == 0) return '${minutes}m';
    return '${minutes}m ${seconds}s';
  }

  /// Human-readable label for the first reward type
  String? get rewardTypeLabel {
    if (rewardTypes.isEmpty) return null;
    return _rewardTypeDisplayName(rewardTypes.first);
  }

  static String _earningTypeDisplayName(String type) {
    switch (type) {
      case 'survey':
        return 'Survey';
      case 'video':
        return 'Video';
      case 'image':
        return 'Image';
      case 'poll':
        return 'Poll';
      case 'adVideo':
        return 'Watch & Earn';
      case 'upload':
        return 'Upload';
      default:
        return 'Earn';
    }
  }

  static String _rewardTypeDisplayName(String type) {
    switch (type) {
      case 'qrCode':
        return 'QR Code';
      case 'voucherCode':
        return 'Voucher';
      case 'discountCode':
        return 'Discount';
      case 'digitalContent':
        return 'Digital Content';
      default:
        return 'Reward';
    }
  }
}
