import 'dart:convert';
import 'dart:typed_data';

import '../../services/crypto_service.dart';
import '../session/session_state.dart';
import 'header.dart';
import 'kdf.dart';

/// Spec-compliant Double Ratchet algorithm.
///
/// Implements the Double Ratchet as specified at:
/// https://signal.org/docs/specifications/doubleratchet/
///
/// Key differences from the legacy (v1) implementation:
/// - Uses HMAC-SHA256(CK, 0x01/0x02) for chain ratchet (not HKDF)
/// - Derives encryption key + nonce from message key via HKDF (not direct use)
/// - Includes encoded header in AEAD associated data
/// - All state mutations return new [SessionState] instances (immutable)
///
/// This class is stateless — all session state is passed in and returned.
class SpecDoubleRatchet {
  final CryptoService _crypto;
  final SignalKdf _kdf;

  /// Maximum number of skipped message keys to store per session.
  /// Prevents unbounded memory growth from protocol violations or
  /// very long offline gaps.
  static const maxSkippedKeys = 200;

  SpecDoubleRatchet(this._crypto, this._kdf);

  // ── Encrypt ────────────────────────────────────────────────────────────

  /// Encrypt a plaintext message.
  ///
  /// Returns the updated session state, the message header, and the
  /// ciphertext (nonce-free — nonce is derived deterministically from
  /// the message key).
  ///
  /// Per spec §3.1 ENCRYPT:
  /// 1. Derive message key from send chain key
  /// 2. Advance send chain key
  /// 3. Build header with current DH ratchet key, PN, N
  /// 4. Encrypt plaintext with AEAD(mk, pt, AD || header)
  Future<({SessionState state, MessageHeader header, Uint8List ciphertext})>
      encrypt(SessionState session, String plaintext) async {
    final sendCk = session.sendChainKey;
    if (sendCk == null) {
      throw StateError('E2EE v2: Cannot encrypt — no send chain key');
    }

    // Derive message key and advance chain
    final messageKey = _kdf.kdfCkMessageKey(sendCk);
    final nextSendCk = _kdf.kdfCkNextChainKey(sendCk);

    // Build header
    final header = MessageHeader(
      dhRatchetKey: session.dhSendPublic,
      previousChainLength: session.previousChainLength,
      messageNumber: session.sendMessageNumber,
    );

    // Construct AEAD associated data: AD || encoded_header
    final ad = _concatAd(session.associatedData, header.encode());

    // Derive encryption key + deterministic nonce from message key
    final keys = await _kdf.deriveMessageEncryptionKeys(messageKey);

    // Encrypt
    final plaintextBytes = Uint8List.fromList(utf8.encode(plaintext));
    final ciphertext = await _crypto.encrypt(
      plaintextBytes,
      keys.encKey,
      nonce: keys.nonce,
      aad: ad,
    );

    // The ciphertext from CryptoService includes nonce(12)||ct||mac(16),
    // but since our nonce is deterministic, we strip the prepended nonce
    // to save bandwidth. The receiver re-derives it from the message key.
    final ctWithoutNonce = Uint8List.fromList(ciphertext.sublist(12));

    // Update session state (immutable)
    final newState = session.copyWith(
      sendChainKey: nextSendCk,
      sendMessageNumber: session.sendMessageNumber + 1,
    );

    return (state: newState, header: header, ciphertext: ctWithoutNonce);
  }

  // ── Decrypt ────────────────────────────────────────────────────────────

  /// Decrypt a received message.
  ///
  /// Returns the updated session state and the decrypted plaintext.
  ///
  /// Per spec §3.2 DECRYPT:
  /// 1. Try skipped message keys first
  /// 2. If peer's DH key changed, perform DH ratchet step
  /// 3. Skip any missing message keys in current chain
  /// 4. Derive message key, advance chain, decrypt
  Future<({SessionState state, String plaintext})> decrypt(
    SessionState session,
    MessageHeader header,
    Uint8List ciphertext,
  ) async {
    // 1. Try skipped keys
    final skippedResult = await _trySkippedKeys(session, header, ciphertext);
    if (skippedResult != null) return skippedResult;

    var state = session;

    // 2. DH ratchet step if peer's key changed
    if (!_bytesEqual(header.dhRatchetKey, state.dhRecvPublic)) {
      state = await _skipKeys(state, header.previousChainLength);
      state = await _dhRatchetStep(state, header.dhRatchetKey);
    }

    // 3. Skip keys up to this message's number
    state = await _skipKeys(state, header.messageNumber);

    // 4. Derive message key and decrypt
    final recvCk = state.recvChainKey;
    if (recvCk == null) {
      throw StateError('E2EE v2: Cannot decrypt — no recv chain key');
    }

    final messageKey = _kdf.kdfCkMessageKey(recvCk);
    final nextRecvCk = _kdf.kdfCkNextChainKey(recvCk);

    final plaintext = await _decryptWithKey(
      messageKey,
      state.associatedData,
      header,
      ciphertext,
    );

    final newState = state.copyWith(
      recvChainKey: nextRecvCk,
      recvMessageNumber: state.recvMessageNumber + 1,
    );

    return (state: newState, plaintext: plaintext);
  }

  // ── DH Ratchet Step ────────────────────────────────────────────────────

