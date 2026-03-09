import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/buy_category.dart';
import '../../theme/app_colors.dart';

/// Single category tile: rounded square with brand logo or emoji + label.
class BuyCategoryTile extends StatelessWidget {
  final BuyCategory category;
  final VoidCallback onTap;

  const BuyCategoryTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = category.backgroundColor != null
        ? AppColors.parseHex(category.backgroundColor!).withValues(alpha: 0.15)
        : AppColors.surfaceElevated;

    return GestureDetector(
      onTap: category.isComingSoon ? null : onTap,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Center(child: _buildIcon()),
                ),
                if (category.isComingSoon) _buildComingSoonBadge(),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 76,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: category.isComingSoon
                      ? AppColors.textTertiary
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (category.logoUrl != null && category.logoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: category.logoUrl!,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          placeholder: (_, __) => Text(
            category.iconEmoji,
            style: const TextStyle(fontSize: 28),
          ),
          errorWidget: (_, __, ___) => Text(
            category.iconEmoji,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      );
    }
    return Text(
      category.iconEmoji,
      style: const TextStyle(fontSize: 28),
    );
  }

  Widget _buildComingSoonBadge() {
    return Positioned(
      top: -2,
      right: -2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.warning,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'SOON',
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }
}
