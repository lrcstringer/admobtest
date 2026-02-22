import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/data/models/message_model.dart';
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
// MOCK
// =============================================================================

class MockKeyManagementService extends Mock implements KeyManagementService {}

// =============================================================================
// PARTICIPANT — bundles a SignalProtocolService with its own keys
// =============================================================================

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

  /// Generate real X25519 key material and wire the mock.
  Future<void> init(CryptoService crypto) async {
    final identityKp = await crypto.generateX25519KeyPair();
    final signedPreKp = await crypto.generateX25519KeyPair();
    final otkKp = await crypto.generateX25519KeyPair();

    final identityEncoded =
        '${base64Encode(identityKp['privateKey']!)}|${base64Encode(identityKp['publicKey']!)}';
    final signedPreEncoded =
        '${base64Encode(signedPreKp['privateKey']!)}|${base64Encode(signedPreKp['publicKey']!)}';
    final otkEncoded =
        '${base64Encode(otkKp['privateKey']!)}|${base64Encode(otkKp['publicKey']!)}';

    privateBundle = KeyBundle(
      identityKeyPair: identityEncoded,
      signedPreKey: signedPreEncoded,
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [otkEncoded],
      registrationId: 1,
    );

    publicBundle = PublicKeyBundle(
      identityKey: base64Encode(identityKp['publicKey']!),
      signedPreKey: base64Encode(signedPreKp['publicKey']!),
      signedPreKeySignature: 'sig',
      oneTimePreKeys: [base64Encode(otkKp['publicKey']!)],
      registrationId: 1,
      userId: userId,
    );

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

  const aliceId = 'alice_user_id';
  const bobId = 'bob_user_id';

  setUp(() {
    crypto = CryptoService();
  });

  group('E2EE P2P Integration Flow', () {
    late _Participant alice;
    late _Participant bob;

    setUp(() async {
      alice = _Participant(aliceId);
      bob = _Participant(bobId);

      await alice.init(crypto);
      await bob.init(crypto);

      // Wire cross-references
      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    test('Full P2P flow: generate keys -> establish session -> encrypt -> decrypt',
        () async {
      // Alice establishes session with Bob
      await alice.service.establishSession(bobId);

      // Verify session is stored
      expect(await alice.service.hasSession(bobId), isTrue);

      // Alice encrypts a message
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Hello from Alice!');

      // Verify encrypted output shape
      expect(encrypted['ciphertext'], isA<String>());
      expect(encrypted['e2ee'], isA<Map<String, dynamic>>());

      // Bob decrypts the message (receiver-side X3DH via x3dhHeader)
      final plaintext = await bob.service.decryptP2P(aliceId, encrypted);
      expect(plaintext, equals('Hello from Alice!'));
    });

    test('Alice + Bob exchange keys -> Alice encrypts, Bob decrypts (one direction)',
        () async {
      // Alice sends 3 messages to Bob — all decrypt correctly
      await alice.service.establishSession(bobId);

      final enc1 = await alice.service.encryptP2P(bobId, 'First message');
      final enc2 = await alice.service.encryptP2P(bobId, 'Second message');
      final enc3 = await alice.service.encryptP2P(bobId, 'Third message');

      final pt1 = await bob.service.decryptP2P(aliceId, enc1);
      final pt2 = await bob.service.decryptP2P(aliceId, enc2);
      final pt3 = await bob.service.decryptP2P(aliceId, enc3);

      expect(pt1, equals('First message'));
      expect(pt2, equals('Second message'));
      expect(pt3, equals('Third message'));
    });

    test('Roundtrip: plaintext -> encrypt -> ciphertext -> decrypt -> same plaintext',
        () async {
      const original = 'The quick brown fox jumps over the lazy dog.';
      await alice.service.establishSession(bobId);

      final encrypted = await alice.service.encryptP2P(bobId, original);

      // The ciphertext must differ from the plaintext
      final ciphertext = encrypted['ciphertext'] as String;
      expect(ciphertext, isNot(equals(base64Encode(utf8.encode(original)))));

      // Decryption must recover the exact original plaintext
      final recovered = await bob.service.decryptP2P(aliceId, encrypted);
      expect(recovered, equals(original));
    });

    test('Multiple sequential messages maintain session', () async {
      await alice.service.establishSession(bobId);

      final messages = <String>[];
      final encrypted = <Map<String, dynamic>>[];

      for (var i = 0; i < 5; i++) {
        final msg = 'Sequential message #$i';
        messages.add(msg);
        encrypted.add(await alice.service.encryptP2P(bobId, msg));
      }

      // Decrypt all in order
      for (var i = 0; i < 5; i++) {
        final plaintext = await bob.service.decryptP2P(aliceId, encrypted[i]);
        expect(plaintext, equals(messages[i]));
      }
    });

    test('All messages include x3dhHeader until session confirmed', () async {
      await alice.service.establishSession(bobId);

      final first = await alice.service.encryptP2P(bobId, 'first message');
      final second = await alice.service.encryptP2P(bobId, 'second message');
      final third = await alice.service.encryptP2P(bobId, 'third message');

      // All messages include x3dhHeader while pending keys exist
      // (pending keys are cleared only when sender receives a decrypted reply)
      expect(first.containsKey('x3dhHeader'), isTrue);
      expect(second.containsKey('x3dhHeader'), isTrue);
      expect(third.containsKey('x3dhHeader'), isTrue);

      final h1 = first['x3dhHeader'] as Map<String, dynamic>;
      expect(h1['identityKey'], isA<String>());
      expect(h1['ephemeralKey'], isA<String>());
    });

    test('Large message (5000 chars) encrypts and decrypts correctly', () async {
      final largeMessage = 'A' * 5000;
      await alice.service.establishSession(bobId);

      final encrypted = await alice.service.encryptP2P(bobId, largeMessage);
      final plaintext = await bob.service.decryptP2P(aliceId, encrypted);

      expect(plaintext, equals(largeMessage));
      expect(plaintext.length, equals(5000));
    });

    test('Unicode and emoji roundtrip', () async {
      const message =
          'Hello World! Hej! Salut! Ciao! Emoji test: \u2764\ufe0f\ud83d\ude80\ud83c\udf1f\ud83d\ude00 '
          'CJK: \u4f60\u597d\u4e16\u754c Cyrillic: \u041f\u0440\u0438\u0432\u0435\u0442 '
          'Arabic: \u0645\u0631\u062d\u0628\u0627 Special: <>&"\'\\/ \u00e9\u00e8\u00ea\u00eb\u00fc\u00f6\u00e4';
      await alice.service.establishSession(bobId);

      final encrypted = await alice.service.encryptP2P(bobId, message);
      final plaintext = await bob.service.decryptP2P(aliceId, encrypted);

      expect(plaintext, equals(message));
    });

    test('Empty string encrypts and decrypts correctly', () async {
      await alice.service.establishSession(bobId);

      final encrypted = await alice.service.encryptP2P(bobId, '');
      final plaintext = await bob.service.decryptP2P(aliceId, encrypted);

      expect(plaintext, equals(''));
    });

    test('Different messages produce different ciphertext', () async {
      await alice.service.establishSession(bobId);

      // Consume the x3dhHeader first
      await alice.service.encryptP2P(bobId, 'primer');

      final enc1 = await alice.service.encryptP2P(bobId, 'same text');
      final enc2 = await alice.service.encryptP2P(bobId, 'same text');

      // Even the same plaintext produces different ciphertext due to
      // ratcheting chain keys and random nonces
      expect(enc1['ciphertext'], isNot(equals(enc2['ciphertext'])));
    });

    test(
      'Bidirectional P2P messaging (Alice->Bob then Bob->Alice)',
      () async {
        await alice.service.establishSession(bobId);
        final encrypted =
            await alice.service.encryptP2P(bobId, 'Hello Bob');
        await bob.service.decryptP2P(aliceId, encrypted);

        // Bob replies
        final reply =
            await bob.service.encryptP2P(aliceId, 'Hello Alice');
        final fromBob = await alice.service.decryptP2P(bobId, reply);
        expect(fromBob, equals('Hello Alice'));
      },
    );
  });

  // ===========================================================================
  // FIRESTORE ROUND-TRIP TESTS
  //
  // These tests simulate the EXACT production data path:
  //   encryptP2P → JSON (CF callable) → Firestore → MessageModel.fromJson
  //   → toEntity → rebuild encrypted map (sync service) → decryptP2P
  //
  // The direct encrypt/decrypt tests above pass the map DIRECTLY between
  // encrypt and decrypt. Production goes through serialisation/deserialisation
  // which can lose types (int→double), drop null keys, or mutate nested maps.
  // ===========================================================================

  group('Firestore round-trip serialisation', () {
    late _Participant alice;
    late _Participant bob;

    setUp(() async {
      alice = _Participant(aliceId);
      bob = _Participant(bobId);

      await alice.init(CryptoService());
      await bob.init(CryptoService());

      when(() => alice.keyMgmt.fetchKeyBundle(bobId))
          .thenAnswer((_) async => bob.publicBundle);
      when(() => bob.keyMgmt.fetchKeyBundle(aliceId))
          .thenAnswer((_) async => alice.publicBundle);
    });

    /// Simulate what the Cloud Function does: build a Firestore message doc
    /// from the encrypted output, then parse it back via MessageModel.
    Map<String, dynamic> buildFirestoreDoc(
      Map<String, dynamic> encrypted,
      String senderId,
    ) {
      // CF stores these fields (conversations.ts lines 271-308)
      return {
        'id': 'test_msg_${DateTime.now().microsecondsSinceEpoch}',
        'senderId': senderId,
        'senderName': 'Test User',
        'type': 'text',
        'status': 'sent',
        'textContent': null,
        'ciphertext': encrypted['ciphertext'],
        'e2ee': encrypted['e2ee'],
        'x3dhHeader': encrypted['x3dhHeader'],
        'createdAt': DateTime.now().toIso8601String(),
      };
    }

    /// Rebuild the encrypted map exactly as MessageSyncService._decryptMessage
    /// does (message_sync_service.dart lines 268-285).
    Map<String, dynamic> rebuildEncryptedMap(dynamic msg) {
      final message = msg;
      return <String, dynamic>{
        'ciphertext': message.ciphertext,
        if (message.e2ee != null)
          'e2ee': {
            'protocol': message.e2ee.protocol,
            'messageNumber': message.e2ee.messageNumber,
            'dhPublicKey': message.e2ee.dhPublicKey,
          },
        if (message.x3dhHeader != null)
          'x3dhHeader': {
            'identityKey': message.x3dhHeader.identityKey,
            'ephemeralKey': message.x3dhHeader.ephemeralKey,
            if (message.x3dhHeader.oneTimePreKeyPublicKey != null)
              'oneTimePreKeyPublicKey':
                  message.x3dhHeader.oneTimePreKeyPublicKey,
            if (message.x3dhHeader.oneTimePreKeyId != null)
              'oneTimePreKeyId': message.x3dhHeader.oneTimePreKeyId,
          },
      };
    }

    test('encrypt → Firestore doc → MessageModel → entity → rebuild → decrypt',
        () async {
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'Hello via Firestore!');

      // Step 1: Build Firestore document (simulating CF storage)
      final firestoreDoc = buildFirestoreDoc(encrypted, aliceId);

      // Step 2: Parse via MessageModel (simulating Firestore SDK read)
      final model = MessageModel.fromJson(firestoreDoc);

      // Step 3: Convert to entity (simulating sync service)
      final entity = model.toEntity();

      // Verify the entity preserved the E2EE fields
      expect(entity.ciphertext, isNotNull);
      expect(entity.e2ee, isNotNull);
      expect(entity.e2ee!.messageNumber, isA<int>());
      expect(entity.e2ee!.dhPublicKey, isNotNull);
      expect(entity.x3dhHeader, isNotNull);
      expect(entity.x3dhHeader!.identityKey, isNotEmpty);
      expect(entity.x3dhHeader!.ephemeralKey, isNotEmpty);

      // Step 4: Rebuild encrypted map (exactly as sync service does)
      final rebuiltMap = rebuildEncryptedMap(entity);

      // Step 5: Bob decrypts using the rebuilt map
      final plaintext = await bob.service.decryptP2P(aliceId, rebuiltMap);
      expect(plaintext, equals('Hello via Firestore!'));
    });

    test('JSON round-trip simulating JavaScript number serialisation',
        () async {
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'JSON round-trip test');

      // Simulate: Dart map → JSON string → JavaScript → Firestore → JSON → Dart
      // This is what actually happens with callable functions + Firestore
      final jsonStr = jsonEncode(encrypted);
      final fromJson = jsonDecode(jsonStr) as Map<String, dynamic>;

      // Verify types survived JSON round-trip
      final e2ee = fromJson['e2ee'] as Map<String, dynamic>;
      // JSON decode returns int for whole numbers in Dart
      expect(e2ee['messageNumber'], isA<int>());

      // Build Firestore doc from JSON-roundtripped data
      final firestoreDoc = buildFirestoreDoc(fromJson, aliceId);
      final model = MessageModel.fromJson(firestoreDoc);
      final entity = model.toEntity();
      final rebuiltMap = rebuildEncryptedMap(entity);

      final plaintext = await bob.service.decryptP2P(aliceId, rebuiltMap);
      expect(plaintext, equals('JSON round-trip test'));
    });

    test('messageNumber as double (Firestore web edge case) still decrypts',
        () async {
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'double messageNumber');

      // Simulate Firestore returning messageNumber as double (web platform)
      final firestoreDoc = buildFirestoreDoc(encrypted, aliceId);
      final e2eeMap =
          Map<String, dynamic>.from(firestoreDoc['e2ee'] as Map);
      e2eeMap['messageNumber'] =
          (e2eeMap['messageNumber'] as int).toDouble();
      firestoreDoc['e2ee'] = e2eeMap;

      // MessageModel.fromJson should handle this — _parseE2eeMetadata
      // casts messageNumber as int?, which WILL throw for double.
      // This test documents the current behavior.
      try {
        final model = MessageModel.fromJson(firestoreDoc);
        final entity = model.toEntity();
        final rebuiltMap = rebuildEncryptedMap(entity);

        final plaintext = await bob.service.decryptP2P(aliceId, rebuiltMap);
        expect(plaintext, equals('double messageNumber'));
      } on TypeError {
        // If this fires, messageNumber: double → as int? throws.
        // This IS a real production bug on platforms that return double.
        fail(
          'messageNumber as double caused TypeError — '
          '_parseE2eeMetadata needs (raw["messageNumber"] as num?)?.toInt()',
        );
      }
    });

    test('multiple messages through Firestore round-trip', () async {
      await alice.service.establishSession(bobId);

      for (var i = 0; i < 5; i++) {
        final msg = 'Firestore message #$i';
        final encrypted = await alice.service.encryptP2P(bobId, msg);

        final firestoreDoc = buildFirestoreDoc(encrypted, aliceId);
        final model = MessageModel.fromJson(firestoreDoc);
        final entity = model.toEntity();
        final rebuiltMap = rebuildEncryptedMap(entity);

        final plaintext = await bob.service.decryptP2P(aliceId, rebuiltMap);
        expect(plaintext, equals(msg));
      }
    });

    test('bidirectional through Firestore round-trip', () async {
      // Alice → Bob
      await alice.service.establishSession(bobId);
      final enc1 =
          await alice.service.encryptP2P(bobId, 'Hello from Alice');
      final doc1 = buildFirestoreDoc(enc1, aliceId);
      final model1 = MessageModel.fromJson(doc1);
      final entity1 = model1.toEntity();
      final rebuilt1 = rebuildEncryptedMap(entity1);
      final pt1 = await bob.service.decryptP2P(aliceId, rebuilt1);
      expect(pt1, equals('Hello from Alice'));

      // Bob → Alice
      final enc2 =
          await bob.service.encryptP2P(aliceId, 'Hello from Bob');
      final doc2 = buildFirestoreDoc(enc2, bobId);
      final model2 = MessageModel.fromJson(doc2);
      final entity2 = model2.toEntity();
      final rebuilt2 = rebuildEncryptedMap(entity2);
      final pt2 = await alice.service.decryptP2P(bobId, rebuilt2);
      expect(pt2, equals('Hello from Bob'));
    });

    test('x3dhHeader.oneTimePreKeyPublicKey preserved through round-trip',
        () async {
      await alice.service.establishSession(bobId);
      final encrypted =
          await alice.service.encryptP2P(bobId, 'OTK round-trip');

      // Verify original has OTK
      final origHeader = encrypted['x3dhHeader'] as Map<String, dynamic>;
      expect(origHeader['oneTimePreKeyPublicKey'], isNotNull,
          reason: 'sender must include OTK public key in x3dhHeader');

      // Round-trip
      final firestoreDoc = buildFirestoreDoc(encrypted, aliceId);
      final model = MessageModel.fromJson(firestoreDoc);
      final entity = model.toEntity();

      // Verify OTK survived
      expect(entity.x3dhHeader!.oneTimePreKeyPublicKey, isNotNull);
      expect(entity.x3dhHeader!.oneTimePreKeyPublicKey,
          equals(origHeader['oneTimePreKeyPublicKey']));

      // Decrypt
      final rebuiltMap = rebuildEncryptedMap(entity);
      final plaintext = await bob.service.decryptP2P(aliceId, rebuiltMap);
      expect(plaintext, equals('OTK round-trip'));
    });
  });
}
