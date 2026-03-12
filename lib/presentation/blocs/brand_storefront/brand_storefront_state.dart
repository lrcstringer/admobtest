part of 'brand_storefront_bloc.dart';

@freezed
class BrandStorefrontState with _$BrandStorefrontState {
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
    @Default(false) bool isFollowing,
    @Default([]) List<String> mutualFollowers,
    @Default(0) int mutualFollowerCount,
    String? errorMessage,
  }) = _BrandStorefrontState;
}
