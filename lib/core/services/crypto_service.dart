import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:injectable/injectable.dart';

/// Low-level cryptographic primitives for the E2EE system.
///
/// Uses the `cryptography` package for AES-256-GCM, X25519,
/// HKDF-SHA256, and PBKDF2-SHA256.
@lazySingleton
class CryptoService {
  static final _aesGcm = AesGcm.with256bits();
  static final _x25519 = X25519();
  static final _rng = Random.secure();

  /// Generate cryptographically secure random bytes.
  Uint8List randomBytes(int length) {
    return Uint8List.fromList(
      List.generate(length, (_) => _rng.nextInt(256)),
    );
  }

  /// Generate a random AES-256 key (32 bytes).
  Uint8List generateAesKey() => randomBytes(32);

  /// Encrypt plaintext with AES-256-GCM.
  ///
  /// Returns the concatenation of nonce(12) + ciphertext + tag(16).
  /// If [nonce] is not provided, a random 12-byte nonce is generated.
  Future<Uint8List> encrypt(
    Uint8List plaintext,
    Uint8List key, {
    Uint8List? nonce,
  }) async {
    final iv = nonce ?? randomBytes(12);
    final secretKey = SecretKey(key);
    final secretBox = await _aesGcm.encrypt(
      plaintext,
      secretKey: secretKey,
      nonce: iv,
    );
    // Return: nonce(12) || ciphertext || mac(16)
    final result = Uint8List(iv.length + secretBox.cipherText.length + secretBox.mac.bytes.length);
    result.setRange(0, iv.length, iv);
    result.setRange(iv.length, iv.length + secretBox.cipherText.length, secretBox.cipherText);
    result.setRange(iv.length + secretBox.cipherText.length, result.length, secretBox.mac.bytes);
    return result;
  }

  /// Decrypt ciphertext with AES-256-GCM.
  ///
  /// Expects input format: ciphertext + tag(16).
  /// [nonce] must be the same 12-byte nonce used during encryption.
  Future<Uint8List> decrypt(
    Uint8List ciphertext,
    Uint8List key, {
    required Uint8List nonce,
  }) async {
    // Split: last 16 bytes = MAC, rest = actual ciphertext
    final macBytes = ciphertext.sublist(ciphertext.length - 16);
    final ct = ciphertext.sublist(0, ciphertext.length - 16);
    final secretKey = SecretKey(key);
    final secretBox = SecretBox(
      ct,
      nonce: nonce,
      mac: Mac(macBytes),
    );
    final plaintext = await _aesGcm.decrypt(secretBox, secretKey: secretKey);
    return Uint8List.fromList(plaintext);
  }

  /// Generate an X25519 key pair for Diffie-Hellman key agreement.
  ///
  /// Returns a map with `publicKey` and `privateKey` as [Uint8List] values.
  Future<Map<String, Uint8List>> generateX25519KeyPair() async {
    final keyPair = await _x25519.newKeyPair();
    final privateBytes = await keyPair.extractPrivateKeyBytes();
    final publicKey = await keyPair.extractPublicKey();
    return {
      'privateKey': Uint8List.fromList(privateBytes),
      'publicKey': Uint8List.fromList(publicKey.bytes),
    };
  }

  /// Perform X25519 Diffie-Hellman key agreement.
  ///
  /// Computes a shared secret from [privateKey] and the other party's
  /// [publicKey].
  Future<Uint8List> diffieHellman(
    Uint8List privateKey,
    Uint8List publicKey,
  ) async {
    final keyPair = await _x25519.newKeyPairFromSeed(privateKey);
    final remotePublicKey = SimplePublicKey(publicKey, type: KeyPairType.x25519);
    final sharedSecret = await _x25519.sharedSecretKey(
      keyPair: keyPair,
      remotePublicKey: remotePublicKey,
    );
    final bytes = await sharedSecret.extractBytes();
    return Uint8List.fromList(bytes);
  }

  /// HKDF (HMAC-based Key Derivation Function) key derivation.
  ///
  /// Derives [length] bytes from [inputKeyMaterial] using optional
  /// [salt] and [info] parameters.
  Future<Uint8List> hkdf({
    required Uint8List inputKeyMaterial,
    required int length,
    Uint8List? salt,
    Uint8List? info,
  }) async {
    final algorithm = Hkdf(
      hmac: Hmac.sha256(),
      outputLength: length,
    );
    final secretKey = SecretKey(inputKeyMaterial);
    final derived = await algorithm.deriveKey(
      secretKey: secretKey,
      nonce: salt ?? Uint8List(0),
      info: info ?? Uint8List(0),
    );
    final bytes = await derived.extractBytes();
    return Uint8List.fromList(bytes);
  }

  /// PBKDF2-SHA256 key derivation from a user passphrase.
  ///
  /// Used for encrypting key backups. Default [iterations] is 600,000
  /// per OWASP recommendations for PBKDF2-SHA256.
  Future<Uint8List> pbkdf2({
    required String passphrase,
    required Uint8List salt,
    int iterations = 600000,
    int keyLength = 32,
  }) async {
    final algorithm = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: keyLength * 8,
    );
    final secretKey = SecretKey(utf8.encode(passphrase));
    final derived = await algorithm.deriveKey(
      secretKey: secretKey,
      nonce: salt,
    );
    final bytes = await derived.extractBytes();
    return Uint8List.fromList(bytes);
  }
}
