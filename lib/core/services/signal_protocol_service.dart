import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'crypto_service.dart';
import 'key_management_service.dart';

/// Thrown when a message can never be decrypted, regardless of retries.
///
/// Causes: missing x3dhHeader (pre-fix legacy message), OTK mismatch
/// (sender used an OTK the receiver no longer has after key regeneration),
/// or stale session with no recovery path.
class PermanentDecryptionError extends StateError {
  PermanentDecryptionError(super.message);
}

/// Implements the Signal Protocol for peer-to-peer encrypted messaging.
///
/// Handles X3DH key agreement for session establishment and Double Ratchet
/// for ongoing message encryption/decryption.
@lazySingleton
class SignalProtocolService {
  final KeyManagementService _keyManagementService;
  final CryptoService _cryptoService;
  final FlutterSecureStorage _secureStorage;

  SignalProtocolService(
    this._keyManagementService,
    this._cryptoService,
    this._secureStorage,
  );

  static const _sessionPrefix = 'e2ee_session_';
  static const _maxSkippedKeys = 200;

  /// Short fingerprint of key bytes for diagnostic logging.
  static String _fp(Uint8List? bytes) =>
      bytes == null ? 'null' : base64Encode(bytes).substring(0, 8);

  /// Establish an X3DH session with [recipientUserId].
  ///
  /// Fetches the recipient's public key bundle, performs the X3DH
  /// handshake, and initialises the Double Ratchet state.
  Future<void> establishSession(String recipientUserId) async {
    // 1. Load our identity key pair
    final ourBundle = await _keyManagementService.loadPrivateKeys();
    if (ourBundle == null) {
      throw StateError('E2EE: No local key bundle — cannot establish session');
    }

    final ourIdentityPrivate =
        base64Decode(ourBundle.identityKeyPair.split('|')[0]);
    final ourIdentityPublic =
        base64Decode(ourBundle.identityKeyPair.split('|')[1]);

    // 2. Generate ephemeral key pair
    final ephemeralKp = await _cryptoService.generateX25519KeyPair();

    // 3. Fetch recipient's public key bundle
    final theirBundle =
        await _keyManagementService.fetchKeyBundle(recipientUserId);
    final theirIdentityKey = base64Decode(theirBundle.identityKey);
    final theirSignedPreKey = base64Decode(theirBundle.signedPreKey);

    // Verify Ed25519 signature on the signed pre-key before using it
    if (theirBundle.ed25519IdentityKey != null &&
        theirBundle.ed25519Signature != null) {
      final ed25519PubKey = base64Decode(theirBundle.ed25519IdentityKey!);
      final ed25519Sig = base64Decode(theirBundle.ed25519Signature!);
      final valid = await _cryptoService.ed25519Verify(
        theirSignedPreKey, ed25519Sig, ed25519PubKey,
      );
      if (!valid) {
        throw StateError(
          'E2EE: Signed pre-key signature verification failed for $recipientUserId — '
          'possible MITM attack',
        );
      }
    }

    // 4. Compute DH shared secrets
    // DH1 = DH(ourIdentityPrivate, theirSignedPreKey)
    final dh1 =
        await _cryptoService.diffieHellman(ourIdentityPrivate, theirSignedPreKey);
    // DH2 = DH(ourEphemeralPrivate, theirIdentityKey)
    final dh2 = await _cryptoService.diffieHellman(
        ephemeralKp['privateKey']!, theirIdentityKey);
    // DH3 = DH(ourEphemeralPrivate, theirSignedPreKey)
    final dh3 = await _cryptoService.diffieHellman(
        ephemeralKp['privateKey']!, theirSignedPreKey);

    // DH4 = DH(ourEphemeralPrivate, theirOneTimePreKey) [if available]
    Uint8List? dh4;
    String? consumedOtkPublicKey;
    if (theirBundle.oneTimePreKeys.isNotEmpty) {
      final theirOtk = base64Decode(theirBundle.oneTimePreKeys.first);
      dh4 = await _cryptoService.diffieHellman(
          ephemeralKp['privateKey']!, theirOtk);
      consumedOtkPublicKey = theirBundle.oneTimePreKeys.first;
    }

    // 5. Concatenate master secret
    final masterSecretLength =
        dh1.length + dh2.length + dh3.length + (dh4?.length ?? 0);
    final masterSecret = Uint8List(masterSecretLength);
    var offset = 0;
    masterSecret.setRange(offset, offset + dh1.length, dh1);
    offset += dh1.length;
    masterSecret.setRange(offset, offset + dh2.length, dh2);
    offset += dh2.length;
    masterSecret.setRange(offset, offset + dh3.length, dh3);
    offset += dh3.length;
    if (dh4 != null) {
      masterSecret.setRange(offset, offset + dh4.length, dh4);
    }

    // 6. Derive root key + send chain key via HKDF
    final derived = await _cryptoService.hkdf(
      inputKeyMaterial: masterSecret,
      length: 64,
      salt: Uint8List(32), // zeros
      info: utf8.encode('X3DH-init'),
    );
    final rootKey = Uint8List.fromList(derived.sublist(0, 32));
    final sendChainKey = Uint8List.fromList(derived.sublist(32, 64));

    // 7. Generate initial DH ratchet key pair for sending
    final dhSendKp = await _cryptoService.generateX25519KeyPair();

    // 8. Create Double Ratchet session
    final session = _DoubleRatchetSession(
      rootKey: rootKey,
      sendChainKey: sendChainKey,
      recvChainKey: Uint8List(32),
      dhSendPrivate: dhSendKp['privateKey']!,
      dhSendPublic: dhSendKp['publicKey']!,
      dhRecvPublic: theirSignedPreKey,
      isInitiator: true,
      pendingIdentityKey: base64Encode(ourIdentityPublic),
      pendingEphemeralKey: base64Encode(ephemeralKp['publicKey']!),
      pendingOtkPublicKey: consumedOtkPublicKey,
      peerIdentityKey: base64Encode(theirIdentityKey),
    );

    debugPrint('E2EE INIT-SEND [$recipientUserId]: '
        'rootKey=${_fp(rootKey)} sendCK=${_fp(sendChainKey)} '
        'dhSendPub=${_fp(dhSendKp['publicKey']!)} '
        'theirIdPub=${_fp(theirIdentityKey)} '
        'theirSPKPub=${_fp(theirSignedPreKey)} '
        'ourIdPub=${_fp(ourIdentityPublic)} '
        'ephPub=${_fp(ephemeralKp['publicKey']!)} '
        'otk=${consumedOtkPublicKey != null ? consumedOtkPublicKey.substring(0, 12) : "none"}…');

    // 9. Persist session
    await _saveSession(recipientUserId, session);
  }

