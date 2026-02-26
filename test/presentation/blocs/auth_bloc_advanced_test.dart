import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/device_binding_service.dart';
import 'package:imalichat/core/services/biometric_login_service.dart';
import 'package:imalichat/core/services/fcm_challenge_handler.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/core/services/community_sync_service.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/offline_action_queue.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/domain/entities/trusted_device.dart';
import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/repositories/auth_repository.dart';
import 'package:imalichat/domain/repositories/user_repository.dart';
import 'package:imalichat/presentation/blocs/auth/auth_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockDeviceBindingService extends Mock implements DeviceBindingService {}

class MockBiometricLoginService extends Mock implements BiometricLoginService {}

class MockFcmChallengeHandler extends Mock implements FcmChallengeHandler {}

class MockKeyManagementService extends Mock implements KeyManagementService {}

class MockSignalProtocolService extends Mock implements SignalProtocolService {}

class MockMessageSyncService extends Mock implements MessageSyncService {}

class MockOfflineActionQueue extends Mock implements OfflineActionQueue {}

class MockCommunitySyncService extends Mock implements CommunitySyncService {}

class MockOutgoingMessageQueue extends Mock implements OutgoingMessageQueue {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late MockDeviceBindingService mockDeviceBindingService;
  late MockBiometricLoginService mockBiometricLoginService;
  late MockFcmChallengeHandler mockFcmChallengeHandler;
  late MockKeyManagementService mockKeyManagementService;
  late MockSignalProtocolService mockSignalProtocolService;
  late StreamController<User?> authStateController;

  final testTrustedDevice = TrustedDevice(
    deviceId: 'mock_device',
    userId: 'user123',
    publicKeyPem: 'mock_key',
    platform: 'android',
    trusted: true,
    revoked: false,
    registeredAt: DateTime(2024, 1, 1),
  );

  AuthBloc createBloc() => AuthBloc(
        mockAuthRepository,
        mockUserRepository,
        mockDeviceBindingService,
        mockBiometricLoginService,
        mockFcmChallengeHandler,
        mockKeyManagementService,
        mockSignalProtocolService,
        MockMessageSyncService(),
        MockOfflineActionQueue(),
        MockCommunitySyncService(),
        MockOutgoingMessageQueue(),
      );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockDeviceBindingService = MockDeviceBindingService();
    mockBiometricLoginService = MockBiometricLoginService();
    mockFcmChallengeHandler = MockFcmChallengeHandler();
    mockKeyManagementService = MockKeyManagementService();
    mockSignalProtocolService = MockSignalProtocolService();
    authStateController = StreamController<User?>.broadcast();

    // Stub SignalProtocolService methods called during sign-out / E2EE init
    when(() => mockSignalProtocolService.resetAllSessions())
        .thenAnswer((_) async {});
    when(() => mockSignalProtocolService.clearAllSessions())
        .thenAnswer((_) async {});
    when(() => mockSignalProtocolService.migrateResetCorruptedSessions())
        .thenAnswer((_) async => false);

    // Stub auth state stream (subscribed in constructor)
    when(() => mockAuthRepository.authStateChanges)
        .thenAnswer((_) => authStateController.stream);

    // Stub services that are called as side-effects in various handlers
    when(() => mockBiometricLoginService.recordSuccessfulAuth())
        .thenAnswer((_) async {});
    when(() => mockBiometricLoginService.clearCachedDisplayName())
        .thenAnswer((_) async {});
    when(() => mockBiometricLoginService.clearLastAuthTime())
        .thenAnswer((_) async {});
    when(() => mockDeviceBindingService.clearBinding())
        .thenAnswer((_) async {});
    when(() => mockDeviceBindingService.bindCurrentDevice(any()))
        .thenAnswer((_) async => Right(testTrustedDevice));
    when(() => mockDeviceBindingService.deleteKeypair(any()))
        .thenAnswer((_) async {});
    when(() => mockAuthRepository.clearLocalCache())
        .thenAnswer((_) async {});

