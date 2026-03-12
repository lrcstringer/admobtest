import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/marketplace_listing.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Quick view bottom sheet for listings (Spec §8.3).
///
/// Shows thumbnail, title, price, description preview, and CTAs
/// without navigating to the full detail screen.
class QuickViewSheet extends StatelessWidget {
  final MarketplaceListing listing;
  final VoidCallback? onBuyNow;
  final VoidCallback? onMessage;
  final bool isFavourited;
  final VoidCallback? onToggleFavourite;

  const QuickViewSheet({
    super.key,
    required this.listing,
    this.onBuyNow,
    this.onMessage,
    this.isFavourited = false,
    this.onToggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 8, 16, MediaQuery.of(context).padding.bottom + 16),
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
          const SizedBox(height: 12),

          // Image + info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: listing.thumbnailUrl != null ||
                          listing.images.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: listing.thumbnailUrl ??
                              listing.images.first,
                          fit: BoxFit.cover,
                          placeholder: (_, _) =>
                              Container(color: AppColors.buyShimmerBase),
                          errorWidget: (_, _, _) => Container(
                            color: AppColors.buyShimmerBase,
                            child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.buyTextTertiary),
                          ),
                        )
                      : Container(
                          color: AppColors.buyShimmerBase,
                          child: const Icon(Icons.storefront_outlined,
                              color: AppColors.buyTextTertiary),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    Text(
                      listing.formattedZarPrice,
                      style: const TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${listing.priceTokens} tokens',
                      style: const TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      listing.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Seller
                    Text(
                      listing.providerName,
                      style: const TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Favourite
              if (onToggleFavourite != null)
                IconButton(
                  onPressed: onToggleFavourite,
                  icon: Icon(
                    isFavourited
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavourited
                        ? AppColors.buyError
                        : AppColors.buyTextTertiary,
                    size: 22,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Description preview
          if (listing.description.isNotEmpty)
            Text(
              listing.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          const SizedBox(height: 16),

          // CTAs
          Row(
            children: [
              // View full detail
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.push('/buy/marketplace/listing/${listing.id}');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.buyTextSecondary,
                    side: const BorderSide(
                        color: AppColors.buyCardBorder),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                  ),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 10),
              // Message / Buy
              if (onMessage != null)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onMessage!();
                    },
                    icon: const Icon(Icons.chat_bubble_outline, size: 16),
                    label: const Text('Message'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.buyMarketplaceAccent,
                      side: const BorderSide(
                          color: AppColors.buyMarketplaceAccent, width: 0.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                    ),
                  ),
                ),
              if (onBuyNow != null) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onBuyNow!();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buyMarketplaceAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                    ),
                    child: Text(
                      'Buy ${listing.formattedZarPrice}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
