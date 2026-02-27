import 'dart:typed_data';

/// Double Ratchet message header.
///
/// Per Double Ratchet spec §5.1, every encrypted message includes:
/// - [dhRatchetKey]: Sender's current DH ratchet public key (32 bytes)
/// - [previousChainLength]: Number of messages in the sender's previous
///   sending chain (PN)
/// - [messageNumber]: Message index in the sender's current sending chain (N)
///
/// These are included in the AEAD associated data to prevent manipulation.
class MessageHeader {
  /// Sender's current DH ratchet public key (32 bytes, X25519).
  final Uint8List dhRatchetKey;

  /// Number of messages sent in the previous sending chain (PN).
  final int previousChainLength;

  /// Index of this message in the current sending chain (N).
  final int messageNumber;

  const MessageHeader({
    required this.dhRatchetKey,
    required this.previousChainLength,
    required this.messageNumber,
  });

  /// Encode the header to bytes for inclusion in AEAD associated data.
  ///
  /// Format: dhRatchetKey(32) || PN(4, big-endian) || N(4, big-endian)
  /// Total: 40 bytes.
  Uint8List encode() {
    final encoded = Uint8List(40);
    encoded.setRange(0, 32, dhRatchetKey);
    // PN as big-endian uint32
    encoded[32] = (previousChainLength >> 24) & 0xFF;
    encoded[33] = (previousChainLength >> 16) & 0xFF;
    encoded[34] = (previousChainLength >> 8) & 0xFF;
    encoded[35] = previousChainLength & 0xFF;
    // N as big-endian uint32
    encoded[36] = (messageNumber >> 24) & 0xFF;
    encoded[37] = (messageNumber >> 16) & 0xFF;
    encoded[38] = (messageNumber >> 8) & 0xFF;
    encoded[39] = messageNumber & 0xFF;
    return encoded;
  }

  /// Decode a header from its 40-byte encoded form.
  factory MessageHeader.decode(Uint8List encoded) {
    if (encoded.length != 40) {
      throw ArgumentError('MessageHeader must be exactly 40 bytes, '
          'got ${encoded.length}');
    }
    final dhKey = Uint8List.fromList(encoded.sublist(0, 32));
    final pn = (encoded[32] << 24) |
        (encoded[33] << 16) |
        (encoded[34] << 8) |
        encoded[35];
    final n = (encoded[36] << 24) |
        (encoded[37] << 16) |
        (encoded[38] << 8) |
        encoded[39];
    return MessageHeader(
      dhRatchetKey: dhKey,
      previousChainLength: pn,
      messageNumber: n,
    );
  }

  @override
  String toString() =>
      'MessageHeader(PN=$previousChainLength, N=$messageNumber)';
}
