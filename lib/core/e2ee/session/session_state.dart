import 'dart:convert';
import 'dart:typed_data';

/// Immutable Double Ratchet session state for the v2 (spec-compliant) protocol.
///
/// All mutations return a new instance via [copyWith]. This prevents
/// accidental partial updates and makes the state safe to snapshot for
/// Sesame multi-session management.
///
/// Stored with a `v2_session_` key prefix to avoid collision with the
/// legacy `e2ee_session_` format.
class SessionState {
  /// Protocol version (2 for spec-compliant).
  final int version;

  /// Current root key (32 bytes).
  final Uint8List rootKey;

  /// Sending chain key (32 bytes). Null before first send.
  final Uint8List? sendChainKey;

  /// Receiving chain key (32 bytes). Null before first receive.
  final Uint8List? recvChainKey;

  /// Our current DH ratchet private key (32 bytes).
  final Uint8List dhSendPrivate;

  /// Our current DH ratchet public key (32 bytes).
  final Uint8List dhSendPublic;

  /// Peer's current DH ratchet public key (32 bytes). Null if unknown.
  final Uint8List? dhRecvPublic;

  /// Number of messages sent in the current sending chain.
  final int sendMessageNumber;

  /// Number of messages received in the current receiving chain.
  final int recvMessageNumber;

  /// Length of our previous sending chain (included as PN in headers).
  final int previousChainLength;

  /// Skipped message keys for out-of-order decryption.
  /// Key format: `base64(dhPublicKey):messageNumber` → message key bytes.
  final Map<String, Uint8List> skippedKeys;

  /// Our identity public key (raw 32 bytes) at session creation.
  /// Used for AD construction: AD = IK_A || IK_B.
  final Uint8List localIdentityKey;

  /// Peer's identity public key (raw 32 bytes) at session creation.
  /// Used for AD construction and identity verification.
  final Uint8List remoteIdentityKey;

  /// Whether we initiated this session (Alice role).
  final bool isInitiator;

  /// When this session was created.
  final DateTime createdAt;

  const SessionState({
    this.version = 2,
    required this.rootKey,
    this.sendChainKey,
    this.recvChainKey,
    required this.dhSendPrivate,
    required this.dhSendPublic,
    this.dhRecvPublic,
    this.sendMessageNumber = 0,
    this.recvMessageNumber = 0,
    this.previousChainLength = 0,
    this.skippedKeys = const {},
    required this.localIdentityKey,
    required this.remoteIdentityKey,
    this.isInitiator = false,
    required this.createdAt,
  });

  /// Compute the 64-byte Associated Data for AEAD encryption/decryption.
  ///
  /// Per X3DH spec: AD = Encode(IK_A) || Encode(IK_B)
  /// where A is the initiator and B is the receiver.
  Uint8List get associatedData {
    final ad = Uint8List(64);
    if (isInitiator) {
      ad.setRange(0, 32, localIdentityKey);
      ad.setRange(32, 64, remoteIdentityKey);
    } else {
      ad.setRange(0, 32, remoteIdentityKey);
      ad.setRange(32, 64, localIdentityKey);
    }
    return ad;
  }

  SessionState copyWith({
    int? version,
    Uint8List? rootKey,
    Uint8List? sendChainKey,
    Uint8List? recvChainKey,
    Uint8List? dhSendPrivate,
    Uint8List? dhSendPublic,
    Uint8List? dhRecvPublic,
    int? sendMessageNumber,
    int? recvMessageNumber,
    int? previousChainLength,
    Map<String, Uint8List>? skippedKeys,
    Uint8List? localIdentityKey,
    Uint8List? remoteIdentityKey,
    bool? isInitiator,
    DateTime? createdAt,
  }) {
    return SessionState(
      version: version ?? this.version,
      rootKey: rootKey ?? this.rootKey,
      sendChainKey: sendChainKey ?? this.sendChainKey,
      recvChainKey: recvChainKey ?? this.recvChainKey,
      dhSendPrivate: dhSendPrivate ?? this.dhSendPrivate,
      dhSendPublic: dhSendPublic ?? this.dhSendPublic,
      dhRecvPublic: dhRecvPublic ?? this.dhRecvPublic,
      sendMessageNumber: sendMessageNumber ?? this.sendMessageNumber,
      recvMessageNumber: recvMessageNumber ?? this.recvMessageNumber,
      previousChainLength: previousChainLength ?? this.previousChainLength,
      skippedKeys: skippedKeys ?? this.skippedKeys,
      localIdentityKey: localIdentityKey ?? this.localIdentityKey,
      remoteIdentityKey: remoteIdentityKey ?? this.remoteIdentityKey,
      isInitiator: isInitiator ?? this.isInitiator,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Serialize to JSON for secure storage persistence.
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'rootKey': base64Encode(rootKey),
      'sendChainKey':
          sendChainKey != null ? base64Encode(sendChainKey!) : null,
      'recvChainKey':
          recvChainKey != null ? base64Encode(recvChainKey!) : null,
      'dhSendPrivate': base64Encode(dhSendPrivate),
      'dhSendPublic': base64Encode(dhSendPublic),
      'dhRecvPublic':
          dhRecvPublic != null ? base64Encode(dhRecvPublic!) : null,
      'sendMessageNumber': sendMessageNumber,
      'recvMessageNumber': recvMessageNumber,
      'previousChainLength': previousChainLength,
      'skippedKeys':
          skippedKeys.map((k, v) => MapEntry(k, base64Encode(v))),
      'localIdentityKey': base64Encode(localIdentityKey),
      'remoteIdentityKey': base64Encode(remoteIdentityKey),
      'isInitiator': isInitiator,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Deserialize from JSON.
  factory SessionState.fromJson(Map<String, dynamic> json) {
    final skippedRaw = json['skippedKeys'] as Map<String, dynamic>? ?? {};
    return SessionState(
      version: json['version'] as int? ?? 2,
      rootKey: base64Decode(json['rootKey'] as String),
      sendChainKey: json['sendChainKey'] != null
          ? base64Decode(json['sendChainKey'] as String)
          : null,
      recvChainKey: json['recvChainKey'] != null
          ? base64Decode(json['recvChainKey'] as String)
          : null,
      dhSendPrivate: base64Decode(json['dhSendPrivate'] as String),
      dhSendPublic: base64Decode(json['dhSendPublic'] as String),
      dhRecvPublic: json['dhRecvPublic'] != null
          ? base64Decode(json['dhRecvPublic'] as String)
          : null,
      sendMessageNumber: json['sendMessageNumber'] as int? ?? 0,
      recvMessageNumber: json['recvMessageNumber'] as int? ?? 0,
      previousChainLength: json['previousChainLength'] as int? ?? 0,
      skippedKeys:
          skippedRaw.map((k, v) => MapEntry(k, base64Decode(v as String))),
      localIdentityKey: base64Decode(json['localIdentityKey'] as String),
      remoteIdentityKey: base64Decode(json['remoteIdentityKey'] as String),
      isInitiator: json['isInitiator'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }
}
