import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/token_pool.dart';
import '../../domain/enums/gift_style.dart';
import '../../domain/enums/pool_mode.dart';
import '../../domain/repositories/token_pool_repository.dart';
import '../datasources/remote/token_pool_remote_datasource.dart';

@LazySingleton(as: TokenPoolRepository)
class TokenPoolRepositoryImpl implements TokenPoolRepository {
  final TokenPoolRemoteDataSource _remoteDataSource;

  TokenPoolRepositoryImpl(this._remoteDataSource);

  // =========================================================================
  // POOL LIFECYCLE
  // =========================================================================

  @override
  Future<Either<Failure, TokenPool>> createPool({
    required PoolMode mode,
    required String title,
    required String message,
    required GiftStyle style,
    String? recipientId,
    required List<String> inviteeIds,
  }) async {
    try {
      final model = await _remoteDataSource.createPool(
        mode: mode.name,
        title: title,
        message: message,
        style: style.name,
        recipientId: recipientId,
        inviteeIds: inviteeIds,
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

  @override
  Future<Either<Failure, TokenPool>> contribute({
    required String poolId,
    required int amount,
    required bool anonymous,
  }) async {
    try {
      final model = await _remoteDataSource.contribute(
        poolId: poolId,
        amount: amount,
        anonymous: anonymous,
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

  @override
  Future<Either<Failure, TokenPool>> sendGroupGift(String poolId) async {
    try {
      final model = await _remoteDataSource.sendGroupGift(poolId);
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
  Future<Either<Failure, TokenPool>> distributePool({
    required String poolId,
    required List<Map<String, dynamic>> payouts,
  }) async {
    try {
      final model = await _remoteDataSource.distributePool(
        poolId: poolId,
        payouts: payouts,
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

  @override
  Future<Either<Failure, TokenPool>> cancelPool(String poolId) async {
    try {
      final model = await _remoteDataSource.cancelPool(poolId);
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
  // RECIPIENT ACTIONS
  // =========================================================================

  @override
  Future<Either<Failure, TokenPool>> openGroupGift(String poolId) async {
    try {
      final model = await _remoteDataSource.openGroupGift(poolId);
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
  Future<Either<Failure, TokenPool>> claimGroupGift(String poolId) async {
    try {
      final model = await _remoteDataSource.claimGroupGift(poolId);
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
  Future<Either<Failure, TokenPool>> getPool(String poolId) async {
    try {
      final model = await _remoteDataSource.getPool(poolId);
      if (model == null) {
        return Left(Failure.serverError(message: 'Pool not found'));
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
  Stream<Either<Failure, TokenPool>> watchPool(String poolId) {
    return _remoteDataSource
        .watchPool(poolId)
        .map<Either<Failure, TokenPool>>(
          (model) => Right(model.toEntity()),
        )
        .transform(
          StreamTransformer<Either<Failure, TokenPool>,
              Either<Failure, TokenPool>>.fromHandlers(
            handleData: (data, sink) => sink.add(data),
            handleError: (error, stackTrace, sink) {
              if (error is AuthException) {
                sink.add(const Left(Failure.unauthenticated()));
              } else {
                sink.add(
                    Left(Failure.serverError(message: error.toString())));
              }
            },
          ),
        );
  }

  @override
  Future<Either<Failure, List<TokenPool>>> getMyPools() async {
    try {
      final models = await _remoteDataSource.getMyPools();
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
