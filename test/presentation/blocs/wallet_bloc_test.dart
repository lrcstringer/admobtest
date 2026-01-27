import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/wallet_repository.dart';
import 'package:imalichat/presentation/blocs/wallet/wallet_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockWalletRepository extends Mock implements WalletRepository {}

void main() {
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
  });

  group('WalletBloc', () {
    test('initial state is correct', () {
      final bloc = WalletBloc(mockWalletRepository);
      expect(bloc.state.status, WalletStatus.initial);
      expect(bloc.state.wallet, isNull);
      expect(bloc.state.transactions, isEmpty);
      bloc.close();
    });

    group('LoadWallet', () {
      blocTest<WalletBloc, WalletState>(
        'emits [loading, loaded, transactions] when getMainWallet succeeds',
        build: () {
          when(() => mockWalletRepository.getMainWallet())
              .thenAnswer((_) async => Right(TestData.testWallet));
          when(() => mockWalletRepository.watchWallet(any()))
              .thenAnswer((_) => Stream.value(Right(TestData.testWallet)));
          when(() => mockWalletRepository.getTransactions(
                walletId: any(named: 'walletId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) async => Right(TestData.transactionList));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadWallet()),
        expect: () => [
          isA<WalletState>().having((s) => s.status, 'status', WalletStatus.loading),
          isA<WalletState>()
              .having((s) => s.status, 'status', WalletStatus.loaded)
              .having((s) => s.wallet, 'wallet', TestData.testWallet),
          isA<WalletState>()
              .having((s) => s.transactions, 'transactions', TestData.transactionList),
        ],
        verify: (_) {
          verify(() => mockWalletRepository.getMainWallet()).called(1);
        },
      );

      blocTest<WalletBloc, WalletState>(
        'emits [loading, error] when getMainWallet fails',
        build: () {
          when(() => mockWalletRepository.getMainWallet())
              .thenAnswer((_) async => const Left(Failure.network()));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadWallet()),
        expect: () => [
          isA<WalletState>().having((s) => s.status, 'status', WalletStatus.loading),
          isA<WalletState>()
              .having((s) => s.status, 'status', WalletStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('LoadTransactions', () {
      blocTest<WalletBloc, WalletState>(
        'loads transactions successfully',
        build: () {
          when(() => mockWalletRepository.getTransactions(
                walletId: any(named: 'walletId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) async => Right(TestData.transactionList));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadTransactions(walletId: 'wallet123')),
        expect: () => [
          isA<WalletState>().having(
            (s) => s.transactions,
            'transactions',
            TestData.transactionList,
          ),
        ],
      );

      blocTest<WalletBloc, WalletState>(
        'sets hasMoreTransactions correctly when less than limit',
        build: () {
          when(() => mockWalletRepository.getTransactions(
                walletId: any(named: 'walletId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) async => Right([TestData.earnTransaction]));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadTransactions(walletId: 'wallet123')),
        expect: () => [
          isA<WalletState>().having((s) => s.hasMoreTransactions, 'hasMoreTransactions', false),
        ],
      );
    });

    group('LoadMoreTransactions', () {
      blocTest<WalletBloc, WalletState>(
        'does nothing when already loading',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => const WalletState(isLoadingMore: true),
        act: (bloc) => bloc.add(const WalletEvent.loadMoreTransactions()),
        expect: () => [],
      );

      blocTest<WalletBloc, WalletState>(
        'does nothing when no more transactions',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => const WalletState(hasMoreTransactions: false),
        act: (bloc) => bloc.add(const WalletEvent.loadMoreTransactions()),
        expect: () => [],
      );

      blocTest<WalletBloc, WalletState>(
        'does nothing when wallet is null',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => const WalletState(hasMoreTransactions: true),
        act: (bloc) => bloc.add(const WalletEvent.loadMoreTransactions()),
        expect: () => [],
      );

      blocTest<WalletBloc, WalletState>(
        'loads more transactions when conditions are met',
        build: () {
          when(() => mockWalletRepository.getTransactions(
                walletId: any(named: 'walletId'),
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right([TestData.p2pReceiveTransaction]));
          return WalletBloc(mockWalletRepository);
        },
        seed: () => WalletState(
          wallet: TestData.testWallet,
          transactions: [TestData.earnTransaction],
          hasMoreTransactions: true,
        ),
        act: (bloc) => bloc.add(const WalletEvent.loadMoreTransactions()),
        expect: () => [
          isA<WalletState>().having((s) => s.isLoadingMore, 'isLoadingMore', true),
          isA<WalletState>()
              .having((s) => s.isLoadingMore, 'isLoadingMore', false)
              .having((s) => s.transactions.length, 'transactions.length', 2),
        ],
      );
    });

    group('WalletUpdated', () {
      final updatedWallet = TestData.testWallet.copyWith(balanceTokens: 15000);

      blocTest<WalletBloc, WalletState>(
        'updates wallet in state',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => WalletState(wallet: TestData.testWallet),
        act: (bloc) => bloc.add(WalletEvent.walletUpdated(updatedWallet)),
        expect: () => [
          isA<WalletState>()
              .having((s) => s.status, 'status', WalletStatus.loaded)
              .having((s) => s.wallet?.balanceTokens, 'balanceTokens', 15000),
        ],
      );
    });

    group('TransactionsUpdated', () {
      blocTest<WalletBloc, WalletState>(
        'updates transactions in state',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => WalletState(transactions: [TestData.earnTransaction]),
        act: (bloc) => bloc.add(WalletEvent.transactionsUpdated(TestData.transactionList)),
        expect: () => [
          isA<WalletState>().having(
            (s) => s.transactions,
            'transactions',
            TestData.transactionList,
          ),
        ],
      );
    });
  });
}
