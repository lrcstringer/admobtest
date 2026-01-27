import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user_score.dart';
import '../entities/pot_pool.dart';
import '../enums/pot_type.dart';

/// Gamification repository interface (pots & leaderboards)
abstract class GamificationRepository {
  /// Get current daily pot
  Future<Either<Failure, PotPool>> getCurrentDailyPot();

  /// Get current weekly pot
  Future<Either<Failure, PotPool>> getCurrentWeeklyPot();

  /// Stream pot updates
  Stream<Either<Failure, PotPool>> watchPot(PotType type);

  /// Get pot history
  Future<Either<Failure, List<PotPool>>> getPotHistory({
    required PotType type,
    int? limit,
  });

  /// Get pot by ID
  Future<Either<Failure, PotPool>> getPotById(String potId);

  /// Get daily leaderboard
  Future<Either<Failure, List<UserScore>>> getDailyLeaderboard({
    int? limit,
  });

  /// Get weekly leaderboard
  Future<Either<Failure, List<UserScore>>> getWeeklyLeaderboard({
    int? limit,
  });

  /// Get all-time leaderboard
  Future<Either<Failure, List<UserScore>>> getAllTimeLeaderboard({
    int? limit,
  });

  /// Stream leaderboard updates
  Stream<Either<Failure, List<UserScore>>> watchLeaderboard({
    required PotType type,
    int? limit,
  });

  /// Get current user's score
  Future<Either<Failure, UserScore>> getCurrentUserScore(PotType type);

  /// Get current user's rank
  Future<Either<Failure, int>> getCurrentUserRank(PotType type);

  /// Check if user is eligible for pot
  Future<Either<Failure, bool>> isEligibleForPot(PotType type);

  /// Get pot distribution preview
  Future<Either<Failure, List<PotWinner>>> getPotDistributionPreview(
    String potId,
  );
}
