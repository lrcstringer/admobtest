part of 'brand_storefront_bloc.dart';

@freezed
class BrandStorefrontEvent with _$BrandStorefrontEvent {
  /// Load a single brand storefront by ID
  const factory BrandStorefrontEvent.loadStorefront(String id) =
      _LoadStorefront;

  /// Load products for the current storefront's brand
  const factory BrandStorefrontEvent.loadProducts(String brandId) =
      _LoadProducts;

  /// Load reviews for the current storefront's brand
  const factory BrandStorefrontEvent.loadReviews(String brandId) =
      _LoadReviews;

  /// Submit a review for the brand
  const factory BrandStorefrontEvent.submitReview({
    required String brandId,
    required int qualityRating,
    required int valueRating,
    required int serviceRating,
    String? comment,
  }) = _SubmitReview;
}
