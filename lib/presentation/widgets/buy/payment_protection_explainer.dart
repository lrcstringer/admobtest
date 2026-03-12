import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// 3-step payment protection visual explainer (Spec §8.21).
///
/// Step 1: Shield + "You pay" — tokens held safely
/// Step 2: Box + "Seller delivers" — item sent within 7 days
/// Step 3: Check + "You confirm" — seller gets paid
///
/// Shown in expandable section on listing detail. Expanded by default on first visit.
class PaymentProtectionExplainer extends StatelessWidget {
  const PaymentProtectionExplainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user_outlined,
                  size: 18, color: AppColors.buySuccess),
              const SizedBox(width: 8),
              const Text(
                'Payment Protection',
                style: TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Step 1
          _ProtectionStep(
            icon: Icons.shield_outlined,
            iconColor: AppColors.buyMarketplaceAccent,
            title: 'You pay',
            description:
                'Your tokens are held safely, not sent to the seller',
            isFirst: true,
          ),

          // Connector
          _StepConnector(),

          // Step 2
          _ProtectionStep(
            icon: Icons.inventory_2_outlined,
            iconColor: AppColors.buyWarning,
            title: 'Seller delivers',
            description: 'The seller sends your item within 7 days',
          ),

          // Connector
          _StepConnector(),

          // Step 3
          _ProtectionStep(
            icon: Icons.check_circle_outline,
            iconColor: AppColors.buySuccess,
            title: 'You confirm',
            description: 'Only then does the seller get paid',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _ProtectionStep extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final bool isFirst;
  final bool isLast;

  const _ProtectionStep({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  color: AppColors.buyTextSecondary,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: Container(
        width: 2,
        height: 20,
        color: AppColors.buyDivider,
      ),
    );
  }
}