  /// Encrypt a plaintext message for [recipientUserId].
  ///
  /// Returns a map containing:
  /// - `ciphertext`: the encrypted message (base64)
  /// - `e2ee`: metadata for decryption
  /// - `x3dhHeader`: X3DH header data (only on the first message in a session)
  ///
  /// Automatically establishes a session if one does not exist.
  Future<Map<String, dynamic>> encryptP2P(
    String recipientUserId,
    String plaintext,
  ) async {
    // Load or establish session
    var session = await _loadSession(recipientUserId);
    if (session == null || !session.isInitiator) {
      // No session, or the session was established from a receiver X3DH
      // (decrypt path). Receiver-side sessions have no pendingIdentityKey,
      // so the encrypted message would lack an x3dh header — the recipient
      // on a fresh install can't establish a session without one.
      // Always establish a proper sender session for encryption.
      if (session != null && !session.isInitiator) {
        debugPrint('E2EE ENCRYPT [$recipientUserId]: Discarding receiver-side '
            'session — establishing fresh sender session for proper x3dh header');
      }
      await establishSession(recipientUserId);
      session = await _loadSession(recipientUserId);
      if (session == null) {
        throw StateError('E2EE: Failed to establish session');
      }
    }

    // Derive message key from send chain key
    final messageKey = await _cryptoService.hkdf(
      inputKeyMaterial: session.sendChainKey,
      length: 32,
      info: utf8.encode('MsgKey'),
    );

    // Ratchet send chain key forward
    session.sendChainKey = await _cryptoService.hkdf(
      inputKeyMaterial: session.sendChainKey,
      length: 32,
      info: utf8.encode('ChainKey'),
    );

    // Encrypt with AES-256-GCM
    final plaintextBytes = Uint8List.fromList(utf8.encode(plaintext));
    final encrypted = await _cryptoService.encrypt(plaintextBytes, messageKey);

    debugPrint('E2EE ENCRYPT [$recipientUserId]: '
        'msgNum=${session.sendMessageNumber} '
        'sendCK=${_fp(session.sendChainKey)} '
        'msgKey=${_fp(messageKey)} '
        'dhSendPub=${_fp(session.dhSendPublic)} '
        'hasX3DH=${session.pendingIdentityKey != null}');

    // Build result
    final result = <String, dynamic>{
      'ciphertext': base64Encode(encrypted),
      'e2ee': {
        'protocol': 'signal-v1',
        'messageNumber': session.sendMessageNumber,
        'dhPublicKey': base64Encode(session.dhSendPublic),
      },
    };

    // Always include X3DH header when pending keys exist (which is now
    // always, since we never clear them). This ensures the recipient can
    // perform a fresh receiver-side X3DH at any time — critical when the
    // peer regenerates their key bundle (reinstall, data clear, etc.).
    // The receiver ignores the header when peerX3dhEphemeralKey matches.
    if (session.pendingIdentityKey != null) {
      result['x3dhHeader'] = {
        'identityKey': session.pendingIdentityKey,
        'ephemeralKey': session.pendingEphemeralKey,
        'oneTimePreKeyPublicKey': session.pendingOtkPublicKey,
      };
    }

    session.sendMessageNumber++;
    await _saveSession(recipientUserId, session);
    return result;
  }

