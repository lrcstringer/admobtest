import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/reward_campaign.dart';
import '../../domain/entities/reward_item.dart';
import '../../domain/repositories/reward_repository.dart';
import '../datasources/remote/reward_remote_datasource.dart';

@LazySingleton(as: RewardRepository)
class RewardRepositoryImpl implements RewardRepository {
  final RewardRemoteDataSource _remoteDataSource;

  RewardRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<RewardItem>>> getUserRewardItems({
    String? status,
  }) async {
    try {
      final items = await _remoteDataSource.getUserRewardItems(status: status);
      return Right(items.map((i) => i.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RewardItem>> getRewardItemDetail(
    String itemId,
  ) async {
    try {
      final item = await _remoteDataSource.getRewardItemDetail(itemId);
      return Right(item.toEntity());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> redeemRewardItem(
    String itemId, {
    String? location,
  }) async {
    try {
      await _remoteDataSource.redeemRewardItem(itemId, location: location);
      return const Right(null);
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RewardCampaign>>> getActiveCampaigns() async {
    try {
      final campaigns = await _remoteDataSource.getActiveCampaigns();
      return Right(campaigns.map((c) => c.toEntity()).toList());
    } on AuthException {
      return const Left(Failure.unauthenticated());
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }
}
