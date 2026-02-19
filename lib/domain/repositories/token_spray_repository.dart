import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/token_spray.dart';
import '../enums/spray_occasion.dart';

/// Token Spray repository interface
///
/// Defines the contract for community token spray (celebration) operations:
/// - Creating a spray for a community member
/// - Contributing tokens to an active spray
/// - Spray lifecycle (close, claim)
/// - Query and real-time watching
abstract class TokenSprayRepository {
  // =========================================================================
  // CREATE
  // =========================================================================

  /// Create a new token spray celebration in a community
  Future<Either<Failure, TokenSpray>> createSpray({
    required String communityId,
    required String recipientId,
    required SprayOccasion occasion,
    required String message,
    int? targetAmount,
  });

  // =========================================================================
  // CONTRIBUTE
  // =========================================================================

  /// Contribute tokens to an active spray
  Future<Either<Failure, TokenSpray>> contributeToSpray({
    required String sprayId,
    required int amount,
    String? message,
  });

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  /// Close a spray (only creator or community admin)
  Future<Either<Failure, TokenSpray>> closeSpray(String sprayId);

  /// Claim a spray (only recipient — transfers accumulated tokens)
  Future<Either<Failure, TokenSpray>> claimSpray(String sprayId);

  // =========================================================================
  // QUERY
  // =========================================================================

  /// Get a single spray by ID
  Future<Either<Failure, TokenSpray>> getSpray(String sprayId);

  /// Watch a spray in real-time (for live contribution updates)
  Stream<Either<Failure, TokenSpray>> watchSpray(String sprayId);

  /// Get spray history for a community
  Future<Either<Failure, List<TokenSpray>>> getCommunitySprayHistory(
    String communityId, {
    int? limit,
  });
}
