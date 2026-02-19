import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/sub_account.dart';
import 'package:imalichat/domain/repositories/wallet_repository.dart';
import 'package:imalichat/presentation/blocs/wallet/wallet_bloc.dart';

import '../helpers/test_helpers.dart';

// =============================================================================
// MOCK CLASSES
// =============================================================================

class MockWalletRepository extends Mock implements WalletRepository {}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late MockWalletRepository mockRepo;

  setUp(() {
    mockRepo = MockWalletRepository();

    // Default stubs for stream methods that LoadLedger triggers automatically.
    // These prevent MissingStubError when the BLoC fires watch* events.
    when(() => mockRepo.watchLedgerAccount())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchLedgerJournals(limit: any(named: 'limit')))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchEngagementStats())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchSubAccounts())
        .thenAnswer((_) => const Stream.empty());
  });

  group('Wallet Integration Flows', () {
    // =========================================================================
    // 1. Load wallet - loadLedger loads account, journals, stats, sub-accounts
    // =========================================================================
    blocTest<WalletBloc, WalletState>(
      '1. Load wallet - loadLedger loads account, journals, stats, and sub-accounts',
      build: () {
        when(() => mockRepo.getLedgerAccount())
            .thenAnswer((_) async => Right(TestData.testLedgerAccount));
        when(() => mockRepo.getLedgerJournals(limit: any(named: 'limit')))
            .thenAnswer((_) async => Right(TestData.ledgerJournalList));
        when(() => mockRepo.getEngagementStats())
            .thenAnswer((_) async => Right(TestData.growingStreakStats));
        when(() => mockRepo.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        return WalletBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const WalletEvent.loadLedger()),
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        final s = bloc.state;
        expect(s.status, WalletStatus.loaded);
        expect(s.ledgerAccount, TestData.testLedgerAccount);
        expect(s.ledgerJournals, TestData.ledgerJournalList);
        expect(s.subAccounts, TestData.subAccountList);
        // Engagement stats come from the watchEngagementStats stream or
        // the loadLedger flow; with empty streams the one-shot calls
        // populate journals and sub-accounts. Stats are populated via stream.
        // Since watchEngagementStats emits nothing, stats will be null here
        // unless we also wire up getEngagementStats (which RefreshLedger uses).
        // LoadLedger does NOT call getEngagementStats directly - it watches.
        // So we verify the fields that LoadLedger does populate directly.
        expect(s.balance, TestData.testLedgerAccount.balance);
        expect(s.mainWalletAvailable,
            TestData.testLedgerAccount.mainWalletAvailable);
      },
    );

    // =========================================================================
    // 2. Refresh cycle - loadLedger then refreshLedger updates data
    // =========================================================================
    blocTest<WalletBloc, WalletState>(
      '2. Refresh cycle - loadLedger then refreshLedger updates data',
      build: () {
        final updatedAccount = TestData.richLedgerAccount;
        final updatedJournals = [TestData.potWinJournal];
        final updatedStats = TestData.masterStreakStats;
        final updatedSubs = [TestData.defaultSubAccount];

        var loadCount = 0;
        when(() => mockRepo.getLedgerAccount()).thenAnswer((_) async {
          loadCount++;
          if (loadCount == 1) return Right(TestData.testLedgerAccount);
          return Right(updatedAccount);
        });
        when(() => mockRepo.getLedgerJournals(limit: any(named: 'limit')))
            .thenAnswer((_) async {
          if (loadCount <= 1) return Right(TestData.ledgerJournalList);
          return Right(updatedJournals);
        });
        when(() => mockRepo.getEngagementStats())
            .thenAnswer((_) async => Right(updatedStats));
        when(() => mockRepo.getSubAccounts()).thenAnswer((_) async {
          if (loadCount <= 1) return Right(TestData.subAccountList);
          return Right(updatedSubs);
        });
        return WalletBloc(mockRepo);
      },
      act: (bloc) async {
        bloc.add(const WalletEvent.loadLedger());
        await Future.delayed(const Duration(milliseconds: 200));
        bloc.add(const WalletEvent.refreshLedger());
        await Future.delayed(const Duration(milliseconds: 200));
      },
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        final s = bloc.state;
        // After refresh the state should reflect updated data
        expect(s.ledgerAccount, TestData.richLedgerAccount);
        expect(s.ledgerJournals, [TestData.potWinJournal]);
        expect(s.engagementStats, TestData.masterStreakStats);
        expect(s.subAccounts, [TestData.defaultSubAccount]);
      },
    );

    // =========================================================================
    // 3. Create wallet then select it
    // =========================================================================
    blocTest<WalletBloc, WalletState>(
      '3. Create wallet then load sub-accounts then select one',
      build: () {
        final newSub = SubAccount(
          id: 'sub_new',
          userId: 'user123',
          name: 'Groceries',
          balance: 0,
          lifetimeCredits: 0,
          lifetimeDebits: 0,
          isActive: true,
          isDefault: false,
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 1),
        );
        when(() => mockRepo.createUserWallet(name: any(named: 'name')))
            .thenAnswer((_) async => const Right('sub_new'));
        when(() => mockRepo.getSubAccounts()).thenAnswer(
            (_) async => Right([...TestData.subAccountList, newSub]));
        return WalletBloc(mockRepo);
      },
      act: (bloc) async {
        bloc.add(const WalletEvent.createUserWallet(name: 'Groceries'));
        await Future.delayed(const Duration(milliseconds: 200));
        // createUserWallet auto-triggers loadSubAccounts on success
        bloc.add(const WalletEvent.selectSubAccount('sub_new'));
        await Future.delayed(const Duration(milliseconds: 50));
      },
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        final s = bloc.state;
        expect(s.isTransferring, false);
        expect(s.successMessage, 'Wallet "Groceries" created');
        expect(s.subAccounts.length, 3);
        expect(s.selectedSubAccountId, 'sub_new');
        expect(s.selectedSubAccount, isNotNull);
        expect(s.selectedSubAccount!.name, 'Groceries');
      },
    );

    // =========================================================================
    // 4. Transfer flow - transfer then verify isTransferring cycle
    // =========================================================================
    blocTest<WalletBloc, WalletState>(
      '4. Transfer flow - transferBetweenWallets sets isTransferring then clears with success',
      seed: () => WalletState(
        status: WalletStatus.loaded,
        ledgerAccount: TestData.testLedgerAccount,
        subAccounts: TestData.subAccountList,
      ),
      build: () {
        when(() => mockRepo.transferBetweenWallets(
              fromSubAccountId: any(named: 'fromSubAccountId'),
              toSubAccountId: any(named: 'toSubAccountId'),
              amount: any(named: 'amount'),
            )).thenAnswer((_) async => const Right(null));
        return WalletBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const WalletEvent.transferBetweenWallets(
        fromSubAccountId: 'sub_default',
        toSubAccountId: 'sub_brand',
        amount: 500,
      )),
      expect: () => [
        // isTransferring = true
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true),
        // isTransferring = false, successMessage set
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having(
                (s) => s.successMessage, 'successMessage', 'Transfer complete'),
      ],
    );

    // =========================================================================
    // 5. P2P transfer flow
    // =========================================================================
    blocTest<WalletBloc, WalletState>(
      '5. P2P transfer flow - sendP2PTransfer sets isTransferring then clears with success',
      seed: () => WalletState(
        status: WalletStatus.loaded,
        ledgerAccount: TestData.testLedgerAccount,
      ),
      build: () {
        when(() => mockRepo.sendP2PTransfer(
              recipientUserId: any(named: 'recipientUserId'),
              amount: any(named: 'amount'),
              subAccountId: any(named: 'subAccountId'),
              note: any(named: 'note'),
            )).thenAnswer((_) async => const Right(null));
        return WalletBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const WalletEvent.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 200,
        subAccountId: 'sub_default',
        note: 'Thanks!',
      )),
      expect: () => [
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', true),
        isA<WalletState>()
            .having((s) => s.isTransferring, 'isTransferring', false)
            .having((s) => s.successMessage, 'successMessage',
                'Transfer sent successfully'),
      ],
    );

    // =========================================================================
    // 6. Cashout eligibility - account with 5000+ tokens and active
    // =========================================================================
    test(
        '6. Cashout eligibility - account with 5000+ tokens and active => canCashout true',
        () {
      // testLedgerAccount has balance=10000, allocatedBalance=0, active
      // mainWalletAvailable = 10000 - 0 = 10000 >= 5000
      final state = WalletState(
        status: WalletStatus.loaded,
        ledgerAccount: TestData.testLedgerAccount,
      );
      expect(state.canCashout, true);
      expect(state.balance, 10000);
      expect(state.mainWalletAvailable, 10000);
      expect(state.balanceZar, 100.0); // 10000 / 100 = R100
    });

    // =========================================================================
    // 7. Cashout ineligible - account with <5000 tokens
    // =========================================================================
    test('7. Cashout ineligible - account with <5000 tokens => canCashout false',
        () {
      // poorLedgerAccount has balance=1000, active
      final state = WalletState(
        status: WalletStatus.loaded,
        ledgerAccount: TestData.poorLedgerAccount,
      );
      expect(state.canCashout, false);
      expect(state.mainWalletAvailable, 1000);
      expect(state.balanceZar, 10.0); // 1000 / 100 = R10
    });

    // =========================================================================
    // 8. Frozen account cannot cashout
    // =========================================================================
    test('8. Frozen account cannot cashout even with sufficient balance', () {
      // frozenLedgerAccount has balance=50000, status=frozen
      final state = WalletState(
        status: WalletStatus.loaded,
        ledgerAccount: TestData.frozenLedgerAccount,
      );
      expect(state.canCashout, false);
      expect(state.balance, 50000);
      expect(state.mainWalletAvailable, 50000);
      // isActive is false because status is frozen
      expect(state.ledgerAccount!.isActive, false);
    });

    // =========================================================================
    // 9. Streak progression updates correctly
    // =========================================================================
    blocTest<WalletBloc, WalletState>(
      '9. Streak progression - engagementStatsUpdated updates streak fields',
      build: () => WalletBloc(mockRepo),
      act: (bloc) async {
        // Start with no streak
        bloc.add(
            WalletEvent.engagementStatsUpdated(TestData.noStreakStats));
        await Future.delayed(const Duration(milliseconds: 50));
        // Progress to growing streak
        bloc.add(
            WalletEvent.engagementStatsUpdated(TestData.growingStreakStats));
        await Future.delayed(const Duration(milliseconds: 50));
        // Progress to master streak
        bloc.add(
            WalletEvent.engagementStatsUpdated(TestData.masterStreakStats));
        await Future.delayed(const Duration(milliseconds: 50));
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final s = bloc.state;
        // Final state should reflect master streak
        expect(s.currentStreak, 14);
        expect(s.longestStreak, 14);
        expect(s.streakMultiplier, 1.5);
        expect(s.totalTokensEarned, 14000);
        expect(s.engagementStats!.streakTierName, 'Master');
        expect(s.engagementStats!.multiplierDisplay, '+50%');
      },
    );

    // =========================================================================
    // 10. Error recovery - load failure then refresh success
    // =========================================================================
    blocTest<WalletBloc, WalletState>(
      '10. Error recovery - loadLedger fails then refreshLedger succeeds',
      build: () {
        var callCount = 0;
        when(() => mockRepo.getLedgerAccount()).thenAnswer((_) async {
          callCount++;
          if (callCount == 1) {
            return const Left(Failure.serverError());
          }
          return Right(TestData.testLedgerAccount);
        });
        // LoadLedger also triggers loadLedgerJournals + loadSubAccounts
        when(() => mockRepo.getLedgerJournals(limit: any(named: 'limit')))
            .thenAnswer((_) async => Right(TestData.ledgerJournalList));
        when(() => mockRepo.getSubAccounts())
            .thenAnswer((_) async => Right(TestData.subAccountList));
        when(() => mockRepo.getEngagementStats())
            .thenAnswer((_) async => Right(TestData.growingStreakStats));
        return WalletBloc(mockRepo);
      },
      act: (bloc) async {
        // First: loadLedger fails (getLedgerAccount returns Left)
        bloc.add(const WalletEvent.loadLedger());
        await Future.delayed(const Duration(milliseconds: 200));
        // Then: refreshLedger succeeds
        bloc.add(const WalletEvent.refreshLedger());
        await Future.delayed(const Duration(milliseconds: 200));
      },
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        final s = bloc.state;
        // After successful refresh, account should be populated
        expect(s.ledgerAccount, TestData.testLedgerAccount);
        expect(s.ledgerJournals, TestData.ledgerJournalList);
        expect(s.engagementStats, TestData.growingStreakStats);
        expect(s.subAccounts, TestData.subAccountList);
        // The error from the first load should have been in a transient state
        // After refresh succeeds the state has valid data
        expect(s.balance, 10000);
      },
    );
  });
}
