import 'package:flutter/material.dart';

import '../../../domain/enums/offer_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Offer message card displayed in chat thread (Spec §8.6, §8.8).
///
/// Shows offer amount, original price, discount percentage,
/// and context-aware action buttons.
class OfferMessageCard extends StatelessWidget {
  final int offerAmount;
  final int originalPrice;
  final OfferStatus status;
  final int? counterAmount;
  final bool isSender;
  final bool isSeller;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onCounter;
  final VoidCallback? onWithdraw;

  const OfferMessageCard({
    super.key,
    required this.offerAmount,
    required this.originalPrice,
    required this.status,
    this.counterAmount,
    required this.isSender,
    required this.isSeller,
    this.onAccept,
    this.onDecline,
    this.onCounter,
    this.onWithdraw,
  });

  int get _discountPercent =>
      originalPrice > 0
          ? ((1 - offerAmount / originalPrice) * 100).round()
          : 0;

  String _formatTokens(int amount) => '$amount tokens';
  String _formatZar(int amount) =>
      'R${(amount / 100.0).toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: _borderColor,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.buyShadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _headerColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusMd - 1),
              ),
            ),
            child: Row(
              children: [
                Icon(_headerIcon, size: 16, color: _headerTextColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _headerLabel,
                    style: TextStyle(
                      color: _headerTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (status != OfferStatus.pending)
                  _StatusPill(status: status),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Offer amount
                Row(
                  children: [
                    Text(
                      _formatTokens(offerAmount),
                      style: const TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatZar(offerAmount),
                      style: const TextStyle(
                        color: AppColors.buyTextSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Original price + discount
                Row(
                  children: [
                    Text(
                      'Listed at ${_formatTokens(originalPrice)}',
                      style: const TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 11,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    if (_discountPercent > 0) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.buySuccess.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          '-$_discountPercent%',
                          style: const TextStyle(
                            color: AppColors.buySuccess,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                // Counter amount (if countered)
                if (status == OfferStatus.countered &&
                    counterAmount != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.buyMarketplaceAccent
                          .withValues(alpha: 0.06),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.swap_horiz,
                            size: 14,
                            color: AppColors.buyMarketplaceAccent),
                        const SizedBox(width: 4),
                        Text(
                          'Counter: ${_formatTokens(counterAmount!)}',
                          style: const TextStyle(
                            color: AppColors.buyMarketplaceAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatZar(counterAmount!),
                          style: const TextStyle(
                            color: AppColors.buyTextSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Action buttons (only for pending offers)
          if (status == OfferStatus.pending && _showActions) ...[
            const Divider(color: AppColors.buyDivider, height: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _buildActions(),
            ),
          ],
        ],
      ),
    );
  }

  bool get _showActions {
    // Seller sees Accept/Decline/Counter on buyer's offer
    // Buyer sees Withdraw on their own pending offer
    if (isSeller && !isSender) return true;
    if (!isSeller && isSender) return true;
    return false;
  }

  Widget _buildActions() {
    if (isSeller && !isSender) {
      // Seller responding to buyer's offer
      return Row(
        children: [
          Expanded(
            child: _ActionButton(
              label: 'Accept',
              color: AppColors.buySuccess,
              filled: true,
              onTap: onAccept,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _ActionButton(
              label: 'Counter',
              color: AppColors.buyMarketplaceAccent,
              filled: false,
              onTap: onCounter,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _ActionButton(
              label: 'Decline',
              color: AppColors.buyError,
              filled: false,
              onTap: onDecline,
            ),
          ),
        ],
      );
    }

    if (!isSeller && isSender) {
      // Buyer can withdraw their own offer
      return _ActionButton(
        label: 'Withdraw Offer',
        color: AppColors.buyTextSecondary,
        filled: false,
        onTap: onWithdraw,
      );
    }

    return const SizedBox.shrink();
  }

  Color get _borderColor {
    switch (status) {
      case OfferStatus.pending:
        return AppColors.buyMarketplaceAccent;
      case OfferStatus.accepted:
        return AppColors.buySuccess;
      case OfferStatus.declined:
        return AppColors.buyError;
      case OfferStatus.countered:
        return AppColors.buyWarning;
      case OfferStatus.expired:
      case OfferStatus.withdrawn:
        return AppColors.buyCardBorder;
    }
  }

  Color get _headerColor {
    switch (status) {
      case OfferStatus.pending:
        return AppColors.buyMarketplaceAccent.withValues(alpha: 0.08);
      case OfferStatus.accepted:
        return AppColors.buySuccess.withValues(alpha: 0.08);
      case OfferStatus.declined:
        return AppColors.buyError.withValues(alpha: 0.08);
      case OfferStatus.countered:
        return AppColors.buyWarning.withValues(alpha: 0.08);
      case OfferStatus.expired:
      case OfferStatus.withdrawn:
        return AppColors.buyChipBg;
    }
  }

  Color get _headerTextColor {
    switch (status) {
      case OfferStatus.pending:
        return AppColors.buyMarketplaceAccent;
      case OfferStatus.accepted:
        return AppColors.buySuccess;
      case OfferStatus.declined:
        return AppColors.buyError;
      case OfferStatus.countered:
        return AppColors.buyWarning;
      case OfferStatus.expired:
      case OfferStatus.withdrawn:
        return AppColors.buyTextTertiary;
    }
  }

  IconData get _headerIcon {
    switch (status) {
      case OfferStatus.pending:
        return Icons.local_offer_outlined;
      case OfferStatus.accepted:
        return Icons.check_circle_outline;
      case OfferStatus.declined:
        return Icons.cancel_outlined;
      case OfferStatus.countered:
        return Icons.swap_horiz;
      case OfferStatus.expired:
        return Icons.timer_off_outlined;
      case OfferStatus.withdrawn:
        return Icons.undo;
    }
  }

  String get _headerLabel {
    if (isSender) {
      return status == OfferStatus.countered
          ? 'Counter-Offer'
          : 'Your Offer';
    }
    return status == OfferStatus.countered
        ? 'Counter-Offer'
        : 'Offer Received';
  }
}

// ─── Status Pill ──────────────────────────────────────────────────────

class _StatusPill extends StatelessWidget {
  final OfferStatus status;

  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        status.displayName,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─── Action Button ────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool filled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.filled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: filled ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: filled ? null : Border.all(color: color, width: 0.5),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: filled ? Colors.white : color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