  /// Decrypt an encrypted message from [senderUserId].
  Future<String> decryptP2P(
    String senderUserId,
    Map<String, dynamic> encryptedMessage,
  ) async {
    final ciphertextBase64 = encryptedMessage['ciphertext'] as String;
    final e2ee = encryptedMessage['e2ee'] as Map<String, dynamic>?;
    final x3dhHeader =
        encryptedMessage['x3dhHeader'] as Map<String, dynamic>?;

    final messageNumber = (e2ee?['messageNumber'] as num?)?.toInt() ?? 0;
    final peerDhPublicBase64 = e2ee?['dhPublicKey'] as String?;
    final peerDhPublic =
        peerDhPublicBase64 != null ? base64Decode(peerDhPublicBase64) : null;

    debugPrint('E2EE DECRYPT-START [$senderUserId]: '
        'msgNum=$messageNumber '
        'hasE2ee=${e2ee != null} '
        'hasX3DH=${x3dhHeader != null} '
        'peerDhPub=${peerDhPublic != null ? _fp(peerDhPublic) : "null"} '
        'ciphertextLen=${ciphertextBase64.length}');

    var session = await _loadSession(senderUserId);

    debugPrint('E2EE DECRYPT-SESSION [$senderUserId]: '
        'hasSession=${session != null} '
        'isInitiator=${session?.isInitiator} '
        'recvMsgNum=${session?.recvMessageNumber}');

    // Perform receiver-side X3DH when:
    //  1. No session exists (first message from this peer)
    //  2. Only an initiator session exists (simultaneous key exchange race)
    //  3. Peer's ephemeral key is known AND CHANGED (sender re-established)
    // Legacy sessions (peerX3dhEphemeralKey == null) are preserved — they have
    // valid ratchet state. The backfill below sets peerX3dhEphemeralKey so
    // future genuine re-establishments are detected.
    final peerEph = x3dhHeader?['ephemeralKey'] as String?;
    final needsReceiverX3dh = x3dhHeader != null &&
        (session == null ||
         session.isInitiator ||
         (session.peerX3dhEphemeralKey != null &&
          session.peerX3dhEphemeralKey != peerEph));

    // Backfill peerX3dhEphemeralKey for legacy non-initiator sessions
    // so future messages don't trigger unnecessary checks.
    if (!needsReceiverX3dh && session != null &&
        !session.isInitiator && session.peerX3dhEphemeralKey == null && peerEph != null) {
      session.peerX3dhEphemeralKey = peerEph;
      await _saveSession(senderUserId, session);
    }

    String? consumedOtkPublicKey;
    if (needsReceiverX3dh) {
      debugPrint('E2EE: Performing receiver X3DH for $senderUserId '
          '(reason: session=${session == null ? "none" : session.isInitiator ? "initiator" : "stale"})');
      final x3dhResult =
          await _performReceiverX3DH(senderUserId, x3dhHeader, peerDhPublic);
      session = x3dhResult.session;
      consumedOtkPublicKey = x3dhResult.consumedOtkPublicKey;
    }

    if (session == null) {
      throw PermanentDecryptionError(
        'E2EE: No session with $senderUserId and no x3dhHeader — '
        'message was sent before x3dhHeader fix or with a stale session. '
        'This message is permanently undecryptable.',
      );
    }

    // Check for skipped message key first
    final skippedLookup = peerDhPublicBase64 != null
        ? '$peerDhPublicBase64:$messageNumber'
        : null;
    if (skippedLookup != null && session.skippedKeys.containsKey(skippedLookup)) {
      final messageKey = session.skippedKeys.remove(skippedLookup)!;
      // Decrypt BEFORE saving — if it fails, the on-disk session still
      // has the skipped key so we can retry.
      final plaintext = await _decryptWithKey(ciphertextBase64, messageKey);
      await _saveSession(senderUserId, session);
      return plaintext;
    }

    // DH ratchet step if peer's DH key changed
    if (peerDhPublic != null && !_bytesEqual(peerDhPublic, session.dhRecvPublic)) {
      // Store skipped keys for current recv chain
      await _skipRecvKeys(session, session.recvMessageNumber, messageNumber);

      // Update recv side
      session.dhRecvPublic = peerDhPublic;
      session.previousChainLength = session.recvMessageNumber;
      session.recvMessageNumber = 0;

      // DH ratchet: recv side
      final dhResult = await _cryptoService.diffieHellman(
        session.dhSendPrivate,
        peerDhPublic,
      );
      final combined = _concat(session.rootKey, dhResult);
      final derived = await _cryptoService.hkdf(
        inputKeyMaterial: combined,
        length: 64,
        info: utf8.encode('Ratchet'),
      );
      session.rootKey = Uint8List.fromList(derived.sublist(0, 32));
      session.recvChainKey = Uint8List.fromList(derived.sublist(32, 64));

      // DH ratchet: send side — generate new DH key pair
      final newDhKp = await _cryptoService.generateX25519KeyPair();
      session.dhSendPrivate = newDhKp['privateKey']!;
      session.dhSendPublic = newDhKp['publicKey']!;

      final dhResult2 = await _cryptoService.diffieHellman(
        session.dhSendPrivate,
        peerDhPublic,
      );
      final combined2 = _concat(session.rootKey, dhResult2);
      final derived2 = await _cryptoService.hkdf(
        inputKeyMaterial: combined2,
        length: 64,
        info: utf8.encode('Ratchet'),
      );
      session.rootKey = Uint8List.fromList(derived2.sublist(0, 32));
      session.sendChainKey = Uint8List.fromList(derived2.sublist(32, 64));
      session.sendMessageNumber = 0;
    }

    // Guard: if message number is behind the current chain position AND
    // not found in skipped keys, the message was already decrypted in a
    // previous session. Re-decrypting would corrupt the chain — bail out.
    if (messageNumber < session.recvMessageNumber) {
      throw StateError(
        'E2EE: message #$messageNumber already consumed '
        '(chain at #${session.recvMessageNumber}) — cannot re-decrypt',
      );
    }

    // Skip to target message number in recv chain
    while (session.recvMessageNumber < messageNumber) {
      final skippedKey = await _deriveMessageKey(session.recvChainKey);
      final lookupKey =
          '${base64Encode(session.dhRecvPublic!)}:${session.recvMessageNumber}';
      session.skippedKeys[lookupKey] = skippedKey;
      session.recvChainKey = await _ratchetChainKey(session.recvChainKey);
      session.recvMessageNumber++;
      _pruneSkippedKeys(session);
    }

    // Derive message key for this message
    final messageKey = await _deriveMessageKey(session.recvChainKey);

    debugPrint('E2EE DECRYPT-KEY [$senderUserId]: '
        'msgNum=$messageNumber '
        'recvCK=${_fp(session.recvChainKey)} '
        'msgKey=${_fp(messageKey)} '
        'dhRecvPub=${_fp(session.dhRecvPublic)}');

    session.recvChainKey = await _ratchetChainKey(session.recvChainKey);
    session.recvMessageNumber++;

    // Decrypt BEFORE saving session. If AES-GCM auth fails, the session
    // state is NOT persisted, so the chain doesn't advance past this
    // message — allowing retry when the correct session is established.
    final plaintext = await _decryptWithKey(ciphertextBase64, messageKey);

    // NOTE: We deliberately do NOT clear pendingIdentityKey/pendingEphemeralKey
    // here. Keeping the X3DH header on every outgoing message ensures that if
    // the peer regenerates their key bundle (reinstall, data clear, etc.),
    // they can always perform a fresh receiver-side X3DH and recover the
    // session. The receiver already ignores duplicate x3dhHeaders when the
    // ephemeral key matches (peerX3dhEphemeralKey check in decryptP2P).
    if (session.pendingIdentityKey != null) {
      debugPrint('E2EE: Decrypt succeeded with $senderUserId — keeping X3DH header for future messages');
    }

    await _saveSession(senderUserId, session);

    // Remove the consumed OTK from local storage so the local count stays
    // in sync with the server (server atomically removes it during fetchKeyBundle).
    if (consumedOtkPublicKey != null) {
      unawaited(_keyManagementService.removeConsumedOtk(consumedOtkPublicKey));
    }

    return plaintext;
  }

