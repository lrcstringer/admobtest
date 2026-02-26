import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
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
// PARTICIPANT — bundles a SignalProtocolService with its own keys
// =============================================================================

/// Holds everything needed to represent one side of a Signal Protocol exchange.
class _Participant {
  final String userId;
  final InMemorySecureStorage storage;
  final MockKeyManagementService keyMgmt;
  late final SignalProtocolService service;

  late KeyBundle privateBundle;
  late PublicKeyBundle publicBundle;

  _Participant(this.userId)
      : storage = InMemorySecureStorage(),
        keyMgmt = MockKeyManagementService();

  /// Generate real X25519 + Ed25519 key material and wire the mock.
  Future<void> init(CryptoService crypto) async {
    // Generate real key pairs
    final identityKp = await crypto.generateX25519KeyPair();
    final signedPreKp = await crypto.generateX25519KeyPair();
    final otkKp = await crypto.generateX25519KeyPair();
    final ed25519Kp = await crypto.generateEd25519KeyPair();

    final identityEncoded =
        '${base64Encode(identityKp['privateKey']!)}|${base64Encode(identityKp['publicKey']!)}';
    final signedPreEncoded =
        '${base64Encode(signedPreKp['privateKey']!)}|${base64Encode(signedPreKp['publicKey']!)}';
    final otkEncoded =
        '${base64Encode(otkKp['privateKey']!)}|${base64Encode(otkKp['publicKey']!)}';
    final ed25519Encoded =
        '${base64Encode(ed25519Kp['privateKey']!)}|${base64Encode(ed25519Kp['publicKey']!)}';

    // Ed25519 signature over the signed pre-key public bytes
    final ed25519Sig = await crypto.ed25519Sign(
      signedPreKp['publicKey']!,
      ed25519Kp['privateKey']!,
    );
    final ed25519SigBase64 = base64Encode(ed25519Sig);

    privateBundle = KeyBundle(
      identityKeyPair: identityEncoded,
      signedPreKey: signedPreEncoded,
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [otkEncoded],
      registrationId: 1,
      ed25519IdentityKeyPair: ed25519Encoded,
      ed25519Signature: ed25519SigBase64,
    );

    publicBundle = PublicKeyBundle(
      identityKey: base64Encode(identityKp['publicKey']!),
      signedPreKey: base64Encode(signedPreKp['publicKey']!),
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [base64Encode(otkKp['publicKey']!)],
      registrationId: 1,
      userId: userId,
      ed25519IdentityKey: base64Encode(ed25519Kp['publicKey']!),
      ed25519Signature: ed25519SigBase64,
    );

    // Wire mock: loadPrivateKeys always returns this participant's private bundle
    when(() => keyMgmt.loadPrivateKeys())
        .thenAnswer((_) async => privateBundle);

    service = SignalProtocolService(keyMgmt, crypto, storage);
  }
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late CryptoService crypto;

  // Single-user helpers (Alice only, Bob's public bundle is wired via mock)
  late InMemorySecureStorage aliceStorage;
  late MockKeyManagementService aliceKeyMgmt;
  late SignalProtocolService aliceService;

  late KeyBundle alicePrivateBundle;
  late PublicKeyBundle bobPublicBundle;

  const aliceId = 'alice_user_id';
  const bobId = 'bob_user_id';

