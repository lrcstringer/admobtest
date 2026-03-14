import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/enums/delivery_method.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/token_display.dart';
import 'trust_badge.dart';

/// Card widget for displaying a marketplace listing in a grid or list view.
/// Uses thumbnail images for data efficiency.
class MarketplaceListingCard extends StatelessWidget {
  final MarketplaceListing listing;
  final VoidCallback? onTap;

  const MarketplaceListingCard({
    super.key,
    required this.listing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image
            AspectRatio(
              aspectRatio: 1.3,
              child: _buildImage(),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    listing.title,
                    style: const TextStyle(
                      color: AppColors.buyTextPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Price
                  TokenDisplay(
                    amount: listing.priceTokens,
                    style: TokenDisplayStyle.small,
                    showZar: true,
                  ),
                  const SizedBox(height: 6),

                  // Delivery method
                  Row(
                    children: [
                      Icon(
                        listing.deliveryMethod == DeliveryMethod.delivery
                            ? Icons.local_shipping_outlined
                            : listing.deliveryMethod == DeliveryMethod.both
                                ? Icons.swap_horiz
                                : Icons.store_outlined,
                        size: 12,
                        color: AppColors.buyTextTertiary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        listing.deliveryMethod.displayName,
                        style: const TextStyle(
                          color: AppColors.buyTextTertiary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Provider row + sales count
                  Row(
                    children: [
                      if (listing.providerIsVerified == true)
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: TrustBadge(
                            score: 5.0,
                            isVerified: true,
                            size: TrustBadgeSize.small,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          listing.providerName,
                          style: const TextStyle(
                            color: AppColors.buyTextSecondary,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _salesLabel(listing.providerCompletedOrders),
                        style: const TextStyle(
                          color: AppColors.buyTextTertiary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _salesLabel(int count) {
    if (count == 1) return '1 sale';
    return '$count sales';
  }

  Widget _buildImage() {
    final url = listing.thumbnailUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, _) => Shimmer.fromColors(
          baseColor: AppColors.buyCard,
          highlightColor: AppColors.buyCard,
          child: Container(color: AppColors.buyCard),
        ),
        errorWidget: (_, _, _) => Container(
          color: AppColors.buyCard,
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: AppColors.buyTextTertiary,
          ),
        ),
      );
    }
    return Container(
      color: AppColors.buyCard,
      child: const Icon(
        Icons.storefront_outlined,
        color: AppColors.buyTextTertiary,
        size: 32,
      ),
    );
  }
}
