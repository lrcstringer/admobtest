import 'package:flutter/material.dart';

import '../../../domain/entities/buy_order.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom sheet for seller-initiated refund confirmation (Spec §8.20).
///
/// Shows order summary, refund amount, and requires explicit confirmation.
class SellerRefundSheet extends StatelessWidget {
  final BuyOrder order;
  final VoidCallback onConfirm;

  const SellerRefundSheet({
    super.key,
    required this.order,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 8, 20, MediaQuery.of(context).padding.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.buyDivider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.buyWarning.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.currency_exchange_rounded,
              size: 28,
              color: AppColors.buyWarning,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Refund this buyer?',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          // Explanation
          Text(
            'This will release the escrowed tokens back to ${order.buyerName}. '
            'This action cannot be undone.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Refund summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.buyChipBg,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Column(
              children: [
                _SummaryRow(
                  label: 'Order',
                  value: '#${order.id.substring(0, 8).toUpperCase()}',
                ),
                const SizedBox(height: 8),
                _SummaryRow(
                  label: 'Item',
                  value: order.listingTitle,
                ),
                const SizedBox(height: 8),
                _SummaryRow(
                  label: 'Refund amount',
                  value: '${order.effectiveTotal} tokens',
                  isBold: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.buyTextSecondary,
                    side: const BorderSide(color: AppColors.buyCardBorder),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.buyWarning,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                  ),
                  child: const Text(
                    'Refund Buyer',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.buyTextTertiary,
            fontSize: 12,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: isBold ? 14 : 12,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
