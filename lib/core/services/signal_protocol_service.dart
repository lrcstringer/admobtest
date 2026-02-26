import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../concurrency/keyed_mutex.dart';
import '../e2ee/permanent_decryption_error.dart';
import '../e2ee/ratchet/double_ratchet.dart';
import '../e2ee/ratchet/x3dh.dart';
import '../e2ee/session/double_ratchet_session.dart';
import '../e2ee/session/secure_storage_session_store.dart';
import '../e2ee/session/session_store.dart';
import 'crypto_service.dart';
import 'key_management_service.dart';

export '../e2ee/permanent_decryption_error.dart';

/// Implements the Signal Protocol for peer-to-peer encrypted messaging.
///
/// Handles X3DH key agreement for session establishment and Double Ratchet
/// for ongoing message encryption/decryption.
@lazySingleton
class SignalProtocolService {
  final KeyManagementService _keyManagementService;
  final SessionStore _sessionStore;
  final DoubleRatchet _ratchet;
  final X3dhProtocol _x3dh;

  SignalProtocolService(
    this._keyManagementService,
    CryptoService cryptoService,
    FlutterSecureStorage secureStorage,
  )   : _sessionStore = SecureStorageSessionStore(secureStorage),
        _ratchet = DoubleRatchet(cryptoService),
        _x3dh = X3dhProtocol(cryptoService);

  /// Per-recipient session lock. Serializes ALL session-mutating operations
  /// (encrypt, decrypt, establish) for the same peer.
  ///
  /// Why a single shared lock for both encrypt and decrypt:
  /// - The DH ratchet step during decrypt mutates rootKey, dhSendPrivate,
  ///   dhSendPublic, and sendChainKey — the same fields encrypt reads/writes.
  /// - Two concurrent encrypts must see sequential sendMessageNumber values.
  /// - Two concurrent decrypts must see sequential recvMessageNumber values.
  /// - An interleaved encrypt + decrypt would corrupt the shared root key.
  final _sessionLock = KeyedMutex();

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
    final ephemeralKp = await _x3dh.generateKeyPair();

    // 3. Fetch recipient's public key bundle
    final theirBundle =
        await _keyManagementService.fetchKeyBundle(recipientUserId);
    final theirIdentityKey = base64Decode(theirBundle.identityKey);
    final theirSignedPreKey = base64Decode(theirBundle.signedPreKey);

    // Verify Ed25519 signature on the signed pre-key (REQUIRED).
    // Without this, a server-side attacker could substitute their own SPK
    // and perform a MITM attack on the X3DH key agreement.
    if (theirBundle.ed25519IdentityKey == null ||
        theirBundle.ed25519Signature == null) {
      throw StateError(
        'E2EE: Key bundle for $recipientUserId is missing Ed25519 fields — '
        'cannot verify signed pre-key authenticity. '
        'Bundle may be corrupted or from an incompatible version.',
      );
    }
    final ed25519PubKey = base64Decode(theirBundle.ed25519IdentityKey!);
    final ed25519Sig = base64Decode(theirBundle.ed25519Signature!);
    final valid = await _x3dh.verifySignedPreKey(
      theirSignedPreKey, ed25519Sig, ed25519PubKey,
    );
    if (!valid) {
      throw StateError(
        'E2EE: Signed pre-key signature verification failed for $recipientUserId — '
        'possible MITM attack',
      );
    }

    // 4-6. Compute X3DH shared secret (SK) — 32 bytes per spec
    String? consumedOtkPublicKey;
    Uint8List? theirOtk;
    if (theirBundle.oneTimePreKeys.isNotEmpty) {
      theirOtk = base64Decode(theirBundle.oneTimePreKeys.first);
      consumedOtkPublicKey = theirBundle.oneTimePreKeys.first;
    }

    final sk = await _x3dh.computeInitiatorSharedSecret(
      ourIdentityPrivate: ourIdentityPrivate,
      ourEphemeralPrivate: ephemeralKp['privateKey']!,
      theirIdentityKey: theirIdentityKey,
      theirSignedPreKey: theirSignedPreKey,
      theirOneTimePreKey: theirOtk,
    );

