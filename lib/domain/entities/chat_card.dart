import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/chat_card_type.dart';
import '../enums/chat_card_status.dart';

part 'chat_card.freezed.dart';
part 'chat_card.g.dart';

/// Chat card representing a message/action in a chat
/// @deprecated Use [Message] entity instead.
@freezed
class ChatCard with _$ChatCard {
  const factory ChatCard({
    required String id,
    required String threadId,
    required String senderId,
    required ChatCardType type,
    required ChatCardStatus status,
    String? textContent,
    int? tokenAmount,
    String? mediaUrl,
    String? mediaType,
    String? actionData,
    DateTime? expiresAt,
    required DateTime createdAt,
    DateTime? readAt,
    DateTime? actionedAt,
    String? recipientId,
  }) = _ChatCard;

  const ChatCard._();

  factory ChatCard.fromJson(Map<String, dynamic> json) =>
      _$ChatCardFromJson(json);

  /// Check if card is a text message
  bool get isTextMessage => type == ChatCardType.text;

  /// Check if card is a token transfer
  bool get isTokenTransfer =>
      type == ChatCardType.tokenSend || type == ChatCardType.tokenRequest;

  /// Check if card is actionable
  bool get isActionable =>
      type == ChatCardType.tokenRequest && status == ChatCardStatus.pending;

  /// Check if card is expired
  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  /// Check if card was sent by user
  bool isSentBy(String userId) => senderId == userId;

  /// Check if card was received by user
  bool isReceivedBy(String userId) => recipientId == userId;
}
