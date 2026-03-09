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
  });
}
