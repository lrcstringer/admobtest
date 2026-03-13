import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/device_binding_service.dart';
import 'package:imalichat/core/services/biometric_login_service.dart';
import 'package:imalichat/core/services/call_notification_service.dart';
import 'package:imalichat/core/services/key_backup_service.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/core/services/community_sync_service.dart';
import 'package:imalichat/core/services/media_recovery_service.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/notification_service.dart';
import 'package:imalichat/core/services/offline_action_queue.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
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

class MockKeyManagementService extends Mock implements KeyManagementService {}

class MockSignalProtocolService extends Mock implements SignalProtocolService {}

class MockMessageSyncService extends Mock implements MessageSyncService {}

class MockOfflineActionQueue extends Mock implements OfflineActionQueue {}

class MockCommunitySyncService extends Mock implements CommunitySyncService {}

class MockOutgoingMessageQueue extends Mock implements OutgoingMessageQueue {}

class MockNotificationService extends Mock implements NotificationService {}

class MockCallNotificationService extends Mock implements CallNotificationService {}

class MockKeyBackupService extends Mock implements KeyBackupService {}

class MockMediaRecoveryService extends Mock implements MediaRecoveryService {}

class MockAppDatabase extends Mock implements AppDatabase {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late MockDeviceBindingService mockDeviceBindingService;
  late MockBiometricLoginService mockBiometricLoginService;
  late MockKeyManagementService mockKeyManagementService;
  late MockSignalProtocolService mockSignalProtocolService;
  late StreamController<User?> authStateController;

  AuthBloc createBloc() => AuthBloc(
        mockAuthRepository,
        mockUserRepository,
        mockDeviceBindingService,
        mockBiometricLoginService,
        mockKeyManagementService,
        mockSignalProtocolService,
        MockMessageSyncService(),
        MockOfflineActionQueue(),
        MockCommunitySyncService(),
        MockOutgoingMessageQueue(),
      );

  setUp(() {
    SharedPreferences.setMockInitialValues({});

    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockDeviceBindingService = MockDeviceBindingService();
    mockBiometricLoginService = MockBiometricLoginService();
    mockKeyManagementService = MockKeyManagementService();
    mockSignalProtocolService = MockSignalProtocolService();
    authStateController = StreamController<User?>.broadcast();

    // Register GetIt services that AuthBloc resolves during authenticated state
    final gi = GetIt.instance;
    final mockNotificationService = MockNotificationService();
    final mockCallNotificationService = MockCallNotificationService();
    final mockKeyBackupService = MockKeyBackupService();
    final mockMediaRecoveryService = MockMediaRecoveryService();
    final mockAppDatabase = MockAppDatabase();

    when(() => mockNotificationService.initialize()).thenAnswer((_) async {});
    when(() => mockCallNotificationService.saveVoipToken()).thenAnswer((_) async {});
    when(() => mockKeyBackupService.autoRestore()).thenAnswer((_) async => false);
    when(() => mockKeyBackupService.autoBackup()).thenAnswer((_) async {});
    when(() => mockMediaRecoveryService.initialize()).thenAnswer((_) async => true);
    when(() => mockAppDatabase.clearMessageCacheIfUserChanged(any())).thenAnswer((_) => Future.value(false));
    when(() => mockAppDatabase.purgeUndecryptableMessages()).thenAnswer((_) async => 0);

    if (gi.isRegistered<NotificationService>()) gi.unregister<NotificationService>();
    if (gi.isRegistered<CallNotificationService>()) gi.unregister<CallNotificationService>();
    if (gi.isRegistered<KeyBackupService>()) gi.unregister<KeyBackupService>();
    if (gi.isRegistered<MediaRecoveryService>()) gi.unregister<MediaRecoveryService>();
    if (gi.isRegistered<AppDatabase>()) gi.unregister<AppDatabase>();

    gi.registerSingleton<NotificationService>(mockNotificationService);
    gi.registerSingleton<CallNotificationService>(mockCallNotificationService);
    gi.registerSingleton<KeyBackupService>(mockKeyBackupService);
    gi.registerSingleton<MediaRecoveryService>(mockMediaRecoveryService);
    gi.registerSingleton<AppDatabase>(mockAppDatabase);

    // Stub SignalProtocolService methods called during sign-out / E2EE init
    when(() => mockSignalProtocolService.resetAllSessions())
        .thenAnswer((_) async {});
    when(() => mockSignalProtocolService.clearAllSessions())
        .thenAnswer((_) async {});
    when(() => mockSignalProtocolService.migrateResetCorruptedSessions())
        .thenAnswer((_) async => false);

    when(() => mockAuthRepository.authStateChanges)
        .thenAnswer((_) => authStateController.stream);
    when(() => mockAuthRepository.clearLocalCache())
        .thenAnswer((_) async {});
    when(() => mockBiometricLoginService.recordSuccessfulAuth())
        .thenAnswer((_) async {});
    when(() => mockDeviceBindingService.clearBinding())
        .thenAnswer((_) async {});
    when(() => mockDeviceBindingService.bindCurrentDevice(any()))
        .thenAnswer((_) async => Right(TrustedDevice(
              deviceId: 'mock_device',
              userId: 'user123',
              publicKeyPem: 'mock_key',
              platform: 'android',
              trusted: true,
              revoked: false,
              registeredAt: DateTime(2024, 1, 1),
            )));
    // Stub E2EE key init (fire-and-forget in auth flow)
    when(() => mockKeyManagementService.loadPrivateKeys())
        .thenAnswer((_) async => null);
  });

