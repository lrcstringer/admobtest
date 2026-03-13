import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/device_binding_service.dart';
import 'package:imalichat/core/security/device_capability_service.dart';
import 'package:imalichat/core/security/keystore_service.dart';
import 'package:imalichat/core/services/biometric_login_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------
class MockDeviceBindingService extends Mock implements DeviceBindingService {}

class MockDeviceCapabilityService extends Mock
    implements DeviceCapabilityService {}

class MockKeystoreService extends Mock implements KeystoreService {}

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult extends Mock
    implements HttpsCallableResult<Map<String, dynamic>> {}

// ---------------------------------------------------------------------------
// In-memory FlutterSecureStorage (same pattern as pin_manager_test.dart)
// ---------------------------------------------------------------------------
class InMemorySecureStorage extends Mock implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) _store[key] = value;
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store.remove(key);

  Map<String, String> get store => _store;
}

void main() {
  late MockDeviceBindingService mockDeviceBinding;
  late MockDeviceCapabilityService mockCapabilityService;
  late MockKeystoreService mockKeystoreService;
  late MockLocalAuthentication mockLocalAuth;
  late MockFirebaseFunctions mockFunctions;
  late InMemorySecureStorage secureStorage;
  late BiometricLoginService service;

  setUp(() {
    mockDeviceBinding = MockDeviceBindingService();
    mockCapabilityService = MockDeviceCapabilityService();
    mockKeystoreService = MockKeystoreService();
    mockLocalAuth = MockLocalAuthentication();
    mockFunctions = MockFirebaseFunctions();
    secureStorage = InMemorySecureStorage();

    service = BiometricLoginService(
      mockDeviceBinding,
      mockCapabilityService,
      mockKeystoreService,
      mockLocalAuth,
      mockFunctions,
      secureStorage,
    );
  });

  // -----------------------------------------------------------------------
  // Helper: set up storage with a recent auth time (within threshold)
  // -----------------------------------------------------------------------
  void seedRecentAuthTime() {
    final recent = DateTime.now().subtract(const Duration(days: 2));
    secureStorage.store['imali_last_auth_time'] = recent.toIso8601String();
  }

  // -----------------------------------------------------------------------
  // Helper: set up storage with an old auth time (beyond threshold)
  // -----------------------------------------------------------------------
  void seedOldAuthTime() {
    final old = DateTime.now().subtract(const Duration(days: 8));
    secureStorage.store['imali_last_auth_time'] = old.toIso8601String();
  }

  // -----------------------------------------------------------------------
  // canUseBiometricLogin
  // -----------------------------------------------------------------------
  group('canUseBiometricLogin', () {
    test(
        'returns true when binding exists, recent auth, and biometric tier',
        () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.biometric);
      seedRecentAuthTime();

      final result = await service.canUseBiometricLogin();

      expect(result, isTrue);
    });

    test('returns false when no device ID is stored', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => null);
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');

      final result = await service.canUseBiometricLogin();

      expect(result, isFalse);
    });

    test('returns false when no user ID is stored', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => null);

      final result = await service.canUseBiometricLogin();

      expect(result, isFalse);
    });

    test('returns false when inactivity threshold is exceeded (> 7 days)',
        () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');
      seedOldAuthTime();

      final result = await service.canUseBiometricLogin();

      expect(result, isFalse);
    });

    test('returns false when no auth time has been recorded', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');
      // No auth time in storage — treated as expired

      final result = await service.canUseBiometricLogin();

      expect(result, isFalse);
    });

    test('returns false when capability tier is otpOnly', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.otpOnly);
      seedRecentAuthTime();

      final result = await service.canUseBiometricLogin();

      expect(result, isFalse);
    });

    test('returns false when capability tier is inAppPin', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.inAppPin);
      seedRecentAuthTime();

      final result = await service.canUseBiometricLogin();

      expect(result, isFalse);
    });

    test('returns true when capability tier is deviceCredential', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.deviceCredential);
      seedRecentAuthTime();

      final result = await service.canUseBiometricLogin();

      expect(result, isTrue);
    });
  });

  // -----------------------------------------------------------------------
  // Inactivity threshold edge cases
  // -----------------------------------------------------------------------
  group('inactivity threshold', () {
    test('6 days ago is within threshold (canUseBiometricLogin true)',
        () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.biometric);

      final sixDaysAgo = DateTime.now().subtract(const Duration(days: 6));
      secureStorage.store['imali_last_auth_time'] =
          sixDaysAgo.toIso8601String();

      final result = await service.canUseBiometricLogin();

      expect(result, isTrue);
    });

    test('8 days ago exceeds threshold (canUseBiometricLogin false)',
        () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_123');

      final eightDaysAgo = DateTime.now().subtract(const Duration(days: 8));
      secureStorage.store['imali_last_auth_time'] =
          eightDaysAgo.toIso8601String();

      final result = await service.canUseBiometricLogin();

      expect(result, isFalse);
    });
  });

  // -----------------------------------------------------------------------
  // attemptBiometricLogin
  // -----------------------------------------------------------------------
  group('attemptBiometricLogin', () {
    test('returns Right(customToken) on successful full flow', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_456');

      // Step 1: Biometric prompt succeeds
      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            biometricOnly: any(named: 'biometricOnly'),
            persistAcrossBackgrounding:
                any(named: 'persistAcrossBackgrounding'),
          )).thenAnswer((_) async => true);

      // Step 2: Challenge request succeeds
      final challengeCallable = MockHttpsCallable();
      final challengeResult = MockHttpsCallableResult();
      when(() => mockFunctions.httpsCallable('requestBiometricChallenge'))
          .thenReturn(challengeCallable);
      when(() => challengeCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => challengeResult);
      when(() => challengeResult.data).thenReturn({
        'challengeId': 'challenge_abc',
        'nonce': 'nonce_xyz',
      });

      // Step 3: Signing succeeds
      final expectedAlias = KeystoreService.keyAlias('user_456');
      when(() => mockKeystoreService.sign(expectedAlias, 'nonce_xyz'))
          .thenAnswer((_) async => const Right('signed_nonce_data'));

      // Step 4: Verification succeeds
      final verifyCallable = MockHttpsCallable();
      final verifyResult = MockHttpsCallableResult();
      when(() => mockFunctions.httpsCallable('verifyBiometricChallenge'))
          .thenReturn(verifyCallable);
      when(() => verifyCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => verifyResult);
      when(() => verifyResult.data).thenReturn({
        'customToken': 'firebase_custom_token_123',
      });

      final result = await service.attemptBiometricLogin();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (token) => expect(token, equals('firebase_custom_token_123')),
      );
    });

    test('returns Left(deviceNotTrusted) when no device ID', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => null);
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_456');

      final result = await service.attemptBiometricLogin();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<DeviceNotTrustedFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left(deviceNotTrusted) when no user ID', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => null);

      final result = await service.attemptBiometricLogin();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<DeviceNotTrustedFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left when biometric authentication is cancelled', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_456');

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            biometricOnly: any(named: 'biometricOnly'),
            persistAcrossBackgrounding:
                any(named: 'persistAcrossBackgrounding'),
          )).thenAnswer((_) async => false);

      final result = await service.attemptBiometricLogin();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<AuthFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left when challenge request fails', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_456');

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            biometricOnly: any(named: 'biometricOnly'),
            persistAcrossBackgrounding:
                any(named: 'persistAcrossBackgrounding'),
          )).thenAnswer((_) async => true);

      final challengeCallable = MockHttpsCallable();
      when(() => mockFunctions.httpsCallable('requestBiometricChallenge'))
          .thenReturn(challengeCallable);
      when(() => challengeCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('Network error'));

      final result = await service.attemptBiometricLogin();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('returns Left when nonce signing fails', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_456');

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            biometricOnly: any(named: 'biometricOnly'),
            persistAcrossBackgrounding:
                any(named: 'persistAcrossBackgrounding'),
          )).thenAnswer((_) async => true);

      final challengeCallable = MockHttpsCallable();
      final challengeResult = MockHttpsCallableResult();
      when(() => mockFunctions.httpsCallable('requestBiometricChallenge'))
          .thenReturn(challengeCallable);
      when(() => challengeCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => challengeResult);
      when(() => challengeResult.data).thenReturn({
        'challengeId': 'challenge_abc',
        'nonce': 'nonce_xyz',
      });

      final expectedAlias = KeystoreService.keyAlias('user_456');
      when(() => mockKeystoreService.sign(expectedAlias, 'nonce_xyz'))
          .thenAnswer((_) async =>
              const Left(Failure.unknown(message: 'Key not found')));

      final result = await service.attemptBiometricLogin();

      expect(result.isLeft(), isTrue);
    });

    test('returns Left when verification fails', () async {
      when(() => mockDeviceBinding.getStoredDeviceId())
          .thenAnswer((_) async => 'device_123');
      when(() => mockDeviceBinding.getStoredUserId())
          .thenAnswer((_) async => 'user_456');

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            biometricOnly: any(named: 'biometricOnly'),
            persistAcrossBackgrounding:
                any(named: 'persistAcrossBackgrounding'),
          )).thenAnswer((_) async => true);

      // Challenge succeeds
      final challengeCallable = MockHttpsCallable();
      final challengeResult = MockHttpsCallableResult();
      when(() => mockFunctions.httpsCallable('requestBiometricChallenge'))
          .thenReturn(challengeCallable);
      when(() => challengeCallable.call<Map<String, dynamic>>(any()))
          .thenAnswer((_) async => challengeResult);
      when(() => challengeResult.data).thenReturn({
        'challengeId': 'challenge_abc',
        'nonce': 'nonce_xyz',
      });

      // Signing succeeds
      final expectedAlias = KeystoreService.keyAlias('user_456');
      when(() => mockKeystoreService.sign(expectedAlias, 'nonce_xyz'))
          .thenAnswer((_) async => const Right('signed_data'));

      // Verification fails
      final verifyCallable = MockHttpsCallable();
      when(() => mockFunctions.httpsCallable('verifyBiometricChallenge'))
          .thenReturn(verifyCallable);
      when(() => verifyCallable.call<Map<String, dynamic>>(any()))
          .thenThrow(Exception('Verification server error'));

      final result = await service.attemptBiometricLogin();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  // -----------------------------------------------------------------------
  // recordSuccessfulAuth
  // -----------------------------------------------------------------------
  group('recordSuccessfulAuth', () {
    test('stores ISO8601 timestamp in secure storage', () async {
      await service.recordSuccessfulAuth();

      final stored = secureStorage.store['imali_last_auth_time'];
      expect(stored, isNotNull);

      // Verify it is a valid ISO8601 string
      final parsed = DateTime.tryParse(stored!);
      expect(parsed, isNotNull);

      // Should be very recent (within last few seconds)
      final diff = DateTime.now().difference(parsed!);
      expect(diff.inSeconds, lessThan(5));
    });
  });

  // -----------------------------------------------------------------------
  // getStoredDisplayName
  // -----------------------------------------------------------------------
  group('getStoredDisplayName', () {
    test('returns cached display name', () async {
      secureStorage.store['imali_cached_display_name'] = 'John';

      final result = await service.getStoredDisplayName();

      expect(result, equals('John'));
    });

    test('returns null when not cached', () async {
      final result = await service.getStoredDisplayName();

      expect(result, isNull);
    });
  });

  // -----------------------------------------------------------------------
  // cacheDisplayName
  // -----------------------------------------------------------------------
  group('cacheDisplayName', () {
    test('stores display name in secure storage', () async {
      await service.cacheDisplayName('Jane Doe');

      expect(
        secureStorage.store['imali_cached_display_name'],
        equals('Jane Doe'),
      );
    });
  });

  // -----------------------------------------------------------------------
  // clearCachedDisplayName
  // -----------------------------------------------------------------------
  group('clearCachedDisplayName', () {
    test('deletes display name from secure storage', () async {
      secureStorage.store['imali_cached_display_name'] = 'John';

      await service.clearCachedDisplayName();

      expect(
        secureStorage.store.containsKey('imali_cached_display_name'),
        isFalse,
      );
    });
  });

  // -----------------------------------------------------------------------
  // clearLastAuthTime
  // -----------------------------------------------------------------------
  group('clearLastAuthTime', () {
    test('deletes last auth time from secure storage', () async {
      secureStorage.store['imali_last_auth_time'] =
          DateTime.now().toIso8601String();

      await service.clearLastAuthTime();

      expect(
        secureStorage.store.containsKey('imali_last_auth_time'),
        isFalse,
      );
    });
  });
}
