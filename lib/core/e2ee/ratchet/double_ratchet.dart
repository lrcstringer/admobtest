import 'dart:convert';
import 'dart:typed_data';

import '../../services/crypto_service.dart';
import '../session/double_ratchet_session.dart';

/// Pure Double Ratchet cryptographic operations.
///
/// All methods are stateless computations that operate on [DoubleRatchetSession]
/// data and [CryptoService] primitives. No I/O, no storage, no network.
class DoubleRatchet {
  final CryptoService _crypto;

  static const maxSkippedKeys = 200;

  DoubleRatchet(this._crypto);

  /// KDF_RK per Signal spec: HKDF(salt=rootKey, IKM=DH(private, peerPublic)).
  ///
  /// Returns a new root key and chain key (64 bytes split in half).
  /// The root key is used as HKDF salt (not concatenated into IKM) per spec.
  Future<({Uint8List rootKey, Uint8List chainKey})> kdfRk(
    Uint8List rootKey,
    Uint8List dhPrivate,
    Uint8List peerPublic,
  ) async {
    final dhOutput = await _crypto.diffieHellman(dhPrivate, peerPublic);
    final derived = await _crypto.hkdf(
      inputKeyMaterial: dhOutput,
      length: 64,
      salt: rootKey,
      info: utf8.encode('Ratchet'),
    );
    return (
      rootKey: Uint8List.fromList(derived.sublist(0, 32)),
      chainKey: Uint8List.fromList(derived.sublist(32, 64)),
    );
  }

  /// Derive a message key from a chain key via HKDF.
  ///
  /// Signal spec uses HMAC-SHA256(chainKey, 0x01). This implementation uses
  /// HKDF(IKM=chainKey, info='MsgKey') which provides equivalent cryptographic
  /// separation — HKDF-Expand with distinct info strings ensures message keys
  /// and next chain keys are independent.
  ///
  /// No explicit HKDF salt is used (empty salt). This is safe because the IKM
  /// (chain key) already has high entropy (32 bytes from a previous HKDF or
  /// from the X3DH shared secret). Per RFC 5869 §3.1, when IKM is already
  /// uniformly random, omitting the salt does not weaken the derivation.
  Future<Uint8List> deriveMessageKey(Uint8List chainKey) {
    return _crypto.hkdf(
      inputKeyMaterial: chainKey,
      length: 32,
      info: utf8.encode('MsgKey'),
    );
  }

  /// Ratchet a chain key forward via HKDF.
  ///
  /// Signal spec uses HMAC-SHA256(chainKey, 0x02). This implementation uses
  /// HKDF(IKM=chainKey, info='ChainKey') — see [deriveMessageKey] for
  /// rationale on why this is an acceptable alternative.
  Future<Uint8List> ratchetChainKey(Uint8List chainKey) {
    return _crypto.hkdf(
      inputKeyMaterial: chainKey,
      length: 32,
      info: utf8.encode('ChainKey'),
    );
  }

  /// Encrypt [plaintext] using AES-256-GCM with [messageKey].
  ///
  /// Returns the raw ciphertext bytes (nonce || ciphertext || MAC).
  /// [aad] is optional Associated Data bound to the ciphertext per Signal spec.
  Future<Uint8List> encrypt(String plaintext, Uint8List messageKey,
      {Uint8List? aad}) {
    final plaintextBytes = Uint8List.fromList(utf8.encode(plaintext));
    return _crypto.encrypt(plaintextBytes, messageKey, aad: aad);
  }

  /// Decrypt [ciphertextBase64] using AES-256-GCM with [messageKey].
  ///
  /// The ciphertext format is: nonce(12) || ciphertext || mac(16).
  /// [aad] must match the AAD used during encryption.
  Future<String> decrypt(String ciphertextBase64, Uint8List messageKey,
      {Uint8List? aad}) async {
    final encrypted = base64Decode(ciphertextBase64);
    if (encrypted.length < 28) {
      throw StateError('E2EE: ciphertext too short (${encrypted.length} bytes)');
    }
    final nonce = Uint8List.fromList(encrypted.sublist(0, 12));
    final ciphertextWithMac = Uint8List.fromList(encrypted.sublist(12));
    final plaintext = await _crypto.decrypt(
      ciphertextWithMac,
      messageKey,
      nonce: nonce,
      aad: aad,
    );
    return utf8.decode(plaintext);
  }