  tearDown(() {
    authStateController.close();
    final gi = GetIt.instance;
    if (gi.isRegistered<NotificationService>()) gi.unregister<NotificationService>();
    if (gi.isRegistered<CallNotificationService>()) gi.unregister<CallNotificationService>();
    if (gi.isRegistered<KeyBackupService>()) gi.unregister<KeyBackupService>();
    if (gi.isRegistered<MediaRecoveryService>()) gi.unregister<MediaRecoveryService>();
    if (gi.isRegistered<AppDatabase>()) gi.unregister<AppDatabase>();
  });

  group('AuthBloc', () {
    test('initial state is correct', () {
      final bloc = createBloc();
      expect(bloc.state.status, AuthStatus.initial);
      expect(bloc.state.user, isNull);
      expect(bloc.state.isLoading, false);
      bloc.close();
    });

    group('CheckAuthStatus', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, authenticated] when user is found and complete',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.checkAuthStatus()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading)
              .having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.isLoading, 'isLoading', false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, onboardingRequired] when user needs onboarding',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.userNeedsOnboarding));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.checkAuthStatus()),
        expect: () => [
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.onboardingRequired)
              .having((s) => s.user, 'user', TestData.userNeedsOnboarding),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when no user found',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.checkAuthStatus()),
        expect: () => [
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated)
              .having((s) => s.isLoading, 'isLoading', false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when getCurrentUser fails',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.checkAuthStatus()),
        expect: () => [
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.unauthenticated),
        ],
      );
    });

    group('SendOtp', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, otpSent, countdown] when sendOtp succeeds',
        build: () {
          when(() => mockAuthRepository.sendOtp(phoneNumber: any(named: 'phoneNumber')))
              .thenAnswer((_) async => const Right('verification_id_123'));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.sendOtp(phoneNumber: '+27612345678')),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading)
              .having((s) => s.phoneNumber, 'phoneNumber', '+27612345678'),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.otpSent)
              .having((s) => s.verificationId, 'verificationId', 'verification_id_123'),
          isA<AuthState>()
              .having((s) => s.resendCountdown, 'resendCountdown', 60),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, error] when sendOtp fails',
        build: () {
          when(() => mockAuthRepository.sendOtp(phoneNumber: any(named: 'phoneNumber')))
              .thenAnswer((_) async => const Left(Failure.invalidPhone()));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.sendOtp(phoneNumber: 'invalid')),
        expect: () => [
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('VerifyOtp', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, authenticated] when verifyOtp succeeds for complete user',
        build: () {
          when(() => mockAuthRepository.verifyOtp(
                verificationId: any(named: 'verificationId'),
                otp: any(named: 'otp'),
              )).thenAnswer((_) async => Right(TestData.testUser));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.verifyOtp(
          verificationId: 'verification_id_123',
          otp: '123456',
        )),
        expect: () => [
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.verificationId, 'verificationId', isNull),
          // Device binding fires asynchronously after verify
          isA<AuthState>()
              .having((s) => s.isDeviceBound, 'isDeviceBound', true)
              .having((s) => s.deviceId, 'deviceId', 'mock_device'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, onboardingRequired, deviceBound] when user needs onboarding',
        build: () {
          when(() => mockAuthRepository.verifyOtp(
                verificationId: any(named: 'verificationId'),
                otp: any(named: 'otp'),
              )).thenAnswer((_) async => Right(TestData.userNeedsOnboarding));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.verifyOtp(
          verificationId: 'verification_id_123',
          otp: '123456',
        )),
        expect: () => [
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.onboardingRequired),
          // Device binding fires asynchronously after verify
          isA<AuthState>()
              .having((s) => s.isDeviceBound, 'isDeviceBound', true)
              .having((s) => s.deviceId, 'deviceId', 'mock_device'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [loading, error] when verifyOtp fails with invalid OTP',
        build: () {
          when(() => mockAuthRepository.verifyOtp(
                verificationId: any(named: 'verificationId'),
                otp: any(named: 'otp'),
              )).thenAnswer((_) async => const Left(Failure.invalidOtp()));
          return createBloc();
        },
        act: (bloc) => bloc.add(const AuthEvent.verifyOtp(
          verificationId: 'verification_id_123',
          otp: '000000',
        )),
        expect: () => [
          isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', contains('Invalid')),
        ],
      );
    });

    group('ResendOtp', () {
      blocTest<AuthBloc, AuthState>(
        'does nothing when countdown is active',
        build: () => createBloc(),
        seed: () => const AuthState(resendCountdown: 30),
        act: (bloc) => bloc.add(const AuthEvent.resendOtp(phoneNumber: '+27612345678')),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockAuthRepository.sendOtp(phoneNumber: any(named: 'phoneNumber')));
        },
      );

      blocTest<AuthBloc, AuthState>(
        'resends OTP when countdown is 0',
        build: () {
          when(() => mockAuthRepository.sendOtp(phoneNumber: any(named: 'phoneNumber')))
              .thenAnswer((_) async => const Right('new_verification_id'));
          return createBloc();
        },
        seed: () => const AuthState(resendCountdown: 0),
        act: (bloc) => bloc.add(const AuthEvent.resendOtp(phoneNumber: '+27612345678')),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.verificationId, 'verificationId', 'new_verification_id')
              .having((s) => s.isLoading, 'isLoading', false),
          isA<AuthState>()
              .having((s) => s.resendCountdown, 'resendCountdown', 60),
        ],
      );
    });

    group('SignOut', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when signOut succeeds',
        build: () {
          when(() => mockAuthRepository.signOut())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        seed: () => AuthState(user: TestData.testUser, status: AuthStatus.authenticated),
        act: (bloc) => bloc.add(const AuthEvent.signOut()),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated)
              .having((s) => s.user, 'user', isNull),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits error when signOut fails',
        build: () {
          when(() => mockAuthRepository.signOut())
              .thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        seed: () => AuthState(user: TestData.testUser, status: AuthStatus.authenticated),
        act: (bloc) => bloc.add(const AuthEvent.signOut()),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('DeleteAccount', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, unauthenticated] when deleteAccount succeeds',
        build: () {
          when(() => mockAuthRepository.deleteAccount())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        seed: () => AuthState(user: TestData.testUser, status: AuthStatus.authenticated),
        act: (bloc) => bloc.add(const AuthEvent.deleteAccount()),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated),
        ],
      );
    });

    group('AcceptTerms', () {
      blocTest<AuthBloc, AuthState>(
        'updates user with hasAcceptedTerms = true when acceptTerms succeeds',
        build: () {
          when(() => mockUserRepository.acceptTerms())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        seed: () => AuthState(
          user: TestData.userNeedsOnboarding.copyWith(hasAcceptedTerms: false),
          status: AuthStatus.onboardingRequired,
        ),
        act: (bloc) => bloc.add(const AuthEvent.acceptTerms()),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.user?.hasAcceptedTerms, 'hasAcceptedTerms', true),
        ],
      );
    });

    group('CompleteOnboarding', () {
      blocTest<AuthBloc, AuthState>(
        'emits [loading, authenticated] when onboarding is completed',
        build: () {
          when(() => mockUserRepository.completeOnboarding())
              .thenAnswer((_) async => const Right(null));
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          return createBloc();
        },
        seed: () => AuthState(
          user: TestData.userNeedsOnboarding.copyWith(hasAcceptedTerms: true),
          status: AuthStatus.onboardingRequired,
        ),
        act: (bloc) => bloc.add(const AuthEvent.completeOnboarding()),
        expect: () => [
          isA<AuthState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.isLoading, 'isLoading', false),
        ],
      );
    });

    group('AuthState helpers', () {
      test('isAuthenticated returns true when user is not null', () {
        final state = AuthState(user: TestData.testUser);
        expect(state.isAuthenticated, true);
      });

      test('isAuthenticated returns false when user is null', () {
        const state = AuthState();
        expect(state.isAuthenticated, false);
      });

      test('needsOnboarding returns true when user needs onboarding', () {
        final state = AuthState(user: TestData.userNeedsOnboarding);
        expect(state.needsOnboarding, true);
      });

      test('otpSent returns true when verificationId is not null', () {
        const state = AuthState(verificationId: 'verification_id');
        expect(state.otpSent, true);
      });
    });
  });
}