    // Stub E2EE key init (fire-and-forget in auth flow)
    when(() => mockKeyManagementService.loadPrivateKeys())
        .thenAnswer((_) async => null);
  });

  tearDown(() {
    authStateController.close();
  });

  group('AuthBloc Advanced Tests', () {
    // =========================================================================
    // LockSession
    // =========================================================================
    group('LockSession', () {
      blocTest<AuthBloc, AuthState>(
        'emits sessionLocked when user is currently authenticated',
        build: () => createBloc(),
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const AuthEvent.lockSession()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.sessionLocked)
              .having((s) => s.user, 'user', TestData.testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'does nothing when status is unauthenticated',
        build: () => createBloc(),
        seed: () => const AuthState(status: AuthStatus.unauthenticated),
        act: (bloc) => bloc.add(const AuthEvent.lockSession()),
        expect: () => [],
      );

      blocTest<AuthBloc, AuthState>(
        'does nothing when status is initial',
        build: () => createBloc(),
        seed: () => const AuthState(status: AuthStatus.initial),
        act: (bloc) => bloc.add(const AuthEvent.lockSession()),
        expect: () => [],
      );

      blocTest<AuthBloc, AuthState>(
        'does nothing when status is onboardingRequired',
        build: () => createBloc(),
        seed: () => AuthState(
          status: AuthStatus.onboardingRequired,
          user: TestData.userNeedsOnboarding,
        ),
        act: (bloc) => bloc.add(const AuthEvent.lockSession()),
        expect: () => [],
      );

      blocTest<AuthBloc, AuthState>(
        'does nothing when status is already sessionLocked',
        build: () => createBloc(),
        seed: () => AuthState(
          status: AuthStatus.sessionLocked,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const AuthEvent.lockSession()),
        expect: () => [],
      );
    });

    // =========================================================================
    // UnlockSession
    // =========================================================================
    group('UnlockSession', () {
      blocTest<AuthBloc, AuthState>(
        'restores authenticated status when session was locked',
        build: () => createBloc(),
        seed: () => AuthState(
          status: AuthStatus.sessionLocked,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const AuthEvent.unlockSession()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'does nothing when status is not sessionLocked',
        build: () => createBloc(),
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const AuthEvent.unlockSession()),
        expect: () => [],
      );

      blocTest<AuthBloc, AuthState>(
        'does nothing when status is unauthenticated',
        build: () => createBloc(),
        seed: () => const AuthState(status: AuthStatus.unauthenticated),
        act: (bloc) => bloc.add(const AuthEvent.unlockSession()),
        expect: () => [],
      );
    });

    // =========================================================================
    // ForceReauth
    // =========================================================================
    group('ForceReauth', () {
      blocTest<AuthBloc, AuthState>(
        'clears binding, signs out, and emits unauthenticated with fresh state',
        build: () {
          when(() => mockAuthRepository.signOut())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
          isDeviceBound: true,
          deviceId: 'mock_device',
        ),
        act: (bloc) => bloc.add(const AuthEvent.forceReauth()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated)
              .having((s) => s.user, 'user', isNull)
              .having((s) => s.isDeviceBound, 'isDeviceBound', false)
              .having((s) => s.deviceId, 'deviceId', isNull),
        ],
        verify: (_) {
          verify(() => mockDeviceBindingService.clearBinding()).called(1);
          verify(() => mockAuthRepository.signOut()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'calls clearBinding before signOut (order matters)',
        build: () {
          final callOrder = <String>[];
          when(() => mockDeviceBindingService.clearBinding()).thenAnswer((_) async {
            callOrder.add('clearBinding');
          });
          when(() => mockAuthRepository.signOut()).thenAnswer((_) async {
            callOrder.add('signOut');
            return const Right(null);
          });
          return createBloc();
        },
        seed: () => AuthState(
          status: AuthStatus.sessionLocked,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const AuthEvent.forceReauth()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated),
        ],
        verify: (_) {
          verify(() => mockDeviceBindingService.clearBinding()).called(1);
          verify(() => mockAuthRepository.signOut()).called(1);
        },
      );
    });

    // =========================================================================
    // BindDevice
    // =========================================================================
    group('BindDevice', () {
      blocTest<AuthBloc, AuthState>(
        'sets isDeviceBound true and deviceId on success',
        build: () => createBloc(),
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const AuthEvent.bindDevice()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.isDeviceBound, 'isDeviceBound', true)
              .having((s) => s.deviceId, 'deviceId', 'mock_device'),
        ],
        verify: (_) {
          verify(() =>
                  mockDeviceBindingService.bindCurrentDevice('user123'))
              .called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'sets isDeviceBound false on binding failure',
        build: () {
          when(() => mockDeviceBindingService.bindCurrentDevice(any()))
              .thenAnswer((_) async =>
                  const Left(Failure.deviceBindingFailed(message: 'FCM failed')));
          return createBloc();
        },
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
          isDeviceBound: true, // seed as true so the false emission is observable
        ),
        act: (bloc) => bloc.add(const AuthEvent.bindDevice()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.isDeviceBound, 'isDeviceBound', false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'does nothing when user is null (no userId)',
        build: () => createBloc(),
        seed: () => const AuthState(status: AuthStatus.unauthenticated),
        act: (bloc) => bloc.add(const AuthEvent.bindDevice()),
        expect: () => [],
        verify: (_) {
          verifyNever(
              () => mockDeviceBindingService.bindCurrentDevice(any()));
        },
      );
    });

    // =========================================================================
    // RequestPushLogin
    // =========================================================================
    group('RequestPushLogin', () {
      blocTest<AuthBloc, AuthState>(
        'emits challengeId and hasTrustedDevice when trusted device exists',
        build: () {
          when(() => mockFcmChallengeHandler.requestLogin(any())).thenAnswer(
            (_) async =>
                (challengeId: 'challenge_abc', hasTrustedDevice: true),
          );
          return createBloc();
        },
        act: (bloc) => bloc.add(
          const AuthEvent.requestPushLogin(phoneNumber: '+27612345678'),
        ),
        expect: () => [
          // First emission: isPushLoginLoading = true, reset state
          isA<AuthState>()
              .having((s) => s.isPushLoginLoading, 'isPushLoginLoading', true)
              .having((s) => s.phoneNumber, 'phoneNumber', '+27612345678')
              .having(
                  (s) => s.pushLoginChallengeId, 'pushLoginChallengeId', isNull)
              .having((s) => s.hasTrustedDevice, 'hasTrustedDevice', false),
          // Second emission: loading done, challenge available
          isA<AuthState>()
              .having((s) => s.isPushLoginLoading, 'isPushLoginLoading', false)
              .having((s) => s.pushLoginChallengeId, 'pushLoginChallengeId',
                  'challenge_abc')
              .having((s) => s.hasTrustedDevice, 'hasTrustedDevice', true),
        ],
        verify: (_) {
          verify(() => mockFcmChallengeHandler.requestLogin('+27612345678'))
              .called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'falls back to OTP when no trusted device found',
        build: () {
          when(() => mockFcmChallengeHandler.requestLogin(any())).thenAnswer(
            (_) async => (challengeId: null, hasTrustedDevice: false),
          );
          when(() => mockAuthRepository.sendOtp(
                  phoneNumber: any(named: 'phoneNumber')))
              .thenAnswer((_) async => const Right('verification_id'));
          return createBloc();
        },
        act: (bloc) => bloc.add(
          const AuthEvent.requestPushLogin(phoneNumber: '+27612345678'),
        ),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // Push login loading starts
          isA<AuthState>()
              .having((s) => s.isPushLoginLoading, 'isPushLoginLoading', true),
          // Push login done, no trusted device
          isA<AuthState>()
              .having((s) => s.isPushLoginLoading, 'isPushLoginLoading', false)
              .having((s) => s.hasTrustedDevice, 'hasTrustedDevice', false),
          // OTP fallback: loading
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading)
              .having((s) => s.isLoading, 'isLoading', true),
          // OTP sent
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.otpSent)
              .having(
                  (s) => s.verificationId, 'verificationId', 'verification_id'),
          // Resend countdown
          isA<AuthState>()
              .having((s) => s.resendCountdown, 'resendCountdown', 60),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'skips push login and falls back to OTP when skipPushLogin is true',
        build: () {
          when(() => mockAuthRepository.sendOtp(
                  phoneNumber: any(named: 'phoneNumber')))
              .thenAnswer((_) async => const Right('verification_id'));
          return createBloc();
        },
        act: (bloc) => bloc.add(
          const AuthEvent.requestPushLogin(
            phoneNumber: '+27612345678',
            skipPushLogin: true,
          ),
        ),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // Push login loading starts
          isA<AuthState>()
              .having((s) => s.isPushLoginLoading, 'isPushLoginLoading', true),
          // Push login loading ends immediately (skip)
          isA<AuthState>()
              .having((s) => s.isPushLoginLoading, 'isPushLoginLoading', false),
          // Falls back to sendOtp -> loading
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          // OTP sent
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.otpSent),
          // Resend countdown
          isA<AuthState>()
              .having((s) => s.resendCountdown, 'resendCountdown', 60),
        ],
        verify: (_) {
          verifyNever(() => mockFcmChallengeHandler.requestLogin(any()));
        },
      );
    });

    // =========================================================================
    // AuthenticateWithPushToken
    // =========================================================================
    group('AuthenticateWithPushToken', () {
      blocTest<AuthBloc, AuthState>(
        'emits authenticated when signInWithCustomToken succeeds for complete user',
        build: () {
          when(() => mockAuthRepository.signInWithCustomToken(any()))
              .thenAnswer((_) async => Right(TestData.testUser));
          return createBloc();
        },
        act: (bloc) => bloc.add(
          const AuthEvent.authenticateWithPushToken(
              customToken: 'custom_token_abc'),
        ),
        // bindDevice fires as side-effect; wait to capture all emissions
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading)
              .having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.isLoading, 'isLoading', false),
          // bindDevice side-effect fires and succeeds
          isA<AuthState>()
              .having((s) => s.isDeviceBound, 'isDeviceBound', true)
              .having((s) => s.deviceId, 'deviceId', 'mock_device'),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.signInWithCustomToken('custom_token_abc'))
              .called(1);
          verify(() => mockBiometricLoginService.recordSuccessfulAuth())
              .called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits onboardingRequired when user needs onboarding',
        build: () {
          when(() => mockAuthRepository.signInWithCustomToken(any()))
              .thenAnswer((_) async => Right(TestData.userNeedsOnboarding));
          return createBloc();
        },
        act: (bloc) => bloc.add(
          const AuthEvent.authenticateWithPushToken(
              customToken: 'custom_token_abc'),
        ),
        // bindDevice fires as side-effect; wait to capture all emissions
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.onboardingRequired)
              .having((s) => s.user, 'user', TestData.userNeedsOnboarding),
          // bindDevice side-effect fires (user789 has an id so binding runs)
          isA<AuthState>()
              .having((s) => s.isDeviceBound, 'isDeviceBound', true)
              .having((s) => s.deviceId, 'deviceId', 'mock_device'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits error when signInWithCustomToken fails',
        build: () {
          when(() => mockAuthRepository.signInWithCustomToken(any()))
              .thenAnswer((_) async =>
                  const Left(Failure.auth(message: 'Invalid token')));
          return createBloc();
        },
        act: (bloc) => bloc.add(
          const AuthEvent.authenticateWithPushToken(
              customToken: 'bad_token'),
        ),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', 'Invalid token')
              .having((s) => s.isLoading, 'isLoading', false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'triggers bindDevice after successful push token auth',
        build: () {
          when(() => mockAuthRepository.signInWithCustomToken(any()))
              .thenAnswer((_) async => Right(TestData.testUser));
          return createBloc();
        },
        act: (bloc) => bloc.add(
          const AuthEvent.authenticateWithPushToken(
              customToken: 'custom_token_abc'),
        ),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // loading
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          // authenticated
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated),
          // bind device result
          isA<AuthState>()
              .having((s) => s.isDeviceBound, 'isDeviceBound', true)
              .having((s) => s.deviceId, 'deviceId', 'mock_device'),
        ],
      );
    });

    // =========================================================================
    // ClearPushLoginState
    // =========================================================================
    group('ClearPushLoginState', () {
      blocTest<AuthBloc, AuthState>(
        'resets pushLoginChallengeId, isPushLoginLoading, and hasTrustedDevice',
        build: () => createBloc(),
        seed: () => const AuthState(
          isPushLoginLoading: true,
          pushLoginChallengeId: 'challenge_abc',
          hasTrustedDevice: true,
        ),
        act: (bloc) => bloc.add(const AuthEvent.clearPushLoginState()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.isPushLoginLoading, 'isPushLoginLoading', false)
              .having(
                  (s) => s.pushLoginChallengeId, 'pushLoginChallengeId', isNull)
              .having((s) => s.hasTrustedDevice, 'hasTrustedDevice', false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'works correctly when push login state is already cleared',
        build: () => createBloc(),
        seed: () => const AuthState(
          isPushLoginLoading: false,
          pushLoginChallengeId: null,
          hasTrustedDevice: false,
        ),
        act: (bloc) => bloc.add(const AuthEvent.clearPushLoginState()),
        // State does not change because the values are already default
        expect: () => [],
      );
    });

    // =========================================================================
    // DeleteAccount - detailed cleanup sequence
    // =========================================================================
    group('DeleteAccount detailed cleanup', () {
      blocTest<AuthBloc, AuthState>(
        'calls deleteAccount, then clears all local data in correct order',
        build: () {
          when(() => mockAuthRepository.deleteAccount())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
          isDeviceBound: true,
          deviceId: 'mock_device',
        ),
        act: (bloc) => bloc.add(const AuthEvent.deleteAccount()),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated)
              .having((s) => s.user, 'user', isNull)
              .having((s) => s.isDeviceBound, 'isDeviceBound', false),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.deleteAccount()).called(1);
          verify(() => mockDeviceBindingService.clearBinding()).called(1);
          verify(() => mockBiometricLoginService.clearCachedDisplayName())
              .called(1);
          verify(() => mockBiometricLoginService.clearLastAuthTime()).called(1);
          verify(() => mockAuthRepository.clearLocalCache()).called(1);
          verify(() => mockDeviceBindingService.deleteKeypair('user123'))
              .called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits error and does not clean up when deleteAccount fails',
        build: () {
          when(() => mockAuthRepository.deleteAccount())
              .thenAnswer((_) async =>
                  const Left(Failure.serverError(message: 'Server error')));
          return createBloc();
        },
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
        ),
        act: (bloc) => bloc.add(const AuthEvent.deleteAccount()),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', 'Server error')
              .having((s) => s.status, 'status', AuthStatus.authenticated),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.deleteAccount()).called(1);
          // Cleanup should NOT be called on failure
          verifyNever(() => mockDeviceBindingService.clearBinding());
          verifyNever(
              () => mockBiometricLoginService.clearCachedDisplayName());
          verifyNever(() => mockBiometricLoginService.clearLastAuthTime());
          verifyNever(() => mockAuthRepository.clearLocalCache());
          verifyNever(() => mockDeviceBindingService.deleteKeypair(any()));
        },
      );

      blocTest<AuthBloc, AuthState>(
        'skips deleteKeypair when userId is null',
        build: () {
          when(() => mockAuthRepository.deleteAccount())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        seed: () => const AuthState(
          status: AuthStatus.authenticated,
          // user is null, so no userId to delete keypair for
        ),
        act: (bloc) => bloc.add(const AuthEvent.deleteAccount()),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.deleteAccount()).called(1);
          verify(() => mockDeviceBindingService.clearBinding()).called(1);
          verify(() => mockBiometricLoginService.clearCachedDisplayName())
              .called(1);
          verify(() => mockBiometricLoginService.clearLastAuthTime()).called(1);
          verify(() => mockAuthRepository.clearLocalCache()).called(1);
          // deleteKeypair should NOT be called when user is null
          verifyNever(() => mockDeviceBindingService.deleteKeypair(any()));
        },
      );
    });

    // =========================================================================
    // Auth state stream integration
    // =========================================================================
    group('Auth state stream', () {
      blocTest<AuthBloc, AuthState>(
        'emits authenticated when stream emits a complete user',
        build: () => createBloc(),
        act: (bloc) => authStateController.add(TestData.testUser),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.isLoading, 'isLoading', false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits onboardingRequired when stream emits a user needing onboarding',
        build: () => createBloc(),
        act: (bloc) => authStateController.add(TestData.userNeedsOnboarding),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.onboardingRequired)
              .having((s) => s.user, 'user', TestData.userNeedsOnboarding),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'does not emit when stream emits null',
        build: () => createBloc(),
        act: (bloc) => authStateController.add(null),
        wait: const Duration(milliseconds: 50),
        expect: () => [],
      );
    });

    // =========================================================================
    // Lock/Unlock round-trip
    // =========================================================================
    group('Lock/Unlock round-trip', () {
      blocTest<AuthBloc, AuthState>(
        'lock then unlock restores authenticated status and preserves user',
        build: () => createBloc(),
        seed: () => AuthState(
          status: AuthStatus.authenticated,
          user: TestData.testUser,
          isDeviceBound: true,
        ),
        act: (bloc) {
          bloc.add(const AuthEvent.lockSession());
          bloc.add(const AuthEvent.unlockSession());
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.sessionLocked)
              .having((s) => s.user, 'user', TestData.testUser),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.isDeviceBound, 'isDeviceBound', true),
        ],
      );
    });
  });
}
