import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox_thread.freezed.dart';
part 'inbox_thread.g.dart';

/// Thread within a client group in the earn inbox
@freezed
class InboxThread with _$InboxThread {
  const factory InboxThread({
    required String id,
    required String title,
    String? description,
    String? threadImage,
    required bool isPinned,
    required bool isFeatured,
    DateTime? activeTo,
    required int availableOpportunities,
    required int totalTokenReward,
    @Default([]) List<String> rewardTypes,
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

  /// Whether this thread is expiring within 5 days
  bool get isExpiringSoon {
    final days = daysUntilExpiry;
    return days != null && days <= 5;
  }

  /// Human-readable label for the first reward type
  String? get rewardTypeLabel {
    if (rewardTypes.isEmpty) return null;
    return _rewardTypeDisplayName(rewardTypes.first);
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
