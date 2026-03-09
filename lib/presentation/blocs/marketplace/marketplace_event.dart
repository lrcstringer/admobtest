part of 'marketplace_bloc.dart';

@freezed
class MarketplaceEvent with _$MarketplaceEvent {
  /// Load listings for a category
  const factory MarketplaceEvent.loadListings({
    String? category,
    String? communityId,
  }) = _LoadListings;

  /// Load more listings (pagination)
  const factory MarketplaceEvent.loadMore() = _LoadMore;

  /// Search listings by query (client-side filter)
  const factory MarketplaceEvent.searchListings(String query) = _SearchListings;

  /// Clear search
  const factory MarketplaceEvent.clearSearch() = _ClearSearch;

  /// Select a listing for detail view
  const factory MarketplaceEvent.selectListing(String id) = _SelectListing;

  /// Load provider profile
  const factory MarketplaceEvent.loadProviderProfile(String providerId) =
      _LoadProviderProfile;

  /// Load provider's vouches
  const factory MarketplaceEvent.loadProviderVouches(String providerId) =
      _LoadProviderVouches;

  /// Report a listing
  const factory MarketplaceEvent.reportListing({
    required String listingId,
    required String reason,
    String? description,
  }) = _ReportListing;

  /// Report a provider
  const factory MarketplaceEvent.reportProvider({
    required String providerId,
    required String reason,
    String? description,
  }) = _ReportProvider;

  /// Create a new marketplace listing
  const factory MarketplaceEvent.createListing({
    required String title,
    required String description,
    required String category,
    String? subCategory,
    required int priceTokens,
    required List<String> imageUrls,
    String? location,
  }) = _CreateListing;

  /// Clear success/error messages
  const factory MarketplaceEvent.clearMessages() = _ClearMessages;
}
