import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/data/datasources/remote/wallet_remote_datasource.dart';
import 'package:imalichat/data/models/cashout_model.dart';
import 'package:imalichat/data/models/ledger_account_model.dart';
import 'package:imalichat/data/models/ledger_journal_model.dart';
import 'package:imalichat/data/models/sub_account_model.dart';
import 'package:imalichat/data/models/user_engagement_stats_model.dart';
import 'package:imalichat/data/repositories/wallet_repository_impl.dart';
import 'package:imalichat/domain/entities/cashout.dart';
import 'package:imalichat/domain/entities/ledger_account.dart';
import 'package:imalichat/domain/entities/ledger_journal.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockWalletRemoteDataSource extends Mock
    implements WalletRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

// ==================== TEST FIXTURES ====================

final _now = DateTime(2024, 6, 1);

LedgerAccountModel _createLedgerAccountModel() {
  return LedgerAccountModel(
    id: 'user:user123',
    type: LedgerAccountType.user,
    name: 'Test User Account',
    ownerId: 'user123',
    balance: 10000,
    allocatedBalance: 0,
    currency: 'TOKEN',
    status: LedgerAccountStatus.active,
    metadata: const {},
    createdAt: _now,
    updatedAt: _now,
    version: 1,
  );
}

LedgerJournalModel _createJournalModel({String id = 'journal_1'}) {
  return LedgerJournalModel(
    id: id,
    idempotencyKey: 'earn-user123-20240601-001',
    type: LedgerJournalType.earn,
    status: LedgerJournalStatus.posted,
    description: 'Watched ad',
    entries: [
      const LedgerEntryModel(
        id: 'entry_1',
        accountId: 'user:user123',
        entryType: LedgerEntryType.credit,
        amount: 100,
        balanceAfter: 10100,
      ),
    ],
    totalDebits: 100,
    totalCredits: 100,
    initiatedBy: 'system',
    createdAt: _now,
    postedAt: _now,
  );
}

UserEngagementStatsModel _createStatsModel() {
  return UserEngagementStatsModel(
    userId: 'user123',
    currentStreak: 5,
    longestStreak: 10,
    totalEngagementsCompleted: 50,
    totalTokensEarned: 5000,
    updatedAt: _now,
  );
}

SubAccountModel _createSubAccountModel({
  String id = 'sub_1',
  String name = 'Savings',
}) {
  return SubAccountModel(
    id: id,
    userId: 'user123',
    name: name,
    balance: 3000,
    lifetimeCredits: 5000,
    lifetimeDebits: 2000,
    isActive: true,
    isDefault: false,
    createdAt: _now,
    updatedAt: _now,
  );
}

CashoutModel _createCashoutModel({String id = 'cashout_1'}) {
  return CashoutModel(
    id: id,
    walletId: 'user:user123',
    userId: 'user123',
    tokenAmount: 5000,
    zarAmount: 50.0,
    method: 'bankTransfer',
    status: 'pending',
    destinationDetails: 'FNB *****1234',
    bankName: 'FNB',
    accountNumber: '62000001234',
    accountHolderName: 'Test User',
    createdAt: _now,
  );
}

// ==================== TESTS ====================

