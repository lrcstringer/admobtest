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
    String? deliveryMethod,
    int? deliveryFee,
    String? serviceAreaType,
    Map<String, dynamic>? locationData,
  }) = _CreateListing;

  /// Clear success/error messages
  const factory MarketplaceEvent.clearMessages() = _ClearMessages;

  /// Update an existing listing
  const factory MarketplaceEvent.updateListing({
    required String listingId,
    String? title,
    String? description,
    String? category,
    int? priceTokens,
    List<String>? imageUrls,
    String? location,
    String? deliveryMethod,
    int? deliveryFee,
    String? serviceAreaType,
    Map<String, dynamic>? locationData,
  }) = _UpdateListing;

  /// Toggle listing status (pause/unpause/markSold)
  const factory MarketplaceEvent.toggleListingStatus({
    required String listingId,
    required String action,
  }) = _ToggleListingStatus;

  /// Renew an expired listing
  const factory MarketplaceEvent.renewListing(String listingId) =
      _RenewListing;

  /// Make an offer on a listing
  const factory MarketplaceEvent.makeOffer({
    required String listingId,
    required int offerAmount,
    String? message,
  }) = _MakeOffer;

  /// Respond to an offer (accept/decline/counter)
  const factory MarketplaceEvent.respondToOffer({
    required String offerId,
    required String action,
    int? counterAmount,
  }) = _RespondToOffer;

  /// Seller-initiated refund
  const factory MarketplaceEvent.sellerRefund({
    required String orderId,
    String? reason,
  }) = _SellerRefund;

  /// Load current user's listings
  const factory MarketplaceEvent.loadMyListings() = _LoadMyListings;

  /// Load saved/favourite items
  const factory MarketplaceEvent.loadSavedItems() = _LoadSavedItems;

  /// Load seller portal profile
  const factory MarketplaceEvent.loadSellerPortal() = _LoadSellerPortal;

  /// Toggle favourite/save on a listing
  const factory MarketplaceEvent.toggleFavourite(String listingId) =
      _ToggleFavourite;

  /// Upload listing images and return URLs
  const factory MarketplaceEvent.uploadImages({
    required List<Uint8List> imageData,
    required String listingId,
  }) = _UploadImages;

  /// Register as a marketplace provider
  const factory MarketplaceEvent.registerProvider({
    required String displayName,
    String? bio,
    String? photoUrl,
    String? servicesDescription,
    String? communityId,
    String? category,
  }) = _RegisterProvider;
}
