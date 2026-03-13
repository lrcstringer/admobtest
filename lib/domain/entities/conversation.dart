import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/conversation_type.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

/// Denormalized participant info stored on the conversation document
@freezed
abstract class ParticipantInfo with _$ParticipantInfo {
  const factory ParticipantInfo({
    required String displayName,
    String? avatarUrl,
  }) = _ParticipantInfo;

  factory ParticipantInfo.fromJson(Map<String, dynamic> json) =>
      _$ParticipantInfoFromJson(json);
}

/// P2P conversation entity
///
/// Represents a direct message thread between two users.
/// Collection: conversations/{conversationId}
@freezed
abstract class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required ConversationType type,
    required List<String> participantIds,
    required Map<String, ParticipantInfo> participants,

    // Last message preview (for inbox list)
    String? lastMessageId,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    DateTime? lastMessageAt,

    // Per-user state
    required Map<String, int> unreadCounts,
    required Map<String, bool> archived,
    required Map<String, bool> pinned,
    required Map<String, bool> muted,

    // E2EE: per-user encrypted last message previews
    @Default({}) Map<String, String> lastMessageEncryptedPreviews,

    // Per-user chat cleared timestamps
    @Default({}) Map<String, DateTime> chatClearedAt,

    // Per-user acceptance status (message request system)
    @Default({}) Map<String, bool> accepted,

    // E2EE: per-user session reset requested flags
    @Default({}) Map<String, bool> sessionResetRequested,

    /// Token pool ID (for collection-type conversations)
    String? tokenPoolId,

    /// Pool title (denormalized for collection-type conversations)
    String? poolTitle,

    /// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
    String? poolMode,

    /// Marketplace listing ID (for marketplace-tagged conversations)
    String? marketplaceListingId,

    /// Marketplace listing title (denormalized for display)
    String? marketplaceListingTitle,

    /// Marketplace listing thumbnail URL (denormalized for display)
    String? marketplaceListingThumbnailUrl,

    /// Marketplace listing price in tokens (denormalized for display)
    int? marketplaceListingPrice,

    /// Marketplace order ID (linked after order is placed)
    String? marketplaceOrderId,

    /// Disappearing messages duration. Null means off.
    Duration? disappearingMessagesDuration,

    // Timestamps
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Conversation;

  const Conversation._();

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  /// Get unread count for a specific user
  int unreadCountFor(String userId) => unreadCounts[userId] ?? 0;

  /// Check if pinned for a specific user
  bool isPinnedFor(String userId) => pinned[userId] ?? false;

  /// Check if muted for a specific user
  bool isMutedFor(String userId) => muted[userId] ?? false;

  /// Check if archived for a specific user
  bool isArchivedFor(String userId) => archived[userId] ?? false;

  /// Check if thread has unread messages for a user
  bool hasUnreadFor(String userId) => unreadCountFor(userId) > 0;

  /// Whether the chat was cleared after the last message (hide preview)
  bool isChatClearedFor(String userId) {
    final cleared = chatClearedAt[userId];
    if (cleared == null) return false;
    if (lastMessageAt == null) return true;
    return cleared.isAfter(lastMessageAt!);
  }

  /// Whether this user has accepted the conversation (not a message request)
  bool isAcceptedFor(String userId) => accepted[userId] ?? true;

  /// Whether this is a message request for the given user
  bool isMessageRequestFor(String userId) => !isAcceptedFor(userId);

  /// Whether this is a collection room (Group Sasaza / Group Save)
  bool get isCollectionRoom => type == ConversationType.collection;

  /// Whether this conversation is tagged to a marketplace listing
  bool get isMarketplaceConversation => marketplaceListingId != null;

  /// Whether disappearing messages are enabled for this conversation
  bool get hasDisappearingMessages => disappearingMessagesDuration != null;

  /// Human-readable label for the disappearing messages duration
  String get disappearingMessagesLabel {
    if (disappearingMessagesDuration == null) return 'Off';
    final hours = disappearingMessagesDuration!.inHours;
    if (hours <= 24) return '24 hours';
    if (hours <= 168) return '7 days';
    return '90 days';
  }

  /// Get the other participant's ID (for P2P)
  String otherParticipantId(String currentUserId) =>
      participantIds.firstWhere((id) => id != currentUserId,
          orElse: () => participantIds.first);

  /// Get the other participant's info (for P2P)
  ParticipantInfo getOtherParticipant(String currentUserId) {
    final otherId = otherParticipantId(currentUserId);
    return participants[otherId] ??
        const ParticipantInfo(displayName: 'Unknown');
  }

  /// Get display name for the other participant
  String displayNameFor(String currentUserId) =>
      getOtherParticipant(currentUserId).displayName;

  /// Get initials for avatar fallback
  String displayInitialsFor(String currentUserId) {
    final name = displayNameFor(currentUserId);
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }
}