  /// Check whether an active Double Ratchet session exists with [userId].
  Future<bool> hasSession(String userId) async {
    final stored = await _secureStorage.read(key: '$_sessionPrefix$userId');
    return stored != null;
  }

  /// Reset the session with [userId], deleting all local state.
  ///
  /// The next message exchange will trigger a fresh X3DH handshake.
  /// Use this when decryption failures indicate a corrupted session.
  Future<void> resetSession(String userId) async {
    await _secureStorage.delete(key: '$_sessionPrefix$userId');
  }

  /// One-time migration: reset sessions corrupted by the legacy
  /// peerX3dhEphemeralKey bug. Returns true if migration was performed.
  Future<bool> migrateResetCorruptedSessions() async {
    final migrated = await _secureStorage.read(key: 'e2ee_session_migration_v1');
    if (migrated != null) {
      debugPrint('E2EE: Session migration already done (flag present)');
      return false;
    }

    // Diagnostic: check total secure storage state to understand if this is
    // a first launch or if storage was wiped by app reinstall.
    try {
      final all = await _secureStorage.readAll();
      final sessionKeys = all.keys.where((k) => k.startsWith(_sessionPrefix)).toList();
      final e2eeKeys = all.keys.where((k) => k.startsWith('e2ee_')).toList();
      debugPrint('E2EE: Migration flag NOT found — total keys: ${all.length}, '
          'E2EE keys: ${e2eeKeys.length}, sessions: ${sessionKeys.length}. '
          '${all.isEmpty ? "Storage is EMPTY (first launch or wiped by reinstall)" : ""}');
    } catch (e) {
      debugPrint('E2EE: Migration flag NOT found, readAll failed: $e');
    }

    await resetAllSessions();
    await _secureStorage.write(key: 'e2ee_session_migration_v1', value: 'done');

    // Readback verification for migration flag
    final readback = await _secureStorage.read(key: 'e2ee_session_migration_v1');
    if (readback == null) {
      debugPrint('E2EE: ⚠ CRITICAL — migration flag readback is NULL immediately '
          'after write! Secure storage writes are NOT persisting. This device '
          'will regenerate keys on every app restart.');
    }

    debugPrint('E2EE: One-time session migration — all sessions reset');
    return true;
  }