  /// Perform a DH ratchet step when the peer's DH key changes.
  ///
  /// Per spec §3.5:
  /// 1. Save previous chain length
  /// 2. Reset recv chain via KDF_RK(RK, DH(our_old, their_new))
  /// 3. Generate new DH key pair
  /// 4. Reset send chain via KDF_RK(RK, DH(our_new, their_new))
  Future<SessionState> _dhRatchetStep(
    SessionState state,
    Uint8List peerDhPublic,
  ) async {
    // Derive new recv chain
    final dhOutputRecv = await _crypto.diffieHellman(
      state.dhSendPrivate,
      peerDhPublic,
    );
    final recvRatchet = await _kdf.kdfRk(state.rootKey, dhOutputRecv);

    // Generate new DH key pair
    final newDhKp = await _crypto.generateX25519KeyPair();

    // Derive new send chain
    final dhOutputSend = await _crypto.diffieHellman(
      newDhKp['privateKey']!,
      peerDhPublic,
    );
    final sendRatchet = await _kdf.kdfRk(recvRatchet.rootKey, dhOutputSend);

    return state.copyWith(
      previousChainLength: state.sendMessageNumber,
      sendMessageNumber: 0,
      recvMessageNumber: 0,
      rootKey: sendRatchet.rootKey,
      recvChainKey: recvRatchet.chainKey,
      sendChainKey: sendRatchet.chainKey,
      dhSendPrivate: newDhKp['privateKey']!,
      dhSendPublic: newDhKp['publicKey']!,
      dhRecvPublic: peerDhPublic,
    );
  }

  // ── Skipped Keys ───────────────────────────────────────────────────────

  /// Skip receive chain keys up to [targetNumber], storing them for
  /// future out-of-order decryption.
  Future<SessionState> _skipKeys(SessionState state, int targetNumber) async {
    final recvCk = state.recvChainKey;
    if (recvCk == null) return state;

    final toSkip = targetNumber - state.recvMessageNumber;
    if (toSkip <= 0) return state;
    if (toSkip > maxSkippedKeys) {
      throw StateError(
        'E2EE v2: Too many skipped keys ($toSkip, max $maxSkippedKeys)',
      );
    }

    final newSkipped = Map<String, Uint8List>.from(state.skippedKeys);
    var currentCk = recvCk;
    var currentNum = state.recvMessageNumber;

    for (var i = 0; i < toSkip; i++) {
      final mk = _kdf.kdfCkMessageKey(currentCk);
      final dhPubB64 = state.dhRecvPublic != null
          ? base64Encode(state.dhRecvPublic!)
          : '';
      newSkipped['$dhPubB64:$currentNum'] = mk;
      currentCk = _kdf.kdfCkNextChainKey(currentCk);
      currentNum++;
    }

    // Prune oldest if over limit
    while (newSkipped.length > maxSkippedKeys) {
      newSkipped.remove(newSkipped.keys.first);
    }

    return state.copyWith(
      recvChainKey: currentCk,
      recvMessageNumber: currentNum,
      skippedKeys: newSkipped,
    );
  }

  /// Try to decrypt using a previously skipped message key.
  Future<({SessionState state, String plaintext})?> _trySkippedKeys(
    SessionState session,
    MessageHeader header,
    Uint8List ciphertext,
  ) async {
    final dhPubB64 = base64Encode(header.dhRatchetKey);
    final lookup = '$dhPubB64:${header.messageNumber}';

    final messageKey = session.skippedKeys[lookup];
    if (messageKey == null) return null;

    final plaintext = await _decryptWithKey(
      messageKey,
      session.associatedData,
      header,
      ciphertext,
    );

    final newSkipped = Map<String, Uint8List>.from(session.skippedKeys);
    newSkipped.remove(lookup);

    return (
      state: session.copyWith(skippedKeys: newSkipped),
      plaintext: plaintext,
    );
  }

  // ── Encryption / Decryption Helpers ────────────────────────────────────

  /// Decrypt ciphertext using a message key.
  ///
  /// The ciphertext format is ct||mac(16) — no prepended nonce, because the
  /// nonce is derived deterministically from the message key.
  Future<String> _decryptWithKey(
    Uint8List messageKey,
    Uint8List sessionAd,
    MessageHeader header,
    Uint8List ciphertext,
  ) async {
    final ad = _concatAd(sessionAd, header.encode());
    final keys = await _kdf.deriveMessageEncryptionKeys(messageKey);

    final plaintext = await _crypto.decrypt(
      ciphertext,
      keys.encKey,
      nonce: keys.nonce,
      aad: ad,
    );
    return utf8.decode(plaintext);
  }

  /// Concatenate session AD (64 bytes) with encoded header (40 bytes).
  ///
  /// Per spec §3.4: AEAD_AD = AD || HEADER
  Uint8List _concatAd(Uint8List sessionAd, Uint8List encodedHeader) {
    final result = Uint8List(sessionAd.length + encodedHeader.length);
    result.setAll(0, sessionAd);
    result.setAll(sessionAd.length, encodedHeader);
    return result;
  }

  /// Constant-time byte comparison.
  bool _bytesEqual(Uint8List a, Uint8List? b) {
    if (b == null) return false;
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }
}
