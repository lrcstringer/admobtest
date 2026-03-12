import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class DelegateBanner extends StatelessWidget {
  final String delegateName;
  final DateTime? expiresAt;

  const DelegateBanner({
    super.key,
    required this.delegateName,
    this.expiresAt,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = expiresAt?.difference(DateTime.now());
    final daysLeft = remaining?.inDays ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.tealLight.withValues(alpha: 0.15),
        border: Border(
          bottom: BorderSide(color: AppColors.teal.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.swap_horiz, color: AppColors.teal, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'ACTING AS TRIGGER DELEGATE',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.teal,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          if (daysLeft > 0)
            Text(
              '${daysLeft}d left',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.teal),
            ),
        ],
      ),
    );
  }
}