  /// Reset all sessions. Used during key bundle re-generation or
  /// device-level key wipe.
  Future<void> resetAllSessions() async {
    final all = await _secureStorage.readAll();
    for (final key in all.keys) {
      if (key.startsWith(_sessionPrefix)) {
        await _secureStorage.delete(key: key);
      }
    }
  }

  /// Get the peer's identity public key (base64) stored in the session.
  ///
  /// Returns `null` if no session exists or the session predates the
  /// `peerIdentityKey` field (legacy sessions).
  Future<String?> getPeerIdentityKey(String userId) async {
    final session = await _loadSession(userId);
    return session?.peerIdentityKey;
  }

  /// Check whether the peer's identity key has changed since the session
  /// was established. Returns `true` if the session should be reset.
  ///
  /// [currentPeerIdentityKey] is the peer's current identity public key
  /// (base64) as known from their Firestore key bundle.
  Future<bool> isPeerKeyStale(
    String userId,
    String currentPeerIdentityKey,
  ) async {
    final session = await _loadSession(userId);
    if (session == null) return false; // no session → will establish fresh
    if (session.peerIdentityKey == null) return false; // legacy session
    return session.peerIdentityKey != currentPeerIdentityKey;
  }

  // ===========================================================================
  // RECEIVER-SIDE X3DH
  // ===========================================================================