void main() {
  late WalletRepositoryImpl repository;
  late MockWalletRemoteDataSource mockDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockDataSource = MockWalletRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WalletRepositoryImpl(mockDataSource, mockNetworkInfo);
  });

  // Helper to set network connected
  void setNetworkConnected() {
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  // Helper to set network disconnected
  void setNetworkDisconnected() {
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  }

  // ===========================================================================
  // getLedgerAccount
  // ===========================================================================

  group('getLedgerAccount', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.getLedgerAccount();

      expect(result, const Left(Failure.network()));
      verifyNever(() => mockDataSource.getLedgerAccount());
    });

    test('returns Right(entity) when datasource returns model', () async {
      setNetworkConnected();
      final model = _createLedgerAccountModel();
      when(() => mockDataSource.getLedgerAccount())
          .thenAnswer((_) async => model);

      final result = await repository.getLedgerAccount();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (account) {
          expect(account.id, 'user:user123');
          expect(account.balance, 10000);
          expect(account.type, LedgerAccountType.user);
          expect(account.name, 'Test User Account');
        },
      );
    });

    test('returns Left(serverError) when datasource returns null', () async {
      setNetworkConnected();
      when(() => mockDataSource.getLedgerAccount())
          .thenAnswer((_) async => null);

      final result = await repository.getLedgerAccount();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure,
          const Failure.serverError(message: 'Ledger account not found'),
        ),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.getLedgerAccount())
          .thenThrow(const AuthException(message: 'Not authenticated'));

      final result = await repository.getLedgerAccount();

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      setNetworkConnected();
      when(() => mockDataSource.getLedgerAccount())
          .thenThrow(const ServerException(message: 'DB error'));

      final result = await repository.getLedgerAccount();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) =>
            expect(failure, const Failure.serverError(message: 'DB error')),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left(serverError) on generic exception', () async {
      setNetworkConnected();
      when(() => mockDataSource.getLedgerAccount())
          .thenThrow(Exception('Something unexpected'));

      final result = await repository.getLedgerAccount();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
        },
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // getLedgerBalance
  // ===========================================================================

  group('getLedgerBalance', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.getLedgerBalance();

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(balance) on success', () async {
      setNetworkConnected();
      when(() => mockDataSource.getLedgerBalance())
          .thenAnswer((_) async => 10000);

      final result = await repository.getLedgerBalance();

      expect(result, const Right(10000));
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.getLedgerBalance())
          .thenThrow(const AuthException(message: 'Not logged in'));

      final result = await repository.getLedgerBalance();

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // ===========================================================================
  // getLedgerJournals
  // ===========================================================================

  group('getLedgerJournals', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.getLedgerJournals();

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(list of entities) on success', () async {
      setNetworkConnected();
      final models = [
        _createJournalModel(id: 'j1'),
        _createJournalModel(id: 'j2'),
      ];
      when(() => mockDataSource.getLedgerJournals())
          .thenAnswer((_) async => models);

      final result = await repository.getLedgerJournals();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (journals) {
          expect(journals.length, 2);
          expect(journals[0].id, 'j1');
          expect(journals[1].id, 'j2');
          expect(journals[0].type, LedgerJournalType.earn);
        },
      );
    });

    test('passes limit and startAfter parameters to datasource', () async {
      setNetworkConnected();
      final startAfter = DateTime(2024, 5, 1);
      when(() => mockDataSource.getLedgerJournals(
            limit: 10,
            startAfter: startAfter,
          )).thenAnswer((_) async => [_createJournalModel()]);

      final result = await repository.getLedgerJournals(
        limit: 10,
        startAfter: startAfter,
      );

      expect(result.isRight(), isTrue);
      verify(() => mockDataSource.getLedgerJournals(
            limit: 10,
            startAfter: startAfter,
          )).called(1);
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.getLedgerJournals())
          .thenThrow(const AuthException(message: 'No auth'));

      final result = await repository.getLedgerJournals();

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // ===========================================================================
  // getEngagementStats
  // ===========================================================================

  group('getEngagementStats', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.getEngagementStats();

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(entity) when datasource returns model', () async {
      setNetworkConnected();
      when(() => mockDataSource.getEngagementStats())
          .thenAnswer((_) async => _createStatsModel());

      final result = await repository.getEngagementStats();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (stats) {
          expect(stats.userId, 'user123');
          expect(stats.currentStreak, 5);
          expect(stats.longestStreak, 10);
          expect(stats.totalEngagementsCompleted, 50);
          expect(stats.totalTokensEarned, 5000);
        },
      );
    });

    test(
        'returns Right(empty stats) when datasource returns null and user is '
        'authenticated', () async {
      setNetworkConnected();
      when(() => mockDataSource.getEngagementStats())
          .thenAnswer((_) async => null);
      when(() => mockDataSource.currentUserId).thenReturn('user123');

      final result = await repository.getEngagementStats();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (stats) {
          expect(stats.userId, 'user123');
          expect(stats.currentStreak, 0);
          expect(stats.longestStreak, 0);
          expect(stats.totalEngagementsCompleted, 0);
          expect(stats.totalTokensEarned, 0);
        },
      );
    });

    test(
        'returns Left(unauthenticated) when datasource returns null and '
        'currentUserId is null', () async {
      setNetworkConnected();
      when(() => mockDataSource.getEngagementStats())
          .thenAnswer((_) async => null);
      when(() => mockDataSource.currentUserId).thenReturn(null);

      final result = await repository.getEngagementStats();

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.getEngagementStats())
          .thenThrow(const AuthException(message: 'Not authed'));

      final result = await repository.getEngagementStats();

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // ===========================================================================
  // getSubAccounts
  // ===========================================================================

  group('getSubAccounts', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.getSubAccounts();

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(list of entities) on success', () async {
      setNetworkConnected();
      final models = [
        _createSubAccountModel(id: 'sub_1', name: 'Savings'),
        _createSubAccountModel(id: 'sub_2', name: 'Groceries'),
      ];
      when(() => mockDataSource.getSubAccounts())
          .thenAnswer((_) async => models);

      final result = await repository.getSubAccounts();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (accounts) {
          expect(accounts.length, 2);
          expect(accounts[0].id, 'sub_1');
          expect(accounts[0].name, 'Savings');
          expect(accounts[1].id, 'sub_2');
          expect(accounts[1].name, 'Groceries');
        },
      );
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.getSubAccounts())
          .thenThrow(const AuthException(message: 'Not logged in'));

      final result = await repository.getSubAccounts();

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      setNetworkConnected();
      when(() => mockDataSource.getSubAccounts())
          .thenThrow(const ServerException(message: 'Function error'));

      final result = await repository.getSubAccounts();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure,
          const Failure.serverError(message: 'Function error'),
        ),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // createUserWallet
  // ===========================================================================

  group('createUserWallet', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.createUserWallet(name: 'My Wallet');

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(subAccountId) on success', () async {
      setNetworkConnected();
      when(() => mockDataSource.createUserWallet(name: 'My Wallet'))
          .thenAnswer((_) async => 'new_sub_id_123');

      final result = await repository.createUserWallet(name: 'My Wallet');

      expect(result, const Right('new_sub_id_123'));
      verify(() => mockDataSource.createUserWallet(name: 'My Wallet'))
          .called(1);
    });

    test('returns Left(serverError) on ServerException', () async {
      setNetworkConnected();
      when(() => mockDataSource.createUserWallet(name: 'Bad Wallet'))
          .thenThrow(const ServerException(message: 'Wallet limit reached'));

      final result = await repository.createUserWallet(name: 'Bad Wallet');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure,
          const Failure.serverError(message: 'Wallet limit reached'),
        ),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // transferBetweenWallets
  // ===========================================================================

  group('transferBetweenWallets', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.transferBetweenWallets(
        fromSubAccountId: 'sub_1',
        toSubAccountId: 'sub_2',
        amount: 500,
      );

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(null) on success', () async {
      setNetworkConnected();
      when(() => mockDataSource.transferBetweenWallets(
            fromSubAccountId: 'sub_1',
            toSubAccountId: 'sub_2',
            amount: 500,
          )).thenAnswer((_) async {});

      final result = await repository.transferBetweenWallets(
        fromSubAccountId: 'sub_1',
        toSubAccountId: 'sub_2',
        amount: 500,
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.transferBetweenWallets(
            fromSubAccountId: 'sub_1',
            toSubAccountId: 'sub_2',
            amount: 500,
          )).called(1);
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.transferBetweenWallets(
            fromSubAccountId: 'sub_1',
            toSubAccountId: 'sub_2',
            amount: 500,
          )).thenThrow(const AuthException(message: 'Session expired'));

      final result = await repository.transferBetweenWallets(
        fromSubAccountId: 'sub_1',
        toSubAccountId: 'sub_2',
        amount: 500,
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      setNetworkConnected();
      when(() => mockDataSource.transferBetweenWallets(
            fromSubAccountId: 'sub_1',
            toSubAccountId: 'sub_2',
            amount: 500,
          )).thenThrow(const ServerException(message: 'Insufficient balance'));

      final result = await repository.transferBetweenWallets(
        fromSubAccountId: 'sub_1',
        toSubAccountId: 'sub_2',
        amount: 500,
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure,
          const Failure.serverError(message: 'Insufficient balance'),
        ),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // sendP2PTransfer
  // ===========================================================================

  group('sendP2PTransfer', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 100,
        subAccountId: 'main',
      );

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(null) on success', () async {
      setNetworkConnected();
      when(() => mockDataSource.sendP2PTransfer(
            recipientUserId: 'user456',
            amount: 100,
            subAccountId: 'main',
            note: 'For lunch',
          )).thenAnswer((_) async {});

      final result = await repository.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 100,
        subAccountId: 'main',
        note: 'For lunch',
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.sendP2PTransfer(
            recipientUserId: 'user456',
            amount: 100,
            subAccountId: 'main',
            note: 'For lunch',
          )).called(1);
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.sendP2PTransfer(
            recipientUserId: 'user456',
            amount: 100,
            subAccountId: 'main',
          )).thenThrow(const AuthException(message: 'No auth'));

      final result = await repository.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 100,
        subAccountId: 'main',
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      setNetworkConnected();
      when(() => mockDataSource.sendP2PTransfer(
            recipientUserId: 'user456',
            amount: 100,
            subAccountId: 'main',
          )).thenThrow(const ServerException(message: 'Transfer failed'));

      final result = await repository.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 100,
        subAccountId: 'main',
      );

      expect(
        result,
        const Left(Failure.serverError(message: 'Transfer failed')),
      );
    });

    test('returns Left(serverError) on generic exception', () async {
      setNetworkConnected();
      when(() => mockDataSource.sendP2PTransfer(
            recipientUserId: 'user456',
            amount: 100,
            subAccountId: 'main',
          )).thenThrow(Exception('unexpected'));

      final result = await repository.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 100,
        subAccountId: 'main',
      );

      expect(result.isLeft(), true);
      result.fold(
        (failure) => failure.maybeMap(
          serverError: (e) => expect(e.message, contains('unexpected')),
          orElse: () => fail('Expected serverError'),
        ),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // requestCashout
  // ===========================================================================

  group('requestCashout', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.requestCashout(
        tokenAmount: 5000,
        method: CashoutMethod.bankTransfer,
        destinationDetails: 'FNB *****1234',
      );

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(entity) on success', () async {
      setNetworkConnected();
      when(() => mockDataSource.requestCashout(
            tokenAmount: 5000,
            method: CashoutMethod.bankTransfer,
            destinationDetails: 'FNB *****1234',
            bankName: 'FNB',
            accountNumber: '62000001234',
            accountHolderName: 'Test User',
            mobileNumber: null,
          )).thenAnswer((_) async => _createCashoutModel());

      final result = await repository.requestCashout(
        tokenAmount: 5000,
        method: CashoutMethod.bankTransfer,
        destinationDetails: 'FNB *****1234',
        bankName: 'FNB',
        accountNumber: '62000001234',
        accountHolderName: 'Test User',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (cashout) {
          expect(cashout.id, 'cashout_1');
          expect(cashout.tokenAmount, 5000);
          expect(cashout.zarAmount, 50.0);
          expect(cashout.method, CashoutMethod.bankTransfer);
        },
      );
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      setNetworkConnected();
      when(() => mockDataSource.requestCashout(
            tokenAmount: 5000,
            method: CashoutMethod.bankTransfer,
            destinationDetails: 'FNB *****1234',
            bankName: null,
            accountNumber: null,
            accountHolderName: null,
            mobileNumber: null,
          )).thenThrow(const AuthException(message: 'No auth'));

      final result = await repository.requestCashout(
        tokenAmount: 5000,
        method: CashoutMethod.bankTransfer,
        destinationDetails: 'FNB *****1234',
      );

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // ===========================================================================
  // getCashoutHistory
  // ===========================================================================

  group('getCashoutHistory', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.getCashoutHistory();

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(list of entities) on success', () async {
      setNetworkConnected();
      final models = [
        _createCashoutModel(id: 'c1'),
        _createCashoutModel(id: 'c2'),
      ];
      when(() => mockDataSource.getCashoutHistory())
          .thenAnswer((_) async => models);

      final result = await repository.getCashoutHistory();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (cashouts) {
          expect(cashouts.length, 2);
          expect(cashouts[0].id, 'c1');
          expect(cashouts[1].id, 'c2');
        },
      );
    });
  });

  // ===========================================================================
  // getCashoutById
  // ===========================================================================

  group('getCashoutById', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.getCashoutById('cashout_1');

      expect(result, const Left(Failure.network()));
    });

    test('returns Left(serverError) when datasource returns null', () async {
      setNetworkConnected();
      when(() => mockDataSource.getCashout('missing_id'))
          .thenAnswer((_) async => null);

      final result = await repository.getCashoutById('missing_id');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure,
          const Failure.serverError(message: 'Cashout not found'),
        ),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Right(entity) on success', () async {
      setNetworkConnected();
      when(() => mockDataSource.getCashout('cashout_1'))
          .thenAnswer((_) async => _createCashoutModel());

      final result = await repository.getCashoutById('cashout_1');

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (cashout) {
          expect(cashout.id, 'cashout_1');
          expect(cashout.tokenAmount, 5000);
          expect(cashout.bankName, 'FNB');
        },
      );
    });
  });

  // ===========================================================================
  // cancelCashout
  // ===========================================================================

  group('cancelCashout', () {
    test('returns Left(network) when not connected', () async {
      setNetworkDisconnected();

      final result = await repository.cancelCashout('cashout_1');

      expect(result, const Left(Failure.network()));
    });

    test('returns Right(null) on success', () async {
      setNetworkConnected();
      when(() => mockDataSource.cancelCashout('cashout_1'))
          .thenAnswer((_) async {});

      final result = await repository.cancelCashout('cashout_1');

      expect(result, const Right(null));
      verify(() => mockDataSource.cancelCashout('cashout_1')).called(1);
    });

    test('returns Left(serverError) on ServerException', () async {
      setNetworkConnected();
      when(() => mockDataSource.cancelCashout('cashout_1'))
          .thenThrow(const ServerException(message: 'Already processed'));

      final result = await repository.cancelCashout('cashout_1');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure,
          const Failure.serverError(message: 'Already processed'),
        ),
        (_) => fail('Expected Left'),
      );
    });
  });
}
