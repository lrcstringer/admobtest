import 'package:flutter/material.dart';

import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/enums/listing_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Expiry countdown card shown on seller's listing detail (Spec §8.19).
///
/// States:
/// - Normal (>7 days): subtle grey info
/// - Warning (1-7 days): amber card with countdown
/// - Expired: red card with "Renew" CTA
/// - Stale nudge (3+ renewals, <10 views): advisory card
class ListingExpiryCard extends StatelessWidget {
  final MarketplaceListing listing;
  final VoidCallback? onRenew;

  const ListingExpiryCard({
    super.key,
    required this.listing,
    this.onRenew,
  });

  @override
  Widget build(BuildContext context) {
    // Stale nudge takes priority over normal expiry display
    if (listing.isStaleRenewal) return _buildStaleNudge();

    final now = DateTime.now();
    final days = listing.daysUntilExpiry(now);
    if (days == null) return const SizedBox.shrink();

    if (listing.status == ListingStatus.expired || days == 0) {
      return _buildExpiredCard();
    }

    if (listing.isExpiringSoon(now)) return _buildWarningCard(days);

    return _buildNormalCard(days);
  }

  Widget _buildNormalCard(int days) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.buyChipBg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule, size: 16, color: AppColors.buyTextTertiary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Listing expires in $days days',
              style: const TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 12,
              ),
            ),
          ),
          if (listing.renewalCount > 0)
            Text(
              'Renewed ${listing.renewalCount}×',
              style: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(int days) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.buyWarning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(
          color: AppColors.buyWarning.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              size: 20, color: AppColors.buyWarning),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  days == 1 ? 'Expires tomorrow' : 'Expires in $days days',
                  style: TextStyle(
                    color: AppColors.buyWarning,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Renew to keep your listing visible',
                  style: TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (onRenew != null)
            TextButton(
              onPressed: onRenew,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.buyWarning,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Renew',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExpiredCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.buyError.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(
          color: AppColors.buyError.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.event_busy_rounded,
              size: 20, color: AppColors.buyError),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Listing expired',
                  style: TextStyle(
                    color: AppColors.buyError,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'This listing is no longer visible to buyers',
                  style: TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (onRenew != null)
            FilledButton(
              onPressed: onRenew,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.buyMarketplaceAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
              ),
              child: const Text(
                'Renew Free',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStaleNudge() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.buyChipBg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded,
              size: 20, color: AppColors.buyWarning),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This listing isn\'t getting much attention',
                  style: TextStyle(
                    color: AppColors.buyTextPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Renewed ${listing.renewalCount} times with only ${listing.viewCount} views. '
                  'Try updating the photos, price, or description.',
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
