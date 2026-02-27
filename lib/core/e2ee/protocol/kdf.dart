import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;

import '../../services/crypto_service.dart';

/// Signal Protocol Key Derivation Functions.
///
/// Implements the exact KDF constructions specified in:
/// - X3DH: https://signal.org/docs/specifications/x3dh/
/// - Double Ratchet: https://signal.org/docs/specifications/doubleratchet/
///
/// Uses [CryptoService] (backed by the MIT-licensed `cryptography` package)
/// for HKDF, and the MIT-licensed `crypto` package for HMAC-SHA256.
class SignalKdf {
  final CryptoService _crypto;

  SignalKdf(this._crypto);

  // ── Constants ──────────────────────────────────────────────────────────

  /// 32 bytes of 0xFF prepended to the DH secret concatenation in X3DH.
  /// Per X3DH spec §5.2: "F = 0xFF * 32" for X25519 (256-bit curve).
  static final _ffPrefix = Uint8List.fromList(List.filled(32, 0xFF));

  /// 32 zero bytes used as the HKDF salt for X3DH.
  /// Per X3DH spec §5.2: "a zero-filled byte sequence with length equal
  /// to the hash output length" (SHA-256 → 32 bytes).
  static final _zeroSalt32 = Uint8List(32);

  /// HKDF info string for X3DH key derivation.
  static final _x3dhInfo = utf8.encode('iMaliChat');

  /// HKDF info string for the root key ratchet (KDF_RK).
  static final _ratchetInfo = utf8.encode('iMaliChatRatchet');

  /// HKDF info string for deriving encryption key + nonce from a message key.
  static final _msgKeyInfo = utf8.encode('iMaliChatMsg');

  /// Single byte 0x01 — HMAC input for message key derivation.
  static final _hmacByte01 = Uint8List.fromList([0x01]);

  /// Single byte 0x02 — HMAC input for chain key advancement.
  static final _hmacByte02 = Uint8List.fromList([0x02]);

  // ── X3DH KDF ──────────────────────────────────────────────────────────

  /// X3DH shared secret derivation.
  ///
  /// Per X3DH spec §5.2:
  /// ```
  /// IKM = F || DH1 || DH2 || DH3 [|| DH4]
  /// SK  = HKDF(salt=0x00*32, ikm=IKM, info="iMaliChat", length=32)
  /// ```
  ///
  /// [masterSecret] is the concatenation of DH outputs (DH1||DH2||DH3[||DH4]),
  /// WITHOUT the 0xFF prefix — this method prepends it.
  Future<Uint8List> kdfX3dh(Uint8List masterSecret) async {
    // Prepend 32 bytes of 0xFF
    final ikm = Uint8List(_ffPrefix.length + masterSecret.length);
    ikm.setAll(0, _ffPrefix);
    ikm.setAll(_ffPrefix.length, masterSecret);

    return _crypto.hkdf(
      inputKeyMaterial: ikm,
      length: 32,
      salt: _zeroSalt32,
      info: Uint8List.fromList(_x3dhInfo),
    );
  }

  // ── Root Key Ratchet (KDF_RK) ─────────────────────────────────────────

  /// Root key ratchet step.
  ///
  /// Per Double Ratchet spec §5.2:
  /// ```
  /// (new_rk, new_ck) = HKDF(salt=rk, ikm=dh_out, info="...", length=64)
  /// ```
  ///
  /// Returns 32-byte root key and 32-byte chain key.
  Future<({Uint8List rootKey, Uint8List chainKey})> kdfRk(
    Uint8List rootKey,
    Uint8List dhOutput,
  ) async {
    final derived = await _crypto.hkdf(
      inputKeyMaterial: dhOutput,
      length: 64,
      salt: rootKey,
      info: Uint8List.fromList(_ratchetInfo),
    );
    return (
      rootKey: Uint8List.fromList(derived.sublist(0, 32)),
      chainKey: Uint8List.fromList(derived.sublist(32, 64)),
    );
  }

  // ── Chain Key Ratchet (KDF_CK) ────────────────────────────────────────

  /// Derive a message key from a chain key.
  ///
  /// Per Double Ratchet spec §5.2:
  /// ```
  /// MK = HMAC-SHA256(CK, 0x01)
  /// ```
  Uint8List kdfCkMessageKey(Uint8List chainKey) {
    return hmacSha256(chainKey, _hmacByte01);
  }

  /// Advance the chain key.
  ///
  /// Per Double Ratchet spec §5.2:
  /// ```
  /// CK_next = HMAC-SHA256(CK, 0x02)
  /// ```
  Uint8List kdfCkNextChainKey(Uint8List chainKey) {
    return hmacSha256(chainKey, _hmacByte02);
  }

  // ── Message Key → Encryption Key + Nonce ──────────────────────────────

  /// Derive AES-256-GCM encryption key and deterministic nonce from a
  /// message key.
  ///
  /// Per Double Ratchet spec §5.2 ENCRYPT:
  /// ```
  /// (enc_key, nonce) = HKDF(salt=0x00*32, ikm=mk, info="...", length=44)
  /// ```
  ///
  /// Returns 32-byte encryption key and 12-byte nonce.
  /// The nonce is deterministic (derived from the single-use message key),
  /// eliminating nonce-reuse risk with AES-GCM.
  Future<({Uint8List encKey, Uint8List nonce})> deriveMessageEncryptionKeys(
    Uint8List messageKey,
  ) async {
    final derived = await _crypto.hkdf(
      inputKeyMaterial: messageKey,
      length: 44,
      salt: _zeroSalt32,
      info: Uint8List.fromList(_msgKeyInfo),
    );
    return (
      encKey: Uint8List.fromList(derived.sublist(0, 32)),
      nonce: Uint8List.fromList(derived.sublist(32, 44)),
    );
  }

  // ── Low-level HMAC ────────────────────────────────────────────────────

  /// HMAC-SHA256 using the `crypto` package (synchronous).
  ///
  /// Used for chain key ratcheting (KDF_CK) where the spec mandates
  /// HMAC-SHA256 with single-byte inputs, not HKDF.
  static Uint8List hmacSha256(Uint8List key, Uint8List data) {
    final hmac = crypto.Hmac(crypto.sha256, key);
    final digest = hmac.convert(data);
    return Uint8List.fromList(digest.bytes);
  }
}
