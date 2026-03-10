part of 'buy_tab_bloc.dart';

@freezed
class BuyTabState with _$BuyTabState {
  const factory BuyTabState({
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default([]) List<BuyCategory> categories,
    @Default([]) List<BuyRegular> regulars,
    @Default([]) List<FeaturedItem> featuredItems,
    @Default([]) List<BrandStorefront> brandPartners,
    @Default(0) int marketplaceListingCount,
    @Default(0) int marketplaceSellerCount,
    @Default([]) List<String> trendingThumbnails,
    @Default([]) List<String> userClusters,
    @Default(false) bool isOffline,
    DateTime? lastSyncedAt,
    String? errorMessage,
  }) = _BuyTabState;
}
