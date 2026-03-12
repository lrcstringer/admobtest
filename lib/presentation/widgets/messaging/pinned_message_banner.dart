import 'package:flutter/material.dart';

import '../../../domain/entities/message.dart';
import '../../theme/app_colors.dart';

/// Compact banner shown below the app bar when a conversation has pinned messages.
///
/// Shows the latest pinned message preview. Tap scrolls to the pinned message.
class PinnedMessageBanner extends StatelessWidget {
  final List<Message> pinnedMessages;
  final ValueChanged<String> onTap;
  final VoidCallback? onShowAll;

  const PinnedMessageBanner({
    super.key,
    required this.pinnedMessages,
    required this.onTap,
    this.onShowAll,
  });

  @override
  Widget build(BuildContext context) {
    if (pinnedMessages.isEmpty) return const SizedBox.shrink();

    final latest = pinnedMessages.first;
    final preview = latest.textContent ?? latest.type.name;

    return GestureDetector(
      onTap: () => onTap(latest.id),
      onLongPress: onShowAll,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.surfaceElevated,
          border: Border(
            bottom: BorderSide(color: AppColors.divider, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.push_pin_rounded,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    latest.senderName,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    preview,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (pinnedMessages.length > 1)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${pinnedMessages.length}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
