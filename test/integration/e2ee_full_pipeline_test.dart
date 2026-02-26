/// End-to-end simulation of the EXACT production flow for E2EE messaging.
///
/// This test exercises every layer of the real code path:
///
///   SENDER DEVICE:
///     1. SignalProtocolService.establishSession()  → X3DH key agreement
///     2. SignalProtocolService.encryptP2P()         → Double Ratchet encrypt
///     3. ConversationRemoteDataSource.sendEncryptedMessage()
///        → sends {ciphertext, e2ee, x3dhHeader} to Cloud Function
///
///   CLOUD FUNCTION (sendConversationMessage):
///     4. Stores the message in Firestore as-is:
///        { ciphertext, e2ee, x3dhHeader, senderId, type, status, ... }
///
///   RECIPIENT DEVICE:
///     5. Firestore snapshot arrives → MessageModel.fromFirestore(doc)
///     6. MessageModel.toEntity() → Message with E2eeMetadata, X3dhHeader
///     7. _decryptIfNeeded() reconstructs encryptedMap from entity fields
///     8. SignalProtocolService.decryptP2P(senderId, encryptedMap) → plaintext
///     9. UI displays the decrypted text
///
/// Steps 4-7 are the "Firestore round-trip" that could silently corrupt data
/// (wrong types, missing fields, null coercion). This test catches that.
library;

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/data/models/message_model.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
import 'package:mocktail/mocktail.dart';

// =============================================================================
// IN-MEMORY SECURE STORAGE (same as other test files)
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
}

// =============================================================================
// MOCK
// =============================================================================

class MockKeyManagementService extends Mock implements KeyManagementService {}

// =============================================================================
// PARTICIPANT — bundles a SignalProtocolService with its own real keys
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

  /// Generate real X25519+Ed25519 key material and wire the mock.
  Future<void> init(CryptoService crypto) async {
    final identityKp = await crypto.generateX25519KeyPair();
    final signedPreKp = await crypto.generateX25519KeyPair();
    final ed25519Kp = await crypto.generateEd25519KeyPair();
    final otkKps = <Map<String, dynamic>>[];
    for (var i = 0; i < 3; i++) {
      final kp = await crypto.generateX25519KeyPair();
      otkKps.add({
        'encoded':
            '${base64Encode(kp['privateKey']!)}|${base64Encode(kp['publicKey']!)}',
        'public': base64Encode(kp['publicKey']!),
      });
    }

    final identityEncoded =
        '${base64Encode(identityKp['privateKey']!)}|${base64Encode(identityKp['publicKey']!)}';
    final signedPreEncoded =
        '${base64Encode(signedPreKp['privateKey']!)}|${base64Encode(signedPreKp['publicKey']!)}';
    final ed25519Encoded =
        '${base64Encode(ed25519Kp['privateKey']!)}|${base64Encode(ed25519Kp['publicKey']!)}';

    // Ed25519 signature over the signed pre-key public key
    final ed25519Sig = await crypto.ed25519Sign(
      signedPreKp['publicKey']!,
      ed25519Kp['privateKey']!,
    );

    privateBundle = KeyBundle(
      identityKeyPair: identityEncoded,
      signedPreKey: signedPreEncoded,
      signedPreKeySignature: 'hmac-sig',
      oneTimePreKeys: otkKps.map((kp) => kp['encoded'] as String).toList(),
      registrationId: 1,
      ed25519IdentityKeyPair: ed25519Encoded,
      ed25519Signature: base64Encode(ed25519Sig),
    );

    publicBundle = PublicKeyBundle(
      identityKey: base64Encode(identityKp['publicKey']!),
      signedPreKey: base64Encode(signedPreKp['publicKey']!),
      signedPreKeySignature: 'hmac-sig',
      oneTimePreKeys: otkKps.map((kp) => kp['public'] as String).toList(),
      registrationId: 1,
      userId: userId,
      ed25519IdentityKey: base64Encode(ed25519Kp['publicKey']!),
      ed25519Signature: base64Encode(ed25519Sig),
    );

    when(() => keyMgmt.loadPrivateKeys())
        .thenAnswer((_) async => privateBundle);
    when(() => keyMgmt.removeConsumedOtk(any()))
        .thenAnswer((_) async {});

    service = SignalProtocolService(keyMgmt, crypto, storage);
  }
}

