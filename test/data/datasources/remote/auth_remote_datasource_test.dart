import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/data/datasources/remote/auth_remote_datasource.dart';

// ==================== MOCKS ====================

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult extends Mock
    implements HttpsCallableResult<Map<String, dynamic>> {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

// Concrete subclass so we can instantiate the @protected constructor.
class TestFirebaseFunctionsException extends FirebaseFunctionsException {
  TestFirebaseFunctionsException({
    required super.code,
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Concrete subclass for FirebaseAuthException (@protected constructor).
class TestFirebaseAuthException extends firebase_auth.FirebaseAuthException {
  TestFirebaseAuthException({
    required super.code,
    super.message,
  });
}

// ==================== TEST FIXTURES ====================

const _testPhone = '+27612345678';
const _testOtp = '123456';
const _testCustomToken = 'custom-token-abc';

// ==================== TESTS ====================

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockResult;
  late MockFirebaseUser mockUser;
  late MockUserCredential mockUserCredential;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFunctions = MockFirebaseFunctions();
    mockCallable = MockHttpsCallable();
    mockResult = MockHttpsCallableResult();
    mockUser = MockFirebaseUser();
    mockUserCredential = MockUserCredential();
    dataSource = AuthRemoteDataSourceImpl(mockFirebaseAuth, mockFunctions);
  });

  // ==================== currentUser ====================

  group('currentUser', () {
    test('returns firebaseAuth.currentUser', () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final result = dataSource.currentUser;

      expect(result, equals(mockUser));
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });
  });

  // ==================== authStateChanges ====================

  group('authStateChanges', () {
    test('returns firebaseAuth.authStateChanges() stream', () {
      final controller = StreamController<firebase_auth.User?>();
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => controller.stream);

      final result = dataSource.authStateChanges;

      expect(result, isA<Stream<firebase_auth.User?>>());
      verify(() => mockFirebaseAuth.authStateChanges()).called(1);

      controller.close();
    });
  });

  // ==================== sendOtp ====================

  group('sendOtp', () {
    setUp(() {
      when(() => mockFunctions.httpsCallable('sendOtp'))
          .thenReturn(mockCallable);
    });

    test('calls httpsCallable(sendOtp) with correct phoneNumber', () async {
      when(() => mockResult.data)
          .thenReturn(<String, dynamic>{'success': true});
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      await dataSource.sendOtp(phoneNumber: _testPhone);

      verify(() => mockFunctions.httpsCallable('sendOtp')).called(1);
      verify(
        () => mockCallable
            .call<Map<String, dynamic>>({'phoneNumber': _testPhone}),
      ).called(1);
    });

    test('returns normally when success is true', () async {
      when(() => mockResult.data)
          .thenReturn(<String, dynamic>{'success': true});
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      await expectLater(
        dataSource.sendOtp(phoneNumber: _testPhone),
        completes,
      );
    });

    test('throws AuthException when success is false', () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'success': false,
        'message': 'Phone number blocked',
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      // The internal AuthException is caught by the generic catch block,
      // which re-wraps it with a fixed message.
      expect(
        () => dataSource.sendOtp(phoneNumber: _testPhone),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Failed to send verification code. Please try again.',
          ),
        ),
      );
    });

    test(
        'throws AuthException with mapped message '
        'on FirebaseFunctionsException with invalid-argument', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'invalid-argument',
          message: 'Invalid phone number',
        ),
      );

      expect(
        () => dataSource.sendOtp(phoneNumber: _testPhone),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Invalid phone number',
          ),
        ),
      );
    });

    test('throws AuthException on resource-exhausted', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'resource-exhausted',
          message: 'Rate limited',
        ),
      );

      expect(
        () => dataSource.sendOtp(phoneNumber: _testPhone),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Rate limited',
          ),
        ),
      );
    });

    test('throws AuthException on deadline-exceeded', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'deadline-exceeded',
          message: 'Timed out',
        ),
      );

      expect(
        () => dataSource.sendOtp(phoneNumber: _testPhone),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Timed out',
          ),
        ),
      );
    });

    test('throws AuthException on unknown error code', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'unknown-code',
          message: 'Something weird',
        ),
      );

      expect(
        () => dataSource.sendOtp(phoneNumber: _testPhone),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Something weird',
          ),
        ),
      );
    });

    test('throws AuthException on generic (non-Firebase) exception', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('Network error'));

      expect(
        () => dataSource.sendOtp(phoneNumber: _testPhone),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Failed to send verification code. Please try again.',
          ),
        ),
      );
    });
  });

  // ==================== verifyOtp ====================

  group('verifyOtp', () {
    setUp(() {
      when(() => mockFunctions.httpsCallable('verifyOtp'))
          .thenReturn(mockCallable);
    });

    test('calls httpsCallable(verifyOtp) with phoneNumber and code', () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'success': true,
        'customToken': _testCustomToken,
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);
      when(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .thenAnswer((_) async => mockUserCredential);

      await dataSource.verifyOtp(phoneNumber: _testPhone, otp: _testOtp);

      verify(
        () => mockCallable.call<Map<String, dynamic>>({
          'phoneNumber': _testPhone,
          'code': _testOtp,
        }),
      ).called(1);
    });

    test('extracts customToken and signs in with it', () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'success': true,
        'customToken': _testCustomToken,
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);
      when(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .thenAnswer((_) async => mockUserCredential);

      await dataSource.verifyOtp(phoneNumber: _testPhone, otp: _testOtp);

      verify(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .called(1);
    });

    test('returns UserCredential from signInWithCustomToken', () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'success': true,
        'customToken': _testCustomToken,
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);
      when(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .thenAnswer((_) async => mockUserCredential);

      final result =
          await dataSource.verifyOtp(phoneNumber: _testPhone, otp: _testOtp);

      expect(result, equals(mockUserCredential));
    });

    test('throws AuthException when success is false', () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'success': false,
        'message': 'Wrong code',
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      expect(
        () => dataSource.verifyOtp(phoneNumber: _testPhone, otp: _testOtp),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Wrong code',
          ),
        ),
      );
    });

    test('throws AuthException when customToken is null', () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'success': true,
        'customToken': null,
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);

      expect(
        () => dataSource.verifyOtp(phoneNumber: _testPhone, otp: _testOtp),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'No auth token received',
          ),
        ),
      );
    });

    test('throws AuthException on FirebaseFunctionsException', () async {
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'not-found',
          message: 'No verification session',
        ),
      );

      expect(
        () => dataSource.verifyOtp(phoneNumber: _testPhone, otp: _testOtp),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'No verification session',
          ),
        ),
      );
    });

    test('throws AuthException on FirebaseAuthException during sign-in',
        () async {
      when(() => mockResult.data).thenReturn(<String, dynamic>{
        'success': true,
        'customToken': _testCustomToken,
      });
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);
      when(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .thenThrow(
        TestFirebaseAuthException(
          code: 'invalid-custom-token',
          message: 'Token expired',
        ),
      );

      expect(
        () => dataSource.verifyOtp(phoneNumber: _testPhone, otp: _testOtp),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Token expired',
          ),
        ),
      );
    });
  });

  // ==================== signOut ====================

  group('signOut', () {
    test('calls firebaseAuth.signOut()', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      await dataSource.signOut();

      verify(() => mockFirebaseAuth.signOut()).called(1);
    });
  });

  // ==================== deleteAccount ====================

  group('deleteAccount', () {
    setUp(() {
      when(() => mockFunctions.httpsCallable('deleteUserAccount'))
          .thenReturn(mockCallable);
    });

    test('calls httpsCallable(deleteUserAccount) then signOut', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockResult.data).thenReturn(<String, dynamic>{});
      when(() => mockCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => mockResult);
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      await dataSource.deleteAccount();

      verifyInOrder([
        () => mockCallable.call<Map<String, dynamic>>({}),
        () => mockFirebaseAuth.signOut(),
      ]);
    });

    test('throws AuthException when no user is signed in', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      expect(
        () => dataSource.deleteAccount(),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'No user signed in',
          ),
        ),
      );
    });

    test('propagates FirebaseFunctionsException as AuthException', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockCallable.call<Map<String, dynamic>>(any())).thenThrow(
        TestFirebaseFunctionsException(
          code: 'internal',
          message: 'Server error during deletion',
        ),
      );

      expect(
        () => dataSource.deleteAccount(),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Server error during deletion',
          ),
        ),
      );
    });
  });

  // ==================== signInWithCustomToken ====================

  group('signInWithCustomToken', () {
    test('calls firebaseAuth.signInWithCustomToken', () async {
      when(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .thenAnswer((_) async => mockUserCredential);

      await dataSource.signInWithCustomToken(_testCustomToken);

      verify(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .called(1);
    });

    test('returns UserCredential', () async {
      when(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .thenAnswer((_) async => mockUserCredential);

      final result = await dataSource.signInWithCustomToken(_testCustomToken);

      expect(result, equals(mockUserCredential));
    });

    test('throws AuthException on FirebaseAuthException', () async {
      when(() => mockFirebaseAuth.signInWithCustomToken(_testCustomToken))
          .thenThrow(
        TestFirebaseAuthException(
          code: 'invalid-custom-token',
          message: 'Bad token',
        ),
      );

      expect(
        () => dataSource.signInWithCustomToken(_testCustomToken),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            'Bad token',
          ),
        ),
      );
    });
  });

  // ==================== getIdToken ====================

  group('getIdToken', () {
    test('returns token from currentUser.getIdToken', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.getIdToken(false))
          .thenAnswer((_) async => 'id-token-123');

      final result = await dataSource.getIdToken();

      expect(result, equals('id-token-123'));
      verify(() => mockUser.getIdToken(false)).called(1);
    });

    test('passes forceRefresh parameter to getIdToken', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.getIdToken(true))
          .thenAnswer((_) async => 'refreshed-token');

      final result = await dataSource.getIdToken(forceRefresh: true);

      expect(result, equals('refreshed-token'));
      verify(() => mockUser.getIdToken(true)).called(1);
    });

    test('returns null when there is no currentUser', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      final result = await dataSource.getIdToken();

      expect(result, isNull);
    });
  });
}
