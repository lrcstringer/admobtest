@Timeout(Duration(minutes: 5))
library;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_backup_service.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

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
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
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
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockCallable = MockHttpsCallable();
    mockResult = MockHttpsCallableResult();

    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn('test-user-123');

    backupService = KeyBackupService(
      mockKeyMgmt,
      realCrypto,
      mockFunctions,
      secureStorage,
      mockAuth,
    );

    // Default stubs
    when(() => mockFunctions.httpsCallable(any())).thenReturn(mockCallable);
    when(() => mockCallable.call<dynamic>(any()))
        .thenAnswer((_) async => mockResult);
    when(() => mockResult.data).thenReturn(<String, dynamic>{});
  });

  group('KeyBackupService', () {
    // ==================== autoBackup ====================
    group('autoBackup', () {
      test('loads private keys via keyManagementService', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'secret': 'dGVzdC1zZWNyZXQ=',
        });

        await backupService.autoBackup();

        verify(() => mockKeyMgmt.loadPrivateKeys()).called(1);
      });

      test('does nothing when no private keys exist', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => null);

        await backupService.autoBackup();

        // Should not call any Cloud Functions
        verifyNever(() => mockFunctions.httpsCallable(any()));
      });

      test('does nothing when user is not authenticated', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockAuth.currentUser).thenReturn(null);

        await backupService.autoBackup();

        // Should not call any Cloud Functions
        verifyNever(() => mockFunctions.httpsCallable(any()));
      });

      test('stores blob and timestamp in secure storage', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'secret': 'dGVzdC1zZWNyZXQ=',
        });

        await backupService.autoBackup();

        final blob = await secureStorage.read(key: 'e2ee_backup_blob');
        final ts = await secureStorage.read(key: 'e2ee_backup_timestamp');
        expect(blob, isNotNull);
        expect(blob!.isNotEmpty, isTrue);
        expect(ts, isNotNull);
        expect(() => DateTime.parse(ts!), returnsNormally);
      });

      test('uploads encrypted blob via saveKeyBackup Cloud Function', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'secret': 'dGVzdC1zZWNyZXQ=',
        });

        await backupService.autoBackup();

        verify(() => mockFunctions.httpsCallable('saveKeyBackup')).called(1);
      });
    });

    // ==================== autoRestore ====================
    group('autoRestore', () {
      test('returns false when user is not authenticated', () async {
        when(() => mockAuth.currentUser).thenReturn(null);

        final result = await backupService.autoRestore();
        expect(result, isFalse);
      });

      test('returns false when no server secret exists', () async {
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'secret': null,
        });

        final result = await backupService.autoRestore();
        expect(result, isFalse);
      });

      test('returns false when no backup blob exists on server', () async {
        var callCount = 0;
        when(() => mockCallable.call<dynamic>(any())).thenAnswer((_) async {
          callCount++;
          return mockResult;
        });
        when(() => mockResult.data).thenAnswer((_) {
          if (callCount <= 1) {
            return <String, dynamic>{'secret': 'dGVzdC1zZWNyZXQ='};
          }
          return <String, dynamic>{'backupExists': false};
        });

        final result = await backupService.autoRestore();
        expect(result, isFalse);
      });

      test('calls storePrivateKeys and uploadKeyBundle on success', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockKeyMgmt.storePrivateKeys(any()))
            .thenAnswer((_) async {});
        when(() => mockKeyMgmt.uploadKeyBundle(any()))
            .thenAnswer((_) async {});

        // First: autoBackup to create a real encrypted blob
        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'secret': 'dGVzdC1zZWNyZXQ=',
        });
        await backupService.autoBackup();

        final blob = await secureStorage.read(key: 'e2ee_backup_blob');

        // Mock restore calls
        var callCount = 0;
        when(() => mockCallable.call<dynamic>(any())).thenAnswer((_) async {
          callCount++;
          return mockResult;
        });
        when(() => mockResult.data).thenAnswer((_) {
          if (callCount <= 1) {
            return <String, dynamic>{'secret': 'dGVzdC1zZWNyZXQ='};
          }
          return <String, dynamic>{
            'backupExists': true,
            'encryptedBlob': blob,
          };
        });

        final result = await backupService.autoRestore();
        expect(result, isTrue);

        verify(() => mockKeyMgmt.storePrivateKeys(any())).called(1);
        verify(() => mockKeyMgmt.uploadKeyBundle(any())).called(1);
      });

      test('returns false on decryption failure (corrupted blob)', () async {
        var callCount = 0;
        when(() => mockCallable.call<dynamic>(any())).thenAnswer((_) async {
          callCount++;
          return mockResult;
        });
        when(() => mockResult.data).thenAnswer((_) {
          if (callCount <= 1) {
            return <String, dynamic>{'secret': 'dGVzdC1zZWNyZXQ='};
          }
          return <String, dynamic>{
            'backupExists': true,
            'encryptedBlob': 'Y29ycnVwdGVkX2RhdGE=',
          };
        });

        final result = await backupService.autoRestore();
        expect(result, isFalse);
      });
    });

    // ==================== Full roundtrip ====================
    group('full auto backup/restore roundtrip', () {
      test('autoBackup then autoRestore yields matching key bundle', () async {
        when(() => mockKeyMgmt.loadPrivateKeys())
            .thenAnswer((_) async => testBundle);
        when(() => mockKeyMgmt.storePrivateKeys(any()))
            .thenAnswer((_) async {});
        when(() => mockKeyMgmt.uploadKeyBundle(any()))
            .thenAnswer((_) async {});

        when(() => mockResult.data).thenReturn(<String, dynamic>{
          'secret': 'dGVzdC1zZWNyZXQ=',
        });

        // Create backup
        await backupService.autoBackup();
        final blob = await secureStorage.read(key: 'e2ee_backup_blob');
        expect(blob, isNotNull);

        // Mock restore calls
        var callCount = 0;
        when(() => mockCallable.call<dynamic>(any())).thenAnswer((_) async {
          callCount++;
          return mockResult;
        });
        when(() => mockResult.data).thenAnswer((_) {
          if (callCount <= 1) {
            return <String, dynamic>{'secret': 'dGVzdC1zZWNyZXQ='};
          }
          return <String, dynamic>{
            'backupExists': true,
            'encryptedBlob': blob,
          };
        });

        // Restore
        final success = await backupService.autoRestore();
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
