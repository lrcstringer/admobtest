import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/group_buy.dart';
import '../entities/group_buy_contribution.dart';

abstract class GroupBuyRepository {
  /// Get active group buys (optionally filtered by community)
  Future<Either<Failure, List<GroupBuy>>> getActiveGroupBuys({
    String? communityId,
  });

  /// Get a single group buy by ID
  Future<Either<Failure, GroupBuy>> getGroupBuy(String id);

  /// Get contributions for a group buy
  Future<Either<Failure, List<GroupBuyContribution>>> getContributions(
      String groupBuyId);

  /// Get group buys the current user has participated in
  Future<Either<Failure, List<GroupBuy>>> getMyGroupBuys();

  /// Create a new group buy
  Future<Either<Failure, String>> createGroupBuy({
    required String title,
    required String description,
    required int targetAmount,
    required DateTime deadline,
    String? linkedListingId,
    int minParticipants,
    int? maxParticipants,
  });

  /// Join a group buy with a contribution
  Future<Either<Failure, void>> joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
    String? deliveryAddress,
  });

  /// Get admin-curated group buys for the hub
  /// Digital deals shown to all, physical deals filtered by user clusters
  Future<Either<Failure, List<GroupBuy>>> getHubGroupBuys({
    List<String> userClusters = const [],
  });

  /// Complete a group buy (organizer only, releases escrow)
  Future<Either<Failure, void>> completeGroupBuy({
    required String groupBuyId,
  });

  /// Leave a group buy (refunds contribution)
  Future<Either<Failure, void>> leaveGroupBuy({
    required String groupBuyId,
  });

  /// Submit a deal suggestion for admin review
  Future<Either<Failure, String>> suggestGroupBuyDeal({
    required String description,
    required String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    bool wantsToJoin = true,
  });

  /// Confirm collection of a physical item
  Future<Either<Failure, void>> confirmCollection({
    required String groupBuyId,
    required String contributionId,
  });

  /// Cancel a community group buy (organizer only)
  Future<Either<Failure, void>> cancelGroupBuy({
    required String groupBuyId,
    String? reason,
  });

  /// Update delivery status (organizer only)
  Future<Either<Failure, void>> updateDeliveryStatus({
    required String groupBuyId,
    required String deliveryStatus,
    String? trackingInfo,
  });
}
