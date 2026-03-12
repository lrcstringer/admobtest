import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/domain/repositories/buy_repository.dart';
import 'package:imalichat/presentation/blocs/buy_tab/buy_tab_bloc.dart';

class MockBuyRepository extends Mock implements BuyRepository {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockBuyRepository mockBuyRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockBuyRepository = MockBuyRepository();
    mockNetworkInfo = MockNetworkInfo();
  });

  BuyTabBloc buildBloc() => BuyTabBloc(mockBuyRepository, mockNetworkInfo);

  void stubAllRepositoryCalls() {
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockBuyRepository.getCachedCategories()).thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getCachedRegulars()).thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getCachedFeaturedItems()).thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getBuyCategories()).thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getBuyRegulars()).thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getFeaturedItems()).thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getBrandStorefronts()).thenAnswer((_) async => const Right([]));
    when(() => mockBuyRepository.getMarketplaceStats()).thenAnswer((_) async => const Right((listingCount: 0, sellerCount: 0, thumbnails: <String>[])));
  }

  group('BuyTabBloc', () {
    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state.isLoading, false);
      expect(bloc.state.categories, isEmpty);
      expect(bloc.state.featuredItems, isEmpty);
      bloc.close();
    });

    group('LoadBuyTab', () {
      blocTest<BuyTabBloc, BuyTabState>(
        'emits [loading, loaded] when all data loads successfully',
        build: () {
          stubAllRepositoryCalls();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          // Cached results may emit intermediate states
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true).having((s) => s.isOffline, 'isOffline', false),
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', false),
        ],
        verify: (_) {
          verify(() => mockBuyRepository.getBuyCategories()).called(1);
          verify(() => mockBuyRepository.getBuyRegulars()).called(1);
          verify(() => mockBuyRepository.getFeaturedItems()).called(1);
        },
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'emits offline state when not connected',
        build: () {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          when(() => mockBuyRepository.getCachedCategories()).thenAnswer((_) async => const Right([]));
          when(() => mockBuyRepository.getCachedRegulars()).thenAnswer((_) async => const Right([]));
          when(() => mockBuyRepository.getCachedFeaturedItems()).thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.isOffline, 'isOffline', true),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'emits error when categories fail',
        build: () {
          stubAllRepositoryCalls();
          when(() => mockBuyRepository.getBuyCategories())
              .thenAnswer((_) async => const Left(Failure.network(message: 'Failed')));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.loadBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true),
          isA<BuyTabState>().having((s) => s.isLoading, 'isLoading', true).having((s) => s.isOffline, 'isOffline', false),
          isA<BuyTabState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('RefreshBuyTab', () {
      blocTest<BuyTabBloc, BuyTabState>(
        'emits [refreshing, refreshed] when successful',
        build: () {
          stubAllRepositoryCalls();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.refreshBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isRefreshing, 'isRefreshing', true),
          isA<BuyTabState>().having((s) => s.isRefreshing, 'isRefreshing', false),
        ],
      );

      blocTest<BuyTabBloc, BuyTabState>(
        'emits offline when not connected on refresh',
        build: () {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          return buildBloc();
        },
        act: (bloc) => bloc.add(const BuyTabEvent.refreshBuyTab()),
        expect: () => [
          isA<BuyTabState>().having((s) => s.isRefreshing, 'isRefreshing', true),
          isA<BuyTabState>()
              .having((s) => s.isRefreshing, 'isRefreshing', false)
              .having((s) => s.isOffline, 'isOffline', true),
        ],
      );
    });
  });
}
