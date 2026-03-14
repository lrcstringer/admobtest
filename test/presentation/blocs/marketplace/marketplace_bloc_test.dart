import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/marketplace_listing.dart';
import 'package:imalichat/domain/entities/marketplace_provider.dart';
import 'package:imalichat/domain/entities/saved_listing.dart';
import 'package:imalichat/domain/entities/seller_dashboard.dart';
import 'package:imalichat/domain/entities/vouch.dart';
import 'package:imalichat/domain/enums/listing_status.dart';
import 'package:imalichat/domain/enums/marketplace_category.dart';
import 'package:imalichat/domain/enums/provider_status.dart';
import 'package:imalichat/domain/repositories/marketplace_repository.dart';
import 'package:imalichat/domain/repositories/saved_listing_repository.dart';
import 'package:imalichat/presentation/blocs/marketplace/marketplace_bloc.dart';

class MockMarketplaceRepository extends Mock implements MarketplaceRepository {}

class MockSavedListingRepository extends Mock
    implements SavedListingRepository {}

// Fallback values for mocktail
class FakeSavedListing extends Fake implements SavedListing {}


/// Helper to create a minimal [MarketplaceListing] for tests.
MarketplaceListing _listing({
  String id = 'l1',
  String title = 'Test Listing',
  String description = 'A test listing',
  int priceTokens = 100,
}) =>
    MarketplaceListing(
      id: id,
      title: title,
      description: description,
      category: MarketplaceCategory.foodAndDrinks,
      priceTokens: priceTokens,
      priceZar: priceTokens / 100,
      providerId: 'p1',
      providerName: 'Provider One',
      status: ListingStatus.active,
      createdAt: DateTime(2026),
    );

/// Helper to create a minimal [MarketplaceProvider] for tests.
MarketplaceProvider _provider({String id = 'p1'}) => MarketplaceProvider(
      id: id,
      userId: 'u1',
      displayName: 'Provider One',
      status: ProviderStatus.active,
      createdAt: DateTime(2026),
    );

/// Helper to create a minimal [Vouch] for tests.
Vouch _vouch({String id = 'v1'}) => Vouch(
      id: id,
      voucherId: 'u2',
      voucherName: 'Voucher User',
      providerId: 'p1',
      rating: 5,
      createdAt: DateTime(2026),
    );

/// Helper to create a minimal [SavedListing] for tests.
SavedListing _saved({String listingId = 'l1'}) => SavedListing(
      listingId: listingId,
      savedAt: DateTime(2026),
    );

