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
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) {
      _store[key] = value;
    }
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store.remove(key);

  @override
  Future<Map<String, String>> readAll({
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
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
    final ed25519Encoded =
        '${base64Encode(ed25519Kp['privateKey']!)}|${base64Encode(ed25519Kp['publicKey']!)}';

    // v2 OTK format: "id|priv|pub"
    final otkPriv = base64Encode(otkKp['privateKey']!);
    final otkPub = base64Encode(otkKp['publicKey']!);
    final otkEncoded = '1|$otkPriv|$otkPub';

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
      signedPreKeyId: 1,
      protocolVersion: 2,
    );

    publicBundle = PublicKeyBundle(
      identityKey: base64Encode(identityKp['publicKey']!),
      signedPreKey: base64Encode(signedPreKp['publicKey']!),
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [otkPub],
      registrationId: 1,
      userId: userId,
      ed25519IdentityKey: base64Encode(ed25519Kp['publicKey']!),
      ed25519Signature: ed25519SigBase64,
      signedPreKeyId: 1,
      oneTimePreKeyId: 1,
      protocolVersion: 2,
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

    // Build Alice's private bundle (v2 format)
    final aliceIdentityEncoded =
        '${base64Encode(aliceIdentityKp['privateKey']!)}|${base64Encode(aliceIdentityKp['publicKey']!)}';
    final aliceSignedPreEncoded =
        '${base64Encode(aliceSignedPreKp['privateKey']!)}|${base64Encode(aliceSignedPreKp['publicKey']!)}';
    final aliceEd25519Encoded =
        '${base64Encode(aliceEd25519Kp['privateKey']!)}|${base64Encode(aliceEd25519Kp['publicKey']!)}';
    // v2 OTK: "id|priv|pub"
    final aliceOtkEncoded =
        '1|${base64Encode(aliceOtkKp['privateKey']!)}|${base64Encode(aliceOtkKp['publicKey']!)}';

    alicePrivateBundle = KeyBundle(
      identityKeyPair: aliceIdentityEncoded,
      signedPreKey: aliceSignedPreEncoded,
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [aliceOtkEncoded],
      registrationId: 1,
      ed25519IdentityKeyPair: aliceEd25519Encoded,
      ed25519Signature: base64Encode(aliceEd25519Sig),
      signedPreKeyId: 1,
      protocolVersion: 2,
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
      signedPreKeyId: 1,
      oneTimePreKeyId: 1,
      protocolVersion: 2,
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
  // encryptP2P
  // ===========================================================================
  group('encryptP2P', () {
    test('auto-establishes session if none exists', () async {
      final result = await aliceService.encryptP2P(bobId, 'Hello');
      expect(result['ciphertext'], isA<String>());
      // v2 session should exist
      expect(aliceStorage.store.containsKey('v2_session_$bobId'), isTrue);
    });

    test('returns map with ciphertext (base64) and e2ee (map)', () async {
      final result = await aliceService.encryptP2P(bobId, 'test message');

      expect(result['ciphertext'], isA<String>());
      expect(() => base64Decode(result['ciphertext'] as String), returnsNormally);
      expect(result['e2ee'], isA<Map<String, dynamic>>());
    });

    test('e2ee.protocol is signal-v2', () async {
      final result = await aliceService.encryptP2P(bobId, 'test');

      final e2ee = result['e2ee'] as Map<String, dynamic>;
      expect(e2ee['protocol'], equals('signal-v2'));
    });

    test('e2ee.messageNumber starts at 0 and increments', () async {
      final msg0 = await aliceService.encryptP2P(bobId, 'message 0');
      final msg1 = await aliceService.encryptP2P(bobId, 'message 1');
      final msg2 = await aliceService.encryptP2P(bobId, 'message 2');

      expect((msg0['e2ee'] as Map)['messageNumber'], equals(0));
      expect((msg1['e2ee'] as Map)['messageNumber'], equals(1));
      expect((msg2['e2ee'] as Map)['messageNumber'], equals(2));
    });

    test('e2ee.dhPublicKey is present (base64 string)', () async {
      final result = await aliceService.encryptP2P(bobId, 'test');

      final e2ee = result['e2ee'] as Map<String, dynamic>;
      final dhPubKey = e2ee['dhPublicKey'] as String;
      expect(dhPubKey, isNotEmpty);
      final decoded = base64Decode(dhPubKey);
      expect(decoded.length, equals(32));
    });

    test('first message includes x3dhHeader with identityKey, ephemeralKey',
        () async {
      final first = await aliceService.encryptP2P(bobId, 'first message');

      expect(first.containsKey('x3dhHeader'), isTrue);
      final header = first['x3dhHeader'] as Map<String, dynamic>;
      expect(header['identityKey'], isA<String>());
      expect(header['ephemeralKey'], isA<String>());
      expect(() => base64Decode(header['identityKey'] as String), returnsNormally);
      expect(
          () => base64Decode(header['ephemeralKey'] as String), returnsNormally);
    });

    test('x3dhHeader includes signedPreKeyId and oneTimePreKeyId', () async {
      final first = await aliceService.encryptP2P(bobId, 'first');
      final header = first['x3dhHeader'] as Map<String, dynamic>;
      expect(header['signedPreKeyId'], equals(1));
      expect(header['oneTimePreKeyId'], equals(1));
    });

    test('x3dhHeader is included on all messages until session confirmed', () async {
      final first = await aliceService.encryptP2P(bobId, 'first');
      final second = await aliceService.encryptP2P(bobId, 'second');

      expect(first.containsKey('x3dhHeader'), isTrue);
      expect(second.containsKey('x3dhHeader'), isTrue);

      final h1 = first['x3dhHeader'] as Map<String, dynamic>;
      final h2 = second['x3dhHeader'] as Map<String, dynamic>;
      expect(h1['identityKey'], equals(h2['identityKey']));
      expect(h1['ephemeralKey'], equals(h2['ephemeralKey']));
    });

    test('different messages produce different ciphertext', () async {
      // Consume x3dhHeader on first message
      await aliceService.encryptP2P(bobId, 'primer');

      final enc1 = await aliceService.encryptP2P(bobId, 'same text');
      final enc2 = await aliceService.encryptP2P(bobId, 'same text');

      expect(enc1['ciphertext'], isNot(equals(enc2['ciphertext'])));
    });

    test('encrypts empty string without error', () async {
      final result = await aliceService.encryptP2P(bobId, '');

      expect(result['ciphertext'], isA<String>());
      expect(result['e2ee'], isA<Map>());
    });
  });

  // ===========================================================================
  // decryptP2P
  // ===========================================================================
  group('decryptP2P', () {
    test('throws PermanentDecryptionError when no session and no x3dhHeader',
        () async {
      final fakeEncrypted = {
        'ciphertext': base64Encode([1, 2, 3]),
        'e2ee': {
          'protocol': 'signal-v2',
          'messageNumber': 0,
          'previousChainLength': 0,
          'dhPublicKey': base64Encode(crypto.randomBytes(32)),
        },
      };

      expect(
        () => aliceService.decryptP2P(bobId, fakeEncrypted),
        throwsA(isA<PermanentDecryptionError>()),
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

    test('returns true after encryptP2P auto-establishes', () async {
      await aliceService.encryptP2P(bobId, 'hello');
      expect(await aliceService.hasSession(bobId), isTrue);
    });

    test('returns false for a different user', () async {
      await aliceService.encryptP2P(bobId, 'hello');
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
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Hello from Alice!');

      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);

      expect(plaintext, equals('Hello from Alice!'));
    });

    test('Alice sends 3 messages -> Bob decrypts all 3', () async {
      final enc0 = await alice.service.encryptP2P(bobId, 'Message 0');
      final enc1 = await alice.service.encryptP2P(bobId, 'Message 1');
      final enc2 = await alice.service.encryptP2P(bobId, 'Message 2');

      final pt0 = await bob.service.decryptP2P(aliceId, enc0);
      final pt1 = await bob.service.decryptP2P(aliceId, enc1);
      final pt2 = await bob.service.decryptP2P(aliceId, enc2);

      expect(pt0, equals('Message 0'));
      expect(pt1, equals('Message 1'));
      expect(pt2, equals('Message 2'));
    });

    test('Bob replies to Alice -> Alice decrypts', () async {
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Hello Bob');

      final ptFromAlice =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(ptFromAlice, equals('Hello Bob'));

      final reply = await bob.service.encryptP2P(aliceId, 'Hello Alice');

      final ptFromBob =
          await alice.service.decryptP2P(bobId, reply);
      expect(ptFromBob, equals('Hello Alice'));
    });

    test('hasSession returns true on Bob after decryptP2P with x3dhHeader',
        () async {
      expect(await bob.service.hasSession(aliceId), isFalse);

      final encrypted =
          await alice.service.encryptP2P(bobId, 'trigger session');

      await bob.service.decryptP2P(aliceId, encrypted);

      expect(await bob.service.hasSession(aliceId), isTrue);
    });

    test('empty string roundtrip', () async {
      final encrypted = await alice.service.encryptP2P(bobId, '');
      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals(''));
    });

    test('unicode / special chars roundtrip', () async {
      const message = 'Hello World! 12345 abcdef special chars: <>&"\'';
      final encrypted = await alice.service.encryptP2P(bobId, message);
      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals(message));
    });

    test('long message roundtrip (1KB)', () async {
      final message = 'A' * 1024;
      final encrypted = await alice.service.encryptP2P(bobId, message);
      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals(message));
    });

    test('bidirectional multi-turn conversation', () async {
      // Alice -> Bob
      final a2b0 = await alice.service.encryptP2P(bobId, 'A->B #0');
      expect(await bob.service.decryptP2P(aliceId, a2b0), 'A->B #0');

      // Bob -> Alice
      final b2a0 = await bob.service.encryptP2P(aliceId, 'B->A #0');
      expect(await alice.service.decryptP2P(bobId, b2a0), 'B->A #0');

      // Alice -> Bob
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
        signedPreKeyId: 1,
        protocolVersion: 2,
      );
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => noOtkBundle);

      // Also update Bob's private bundle to have no OTKs
      final noOtkPrivateBundle = KeyBundle(
        identityKeyPair: bob.privateBundle.identityKeyPair,
        signedPreKey: bob.privateBundle.signedPreKey,
        signedPreKeySignature: bob.privateBundle.signedPreKeySignature,
        oneTimePreKeys: [],
        registrationId: bob.privateBundle.registrationId,
        ed25519IdentityKeyPair: bob.privateBundle.ed25519IdentityKeyPair,
        ed25519Signature: bob.privateBundle.ed25519Signature,
        signedPreKeyId: 1,
        protocolVersion: 2,
      );
      when(() => bob.keyMgmt.loadPrivateKeys())
          .thenAnswer((_) async => noOtkPrivateBundle);

      final encrypted =
          await alice.service.encryptP2P(bobId, 'No OTK message');

      final header = encrypted['x3dhHeader'] as Map<String, dynamic>?;
      expect(header, isNotNull);
      expect(header!['oneTimePreKeyId'], isNull);

      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('No OTK message'));
    });

    test('session persists across encryptP2P calls (state consistency)',
        () async {
      for (var i = 0; i < 5; i++) {
        final result =
            await alice.service.encryptP2P(bobId, 'Message $i');
        final e2ee = result['e2ee'] as Map<String, dynamic>;
        expect(e2ee['messageNumber'], equals(i));
      }
    });

    test('x3dhHeader identity key matches Alice public identity key',
        () async {
      final encrypted =
          await alice.service.encryptP2P(bobId, 'check keys');

      final header = encrypted['x3dhHeader'] as Map<String, dynamic>;
      final aliceIdentityPublic =
          alice.privateBundle.identityKeyPair.split('|')[1];
      expect(header['identityKey'], equals(aliceIdentityPublic));
    });

    test('auto-establish in encryptP2P produces valid roundtrip', () async {
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Auto-established');

      final plaintext =
          await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('Auto-established'));
    });
  });
}
