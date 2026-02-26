import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart' as hmac_lib;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'crypto_service.dart';
import 'signal_protocol_service.dart';

/// Implements the Sender Key protocol for efficient community/group
/// message encryption.
///
/// Each member generates a sender key and distributes it (encrypted via
/// the Signal Protocol pairwise channel) to all other members. Messages
/// are then encrypted with symmetric ratcheting, so only one encryption
/// operation is needed per message regardless of group size.
///
/// Security features:
/// - HMAC-SHA256 signature on every message (sender authentication)
/// - AES-256-GCM with Associated Data (AAD) binding ciphertext to context
/// - Skipped message key storage for out-of-order delivery
/// - Message key zeroization after use
/// - Message number overflow protection
/// - Decrypt-before-save to prevent state corruption
@lazySingleton
class SenderKeyService {
  final CryptoService _cryptoService;
  final SignalProtocolService _signalProtocolService;
  final FlutterSecureStorage _secureStorage;
  final FirebaseFunctions _functions;

  SenderKeyService(
    this._cryptoService,
    this._signalProtocolService,
    this._secureStorage,
    this._functions,
  );

  static const _ownKeyPrefix = 'e2ee_sk_own_';
  static const _peerKeyPrefix = 'e2ee_sk_';
  static const _distPrefix = 'e2ee_sk_dist_';
  static const _maxMessageNumber = 1 << 31;

  /// Generate a new sender key for [communityId].
  ///
  /// Creates a symmetric chain key and signing key, stored locally.
  Future<void> generateSenderKey(String communityId) async {
    final chainKey = _cryptoService.generateAesKey(); // 32 bytes
    final signingKey = _cryptoService.generateAesKey(); // 32 bytes
    final chainIdBytes = _cryptoService.randomBytes(16);
    final chainId = base64Encode(chainIdBytes);

    final state = _SenderKeyState(
      chainId: chainId,
      chainKey: chainKey,
      signingKey: signingKey,
      messageNumber: 0,
    );

    await _secureStorage.write(
      key: '$_ownKeyPrefix$communityId',
      value: jsonEncode(state.toJson()),
    );
  }

  /// Distribute this user's sender key to [recipientUserId] via the
  /// pairwise Signal Protocol channel.
  Future<void> distributeSenderKey(
    String communityId,
    String recipientUserId,
  ) async {
    // Load our sender key
    final stateJson =
        await _secureStorage.read(key: '$_ownKeyPrefix$communityId');
    if (stateJson == null) {
      throw StateError('E2EE: No sender key for community $communityId');
    }
    final state =
        _SenderKeyState.fromJson(jsonDecode(stateJson) as Map<String, dynamic>);

    // Encrypt the sender key data via P2P Signal Protocol channel
    final keyDataJson = jsonEncode({
      'chainId': state.chainId,
      'chainKey': base64Encode(state.chainKey),
      'signingKey': base64Encode(state.signingKey),
      'messageNumber': state.messageNumber,
    });

    final encrypted = await _signalProtocolService.encryptP2P(
      recipientUserId,
      keyDataJson,
    );

    // Upload encrypted key distribution to server
    final callable = _functions.httpsCallable('distributeSenderKey');
    await callable.call<dynamic>({
      'communityId': communityId,
      'recipientUserId': recipientUserId,
      'encryptedKeyData': encrypted['ciphertext'],
      'e2ee': encrypted['e2ee'],
      if (encrypted['x3dhHeader'] != null)
        'x3dhHeader': encrypted['x3dhHeader'],
    });
  }

  /// Distribute this user's sender key to all [memberIds] in a community.
  ///
  /// Typically called when the user joins a community or when a re-key
  /// is triggered.
  Future<void> distributeSenderKeyToAll(
    String communityId,
    List<String> memberIds,
  ) async {
    for (final memberId in memberIds) {
      await distributeSenderKey(communityId, memberId);
    }
  }

  /// Check whether a sender key exists locally for [communityId].
  Future<bool> hasSenderKey(String communityId) async {
    final stateJson =
        await _secureStorage.read(key: '$_ownKeyPrefix$communityId');
    return stateJson != null;
  }

  // ===========================================================================
  // DISTRIBUTION PERSISTENCE (M3)
  // ===========================================================================

  /// Check whether the sender key for [communityId] has been distributed
  /// to all members this session (persisted across app restarts).
  Future<bool> isDistributed(String communityId) async {
    final flag = await _secureStorage.read(key: '$_distPrefix$communityId');
    return flag != null;
  }

