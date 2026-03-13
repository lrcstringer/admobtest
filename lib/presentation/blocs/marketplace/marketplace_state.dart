part of 'marketplace_bloc.dart';

@freezed
class MarketplaceState with _$MarketplaceState {
  const factory MarketplaceState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isLoadingDetail,
    @Default(false) bool isLoadingProvider,
    @Default([]) List<MarketplaceListing> listings,
    @Default([]) List<MarketplaceListing> filteredListings,
    @Default(true) bool hasMore,
    MarketplaceListing? selectedListing,
    MarketplaceProvider? selectedProvider,
    /// Vouches for the currently viewed provider profile
    @Default([]) List<Vouch> providerVouches,
    @Default(false) bool isSearching,
    @Default('') String searchQuery,
    /// Current category filter — used for pagination in loadMore
    String? activeCategory,
    /// Current community filter — used for pagination in loadMore
    String? activeCommunityId,
    @Default(false) bool isCreating,
    @Default(false) bool isReporting,
    @Default(false) bool isUpdating,
    @Default(false) bool isTogglingStatus,
    @Default(false) bool isMakingOffer,
    @Default(false) bool isRespondingToOffer,
    @Default(false) bool isRefunding,
    @Default(false) bool isRenewing,
    @Default(false) bool isLoadingMyListings,
    @Default(false) bool isLoadingSaved,
    @Default(false) bool isLoadingSellerPortal,
    @Default([]) List<MarketplaceListing> myListings,
    @Default([]) List<SavedListing> savedItems,
    MarketplaceProvider? currentSellerProfile,
    String? createSuccessId,
    String? errorMessage,
    String? reportSuccessMessage,
    String? successMessage,
    @Default(false) bool isUploadingImages,
    @Default([]) List<String> uploadedImageUrls,
    @Default(false) bool isRegistering,
  }) = _MarketplaceState;
}
