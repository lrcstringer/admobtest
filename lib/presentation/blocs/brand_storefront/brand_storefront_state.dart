part of 'brand_storefront_bloc.dart';

@freezed
abstract class BrandStorefrontState with _$BrandStorefrontState {
  const factory BrandStorefrontState({
    @Default(false) bool isLoading,
    BrandStorefront? storefront,
    @Default([]) List<BrandProduct> products,
    @Default([]) List<BrandReview> reviews,
    @Default(false) bool isLoadingProducts,
    @Default(false) bool isLoadingReviews,
    @Default(false) bool isSubmittingReview,
    @Default(false) bool reviewSubmitSuccess,
    @Default(false) bool isClaimingCoupon,
    @Default({}) Set<String> claimedCouponIds,
    String? lastClaimedCouponCode,
    @Default(false) bool isFollowing,
    DateTime? followedAt,
    @Default(false) bool isTogglingFollow,
    String? errorMessage,
    String? eligibleReviewOrderId,
  }) = _BrandStorefrontState;
}