  /// Returns a record containing the new session and the public key of the
  /// consumed OTK (if any), so the caller can remove it from local storage.
  Future<({_DoubleRatchetSession session, String? consumedOtkPublicKey})>
      _performReceiverX3DH(
    String senderUserId,
    Map<String, dynamic> x3dhHeader,
    Uint8List? peerDhPublic,
  ) async {
    final ourBundle = await _keyManagementService.loadPrivateKeys();
    if (ourBundle == null) {
      throw StateError('E2EE: No local key bundle for receiver X3DH');
    }

    final ourIdentityPrivate =
        base64Decode(ourBundle.identityKeyPair.split('|')[0]);
    final ourSignedPreKeyPrivate =
        base64Decode(ourBundle.signedPreKey.split('|')[0]);

    final theirIdentityPub =
        base64Decode(x3dhHeader['identityKey'] as String);
    final theirEphemeralPub =
        base64Decode(x3dhHeader['ephemeralKey'] as String);

    // Verify Ed25519 signature on our signed pre-key if the sender included
    // verification data. This is self-verification that our own bundle is intact.
    // (The sender already verified the signature before using our pre-key.)

    // Compute DH secrets (reversed roles)
    // DH1 = DH(ourSignedPreKeyPriv, theirIdentityPub)
    final dh1 = await _cryptoService.diffieHellman(
        ourSignedPreKeyPrivate, theirIdentityPub);
    // DH2 = DH(ourIdentityPriv, theirEphemeralPub)
    final dh2 = await _cryptoService.diffieHellman(
        ourIdentityPrivate, theirEphemeralPub);
    // DH3 = DH(ourSignedPreKeyPriv, theirEphemeralPub)
    final dh3 = await _cryptoService.diffieHellman(
        ourSignedPreKeyPrivate, theirEphemeralPub);

    // DH4 = DH(ourOtkPriv, theirEphemeralPub) [if OTK was used]
    // Gap 11 fix: match OTK by public key content instead of fragile array index
    Uint8List? dh4;
    final otkPublicKey = x3dhHeader['oneTimePreKeyPublicKey'] as String?;
    // Log all local OTK public keys for correlation with sender logs
    debugPrint('E2EE RECV-X3DH [$senderUserId]: looking for OTK '
        '${otkPublicKey != null ? "${otkPublicKey.substring(0, 12)}…" : "null"} '
        'in ${ourBundle.oneTimePreKeys.length} local OTKs:');
    for (var i = 0; i < ourBundle.oneTimePreKeys.length; i++) {
      final pub = ourBundle.oneTimePreKeys[i].split('|')[1];
      debugPrint('  OTK[$i] = ${pub.substring(0, 12)}… '
          '${pub == otkPublicKey ? "← MATCH" : ""}');
    }
    // Also support legacy 'oneTimePreKeyId' (int index) for backward compatibility
    final legacyOtkId = (x3dhHeader['oneTimePreKeyId'] as num?)?.toInt();
    if (otkPublicKey != null) {
      // Content-based matching: find the OTK whose public key matches
      for (final otkEncoded in ourBundle.oneTimePreKeys) {
        final pubPart = otkEncoded.split('|')[1];
        if (pubPart == otkPublicKey) {
          final otkPrivate = base64Decode(otkEncoded.split('|')[0]);
          dh4 = await _cryptoService.diffieHellman(otkPrivate, theirEphemeralPub);
          break;
        }
      }
      if (dh4 == null) {
        debugPrint('E2EE WARN [$senderUserId]: OTK public key from x3dhHeader '
            'not found in local OTK bundle (${ourBundle.oneTimePreKeys.length} '
            'keys available). Key may have been consumed or bundle regenerated.');
        // Sender computed DH4 with this OTK but we can't — master secrets
        // will ALWAYS differ. This message is permanently undecryptable.
        throw PermanentDecryptionError(
          'E2EE: OTK mismatch with $senderUserId — sender used OTK '
          '${otkPublicKey.substring(0, 8)}… which is not in our local bundle. '
          'Sender\'s master secret includes DH4 but ours cannot. '
          'This message is permanently undecryptable.',
        );
      }
    } else if (legacyOtkId != null && ourBundle.oneTimePreKeys.length > legacyOtkId) {
      // Legacy index-based fallback
      final otkPrivate =
          base64Decode(ourBundle.oneTimePreKeys[legacyOtkId].split('|')[0]);
      dh4 = await _cryptoService.diffieHellman(otkPrivate, theirEphemeralPub);
    }

    // Log OUR public keys (derived from local private keys) alongside the
    // sender's keys. If our public keys DON'T match what the sender fetched
    // from the server, that means our key bundle was regenerated since the
    // sender established their session → master secrets will differ → MAC fail.
    final ourIdentityPublic = base64Decode(ourBundle.identityKeyPair.split('|')[1]);
    final ourSignedPreKeyPublic = base64Decode(ourBundle.signedPreKey.split('|')[1]);
    debugPrint('E2EE RECV-X3DH [$senderUserId]: '
        'ourIdPub=${_fp(ourIdentityPublic)} '
        'ourSPKPub=${_fp(ourSignedPreKeyPublic)} '
        'ourOTKCount=${ourBundle.oneTimePreKeys.length} '
        'theirIdPub=${_fp(theirIdentityPub)} '
        'theirEphPub=${_fp(theirEphemeralPub)} '
        'otkMatch=${dh4 != null} '
        'otkRequested=$otkPublicKey');

    // Concatenate master secret
    final masterSecretLength =
        dh1.length + dh2.length + dh3.length + (dh4?.length ?? 0);
    final masterSecret = Uint8List(masterSecretLength);
    var offset = 0;
    masterSecret.setRange(offset, offset + dh1.length, dh1);
    offset += dh1.length;
    masterSecret.setRange(offset, offset + dh2.length, dh2);
    offset += dh2.length;
    masterSecret.setRange(offset, offset + dh3.length, dh3);
    offset += dh3.length;
    if (dh4 != null) {
      masterSecret.setRange(offset, offset + dh4.length, dh4);
    }

    // Derive keys
    final derived = await _cryptoService.hkdf(
      inputKeyMaterial: masterSecret,
      length: 64,
      salt: Uint8List(32),
      info: utf8.encode('X3DH-init'),
    );
    final rootKey = Uint8List.fromList(derived.sublist(0, 32));
    final recvChainKey = Uint8List.fromList(derived.sublist(32, 64));

    debugPrint('E2EE RECV-X3DH [$senderUserId]: '
        'masterSecret=${_fp(masterSecret)} '
        'rootKey=${_fp(rootKey)} recvCK=${_fp(recvChainKey)}');

    // Generate our DH ratchet key pair for send direction
    final dhSendKp = await _cryptoService.generateX25519KeyPair();

    // Guard: peerDhPublic is required for the send-side DH ratchet.
    // It comes from e2ee.dhPublicKey in the incoming message. If missing,
    // the sender's client didn't include it — can't derive sendChainKey.
    if (peerDhPublic == null) {
      throw StateError(
        'E2EE: peerDhPublic is null in receiver X3DH for $senderUserId — '
        'sender message is missing e2ee.dhPublicKey',
      );
    }

    // Perform DH ratchet for send direction so sendChainKey is properly
    // derived (not zeros). The initiator will perform the matching recv-side
    // ratchet when it sees our new dhSendPublic in the first reply message.
    final dhSendResult = await _cryptoService.diffieHellman(
      dhSendKp['privateKey']!, peerDhPublic,
    );
    final combinedSend = _concat(rootKey, dhSendResult);
    final derivedSend = await _cryptoService.hkdf(
      inputKeyMaterial: combinedSend,
      length: 64,
      info: utf8.encode('Ratchet'),
    );
    final sendRootKey = Uint8List.fromList(derivedSend.sublist(0, 32));
    final sendChainKey = Uint8List.fromList(derivedSend.sublist(32, 64));

    final session = _DoubleRatchetSession(
      rootKey: sendRootKey,
      sendChainKey: sendChainKey,
      recvChainKey: recvChainKey,
      dhSendPrivate: dhSendKp['privateKey']!,
      dhSendPublic: dhSendKp['publicKey']!,
      dhRecvPublic: peerDhPublic,
      isInitiator: false,
      peerX3dhEphemeralKey: x3dhHeader['ephemeralKey'] as String?,
      peerIdentityKey: x3dhHeader['identityKey'] as String?,
    );

    // NOTE: Do NOT save the session here. The session must only be persisted
    // after decrypt succeeds in decryptP2P. If we save here and decrypt fails
    // (MAC error from wrong keys), a corrupt receiver-side session is left in
    // secure storage. When the user next sends a message, encryptP2P may find
    // this corrupt session and use it — producing a message without x3dhHeader
    // that the recipient can never decrypt ("Session expired").
    return (session: session, consumedOtkPublicKey: otkPublicKey);
  }

