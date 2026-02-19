@Timeout(Duration(minutes: 5))
library;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_backup_service.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

// In-memory secure storage for tests
class _InMemorySecureStorage extends Mock implements FlutterSecureStorage {
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
    if (value != null) {
      _store[key] = value;
    }
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
}

void main() {
  late KeyBackupService backupService;
  late MockKeyManagementService mockKeyMgmt;
  late CryptoService realCrypto;
  late _InMemorySecureStorage secureStorage;
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockResult;

  final testBundle = E2EETestData.createTestKeyBundle();

  setUpAll(() {
    registerFallbackValue(testBundle);
  });

  setUp(() {
    mockKeyMgmt = MockKeyManagementService();
    realCrypto = CryptoService();
    secureStorage = _InMemorySecureStorage();
    mockFunctions = MockFirebaseFunctions();
    mockCallable = MockHttpsCallable();
    mockResult = MockHttpsCallableResult();

    backupService = KeyBackupService(
      mockKeyMgmt,
      realCrypto,
      mockFunctions,
      secureStorage,
    );

    // Default stubs
    when(() => mockFunctions.httpsCallable(any())).thenReturn(mockCallable);
    when(() => mockCallable.call<dynamic>(any()))
        .thenAnswer((_) async => mockResult);
    when(() => mockResult.data).thenReturn(<String, dynamic>{});
  });

  group('KeyBackupService', () {
    // ==================== createBackup ====================
    group('createBackup', () {
      test('loads private keys via keyManagementService', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.createBackup('my-passphrase');

        verify(() => mockKeyMgmt.loadPrivateKeys()).called(1);
      });

      test('encrypts and stores blob in secure storage', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.createBackup('my-passphrase');

        // Verify blob and salt are stored
        final blob = await secureStorage.read(key: 'e2ee_backup_blob');
        final salt = await secureStorage.read(key: 'e2ee_backup_salt');
        expect(blob, isNotNull);
        expect(salt, isNotNull);
        expect(blob!.isNotEmpty, isTrue);
        expect(salt!.isNotEmpty, isTrue);
      });

      test('caches passphrase in secure storage', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.createBackup('my-passphrase');

        final cached =
            await secureStorage.read(key: 'e2ee_backup_passphrase');
        expect(cached, 'my-passphrase');
      });

      test('stores timestamp in secure storage', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.createBackup('my-passphrase');

        final ts = await secureStorage.read(key: 'e2ee_backup_timestamp');
        expect(ts, isNotNull);
        // Verify it's a valid ISO 8601 timestamp
        expect(() => DateTime.parse(ts!), returnsNormally);
      });

      test('uploads metadata to server via Cloud Function', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.createBackup('my-passphrase');

        verify(() => mockFunctions.httpsCallable('saveBackupMetadata'))
            .called(1);
        verify(() => mockCallable.call<dynamic>(any())).called(1);
      });

      test('throws when no private keys to back up', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => null);

        expect(
          () => backupService.createBackup('my-passphrase'),
          throwsA(isA<StateError>()),
        );
      });

      test('generates random salt for PBKDF2', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.createBackup('pass1');
        final salt1 = await secureStorage.read(key: 'e2ee_backup_salt');

        // Clear and create again
        secureStorage._store.clear();
        await backupService.createBackup('pass1');
        final salt2 = await secureStorage.read(key: 'e2ee_backup_salt');

        // Different salts (probabilistically guaranteed)
        expect(salt1, isNot(equals(salt2)));
      });
    });

    // ==================== restoreFromBackup ====================
    group('restoreFromBackup', () {
      test('returns true on successful restore with correct passphrase',
          () async {
        // First create a backup
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockKeyMgmt.storePrivateKeys(any()))
            .thenAnswer((_) async {});
        when(() => mockKeyMgmt.uploadKeyBundle(any()))
            .thenAnswer((_) async {});

        await backupService.createBackup('correct-pass');

        final result = await backupService.restoreFromBackup('correct-pass');
        expect(result, isTrue);
      });

      test('returns false on wrong passphrase', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.createBackup('correct-pass');

        final result = await backupService.restoreFromBackup('wrong-pass');
        expect(result, isFalse);
      });

      test('returns false when no backup blob exists', () async {
        final result = await backupService.restoreFromBackup('any-pass');
        expect(result, isFalse);
      });

      test('calls storePrivateKeys and uploadKeyBundle on success', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockKeyMgmt.storePrivateKeys(any()))
            .thenAnswer((_) async {});
        when(() => mockKeyMgmt.uploadKeyBundle(any()))
            .thenAnswer((_) async {});

        await backupService.createBackup('pass');
        await backupService.restoreFromBackup('pass');

        verify(() => mockKeyMgmt.storePrivateKeys(any())).called(1);
        verify(() => mockKeyMgmt.uploadKeyBundle(any())).called(1);
      });

      test('caches passphrase on successful restore', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockKeyMgmt.storePrivateKeys(any()))
            .thenAnswer((_) async {});
        when(() => mockKeyMgmt.uploadKeyBundle(any()))
            .thenAnswer((_) async {});

        await backupService.createBackup('my-pass');

        // Clear passphrase cache
        secureStorage._store.remove('e2ee_backup_passphrase');

        await backupService.restoreFromBackup('my-pass');

        final cached =
            await secureStorage.read(key: 'e2ee_backup_passphrase');
        expect(cached, 'my-pass');
      });
    });

    // ==================== hasBackup ====================
    group('hasBackup', () {
      test('returns true when backup metadata exists on server', () async {
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'backupExists': true,
          'userId': 'user123',
        });

        final result = await backupService.hasBackup();
        expect(result, isTrue);
      });

      test('returns false when no backup exists', () async {
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'backupExists': false,
          'userId': 'user123',
        });

        final result = await backupService.hasBackup();
        expect(result, isFalse);
      });

      test('returns false when server returns null', () async {
        when(() => mockResult.data).thenReturn(null);

        final result = await backupService.hasBackup();
        expect(result, isFalse);
      });
    });

    // ==================== getBackupMetadata ====================
    group('getBackupMetadata', () {
      test('calls httpsCallable with correct function name', () async {
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'backupExists': true,
          'userId': 'user123',
          'backupVersion': 1,
          'lastBackupAt': '2024-06-01T00:00:00.000Z',
        });

        await backupService.getBackupMetadata();

        verify(() => mockFunctions.httpsCallable('getBackupMetadata'))
            .called(1);
      });

      test('parses BackupMetadata from response', () async {
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'backupExists': true,
          'userId': 'user123',
          'backupVersion': 1,
          'lastBackupAt': '2024-06-01T00:00:00.000Z',
        });

        final metadata = await backupService.getBackupMetadata();

        expect(metadata, isNotNull);
        expect(metadata!.backupExists, isTrue);
        expect(metadata.userId, 'user123');
        expect(metadata.backupVersion, 1);
        expect(metadata.lastBackupAt, isNotNull);
      });

      test('returns null when server throws', () async {
        when(() => mockCallable.call<dynamic>(any()))
            .thenThrow(Exception('Network error'));

        final metadata = await backupService.getBackupMetadata();
        expect(metadata, isNull);
      });
    });

    // ==================== autoBackupIfNeeded ====================
    group('autoBackupIfNeeded', () {
      test('skips when no cached passphrase', () async {
        await backupService.autoBackupIfNeeded();

        // Should not call loadPrivateKeys since no passphrase
        verifyNever(() => mockKeyMgmt.loadPrivateKeys());
      });

      test('skips when backup is recent (less than 7 days)', () async {
        // Cache a passphrase and recent timestamp
        await secureStorage.write(
          key: 'e2ee_backup_passphrase',
          value: 'cached-pass',
        );
        await secureStorage.write(
          key: 'e2ee_backup_timestamp',
          value: DateTime.now().toIso8601String(),
        );

        await backupService.autoBackupIfNeeded();

        // Should not attempt backup since it's fresh
        verifyNever(() => mockKeyMgmt.loadPrivateKeys());
      });

      test('creates backup when stale (older than 7 days)', () async {
        await secureStorage.write(
          key: 'e2ee_backup_passphrase',
          value: 'cached-pass',
        );
        await secureStorage.write(
          key: 'e2ee_backup_timestamp',
          value:
              DateTime.now().subtract(const Duration(days: 8)).toIso8601String(),
        );

        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.autoBackupIfNeeded();

        verify(() => mockKeyMgmt.loadPrivateKeys()).called(1);
      });

      test('creates backup when no timestamp exists (first time)', () async {
        await secureStorage.write(
          key: 'e2ee_backup_passphrase',
          value: 'cached-pass',
        );
        // No timestamp stored

        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);

        await backupService.autoBackupIfNeeded();

        verify(() => mockKeyMgmt.loadPrivateKeys()).called(1);
      });
    });

    // ==================== Full roundtrip ====================
    group('full backup/restore roundtrip', () {
      test('backup then restore yields matching key bundle', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockKeyMgmt.storePrivateKeys(any()))
            .thenAnswer((_) async {});
        when(() => mockKeyMgmt.uploadKeyBundle(any()))
            .thenAnswer((_) async {});

        // Create backup
        await backupService.createBackup('roundtrip-pass');

        // Restore
        final success =
            await backupService.restoreFromBackup('roundtrip-pass');
        expect(success, isTrue);

        // Verify the restored bundle matches
        final captured =
            verify(() => mockKeyMgmt.storePrivateKeys(captureAny()))
                .captured
                .first as KeyBundle;
        expect(captured.identityKeyPair, testBundle.identityKeyPair);
        expect(captured.signedPreKey, testBundle.signedPreKey);
        expect(
            captured.signedPreKeySignature, testBundle.signedPreKeySignature);
        expect(captured.oneTimePreKeys, testBundle.oneTimePreKeys);
        expect(captured.registrationId, testBundle.registrationId);
      });
    });
  });
}
