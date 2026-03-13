import 'package:flutter/material.dart';

import '../../../domain/entities/buy_regular.dart';
import '../../theme/app_colors.dart';

/// Horizontal scrolling dock of user's quick-buy regular purchase shortcuts.
class MyRegularsDock extends StatelessWidget {
  final List<BuyRegular> regulars;
  final ValueChanged<BuyRegular> onRegularTap;
  final ValueChanged<BuyRegular> onRegularLongPress;
  final VoidCallback onAddTap;

  const MyRegularsDock({
    super.key,
    required this.regulars,
    required this.onRegularTap,
    required this.onRegularLongPress,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Regulars',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.buyTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: regulars.length + 1, // +1 for Add chip
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                if (index == regulars.length) {
                  return _buildAddChip();
                }
                return _buildRegularChip(regulars[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegularChip(BuyRegular regular) {
    return GestureDetector(
      onTap: () => onRegularTap(regular),
      onLongPress: () => onRegularLongPress(regular),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: regular.isPinned
                ? AppColors.gold.withValues(alpha: 0.4)
                : AppColors.buyCardBorder.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (regular.categoryEmoji != null) ...[
              Text(
                regular.categoryEmoji!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              regular.chipLabel,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.buyTextPrimary,
              ),
            ),
            if (regular.isPinned) ...[
              const SizedBox(width: 4),
              const Icon(Icons.push_pin, size: 12, color: AppColors.gold),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddChip() {
    return GestureDetector(
      onTap: onAddTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.buyCardBorder,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 16, color: AppColors.buyTextTertiary),
            SizedBox(width: 4),
            Text(
              'Add',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.buyTextTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state shown when user has no regulars yet.
class MyRegularsEmptyDock extends StatelessWidget {
  const MyRegularsEmptyDock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Regulars',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.buyTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.buyCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.buyCardBorder.withValues(alpha: 0.3),
              ),
            ),
            child: const Text(
              'Your quick-buy shortcuts appear after your first purchase',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.buyTextTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
