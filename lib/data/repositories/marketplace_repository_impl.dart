import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/buy_order.dart';
import '../../domain/entities/marketplace_listing.dart';
import '../../domain/entities/marketplace_provider.dart';
import '../../domain/entities/vouch.dart';
import '../../domain/repositories/marketplace_repository.dart';
import '../datasources/remote/marketplace_remote_datasource.dart';

@LazySingleton(as: MarketplaceRepository)
class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final MarketplaceRemoteDataSource _remoteDataSource;

  MarketplaceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<MarketplaceListing>>> getListings({
    String? category,
    String? communityId,
    int limit = 20,
    String? startAfterId,
  }) async {
    try {
      final models = await _remoteDataSource.getListings(
        category: category,
        communityId: communityId,
        limit: limit,
        startAfterId: startAfterId,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MarketplaceListing>> getListing(String id) async {
    try {
      final model = await _remoteDataSource.getListing(id);
      if (model == null) {
        return const Left(ServerFailure(message: 'Listing not found'));
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MarketplaceProvider>> getProvider(String id) async {
    try {
      final model = await _remoteDataSource.getProvider(id);
      if (model == null) {
        return const Left(ServerFailure(message: 'Provider not found'));
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MarketplaceListing>>> getProviderListings(
      String providerId) async {
    try {
      final models = await _remoteDataSource.getProviderListings(providerId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Vouch>>> getProviderVouches(
      String providerId) async {
    try {
      final models = await _remoteDataSource.getProviderVouches(providerId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BuyOrder>>> getBuyerOrders() async {
    try {
      final models = await _remoteDataSource.getBuyerOrders();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BuyOrder>>> getSellerOrders() async {
    try {
      final models = await _remoteDataSource.getSellerOrders();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BuyOrder>> getOrder(String id) async {
    try {
      final model = await _remoteDataSource.getOrder(id);
      if (model == null) {
        return const Left(ServerFailure(message: 'Order not found'));
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> registerProvider({
    required String displayName,
    String? bio,
    String? photoUrl,
    String? servicesDescription,
    String? communityId,
  }) async {
    try {
      final providerId = await _remoteDataSource.registerProvider(
        displayName: displayName,
        bio: bio,
        photoUrl: photoUrl,
        servicesDescription: servicesDescription,
        communityId: communityId,
      );
      return Right(providerId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createListing({
    required String title,
    required String description,
    required String category,
    String? subCategory,
    required int priceTokens,
    required List<String> imageUrls,
    String? location,
  }) async {
    try {
      final listingId = await _remoteDataSource.createListing(
        title: title,
        description: description,
        category: category,
        subCategory: subCategory,
        priceTokens: priceTokens,
        imageUrls: imageUrls,
        location: location,
      );
      return Right(listingId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> buyItem({
    required String listingId,
    required String walletId,
  }) async {
    try {
      final orderId = await _remoteDataSource.buyItem(
        listingId: listingId,
        walletId: walletId,
      );
      return Right(orderId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmFulfilment(String orderId) async {
    try {
      await _remoteDataSource.confirmFulfilment(orderId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmReceipt(String orderId) async {
    try {
      await _remoteDataSource.confirmReceipt(orderId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    try {
      await _remoteDataSource.cancelOrder(orderId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> disputeOrder(
      String orderId, String reason) async {
    try {
      await _remoteDataSource.disputeOrder(orderId, reason);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> vouchForProvider({
    required String providerId,
    required int rating,
    String? comment,
    String? orderId,
  }) async {
    try {
      await _remoteDataSource.vouchForProvider(
        providerId: providerId,
        rating: rating,
        comment: comment,
        orderId: orderId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reportItem({
    required String targetId,
    required String targetType,
    required String reason,
    String? description,
  }) async {
    try {
      await _remoteDataSource.reportItem(
        targetId: targetId,
        targetType: targetType,
        reason: reason,
        description: description,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
