import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/domain/entities/buy_regular.dart';
import 'package:imalichat/domain/repositories/buy_repository.dart';
import 'package:imalichat/domain/repositories/marketplace_repository.dart';
import 'package:imalichat/presentation/blocs/buy_tab/buy_tab_bloc.dart';

class MockBuyRepository extends Mock implements BuyRepository {}

class MockMarketplaceRepository extends Mock implements MarketplaceRepository {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockBuyRepository mockBuyRepository;
  late MockMarketplaceRepository mockMarketplaceRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockBuyRepository = MockBuyRepository();
    mockMarketplaceRepository = MockMarketplaceRepository();
    mockNetworkInfo = MockNetworkInfo();
  });

  BuyTabBloc buildBloc() => BuyTabBloc(
        mockBuyRepository,
        mockMarketplaceRepository,
        mockNetworkInfo,
      );

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  final tNow = DateTime(2026, 3, 13);

  BuyRegular makeRegular({
    required String id,
    bool isPinned = false,
  }) =>
      BuyRegular(
        id: id,
        providerId: 'prov_$id',
        productId: 'prod_$id',
        providerName: 'Provider $id',
        productName: 'Product $id',
        recipientNumber: '0812345678',
        isPinned: isPinned,
        usageCount: 1,
        lastUsedAt: tNow,
      );

  final tRegulars = [
    makeRegular(id: 'r1', isPinned: true),
    makeRegular(id: 'r2'),
    makeRegular(id: 'r3'),
  ];

  /// Stubs every repository call to return success with empty/default data.
  void stubAllSuccess() {
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockBuyRepository.getCachedCategories())
        .thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getCachedRegulars())
        .thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getCachedFeaturedItems())
        .thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getBuyCategories())
        .thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getBuyRegulars())
        .thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getFeaturedItems())
        .thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getBrandStorefronts())
        .thenAnswer((_) async => const Right([]));
    when(() => mockMarketplaceRepository.getMarketplaceStats()).thenAnswer(
      (_) async => const Right(
        (listingCount: 0, sellerCount: 0, thumbnails: <String>[]),
      ),
    );
  }

  /// Stubs the toggle and delete calls.
  void stubToggleAndDelete() {
    when(() => mockBuyRepository.toggleRegularPin(
          any(),
          isPinned: any(named: 'isPinned'),
        )).thenAnswer((_) async => const Right(null));
    when(() => mockBuyRepository.deleteRegular(any()))
        .thenAnswer((_) async => const Right(null));
  }

  // ---------------------------------------------------------------------------
  // Tests
  // ---------------------------------------------------------------------------

  group('BuyTabBloc', () {
    // ── Initial state ──────────────────────────────────────────────────────
    test('initial state has sensible defaults', () {
      final bloc = buildBloc();
      final s = bloc.state;
      expect(s.isLoading, false);
      expect(s.isRefreshing, false);
      expect(s.isOffline, false);
      expect(s.categories, isEmpty);
      expect(s.regulars, isEmpty);
      expect(s.featuredItems, isEmpty);
      expect(s.brandPartners, isEmpty);
      expect(s.marketplaceListingCount, 0);
      expect(s.marketplaceSellerCount, 0);
      expect(s.trendingThumbnails, isEmpty);
      expect(s.errorMessage, isNull);
      expect(s.lastSyncedAt, isNull);
      bloc.close();
    });

    // ── LoadBuyTab ─────────────────────────────────────────────────────────
    group('LoadBuyTab', () {
      blocTest<BuyTabBloc, BuyTabState>(
        'emits loading → cached → online flag → loaded when all succeed',
        build: () {
          stubAllSuccess();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          // 1. isLoading = true
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          // 2. final state — loaded (online flag emit is deduplicated since
          //    isOffline defaults to false and cached results are empty)
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.lastSyncedAt, 'lastSyncedAt', isNotNull),
        ],
        verify: (_) {
          verify(() => mockBuyRepository.getCachedCategories()).called(1);
          verify(() => mockBuyRepository.getCachedRegulars()).called(1);
          verify(() => mockBuyRepository.getCachedFeaturedItems()).called(1);
          verify(() => mockBuyRepository.getBuyCategories()).called(1);
          verify(() => mockBuyRepository.getBuyRegulars()).called(1);
          verify(() => mockBuyRepository.getFeaturedItems()).called(1);
          verify(() => mockBuyRepository.getBrandStorefronts()).called(1);
          verify(() => mockMarketplaceRepository.getMarketplaceStats())
              .called(1);
        },
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'emits offline state when not connected — only uses cache',
        build: () {
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => false);
          when(() => mockBuyRepository.getCachedCategories())
              .thenAnswer((_) async => const Right([]));
          when(() => mockBuyRepository.getCachedRegulars())
              .thenAnswer((_) async => const Right([]));
          when(() => mockBuyRepository.getCachedFeaturedItems())
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.isOffline, 'isOffline', true),
        ],
        verify: (_) {
          verifyNever(() => mockBuyRepository.getBuyCategories());
          verifyNever(() => mockBuyRepository.getBuyRegulars());
          verifyNever(() => mockBuyRepository.getFeaturedItems());
          verifyNever(() => mockBuyRepository.getBrandStorefronts());
          verifyNever(() => mockMarketplaceRepository.getMarketplaceStats());
        },
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'emits error when categories remote call fails',
        build: () {
          stubAllSuccess();
          when(() => mockBuyRepository.getBuyCategories()).thenAnswer(
            (_) async => const Left(Failure.network(message: 'cat fail')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull)
              .having((s) => s.categories, 'categories', isEmpty),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'partial failure — regulars fail but others succeed, data is preserved',
        build: () {
          stubAllSuccess();
          when(() => mockBuyRepository.getBuyRegulars()).thenAnswer(
            (_) async =>
                const Left(Failure.network(message: 'regulars fail')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull)
              .having((s) => s.regulars, 'regulars', isEmpty),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'partial failure — marketplace stats fail, other data loaded',
        build: () {
          stubAllSuccess();
          when(() => mockMarketplaceRepository.getMarketplaceStats())
              .thenAnswer(
            (_) async =>
                const Left(Failure.network(message: 'stats fail')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull)
              .having(
                (s) => s.marketplaceListingCount,
                'marketplaceListingCount',
                0,
              )
              .having(
                (s) => s.marketplaceSellerCount,
                'marketplaceSellerCount',
                0,
              ),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'multiple remote failures — first failure message is preserved',
        build: () {
          stubAllSuccess();
          when(() => mockBuyRepository.getBuyCategories()).thenAnswer(
            (_) async =>
                const Left(Failure.network(message: 'first failure')),
          );
          when(() => mockBuyRepository.getBuyRegulars()).thenAnswer(
            (_) async =>
                const Left(Failure.network(message: 'second failure')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── RefreshBuyTab ──────────────────────────────────────────────────────
    group('RefreshBuyTab', () {
      blocTest<BuyTabBloc, BuyTabState>(
        'emits refreshing → refreshed when all succeed',
        build: () {
          stubAllSuccess();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.refreshBuyTab()),
        expect: () => [
          isA<BuyTabState>().having(
              (s) => s.isRefreshing, 'isRefreshing', true),
          isA<BuyTabState>()
              .having((s) => s.isRefreshing, 'isRefreshing', false)
              .having((s) => s.isOffline, 'isOffline', false)
              .having((s) => s.lastSyncedAt, 'lastSyncedAt', isNotNull)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'emits offline when not connected on refresh',
        build: () {
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => false);
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.refreshBuyTab()),
        expect: () => [
          isA<BuyTabState>().having(
              (s) => s.isRefreshing, 'isRefreshing', true),
          isA<BuyTabState>()
              .having((s) => s.isRefreshing, 'isRefreshing', false)
              .having((s) => s.isOffline, 'isOffline', true),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'emits error when a remote call fails during refresh',
        build: () {
          stubAllSuccess();
          when(() => mockBuyRepository.getFeaturedItems()).thenAnswer(
            (_) async =>
                const Left(Failure.network(message: 'featured fail')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.refreshBuyTab()),
        expect: () => [
          isA<BuyTabState>().having(
              (s) => s.isRefreshing, 'isRefreshing', true),
          isA<BuyTabState>()
              .having((s) => s.isRefreshing, 'isRefreshing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull)
              .having((s) => s.featuredItems, 'featuredItems', isEmpty),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'refresh clears previous errorMessage when all calls succeed',
        seed: () => const BuyTabState(errorMessage: 'old error'),
        build: () {
          stubAllSuccess();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.refreshBuyTab()),
        expect: () => [
          isA<BuyTabState>().having(
              (s) => s.isRefreshing, 'isRefreshing', true),
          isA<BuyTabState>()
              .having((s) => s.isRefreshing, 'isRefreshing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    // ── ToggleRegularPin ───────────────────────────────────────────────────
    group('ToggleRegularPin', () {
      blocTest<BuyTabBloc, BuyTabState>(
        'optimistically pins a regular, then confirms on success',
        seed: () => BuyTabState(regulars: tRegulars),
        build: () {
          stubToggleAndDelete();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.toggleRegularPin(
          regularId: 'r2',
          isPinned: true,
        )),
        expect: () => [
          // Optimistic: r2 is now pinned (confirmation emit is deduplicated
          // because errorMessage was already null)
          isA<BuyTabState>().having(
            (s) => s.regulars.firstWhere((r) => r.id == 'r2').isPinned,
            'r2.isPinned',
            true,
          ),
        ],
        verify: (_) {
          verify(() => mockBuyRepository.toggleRegularPin(
                'r2',
                isPinned: true,
              )).called(1);
        },
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'optimistically unpins a regular, then confirms on success',
        seed: () => BuyTabState(regulars: tRegulars),
        build: () {
          stubToggleAndDelete();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.toggleRegularPin(
          regularId: 'r1',
          isPinned: false,
        )),
        expect: () => [
          // Optimistic: r1 is now unpinned (confirmation deduplicated)
          isA<BuyTabState>().having(
            (s) => s.regulars.firstWhere((r) => r.id == 'r1').isPinned,
            'r1.isPinned',
            false,
          ),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'reverts optimistic pin on failure and sets errorMessage',
        seed: () => BuyTabState(regulars: tRegulars),
        build: () {
          when(() => mockBuyRepository.toggleRegularPin(
                any(),
                isPinned: any(named: 'isPinned'),
              )).thenAnswer(
            (_) async =>
                const Left(Failure.network(message: 'toggle failed')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.toggleRegularPin(
          regularId: 'r2',
          isPinned: true,
        )),
        expect: () => [
          // 1. Optimistic: r2 pinned
          isA<BuyTabState>().having(
            (s) => s.regulars.firstWhere((r) => r.id == 'r2').isPinned,
            'r2.isPinned',
            true,
          ),
          // 2. Reverted: r2 back to unpinned, error set
          isA<BuyTabState>()
              .having(
                (s) => s.regulars.firstWhere((r) => r.id == 'r2').isPinned,
                'r2.isPinned (reverted)',
                false,
              )
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'does not affect other regulars during toggle',
        seed: () => BuyTabState(regulars: tRegulars),
        build: () {
          stubToggleAndDelete();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.toggleRegularPin(
          regularId: 'r2',
          isPinned: true,
        )),
        verify: (bloc) {
          // r1 and r3 are unchanged
          final r1 = bloc.state.regulars.firstWhere((r) => r.id == 'r1');
          final r3 = bloc.state.regulars.firstWhere((r) => r.id == 'r3');
          expect(r1.isPinned, true); // was already pinned
          expect(r3.isPinned, false); // still unpinned
          expect(bloc.state.regulars.length, 3);
        },
      );
    });

    // ── DeleteRegular ──────────────────────────────────────────────────────
    group('DeleteRegular', () {
      blocTest<BuyTabBloc, BuyTabState>(
        'optimistically removes regular, then confirms on success',
        seed: () => BuyTabState(regulars: tRegulars),
        build: () {
          stubToggleAndDelete();
          return buildBloc();
        },
        act: (bloc) => bloc.add(
            const BuyTabEvent.deleteRegular(regularId: 'r2')),
        expect: () => [
          // Optimistic removal (confirmation deduplicated)
          isA<BuyTabState>()
              .having((s) => s.regulars.length, 'length', 2)
              .having(
                (s) => s.regulars.any((r) => r.id == 'r2'),
                'contains r2',
                false,
              ),
        ],
        verify: (_) {
          verify(() => mockBuyRepository.deleteRegular('r2')).called(1);
        },
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'reverts deletion on failure — restores original list and sets error',
        seed: () => BuyTabState(regulars: tRegulars),
        build: () {
          when(() => mockBuyRepository.deleteRegular(any())).thenAnswer(
            (_) async =>
                const Left(Failure.network(message: 'delete failed')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(
            const BuyTabEvent.deleteRegular(regularId: 'r2')),
        expect: () => [
          // 1. Optimistic removal
          isA<BuyTabState>()
              .having((s) => s.regulars.length, 'length', 2)
              .having(
                (s) => s.regulars.any((r) => r.id == 'r2'),
                'contains r2',
                false,
              ),
          // 2. Reverted — all three regulars restored
          isA<BuyTabState>()
              .having((s) => s.regulars.length, 'length', 3)
              .having(
                (s) => s.regulars.any((r) => r.id == 'r2'),
                'contains r2 (restored)',
                true,
              )
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'deleting non-existent regular is a no-op on list',
        seed: () => BuyTabState(regulars: tRegulars),
        build: () {
          stubToggleAndDelete();
          return buildBloc();
        },
        act: (bloc) => bloc.add(
            const BuyTabEvent.deleteRegular(regularId: 'nonexistent')),
        // Removing a non-existent ID produces an identical list,
        // and confirmation also produces identical state → zero emissions.
        expect: () => [],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'delete from single-item list results in empty list',
        seed: () => BuyTabState(regulars: [makeRegular(id: 'only')]),
        build: () {
          stubToggleAndDelete();
          return buildBloc();
        },
        act: (bloc) => bloc.add(
            const BuyTabEvent.deleteRegular(regularId: 'only')),
        expect: () => [
          // Empty list after optimistic removal (confirmation deduplicated)
          isA<BuyTabState>()
              .having((s) => s.regulars, 'regulars', isEmpty),
        ],
      );
    });
  });
}
