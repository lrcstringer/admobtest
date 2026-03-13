import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Rich preview card rendered inside a chat bubble for marketplace/group-buy shares.
///
/// Displays thumbnail, title, price, and a "View" CTA. Tappable to deep-link
/// back to the listing or group buy detail screen.
class ShareableBuyCard extends StatelessWidget {
  final String title;
  final String? thumbnailUrl;
  final String priceLabel;
  final String? subtitle;
  final bool isGroupBuy;
  final VoidCallback? onTap;

  const ShareableBuyCard({
    super.key,
    required this.title,
    this.thumbnailUrl,
    required this.priceLabel,
    this.subtitle,
    this.isGroupBuy = false,
    this.onTap,
  });

  /// Build from structured message data (stored in message textContent as JSON).
  factory ShareableBuyCard.fromMessageData({
    required Map<String, dynamic> data,
    required bool isGroupBuy,
    VoidCallback? onTap,
  }) {
    return ShareableBuyCard(
      title: data['title'] as String? ?? 'Listing',
      thumbnailUrl: data['thumbnailUrl'] as String?,
      priceLabel: data['price'] != null ? '${data['price']} tokens' : '',
      subtitle: isGroupBuy ? data['spotsLeft'] as String? : null,
      isGroupBuy: isGroupBuy,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor =
        isGroupBuy ? AppColors.secondary : AppColors.tokenGold;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 230,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            SizedBox(
              height: 120,
              width: double.infinity,
              child: thumbnailUrl != null && thumbnailUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: thumbnailUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => _placeholderImage(),
                    )
                  : _placeholderImage(),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isGroupBuy ? 'Group Buy' : 'Marketplace',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: 6),

                  // Price + View CTA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (priceLabel.isNotEmpty)
                        Text(
                          priceLabel,
                          style: TextStyle(
                            color: AppColors.tokenGold,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
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

  Widget _placeholderImage() {
    return Container(
      color: AppColors.surface,
      child: Center(
        child: Icon(
          isGroupBuy ? Icons.groups_outlined : Icons.storefront_outlined,
          color: AppColors.textHint,
          size: 36,
        ),
      ),
    );
  }
}
