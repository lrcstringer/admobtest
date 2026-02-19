import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/user_engagement_stats.dart';
import 'package:imalichat/domain/entities/user_profile.dart';
import 'package:imalichat/domain/repositories/user_repository.dart';
import 'package:imalichat/domain/repositories/wallet_repository.dart';
import 'package:imalichat/presentation/blocs/profile/profile_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockWalletRepository extends Mock implements WalletRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late MockWalletRepository mockWalletRepository;

  final testEngagementStats = UserEngagementStats(
    userId: 'user123',
    currentStreak: 5,
    longestStreak: 10,
    totalEngagementsCompleted: 50,
    totalTokensEarned: 5000,
    updatedAt: DateTime(2024, 1, 1),
  );

  final testUserWithProfile = TestData.testUser.copyWith(
    profile: const UserProfile(
      displayName: 'John Doe',
      username: 'johndoe',
      gender: 'Male',
      dateOfBirth: null,
    ),
  );

  final updatedUser = testUserWithProfile.copyWith(
    profile: testUserWithProfile.profile!.copyWith(
      displayName: 'Jane Doe',
      firstName: 'Jane',
      lastName: 'Doe',
    ),
  );

  ProfileBloc createBloc() => ProfileBloc(
        mockUserRepository,
        mockWalletRepository,
      );

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockWalletRepository = MockWalletRepository();

    // Default stub: watchCurrentUser returns an empty stream
    when(() => mockUserRepository.watchCurrentUser())
        .thenAnswer((_) => const Stream.empty());
  });

  group('ProfileBloc', () {
    test('initial state is correct', () {
      final bloc = createBloc();
      expect(bloc.state.status, ProfileStatus.initial);
      expect(bloc.state.user, isNull);
      expect(bloc.state.isUpdating, false);
      expect(bloc.state.isCheckingUsername, false);
      expect(bloc.state.usernameAvailable, isNull);
      expect(bloc.state.updateSuccess, false);
      expect(bloc.state.lifetimeEarned, 0);
      expect(bloc.state.lifetimeWithdrawn, 0);
      bloc.close();
    });

    // =========================================================================
    // LoadProfile
    // =========================================================================
    group('LoadProfile', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [loading, loaded] with user and engagement stats on success',
        build: () {
          when(() => mockUserRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockWalletRepository.getEngagementStats())
              .thenAnswer((_) async => Right(testEngagementStats));
          return createBloc();
        },
        act: (bloc) => bloc.add(const ProfileEvent.loadProfile()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loading),
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loaded)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.lifetimeEarned, 'lifetimeEarned', 5000)
              .having((s) => s.lifetimeWithdrawn, 'lifetimeWithdrawn', 0),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [loading, loaded] with zero lifetimeEarned when stats fail',
        build: () {
          when(() => mockUserRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockWalletRepository.getEngagementStats())
              .thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) => bloc.add(const ProfileEvent.loadProfile()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loading),
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loaded)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.lifetimeEarned, 'lifetimeEarned', 0),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [loading, error] when getCurrentUser fails',
        build: () {
          when(() => mockUserRepository.getCurrentUser())
              .thenAnswer((_) async =>
                  const Left(Failure.serverError(message: 'Server error')));
          return createBloc();
        },
        act: (bloc) => bloc.add(const ProfileEvent.loadProfile()),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loading),
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', 'Server error'),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [loading, error] when getCurrentUser throws an exception',
        build: () {
          when(() => mockUserRepository.getCurrentUser())
              .thenThrow(Exception('Unexpected error'));
          return createBloc();
        },
        act: (bloc) => bloc.add(const ProfileEvent.loadProfile()),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loading),
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'triggers watchProfile after successful load',
        build: () {
          when(() => mockUserRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockWalletRepository.getEngagementStats())
              .thenAnswer((_) async => Right(testEngagementStats));
          return createBloc();
        },
        act: (bloc) => bloc.add(const ProfileEvent.loadProfile()),
        wait: const Duration(milliseconds: 50),
        verify: (_) {
          verify(() => mockUserRepository.watchCurrentUser()).called(1);
        },
      );
    });

    // =========================================================================
    // WatchProfile
    // =========================================================================
    group('WatchProfile', () {
      blocTest<ProfileBloc, ProfileState>(
        'updates user when stream emits new user data',
        build: () {
          when(() => mockUserRepository.watchCurrentUser()).thenAnswer(
            (_) => Stream.value(Right(updatedUser)),
          );
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const ProfileEvent.watchProfile()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.user, 'user', updatedUser),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'ignores failures from user stream',
        build: () {
          when(() => mockUserRepository.watchCurrentUser()).thenAnswer(
            (_) => Stream.value(const Left(Failure.network())),
          );
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const ProfileEvent.watchProfile()),
        wait: const Duration(milliseconds: 50),
        // No state changes expected since failures are ignored
        expect: () => [],
      );
    });

    // =========================================================================
    // UserUpdated
    // =========================================================================
    group('UserUpdated', () {
      blocTest<ProfileBloc, ProfileState>(
        'updates user in state',
        build: () => createBloc(),
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(ProfileEvent.userUpdated(updatedUser)),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.user, 'user', updatedUser)
              .having((s) => s.status, 'status', ProfileStatus.loaded),
        ],
      );
    });

    // =========================================================================
    // UpdateProfile
    // =========================================================================
    group('UpdateProfile', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [updating, updated with success] when update succeeds',
        build: () {
          when(() => mockUserRepository.updateProfile(
                userId: any(named: 'userId'),
                displayName: any(named: 'displayName'),
                firstName: any(named: 'firstName'),
                lastName: any(named: 'lastName'),
                gender: any(named: 'gender'),
                dateOfBirth: any(named: 'dateOfBirth'),
                province: any(named: 'province'),
                avatarUrl: any(named: 'avatarUrl'),
              )).thenAnswer((_) async => Right(updatedUser));
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: testUserWithProfile,
        ),
        act: (bloc) => bloc.add(const ProfileEvent.updateProfile(
          displayName: 'Jane Doe',
          firstName: 'Jane',
          lastName: 'Doe',
        )),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', true)
              .having((s) => s.updateError, 'updateError', isNull),
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', false)
              .having((s) => s.user, 'user', updatedUser)
              .having((s) => s.updateSuccess, 'updateSuccess', true),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [updating, error] when update fails',
        build: () {
          when(() => mockUserRepository.updateProfile(
                userId: any(named: 'userId'),
                displayName: any(named: 'displayName'),
                firstName: any(named: 'firstName'),
                lastName: any(named: 'lastName'),
                gender: any(named: 'gender'),
                dateOfBirth: any(named: 'dateOfBirth'),
                province: any(named: 'province'),
                avatarUrl: any(named: 'avatarUrl'),
              )).thenAnswer((_) async =>
                  const Left(Failure.serverError(message: 'Update failed')));
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: testUserWithProfile,
        ),
        act: (bloc) => bloc.add(const ProfileEvent.updateProfile(
          displayName: 'Jane Doe',
        )),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', true),
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', false)
              .having((s) => s.updateError, 'updateError', 'Update failed'),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'does nothing when user is null',
        build: () => createBloc(),
        seed: () => const ProfileState(status: ProfileStatus.initial),
        act: (bloc) => bloc.add(const ProfileEvent.updateProfile(
          displayName: 'Jane Doe',
        )),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockUserRepository.updateProfile(
                userId: any(named: 'userId'),
                displayName: any(named: 'displayName'),
                firstName: any(named: 'firstName'),
                lastName: any(named: 'lastName'),
                gender: any(named: 'gender'),
                dateOfBirth: any(named: 'dateOfBirth'),
                province: any(named: 'province'),
                avatarUrl: any(named: 'avatarUrl'),
              ));
        },
      );
    });

    // =========================================================================
    // UpdateUsername
    // =========================================================================
    group('UpdateUsername', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [updating, updated] when username update succeeds',
        build: () {
          final userWithNewUsername = testUserWithProfile.copyWith(
            profile: testUserWithProfile.profile!.copyWith(username: 'newname'),
          );
          when(() => mockUserRepository.updateProfile(
                userId: any(named: 'userId'),
                username: any(named: 'username'),
              )).thenAnswer((_) async => Right(userWithNewUsername));
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: testUserWithProfile,
        ),
        act: (bloc) =>
            bloc.add(const ProfileEvent.updateUsername('newname')),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', true)
              .having((s) => s.updateError, 'updateError', isNull),
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', false)
              .having((s) => s.updateSuccess, 'updateSuccess', true)
              .having(
                  (s) => s.user?.profile?.username, 'username', 'newname'),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [updating, error] when username update fails',
        build: () {
          when(() => mockUserRepository.updateProfile(
                userId: any(named: 'userId'),
                username: any(named: 'username'),
              )).thenAnswer((_) async =>
                  const Left(Failure.invalidUsername()));
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: testUserWithProfile,
        ),
        act: (bloc) =>
            bloc.add(const ProfileEvent.updateUsername('ab')),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', true),
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', false)
              .having((s) => s.updateError, 'updateError', isNotNull),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'does nothing when user is null',
        build: () => createBloc(),
        seed: () => const ProfileState(status: ProfileStatus.initial),
        act: (bloc) =>
            bloc.add(const ProfileEvent.updateUsername('newname')),
        expect: () => [],
      );
    });

    // =========================================================================
    // CheckUsername
    // =========================================================================
    group('CheckUsername', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [checking, available=true] when username is available',
        build: () {
          when(() => mockUserRepository.isUsernameAvailable(any()))
              .thenAnswer((_) async => const Right(true));
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const ProfileEvent.checkUsername('uniquename')),
        expect: () => [
          isA<ProfileState>()
              .having(
                  (s) => s.isCheckingUsername, 'isCheckingUsername', true)
              .having((s) => s.usernameAvailable, 'usernameAvailable', isNull),
          isA<ProfileState>()
              .having(
                  (s) => s.isCheckingUsername, 'isCheckingUsername', false)
              .having((s) => s.usernameAvailable, 'usernameAvailable', true),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [checking, available=false] when username is taken',
        build: () {
          when(() => mockUserRepository.isUsernameAvailable(any()))
              .thenAnswer((_) async => const Right(false));
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const ProfileEvent.checkUsername('takenname')),
        expect: () => [
          isA<ProfileState>()
              .having(
                  (s) => s.isCheckingUsername, 'isCheckingUsername', true)
              .having((s) => s.usernameAvailable, 'usernameAvailable', isNull),
          isA<ProfileState>()
              .having(
                  (s) => s.isCheckingUsername, 'isCheckingUsername', false)
              .having((s) => s.usernameAvailable, 'usernameAvailable', false),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [checking, available=null] when check fails',
        build: () {
          when(() => mockUserRepository.isUsernameAvailable(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const ProfileEvent.checkUsername('anyname')),
        expect: () => [
          isA<ProfileState>()
              .having(
                  (s) => s.isCheckingUsername, 'isCheckingUsername', true)
              .having((s) => s.usernameAvailable, 'usernameAvailable', isNull),
          isA<ProfileState>()
              .having(
                  (s) => s.isCheckingUsername, 'isCheckingUsername', false)
              .having((s) => s.usernameAvailable, 'usernameAvailable', isNull),
        ],
      );
    });

    // =========================================================================
    // AcceptTerms
    // =========================================================================
    group('AcceptTerms', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits updating then triggers loadProfile on success',
        build: () {
          when(() => mockUserRepository.acceptTerms())
              .thenAnswer((_) async => const Right(null));
          // loadProfile will be triggered, so we need to stub getCurrentUser
          when(() => mockUserRepository.getCurrentUser())
              .thenAnswer((_) async => Right(
                    TestData.testUser.copyWith(hasAcceptedTerms: true),
                  ));
          when(() => mockWalletRepository.getEngagementStats())
              .thenAnswer((_) async => Right(testEngagementStats));
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const ProfileEvent.acceptTerms()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // isUpdating = true
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', true),
          // loadProfile triggers loading
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loading),
          // loadProfile completes with loaded
          isA<ProfileState>()
              .having((s) => s.status, 'status', ProfileStatus.loaded)
              .having(
                  (s) => s.user?.hasAcceptedTerms, 'hasAcceptedTerms', true),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [updating, error] when acceptTerms fails',
        build: () {
          when(() => mockUserRepository.acceptTerms())
              .thenAnswer((_) async =>
                  const Left(Failure.serverError(message: 'Terms error')));
          return createBloc();
        },
        seed: () => ProfileState(
          status: ProfileStatus.loaded,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const ProfileEvent.acceptTerms()),
        expect: () => [
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', true),
          isA<ProfileState>()
              .having((s) => s.isUpdating, 'isUpdating', false)
              .having((s) => s.updateError, 'updateError', 'Terms error'),
        ],
      );
    });

    // =========================================================================
    // ProfileState extensions
    // =========================================================================
    group('ProfileState extensions', () {
      test('isLoading returns true when status is loading', () {
        const state = ProfileState(status: ProfileStatus.loading);
        expect(state.isLoading, true);
      });

      test('isLoaded returns true when status is loaded', () {
        const state = ProfileState(status: ProfileStatus.loaded);
        expect(state.isLoaded, true);
      });

      test('hasError returns true when status is error', () {
        const state = ProfileState(status: ProfileStatus.error);
        expect(state.hasError, true);
      });

      test('hasUser returns true when user is present', () {
        final state = ProfileState(user: TestData.testUser);
        expect(state.hasUser, true);
      });

      test('hasUser returns false when user is null', () {
        const state = ProfileState();
        expect(state.hasUser, false);
      });

      test('displayName falls back to "User" when no user', () {
        const state = ProfileState();
        expect(state.displayName, 'User');
      });

      test('displayName returns user displayName when user has profile', () {
        final state = ProfileState(user: testUserWithProfile);
        expect(state.displayName, 'John Doe');
      });

      test('username returns null when no user', () {
        const state = ProfileState();
        expect(state.username, isNull);
      });

      test('username returns user username', () {
        final state = ProfileState(user: testUserWithProfile);
        expect(state.username, 'johndoe');
      });

      test('needsOnboarding returns true when no user', () {
        const state = ProfileState();
        expect(state.needsOnboarding, true);
      });

      test('needsOnboarding returns false for complete user', () {
        final state = ProfileState(user: TestData.testUser);
        expect(state.needsOnboarding, false);
      });

      test('canCashout returns false when no user', () {
        const state = ProfileState();
        expect(state.canCashout, false);
      });
    });
  });
}
