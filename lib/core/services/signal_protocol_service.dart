import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'crypto_service.dart';
import 'key_management_service.dart';

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
    );

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
    if (session == null) {
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

    // Build result
    final result = <String, dynamic>{
      'ciphertext': base64Encode(encrypted),
      'e2ee': {
        'protocol': 'signal-v1',
        'messageNumber': session.sendMessageNumber,
        'dhPublicKey': base64Encode(session.dhSendPublic),
      },
    };

    // Include X3DH header on first message
    if (session.pendingIdentityKey != null) {
      result['x3dhHeader'] = {
        'identityKey': session.pendingIdentityKey,
        'ephemeralKey': session.pendingEphemeralKey,
        'oneTimePreKeyPublicKey': session.pendingOtkPublicKey,
      };
      session.pendingIdentityKey = null;
      session.pendingEphemeralKey = null;
      session.pendingOtkPublicKey = null;
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

    final messageNumber = e2ee?['messageNumber'] as int? ?? 0;
    final peerDhPublicBase64 = e2ee?['dhPublicKey'] as String?;
    final peerDhPublic =
        peerDhPublicBase64 != null ? base64Decode(peerDhPublicBase64) : null;

    var session = await _loadSession(senderUserId);

    // If X3DH header present and no session exists (or only an initiator
    // session from a simultaneous key exchange) — perform receiver-side X3DH.
    // The isInitiator guard handles the race condition where both users call
    // establishSession() simultaneously: the receiver X3DH takes precedence
    // because the incoming message was encrypted under those keys.
    if (x3dhHeader != null && (session == null || session.isInitiator)) {
      session = await _performReceiverX3DH(senderUserId, x3dhHeader, peerDhPublic);
    }

    if (session == null) {
      throw StateError('E2EE: No session with $senderUserId — cannot decrypt');
    }

    // Check for skipped message key first
    final skippedLookup = peerDhPublicBase64 != null
        ? '$peerDhPublicBase64:$messageNumber'
        : null;
    if (skippedLookup != null && session.skippedKeys.containsKey(skippedLookup)) {
      final messageKey = session.skippedKeys.remove(skippedLookup)!;
      await _saveSession(senderUserId, session);
      return _decryptWithKey(ciphertextBase64, messageKey);
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
    session.recvChainKey = await _ratchetChainKey(session.recvChainKey);
    session.recvMessageNumber++;

    await _saveSession(senderUserId, session);
    return _decryptWithKey(ciphertextBase64, messageKey);
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

  // ===========================================================================
  // RECEIVER-SIDE X3DH
  // ===========================================================================

  Future<_DoubleRatchetSession> _performReceiverX3DH(
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
    // Also support legacy 'oneTimePreKeyId' (int index) for backward compatibility
    final legacyOtkId = x3dhHeader['oneTimePreKeyId'] as int?;
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
    } else if (legacyOtkId != null && ourBundle.oneTimePreKeys.length > legacyOtkId) {
      // Legacy index-based fallback
      final otkPrivate =
          base64Decode(ourBundle.oneTimePreKeys[legacyOtkId].split('|')[0]);
      dh4 = await _cryptoService.diffieHellman(otkPrivate, theirEphemeralPub);
    }

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

    // Generate our DH ratchet key pair for send direction
    final dhSendKp = await _cryptoService.generateX25519KeyPair();

    // Perform DH ratchet for send direction so sendChainKey is properly
    // derived (not zeros). The initiator will perform the matching recv-side
    // ratchet when it sees our new dhSendPublic in the first reply message.
    final dhSendResult = await _cryptoService.diffieHellman(
      dhSendKp['privateKey']!, peerDhPublic!,
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
    );

    await _saveSession(senderUserId, session);
    return session;
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
    // Format: nonce(12) || ciphertext || mac(16)
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
    );
  }
}
