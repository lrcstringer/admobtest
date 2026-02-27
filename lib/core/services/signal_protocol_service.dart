import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../concurrency/keyed_mutex.dart';
import '../e2ee/permanent_decryption_error.dart';
import '../e2ee/protocol/double_ratchet.dart';
import '../e2ee/protocol/header.dart';
import '../e2ee/protocol/kdf.dart';
import '../e2ee/protocol/x3dh.dart';
import '../e2ee/session/secure_storage_session_store.dart';
import '../e2ee/session/session_record.dart';
import '../e2ee/session/session_state.dart';
import '../e2ee/session/session_store.dart';
import '../../domain/entities/e2ee_types.dart';
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

  late final SignalKdf _kdf;
  late final SpecDoubleRatchet _specRatchet;
  late final SpecX3dh _specX3dh;

  SignalProtocolService(
    this._keyManagementService,
    CryptoService cryptoService,
    FlutterSecureStorage secureStorage,
  ) : _sessionStore = SecureStorageSessionStore(secureStorage) {
    _kdf = SignalKdf(cryptoService);
    _specRatchet = SpecDoubleRatchet(cryptoService, _kdf);
    _specX3dh = SpecX3dh(cryptoService, _kdf);
  }

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

  static const _sessionTtl = Duration(days: 30);
  static const _maxMessageNumber = 1 << 31;

  // ===========================================================================
  // ENCRYPT
  // ===========================================================================

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
      () => _encryptImpl(recipientUserId, plaintext),
    );
  }

  Future<Map<String, dynamic>> _encryptImpl(
    String recipientUserId,
    String plaintext,
  ) async {
    // Check for existing session
    var record = await _sessionStore.loadRecord(recipientUserId);
    if (record != null && record.hasSession) {
      return _encryptWithRecord(recipientUserId, plaintext, record);
    }

    // No valid session — establish from peer's bundle
    final bundle = await _keyManagementService.fetchKeyBundle(recipientUserId);
    record = await _establishSession(recipientUserId, bundle);
    return _encryptWithRecord(recipientUserId, plaintext, record);
  }

  Future<Map<String, dynamic>> _encryptWithRecord(
    String recipientUserId,
    String plaintext,
    SessionRecord record,
  ) async {
    var session = record.activeSession;
    if (session == null) {
      throw StateError('E2EE: No active session for $recipientUserId');
    }

    // Re-establish if TTL expired or message number overflow
    if (DateTime.now().difference(session.createdAt) > _sessionTtl ||
        session.sendMessageNumber >= _maxMessageNumber) {
      CryptoService.e2eeLog('E2EE ENCRYPT [$recipientUserId]: Re-establishing '
          '(TTL expired or message number overflow)');
      final bundle =
          await _keyManagementService.fetchKeyBundle(recipientUserId);
      record = await _establishSession(recipientUserId, bundle);
      session = record.activeSession!;
    }

    // Encrypt using spec-compliant Double Ratchet
    final result = await _specRatchet.encrypt(session, plaintext);

    // Update session in record (immutable → replace)
    record.activeSession = result.state;

    CryptoService.e2eeLog('E2EE ENCRYPT [$recipientUserId]: '
        'msgNum=${result.header.messageNumber} '
        'dhPub=${_fp(result.header.dhRatchetKey)}');

    // Build wire format
    final output = <String, dynamic>{
      'ciphertext': base64Encode(result.ciphertext),
      'e2ee': {
        'protocol': 'signal-v2',
        'messageNumber': result.header.messageNumber,
        'previousChainLength': result.header.previousChainLength,
        'dhPublicKey': base64Encode(result.header.dhRatchetKey),
      },
    };

    // Include X3DH header on initiator sessions (kept until peer establishes)
    if (record.pendingX3dhHeader != null) {
      output['x3dhHeader'] = record.pendingX3dhHeader;
    }

    await _sessionStore.saveRecord(recipientUserId, record);
    return output;
  }

  // ===========================================================================
  // DECRYPT
  // ===========================================================================

  /// Decrypt an encrypted message from [senderUserId].
  Future<String> decryptP2P(
    String senderUserId,
    Map<String, dynamic> encryptedMessage,
  ) {
    return _sessionLock.protect(
      senderUserId,
      () => _decryptImpl(senderUserId, encryptedMessage),
    );
  }

  Future<String> _decryptImpl(
    String senderUserId,
    Map<String, dynamic> encryptedMessage,
  ) async {
    final ciphertextBase64 = encryptedMessage['ciphertext'] as String;
    final e2ee = encryptedMessage['e2ee'] as Map<String, dynamic>;
    final x3dhHeader =
        encryptedMessage['x3dhHeader'] as Map<String, dynamic>?;

    final messageNumber = (e2ee['messageNumber'] as num).toInt();
    final previousChainLength =
        (e2ee['previousChainLength'] as num?)?.toInt() ?? 0;
    final dhPublicKeyBase64 = e2ee['dhPublicKey'] as String;

    final ciphertext = base64Decode(ciphertextBase64);
    final header = MessageHeader(
      dhRatchetKey: base64Decode(dhPublicKeyBase64),
      previousChainLength: previousChainLength,
      messageNumber: messageNumber,
    );

    CryptoService.e2eeLog('E2EE DECRYPT-START [$senderUserId]: '
        'msgNum=$messageNumber hasX3DH=${x3dhHeader != null}');

    var record = await _sessionStore.loadRecord(senderUserId);

    // Determine if receiver-side X3DH is needed
    String? consumedOtkPublicKey;
    if (x3dhHeader != null) {
      final peerEph = x3dhHeader['ephemeralKey'] as String?;
      final needsX3dh = record == null ||
          !record.hasSession ||
          (record.activeSession?.isInitiator ?? false) ||
          (record.peerX3dhEphemeralKey != null &&
              record.peerX3dhEphemeralKey != peerEph);

      if (needsX3dh) {
        CryptoService.e2eeLog(
            'E2EE: Performing receiver X3DH for $senderUserId');
        final x3dhResult =
            await _performReceiverX3DH(senderUserId, x3dhHeader);
        record ??= SessionRecord();
        record.promoteState(x3dhResult.sessionState);
        record.peerX3dhEphemeralKey = peerEph;
        consumedOtkPublicKey = x3dhResult.consumedOtkPublicKey;
        // Don't save yet — save only after decrypt succeeds
      } else if (record.peerX3dhEphemeralKey == null &&
          peerEph != null) {
        // Backfill for future re-establishment detection
        record.peerX3dhEphemeralKey = peerEph;
      }
    }

    if (record == null || !record.hasSession) {
      throw PermanentDecryptionError(
        'E2EE: No session with $senderUserId and no x3dhHeader — '
        'message is permanently undecryptable.',
      );
    }

    // Try decrypt with all sessions (Sesame multi-session)
    final result =
        await record.tryDecryptAll(_specRatchet, header, ciphertext);
    if (result == null) {
      throw PermanentDecryptionError(
        'E2EE: No session could decrypt message from $senderUserId',
      );
    }

    CryptoService.e2eeLog(
        'E2EE DECRYPT-OK [$senderUserId]: msgNum=$messageNumber');

    // Persist only after successful decrypt
    await _sessionStore.saveRecord(senderUserId, record);

    // Remove consumed OTK from local storage
    if (consumedOtkPublicKey != null) {
      await _keyManagementService.removeConsumedOtk(consumedOtkPublicKey);
    }

    return result.plaintext;
  }

  // ===========================================================================
  // SESSION ESTABLISHMENT
  // ===========================================================================

  /// Establish a session with [recipientUserId].
  ///
  /// Performs X3DH key agreement using the peer's published bundle and
  /// initializes a Double Ratchet session.
  Future<SessionRecord> _establishSession(
    String recipientUserId,
    PublicKeyBundle theirBundle,
  ) async {
    final ourBundle = await _keyManagementService.loadPrivateKeys();
    if (ourBundle == null) {
      throw StateError(
          'E2EE: No local key bundle — cannot establish session');
    }

    final ourIdentityPrivate =
        base64Decode(ourBundle.identityKeyPair.split('|')[0]);
    final ourIdentityPublic =
        base64Decode(ourBundle.identityKeyPair.split('|')[1]);
    final theirIdentityKey = base64Decode(theirBundle.identityKey);
    final theirSignedPreKey = base64Decode(theirBundle.signedPreKey);

    // Verify Ed25519 SPK signature
    if (theirBundle.ed25519IdentityKey == null ||
        theirBundle.ed25519Signature == null) {
      throw StateError(
        'E2EE: Key bundle for $recipientUserId missing Ed25519 fields',
      );
    }
    final valid = await _specX3dh.verifySignedPreKey(
      signedPreKey: theirSignedPreKey,
      signature: base64Decode(theirBundle.ed25519Signature!),
      ed25519PublicKey: base64Decode(theirBundle.ed25519IdentityKey!),
    );
    if (!valid) {
      throw StateError(
        'E2EE: SPK signature verification failed for $recipientUserId',
      );
    }

    // Resolve OTK
    Uint8List? theirOtk;
    if (theirBundle.oneTimePreKeys.isNotEmpty) {
      theirOtk = base64Decode(theirBundle.oneTimePreKeys.first);
    }

    // Perform X3DH (initiator side)
    final result = await _specX3dh.computeInitiator(
      ourIdentityPrivate: ourIdentityPrivate,
      ourIdentityPublic: ourIdentityPublic,
      theirIdentityPublic: theirIdentityKey,
      theirSignedPreKey: theirSignedPreKey,
      theirOneTimePreKey: theirOtk,
    );

    // Create session record
    final record = SessionRecord();
    record.promoteState(result.sessionState);

    // Store X3DH header for outgoing messages
    record.pendingX3dhHeader = {
      'identityKey': base64Encode(ourIdentityPublic),
      'ephemeralKey': base64Encode(result.ephemeralPublic),
      'signedPreKeyId': theirBundle.signedPreKeyId,
      'oneTimePreKeyId': theirBundle.oneTimePreKeyId,
    };

    CryptoService.e2eeLog('E2EE INIT-SEND [$recipientUserId]: '
        'rootKey=${_fp(result.sessionState.rootKey)} '
        'dhSendPub=${_fp(result.sessionState.dhSendPublic)}');

    await _sessionStore.saveRecord(recipientUserId, record);
    return record;
  }

  // ===========================================================================
  // RECEIVER-SIDE X3DH
  // ===========================================================================

  /// Perform receiver-side X3DH.
  ///
  /// Resolves SPK and OTK by their integer IDs (from the X3DH header)
  /// with grace period support for rotated SPKs.
  Future<({SessionState sessionState, String? consumedOtkPublicKey})>
      _performReceiverX3DH(
    String senderUserId,
    Map<String, dynamic> x3dhHeader,
  ) async {
    final ourBundle = await _keyManagementService.loadPrivateKeys();
    if (ourBundle == null) {
      throw StateError('E2EE: No local key bundle for receiver X3DH');
    }

    final ourIdentityPrivate =
        base64Decode(ourBundle.identityKeyPair.split('|')[0]);
    final ourIdentityPublic =
        base64Decode(ourBundle.identityKeyPair.split('|')[1]);
    final theirIdentityPub =
        base64Decode(x3dhHeader['identityKey'] as String);
    final theirEphemeralPub =
        base64Decode(x3dhHeader['ephemeralKey'] as String);

    // Resolve SPK by ID (with grace period for previous SPK)
    final spkId = (x3dhHeader['signedPreKeyId'] as num?)?.toInt();
    String spkPair = ourBundle.signedPreKey; // default: current SPK

    if (spkId != null) {
      if (ourBundle.signedPreKeyId == spkId) {
        spkPair = ourBundle.signedPreKey;
      } else if (ourBundle.previousSignedPreKeyId == spkId &&
          ourBundle.previousSignedPreKey != null) {
        spkPair = ourBundle.previousSignedPreKey!;
        CryptoService.e2eeLog('E2EE: Using previous SPK (grace period) '
            'for $senderUserId');
      } else {
        CryptoService.e2eeLog('E2EE WARN: SPK ID $spkId not found — '
            'using current SPK as fallback');
      }
    }

    final ourSpkPrivate = base64Decode(spkPair.split('|')[0]);
    final ourSpkPublic = base64Decode(spkPair.split('|')[1]);

    // Resolve OTK by integer ID (format: "id|priv|pub")
    Uint8List? ourOtkPrivate;
    String? consumedOtkPublicKey;
    final otkId = (x3dhHeader['oneTimePreKeyId'] as num?)?.toInt();

    if (otkId != null) {
      for (final otk in ourBundle.oneTimePreKeys) {
        final parts = otk.split('|');
        if (parts.length == 3 && int.tryParse(parts[0]) == otkId) {
          ourOtkPrivate = base64Decode(parts[1]);
          consumedOtkPublicKey = parts[2];
          break;
        }
      }
      if (ourOtkPrivate == null) {
        CryptoService.e2eeLog('E2EE WARN [$senderUserId]: OTK ID $otkId '
            'not found — continuing without DH4');
      }
    }

    final result = await _specX3dh.computeReceiver(
      ourIdentityPrivate: ourIdentityPrivate,
      ourIdentityPublic: ourIdentityPublic,
      ourSignedPreKeyPrivate: ourSpkPrivate,
      ourSignedPreKeyPublic: ourSpkPublic,
      theirIdentityPublic: theirIdentityPub,
      theirEphemeralPublic: theirEphemeralPub,
      ourOneTimePreKeyPrivate: ourOtkPrivate,
    );

    CryptoService.e2eeLog('E2EE RECV-X3DH [$senderUserId]: '
        'rootKey=${_fp(result.sessionState.rootKey)}');

    return (
      sessionState: result.sessionState,
      consumedOtkPublicKey: consumedOtkPublicKey,
    );
  }

  // ===========================================================================
  // SESSION MANAGEMENT
  // ===========================================================================

  /// Check whether an active session exists with [userId].
  Future<bool> hasSession(String userId) async {
    return _sessionStore.recordExists(userId);
  }

  /// Reset the session with [userId], deleting all local state.
  ///
  /// The next message exchange will trigger a fresh X3DH handshake.
  /// Use this when decryption failures indicate a corrupted session.
  Future<void> resetSession(String userId) async {
    await _sessionStore.deleteRecord(userId);
  }

  /// Wipe ALL sessions from secure storage.
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

  /// Latest migration version. Bump this to force a one-time session reset
  /// when E2EE protocol changes make old sessions incompatible.
  static const _migrationVersion = 'e2ee_session_migration_v3';

  /// One-time migration: reset sessions that may be incompatible with the
  /// current E2EE code. Returns true if migration was performed.
  ///
  /// v2: Fixed peerX3dhEphemeralKey bug.
  /// v3: Clear stale sessions after AD, SPK rotation, and key-staleness
  ///     changes across commits 00d68e8–0132969 that may have left sessions
  ///     with mismatched chain state.
  Future<bool> migrateResetCorruptedSessions() async {
    final migrated = await _sessionStore.readMeta(_migrationVersion);
    if (migrated != null) {
      CryptoService.e2eeLog('E2EE: Session migration already done ($_migrationVersion)');
      return false;
    }

    // Diagnostic: check total session count to understand if this is
    // a first launch or if storage was wiped by app reinstall.
    try {
      final count = await _sessionStore.sessionCount();
      CryptoService.e2eeLog('E2EE: Migration $_migrationVersion NOT found — sessions: $count. '
          '${count == 0 ? "Storage is EMPTY (first launch or wiped by reinstall)" : ""}');
    } catch (e) {
      CryptoService.e2eeLog('E2EE: Migration $_migrationVersion NOT found, sessionCount failed: $e');
    }

    await resetAllSessions();
    await _sessionStore.writeMeta(_migrationVersion, 'done');

    // Readback verification for migration flag
    final readback = await _sessionStore.readMeta(_migrationVersion);
    if (readback == null) {
      CryptoService.e2eeLog('E2EE: ⚠ CRITICAL — migration flag readback is NULL immediately '
          'after write! Secure storage writes are NOT persisting. This device '
          'will regenerate keys on every app restart.');
    }

    CryptoService.e2eeLog('E2EE: One-time session migration ($_migrationVersion) — all sessions reset');
    return true;
  }

  /// Reset all sessions. Used during key bundle re-generation or
  /// device-level key wipe.
  Future<void> resetAllSessions() async {
    await _sessionStore.deleteAll();
  }

  /// Get the peer's identity public key (base64) stored in the session.
  ///
  /// Returns `null` if no session exists.
  Future<String?> getPeerIdentityKey(String userId) async {
    final record = await _sessionStore.loadRecord(userId);
    if (record?.activeSession != null) {
      return base64Encode(record!.activeSession!.remoteIdentityKey);
    }
    return null;
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
    final record = await _sessionStore.loadRecord(userId);
    if (record?.activeSession != null) {
      final peerKey =
          base64Encode(record!.activeSession!.remoteIdentityKey);
      return peerKey != currentPeerIdentityKey;
    }
    return false; // no session → will establish fresh
  }
}
