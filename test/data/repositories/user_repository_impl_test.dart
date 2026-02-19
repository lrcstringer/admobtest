import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/data/datasources/remote/auth_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/user_remote_datasource.dart';
import 'package:imalichat/data/models/user_model.dart';
import 'package:imalichat/data/repositories/user_repository_impl.dart';
import 'package:imalichat/domain/enums/user_status.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

// ==================== FALLBACK VALUES ====================

class FakeUserModel extends Fake implements UserModel {}

// ==================== TEST FIXTURES ====================

const _userId = 'user123';
const _phoneNumber = '+27612345678';

UserModel _createTestUserModel({
  String userId = _userId,
  String phoneNumber = _phoneNumber,
  String displayName = 'Test User',
  bool hasAcceptedTerms = true,
  bool hasCompletedOnboarding = true,
}) {
  return UserModel(
    userId: userId,
    phoneNumber: phoneNumber,
    displayName: displayName,
    status: UserStatus.active,
    hasAcceptedTerms: hasAcceptedTerms,
    hasCompletedOnboarding: hasCompletedOnboarding,
    isPotEligible: false,
    createdAt: DateTime(2024, 1, 1),
  );
}

// ==================== TESTS ====================

void main() {
  late MockUserRemoteDataSource mockUserDataSource;
  late MockAuthRemoteDataSource mockAuthDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockFirebaseUser mockFirebaseUser;
  late UserRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeUserModel());
  });

  setUp(() {
    mockUserDataSource = MockUserRemoteDataSource();
    mockAuthDataSource = MockAuthRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockFirebaseUser = MockFirebaseUser();
    repository = UserRepositoryImpl(
      mockUserDataSource,
      mockAuthDataSource,
      mockNetworkInfo,
    );

    when(() => mockFirebaseUser.uid).thenReturn(_userId);
    when(() => mockFirebaseUser.phoneNumber).thenReturn(_phoneNumber);
  });

  // ===========================================================================
  // getUserById
  // ===========================================================================

  group('getUserById', () {
    test('returns Right(User) when connected and user found', () async {
      final testUserModel = _createTestUserModel();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => testUserModel);

      final result = await repository.getUserById(_userId);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id, _userId);
          expect(user.phoneNumber, _phoneNumber);
        },
      );
    });

    test('returns Left(serverError) when user not found', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => null);

      final result = await repository.getUserById(_userId);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
            failure, const Failure.serverError(message: 'User not found')),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left(network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getUserById(_userId);

      expect(result, const Left(Failure.network()));
      verifyNever(() => mockUserDataSource.getUserById(any()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenThrow(const ServerException(message: 'Firestore error'));

      final result = await repository.getUserById(_userId);

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // getCurrentUser
  // ===========================================================================

  group('getCurrentUser', () {
    test('returns Right(User) when firebase user exists and user found',
        () async {
      final testUserModel = _createTestUserModel();
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => testUserModel);

      final result = await repository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id, _userId);
          expect(user.phoneNumber, _phoneNumber);
        },
      );
    });

    test('returns Left(unauthenticated) when no firebase user', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(null);

      final result = await repository.getCurrentUser();

      expect(result, const Left(Failure.unauthenticated()));
      verifyNever(() => mockUserDataSource.getUserById(any()));
    });
  });

  // ===========================================================================
  // watchCurrentUser
  // ===========================================================================

  group('watchCurrentUser', () {
    test('emits Right(User) when firebase user exists and user data streams',
        () async {
      final testUserModel = _createTestUserModel();
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.watchUser(_userId))
          .thenAnswer((_) => Stream.value(testUserModel));

      final stream = repository.watchCurrentUser();
      final emission = await stream.first;

      expect(emission.isRight(), isTrue);
      emission.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id, _userId);
          expect(user.phoneNumber, _phoneNumber);
        },
      );
    });

    test('emits Left(unauthenticated) when no firebase user', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(null);

      final stream = repository.watchCurrentUser();
      final emission = await stream.first;

      expect(emission, const Left(Failure.unauthenticated()));
    });

    test('emits Left(serverError) when user data is null in stream', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.watchUser(_userId))
          .thenAnswer((_) => Stream.value(null));

      final stream = repository.watchCurrentUser();
      final emission = await stream.first;

      expect(emission.isLeft(), isTrue);
      emission.fold(
        (failure) => expect(
            failure, const Failure.serverError(message: 'User not found')),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // createUser
  // ===========================================================================

  group('createUser', () {
    test('returns Right(User) on success', () async {
      final testUserModel = _createTestUserModel(
        hasAcceptedTerms: false,
        hasCompletedOnboarding: false,
      );
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.createUser(any()))
          .thenAnswer((_) async => testUserModel);

      final result = await repository.createUser(
        userId: _userId,
        phoneNumber: _phoneNumber,
        displayName: 'Test User',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.id, _userId);
          expect(user.phoneNumber, _phoneNumber);
        },
      );
      verify(() => mockUserDataSource.createUser(any())).called(1);
    });

    test('returns Left(network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.createUser(
        userId: _userId,
        phoneNumber: _phoneNumber,
        displayName: 'Test User',
      );

      expect(result, const Left(Failure.network()));
      verifyNever(() => mockUserDataSource.createUser(any()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.createUser(any()))
          .thenThrow(const ServerException(message: 'Create failed'));

      final result = await repository.createUser(
        userId: _userId,
        phoneNumber: _phoneNumber,
        displayName: 'Test User',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // updateProfile
  // ===========================================================================

  group('updateProfile', () {
    test('returns Right(User) after merging updated fields', () async {
      final existingUser = _createTestUserModel();
      final updatedUser = _createTestUserModel(displayName: 'New Name');
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => existingUser);
      when(() => mockUserDataSource.updateUser(any()))
          .thenAnswer((_) async => updatedUser);

      final result = await repository.updateProfile(
        userId: _userId,
        displayName: 'New Name',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (user) {
          expect(user.profile?.displayName, 'New Name');
        },
      );

      // Verify updateUser was called with merged data
      final captured =
          verify(() => mockUserDataSource.updateUser(captureAny())).captured;
      final updatedModel = captured.first as UserModel;
      expect(updatedModel.displayName, 'New Name');
    });

    test('returns Left(network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.updateProfile(
        userId: _userId,
        displayName: 'New Name',
      );

      expect(result, const Left(Failure.network()));
    });

    test('returns Left(serverError) when user not found', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => null);

      final result = await repository.updateProfile(
        userId: _userId,
        displayName: 'New Name',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
            failure, const Failure.serverError(message: 'User not found')),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left(serverError) on ServerException during update',
        () async {
      final existingUser = _createTestUserModel();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => existingUser);
      when(() => mockUserDataSource.updateUser(any()))
          .thenThrow(const ServerException(message: 'Update failed'));

      final result = await repository.updateProfile(
        userId: _userId,
        displayName: 'New Name',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // isUsernameAvailable
  // ===========================================================================

  group('isUsernameAvailable', () {
    test('returns Right(true) when username is available', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.isUsernameAvailable('newuser'))
          .thenAnswer((_) async => true);

      final result = await repository.isUsernameAvailable('newuser');

      expect(result, const Right(true));
    });

    test('returns Right(false) when username is taken', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.isUsernameAvailable('takenuser'))
          .thenAnswer((_) async => false);

      final result = await repository.isUsernameAvailable('takenuser');

      expect(result, const Right(false));
    });

    test('returns Left(network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.isUsernameAvailable('anyuser');

      expect(result, const Left(Failure.network()));
      verifyNever(() => mockUserDataSource.isUsernameAvailable(any()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.isUsernameAvailable('test'))
          .thenThrow(const ServerException(message: 'Query failed'));

      final result = await repository.isUsernameAvailable('test');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // searchByUsername
  // ===========================================================================

  group('searchByUsername', () {
    test('returns Right(List<User>) on success', () async {
      final testUserModel = _createTestUserModel();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockUserDataSource.searchByUsername('test'))
          .thenAnswer((_) async => [testUserModel]);

      final result = await repository.searchByUsername('test');

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (users) {
          expect(users.length, 1);
          expect(users.first.id, _userId);
        },
      );
    });

    test('returns Left(network) when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.searchByUsername('test');

      expect(result, const Left(Failure.network()));
    });
  });

  // ===========================================================================
  // acceptTerms
  // ===========================================================================

  group('acceptTerms', () {
    test('returns Right(null) on success and sets hasAcceptedTerms', () async {
      final existingUser =
          _createTestUserModel(hasAcceptedTerms: false);
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => existingUser);
      when(() => mockUserDataSource.updateUser(any()))
          .thenAnswer((_) async => existingUser.copyWith(
                hasAcceptedTerms: true,
              ));

      final result = await repository.acceptTerms();

      expect(result, const Right(null));

      // Verify the updated model has hasAcceptedTerms = true
      final captured =
          verify(() => mockUserDataSource.updateUser(captureAny())).captured;
      final updatedModel = captured.first as UserModel;
      expect(updatedModel.hasAcceptedTerms, isTrue);
    });

    test('returns Left(unauthenticated) when not signed in', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(null);

      final result = await repository.acceptTerms();

      expect(result, const Left(Failure.unauthenticated()));
      verifyNever(() => mockUserDataSource.getUserById(any()));
    });

    test('returns Left(serverError) when user not found', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => null);

      final result = await repository.acceptTerms();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
            failure, const Failure.serverError(message: 'User not found')),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // completeOnboarding
  // ===========================================================================

  group('completeOnboarding', () {
    test('returns Right(null) on success and sets hasCompletedOnboarding',
        () async {
      final existingUser =
          _createTestUserModel(hasCompletedOnboarding: false);
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.getUserById(_userId))
          .thenAnswer((_) async => existingUser);
      when(() => mockUserDataSource.updateUser(any()))
          .thenAnswer((_) async => existingUser.copyWith(
                hasCompletedOnboarding: true,
              ));

      final result = await repository.completeOnboarding();

      expect(result, const Right(null));

      // Verify the updated model has hasCompletedOnboarding = true
      final captured =
          verify(() => mockUserDataSource.updateUser(captureAny())).captured;
      final updatedModel = captured.first as UserModel;
      expect(updatedModel.hasCompletedOnboarding, isTrue);
    });

    test('returns Left(unauthenticated) when not signed in', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(null);

      final result = await repository.completeOnboarding();

      expect(result, const Left(Failure.unauthenticated()));
      verifyNever(() => mockUserDataSource.getUserById(any()));
    });
  });

  // ===========================================================================
  // updateFcmToken
  // ===========================================================================

  group('updateFcmToken', () {
    test('returns Right(null) on success', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.updateFcmToken(_userId, 'new_token'))
          .thenAnswer((_) async {});

      final result = await repository.updateFcmToken('new_token');

      expect(result, const Right(null));
      verify(() => mockUserDataSource.updateFcmToken(_userId, 'new_token'))
          .called(1);
    });

    test('returns Left(unauthenticated) when not signed in', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(null);

      final result = await repository.updateFcmToken('token');

      expect(result, const Left(Failure.unauthenticated()));
      verifyNever(() => mockUserDataSource.updateFcmToken(any(), any()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.updateFcmToken(_userId, 'token'))
          .thenThrow(const ServerException(message: 'FCM update failed'));

      final result = await repository.updateFcmToken('token');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // updateLastActive
  // ===========================================================================

  group('updateLastActive', () {
    test('returns Right(null) on success', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.updateLastActive(_userId))
          .thenAnswer((_) async {});

      final result = await repository.updateLastActive();

      expect(result, const Right(null));
      verify(() => mockUserDataSource.updateLastActive(_userId)).called(1);
    });

    test('returns Left(unauthenticated) when not signed in', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(null);

      final result = await repository.updateLastActive();

      expect(result, const Left(Failure.unauthenticated()));
      verifyNever(() => mockUserDataSource.updateLastActive(any()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockAuthDataSource.currentUser).thenReturn(mockFirebaseUser);
      when(() => mockUserDataSource.updateLastActive(_userId))
          .thenThrow(const ServerException(message: 'Update failed'));

      final result = await repository.updateLastActive();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
