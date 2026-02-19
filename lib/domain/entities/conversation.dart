import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/conversation_type.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

/// Denormalized participant info stored on the conversation document
@freezed
class ParticipantInfo with _$ParticipantInfo {
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
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required ConversationType type,
    required List<String> participantIds,
    required Map<String, ParticipantInfo> participants,

    // Last message preview (for inbox list)
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
