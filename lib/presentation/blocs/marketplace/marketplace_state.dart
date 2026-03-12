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
    @Default([]) List<Vouch> providerVouches,
    @Default(false) bool isSearching,
    @Default('') String searchQuery,
    String? activeCategory,
    String? activeCommunityId,
    @Default(false) bool isCreating,
    @Default(false) bool isReporting,
    @Default(false) bool isUpdating,
    @Default(false) bool isTogglingStatus,
    @Default(false) bool isMakingOffer,
    @Default(false) bool isRespondingToOffer,
    @Default(false) bool isRefunding,
    String? createSuccessId,
    String? errorMessage,
    String? reportSuccessMessage,
    String? successMessage,
  }) = _MarketplaceState;
}
