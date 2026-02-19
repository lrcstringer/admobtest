import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/gift.dart';
import '../enums/gift_style.dart';

/// Gift repository interface
///
/// Defines the contract for iMali gift operations including:
/// - Sending gifts (in conversations or communities)
/// - Gift lifecycle (open, claim)
/// - Query (sent, received, by ID)
/// - Stats
abstract class GiftRepository {
  // =========================================================================
  // SEND
  // =========================================================================

  /// Send a gift to a user (creates gift document + associated message)
  Future<Either<Failure, Gift>> sendGift({
    required String recipientId,
    required int amount,
    required String message,
    required GiftStyle style,
    String? conversationId,
    String? communityId,
  });

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  /// Open a gift (recipient saw it — updates status to opened)
  Future<Either<Failure, Gift>> openGift(String giftId);

  /// Claim a gift (transfers tokens to recipient)
  Future<Either<Failure, Gift>> claimGift(String giftId);

  // =========================================================================
  // QUERY
  // =========================================================================

  /// Get gifts sent by current user
  Future<Either<Failure, List<Gift>>> getSentGifts({int? limit});

  /// Get gifts received by current user
  Future<Either<Failure, List<Gift>>> getReceivedGifts({int? limit});

  /// Get a single gift by ID
  Future<Either<Failure, Gift>> getGift(String giftId);

  /// Watch a gift in real-time (for live status updates)
  Stream<Either<Failure, Gift>> watchGift(String giftId);

  // =========================================================================
  // STATS
  // =========================================================================

  /// Get aggregate gift statistics for current user
  Future<Either<Failure, GiftStats>> getGiftStats();
}
