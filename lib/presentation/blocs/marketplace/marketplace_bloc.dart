import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/entities/marketplace_provider.dart';
import '../../../domain/entities/saved_listing.dart';
import '../../../domain/entities/seller_dashboard.dart';
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
    on<_UploadImages>(_onUploadImages);
    on<_RegisterProvider>(_onRegisterProvider);
    on<_UpdateSellerProfile>(_onUpdateSellerProfile);
    on<_DeregisterSeller>(_onDeregisterSeller);
    on<_CancelDeregistration>(_onCancelDeregistration);
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
      deliveryMethod: event.deliveryMethod,
      deliveryFee: event.deliveryFee,
      serviceAreaType: event.serviceAreaType,
      locationData: event.locationData,
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
      deliveryMethod: event.deliveryMethod,
      deliveryFee: event.deliveryFee,
      serviceAreaType: event.serviceAreaType,
      locationData: event.locationData,
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

    // Load seller profile and dashboard in parallel
    final results = await Future.wait([
      _repository.getCurrentSellerProfile(),
      _repository.getSellerDashboard(),
    ]);

    final profileResult =
        results[0] as Either<Failure, MarketplaceProvider?>;
    final dashboardResult =
        results[1] as Either<Failure, SellerDashboard>;

    final profile = profileResult.fold((_) => null, (p) => p);
    final dashboard = dashboardResult.fold((_) => null, (d) => d);

    emit(state.copyWith(
      isLoadingSellerPortal: false,
      currentSellerProfile: profile,
      sellerDashboard: dashboard,
    ));
  }

  Future<void> _onToggleFavourite(
    _ToggleFavourite event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isTogglingFavourite) return;

    // Snapshot for revert on failure
    final previousItems = List<SavedListing>.from(state.savedItems);
    final isSaved =
        previousItems.any((item) => item.listingId == event.listingId);

    // Optimistic update — toggle immediately in UI
    if (isSaved) {
      emit(state.copyWith(
        savedItems: previousItems
            .where((item) => item.listingId != event.listingId)
            .toList(),
      ));
    } else {
      emit(state.copyWith(
        savedItems: [
          ...previousItems,
          SavedListing(
            listingId: event.listingId,
            savedAt: DateTime.now(),
          ),
        ],
      ));
    }

    // Perform the actual server call
    late final Either<Failure, void> toggleResult;
    if (isSaved) {
      toggleResult = await _savedListingRepository.remove(event.listingId);
    } else {
      toggleResult = await _savedListingRepository.save(SavedListing(
        listingId: event.listingId,
        savedAt: DateTime.now(),
      ));
    }

    // Handle result — revert on failure, refresh on success
    final failure = toggleResult.fold<Failure?>(
      (failure) => failure,
      (_) => null,
    );

    if (failure != null) {
      // Revert to previous state on failure
      emit(state.copyWith(
        savedItems: previousItems,
        errorMessage: failure.displayMessage,
      ));
      return;
    }

    // Refresh from source of truth for consistency
    final refreshResult = await _savedListingRepository.getAll();
    refreshResult.fold(
      (_) {}, // Non-critical — keep optimistic state
      (items) => emit(state.copyWith(savedItems: items)),
    );
  }

  Future<void> _onUploadImages(
    _UploadImages event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isUploadingImages) return;
    emit(state.copyWith(
      isUploadingImages: true,
      uploadedImageUrls: [],
      errorMessage: null,
    ));

    final result = await _repository.uploadListingImages(
      imageData: event.imageData,
      listingId: event.listingId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isUploadingImages: false,
        errorMessage: failure.displayMessage,
      )),
      (urls) => emit(state.copyWith(
        isUploadingImages: false,
        uploadedImageUrls: urls,
      )),
    );
  }

  Future<void> _onRegisterProvider(
    _RegisterProvider event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isRegistering) return;
    emit(state.copyWith(
      isRegistering: true,
      registrationSuccess: false,
      errorMessage: null,
    ));

    final result = await _repository.registerProvider(
      displayName: event.displayName,
      photoUrl: event.photoUrl,
      contactPreferences: event.contactPreferences,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isRegistering: false,
        errorMessage: failure.displayMessage,
      )),
      (providerId) {
        // Reload seller portal to populate currentSellerProfile
        add(const MarketplaceEvent.loadSellerPortal());
        emit(state.copyWith(
          isRegistering: false,
          registrationSuccess: true,
          successMessage: 'You are now a seller!',
        ));
      },
    );
  }

  Future<void> _onUpdateSellerProfile(
    _UpdateSellerProfile event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(state.copyWith(isUpdatingProfile: true, errorMessage: null));

    final result = await _repository.updateSellerProfile(
      bio: event.bio,
      photoUrl: event.photoUrl,
      contactPreferences: event.contactPreferences,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isUpdatingProfile: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        add(const MarketplaceEvent.loadSellerPortal());
        emit(state.copyWith(
          isUpdatingProfile: false,
          successMessage: 'Profile updated',
        ));
      },
    );
  }

  Future<void> _onDeregisterSeller(
    _DeregisterSeller event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isDeregistering) return;
    emit(state.copyWith(isDeregistering: true, errorMessage: null));

    final result = await _repository.deregisterProvider();

    result.fold(
      (failure) => emit(state.copyWith(
        isDeregistering: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        add(const MarketplaceEvent.loadSellerPortal());
        emit(state.copyWith(
          isDeregistering: false,
          successMessage: 'De-registration requested. You have 7 days to change your mind.',
        ));
      },
    );
  }

  Future<void> _onCancelDeregistration(
    _CancelDeregistration event,
    Emitter<MarketplaceState> emit,
  ) async {
    if (state.isDeregistering) return;
    emit(state.copyWith(isDeregistering: true, errorMessage: null));

    final result = await _repository.cancelDeregistration();

    result.fold(
      (failure) => emit(state.copyWith(
        isDeregistering: false,
        errorMessage: failure.displayMessage,
      )),
      (_) {
        add(const MarketplaceEvent.loadSellerPortal());
        emit(state.copyWith(
          isDeregistering: false,
          successMessage: 'De-registration cancelled. Your seller account is active again.',
        ));
      },
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
