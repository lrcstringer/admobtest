import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/message_type.dart';
import '../enums/message_status.dart';
import '../enums/gift_style.dart';
import '../enums/gift_status.dart';
import '../enums/pool_status.dart';
import '../enums/spray_status.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// Media attachment on a message
@freezed
class MessageMedia with _$MessageMedia {
  const factory MessageMedia({
    required String url,
    String? thumbnailUrl,
    required String fileName,
    required int fileSize,
    required String mimeType,
    int? duration,
    int? width,
    int? height,

    /// AES-256-GCM key used to encrypt the full media file (E2EE)
    String? mediaKey,

    /// AES-256-GCM key used to encrypt the thumbnail (E2EE)
    String? thumbKey,
  }) = _MessageMedia;

  factory MessageMedia.fromJson(Map<String, dynamic> json) =>
      _$MessageMediaFromJson(json);
}

/// Reply-to context embedded in a message
@freezed
class MessageReply with _$MessageReply {
  const factory MessageReply({
    required String messageId,
    required String senderName,
    required String text,
    required String type,
  }) = _MessageReply;

  factory MessageReply.fromJson(Map<String, dynamic> json) =>
      _$MessageReplyFromJson(json);
}

/// Embedded gift data within a message
@freezed
class GiftMessageData with _$GiftMessageData {
  const factory GiftMessageData({
    required String giftId,
    required int amount,
    required String message,
    required GiftStyle style,
    required GiftStatus status,
    String? recipientId,
    String? recipientName,
    DateTime? expiresAt,
  }) = _GiftMessageData;

  factory GiftMessageData.fromJson(Map<String, dynamic> json) =>
      _$GiftMessageDataFromJson(json);
}

/// Embedded token spray data within a message
@freezed
class TokenSprayMessageData with _$TokenSprayMessageData {
  const factory TokenSprayMessageData({
    required String sprayId,
    required String recipientId,
    required String recipientName,
    required String occasion,
    required int currentTotal,
    required int contributorCount,
    required SprayStatus status,
    int? targetAmount,
    required DateTime expiresAt,
  }) = _TokenSprayMessageData;

  factory TokenSprayMessageData.fromJson(Map<String, dynamic> json) =>
      _$TokenSprayMessageDataFromJson(json);
}

/// Embedded group gift data within a message (Group Sasaza delivery)
@freezed
class GroupGiftMessageData with _$GroupGiftMessageData {
  const factory GroupGiftMessageData({
    required String poolId,
    required int amount,
    required String message,
    required GiftStyle style,
    required String organizerId,
    required String organizerName,
    required int contributorCount,
    @Default([]) List<String> visibleContributorNames,
    @Default(0) int anonymousCount,
    required PoolStatus status,
    DateTime? expiresAt,
  }) = _GroupGiftMessageData;

  factory GroupGiftMessageData.fromJson(Map<String, dynamic> json) =>
      _$GroupGiftMessageDataFromJson(json);
}

/// Metadata for forwarded messages
@freezed
class ForwardedFrom with _$ForwardedFrom {
  const factory ForwardedFrom({
    required String messageId,
    required String conversationId,
    required String senderName,
  }) = _ForwardedFrom;

  factory ForwardedFrom.fromJson(Map<String, dynamic> json) =>
      _$ForwardedFromFromJson(json);
}

/// E2EE metadata attached to encrypted messages
@freezed
class E2eeMetadata with _$E2eeMetadata {
  const factory E2eeMetadata({
    required String protocol,
    String? senderKeyChainId,
    int? messageNumber,
    String? dhPublicKey,
    int? previousChainLength,

    /// HMAC-SHA256 sender authentication signature for sender-key messages.
    String? signature,
  }) = _E2eeMetadata;

  factory E2eeMetadata.fromJson(Map<String, dynamic> json) =>
      _$E2eeMetadataFromJson(json);
}

/// X3DH key exchange header for initial P2P messages
@freezed
class X3dhHeader with _$X3dhHeader {
  const factory X3dhHeader({
    required String identityKey,
    required String ephemeralKey,
    int? oneTimePreKeyId,

    /// Integer ID of the signed pre-key used during X3DH.
    /// Required for SPK grace period resolution after rotation.
    int? signedPreKeyId,
  }) = _X3dhHeader;

  factory X3dhHeader.fromJson(Map<String, dynamic> json) =>
      _$X3dhHeaderFromJson(json);
}

/// Unified message entity for both conversations and communities
///
/// Subcollection: conversations/{id}/messages/{messageId}
///            or: communities/{id}/messages/{messageId}
@freezed
class Message with _$Message {
  const factory Message({
    required String id,

    // Sender
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,

    // Content
    required MessageType type,
    required MessageStatus status,
    String? textContent,

    // Token operations
    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,

    // Media
    MessageMedia? media,

    // Interactions
    @Default({}) Map<String, List<String>> reactions,
    MessageReply? replyTo,

    // Read receipts & forwarding
    @Default({}) Map<String, DateTime> readBy,
    ForwardedFrom? forwardedFrom,

    // Gift & spray embedded data
    GiftMessageData? gift,
    GroupGiftMessageData? groupGift,
    TokenSprayMessageData? tokenSpray,

    // Community-specific
    String? communityId,
    String? systemEventType,
    Map<String, dynamic>? systemEventData,

    // E2EE (null when plaintext / E2EE not yet enabled)
    String? ciphertext,
    E2eeMetadata? e2ee,
    X3dhHeader? x3dhHeader,

    // Timestamps
    required DateTime createdAt,
    DateTime? expiresAt,
    DateTime? actionedAt,
    DateTime? deletedAt,

    // Deletion
    @Default([]) List<String> deletedFor,
    @Default(false) bool deletedForEveryone,
  }) = _Message;

  const Message._();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  bool get isTextMessage => type == MessageType.text;

  bool get isTokenTransfer =>
      type == MessageType.tokenSend || type == MessageType.tokenRequest;

  bool get isSystem => type == MessageType.system;
  bool get isGift => type == MessageType.gift;
  bool get isGroupGift => type == MessageType.groupGift;
  bool get isSpray => type == MessageType.tokenSpray;
  bool get isEncrypted => ciphertext != null;

  bool get hasMedia => media != null || type.isMedia;
  bool get isForwarded => forwardedFrom != null;

  /// Whether this message has been read by a specific user
  bool isReadBy(String userId) => readBy.containsKey(userId);

  /// Whether all non-sender participants have read this message
  bool isReadByAll(List<String> participantIds) =>
      participantIds.where((id) => id != senderId).every(readBy.containsKey);

  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  bool isSentBy(String userId) => senderId == userId;

  /// Whether this message is visible to a specific user
  bool isVisibleTo(String userId) =>
      !deletedForEveryone && !deletedFor.contains(userId);

  /// Total reaction count across all emoji
  int get totalReactions =>
      reactions.values.fold(0, (sum, list) => sum + list.length);

  /// Check if a user has reacted with a specific emoji
  bool hasReacted(String userId, String emoji) =>
      reactions[emoji]?.contains(userId) ?? false;
}
