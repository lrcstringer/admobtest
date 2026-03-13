import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/buy_order.dart';
import '../../domain/entities/marketplace_listing.dart';
import '../../domain/entities/marketplace_offer.dart';
import '../../domain/entities/marketplace_provider.dart';
import '../../domain/entities/seller_dashboard.dart';
import '../../domain/entities/vouch.dart';
import '../../domain/repositories/marketplace_repository.dart';
import '../datasources/remote/marketplace_remote_datasource.dart';
import '../datasources/remote/media_upload_datasource.dart';

@LazySingleton(as: MarketplaceRepository)
class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final MarketplaceRemoteDataSource _remoteDataSource;
  final MediaUploadDatasource _mediaUploadDatasource;

  MarketplaceRepositoryImpl(this._remoteDataSource, this._mediaUploadDatasource);

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
    String? category,
  }) async {
    try {
      final providerId = await _remoteDataSource.registerProvider(
        displayName: displayName,
        bio: bio,
        photoUrl: photoUrl,
        servicesDescription: servicesDescription,
        communityId: communityId,
        category: category,
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
    String? deliveryMethod,
    int? deliveryFee,
    String? serviceAreaType,
    Map<String, dynamic>? locationData,
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
        deliveryMethod: deliveryMethod,
        deliveryFee: deliveryFee,
        serviceAreaType: serviceAreaType,
        locationData: locationData,
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

  @override
  Future<Either<Failure, List<String>>> uploadListingImages({
    required List<Uint8List> imageData,
    required String listingId,
  }) async {
    try {
      final futures = imageData.asMap().entries.map(
            (entry) => _mediaUploadDatasource.uploadListingImageBytes(
              imageBytes: entry.value,
              listingId: listingId,
              index: entry.key,
            ),
          );
      // eagerError: false — let all uploads finish even if one fails,
      // so user doesn't lose all images on a single failure
      final results = await Future.wait(
        futures.map((f) => f.then<String?>((url) => url).catchError((_) => null)),
      );
      final urls = results.whereType<String>().toList();
      if (urls.isEmpty) {
        return const Left(ServerFailure(message: 'All image uploads failed'));
      }
      return Right(urls);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateListing({
    required String listingId,
    String? title,
    String? description,
    String? category,
    int? priceTokens,
    List<String>? imageUrls,
    String? location,
    String? deliveryMethod,
    int? deliveryFee,
    String? serviceAreaType,
    Map<String, dynamic>? locationData,
  }) async {
    try {
      await _remoteDataSource.updateListing(
        listingId: listingId,
        title: title,
        description: description,
        category: category,
        priceTokens: priceTokens,
        imageUrls: imageUrls,
        location: location,
        deliveryMethod: deliveryMethod,
        deliveryFee: deliveryFee,
        serviceAreaType: serviceAreaType,
        locationData: locationData,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleListingStatus({
    required String listingId,
    required String action,
  }) async {
    try {
      await _remoteDataSource.toggleListingStatus(
        listingId: listingId,
        action: action,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> renewListing(String listingId) async {
    try {
      await _remoteDataSource.renewListing(listingId: listingId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MarketplaceOffer>> getOffer(String offerId) async {
    try {
      final model = await _remoteDataSource.getOffer(offerId);
      if (model == null) {
        return const Left(ServerFailure(message: 'Offer not found'));
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> makeOffer({
    required String listingId,
    required int offerAmount,
    String? message,
  }) async {
    try {
      final offerId = await _remoteDataSource.makeOffer(
        listingId: listingId,
        offerAmount: offerAmount,
        message: message,
      );
      return Right(offerId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> respondToOffer({
    required String offerId,
    required String action,
    int? counterAmount,
  }) async {
    try {
      final orderId = await _remoteDataSource.respondToOffer(
        offerId: offerId,
        action: action,
        counterAmount: counterAmount,
      );
      return Right(orderId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sellerRefund({
    required String orderId,
    String? reason,
  }) async {
    try {
      await _remoteDataSource.sellerRefund(
        orderId: orderId,
        reason: reason,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> respondToDispute({
    required String orderId,
    required String response,
    List<String>? photoUrls,
    String? proposedResolution,
    int? proposedResolutionAmount,
  }) async {
    try {
      await _remoteDataSource.respondToDispute(
        orderId: orderId,
        response: response,
        photoUrls: photoUrls,
        proposedResolution: proposedResolution,
        proposedResolutionAmount: proposedResolutionAmount,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addDisputeEvidence({
    required String orderId,
    required List<String> photoUrls,
    String? additionalDetails,
  }) async {
    try {
      await _remoteDataSource.addDisputeEvidence(
        orderId: orderId,
        photoUrls: photoUrls,
        additionalDetails: additionalDetails,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> proposeResolution({
    required String orderId,
    required String resolutionType,
    int? refundAmount,
  }) async {
    try {
      await _remoteDataSource.proposeResolution(
        orderId: orderId,
        resolutionType: resolutionType,
        refundAmount: refundAmount,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SellerDashboard>> getSellerDashboard() async {
    try {
      final dashboardMap = await _remoteDataSource.getSellerDashboard();
      return Right(SellerDashboard.fromMap(dashboardMap));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<
    Either<
      Failure,
      ({int listingCount, int sellerCount, List<String> thumbnails})
    >
  >
  getMarketplaceStats() async {
    try {
      final stats = await _remoteDataSource.getMarketplaceStats();
      return Right(stats);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
