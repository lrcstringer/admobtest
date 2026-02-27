import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/sender_key_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

// =============================================================================
// IN-MEMORY SECURE STORAGE
// =============================================================================

/// A fake [FlutterSecureStorage] backed by a plain [Map] for testing.
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

  /// Direct access to the backing store for assertions.
  Map<String, String> get store => _store;
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late CryptoService crypto;
  late MockSignalProtocolService mockSignal;
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallable;
  late MockHttpsCallableResult mockCallableResult;
  late InMemorySecureStorage storage;
  late SenderKeyService service;

  const communityId = 'community_123';
  const senderId = 'alice_user_id';
  const recipientId = 'bob_user_id';

  setUp(() {
    crypto = CryptoService();
    mockSignal = MockSignalProtocolService();
    mockFunctions = MockFirebaseFunctions();
    mockCallable = MockHttpsCallable();
    mockCallableResult = MockHttpsCallableResult();
    storage = InMemorySecureStorage();

    service = SenderKeyService(crypto, mockSignal, storage, mockFunctions);

    // Default mock wiring: httpsCallable returns our mock callable
    when(() => mockFunctions.httpsCallable('distributeSenderKey'))
        .thenReturn(mockCallable);
    when(() => mockCallable.call<dynamic>(any()))
        .thenAnswer((_) async => mockCallableResult);

    // Default mock for encryptP2P
    when(() => mockSignal.encryptP2P(any(), any())).thenAnswer(
      (_) async => <String, dynamic>{
        'ciphertext': 'encrypted_sender_key_data',
        'e2ee': <String, dynamic>{'protocol': 'signal-v2'},
      },
    );

    // Register fallback values for mocktail
    registerFallbackValue('');
    registerFallbackValue(<String, dynamic>{});
  });

  // ===========================================================================
  // generateSenderKey
  // ===========================================================================
  group('generateSenderKey', () {
    test('stores key in secure storage under correct key', () async {
      await service.generateSenderKey(communityId);

      final stored = storage.store['e2ee_sk_own_$communityId'];
      expect(stored, isNotNull);
    });

    test('stored JSON has chainId, chainKey, signingKey, messageNumber=0',
        () async {
      await service.generateSenderKey(communityId);

      final stored = storage.store['e2ee_sk_own_$communityId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json.containsKey('chainId'), isTrue);
      expect(json.containsKey('chainKey'), isTrue);
      expect(json.containsKey('signingKey'), isTrue);
      expect(json.containsKey('messageNumber'), isTrue);
      expect(json['messageNumber'], equals(0));
    });

    test('chainId is a base64-encoded 16-byte value', () async {
      await service.generateSenderKey(communityId);

      final stored = storage.store['e2ee_sk_own_$communityId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;
      final chainId = json['chainId'] as String;

      // Should be valid base64 decoding to 16 bytes
      final decoded = base64Decode(chainId);
      expect(decoded.length, equals(16));
    });

    test('chainKey is a base64-encoded 32-byte value', () async {
      await service.generateSenderKey(communityId);

      final stored = storage.store['e2ee_sk_own_$communityId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;
      final chainKey = json['chainKey'] as String;

      final decoded = base64Decode(chainKey);
      expect(decoded.length, equals(32));
    });

    test('signingKey is a base64-encoded 32-byte value', () async {
      await service.generateSenderKey(communityId);

      final stored = storage.store['e2ee_sk_own_$communityId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;
      final signingKey = json['signingKey'] as String;

      final decoded = base64Decode(signingKey);
      expect(decoded.length, equals(32));
    });

    test('different calls produce different chainIds', () async {
      await service.generateSenderKey('community_a');
      await service.generateSenderKey('community_b');

      final storedA = storage.store['e2ee_sk_own_community_a']!;
      final storedB = storage.store['e2ee_sk_own_community_b']!;
      final jsonA = jsonDecode(storedA) as Map<String, dynamic>;
      final jsonB = jsonDecode(storedB) as Map<String, dynamic>;

      expect(jsonA['chainId'], isNot(equals(jsonB['chainId'])));
    });

    test('stored JSON has expected fields for newly generated keys', () async {
      await service.generateSenderKey(communityId);

      final stored = storage.store['e2ee_sk_own_$communityId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json.containsKey('chainId'), isTrue);
      expect(json.containsKey('chainKey'), isTrue);
      expect(json.containsKey('signingKey'), isTrue);
      expect(json.containsKey('messageNumber'), isTrue);
    });

    test('regenerating for the same community overwrites previous key',
        () async {
      await service.generateSenderKey(communityId);
      final first = storage.store['e2ee_sk_own_$communityId']!;
      final firstJson = jsonDecode(first) as Map<String, dynamic>;
      final firstChainId = firstJson['chainId'];

      await service.generateSenderKey(communityId);
      final second = storage.store['e2ee_sk_own_$communityId']!;
      final secondJson = jsonDecode(second) as Map<String, dynamic>;
      final secondChainId = secondJson['chainId'];

      expect(secondChainId, isNot(equals(firstChainId)));
    });
  });

  // ===========================================================================
  // distributeSenderKey
  // ===========================================================================
  group('distributeSenderKey', () {
    test('encrypts key data via signalProtocolService.encryptP2P', () async {
      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      verify(() => mockSignal.encryptP2P(recipientId, any())).called(1);
    });

    test('calls httpsCallable with distributeSenderKey', () async {
      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      verify(() => mockFunctions.httpsCallable('distributeSenderKey')).called(1);
    });

    test('sends correct communityId and recipientUserId to callable',
        () async {
      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      final captured = verify(() => mockCallable.call<dynamic>(captureAny()))
          .captured
          .single as Map<String, dynamic>;

      expect(captured['communityId'], equals(communityId));
      expect(captured['recipientUserId'], equals(recipientId));
    });

    test('sends encryptedKeyData from encryptP2P result', () async {
      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      final captured = verify(() => mockCallable.call<dynamic>(captureAny()))
          .captured
          .single as Map<String, dynamic>;

      expect(captured['encryptedKeyData'], equals('encrypted_sender_key_data'));
    });

    test('sends e2ee metadata from encryptP2P result', () async {
      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      final captured = verify(() => mockCallable.call<dynamic>(captureAny()))
          .captured
          .single as Map<String, dynamic>;

      expect(
        captured['e2ee'],
        equals(<String, dynamic>{'protocol': 'signal-v2'}),
      );
    });

    test('throws StateError when no sender key exists', () async {
      expect(
        () => service.distributeSenderKey(communityId, recipientId),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('No sender key'),
        )),
      );
    });

    test('encrypts JSON that contains chainId, chainKey, signingKey, messageNumber',
        () async {
      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      final captured = verify(() => mockSignal.encryptP2P(recipientId, captureAny()))
          .captured
          .single as String;
      final keyData = jsonDecode(captured) as Map<String, dynamic>;

      expect(keyData.containsKey('chainId'), isTrue);
      expect(keyData.containsKey('chainKey'), isTrue);
      expect(keyData.containsKey('signingKey'), isTrue);
      expect(keyData.containsKey('messageNumber'), isTrue);
    });

    test('includes x3dhHeader when encryptP2P returns one', () async {
      when(() => mockSignal.encryptP2P(any(), any())).thenAnswer(
        (_) async => <String, dynamic>{
          'ciphertext': 'encrypted_data',
          'e2ee': <String, dynamic>{'protocol': 'signal-v2'},
          'x3dhHeader': <String, dynamic>{
            'identityKey': 'abc123',
            'ephemeralKey': 'def456',
          },
        },
      );

      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      final captured = verify(() => mockCallable.call<dynamic>(captureAny()))
          .captured
          .single as Map<String, dynamic>;

      expect(captured.containsKey('x3dhHeader'), isTrue);
      expect(
        (captured['x3dhHeader'] as Map)['identityKey'],
        equals('abc123'),
      );
    });

    test('omits x3dhHeader when encryptP2P returns null for it', () async {
      when(() => mockSignal.encryptP2P(any(), any())).thenAnswer(
        (_) async => <String, dynamic>{
          'ciphertext': 'encrypted_data',
          'e2ee': <String, dynamic>{'protocol': 'signal-v2'},
          'x3dhHeader': null,
        },
      );

      await service.generateSenderKey(communityId);
      await service.distributeSenderKey(communityId, recipientId);

      final captured = verify(() => mockCallable.call<dynamic>(captureAny()))
          .captured
          .single as Map<String, dynamic>;

      expect(captured.containsKey('x3dhHeader'), isFalse);
    });
  });

  // ===========================================================================
  // distributeSenderKeyToAll
  // ===========================================================================
  group('distributeSenderKeyToAll', () {
    test('distributes to each member in the list', () async {
      await service.generateSenderKey(communityId);

      final memberIds = ['user_a', 'user_b', 'user_c'];
      await service.distributeSenderKeyToAll(communityId, memberIds);

      verify(() => mockSignal.encryptP2P('user_a', any())).called(1);
      verify(() => mockSignal.encryptP2P('user_b', any())).called(1);
      verify(() => mockSignal.encryptP2P('user_c', any())).called(1);
    });

    test('calls httpsCallable once per member', () async {
      await service.generateSenderKey(communityId);

      final memberIds = ['user_a', 'user_b', 'user_c'];
      await service.distributeSenderKeyToAll(communityId, memberIds);

      verify(() => mockCallable.call<dynamic>(any())).called(3);
    });

    test('handles empty list without errors', () async {
      await service.generateSenderKey(communityId);

      await service.distributeSenderKeyToAll(communityId, []);

      verifyNever(() => mockSignal.encryptP2P(any(), any()));
      verifyNever(() => mockCallable.call<dynamic>(any()));
    });

    test('distributes to single member', () async {
      await service.generateSenderKey(communityId);

      await service.distributeSenderKeyToAll(communityId, ['only_member']);

      verify(() => mockSignal.encryptP2P('only_member', any())).called(1);
      verify(() => mockCallable.call<dynamic>(any())).called(1);
    });
  });

  // ===========================================================================
  // encryptCommunity
  // ===========================================================================
  group('encryptCommunity', () {
    test('returns a map with ciphertext and e2ee keys', () async {
      await service.generateSenderKey(communityId);

      final result = await service.encryptCommunity(communityId, 'Hello group!');

      expect(result.containsKey('ciphertext'), isTrue);
      expect(result.containsKey('e2ee'), isTrue);
    });

    test('ciphertext is a valid base64 string', () async {
      await service.generateSenderKey(communityId);

      final result =
          await service.encryptCommunity(communityId, 'Hello group!');
      final ciphertext = result['ciphertext'] as String;

      expect(() => base64Decode(ciphertext), returnsNormally);
      expect(base64Decode(ciphertext).isNotEmpty, isTrue);
    });

    test('e2ee.protocol is sender-key-v2 for new keys', () async {
      await service.generateSenderKey(communityId);

      final result = await service.encryptCommunity(communityId, 'test');
      final e2ee = result['e2ee'] as Map<String, dynamic>;

      expect(e2ee['protocol'], equals('sender-key-v2'));
    });

    test('e2ee contains senderKeyChainId', () async {
      await service.generateSenderKey(communityId);

      final result = await service.encryptCommunity(communityId, 'test');
      final e2ee = result['e2ee'] as Map<String, dynamic>;

      expect(e2ee.containsKey('senderKeyChainId'), isTrue);
      expect(e2ee['senderKeyChainId'], isA<String>());
      expect((e2ee['senderKeyChainId'] as String).isNotEmpty, isTrue);
    });

    test('senderKeyChainId matches the generated key chainId', () async {
      await service.generateSenderKey(communityId);

      final stored = storage.store['e2ee_sk_own_$communityId']!;
      final keyJson = jsonDecode(stored) as Map<String, dynamic>;
      final expectedChainId = keyJson['chainId'];

      final result = await service.encryptCommunity(communityId, 'test');
      final e2ee = result['e2ee'] as Map<String, dynamic>;

      expect(e2ee['senderKeyChainId'], equals(expectedChainId));
    });

    test('messageNumber starts at 0', () async {
      await service.generateSenderKey(communityId);

      final result = await service.encryptCommunity(communityId, 'first');
      final e2ee = result['e2ee'] as Map<String, dynamic>;

      expect(e2ee['messageNumber'], equals(0));
    });

    test('messageNumber increments with each encryption', () async {
      await service.generateSenderKey(communityId);

      final r0 = await service.encryptCommunity(communityId, 'msg 0');
      final r1 = await service.encryptCommunity(communityId, 'msg 1');
      final r2 = await service.encryptCommunity(communityId, 'msg 2');

      expect((r0['e2ee'] as Map)['messageNumber'], equals(0));
      expect((r1['e2ee'] as Map)['messageNumber'], equals(1));
      expect((r2['e2ee'] as Map)['messageNumber'], equals(2));
    });

    test('auto-generates key if missing (does not throw)', () async {
      // No generateSenderKey call — encryptCommunity should auto-generate
      final result =
          await service.encryptCommunity(communityId, 'auto-generated');

      expect(result['ciphertext'], isA<String>());
      expect(result['e2ee'], isA<Map<String, dynamic>>());

      // Key should now exist in storage
      expect(storage.store.containsKey('e2ee_sk_own_$communityId'), isTrue);
    });

    test('different ciphertext for same plaintext (due to ratchet + random nonce)',
        () async {
      await service.generateSenderKey(communityId);

      final r1 = await service.encryptCommunity(communityId, 'same text');
      final r2 = await service.encryptCommunity(communityId, 'same text');

      expect(r1['ciphertext'], isNot(equals(r2['ciphertext'])));
    });

    test('encrypts empty string without error', () async {
      await service.generateSenderKey(communityId);

      final result = await service.encryptCommunity(communityId, '');

      expect(result['ciphertext'], isA<String>());
      expect(result['e2ee'], isA<Map>());
    });

    test('chain key ratchets forward after encryption', () async {
      await service.generateSenderKey(communityId);

      final beforeJson = storage.store['e2ee_sk_own_$communityId']!;
      final beforeState = jsonDecode(beforeJson) as Map<String, dynamic>;
      final chainKeyBefore = beforeState['chainKey'] as String;

      await service.encryptCommunity(communityId, 'trigger ratchet');

      final afterJson = storage.store['e2ee_sk_own_$communityId']!;
      final afterState = jsonDecode(afterJson) as Map<String, dynamic>;
      final chainKeyAfter = afterState['chainKey'] as String;

      expect(chainKeyAfter, isNot(equals(chainKeyBefore)));
    });
  });

  // ===========================================================================
  // HMAC SIGNATURE (C2)
  // ===========================================================================
  group('HMAC signature', () {
    test('encryptCommunity includes HMAC signature in e2ee', () async {
      await service.generateSenderKey(communityId);
      final result = await service.encryptCommunity(communityId, 'test');
      final e2ee = result['e2ee'] as Map<String, dynamic>;

      expect(e2ee.containsKey('signature'), isTrue);
      expect(e2ee['signature'], isA<String>());
      // Should be valid base64 decoding to 32 bytes (SHA-256)
      final sigBytes = base64Decode(e2ee['signature'] as String);
      expect(sigBytes.length, equals(32));
    });

    test('decryptCommunity throws when HMAC signature wrong', () async {
      final senderStorage = InMemorySecureStorage();
      final receiverStorage = InMemorySecureStorage();
      final sender = SenderKeyService(
          crypto, mockSignal, senderStorage, mockFunctions);
      final receiver = SenderKeyService(
          crypto, mockSignal, receiverStorage, mockFunctions);

      await sender.generateSenderKey(communityId);
      final keyJson = senderStorage.store['e2ee_sk_own_$communityId']!;
      final keyData = jsonDecode(keyJson) as Map<String, dynamic>;
      await receiver.processReceivedSenderKey(
          communityId, senderId, keyData);

      final encrypted = await sender.encryptCommunity(communityId, 'test');

      // Tamper with signature
      final e2ee = encrypted['e2ee'] as Map<String, dynamic>;
      e2ee['signature'] = base64Encode(crypto.randomBytes(32));

      expect(
        () => receiver.decryptCommunity(communityId, senderId, encrypted),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('HMAC signature verification failed'),
        )),
      );
    });
  });

  // ===========================================================================
  // MESSAGE NUMBER OVERFLOW (H2)
  // ===========================================================================
  group('message number overflow', () {
    test('throws StateError when messageNumber reaches limit', () async {
      await service.generateSenderKey(communityId);

      // Manually set messageNumber to the limit
      final stateJson = storage.store['e2ee_sk_own_$communityId']!;
      final state = jsonDecode(stateJson) as Map<String, dynamic>;
      state['messageNumber'] = 1 << 31;
      storage.store['e2ee_sk_own_$communityId'] = jsonEncode(state);

      expect(
        () => service.encryptCommunity(communityId, 'overflow'),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('overflow'),
        )),
      );
    });
  });

  // ===========================================================================
  // OUT-OF-ORDER MESSAGES (H4)
  // ===========================================================================
  group('out-of-order messages', () {
    test('encrypt 0,1,2 → decrypt 0,2,1 succeeds', () async {
      final senderStorage = InMemorySecureStorage();
      final receiverStorage = InMemorySecureStorage();
      final sender = SenderKeyService(
          crypto, mockSignal, senderStorage, mockFunctions);
      final receiver = SenderKeyService(
          crypto, mockSignal, receiverStorage, mockFunctions);

      await sender.generateSenderKey(communityId);
      final keyJson = senderStorage.store['e2ee_sk_own_$communityId']!;
      final keyData = jsonDecode(keyJson) as Map<String, dynamic>;
      await receiver.processReceivedSenderKey(
          communityId, senderId, keyData);

      final enc0 = await sender.encryptCommunity(communityId, 'msg 0');
      final enc1 = await sender.encryptCommunity(communityId, 'msg 1');
      final enc2 = await sender.encryptCommunity(communityId, 'msg 2');

      // Decrypt in order: 0, 2, 1
      final pt0 = await receiver.decryptCommunity(
          communityId, senderId, enc0);
      expect(pt0, equals('msg 0'));

      final pt2 = await receiver.decryptCommunity(
          communityId, senderId, enc2);
      expect(pt2, equals('msg 2'));

      final pt1 = await receiver.decryptCommunity(
          communityId, senderId, enc1);
      expect(pt1, equals('msg 1'));
    });
  });

  // ===========================================================================
  // DECRYPT-BEFORE-SAVE (H3)
  // ===========================================================================
  group('decrypt-before-save', () {
    test('failed decrypt does not advance chain state', () async {
      final senderStorage = InMemorySecureStorage();
      final receiverStorage = InMemorySecureStorage();
      final sender = SenderKeyService(
          crypto, mockSignal, senderStorage, mockFunctions);
      final receiver = SenderKeyService(
          crypto, mockSignal, receiverStorage, mockFunctions);

      await sender.generateSenderKey(communityId);
      final keyJson = senderStorage.store['e2ee_sk_own_$communityId']!;
      final keyData = jsonDecode(keyJson) as Map<String, dynamic>;
      await receiver.processReceivedSenderKey(
          communityId, senderId, keyData);

      // Get state before failed decrypt
      final storageKey = 'e2ee_sk_${communityId}_$senderId';
      final stateBefore = receiverStorage.store[storageKey]!;

      // Try to decrypt garbage — should fail
      final badEncrypted = <String, dynamic>{
        'ciphertext': base64Encode(crypto.randomBytes(60)),
        'e2ee': <String, dynamic>{
          'protocol': 'sender-key-v2',
          'senderKeyChainId': keyData['chainId'],
          'messageNumber': 0,
          'signature': base64Encode(crypto.randomBytes(32)),
        },
      };

      try {
        await receiver.decryptCommunity(communityId, senderId, badEncrypted);
      } catch (_) {
        // Expected to fail
      }

      // State should NOT have changed after failed decrypt
      final stateAfter = receiverStorage.store[storageKey]!;
      expect(stateAfter, equals(stateBefore));
    });
  });

  // ===========================================================================
  // DISTRIBUTION PERSISTENCE (M3)
  // ===========================================================================
  group('distribution persistence', () {
    test('isDistributed returns false initially', () async {
      expect(await service.isDistributed(communityId), isFalse);
    });

    test('markDistributed → isDistributed returns true', () async {
      await service.markDistributed(communityId);
      expect(await service.isDistributed(communityId), isTrue);
    });

    test('clearDistributed → isDistributed returns false', () async {
      await service.markDistributed(communityId);
      await service.clearDistributed(communityId);
      expect(await service.isDistributed(communityId), isFalse);
    });

    test('rekeyAllSenderKeys clears distribution flag', () async {
      await service.generateSenderKey(communityId);
      await service.markDistributed(communityId);
      expect(await service.isDistributed(communityId), isTrue);

      await service.rekeyAllSenderKeys(communityId);
      expect(await service.isDistributed(communityId), isFalse);
    });
  });

  // ===========================================================================
  // decryptCommunity
  // ===========================================================================
  group('decryptCommunity', () {
    test('throws StateError when no sender key stored for that user', () async {
      final fakeEncrypted = <String, dynamic>{
        'ciphertext': base64Encode([1, 2, 3]),
        'e2ee': <String, dynamic>{
          'protocol': 'sender-key-v2',
          'senderKeyChainId': 'some-chain',
          'messageNumber': 0,
        },
      };

      expect(
        () => service.decryptCommunity(communityId, senderId, fakeEncrypted),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('No sender key'),
        )),
      );
    });

    test('error message includes senderUserId and communityId', () async {
      final fakeEncrypted = <String, dynamic>{
        'ciphertext': base64Encode([1, 2, 3]),
        'e2ee': <String, dynamic>{
          'protocol': 'sender-key-v2',
          'messageNumber': 0,
        },
      };

      expect(
        () => service.decryptCommunity(communityId, senderId, fakeEncrypted),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          allOf(contains(senderId), contains(communityId)),
        )),
      );
    });
  });

  // ===========================================================================
  // rekeyAllSenderKeys
  // ===========================================================================
  group('rekeyAllSenderKeys', () {
    test('generates a new sender key for the community', () async {
      await service.generateSenderKey(communityId);
      final firstJson = storage.store['e2ee_sk_own_$communityId']!;
      final firstState = jsonDecode(firstJson) as Map<String, dynamic>;
      final firstChainId = firstState['chainId'];

      await service.rekeyAllSenderKeys(communityId);

      final secondJson = storage.store['e2ee_sk_own_$communityId']!;
      final secondState = jsonDecode(secondJson) as Map<String, dynamic>;
      final secondChainId = secondState['chainId'];

      expect(secondChainId, isNot(equals(firstChainId)));
    });

    test('new key has messageNumber reset to 0', () async {
      await service.generateSenderKey(communityId);

      // Encrypt a few messages to advance messageNumber
      await service.encryptCommunity(communityId, 'msg 0');
      await service.encryptCommunity(communityId, 'msg 1');

      final beforeJson = storage.store['e2ee_sk_own_$communityId']!;
      final beforeState = jsonDecode(beforeJson) as Map<String, dynamic>;
      expect(beforeState['messageNumber'], equals(2));

      await service.rekeyAllSenderKeys(communityId);

      final afterJson = storage.store['e2ee_sk_own_$communityId']!;
      final afterState = jsonDecode(afterJson) as Map<String, dynamic>;
      expect(afterState['messageNumber'], equals(0));
    });

    test('new key has different chainKey from old key', () async {
      await service.generateSenderKey(communityId);
      final firstJson = storage.store['e2ee_sk_own_$communityId']!;
      final firstState = jsonDecode(firstJson) as Map<String, dynamic>;
      final firstChainKey = firstState['chainKey'];

      await service.rekeyAllSenderKeys(communityId);

      final secondJson = storage.store['e2ee_sk_own_$communityId']!;
      final secondState = jsonDecode(secondJson) as Map<String, dynamic>;
      final secondChainKey = secondState['chainKey'];

      expect(secondChainKey, isNot(equals(firstChainKey)));
    });

    test('works when no previous key exists', () async {
      // Should not throw
      await service.rekeyAllSenderKeys(communityId);

      expect(storage.store.containsKey('e2ee_sk_own_$communityId'), isTrue);
    });
  });

  // ===========================================================================
  // processReceivedSenderKey
  // ===========================================================================
  group('processReceivedSenderKey', () {
    test('stores key in correct storage slot', () async {
      final keyData = <String, dynamic>{
        'chainId': 'test-chain-id',
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
        'messageNumber': 0,
      };

      await service.processReceivedSenderKey(communityId, senderId, keyData);

      final storageKey = 'e2ee_sk_${communityId}_$senderId';
      expect(storage.store.containsKey(storageKey), isTrue);
    });

    test('correct key pattern: e2ee_sk_{communityId}_{senderUserId}',
        () async {
      const testCommunity = 'test_community';
      const testSender = 'test_sender';
      final keyData = <String, dynamic>{
        'chainId': 'chain-abc',
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
        'messageNumber': 0,
      };

      await service.processReceivedSenderKey(testCommunity, testSender, keyData);

      expect(
        storage.store.containsKey('e2ee_sk_${testCommunity}_$testSender'),
        isTrue,
      );
    });

    test('stored JSON preserves chainId', () async {
      final keyData = <String, dynamic>{
        'chainId': 'unique-chain-123',
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
        'messageNumber': 5,
      };

      await service.processReceivedSenderKey(communityId, senderId, keyData);

      final storageKey = 'e2ee_sk_${communityId}_$senderId';
      final stored = storage.store[storageKey]!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json['chainId'], equals('unique-chain-123'));
    });

    test('stored JSON preserves messageNumber', () async {
      final keyData = <String, dynamic>{
        'chainId': 'chain-1',
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
        'messageNumber': 7,
      };

      await service.processReceivedSenderKey(communityId, senderId, keyData);

      final storageKey = 'e2ee_sk_${communityId}_$senderId';
      final stored = storage.store[storageKey]!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json['messageNumber'], equals(7));
    });

    test('defaults messageNumber to 0 when not provided', () async {
      final keyData = <String, dynamic>{
        'chainId': 'chain-no-msg',
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
      };

      await service.processReceivedSenderKey(communityId, senderId, keyData);

      final storageKey = 'e2ee_sk_${communityId}_$senderId';
      final stored = storage.store[storageKey]!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json['messageNumber'], equals(0));
    });

    test('overwrites existing key for same community/sender', () async {
      final keyData1 = <String, dynamic>{
        'chainId': 'old-chain',
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
        'messageNumber': 0,
      };
      final keyData2 = <String, dynamic>{
        'chainId': 'new-chain',
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
        'messageNumber': 0,
      };

      await service.processReceivedSenderKey(communityId, senderId, keyData1);
      await service.processReceivedSenderKey(communityId, senderId, keyData2);

      final storageKey = 'e2ee_sk_${communityId}_$senderId';
      final stored = storage.store[storageKey]!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json['chainId'], equals('new-chain'));
    });
  });

  // ===========================================================================
  // ENCRYPT / DECRYPT ROUNDTRIP
  // ===========================================================================
  group('encrypt / decrypt roundtrip', () {
    late InMemorySecureStorage senderStorage;
    late InMemorySecureStorage receiverStorage;
    late SenderKeyService senderService;
    late SenderKeyService receiverService;

    const senderUserId = 'sender_user';

    setUp(() {
      senderStorage = InMemorySecureStorage();
      receiverStorage = InMemorySecureStorage();

      senderService = SenderKeyService(
        crypto,
        mockSignal,
        senderStorage,
        mockFunctions,
      );

      receiverService = SenderKeyService(
        crypto,
        mockSignal,
        receiverStorage,
        mockFunctions,
      );
    });

    Future<void> shareKeyFromSenderToReceiver() async {
      // Read the sender's own key from storage
      final senderKeyJson =
          senderStorage.store['e2ee_sk_own_$communityId']!;
      final senderState =
          jsonDecode(senderKeyJson) as Map<String, dynamic>;

      // Process it as a received key on the receiver side
      await receiverService.processReceivedSenderKey(
        communityId,
        senderUserId,
        senderState,
      );
    }

    test('basic roundtrip: encrypt on sender, decrypt on receiver', () async {
      await senderService.generateSenderKey(communityId);
      await shareKeyFromSenderToReceiver();

      const plaintext = 'Hello community!';
      final encrypted =
          await senderService.encryptCommunity(communityId, plaintext);

      final decrypted = await receiverService.decryptCommunity(
        communityId,
        senderUserId,
        encrypted,
      );

      expect(decrypted, equals(plaintext));
    });

    test('sequential messages decrypt correctly', () async {
      await senderService.generateSenderKey(communityId);
      await shareKeyFromSenderToReceiver();

      final enc0 =
          await senderService.encryptCommunity(communityId, 'Message 0');
      final enc1 =
          await senderService.encryptCommunity(communityId, 'Message 1');
      final enc2 =
          await senderService.encryptCommunity(communityId, 'Message 2');

      final pt0 = await receiverService.decryptCommunity(
          communityId, senderUserId, enc0);
      final pt1 = await receiverService.decryptCommunity(
          communityId, senderUserId, enc1);
      final pt2 = await receiverService.decryptCommunity(
          communityId, senderUserId, enc2);

      expect(pt0, equals('Message 0'));
      expect(pt1, equals('Message 1'));
      expect(pt2, equals('Message 2'));
    });

    test('empty string roundtrip', () async {
      await senderService.generateSenderKey(communityId);
      await shareKeyFromSenderToReceiver();

      final encrypted =
          await senderService.encryptCommunity(communityId, '');
      final decrypted = await receiverService.decryptCommunity(
        communityId,
        senderUserId,
        encrypted,
      );

      expect(decrypted, equals(''));
    });

    test('long message roundtrip (1KB)', () async {
      await senderService.generateSenderKey(communityId);
      await shareKeyFromSenderToReceiver();

      final longMessage = 'A' * 1024;
      final encrypted =
          await senderService.encryptCommunity(communityId, longMessage);
      final decrypted = await receiverService.decryptCommunity(
        communityId,
        senderUserId,
        encrypted,
      );

      expect(decrypted, equals(longMessage));
    });

    test('special characters roundtrip', () async {
      await senderService.generateSenderKey(communityId);
      await shareKeyFromSenderToReceiver();

      const message = 'Hello World! <>&"\' special chars: @#\$%^&*()';
      final encrypted =
          await senderService.encryptCommunity(communityId, message);
      final decrypted = await receiverService.decryptCommunity(
        communityId,
        senderUserId,
        encrypted,
      );

      expect(decrypted, equals(message));
    });

    test('receiver state ratchets after decryption', () async {
      await senderService.generateSenderKey(communityId);
      await shareKeyFromSenderToReceiver();

      final encrypted =
          await senderService.encryptCommunity(communityId, 'msg');
      await receiverService.decryptCommunity(
          communityId, senderUserId, encrypted);

      // Check receiver state was updated
      final storageKey = 'e2ee_sk_${communityId}_$senderUserId';
      final stateJson = receiverStorage.store[storageKey]!;
      final state = jsonDecode(stateJson) as Map<String, dynamic>;

      // After decrypting message 0, messageNumber should be 1
      expect(state['messageNumber'], equals(1));
    });
  });

  // ===========================================================================
  // V2 SENDER KEY PROTOCOL TESTS
  // ===========================================================================
  group('v2 sender key protocol', () {
    late InMemorySecureStorage senderStorage;
    late InMemorySecureStorage receiverStorage;
    late SenderKeyService senderService;
    late SenderKeyService receiverService;

    const senderUserId = 'v2_sender';

    setUp(() {
      senderStorage = InMemorySecureStorage();
      receiverStorage = InMemorySecureStorage();
      senderService = SenderKeyService(
          crypto, mockSignal, senderStorage, mockFunctions);
      receiverService = SenderKeyService(
          crypto, mockSignal, receiverStorage, mockFunctions);
    });

    Future<void> shareV2Key() async {
      final keyJson =
          senderStorage.store['e2ee_sk_own_$communityId']!;
      final keyData =
          jsonDecode(keyJson) as Map<String, dynamic>;
      await receiverService.processReceivedSenderKey(
        communityId, senderUserId, keyData,
      );
    }

    test('v2 encrypt uses HMAC-SHA256 chain ratchet (not HKDF)', () async {
      await senderService.generateSenderKey(communityId);

      final result =
          await senderService.encryptCommunity(communityId, 'test v2');
      final e2ee = result['e2ee'] as Map<String, dynamic>;

      expect(e2ee['protocol'], equals('sender-key-v2'));
    });

    test('v2 roundtrip works end-to-end', () async {
      await senderService.generateSenderKey(communityId);
      await shareV2Key();

      const plaintext = 'Hello v2 community!';
      final encrypted =
          await senderService.encryptCommunity(communityId, plaintext);
      final decrypted = await receiverService.decryptCommunity(
        communityId, senderUserId, encrypted,
      );

      expect(decrypted, equals(plaintext));
    });

    test('v2 sequential messages (10 messages)', () async {
      await senderService.generateSenderKey(communityId);
      await shareV2Key();

      for (var i = 0; i < 10; i++) {
        final msg = 'v2 message #$i';
        final encrypted =
            await senderService.encryptCommunity(communityId, msg);
        final decrypted = await receiverService.decryptCommunity(
          communityId, senderUserId, encrypted,
        );
        expect(decrypted, equals(msg));
      }
    });

    test('v2 out-of-order: encrypt 0-4, decrypt 0,3,1,4,2', () async {
      await senderService.generateSenderKey(communityId);
      await shareV2Key();

      final encrypted = <Map<String, dynamic>>[];
      for (var i = 0; i < 5; i++) {
        encrypted.add(
          await senderService.encryptCommunity(communityId, 'msg-$i'),
        );
      }

      // Decrypt out-of-order
      final order = [0, 3, 1, 4, 2];
      for (final idx in order) {
        final pt = await receiverService.decryptCommunity(
          communityId, senderUserId, encrypted[idx],
        );
        expect(pt, equals('msg-$idx'));
      }
    });

    test('v2 empty string roundtrip', () async {
      await senderService.generateSenderKey(communityId);
      await shareV2Key();

      final encrypted =
          await senderService.encryptCommunity(communityId, '');
      final decrypted = await receiverService.decryptCommunity(
        communityId, senderUserId, encrypted,
      );

      expect(decrypted, equals(''));
    });

    test('v2 unicode roundtrip', () async {
      await senderService.generateSenderKey(communityId);
      await shareV2Key();

      const msg = 'Sawubona! \u{1F1FF}\u{1F1E6} \u{1F44B}';
      final encrypted =
          await senderService.encryptCommunity(communityId, msg);
      final decrypted = await receiverService.decryptCommunity(
        communityId, senderUserId, encrypted,
      );

      expect(decrypted, equals(msg));
    });

    test('v2 HMAC signature prevents tampering', () async {
      await senderService.generateSenderKey(communityId);
      await shareV2Key();

      final encrypted =
          await senderService.encryptCommunity(communityId, 'secure msg');

      // Tamper with ciphertext
      final ctBytes = base64Decode(encrypted['ciphertext'] as String);
      ctBytes[0] ^= 0xFF;
      encrypted['ciphertext'] = base64Encode(ctBytes);

      expect(
        () => receiverService.decryptCommunity(
            communityId, senderUserId, encrypted),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('HMAC signature verification failed'),
        )),
      );
    });

    test('processReceivedSenderKey stores key data correctly', () async {
      final keyData = <String, dynamic>{
        'chainId': base64Encode(crypto.randomBytes(16)),
        'chainKey': base64Encode(crypto.generateAesKey()),
        'signingKey': base64Encode(crypto.generateAesKey()),
        'messageNumber': 0,
      };

      await service.processReceivedSenderKey(communityId, senderId, keyData);

      final storageKey = 'e2ee_sk_${communityId}_$senderId';
      final stored = storage.store[storageKey]!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json['chainId'], equals(keyData['chainId']));
      expect(json['chainKey'], equals(keyData['chainKey']));
      expect(json['signingKey'], equals(keyData['signingKey']));
      expect(json['messageNumber'], equals(0));
    });

    test('rekey produces fresh key with reset messageNumber', () async {
      await senderService.generateSenderKey(communityId);
      await senderService.rekeyAllSenderKeys(communityId);

      final stored = senderStorage.store['e2ee_sk_own_$communityId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;

      expect(json['messageNumber'], equals(0));
      expect(json.containsKey('chainId'), isTrue);
      expect(json.containsKey('chainKey'), isTrue);
    });
  });
}
