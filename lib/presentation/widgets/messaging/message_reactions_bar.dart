import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Displays emoji reactions below a message bubble.
///
/// Each emoji group shows the emoji + count. Tapping toggles the current
/// user's reaction for that emoji.
class MessageReactionsBar extends StatelessWidget {
  /// Map of emoji → list of userIds who reacted.
  final Map<String, List<String>> reactions;

  /// The current authenticated user's ID.
  final String currentUserId;

  /// Called when a user taps a reaction to toggle it.
  final void Function(String emoji) onToggleReaction;

  const MessageReactionsBar({
    super.key,
    required this.reactions,
    required this.currentUserId,
    required this.onToggleReaction,
  });

  @override
  Widget build(BuildContext context) {
    // Filter out empty reaction groups
    final activeReactions =
        reactions.entries.where((e) => e.value.isNotEmpty).toList();
    if (activeReactions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: activeReactions.map((entry) {
          final emoji = entry.key;
          final users = entry.value;
          final hasReacted = users.contains(currentUserId);

          return GestureDetector(
            onTap: () => onToggleReaction(emoji),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: hasReacted
                    ? AppColors.primary
                        .withValues(alpha: 0.15)
                    : AppColors.chatSurface
                        .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: hasReacted
                    ? Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.4),
                      )
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 14)),
                  if (users.length > 1) ...[
                    const SizedBox(width: 2),
                    Text(
                      '${users.length}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight:
                                hasReacted ? FontWeight.bold : FontWeight.normal,
                            color: hasReacted
                                ? AppColors.primary
                                : null,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
