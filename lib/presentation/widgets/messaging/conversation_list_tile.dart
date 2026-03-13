import 'package:flutter/material.dart';

import '../../../core/utils/chat_date_formatter.dart';
import '../../../domain/entities/conversation.dart';
import '../../theme/app_colors.dart';
import 'imali_avatar.dart';

/// List tile for a P2P conversation in the unified inbox.
class ConversationListTile extends StatelessWidget {
  final Conversation conversation;
  final String currentUserId;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  /// Names of users currently typing in this conversation.
  /// When non-empty, replaces the subtitle with a typing indicator.
  final List<String> typingNames;

  const ConversationListTile({
    super.key,
    required this.conversation,
    required this.currentUserId,
    required this.onTap,
    this.onLongPress,
    this.typingNames = const [],
  });

  @override
  Widget build(BuildContext context) {
    final other = conversation.getOtherParticipant(currentUserId);
    final hasUnread = conversation.hasUnreadFor(currentUserId);
    final unreadCount = conversation.unreadCountFor(currentUserId);

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: _buildAvatar(context, other),
      title: Row(
        children: [
          Expanded(
            child: Text(
              other.displayName,
              style: hasUnread
                  ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                  : null,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (conversation.isPinnedFor(currentUserId))
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(Icons.push_pin, size: 14, color: AppColors.primary),
            ),
          if (conversation.isMutedFor(currentUserId))
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(Icons.volume_off,
                  size: 14, color: AppColors.textSecondary),
            ),
        ],
      ),
      subtitle: typingNames.isNotEmpty
          ? _buildInlineTyping(context)
          : _buildSubtitle(context, hasUnread),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (conversation.lastMessageAt != null &&
              !conversation.isChatClearedFor(currentUserId))
            Text(
              _formatDate(conversation.lastMessageAt!),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        hasUnread ? AppColors.primary : AppColors.textSecondary,
                  ),
            ),
          if (unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                unreadCount > 99 ? '99+' : '$unreadCount',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _buildSubtitle(BuildContext context, bool hasUnread) {
    final chatCleared = conversation.isChatClearedFor(currentUserId);

    if (!chatCleared && conversation.lastMessageText != null) {
      return Text(
        conversation.lastMessageText!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: hasUnread
            ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
      );
    }

    if (!chatCleared && conversation.lastMessageAt != null) {
      // Show a human-readable fallback for messages whose plaintext
      // preview hasn't been populated yet (e.g. still decrypting, or
      // media-only messages without caption).
      final type = conversation.lastMessageType;
      final (IconData icon, String label) = switch (type) {
        'image' => (Icons.photo, 'Photo'),
        'voice' => (Icons.mic, 'Voice message'),
        'video' => (Icons.videocam, 'Video'),
        'document' => (Icons.description, 'Document'),
        'text' => (Icons.lock, 'Encrypted message'),
        _ => (Icons.chat_bubble_outline, 'New message'),
      };
      return Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      );
    }

    return null;
  }

  Widget _buildAvatar(BuildContext context, ParticipantInfo other) {
    return IMaliAvatar(
      imageUrl: other.avatarUrl,
      displayName: other.displayName,
    );
  }

  Widget _buildInlineTyping(BuildContext context) {
    final label = typingNames.length == 1
        ? '${typingNames.first} is typing...'
        : '${typingNames.join(", ")} are typing...';
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primary,
            fontStyle: FontStyle.italic,
          ),
    );
  }

  String _formatDate(DateTime date) =>
      ChatDateFormatter.formatListTimestamp(date);
}
