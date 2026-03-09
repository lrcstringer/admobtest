import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/entities/marketplace_provider.dart';
import '../../../domain/entities/vouch.dart';
import '../../../domain/repositories/marketplace_repository.dart';

part 'marketplace_bloc.freezed.dart';
part 'marketplace_event.dart';
part 'marketplace_state.dart';

@injectable
class MarketplaceBloc extends Bloc<MarketplaceEvent, MarketplaceState> {
  final MarketplaceRepository _repository;

  MarketplaceBloc(this._repository) : super(const MarketplaceState()) {
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
    on<_ClearMessages>(_onClearMessages);
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

  Future<void> _onClearMessages(
    _ClearMessages event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(state.copyWith(
      errorMessage: null,
      reportSuccessMessage: null,
      createSuccessId: null,
    ));
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
