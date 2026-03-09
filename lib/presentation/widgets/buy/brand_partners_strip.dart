import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/brand_storefront.dart';
import '../../theme/app_colors.dart';
import 'buy_section_header.dart';

/// Horizontal scroll of brand partner mini storefront cards.
class BrandPartnersStrip extends StatelessWidget {
  final List<BrandStorefront> brands;
  final ValueChanged<BrandStorefront> onBrandTap;
  final VoidCallback? onSeeAllTap;

  const BrandPartnersStrip({
    super.key,
    required this.brands,
    required this.onBrandTap,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BuySectionHeader(
          title: '🏪 Brand Partners',
          actionText: 'See All',
          onActionTap: onSeeAllTap,
        ),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: brands.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) =>
                _buildBrandCard(brands[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandCard(BrandStorefront brand) {
    final brandColor = brand.brandColor != null
        ? AppColors.parseHex(brand.brandColor!)
        : AppColors.primary;

    return GestureDetector(
      onTap: () => onBrandTap(brand),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              brandColor.withValues(alpha: 0.15),
              AppColors.surfaceElevated,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: brand.isPremium
                ? AppColors.gold.withValues(alpha: 0.4)
                : AppColors.border.withValues(alpha: 0.5),
            width: brand.isPremium ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildBrandLogo(brand),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    brand.brandName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (brand.tagline != null)
              Text(
                brand.tagline!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            const Spacer(),
            const Text(
              'Visit →',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandLogo(BrandStorefront brand) {
    if (brand.brandLogoUrl != null && brand.brandLogoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: brand.brandLogoUrl!,
          width: 32,
          height: 32,
          fit: BoxFit.contain,
          placeholder: (_, __) => _buildLogoFallback(brand),
          errorWidget: (_, __, ___) => _buildLogoFallback(brand),
        ),
      );
    }
    return _buildLogoFallback(brand);
  }

  Widget _buildLogoFallback(BrandStorefront brand) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          brand.brandName.isNotEmpty ? brand.brandName[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
