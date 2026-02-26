import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/core/services/sender_key_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
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

class MockKeyManagementService extends Mock implements KeyManagementService {}

class MockSignalProtocolService extends Mock implements SignalProtocolService {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

// =============================================================================
// HELPER: Creates a SenderKeyService backed by real CryptoService
// =============================================================================

/// Creates a [SenderKeyService] that uses a real [CryptoService] for encryption,
/// backed by the given [InMemorySecureStorage]. The [SignalProtocolService] and
/// [FirebaseFunctions] are mocked since community encryption does not require
/// them for the core encrypt/decrypt path.
SenderKeyService _createSenderKeyService(InMemorySecureStorage storage) {
  return SenderKeyService(
    CryptoService(),
    MockSignalProtocolService(),
    storage,
    MockFirebaseFunctions(),
  );
}

/// Reads the sender key state from storage and returns key data map
/// suitable for [processReceivedSenderKey].
Map<String, dynamic> _extractSenderKeyData(
    InMemorySecureStorage storage, String communityId) {
  final json = storage.store['e2ee_sk_own_$communityId']!;
  final parsed = jsonDecode(json) as Map<String, dynamic>;
  return {
    'chainId': parsed['chainId'],
    'chainKey': parsed['chainKey'],
    'signingKey': parsed['signingKey'],
    'messageNumber': parsed['messageNumber'],
  };
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  const communityId = 'community_test_123';
  const communityId2 = 'community_test_456';
  const aliceId = 'alice_user_id';

  group('E2EE Community Flow Integration', () {
    test('Generate sender key -> encrypt -> process received key -> recipient decrypt',
        () async {
      // Alice generates a sender key and encrypts
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      await aliceService.generateSenderKey(communityId);
      final aliceKeyData = _extractSenderKeyData(aliceStorage, communityId);

      final encrypted =
          await aliceService.encryptCommunity(communityId, 'Hello community!');

      // Bob receives Alice's sender key and decrypts
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);

      await bobService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);
      final plaintext = await bobService.decryptCommunity(
          communityId, aliceId, encrypted);

      expect(plaintext, equals('Hello community!'));
    });

    test('Multiple members: A encrypts, B and C both decrypt', () async {
      // Alice generates sender key
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      await aliceService.generateSenderKey(communityId);
      final aliceKeyData = _extractSenderKeyData(aliceStorage, communityId);

      final encrypted =
          await aliceService.encryptCommunity(communityId, 'Broadcast to all');

      // Bob receives Alice's key and decrypts
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);
      await bobService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);
      final bobPlaintext = await bobService.decryptCommunity(
          communityId, aliceId, encrypted);

      // Charlie receives Alice's key and decrypts
      final charlieStorage = InMemorySecureStorage();
      final charlieService = _createSenderKeyService(charlieStorage);
      await charlieService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);
      final charliePlaintext = await charlieService.decryptCommunity(
          communityId, aliceId, encrypted);