void main() {
  late MockMarketplaceRepository mockRepository;
  late MockSavedListingRepository mockSavedRepository;

  setUpAll(() {
    registerFallbackValue(FakeSavedListing());
  });

  setUp(() {
    mockRepository = MockMarketplaceRepository();
    mockSavedRepository = MockSavedListingRepository();
  });

  MarketplaceBloc buildBloc() =>
      MarketplaceBloc(mockRepository, mockSavedRepository);

  // ─── Shared stubs ───────────────────────────────────────────────

  void stubGetListings([List<MarketplaceListing> result = const []]) {
    when(() => mockRepository.getListings(
          category: any(named: 'category'),
          communityId: any(named: 'communityId'),
          limit: any(named: 'limit'),
          startAfterId: any(named: 'startAfterId'),
        )).thenAnswer((_) async => Right(result));
  }

  void stubGetListingsFailure() {
    when(() => mockRepository.getListings(
          category: any(named: 'category'),
          communityId: any(named: 'communityId'),
          limit: any(named: 'limit'),
          startAfterId: any(named: 'startAfterId'),
        )).thenAnswer((_) async => const Left(Failure.network()));
  }

  // ─── Tests ──────────────────────────────────────────────────────

  group('MarketplaceBloc', () {
    test('initial state has correct defaults', () {
      final bloc = buildBloc();
      expect(bloc.state.isLoading, false);
      expect(bloc.state.listings, isEmpty);
      expect(bloc.state.selectedListing, isNull);
      expect(bloc.state.selectedProvider, isNull);
      expect(bloc.state.savedItems, isEmpty);
      expect(bloc.state.myListings, isEmpty);
      expect(bloc.state.hasMore, true);
      bloc.close();
    });

    // ── 1. LoadListings ─────────────────────────────────────────

    group('LoadListings', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits [loading, loaded] when getListings succeeds',
        build: () {
          stubGetListings([_listing()]);
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadListings()),
        expect: () => [
          isA<MarketplaceState>().having((s) => s.isLoading, 'isLoading', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.listings.length, 'listings.length', 1),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when getListings fails',
        build: () {
          stubGetListingsFailure();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadListings()),
        expect: () => [
          isA<MarketplaceState>().having((s) => s.isLoading, 'isLoading', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 2. LoadMore ─────────────────────────────────────────────

    group('LoadMore', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already loading more',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isLoadingMore: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMore()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when hasMore is false',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(hasMore: false),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMore()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when listings is empty',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(listings: [], hasMore: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMore()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'appends new listings on success',
        build: () {
          stubGetListings([_listing(id: 'l2')]);
          return buildBloc();
        },
        seed: () => MarketplaceState(
          listings: [_listing(id: 'l1')],
          hasMore: true,
        ),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMore()),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isLoadingMore, 'isLoadingMore', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingMore, 'isLoadingMore', false)
              .having((s) => s.listings.length, 'listings.length', 2),
        ],
      );
    });

    // ── 3. SearchListings ───────────────────────────────────────

    group('SearchListings', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'clears search when query is empty',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(
          isSearching: true,
          searchQuery: 'old',
        ),
        act: (bloc) => bloc.add(const MarketplaceEvent.searchListings('')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isSearching, 'isSearching', false)
              .having((s) => s.searchQuery, 'searchQuery', ''),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'filters listings by query',
        build: () => buildBloc(),
        seed: () => MarketplaceState(
          listings: [
            _listing(id: 'l1', title: 'Apple Phone'),
            _listing(id: 'l2', title: 'Banana Snack'),
          ],
        ),
        act: (bloc) => bloc.add(const MarketplaceEvent.searchListings('apple')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isSearching, 'isSearching', true)
              .having((s) => s.searchQuery, 'searchQuery', 'apple')
              .having(
                  (s) => s.filteredListings.length, 'filteredListings', 1),
        ],
      );
    });

    // ── 4. ClearSearch ──────────────────────────────────────────

    group('ClearSearch', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'clears search state and restores full listings',
        build: () => buildBloc(),
        seed: () => MarketplaceState(
          isSearching: true,
          searchQuery: 'test',
          listings: [_listing()],
          filteredListings: [],
        ),
        act: (bloc) => bloc.add(const MarketplaceEvent.clearSearch()),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isSearching, 'isSearching', false)
              .having((s) => s.searchQuery, 'searchQuery', '')
              .having(
                  (s) => s.filteredListings.length, 'filteredListings', 1),
        ],
      );
    });

    // ── 5. SelectListing ────────────────────────────────────────

    group('SelectListing', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits [loadingDetail, selectedListing] on success',
        build: () {
          when(() => mockRepository.getListing(any()))
              .thenAnswer((_) async => Right(_listing()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.selectListing('l1')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true)
              .having((s) => s.selectedListing, 'selectedListing', isNull),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having(
                  (s) => s.selectedListing, 'selectedListing', isNotNull),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when getListing fails',
        build: () {
          when(() => mockRepository.getListing(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.selectListing('l1')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 6. LoadProviderProfile ──────────────────────────────────

    group('LoadProviderProfile', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits [loadingProvider, selectedProvider] on success',
        build: () {
          when(() => mockRepository.getProvider(any()))
              .thenAnswer((_) async => Right(_provider()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.loadProviderProfile('p1')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isLoadingProvider, 'isLoadingProvider', true)
              .having((s) => s.selectedProvider, 'selectedProvider', isNull),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingProvider, 'isLoadingProvider', false)
              .having(
                  (s) => s.selectedProvider, 'selectedProvider', isNotNull),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when getProvider fails',
        build: () {
          when(() => mockRepository.getProvider(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.loadProviderProfile('p1')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isLoadingProvider, 'isLoadingProvider', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingProvider, 'isLoadingProvider', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 7. LoadProviderVouches ──────────────────────────────────

    group('LoadProviderVouches', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits providerVouches on success',
        build: () {
          when(() => mockRepository.getProviderVouches(any()))
              .thenAnswer((_) async => Right([_vouch()]));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.loadProviderVouches('p1')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.providerVouches.length, 'vouches', 1),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits nothing on failure (non-critical)',
        build: () {
          when(() => mockRepository.getProviderVouches(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.loadProviderVouches('p1')),
        expect: () => [],
      );
    });

    // ── 8. ReportListing ────────────────────────────────────────

    group('ReportListing', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already reporting',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isReporting: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.reportListing(
          listingId: 'l1',
          reason: 'spam',
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when report succeeds',
        build: () {
          when(() => mockRepository.reportItem(
                targetId: any(named: 'targetId'),
                targetType: any(named: 'targetType'),
                reason: any(named: 'reason'),
                description: any(named: 'description'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.reportListing(
          listingId: 'l1',
          reason: 'spam',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isReporting, 'isReporting', true),
          isA<MarketplaceState>()
              .having((s) => s.isReporting, 'isReporting', false)
              .having((s) => s.reportSuccessMessage, 'msg', isNotNull),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when report fails',
        build: () {
          when(() => mockRepository.reportItem(
                targetId: any(named: 'targetId'),
                targetType: any(named: 'targetType'),
                reason: any(named: 'reason'),
                description: any(named: 'description'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.reportListing(
          listingId: 'l1',
          reason: 'spam',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isReporting, 'isReporting', true),
          isA<MarketplaceState>()
              .having((s) => s.isReporting, 'isReporting', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 9. ReportProvider ───────────────────────────────────────

    group('ReportProvider', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already reporting',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isReporting: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.reportProvider(
          providerId: 'p1',
          reason: 'scam',
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when reportProvider succeeds',
        build: () {
          when(() => mockRepository.reportItem(
                targetId: any(named: 'targetId'),
                targetType: any(named: 'targetType'),
                reason: any(named: 'reason'),
                description: any(named: 'description'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.reportProvider(
          providerId: 'p1',
          reason: 'scam',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isReporting, 'isReporting', true),
          isA<MarketplaceState>()
              .having((s) => s.isReporting, 'isReporting', false)
              .having((s) => s.reportSuccessMessage, 'msg', isNotNull),
        ],
        verify: (_) {
          verify(() => mockRepository.reportItem(
                targetId: 'p1',
                targetType: 'provider',
                reason: 'scam',
                description: null,
              )).called(1);
        },
      );
    });

    // ── 10. CreateListing ───────────────────────────────────────

    group('CreateListing', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already creating',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isCreating: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.createListing(
          title: 'T',
          description: 'D',
          category: 'electronics',
          priceTokens: 100,
          imageUrls: [],
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits createSuccessId on success',
        build: () {
          when(() => mockRepository.createListing(
                title: any(named: 'title'),
                description: any(named: 'description'),
                category: any(named: 'category'),
                subCategory: any(named: 'subCategory'),
                priceTokens: any(named: 'priceTokens'),
                imageUrls: any(named: 'imageUrls'),
                location: any(named: 'location'),
                deliveryMethod: any(named: 'deliveryMethod'),
                deliveryFee: any(named: 'deliveryFee'),
                serviceAreaType: any(named: 'serviceAreaType'),
                locationData: any(named: 'locationData'),
              )).thenAnswer((_) async => const Right('newId'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.createListing(
          title: 'T',
          description: 'D',
          category: 'electronics',
          priceTokens: 100,
          imageUrls: [],
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isCreating, 'isCreating', true),
          isA<MarketplaceState>()
              .having((s) => s.isCreating, 'isCreating', false)
              .having((s) => s.createSuccessId, 'createSuccessId', 'newId'),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when createListing fails',
        build: () {
          when(() => mockRepository.createListing(
                title: any(named: 'title'),
                description: any(named: 'description'),
                category: any(named: 'category'),
                subCategory: any(named: 'subCategory'),
                priceTokens: any(named: 'priceTokens'),
                imageUrls: any(named: 'imageUrls'),
                location: any(named: 'location'),
                deliveryMethod: any(named: 'deliveryMethod'),
                deliveryFee: any(named: 'deliveryFee'),
                serviceAreaType: any(named: 'serviceAreaType'),
                locationData: any(named: 'locationData'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.createListing(
          title: 'T',
          description: 'D',
          category: 'electronics',
          priceTokens: 100,
          imageUrls: [],
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isCreating, 'isCreating', true),
          isA<MarketplaceState>()
              .having((s) => s.isCreating, 'isCreating', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 11. UpdateListing ───────────────────────────────────────

    group('UpdateListing', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already updating',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isUpdating: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.updateListing(
          listingId: 'l1',
          title: 'New Title',
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when updateListing succeeds',
        build: () {
          when(() => mockRepository.updateListing(
                listingId: any(named: 'listingId'),
                title: any(named: 'title'),
                description: any(named: 'description'),
                category: any(named: 'category'),
                priceTokens: any(named: 'priceTokens'),
                imageUrls: any(named: 'imageUrls'),
                location: any(named: 'location'),
                deliveryMethod: any(named: 'deliveryMethod'),
                deliveryFee: any(named: 'deliveryFee'),
                serviceAreaType: any(named: 'serviceAreaType'),
                locationData: any(named: 'locationData'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.updateListing(
          listingId: 'l1',
          title: 'New Title',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isUpdating, 'isUpdating', true),
          isA<MarketplaceState>()
              .having((s) => s.isUpdating, 'isUpdating', false)
              .having((s) => s.successMessage, 'msg',
                  'Listing updated successfully'),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when updateListing fails',
        build: () {
          when(() => mockRepository.updateListing(
                listingId: any(named: 'listingId'),
                title: any(named: 'title'),
                description: any(named: 'description'),
                category: any(named: 'category'),
                priceTokens: any(named: 'priceTokens'),
                imageUrls: any(named: 'imageUrls'),
                location: any(named: 'location'),
                deliveryMethod: any(named: 'deliveryMethod'),
                deliveryFee: any(named: 'deliveryFee'),
                serviceAreaType: any(named: 'serviceAreaType'),
                locationData: any(named: 'locationData'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.updateListing(
          listingId: 'l1',
          title: 'New Title',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isUpdating, 'isUpdating', true),
          isA<MarketplaceState>()
              .having((s) => s.isUpdating, 'isUpdating', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 12. ToggleListingStatus ─────────────────────────────────

    group('ToggleListingStatus', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already toggling status',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isTogglingStatus: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.toggleListingStatus(
          listingId: 'l1',
          action: 'pause',
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when toggleListingStatus succeeds',
        build: () {
          when(() => mockRepository.toggleListingStatus(
                listingId: any(named: 'listingId'),
                action: any(named: 'action'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.toggleListingStatus(
          listingId: 'l1',
          action: 'pause',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isTogglingStatus, 'isTogglingStatus', true),
          isA<MarketplaceState>()
              .having((s) => s.isTogglingStatus, 'isTogglingStatus', false)
              .having(
                  (s) => s.successMessage, 'msg', 'Listing status updated'),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when toggleListingStatus fails',
        build: () {
          when(() => mockRepository.toggleListingStatus(
                listingId: any(named: 'listingId'),
                action: any(named: 'action'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.toggleListingStatus(
          listingId: 'l1',
          action: 'pause',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isTogglingStatus, 'isTogglingStatus', true),
          isA<MarketplaceState>()
              .having((s) => s.isTogglingStatus, 'isTogglingStatus', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 13. RenewListing ────────────────────────────────────────

    group('RenewListing', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already renewing',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isRenewing: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.renewListing('l1')),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when renewListing succeeds',
        build: () {
          when(() => mockRepository.renewListing(any()))
              .thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.renewListing('l1')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isRenewing, 'isRenewing', true),
          isA<MarketplaceState>()
              .having((s) => s.isRenewing, 'isRenewing', false)
              .having((s) => s.successMessage, 'msg',
                  'Listing renewed successfully'),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when renewListing fails',
        build: () {
          when(() => mockRepository.renewListing(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.renewListing('l1')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isRenewing, 'isRenewing', true),
          isA<MarketplaceState>()
              .having((s) => s.isRenewing, 'isRenewing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 14. MakeOffer ───────────────────────────────────────────

    group('MakeOffer', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already making offer',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isMakingOffer: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.makeOffer(
          listingId: 'l1',
          offerAmount: 50,
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when makeOffer succeeds',
        build: () {
          when(() => mockRepository.makeOffer(
                listingId: any(named: 'listingId'),
                offerAmount: any(named: 'offerAmount'),
                message: any(named: 'message'),
              )).thenAnswer((_) async => const Right('offer1'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.makeOffer(
          listingId: 'l1',
          offerAmount: 50,
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isMakingOffer, 'isMakingOffer', true),
          isA<MarketplaceState>()
              .having((s) => s.isMakingOffer, 'isMakingOffer', false)
              .having((s) => s.successMessage, 'msg', isNotNull),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when makeOffer fails',
        build: () {
          when(() => mockRepository.makeOffer(
                listingId: any(named: 'listingId'),
                offerAmount: any(named: 'offerAmount'),
                message: any(named: 'message'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.makeOffer(
          listingId: 'l1',
          offerAmount: 50,
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isMakingOffer, 'isMakingOffer', true),
          isA<MarketplaceState>()
              .having((s) => s.isMakingOffer, 'isMakingOffer', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 15. RespondToOffer ──────────────────────────────────────

    group('RespondToOffer', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already responding',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isRespondingToOffer: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.respondToOffer(
          offerId: 'o1',
          action: 'accept',
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when respondToOffer succeeds',
        build: () {
          when(() => mockRepository.respondToOffer(
                offerId: any(named: 'offerId'),
                action: any(named: 'action'),
                counterAmount: any(named: 'counterAmount'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.respondToOffer(
          offerId: 'o1',
          action: 'accept',
        )),
        expect: () => [
          isA<MarketplaceState>().having(
              (s) => s.isRespondingToOffer, 'isRespondingToOffer', true),
          isA<MarketplaceState>()
              .having(
                  (s) => s.isRespondingToOffer, 'isRespondingToOffer', false)
              .having(
                  (s) => s.successMessage, 'msg', 'Offer response sent'),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when respondToOffer fails',
        build: () {
          when(() => mockRepository.respondToOffer(
                offerId: any(named: 'offerId'),
                action: any(named: 'action'),
                counterAmount: any(named: 'counterAmount'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.respondToOffer(
          offerId: 'o1',
          action: 'accept',
        )),
        expect: () => [
          isA<MarketplaceState>().having(
              (s) => s.isRespondingToOffer, 'isRespondingToOffer', true),
          isA<MarketplaceState>()
              .having(
                  (s) => s.isRespondingToOffer, 'isRespondingToOffer', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 16. SellerRefund ────────────────────────────────────────

    group('SellerRefund', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already refunding',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isRefunding: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.sellerRefund(
          orderId: 'ord1',
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when sellerRefund succeeds',
        build: () {
          when(() => mockRepository.sellerRefund(
                orderId: any(named: 'orderId'),
                reason: any(named: 'reason'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.sellerRefund(
          orderId: 'ord1',
          reason: 'damaged',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isRefunding, 'isRefunding', true),
          isA<MarketplaceState>()
              .having((s) => s.isRefunding, 'isRefunding', false)
              .having((s) => s.successMessage, 'msg',
                  'Refund initiated successfully'),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when sellerRefund fails',
        build: () {
          when(() => mockRepository.sellerRefund(
                orderId: any(named: 'orderId'),
                reason: any(named: 'reason'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.sellerRefund(
          orderId: 'ord1',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isRefunding, 'isRefunding', true),
          isA<MarketplaceState>()
              .having((s) => s.isRefunding, 'isRefunding', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 17. ClearMessages ───────────────────────────────────────

    group('ClearMessages', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'clears all message fields',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(
          errorMessage: 'error',
          successMessage: 'success',
          reportSuccessMessage: 'reported',
          createSuccessId: 'id',
        ),
        act: (bloc) => bloc.add(const MarketplaceEvent.clearMessages()),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull)
              .having((s) => s.reportSuccessMessage, 'reportMsg', isNull)
              .having((s) => s.createSuccessId, 'createSuccessId', isNull),
        ],
      );
    });

    // ── 18. LoadMyListings ──────────────────────────────────────

    group('LoadMyListings', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already loading my listings',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isLoadingMyListings: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMyListings()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'returns empty list when currentSellerProfile is null',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(currentSellerProfile: null),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMyListings()),
        expect: () => [
          isA<MarketplaceState>().having(
              (s) => s.isLoadingMyListings, 'isLoadingMyListings', true),
          isA<MarketplaceState>()
              .having(
                  (s) => s.isLoadingMyListings, 'isLoadingMyListings', false)
              .having((s) => s.myListings, 'myListings', isEmpty),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'loads listings when currentSellerProfile is set',
        build: () {
          when(() => mockRepository.getProviderListings(any()))
              .thenAnswer((_) async => Right([_listing()]));
          return buildBloc();
        },
        seed: () => MarketplaceState(currentSellerProfile: _provider()),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMyListings()),
        expect: () => [
          isA<MarketplaceState>().having(
              (s) => s.isLoadingMyListings, 'isLoadingMyListings', true),
          isA<MarketplaceState>()
              .having(
                  (s) => s.isLoadingMyListings, 'isLoadingMyListings', false)
              .having((s) => s.myListings.length, 'myListings.length', 1),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when getProviderListings fails',
        build: () {
          when(() => mockRepository.getProviderListings(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        seed: () => MarketplaceState(currentSellerProfile: _provider()),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMyListings()),
        expect: () => [
          isA<MarketplaceState>().having(
              (s) => s.isLoadingMyListings, 'isLoadingMyListings', true),
          isA<MarketplaceState>()
              .having(
                  (s) => s.isLoadingMyListings, 'isLoadingMyListings', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 19. LoadSavedItems ──────────────────────────────────────

    group('LoadSavedItems', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already loading saved',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isLoadingSaved: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSavedItems()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits saved items on success',
        build: () {
          when(() => mockSavedRepository.getAll())
              .thenAnswer((_) async => Right([_saved()]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSavedItems()),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isLoadingSaved, 'isLoadingSaved', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingSaved, 'isLoadingSaved', false)
              .having((s) => s.savedItems.length, 'savedItems.length', 1),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when getAll fails',
        build: () {
          when(() => mockSavedRepository.getAll())
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSavedItems()),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isLoadingSaved, 'isLoadingSaved', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingSaved, 'isLoadingSaved', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 20. LoadSellerPortal ────────────────────────────────────

    group('LoadSellerPortal', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already loading seller portal',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isLoadingSellerPortal: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSellerPortal()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits sellerDashboard on success',
        build: () {
          when(() => mockRepository.getSellerDashboard()).thenAnswer(
              (_) async => const Right(SellerDashboard(totalListings: 5)));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSellerPortal()),
        expect: () => [
          isA<MarketplaceState>().having(
              (s) => s.isLoadingSellerPortal, 'isLoadingSellerPortal', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingSellerPortal,
                  'isLoadingSellerPortal', false)
              .having((s) => s.sellerDashboard?.totalListings,
                  'totalListings', 5),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when getSellerDashboard fails',
        build: () {
          when(() => mockRepository.getSellerDashboard())
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSellerPortal()),
        expect: () => [
          isA<MarketplaceState>().having(
              (s) => s.isLoadingSellerPortal, 'isLoadingSellerPortal', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingSellerPortal,
                  'isLoadingSellerPortal', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 21. ToggleFavourite ─────────────────────────────────────

    group('ToggleFavourite', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already toggling favourite',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isTogglingFavourite: true),
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.toggleFavourite('l1')),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'optimistic add: adds item then refreshes from source',
        build: () {
          when(() => mockSavedRepository.save(any()))
              .thenAnswer((_) async => const Right(null));
          when(() => mockSavedRepository.getAll())
              .thenAnswer((_) async => Right([_saved(listingId: 'l1')]));
          return buildBloc();
        },
        seed: () => const MarketplaceState(savedItems: []),
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.toggleFavourite('l1')),
        expect: () => [
          // Optimistic: item added immediately
          isA<MarketplaceState>()
              .having((s) => s.savedItems.length, 'savedItems.length', 1),
          // Refresh from source of truth
          isA<MarketplaceState>()
              .having((s) => s.savedItems.length, 'savedItems.length', 1),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'optimistic remove: removes item then refreshes from source',
        build: () {
          when(() => mockSavedRepository.remove(any()))
              .thenAnswer((_) async => const Right(null));
          when(() => mockSavedRepository.getAll())
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        seed: () => MarketplaceState(savedItems: [_saved(listingId: 'l1')]),
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.toggleFavourite('l1')),
        expect: () => [
          // Optimistic remove + refresh both yield empty savedItems,
          // so BLoC deduplicates into a single emission.
          isA<MarketplaceState>()
              .having((s) => s.savedItems, 'savedItems', isEmpty),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'reverts to previous state on save failure',
        build: () {
          when(() => mockSavedRepository.save(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        seed: () => const MarketplaceState(savedItems: []),
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.toggleFavourite('l1')),
        expect: () => [
          // Optimistic: item added
          isA<MarketplaceState>()
              .having((s) => s.savedItems.length, 'savedItems.length', 1),
          // Revert: back to empty + error message
          isA<MarketplaceState>()
              .having((s) => s.savedItems, 'savedItems', isEmpty)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'reverts to previous state on remove failure',
        build: () {
          when(() => mockSavedRepository.remove(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        seed: () => MarketplaceState(savedItems: [_saved(listingId: 'l1')]),
        act: (bloc) =>
            bloc.add(const MarketplaceEvent.toggleFavourite('l1')),
        expect: () => [
          // Optimistic: item removed
          isA<MarketplaceState>()
              .having((s) => s.savedItems, 'savedItems', isEmpty),
          // Revert: item restored + error message
          isA<MarketplaceState>()
              .having((s) => s.savedItems.length, 'savedItems.length', 1)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 22. UploadImages ────────────────────────────────────────

    group('UploadImages', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already uploading',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isUploadingImages: true),
        act: (bloc) => bloc.add(MarketplaceEvent.uploadImages(
          imageData: [Uint8List(0)],
          listingId: 'l1',
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits uploadedImageUrls on success',
        build: () {
          when(() => mockRepository.uploadListingImages(
                imageData: any(named: 'imageData'),
                listingId: any(named: 'listingId'),
              )).thenAnswer((_) async => const Right(['url1', 'url2']));
          return buildBloc();
        },
        act: (bloc) => bloc.add(MarketplaceEvent.uploadImages(
          imageData: [Uint8List(0)],
          listingId: 'l1',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having(
                  (s) => s.isUploadingImages, 'isUploadingImages', true)
              .having(
                  (s) => s.uploadedImageUrls, 'uploadedImageUrls', isEmpty),
          isA<MarketplaceState>()
              .having(
                  (s) => s.isUploadingImages, 'isUploadingImages', false)
              .having((s) => s.uploadedImageUrls.length, 'urls.length', 2),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when uploadListingImages fails',
        build: () {
          when(() => mockRepository.uploadListingImages(
                imageData: any(named: 'imageData'),
                listingId: any(named: 'listingId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(MarketplaceEvent.uploadImages(
          imageData: [Uint8List(0)],
          listingId: 'l1',
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having(
                  (s) => s.isUploadingImages, 'isUploadingImages', true),
          isA<MarketplaceState>()
              .having(
                  (s) => s.isUploadingImages, 'isUploadingImages', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── 23. RegisterProvider ────────────────────────────────────

    group('RegisterProvider', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'guard: does nothing when already registering',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isRegistering: true),
        act: (bloc) => bloc.add(MarketplaceEvent.registerProvider(
          displayName: 'Test Provider',
          contactPreferences: const {'chat': true, 'phone': false},
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when registerProvider succeeds',
        build: () {
          when(() => mockRepository.registerProvider(
                displayName: any(named: 'displayName'),
                photoUrl: any(named: 'photoUrl'),
                contactPreferences: any(named: 'contactPreferences'),
              )).thenAnswer((_) async => const Right('providerId'));
          when(() => mockRepository.getProvider(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(MarketplaceEvent.registerProvider(
          displayName: 'Test Provider',
          contactPreferences: const {'chat': true, 'phone': false},
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isRegistering, 'isRegistering', true),
          isA<MarketplaceState>()
              .having((s) => s.isRegistering, 'isRegistering', false)
              .having(
                  (s) => s.registrationSuccess, 'registrationSuccess', true),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when registerProvider fails',
        build: () {
          when(() => mockRepository.registerProvider(
                displayName: any(named: 'displayName'),
                photoUrl: any(named: 'photoUrl'),
                contactPreferences: any(named: 'contactPreferences'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(MarketplaceEvent.registerProvider(
          displayName: 'Test Provider',
          contactPreferences: const {'chat': true, 'phone': false},
        )),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isRegistering, 'isRegistering', true),
          isA<MarketplaceState>()
              .having((s) => s.isRegistering, 'isRegistering', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });
  });
}
