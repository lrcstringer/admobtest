import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/buy_order.dart';
import '../entities/marketplace_listing.dart';
import '../entities/marketplace_provider.dart';
import '../entities/vouch.dart';

abstract class MarketplaceRepository {
  /// Get marketplace listings (paginated)
  Future<Either<Failure, List<MarketplaceListing>>> getListings({
    String? category,
    String? communityId,
    int limit = 20,
    String? startAfterId,
  });

  /// Get a single listing by ID
  Future<Either<Failure, MarketplaceListing>> getListing(String id);

  /// Get a marketplace provider profile
  Future<Either<Failure, MarketplaceProvider>> getProvider(String id);

  /// Get provider's listings
  Future<Either<Failure, List<MarketplaceListing>>> getProviderListings(
      String providerId);

  /// Get vouches for a provider
  Future<Either<Failure, List<Vouch>>> getProviderVouches(String providerId);

  /// Get user's orders as buyer
  Future<Either<Failure, List<BuyOrder>>> getBuyerOrders();

  /// Get user's orders as seller
  Future<Either<Failure, List<BuyOrder>>> getSellerOrders();

  /// Get a single order by ID
  Future<Either<Failure, BuyOrder>> getOrder(String id);

  /// Register as a marketplace provider
  Future<Either<Failure, String>> registerProvider({
    required String displayName,
    String? bio,
    String? photoUrl,
    String? servicesDescription,
    String? communityId,
  });

  /// Create a marketplace listing
  Future<Either<Failure, String>> createListing({
    required String title,
    required String description,
    required String category,
    String? subCategory,
    required int priceTokens,
    required List<String> imageUrls,
    String? location,
  });

  /// Buy a marketplace item (creates escrow)
  Future<Either<Failure, String>> buyItem({
    required String listingId,
    required String walletId,
  });

  /// Seller confirms fulfilment
  Future<Either<Failure, void>> confirmFulfilment(String orderId);

  /// Buyer confirms receipt (releases escrow)
  Future<Either<Failure, void>> confirmReceipt(String orderId);

  /// Cancel an order
  Future<Either<Failure, void>> cancelOrder(String orderId);

  /// Dispute an order
  Future<Either<Failure, void>> disputeOrder(String orderId, String reason);

  /// Vouch for a provider
  Future<Either<Failure, void>> vouchForProvider({
    required String providerId,
    required int rating,
    String? comment,
    String? orderId,
  });

  /// Report a listing or provider
  Future<Either<Failure, void>> reportItem({
    required String targetId,
    required String targetType,
    required String reason,
    String? description,
  });

  /// Upload listing images and return their download URLs
  Future<Either<Failure, List<String>>> uploadListingImages({
    required List<File> imageFiles,
    required String listingId,
  });
}
