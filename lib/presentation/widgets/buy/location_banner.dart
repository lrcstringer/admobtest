import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Location setup banner shown on Buy hub when profileLocation is null (Spec §8.21).
///
/// Two CTAs: "Enable GPS" and "Set manually".
/// Dismissible but re-appears on next app launch until location is set.
class LocationBanner extends StatelessWidget {
  final VoidCallback onEnableGps;
  final VoidCallback onSetManually;
  final VoidCallback? onDismiss;

  const LocationBanner({
    super.key,
    required this.onEnableGps,
    required this.onSetManually,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.3),
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.buyShadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 20,
                  color: AppColors.buyMarketplaceAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Set your location',
                      style: TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'See items near you and get accurate delivery estimates',
                      style: TextStyle(
                        color: AppColors.buyTextSecondary,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.buyTextTertiary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onSetManually,
                  icon: const Icon(Icons.edit_location_alt_outlined, size: 16),
                  label: const Text('Set manually'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.buyMarketplaceAccent,
                    side: const BorderSide(
                      color: AppColors.buyMarketplaceAccent,
                      width: 0.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onEnableGps,
                  icon: const Icon(Icons.gps_fixed_rounded, size: 16),
                  label: const Text('Enable GPS'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.buyMarketplaceAccent,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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