  setUp(() async {
    crypto = CryptoService();

    // Generate real X25519 + Ed25519 key pairs for Alice and Bob
    final aliceIdentityKp = await crypto.generateX25519KeyPair();
    final aliceSignedPreKp = await crypto.generateX25519KeyPair();
    final aliceOtkKp = await crypto.generateX25519KeyPair();
    final aliceEd25519Kp = await crypto.generateEd25519KeyPair();

    final bobIdentityKp = await crypto.generateX25519KeyPair();
    final bobSignedPreKp = await crypto.generateX25519KeyPair();
    final bobOtkKp = await crypto.generateX25519KeyPair();
    final bobEd25519Kp = await crypto.generateEd25519KeyPair();

    // Ed25519 signatures over the signed pre-key public bytes
    final aliceEd25519Sig = await crypto.ed25519Sign(
      aliceSignedPreKp['publicKey']!,
      aliceEd25519Kp['privateKey']!,
    );
    final bobEd25519Sig = await crypto.ed25519Sign(
      bobSignedPreKp['publicKey']!,
      bobEd25519Kp['privateKey']!,
    );

    // Build Alice's private bundle
    final aliceIdentityEncoded =
        '${base64Encode(aliceIdentityKp['privateKey']!)}|${base64Encode(aliceIdentityKp['publicKey']!)}';
    final aliceSignedPreEncoded =
        '${base64Encode(aliceSignedPreKp['privateKey']!)}|${base64Encode(aliceSignedPreKp['publicKey']!)}';
    final aliceOtkEncoded =
        '${base64Encode(aliceOtkKp['privateKey']!)}|${base64Encode(aliceOtkKp['publicKey']!)}';
    final aliceEd25519Encoded =
        '${base64Encode(aliceEd25519Kp['privateKey']!)}|${base64Encode(aliceEd25519Kp['publicKey']!)}';

    alicePrivateBundle = KeyBundle(
      identityKeyPair: aliceIdentityEncoded,
      signedPreKey: aliceSignedPreEncoded,
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [aliceOtkEncoded],
      registrationId: 1,
      ed25519IdentityKeyPair: aliceEd25519Encoded,
      ed25519Signature: base64Encode(aliceEd25519Sig),
    );

    // Build Bob's public-only bundle (as seen by Alice)
    bobPublicBundle = PublicKeyBundle(
      identityKey: base64Encode(bobIdentityKp['publicKey']!),
      signedPreKey: base64Encode(bobSignedPreKp['publicKey']!),
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [base64Encode(bobOtkKp['publicKey']!)],
      registrationId: 2,
      userId: bobId,
      ed25519IdentityKey: base64Encode(bobEd25519Kp['publicKey']!),
      ed25519Signature: base64Encode(bobEd25519Sig),
    );

    aliceStorage = InMemorySecureStorage();
    aliceKeyMgmt = MockKeyManagementService();

    when(() => aliceKeyMgmt.loadPrivateKeys())
        .thenAnswer((_) async => alicePrivateBundle);
    when(() => aliceKeyMgmt.fetchKeyBundle(bobId))
        .thenAnswer((_) async => bobPublicBundle);
    when(() => aliceKeyMgmt.removeConsumedOtk(any()))
        .thenAnswer((_) async {});

    aliceService = SignalProtocolService(aliceKeyMgmt, crypto, aliceStorage);
  });

  // ===========================================================================
  // establishSession
  // ===========================================================================
  group('establishSession', () {
    test('creates session and persists to storage', () async {
      await aliceService.establishSession(bobId);

      final stored = aliceStorage.store['e2ee_session_$bobId'];
      expect(stored, isNotNull);

      // The stored value must be valid JSON with expected keys
      final json = jsonDecode(stored!) as Map<String, dynamic>;
      expect(json.containsKey('rootKey'), isTrue);
      expect(json.containsKey('sendChainKey'), isTrue);
      expect(json.containsKey('dhSendPublic'), isTrue);
      expect(json['isInitiator'], isTrue);
    });

    test('calls loadPrivateKeys for own keys', () async {
      await aliceService.establishSession(bobId);
      verify(() => aliceKeyMgmt.loadPrivateKeys()).called(1);
    });

    test('calls fetchKeyBundle for recipient', () async {
      await aliceService.establishSession(bobId);
      verify(() => aliceKeyMgmt.fetchKeyBundle(bobId)).called(1);
    });

    test('throws StateError when own private keys are null', () async {
      when(() => aliceKeyMgmt.loadPrivateKeys()).thenAnswer((_) async => null);

      expect(
        () => aliceService.establishSession(bobId),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('No local key bundle'),
        )),
      );
    });

