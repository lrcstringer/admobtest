import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

void main() {
  late KeyManagementService service;
  late MockCryptoService mockCryptoService;
  late MockFlutterSecureStorage mockSecureStorage;
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockCallableResult;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockCryptoService = MockCryptoService();
    mockSecureStorage = MockFlutterSecureStorage();
    mockFunctions = MockFirebaseFunctions();
    mockCallable = MockHttpsCallable();
    mockCallableResult = MockHttpsCallableResult();

    // Default stubs for Ed25519 storage keys (optional, null by default)
    when(() => mockSecureStorage.read(key: 'e2ee_ed25519_identity_key'))
        .thenAnswer((_) async => null);
    when(() => mockSecureStorage.read(key: 'e2ee_ed25519_signature'))
        .thenAnswer((_) async => null);

    service = KeyManagementService(
      mockCryptoService,
      mockSecureStorage,
      mockFunctions,
    );
  });

  // Helper: create a fake key pair map as returned by generateX25519KeyPair
  Map<String, Uint8List> fakeKeyPair([int seed = 0]) {
    return {
      'privateKey': Uint8List.fromList(List.generate(32, (i) => i + seed)),
      'publicKey':
          Uint8List.fromList(List.generate(32, (i) => i + seed + 100)),
    };
  }

  // Helper: encode a key pair as "base64Private|base64Public"
  String encodeKeyPair(Map<String, Uint8List> kp) {
    return '${base64Encode(kp['privateKey']!)}|${base64Encode(kp['publicKey']!)}';
  }

  // Helper: extract the public base64 from an encoded pair
  String extractPublicBase64(String encodedPair) {
    return encodedPair.split('|')[1];
  }

  /// Stub generateX25519KeyPair, Ed25519 key generation, and signing.
  void stubKeyPairGeneration({int count = 12}) {
    var callIndex = 0;
    when(() => mockCryptoService.generateX25519KeyPair()).thenAnswer((_) async {
      final kp = fakeKeyPair(callIndex * 10);
      callIndex++;
      return kp;
    });
    // Ed25519 key pair (used for verifiable signatures)
    when(() => mockCryptoService.generateEd25519KeyPair()).thenAnswer((_) async {
      return fakeKeyPair(200);
    });
    // Ed25519 signing
    when(() => mockCryptoService.ed25519Sign(any(), any())).thenAnswer((_) async {
      return Uint8List.fromList(List.generate(64, (i) => i + 50));
    });
  }

  /// Stub randomBytes to return a predictable 2-byte value for registration ID.
  void stubRandomBytes() {
    when(() => mockCryptoService.randomBytes(any()))
        .thenReturn(Uint8List.fromList([0x12, 0x34]));
  }

  /// Creates a known KeyBundle for tests that require pre-existing stored keys.
  KeyBundle createStoredBundle({int otkCount = 3}) {
    final identityKp = fakeKeyPair(0);
    final signedPreKp = fakeKeyPair(10);
    final otks = <String>[];
    for (var i = 0; i < otkCount; i++) {
      otks.add(encodeKeyPair(fakeKeyPair(20 + i * 10)));
    }
    return KeyBundle(
      identityKeyPair: encodeKeyPair(identityKp),
      signedPreKey: encodeKeyPair(signedPreKp),
      signedPreKeySignature: 'c2lnbmF0dXJl',
      oneTimePreKeys: otks,
      registrationId: 12345,
    );
  }

  /// Stubs secure storage reads to return the given bundle's values.
  void stubStorageReadsForBundle(KeyBundle bundle) {
    when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
        .thenAnswer((_) async => bundle.identityKeyPair);
    when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key'))
        .thenAnswer((_) async => bundle.signedPreKey);
    when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key_sig'))
        .thenAnswer((_) async => bundle.signedPreKeySignature);
    when(() => mockSecureStorage.read(key: 'e2ee_one_time_pre_keys'))
        .thenAnswer((_) async => jsonEncode(bundle.oneTimePreKeys));
    when(() => mockSecureStorage.read(key: 'e2ee_registration_id'))
        .thenAnswer((_) async => bundle.registrationId.toString());
    when(() => mockSecureStorage.read(key: 'e2ee_ed25519_identity_key'))
        .thenAnswer((_) async => bundle.ed25519IdentityKeyPair);
    when(() => mockSecureStorage.read(key: 'e2ee_ed25519_signature'))
        .thenAnswer((_) async => bundle.ed25519Signature);
  }

  /// Stubs all secure storage writes to succeed.
  void stubStorageWrites() {
    when(() => mockSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).thenAnswer((_) async {});
  }

  group('KeyManagementService', () {
    // ==================== generateKeyBundle ====================
    group('generateKeyBundle', () {
      test('returns a KeyBundle with all fields populated', () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        expect(bundle.identityKeyPair, isNotEmpty);
        expect(bundle.signedPreKey, isNotEmpty);
        expect(bundle.signedPreKeySignature, isNotEmpty);
        expect(bundle.oneTimePreKeys, isNotEmpty);
        expect(bundle.registrationId, isNonNegative);
      });

      test('identity key pair is encoded as base64Private|base64Public',
          () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        final parts = bundle.identityKeyPair.split('|');
        expect(parts.length, 2);
        // Both parts should be valid base64
        expect(() => base64Decode(parts[0]), returnsNormally);
        expect(() => base64Decode(parts[1]), returnsNormally);
      });

      test('signed pre-key is encoded as base64Private|base64Public', () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        final parts = bundle.signedPreKey.split('|');
        expect(parts.length, 2);
        expect(() => base64Decode(parts[0]), returnsNormally);
        expect(() => base64Decode(parts[1]), returnsNormally);
      });

      test('signed pre-key signature is non-empty valid base64', () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        expect(bundle.signedPreKeySignature, isNotEmpty);
        expect(
            () => base64Decode(bundle.signedPreKeySignature), returnsNormally);
      });

      test('generates exactly 10 one-time pre-keys', () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        expect(bundle.oneTimePreKeys.length, 10);
      });

      test('each one-time pre-key is encoded as base64Private|base64Public',
          () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        for (final otk in bundle.oneTimePreKeys) {
          final parts = otk.split('|');
          expect(parts.length, 2);
          expect(() => base64Decode(parts[0]), returnsNormally);
          expect(() => base64Decode(parts[1]), returnsNormally);
        }
      });

      test('registration ID is a 16-bit value (0 to 65535)', () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        expect(bundle.registrationId, greaterThanOrEqualTo(0));
        expect(bundle.registrationId, lessThanOrEqualTo(65535));
      });

      test('registration ID is computed from 2 random bytes', () async {
        stubKeyPairGeneration();
        // Stub to return specific bytes [0x12, 0x34] => (0x12 << 8) | 0x34 = 4660
        when(() => mockCryptoService.randomBytes(2))
            .thenReturn(Uint8List.fromList([0x12, 0x34]));

        final bundle = await service.generateKeyBundle();

        expect(bundle.registrationId, 0x1234); // 4660
      });

      test(
          'calls generateX25519KeyPair 12 times (1 identity + 1 signed + 10 OTKs)',
          () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        await service.generateKeyBundle();

        verify(() => mockCryptoService.generateX25519KeyPair()).called(12);
      });

      test('one-time pre-keys have unique encoded values', () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        final otkSet = bundle.oneTimePreKeys.toSet();
        expect(otkSet.length, bundle.oneTimePreKeys.length);
      });

      test('identity key pair differs from signed pre-key', () async {
        stubKeyPairGeneration();
        stubRandomBytes();

        final bundle = await service.generateKeyBundle();

        expect(bundle.identityKeyPair, isNot(equals(bundle.signedPreKey)));
      });
    });

    // ==================== uploadKeyBundle ====================
    group('uploadKeyBundle', () {
      test('calls httpsCallable with "uploadKeyBundle"', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();
        when(() => mockFunctions.httpsCallable('uploadKeyBundle'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);

        await service.uploadKeyBundle(bundle);

        verify(() => mockFunctions.httpsCallable('uploadKeyBundle')).called(1);
      });

      test('sends only public halves in the payload', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();
        when(() => mockFunctions.httpsCallable('uploadKeyBundle'))
            .thenReturn(mockCallable);

        Map<String, dynamic>? capturedPayload;
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((invocation) async {
          capturedPayload =
              invocation.positionalArguments[0] as Map<String, dynamic>;
          return mockCallableResult;
        });

        await service.uploadKeyBundle(bundle);

        expect(capturedPayload, isNotNull);
        // identityKey should be the public half only
        expect(
          capturedPayload!['identityKey'],
          extractPublicBase64(bundle.identityKeyPair),
        );
        // signedPreKey should be the public half only
        expect(
          capturedPayload!['signedPreKey'],
          extractPublicBase64(bundle.signedPreKey),
        );
        // oneTimePreKeys should be public halves only
        final otkPublics = capturedPayload!['oneTimePreKeys'] as List<dynamic>;
        for (var i = 0; i < bundle.oneTimePreKeys.length; i++) {
          expect(
            otkPublics[i],
            extractPublicBase64(bundle.oneTimePreKeys[i]),
          );
        }
        // Signature and registrationId should be passed through
        expect(capturedPayload!['signedPreKeySignature'],
            bundle.signedPreKeySignature);
        expect(capturedPayload!['registrationId'], bundle.registrationId);
      });

      test('does not include private keys in the upload payload', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();
        when(() => mockFunctions.httpsCallable('uploadKeyBundle'))
            .thenReturn(mockCallable);

        Map<String, dynamic>? capturedPayload;
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((invocation) async {
          capturedPayload =
              invocation.positionalArguments[0] as Map<String, dynamic>;
          return mockCallableResult;
        });

        await service.uploadKeyBundle(bundle);

        // The identity key in the payload should NOT contain the pipe separator
        // (i.e., it is only the public part, not "private|public")
        final identityKey = capturedPayload!['identityKey'] as String;
        expect(identityKey.contains('|'), isFalse);

        final signedPreKey = capturedPayload!['signedPreKey'] as String;
        expect(signedPreKey.contains('|'), isFalse);
      });

      test('propagates errors from the Cloud Function', () async {
        final bundle = createStoredBundle();
        when(() => mockFunctions.httpsCallable('uploadKeyBundle'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenThrow(Exception('Server error'));

        expect(
          () => service.uploadKeyBundle(bundle),
          throwsA(isA<Exception>()),
        );
      });
    });

    // ==================== fetchKeyBundle ====================
    group('fetchKeyBundle', () {
      test('calls httpsCallable with "fetchKeyBundle" and target user ID',
          () async {
        when(() => mockFunctions.httpsCallable('fetchKeyBundle'))
            .thenReturn(mockCallable);
        when(() => mockCallableResult.data).thenReturn({
          'identityKey': 'aWRlbnRpdHlLZXk=',
          'signedPreKey': 'c2lnbmVkUHJlS2V5',
          'signedPreKeySignature': 'c2lnbmF0dXJl',
          'oneTimePreKey': 'b3RrMQ==',
          'registrationId': 67890,
        });

        Map<String, dynamic>? capturedPayload;
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((invocation) async {
          capturedPayload =
              invocation.positionalArguments[0] as Map<String, dynamic>;
          return mockCallableResult;
        });

        await service.fetchKeyBundle('bob_user_id');

        verify(() => mockFunctions.httpsCallable('fetchKeyBundle')).called(1);
        expect(capturedPayload!['targetUserId'], 'bob_user_id');
      });

      test('parses response into PublicKeyBundle correctly', () async {
        when(() => mockFunctions.httpsCallable('fetchKeyBundle'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);
        when(() => mockCallableResult.data).thenReturn({
          'identityKey': 'aWRlbnRpdHlLZXk=',
          'signedPreKey': 'c2lnbmVkUHJlS2V5',
          'signedPreKeySignature': 'c2lnbmF0dXJl',
          'oneTimePreKey': 'b3RrMQ==',
          'registrationId': 67890,
        });

        final publicBundle = await service.fetchKeyBundle('bob_user_id');

        expect(publicBundle.identityKey, 'aWRlbnRpdHlLZXk=');
        expect(publicBundle.signedPreKey, 'c2lnbmVkUHJlS2V5');
        expect(publicBundle.signedPreKeySignature, 'c2lnbmF0dXJl');
        expect(publicBundle.oneTimePreKeys, ['b3RrMQ==']);
        expect(publicBundle.registrationId, 67890);
        expect(publicBundle.userId, 'bob_user_id');
      });

      test('handles null oneTimePreKey by returning empty list', () async {
        when(() => mockFunctions.httpsCallable('fetchKeyBundle'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);
        when(() => mockCallableResult.data).thenReturn({
          'identityKey': 'aWRlbnRpdHlLZXk=',
          'signedPreKey': 'c2lnbmVkUHJlS2V5',
          'signedPreKeySignature': 'c2lnbmF0dXJl',
          'oneTimePreKey': null,
          'registrationId': 67890,
        });

        final publicBundle = await service.fetchKeyBundle('bob_user_id');

        expect(publicBundle.oneTimePreKeys, isEmpty);
      });

      test('throws on malformed response (missing required field)', () async {
        when(() => mockFunctions.httpsCallable('fetchKeyBundle'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);
        when(() => mockCallableResult.data).thenReturn({
          'identityKey': 'aWRlbnRpdHlLZXk=',
          // missing signedPreKey, signedPreKeySignature, registrationId
        });

        expect(
          () => service.fetchKeyBundle('bob_user_id'),
          throwsA(anything),
        );
      });

      test('propagates Cloud Function errors', () async {
        when(() => mockFunctions.httpsCallable('fetchKeyBundle'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenThrow(Exception('User not found'));

        expect(
          () => service.fetchKeyBundle('nonexistent_user'),
          throwsA(isA<Exception>()),
        );
      });
    });

    // ==================== storePrivateKeys ====================
    group('storePrivateKeys', () {
      test('writes identity key pair to secure storage', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();

        await service.storePrivateKeys(bundle);

        verify(() => mockSecureStorage.write(
              key: 'e2ee_identity_key',
              value: bundle.identityKeyPair,
            )).called(1);
      });

      test('writes signed pre-key to secure storage', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();

        await service.storePrivateKeys(bundle);

        verify(() => mockSecureStorage.write(
              key: 'e2ee_signed_pre_key',
              value: bundle.signedPreKey,
            )).called(1);
      });

      test('writes signed pre-key signature to secure storage', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();

        await service.storePrivateKeys(bundle);

        verify(() => mockSecureStorage.write(
              key: 'e2ee_signed_pre_key_sig',
              value: bundle.signedPreKeySignature,
            )).called(1);
      });

      test('writes one-time pre-keys as JSON array to secure storage',
          () async {
        final bundle = createStoredBundle();
        stubStorageWrites();

        await service.storePrivateKeys(bundle);

        verify(() => mockSecureStorage.write(
              key: 'e2ee_one_time_pre_keys',
              value: jsonEncode(bundle.oneTimePreKeys),
            )).called(1);
      });

      test('writes registration ID as string to secure storage', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();

        await service.storePrivateKeys(bundle);

        verify(() => mockSecureStorage.write(
              key: 'e2ee_registration_id',
              value: bundle.registrationId.toString(),
            )).called(1);
      });

      test('writes all 5 storage keys exactly once', () async {
        final bundle = createStoredBundle();
        stubStorageWrites();

        await service.storePrivateKeys(bundle);

        verify(() => mockSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).called(5);
      });
    });

    // ==================== loadPrivateKeys ====================
    group('loadPrivateKeys', () {
      test('returns null when no identity key is stored', () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => null);

        final result = await service.loadPrivateKeys();

        expect(result, isNull);
      });

      test(
          'returns null when identity key exists but signed pre-key is missing',
          () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => 'someIdentityKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key'))
            .thenAnswer((_) async => null);
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key_sig'))
            .thenAnswer((_) async => 'someSig');
        when(() => mockSecureStorage.read(key: 'e2ee_one_time_pre_keys'))
            .thenAnswer((_) async => '[]');
        when(() => mockSecureStorage.read(key: 'e2ee_registration_id'))
            .thenAnswer((_) async => '12345');

        final result = await service.loadPrivateKeys();

        expect(result, isNull);
      });

      test(
          'returns null when identity key exists but signature is missing',
          () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => 'someIdentityKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key'))
            .thenAnswer((_) async => 'someSignedPreKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key_sig'))
            .thenAnswer((_) async => null);
        when(() => mockSecureStorage.read(key: 'e2ee_one_time_pre_keys'))
            .thenAnswer((_) async => '[]');
        when(() => mockSecureStorage.read(key: 'e2ee_registration_id'))
            .thenAnswer((_) async => '12345');

        final result = await service.loadPrivateKeys();

        expect(result, isNull);
      });

      test('returns null when registration ID is missing', () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => 'someIdentityKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key'))
            .thenAnswer((_) async => 'someSignedPreKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key_sig'))
            .thenAnswer((_) async => 'someSig');
        when(() => mockSecureStorage.read(key: 'e2ee_one_time_pre_keys'))
            .thenAnswer((_) async => '[]');
        when(() => mockSecureStorage.read(key: 'e2ee_registration_id'))
            .thenAnswer((_) async => null);

        final result = await service.loadPrivateKeys();

        expect(result, isNull);
      });

      test('returns KeyBundle when all keys are stored', () async {
        final bundle = createStoredBundle();
        stubStorageReadsForBundle(bundle);

        final result = await service.loadPrivateKeys();

        expect(result, isNotNull);
        expect(result!.identityKeyPair, bundle.identityKeyPair);
        expect(result.signedPreKey, bundle.signedPreKey);
        expect(result.signedPreKeySignature, bundle.signedPreKeySignature);
        expect(result.oneTimePreKeys, bundle.oneTimePreKeys);
        expect(result.registrationId, bundle.registrationId);
      });

      test('returns empty OTK list when OTK JSON is null', () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => 'identityKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key'))
            .thenAnswer((_) async => 'signedPreKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key_sig'))
            .thenAnswer((_) async => 'sig');
        when(() => mockSecureStorage.read(key: 'e2ee_one_time_pre_keys'))
            .thenAnswer((_) async => null);
        when(() => mockSecureStorage.read(key: 'e2ee_registration_id'))
            .thenAnswer((_) async => '99');

        final result = await service.loadPrivateKeys();

        expect(result, isNotNull);
        expect(result!.oneTimePreKeys, isEmpty);
      });

      test('parses registration ID as integer', () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => 'identityKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key'))
            .thenAnswer((_) async => 'signedPreKey');
        when(() => mockSecureStorage.read(key: 'e2ee_signed_pre_key_sig'))
            .thenAnswer((_) async => 'sig');
        when(() => mockSecureStorage.read(key: 'e2ee_one_time_pre_keys'))
            .thenAnswer((_) async => '[]');
        when(() => mockSecureStorage.read(key: 'e2ee_registration_id'))
            .thenAnswer((_) async => '54321');

        final result = await service.loadPrivateKeys();

        expect(result!.registrationId, 54321);
      });
    });

    // ==================== replenishOneTimePreKeysIfNeeded ====================
    group('replenishOneTimePreKeysIfNeeded', () {
      test('does nothing when no stored keys exist', () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => null);

        await service.replenishOneTimePreKeysIfNeeded();

        verifyNever(() => mockFunctions.httpsCallable(any()));
      });

      test('does nothing when OTK count is at the threshold (5)', () async {
        final bundle = createStoredBundle(otkCount: 5);
        stubStorageReadsForBundle(bundle);

        await service.replenishOneTimePreKeysIfNeeded();

        verifyNever(() => mockFunctions.httpsCallable(any()));
      });

      test('does nothing when OTK count is above the threshold', () async {
        final bundle = createStoredBundle(otkCount: 8);
        stubStorageReadsForBundle(bundle);

        await service.replenishOneTimePreKeysIfNeeded();

        verifyNever(() => mockFunctions.httpsCallable(any()));
      });

      test('generates and uploads new batch when OTK count is below threshold',
          () async {
        final bundle = createStoredBundle(otkCount: 3);
        stubStorageReadsForBundle(bundle);
        stubKeyPairGeneration(count: 10);
        stubStorageWrites();

        when(() => mockFunctions.httpsCallable('replenishOneTimePreKeys'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);

        await service.replenishOneTimePreKeysIfNeeded();

        verify(() => mockCryptoService.generateX25519KeyPair()).called(10);
        verify(() => mockFunctions.httpsCallable('replenishOneTimePreKeys'))
            .called(1);
      });

      test('uploads only public parts of new OTKs', () async {
        final bundle = createStoredBundle(otkCount: 2);
        stubStorageReadsForBundle(bundle);
        stubKeyPairGeneration(count: 10);
        stubStorageWrites();

        when(() => mockFunctions.httpsCallable('replenishOneTimePreKeys'))
            .thenReturn(mockCallable);

        Map<String, dynamic>? capturedPayload;
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((invocation) async {
          capturedPayload =
              invocation.positionalArguments[0] as Map<String, dynamic>;
          return mockCallableResult;
        });

        await service.replenishOneTimePreKeysIfNeeded();

        final newPreKeys = capturedPayload!['newPreKeys'] as List<dynamic>;
        expect(newPreKeys.length, 10);
        // Each should be a base64 string without pipe separator (public only)
        for (final key in newPreKeys) {
          expect((key as String).contains('|'), isFalse);
        }
      });

      test('appends new OTKs to existing ones in storage', () async {
        final bundle = createStoredBundle(otkCount: 4);
        stubStorageReadsForBundle(bundle);
        stubKeyPairGeneration(count: 10);
        stubStorageWrites();

        when(() => mockFunctions.httpsCallable('replenishOneTimePreKeys'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);

        await service.replenishOneTimePreKeysIfNeeded();

        // Verify storePrivateKeys was called (it writes all 5 keys)
        // The OTK list should now have 4 old + 10 new = 14
        final otkWriteCall = verify(() => mockSecureStorage.write(
              key: 'e2ee_one_time_pre_keys',
              value: captureAny(named: 'value'),
            ));
        otkWriteCall.called(1);
        final writtenOtkJson = otkWriteCall.captured.first as String;
        final writtenOtks =
            List<String>.from(jsonDecode(writtenOtkJson) as List);
        expect(writtenOtks.length, 14); // 4 old + 10 new
      });
    });

    // ==================== rotateSignedPreKey ====================
    group('rotateSignedPreKey', () {
      test('does nothing when no stored keys exist', () async {
        when(() => mockSecureStorage.read(key: 'e2ee_identity_key'))
            .thenAnswer((_) async => null);

        await service.rotateSignedPreKey();

        verifyNever(() => mockCryptoService.generateX25519KeyPair());
        verifyNever(() => mockFunctions.httpsCallable(any()));
      });

      test('generates a new signed pre-key pair', () async {
        final bundle = createStoredBundle();
        stubStorageReadsForBundle(bundle);
        stubKeyPairGeneration(count: 1);
        stubStorageWrites();

        when(() => mockFunctions.httpsCallable('rotateSignedPreKey'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);

        await service.rotateSignedPreKey();

        verify(() => mockCryptoService.generateX25519KeyPair()).called(1);
      });

      test('uploads new signed pre-key and signature to server', () async {
        final bundle = createStoredBundle();
        stubStorageReadsForBundle(bundle);
        stubKeyPairGeneration(count: 1);
        stubStorageWrites();

        when(() => mockFunctions.httpsCallable('rotateSignedPreKey'))
            .thenReturn(mockCallable);

        Map<String, dynamic>? capturedPayload;
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((invocation) async {
          capturedPayload =
              invocation.positionalArguments[0] as Map<String, dynamic>;
          return mockCallableResult;
        });

        await service.rotateSignedPreKey();

        expect(capturedPayload, isNotNull);
        expect(capturedPayload!['newSignedPreKey'], isA<String>());
        expect(capturedPayload!['newSignedPreKeySignature'], isA<String>());
        // Uploaded key should not contain pipe (public only)
        expect(
          (capturedPayload!['newSignedPreKey'] as String).contains('|'),
          isFalse,
        );
      });

      test('updates local storage with new signed pre-key', () async {
        final bundle = createStoredBundle();
        stubStorageReadsForBundle(bundle);
        stubKeyPairGeneration(count: 1);
        stubStorageWrites();

        when(() => mockFunctions.httpsCallable('rotateSignedPreKey'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);

        await service.rotateSignedPreKey();

        // Verify signed pre-key was updated in storage
        final spkWriteCall = verify(() => mockSecureStorage.write(
              key: 'e2ee_signed_pre_key',
              value: captureAny(named: 'value'),
            ));
        spkWriteCall.called(1);
        final writtenSpk = spkWriteCall.captured.first as String;
        // Should contain pipe separator (full key pair stored locally)
        expect(writtenSpk.contains('|'), isTrue);
      });

      test('updates local storage with new signature', () async {
        final bundle = createStoredBundle();
        stubStorageReadsForBundle(bundle);
        stubKeyPairGeneration(count: 1);
        stubStorageWrites();

        when(() => mockFunctions.httpsCallable('rotateSignedPreKey'))
            .thenReturn(mockCallable);
        when(() => mockCallable.call<dynamic>(any()))
            .thenAnswer((_) async => mockCallableResult);

        await service.rotateSignedPreKey();

        final sigWriteCall = verify(() => mockSecureStorage.write(
              key: 'e2ee_signed_pre_key_sig',
              value: captureAny(named: 'value'),
            ));
        sigWriteCall.called(1);
        final writtenSig = sigWriteCall.captured.first as String;
        expect(writtenSig, isNotEmpty);
        // Signature should be valid base64
        expect(() => base64Decode(writtenSig), returnsNormally);
      });
    });

    // ==================== consumeOneTimePreKey ====================
    group('consumeOneTimePreKey', () {
      test('is a no-op that completes without error', () async {
        await service.consumeOneTimePreKey('some_user', 42);

        // Should not call any functions or storage
        verifyZeroInteractions(mockFunctions);
        verifyZeroInteractions(mockSecureStorage);
        verifyZeroInteractions(mockCryptoService);
      });

      test('does not call any Cloud Function', () async {
        await service.consumeOneTimePreKey('alice', 1);

        verifyNever(() => mockFunctions.httpsCallable(any()));
      });
    });

    // ==================== extractPublicBytes ====================
    group('extractPublicBytes', () {
      test('extracts the public key bytes from an encoded key pair', () {
        final publicBytes = Uint8List.fromList([10, 20, 30, 40, 50]);
        final privateBytes = Uint8List.fromList([1, 2, 3, 4, 5]);
        final encoded =
            '${base64Encode(privateBytes)}|${base64Encode(publicBytes)}';

        final result = service.extractPublicBytes(encoded);

        expect(result, equals(publicBytes));
      });

      test('returns Uint8List from base64-encoded public portion', () {
        final kp = fakeKeyPair(42);
        final encoded = encodeKeyPair(kp);

        final result = service.extractPublicBytes(encoded);

        expect(result, equals(kp['publicKey']));
      });

      test('does not return private key bytes', () {
        final kp = fakeKeyPair(7);
        final encoded = encodeKeyPair(kp);

        final result = service.extractPublicBytes(encoded);

        expect(result, isNot(equals(kp['privateKey'])));
      });
    });
  });
}
