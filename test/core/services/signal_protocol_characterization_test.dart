// Characterization tests for SignalProtocolService.
//
// These tests capture the EXACT current behavior of every public method and
// significant code branch. They serve as the regression safety net for the
// E2EE refactoring — no refactoring step may break any of these tests.
//
// Organized by method, then by branch/scenario within each method.

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

class Participant {
  final String userId;
  final InMemorySecureStorage storage;
  final MockKeyManagementService keyMgmt;
  late final SignalProtocolService service;

  late KeyBundle privateBundle;
  late PublicKeyBundle publicBundle;

  Participant(this.userId)
      : storage = InMemorySecureStorage(),
        keyMgmt = MockKeyManagementService();

  /// Generate real X25519 + Ed25519 key material and wire the mock.
  Future<void> init(CryptoService crypto) async {
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

    when(() => keyMgmt.loadPrivateKeys())
        .thenAnswer((_) async => privateBundle);
    // removeConsumedOtk is called after receiver X3DH
    when(() => keyMgmt.removeConsumedOtk(any()))
        .thenAnswer((_) async {});

    service = SignalProtocolService(keyMgmt, crypto, storage);
  }

  /// Generate a fresh identity + keys (simulates reinstall/key regeneration).
  Future<void> regenerateKeys(CryptoService crypto) async {
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
      registrationId: 2,
      ed25519IdentityKeyPair: ed25519Encoded,
      ed25519Signature: ed25519SigBase64,
    );

    publicBundle = PublicKeyBundle(
      identityKey: base64Encode(identityKp['publicKey']!),
      signedPreKey: base64Encode(signedPreKp['publicKey']!),
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [base64Encode(otkKp['publicKey']!)],
      registrationId: 2,
      userId: userId,
      ed25519IdentityKey: base64Encode(ed25519Kp['publicKey']!),
      ed25519Signature: ed25519SigBase64,
    );

