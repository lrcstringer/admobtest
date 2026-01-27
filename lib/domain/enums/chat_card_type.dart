/// Type of money chat card
enum ChatCardType {
  /// Plain text message
  text,

  /// Sending tokens to someone
  tokenSend,

  /// Requesting tokens from someone
  tokenRequest,

  /// System message
  system,

  /// Image message
  image,

  /// Token received (for display purposes)
  tokenReceived,
}

extension ChatCardTypeX on ChatCardType {
  bool get isText => this == ChatCardType.text;
  bool get isSend => this == ChatCardType.tokenSend;
  bool get isRequest => this == ChatCardType.tokenRequest;
  bool get isTokenRelated =>
      this == ChatCardType.tokenSend ||
      this == ChatCardType.tokenRequest ||
      this == ChatCardType.tokenReceived;
  bool get isSystem => this == ChatCardType.system;

  String get displayName {
    switch (this) {
      case ChatCardType.text:
        return 'Message';
      case ChatCardType.tokenSend:
        return 'Send Tokens';
      case ChatCardType.tokenRequest:
        return 'Request Tokens';
      case ChatCardType.system:
        return 'System';
      case ChatCardType.image:
        return 'Image';
      case ChatCardType.tokenReceived:
        return 'Tokens Received';
    }
  }
}
