import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/reward_campaign.dart';
import '../entities/reward_item.dart';

/// Reward repository interface
abstract class RewardRepository {
  /// Get user's reward items, optionally filtered by status
  Future<Either<Failure, List<RewardItem>>> getUserRewardItems({
    String? status,
  });

  /// Get single reward item with decrypted code value
  Future<Either<Failure, RewardItem>> getRewardItemDetail(String itemId);

  /// Mark reward item as redeemed
  Future<Either<Failure, void>> redeemRewardItem(
    String itemId, {
    String? location,
  });

  /// Get active reward campaigns the user can earn from
  Future<Either<Failure, List<RewardCampaign>>> getActiveCampaigns();
}
