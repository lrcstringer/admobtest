import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/entities/marketplace_provider.dart';
import '../../../domain/entities/saved_listing.dart';
import '../../../domain/enums/provider_status.dart';
import '../../../domain/entities/vouch.dart';
import '../../../domain/repositories/marketplace_repository.dart';
import '../../../domain/repositories/saved_listing_repository.dart';

part 'marketplace_bloc.freezed.dart';
part 'marketplace_event.dart';
part 'marketplace_state.dart';

@injectable
class MarketplaceBloc extends Bloc<MarketplaceEvent, MarketplaceState> {
  final MarketplaceRepository _repository;
  final SavedListingRepository _savedListingRepository;

  MarketplaceBloc(this._repository, this._savedListingRepository)
      : super(const MarketplaceState()) {
    on<_LoadListings>(_onLoadListings);
    on<_LoadMore>(_onLoadMore);
    on<_SearchListings>(_onSearchListings);
    on<_ClearSearch>(_onClearSearch);
    on<_SelectListing>(_onSelectListing);
    on<_LoadProviderProfile>(_onLoadProviderProfile);
    on<_LoadProviderVouches>(_onLoadProviderVouches);
    on<_ReportListing>(_onReportListing);
    on<_ReportProvider>(_onReportProvider);
    on<_CreateListing>(_onCreateListing);
    on<_UpdateListing>(_onUpdateListing);
    on<_ToggleListingStatus>(_onToggleListingStatus);
    on<_RenewListing>(_onRenewListing);
    on<_MakeOffer>(_onMakeOffer);
    on<_RespondToOffer>(_onRespondToOffer);
    on<_SellerRefund>(_onSellerRefund);
    on<_ClearMessages>(_onClearMessages);
    on<_LoadMyListings>(_onLoadMyListings);
    on<_LoadSavedItems>(_onLoadSavedItems);
    on<_LoadSellerPortal>(_onLoadSellerPortal);
    on<_ToggleFavourite>(_onToggleFavourite);
  }

