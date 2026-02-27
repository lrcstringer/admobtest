import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/e2ee/protocol/kdf.dart';
import 'package:imalichat/core/services/crypto_service.dart';

void main() {
  late CryptoService cryptoService;
  late SignalKdf kdf;

  setUp(() {
    cryptoService = CryptoService();
    kdf = SignalKdf(cryptoService);
  });

  group('SignalKdf.hmacSha256', () {
    test('produces correct output for known input', () {
      // RFC 4231 Test Case 2
      final key = utf8.encode('Jefe');
      final data = utf8.encode('what do ya want for nothing?');
      final result = SignalKdf.hmacSha256(
        Uint8List.fromList(key),
        Uint8List.fromList(data),
      );
      expect(
        _hex(result),
        '5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843',
      );
    });

    test('single byte 0x01 produces deterministic output', () {
      final key = Uint8List(32); // all zeros
      final data = Uint8List.fromList([0x01]);
      final r1 = SignalKdf.hmacSha256(key, data);
      final r2 = SignalKdf.hmacSha256(key, data);
      expect(r1, equals(r2));
      expect(r1.length, 32);
    });

    test('0x01 and 0x02 inputs produce different outputs', () {
      final key = Uint8List(32);
      key.fillRange(0, 32, 0xAB);
      final mk = SignalKdf.hmacSha256(key, Uint8List.fromList([0x01]));
      final ck = SignalKdf.hmacSha256(key, Uint8List.fromList([0x02]));
      expect(mk, isNot(equals(ck)));
    });
  });

  group('SignalKdf.kdfCkMessageKey', () {
    test('is HMAC-SHA256(CK, 0x01)', () {
      final chainKey = Uint8List(32);
      chainKey.fillRange(0, 32, 0x42);

      final result = kdf.kdfCkMessageKey(chainKey);

      // Verify against direct HMAC computation
      final expected = crypto.Hmac(crypto.sha256, chainKey).convert([0x01]);
      expect(result, equals(Uint8List.fromList(expected.bytes)));
    });

    test('returns 32 bytes', () {
      final chainKey = Uint8List(32);
      expect(kdf.kdfCkMessageKey(chainKey).length, 32);
    });
  });

  group('SignalKdf.kdfCkNextChainKey', () {
    test('is HMAC-SHA256(CK, 0x02)', () {
      final chainKey = Uint8List(32);
      chainKey.fillRange(0, 32, 0x42);

      final result = kdf.kdfCkNextChainKey(chainKey);

      final expected = crypto.Hmac(crypto.sha256, chainKey).convert([0x02]);
      expect(result, equals(Uint8List.fromList(expected.bytes)));
    });

    test('message key != next chain key (different HMAC inputs)', () {
      final chainKey = Uint8List(32);
      chainKey.fillRange(0, 32, 0x99);
      final mk = kdf.kdfCkMessageKey(chainKey);
      final ck = kdf.kdfCkNextChainKey(chainKey);
      expect(mk, isNot(equals(ck)));
    });

    test('chain ratchet is deterministic', () {
      final ck0 = Uint8List(32);
      ck0.fillRange(0, 32, 0x11);

      final ck1 = kdf.kdfCkNextChainKey(ck0);
      final ck2 = kdf.kdfCkNextChainKey(ck1);
      final ck3 = kdf.kdfCkNextChainKey(ck2);

      // Re-derive from ck0 and verify same sequence
      expect(kdf.kdfCkNextChainKey(ck0), equals(ck1));
      expect(kdf.kdfCkNextChainKey(ck1), equals(ck2));
      expect(kdf.kdfCkNextChainKey(ck2), equals(ck3));

      // All chain keys are unique
      expect({_hex(ck0), _hex(ck1), _hex(ck2), _hex(ck3)}.length, 4);
    });
  });

  group('SignalKdf.kdfX3dh', () {
    test('prepends 0xFF*32 to master secret', () async {
      final masterSecret = Uint8List(96); // 3 DH outputs
      masterSecret.fillRange(0, 96, 0xAA);

      final sk = await kdf.kdfX3dh(masterSecret);
      expect(sk.length, 32);

      // Manually compute expected: HKDF(salt=0*32, ikm=FF*32||masterSecret, info="iMaliChat", len=32)
      final expectedIkm = Uint8List(32 + 96);
      expectedIkm.fillRange(0, 32, 0xFF);
      expectedIkm.setAll(32, masterSecret);

      final expected = await cryptoService.hkdf(
        inputKeyMaterial: expectedIkm,
        length: 32,
        salt: Uint8List(32),
        info: Uint8List.fromList(utf8.encode('iMaliChat')),
      );
      expect(sk, equals(expected));
    });

    test('different master secrets produce different SKs', () async {
      final ms1 = Uint8List(96);
      ms1.fillRange(0, 96, 0x01);
      final ms2 = Uint8List(96);
      ms2.fillRange(0, 96, 0x02);

      final sk1 = await kdf.kdfX3dh(ms1);
      final sk2 = await kdf.kdfX3dh(ms2);
      expect(sk1, isNot(equals(sk2)));
    });

    test('handles 4 DH outputs (128 bytes with OTK)', () async {
      final masterSecret = Uint8List(128); // 4 × 32 bytes
      masterSecret.fillRange(0, 128, 0xBB);

      final sk = await kdf.kdfX3dh(masterSecret);
      expect(sk.length, 32);
    });

    test('handles 3 DH outputs (96 bytes without OTK)', () async {
      final masterSecret = Uint8List(96); // 3 × 32 bytes
      masterSecret.fillRange(0, 96, 0xCC);

      final sk = await kdf.kdfX3dh(masterSecret);
      expect(sk.length, 32);
    });

    test('0xFF prefix is the critical differentiator from old impl', () async {
      // Per RFC 5869 §2.2, empty salt == HashLen zeros, so salt was NOT
      // the old bug. The REAL difference is the 0xFF prefix and info string.
      final masterSecret = Uint8List(96);
      masterSecret.fillRange(0, 96, 0xDD);

      final correctSk = await kdf.kdfX3dh(masterSecret);

      // Compute WITHOUT 0xFF prefix (old bug) — should differ
      final wrongSk = await cryptoService.hkdf(
        inputKeyMaterial: masterSecret, // no 0xFF prefix
        length: 32,
        salt: Uint8List(32),
        info: Uint8List.fromList(utf8.encode('iMaliChat')),
      );

      expect(correctSk, isNot(equals(wrongSk)));
    });
  });

  group('SignalKdf.kdfRk', () {
    test('produces 32-byte root key and 32-byte chain key', () async {
      final rootKey = Uint8List(32);
      rootKey.fillRange(0, 32, 0x11);
      final dhOutput = Uint8List(32);
      dhOutput.fillRange(0, 32, 0x22);

      final result = await kdf.kdfRk(rootKey, dhOutput);
      expect(result.rootKey.length, 32);
      expect(result.chainKey.length, 32);
    });

    test('root key != chain key', () async {
      final rootKey = Uint8List(32);
      rootKey.fillRange(0, 32, 0x33);
      final dhOutput = Uint8List(32);
      dhOutput.fillRange(0, 32, 0x44);

      final result = await kdf.kdfRk(rootKey, dhOutput);
      expect(result.rootKey, isNot(equals(result.chainKey)));
    });

    test('uses root key as HKDF salt (per spec)', () async {
      final rootKey = Uint8List(32);
      rootKey.fillRange(0, 32, 0x55);
      final dhOutput = Uint8List(32);
      dhOutput.fillRange(0, 32, 0x66);

      final result = await kdf.kdfRk(rootKey, dhOutput);

      // Verify against direct HKDF with rootKey as salt
      final expected = await cryptoService.hkdf(
        inputKeyMaterial: dhOutput,
        length: 64,
        salt: rootKey,
        info: Uint8List.fromList(utf8.encode('iMaliChatRatchet')),
      );
      expect(result.rootKey, equals(expected.sublist(0, 32)));
      expect(result.chainKey, equals(expected.sublist(32, 64)));
    });

    test('is deterministic', () async {
      final rootKey = Uint8List(32);
      rootKey.fillRange(0, 32, 0x77);
      final dhOutput = Uint8List(32);
      dhOutput.fillRange(0, 32, 0x88);

      final r1 = await kdf.kdfRk(rootKey, dhOutput);
      final r2 = await kdf.kdfRk(rootKey, dhOutput);
      expect(r1.rootKey, equals(r2.rootKey));
      expect(r1.chainKey, equals(r2.chainKey));
    });

    test('different inputs produce different outputs', () async {
      final rk = Uint8List(32);
      rk.fillRange(0, 32, 0xAA);
      final dh1 = Uint8List(32);
      dh1.fillRange(0, 32, 0xBB);
      final dh2 = Uint8List(32);
      dh2.fillRange(0, 32, 0xCC);

      final r1 = await kdf.kdfRk(rk, dh1);
      final r2 = await kdf.kdfRk(rk, dh2);
      expect(r1.rootKey, isNot(equals(r2.rootKey)));
      expect(r1.chainKey, isNot(equals(r2.chainKey)));
    });
  });

  group('SignalKdf.deriveMessageEncryptionKeys', () {
    test('produces 32-byte key and 12-byte nonce', () async {
      final messageKey = Uint8List(32);
      messageKey.fillRange(0, 32, 0xEE);

      final result = await kdf.deriveMessageEncryptionKeys(messageKey);
      expect(result.encKey.length, 32);
      expect(result.nonce.length, 12);
    });

    test('key and nonce are deterministic', () async {
      final mk = Uint8List(32);
      mk.fillRange(0, 32, 0xFF);

      final r1 = await kdf.deriveMessageEncryptionKeys(mk);
      final r2 = await kdf.deriveMessageEncryptionKeys(mk);
      expect(r1.encKey, equals(r2.encKey));
      expect(r1.nonce, equals(r2.nonce));
    });

    test('different message keys produce different encryption keys', () async {
      final mk1 = Uint8List(32);
      mk1.fillRange(0, 32, 0x01);
      final mk2 = Uint8List(32);
      mk2.fillRange(0, 32, 0x02);

      final r1 = await kdf.deriveMessageEncryptionKeys(mk1);
      final r2 = await kdf.deriveMessageEncryptionKeys(mk2);
      expect(r1.encKey, isNot(equals(r2.encKey)));
      expect(r1.nonce, isNot(equals(r2.nonce)));
    });

    test('uses zero salt and iMaliChatMsg info', () async {
      final mk = Uint8List(32);
      mk.fillRange(0, 32, 0xAB);

      final result = await kdf.deriveMessageEncryptionKeys(mk);

      // Verify against direct HKDF
      final expected = await cryptoService.hkdf(
        inputKeyMaterial: mk,
        length: 44,
        salt: Uint8List(32),
        info: Uint8List.fromList(utf8.encode('iMaliChatMsg')),
      );
      expect(result.encKey, equals(expected.sublist(0, 32)));
      expect(result.nonce, equals(expected.sublist(32, 44)));
    });
  });

  group('Chain ratchet integration', () {
    test('full chain produces unique keys for each message', () {
      final ck0 = Uint8List(32);
      ck0.fillRange(0, 32, 0x42);

      final messageKeys = <String>{};
      var currentCk = ck0;

      for (var i = 0; i < 100; i++) {
        final mk = kdf.kdfCkMessageKey(currentCk);
        final hexMk = _hex(mk);
        expect(messageKeys.contains(hexMk), isFalse,
            reason: 'Message key $i collided with a previous key');
        messageKeys.add(hexMk);
        currentCk = kdf.kdfCkNextChainKey(currentCk);
      }

      expect(messageKeys.length, 100);
    });

    test('chain key advancement is one-way (cannot derive earlier keys)', () {
      final ck0 = Uint8List(32);
      ck0.fillRange(0, 32, 0x42);

      final ck1 = kdf.kdfCkNextChainKey(ck0);
      final mk0 = kdf.kdfCkMessageKey(ck0);

      // From ck1, there is no way to derive ck0 or mk0
      // We can only verify this indirectly: ck1 doesn't trivially relate to ck0
      expect(ck1, isNot(equals(ck0)));
      expect(kdf.kdfCkMessageKey(ck1), isNot(equals(mk0)));
    });
  });
}

String _hex(Uint8List bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
