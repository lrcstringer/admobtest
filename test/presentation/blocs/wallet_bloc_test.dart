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

    // Default stubs for methods that WalletBloc may call during event handling.
    // Individual tests can override these with more specific stubs.
    when(() => mockWalletRepository.getSubAccounts())
        .thenAnswer((_) async => const Right([]));
    when(() => mockWalletRepository.watchSubAccounts())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockWalletRepository.watchLedgerAccount())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockWalletRepository.watchLedgerJournals(limit: any(named: 'limit')))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockWalletRepository.watchEngagementStats())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockWalletRepository.getEngagementStats())
        .thenAnswer((_) async => Right(TestData.noStreakStats));
    when(() => mockWalletRepository.getLedgerJournals(
          limit: any(named: 'limit'),
          startAfter: any(named: 'startAfter'),
        )).thenAnswer((_) async => const Right([]));
  });

  group('WalletBloc', () {
    test('initial state is correct', () {
      final bloc = WalletBloc(mockWalletRepository);
      expect(bloc.state.status, WalletStatus.initial);
      expect(bloc.state.ledgerAccount, isNull);
      expect(bloc.state.ledgerJournals, isEmpty);
      expect(bloc.state.engagementStats, isNull);
      bloc.close();
    });

    group('LoadLedger', () {
      blocTest<WalletBloc, WalletState>(
        'emits loading then loaded with account when getLedgerAccount succeeds',
        build: () {
          when(() => mockWalletRepository.getLedgerAccount())
              .thenAnswer((_) async => Right(TestData.testLedgerAccount));
          when(() => mockWalletRepository.watchLedgerAccount())
              .thenAnswer((_) => Stream.value(Right(TestData.testLedgerAccount)));
          when(() => mockWalletRepository.watchLedgerJournals(limit: any(named: 'limit')))
              .thenAnswer((_) => Stream.value(Right(TestData.ledgerJournalList)));
          when(() => mockWalletRepository.watchEngagementStats())
              .thenAnswer((_) => const Stream.empty());
          when(() => mockWalletRepository.getLedgerJournals(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right(TestData.ledgerJournalList));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadLedger()),
        verify: (bloc) {
          verify(() => mockWalletRepository.getLedgerAccount()).called(1);
          expect(bloc.state.status, WalletStatus.loaded);
          expect(bloc.state.ledgerAccount, TestData.testLedgerAccount);
        },
      );

      blocTest<WalletBloc, WalletState>(
        'emits loading then sets errorMessage when getLedgerAccount fails',
        build: () {
          when(() => mockWalletRepository.getLedgerAccount())
              .thenAnswer((_) async => const Left(Failure.network()));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadLedger()),
        verify: (bloc) {
          expect(bloc.state.errorMessage, isNotNull);
        },
      );
    });

    group('LoadLedgerJournals', () {
      blocTest<WalletBloc, WalletState>(
        'loads ledger journals successfully',
        build: () {
          when(() => mockWalletRepository.getLedgerJournals(
                limit: any(named: 'limit'),
              )).thenAnswer((_) async => Right(TestData.ledgerJournalList));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadLedgerJournals()),
        expect: () => [
          isA<WalletState>().having(
            (s) => s.ledgerJournals,
            'ledgerJournals',
            TestData.ledgerJournalList,
          ),
        ],
      );

      blocTest<WalletBloc, WalletState>(
        'sets hasMoreLedgerJournals correctly when less than limit',
        build: () {
          when(() => mockWalletRepository.getLedgerJournals(
                limit: any(named: 'limit'),
              )).thenAnswer((_) async => Right([TestData.earnJournal]));
          return WalletBloc(mockWalletRepository);
        },
        act: (bloc) => bloc.add(const WalletEvent.loadLedgerJournals()),
        expect: () => [
          isA<WalletState>().having((s) => s.hasMoreLedgerJournals, 'hasMoreLedgerJournals', false),
        ],
      );
    });

    group('LoadMoreLedgerJournals', () {
      blocTest<WalletBloc, WalletState>(
        'does nothing when already loading',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => const WalletState(isLoadingMore: true),
        act: (bloc) => bloc.add(const WalletEvent.loadMoreLedgerJournals()),
        expect: () => [],
      );

      blocTest<WalletBloc, WalletState>(
        'does nothing when no more journals',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => const WalletState(hasMoreLedgerJournals: false),
        act: (bloc) => bloc.add(const WalletEvent.loadMoreLedgerJournals()),
        expect: () => [],
      );

      blocTest<WalletBloc, WalletState>(
        'loads more journals when conditions are met',
        build: () {
          when(() => mockWalletRepository.getLedgerJournals(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right([TestData.cashoutJournal]));
          return WalletBloc(mockWalletRepository);
        },
        seed: () => WalletState(
          ledgerJournals: [TestData.earnJournal],
          hasMoreLedgerJournals: true,
        ),
        act: (bloc) => bloc.add(const WalletEvent.loadMoreLedgerJournals()),
        expect: () => [
          isA<WalletState>().having((s) => s.isLoadingMore, 'isLoadingMore', true),
          isA<WalletState>()
              .having((s) => s.isLoadingMore, 'isLoadingMore', false)
              .having((s) => s.ledgerJournals.length, 'ledgerJournals.length', 2),
        ],
      );
    });

    group('LedgerAccountUpdated', () {
      final updatedAccount = TestData.testLedgerAccount.copyWith(balance: 15000);

      blocTest<WalletBloc, WalletState>(
        'updates ledger account in state',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => WalletState(ledgerAccount: TestData.testLedgerAccount),
        act: (bloc) => bloc.add(WalletEvent.ledgerAccountUpdated(updatedAccount)),
        expect: () => [
          isA<WalletState>()
              .having((s) => s.ledgerAccount?.balance, 'balance', 15000),
        ],
      );
    });

    group('LedgerJournalsUpdated', () {
      blocTest<WalletBloc, WalletState>(
        'updates ledger journals in state',
        build: () => WalletBloc(mockWalletRepository),
        seed: () => WalletState(ledgerJournals: [TestData.earnJournal]),
        act: (bloc) => bloc.add(WalletEvent.ledgerJournalsUpdated(TestData.ledgerJournalList)),
        expect: () => [
          isA<WalletState>().having(
            (s) => s.ledgerJournals,
            'ledgerJournals',
            TestData.ledgerJournalList,
          ),
        ],
      );
    });

    group('balance getter', () {
      test('returns 0 when ledgerAccount is null', () {
        const state = WalletState();
        expect(state.balance, 0);
      });

      test('returns ledgerAccount balance when available', () {
        final state = WalletState(ledgerAccount: TestData.testLedgerAccount);
        expect(state.balance, 10000);
      });
    });

    group('canCashout getter', () {
      test('returns false when ledgerAccount is null', () {
        const state = WalletState();
        expect(state.canCashout, false);
      });

      test('returns false when balance is below minimum', () {
        final state = WalletState(ledgerAccount: TestData.poorLedgerAccount);
        expect(state.canCashout, false);
      });

      test('returns true when account is active and balance is sufficient', () {
        final state = WalletState(ledgerAccount: TestData.richLedgerAccount);
        expect(state.canCashout, true);
      });
    });
  });
}
