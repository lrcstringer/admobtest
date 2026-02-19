import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/token_spray.dart';
import '../../domain/enums/spray_occasion.dart';
import '../../domain/repositories/token_spray_repository.dart';
import '../datasources/remote/token_spray_remote_datasource.dart';

@LazySingleton(as: TokenSprayRepository)
class TokenSprayRepositoryImpl implements TokenSprayRepository {
  final TokenSprayRemoteDataSource _remoteDataSource;

  TokenSprayRepositoryImpl(this._remoteDataSource);

  // =========================================================================
  // CREATE
  // =========================================================================

  @override
  Future<Either<Failure, TokenSpray>> createSpray({
    required String communityId,
    required String recipientId,
    required SprayOccasion occasion,
    required String message,
    int? targetAmount,
  }) async {
    try {
      final model = await _remoteDataSource.createSpray(
        communityId: communityId,
        recipientId: recipientId,
        occasion: _occasionToString(occasion),
        message: message,
        targetAmount: targetAmount,
      );
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // CONTRIBUTE
  // =========================================================================

  @override
  Future<Either<Failure, TokenSpray>> contributeToSpray({
    required String sprayId,
    required int amount,
    String? message,
  }) async {
    try {
      final model = await _remoteDataSource.contributeToSpray(
        sprayId: sprayId,
        amount: amount,
        message: message,
      );
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  @override
  Future<Either<Failure, TokenSpray>> closeSpray(String sprayId) async {
    try {
      final model = await _remoteDataSource.closeSpray(sprayId);
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenSpray>> claimSpray(String sprayId) async {
    try {
      final model = await _remoteDataSource.claimSpray(sprayId);
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // QUERY
  // =========================================================================

  @override
  Future<Either<Failure, TokenSpray>> getSpray(String sprayId) async {
    try {
      final model = await _remoteDataSource.getSpray(sprayId);
      if (model == null) {
        return Left(Failure.serverError(message: 'Spray not found'));
      }
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, TokenSpray>> watchSpray(String sprayId) {
    return _remoteDataSource.watchSpray(sprayId).map((model) {
      return Right<Failure, TokenSpray>(model.toEntity());
    }).handleError((error) {
      if (error is AuthException) {
        return const Left<Failure, TokenSpray>(Failure.unauthenticated());
      }
      return Left<Failure, TokenSpray>(
        Failure.serverError(message: error.toString()),
      );
    });
  }

  @override
  Future<Either<Failure, List<TokenSpray>>> getCommunitySprayHistory(
    String communityId, {
    int? limit,
  }) async {
    try {
      final models = await _remoteDataSource.getCommunitySprayHistory(
        communityId,
        limit: limit,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  // =========================================================================
  // HELPERS
  // =========================================================================

  static String _occasionToString(SprayOccasion occasion) {
    switch (occasion) {
      case SprayOccasion.newJob:
        return 'new_job';
      case SprayOccasion.birthday:
        return 'birthday';
      case SprayOccasion.graduation:
        return 'graduation';
      case SprayOccasion.newBaby:
        return 'new_baby';
      case SprayOccasion.wedding:
        return 'wedding';
      case SprayOccasion.achievement:
        return 'achievement';
      case SprayOccasion.custom:
        return 'custom';
    }
  }
}
