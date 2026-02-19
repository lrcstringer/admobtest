import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
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

  /// Encrypt a plaintext message for [communityId] using the sender key.
  ///
  /// Returns a map containing:
  /// - `ciphertext`: the encrypted message (base64)
  /// - `e2ee`: metadata with protocol, senderKeyChainId, messageNumber
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

    // Encrypt with AES-256-GCM
    final plaintextBytes = Uint8List.fromList(utf8.encode(plaintext));
    final encrypted = await _cryptoService.encrypt(plaintextBytes, messageKey);

    final result = <String, dynamic>{
      'ciphertext': base64Encode(encrypted),
      'e2ee': {
        'protocol': 'sender-key-v1',
        'senderKeyChainId': state.chainId,
        'messageNumber': state.messageNumber,
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

  /// Decrypt a community message from [senderUserId].
  ///
  /// Uses the stored sender key for that user in [communityId].
  Future<String> decryptCommunity(
    String communityId,
    String senderUserId,
    Map<String, dynamic> encrypted,
  ) async {
    final ciphertextBase64 = encrypted['ciphertext'] as String;
    final e2ee = encrypted['e2ee'] as Map<String, dynamic>?;
    final targetMessageNumber = e2ee?['messageNumber'] as int? ?? 0;

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

    // Ratchet forward to target message number
    var currentChainKey = state.chainKey;
    for (var i = state.messageNumber; i < targetMessageNumber; i++) {
      currentChainKey = await _cryptoService.hkdf(
        inputKeyMaterial: currentChainKey,
        length: 32,
        info: utf8.encode('SKChainKey'),
      );
    }

    // Derive message key
    final messageKey = await _cryptoService.hkdf(
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

    // Persist updated state
    await _secureStorage.write(
      key: '$_peerKeyPrefix${communityId}_$senderUserId',
      value: jsonEncode(state.toJson()),
    );

    // Decrypt
    final encryptedBytes = base64Decode(ciphertextBase64);
    // Format: nonce(12) || ciphertext || mac(16)
    final nonce = Uint8List.fromList(encryptedBytes.sublist(0, 12));
    final ciphertextWithMac = Uint8List.fromList(encryptedBytes.sublist(12));
    final plaintext = await _cryptoService.decrypt(
      ciphertextWithMac,
      messageKey,
      nonce: nonce,
    );
    return utf8.decode(plaintext);
  }

  /// Re-key all sender keys for [communityId].
  ///
  /// Called when a member leaves the community to ensure forward secrecy.
  /// Generates a new sender key — caller must distribute it.
  Future<void> rekeyAllSenderKeys(String communityId) async {
    await generateSenderKey(communityId);
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
}

// =============================================================================
// SENDER KEY STATE
// =============================================================================

class _SenderKeyState {
  String chainId;
  Uint8List chainKey;
  Uint8List signingKey;
  int messageNumber;

  _SenderKeyState({
    required this.chainId,
    required this.chainKey,
    required this.signingKey,
    this.messageNumber = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'chainId': chainId,
      'chainKey': base64Encode(chainKey),
      'signingKey': base64Encode(signingKey),
      'messageNumber': messageNumber,
    };
  }

  factory _SenderKeyState.fromJson(Map<String, dynamic> json) {
    return _SenderKeyState(
      chainId: json['chainId'] as String,
      chainKey: base64Decode(json['chainKey'] as String),
      signingKey: base64Decode(json['signingKey'] as String),
      messageNumber: json['messageNumber'] as int? ?? 0,
    );
  }
}