  // ===========================================================================
  // DOUBLE RATCHET HELPERS
  // ===========================================================================

  Future<Uint8List> _deriveMessageKey(Uint8List chainKey) async {
    return _cryptoService.hkdf(
      inputKeyMaterial: chainKey,
      length: 32,
      info: utf8.encode('MsgKey'),
    );
  }

  Future<Uint8List> _ratchetChainKey(Uint8List chainKey) async {
    return _cryptoService.hkdf(
      inputKeyMaterial: chainKey,
      length: 32,
      info: utf8.encode('ChainKey'),
    );
  }

  Future<void> _skipRecvKeys(
    _DoubleRatchetSession session,
    int currentNum,
    int targetNum,
  ) async {
    // Don't skip more than _maxSkippedKeys to prevent DoS
    final toSkip = targetNum - currentNum;
    if (toSkip > _maxSkippedKeys) return;

    for (var i = currentNum; i < targetNum; i++) {
      final key = await _deriveMessageKey(session.recvChainKey);
      final lookup =
          '${base64Encode(session.dhRecvPublic!)}:$i';
      session.skippedKeys[lookup] = key;
      session.recvChainKey = await _ratchetChainKey(session.recvChainKey);
    }
    _pruneSkippedKeys(session);
  }

  void _pruneSkippedKeys(_DoubleRatchetSession session) {
    while (session.skippedKeys.length > _maxSkippedKeys) {
      session.skippedKeys.remove(session.skippedKeys.keys.first);
    }
  }

  Future<String> _decryptWithKey(String ciphertextBase64, Uint8List messageKey) async {
    final encrypted = base64Decode(ciphertextBase64);
    // Format: nonce(12) || ciphertext || mac(16) — minimum 28 bytes
    if (encrypted.length < 28) {
      throw StateError('E2EE: ciphertext too short (${encrypted.length} bytes)');
    }
    final nonce = Uint8List.fromList(encrypted.sublist(0, 12));
    final ciphertextWithMac = Uint8List.fromList(encrypted.sublist(12));
    final plaintext = await _cryptoService.decrypt(
      ciphertextWithMac,
      messageKey,
      nonce: nonce,
    );
    return utf8.decode(plaintext);
  }

  // ===========================================================================
  // SESSION PERSISTENCE
  // ===========================================================================

  Future<void> _saveSession(String userId, _DoubleRatchetSession session) async {
    final json = jsonEncode(session.toJson());
    await _secureStorage.write(key: '$_sessionPrefix$userId', value: json);
  }

  Future<_DoubleRatchetSession?> _loadSession(String userId) async {
    final stored = await _secureStorage.read(key: '$_sessionPrefix$userId');
    if (stored == null) return null;
    return _DoubleRatchetSession.fromJson(
        jsonDecode(stored) as Map<String, dynamic>);
  }

