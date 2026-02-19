import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/audit_logger.dart';
import 'package:imalichat/core/security/device_binding_service.dart';
import 'package:imalichat/core/security/keystore_service.dart';
import 'package:imalichat/domain/repositories/device_repository.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------
class MockKeystoreService extends Mock implements KeystoreService {}

class MockDeviceRepository extends Mock implements DeviceRepository {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockAuditLogger extends Mock implements AuditLogger {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

// ---------------------------------------------------------------------------
// In-memory FlutterSecureStorage (same pattern as pin_manager_test.dart)
// ---------------------------------------------------------------------------
class InMemorySecureStorage extends Mock implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) _store[key] = value;
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store.remove(key);

  Map<String, String> get store => _store;
}

// ---------------------------------------------------------------------------
// Throwing secure storage (simulates platform errors)
// ---------------------------------------------------------------------------
class ThrowingSecureStorage extends Mock implements FlutterSecureStorage {
  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      throw Exception('Storage unavailable');

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      throw Exception('Storage unavailable');
}

void main() {
  late MockKeystoreService mockKeystoreService;
  late MockDeviceRepository mockDeviceRepository;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late InMemorySecureStorage secureStorage;
  late MockAuditLogger mockAuditLogger;
  late MockFirebaseFunctions mockFirebaseFunctions;
  late DeviceBindingService service;

  setUp(() {
    mockKeystoreService = MockKeystoreService();
    mockDeviceRepository = MockDeviceRepository();
    mockFirebaseMessaging = MockFirebaseMessaging();
    secureStorage = InMemorySecureStorage();
    mockAuditLogger = MockAuditLogger();
    mockFirebaseFunctions = MockFirebaseFunctions();

    service = DeviceBindingService(
      mockKeystoreService,
      mockDeviceRepository,
      mockFirebaseMessaging,
      secureStorage,
      mockAuditLogger,
      mockFirebaseFunctions,
    );
  });

  // -----------------------------------------------------------------------
  // isCurrentDeviceTrusted
  // -----------------------------------------------------------------------
  group('isCurrentDeviceTrusted', () {
    const testUserId = 'user_123';

    test('returns true when cached trusted flag is "true"', () async {
      secureStorage.store['imali_device_trusted'] = 'true';

      final result = await service.isCurrentDeviceTrusted(testUserId);

      expect(result, isTrue);
    });

    test('returns false when no device ID is cached', () async {
      // No trusted flag, no device ID in storage
      final result = await service.isCurrentDeviceTrusted(testUserId);

      expect(result, isFalse);
    });

    test(
        'returns true and caches when server says device is trusted',
        () async {
      // No cached trust flag, but device ID is present
      secureStorage.store['imali_bound_device_id'] = 'device_abc';

      when(() => mockDeviceRepository.isDeviceTrusted('device_abc'))
          .thenAnswer((_) async => const Right(true));

      final result = await service.isCurrentDeviceTrusted(testUserId);

      expect(result, isTrue);
      // Should have cached the trusted flag
      expect(secureStorage.store['imali_device_trusted'], equals('true'));
      verify(() => mockDeviceRepository.isDeviceTrusted('device_abc'))
          .called(1);
    });

    test('returns false when server says device is not trusted', () async {
      secureStorage.store['imali_bound_device_id'] = 'device_abc';

      when(() => mockDeviceRepository.isDeviceTrusted('device_abc'))
          .thenAnswer((_) async => const Right(false));

      final result = await service.isCurrentDeviceTrusted(testUserId);

      expect(result, isFalse);
      // Should NOT have cached anything
      expect(secureStorage.store.containsKey('imali_device_trusted'), isFalse);
    });

    test('returns false when server returns a failure', () async {
      secureStorage.store['imali_bound_device_id'] = 'device_abc';

      when(() => mockDeviceRepository.isDeviceTrusted('device_abc'))
          .thenAnswer(
              (_) async => const Left(Failure.network(message: 'offline')));

      final result = await service.isCurrentDeviceTrusted(testUserId);

      expect(result, isFalse);
    });
  });

  // -----------------------------------------------------------------------
  // getCachedDeviceId
  // -----------------------------------------------------------------------
  group('getCachedDeviceId', () {
    test('returns device ID when cached', () async {
      secureStorage.store['imali_bound_device_id'] = 'device_xyz';

      final result = await service.getCachedDeviceId();

      expect(result, equals('device_xyz'));
    });

    test('returns null when no device ID is cached', () async {
      final result = await service.getCachedDeviceId();

      expect(result, isNull);
    });

    test('returns null on storage error', () async {
      // Create a service with throwing storage
      final throwingStorage = ThrowingSecureStorage();
      final errorService = DeviceBindingService(
        mockKeystoreService,
        mockDeviceRepository,
        mockFirebaseMessaging,
        throwingStorage,
        mockAuditLogger,
        mockFirebaseFunctions,
      );

      final result = await errorService.getCachedDeviceId();

      expect(result, isNull);
    });
  });

  // -----------------------------------------------------------------------
  // getStoredDeviceId (alias for getCachedDeviceId)
  // -----------------------------------------------------------------------
  group('getStoredDeviceId', () {
    test('returns same result as getCachedDeviceId', () async {
      secureStorage.store['imali_bound_device_id'] = 'device_alias_test';

      final cachedResult = await service.getCachedDeviceId();
      final storedResult = await service.getStoredDeviceId();

      expect(storedResult, equals(cachedResult));
      expect(storedResult, equals('device_alias_test'));
    });
  });

  // -----------------------------------------------------------------------
  // getStoredUserId
  // -----------------------------------------------------------------------
  group('getStoredUserId', () {
    test('returns user ID when cached', () async {
      secureStorage.store['imali_bound_user_id'] = 'user_456';

      final result = await service.getStoredUserId();

      expect(result, equals('user_456'));
    });

    test('returns null when no user ID is cached', () async {
      final result = await service.getStoredUserId();

      expect(result, isNull);
    });
  });

  // -----------------------------------------------------------------------
  // hasKeypair
  // -----------------------------------------------------------------------
  group('hasKeypair', () {
    const testUserId = 'user_789';
    final expectedAlias = KeystoreService.keyAlias(testUserId);

    test('returns true when keystoreService has key', () async {
      when(() => mockKeystoreService.hasKey(expectedAlias))
          .thenAnswer((_) async => const Right(true));

      final result = await service.hasKeypair(testUserId);

      expect(result, isTrue);
      verify(() => mockKeystoreService.hasKey(expectedAlias)).called(1);
    });

    test('returns false when keystoreService does not have key', () async {
      when(() => mockKeystoreService.hasKey(expectedAlias))
          .thenAnswer((_) async => const Right(false));

      final result = await service.hasKeypair(testUserId);

      expect(result, isFalse);
    });

    test('returns false when keystoreService returns failure', () async {
      when(() => mockKeystoreService.hasKey(expectedAlias)).thenAnswer(
          (_) async =>
              const Left(Failure.unknown(message: 'Keystore error')));

      final result = await service.hasKeypair(testUserId);

      expect(result, isFalse);
    });
  });

  // -----------------------------------------------------------------------
  // clearBinding
  // -----------------------------------------------------------------------
  group('clearBinding', () {
    test('deletes all three keys from secure storage', () async {
      secureStorage.store['imali_bound_device_id'] = 'device_123';
      secureStorage.store['imali_device_trusted'] = 'true';
      secureStorage.store['imali_bound_user_id'] = 'user_123';

      await service.clearBinding();

      expect(secureStorage.store.containsKey('imali_bound_device_id'), isFalse);
      expect(
          secureStorage.store.containsKey('imali_device_trusted'), isFalse);
      expect(secureStorage.store.containsKey('imali_bound_user_id'), isFalse);
    });

    test('does not throw on storage error', () async {
      final throwingStorage = ThrowingSecureStorage();
      final errorService = DeviceBindingService(
        mockKeystoreService,
        mockDeviceRepository,
        mockFirebaseMessaging,
        throwingStorage,
        mockAuditLogger,
        mockFirebaseFunctions,
      );

      // Should complete without throwing
      await expectLater(errorService.clearBinding(), completes);
    });
  });

  // -----------------------------------------------------------------------
  // deleteKeypair
  // -----------------------------------------------------------------------
  group('deleteKeypair', () {
    const testUserId = 'user_del';
    final expectedAlias = KeystoreService.keyAlias(testUserId);

    test('calls keystoreService.deleteKey with correct alias', () async {
      when(() => mockKeystoreService.deleteKey(expectedAlias))
          .thenAnswer((_) async => const Right(true));

      await service.deleteKeypair(testUserId);

      verify(() => mockKeystoreService.deleteKey(expectedAlias)).called(1);
    });

    test('does not throw when keystoreService.deleteKey fails', () async {
      when(() => mockKeystoreService.deleteKey(expectedAlias)).thenAnswer(
          (_) async =>
              const Left(Failure.unknown(message: 'Delete failed')));

      // Should complete without throwing
      await expectLater(service.deleteKeypair(testUserId), completes);
    });

    test('does not throw when keystoreService throws exception', () async {
      when(() => mockKeystoreService.deleteKey(expectedAlias))
          .thenThrow(Exception('Platform error'));

      // Should complete without throwing (caught internally)
      await expectLater(service.deleteKeypair(testUserId), completes);
    });
  });

  // -----------------------------------------------------------------------
  // keyAlias static method verification
  // -----------------------------------------------------------------------
  group('KeystoreService.keyAlias', () {
    test('returns expected alias format', () {
      expect(
        KeystoreService.keyAlias('user_abc'),
        equals('imali_device_key_user_abc'),
      );
    });
  });
}
