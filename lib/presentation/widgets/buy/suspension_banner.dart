import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Seller suspension banner shown when provider is suspended (Spec §8.12).
///
/// Displays reason, trigger, and contact support CTA.
class SuspensionBanner extends StatelessWidget {
  final String? reason;
  final String? trigger;
  final VoidCallback? onContactSupport;

  const SuspensionBanner({
    super.key,
    this.reason,
    this.trigger,
    this.onContactSupport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.buyError.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: AppColors.buyError.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.block_rounded,
                  size: 20, color: AppColors.buyError),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Account Suspended',
                  style: TextStyle(
                    color: AppColors.buyError,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Your seller account has been suspended. Your listings are hidden and active orders have been cancelled.',
            style: TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          if (reason != null) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reason: ',
                  style: TextStyle(
                    color: AppColors.buyTextTertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    reason!,
                    style: const TextStyle(
                      color: AppColors.buyTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (trigger != null) ...[
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trigger: ',
                  style: TextStyle(
                    color: AppColors.buyTextTertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Text(
                    _friendlyTrigger(trigger!),
                    style: const TextStyle(
                      color: AppColors.buyTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (onContactSupport != null) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onContactSupport,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.buyError,
                  side: BorderSide(
                    color: AppColors.buyError.withValues(alpha: 0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                ),
                child: const Text('Contact Support'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _friendlyTrigger(String trigger) {
    switch (trigger) {
      case 'trust_score_below_minimum':
        return 'Trust score dropped below 2.0';
      case 'warning_accumulation':
        return '3 warnings within 30 days';
      case 'admin_action':
        return 'Manual review by admin';
      default:
        return trigger;
    }
  }
}
