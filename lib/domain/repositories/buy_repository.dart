import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/brand_product.dart';
import '../entities/brand_review.dart';
import '../entities/brand_storefront.dart';
import '../entities/buy_category.dart';
import '../entities/buy_regular.dart';
import '../entities/featured_item.dart';

abstract class BuyRepository {
  /// Get buy categories (remote, syncs to local cache)
  Future<Either<Failure, List<BuyCategory>>> getBuyCategories();

  /// Get cached buy categories from local DB
  Future<Either<Failure, List<BuyCategory>>> getCachedCategories();

  /// Get user's buy regulars (remote, syncs to local cache)
  Future<Either<Failure, List<BuyRegular>>> getBuyRegulars();

  /// Get cached buy regulars from local DB
  Future<Either<Failure, List<BuyRegular>>> getCachedRegulars();

  /// Get featured items (remote, syncs to local cache)
  Future<Either<Failure, List<FeaturedItem>>> getFeaturedItems();

  /// Get cached featured items from local DB
  Future<Either<Failure, List<FeaturedItem>>> getCachedFeaturedItems();

  /// Get active brand storefronts
  Future<Either<Failure, List<BrandStorefront>>> getBrandStorefronts();

  /// Get a single brand storefront by ID
  Future<Either<Failure, BrandStorefront>> getBrandStorefront(String id);

  /// Get products for a brand storefront
  Future<Either<Failure, List<BrandProduct>>> getBrandProducts(String brandId);

  /// Get reviews for a brand
  Future<Either<Failure, List<BrandReview>>> getBrandReviews(String brandId);

  /// Submit a review for a brand (delegates to Cloud Function)
  Future<Either<Failure, void>> submitBrandReview({
    required String brandId,
    required int qualityRating,
    required int valueRating,
    required int serviceRating,
    String? comment,
  });

  /// Get marketplace stats for the entry card
  Future<Either<Failure, ({int listingCount, int sellerCount, List<String> thumbnails})>>
      getMarketplaceStats();
}
