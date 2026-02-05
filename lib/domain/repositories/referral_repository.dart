import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/referral.dart';

/// Referral repository interface
abstract class ReferralRepository {
  /// Get user's referral code
  Future<Either<Failure, String>> getReferralCode();

  /// Get referral stats
  Future<Either<Failure, ReferralStats>> getReferralStats();

  /// Get referral list
  Future<Either<Failure, List<Referral>>> getReferrals({
    ReferralStatus? status,
    int? limit,
    DateTime? startAfter,
  });

  /// Stream referrals
  Stream<Either<Failure, List<Referral>>> watchReferrals();

  /// Get referral by ID
  Future<Either<Failure, Referral>> getReferralById(String referralId);

  /// Apply referral code (as referee)
  Future<Either<Failure, Referral>> applyReferralCode(String code);

  /// Generate shareable referral link
  Future<Either<Failure, String>> generateShareableLink();

  /// Share referral via platform. Returns true if the user actually shared.
  Future<Either<Failure, bool>> shareReferral({
    required String platform,
    String? customMessage,
  });

  /// Check if referral code is valid
  Future<Either<Failure, bool>> isValidReferralCode(String code);

  /// Get referral leaderboard
  Future<Either<Failure, List<ReferralStats>>> getReferralLeaderboard({
    int? limit,
  });
}
