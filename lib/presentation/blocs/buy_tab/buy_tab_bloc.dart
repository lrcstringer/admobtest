import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities/brand_storefront.dart';
import '../../../domain/entities/buy_category.dart';
import '../../../domain/entities/buy_regular.dart';
import '../../../domain/entities/featured_item.dart';
import '../../../domain/entities/vas_category.dart';
import '../../../domain/repositories/buy_repository.dart';
import '../../../domain/repositories/marketplace_repository.dart';

part 'buy_tab_event.dart';
part 'buy_tab_state.dart';
part 'buy_tab_bloc.freezed.dart';

@injectable
class BuyTabBloc extends Bloc<BuyTabEvent, BuyTabState> {
  final BuyRepository _buyRepository;
  final MarketplaceRepository _marketplaceRepository;
  final NetworkInfo _networkInfo;

  BuyTabBloc(this._buyRepository, this._marketplaceRepository, this._networkInfo)
      : super(const BuyTabState()) {
    on<_LoadBuyTab>(_onLoadBuyTab);
    on<_RefreshBuyTab>(_onRefreshBuyTab);
    on<_ToggleRegularPin>(_onToggleRegularPin);
    on<_DeleteRegular>(_onDeleteRegular);
  }

  Future<void> _onLoadBuyTab(
    _LoadBuyTab event,
    Emitter<BuyTabState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final isConnected = await _networkInfo.isConnected;

    // Load from local DB first (offline-first) — typed awaits to avoid dynamic casts
    final cachedCategoriesResult = await _buyRepository.getCachedCategories();
    final cachedRegularsResult = await _buyRepository.getCachedRegulars();
    final cachedFeaturedResult = await _buyRepository.getCachedFeaturedItems();

    cachedCategoriesResult.fold((_) {}, (cached) {
      if (cached.isNotEmpty) {
        emit(state.copyWith(categories: cached));
      }
    });
    cachedRegularsResult.fold((_) {}, (cached) {
      if (cached.isNotEmpty) {
        emit(state.copyWith(regulars: cached));
      }
    });
    cachedFeaturedResult.fold((_) {}, (cached) {
      if (cached.isNotEmpty) {
        emit(state.copyWith(featuredItems: cached));
      }
    });

    if (!isConnected) {
      emit(state.copyWith(
        isLoading: false,
        isOffline: true,
        lastSyncedAt: state.lastSyncedAt,
      ));
      return;
    }

    // Keep loading indicator while fetching fresh data
    emit(state.copyWith(isLoading: true, isOffline: false));

    // Fetch all remote data in parallel — typed futures to avoid dynamic casts
    final categoriesFuture = _buyRepository.getBuyCategories();
    final vasCategoriesFuture = _buyRepository.getVasCategories();
    final regularsFuture = _buyRepository.getBuyRegulars();
    final featuredFuture = _buyRepository.getFeaturedItems();
    final brandsFuture = _buyRepository.getBrandStorefronts();
    final statsFuture = _marketplaceRepository.getMarketplaceStats();

    final categoriesResult = await categoriesFuture;
    final vasCategoriesResult = await vasCategoriesFuture;
    final regularsResult = await regularsFuture;
    final featuredResult = await featuredFuture;
    final brandsResult = await brandsFuture;
    final statsResult = await statsFuture;

    final now = DateTime.now();
    var newState = state.copyWith(isLoading: false, lastSyncedAt: now);

    categoriesResult.fold(
      (failure) => newState = newState.copyWith(
        categories: [],
        errorMessage: failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(categories: data),
    );
    vasCategoriesResult.fold(
      (failure) => newState = newState.copyWith(
        vasCategories: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(vasCategories: data),
    );
    regularsResult.fold(
      (failure) => newState = newState.copyWith(
        regulars: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(regulars: data),
    );
    featuredResult.fold(
      (failure) => newState = newState.copyWith(
        featuredItems: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(featuredItems: data),
    );
    brandsResult.fold(
      (failure) => newState = newState.copyWith(
        brandPartners: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(brandPartners: data),
    );
    statsResult.fold(
      (failure) => newState = newState.copyWith(
        marketplaceListingCount: 0,
        marketplaceSellerCount: 0,
        trendingThumbnails: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (stats) => newState = newState.copyWith(
        marketplaceListingCount: stats.listingCount,
        marketplaceSellerCount: stats.sellerCount,
        trendingThumbnails: stats.thumbnails,
      ),
    );

    emit(newState);
  }

  Future<void> _onRefreshBuyTab(
    _RefreshBuyTab event,
    Emitter<BuyTabState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));

    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      emit(state.copyWith(isRefreshing: false, isOffline: true));
      return;
    }

    final categoriesFuture = _buyRepository.getBuyCategories();
    final vasCategoriesFuture = _buyRepository.getVasCategories();
    final regularsFuture = _buyRepository.getBuyRegulars();
    final featuredFuture = _buyRepository.getFeaturedItems();
    final brandsFuture = _buyRepository.getBrandStorefronts();
    final statsFuture = _marketplaceRepository.getMarketplaceStats();

    final categoriesResult = await categoriesFuture;
    final vasCategoriesResult = await vasCategoriesFuture;
    final regularsResult = await regularsFuture;
    final featuredResult = await featuredFuture;
    final brandsResult = await brandsFuture;
    final statsResult = await statsFuture;

    final now = DateTime.now();
    var newState = state.copyWith(
      isRefreshing: false,
      isOffline: false,
      lastSyncedAt: now,
      errorMessage: null,
    );

    categoriesResult.fold(
      (failure) => newState = newState.copyWith(
        categories: [],
        errorMessage: failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(categories: data),
    );
    vasCategoriesResult.fold(
      (failure) => newState = newState.copyWith(
        vasCategories: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(vasCategories: data),
    );
    regularsResult.fold(
      (failure) => newState = newState.copyWith(
        regulars: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(regulars: data),
    );
    featuredResult.fold(
      (failure) => newState = newState.copyWith(
        featuredItems: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(featuredItems: data),
    );
    brandsResult.fold(
      (failure) => newState = newState.copyWith(
        brandPartners: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (data) => newState = newState.copyWith(brandPartners: data),
    );
    statsResult.fold(
      (failure) => newState = newState.copyWith(
        marketplaceListingCount: 0,
        marketplaceSellerCount: 0,
        trendingThumbnails: [],
        errorMessage: newState.errorMessage ?? failure.displayMessage,
      ),
      (stats) => newState = newState.copyWith(
        marketplaceListingCount: stats.listingCount,
        marketplaceSellerCount: stats.sellerCount,
        trendingThumbnails: stats.thumbnails,
      ),
    );

    emit(newState);
  }

  Future<void> _onToggleRegularPin(
    _ToggleRegularPin event,
    Emitter<BuyTabState> emit,
  ) async {
    // Optimistic update: toggle in local state immediately
    final updated = state.regulars.map((r) {
      if (r.id == event.regularId) {
        return r.copyWith(isPinned: event.isPinned);
      }
      return r;
    }).toList();
    emit(state.copyWith(regulars: updated));

    final result = await _buyRepository.toggleRegularPin(
      event.regularId,
      isPinned: event.isPinned,
    );

    result.fold(
      (failure) {
        // Revert on failure
        final reverted = state.regulars.map((r) {
          if (r.id == event.regularId) {
            return r.copyWith(isPinned: !event.isPinned);
          }
          return r;
        }).toList();
        emit(state.copyWith(
          regulars: reverted,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) => emit(state.copyWith(errorMessage: null)),
    );
  }

  Future<void> _onDeleteRegular(
    _DeleteRegular event,
    Emitter<BuyTabState> emit,
  ) async {
    // Optimistic update: remove from local state immediately
    final removed = state.regulars
        .where((r) => r.id != event.regularId)
        .toList();
    final original = state.regulars;
    emit(state.copyWith(regulars: removed));

    final result = await _buyRepository.deleteRegular(event.regularId);

    result.fold(
      (failure) {
        // Revert on failure
        emit(state.copyWith(
          regulars: original,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) => emit(state.copyWith(errorMessage: null)),
    );
  }
}
