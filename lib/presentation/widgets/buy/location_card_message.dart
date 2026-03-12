import 'package:flutter/material.dart';

import '../../../domain/entities/location_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Location card displayed in chat messages (Spec §8.17).
///
/// Shows a map-style card with location name, suburb/city/province hierarchy,
/// and an optional "Get directions" CTA.
class LocationCardMessage extends StatelessWidget {
  final LocationData location;
  final VoidCallback? onGetDirections;

  const LocationCardMessage({
    super.key,
    required this.location,
    this.onGetDirections,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Map placeholder
          Container(
            height: 100,
            width: double.infinity,
            color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.08),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Grid lines to simulate map
                ...List.generate(
                  5,
                  (i) => Positioned(
                    top: i * 25.0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 0.5,
                      color: AppColors.buyDivider.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                ...List.generate(
                  7,
                  (i) => Positioned(
                    left: i * 40.0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 0.5,
                      color: AppColors.buyDivider.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                // Pin icon
                Icon(
                  Icons.location_on,
                  size: 32,
                  color: AppColors.buyError,
                ),
              ],
            ),
          ),

          // Location info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.shortDisplay,
                  style: const TextStyle(
                    color: AppColors.buyTextPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (location.fullDisplay != location.shortDisplay) ...[
                  const SizedBox(height: 2),
                  Text(
                    location.fullDisplay,
                    style: const TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 11,
                    ),
                  ),
                ],
                if (location.postalCode != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    location.postalCode!,
                    style: const TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 10,
                    ),
                  ),
                ],
                if (onGetDirections != null) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: onGetDirections,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.directions_outlined,
                          size: 14,
                          color: AppColors.buyMarketplaceAccent,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Get directions',
                          style: TextStyle(
                            color: AppColors.buyMarketplaceAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
