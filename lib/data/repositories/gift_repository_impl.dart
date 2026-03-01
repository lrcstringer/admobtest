import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/gift.dart';
import '../../domain/enums/gift_style.dart';
import '../../domain/repositories/gift_repository.dart';
import '../datasources/remote/gift_remote_datasource.dart';

@LazySingleton(as: GiftRepository)
class GiftRepositoryImpl implements GiftRepository {
  final GiftRemoteDataSource _remoteDataSource;

  GiftRepositoryImpl(this._remoteDataSource);

  // =========================================================================
  // SEND
  // =========================================================================

  @override
  Future<Either<Failure, Gift>> sendGift({
    required String recipientId,
    required int amount,
    required String message,
    required GiftStyle style,
    String? conversationId,
    String? communityId,
  }) async {
    try {
      final model = await _remoteDataSource.sendGift(
        recipientId: recipientId,
        amount: amount,
        message: message,
        style: style.name,
        conversationId: conversationId,
        communityId: communityId,
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
  Future<Either<Failure, Gift>> openGift(String giftId) async {
    try {
      final model = await _remoteDataSource.openGift(giftId);
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
  Future<Either<Failure, Gift>> claimGift(String giftId) async {
    try {
      final model = await _remoteDataSource.claimGift(giftId);
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
  Future<Either<Failure, List<Gift>>> getSentGifts({int? limit}) async {
    try {
      final models = await _remoteDataSource.getSentGifts(limit: limit);
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Gift>>> getReceivedGifts({int? limit}) async {
    try {
      final models = await _remoteDataSource.getReceivedGifts(limit: limit);
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Gift>> getGift(String giftId) async {
    try {
      final model = await _remoteDataSource.getGift(giftId);
      if (model == null) {
        return Left(Failure.serverError(message: 'Gift not found'));
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
  Stream<Either<Failure, Gift>> watchGift(String giftId) {
    return _remoteDataSource.watchGift(giftId).map<Either<Failure, Gift>>(
      (model) => Right(model.toEntity()),
    ).transform(
      StreamTransformer<Either<Failure, Gift>, Either<Failure, Gift>>.fromHandlers(
        handleData: (data, sink) => sink.add(data),
        handleError: (error, stackTrace, sink) {
          if (error is AuthException) {
            sink.add(const Left(Failure.unauthenticated()));
          } else {
            sink.add(Left(Failure.serverError(message: error.toString())));
          }
        },
      ),
    );
  }

  // =========================================================================
  // STATS
  // =========================================================================

  @override
  Future<Either<Failure, GiftStats>> getGiftStats() async {
    try {
      final model = await _remoteDataSource.getGiftStats();
      return Right(model.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