// =============================================================================
// HELPER: Simulate what the Cloud Function stores in Firestore
// =============================================================================

/// Builds the EXACT Firestore document map that `sendConversationMessage`
/// would write.  See functions/src/conversations.ts lines 271-308.
Map<String, dynamic> simulateCloudFunctionStore({
  required String messageId,
  required String senderId,
  required String senderName,
  required String ciphertext,
  required Map<String, dynamic> e2ee,
  Map<String, dynamic>? x3dhHeader,
}) {
  return {
    'id': messageId, // Firestore doc ID (added in fromFirestore via doc.id)
    'senderId': senderId,
    'senderName': senderName,
    'senderAvatarUrl': null,
    'type': 'text',
    'status': 'sent',
    'textContent': null, // null because ciphertext is present
    'ciphertext': ciphertext,
    'e2ee': e2ee,
    'x3dhHeader': x3dhHeader,
    'media': null,
    'tokenAmount': null,
    'recipientId': null,
    'ledgerJournalId': null,
    'reactions': <String, dynamic>{},
    'replyTo': null,
    'communityId': null,
    'systemEventType': null,
    'systemEventData': null,
    'createdAt': Timestamp.now(),
    'expiresAt': null,
    'actionedAt': null,
    'deletedAt': null,
    'deletedFor': <String>[],
    'deletedForEveryone': false,
  };
}

// =============================================================================
// HELPER: Simulate _decryptIfNeeded map reconstruction
// =============================================================================

