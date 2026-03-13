import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';

/// Available reaction emoji for messages.
const kReactionEmoji = ['❤️', '👍', '😂', '😮', '😢', '🙏'];

/// Compact emoji reaction picker shown on long-press of a message.
class ReactionPicker extends StatelessWidget {
  final ValueChanged<String> onReactionSelected;

  const ReactionPicker({super.key, required this.onReactionSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.chatSurface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...kReactionEmoji.map((emoji) => InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onReactionSelected(emoji);
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(emoji, style: const TextStyle(fontSize: 24)),
                ),
              )),
          // "More" button → opens full emoji keyboard
          InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              onReactionSelected('+');
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textHint.withValues(alpha: 0.3),
                ),
                child: const Icon(Icons.add, size: 18, color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows a reaction picker anchored to a message.
///
/// Returns the selected emoji string, or null if dismissed.
Future<String?> showReactionPicker(BuildContext context) {
  return showDialog<String>(
    context: context,
    barrierColor: Colors.transparent,
    builder: (ctx) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      alignment: Alignment.center,
      child: ReactionPicker(
        onReactionSelected: (emoji) => Navigator.pop(ctx, emoji),
      ),
    ),
  );
}
