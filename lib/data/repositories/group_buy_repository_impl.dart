import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/group_buy.dart';
import '../../domain/entities/group_buy_contribution.dart';
import '../../domain/repositories/group_buy_repository.dart';
import '../datasources/remote/group_buy_remote_datasource.dart';

@LazySingleton(as: GroupBuyRepository)
class GroupBuyRepositoryImpl implements GroupBuyRepository {
  final GroupBuyRemoteDataSource _remoteDataSource;

  GroupBuyRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<GroupBuy>>> getActiveGroupBuys({
    String? communityId,
  }) async {
    try {
      final models = await _remoteDataSource.getActiveGroupBuys(
        communityId: communityId,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupBuy>> getGroupBuy(String id) async {
    try {
      final model = await _remoteDataSource.getGroupBuy(id);
      if (model == null) {
        return const Left(Failure.serverError(message: 'Group buy not found'));
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupBuyContribution>>> getContributions(
      String groupBuyId) async {
    try {
      final models = await _remoteDataSource.getContributions(groupBuyId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupBuy>>> getMyGroupBuys() async {
    try {
      final models = await _remoteDataSource.getMyGroupBuys();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createGroupBuy({
    required String title,
    required String description,
    required int targetAmount,
    required DateTime deadline,
    String? linkedListingId,
    int minParticipants = 2,
    int? maxParticipants,
  }) async {
    try {
      final id = await _remoteDataSource.createGroupBuy(
        title: title,
        description: description,
        targetAmount: targetAmount,
        deadline: deadline,
        linkedListingId: linkedListingId,
        minParticipants: minParticipants,
        maxParticipants: maxParticipants,
      );
      return Right(id);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinGroupBuy({
    required String groupBuyId,
    required int amount,
    required String walletId,
  }) async {
    try {
      await _remoteDataSource.joinGroupBuy(
        groupBuyId: groupBuyId,
        amount: amount,
        walletId: walletId,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupBuy>>> getHubGroupBuys({
    List<String> userClusters = const [],
  }) async {
    try {
      final models = await _remoteDataSource.getHubGroupBuys(
        userClusters: userClusters,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveGroupBuy({
    required String groupBuyId,
  }) async {
    try {
      await _remoteDataSource.leaveGroupBuy(groupBuyId: groupBuyId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> suggestGroupBuyDeal({
    required String description,
    required String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    bool wantsToJoin = true,
  }) async {
    try {
      final id = await _remoteDataSource.suggestGroupBuyDeal(
        description: description,
        brandOrStore: brandOrStore,
        estimatedPrice: estimatedPrice,
        sourceUrl: sourceUrl,
        imageUrl: imageUrl,
        wantsToJoin: wantsToJoin,
      );
      return Right(id);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