    // 7. Generate initial DH ratchet key pair for sending
    final dhSendKp = await _x3dh.generateKeyPair();

    // 8. Derive initial root key + send chain key via KDF_RK(SK, DH(dhSend, theirSPK))
    // Per Signal spec: initiator's first DH ratchet uses SK as the root key
    // and DH(our new ratchet key, their signed pre-key) as input.
    final initial = await _ratchet.kdfRk(
      sk,
      dhSendKp['privateKey']!,
      theirSignedPreKey,
    );

    // 9. Create Double Ratchet session
    final session = DoubleRatchetSession(
      rootKey: initial.rootKey,
      sendChainKey: initial.chainKey,
      // Sentinel: zero-initialized recvChainKey. Overwritten by the first DH
      // ratchet step when the responder sends their first message. If somehow
      // used directly, AES-GCM MAC verification would fail safely.
      recvChainKey: Uint8List(32),
      dhSendPrivate: dhSendKp['privateKey']!,
      dhSendPublic: dhSendKp['publicKey']!,
      dhRecvPublic: theirSignedPreKey,
      isInitiator: true,
      pendingIdentityKey: base64Encode(ourIdentityPublic),
      pendingEphemeralKey: base64Encode(ephemeralKp['publicKey']!),
      pendingOtkPublicKey: consumedOtkPublicKey,
      peerIdentityKey: base64Encode(theirIdentityKey),
      ourIdentityKey: base64Encode(ourIdentityPublic),
    );

    CryptoService.e2eeLog('E2EE INIT-SEND [$recipientUserId]: '
        'rootKey=${_fp(initial.rootKey)} sendCK=${_fp(initial.chainKey)} '
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
  ) {
    return _sessionLock.protect(
      recipientUserId,
      () => _encryptP2PImpl(recipientUserId, plaintext),
    );
  }

  static const _sessionTtl = Duration(days: 30);
  static const _maxMessageNumber = 1 << 31;

  Future<Map<String, dynamic>> _encryptP2PImpl(
    String recipientUserId,
    String plaintext,
  ) async {
    // Load or establish session
    var session = await _loadSession(recipientUserId);

    // Re-establish only when:
    //  1. No session exists at all
    //  2. Session TTL expired (Issue 11)
    //  3. Send message number overflow (Issue 12)
    if (session == null ||
        DateTime.now().difference(session.createdAt) > _sessionTtl ||
        session.sendMessageNumber >= _maxMessageNumber) {
      if (session != null) {
        CryptoService.e2eeLog('E2EE ENCRYPT [$recipientUserId]: Re-establishing session '
            '(TTL expired or message number overflow)');
      }
      await establishSession(recipientUserId);
      session = await _loadSession(recipientUserId);
      if (session == null) {
        throw StateError('E2EE: Failed to establish session');
      }
    }

    // Derive message key from send chain key
    final messageKey = await _ratchet.deriveMessageKey(session.sendChainKey);

    // Ratchet send chain key forward
    session.sendChainKey = await _ratchet.ratchetChainKey(session.sendChainKey);

    // Compute Associated Data per Signal spec (Issue 4)
    final ad = _computeAssociatedData(
      session,
      dhPublicKey: session.dhSendPublic,
      messageNumber: session.sendMessageNumber,
      previousChainLength: session.previousChainLength,
    );

    // Encrypt with AES-256-GCM + AD
    final encrypted = await _ratchet.encrypt(plaintext, messageKey, aad: ad);

    // Zeroize message key after use (Issue 9)
    CryptoService.zeroize(messageKey);

    CryptoService.e2eeLog('E2EE ENCRYPT [$recipientUserId]: '
        'msgNum=${session.sendMessageNumber} '
        'sendCK=${_fp(session.sendChainKey)} '
        'dhSendPub=${_fp(session.dhSendPublic)} '
        'isInitiator=${session.isInitiator} '
        'hasX3DH=${session.pendingIdentityKey != null}');

    // Build result
    final result = <String, dynamic>{
      'ciphertext': base64Encode(encrypted),
      'e2ee': {
        'protocol': 'signal-v1',
        'messageNumber': session.sendMessageNumber,
        'previousChainLength': session.previousChainLength,
        'dhPublicKey': base64Encode(session.dhSendPublic),
      },
    };

    // Include X3DH header only on initiator sessions (they have the
    // ephemeral key material). Receiver sessions send without x3dhHeader —
    // the peer already has a session from their own X3DH initiation.
    // If the peer reinstalls, they send the first message (as initiator
    // with x3dhHeader), triggering receiver X3DH on our side.
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
  ) {
    return _sessionLock.protect(
      senderUserId,
      () => _decryptP2PImpl(senderUserId, encryptedMessage),
    );
  }

