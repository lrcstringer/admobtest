import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/reward_enums.dart';

part 'reward_campaign.freezed.dart';
part 'reward_campaign.g.dart';

/// Reward campaign entity — a batch of non-fungible reward items
/// linked to a client (sponsor) and optionally to earn opportunities.
@freezed
class RewardCampaign with _$RewardCampaign {
  const factory RewardCampaign({
    required String id,
    required String clientId,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    required String name,
    String? description,
    required RewardType rewardType,
    required CampaignStatus status,
    required int totalQuantity,
    required int remainingQuantity,
    @Default(0) int allocatedQuantity,
    @Default(0) int redeemedQuantity,
    @Default(1) int maxPerUser,
    required DateTime startsAt,
    required DateTime endsAt,
    DateTime? itemExpiresAt,
    String? displayImageUrl,
    @Default(0) int displayPriority,
    @Default({}) Map<String, dynamic> metadata,
    @Default([]) List<String> linkedOpportunityIds,
    required DateTime createdAt,
  }) = _RewardCampaign;

  const RewardCampaign._();

  factory RewardCampaign.fromJson(Map<String, dynamic> json) =>
      _$RewardCampaignFromJson(json);

  /// Whether items are still available for allocation
  bool get hasInventory => remainingQuantity > 0;

  /// Percentage of items allocated or redeemed
  double get utilizationRate =>
      totalQuantity > 0 ? (allocatedQuantity + redeemedQuantity) / totalQuantity : 0;

  /// Whether campaign is currently within its date range
  bool get isInDateRange {
    final now = DateTime.now();
    return now.isAfter(startsAt) && now.isBefore(endsAt);
  }

  /// Redemption instructions from metadata
  String? get redemptionInstructions =>
      metadata['redemption_instructions'] as String?;

  /// Terms and conditions from metadata
  String? get termsAndConditions =>
      metadata['terms_and_conditions'] as String?;

  /// Brand colour from metadata
  String? get brandColour => metadata['brand_colour'] as String?;
}
