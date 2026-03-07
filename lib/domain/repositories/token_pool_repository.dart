import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/token_pool.dart';
import '../enums/gift_style.dart';
import '../enums/pool_mode.dart';

/// Repository interface for token pool (Collection Room) operations
abstract class TokenPoolRepository {
  // ===========================================================================
  // POOL LIFECYCLE
  // ===========================================================================

  /// Create a new token pool (Group Sasaza or Group Save)
  Future<Either<Failure, TokenPool>> createPool({
    required PoolMode mode,
    required String title,
    String? purpose,
    required String message,
    required GiftStyle style,
    String? recipientId,
    required List<String> inviteeIds,
    String? communityId,
  });

  /// Contribute tokens to a pool
  Future<Either<Failure, TokenPool>> contribute({
    required String poolId,
    required int amount,
    required bool anonymous,
  });

  /// Send the group gift to the recipient (sasaza mode only)
  Future<Either<Failure, TokenPool>> sendGroupGift(String poolId);

  /// Distribute pool tokens among participants (save mode only)
  Future<Either<Failure, TokenPool>> distributePool({
    required String poolId,
    required List<Map<String, dynamic>> payouts,
    bool keepOpen = false,
  });

  /// Cancel the pool and refund all contributions
  Future<Either<Failure, TokenPool>> cancelPool(String poolId);

  /// Request a withdrawal from a Group Save pool (auto-approved up to own contribution)
  Future<Either<Failure, TokenPool>> requestWithdrawal({
    required String poolId,
    required int amount,
  });

  // ===========================================================================
  // RECIPIENT ACTIONS (sasaza mode)
  // ===========================================================================

  /// Recipient opens the group gift (UI ceremony, no ledger operation)
  Future<Either<Failure, TokenPool>> openGroupGift(String poolId);

  /// Recipient claims the group gift (status update, no ledger operation)
  Future<Either<Failure, TokenPool>> claimGroupGift(String poolId);

  // ===========================================================================
  // QUERY
  // ===========================================================================

  /// Get a single pool by ID
  Future<Either<Failure, TokenPool>> getPool(String poolId);

  /// Watch a pool in real-time
  Stream<Either<Failure, TokenPool>> watchPool(String poolId);

  /// Get all pools the current user is part of (as organizer or invitee)
  Future<Either<Failure, List<TokenPool>>> getMyPools();
}