  Future<void> _onLoadListings(
    _LoadListings event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      activeCategory: event.category,
      activeCommunityId: event.communityId,
      listings: [],
      filteredListings: [],
      hasMore: true,
      searchQuery: '',
      isSearching: false,
    ));

    final result = await _repository.getListings(
      category: event.category,
      communityId: event.communityId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (listings) => emit(state.copyWith(
        isLoading: false,
        listings: listings,
        filteredListings: listings,
        hasMore: listings.length >= 20,
      )),
    );
  }

  Future<void> _onLoadMore(
    _LoadMore event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.listings.isEmpty) return;

    emit(state.copyWith(isLoadingMore: true));

    // Use last listing ID as pagination cursor
    final lastListingId = state.listings.last.id;

    final result = await _repository.getListings(
      category: state.activeCategory,
      communityId: state.activeCommunityId,
      limit: 20,
      startAfterId: lastListingId,
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoadingMore: false)),
      (newListings) {
        final allListings = [...state.listings, ...newListings];
        emit(state.copyWith(
          isLoadingMore: false,
          listings: allListings,
          filteredListings: state.isSearching
              ? _filterListings(allListings, state.searchQuery)
              : allListings,
          hasMore: newListings.length >= 20,
        ));
      },
    );
  }

  Future<void> _onSearchListings(
    _SearchListings event,
    Emitter<MarketplaceState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(state.copyWith(
        isSearching: false,
        searchQuery: '',
        filteredListings: state.listings,
      ));
      return;
    }

    emit(state.copyWith(
      isSearching: true,
      searchQuery: query,
      filteredListings: _filterListings(state.listings, query),
    ));
  }

  Future<void> _onClearSearch(
    _ClearSearch event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(state.copyWith(
      isSearching: false,
      searchQuery: '',
      filteredListings: state.listings,
    ));
  }

  Future<void> _onSelectListing(
    _SelectListing event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(state.copyWith(isLoadingDetail: true, selectedListing: null));

    final result = await _repository.getListing(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingDetail: false,
        errorMessage: failure.displayMessage,
      )),
      (listing) => emit(state.copyWith(
        isLoadingDetail: false,
        selectedListing: listing,
      )),
    );
  }

  Future<void> _onLoadProviderProfile(
    _LoadProviderProfile event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(state.copyWith(isLoadingProvider: true, selectedProvider: null));

    final result = await _repository.getProvider(event.providerId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingProvider: false,
        errorMessage: failure.displayMessage,
      )),
      (provider) => emit(state.copyWith(
        isLoadingProvider: false,
        selectedProvider: provider,
      )),
    );
  }

  Future<void> _onLoadProviderVouches(
    _LoadProviderVouches event,
    Emitter<MarketplaceState> emit,
  ) async {
    final result = await _repository.getProviderVouches(event.providerId);

    result.fold(
      (_) {}, // Non-critical — keep existing vouches
      (vouches) => emit(state.copyWith(providerVouches: vouches)),
    );
  }

  Future<void> _onReportListing(
    _ReportListing event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isReporting) return;
    emit(state.copyWith(isReporting: true, errorMessage: null));

    final result = await _repository.reportItem(
      targetId: event.listingId,
      targetType: 'listing',
      reason: event.reason,
      description: event.description,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isReporting: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isReporting: false,
        reportSuccessMessage: 'Report submitted successfully',
      )),
    );
  }

  Future<void> _onReportProvider(
    _ReportProvider event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isReporting) return;
    emit(state.copyWith(isReporting: true, errorMessage: null));

    final result = await _repository.reportItem(
      targetId: event.providerId,
      targetType: 'provider',
      reason: event.reason,
      description: event.description,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isReporting: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isReporting: false,
        reportSuccessMessage: 'Report submitted successfully',
      )),
    );
  }

  Future<void> _onCreateListing(
    _CreateListing event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isCreating) return;

    emit(state.copyWith(
      isCreating: true,
      errorMessage: null,
      createSuccessId: null,
    ));

    final result = await _repository.createListing(
      title: event.title,
      description: event.description,
      category: event.category,
      subCategory: event.subCategory,
      priceTokens: event.priceTokens,
      imageUrls: event.imageUrls,
      location: event.location,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isCreating: false,
        errorMessage: failure.displayMessage,
      )),
      (listingId) => emit(state.copyWith(
        isCreating: false,
        createSuccessId: listingId,
      )),
    );
  }

  Future<void> _onUpdateListing(
    _UpdateListing event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isUpdating) return;
    emit(state.copyWith(isUpdating: true, errorMessage: null));

    final result = await _repository.updateListing(
      listingId: event.listingId,
      title: event.title,
      description: event.description,
      category: event.category,
      priceTokens: event.priceTokens,
      imageUrls: event.imageUrls,
      location: event.location,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isUpdating: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isUpdating: false,
        successMessage: 'Listing updated successfully',
      )),
    );
  }

  Future<void> _onToggleListingStatus(
    _ToggleListingStatus event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isTogglingStatus) return;
    emit(state.copyWith(isTogglingStatus: true, errorMessage: null));

    final result = await _repository.toggleListingStatus(
      listingId: event.listingId,
      action: event.action,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isTogglingStatus: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isTogglingStatus: false,
        successMessage: 'Listing status updated',
      )),
    );
  }

  Future<void> _onRenewListing(
    _RenewListing event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isRenewing) return;
    emit(state.copyWith(isRenewing: true, errorMessage: null));

    final result = await _repository.renewListing(event.listingId);

    result.fold(
      (failure) => emit(state.copyWith(
        isRenewing: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isRenewing: false,
        successMessage: 'Listing renewed successfully',
      )),
    );
  }

  Future<void> _onMakeOffer(
    _MakeOffer event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isMakingOffer) return;
    emit(state.copyWith(isMakingOffer: true, errorMessage: null));

    final result = await _repository.makeOffer(
      listingId: event.listingId,
      offerAmount: event.offerAmount,
      message: event.message,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isMakingOffer: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isMakingOffer: false,
        successMessage: 'Offer submitted',
      )),
    );
  }

  Future<void> _onRespondToOffer(
    _RespondToOffer event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isRespondingToOffer) return;
    emit(state.copyWith(isRespondingToOffer: true, errorMessage: null));

    final result = await _repository.respondToOffer(
      offerId: event.offerId,
      action: event.action,
      counterAmount: event.counterAmount,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isRespondingToOffer: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isRespondingToOffer: false,
        successMessage: 'Offer response sent',
      )),
    );
  }

  Future<void> _onSellerRefund(
    _SellerRefund event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isRefunding) return;
    emit(state.copyWith(isRefunding: true, errorMessage: null));

    final result = await _repository.sellerRefund(
      orderId: event.orderId,
      reason: event.reason,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isRefunding: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isRefunding: false,
        successMessage: 'Refund initiated successfully',
      )),
    );
  }

  Future<void> _onClearMessages(
    _ClearMessages event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(state.copyWith(
      errorMessage: null,
      reportSuccessMessage: null,
      createSuccessId: null,
      successMessage: null,
    ));
  }

  Future<void> _onLoadMyListings(
    _LoadMyListings event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isLoadingMyListings) return;
    emit(state.copyWith(isLoadingMyListings: true, errorMessage: null));

    // Use current seller profile's provider ID if available
    final providerId = state.currentSellerProfile?.id;
    if (providerId == null) {
      emit(state.copyWith(
        isLoadingMyListings: false,
        myListings: [],
      ));
      return;
    }

    final result = await _repository.getProviderListings(providerId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingMyListings: false,
        errorMessage: failure.displayMessage,
      )),
      (listings) => emit(state.copyWith(
        isLoadingMyListings: false,
        myListings: listings,
      )),
    );
  }

  Future<void> _onLoadSavedItems(
    _LoadSavedItems event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isLoadingSaved) return;
    emit(state.copyWith(isLoadingSaved: true, errorMessage: null));

    final result = await _savedListingRepository.getAll();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingSaved: false,
        errorMessage: failure.displayMessage,
      )),
      (items) => emit(state.copyWith(
        isLoadingSaved: false,
        savedItems: items,
      )),
    );
  }

  Future<void> _onLoadSellerPortal(
    _LoadSellerPortal event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isLoadingSellerPortal) return;
    emit(state.copyWith(isLoadingSellerPortal: true, errorMessage: null));

    final result = await _repository.getSellerDashboard();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingSellerPortal: false,
        errorMessage: failure.displayMessage,
      )),
      (dashboard) {
        // Extract provider profile from dashboard if present
        final providerData = dashboard['provider'];
        MarketplaceProvider? sellerProfile;
        if (providerData is Map<String, dynamic>) {
          sellerProfile = MarketplaceProvider(
            id: providerData['id'] as String? ?? '',
            userId: providerData['userId'] as String? ?? '',
            displayName: providerData['displayName'] as String? ?? '',
            bio: providerData['bio'] as String?,
            photoUrl: providerData['photoUrl'] as String?,
            status: ProviderStatus.active,
            trustScore: (providerData['trustScore'] as num?)?.toDouble() ?? 0,
            isVerified: providerData['isVerified'] as bool? ?? false,
            vouchCount: providerData['vouchCount'] as int? ?? 0,
            completedOrders: providerData['completedOrders'] as int? ?? 0,
            createdAt: DateTime.tryParse(
                    providerData['createdAt'] as String? ?? '') ??
                DateTime.now(),
          );
        }

        emit(state.copyWith(
          isLoadingSellerPortal: false,
          currentSellerProfile: sellerProfile ?? state.currentSellerProfile,
        ));
      },
    );
  }

  Future<void> _onToggleFavourite(
    _ToggleFavourite event,
    Emitter<MarketplaceState> emit,
  ) async {
    final isSaved =
        state.savedItems.any((item) => item.listingId == event.listingId);

    late final Either<Failure, void> toggleResult;
    if (isSaved) {
      toggleResult = await _savedListingRepository.remove(event.listingId);
    } else {
      toggleResult = await _savedListingRepository.save(SavedListing(
        listingId: event.listingId,
        savedAt: DateTime.now(),
      ));
    }

    // Handle result synchronously — no async in fold callback
    final failure = toggleResult.fold<Failure?>(
      (failure) => failure,
      (_) => null,
    );

    if (failure != null) {
      emit(state.copyWith(errorMessage: failure.displayMessage));
      return;
    }

    // Refresh the full list from the source of truth
    final refreshResult = await _savedListingRepository.getAll();
    refreshResult.fold(
      (_) {}, // Non-critical — keep existing list
      (items) => emit(state.copyWith(savedItems: items)),
    );
  }

  /// Client-side search filter on title + description
  List<MarketplaceListing> _filterListings(
    List<MarketplaceListing> listings,
    String query,
  ) {
    final lowerQuery = query.toLowerCase();
    return listings.where((listing) {
      return listing.title.toLowerCase().contains(lowerQuery) ||
          listing.description.toLowerCase().contains(lowerQuery) ||
          listing.providerName.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
