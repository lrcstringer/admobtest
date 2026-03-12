import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Compact delivery timer countdown for order cards/lists (Spec §8.13).
///
/// Shows days/hours remaining with color-coded urgency:
/// - Green: >3 days
/// - Amber: 1-3 days
/// - Red: <1 day or overdue
class DeliveryTimerWidget extends StatelessWidget {
  final DateTime deadline;
  final bool compact;

  const DeliveryTimerWidget({
    super.key,
    required this.deadline,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final remaining = deadline.difference(now);
    final isOverdue = remaining.isNegative;

    final color = isOverdue
        ? AppColors.buyError
        : remaining.inDays > 3
            ? AppColors.buySuccess
            : remaining.inDays >= 1
                ? AppColors.buyWarning
                : AppColors.buyError;

    final text = isOverdue
        ? 'Overdue'
        : remaining.inDays > 0
            ? '${remaining.inDays}d left'
            : remaining.inHours > 0
                ? '${remaining.inHours}h left'
                : '${remaining.inMinutes}m left';

    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOverdue ? Icons.warning_amber_rounded : Icons.timer_outlined,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
