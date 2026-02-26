import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/e2ee/ratchet/double_ratchet.dart';
import 'package:imalichat/core/e2ee/session/double_ratchet_session.dart';
import 'package:imalichat/core/services/crypto_service.dart';

/// Unit tests for DoubleRatchet — the pure cryptographic operations layer.
///
/// Tests cover performDhRatchetStep, skipRecvKeys, and bytesEqual directly,
/// independent of SignalProtocolService's X3DH session management.
void main() {
  late CryptoService crypto;
  late DoubleRatchet ratchet;

  setUp(() {
    crypto = CryptoService();
    ratchet = DoubleRatchet(crypto);
  });

  /// Create a session with real X25519 keys for testing.
  Future<DoubleRatchetSession> createTestSession({
    int sendMessageNumber = 0,
    int recvMessageNumber = 0,
    int previousChainLength = 0,
  }) async {
    final dhKp = await crypto.generateX25519KeyPair();
    return DoubleRatchetSession(
      rootKey: crypto.randomBytes(32),
      sendChainKey: crypto.randomBytes(32),
      recvChainKey: crypto.randomBytes(32),
      dhSendPrivate: dhKp['privateKey']!,
      dhSendPublic: dhKp['publicKey']!,
      dhRecvPublic: (await crypto.generateX25519KeyPair())['publicKey'],
      sendMessageNumber: sendMessageNumber,
      recvMessageNumber: recvMessageNumber,
      previousChainLength: previousChainLength,
    );
  }

  group('performDhRatchetStep', () {
    test('sets previousChainLength to current sendMessageNumber', () async {
      final session = await createTestSession(sendMessageNumber: 5);
      final newPeerKey =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.performDhRatchetStep(session, newPeerKey, 0);

      expect(session.previousChainLength, equals(5));
    });

    test('resets sendMessageNumber to 0', () async {
      final session = await createTestSession(sendMessageNumber: 7);
      final newPeerKey =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.performDhRatchetStep(session, newPeerKey, 0);

      expect(session.sendMessageNumber, equals(0));
    });

    test('resets recvMessageNumber to 0', () async {
      final session =
          await createTestSession(recvMessageNumber: 3);
      final newPeerKey =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.performDhRatchetStep(session, newPeerKey, 0);

      expect(session.recvMessageNumber, equals(0));
    });

    test('generates new DH send key pair', () async {
      final session = await createTestSession();
      final oldDhSendPublic = Uint8List.fromList(session.dhSendPublic);
      final newPeerKey =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.performDhRatchetStep(session, newPeerKey, 0);

      // New DH keys should differ from old ones
      expect(ratchet.bytesEqual(session.dhSendPublic, oldDhSendPublic),
          isFalse);
    });

    test('updates dhRecvPublic to peer key', () async {
      final session = await createTestSession();
      final newPeerKey =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.performDhRatchetStep(session, newPeerKey, 0);

      expect(ratchet.bytesEqual(session.dhRecvPublic!, newPeerKey), isTrue);
    });

    test('derives new root key and chain keys', () async {
      final session = await createTestSession();
      final oldRootKey = Uint8List.fromList(session.rootKey);
      final oldSendChainKey = Uint8List.fromList(session.sendChainKey);
      final oldRecvChainKey = Uint8List.fromList(session.recvChainKey);
      final newPeerKey =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.performDhRatchetStep(session, newPeerKey, 0);

      expect(ratchet.bytesEqual(session.rootKey, oldRootKey), isFalse);
      expect(
          ratchet.bytesEqual(session.sendChainKey, oldSendChainKey), isFalse);
      expect(
          ratchet.bytesEqual(session.recvChainKey, oldRecvChainKey), isFalse);
    });

    test('skips recv keys up to peerPreviousChainLength', () async {
      final session = await createTestSession(recvMessageNumber: 0);
      final newPeerKey =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      // Peer sent 3 messages on old chain, we haven't received any
      await ratchet.performDhRatchetStep(session, newPeerKey, 3);

      // Should have 3 skipped keys stored
      expect(session.skippedKeys.length, equals(3));
    });
  });

  group('skipRecvKeys', () {
    test('stores keys for skipped message numbers', () async {
      final session = await createTestSession(recvMessageNumber: 0);
      // Set a real dhRecvPublic for the lookup key
      session.dhRecvPublic =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.skipRecvKeys(session, 0, 3);

      expect(session.skippedKeys.length, equals(3));
      // Keys should be indexed by dhRecvPublic:messageNumber
      final dhPubB64 = base64Encode(session.dhRecvPublic!);
      expect(session.skippedKeys.containsKey('$dhPubB64:0'), isTrue);
      expect(session.skippedKeys.containsKey('$dhPubB64:1'), isTrue);
      expect(session.skippedKeys.containsKey('$dhPubB64:2'), isTrue);
    });

    test('does nothing when target equals current', () async {
      final session = await createTestSession();
      session.dhRecvPublic =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.skipRecvKeys(session, 5, 5);

      expect(session.skippedKeys.isEmpty, isTrue);
    });

    test('does nothing when target is behind current', () async {
      final session = await createTestSession();
      session.dhRecvPublic =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.skipRecvKeys(session, 5, 3);

      expect(session.skippedKeys.isEmpty, isTrue);
    });

    test('throws StateError when gap exceeds maxSkippedKeys', () async {
      final session = await createTestSession();
      session.dhRecvPublic =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      expect(
        () => ratchet.skipRecvKeys(session, 0, DoubleRatchet.maxSkippedKeys + 1),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('Too many skipped keys'),
        )),
      );
    });

    test('exactly maxSkippedKeys gap succeeds', () async {
      final session = await createTestSession();
      session.dhRecvPublic =
          (await crypto.generateX25519KeyPair())['publicKey']!;

      await ratchet.skipRecvKeys(session, 0, DoubleRatchet.maxSkippedKeys);

      expect(session.skippedKeys.length, equals(DoubleRatchet.maxSkippedKeys));
    });

    test('ratchets recvChainKey forward for each skipped key', () async {
      final session = await createTestSession();
      session.dhRecvPublic =
          (await crypto.generateX25519KeyPair())['publicKey']!;
      final originalRecvChainKey = Uint8List.fromList(session.recvChainKey);

      await ratchet.skipRecvKeys(session, 0, 3);

      // recvChainKey should have been ratcheted 3 times
      expect(
          ratchet.bytesEqual(session.recvChainKey, originalRecvChainKey),
          isFalse);
    });
  });

  group('bytesEqual', () {
    test('returns true for identical arrays', () {
      final a = Uint8List.fromList([1, 2, 3, 4, 5]);
      final b = Uint8List.fromList([1, 2, 3, 4, 5]);
      expect(ratchet.bytesEqual(a, b), isTrue);
    });

    test('returns false for different arrays', () {
      final a = Uint8List.fromList([1, 2, 3, 4, 5]);
      final b = Uint8List.fromList([1, 2, 3, 4, 6]);
      expect(ratchet.bytesEqual(a, b), isFalse);
    });

    test('returns false for different lengths', () {
      final a = Uint8List.fromList([1, 2, 3]);
      final b = Uint8List.fromList([1, 2, 3, 4]);
      expect(ratchet.bytesEqual(a, b), isFalse);
    });

    test('returns false for null', () {
      final a = Uint8List.fromList([1, 2, 3]);
      expect(ratchet.bytesEqual(a, null), isFalse);
    });

    test('returns true for empty arrays', () {
      expect(ratchet.bytesEqual(Uint8List(0), Uint8List(0)), isTrue);
    });
  });

  group('encrypt/decrypt roundtrip', () {
    test('decrypt recovers original plaintext', () async {
      final messageKey = crypto.randomBytes(32);
      final plaintext = 'Hello, World! 🌍';

      final encrypted = await ratchet.encrypt(plaintext, messageKey);
      final ciphertextB64 = base64Encode(encrypted);
      final decrypted = await ratchet.decrypt(ciphertextB64, messageKey);

      expect(decrypted, equals(plaintext));
    });

    test('different keys produce different ciphertext', () async {
      final key1 = crypto.randomBytes(32);
      final key2 = crypto.randomBytes(32);
      final plaintext = 'Same message';

      final ct1 = await ratchet.encrypt(plaintext, key1);
      final ct2 = await ratchet.encrypt(plaintext, key2);

      expect(ratchet.bytesEqual(ct1, ct2), isFalse);
    });

    test('decrypt with wrong key throws', () async {
      final correctKey = crypto.randomBytes(32);
      final wrongKey = crypto.randomBytes(32);
      final plaintext = 'Secret message';

      final encrypted = await ratchet.encrypt(plaintext, correctKey);
      final ciphertextB64 = base64Encode(encrypted);

      expect(
        () => ratchet.decrypt(ciphertextB64, wrongKey),
        throwsA(isA<Exception>()),
      );
    });

    test('decrypt rejects too-short ciphertext', () {
      final key = crypto.randomBytes(32);
      // Less than 28 bytes (12 nonce + 16 MAC minimum)
      final shortCiphertext = base64Encode(Uint8List(20));

      expect(
        () => ratchet.decrypt(shortCiphertext, key),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('ciphertext too short'),
        )),
      );
    });
  });

  group('kdfRk', () {
    test('produces 32-byte root key and 32-byte chain key', () async {
      final rootKey = crypto.randomBytes(32);
      final dhKp = await crypto.generateX25519KeyPair();
      final peerKp = await crypto.generateX25519KeyPair();

      final result = await ratchet.kdfRk(
        rootKey,
        dhKp['privateKey']!,
        peerKp['publicKey']!,
      );

      expect(result.rootKey.length, equals(32));
      expect(result.chainKey.length, equals(32));
    });

    test('different root keys produce different outputs', () async {
      final dhKp = await crypto.generateX25519KeyPair();
      final peerKp = await crypto.generateX25519KeyPair();

      final r1 = await ratchet.kdfRk(
        crypto.randomBytes(32),
        dhKp['privateKey']!,
        peerKp['publicKey']!,
      );
      final r2 = await ratchet.kdfRk(
        crypto.randomBytes(32),
        dhKp['privateKey']!,
        peerKp['publicKey']!,
      );

      expect(ratchet.bytesEqual(r1.rootKey, r2.rootKey), isFalse);
    });

    test('same inputs produce same outputs (deterministic)', () async {
      final rootKey = crypto.randomBytes(32);
      final dhKp = await crypto.generateX25519KeyPair();
      final peerKp = await crypto.generateX25519KeyPair();

      final r1 = await ratchet.kdfRk(
        rootKey,
        dhKp['privateKey']!,
        peerKp['publicKey']!,
      );
      final r2 = await ratchet.kdfRk(
        rootKey,
        dhKp['privateKey']!,
        peerKp['publicKey']!,
      );

      expect(ratchet.bytesEqual(r1.rootKey, r2.rootKey), isTrue);
      expect(ratchet.bytesEqual(r1.chainKey, r2.chainKey), isTrue);
    });
  });

  group('encrypt/decrypt with AAD', () {
    test('decrypt with matching AAD succeeds', () async {
      final messageKey = crypto.randomBytes(32);
      final aad = Uint8List.fromList([1, 2, 3, 4, 5]);
      final plaintext = 'Hello with AAD';

      final encrypted = await ratchet.encrypt(plaintext, messageKey, aad: aad);
      final ciphertextB64 = base64Encode(encrypted);
      final decrypted =
          await ratchet.decrypt(ciphertextB64, messageKey, aad: aad);

      expect(decrypted, equals(plaintext));
    });

    test('decrypt with wrong AAD throws', () async {
      final messageKey = crypto.randomBytes(32);
      final aad = Uint8List.fromList([1, 2, 3]);
      final wrongAad = Uint8List.fromList([4, 5, 6]);
      final plaintext = 'Secret with AAD';

      final encrypted = await ratchet.encrypt(plaintext, messageKey, aad: aad);
      final ciphertextB64 = base64Encode(encrypted);

      expect(
        () => ratchet.decrypt(ciphertextB64, messageKey, aad: wrongAad),
        throwsA(isA<Exception>()),
      );
    });

    test('decrypt with missing AAD fails when encrypted with AAD', () async {
      final messageKey = crypto.randomBytes(32);
      final aad = Uint8List.fromList([1, 2, 3]);
      final plaintext = 'AAD required';

      final encrypted = await ratchet.encrypt(plaintext, messageKey, aad: aad);
      final ciphertextB64 = base64Encode(encrypted);

      // No AAD passed to decrypt — should fail
      expect(
        () => ratchet.decrypt(ciphertextB64, messageKey),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('zeroize', () {
    test('overwrites bytes with zeros', () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      CryptoService.zeroize(data);
      expect(data, equals(Uint8List(5)));
    });
  });

  group('chain key derivation', () {
    test('deriveMessageKey produces 32-byte key', () async {
      final chainKey = crypto.randomBytes(32);
      final messageKey = await ratchet.deriveMessageKey(chainKey);
      expect(messageKey.length, equals(32));
    });

    test('ratchetChainKey produces 32-byte key', () async {
      final chainKey = crypto.randomBytes(32);
      final nextChainKey = await ratchet.ratchetChainKey(chainKey);
      expect(nextChainKey.length, equals(32));
    });

    test('deriveMessageKey and ratchetChainKey produce different outputs', () async {
      final chainKey = crypto.randomBytes(32);
      final messageKey = await ratchet.deriveMessageKey(chainKey);
      final nextChainKey = await ratchet.ratchetChainKey(chainKey);
      expect(ratchet.bytesEqual(messageKey, nextChainKey), isFalse);
    });

    test('same input produces same output (deterministic)', () async {
      final chainKey = crypto.randomBytes(32);
      final mk1 = await ratchet.deriveMessageKey(chainKey);
      final mk2 = await ratchet.deriveMessageKey(chainKey);
      expect(ratchet.bytesEqual(mk1, mk2), isTrue);
    });
  });
}
