import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/e2ee/protocol/kdf.dart';
import 'package:imalichat/core/e2ee/protocol/sender_key.dart';
import 'package:imalichat/core/services/crypto_service.dart';

void main() {
  late CryptoService crypto;
  late SignalKdf kdf;
  late SenderKeyRatchet ratchet;

  setUp(() {
    crypto = CryptoService();
    kdf = SignalKdf(crypto);
    ratchet = SenderKeyRatchet(crypto, kdf);
  });

  // ===========================================================================
  // ratchetStep
  // ===========================================================================
  group('SenderKeyRatchet.ratchetStep', () {
    test('produces 32-byte messageKey and nextChainKey', () {
      final chainKey = crypto.generateAesKey();
      final step = ratchet.ratchetStep(chainKey);

      expect(step.messageKey.length, equals(32));
      expect(step.nextChainKey.length, equals(32));
    });

    test('messageKey and nextChainKey are different', () {
      final chainKey = crypto.generateAesKey();
      final step = ratchet.ratchetStep(chainKey);

      expect(step.messageKey, isNot(equals(step.nextChainKey)));
    });

    test('is deterministic: same input produces same output', () {
      final chainKey = crypto.generateAesKey();
      final step1 = ratchet.ratchetStep(chainKey);
      final step2 = ratchet.ratchetStep(chainKey);

      expect(step1.messageKey, equals(step2.messageKey));
      expect(step1.nextChainKey, equals(step2.nextChainKey));
    });

    test('different chain keys produce different outputs', () {
      final ck1 = crypto.generateAesKey();
      final ck2 = crypto.generateAesKey();
      final step1 = ratchet.ratchetStep(ck1);
      final step2 = ratchet.ratchetStep(ck2);

      expect(step1.messageKey, isNot(equals(step2.messageKey)));
      expect(step1.nextChainKey, isNot(equals(step2.nextChainKey)));
    });

    test('uses HMAC-SHA256 with 0x01 for messageKey (matches kdfCkMessageKey)',
        () {
      final chainKey = crypto.generateAesKey();
      final step = ratchet.ratchetStep(chainKey);
      final directMk = kdf.kdfCkMessageKey(chainKey);

      expect(step.messageKey, equals(directMk));
    });

    test('uses HMAC-SHA256 with 0x02 for nextChainKey (matches kdfCkNextChainKey)',
        () {
      final chainKey = crypto.generateAesKey();
      final step = ratchet.ratchetStep(chainKey);
      final directCk = kdf.kdfCkNextChainKey(chainKey);

      expect(step.nextChainKey, equals(directCk));
    });

    test('chain ratchet produces unique keys at each step', () {
      var chainKey = crypto.generateAesKey();
      final messageKeys = <String>[];

      for (var i = 0; i < 10; i++) {
        final step = ratchet.ratchetStep(chainKey);
        messageKeys.add(base64Encode(step.messageKey));
        chainKey = step.nextChainKey;
      }

      // All message keys should be unique
      expect(messageKeys.toSet().length, equals(10));
    });
  });

  // ===========================================================================
  // encrypt / decrypt
  // ===========================================================================
  group('SenderKeyRatchet.encrypt / decrypt', () {
    test('basic roundtrip', () async {
      final messageKey = crypto.generateAesKey();
      final aad = Uint8List.fromList(utf8.encode('test-aad'));
      final plaintext = Uint8List.fromList(utf8.encode('Hello Sender Key!'));

      final ciphertext = await ratchet.encrypt(plaintext, messageKey, aad);
      final decrypted = await ratchet.decrypt(ciphertext, messageKey, aad);

      expect(utf8.decode(decrypted), equals('Hello Sender Key!'));
    });

    test('ciphertext does not contain nonce prefix (stripped)', () async {
      final messageKey = crypto.generateAesKey();
      final aad = Uint8List.fromList(utf8.encode('aad'));
      final plaintext = Uint8List.fromList(utf8.encode('test'));

      final ciphertext = await ratchet.encrypt(plaintext, messageKey, aad);

      // ct||mac(16) should be plaintext.length + 16 for GCM tag
      // (exact length depends on AES-GCM implementation)
      expect(ciphertext.length, equals(plaintext.length + 16));
    });

    test('wrong AAD fails decryption', () async {
      final messageKey = crypto.generateAesKey();
      final aad1 = Uint8List.fromList(utf8.encode('correct-aad'));
      final aad2 = Uint8List.fromList(utf8.encode('wrong-aad'));
      final plaintext = Uint8List.fromList(utf8.encode('secret'));

      final ciphertext = await ratchet.encrypt(plaintext, messageKey, aad1);

      expect(
        () => ratchet.decrypt(ciphertext, messageKey, aad2),
        throwsA(anything),
      );
    });

    test('wrong message key fails decryption', () async {
      final mk1 = crypto.generateAesKey();
      final mk2 = crypto.generateAesKey();
      final aad = Uint8List.fromList(utf8.encode('aad'));
      final plaintext = Uint8List.fromList(utf8.encode('secret'));

      final ciphertext = await ratchet.encrypt(plaintext, mk1, aad);

      expect(
        () => ratchet.decrypt(ciphertext, mk2, aad),
        throwsA(anything),
      );
    });

    test('empty plaintext roundtrip', () async {
      final messageKey = crypto.generateAesKey();
      final aad = Uint8List.fromList(utf8.encode('aad'));
      final plaintext = Uint8List(0);

      final ciphertext = await ratchet.encrypt(plaintext, messageKey, aad);
      final decrypted = await ratchet.decrypt(ciphertext, messageKey, aad);

      expect(decrypted.length, equals(0));
    });

    test('deterministic: same inputs produce same ciphertext', () async {
      final messageKey = crypto.generateAesKey();
      final aad = Uint8List.fromList(utf8.encode('aad'));
      final plaintext = Uint8List.fromList(utf8.encode('deterministic'));

      final ct1 = await ratchet.encrypt(plaintext, messageKey, aad);
      final ct2 = await ratchet.encrypt(plaintext, messageKey, aad);

      // Nonce is derived deterministically from message key, so
      // ciphertext should be identical
      expect(ct1, equals(ct2));
    });
  });

  // ===========================================================================
  // Integration: chain ratchet + encrypt/decrypt
  // ===========================================================================
  group('chain ratchet integration', () {
    test('sender and receiver derive same keys from same chain', () async {
      final initialChainKey = crypto.generateAesKey();
      final aad = Uint8List.fromList(utf8.encode('comm|chain|0'));

      // Sender ratchets and encrypts
      final senderStep = ratchet.ratchetStep(initialChainKey);
      final plaintext = Uint8List.fromList(utf8.encode('group message'));
      final ciphertext =
          await ratchet.encrypt(plaintext, senderStep.messageKey, aad);

      // Receiver derives same message key from same chain key
      final receiverStep = ratchet.ratchetStep(initialChainKey);
      final decrypted =
          await ratchet.decrypt(ciphertext, receiverStep.messageKey, aad);

      expect(utf8.decode(decrypted), equals('group message'));
      expect(senderStep.nextChainKey, equals(receiverStep.nextChainKey));
    });

    test('multi-step chain: 5 messages in sequence', () async {
      final initialChainKey = crypto.generateAesKey();

      // Sender encrypts 5 messages
      var senderChainKey = initialChainKey;
      final ciphertexts = <Uint8List>[];
      for (var i = 0; i < 5; i++) {
        final step = ratchet.ratchetStep(senderChainKey);
        final aad = Uint8List.fromList(utf8.encode('comm|chain|$i'));
        final ct = await ratchet.encrypt(
          Uint8List.fromList(utf8.encode('msg $i')),
          step.messageKey,
          aad,
        );
        ciphertexts.add(ct);
        senderChainKey = step.nextChainKey;
      }

      // Receiver decrypts all 5 in order
      var receiverChainKey = initialChainKey;
      for (var i = 0; i < 5; i++) {
        final step = ratchet.ratchetStep(receiverChainKey);
        final aad = Uint8List.fromList(utf8.encode('comm|chain|$i'));
        final pt = await ratchet.decrypt(ciphertexts[i], step.messageKey, aad);
        expect(utf8.decode(pt), equals('msg $i'));
        receiverChainKey = step.nextChainKey;
      }

      // Both sides should have the same chain key after 5 steps
      expect(senderChainKey, equals(receiverChainKey));
    });
  });
}
