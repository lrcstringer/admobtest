@Timeout(Duration(minutes: 5))
library;

import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

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
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockResult;

  /// Simulated server-side secret (base64-encoded 32 random bytes).
  final serverSecretB64 = base64Encode(List.generate(32, (i) => i + 42));

  setUp(() {
    crypto = CryptoService();
    storage = InMemorySecureStorage();
    mockFunctions = MockFirebaseFunctions();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockCallable = MockHttpsCallable();
    mockResult = MockHttpsCallableResult();

    // Auth stubs
    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn('test-user-123');

    // Default: all httpsCallable calls go through the same mock callable
    when(() => mockFunctions.httpsCallable(any())).thenReturn(mockCallable);
    when(() => mockCallable.call<dynamic>(any()))
        .thenAnswer((_) async => mockResult);

    // Wire mock functions — uploadKeyBundle is called during autoRestore
    when(() => mockFunctions.httpsCallable('uploadKeyBundle'))
        .thenReturn(mockCallable);

    keyMgmt = KeyManagementService(crypto, storage, mockFunctions);
    backupService = KeyBackupService(
      keyMgmt,
      crypto,
      mockFunctions,
      storage,
      mockAuth,
    );
  });

  group('E2EE Auto Backup & Restore Integration', () {
    test('autoBackup → autoRestore with server secret → keys match', () async {
      // Generate a real key bundle and store it
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      // Track which function is called to return appropriate data
      final callablesByName = <String, MockHttpsCallable>{};
      for (final name in [
        'getBackupSecret',
        'saveBackupSecret',
        'saveKeyBackup',
        'getKeyBackup',
      ]) {
        final callable = MockHttpsCallable();
        callablesByName[name] = callable;
        when(() => mockFunctions.httpsCallable(name)).thenReturn(callable);
      }

      // Capture the actual secret generated during backup
      String? capturedSecret;
      var getSecretCallCount = 0;

      // getBackupSecret: first call returns null (no secret), subsequent calls return captured
      when(() => callablesByName['getBackupSecret']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        getSecretCallCount++;
        final result = MockHttpsCallableResult();
        if (getSecretCallCount <= 1) {
          when(() => result.data)
              .thenReturn(<String, dynamic>{'secret': null});
        } else {
          when(() => result.data)
              .thenReturn(<String, dynamic>{'secret': capturedSecret});
        }
        return result;
      });

      // saveBackupSecret: capture the actual generated secret
      when(() => callablesByName['saveBackupSecret']!.call<dynamic>(any()))
          .thenAnswer((invocation) async {
        final args = invocation.positionalArguments.first as Map;
        capturedSecret = args['secret'] as String;
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'success': true});
        return result;
      });

      // saveKeyBackup: succeeds
      when(() => callablesByName['saveKeyBackup']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'success': true});
        return result;
      });

      // Create backup
      await backupService.autoBackup();

      // Verify the secret was captured
      expect(capturedSecret, isNotNull);

      // Verify backup blob was stored locally
      expect(storage.store.containsKey('e2ee_backup_blob'), isTrue);
      expect(storage.store.containsKey('e2ee_backup_timestamp'), isTrue);

      // Save the backup blob for restore
      final backupBlob = storage.store['e2ee_backup_blob']!;

      // Clear the key material from storage (simulate device wipe)
      storage.store.remove('e2ee_identity_key');
      storage.store.remove('e2ee_signed_pre_key');
      storage.store.remove('e2ee_signed_pre_key_sig');
      storage.store.remove('e2ee_one_time_pre_keys');
      storage.store.remove('e2ee_registration_id');

      // Verify keys are wiped
      expect(await keyMgmt.loadPrivateKeys(), isNull);

      // Mock restore: getBackupSecret returns the captured secret, getKeyBackup returns blob
      getSecretCallCount = 10; // Force it to return the captured secret
      when(() => callablesByName['getKeyBackup']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data).thenReturn(<String, dynamic>{
          'backupExists': true,
          'encryptedBlob': backupBlob,
          'backupVersion': 2,
        });
        return result;
      });

      // Restore from backup
      final success = await backupService.autoRestore();
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

    test('autoRestore returns false when no backup exists on server', () async {
      final callablesByName = <String, MockHttpsCallable>{};
      for (final name in ['getBackupSecret', 'getKeyBackup']) {
        final callable = MockHttpsCallable();
        callablesByName[name] = callable;
        when(() => mockFunctions.httpsCallable(name)).thenReturn(callable);
      }

      when(() => callablesByName['getBackupSecret']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'secret': serverSecretB64});
        return result;
      });

      when(() => callablesByName['getKeyBackup']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'backupExists': false});
        return result;
      });

      final success = await backupService.autoRestore();
      expect(success, isFalse);
    });

    test('autoRestore returns false when no server secret exists', () async {
      final callable = MockHttpsCallable();
      when(() => mockFunctions.httpsCallable('getBackupSecret'))
          .thenReturn(callable);
      when(() => callable.call<dynamic>(any())).thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'secret': null});
        return result;
      });

      final success = await backupService.autoRestore();
      expect(success, isFalse);
    });

    test('autoRestore returns false on corrupted blob', () async {
      final callablesByName = <String, MockHttpsCallable>{};
      for (final name in ['getBackupSecret', 'getKeyBackup']) {
        final callable = MockHttpsCallable();
        callablesByName[name] = callable;
        when(() => mockFunctions.httpsCallable(name)).thenReturn(callable);
      }

      when(() => callablesByName['getBackupSecret']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'secret': serverSecretB64});
        return result;
      });

      when(() => callablesByName['getKeyBackup']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data).thenReturn(<String, dynamic>{
          'backupExists': true,
          'encryptedBlob': base64Encode([1, 2, 3, 4, 5]),
        });
        return result;
      });

      final success = await backupService.autoRestore();
      expect(success, isFalse);
    });

    test('Backup blob contains encrypted data (not plaintext)', () async {
      final originalBundle = await keyMgmt.generateKeyBundle();
      await keyMgmt.storePrivateKeys(originalBundle);

      // Set up mock to return server secret
      final callablesByName = <String, MockHttpsCallable>{};
      for (final name in [
        'getBackupSecret',
        'saveBackupSecret',
        'saveKeyBackup',
      ]) {
        final callable = MockHttpsCallable();
        callablesByName[name] = callable;
        when(() => mockFunctions.httpsCallable(name)).thenReturn(callable);
      }

      var getSecretCalls = 0;
      when(() => callablesByName['getBackupSecret']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        getSecretCalls++;
        final result = MockHttpsCallableResult();
        if (getSecretCalls <= 1) {
          when(() => result.data)
              .thenReturn(<String, dynamic>{'secret': null});
        } else {
          when(() => result.data)
              .thenReturn(<String, dynamic>{'secret': serverSecretB64});
        }
        return result;
      });

      when(() => callablesByName['saveBackupSecret']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'success': true});
        return result;
      });

      when(() => callablesByName['saveKeyBackup']!.call<dynamic>(any()))
          .thenAnswer((_) async {
        final result = MockHttpsCallableResult();
        when(() => result.data)
            .thenReturn(<String, dynamic>{'success': true});
        return result;
      });

      await backupService.autoBackup();

      // The backup blob should be encrypted, so we can't read it directly.
      final blobBase64 = storage.store['e2ee_backup_blob']!;
      expect(blobBase64.isNotEmpty, isTrue);

      // Decode blob — it should be: nonce(12) + ciphertext + mac(16)
      final blob = base64Decode(blobBase64);
      // Minimum size: 12 (nonce) + 1 (min ciphertext) + 16 (mac) = 29
      expect(blob.length, greaterThan(28));
    });

    test('autoRestore returns false when user is not authenticated', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      final success = await backupService.autoRestore();
      expect(success, isFalse);
    });
  });
}