      expect(bobPlaintext, equals('Broadcast to all'));
      expect(charliePlaintext, equals('Broadcast to all'));
    });

    test('10 sequential messages all decrypt in order', () async {
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      await aliceService.generateSenderKey(communityId);
      final aliceKeyData = _extractSenderKeyData(aliceStorage, communityId);

      // Alice encrypts 10 messages
      final encryptedMessages = <Map<String, dynamic>>[];
      for (var i = 0; i < 10; i++) {
        encryptedMessages.add(
            await aliceService.encryptCommunity(communityId, 'Message #$i'));
      }

      // Bob receives Alice's sender key and decrypts all in order
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);
      await bobService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);

      for (var i = 0; i < 10; i++) {
        final plaintext = await bobService.decryptCommunity(
            communityId, aliceId, encryptedMessages[i]);
        expect(plaintext, equals('Message #$i'));
      }
    });

    test('Rekey: new key for new messages after rekey', () async {
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      // Original key
      await aliceService.generateSenderKey(communityId);
      final oldKeyData = _extractSenderKeyData(aliceStorage, communityId);

      final encBeforeRekey = await aliceService.encryptCommunity(
          communityId, 'Before rekey');

      // Rekey
      await aliceService.rekeyAllSenderKeys(communityId);
      final newKeyData = _extractSenderKeyData(aliceStorage, communityId);

      // The chain IDs must differ after rekey
      expect(newKeyData['chainId'], isNot(equals(oldKeyData['chainId'])));

      final encAfterRekey = await aliceService.encryptCommunity(
          communityId, 'After rekey');

      // Bob with OLD key can decrypt old message
      final bobStorage1 = InMemorySecureStorage();
      final bobService1 = _createSenderKeyService(bobStorage1);
      await bobService1.processReceivedSenderKey(
          communityId, aliceId, oldKeyData);
      final ptOld = await bobService1.decryptCommunity(
          communityId, aliceId, encBeforeRekey);
      expect(ptOld, equals('Before rekey'));

      // Bob with NEW key can decrypt new message
      final bobStorage2 = InMemorySecureStorage();
      final bobService2 = _createSenderKeyService(bobStorage2);
      await bobService2.processReceivedSenderKey(
          communityId, aliceId, newKeyData);
      final ptNew = await bobService2.decryptCommunity(
          communityId, aliceId, encAfterRekey);
      expect(ptNew, equals('After rekey'));
    });

    test('processReceivedSenderKey -> decryptCommunity works', () async {
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      await aliceService.generateSenderKey(communityId);
      final aliceKeyData = _extractSenderKeyData(aliceStorage, communityId);

      final encrypted = await aliceService.encryptCommunity(
          communityId, 'Test processReceivedSenderKey');

      // Bob processes the received key and decrypts
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);

      await bobService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);

      // Verify the key is stored under the correct storage key
      expect(
        bobStorage.store.containsKey('e2ee_sk_${communityId}_$aliceId'),
        isTrue,
      );

      final plaintext = await bobService.decryptCommunity(
          communityId, aliceId, encrypted);
      expect(plaintext, equals('Test processReceivedSenderKey'));
    });

    test('Missing sender key -> StateError', () async {
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);

      // Bob has no sender key for Alice in this community
      final fakeEncrypted = {
        'ciphertext': base64Encode([1, 2, 3]),
        'e2ee': {
          'protocol': 'sender-key-v1',
          'senderKeyChainId': 'unknown_chain',
          'messageNumber': 0,
        },
      };

      expect(
        () => bobService.decryptCommunity(communityId, aliceId, fakeEncrypted),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('No sender key'),
        )),
      );
    });

    test('Different communities have independent keys', () async {
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      // Generate keys for two different communities
      await aliceService.generateSenderKey(communityId);
      await aliceService.generateSenderKey(communityId2);

      final keyData1 = _extractSenderKeyData(aliceStorage, communityId);
      final keyData2 = _extractSenderKeyData(aliceStorage, communityId2);

      // Chain IDs should be different
      expect(keyData1['chainId'], isNot(equals(keyData2['chainId'])));

      // Encrypt in community 1
      final enc1 = await aliceService.encryptCommunity(
          communityId, 'Community 1 message');
      // Encrypt in community 2
      final enc2 = await aliceService.encryptCommunity(
          communityId2, 'Community 2 message');

      // Bob with community 1 key decrypts community 1 message
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);
      await bobService.processReceivedSenderKey(
          communityId, aliceId, keyData1);
      await bobService.processReceivedSenderKey(
          communityId2, aliceId, keyData2);

      final pt1 = await bobService.decryptCommunity(
          communityId, aliceId, enc1);
      final pt2 = await bobService.decryptCommunity(
          communityId2, aliceId, enc2);

      expect(pt1, equals('Community 1 message'));
      expect(pt2, equals('Community 2 message'));
    });

    test('Out-of-order: encrypt 5 msgs, decrypt in shuffled order', () async {
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      await aliceService.generateSenderKey(communityId);
      final aliceKeyData = _extractSenderKeyData(aliceStorage, communityId);

      // Alice encrypts 5 messages
      final encrypted = <Map<String, dynamic>>[];
      for (var i = 0; i < 5; i++) {
        encrypted.add(
            await aliceService.encryptCommunity(communityId, 'Msg #$i'));
      }

      // Bob receives sender key and decrypts in order: 0, 3, 1, 4, 2
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);
      await bobService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);

      final decryptOrder = [0, 3, 1, 4, 2];
      for (final idx in decryptOrder) {
        final plaintext = await bobService.decryptCommunity(
            communityId, aliceId, encrypted[idx]);
        expect(plaintext, equals('Msg #$idx'));
      }
    });

    test('HMAC end-to-end: valid signature decrypts, tampered fails', () async {
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      await aliceService.generateSenderKey(communityId);
      final aliceKeyData = _extractSenderKeyData(aliceStorage, communityId);

      final encrypted =
          await aliceService.encryptCommunity(communityId, 'HMAC test');

      // Verify signature field exists
      final e2ee = encrypted['e2ee'] as Map<String, dynamic>;
      expect(e2ee['signature'], isA<String>());

      // Bob decrypts with valid signature — succeeds
      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);
      await bobService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);

      final plaintext = await bobService.decryptCommunity(
          communityId, aliceId, encrypted);
      expect(plaintext, equals('HMAC test'));

      // Charlie gets same key but tampered signature — fails
      final charlieStorage = InMemorySecureStorage();
      final charlieService = _createSenderKeyService(charlieStorage);
      await charlieService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);

      // Re-encrypt to get a fresh message (Charlie hasn't consumed msg 0)
      // Actually we need to use a fresh key for Charlie since Bob consumed msg 0
      final charlieStorage2 = InMemorySecureStorage();
      final charlieService2 = _createSenderKeyService(charlieStorage2);
      await charlieService2.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);

      // Create a tampered copy
      final tampered = Map<String, dynamic>.from(encrypted);
      final tamperedE2ee = Map<String, dynamic>.from(e2ee);
      tamperedE2ee['signature'] = base64Encode(
          CryptoService().randomBytes(32));
      tampered['e2ee'] = tamperedE2ee;

      expect(
        () => charlieService2.decryptCommunity(
            communityId, aliceId, tampered),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('HMAC signature verification failed'),
        )),
      );
    });

    test('Empty string roundtrip', () async {
      final aliceStorage = InMemorySecureStorage();
      final aliceService = _createSenderKeyService(aliceStorage);

      await aliceService.generateSenderKey(communityId);
      final aliceKeyData = _extractSenderKeyData(aliceStorage, communityId);

      final encrypted =
          await aliceService.encryptCommunity(communityId, '');

      final bobStorage = InMemorySecureStorage();
      final bobService = _createSenderKeyService(bobStorage);
      await bobService.processReceivedSenderKey(
          communityId, aliceId, aliceKeyData);

      final plaintext = await bobService.decryptCommunity(
          communityId, aliceId, encrypted);
      expect(plaintext, equals(''));
    });
  });
}
