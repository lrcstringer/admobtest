import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/conversation.dart';
import '../../theme/app_colors.dart';

/// List tile for a P2P conversation in the unified inbox.
class ConversationListTile extends StatelessWidget {
  final Conversation conversation;
  final String currentUserId;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const ConversationListTile({
    super.key,
    required this.conversation,
    required this.currentUserId,
    required this.onTap,
    this.onLongPress,
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
      subtitle: _buildSubtitle(context, hasUnread),
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
      // Show a human-readable fallback for media messages whose plaintext
      // preview is not stored (e.g. image-only or voice-only messages).
      final type = conversation.lastMessageType;
      final (IconData icon, String label) = switch (type) {
        'image' => (Icons.photo, 'Photo'),
        'voice' => (Icons.mic, 'Voice message'),
        _ => (Icons.lock, 'Encrypted message'),
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
    const double size = 48;
    const double radius = 6;

    final initialsWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        _initials(other.displayName),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );

    if (other.avatarUrl != null && other.avatarUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: other.avatarUrl!,
        imageBuilder: (_, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, __) => initialsWidget,
        errorWidget: (_, __, ___) => initialsWidget,
      );
    }

    return initialsWidget;
  }

  String _initials(String name) {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[date.weekday - 1];
    }
    return '${date.day}/${date.month}';
  }
}
