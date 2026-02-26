import 'dart:convert';
import 'dart:typed_data';

import '../../services/crypto_service.dart';

/// Pure X3DH (Extended Triple Diffie-Hellman) key agreement computations.
///
/// All methods are stateless computations using [CryptoService] primitives.
/// No I/O, no storage, no network, no key bundle fetching.
class X3dhProtocol {
  final CryptoService _crypto;

  X3dhProtocol(this._crypto);

  /// Compute the initiator-side X3DH shared secret (SK).
  ///
  /// Returns a 32-byte shared secret. The caller must use KDF_RK (via
  /// [DoubleRatchet.kdfRk]) to derive the initial root key and send chain key
  /// for the Double Ratchet session.
  Future<Uint8List> computeInitiatorSharedSecret({
    required Uint8List ourIdentityPrivate,
    required Uint8List ourEphemeralPrivate,
    required Uint8List theirIdentityKey,
    required Uint8List theirSignedPreKey,
    Uint8List? theirOneTimePreKey,
  }) async {
    // DH1 = DH(ourIdentityPrivate, theirSignedPreKey)
    final dh1 = await _crypto.diffieHellman(ourIdentityPrivate, theirSignedPreKey);
    // DH2 = DH(ourEphemeralPrivate, theirIdentityKey)
    final dh2 = await _crypto.diffieHellman(ourEphemeralPrivate, theirIdentityKey);
    // DH3 = DH(ourEphemeralPrivate, theirSignedPreKey)
    final dh3 = await _crypto.diffieHellman(ourEphemeralPrivate, theirSignedPreKey);
    // DH4 = DH(ourEphemeralPrivate, theirOneTimePreKey) [if available]
    Uint8List? dh4;
    if (theirOneTimePreKey != null) {
      dh4 = await _crypto.diffieHellman(ourEphemeralPrivate, theirOneTimePreKey);
    }

    final masterSecret = _concatSecrets(dh1, dh2, dh3, dh4);
    return _deriveSharedSecret(masterSecret);
  }

  /// Compute the receiver-side X3DH shared secret (SK).
  ///
  /// Returns a 32-byte shared secret. The caller must use KDF_RK (via
  /// [DoubleRatchet.kdfRk]) to derive the initial recv chain key and then
  /// the send chain key for the Double Ratchet session.
  Future<Uint8List> computeReceiverSharedSecret({
    required Uint8List ourIdentityPrivate,
    required Uint8List ourSignedPreKeyPrivate,
    required Uint8List theirIdentityPub,
    required Uint8List theirEphemeralPub,
    Uint8List? ourOtkPrivate,
  }) async {
    // DH1 = DH(ourSignedPreKeyPriv, theirIdentityPub)
    final dh1 = await _crypto.diffieHellman(ourSignedPreKeyPrivate, theirIdentityPub);
    // DH2 = DH(ourIdentityPriv, theirEphemeralPub)
    final dh2 = await _crypto.diffieHellman(ourIdentityPrivate, theirEphemeralPub);
    // DH3 = DH(ourSignedPreKeyPriv, theirEphemeralPub)
    final dh3 = await _crypto.diffieHellman(ourSignedPreKeyPrivate, theirEphemeralPub);
    // DH4 = DH(ourOtkPriv, theirEphemeralPub) [if OTK was used]
    Uint8List? dh4;
    if (ourOtkPrivate != null) {
      dh4 = await _crypto.diffieHellman(ourOtkPrivate, theirEphemeralPub);
    }

    final masterSecret = _concatSecrets(dh1, dh2, dh3, dh4);
    return _deriveSharedSecret(masterSecret);
  }

  /// Verify an Ed25519 signature on a signed pre-key.
  Future<bool> verifySignedPreKey(
    Uint8List signedPreKey,
    Uint8List signature,
    Uint8List ed25519PublicKey,
  ) {
    return _crypto.ed25519Verify(signedPreKey, signature, ed25519PublicKey);
  }

  /// Generate an X25519 key pair.
  Future<Map<String, Uint8List>> generateKeyPair() {
    return _crypto.generateX25519KeyPair();
  }

  /// Concatenate DH secrets into a master secret.
  Uint8List _concatSecrets(
    Uint8List dh1,
    Uint8List dh2,
    Uint8List dh3,
    Uint8List? dh4,
  ) {
    final length = dh1.length + dh2.length + dh3.length + (dh4?.length ?? 0);
    final result = Uint8List(length);
    var offset = 0;
    result.setRange(offset, offset + dh1.length, dh1);
    offset += dh1.length;
    result.setRange(offset, offset + dh2.length, dh2);
    offset += dh2.length;
    result.setRange(offset, offset + dh3.length, dh3);
    offset += dh3.length;
    if (dh4 != null) {
      result.setRange(offset, offset + dh4.length, dh4);
    }
    return result;
  }

  /// Derive 32-byte shared secret (SK) from master secret via HKDF.
  ///
  /// Per Signal spec, X3DH produces SK only. The caller uses KDF_RK
  /// (DoubleRatchet.kdfRk) to derive the initial root key and chain keys
  /// for the Double Ratchet session.
  Future<Uint8List> _deriveSharedSecret(Uint8List masterSecret) async {
    return _crypto.hkdf(
      inputKeyMaterial: masterSecret,
      length: 32,
      salt: Uint8List(0),
      info: utf8.encode('X3DH-init'),
    );
  }
}