  /// Mark the sender key for [communityId] as distributed.
  Future<void> markDistributed(String communityId) async {
    await _secureStorage.write(
      key: '$_distPrefix$communityId',
      value: DateTime.now().toIso8601String(),
    );
  }

  /// Clear the distribution flag for [communityId] (e.g., on rekey).
  Future<void> clearDistributed(String communityId) async {
    await _secureStorage.delete(key: '$_distPrefix$communityId');
  }

  // ===========================================================================
  // ENCRYPT
  // ===========================================================================

  /// Encrypt a plaintext message for [communityId] using the sender key.
  ///
  /// Returns a map containing:
  /// - `ciphertext`: the encrypted message (base64)
  /// - `e2ee`: metadata with protocol, senderKeyChainId, messageNumber,
  ///   and HMAC signature for sender authentication
  Future<Map<String, dynamic>> encryptCommunity(
    String communityId,
    String plaintext,
  ) async {
    // Load our sender key
    final stateJson =
        await _secureStorage.read(key: '$_ownKeyPrefix$communityId');
    if (stateJson == null) {
      // Auto-generate if missing
      await generateSenderKey(communityId);
      return encryptCommunity(communityId, plaintext);
    }
    final state =
        _SenderKeyState.fromJson(jsonDecode(stateJson) as Map<String, dynamic>);

    // Message number overflow guard (H2)
    if (state.messageNumber >= _maxMessageNumber) {
      throw StateError(
        'E2EE: Sender key message number overflow for community $communityId — '
        'rekey required',
      );
    }

    // Derive message key from chain key via HKDF
    final messageKey = await _cryptoService.hkdf(
      inputKeyMaterial: state.chainKey,
      length: 32,
      info: utf8.encode('SKMsgKey'),
    );

    // Ratchet chain key forward
    state.chainKey = await _cryptoService.hkdf(
      inputKeyMaterial: state.chainKey,
      length: 32,
      info: utf8.encode('SKChainKey'),
    );

    // Compute AAD: communityId || chainId || messageNumber (M6)
    final aad = _computeSenderKeyAAD(
      communityId, state.chainId, state.messageNumber,
    );

    // Encrypt with AES-256-GCM + AAD
    final plaintextBytes = Uint8List.fromList(utf8.encode(plaintext));
    final encrypted = await _cryptoService.encrypt(
      plaintextBytes, messageKey, aad: aad,
    );

    // Zeroize message key after use (H1)
    CryptoService.zeroize(messageKey);

    // HMAC-SHA256 signature for sender authentication (C2)
    final signature = _hmacSign(state.signingKey, encrypted);

    final result = <String, dynamic>{
      'ciphertext': base64Encode(encrypted),
      'e2ee': {
        'protocol': 'sender-key-v1',
        'senderKeyChainId': state.chainId,
        'messageNumber': state.messageNumber,
        'signature': base64Encode(signature),
      },
    };

    state.messageNumber++;

    // Persist updated state
    await _secureStorage.write(
      key: '$_ownKeyPrefix$communityId',
      value: jsonEncode(state.toJson()),
    );

    return result;
  }

  // ===========================================================================
  // DECRYPT
  // ===========================================================================

