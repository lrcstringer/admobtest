import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/crypto_service.dart';

void main() {
  late CryptoService cryptoService;

  setUp(() {
    cryptoService = CryptoService();
  });

  group('CryptoService', () {
    // ==================== randomBytes ====================
    group('randomBytes', () {
      test('returns correct length for various sizes', () {
        expect(cryptoService.randomBytes(1).length, 1);
        expect(cryptoService.randomBytes(16).length, 16);
        expect(cryptoService.randomBytes(32).length, 32);
        expect(cryptoService.randomBytes(64).length, 64);
      });

      test('returns different bytes on each call (non-deterministic)', () {
        final a = cryptoService.randomBytes(32);
        final b = cryptoService.randomBytes(32);
        // Probability of collision is ~1/2^256, effectively zero
        expect(a, isNot(equals(b)));
      });

      test('returns empty list for length 0', () {
        expect(cryptoService.randomBytes(0).length, 0);
      });
    });

    // ==================== generateAesKey ====================
    group('generateAesKey', () {
      test('returns exactly 32 bytes (256-bit)', () {
        expect(cryptoService.generateAesKey().length, 32);
      });

      test('returns different key each call', () {
        final a = cryptoService.generateAesKey();
        final b = cryptoService.generateAesKey();
        expect(a, isNot(equals(b)));
      });
    });

    // ==================== encrypt / decrypt ====================
    group('encrypt and decrypt', () {
      test('roundtrip: encrypt then decrypt returns original plaintext',
          () async {
        final key = cryptoService.generateAesKey();
        final plaintext = Uint8List.fromList(utf8.encode('Hello, E2EE!'));

        final encrypted = await cryptoService.encrypt(plaintext, key);

        // Extract nonce from first 12 bytes
        final nonce = encrypted.sublist(0, 12);
        final ciphertextWithMac = encrypted.sublist(12);

        final decrypted = await cryptoService.decrypt(
          ciphertextWithMac,
          key,
          nonce: nonce,
        );

        expect(decrypted, equals(plaintext));
        expect(utf8.decode(decrypted), 'Hello, E2EE!');
      });

      test('encrypt with explicit nonce produces deterministic nonce prefix',
          () async {
        final key = cryptoService.generateAesKey();
        final nonce = Uint8List.fromList(List.generate(12, (i) => i));
        final plaintext = Uint8List.fromList(utf8.encode('test'));

        final encrypted =
            await cryptoService.encrypt(plaintext, key, nonce: nonce);

        // First 12 bytes should match our nonce
        expect(encrypted.sublist(0, 12), equals(nonce));
      });

      test('encrypt with null nonce auto-generates 12-byte nonce', () async {
        final key = cryptoService.generateAesKey();
        final plaintext = Uint8List.fromList(utf8.encode('test'));

        final encrypted = await cryptoService.encrypt(plaintext, key);

        // Output length should be: 12 (nonce) + plaintext.length (ct) + 16 (mac)
        expect(encrypted.length, greaterThanOrEqualTo(12 + 16));
      });

      test(
          'output format is nonce(12) || ciphertext || mac(16) with correct total length',
          () async {
        final key = cryptoService.generateAesKey();
        final plaintext = Uint8List.fromList(List.generate(20, (i) => i));

        final encrypted = await cryptoService.encrypt(plaintext, key);

        // AES-GCM output: nonce(12) + ciphertext(same as plaintext length) + mac(16)
        expect(encrypted.length, 12 + plaintext.length + 16);
      });

      test('decrypt with wrong key throws', () async {
        final key1 = cryptoService.generateAesKey();
        final key2 = cryptoService.generateAesKey();
        final plaintext = Uint8List.fromList(utf8.encode('secret'));

        final encrypted = await cryptoService.encrypt(plaintext, key1);
        final nonce = encrypted.sublist(0, 12);
        final ct = encrypted.sublist(12);

        expect(
          () => cryptoService.decrypt(ct, key2, nonce: nonce),
          throwsA(anything),
        );
      });

      test('decrypt with tampered ciphertext throws (integrity check)',
          () async {
        final key = cryptoService.generateAesKey();
        final plaintext = Uint8List.fromList(utf8.encode('secret'));

        final encrypted = await cryptoService.encrypt(plaintext, key);
        final nonce = encrypted.sublist(0, 12);
        final ct = Uint8List.fromList(encrypted.sublist(12));
        // Flip a byte in the ciphertext
        ct[0] = ct[0] ^ 0xFF;

        expect(
          () => cryptoService.decrypt(ct, key, nonce: nonce),
          throwsA(anything),
        );
      });

      test('decrypt with wrong nonce throws', () async {
        final key = cryptoService.generateAesKey();
        final plaintext = Uint8List.fromList(utf8.encode('secret'));

        final encrypted = await cryptoService.encrypt(plaintext, key);
        final wrongNonce = Uint8List.fromList(List.generate(12, (i) => 255));
        final ct = encrypted.sublist(12);

        expect(
          () => cryptoService.decrypt(ct, key, nonce: wrongNonce),
          throwsA(anything),
        );
      });

      test('encrypt empty plaintext works', () async {
        final key = cryptoService.generateAesKey();
        final plaintext = Uint8List(0);

        final encrypted = await cryptoService.encrypt(plaintext, key);
        final nonce = encrypted.sublist(0, 12);
        final ct = encrypted.sublist(12);

        final decrypted = await cryptoService.decrypt(ct, key, nonce: nonce);
        expect(decrypted, equals(plaintext));
      });

      test('encrypt large plaintext (10KB) works', () async {
        final key = cryptoService.generateAesKey();
        final plaintext =
            Uint8List.fromList(List.generate(10240, (i) => i % 256));

        final encrypted = await cryptoService.encrypt(plaintext, key);
        final nonce = encrypted.sublist(0, 12);
        final ct = encrypted.sublist(12);

        final decrypted = await cryptoService.decrypt(ct, key, nonce: nonce);
        expect(decrypted, equals(plaintext));
      });

      test('same plaintext produces different ciphertext each time', () async {
        final key = cryptoService.generateAesKey();
        final plaintext = Uint8List.fromList(utf8.encode('same message'));

        final encrypted1 = await cryptoService.encrypt(plaintext, key);
        final encrypted2 = await cryptoService.encrypt(plaintext, key);

        // Different nonces mean different output
        expect(encrypted1, isNot(equals(encrypted2)));
      });
    });

    // ==================== generateX25519KeyPair ====================
    group('generateX25519KeyPair', () {
      test('returns map with privateKey and publicKey', () async {
        final kp = await cryptoService.generateX25519KeyPair();
        expect(kp.containsKey('privateKey'), isTrue);
        expect(kp.containsKey('publicKey'), isTrue);
      });

      test('private key is 32 bytes', () async {
        final kp = await cryptoService.generateX25519KeyPair();
        expect(kp['privateKey']!.length, 32);
      });

      test('public key is 32 bytes', () async {
        final kp = await cryptoService.generateX25519KeyPair();
        expect(kp['publicKey']!.length, 32);
      });

      test('two generated pairs are different', () async {
        final kp1 = await cryptoService.generateX25519KeyPair();
        final kp2 = await cryptoService.generateX25519KeyPair();
        expect(kp1['privateKey'], isNot(equals(kp2['privateKey'])));
        expect(kp1['publicKey'], isNot(equals(kp2['publicKey'])));
      });
    });

    // ==================== diffieHellman ====================
    group('diffieHellman', () {
      test(
          'shared secret from (A_priv, B_pub) equals (B_priv, A_pub) — commutativity',
          () async {
        final alice = await cryptoService.generateX25519KeyPair();
        final bob = await cryptoService.generateX25519KeyPair();

        final secretAB = await cryptoService.diffieHellman(
          alice['privateKey']!,
          bob['publicKey']!,
        );
        final secretBA = await cryptoService.diffieHellman(
          bob['privateKey']!,
          alice['publicKey']!,
        );

        expect(secretAB, equals(secretBA));
      });

      test('shared secret is 32 bytes', () async {
        final alice = await cryptoService.generateX25519KeyPair();
        final bob = await cryptoService.generateX25519KeyPair();

        final secret = await cryptoService.diffieHellman(
          alice['privateKey']!,
          bob['publicKey']!,
        );

        expect(secret.length, 32);
      });

      test('different key pairs produce different shared secrets', () async {
        final alice = await cryptoService.generateX25519KeyPair();
        final bob = await cryptoService.generateX25519KeyPair();
        final charlie = await cryptoService.generateX25519KeyPair();

        final secretAB = await cryptoService.diffieHellman(
          alice['privateKey']!,
          bob['publicKey']!,
        );
        final secretAC = await cryptoService.diffieHellman(
          alice['privateKey']!,
          charlie['publicKey']!,
        );

        expect(secretAB, isNot(equals(secretAC)));
      });
    });

    // ==================== hkdf ====================
    group('hkdf', () {
      test('derives correct length output', () async {
        final ikm = cryptoService.randomBytes(32);
        final result = await cryptoService.hkdf(
          inputKeyMaterial: ikm,
          length: 64,
        );
        expect(result.length, 64);
      });

      test('same input produces same output (deterministic)', () async {
        final ikm = Uint8List.fromList(List.generate(32, (i) => i));
        final salt = Uint8List.fromList(List.generate(16, (i) => i));
        final info = Uint8List.fromList(utf8.encode('test'));

        final a = await cryptoService.hkdf(
          inputKeyMaterial: ikm,
          length: 32,
          salt: salt,
          info: info,
        );
        final b = await cryptoService.hkdf(
          inputKeyMaterial: ikm,
          length: 32,
          salt: salt,
          info: info,
        );

        expect(a, equals(b));
      });

      test('different salt produces different output', () async {
        final ikm = Uint8List.fromList(List.generate(32, (i) => i));
        final salt1 = Uint8List.fromList(List.generate(16, (i) => i));
        final salt2 = Uint8List.fromList(List.generate(16, (i) => i + 100));

        final a = await cryptoService.hkdf(
          inputKeyMaterial: ikm,
          length: 32,
          salt: salt1,
        );
        final b = await cryptoService.hkdf(
          inputKeyMaterial: ikm,
          length: 32,
          salt: salt2,
        );

        expect(a, isNot(equals(b)));
      });

      test('different info produces different output', () async {
        final ikm = Uint8List.fromList(List.generate(32, (i) => i));
        final info1 = Uint8List.fromList(utf8.encode('info-a'));
        final info2 = Uint8List.fromList(utf8.encode('info-b'));

        final a = await cryptoService.hkdf(
          inputKeyMaterial: ikm,
          length: 32,
          info: info1,
        );
        final b = await cryptoService.hkdf(
          inputKeyMaterial: ikm,
          length: 32,
          info: info2,
        );

        expect(a, isNot(equals(b)));
      });
    });

    // ==================== pbkdf2 ====================
    group('pbkdf2', () {
      test('derives correct length key', () async {
        final salt = cryptoService.randomBytes(16);
        final result = await cryptoService.pbkdf2(
          passphrase: 'my-passphrase',
          salt: salt,
          iterations: 1000, // low count for test speed
          keyLength: 32,
        );
        expect(result.length, 32);
      });

      test('same passphrase + salt + iterations produces same key', () async {
        final salt = Uint8List.fromList(List.generate(16, (i) => i));

        final a = await cryptoService.pbkdf2(
          passphrase: 'passphrase',
          salt: salt,
          iterations: 1000,
        );
        final b = await cryptoService.pbkdf2(
          passphrase: 'passphrase',
          salt: salt,
          iterations: 1000,
        );

        expect(a, equals(b));
      });

      test('different passphrase produces different key', () async {
        final salt = Uint8List.fromList(List.generate(16, (i) => i));

        final a = await cryptoService.pbkdf2(
          passphrase: 'passphrase-1',
          salt: salt,
          iterations: 1000,
        );
        final b = await cryptoService.pbkdf2(
          passphrase: 'passphrase-2',
          salt: salt,
          iterations: 1000,
        );

        expect(a, isNot(equals(b)));
      });

      test('different iteration count produces different key', () async {
        final salt = Uint8List.fromList(List.generate(16, (i) => i));

        final a = await cryptoService.pbkdf2(
          passphrase: 'passphrase',
          salt: salt,
          iterations: 1000,
        );
        final b = await cryptoService.pbkdf2(
          passphrase: 'passphrase',
          salt: salt,
          iterations: 2000,
        );

        expect(a, isNot(equals(b)));
      });
    });
  });
}
