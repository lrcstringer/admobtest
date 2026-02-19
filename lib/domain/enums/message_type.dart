/// Type of message in conversations and communities
enum MessageType {
  /// Plain text message
  text,

  /// Image attachment
  image,

  /// Voice note
  voice,

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
}

extension MessageTypeX on MessageType {
  bool get isText => this == MessageType.text;
  bool get isMedia => this == MessageType.image || this == MessageType.voice;
  bool get isTokenRelated =>
      this == MessageType.tokenSend || this == MessageType.tokenRequest;
  bool get isSystem => this == MessageType.system;
  bool get isGift => this == MessageType.gift;
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
      case MessageType.system:
        return 'System';
    }
  }
}
