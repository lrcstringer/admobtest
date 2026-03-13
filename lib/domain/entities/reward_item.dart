import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/reward_enums.dart';

part 'reward_item.freezed.dart';
part 'reward_item.g.dart';

/// Reward item entity — a single non-fungible reward allocated to a user.
/// Code value is only populated on detail fetch (decrypted server-side).
@freezed
abstract class RewardItem with _$RewardItem {
  const factory RewardItem({
    required String id,
    required String campaignId,
    // Denormalized campaign info (for list display without extra reads)
    String? campaignName,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    RewardType? rewardType,
    required RewardItemStatus status,
    // Only populated on detail fetch (decrypted server-side)
    String? codeValue,
    DateTime? allocatedAt,
    DateTime? redeemedAt,
    DateTime? expiresAt,
    String? redemptionLocation,
    // Campaign-level metadata (instructions, terms, etc.)
    @Default({}) Map<String, dynamic> campaignMetadata,
    // Item-level metadata (batch, face value, etc.)
    @Default({}) Map<String, dynamic> itemMetadata,
  }) = _RewardItem;

  const RewardItem._();

  factory RewardItem.fromJson(Map<String, dynamic> json) =>
      _$RewardItemFromJson(json);

  /// Whether this item can still be used
  bool get isUsable => status == RewardItemStatus.allocated;

  /// Whether this item is expired or will expire soon
  bool get isExpiringSoon {
    if (expiresAt == null || !isUsable) return false;
    return expiresAt!.difference(DateTime.now()).inHours < 24;
  }

  /// Days until expiry (null if no expiry or already expired)
  int? get daysUntilExpiry {
    if (expiresAt == null) return null;
    final diff = expiresAt!.difference(DateTime.now()).inDays;
    return diff >= 0 ? diff : null;
  }

  /// Hours until expiry (for items expiring within 24h)
  int? get hoursUntilExpiry {
    if (expiresAt == null) return null;
    final diff = expiresAt!.difference(DateTime.now()).inHours;
    return diff >= 0 ? diff : null;
  }

  /// Redemption instructions from campaign metadata
  String? get redemptionInstructions =>
      campaignMetadata['redemption_instructions'] as String?;

  /// Terms and conditions from campaign metadata
  String? get termsAndConditions =>
      campaignMetadata['terms_and_conditions'] as String?;

  /// Whether this reward type has a scannable/copyable code
  bool get hasCode => rewardType?.hasCode ?? false;

  /// Whether this reward displays as QR
  bool get isQrType => rewardType?.isQrType ?? false;
}