  // ===========================================================================
  // BYTE HELPERS
  // ===========================================================================

  Uint8List _concat(Uint8List a, Uint8List b) {
    final result = Uint8List(a.length + b.length);
    result.setRange(0, a.length, a);
    result.setRange(a.length, result.length, b);
    return result;
  }

  bool _bytesEqual(Uint8List a, Uint8List? b) {
    if (b == null) return false;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

// =============================================================================
// DOUBLE RATCHET SESSION STATE
// =============================================================================

class _DoubleRatchetSession {
  Uint8List rootKey;
  Uint8List sendChainKey;
  Uint8List recvChainKey;
  Uint8List dhSendPrivate;
  Uint8List dhSendPublic;
  Uint8List? dhRecvPublic;
  int sendMessageNumber;
  int recvMessageNumber;
  int previousChainLength;
  Map<String, Uint8List> skippedKeys;
  bool isInitiator;
  String? pendingIdentityKey;
  String? pendingEphemeralKey;
  String? pendingOtkPublicKey;

  /// The ephemeral key from the x3dhHeader that established this session.
  /// Used to detect when the peer re-established with new keys — if a new
  /// x3dhHeader arrives with a different ephemeral key, receiver X3DH must
  /// be re-performed to pick up the new session keys.
  String? peerX3dhEphemeralKey;

  /// The peer's identity public key (base64) at the time the session was
  /// established. Used to detect when the peer has regenerated their key
  /// bundle — if their current identity key differs from this, the session
  /// is stale and must be re-established.
  String? peerIdentityKey;

  _DoubleRatchetSession({
    required this.rootKey,
    required this.sendChainKey,
    required this.recvChainKey,
    required this.dhSendPrivate,
    required this.dhSendPublic,
    this.dhRecvPublic,
    this.sendMessageNumber = 0,
    this.recvMessageNumber = 0,
    this.previousChainLength = 0,
    Map<String, Uint8List>? skippedKeys,
    this.isInitiator = false,
    this.pendingIdentityKey,
    this.pendingEphemeralKey,
    this.pendingOtkPublicKey,
    this.peerX3dhEphemeralKey,
    this.peerIdentityKey,
  }) : skippedKeys = skippedKeys ?? {};

  Map<String, dynamic> toJson() {
    return {
      'rootKey': base64Encode(rootKey),
      'sendChainKey': base64Encode(sendChainKey),
      'recvChainKey': base64Encode(recvChainKey),
      'dhSendPrivate': base64Encode(dhSendPrivate),
      'dhSendPublic': base64Encode(dhSendPublic),
      'dhRecvPublic': dhRecvPublic != null ? base64Encode(dhRecvPublic!) : null,
      'sendMessageNumber': sendMessageNumber,
      'recvMessageNumber': recvMessageNumber,
      'previousChainLength': previousChainLength,
      'skippedKeys': skippedKeys
          .map((k, v) => MapEntry(k, base64Encode(v))),
      'isInitiator': isInitiator,
      'pendingIdentityKey': pendingIdentityKey,
      'pendingEphemeralKey': pendingEphemeralKey,
      'pendingOtkPublicKey': pendingOtkPublicKey,
      'peerX3dhEphemeralKey': peerX3dhEphemeralKey,
      'peerIdentityKey': peerIdentityKey,
    };
  }

  factory _DoubleRatchetSession.fromJson(Map<String, dynamic> json) {
    final skippedRaw = json['skippedKeys'] as Map<String, dynamic>? ?? {};
    return _DoubleRatchetSession(
      rootKey: base64Decode(json['rootKey'] as String),
      sendChainKey: base64Decode(json['sendChainKey'] as String),
      recvChainKey: base64Decode(json['recvChainKey'] as String),
      dhSendPrivate: base64Decode(json['dhSendPrivate'] as String),
      dhSendPublic: base64Decode(json['dhSendPublic'] as String),
      dhRecvPublic: json['dhRecvPublic'] != null
          ? base64Decode(json['dhRecvPublic'] as String)
          : null,
      sendMessageNumber: json['sendMessageNumber'] as int? ?? 0,
      recvMessageNumber: json['recvMessageNumber'] as int? ?? 0,
      previousChainLength: json['previousChainLength'] as int? ?? 0,
      skippedKeys: skippedRaw
          .map((k, v) => MapEntry(k, base64Decode(v as String))),
      isInitiator: json['isInitiator'] as bool? ?? false,
      pendingIdentityKey: json['pendingIdentityKey'] as String?,
      pendingEphemeralKey: json['pendingEphemeralKey'] as String?,
      pendingOtkPublicKey: json['pendingOtkPublicKey'] as String?,
      peerX3dhEphemeralKey: json['peerX3dhEphemeralKey'] as String?,
      peerIdentityKey: json['peerIdentityKey'] as String?,
    );
  }
}
