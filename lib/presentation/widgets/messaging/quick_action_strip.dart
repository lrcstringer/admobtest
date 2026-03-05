import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Collapsible action strip with branded buttons for Sasaza, Group Save, and Tokens.
///
/// Sits between the tab bar and conversation list on the Chats tab.
/// Collapses on scroll down, reappears on scroll up.
class QuickActionStrip extends StatelessWidget {
  final bool visible;
  final VoidCallback onSasaza;
  final VoidCallback onGroupSave;
  final VoidCallback onTokens;

  const QuickActionStrip({
    super.key,
    required this.visible,
    required this.onSasaza,
    required this.onGroupSave,
    required this.onTokens,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      height: visible ? 78 : 0,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topCenter,
          maxHeight: 78,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  imageAsset: 'assets/images/sasaza.png',
                  label: 'Sasaza',
                  color: AppColors.gold,
                  onTap: onSasaza,
                ),
                _ActionButton(
                  imageAsset: 'assets/images/groupts.png',
                  label: 'Group Save',
                  color: AppColors.secondary,
                  onTap: onGroupSave,
                ),
                _ActionButton(
                  imageAsset: 'assets/images/transfer.png',
                  label: 'Tokens',
                  color: AppColors.accent,
                  onTap: onTokens,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.imageAsset,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                imageAsset,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
