import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/marketplace_repository.dart';
import 'package:imalichat/domain/repositories/saved_listing_repository.dart';
import 'package:imalichat/presentation/blocs/marketplace/marketplace_bloc.dart';

class MockMarketplaceRepository extends Mock implements MarketplaceRepository {}
class MockSavedListingRepository extends Mock implements SavedListingRepository {}

void main() {
  late MockMarketplaceRepository mockRepository;
  late MockSavedListingRepository mockSavedRepository;

  setUp(() {
    mockRepository = MockMarketplaceRepository();
    mockSavedRepository = MockSavedListingRepository();
  });

  MarketplaceBloc buildBloc() => MarketplaceBloc(mockRepository, mockSavedRepository);

  group('MarketplaceBloc', () {
    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state.isLoading, false);
      expect(bloc.state.listings, isEmpty);
      expect(bloc.state.selectedListing, isNull);
      bloc.close();
    });

    group('LoadListings', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits [loading, loaded] when getListings succeeds',
        build: () {
          when(() => mockRepository.getListings(
            category: any(named: 'category'),
            communityId: any(named: 'communityId'),
            limit: any(named: 'limit'),
            startAfterId: any(named: 'startAfterId'),
          )).thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadListings()),
        expect: () => [
          isA<MarketplaceState>().having((s) => s.isLoading, 'isLoading', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.listings, 'listings', isEmpty),
        ],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits error when getListings fails',
        build: () {
          when(() => mockRepository.getListings(
            category: any(named: 'category'),
            communityId: any(named: 'communityId'),
            limit: any(named: 'limit'),
            startAfterId: any(named: 'startAfterId'),
          )).thenAnswer((_) async => const Left(Failure.network()));
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

    group('LoadMore', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'does nothing when already loading more',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isLoadingMore: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMore()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'does nothing when no more items',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(hasMore: false),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadMore()),
        expect: () => [],
      );
    });

    group('SearchListings', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'clears search when query is empty',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isSearching: true, searchQuery: 'old'),
        act: (bloc) => bloc.add(const MarketplaceEvent.searchListings('')),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isSearching, 'isSearching', false)
              .having((s) => s.searchQuery, 'searchQuery', ''),
        ],
      );
    });

    group('ClearSearch', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'clears search state',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isSearching: true, searchQuery: 'test'),
        act: (bloc) => bloc.add(const MarketplaceEvent.clearSearch()),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.isSearching, 'isSearching', false)
              .having((s) => s.searchQuery, 'searchQuery', ''),
        ],
      );
    });

    group('ReportListing', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'double-submit guard prevents concurrent reports',
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
          isA<MarketplaceState>().having((s) => s.isReporting, 'isReporting', true),
          isA<MarketplaceState>()
              .having((s) => s.isReporting, 'isReporting', false)
              .having((s) => s.reportSuccessMessage, 'reportSuccessMessage', isNotNull),
        ],
      );
    });

    group('CreateListing', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'double-submit guard prevents concurrent creates',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isCreating: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.createListing(
          title: 'Test',
          description: 'Desc',
          category: 'electronics',
          priceTokens: 100,
          imageUrls: [],
        )),
        expect: () => [],
      );
    });

    group('MakeOffer', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'double-submit guard prevents concurrent offers',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isMakingOffer: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.makeOffer(
          listingId: 'l1',
          offerAmount: 50,
        )),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits success when offer succeeds',
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
          isA<MarketplaceState>().having((s) => s.isMakingOffer, 'isMakingOffer', true),
          isA<MarketplaceState>()
              .having((s) => s.isMakingOffer, 'isMakingOffer', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );
    });

    group('ClearMessages', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'clears all messages',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(
          errorMessage: 'error',
          successMessage: 'success',
          reportSuccessMessage: 'reported',
        ),
        act: (bloc) => bloc.add(const MarketplaceEvent.clearMessages()),
        expect: () => [
          isA<MarketplaceState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull)
              .having((s) => s.reportSuccessMessage, 'reportSuccessMessage', isNull),
        ],
      );
    });

    group('LoadSavedItems', () {
      blocTest<MarketplaceBloc, MarketplaceState>(
        'double-submit guard prevents concurrent loads',
        build: () => buildBloc(),
        seed: () => const MarketplaceState(isLoadingSaved: true),
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSavedItems()),
        expect: () => [],
      );

      blocTest<MarketplaceBloc, MarketplaceState>(
        'emits saved items when loaded successfully',
        build: () {
          when(() => mockSavedRepository.getAll())
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const MarketplaceEvent.loadSavedItems()),
        expect: () => [
          isA<MarketplaceState>().having((s) => s.isLoadingSaved, 'isLoadingSaved', true),
          isA<MarketplaceState>()
              .having((s) => s.isLoadingSaved, 'isLoadingSaved', false)
              .having((s) => s.savedItems, 'savedItems', isEmpty),
        ],
      );
    });
  });
}
