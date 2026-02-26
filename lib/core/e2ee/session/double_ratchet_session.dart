import 'dart:convert';
import 'dart:typed_data';

/// Mutable Double Ratchet session state.
///
/// Holds all keys, counters, and metadata needed for the Signal Protocol's
/// Double Ratchet algorithm. Serializable to/from JSON for persistence in
/// secure storage.
class DoubleRatchetSession {
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

  /// Our identity public key (base64) at the time the session was established.
  /// Used for Associated Data (AD) computation: AD = senderIdentity || receiverIdentity.
  String? ourIdentityKey;

  /// When this session was created. Used for session TTL enforcement.
  DateTime createdAt;

  DoubleRatchetSession({
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
    this.ourIdentityKey,
    DateTime? createdAt,
  })  : skippedKeys = skippedKeys ?? {},
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'rootKey': base64Encode(rootKey),
      'sendChainKey': base64Encode(sendChainKey),
      'recvChainKey': base64Encode(recvChainKey),
      'dhSendPrivate': base64Encode(dhSendPrivate),
      'dhSendPublic': base64Encode(dhSendPublic),
      'dhRecvPublic':
          dhRecvPublic != null ? base64Encode(dhRecvPublic!) : null,
      'sendMessageNumber': sendMessageNumber,
      'recvMessageNumber': recvMessageNumber,
      'previousChainLength': previousChainLength,
      'skippedKeys':
          skippedKeys.map((k, v) => MapEntry(k, base64Encode(v))),
      'isInitiator': isInitiator,
      'pendingIdentityKey': pendingIdentityKey,
      'pendingEphemeralKey': pendingEphemeralKey,
      'pendingOtkPublicKey': pendingOtkPublicKey,
      'peerX3dhEphemeralKey': peerX3dhEphemeralKey,
      'peerIdentityKey': peerIdentityKey,
      'ourIdentityKey': ourIdentityKey,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DoubleRatchetSession.fromJson(Map<String, dynamic> json) {
    final skippedRaw = json['skippedKeys'] as Map<String, dynamic>? ?? {};
    return DoubleRatchetSession(
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
      skippedKeys:
          skippedRaw.map((k, v) => MapEntry(k, base64Decode(v as String))),
      isInitiator: json['isInitiator'] as bool? ?? false,
      pendingIdentityKey: json['pendingIdentityKey'] as String?,
      pendingEphemeralKey: json['pendingEphemeralKey'] as String?,
      pendingOtkPublicKey: json['pendingOtkPublicKey'] as String?,
      peerX3dhEphemeralKey: json['peerX3dhEphemeralKey'] as String?,
      peerIdentityKey: json['peerIdentityKey'] as String?,
      ourIdentityKey: json['ourIdentityKey'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }
}