    test('performs X3DH with OTK when available (4 DH operations)', () async {
      // Bob's public bundle already has oneTimePreKeys
      expect(bobPublicBundle.oneTimePreKeys, isNotEmpty);
      await aliceService.establishSession(bobId);

      // Session should record the consumed OTK public key in pending data
      final stored = aliceStorage.store['e2ee_session_$bobId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;
      expect(json['pendingOtkPublicKey'], isNotNull);
      expect(json['pendingOtkPublicKey'], equals(bobPublicBundle.oneTimePreKeys.first));
    });

    test('performs X3DH without OTK when none available (3 DH operations)',
        () async {
      // Return a bundle with no OTKs
      final noOtkBundle = PublicKeyBundle(
        identityKey: bobPublicBundle.identityKey,
        signedPreKey: bobPublicBundle.signedPreKey,
        signedPreKeySignature: bobPublicBundle.signedPreKeySignature,
        oneTimePreKeys: [],
        registrationId: 2,
        userId: bobId,
        ed25519IdentityKey: bobPublicBundle.ed25519IdentityKey,
        ed25519Signature: bobPublicBundle.ed25519Signature,
      );
      when(() => aliceKeyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => noOtkBundle);

      await aliceService.establishSession(bobId);

      final stored = aliceStorage.store['e2ee_session_$bobId']!;
      final json = jsonDecode(stored) as Map<String, dynamic>;
      // No OTK consumed
      expect(json['pendingOtkPublicKey'], isNull);
      // Session still created successfully
      expect(json['rootKey'], isNotNull);
    });
  });

  // ===========================================================================
  // encryptP2P
  // ===========================================================================
  group('encryptP2P', () {
    test('auto-establishes session if none exists', () async {
      // No prior establishSession call
      final result = await aliceService.encryptP2P(bobId, 'Hello');
      expect(result['ciphertext'], isA<String>());
      // Session should now exist
      expect(aliceStorage.store.containsKey('e2ee_session_$bobId'), isTrue);
    });

    test('returns map with ciphertext (base64) and e2ee (map)', () async {
      await aliceService.establishSession(bobId);
      final result = await aliceService.encryptP2P(bobId, 'test message');

      expect(result['ciphertext'], isA<String>());
      // Verify it's valid base64
      expect(() => base64Decode(result['ciphertext'] as String), returnsNormally);
      expect(result['e2ee'], isA<Map<String, dynamic>>());
    });

    test('e2ee.protocol is signal-v1', () async {
      await aliceService.establishSession(bobId);
      final result = await aliceService.encryptP2P(bobId, 'test');

      final e2ee = result['e2ee'] as Map<String, dynamic>;
      expect(e2ee['protocol'], equals('signal-v1'));
    });

    test('e2ee.messageNumber starts at 0 and increments', () async {
      await aliceService.establishSession(bobId);

      final msg0 = await aliceService.encryptP2P(bobId, 'message 0');
      final msg1 = await aliceService.encryptP2P(bobId, 'message 1');
      final msg2 = await aliceService.encryptP2P(bobId, 'message 2');

      expect((msg0['e2ee'] as Map)['messageNumber'], equals(0));
      expect((msg1['e2ee'] as Map)['messageNumber'], equals(1));
      expect((msg2['e2ee'] as Map)['messageNumber'], equals(2));
    });

    test('e2ee.dhPublicKey is present (base64 string)', () async {
      await aliceService.establishSession(bobId);
      final result = await aliceService.encryptP2P(bobId, 'test');

      final e2ee = result['e2ee'] as Map<String, dynamic>;
      final dhPubKey = e2ee['dhPublicKey'] as String;
      expect(dhPubKey, isNotEmpty);
      // Must be valid base64 that decodes to 32 bytes (X25519 public key)
      final decoded = base64Decode(dhPubKey);
      expect(decoded.length, equals(32));
    });

    test('first message includes x3dhHeader with identityKey, ephemeralKey',
        () async {
      await aliceService.establishSession(bobId);
      final first = await aliceService.encryptP2P(bobId, 'first message');

      expect(first.containsKey('x3dhHeader'), isTrue);
      final header = first['x3dhHeader'] as Map<String, dynamic>;
      expect(header['identityKey'], isA<String>());
      expect(header['ephemeralKey'], isA<String>());
      // Keys should be valid base64
      expect(() => base64Decode(header['identityKey'] as String), returnsNormally);
      expect(
          () => base64Decode(header['ephemeralKey'] as String), returnsNormally);
    });

    test('x3dhHeader is included on all messages until session confirmed', () async {
      await aliceService.establishSession(bobId);

      final first = await aliceService.encryptP2P(bobId, 'first');
      final second = await aliceService.encryptP2P(bobId, 'second');

      // Both messages include x3dhHeader because pending keys are kept
      // until the sender receives a decrypted reply (session confirmation).
      expect(first.containsKey('x3dhHeader'), isTrue);
      expect(second.containsKey('x3dhHeader'), isTrue);

      // Both headers contain the same keys
      final h1 = first['x3dhHeader'] as Map<String, dynamic>;
      final h2 = second['x3dhHeader'] as Map<String, dynamic>;
      expect(h1['identityKey'], equals(h2['identityKey']));
      expect(h1['ephemeralKey'], equals(h2['ephemeralKey']));
    });

    test('different messages produce different ciphertext', () async {
      await aliceService.establishSession(bobId);
      // Consume x3dhHeader on first message
      await aliceService.encryptP2P(bobId, 'primer');

      final enc1 = await aliceService.encryptP2P(bobId, 'same text');
      final enc2 = await aliceService.encryptP2P(bobId, 'same text');

      expect(enc1['ciphertext'], isNot(equals(enc2['ciphertext'])));
    });

    test('encrypts empty string without error', () async {
      await aliceService.establishSession(bobId);
      final result = await aliceService.encryptP2P(bobId, '');

      expect(result['ciphertext'], isA<String>());
      expect(result['e2ee'], isA<Map>());
    });
  });

  // ===========================================================================
  // decryptP2P
  // ===========================================================================
  group('decryptP2P', () {
    test('throws StateError when no session exists and no x3dhHeader',
        () async {
      final fakeEncrypted = {
        'ciphertext': base64Encode([1, 2, 3]),
        'e2ee': {
          'protocol': 'signal-v1',
          'messageNumber': 0,
          'dhPublicKey': base64Encode(crypto.randomBytes(32)),
        },
      };

      expect(
        () => aliceService.decryptP2P(bobId, fakeEncrypted),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('No session'),
        )),
      );
    });
  });

  // ===========================================================================
  // hasSession
  // ===========================================================================
  group('hasSession', () {
    test('returns false when no session stored', () async {
      expect(await aliceService.hasSession(bobId), isFalse);
    });

    test('returns true after establishSession called', () async {
      await aliceService.establishSession(bobId);
      expect(await aliceService.hasSession(bobId), isTrue);
    });

    test('returns false for a different user', () async {
      await aliceService.establishSession(bobId);
      expect(await aliceService.hasSession('charlie_user_id'), isFalse);
    });
  });

  // ===========================================================================
  // FULL PROTOCOL ROUNDTRIP (Alice <-> Bob, two separate service instances)
  // ===========================================================================
  group('Full protocol roundtrip', () {
    late _Participant alice;
    late _Participant bob;

    setUp(() async {
      alice = _Participant(aliceId);
      bob = _Participant(bobId);

      await alice.init(crypto);
      await bob.init(crypto);

      // Wire cross-references: Alice's fetchKeyBundle returns Bob's public keys
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
      when(() => alice.keyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});
      when(() => bob.keyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});
    });

    test('Alice sends to Bob -> Bob decrypts successfully', () async {
      // Alice establishes session and encrypts
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Hello from Alice!');

      // Bob receives and decrypts (receiver-side X3DH via x3dhHeader)
      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);

      expect(plaintext, equals('Hello from Alice!'));
    });

    test('Alice sends 3 messages -> Bob decrypts all 3', () async {
      await alice.service.establishSession(bobId);

      final enc0 = await alice.service.encryptP2P(bobId, 'Message 0');
      final enc1 = await alice.service.encryptP2P(bobId, 'Message 1');
      final enc2 = await alice.service.encryptP2P(bobId, 'Message 2');

      // Bob decrypts in order
      final pt0 = await bob.service.decryptP2P(aliceId, enc0);
      final pt1 = await bob.service.decryptP2P(aliceId, enc1);
      final pt2 = await bob.service.decryptP2P(aliceId, enc2);

      expect(pt0, equals('Message 0'));
      expect(pt1, equals('Message 1'));
      expect(pt2, equals('Message 2'));
    });

    test('Bob replies to Alice -> Alice decrypts', () async {
      // Alice initiates
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Hello Bob');

      // Bob decrypts (establishes receiver-side session)
      final ptFromAlice =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(ptFromAlice, equals('Hello Bob'));

      // Bob replies
      final reply = await bob.service.encryptP2P(aliceId, 'Hello Alice');

      // Alice decrypts Bob's reply
      final ptFromBob =
          await alice.service.decryptP2P(bobId, reply);
      expect(ptFromBob, equals('Hello Alice'));
    });

    test('hasSession returns true on Bob after decryptP2P with x3dhHeader',
        () async {
      // Bob has no session yet
      expect(await bob.service.hasSession(aliceId), isFalse);

      // Alice sends a message with x3dhHeader
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'trigger session');

      // Bob decrypts -> receiver-side X3DH creates session
      await bob.service.decryptP2P(aliceId, encrypted);

      expect(await bob.service.hasSession(aliceId), isTrue);
    });

    test('empty string roundtrip', () async {
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, '');
      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals(''));
    });

    test('unicode / emoji roundtrip', () async {
      const message = 'Hello World! 12345 abcdef special chars: <>&"\'';
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, message);
      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals(message));
    });

    test('long message roundtrip (1KB)', () async {
      final message = 'A' * 1024;
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, message);
      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals(message));
    });

    test('bidirectional multi-turn conversation', () async {
      // Alice initiates
      await alice.service.establishSession(bobId);

      // Alice -> Bob (msg 0, with x3dhHeader)
      final a2b0 = await alice.service.encryptP2P(bobId, 'A->B #0');
      expect(await bob.service.decryptP2P(aliceId, a2b0), 'A->B #0');

      // Bob -> Alice
      final b2a0 = await bob.service.encryptP2P(aliceId, 'B->A #0');
      expect(await alice.service.decryptP2P(bobId, b2a0), 'B->A #0');

      // Alice -> Bob (msg 1, no x3dhHeader)
      final a2b1 = await alice.service.encryptP2P(bobId, 'A->B #1');
      expect(await bob.service.decryptP2P(aliceId, a2b1), 'A->B #1');

      // Bob -> Alice
      final b2a1 = await bob.service.encryptP2P(aliceId, 'B->A #1');
      expect(await alice.service.decryptP2P(bobId, b2a1), 'B->A #1');
    });

    test('X3DH without OTK still completes roundtrip', () async {
      // Create a public bundle for Bob without OTKs
      final noOtkBundle = PublicKeyBundle(
        identityKey: bob.publicBundle.identityKey,
        signedPreKey: bob.publicBundle.signedPreKey,
        signedPreKeySignature: bob.publicBundle.signedPreKeySignature,
        oneTimePreKeys: [],
        registrationId: bob.publicBundle.registrationId,
        userId: bobId,
        ed25519IdentityKey: bob.publicBundle.ed25519IdentityKey,
        ed25519Signature: bob.publicBundle.ed25519Signature,
      );
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => noOtkBundle);

      // Also update Bob's private bundle to have no OTKs so receiver-side
      // X3DH skips DH4
      final noOtkPrivateBundle = KeyBundle(
        identityKeyPair: bob.privateBundle.identityKeyPair,
        signedPreKey: bob.privateBundle.signedPreKey,
        signedPreKeySignature: bob.privateBundle.signedPreKeySignature,
        oneTimePreKeys: [],
        registrationId: bob.privateBundle.registrationId,
        ed25519IdentityKeyPair: bob.privateBundle.ed25519IdentityKeyPair,
        ed25519Signature: bob.privateBundle.ed25519Signature,
      );
      when(() => bob.keyMgmt.loadPrivateKeys())
          .thenAnswer((_) async => noOtkPrivateBundle);

      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'No OTK message');

      // x3dhHeader should have oneTimePreKeyId = null
      final header = encrypted['x3dhHeader'] as Map<String, dynamic>?;
      expect(header, isNotNull);
      expect(header!['oneTimePreKeyId'], isNull);

      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('No OTK message'));
    });

    test('session persists across encryptP2P calls (state consistency)',
        () async {
      await alice.service.establishSession(bobId);

      // Send 5 messages and verify monotonically increasing message numbers
      for (var i = 0; i < 5; i++) {
        final result =
            await alice.service.encryptP2P(bobId, 'Message $i');
        final e2ee = result['e2ee'] as Map<String, dynamic>;
        expect(e2ee['messageNumber'], equals(i));
      }
    });

    test('x3dhHeader identity key matches Alice public identity key',
        () async {
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'check keys');

      final header = encrypted['x3dhHeader'] as Map<String, dynamic>;
      // The identity key in the header should be Alice's public identity key
      final aliceIdentityPublic =
          alice.privateBundle.identityKeyPair.split('|')[1];
      expect(header['identityKey'], equals(aliceIdentityPublic));
    });

    test('auto-establish in encryptP2P produces valid roundtrip', () async {
      // Skip explicit establishSession - let encryptP2P do it
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Auto-established');

      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('Auto-established'));
    });
  });
}