    when(() => keyMgmt.loadPrivateKeys())
        .thenAnswer((_) async => privateBundle);
  }

  /// Get the session JSON stored in secure storage for a peer.
  Map<String, dynamic>? getSessionJson(String peerId) {
    final raw = storage.store['e2ee_session_$peerId'];
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late CryptoService crypto;

  const aliceId = 'alice_user_id';
  const bobId = 'bob_user_id';
  const charlieId = 'charlie_user_id';

  setUp(() {
    crypto = CryptoService();
  });

  // ===========================================================================
  // Section 1: SESSION STATE SERIALIZATION
  // ===========================================================================
  group('Session serialization', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
    });

    test('session JSON contains all required fields after establishment', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;

      expect(json.containsKey('rootKey'), isTrue);
      expect(json.containsKey('sendChainKey'), isTrue);
      expect(json.containsKey('recvChainKey'), isTrue);
      expect(json.containsKey('dhSendPrivate'), isTrue);
      expect(json.containsKey('dhSendPublic'), isTrue);
      expect(json.containsKey('dhRecvPublic'), isTrue);
      expect(json.containsKey('sendMessageNumber'), isTrue);
      expect(json.containsKey('recvMessageNumber'), isTrue);
      expect(json.containsKey('previousChainLength'), isTrue);
      expect(json.containsKey('skippedKeys'), isTrue);
      expect(json.containsKey('isInitiator'), isTrue);
      expect(json.containsKey('pendingIdentityKey'), isTrue);
      expect(json.containsKey('pendingEphemeralKey'), isTrue);
      expect(json.containsKey('pendingOtkPublicKey'), isTrue);
      expect(json.containsKey('peerX3dhEphemeralKey'), isTrue);
      expect(json.containsKey('peerIdentityKey'), isTrue);
    });

    test('initiator session has isInitiator=true', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;
      expect(json['isInitiator'], isTrue);
    });

    test('initiator session has non-null pendingIdentityKey and pendingEphemeralKey', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;
      expect(json['pendingIdentityKey'], isNotNull);
      expect(json['pendingEphemeralKey'], isNotNull);
    });

    test('initiator session records peer identity key', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;
      expect(json['peerIdentityKey'], equals(bob.publicBundle.identityKey));
    });

    test('initiator session starts with sendMessageNumber=0', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;
      expect(json['sendMessageNumber'], equals(0));
    });

    test('all key fields are valid base64 that decode to 32 bytes', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;

      for (final field in ['rootKey', 'sendChainKey', 'dhSendPrivate', 'dhSendPublic']) {
        final bytes = base64Decode(json[field] as String);
        expect(bytes.length, equals(32), reason: '$field should be 32 bytes');
      }
    });

    test('session survives JSON roundtrip (serialize then load)', () async {
      await alice.service.establishSession(bobId);
      // encryptP2P loads the session from storage — if roundtrip is broken, this fails
      final result = await alice.service.encryptP2P(bobId, 'test');
      expect(result['ciphertext'], isA<String>());
    });
  });

  // ===========================================================================
  // Section 1b: Signal Protocol compliance tests
  // ===========================================================================
  group('Signal Protocol compliance', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await Future.wait([alice.init(crypto), bob.init(crypto)]);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
      when(() => alice.keyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});
      when(() => bob.keyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});
    });

    test('session stores ourIdentityKey', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;
      expect(json['ourIdentityKey'], isNotNull);
      expect(json['ourIdentityKey'],
          equals(alice.privateBundle.identityKeyPair.split('|')[1]));
    });

    test('session stores createdAt and survives JSON roundtrip', () async {
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;
      expect(json['createdAt'], isNotNull);
      final dt = DateTime.parse(json['createdAt'] as String);
      expect(dt.difference(DateTime.now()).abs().inSeconds, lessThan(5));
    });

    test('receiver session stores ourIdentityKey', () async {
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, 'hello');
      await bob.service.decryptP2P(aliceId, encrypted);
      final json = bob.getSessionJson(aliceId)!;
      expect(json['ourIdentityKey'], isNotNull);
      expect(json['ourIdentityKey'],
          equals(bob.privateBundle.identityKeyPair.split('|')[1]));
    });

    test('multi-turn bidirectional conversation uses DH ratchet (not X3DH per turn)', () async {
      // Alice sends first
      await alice.service.establishSession(bobId);
      final a2b = await alice.service.encryptP2P(bobId, 'Hello Bob');
      await bob.service.decryptP2P(aliceId, a2b);

      // Bob replies — uses receiver session (no re-establishment)
      final b2a = await bob.service.encryptP2P(aliceId, 'Hi Alice');
      final bobSession = bob.getSessionJson(aliceId)!;
      expect(bobSession['isInitiator'], isFalse); // Still receiver

      // Alice decrypts — triggers DH ratchet (not full X3DH)
      await alice.service.decryptP2P(bobId, b2a);

      // Alice sends again — session is still the same (no re-establishment)
      final a2b2 = await alice.service.encryptP2P(bobId, 'Thanks!');
      final aliceSession = alice.getSessionJson(bobId)!;
      expect(aliceSession['isInitiator'], isTrue); // Still initiator

      // Bob decrypts — DH ratchet again
      await bob.service.decryptP2P(aliceId, a2b2);
    });

    test('receiver session sends without x3dhHeader', () async {
      await alice.service.establishSession(bobId);
      final a2b = await alice.service.encryptP2P(bobId, 'Hello');
      await bob.service.decryptP2P(aliceId, a2b);

      // Bob's reply from receiver session — no x3dhHeader
      final b2a = await bob.service.encryptP2P(aliceId, 'Reply');
      expect(b2a.containsKey('x3dhHeader'), isFalse);
      expect(b2a['e2ee'], isNotNull);
      expect(b2a['ciphertext'], isA<String>());

      // Alice can decrypt it
      final plaintext = await alice.service.decryptP2P(bobId, b2a);
      expect(plaintext, equals('Reply'));
    });

    test('migration key is v2', () async {
      await alice.service.migrateResetCorruptedSessions();
      final meta = alice.storage.store['e2ee_session_migration_v2'];
      expect(meta, isNotNull);
    });
  });

  // ===========================================================================
  // Section 2: encryptP2P BRANCH COVERAGE
  // ===========================================================================
  group('encryptP2P branches', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    test('Branch: no session → auto-establish', () async {
      expect(await alice.service.hasSession(bobId), isFalse);
      final result = await alice.service.encryptP2P(bobId, 'Hello');
      expect(result['ciphertext'], isA<String>());
      expect(await alice.service.hasSession(bobId), isTrue);
    });

    test('Branch: receiver-side session sends successfully without re-establishment', () async {
      // Create a receiver-side session on Alice by having Bob send first
      await bob.service.establishSession(aliceId);
      final encrypted = await bob.service.encryptP2P(aliceId, 'Bob initiates');
      await alice.service.decryptP2P(bobId, encrypted);

      // Alice now has a receiver-side session (isInitiator=false)
      final sessionBefore = alice.getSessionJson(bobId)!;
      expect(sessionBefore['isInitiator'], isFalse);

      // Alice encrypts — receiver session should be used directly (no re-establishment)
      final result = await alice.service.encryptP2P(bobId, 'Alice replies');
      expect(result['ciphertext'], isA<String>());

      // Session remains receiver-side (NOT re-established as initiator)
      final sessionAfter = alice.getSessionJson(bobId)!;
      expect(sessionAfter['isInitiator'], isFalse);
      // Receiver sessions do NOT include x3dhHeader (no ephemeral key material)
      expect(result.containsKey('x3dhHeader'), isFalse);
    });

    test('Branch: legacy session (pendingIdentityKey==null) still sends successfully', () async {
      // Manually create a session with pendingIdentityKey=null (legacy)
      await alice.service.establishSession(bobId);
      final json = alice.getSessionJson(bobId)!;
      json['pendingIdentityKey'] = null;
      json['pendingEphemeralKey'] = null;
      alice.storage.store['e2ee_session_$bobId'] = jsonEncode(json);

      // Encrypt should work with the existing session (no re-establishment)
      final result = await alice.service.encryptP2P(bobId, 'test');
      expect(result['ciphertext'], isA<String>());

      // No x3dhHeader because pendingIdentityKey is null
      expect(result.containsKey('x3dhHeader'), isFalse);
    });

    test('x3dhHeader always present on every message (never cleared)', () async {
      await alice.service.establishSession(bobId);

      for (var i = 0; i < 5; i++) {
        final result = await alice.service.encryptP2P(bobId, 'Message $i');
        expect(result.containsKey('x3dhHeader'), isTrue,
            reason: 'Message $i should have x3dhHeader');
        final header = result['x3dhHeader'] as Map<String, dynamic>;
        expect(header['identityKey'], isA<String>());
        expect(header['ephemeralKey'], isA<String>());
      }
    });

    test('x3dhHeader identity key matches Alice public identity key', () async {
      await alice.service.establishSession(bobId);
      final result = await alice.service.encryptP2P(bobId, 'test');
      final header = result['x3dhHeader'] as Map<String, dynamic>;
      final alicePubKey = alice.privateBundle.identityKeyPair.split('|')[1];
      expect(header['identityKey'], equals(alicePubKey));
    });

    test('message numbers increment monotonically', () async {
      await alice.service.establishSession(bobId);
      for (var i = 0; i < 10; i++) {
        final result = await alice.service.encryptP2P(bobId, 'Msg $i');
        expect((result['e2ee'] as Map)['messageNumber'], equals(i));
      }
    });

    test('same plaintext produces different ciphertext (unique nonce per message)', () async {
      await alice.service.establishSession(bobId);
      final results = <String>[];
      for (var i = 0; i < 5; i++) {
        final result = await alice.service.encryptP2P(bobId, 'same text');
        results.add(result['ciphertext'] as String);
      }
      // All should be unique
      expect(results.toSet().length, equals(5));
    });

    test('previousChainLength present in e2ee wire format', () async {
      await alice.service.establishSession(bobId);
      final result = await alice.service.encryptP2P(bobId, 'test');
      final e2ee = result['e2ee'] as Map;
      expect(e2ee.containsKey('previousChainLength'), isTrue);
    });

    test('previousChainLength starts at 0 for fresh session', () async {
      await alice.service.establishSession(bobId);
      final result = await alice.service.encryptP2P(bobId, 'First msg');
      final e2ee = result['e2ee'] as Map;
      expect(e2ee['previousChainLength'], equals(0));
    });

    test('previousChainLength reflects send chain length after DH ratchet', () async {
      // With proper Signal Protocol, the DH ratchet is used (not X3DH per turn),
      // so previousChainLength records the old send chain length.
      await alice.service.establishSession(bobId);

      // Alice sends 3 messages (sendMessageNumber goes to 3)
      final a2b0 = await alice.service.encryptP2P(bobId, 'A→B 0');
      await alice.service.encryptP2P(bobId, 'A→B 1');
      await alice.service.encryptP2P(bobId, 'A→B 2');

      // Bob decrypts first message and replies — Bob's reply triggers
      // a DH ratchet on Alice's side when she decrypts it
      await bob.service.decryptP2P(aliceId, a2b0);
      final b2a = await bob.service.encryptP2P(aliceId, 'B→A reply');
      // Alice decrypts Bob's reply — DH ratchet happens here because
      // Bob's DH key is different from Alice's dhRecvPublic
      await alice.service.decryptP2P(bobId, b2a);

      // Alice sends again — after DH ratchet, previousChainLength = 3
      // (Alice's old send chain had 3 messages on it)
      final newMsg = await alice.service.encryptP2P(bobId, 'A→B after turn');
      final e2ee = newMsg['e2ee'] as Map;
      expect(e2ee['previousChainLength'], equals(3));
    });

    test('dhPublicKey is consistent across messages (same send DH key pair)', () async {
      await alice.service.establishSession(bobId);
      final dhKeys = <String>[];
      for (var i = 0; i < 3; i++) {
        final result = await alice.service.encryptP2P(bobId, 'Msg $i');
        dhKeys.add((result['e2ee'] as Map)['dhPublicKey'] as String);
      }
      // All the same (no DH ratchet without reply)
      expect(dhKeys.toSet().length, equals(1));
    });
  });

  // ===========================================================================
  // Section 3: decryptP2P BRANCH COVERAGE
  // ===========================================================================
  group('decryptP2P branches', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    test('Branch: no session + no x3dhHeader → PermanentDecryptionError', () async {
      final fakeEncrypted = {
        'ciphertext': base64Encode(List.generate(50, (i) => i % 5 + 1)),
        'e2ee': {
          'protocol': 'signal-v1',
          'messageNumber': 0,
          'dhPublicKey': base64Encode(crypto.randomBytes(32)),
        },
        // No x3dhHeader
      };

      expect(
        () => alice.service.decryptP2P(bobId, fakeEncrypted),
        throwsA(isA<PermanentDecryptionError>()),
      );
    });

    test('Branch: no session + x3dhHeader → receiver X3DH + decrypt', () async {
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, 'First message');

      // Bob has no session — receiver X3DH triggered
      expect(await bob.service.hasSession(aliceId), isFalse);
      final plaintext = await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('First message'));
      expect(await bob.service.hasSession(aliceId), isTrue);
    });

    test('Branch: initiator session + x3dhHeader → receiver X3DH (simultaneous exchange)', () async {
      // Both Alice and Bob establish initiator sessions with each other
      await alice.service.establishSession(bobId);
      await bob.service.establishSession(aliceId);

      // Both have initiator sessions
      expect(alice.getSessionJson(bobId)!['isInitiator'], isTrue);
      expect(bob.getSessionJson(aliceId)!['isInitiator'], isTrue);

      // Alice sends to Bob — Bob has initiator session but gets x3dhHeader
      // → receiver X3DH should be triggered
      final encrypted = await alice.service.encryptP2P(bobId, 'Alice wins');
      final plaintext = await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('Alice wins'));
    });

    test('Branch: peer ephemeral key changed → receiver X3DH re-establishment', () async {
      // Alice sends first message → Bob establishes receiver session
      await alice.service.establishSession(bobId);
      final msg1 = await alice.service.encryptP2P(bobId, 'First');
      await bob.service.decryptP2P(aliceId, msg1);

      // Alice re-establishes (simulates reinstall) → new ephemeral key
      await alice.service.establishSession(bobId);
      final msg2 = await alice.service.encryptP2P(bobId, 'After re-establish');

      // Bob should detect different ephemeral key and perform fresh receiver X3DH
      final plaintext = await bob.service.decryptP2P(aliceId, msg2);
      expect(plaintext, equals('After re-establish'));
    });

    test('Branch: message behind chain position → StateError', () async {
      await alice.service.establishSession(bobId);
      final msg0 = await alice.service.encryptP2P(bobId, 'Msg 0');
      final msg1 = await alice.service.encryptP2P(bobId, 'Msg 1');

      // Bob decrypts msg1 first (skipping msg0), then tries msg0 in-order
      // Actually, let's decrypt both in order first
      await bob.service.decryptP2P(aliceId, msg0);
      await bob.service.decryptP2P(aliceId, msg1);

      // Now try to re-decrypt msg0 → should throw (already consumed)
      expect(
        () => bob.service.decryptP2P(aliceId, msg0),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('already consumed'),
        )),
      );
    });

    test('Branch: out-of-order messages → skipped keys used', () async {
      await alice.service.establishSession(bobId);
      final msg0 = await alice.service.encryptP2P(bobId, 'Msg 0');
      final msg1 = await alice.service.encryptP2P(bobId, 'Msg 1');
      final msg2 = await alice.service.encryptP2P(bobId, 'Msg 2');

      // Bob decrypts out of order: msg2 first, then msg0, then msg1
      final pt2 = await bob.service.decryptP2P(aliceId, msg2);
      expect(pt2, equals('Msg 2'));

      final pt0 = await bob.service.decryptP2P(aliceId, msg0);
      expect(pt0, equals('Msg 0'));

      final pt1 = await bob.service.decryptP2P(aliceId, msg1);
      expect(pt1, equals('Msg 1'));
    });

    test('Branch: DH ratchet step when Bob replies', () async {
      // Alice initiates
      await alice.service.establishSession(bobId);
      final a2b = await alice.service.encryptP2P(bobId, 'Hello Bob');
      await bob.service.decryptP2P(aliceId, a2b);

      // Bob replies → new dhPublicKey in Bob's message
      final b2a = await bob.service.encryptP2P(aliceId, 'Hello Alice');
      final bobDhPub = (b2a['e2ee'] as Map)['dhPublicKey'] as String;

      // Alice's current session has a different dhRecvPublic → DH ratchet
      final aliceSession = alice.getSessionJson(bobId)!;
      // Bob's new dhPublicKey won't match Alice's current dhRecvPublic (which is Bob's signed pre-key)
      expect(bobDhPub, isNot(equals(aliceSession['dhRecvPublic'])));

      // Alice decrypts → triggers DH ratchet
      final plaintext = await alice.service.decryptP2P(bobId, b2a);
      expect(plaintext, equals('Hello Alice'));
    });

    test('Branch: backfill peerX3dhEphemeralKey for legacy session', () async {
      // Create a receiver-side session without peerX3dhEphemeralKey
      await alice.service.establishSession(bobId);
      final msg1 = await alice.service.encryptP2P(bobId, 'First');
      await bob.service.decryptP2P(aliceId, msg1);

      // Manually clear peerX3dhEphemeralKey to simulate legacy session
      final bobSession = bob.getSessionJson(aliceId)!;
      bobSession['peerX3dhEphemeralKey'] = null;
      bob.storage.store['e2ee_session_$aliceId'] = jsonEncode(bobSession);

      // Alice sends another message with same ephemeral key
      final msg2 = await alice.service.encryptP2P(bobId, 'Second');
      final plaintext = await bob.service.decryptP2P(aliceId, msg2);
      expect(plaintext, equals('Second'));

      // peerX3dhEphemeralKey should now be backfilled
      final updatedSession = bob.getSessionJson(aliceId)!;
      expect(updatedSession['peerX3dhEphemeralKey'], isNotNull);
    });

    test('Branch: OTK consumed and removeConsumedOtk called', () async {
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, 'test');

      // Verify the x3dhHeader includes OTK
      final header = encrypted['x3dhHeader'] as Map<String, dynamic>;
      expect(header['oneTimePreKeyPublicKey'], isNotNull);

      await bob.service.decryptP2P(aliceId, encrypted);

      // removeConsumedOtk should have been called
      verify(() => bob.keyMgmt.removeConsumedOtk(any())).called(1);
    });

    test('Branch: x3dhHeader without OTK → DH4 skipped on receiver', () async {
      // Create a public bundle for Bob without OTKs (but with Ed25519)
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

      // Also give Bob no OTKs in private bundle
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
      final encrypted = await alice.service.encryptP2P(bobId, 'No OTK');

      final header = encrypted['x3dhHeader'] as Map<String, dynamic>;
      expect(header['oneTimePreKeyPublicKey'], isNull);

      final plaintext = await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('No OTK'));
    });
  });

  // ===========================================================================
  // Section 4: CONCURRENT ENCRYPTION (Lock Verification)
  // ===========================================================================
  group('Concurrent encryption serialization', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    test('concurrent encrypts produce consecutive message numbers', () async {
      await alice.service.establishSession(bobId);

      // Fire 5 encrypts concurrently
      final futures = List.generate(
        5,
        (i) => alice.service.encryptP2P(bobId, 'Concurrent $i'),
      );
      final results = await Future.wait(futures);

      final messageNumbers = results
          .map((r) => (r['e2ee'] as Map)['messageNumber'] as int)
          .toList();

      // Should be consecutive (0,1,2,3,4) in some order
      messageNumbers.sort();
      expect(messageNumbers, equals([0, 1, 2, 3, 4]));
    });

    test('concurrent encrypts produce unique ciphertexts', () async {
      await alice.service.establishSession(bobId);

      final futures = List.generate(
        5,
        (i) => alice.service.encryptP2P(bobId, 'same text'),
      );
      final results = await Future.wait(futures);

      final ciphertexts =
          results.map((r) => r['ciphertext'] as String).toSet();
      expect(ciphertexts.length, equals(5));
    });

    test('concurrent encrypts for DIFFERENT recipients run independently', () async {
      final charlie = Participant(charlieId);
      await charlie.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(charlieId))
          .thenAnswer((_) async => charlie.publicBundle);

      await alice.service.establishSession(bobId);
      await alice.service.establishSession(charlieId);

      // Fire encrypts for both recipients concurrently
      final bobFutures = List.generate(
        3,
        (i) => alice.service.encryptP2P(bobId, 'Bob $i'),
      );
      final charlieFutures = List.generate(
        3,
        (i) => alice.service.encryptP2P(charlieId, 'Charlie $i'),
      );

      final bobResults = await Future.wait(bobFutures);
      final charlieResults = await Future.wait(charlieFutures);

      // Both should have consecutive message numbers independently
      final bobNums = bobResults
          .map((r) => (r['e2ee'] as Map)['messageNumber'] as int)
          .toList()
        ..sort();
      final charlieNums = charlieResults
          .map((r) => (r['e2ee'] as Map)['messageNumber'] as int)
          .toList()
        ..sort();

      expect(bobNums, equals([0, 1, 2]));
      expect(charlieNums, equals([0, 1, 2]));
    });

    test('all concurrently encrypted messages are decryptable', () async {
      await alice.service.establishSession(bobId);

      final futures = List.generate(
        5,
        (i) => alice.service.encryptP2P(bobId, 'Message $i'),
      );
      final results = await Future.wait(futures);

      // Sort by message number so Bob decrypts in order
      results.sort((a, b) =>
          ((a['e2ee'] as Map)['messageNumber'] as int)
              .compareTo((b['e2ee'] as Map)['messageNumber'] as int));

      for (var i = 0; i < results.length; i++) {
        final plaintext = await bob.service.decryptP2P(aliceId, results[i]);
        expect(plaintext, equals('Message $i'));
      }
    });
  });

  // ===========================================================================
  // Section 5: SESSION MANAGEMENT METHODS
  // ===========================================================================
  group('Session management', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
    });

    test('hasSession returns false initially', () async {
      expect(await alice.service.hasSession(bobId), isFalse);
    });

    test('hasSession returns true after establishment', () async {
      await alice.service.establishSession(bobId);
      expect(await alice.service.hasSession(bobId), isTrue);
    });

    test('resetSession removes specific session', () async {
      await alice.service.establishSession(bobId);
      expect(await alice.service.hasSession(bobId), isTrue);

      await alice.service.resetSession(bobId);
      expect(await alice.service.hasSession(bobId), isFalse);
    });

    test('resetSession does not affect other sessions', () async {
      final charlie = Participant(charlieId);
      await charlie.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(charlieId))
          .thenAnswer((_) async => charlie.publicBundle);

      await alice.service.establishSession(bobId);
      await alice.service.establishSession(charlieId);

      await alice.service.resetSession(bobId);
      expect(await alice.service.hasSession(bobId), isFalse);
      expect(await alice.service.hasSession(charlieId), isTrue);
    });

    test('clearAllSessions removes all sessions', () async {
      final charlie = Participant(charlieId);
      await charlie.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(charlieId))
          .thenAnswer((_) async => charlie.publicBundle);

      await alice.service.establishSession(bobId);
      await alice.service.establishSession(charlieId);

      await alice.service.clearAllSessions();

      expect(await alice.service.hasSession(bobId), isFalse);
      expect(await alice.service.hasSession(charlieId), isFalse);
    });

    test('clearAllSessions does not remove non-session secure storage keys', () async {
      // Store a non-session key
      await alice.storage.write(key: 'e2ee_identity_key', value: 'test_key');
      await alice.service.establishSession(bobId);

      await alice.service.clearAllSessions();

      // Non-session key should still exist
      final identityKey = await alice.storage.read(key: 'e2ee_identity_key');
      expect(identityKey, equals('test_key'));
    });

    test('resetAllSessions removes all sessions', () async {
      await alice.service.establishSession(bobId);
      await alice.service.resetAllSessions();
      expect(await alice.service.hasSession(bobId), isFalse);
    });

    test('getPeerIdentityKey returns stored peer key', () async {
      await alice.service.establishSession(bobId);
      final peerKey = await alice.service.getPeerIdentityKey(bobId);
      expect(peerKey, equals(bob.publicBundle.identityKey));
    });

    test('getPeerIdentityKey returns null when no session', () async {
      final peerKey = await alice.service.getPeerIdentityKey(bobId);
      expect(peerKey, isNull);
    });

    test('isPeerKeyStale returns false when keys match', () async {
      await alice.service.establishSession(bobId);
      final isStale =
          await alice.service.isPeerKeyStale(bobId, bob.publicBundle.identityKey);
      expect(isStale, isFalse);
    });

    test('isPeerKeyStale returns true when keys differ', () async {
      await alice.service.establishSession(bobId);
      final isStale =
          await alice.service.isPeerKeyStale(bobId, 'different_key');
      expect(isStale, isTrue);
    });

    test('isPeerKeyStale returns false when no session exists', () async {
      final isStale =
          await alice.service.isPeerKeyStale(bobId, bob.publicBundle.identityKey);
      expect(isStale, isFalse);
    });

    test('migrateResetCorruptedSessions resets sessions on first call', () async {
      await alice.service.establishSession(bobId);
      expect(await alice.service.hasSession(bobId), isTrue);

      final migrated = await alice.service.migrateResetCorruptedSessions();
      expect(migrated, isTrue);
      expect(await alice.service.hasSession(bobId), isFalse);
    });

    test('migrateResetCorruptedSessions is idempotent (second call is no-op)', () async {
      await alice.service.migrateResetCorruptedSessions();

      // Re-establish
      await alice.service.establishSession(bobId);
      expect(await alice.service.hasSession(bobId), isTrue);

      // Second call should NOT reset sessions
      final migrated = await alice.service.migrateResetCorruptedSessions();
      expect(migrated, isFalse);
      expect(await alice.service.hasSession(bobId), isTrue);
    });
  });

  // ===========================================================================
  // Section 6: FULL BIDIRECTIONAL CONVERSATION
  // ===========================================================================
  group('Full bidirectional conversation', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    test('10-message bidirectional conversation', () async {
      await alice.service.establishSession(bobId);

      for (var i = 0; i < 10; i++) {
        if (i.isEven) {
          // Alice → Bob
          final enc = await alice.service.encryptP2P(bobId, 'A→B #$i');
          final pt = await bob.service.decryptP2P(aliceId, enc);
          expect(pt, equals('A→B #$i'));
        } else {
          // Bob → Alice
          final enc = await bob.service.encryptP2P(aliceId, 'B→A #$i');
          final pt = await alice.service.decryptP2P(bobId, enc);
          expect(pt, equals('B→A #$i'));
        }
      }
    });

    test('multiple messages in same direction then reply', () async {
      await alice.service.establishSession(bobId);

      // Alice sends 3 messages
      final a2b = <Map<String, dynamic>>[];
      for (var i = 0; i < 3; i++) {
        a2b.add(await alice.service.encryptP2P(bobId, 'A→B #$i'));
      }

      // Bob decrypts all 3
      for (var i = 0; i < 3; i++) {
        expect(await bob.service.decryptP2P(aliceId, a2b[i]), 'A→B #$i');
      }

      // Bob sends 3 messages back
      final b2a = <Map<String, dynamic>>[];
      for (var i = 0; i < 3; i++) {
        b2a.add(await bob.service.encryptP2P(aliceId, 'B→A #$i'));
      }

      // Alice decrypts all 3
      for (var i = 0; i < 3; i++) {
        expect(await alice.service.decryptP2P(bobId, b2a[i]), 'B→A #$i');
      }
    });

    test('session re-establishment mid-conversation', () async {
      // Normal conversation
      await alice.service.establishSession(bobId);
      final enc1 = await alice.service.encryptP2P(bobId, 'Before reset');
      await bob.service.decryptP2P(aliceId, enc1);

      // Alice resets and re-establishes (simulates app reinstall)
      await alice.service.resetSession(bobId);
      await alice.service.establishSession(bobId);

      // Alice sends with new session
      final enc2 = await alice.service.encryptP2P(bobId, 'After reset');

      // Bob should detect new ephemeral key and re-establish receiver X3DH
      final pt2 = await bob.service.decryptP2P(aliceId, enc2);
      expect(pt2, equals('After reset'));

      // Bidirectional communication should still work
      final enc3 = await bob.service.encryptP2P(aliceId, 'Bob reply after reset');
      final pt3 = await alice.service.decryptP2P(bobId, enc3);
      expect(pt3, equals('Bob reply after reset'));
    });

    test('unicode and emoji roundtrip', () async {
      await alice.service.establishSession(bobId);

      const messages = [
        'Hello World! Simple ASCII',
        'Unicod\u00e9 \u00e4\u00f6\u00fc\u00df',
        'Chinese: \u4f60\u597d\u4e16\u754c',
        'Arabic: \u0645\u0631\u062d\u0628\u0627',
        'Emoji: \u{1F600}\u{1F680}\u{1F4A1}\u{2764}\u{FE0F}',
        'Mixed: Hello \u{1F44B} World \u{1F30D}!',
        '', // empty string
      ];

      for (final msg in messages) {
        final enc = await alice.service.encryptP2P(bobId, msg);
        final pt = await bob.service.decryptP2P(aliceId, enc);
        expect(pt, equals(msg), reason: 'Failed for: $msg');
      }
    });

    test('large message roundtrip (10KB)', () async {
      await alice.service.establishSession(bobId);
      final largeMsg = 'A' * 10240;
      final enc = await alice.service.encryptP2P(bobId, largeMsg);
      final pt = await bob.service.decryptP2P(aliceId, enc);
      expect(pt, equals(largeMsg));
    });
  });

  // ===========================================================================
  // Section 7: EDGE CASES AND ERROR CONDITIONS
  // ===========================================================================
  group('Edge cases and errors', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    test('establishSession throws when loadPrivateKeys returns null', () async {
      when(() => alice.keyMgmt.loadPrivateKeys()).thenAnswer((_) async => null);

      expect(
        () => alice.service.establishSession(bobId),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('No local key bundle'),
        )),
      );
    });

    test('encryptP2P auto-establishes when no session exists', () async {
      // Skip explicit establishSession
      final result = await alice.service.encryptP2P(bobId, 'Auto');
      expect(result['ciphertext'], isA<String>());
      expect(await alice.service.hasSession(bobId), isTrue);
    });

    test('encryptP2P throws when establishment fails (no keys)', () async {
      when(() => alice.keyMgmt.loadPrivateKeys()).thenAnswer((_) async => null);

      expect(
        () => alice.service.encryptP2P(bobId, 'test'),
        throwsA(isA<StateError>()),
      );
    });

    test('Ed25519 signature verification blocks invalid signed pre-key', () async {
      // Create Bob's bundle with Ed25519 fields
      final ed25519Kp = await crypto.generateEd25519KeyPair();
      // Sign some WRONG data so verification fails
      final wrongSig = await crypto.ed25519Sign(
        base64Decode(base64Encode([1, 2, 3])), // wrong data
        ed25519Kp['privateKey']!,
      );

      final badBundle = PublicKeyBundle(
        identityKey: bob.publicBundle.identityKey,
        signedPreKey: bob.publicBundle.signedPreKey,
        signedPreKeySignature: bob.publicBundle.signedPreKeySignature,
        oneTimePreKeys: bob.publicBundle.oneTimePreKeys,
        registrationId: bob.publicBundle.registrationId,
        userId: bobId,
        ed25519IdentityKey: base64Encode(ed25519Kp['publicKey']!),
        ed25519Signature: base64Encode(wrongSig),
      );
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => badBundle);

      expect(
        () => alice.service.establishSession(bobId),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('MITM'),
        )),
      );
    });

    test('decryptP2P throws on corrupted ciphertext (MAC failure)', () async {
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, 'test');

      // Corrupt the ciphertext
      final ciphertext = base64Decode(encrypted['ciphertext'] as String);
      ciphertext[20] ^= 0xFF; // flip a byte
      encrypted['ciphertext'] = base64Encode(ciphertext);

      expect(
        () => bob.service.decryptP2P(aliceId, encrypted),
        throwsA(anything), // MAC verification failure
      );
    });

    test('decryptP2P throws on too-short ciphertext', () async {
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, 'test');

      // Replace with too-short ciphertext (< 28 bytes)
      encrypted['ciphertext'] = base64Encode([1, 2, 3]);

      expect(
        () => bob.service.decryptP2P(aliceId, encrypted),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('ciphertext too short'),
        )),
      );
    });

    test('session not saved when decryption fails (MAC error)', () async {
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, 'test');

      // Corrupt ciphertext
      final ciphertext = base64Decode(encrypted['ciphertext'] as String);
      ciphertext[20] ^= 0xFF;
      encrypted['ciphertext'] = base64Encode(ciphertext);

      // Bob has no session before first decrypt
      expect(await bob.service.hasSession(aliceId), isFalse);

      try {
        await bob.service.decryptP2P(aliceId, encrypted);
      } catch (_) {
        // Expected
      }

      // Session should NOT be saved (decrypt failed before save)
      expect(await bob.service.hasSession(aliceId), isFalse);
    });
  });

  // ===========================================================================
  // Section 8: SKIPPED KEYS AND PRUNING
  // ===========================================================================
  group('Skipped keys', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await alice.init(crypto);
      await bob.init(crypto);
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    test('skipping messages stores skipped keys in session', () async {
      await alice.service.establishSession(bobId);

      final msg0 = await alice.service.encryptP2P(bobId, 'Msg 0');
      final msg1 = await alice.service.encryptP2P(bobId, 'Msg 1');
      final msg2 = await alice.service.encryptP2P(bobId, 'Msg 2');

      // Decrypt msg2 first (skip 0 and 1)
      await bob.service.decryptP2P(aliceId, msg2);

      // Session should have skipped keys for msg 0 and 1
      final session = bob.getSessionJson(aliceId)!;
      final skippedKeys = session['skippedKeys'] as Map<String, dynamic>;
      expect(skippedKeys.length, equals(2));

      // Now decrypt msg0 and msg1 using skipped keys
      expect(await bob.service.decryptP2P(aliceId, msg0), equals('Msg 0'));
      expect(await bob.service.decryptP2P(aliceId, msg1), equals('Msg 1'));

      // Skipped keys should be consumed
      final sessionAfter = bob.getSessionJson(aliceId)!;
      final skippedKeysAfter = sessionAfter['skippedKeys'] as Map<String, dynamic>;
      expect(skippedKeysAfter.length, equals(0));
    });

    test('skipped key used for out-of-order message after DH ratchet', () async {
      await alice.service.establishSession(bobId);

      // Alice sends msg0 and msg1
      final msg0 = await alice.service.encryptP2P(bobId, 'A→B 0');
      final msg1 = await alice.service.encryptP2P(bobId, 'A→B 1');

      // Bob receives only msg1, skipping msg0
      expect(await bob.service.decryptP2P(aliceId, msg1), 'A→B 1');

      // Bob replies (triggers DH ratchet on Alice's side)
      final reply = await bob.service.encryptP2P(aliceId, 'B→A reply');
      expect(await alice.service.decryptP2P(bobId, reply), 'B→A reply');

      // Alice sends more messages (new DH keys after ratchet)
      final msg2 = await alice.service.encryptP2P(bobId, 'A→B 2');
      expect(await bob.service.decryptP2P(aliceId, msg2), 'A→B 2');

      // Now Bob tries to decrypt the skipped msg0 from the OLD chain
      expect(await bob.service.decryptP2P(aliceId, msg0), 'A→B 0');
    });

    test('skipRecvKeys throws StateError on gap exceeding maxSkippedKeys', () async {
      await alice.service.establishSession(bobId);

      // Encrypt 1 message to establish Bob's receiver session
      final msg0 = await alice.service.encryptP2P(bobId, 'Setup');
      await bob.service.decryptP2P(aliceId, msg0);

      // Forge a message with messageNumber > maxSkippedKeys (200)
      // by manipulating Alice's session to jump message numbers
      final aliceSession = alice.getSessionJson(bobId)!;
      aliceSession['sendMessageNumber'] = 250;
      alice.storage.store['e2ee_session_$bobId'] = jsonEncode(aliceSession);

      final farFutureMsg = await alice.service.encryptP2P(bobId, 'Far future');

      // Bob should fail to decrypt — skipRecvKeys throws on gap > 200
      expect(
        () => bob.service.decryptP2P(aliceId, farFutureMsg),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('Too many skipped keys'),
        )),
      );
    });
  });

  // ===========================================================================
  // Section: Ed25519 SPK VERIFICATION (C1)
  // ===========================================================================
  group('Ed25519 SPK verification', () {
    late Participant alice;
    late Participant bob;

    setUp(() async {
      alice = Participant(aliceId);
      bob = Participant(bobId);
      await Future.wait([alice.init(crypto), bob.init(crypto)]);
      when(() => alice.keyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});
      when(() => bob.keyMgmt.removeConsumedOtk(any()))
          .thenAnswer((_) async {});
    });

    test('establishSession throws when Ed25519 fields null', () async {
      // Create a bundle without Ed25519 fields
      final noEd25519Bundle = PublicKeyBundle(
        identityKey: bob.publicBundle.identityKey,
        signedPreKey: bob.publicBundle.signedPreKey,
        signedPreKeySignature: bob.publicBundle.signedPreKeySignature,
        oneTimePreKeys: bob.publicBundle.oneTimePreKeys,
        registrationId: bob.publicBundle.registrationId,
        userId: bobId,
        // ed25519IdentityKey: null,
        // ed25519Signature: null,
      );
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => noEd25519Bundle);

      expect(
        () => alice.service.establishSession(bobId),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('missing Ed25519 fields'),
        )),
      );
    });

    test('establishSession throws when Ed25519 signature invalid', () async {
      // Create a bundle with wrong Ed25519 signature (random bytes)
      final wrongSigBundle = PublicKeyBundle(
        identityKey: bob.publicBundle.identityKey,
        signedPreKey: bob.publicBundle.signedPreKey,
        signedPreKeySignature: bob.publicBundle.signedPreKeySignature,
        oneTimePreKeys: bob.publicBundle.oneTimePreKeys,
        registrationId: bob.publicBundle.registrationId,
        userId: bobId,
        ed25519IdentityKey: bob.publicBundle.ed25519IdentityKey,
        ed25519Signature: base64Encode(crypto.randomBytes(64)),
      );
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => wrongSigBundle);

      expect(
        () => alice.service.establishSession(bobId),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('signature verification failed'),
        )),
      );
    });

    test('establishSession succeeds with valid Ed25519 signature', () async {
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);

      // Should not throw
      await alice.service.establishSession(bobId);
      expect(alice.getSessionJson(bobId), isNotNull);
    });
  });
}
