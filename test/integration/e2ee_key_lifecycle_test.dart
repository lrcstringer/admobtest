import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
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

class MockKeyManagementService extends Mock implements KeyManagementService {}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late CryptoService crypto;
  late InMemorySecureStorage storage;
  late KeyManagementService keyMgmt;
  late MockFirebaseFunctions mockFunctions;

  setUp(() {
    crypto = CryptoService();
    storage = InMemorySecureStorage();
    mockFunctions = MockFirebaseFunctions();
    keyMgmt = KeyManagementService(crypto, storage, mockFunctions);
  });

  group('E2EE Key Lifecycle Integration', () {
    test('Generate key bundle -> all fields populated', () async {
      final bundle = await keyMgmt.generateKeyBundle();

      expect(bundle.identityKeyPair, isNotEmpty);
      expect(bundle.signedPreKey, isNotEmpty);
      expect(bundle.signedPreKeySignature, isNotEmpty);
      expect(bundle.oneTimePreKeys, isNotEmpty);
      expect(bundle.registrationId, isNonNegative);

      // Identity key pair should contain both private and public parts
      final identityParts = bundle.identityKeyPair.split('|');
      expect(identityParts.length, equals(2));
      expect(identityParts[0], isNotEmpty); // private key base64
      expect(identityParts[1], isNotEmpty); // public key base64

      // Signed pre-key should contain both private and public parts
      final signedPreParts = bundle.signedPreKey.split('|');
      expect(signedPreParts.length, equals(2));
      expect(signedPreParts[0], isNotEmpty);
      expect(signedPreParts[1], isNotEmpty);
    });

    test('OTK list has correct size (10 by default)', () async {
      final bundle = await keyMgmt.generateKeyBundle();

      expect(bundle.oneTimePreKeys.length, equals(10));

      // Each OTK should be a "private|public" pair
      for (final otk in bundle.oneTimePreKeys) {
        final parts = otk.split('|');
        expect(parts.length, equals(2));
        expect(parts[0], isNotEmpty);
        expect(parts[1], isNotEmpty);
      }
    });

    test('Signed pre-key pair is valid X25519 (32 bytes per key)', () async {
      final bundle = await keyMgmt.generateKeyBundle();

      final parts = bundle.signedPreKey.split('|');
      final privateBytes = base64Decode(parts[0]);
      final publicBytes = base64Decode(parts[1]);

      // X25519 keys are 32 bytes
      expect(privateBytes.length, equals(32));
      expect(publicBytes.length, equals(32));
    });

    test('Identity key pair is valid X25519 (32 bytes per key)', () async {
      final bundle = await keyMgmt.generateKeyBundle();

      final parts = bundle.identityKeyPair.split('|');
      final privateBytes = base64Decode(parts[0]);
      final publicBytes = base64Decode(parts[1]);

      // X25519 keys are 32 bytes
      expect(privateBytes.length, equals(32));
      expect(publicBytes.length, equals(32));
    });

    test('Registration ID is a reasonable value (16-bit unsigned)', () async {
      final bundle = await keyMgmt.generateKeyBundle();

      // Registration ID is derived from 2 random bytes: (b[0] << 8) | b[1]
      // Range: 0 to 65535
      expect(bundle.registrationId, greaterThanOrEqualTo(0));
      expect(bundle.registrationId, lessThanOrEqualTo(65535));
    });

    test('Store -> load roundtrip preserves bundle', () async {
      final originalBundle = await keyMgmt.generateKeyBundle();

      // Store to secure storage
      await keyMgmt.storePrivateKeys(originalBundle);

      // Load back from secure storage
      final loadedBundle = await keyMgmt.loadPrivateKeys();

      expect(loadedBundle, isNotNull);
      expect(loadedBundle!.identityKeyPair,
          equals(originalBundle.identityKeyPair));
      expect(loadedBundle.signedPreKey, equals(originalBundle.signedPreKey));
      expect(loadedBundle.signedPreKeySignature,
          equals(originalBundle.signedPreKeySignature));
      expect(
          loadedBundle.registrationId, equals(originalBundle.registrationId));
      expect(loadedBundle.oneTimePreKeys.length,
          equals(originalBundle.oneTimePreKeys.length));
      for (var i = 0; i < originalBundle.oneTimePreKeys.length; i++) {
        expect(loadedBundle.oneTimePreKeys[i],
            equals(originalBundle.oneTimePreKeys[i]));
      }
    });

    test('Second generation produces different keys', () async {
      final bundle1 = await keyMgmt.generateKeyBundle();
      final bundle2 = await keyMgmt.generateKeyBundle();

      // Identity keys must be different (extremely unlikely to collide)
      expect(bundle1.identityKeyPair, isNot(equals(bundle2.identityKeyPair)));
      // Signed pre-keys must be different
      expect(bundle1.signedPreKey, isNot(equals(bundle2.signedPreKey)));
      // Registration IDs may collide (only 16 bits), but keys won't
      // OTKs must be different
      expect(bundle1.oneTimePreKeys.first,
          isNot(equals(bundle2.oneTimePreKeys.first)));
    });

    test('Generated keys can be used for encryption (full roundtrip)',
        () async {
      // Generate bundles for Alice and Bob using real KeyManagementService
      final aliceStorage = InMemorySecureStorage();
      final bobStorage = InMemorySecureStorage();

      final aliceKeyMgmt =
          KeyManagementService(crypto, aliceStorage, mockFunctions);
      final bobKeyMgmt =
          KeyManagementService(crypto, bobStorage, mockFunctions);

      final aliceBundle = await aliceKeyMgmt.generateKeyBundle();
      await aliceKeyMgmt.storePrivateKeys(aliceBundle);

      final bobBundle = await bobKeyMgmt.generateKeyBundle();
      await bobKeyMgmt.storePrivateKeys(bobBundle);

      // Build public bundles from the generated key material
      final alicePublicBundle = PublicKeyBundle(
        identityKey: aliceBundle.identityKeyPair.split('|')[1],
        signedPreKey: aliceBundle.signedPreKey.split('|')[1],
        signedPreKeySignature: aliceBundle.signedPreKeySignature,
        oneTimePreKeys: aliceBundle.oneTimePreKeys
            .map((otk) => otk.split('|')[1])
            .toList(),
        registrationId: aliceBundle.registrationId,
        userId: 'alice',
        ed25519IdentityKey: aliceBundle.ed25519IdentityKeyPair?.split('|')[1],
        ed25519Signature: aliceBundle.ed25519Signature,
      );

      final bobPublicBundle = PublicKeyBundle(
        identityKey: bobBundle.identityKeyPair.split('|')[1],
        signedPreKey: bobBundle.signedPreKey.split('|')[1],
        signedPreKeySignature: bobBundle.signedPreKeySignature,
        oneTimePreKeys: bobBundle.oneTimePreKeys
            .map((otk) => otk.split('|')[1])
            .toList(),
        registrationId: bobBundle.registrationId,
        userId: 'bob',
        ed25519IdentityKey: bobBundle.ed25519IdentityKeyPair?.split('|')[1],
        ed25519Signature: bobBundle.ed25519Signature,
      );

      // Create mock key management services for the Signal Protocol
      final aliceMockKeyMgmt = MockKeyManagementService();
      final bobMockKeyMgmt = MockKeyManagementService();

      when(() => aliceMockKeyMgmt.loadPrivateKeys())
          .thenAnswer((_) async => aliceBundle);
      when(() => aliceMockKeyMgmt.fetchKeyBundle('bob'))
          .thenAnswer((_) async => bobPublicBundle);
      when(() => aliceMockKeyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});

      when(() => bobMockKeyMgmt.loadPrivateKeys())
          .thenAnswer((_) async => bobBundle);
      when(() => bobMockKeyMgmt.fetchKeyBundle('alice'))
          .thenAnswer((_) async => alicePublicBundle);
      when(() => bobMockKeyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});

      // Create Signal Protocol services
      final aliceSignal = SignalProtocolService(
          aliceMockKeyMgmt, crypto, InMemorySecureStorage());
      final bobSignal = SignalProtocolService(
          bobMockKeyMgmt, crypto, InMemorySecureStorage());

      // Alice encrypts a message for Bob
      await aliceSignal.establishSession('bob');
      final encrypted =
          await aliceSignal.encryptP2P('bob', 'Keys work for encryption!');

      // Bob decrypts the message
      final plaintext =
          await bobSignal.decryptP2P('alice', encrypted);
      expect(plaintext, equals('Keys work for encryption!'));
    });
  });
}
