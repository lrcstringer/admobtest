import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/security/play_integrity_service.dart';
import 'package:imalichat/data/datasources/remote/wallet_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockPlayIntegrityService extends Mock implements PlayIntegrityService {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult extends Mock
    implements HttpsCallableResult<Map<String, dynamic>> {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

// Concrete subclass so we can instantiate the @protected constructor.
class TestFirebaseFunctionsException extends FirebaseFunctionsException {
  TestFirebaseFunctionsException({
    required super.code,
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// ==================== TESTS ====================

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFunctions mockFunctions;
  late MockPlayIntegrityService mockPlayIntegrity;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockResult;
  late MockFirebaseUser mockUser;
  late WalletRemoteDataSourceImpl dataSource;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockFunctions = MockFirebaseFunctions();
    mockPlayIntegrity = MockPlayIntegrityService();
    mockCallable = MockHttpsCallable();
    mockResult = MockHttpsCallableResult();
    mockUser = MockFirebaseUser();

    dataSource = WalletRemoteDataSourceImpl(
      mockFirestore,
      mockAuth,
      mockFunctions,
      mockPlayIntegrity,
    );

    // Default: user is authenticated
    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn('user123');
  });

  // ===========================================================================
  // sendP2PTransfer
  // ===========================================================================

  group('sendP2PTransfer', () {
    setUp(() {
      when(() => mockFunctions.httpsCallable('sendP2PTransfer'))
          .thenReturn(mockCallable);
    });

    test('calls httpsCallable with correct params (no note)', () async {
      when(() => mockResult.data)
          .thenReturn(<String, dynamic>{'success': true});
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      await dataSource.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 500,
        subAccountId: 'main',
      );

      verify(() => mockFunctions.httpsCallable('sendP2PTransfer')).called(1);
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'recipientUserId': 'user456',
          'amount': 500,
          'subAccountId': 'main',
        }),
      ).called(1);
    });

    test('includes note in params when provided', () async {
      when(() => mockResult.data)
          .thenReturn(<String, dynamic>{'success': true});
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      await dataSource.sendP2PTransfer(
        recipientUserId: 'user456',
        amount: 200,
        subAccountId: 'savings',
        note: 'For lunch',
      );

      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'recipientUserId': 'user456',
          'amount': 200,
          'subAccountId': 'savings',
          'note': 'For lunch',
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'failed-precondition',
          message: 'Insufficient balance',
        ),
      );

      expect(
        () => dataSource.sendP2PTransfer(
          recipientUserId: 'user456',
          amount: 500,
          subAccountId: 'main',
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Insufficient balance',
        )),
      );
    });

    test('throws ServerException with CF error code in message', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'internal',
          message: 'Internal server error',
        ),
      );

      expect(
        () => dataSource.sendP2PTransfer(
          recipientUserId: 'user456',
          amount: 500,
          subAccountId: 'main',
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Internal server error',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('network timeout'));

      expect(
        () => dataSource.sendP2PTransfer(
          recipientUserId: 'user456',
          amount: 500,
          subAccountId: 'main',
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          contains('network timeout'),
        )),
      );
    });
  });

  // ===========================================================================
  // transferBetweenWallets
  // ===========================================================================

  group('transferBetweenWallets', () {
    setUp(() {
      when(() => mockFunctions.httpsCallable('transferBetweenWallets'))
          .thenReturn(mockCallable);
    });

    test('calls httpsCallable with correct params', () async {
      when(() => mockResult.data)
          .thenReturn(<String, dynamic>{'success': true});
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      await dataSource.transferBetweenWallets(
        fromSubAccountId: 'main',
        toSubAccountId: 'savings',
        amount: 1000,
      );

      verify(() => mockFunctions.httpsCallable('transferBetweenWallets'))
          .called(1);
      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'fromSubAccountId': 'main',
          'toSubAccountId': 'savings',
          'amount': 1000,
        }),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'failed-precondition',
          message: 'Insufficient funds',
        ),
      );

      expect(
        () => dataSource.transferBetweenWallets(
          fromSubAccountId: 'main',
          toSubAccountId: 'savings',
          amount: 1000,
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Insufficient funds',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('connection error'));

      expect(
        () => dataSource.transferBetweenWallets(
          fromSubAccountId: 'main',
          toSubAccountId: 'savings',
          amount: 1000,
        ),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          contains('connection error'),
        )),
      );
    });
  });

  // ===========================================================================
  // createUserWallet
  // ===========================================================================

  group('createUserWallet', () {
    setUp(() {
      when(() => mockFunctions.httpsCallable('createUserWallet'))
          .thenReturn(mockCallable);
    });

    test('returns subAccountId on success', () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'subAccountId': 'sub_abc123',
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      final result = await dataSource.createUserWallet(name: 'Savings');

      expect(result, 'sub_abc123');
      verify(
        () => mockCallable.call<Map<String, dynamic>>({'name': 'Savings'}),
      ).called(1);
    });

    test('throws ServerException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'already-exists',
          message: 'Wallet already exists',
        ),
      );

      expect(
        () => dataSource.createUserWallet(name: 'Savings'),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Wallet already exists',
        )),
      );
    });

    test('throws ServerException on generic exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('timeout'));

      expect(
        () => dataSource.createUserWallet(name: 'Savings'),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          contains('timeout'),
        )),
      );
    });
  });
}
