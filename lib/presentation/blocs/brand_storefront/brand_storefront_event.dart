part of 'brand_storefront_bloc.dart';

@freezed
class BrandStorefrontEvent with _$BrandStorefrontEvent {
  /// Load a single brand storefront by ID.
  /// [orderId] — optional completed-order ID passed from navigation (e.g. "My
  /// Orders") to enable the review submission flow.
  const factory BrandStorefrontEvent.loadStorefront(
    String id, {
    String? orderId,
  }) = _LoadStorefront;

  /// Load products for the current storefront's brand
  const factory BrandStorefrontEvent.loadProducts(String brandId) =
      _LoadProducts;

  /// Load reviews for the current storefront's brand
  const factory BrandStorefrontEvent.loadReviews(String brandId) =
      _LoadReviews;

  /// Submit a review for the brand
  const factory BrandStorefrontEvent.submitReview({
    required String brandId,
    required String orderId,
    required int qualityRating,
    required int valueRating,
    required int serviceRating,
    String? comment,
  }) = _SubmitReview;

  /// Claim a coupon from the storefront
  const factory BrandStorefrontEvent.claimCoupon({
    required String storefrontId,
    required String couponId,
    String? couponCode,
  }) = _ClaimCoupon;

  /// Record a storefront view (fire-and-forget)
  const factory BrandStorefrontEvent.recordView(String storefrontId) =
      _RecordView;

  /// Toggle follow/unfollow for this brand
  const factory BrandStorefrontEvent.toggleFollow(String brandId) =
      _ToggleFollow;

  /// Reset review submission state (clears reviewSubmitSuccess)
  const factory BrandStorefrontEvent.resetReviewState() = _ResetReviewState;
}
