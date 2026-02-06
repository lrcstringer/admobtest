import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/earn_opportunity.dart';
import 'package:imalichat/domain/entities/earn_thread.dart';
import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/repositories/earn_repository.dart';
import 'package:imalichat/presentation/blocs/auth/auth_bloc.dart';
import 'package:imalichat/presentation/blocs/earn/earn_bloc.dart';
import 'package:imalichat/presentation/blocs/wallet/wallet_bloc.dart';

import 'test_fixtures.dart';

// Mock repository
class MockEarnRepository extends Mock implements EarnRepository {}

/// Container for all mock dependencies used in integration tests.
class MockDependencies {
  late final MockEarnRepository mockEarnRepository;
  late final AuthBloc authBloc;
  late final EarnBloc earnBloc;
  late final WalletBloc walletBloc;

  // Test data
  final User testUser;
  final List<EarnThread> threads;
  final List<EarnOpportunity> opportunities;
  final int dailyLimit;
  final int dailyCompleted;
  final bool hasActiveEngagement;
  final bool networkError;
  final bool budgetDepleted;

  MockDependencies({
    User? testUser,
    List<EarnThread>? threads,
    List<EarnOpportunity>? opportunities,
    this.dailyLimit = 30,
    this.dailyCompleted = 0,
    this.hasActiveEngagement = false,
    this.networkError = false,
    this.budgetDepleted = false,
  })  : testUser = testUser ?? TestFixtures.authenticatedUser,
        threads = threads ?? TestFixtures.sampleThreads,
        opportunities = opportunities ?? TestFixtures.sampleOpportunities {
    _setupMocks();
  }

  void _setupMocks() {
    mockEarnRepository = MockEarnRepository();

    // Setup repository mocks based on configuration
    if (networkError) {
      _setupNetworkErrorMocks();
    } else if (budgetDepleted) {
      _setupBudgetDepletedMocks();
    } else {
      _setupSuccessMocks();
    }

    // Create real blocs with mocked dependencies
    earnBloc = EarnBloc(mockEarnRepository);

    // For auth and wallet, we create pre-configured blocs
    // In a real scenario, these would also use mock repositories
    authBloc = _createAuthBloc();
    walletBloc = _createWalletBloc();
  }

  void _setupSuccessMocks() {
    // getEligibleThreads
    when(() => mockEarnRepository.getEligibleThreads()).thenAnswer(
      (_) async => Right(EligibleThreadsResult(
        threads: threads,
        dailyCompletions: dailyCompleted,
        dailyEarnCap: dailyLimit,
        dailyLimitReached: dailyCompleted >= dailyLimit,
      )),
    );

    // getEligibleOpportunities
    when(() => mockEarnRepository.getEligibleOpportunities(
          threadId: any(named: 'threadId'),
        )).thenAnswer((_) async => Right(opportunities));

    // getOpportunityById
    when(() => mockEarnRepository.getOpportunityById(any())).thenAnswer(
      (invocation) async {
        final id = invocation.positionalArguments[0] as String;
        final opp = opportunities.where((o) => o.id == id).firstOrNull;
        return opp != null ? Right(opp) : const Left(Failure.unknown());
      },
    );

    // startEngagement
    when(() => mockEarnRepository.startEngagement(
          opportunityId: any(named: 'opportunityId'),
        )).thenAnswer((_) async => Right(TestFixtures.startedEngagement));

    // updateEngagementProgress
    when(() => mockEarnRepository.updateEngagementProgress(
          engagementId: any(named: 'engagementId'),
          watchDurationSeconds: any(named: 'watchDurationSeconds'),
        )).thenAnswer((_) async => Right(TestFixtures.watchingEngagement));

    // submitSurvey
    when(() => mockEarnRepository.submitSurvey(
          engagementId: any(named: 'engagementId'),
          answers: any(named: 'answers'),
          evidence: any(named: 'evidence'),
        )).thenAnswer((_) async => Right(TestFixtures.completedEngagement));

    // abandonEngagement
    when(() => mockEarnRepository.abandonEngagement(any()))
        .thenAnswer((_) async => const Right(null));

    // getEngagementHistory
    when(() => mockEarnRepository.getEngagementHistory(
          limit: any(named: 'limit'),
          startAfter: any(named: 'startAfter'),
        )).thenAnswer((_) async => Right(TestFixtures.engagementHistory));
  }

  void _setupNetworkErrorMocks() {
    when(() => mockEarnRepository.getEligibleThreads())
        .thenAnswer((_) async => const Left(Failure.network()));

    when(() => mockEarnRepository.getEligibleOpportunities(
          threadId: any(named: 'threadId'),
        )).thenAnswer((_) async => const Left(Failure.network()));
  }

  void _setupBudgetDepletedMocks() {
    // Threads load successfully
    when(() => mockEarnRepository.getEligibleThreads()).thenAnswer(
      (_) async => Right(EligibleThreadsResult(
        threads: threads,
        dailyCompletions: dailyCompleted,
        dailyEarnCap: dailyLimit,
        dailyLimitReached: dailyCompleted >= dailyLimit,
      )),
    );

    when(() => mockEarnRepository.getEligibleOpportunities(
          threadId: any(named: 'threadId'),
        )).thenAnswer((_) async => Right(opportunities));

    // But starting engagement fails due to budget
    when(() => mockEarnRepository.startEngagement(
          opportunityId: any(named: 'opportunityId'),
        )).thenAnswer((_) async => const Left(Failure.insufficientBalance()));
  }

  AuthBloc _createAuthBloc() {
    // Create a mock AuthBloc that starts in authenticated state
    // This is a simplified version for testing
    return MockAuthBloc(initialUser: testUser);
  }

  WalletBloc _createWalletBloc() {
    return MockWalletBloc();
  }

  void dispose() {
    authBloc.close();
    earnBloc.close();
    walletBloc.close();
  }
}

/// Mock AuthBloc that can be initialized with a specific state
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {
  MockAuthBloc({User? initialUser}) {
    if (initialUser != null) {
      when(() => state).thenReturn(AuthState(
        status: AuthStatus.authenticated,
        user: initialUser,
      ));
    } else {
      when(() => state).thenReturn(const AuthState(
        status: AuthStatus.unauthenticated,
      ));
    }
  }
}

/// Mock WalletBloc
class MockWalletBloc extends MockBloc<WalletEvent, WalletState>
    implements WalletBloc {
  MockWalletBloc() {
    when(() => state).thenReturn(WalletState(
      status: WalletStatus.loaded,
      ledgerAccount: TestFixtures.userLedgerAccount,
      subAccounts: [TestFixtures.mainWallet],
      selectedSubAccountId: TestFixtures.mainWallet.id,
    ));
  }
}
