import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/device_binding_service.dart';
import 'package:imalichat/core/services/biometric_login_service.dart';
import 'package:imalichat/core/services/call_notification_service.dart';
import 'package:imalichat/core/services/key_backup_service.dart';
import 'package:imalichat/core/services/community_sync_service.dart';
import 'package:imalichat/core/services/media_recovery_service.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/notification_service.dart';
import 'package:imalichat/core/services/offline_action_queue.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/domain/entities/trusted_device.dart';
import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/repositories/auth_repository.dart';
import 'package:imalichat/domain/repositories/user_repository.dart';
import 'package:imalichat/presentation/blocs/auth/auth_bloc.dart';

import '../../helpers/e2ee_test_helpers.dart';
import '../../helpers/test_helpers.dart';

class MockNotificationService extends Mock implements NotificationService {}

class MockCallNotificationService extends Mock implements CallNotificationService {}

class MockMediaRecoveryService extends Mock implements MediaRecoveryService {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockDeviceBindingService extends Mock implements DeviceBindingService {}

class MockBiometricLoginService extends Mock implements BiometricLoginService {}

class MockMessageSyncService extends Mock implements MessageSyncService {}

class MockOfflineActionQueue extends Mock implements OfflineActionQueue {}

class MockCommunitySyncService extends Mock implements CommunitySyncService {}

class MockOutgoingMessageQueue extends Mock implements OutgoingMessageQueue {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late MockDeviceBindingService mockDeviceBindingService;
  late MockBiometricLoginService mockBiometricLoginService;
  late MockKeyManagementService mockKeyManagementService;
  late MockSignalProtocolService mockSignalProtocolService;
  late MockKeyBackupService mockKeyBackupService;
  late StreamController<User?> authStateController;

  final testKeyBundle = E2EETestData.createTestKeyBundle();

  setUpAll(() {
    registerFallbackValue(E2EETestData.createTestKeyBundle());
  });

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
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockDeviceBindingService = MockDeviceBindingService();
    mockBiometricLoginService = MockBiometricLoginService();
    mockKeyManagementService = MockKeyManagementService();
    mockSignalProtocolService = MockSignalProtocolService();
    mockKeyBackupService = MockKeyBackupService();
    authStateController = StreamController<User?>.broadcast();

    // Register GetIt services that AuthBloc resolves during authenticated state
    final gi = GetIt.instance;
    final mockNotificationService = MockNotificationService();
    final mockCallNotificationService = MockCallNotificationService();
    final mockMediaRecoveryService = MockMediaRecoveryService();
    final mockAppDatabase = MockAppDatabase();

    when(() => mockNotificationService.initialize()).thenAnswer((_) async {});
    when(() => mockCallNotificationService.saveVoipToken()).thenAnswer((_) async {});
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

    // Default stubs for backup service
    when(() => mockKeyBackupService.autoBackup())
        .thenAnswer((_) async {});
    when(() => mockKeyBackupService.autoRestore())
        .thenAnswer((_) async => false);

    // Stub migration method added in Phase 0
    when(() => mockSignalProtocolService.migrateResetCorruptedSessions())
        .thenAnswer((_) async => false);
    when(() => mockSignalProtocolService.resetAllSessions())
        .thenAnswer((_) async {});
    when(() => mockSignalProtocolService.clearAllSessions())
        .thenAnswer((_) async {});

    // Default stubs shared by all tests
    when(() => mockAuthRepository.authStateChanges)
        .thenAnswer((_) => authStateController.stream);
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

    // Default: no existing keys (triggers full generation)
    when(() => mockKeyManagementService.loadPrivateKeys())
        .thenAnswer((_) async => null);
    when(() => mockKeyManagementService.generateKeyBundle())
        .thenAnswer((_) async => testKeyBundle);
    when(() => mockKeyManagementService.storePrivateKeys(any()))
        .thenAnswer((_) async {});
    when(() => mockKeyManagementService.uploadKeyBundle(any()))
        .thenAnswer((_) async {});
    when(() => mockKeyManagementService.replenishOneTimePreKeysIfNeeded())
        .thenAnswer((_) async {});
    when(() => mockKeyManagementService.ensureBundleUploaded(any()))
        .thenAnswer((_) async {});
    when(() => mockKeyManagementService.removeConsumedOtk(any()))
        .thenAnswer((_) async {});
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

