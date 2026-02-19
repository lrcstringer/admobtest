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
  late WalletBloc walletBloc;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
    walletBloc = WalletBloc(mockWalletRepository);
  });

  tearDown(() {
    walletBloc.close();
  });

  // ============================================================
  // RefreshLedger
  // ============================================================
  group('RefreshLedger', () {
    blocTest<WalletBloc, WalletState>(
      'refreshes all data (account, journals, stats, sub-accounts) on success',
      build: () {
        when(() => mockWalletRepository.getLedgerAccount())
            .thenAnswer((_) async => Right(TestData.testLedgerAccount));
        when(() => mockWalletRepository.getLedgerJournals(
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => Right(TestData.ledgerJournalList));
        when(() => mockWalletRepository.getEngagementStats())
            .thenAnswer((_) async => Right(TestData.growingStreakStats));
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(const WalletEvent.refreshLedger()),
      expect: () => [
        // After account refresh
        isA<WalletState>()
            .having((s) => s.ledgerAccount, 'ledgerAccount',
                TestData.testLedgerAccount),
        // After journals refresh
        isA<WalletState>()
            .having((s) => s.ledgerJournals, 'ledgerJournals',
                TestData.ledgerJournalList)
            .having((s) => s.hasMoreLedgerJournals,
                'hasMoreLedgerJournals', false),
        // After stats refresh
        isA<WalletState>()
            .having((s) => s.engagementStats, 'engagementStats',
                TestData.growingStreakStats),
        // After sub-accounts refresh
        isA<WalletState>()
            .having((s) => s.subAccounts, 'subAccounts',
                TestData.subAccountList),
      ],
      verify: (_) {
        verify(() => mockWalletRepository.getLedgerAccount()).called(1);
        verify(() => mockWalletRepository.getLedgerJournals(limit: 20))
            .called(1);
        verify(() => mockWalletRepository.getEngagementStats()).called(1);
        verify(() => mockWalletRepository.getSubAccounts()).called(1);
      },
    );

    blocTest<WalletBloc, WalletState>(
      'handles account refresh failure gracefully and still refreshes others',
      build: () {
        when(() => mockWalletRepository.getLedgerAccount())
            .thenAnswer((_) async => const Left(Failure.network()));
        when(() => mockWalletRepository.getLedgerJournals(
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => Right(TestData.ledgerJournalList));
        when(() => mockWalletRepository.getEngagementStats())
            .thenAnswer((_) async => Right(TestData.growingStreakStats));
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(const WalletEvent.refreshLedger()),
      expect: () => [
        // Account failed silently, journals still updated
        isA<WalletState>()
            .having((s) => s.ledgerJournals, 'ledgerJournals',
                TestData.ledgerJournalList),
        // Stats still updated
        isA<WalletState>()
            .having((s) => s.engagementStats, 'engagementStats',
                TestData.growingStreakStats),
        // Sub-accounts still updated
        isA<WalletState>()
            .having((s) => s.subAccounts, 'subAccounts',
                TestData.subAccountList),
      ],
      verify: (_) {
        verify(() => mockWalletRepository.getLedgerAccount()).called(1);
        verify(() => mockWalletRepository.getLedgerJournals(limit: 20))
            .called(1);
        verify(() => mockWalletRepository.getEngagementStats()).called(1);
        verify(() => mockWalletRepository.getSubAccounts()).called(1);
      },
    );

    blocTest<WalletBloc, WalletState>(
      'handles journals refresh failure gracefully',
      build: () {
        when(() => mockWalletRepository.getLedgerAccount())
            .thenAnswer((_) async => Right(TestData.testLedgerAccount));
        when(() => mockWalletRepository.getLedgerJournals(
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => const Left(Failure.network()));
        when(() => mockWalletRepository.getEngagementStats())
            .thenAnswer((_) async => Right(TestData.growingStreakStats));
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(const WalletEvent.refreshLedger()),
      expect: () => [
        // Account updated
        isA<WalletState>()
            .having((s) => s.ledgerAccount, 'ledgerAccount',
                TestData.testLedgerAccount),
        // Journals failed silently, stats updated
        isA<WalletState>()
            .having((s) => s.engagementStats, 'engagementStats',
                TestData.growingStreakStats),
        // Sub-accounts updated
        isA<WalletState>()
            .having((s) => s.subAccounts, 'subAccounts',
                TestData.subAccountList),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'handles stats refresh failure gracefully',
      build: () {
        when(() => mockWalletRepository.getLedgerAccount())
            .thenAnswer((_) async => Right(TestData.testLedgerAccount));
        when(() => mockWalletRepository.getLedgerJournals(
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => Right(TestData.ledgerJournalList));
        when(() => mockWalletRepository.getEngagementStats())
            .thenAnswer((_) async => const Left(Failure.network()));
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(const WalletEvent.refreshLedger()),
      expect: () => [
        // Account updated
        isA<WalletState>()
            .having((s) => s.ledgerAccount, 'ledgerAccount',
                TestData.testLedgerAccount),
        // Journals updated
        isA<WalletState>()
            .having((s) => s.ledgerJournals, 'ledgerJournals',
                TestData.ledgerJournalList),
        // Stats failed silently, sub-accounts updated
        isA<WalletState>()
            .having((s) => s.subAccounts, 'subAccounts',
                TestData.subAccountList),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'handles sub-accounts refresh failure gracefully',
      build: () {
        when(() => mockWalletRepository.getLedgerAccount())
            .thenAnswer((_) async => Right(TestData.testLedgerAccount));
        when(() => mockWalletRepository.getLedgerJournals(
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => Right(TestData.ledgerJournalList));
        when(() => mockWalletRepository.getEngagementStats())
            .thenAnswer((_) async => Right(TestData.growingStreakStats));
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => const Left(Failure.network()));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(const WalletEvent.refreshLedger()),
      expect: () => [
        // Account updated
        isA<WalletState>()
            .having((s) => s.ledgerAccount, 'ledgerAccount',
                TestData.testLedgerAccount),
        // Journals updated
        isA<WalletState>()
            .having((s) => s.ledgerJournals, 'ledgerJournals',
                TestData.ledgerJournalList),
        // Stats updated
        isA<WalletState>()
            .having((s) => s.engagementStats, 'engagementStats',
                TestData.growingStreakStats),
        // Sub-accounts failed silently — no more emissions
      ],
    );
  });

  // ============================================================
  // EngagementStatsUpdated
  // ============================================================
  group('EngagementStatsUpdated', () {
    blocTest<WalletBloc, WalletState>(
      'updates engagementStats in state',
      build: () => WalletBloc(mockWalletRepository),
      act: (bloc) => bloc.add(
        WalletEvent.engagementStatsUpdated(TestData.growingStreakStats),
      ),
      expect: () => [
        isA<WalletState>().having(
          (s) => s.engagementStats,
          'engagementStats',
          TestData.growingStreakStats,
        ),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'replaces existing engagementStats in state',
      build: () => WalletBloc(mockWalletRepository),
      seed: () => WalletState(engagementStats: TestData.noStreakStats),
      act: (bloc) => bloc.add(
        WalletEvent.engagementStatsUpdated(TestData.masterStreakStats),
      ),
      expect: () => [
        isA<WalletState>().having(
          (s) => s.engagementStats,
          'engagementStats',
          TestData.masterStreakStats,
        ),
      ],
    );
  });

  // ============================================================
  // LoadSubAccounts
  // ============================================================
  group('LoadSubAccounts', () {
    blocTest<WalletBloc, WalletState>(
      'loads sub-accounts on success',
      build: () {
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(const WalletEvent.loadSubAccounts()),
      expect: () => [
        isA<WalletState>().having(
          (s) => s.subAccounts,
          'subAccounts',
          TestData.subAccountList,
        ),
      ],
      verify: (_) {
        verify(() => mockWalletRepository.getSubAccounts()).called(1);
      },
    );

    blocTest<WalletBloc, WalletState>(
      'handles failure silently (no state change)',
      build: () {
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => const Left(Failure.network()));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(const WalletEvent.loadSubAccounts()),
      expect: () => [],
      verify: (_) {
        verify(() => mockWalletRepository.getSubAccounts()).called(1);
      },
    );
  });

  // ============================================================
  // SubAccountsUpdated
  // ============================================================
  group('SubAccountsUpdated', () {
    blocTest<WalletBloc, WalletState>(
      'updates subAccounts list in state',
      build: () => WalletBloc(mockWalletRepository),
      act: (bloc) => bloc.add(
        WalletEvent.subAccountsUpdated(TestData.subAccountList),
      ),
      expect: () => [
        isA<WalletState>().having(
          (s) => s.subAccounts,
          'subAccounts',
          TestData.subAccountList,
        ),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'replaces existing subAccounts list in state',
      build: () => WalletBloc(mockWalletRepository),
      seed: () => WalletState(subAccounts: [TestData.defaultSubAccount]),
      act: (bloc) => bloc.add(
        WalletEvent.subAccountsUpdated(TestData.subAccountList),
      ),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.subAccounts.length, 'subAccounts.length', 2),
      ],
    );
  });

  // ============================================================
  // SelectSubAccount
  // ============================================================
  group('SelectSubAccount', () {
    blocTest<WalletBloc, WalletState>(
      'sets selectedSubAccountId in state',
      build: () => WalletBloc(mockWalletRepository),
      act: (bloc) =>
          bloc.add(const WalletEvent.selectSubAccount('sub_default')),
      expect: () => [
        isA<WalletState>().having(
          (s) => s.selectedSubAccountId,
          'selectedSubAccountId',
          'sub_default',
        ),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'changes selectedSubAccountId when already selected',
      build: () => WalletBloc(mockWalletRepository),
      seed: () => const WalletState(selectedSubAccountId: 'sub_default'),
      act: (bloc) =>
          bloc.add(const WalletEvent.selectSubAccount('sub_brand')),
      expect: () => [
        isA<WalletState>().having(
          (s) => s.selectedSubAccountId,
          'selectedSubAccountId',
          'sub_brand',
        ),
      ],
    );
  });

  // ============================================================
  // CreateUserWallet
  // ============================================================
  group('CreateUserWallet', () {
    blocTest<WalletBloc, WalletState>(
      'success: sets isTransferring then shows successMessage',
      build: () {
        when(() => mockWalletRepository.createUserWallet(
              name: any(named: 'name'),
            )).thenAnswer((_) async => const Right('new_wallet_id'));
        // loadSubAccounts is dispatched on success
        when(() => mockWalletRepository.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(
        const WalletEvent.createUserWallet(name: 'Groceries'),
      ),
      expect: () => [
        // First emission: isTransferring = true, errorMessage = null
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true)
            .having((s) => s.errorMessage, 'errorMessage', isNull),
        // Second emission: isTransferring = false, successMessage set
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having((s) => s.successMessage, 'successMessage',
                'Wallet "Groceries" created'),
        // Third emission: sub-accounts refreshed
        isA<WalletState>()
            .having((s) => s.subAccounts, 'subAccounts',
                TestData.subAccountList),
      ],
      verify: (_) {
        verify(() => mockWalletRepository.createUserWallet(name: 'Groceries'))
            .called(1);
      },
    );

    blocTest<WalletBloc, WalletState>(
      'failure: sets isTransferring then shows errorMessage',
      build: () {
        when(() => mockWalletRepository.createUserWallet(
              name: any(named: 'name'),
            )).thenAnswer(
            (_) async => const Left(Failure.serverError(message: 'Duplicate name')));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(
        const WalletEvent.createUserWallet(name: 'Groceries'),
      ),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true)
            .having((s) => s.errorMessage, 'errorMessage', isNull),
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having((s) => s.errorMessage, 'errorMessage', 'Duplicate name'),
      ],
    );
  });

  // ============================================================
  // TransferBetweenWallets
  // ============================================================
  group('TransferBetweenWallets', () {
    blocTest<WalletBloc, WalletState>(
      'success: sets isTransferring then shows successMessage',
      build: () {
        when(() => mockWalletRepository.transferBetweenWallets(
              fromSubAccountId: any(named: 'fromSubAccountId'),
              toSubAccountId: any(named: 'toSubAccountId'),
              amount: any(named: 'amount'),
            )).thenAnswer((_) async => const Right(null));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(
        const WalletEvent.transferBetweenWallets(
          fromSubAccountId: 'sub_default',
          toSubAccountId: 'sub_brand',
          amount: 500,
        ),
      ),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true),
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having(
                (s) => s.successMessage, 'successMessage', 'Transfer complete'),
      ],
      verify: (_) {
        verify(() => mockWalletRepository.transferBetweenWallets(
              fromSubAccountId: 'sub_default',
              toSubAccountId: 'sub_brand',
              amount: 500,
            )).called(1);
      },
    );

    blocTest<WalletBloc, WalletState>(
      'failure: sets isTransferring then shows errorMessage',
      build: () {
        when(() => mockWalletRepository.transferBetweenWallets(
              fromSubAccountId: any(named: 'fromSubAccountId'),
              toSubAccountId: any(named: 'toSubAccountId'),
              amount: any(named: 'amount'),
            )).thenAnswer(
            (_) async => const Left(Failure.insufficientBalance()));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(
        const WalletEvent.transferBetweenWallets(
          fromSubAccountId: 'sub_default',
          toSubAccountId: 'sub_brand',
          amount: 999999,
        ),
      ),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true),
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having((s) => s.errorMessage, 'errorMessage',
                'Insufficient balance for this transaction.'),
      ],
    );
  });

  // ============================================================
  // SendP2PTransfer
  // ============================================================
  group('SendP2PTransfer', () {
    blocTest<WalletBloc, WalletState>(
      'success: sets isTransferring then shows successMessage',
      build: () {
        when(() => mockWalletRepository.sendP2PTransfer(
              recipientUserId: any(named: 'recipientUserId'),
              amount: any(named: 'amount'),
              subAccountId: any(named: 'subAccountId'),
              note: any(named: 'note'),
            )).thenAnswer((_) async => const Right(null));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(
        const WalletEvent.sendP2PTransfer(
          recipientUserId: 'user456',
          amount: 100,
          subAccountId: 'sub_default',
          note: 'Thanks!',
        ),
      ),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true),
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having((s) => s.successMessage, 'successMessage',
                'Transfer sent successfully'),
      ],
      verify: (_) {
        verify(() => mockWalletRepository.sendP2PTransfer(
              recipientUserId: 'user456',
              amount: 100,
              subAccountId: 'sub_default',
              note: 'Thanks!',
            )).called(1);
      },
    );

    blocTest<WalletBloc, WalletState>(
      'success without note',
      build: () {
        when(() => mockWalletRepository.sendP2PTransfer(
              recipientUserId: any(named: 'recipientUserId'),
              amount: any(named: 'amount'),
              subAccountId: any(named: 'subAccountId'),
              note: any(named: 'note'),
            )).thenAnswer((_) async => const Right(null));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(
        const WalletEvent.sendP2PTransfer(
          recipientUserId: 'user456',
          amount: 50,
          subAccountId: 'sub_default',
        ),
      ),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true),
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having((s) => s.successMessage, 'successMessage',
                'Transfer sent successfully'),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'failure: sets isTransferring then shows errorMessage',
      build: () {
        when(() => mockWalletRepository.sendP2PTransfer(
              recipientUserId: any(named: 'recipientUserId'),
              amount: any(named: 'amount'),
              subAccountId: any(named: 'subAccountId'),
              note: any(named: 'note'),
            )).thenAnswer(
            (_) async => const Left(Failure.insufficientBalance()));
        return WalletBloc(mockWalletRepository);
      },
      act: (bloc) => bloc.add(
        const WalletEvent.sendP2PTransfer(
          recipientUserId: 'user456',
          amount: 999999,
          subAccountId: 'sub_default',
        ),
      ),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true),
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having((s) => s.errorMessage, 'errorMessage',
                'Insufficient balance for this transaction.'),
      ],
    );
  });

  // ============================================================
  // ClearMessages
  // ============================================================
  group('ClearMessages', () {
    blocTest<WalletBloc, WalletState>(
      'clears errorMessage and successMessage',
      build: () => WalletBloc(mockWalletRepository),
      seed: () => const WalletState(
        errorMessage: 'Some error',
        successMessage: 'Some success',
      ),
      act: (bloc) => bloc.add(const WalletEvent.clearMessages()),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.errorMessage, 'errorMessage', isNull)
            .having((s) => s.successMessage, 'successMessage', isNull),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'clears only errorMessage when successMessage is already null',
      build: () => WalletBloc(mockWalletRepository),
      seed: () => const WalletState(errorMessage: 'Error only'),
      act: (bloc) => bloc.add(const WalletEvent.clearMessages()),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.errorMessage, 'errorMessage', isNull)
            .having((s) => s.successMessage, 'successMessage', isNull),
      ],
    );
  });

  // ============================================================
  // WalletState getters (pure state tests, no BLoC needed)
  // ============================================================
  group('WalletState getters', () {
    group('mainWalletAvailable', () {
      test('returns 0 when ledgerAccount is null', () {
        const state = WalletState();
        expect(state.mainWalletAvailable, 0);
      });

      test('returns correct value when account exists with no allocation', () {
        final state =
            WalletState(ledgerAccount: TestData.testLedgerAccount);
        // testLedgerAccount has balance=10000, allocatedBalance=0 (default)
        expect(state.mainWalletAvailable, 10000);
      });

      test('accounts for allocated balance', () {
        final state =
            WalletState(ledgerAccount: TestData.accountWithAllocation);
        // accountWithAllocation has balance=20000, allocatedBalance=5000
        expect(state.mainWalletAvailable, 15000);
      });
    });

    group('balanceZar', () {
      test('returns 0.0 when ledgerAccount is null', () {
        const state = WalletState();
        expect(state.balanceZar, 0.0);
      });

      test('converts correctly (10000 tokens = R100.0)', () {
        final state =
            WalletState(ledgerAccount: TestData.testLedgerAccount);
        // testLedgerAccount has balance=10000
        expect(state.balanceZar, 100.0);
      });

      test('converts 500000 tokens = R5000.0', () {
        final state =
            WalletState(ledgerAccount: TestData.richLedgerAccount);
        // richLedgerAccount has balance=500000
        expect(state.balanceZar, 5000.0);
      });
    });

    group('currentStreak', () {
      test('returns 0 when engagementStats is null', () {
        const state = WalletState();
        expect(state.currentStreak, 0);
      });

      test('returns correct value when stats loaded', () {
        final state =
            WalletState(engagementStats: TestData.growingStreakStats);
        expect(state.currentStreak, 5);
      });
    });

    group('longestStreak', () {
      test('returns 0 when engagementStats is null', () {
        const state = WalletState();
        expect(state.longestStreak, 0);
      });

      test('returns correct value when stats loaded', () {
        final state =
            WalletState(engagementStats: TestData.masterStreakStats);
        // masterStreakStats has longestStreak=14
        expect(state.longestStreak, 14);
      });
    });

    group('streakMultiplier', () {
      test('returns 1.0 when engagementStats is null', () {
        const state = WalletState();
        expect(state.streakMultiplier, 1.0);
      });

      test('returns 1.0 for no streak (days 0)', () {
        final state =
            WalletState(engagementStats: TestData.noStreakStats);
        expect(state.streakMultiplier, 1.0);
      });

      test('returns 1.0 for starter streak (days 1-2)', () {
        final state =
            WalletState(engagementStats: TestData.starterStreakStats);
        // starterStreakStats has currentStreak=2
        expect(state.streakMultiplier, 1.0);
      });

      test('returns 1.2 for growing streak (days 3-6)', () {
        final state =
            WalletState(engagementStats: TestData.growingStreakStats);
        // growingStreakStats has currentStreak=5
        expect(state.streakMultiplier, 1.2);
      });

      test('returns 1.35 for strong streak (days 7-9)', () {
        final state =
            WalletState(engagementStats: TestData.strongStreakStats);
        // strongStreakStats has currentStreak=8
        expect(state.streakMultiplier, 1.35);
      });

      test('returns 1.5 for master streak (days 10+)', () {
        final state =
            WalletState(engagementStats: TestData.masterStreakStats);
        // masterStreakStats has currentStreak=14
        expect(state.streakMultiplier, 1.5);
      });
    });

    group('totalTokensEarned', () {
      test('returns 0 when engagementStats is null', () {
        const state = WalletState();
        expect(state.totalTokensEarned, 0);
      });

      test('returns correct value when stats loaded', () {
        final state =
            WalletState(engagementStats: TestData.growingStreakStats);
        // growingStreakStats has totalTokensEarned=5000
        expect(state.totalTokensEarned, 5000);
      });
    });

    group('selectedSubAccount', () {
      test('returns null when no selection', () {
        final state = WalletState(subAccounts: TestData.subAccountList);
        expect(state.selectedSubAccount, isNull);
      });

      test('returns matching sub-account when id found', () {
        final state = WalletState(
          subAccounts: TestData.subAccountList,
          selectedSubAccountId: 'sub_default',
        );
        expect(state.selectedSubAccount, TestData.defaultSubAccount);
      });

      test('returns null when id not found in list', () {
        final state = WalletState(
          subAccounts: TestData.subAccountList,
          selectedSubAccountId: 'nonexistent_id',
        );
        expect(state.selectedSubAccount, isNull);
      });

      test('returns null when subAccounts is empty', () {
        const state = WalletState(
          selectedSubAccountId: 'sub_default',
        );
        expect(state.selectedSubAccount, isNull);
      });
    });

    group('brandSubAccounts', () {
      test('returns only restricted sub-accounts', () {
        final state = WalletState(subAccounts: TestData.subAccountList);
        // subAccountList has defaultSubAccount (unrestricted) and brandSubAccount (restricted)
        expect(state.brandSubAccounts.length, 1);
        expect(state.brandSubAccounts.first, TestData.brandSubAccount);
      });

      test('returns empty list when no sub-accounts', () {
        const state = WalletState();
        expect(state.brandSubAccounts, isEmpty);
      });

      test('returns empty list when no restricted sub-accounts', () {
        final state = WalletState(
          subAccounts: [TestData.defaultSubAccount],
        );
        expect(state.brandSubAccounts, isEmpty);
      });
    });

    group('portfolioBalance', () {
      test('equals balance (same as ledger balance)', () {
        final state =
            WalletState(ledgerAccount: TestData.testLedgerAccount);
        expect(state.portfolioBalance, state.balance);
        expect(state.portfolioBalance, 10000);
      });

      test('returns 0 when ledgerAccount is null', () {
        const state = WalletState();
        expect(state.portfolioBalance, 0);
      });
    });

    group('portfolioBalanceZar', () {
      test('converts correctly (same as balanceZar)', () {
        final state =
            WalletState(ledgerAccount: TestData.testLedgerAccount);
        // 10000 tokens / 100 = R100.0
        expect(state.portfolioBalanceZar, 100.0);
        expect(state.portfolioBalanceZar, state.balanceZar);
      });

      test('returns 0.0 when ledgerAccount is null', () {
        const state = WalletState();
        expect(state.portfolioBalanceZar, 0.0);
      });
    });
  });
}