/// Reconstructs the encryptedMap exactly as _decryptIfNeeded does in
/// conversation_repository_impl.dart (lines 830-848).
Map<String, dynamic> reconstructEncryptedMap(
  String? ciphertext,
  dynamic e2ee,
  dynamic x3dhHeader,
) {
  return {
    'ciphertext': ciphertext,
    if (e2ee != null)
      'e2ee': {
        'protocol': e2ee.protocol,
        'messageNumber': e2ee.messageNumber,
        'dhPublicKey': e2ee.dhPublicKey,
      },
    if (x3dhHeader != null)
      'x3dhHeader': {
        'identityKey': x3dhHeader.identityKey,
        'ephemeralKey': x3dhHeader.ephemeralKey,
        if (x3dhHeader.oneTimePreKeyPublicKey != null)
          'oneTimePreKeyPublicKey': x3dhHeader.oneTimePreKeyPublicKey,
        if (x3dhHeader.oneTimePreKeyId != null)
          'oneTimePreKeyId': x3dhHeader.oneTimePreKeyId,
      },
  };
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late CryptoService crypto;
  late _Participant alice;
  late _Participant bob;

  const aliceId = 'alice_uid_production';
  const bobId = 'bob_uid_production';

  setUp(() async {
    crypto = CryptoService();
    alice = _Participant(aliceId);
    bob = _Participant(bobId);

    await alice.init(crypto);
    await bob.init(crypto);

    // Wire cross-references (simulates fetchKeyBundle Cloud Function)
    // The CF returns a single OTK (first one), consuming it from the array.
    // We simulate this by returning a PublicKeyBundle with only the first OTK.
    when(() => alice.keyMgmt.fetchKeyBundle(bobId)).thenAnswer((_) async {
      return PublicKeyBundle(
        identityKey: bob.publicBundle.identityKey,
        signedPreKey: bob.publicBundle.signedPreKey,
        signedPreKeySignature: bob.publicBundle.signedPreKeySignature,
        oneTimePreKeys: [bob.publicBundle.oneTimePreKeys.first], // CF returns 1
        registrationId: bob.publicBundle.registrationId,
        userId: bobId,
        ed25519IdentityKey: bob.publicBundle.ed25519IdentityKey,
        ed25519Signature: bob.publicBundle.ed25519Signature,
      );
    });
    when(() => bob.keyMgmt.fetchKeyBundle(aliceId)).thenAnswer((_) async {
      return PublicKeyBundle(
        identityKey: alice.publicBundle.identityKey,
        signedPreKey: alice.publicBundle.signedPreKey,
        signedPreKeySignature: alice.publicBundle.signedPreKeySignature,
        oneTimePreKeys: [alice.publicBundle.oneTimePreKeys.first],
        registrationId: alice.publicBundle.registrationId,
        userId: aliceId,
        ed25519IdentityKey: alice.publicBundle.ed25519IdentityKey,
        ed25519Signature: alice.publicBundle.ed25519Signature,
      );
    });
  });

  group('Full production pipeline simulation', () {
    test(
      'Alice sends "Hello Bob!" → Firestore round-trip → Bob sees "Hello Bob!"',
      () async {
        const originalText = 'Hello Bob!';

        // =====================================================================
        // STEP 1-2: SENDER DEVICE — establish session + encrypt
        // =====================================================================
        await alice.service.establishSession(bobId);
        final encrypted = await alice.service.encryptP2P(bobId, originalText);

        // Verify the encrypted output has the expected shape
        final ciphertext = encrypted['ciphertext'] as String;
        final e2ee = encrypted['e2ee'] as Map<String, dynamic>;
        final x3dhHeader = encrypted['x3dhHeader'] as Map<String, dynamic>?;

        expect(ciphertext, isNotEmpty);
        expect(e2ee['protocol'], 'signal-v1');
        expect(e2ee['messageNumber'], 0);
        expect(e2ee['dhPublicKey'], isA<String>());
        expect(x3dhHeader, isNotNull, reason: 'First message must have x3dhHeader');
        expect(x3dhHeader!['identityKey'], isA<String>());
        expect(x3dhHeader['ephemeralKey'], isA<String>());

        // =====================================================================
        // STEP 3-4: CLOUD FUNCTION — store in Firestore (simulated)
        // =====================================================================
        final firestoreDoc = simulateCloudFunctionStore(
          messageId: 'msg_001',
          senderId: aliceId,
          senderName: 'Alice',
          ciphertext: ciphertext,
          e2ee: e2ee,
          x3dhHeader: x3dhHeader,
        );

        // =====================================================================
        // STEP 5: RECIPIENT DEVICE — Firestore snapshot → MessageModel
        // =====================================================================
        // This is exactly what MessageModel.fromFirestore does:
        //   fromJson({...data, 'id': doc.id})
        final messageModel = MessageModel.fromJson(firestoreDoc);

        // Verify the model parsed correctly
        expect(messageModel.ciphertext, equals(ciphertext));
        expect(messageModel.e2ee, isNotNull);
        expect(messageModel.e2ee!['protocol'], 'signal-v1');
        expect(messageModel.e2ee!['messageNumber'], 0);
        expect(messageModel.e2ee!['dhPublicKey'], isA<String>());
        expect(messageModel.x3dhHeader, isNotNull);
        expect(messageModel.x3dhHeader!['identityKey'], isA<String>());
        expect(messageModel.x3dhHeader!['ephemeralKey'], isA<String>());

        // =====================================================================
        // STEP 6: MessageModel.toEntity() → Message with typed E2EE fields
        // =====================================================================
        final messageEntity = messageModel.toEntity();

        expect(messageEntity.isEncrypted, isTrue);
        expect(messageEntity.ciphertext, equals(ciphertext));
        expect(messageEntity.e2ee, isNotNull);
        expect(messageEntity.e2ee!.protocol, 'signal-v1');
        expect(messageEntity.e2ee!.messageNumber, 0);
        expect(messageEntity.e2ee!.dhPublicKey, isA<String>());
        expect(messageEntity.x3dhHeader, isNotNull);
        expect(messageEntity.x3dhHeader!.identityKey, isNotEmpty);
        expect(messageEntity.x3dhHeader!.ephemeralKey, isNotEmpty);
        expect(messageEntity.x3dhHeader!.oneTimePreKeyPublicKey,
            equals(x3dhHeader['oneTimePreKeyPublicKey']));

        // =====================================================================
        // STEP 7: _decryptIfNeeded — reconstruct the encryptedMap
        // =====================================================================
        final encryptedMap = reconstructEncryptedMap(
          messageEntity.ciphertext,
          messageEntity.e2ee,
          messageEntity.x3dhHeader,
        );

        // Verify the reconstructed map matches the original encrypt output
        expect(encryptedMap['ciphertext'], equals(ciphertext));
        final reconstructedE2ee =
            encryptedMap['e2ee'] as Map<String, dynamic>;
        expect(reconstructedE2ee['protocol'], equals(e2ee['protocol']));
        expect(
            reconstructedE2ee['messageNumber'], equals(e2ee['messageNumber']));
        expect(reconstructedE2ee['dhPublicKey'], equals(e2ee['dhPublicKey']));
        if (x3dhHeader != null) {
          final reconstructedX3dh =
              encryptedMap['x3dhHeader'] as Map<String, dynamic>;
          expect(reconstructedX3dh['identityKey'],
              equals(x3dhHeader['identityKey']));
          expect(reconstructedX3dh['ephemeralKey'],
              equals(x3dhHeader['ephemeralKey']));
          expect(reconstructedX3dh['oneTimePreKeyPublicKey'],
              equals(x3dhHeader['oneTimePreKeyPublicKey']));
        }

        // =====================================================================
        // STEP 8: Bob decrypts using the EXACT reconstructed map
        // =====================================================================
        final plaintext =
            await bob.service.decryptP2P(aliceId, encryptedMap);

        // =====================================================================
        // STEP 9: UI DISPLAYS THE CORRECT TEXT
        // =====================================================================
        expect(plaintext, equals(originalText));
      },
    );

    test(
      'Multiple messages: msg #0 with x3dh, msg #1 and #2 without — all decrypt',
      () async {
        await alice.service.establishSession(bobId);

        final messages = ['First message', 'Second message', 'Third message'];
        final encryptedList = <Map<String, dynamic>>[];

        for (final text in messages) {
          encryptedList.add(await alice.service.encryptP2P(bobId, text));
        }

        // Simulate Firestore round-trip for each message
        for (var i = 0; i < messages.length; i++) {
          final enc = encryptedList[i];
          final firestoreDoc = simulateCloudFunctionStore(
            messageId: 'msg_$i',
            senderId: aliceId,
            senderName: 'Alice',
            ciphertext: enc['ciphertext'] as String,
            e2ee: enc['e2ee'] as Map<String, dynamic>,
            x3dhHeader: enc['x3dhHeader'] as Map<String, dynamic>?,
          );

          final model = MessageModel.fromJson(firestoreDoc);
          final entity = model.toEntity();
          final encryptedMap = reconstructEncryptedMap(
            entity.ciphertext,
            entity.e2ee,
            entity.x3dhHeader,
          );

          final plaintext =
              await bob.service.decryptP2P(aliceId, encryptedMap);
          expect(plaintext, equals(messages[i]),
              reason: 'Message #$i should decrypt to "${messages[i]}"');
        }
      },
    );

    test('Unicode + emoji survives the full Firestore round-trip', () async {
      const original =
          'Hello! 🎉🚀 Привет 你好 مرحبا Special: <>&"\' Accents: éèêë';

      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, original);

      final firestoreDoc = simulateCloudFunctionStore(
        messageId: 'msg_unicode',
        senderId: aliceId,
        senderName: 'Alice',
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
      );

      final model = MessageModel.fromJson(firestoreDoc);
      final entity = model.toEntity();
      final encryptedMap = reconstructEncryptedMap(
        entity.ciphertext,
        entity.e2ee,
        entity.x3dhHeader,
      );

      final plaintext = await bob.service.decryptP2P(aliceId, encryptedMap);
      expect(plaintext, equals(original));
    });

    test(
      'Stale session recovery: Bob has old session → Alice re-establishes → Bob decrypts',
      () async {
        // FIRST EXCHANGE: Alice sends to Bob successfully
        await alice.service.establishSession(bobId);
        final enc1 = await alice.service.encryptP2P(bobId, 'Message 1');

        // Bob decrypts (creates receiver session)
        final firestoreDoc1 = simulateCloudFunctionStore(
          messageId: 'msg_1',
          senderId: aliceId,
          senderName: 'Alice',
          ciphertext: enc1['ciphertext'] as String,
          e2ee: enc1['e2ee'] as Map<String, dynamic>,
          x3dhHeader: enc1['x3dhHeader'] as Map<String, dynamic>?,
        );
        final model1 = MessageModel.fromJson(firestoreDoc1);
        final entity1 = model1.toEntity();
        final map1 = reconstructEncryptedMap(
            entity1.ciphertext, entity1.e2ee, entity1.x3dhHeader);
        final pt1 = await bob.service.decryptP2P(aliceId, map1);
        expect(pt1, equals('Message 1'));

        // Bob now has a non-initiator session with peerX3dhEphemeralKey set.

        // SIMULATE ALICE RESET: Alice's session is destroyed (app reinstall)
        await alice.service.resetSession(bobId);
        expect(await alice.service.hasSession(bobId), isFalse);

        // Alice re-establishes session (new ephemeral key, potentially new OTK)
        await alice.service.establishSession(bobId);
        final enc2 = await alice.service.encryptP2P(bobId, 'Message 2 (new session)');

        // The new x3dhHeader has a DIFFERENT ephemeral key
        final header2 = enc2['x3dhHeader'] as Map<String, dynamic>?;
        final header1 = enc1['x3dhHeader'] as Map<String, dynamic>?;
        expect(header2, isNotNull, reason: 'Re-established session must include x3dhHeader');
        expect(header2!['ephemeralKey'], isNot(equals(header1!['ephemeralKey'])),
            reason: 'New session should have different ephemeral key');

        // Bob receives the new message through Firestore
        final firestoreDoc2 = simulateCloudFunctionStore(
          messageId: 'msg_2',
          senderId: aliceId,
          senderName: 'Alice',
          ciphertext: enc2['ciphertext'] as String,
          e2ee: enc2['e2ee'] as Map<String, dynamic>,
          x3dhHeader: header2,
        );
        final model2 = MessageModel.fromJson(firestoreDoc2);
        final entity2 = model2.toEntity();
        final map2 = reconstructEncryptedMap(
            entity2.ciphertext, entity2.e2ee, entity2.x3dhHeader);

        // THIS IS THE CRITICAL TEST: Bob must re-do receiver X3DH because
        // the ephemeral key changed. Without the peerX3dhEphemeralKey fix,
        // this would fail with AES-GCM auth error.
        final pt2 = await bob.service.decryptP2P(aliceId, map2);
        expect(pt2, equals('Message 2 (new session)'));
      },
    );

    test(
      'No OTK scenario: sender and receiver skip DH4 consistently',
      () async {
        // Override Bob's bundle to have no OTKs (server ran out)
        when(() => alice.keyMgmt.fetchKeyBundle(bobId)).thenAnswer((_) async {
          return PublicKeyBundle(
            identityKey: bob.publicBundle.identityKey,
            signedPreKey: bob.publicBundle.signedPreKey,
            signedPreKeySignature: bob.publicBundle.signedPreKeySignature,
            oneTimePreKeys: [], // No OTKs available
            registrationId: bob.publicBundle.registrationId,
            userId: bobId,
            ed25519IdentityKey: bob.publicBundle.ed25519IdentityKey,
            ed25519Signature: bob.publicBundle.ed25519Signature,
          );
        });

        // Bob's local bundle also returns no OTKs for the match
        when(() => bob.keyMgmt.loadPrivateKeys()).thenAnswer((_) async {
          return KeyBundle(
            identityKeyPair: bob.privateBundle.identityKeyPair,
            signedPreKey: bob.privateBundle.signedPreKey,
            signedPreKeySignature: bob.privateBundle.signedPreKeySignature,
            oneTimePreKeys: [], // None to match
            registrationId: bob.privateBundle.registrationId,
            ed25519IdentityKeyPair: bob.privateBundle.ed25519IdentityKeyPair,
            ed25519Signature: bob.privateBundle.ed25519Signature,
          );
        });

        await alice.service.establishSession(bobId);
        final encrypted =
            await alice.service.encryptP2P(bobId, 'No OTK available');

        // x3dhHeader should NOT contain oneTimePreKeyPublicKey
        final header = encrypted['x3dhHeader'] as Map<String, dynamic>?;
        expect(header, isNotNull);
        expect(header!['oneTimePreKeyPublicKey'], isNull);

        // Full Firestore round-trip
        final firestoreDoc = simulateCloudFunctionStore(
          messageId: 'msg_no_otk',
          senderId: aliceId,
          senderName: 'Alice',
          ciphertext: encrypted['ciphertext'] as String,
          e2ee: encrypted['e2ee'] as Map<String, dynamic>,
          x3dhHeader: header,
        );
        final model = MessageModel.fromJson(firestoreDoc);
        final entity = model.toEntity();
        final encryptedMap = reconstructEncryptedMap(
          entity.ciphertext,
          entity.e2ee,
          entity.x3dhHeader,
        );

        final plaintext =
            await bob.service.decryptP2P(aliceId, encryptedMap);
        expect(plaintext, equals('No OTK available'));
      },
    );

    test('Large message (5KB) survives full pipeline', () async {
      final original = 'A' * 5000;
      await alice.service.establishSession(bobId);
      final encrypted = await alice.service.encryptP2P(bobId, original);

      final firestoreDoc = simulateCloudFunctionStore(
        messageId: 'msg_large',
        senderId: aliceId,
        senderName: 'Alice',
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
      );

      final model = MessageModel.fromJson(firestoreDoc);
      final entity = model.toEntity();
      final map = reconstructEncryptedMap(
          entity.ciphertext, entity.e2ee, entity.x3dhHeader);

      final plaintext = await bob.service.decryptP2P(aliceId, map);
      expect(plaintext, equals(original));
      expect(plaintext.length, equals(5000));
    });

    test(
      'Data integrity: every field survives encode → Firestore → parse → reconstruct',
      () async {
        await alice.service.establishSession(bobId);
        final encrypted = await alice.service.encryptP2P(bobId, 'integrity check');

        final originalCiphertext = encrypted['ciphertext'] as String;
        final originalE2ee = encrypted['e2ee'] as Map<String, dynamic>;
        final originalX3dh = encrypted['x3dhHeader'] as Map<String, dynamic>?;

        // Simulate the full pipeline
        final firestoreDoc = simulateCloudFunctionStore(
          messageId: 'msg_integrity',
          senderId: aliceId,
          senderName: 'Alice',
          ciphertext: originalCiphertext,
          e2ee: originalE2ee,
          x3dhHeader: originalX3dh,
        );
        final model = MessageModel.fromJson(firestoreDoc);
        final entity = model.toEntity();
        final reconstructed = reconstructEncryptedMap(
          entity.ciphertext,
          entity.e2ee,
          entity.x3dhHeader,
        );

        // Verify EVERY field survived the round-trip EXACTLY
        expect(reconstructed['ciphertext'], equals(originalCiphertext),
            reason: 'ciphertext must be identical');

        final recE2ee = reconstructed['e2ee'] as Map<String, dynamic>;
        expect(recE2ee['protocol'], equals(originalE2ee['protocol']),
            reason: 'e2ee.protocol');
        expect(recE2ee['messageNumber'], equals(originalE2ee['messageNumber']),
            reason: 'e2ee.messageNumber');
        expect(
            recE2ee['messageNumber'], isA<int>(), reason: 'messageNumber type');
        expect(recE2ee['dhPublicKey'], equals(originalE2ee['dhPublicKey']),
            reason: 'e2ee.dhPublicKey');

        final recX3dh = reconstructed['x3dhHeader'] as Map<String, dynamic>;
        expect(recX3dh['identityKey'], equals(originalX3dh!['identityKey']),
            reason: 'x3dhHeader.identityKey');
        expect(recX3dh['ephemeralKey'], equals(originalX3dh['ephemeralKey']),
            reason: 'x3dhHeader.ephemeralKey');
        expect(
          recX3dh['oneTimePreKeyPublicKey'],
          equals(originalX3dh['oneTimePreKeyPublicKey']),
          reason: 'x3dhHeader.oneTimePreKeyPublicKey',
        );

        // And the decryption must succeed
        final plaintext =
            await bob.service.decryptP2P(aliceId, reconstructed);
        expect(plaintext, equals('integrity check'));
      },
    );
  });

  // ===========================================================================
  // SESSION RECOVERY — simulates _decryptIfNeeded reset+retry mechanism
  // ===========================================================================
  group('Session recovery (reset + retry with x3dhHeader)', () {
    test(
      'Corrupted session (no peerX3dhEphemeralKey) fails decrypt — fixed bug: no longer auto-heals',
      () async {
        // STEP 1: Alice establishes session and encrypts a message
        await alice.service.establishSession(bobId);
        final encrypted =
            await alice.service.encryptP2P(bobId, 'Recovery test');

        // STEP 2: Corrupt Bob's session by writing garbage WITHOUT
        // peerX3dhEphemeralKey. This simulates old sessions from before
        // the fix — the most common production scenario.
        final sessionKey = 'e2ee_session_$aliceId';
        // Valid 32-byte base64 values (X25519 keys are 32 bytes) but WRONG keys
        await bob.storage.write(
          key: sessionKey,
          value: '{"rootKey":"AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8=",'
              '"sendChainKey":"AQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyA=",'
              '"recvChainKey":"AgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICE=",'
              '"dhSendPrivate":"AwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISI=",'
              '"dhSendPublic":"BAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiM=",'
              '"dhRecvPublic":"BQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQ=",'
              '"sendMessageNumber":0,"recvMessageNumber":0,"isInitiator":false,'
              '"skippedKeys":{},"previousChainLength":0}',
        );

        // STEP 3: Decrypt attempt — with the Phase 0 fix, a session with
        // peerX3dhEphemeralKey == null is NO LONGER auto-healed at the
        // signal protocol level (that auto-heal was the exact bug that
        // caused "Message cannot be decrypted" for all received messages).
        // Instead, the session keeps its wrong chain keys and decrypt fails.
        // Recovery happens at the REPOSITORY level via session reset + retry.
        final firestoreDoc = simulateCloudFunctionStore(
          messageId: 'msg_recovery',
          senderId: aliceId,
          senderName: 'Alice',
          ciphertext: encrypted['ciphertext'] as String,
          e2ee: encrypted['e2ee'] as Map<String, dynamic>,
          x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
        );
        final model = MessageModel.fromJson(firestoreDoc);
        final entity = model.toEntity();
        final encryptedMap = reconstructEncryptedMap(
          entity.ciphertext,
          entity.e2ee,
          entity.x3dhHeader,
        );

        // Decrypt throws because the corrupted session has wrong chain keys.
        // The one-time migration in Phase 0 resets all sessions on first launch
        // so this scenario shouldn't occur in practice after the migration runs.
        expect(
          () => bob.service.decryptP2P(aliceId, encryptedMap),
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      'Corrupted session WITH matching peerX3dhEphemeralKey → fails → reset+retry → succeeds',
      () async {
        // This tests the belt-and-suspenders recovery in _decryptIfNeeded:
        // when the signal protocol's auto-heal can't fix the session,
        // the repository resets and retries.

        // STEP 1: Alice establishes session and encrypts
        await alice.service.establishSession(bobId);
        final encrypted =
            await alice.service.encryptP2P(bobId, 'Deep recovery');

        // Get the ephemeral key Alice used
        final x3dh = encrypted['x3dhHeader'] as Map<String, dynamic>;
        final ephKey = x3dh['ephemeralKey'] as String;

        // STEP 2: Corrupt Bob's session but include the MATCHING
        // peerX3dhEphemeralKey. This bypasses the auto-heal guard.
        final sessionKey = 'e2ee_session_$aliceId';
        await bob.storage.write(
          key: sessionKey,
          value: '{"rootKey":"AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8=",'
              '"sendChainKey":"AQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyA=",'
              '"recvChainKey":"AgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICE=",'
              '"dhSendPrivate":"AwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISI=",'
              '"dhSendPublic":"BAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiM=",'
              '"dhRecvPublic":"BQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQ=",'
              '"sendMessageNumber":0,"recvMessageNumber":0,"isInitiator":false,'
              '"skippedKeys":{},"previousChainLength":0,'
              '"peerX3dhEphemeralKey":"$ephKey"}',
        );

        // STEP 3: Build encrypted map via Firestore round-trip
        final firestoreDoc = simulateCloudFunctionStore(
          messageId: 'msg_deep_recovery',
          senderId: aliceId,
          senderName: 'Alice',
          ciphertext: encrypted['ciphertext'] as String,
          e2ee: encrypted['e2ee'] as Map<String, dynamic>,
          x3dhHeader: x3dh,
        );
        final model = MessageModel.fromJson(firestoreDoc);
        final entity = model.toEntity();
        final encryptedMap = reconstructEncryptedMap(
          entity.ciphertext,
          entity.e2ee,
          entity.x3dhHeader,
        );

        // STEP 4: First attempt FAILS — peerX3dhEphemeralKey matches so
        // auto-heal is skipped, but the chain keys are garbage
        bool firstAttemptFailed = false;
        try {
          await bob.service.decryptP2P(aliceId, encryptedMap);
        } catch (e) {
          firstAttemptFailed = true;
        }
        expect(firstAttemptFailed, isTrue,
            reason: 'First attempt should fail with wrong chain keys');

        // STEP 5: Repository-level recovery (simulates _decryptIfNeeded):
        //   reset → retry → x3dhHeader triggers receiver X3DH
        await bob.service.resetSession(aliceId);
        final plaintext =
            await bob.service.decryptP2P(aliceId, encryptedMap);

        expect(plaintext, equals('Deep recovery'));
      },
    );

    test(
      'Session recovery works for multiple messages after corruption',
      () async {
        // Alice sends 3 messages
        await alice.service.establishSession(bobId);
        final messages = ['Msg A', 'Msg B', 'Msg C'];
        final encryptedList = <Map<String, dynamic>>[];
        for (final text in messages) {
          encryptedList.add(await alice.service.encryptP2P(bobId, text));
        }

        // Corrupt Bob's session
        final sessionKey = 'e2ee_session_$aliceId';
        await bob.storage.write(
          key: sessionKey,
          value: '{"rootKey":"AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8=",'
              '"sendChainKey":"AQIDBAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyA=",'
              '"recvChainKey":"AgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICE=",'
              '"dhSendPrivate":"AwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISI=",'
              '"dhSendPublic":"BAUGBwgJCgsMDQ4PEBESExQVFhcYGRobHB0eHyAhIiM=",'
              '"dhRecvPublic":"BQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQ=",'
              '"sendMessageNumber":5,"recvMessageNumber":5,"isInitiator":false,'
              '"skippedKeys":{},"previousChainLength":0}',
        );

        // Reset once (simulates the recovery mechanism)
        await bob.service.resetSession(aliceId);

        // Now decrypt all 3 messages — all should succeed because:
        // - Message 0 has x3dhHeader → does receiver X3DH → creates fresh session
        // - Messages 1 and 2 use the session from message 0 (skip forward chain)
        for (var i = 0; i < messages.length; i++) {
          final enc = encryptedList[i];
          final firestoreDoc = simulateCloudFunctionStore(
            messageId: 'msg_recovery_$i',
            senderId: aliceId,
            senderName: 'Alice',
            ciphertext: enc['ciphertext'] as String,
            e2ee: enc['e2ee'] as Map<String, dynamic>,
            x3dhHeader: enc['x3dhHeader'] as Map<String, dynamic>?,
          );
          final model = MessageModel.fromJson(firestoreDoc);
          final entity = model.toEntity();
          final encryptedMap = reconstructEncryptedMap(
            entity.ciphertext,
            entity.e2ee,
            entity.x3dhHeader,
          );

          final plaintext =
              await bob.service.decryptP2P(aliceId, encryptedMap);
          expect(plaintext, equals(messages[i]),
              reason: 'Message #$i should decrypt after recovery');
        }
      },
    );
  });
}