  /// Decrypt a community message from [senderUserId].
  ///
  /// Uses the stored sender key for that user in [communityId].
  /// Handles out-of-order message delivery via skipped key storage.
  /// Verifies HMAC signature for sender authentication.
  Future<String> decryptCommunity(
    String communityId,
    String senderUserId,
    Map<String, dynamic> encrypted,
  ) async {
    final ciphertextBase64 = encrypted['ciphertext'] as String;
    final e2ee = encrypted['e2ee'] as Map<String, dynamic>?;
    final targetMessageNumber = e2ee?['messageNumber'] as int? ?? 0;
    final signatureBase64 = e2ee?['signature'] as String?;

    // Load sender's key
    final stateJson = await _secureStorage.read(
      key: '$_peerKeyPrefix${communityId}_$senderUserId',
    );
    if (stateJson == null) {
      throw StateError(
        'E2EE: No sender key for user $senderUserId in community $communityId',
      );
    }
    final state =
        _SenderKeyState.fromJson(jsonDecode(stateJson) as Map<String, dynamic>);

    // Verify HMAC signature for sender authentication (C2)
    final ciphertextBytes = base64Decode(ciphertextBase64);
    if (signatureBase64 != null) {
      final expectedSig = _hmacSign(state.signingKey, ciphertextBytes);
      final actualSig = base64Decode(signatureBase64);
      if (!_constantTimeEquals(expectedSig, actualSig)) {
        throw StateError(
          'E2EE: HMAC signature verification failed for message from '
          '$senderUserId in community $communityId',
        );
      }
    }

    // Compute AAD (M6)
    final aad = _computeSenderKeyAAD(
      communityId, state.chainId, targetMessageNumber,
    );

    Uint8List messageKey;

    if (targetMessageNumber < state.messageNumber) {
      // Out-of-order: check skipped keys (H4)
      final skippedKeyBase64 = state.skippedKeys.remove(targetMessageNumber);
      if (skippedKeyBase64 == null) {
        throw StateError(
          'E2EE: Message #$targetMessageNumber already consumed '
          '(chain at #${state.messageNumber}) and not in skipped keys',
        );
      }
      messageKey = base64Decode(skippedKeyBase64);
    } else {
      // Forward ratchet: store skipped keys for any messages we skip over (H4)
      final toSkip = targetMessageNumber - state.messageNumber;
      if (toSkip > _SenderKeyState._maxSkippedKeys) {
        throw StateError(
          'E2EE: Too many skipped sender key messages ($toSkip, '
          'max ${_SenderKeyState._maxSkippedKeys}) — possible protocol violation',
        );
      }

      var currentChainKey = state.chainKey;
      for (var i = state.messageNumber; i < targetMessageNumber; i++) {
        // Store skipped message key
        final skippedMsgKey = await _cryptoService.hkdf(
          inputKeyMaterial: currentChainKey,
          length: 32,
          info: utf8.encode('SKMsgKey'),
        );
        if (state.skippedKeys.length < _SenderKeyState._maxSkippedKeys) {
          state.skippedKeys[i] = base64Encode(skippedMsgKey);
        }
        // Ratchet chain key forward
        currentChainKey = await _cryptoService.hkdf(
          inputKeyMaterial: currentChainKey,
          length: 32,
          info: utf8.encode('SKChainKey'),
        );
      }

      // Derive message key for the target message number
      messageKey = await _cryptoService.hkdf(
        inputKeyMaterial: currentChainKey,
        length: 32,
        info: utf8.encode('SKMsgKey'),
      );

      // Ratchet one more for next message
      state.chainKey = await _cryptoService.hkdf(
        inputKeyMaterial: currentChainKey,
        length: 32,
        info: utf8.encode('SKChainKey'),
      );
      state.messageNumber = targetMessageNumber + 1;
    }

    // Prune skipped keys to stay under limit
    _pruneSkippedKeys(state);

    // Decrypt BEFORE persisting state (H3)
    // If AES-GCM auth fails, state is NOT saved — chain is not corrupted.
    final nonce = Uint8List.fromList(ciphertextBytes.sublist(0, 12));
    final ciphertextWithMac = Uint8List.fromList(ciphertextBytes.sublist(12));
    final plaintext = await _cryptoService.decrypt(
      ciphertextWithMac,
      messageKey,
      nonce: nonce,
      aad: aad,
    );

    // Zeroize message key after use (H1)
    CryptoService.zeroize(messageKey);

    // Persist state AFTER successful decrypt (H3)
    await _secureStorage.write(
      key: '$_peerKeyPrefix${communityId}_$senderUserId',
      value: jsonEncode(state.toJson()),
    );

    return utf8.decode(plaintext);
  }

  // ===========================================================================
  // KEY LIFECYCLE
  // ===========================================================================

  /// Re-key all sender keys for [communityId].
  ///
  /// Called when a member leaves the community to ensure forward secrecy.
  /// Generates a new sender key and clears the distribution flag —
  /// caller must distribute the new key.
  Future<void> rekeyAllSenderKeys(String communityId) async {
    await generateSenderKey(communityId);
    await clearDistributed(communityId);
  }

  /// Reset all sender keys for [communityId]: own key, all peer keys,
  /// and the distribution flag.
  ///
  /// Called when the user wants to re-establish encryption from scratch
  /// (e.g., after persistent decryption failures).
  Future<void> resetAllKeysForCommunity(String communityId) async {
    // Delete own sender key
    await _secureStorage.delete(key: '$_ownKeyPrefix$communityId');

    // Delete distribution flag
    await _secureStorage.delete(key: '$_distPrefix$communityId');

    // Delete all peer sender keys for this community
    final all = await _secureStorage.readAll();
    for (final key in all.keys) {
      if (key.startsWith('$_peerKeyPrefix${communityId}_')) {
        await _secureStorage.delete(key: key);
      }
    }
  }

