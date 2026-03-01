/// Type of message in conversations and communities
enum MessageType {
  /// Plain text message
  text,

  /// Image attachment
  image,

  /// Voice note
  voice,

  /// Document attachment (PDF, DOC, etc.)
  document,

  /// Video message (max 60s, 480×480 square)
  video,

  /// Token send (completed transfer)
  tokenSend,

  /// Token request (pending action)
  tokenRequest,

  /// Gift message
  gift,

  /// Token spray celebration
  tokenSpray,

  /// System-generated message
  system,

  /// Group gift delivery message (Group Sasaza)
  groupGift,
}

extension MessageTypeX on MessageType {
  bool get isText => this == MessageType.text;
  bool get isMedia => this == MessageType.image || this == MessageType.voice || this == MessageType.document || this == MessageType.video;
  bool get isVideo => this == MessageType.video;
  bool get isTokenRelated =>
      this == MessageType.tokenSend || this == MessageType.tokenRequest;
  bool get isSystem => this == MessageType.system;
  bool get isGift => this == MessageType.gift;
  bool get isGroupGift => this == MessageType.groupGift;
  bool get isSpray => this == MessageType.tokenSpray;

  String get displayName {
    switch (this) {
      case MessageType.text:
        return 'Message';
      case MessageType.image:
        return 'Image';
      case MessageType.voice:
        return 'Voice Note';
      case MessageType.tokenSend:
        return 'Send Tokens';
      case MessageType.tokenRequest:
        return 'Request Tokens';
      case MessageType.gift:
        return 'Gift';
      case MessageType.tokenSpray:
        return 'Token Spray';
      case MessageType.document:
        return 'Document';
      case MessageType.video:
        return 'Video Message';
      case MessageType.system:
        return 'System';
      case MessageType.groupGift:
        return 'Group Sasaza';
    }
  }
}
