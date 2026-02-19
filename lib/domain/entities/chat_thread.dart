import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_thread.freezed.dart';
part 'chat_thread.g.dart';

/// Chat thread type
enum ChatThreadType {
  p2p,
  brand,
  system,
}

/// Chat thread representing a conversation
/// @deprecated Use [Conversation] entity instead.
@freezed
class ChatThread with _$ChatThread {
  const factory ChatThread({
    required String id,
    required ChatThreadType type,
    required List<String> participantIds,
    required String displayName,
    String? avatarUrl,
    String? avatarColor,
    String? lastMessagePreview,
    DateTime? lastMessageAt,
    required int unreadCount,
    required bool isPinned,
    required bool isMuted,
    required bool isArchived,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ChatThread;

  const ChatThread._();

  factory ChatThread.fromJson(Map<String, dynamic> json) =>
      _$ChatThreadFromJson(json);

  /// Check if thread has unread messages
  bool get hasUnread => unreadCount > 0;

  /// Get initials for avatar fallback
  String get displayInitials {
    if (displayName.isEmpty) return '??';
    final words = displayName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return displayName.substring(0, displayName.length.clamp(0, 2)).toUpperCase();
  }
}
