import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/pot_pool.dart';
import '../../domain/entities/user_score.dart';
import '../../domain/enums/pot_type.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../datasources/remote/gamification_remote_datasource.dart';

@LazySingleton(as: GamificationRepository)
class GamificationRepositoryImpl implements GamificationRepository {
  final GamificationRemoteDataSource _remoteDataSource;

  GamificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PotPool>> getCurrentDailyPot() async {
    try {
      final model = await _remoteDataSource.getCurrentDailyPot();
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PotPool>> getCurrentWeeklyPot() async {
    try {
      final model = await _remoteDataSource.getCurrentWeeklyPot();
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, PotPool>> watchPot(PotType type) {
    return _remoteDataSource.watchPot(type).map((model) {
      try {
        return Right<Failure, PotPool>(model.toEntity());
      } catch (e) {
        return Left<Failure, PotPool>(Failure.serverError(message: e.toString()));
      }
    }).handleError((error) {
      return Left<Failure, PotPool>(Failure.serverError(message: error.toString()));
    });
  }

  @override
  Future<Either<Failure, List<PotPool>>> getPotHistory({
    required PotType type,
    int? limit,
  }) async {
    try {
      final models = await _remoteDataSource.getPotHistory(
        type: type,
        limit: limit,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PotPool>> getPotById(String potId) async {
    try {
      final model = await _remoteDataSource.getPotById(potId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserScore>>> getDailyLeaderboard({
    int? limit,
  }) async {
    try {
      final models = await _remoteDataSource.getDailyLeaderboard(limit: limit);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserScore>>> getWeeklyLeaderboard({
    int? limit,
  }) async {
    try {
      final models = await _remoteDataSource.getWeeklyLeaderboard(limit: limit);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserScore>>> getAllTimeLeaderboard({
    int? limit,
  }) async {
    try {
      final models = await _remoteDataSource.getAllTimeLeaderboard(limit: limit);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<UserScore>>> watchLeaderboard({
    required PotType type,
    int? limit,
  }) {
    return _remoteDataSource
        .watchLeaderboard(type: type, limit: limit)
        .map((models) {
      try {
        return Right<Failure, List<UserScore>>(
          models.map((m) => m.toEntity()).toList(),
        );
      } catch (e) {
        return Left<Failure, List<UserScore>>(
          Failure.serverError(message: e.toString()),
        );
      }
    }).handleError((error) {
      return Left<Failure, List<UserScore>>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, UserScore>> getCurrentUserScore(PotType type) async {
    try {
      final model = await _remoteDataSource.getCurrentUserScore(type);
      return Right(model.toEntity());
    } catch (e) {
      if (e.toString().contains('not authenticated')) {
        return const Left(Failure.unauthenticated());
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getCurrentUserRank(PotType type) async {
    try {
      final rank = await _remoteDataSource.getCurrentUserRank(type);
      return Right(rank);
    } catch (e) {
      if (e.toString().contains('not authenticated')) {
        return const Left(Failure.unauthenticated());
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isEligibleForPot(PotType type) async {
    try {
      final eligible = await _remoteDataSource.isEligibleForPot(type);
      return Right(eligible);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PotWinner>>> getPotDistributionPreview(
    String potId,
  ) async {
    try {
      final models = await _remoteDataSource.getPotDistributionPreview(potId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
