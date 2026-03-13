import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Pinned card at the top of marketplace chat conversations showing listing info.
/// Tappable — deep links back to the listing detail.
class ListingContextHeader extends StatelessWidget {
  final String title;
  final String? thumbnailUrl;
  final String formattedPrice;
  final VoidCallback? onTap;

  const ListingContextHeader({
    super.key,
    required this.title,
    this.thumbnailUrl,
    required this.formattedPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          border: Border(
            bottom: BorderSide(
              color: AppColors.buyCardBorder,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 40,
                height: 40,
                child: thumbnailUrl != null && thumbnailUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: thumbnailUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            // Title + price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.buyTextPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    formattedPrice,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: AppColors.buyTextSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.buyCard,
      child: const Icon(
        Icons.storefront_outlined,
        color: AppColors.buyTextTertiary,
        size: 20,
      ),
    );
  }
}
