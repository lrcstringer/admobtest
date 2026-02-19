import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/data/datasources/remote/auth_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/user_remote_datasource.dart';
import 'package:imalichat/data/models/user_model.dart';
import 'package:imalichat/data/repositories/auth_repository_impl.dart';
import 'package:imalichat/domain/entities/user.dart' as domain;
import 'package:imalichat/domain/enums/user_status.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

// ==================== TEST FIXTURES ====================

const _uid = 'uid123';
const _phoneNumber = '+27612345678';

UserModel _createTestUserModel({
  String userId = _uid,
  String phoneNumber = _phoneNumber,
  bool hasCompletedOnboarding = true,
  bool hasAcceptedTerms = true,
}) {
  return UserModel(
    userId: userId,
    phoneNumber: phoneNumber,
    displayName: 'iMali User',
    status: UserStatus.active,
    hasAcceptedTerms: hasAcceptedTerms,
    hasCompletedOnboarding: hasCompletedOnboarding,
    isPotEligible: false,
    createdAt: DateTime(2024, 1, 1),
  );
}

// ==================== TESTS ====================

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockAppDatabase mockAppDatabase;
  late MockFirebaseUser mockFirebaseUser;
  late MockUserCredential mockUserCredential;

  setUpAll(() {
    registerFallbackValue(_createTestUserModel());
  });

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockAppDatabase = MockAppDatabase();
    mockFirebaseUser = MockFirebaseUser();
    mockUserCredential = MockUserCredential();

    repository = AuthRepositoryImpl(
      mockAuthRemoteDataSource,
      mockUserRemoteDataSource,
      mockNetworkInfo,
      mockAppDatabase,
    );

    // Default mock setup
    when(() => mockFirebaseUser.uid).thenReturn(_uid);
    when(() => mockFirebaseUser.phoneNumber).thenReturn(_phoneNumber);
    when(() => mockUserCredential.user).thenReturn(mockFirebaseUser);
  });

  // ==================== getCurrentUser ====================

  group('getCurrentUser', () {
    test('returns Right(User) when firebase user exists and Firestore user found',
        () async {
      final tUserModel = _createTestUserModel();
      when(() => mockAuthRemoteDataSource.currentUser)
          .thenReturn(mockFirebaseUser);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => tUserModel);

      final result = await repository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user, isNotNull);
          expect(user!.id, equals(_uid));
          expect(user.phoneNumber, equals(_phoneNumber));
        },
      );
      verify(() => mockAuthRemoteDataSource.currentUser).called(1);
      verify(() => mockUserRemoteDataSource.getUserById(_uid)).called(1);
    });

    test('returns Right(null) when no firebase user', () async {
      when(() => mockAuthRemoteDataSource.currentUser).thenReturn(null);

      final result = await repository.getCurrentUser();

      expect(result, equals(const Right(null)));
      verify(() => mockAuthRemoteDataSource.currentUser).called(1);
      verifyNever(() => mockUserRemoteDataSource.getUserById(any()));
    });

    test('returns Right(null) when firebase user exists but Firestore returns null',
        () async {
      when(() => mockAuthRemoteDataSource.currentUser)
          .thenReturn(mockFirebaseUser);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => null);

      final result = await repository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) => expect(user, isNull),
      );
    });

    test('returns Left(Failure.serverError) on ServerException', () async {
      when(() => mockAuthRemoteDataSource.currentUser)
          .thenReturn(mockFirebaseUser);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenThrow(const ServerException(message: 'Firestore error'));

      final result = await repository.getCurrentUser();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ==================== sendOtp ====================

  group('sendOtp', () {
    test('returns Right(phoneNumber) on success', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenAnswer((_) async {});

      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result, equals(Right(_phoneNumber)));
      verify(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .called(1);
    });

    test('returns Left(Failure.network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result, equals(const Left(Failure.network())));
      verifyNever(
        () => mockAuthRemoteDataSource.sendOtp(phoneNumber: any(named: 'phoneNumber')),
      );
    });

    test('returns Left(Failure.auth) on 60s cooldown (second call within 60s)',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenAnswer((_) async {});

      // First call succeeds and records _lastOtpSentAt
      await repository.sendOtp(phoneNumber: _phoneNumber);

      // Second call within 60s should be rejected
      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          final authFailure = failure as AuthFailure;
          expect(authFailure.message, contains('wait'));
          expect(authFailure.message, contains('seconds'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('calls datasource.sendOtp with correct phoneNumber', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenAnswer((_) async {});

      await repository.sendOtp(phoneNumber: _phoneNumber);

      verify(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .called(1);
    });

    test('maps AuthException with "expired" to Failure.otpExpired', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenThrow(const AuthException(message: 'Code has expired'));

      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<OtpExpiredFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('maps "invalid code" to Failure.invalidOtp', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenThrow(const AuthException(message: 'The invalid verification code'));

      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<InvalidOtpFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('maps "too many attempts" to Failure.tooManyAttempts', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenThrow(
        const AuthException(message: 'Too many attempts. Please wait.'),
      );

      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<TooManyAttemptsFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('maps "invalid phone" to Failure.auth with message', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenThrow(
        const AuthException(message: 'The invalid phone number provided'),
      );

      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          final authFailure = failure as AuthFailure;
          expect(authFailure.message, contains('invalid phone'));
        },
        (_) => fail('Expected Left'),
      );
    });
  });

  // ==================== verifyOtp ====================

  group('verifyOtp', () {
    test('returns Right(User) for existing user', () async {
      final tUserModel = _createTestUserModel();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.verifyOtp(
            phoneNumber: _phoneNumber,
            otp: '123456',
          )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => tUserModel);

      final result = await repository.verifyOtp(
        verificationId: _phoneNumber,
        otp: '123456',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id, equals(_uid));
          expect(user.phoneNumber, equals(_phoneNumber));
          expect(user.hasCompletedOnboarding, isTrue);
        },
      );
      // Should NOT call createUser for existing users
      verifyNever(() => mockUserRemoteDataSource.createUser(any()));
    });

    test('creates new user when getUserById returns null', () async {
      final tNewUserModel = _createTestUserModel(
        hasCompletedOnboarding: false,
      );
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.verifyOtp(
            phoneNumber: _phoneNumber,
            otp: '123456',
          )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => null);
      when(() => mockUserRemoteDataSource.createUser(any()))
          .thenAnswer((_) async => tNewUserModel);

      final result = await repository.verifyOtp(
        verificationId: _phoneNumber,
        otp: '123456',
      );

      expect(result.isRight(), isTrue);
      verify(() => mockUserRemoteDataSource.createUser(any())).called(1);
    });

    test('new user has hasAcceptedTerms=true, hasCompletedOnboarding=false',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.verifyOtp(
            phoneNumber: _phoneNumber,
            otp: '123456',
          )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => null);
      when(() => mockUserRemoteDataSource.createUser(any()))
          .thenAnswer((invocation) async {
        final capturedModel =
            invocation.positionalArguments[0] as UserModel;
        return capturedModel;
      });

      final result = await repository.verifyOtp(
        verificationId: _phoneNumber,
        otp: '123456',
      );

      expect(result.isRight(), isTrue);

      // Verify the UserModel passed to createUser
      final captured = verify(
        () => mockUserRemoteDataSource.createUser(captureAny()),
      ).captured.single as UserModel;

      expect(captured.hasAcceptedTerms, isTrue);
      expect(captured.hasCompletedOnboarding, isFalse);
      expect(captured.userId, equals(_uid));
      expect(captured.phoneNumber, equals(_phoneNumber));
      expect(captured.displayName, equals('iMali User'));
      expect(captured.status, equals(UserStatus.active));
      expect(captured.isPotEligible, isFalse);
    });

    test('returns Left(Failure.network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.verifyOtp(
        verificationId: _phoneNumber,
        otp: '123456',
      );

      expect(result, equals(const Left(Failure.network())));
    });

    test('returns Left(Failure.auth) when userCredential.user is null',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.verifyOtp(
            phoneNumber: _phoneNumber,
            otp: '123456',
          )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(null);

      final result = await repository.verifyOtp(
        verificationId: _phoneNumber,
        otp: '123456',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          final authFailure = failure as AuthFailure;
          expect(authFailure.message, equals('Authentication failed'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('maps AuthException correctly', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.verifyOtp(
            phoneNumber: _phoneNumber,
            otp: '123456',
          )).thenThrow(
        const AuthException(message: 'Code has expired. Request a new one.'),
      );

      final result = await repository.verifyOtp(
        verificationId: _phoneNumber,
        otp: '123456',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<OtpExpiredFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ==================== signOut ====================

  group('signOut', () {
    test('returns Right(null) on success', () async {
      when(() => mockAuthRemoteDataSource.signOut())
          .thenAnswer((_) async {});

      final result = await repository.signOut();

      expect(result, equals(const Right(null)));
      verify(() => mockAuthRemoteDataSource.signOut()).called(1);
    });

    test('resets OTP cooldown (sendOtp works immediately after)', () async {
      // First, send an OTP to set the cooldown
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.sendOtp(phoneNumber: _phoneNumber))
          .thenAnswer((_) async {});
      await repository.sendOtp(phoneNumber: _phoneNumber);

      // Sign out (should reset cooldown)
      when(() => mockAuthRemoteDataSource.signOut())
          .thenAnswer((_) async {});
      await repository.signOut();

      // Send OTP again should succeed (no cooldown)
      final result = await repository.sendOtp(phoneNumber: _phoneNumber);

      expect(result.isRight(), isTrue);
    });

    test('returns Left(Failure) on error', () async {
      when(() => mockAuthRemoteDataSource.signOut())
          .thenThrow(Exception('Sign out failed'));

      final result = await repository.signOut();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ==================== deleteAccount ====================

  group('deleteAccount', () {
    test('returns Right(null) on success', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.deleteAccount())
          .thenAnswer((_) async {});

      final result = await repository.deleteAccount();

      expect(result, equals(const Right(null)));
      verify(() => mockAuthRemoteDataSource.deleteAccount()).called(1);
    });

    test('returns Left(Failure.network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.deleteAccount();

      expect(result, equals(const Left(Failure.network())));
      verifyNever(() => mockAuthRemoteDataSource.deleteAccount());
    });

    test('returns Left(Failure) on AuthException', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.deleteAccount())
          .thenThrow(const AuthException(message: 'Deletion failed'));

      final result = await repository.deleteAccount();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<AuthFailure>());
          final authFailure = failure as AuthFailure;
          expect(authFailure.message, equals('Deletion failed'));
        },
        (_) => fail('Expected Left'),
      );
    });
  });

  // ==================== signInWithCustomToken ====================

  group('signInWithCustomToken', () {
    const tToken = 'custom-token-abc';

    test('returns Right(User) for existing user', () async {
      final tUserModel = _createTestUserModel();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.signInWithCustomToken(tToken))
          .thenAnswer((_) async => mockUserCredential);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => tUserModel);

      final result = await repository.signInWithCustomToken(tToken);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id, equals(_uid));
          expect(user.phoneNumber, equals(_phoneNumber));
        },
      );
      verifyNever(() => mockUserRemoteDataSource.createUser(any()));
    });

    test('creates new user when not found', () async {
      final tNewUserModel = _createTestUserModel(
        hasCompletedOnboarding: false,
      );
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockAuthRemoteDataSource.signInWithCustomToken(tToken))
          .thenAnswer((_) async => mockUserCredential);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => null);
      when(() => mockUserRemoteDataSource.createUser(any()))
          .thenAnswer((_) async => tNewUserModel);

      final result = await repository.signInWithCustomToken(tToken);

      expect(result.isRight(), isTrue);

      // Verify the created user has correct defaults
      final captured = verify(
        () => mockUserRemoteDataSource.createUser(captureAny()),
      ).captured.single as UserModel;
      expect(captured.hasAcceptedTerms, isTrue);
      expect(captured.hasCompletedOnboarding, isFalse);
      expect(captured.status, equals(UserStatus.active));
    });

    test('returns Left(Failure.network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.signInWithCustomToken(tToken);

      expect(result, equals(const Left(Failure.network())));
    });
  });

  // ==================== clearLocalCache ====================

  group('clearLocalCache', () {
    test('calls appDatabase.clearAllData()', () async {
      when(() => mockAppDatabase.clearAllData())
          .thenAnswer((_) async {});

      await repository.clearLocalCache();

      verify(() => mockAppDatabase.clearAllData()).called(1);
    });
  });

  // ==================== authStateChanges ====================

  group('authStateChanges', () {
    test('emits User when firebase user changes and Firestore user found',
        () async {
      final tUserModel = _createTestUserModel();
      final controller = StreamController<firebase_auth.User?>();

      when(() => mockAuthRemoteDataSource.authStateChanges)
          .thenAnswer((_) => controller.stream);
      when(() => mockUserRemoteDataSource.getUserById(_uid))
          .thenAnswer((_) async => tUserModel);

      final stream = repository.authStateChanges;

      expectLater(
        stream,
        emits(predicate<domain.User?>((user) {
          if (user == null) return false;
          return user.id == _uid && user.phoneNumber == _phoneNumber;
        })),
      );

      controller.add(mockFirebaseUser);

      // Allow async mapping to complete
      await Future.delayed(Duration.zero);

      await controller.close();
    });

    test('emits null when firebase user is null', () async {
      final controller = StreamController<firebase_auth.User?>();

      when(() => mockAuthRemoteDataSource.authStateChanges)
          .thenAnswer((_) => controller.stream);

      final stream = repository.authStateChanges;

      expectLater(stream, emits(isNull));

      controller.add(null);

      await Future.delayed(Duration.zero);

      await controller.close();
    });
  });
}
