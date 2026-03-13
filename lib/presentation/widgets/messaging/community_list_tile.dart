import 'package:flutter/material.dart';

import '../../../core/utils/chat_date_formatter.dart';
import '../../../domain/entities/community.dart';
import '../../theme/app_colors.dart';
import 'imali_avatar.dart';

/// List tile for a community in the unified inbox.
///
/// Shows a group icon overlay on the avatar and member count.
class CommunityListTile extends StatelessWidget {
  final Community community;
  final String currentUserId;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const CommunityListTile({
    super.key,
    required this.community,
    required this.currentUserId,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = community.hasUnreadFor(currentUserId);
    final unreadCount = community.unreadCountFor(currentUserId);

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: _buildAvatar(context),
      title: Row(
        children: [
          Expanded(
            child: Text(
              community.name,
              style: hasUnread
                  ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                  : null,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (community.isMutedFor(currentUserId))
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
          if (community.lastMessageAt != null)
            Text(
              _formatDate(community.lastMessageAt!),
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

  Widget _buildSubtitle(BuildContext context, bool hasUnread) {
    if (community.lastMessageText != null) {
      final preview = community.lastMessageSenderName != null
          ? '${community.lastMessageSenderName}: ${community.lastMessageText}'
          : community.lastMessageText!;
      return Text(
        preview,
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

    return Text(
      '${community.memberCount} ${community.memberCount == 1 ? 'member' : 'members'}',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final color =
        community.isStokvel ? AppColors.secondary : AppColors.primary;

    // Group icon badge overlay
    final badge = Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          community.isStokvel ? Icons.savings : Icons.group,
          size: 10,
          color: AppColors.textOnPrimary,
        ),
      ),
    );

    return IMaliAvatar(
      imageUrl: community.avatarUrl,
      displayName: community.name,
      accentColor: color,
      badge: badge,
    );
  }

  String _formatDate(DateTime date) =>
      ChatDateFormatter.formatListTimestamp(date);
}