  Future<String> _decryptP2PImpl(
    String senderUserId,
    Map<String, dynamic> encryptedMessage,
  ) async {
    final ciphertextBase64 = encryptedMessage['ciphertext'] as String;
    final e2ee = encryptedMessage['e2ee'] as Map<String, dynamic>?;
    final x3dhHeader =
        encryptedMessage['x3dhHeader'] as Map<String, dynamic>?;

    final messageNumber = (e2ee?['messageNumber'] as num?)?.toInt() ?? 0;
    final previousChainLength = (e2ee?['previousChainLength'] as num?)?.toInt() ?? 0;
    final peerDhPublicBase64 = e2ee?['dhPublicKey'] as String?;
    final peerDhPublic =
        peerDhPublicBase64 != null ? base64Decode(peerDhPublicBase64) : null;

    CryptoService.e2eeLog('E2EE DECRYPT-START [$senderUserId]: '
        'msgNum=$messageNumber '
        'hasE2ee=${e2ee != null} '
        'hasX3DH=${x3dhHeader != null} '
        'peerDhPub=${peerDhPublic != null ? _fp(peerDhPublic) : "null"} '
        'ciphertextLen=${ciphertextBase64.length}');

    var session = await _loadSession(senderUserId);

    CryptoService.e2eeLog('E2EE DECRYPT-SESSION [$senderUserId]: '
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
      CryptoService.e2eeLog('E2EE: Performing receiver X3DH for $senderUserId '
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
      // Compute AD for this skipped message
      final ad = peerDhPublic != null
          ? _computeAssociatedData(
              session,
              dhPublicKey: peerDhPublic,
              messageNumber: messageNumber,
              previousChainLength: previousChainLength,
            )
          : Uint8List(0);
      // Decrypt BEFORE saving — if it fails, the on-disk session still
      // has the skipped key so we can retry.
      final plaintext = await _ratchet.decrypt(ciphertextBase64, messageKey, aad: ad);
      CryptoService.zeroize(messageKey);
      await _saveSession(senderUserId, session);
      return plaintext;
    }

    // DH ratchet step if peer's DH key changed
    if (peerDhPublic != null && !_ratchet.bytesEqual(peerDhPublic, session.dhRecvPublic)) {
      await _ratchet.performDhRatchetStep(session, peerDhPublic, previousChainLength);
    }

    // Guard: recv message number overflow (Issue 12)
    if (session.recvMessageNumber >= _maxMessageNumber) {
      throw StateError(
        'E2EE: Recv message number overflow — session must be re-established',
      );
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
    await _ratchet.skipRecvKeys(session, session.recvMessageNumber, messageNumber);
    session.recvMessageNumber = messageNumber;

    // Derive message key for this message
    final messageKey = await _ratchet.deriveMessageKey(session.recvChainKey);

    CryptoService.e2eeLog('E2EE DECRYPT-KEY [$senderUserId]: '
        'msgNum=$messageNumber '
        'recvCK=${_fp(session.recvChainKey)} '
        'dhRecvPub=${_fp(session.dhRecvPublic)}');

    session.recvChainKey = await _ratchet.ratchetChainKey(session.recvChainKey);
    session.recvMessageNumber++;

    // Compute AD for this message
    final ad = peerDhPublic != null
        ? _computeAssociatedData(
            session,
            dhPublicKey: peerDhPublic,
            messageNumber: messageNumber,
            previousChainLength: previousChainLength,
          )
        : Uint8List(0);

    // Decrypt BEFORE saving session. If AES-GCM auth fails, the session
    // state is NOT persisted, so the chain doesn't advance past this
    // message — allowing retry when the correct session is established.
    final plaintext = await _ratchet.decrypt(ciphertextBase64, messageKey, aad: ad);

    // Zeroize message key after successful decrypt (Issue 9)
    CryptoService.zeroize(messageKey);

    // NOTE: We deliberately do NOT clear pendingIdentityKey/pendingEphemeralKey
    // here. Keeping the X3DH header on every outgoing message ensures that if
    // the peer regenerates their key bundle (reinstall, data clear, etc.),
    // they can always perform a fresh receiver-side X3DH and recover the
    // session. The receiver already ignores duplicate x3dhHeaders when the
    // ephemeral key matches (peerX3dhEphemeralKey check in decryptP2P).
    if (session.pendingIdentityKey != null) {
      CryptoService.e2eeLog('E2EE: Decrypt succeeded with $senderUserId — keeping X3DH header for future messages');
    }

    await _saveSession(senderUserId, session);

    // Remove the consumed OTK from local storage so the local count stays
    // in sync with the server (server atomically removes it during fetchKeyBundle).
    // Awaited deliberately: a fire-and-forget removal can complete while a
    // concurrent decryptP2P call's X3DH retry is reading the OTK bundle,
    // producing an OTK mismatch → PermanentDecryptionError → sentinel overwrite.
    if (consumedOtkPublicKey != null) {
      await _keyManagementService.removeConsumedOtk(consumedOtkPublicKey);
    }

    return plaintext;
  }

  /// Check whether an active Double Ratchet session exists with [userId].
  Future<bool> hasSession(String userId) async {
    return _sessionStore.exists(userId);
  }

  /// Reset the session with [userId], deleting all local state.
  ///
  /// The next message exchange will trigger a fresh X3DH handshake.
  /// Use this when decryption failures indicate a corrupted session.
  Future<void> resetSession(String userId) async {
    await _sessionStore.delete(userId);
  }

  /// Wipe ALL Double Ratchet sessions from secure storage.
  ///
  /// Called on fresh key generation (identity key changed). Any session
  /// that survived reinstall via EncryptedSharedPreferences is now stale:
  /// the old identity/signed-pre-key material is gone, so those sessions
  /// cannot encrypt correctly and the X3DH header they carry references
  /// keys the peer will no longer recognise.
  Future<void> clearAllSessions() async {
    try {
      final count = await _sessionStore.sessionCount();
      await _sessionStore.deleteAll();
      CryptoService.e2eeLog('E2EE: Cleared $count stale session(s) '
          'after identity key regeneration');
    } catch (e) {
      // Non-fatal — sessions will be re-established on next send/receive.
      CryptoService.e2eeLog('E2EE: clearAllSessions failed (non-fatal): $e');
    }
  }

  /// One-time migration: reset sessions corrupted by the legacy
  /// peerX3dhEphemeralKey bug. Returns true if migration was performed.
  Future<bool> migrateResetCorruptedSessions() async {
    final migrated =
        await _sessionStore.readMeta('e2ee_session_migration_v2');
    if (migrated != null) {
      CryptoService.e2eeLog('E2EE: Session migration already done (flag present)');
      return false;
    }

    // Diagnostic: check total session count to understand if this is
    // a first launch or if storage was wiped by app reinstall.
    try {
      final count = await _sessionStore.sessionCount();
      CryptoService.e2eeLog('E2EE: Migration flag NOT found — sessions: $count. '
          '${count == 0 ? "Storage is EMPTY (first launch or wiped by reinstall)" : ""}');
    } catch (e) {
      CryptoService.e2eeLog('E2EE: Migration flag NOT found, sessionCount failed: $e');
    }

    await resetAllSessions();
    await _sessionStore.writeMeta('e2ee_session_migration_v2', 'done');

    // Readback verification for migration flag
    final readback =
        await _sessionStore.readMeta('e2ee_session_migration_v2');
    if (readback == null) {
      CryptoService.e2eeLog('E2EE: ⚠ CRITICAL — migration flag readback is NULL immediately '
          'after write! Secure storage writes are NOT persisting. This device '
          'will regenerate keys on every app restart.');
    }

    CryptoService.e2eeLog('E2EE: One-time session migration — all sessions reset');
    return true;
  }

  /// Reset all sessions. Used during key bundle re-generation or
  /// device-level key wipe.
  Future<void> resetAllSessions() async {
    await _sessionStore.deleteAll();
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
  // ASSOCIATED DATA (AD)
  // ===========================================================================

  /// Compute Associated Data for AEAD encryption per Signal spec.
  ///
  /// AD = senderIdentityKey || receiverIdentityKey || dhPublicKey
  ///      || messageNumber (4 bytes big-endian)
  ///      || previousChainLength (4 bytes big-endian)
  ///
  /// Returns empty AD for legacy sessions where identity keys are unknown,
  /// ensuring graceful degradation.
  Uint8List _computeAssociatedData(
    DoubleRatchetSession session, {
    required Uint8List dhPublicKey,
    required int messageNumber,
    required int previousChainLength,
  }) {
    final ourIdKey = session.ourIdentityKey;
    final peerIdKey = session.peerIdentityKey;
    if (ourIdKey == null || peerIdKey == null) {
      // Legacy session — cannot compute AD, return empty
      return Uint8List(0);
    }

    final senderKey = session.isInitiator
        ? base64Decode(ourIdKey)
        : base64Decode(peerIdKey);
    final receiverKey = session.isInitiator
        ? base64Decode(peerIdKey)
        : base64Decode(ourIdKey);

    // Encode message header fields as fixed-width big-endian integers
    final msgNumBytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, messageNumber, Endian.big);
    final prevChainBytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, previousChainLength, Endian.big);

    // AD = senderIdentity || receiverIdentity || dhPublicKey || msgNum || prevChainLen
    final ad = Uint8List(
      senderKey.length + receiverKey.length + dhPublicKey.length + 4 + 4,
    );
    var offset = 0;
    ad.setRange(offset, offset + senderKey.length, senderKey);
    offset += senderKey.length;
    ad.setRange(offset, offset + receiverKey.length, receiverKey);
    offset += receiverKey.length;
    ad.setRange(offset, offset + dhPublicKey.length, dhPublicKey);
    offset += dhPublicKey.length;
    ad.setRange(offset, offset + 4, msgNumBytes);
    offset += 4;
    ad.setRange(offset, offset + 4, prevChainBytes);
    return ad;
  }

  // ===========================================================================
  // RECEIVER-SIDE X3DH
  // ===========================================================================

  /// Returns a record containing the new session and the public key of the
  /// consumed OTK (if any), so the caller can remove it from local storage.
  Future<({DoubleRatchetSession session, String? consumedOtkPublicKey})>
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

    // Resolve OTK private key from header (content-based matching)
    final otkPublicKey = x3dhHeader['oneTimePreKeyPublicKey'] as String?;
    CryptoService.e2eeLog('E2EE RECV-X3DH [$senderUserId]: looking for OTK '
        '${otkPublicKey != null ? "${otkPublicKey.substring(0, 12)}…" : "null"} '
        'in ${ourBundle.oneTimePreKeys.length} local OTKs:');
    for (var i = 0; i < ourBundle.oneTimePreKeys.length; i++) {
      final pub = ourBundle.oneTimePreKeys[i].split('|')[1];
      CryptoService.e2eeLog('  OTK[$i] = ${pub.substring(0, 12)}… '
          '${pub == otkPublicKey ? "← MATCH" : ""}');
    }

    Uint8List? ourOtkPrivate;
    final legacyOtkId = (x3dhHeader['oneTimePreKeyId'] as num?)?.toInt();
    if (otkPublicKey != null) {
      for (final otkEncoded in ourBundle.oneTimePreKeys) {
        final pubPart = otkEncoded.split('|')[1];
        if (pubPart == otkPublicKey) {
          ourOtkPrivate = base64Decode(otkEncoded.split('|')[0]);
          break;
        }
      }
      if (ourOtkPrivate == null) {
        CryptoService.e2eeLog('E2EE WARN [$senderUserId]: OTK public key from x3dhHeader '
            'not found in local OTK bundle (${ourBundle.oneTimePreKeys.length} '
            'keys available). Key may have been consumed or bundle regenerated.');
        throw PermanentDecryptionError(
          'E2EE: OTK mismatch with $senderUserId — sender used OTK '
          '${otkPublicKey.substring(0, 8)}… which is not in our local bundle. '
          'Sender\'s master secret includes DH4 but ours cannot. '
          'This message is permanently undecryptable.',
        );
      }
    } else if (legacyOtkId != null) {
      throw PermanentDecryptionError(
        'E2EE: Legacy OTK index ($legacyOtkId) from $senderUserId cannot be '
        'safely resolved — bundle may have changed since session was established. '
        'This message is permanently undecryptable.',
      );
    }

    // Compute receiver-side X3DH shared secret (SK) — 32 bytes per spec
    final ourIdentityPublic = base64Decode(ourBundle.identityKeyPair.split('|')[1]);
    final ourSignedPreKeyPublic = base64Decode(ourBundle.signedPreKey.split('|')[1]);
    CryptoService.e2eeLog('E2EE RECV-X3DH [$senderUserId]: '
        'ourIdPub=${_fp(ourIdentityPublic)} '
        'ourSPKPub=${_fp(ourSignedPreKeyPublic)} '
        'ourOTKCount=${ourBundle.oneTimePreKeys.length} '
        'theirIdPub=${_fp(theirIdentityPub)} '
        'theirEphPub=${_fp(theirEphemeralPub)} '
        'otkMatch=${ourOtkPrivate != null} '
        'otkRequested=$otkPublicKey');

    final sk = await _x3dh.computeReceiverSharedSecret(
      ourIdentityPrivate: ourIdentityPrivate,
      ourSignedPreKeyPrivate: ourSignedPreKeyPrivate,
      theirIdentityPub: theirIdentityPub,
      theirEphemeralPub: theirEphemeralPub,
      ourOtkPrivate: ourOtkPrivate,
    );

    // Guard: peerDhPublic is required for the DH ratchet steps.
    if (peerDhPublic == null) {
      throw StateError(
        'E2EE: peerDhPublic is null in receiver X3DH for $senderUserId — '
        'sender message is missing e2ee.dhPublicKey',
      );
    }

    // Receiver Double Ratchet initialization per Signal spec:
    // Step 1: KDF_RK(SK, DH(ourSPKPrivate, peerDhPublic)) → (RK1, recvChainKey)
    final recv = await _ratchet.kdfRk(sk, ourSignedPreKeyPrivate, peerDhPublic);

    // Step 2: Generate our DH ratchet key pair for send direction
    final dhSendKp = await _x3dh.generateKeyPair();

    // Step 3: KDF_RK(RK1, DH(dhSendPrivate, peerDhPublic)) → (RK2, sendChainKey)
    final send = await _ratchet.kdfRk(
      recv.rootKey,
      dhSendKp['privateKey']!,
      peerDhPublic,
    );

    CryptoService.e2eeLog('E2EE RECV-X3DH [$senderUserId]: '
        'rootKey=${_fp(send.rootKey)} recvCK=${_fp(recv.chainKey)} '
        'sendCK=${_fp(send.chainKey)}');

    final session = DoubleRatchetSession(
      rootKey: send.rootKey,
      sendChainKey: send.chainKey,
      recvChainKey: recv.chainKey,
      dhSendPrivate: dhSendKp['privateKey']!,
      dhSendPublic: dhSendKp['publicKey']!,
      dhRecvPublic: peerDhPublic,
      isInitiator: false,
      peerX3dhEphemeralKey: x3dhHeader['ephemeralKey'] as String?,
      peerIdentityKey: x3dhHeader['identityKey'] as String?,
      ourIdentityKey: base64Encode(ourIdentityPublic),
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
  // SESSION PERSISTENCE
  // ===========================================================================

  Future<void> _saveSession(String userId, DoubleRatchetSession session) async {
    await _sessionStore.save(userId, session);
  }

  Future<DoubleRatchetSession?> _loadSession(String userId) async {
    return _sessionStore.load(userId);
  }
}
