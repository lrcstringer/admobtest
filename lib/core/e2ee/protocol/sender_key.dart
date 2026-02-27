import 'dart:typed_data';

import '../../services/crypto_service.dart';
import 'kdf.dart';

/// Spec-compliant Sender Key chain ratchet for group messaging.
///
/// Uses the same HMAC-SHA256 chain ratchet as the Double Ratchet
/// specification, fixing deviation #3 (HKDF was incorrectly used in v1):
///
/// - Message key: `HMAC-SHA256(chain_key, 0x01)`
/// - Next chain key: `HMAC-SHA256(chain_key, 0x02)`
/// - Encryption: AES-256-GCM with deterministic nonce derived from the
///   message key via HKDF (matching the Double Ratchet ENCRYPT construction)
///
/// The v1 implementation used HKDF with info strings `'SKMsgKey'`/`'SKChainKey'`
/// for chain ratcheting, which is non-standard. This v2 implementation aligns
/// with the Signal Protocol specification.
class SenderKeyRatchet {
  final CryptoService _crypto;
  final SignalKdf _kdf;

  SenderKeyRatchet(this._crypto, this._kdf);

  /// Perform a single chain ratchet step.
  ///
  /// Returns the message key for the current chain position and the
  /// advanced chain key for the next position.
  ///
  /// Per Signal spec: chain ratchet uses HMAC-SHA256 with single-byte
  /// inputs (0x01 for message key, 0x02 for next chain key).
  ({Uint8List messageKey, Uint8List nextChainKey}) ratchetStep(
    Uint8List chainKey,
  ) {
    return (
      messageKey: _kdf.kdfCkMessageKey(chainKey),
      nextChainKey: _kdf.kdfCkNextChainKey(chainKey),
    );
  }

  /// Encrypt plaintext using a single-use message key.
  ///
  /// Derives AES-256-GCM encryption key and deterministic nonce from
  /// the message key via HKDF, then encrypts. Returns `ct || mac(16)`
  /// — the nonce is NOT prepended because the receiver re-derives it
  /// from the same message key.
  Future<Uint8List> encrypt(
    Uint8List plaintext,
    Uint8List messageKey,
    Uint8List aad,
  ) async {
    final keys = await _kdf.deriveMessageEncryptionKeys(messageKey);
    final encrypted = await _crypto.encrypt(
      plaintext,
      keys.encKey,
      nonce: keys.nonce,
      aad: aad,
    );
    // Strip deterministic nonce (12 bytes) — receiver re-derives it
    return Uint8List.fromList(encrypted.sublist(12));
  }

  /// Decrypt ciphertext (`ct || mac(16)`) using a single-use message key.
  ///
  /// Re-derives the deterministic nonce from the message key, then
  /// decrypts with AES-256-GCM.
  Future<Uint8List> decrypt(
    Uint8List ciphertext,
    Uint8List messageKey,
    Uint8List aad,
  ) async {
    final keys = await _kdf.deriveMessageEncryptionKeys(messageKey);
    return _crypto.decrypt(
      ciphertext,
      keys.encKey,
      nonce: keys.nonce,
      aad: aad,
    );
  }
}
