import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/enums/conversation_type.dart';
import '../../theme/app_colors.dart';
import 'reaction_picker.dart';

/// Callback for message actions.
typedef MessageActionCallback = void Function(Message message);

/// Callback for reaction actions (includes the emoji).
typedef ReactionCallback = void Function(Message message, String emoji);

/// Shows a WhatsApp-style message context menu on long-press.
///
/// Displays an inline emoji reaction row at the top, followed by contextually
/// appropriate action tiles based on message ownership, type, and age.
Future<void> showMessageContextMenu({
  required BuildContext context,
  required Message message,
  required bool isMe,
  required String currentUserId,
  required ConversationType conversationType,
  bool isAdmin = false,
  Set<String> starredMessageIds = const {},
  List<String> pinnedMessageIds = const [],
  required ReactionCallback onReact,
  required MessageActionCallback onReply,
  MessageActionCallback? onCopy,
  MessageActionCallback? onForward,
  MessageActionCallback? onEdit,
  MessageActionCallback? onStar,
  MessageActionCallback? onPin,
  required MessageActionCallback onDeleteForMe,
  MessageActionCallback? onDeleteForEveryone,
}) {
  HapticFeedback.mediumImpact();

  final isDeleted = message.deletedForEveryone;
  final isSystemMessage = message.isSystem;
  final isStarred = starredMessageIds.contains(message.id);
  final isPinned = pinnedMessageIds.contains(message.id);
  final hasText = message.textContent != null &&
      message.textContent!.isNotEmpty &&
      !isDeleted;

  // Edit: own text messages, not forwarded, not deleted, within 15 min
  final canEdit = isMe &&
      message.isTextMessage &&
      !message.isForwarded &&
      !isDeleted &&
      !isSystemMessage &&
      !message.isTokenTransfer &&
      _isWithinWindow(message.createdAt, const Duration(minutes: 15));

  // Delete for everyone: own messages within 1 hour
  final canDeleteForEveryone = isMe &&
      !isDeleted &&
      _isWithinWindow(message.createdAt, const Duration(hours: 1));

  // Forward: not system, not token transfer, not deleted
  final canForward =
      !isSystemMessage && !message.isTokenTransfer && !isDeleted;

  // Pin: in communities only admin/owner; in P2P always; not deleted
  final canPin = !isDeleted &&
      (conversationType != ConversationType.collection || isAdmin);

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _MessageContextMenuSheet(
      isDeleted: isDeleted,
      isSystemMessage: isSystemMessage,
      isStarred: isStarred,
      isPinned: isPinned,
      hasText: hasText,
      canEdit: canEdit,
      canForward: canForward,
      canPin: canPin,
      canDeleteForEveryone: canDeleteForEveryone,
      onReactWithEmoji: (emoji) {
        Navigator.pop(ctx);
        onReact(message, emoji);
      },
      onReply: () {
        Navigator.pop(ctx);
        onReply(message);
      },
      onCopy: hasText && onCopy != null
          ? () {
              Navigator.pop(ctx);
              onCopy(message);
            }
          : null,
      onForward: canForward && onForward != null
          ? () {
              Navigator.pop(ctx);
              onForward(message);
            }
          : null,
      onEdit: canEdit && onEdit != null
          ? () {
              Navigator.pop(ctx);
              onEdit(message);
            }
          : null,
      onStar: !isDeleted && onStar != null
          ? () {
              Navigator.pop(ctx);
              onStar(message);
            }
          : null,
      onPin: canPin && onPin != null
          ? () {
              Navigator.pop(ctx);
              onPin(message);
            }
          : null,
      onDeleteForMe: () {
        Navigator.pop(ctx);
        onDeleteForMe(message);
      },
      onDeleteForEveryone: canDeleteForEveryone && onDeleteForEveryone != null
          ? () {
              Navigator.pop(ctx);
              onDeleteForEveryone(message);
            }
          : null,
    ),
  );
}

bool _isWithinWindow(DateTime createdAt, Duration window) {
  return DateTime.now().difference(createdAt) <= window;
}

class _MessageContextMenuSheet extends StatelessWidget {
  final bool isDeleted;
  final bool isSystemMessage;
  final bool isStarred;
  final bool isPinned;
  final bool hasText;
  final bool canEdit;
  final bool canForward;
  final bool canPin;
  final bool canDeleteForEveryone;
  final ValueChanged<String> onReactWithEmoji;
  final VoidCallback onReply;
  final VoidCallback? onCopy;
  final VoidCallback? onForward;
  final VoidCallback? onEdit;
  final VoidCallback? onStar;
  final VoidCallback? onPin;
  final VoidCallback onDeleteForMe;
  final VoidCallback? onDeleteForEveryone;

  const _MessageContextMenuSheet({
    required this.isDeleted,
    required this.isSystemMessage,
    required this.isStarred,
    required this.isPinned,
    required this.hasText,
    required this.canEdit,
    required this.canForward,
    required this.canPin,
    required this.canDeleteForEveryone,
    required this.onReactWithEmoji,
    required this.onReply,
    this.onCopy,
    this.onForward,
    this.onEdit,
    this.onStar,
    this.onPin,
    required this.onDeleteForMe,
    this.onDeleteForEveryone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Inline emoji reaction row (skip for deleted/system messages)
            if (!isDeleted && !isSystemMessage) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ReactionPicker(
                  onReactionSelected: onReactWithEmoji,
                ),
              ),
              const Divider(height: 1, color: AppColors.divider),
            ],

            // Action tiles
            if (!isDeleted && !isSystemMessage)
              _ActionTile(
                icon: Icons.reply_rounded,
                label: 'Reply',
                onTap: onReply,
              ),

            if (hasText && onCopy != null)
              _ActionTile(
                icon: Icons.copy_rounded,
                label: 'Copy',
                onTap: onCopy!,
              ),

            if (canForward && onForward != null)
              _ActionTile(
                icon: Icons.shortcut_rounded,
                label: 'Forward',
                onTap: onForward!,
              ),

            if (canEdit && onEdit != null)
              _ActionTile(
                icon: Icons.edit_rounded,
                label: 'Edit',
                onTap: onEdit!,
              ),

            if (!isDeleted && onStar != null)
              _ActionTile(
                icon: isStarred
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                label: isStarred ? 'Unstar' : 'Star',
                onTap: onStar!,
              ),

            if (canPin && onPin != null)
              _ActionTile(
                icon: isPinned
                    ? Icons.push_pin_rounded
                    : Icons.push_pin_outlined,
                label: isPinned ? 'Unpin' : 'Pin',
                onTap: onPin!,
              ),

            const Divider(height: 1, color: AppColors.divider),

            // Delete section
            _ActionTile(
              icon: Icons.delete_outline_rounded,
              label: 'Delete for me',
              iconColor: AppColors.error,
              textColor: AppColors.error,
              onTap: onDeleteForMe,
            ),

            if (onDeleteForEveryone != null)
              _ActionTile(
                icon: Icons.delete_forever_rounded,
                label: 'Delete for everyone',
                iconColor: AppColors.error,
                textColor: AppColors.error,
                onTap: onDeleteForEveryone!,
              ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textSecondary),
      title: Text(
        label,
        style: TextStyle(color: textColor ?? AppColors.textPrimary),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