  /// Process a sender key received from [senderUserId] for [communityId].
  ///
  /// Stores the key locally so future messages from that sender can be
  /// decrypted.
  Future<void> processReceivedSenderKey(
    String communityId,
    String senderUserId,
    Map<String, dynamic> keyData,
  ) async {
    final state = _SenderKeyState(
      chainId: keyData['chainId'] as String,
      chainKey: base64Decode(keyData['chainKey'] as String),
      signingKey: base64Decode(keyData['signingKey'] as String),
      messageNumber: keyData['messageNumber'] as int? ?? 0,
    );

    await _secureStorage.write(
      key: '$_peerKeyPrefix${communityId}_$senderUserId',
      value: jsonEncode(state.toJson()),
    );
  }

  // ===========================================================================
  // PRIVATE HELPERS
  // ===========================================================================

  /// HMAC-SHA256 signature for sender authentication (C2).
  Uint8List _hmacSign(Uint8List signingKey, Uint8List data) {
    final hmac = hmac_lib.Hmac(hmac_lib.sha256, signingKey);
    final digest = hmac.convert(data);
    return Uint8List.fromList(digest.bytes);
  }

  /// Constant-time byte comparison to prevent timing attacks.
  bool _constantTimeEquals(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }

  /// Compute AAD for Sender Key AEAD encryption (M6).
  ///
  /// AAD = communityId_utf8 || chainId_utf8 || messageNumber(4B big-endian)
  /// Binds the ciphertext to the community, chain, and message position,
  /// preventing cross-community swaps and message reordering.
  Uint8List _computeSenderKeyAAD(
    String communityId, String chainId, int messageNumber,
  ) {
    final communityBytes = utf8.encode(communityId);
    final chainBytes = utf8.encode(chainId);
    final msgNumBytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, messageNumber, Endian.big);

    final aad = Uint8List(communityBytes.length + chainBytes.length + 4);
    var offset = 0;
    aad.setRange(offset, offset + communityBytes.length, communityBytes);
    offset += communityBytes.length;
    aad.setRange(offset, offset + chainBytes.length, chainBytes);
    offset += chainBytes.length;
    aad.setRange(offset, offset + 4, msgNumBytes);
    return aad;
  }

  /// Prune skipped keys to stay under the maximum limit.
  void _pruneSkippedKeys(_SenderKeyState state) {
    while (state.skippedKeys.length > _SenderKeyState._maxSkippedKeys) {
      // Remove the lowest message number (oldest skipped key)
      final oldestKey = state.skippedKeys.keys.reduce(
        (a, b) => a < b ? a : b,
      );
      state.skippedKeys.remove(oldestKey);
    }
  }
}

// =============================================================================
// SENDER KEY STATE
// =============================================================================

class _SenderKeyState {
  String chainId;
  Uint8List chainKey;
  Uint8List signingKey;
  int messageNumber;

  /// Stored message keys for out-of-order message decryption (H4).
  /// Map of messageNumber → base64-encoded message key.
  Map<int, String> skippedKeys;

  static const _maxSkippedKeys = 200;

  _SenderKeyState({
    required this.chainId,
    required this.chainKey,
    required this.signingKey,
    this.messageNumber = 0,
    Map<int, String>? skippedKeys,
  }) : skippedKeys = skippedKeys ?? {};

  Map<String, dynamic> toJson() {
    return {
      'chainId': chainId,
      'chainKey': base64Encode(chainKey),
      'signingKey': base64Encode(signingKey),
      'messageNumber': messageNumber,
      if (skippedKeys.isNotEmpty)
        'skippedKeys':
            skippedKeys.map((k, v) => MapEntry(k.toString(), v)),
    };
  }

  factory _SenderKeyState.fromJson(Map<String, dynamic> json) {
    final rawSkipped = json['skippedKeys'] as Map<String, dynamic>?;
    final skipped = <int, String>{};
    if (rawSkipped != null) {
      for (final entry in rawSkipped.entries) {
        skipped[int.parse(entry.key)] = entry.value as String;
      }
    }
    return _SenderKeyState(
      chainId: json['chainId'] as String,
      chainKey: base64Decode(json['chainKey'] as String),
      signingKey: base64Decode(json['signingKey'] as String),
      messageNumber: json['messageNumber'] as int? ?? 0,
      skippedKeys: skipped,
    );
  }
}