  /// Perform the full DH ratchet step when the peer's DH key has changed.
  ///
  /// Mutates [session] in place: updates recv/send chains, generates new
  /// DH key pair. [peerPreviousChainLength] is the sender's previous chain
  /// length from the message header — used to skip remaining keys on the
  /// OLD recv chain before switching to the new one.
  ///
  /// Uses KDF_RK per Signal spec: HKDF(salt=rootKey, IKM=DH_output).
  Future<void> performDhRatchetStep(
    DoubleRatchetSession session,
    Uint8List peerDhPublic,
    int peerPreviousChainLength,
  ) async {
    // Store skipped keys for the OLD recv chain up to the peer's
    // previous chain length. This preserves keys for out-of-order
    // messages from the peer's previous send chain.
    await skipRecvKeys(session, session.recvMessageNumber, peerPreviousChainLength);

    // Record OUR send chain length so we can include it in future messages,
    // telling the peer how many keys to skip on their old recv chain.
    session.previousChainLength = session.sendMessageNumber;
    session.recvMessageNumber = 0;

    // DH ratchet: recv side — KDF_RK(rootKey, DH(ourOldPrivate, peerNewPublic))
    session.dhRecvPublic = peerDhPublic;
    final recv = await kdfRk(session.rootKey, session.dhSendPrivate, peerDhPublic);
    session.rootKey = recv.rootKey;
    session.recvChainKey = recv.chainKey;

    // DH ratchet: send side — generate new DH key pair, then
    // KDF_RK(rootKey, DH(ourNewPrivate, peerNewPublic))
    final newDhKp = await _crypto.generateX25519KeyPair();
    session.dhSendPrivate = newDhKp['privateKey']!;
    session.dhSendPublic = newDhKp['publicKey']!;

    final send = await kdfRk(session.rootKey, session.dhSendPrivate, peerDhPublic);
    session.rootKey = send.rootKey;
    session.sendChainKey = send.chainKey;
    session.sendMessageNumber = 0;
  }

  /// Skip recv chain keys up to [targetNum], storing them for out-of-order
  /// message decryption.
  ///
  /// Throws [StateError] if the gap exceeds [maxSkippedKeys] to prevent
  /// unbounded memory growth and detect protocol violations.
  Future<void> skipRecvKeys(
    DoubleRatchetSession session,
    int currentNum,
    int targetNum,
  ) async {
    final toSkip = targetNum - currentNum;
    if (toSkip < 0) return; // Target is behind current position; nothing to skip
    if (toSkip > maxSkippedKeys) {
      throw StateError(
        'E2EE: Too many skipped keys ($toSkip, max $maxSkippedKeys) — '
        'possible protocol violation or very long offline gap',
      );
    }

    for (var i = currentNum; i < targetNum; i++) {
      final key = await deriveMessageKey(session.recvChainKey);
      final lookup = '${base64Encode(session.dhRecvPublic!)}:$i';
      session.skippedKeys[lookup] = key;
      session.recvChainKey = await ratchetChainKey(session.recvChainKey);
    }
    pruneSkippedKeys(session);
  }

  /// Prune skipped keys to stay under the maximum limit.
  void pruneSkippedKeys(DoubleRatchetSession session) {
    while (session.skippedKeys.length > maxSkippedKeys) {
      session.skippedKeys.remove(session.skippedKeys.keys.first);
    }
  }

  /// Constant-time byte comparison using XOR accumulation.
  ///
  /// Iterates all bytes regardless of mismatch position, preventing
  /// timing side-channels on key material comparison.
  ///
  /// The early `a.length != b.length` return is safe here because DH public
  /// keys are always exactly 32 bytes. A length mismatch indicates a
  /// programming error (wrong data passed), not an attacker-controlled input
  /// that could be distinguished via timing.
  bool bytesEqual(Uint8List a, Uint8List? b) {
    if (b == null) return false;
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }
}
