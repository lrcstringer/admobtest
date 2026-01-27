import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/referral.dart';
import '../../domain/repositories/referral_repository.dart';
import '../datasources/remote/referral_remote_datasource.dart';

@LazySingleton(as: ReferralRepository)
class ReferralRepositoryImpl implements ReferralRepository {
  final ReferralRemoteDataSource _remoteDataSource;

  ReferralRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, String>> getReferralCode() async {
    try {
      final code = await _remoteDataSource.getReferralCode();
      return Right(code);
    } catch (e) {
      if (e.toString().contains('not authenticated')) {
        return const Left(Failure.unauthenticated());
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReferralStats>> getReferralStats() async {
    try {
      final model = await _remoteDataSource.getReferralStats();
      return Right(model.toEntity());
    } catch (e) {
      if (e.toString().contains('not authenticated')) {
        return const Left(Failure.unauthenticated());
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Referral>>> getReferrals({
    ReferralStatus? status,
    int? limit,
    DateTime? startAfter,
  }) async {
    try {
      final models = await _remoteDataSource.getReferrals(
        status: status,
        limit: limit,
        startAfter: startAfter,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      if (e.toString().contains('not authenticated')) {
        return const Left(Failure.unauthenticated());
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Referral>>> watchReferrals() {
    return _remoteDataSource.watchReferrals().map((models) {
      try {
        return Right<Failure, List<Referral>>(
          models.map((m) => m.toEntity()).toList(),
        );
      } catch (e) {
        return Left<Failure, List<Referral>>(
          Failure.serverError(message: e.toString()),
        );
      }
    }).handleError((error) {
      return Left<Failure, List<Referral>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, Referral>> getReferralById(String referralId) async {
    try {
      final model = await _remoteDataSource.getReferralById(referralId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Referral>> applyReferralCode(String code) async {
    try {
      final model = await _remoteDataSource.applyReferralCode(code);
      return Right(model.toEntity());
    } catch (e) {
      if (e.toString().contains('not authenticated')) {
        return const Left(Failure.unauthenticated());
      }
      if (e.toString().contains('Invalid referral code')) {
        return const Left(Failure.unknown(message: 'Invalid referral code'));
      }
      if (e.toString().contains('cannot use your own')) {
        return const Left(
            Failure.unknown(message: 'You cannot use your own referral code'));
      }
      if (e.toString().contains('already used')) {
        return const Left(
            Failure.unknown(message: 'You have already used a referral code'));
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> generateShareableLink() async {
    try {
      final link = await _remoteDataSource.generateShareableLink();
      return Right(link);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> shareReferral({
    required String platform,
    String? customMessage,
  }) async {
    try {
      await _remoteDataSource.shareReferral(
        platform: platform,
        customMessage: customMessage,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isValidReferralCode(String code) async {
    try {
      final isValid = await _remoteDataSource.isValidReferralCode(code);
      return Right(isValid);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReferralStats>>> getReferralLeaderboard({
    int? limit,
  }) async {
    try {
      final models =
          await _remoteDataSource.getReferralLeaderboard(limit: limit);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
