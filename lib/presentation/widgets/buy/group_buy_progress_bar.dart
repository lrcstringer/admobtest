import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Animated progress bar for group buy funding status.
///
/// Shows a green gradient fill on a dark track, with fraction text
/// ("R1,200 / R5,000") and percentage.
class GroupBuyProgressBar extends StatelessWidget {
  final double progress;
  final int currentAmount;
  final int targetAmount;
  final bool showLabel;
  final double height;

  const GroupBuyProgressBar({
    super.key,
    required this.progress,
    required this.currentAmount,
    required this.targetAmount,
    this.showLabel = true,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: height,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.success),
              );
            },
          ),
        ),

        if (showLabel) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currentAmount / $targetAmount tokens',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                '$percent%',
                style: TextStyle(
                  color: progress >= 1.0
                      ? AppColors.success
                      : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
