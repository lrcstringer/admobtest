@Timeout(Duration(minutes: 5))
library;

import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_backup_service.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:mocktail/mocktail.dart';

// =============================================================================
// IN-MEMORY SECURE STORAGE
// =============================================================================

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

  @override
  Future<Map<String, String>> readAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      Map.unmodifiable(_store);

  Map<String, String> get store => _store;
}

// =============================================================================
// MOCKS
// =============================================================================

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult extends Mock
    implements HttpsCallableResult<dynamic> {}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late CryptoService crypto;
  late InMemorySecureStorage storage;
  late KeyManagementService keyMgmt;
  late KeyBackupService backupService;
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockResult;

  setUp(() {
    crypto = CryptoService();
    storage = InMemorySecureStorage();
    mockFunctions = MockFirebaseFunctions();
    mockCallable = MockHttpsCallable();
    mockResult = MockHttpsCallableResult();

    // Wire mock functions — saveBackupMetadata is called during createBackup
    when(() => mockFunctions.httpsCallable('saveBackupMetadata'))
        .thenReturn(mockCallable);
    when(() => mockCallable.call<dynamic>(any()))
        .thenAnswer((_) async => mockResult);

    // Wire mock functions — uploadKeyBundle is called during restoreFromBackup
    when(() => mockFunctions.httpsCallable('uploadKeyBundle'))
        .thenReturn(mockCallable);

    keyMgmt = KeyManagementService(crypto, storage, mockFunctions);
    backupService = KeyBackupService(keyMgmt, crypto, mockFunctions, storage);
  });

  group('E2EE Backup & Restore Integration', () {
    test('Backup -> restore with correct passphrase -> keys match', () async {
      // Generate a real key bundle and store it
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      // Create backup with passphrase
      await backupService.createBackup('my-strong-passphrase');

      // Verify backup blob was stored
      expect(storage.store.containsKey('e2ee_backup_blob'), isTrue);
      expect(storage.store.containsKey('e2ee_backup_salt'), isTrue);

      // Clear the key material from storage (simulate device wipe)
      storage.store.remove('e2ee_identity_key');
      storage.store.remove('e2ee_signed_pre_key');
      storage.store.remove('e2ee_signed_pre_key_sig');
      storage.store.remove('e2ee_one_time_pre_keys');
      storage.store.remove('e2ee_registration_id');

      // Verify keys are wiped
      expect(await keyMgmt.loadPrivateKeys(), isNull);

      // Restore from backup with the correct passphrase
      final success =
          await backupService.restoreFromBackup('my-strong-passphrase');
      expect(success, isTrue);

      // Load restored keys and verify they match original
      final restoredBundle = await keyMgmt.loadPrivateKeys();
      expect(restoredBundle, isNotNull);
      expect(
          restoredBundle!.identityKeyPair, equals(originalBundle.identityKeyPair));
      expect(restoredBundle.signedPreKey, equals(originalBundle.signedPreKey));
      expect(restoredBundle.signedPreKeySignature,
          equals(originalBundle.signedPreKeySignature));
      expect(restoredBundle.registrationId,
          equals(originalBundle.registrationId));
      expect(restoredBundle.oneTimePreKeys.length,
          equals(originalBundle.oneTimePreKeys.length));
    });

    test('Wrong passphrase -> returns false', () async {
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      // Create backup
      await backupService.createBackup('correct-passphrase');

      // Attempt restore with wrong passphrase
      final success =
          await backupService.restoreFromBackup('wrong-passphrase');
      expect(success, isFalse);
    });

    test('Backup includes identity, signed pre-key, and OTKs', () async {
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      await backupService.createBackup('test-passphrase');

      // The backup blob should be encrypted, so we can't read it directly.
      // But we can verify it was stored and is non-empty base64.
      final blobBase64 = storage.store['e2ee_backup_blob']!;
      final saltBase64 = storage.store['e2ee_backup_salt']!;

      expect(blobBase64.isNotEmpty, isTrue);
      expect(saltBase64.isNotEmpty, isTrue);

      // Decode blob — it should be: nonce(12) + ciphertext + mac(16)
      final blob = base64Decode(blobBase64);
      // Minimum size: 12 (nonce) + 1 (min ciphertext) + 16 (mac) = 29
      expect(blob.length, greaterThan(28));

      // Verify by restoring and checking all fields are present
      final success =
          await backupService.restoreFromBackup('test-passphrase');
      expect(success, isTrue);

      final restored = await keyMgmt.loadPrivateKeys();
      expect(restored, isNotNull);
      // Identity key pair should contain private|public
      expect(restored!.identityKeyPair.contains('|'), isTrue);
      // Signed pre-key should contain private|public
      expect(restored.signedPreKey.contains('|'), isTrue);
      // OTKs should be present (10 by default from generateKeyBundle)
      expect(restored.oneTimePreKeys.length, equals(10));
    });

    test('After restore, keys match original exactly', () async {
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      await backupService.createBackup('exact-match-test');

      // Wipe keys
      storage.store.remove('e2ee_identity_key');
      storage.store.remove('e2ee_signed_pre_key');
      storage.store.remove('e2ee_signed_pre_key_sig');
      storage.store.remove('e2ee_one_time_pre_keys');
      storage.store.remove('e2ee_registration_id');

      await backupService.restoreFromBackup('exact-match-test');

      final restored = await keyMgmt.loadPrivateKeys();
      expect(restored, isNotNull);

      // Compare every field
      expect(
          restored!.identityKeyPair, equals(originalBundle.identityKeyPair));
      expect(restored.signedPreKey, equals(originalBundle.signedPreKey));
      expect(restored.signedPreKeySignature,
          equals(originalBundle.signedPreKeySignature));
      expect(restored.registrationId,
          equals(originalBundle.registrationId));
      for (var i = 0; i < originalBundle.oneTimePreKeys.length; i++) {
        expect(
            restored.oneTimePreKeys[i], equals(originalBundle.oneTimePreKeys[i]));
      }
    });

    test('Auto-backup triggers when passphrase cached and backup is stale',
        () async {
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      // Cache passphrase and set a stale timestamp (8 days ago)
      storage.store['e2ee_backup_passphrase'] = 'auto-backup-pass';
      final staleDatetime =
          DateTime.now().subtract(const Duration(days: 8)).toIso8601String();
      storage.store['e2ee_backup_timestamp'] = staleDatetime;

      // Call autoBackupIfNeeded — should create a backup since it's stale
      await backupService.autoBackupIfNeeded();

      // Verify backup was created (blob should exist)
      expect(storage.store.containsKey('e2ee_backup_blob'), isTrue);

      // Verify the timestamp was updated to something more recent
      final newTimestamp = storage.store['e2ee_backup_timestamp']!;
      final newDate = DateTime.parse(newTimestamp);
      expect(newDate.isAfter(DateTime.parse(staleDatetime)), isTrue);
    });

    test('No backup when no passphrase cached', () async {
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      // Ensure no passphrase is cached
      expect(storage.store.containsKey('e2ee_backup_passphrase'), isFalse);

      // Call autoBackupIfNeeded — should do nothing
      await backupService.autoBackupIfNeeded();

      // No backup blob should be created
      expect(storage.store.containsKey('e2ee_backup_blob'), isFalse);
    });
  });
}
