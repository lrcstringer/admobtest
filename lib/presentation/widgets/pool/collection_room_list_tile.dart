import 'package:flutter/material.dart';

import '../../../domain/entities/conversation.dart';
import '../../theme/app_colors.dart';

/// Conversation list tile for a Collection Room (Group Sasaza / Group Save).
/// Renders in the chat inbox with a special icon and subtitle.
class CollectionRoomListTile extends StatelessWidget {
  final Conversation conversation;
  final String currentUserId;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CollectionRoomListTile({
    super.key,
    required this.conversation,
    required this.currentUserId,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: _buildAvatar(),
      title: _buildTitle(theme),
      subtitle: _buildSubtitle(theme),
      trailing: _buildTrailing(theme),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.3),
            AppColors.secondary.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.card_giftcard,
        color: AppColors.primary,
        size: 24,
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            conversation.poolTitle ?? conversation.displayNameFor(currentUserId),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            conversation.poolMode == 'save' ? 'Group Save' : 'Group Sasaza',
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(ThemeData theme) {
    final lastMsg = conversation.lastMessageText ?? '';
    return Text(
      lastMsg.isNotEmpty ? lastMsg : 'Tap to view collection',
      style: theme.textTheme.bodySmall?.copyWith(
        color: AppColors.textSecondary,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing(ThemeData theme) {
    final date = conversation.lastMessageAt ?? conversation.createdAt;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.success,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _formatDate(date),
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.textHint,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${date.day}/${date.month}';
  }
}