  group('AuthBloc - E2EE Key Initialization', () {
    // =========================================================================
    // checkAuthStatus → triggers _initializeE2EEKeys
    // =========================================================================

    group('checkAuthStatus triggers E2EE key init', () {
      blocTest<AuthBloc, AuthState>(
        'authenticated user triggers _initializeE2EEKeys',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          // Allow fire-and-forget to complete
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser)
              .having((s) => s.keyRestoreFailed, 'keyRestoreFailed', false),
          // E2EE key init completes: no local keys + autoRestore returns false → keyRestoreFailed
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.keyRestoreFailed, 'keyRestoreFailed', true),
        ],
        verify: (_) {
          verify(() => mockKeyManagementService.loadPrivateKeys()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'no E2EE key init when auth check fails (stays unauthenticated)',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated),
        ],
        verify: (_) {
          verifyNever(() => mockKeyManagementService.loadPrivateKeys());
        },
      );

      blocTest<AuthBloc, AuthState>(
        'no E2EE key init when user is null (unauthenticated)',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Right(null));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.unauthenticated),
        ],
        verify: (_) {
          verifyNever(() => mockKeyManagementService.loadPrivateKeys());
        },
      );

      blocTest<AuthBloc, AuthState>(
        'no E2EE key init when user needs onboarding',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.userNeedsOnboarding));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having(
                  (s) => s.status, 'status', AuthStatus.onboardingRequired),
        ],
        verify: (_) {
          // _initializeE2EEKeys is NOT called for onboarding users
          verifyNever(() => mockKeyManagementService.loadPrivateKeys());
        },
      );
    });

    // =========================================================================
    // loadPrivateKeys returns existing KeyBundle → replenish OTKs
    // =========================================================================

    group('existing keys path', () {
      blocTest<AuthBloc, AuthState>(
        'loadPrivateKeys returns KeyBundle → replenishOneTimePreKeysIfNeeded called',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenAnswer((_) async => testKeyBundle);
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        verify: (_) {
          verify(() => mockKeyManagementService.loadPrivateKeys()).called(1);
          verify(() =>
                  mockKeyManagementService.replenishOneTimePreKeysIfNeeded())
              .called(1);
          // Should NOT generate new keys
          verifyNever(() => mockKeyManagementService.generateKeyBundle());
          verifyNever(
              () => mockKeyManagementService.storePrivateKeys(any()));
          // Should NOT attempt restore (keys already exist)
          verifyNever(() => mockKeyBackupService.autoRestore());
          // autoBackup is called fire-and-forget after successful init
          verify(() => mockKeyBackupService.autoBackup()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'second auth check skips key generation if keys already exist',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenAnswer((_) async => testKeyBundle);
          return createBloc();
        },
        act: (bloc) async {
          // First check
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 200));
          // Second check — _e2eeInitInProgress guard prevents re-entry
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 200));
        },
        verify: (_) {
          // loadPrivateKeys called once (second check skipped by _e2eeInitInProgress guard
          // or called twice if first completes before second starts)
          verify(() => mockKeyManagementService.loadPrivateKeys())
              .called(greaterThanOrEqualTo(1));
          // replenish called at least once
          verify(() =>
                  mockKeyManagementService.replenishOneTimePreKeysIfNeeded())
              .called(greaterThanOrEqualTo(1));
          // Never generates since keys exist
          verifyNever(() => mockKeyManagementService.generateKeyBundle());
        },
      );
    });

    // =========================================================================
    // loadPrivateKeys returns null → full key generation
    // =========================================================================

    group('new keys path', () {
      blocTest<AuthBloc, AuthState>(
        'loadPrivateKeys returns null → autoRestore fails → generateKeyBundle → storePrivateKeys → uploadKeyBundle',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          // No existing keys
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenAnswer((_) async => null);
          // autoRestore returns false (no backup)
          when(() => mockKeyBackupService.autoRestore())
              .thenAnswer((_) async => false);
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        verify: (_) {
          verify(() => mockKeyManagementService.loadPrivateKeys()).called(1);
          // autoRestore is tried first
          verify(() => mockKeyBackupService.autoRestore()).called(1);
          verify(() => mockKeyManagementService.generateKeyBundle()).called(1);
          verify(() => mockKeyManagementService.storePrivateKeys(testKeyBundle))
              .called(1);
          verify(() => mockKeyManagementService.uploadKeyBundle(testKeyBundle))
              .called(1);
        },
      );
    });

    // =========================================================================
    // E2EE failure is non-fatal
    // =========================================================================

    group('E2EE failures are non-fatal', () {
      blocTest<AuthBloc, AuthState>(
        '_initializeE2EEKeys failure does not prevent authenticated emission',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenThrow(Exception('Secure storage corrupted'));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.user, 'user', TestData.testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'uploadKeyBundle failure is caught (non-fatal)',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenAnswer((_) async => null);
          // autoRestore returns false (no backup)
          when(() => mockKeyBackupService.autoRestore())
              .thenAnswer((_) async => false);
          when(() => mockKeyManagementService.uploadKeyBundle(any()))
              .thenThrow(Exception('Upload failed'));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'replenishOneTimePreKeysIfNeeded failure is caught (non-fatal)',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenAnswer((_) async => testKeyBundle);
          when(() =>
                  mockKeyManagementService.replenishOneTimePreKeysIfNeeded())
              .thenThrow(Exception('Replenish failed'));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'generateKeyBundle failure is caught (non-fatal)',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenAnswer((_) async => null);
          // autoRestore returns false (no backup)
          when(() => mockKeyBackupService.autoRestore())
              .thenAnswer((_) async => false);
          when(() => mockKeyManagementService.generateKeyBundle())
              .thenThrow(Exception('Key generation failed'));
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated),
        ],
      );
    });

    // =========================================================================
    // completeOnboarding → triggers _initializeE2EEKeys
    // =========================================================================

    group('completeOnboarding triggers E2EE key init', () {
      blocTest<AuthBloc, AuthState>(
        'completeOnboarding → authenticated → calls _initializeE2EEKeys',
        build: () {
          when(() => mockUserRepository.completeOnboarding())
              .thenAnswer((_) async => const Right(null));
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(
                    TestData.userNeedsOnboarding.copyWith(
                      hasCompletedOnboarding: true,
                    ),
                  ));
          return createBloc();
        },
        seed: () => AuthState(
          user: TestData.userNeedsOnboarding.copyWith(hasAcceptedTerms: true),
          status: AuthStatus.onboardingRequired,
        ),
        act: (bloc) async {
          bloc.add(const AuthEvent.completeOnboarding());
          await Future.delayed(const Duration(milliseconds: 100));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.keyRestoreFailed, 'keyRestoreFailed', false),
          // E2EE key init: no local keys + autoRestore false → keyRestoreFailed
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated)
              .having((s) => s.keyRestoreFailed, 'keyRestoreFailed', true),
        ],
        verify: (_) {
          verify(() => mockKeyManagementService.loadPrivateKeys()).called(1);
        },
      );
    });

    // =========================================================================
    // E2EE init is fire-and-forget (does not block auth emission)
    // =========================================================================

    group('fire-and-forget behavior', () {
      blocTest<AuthBloc, AuthState>(
        'E2EE key init does not block authenticated state emission',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => Right(TestData.testUser));
          // Simulate slow key generation
          when(() => mockKeyManagementService.loadPrivateKeys())
              .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 500));
            return null;
          });
          when(() => mockKeyManagementService.generateKeyBundle())
              .thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 500));
            return testKeyBundle;
          });
          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const AuthEvent.checkAuthStatus());
          // Only wait a short time — auth should already be emitted
          await Future.delayed(const Duration(milliseconds: 50));
        },
        expect: () => [
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.loading),
          isA<AuthState>()
              .having((s) => s.status, 'status', AuthStatus.authenticated),
        ],
      );
    });
  });
}
