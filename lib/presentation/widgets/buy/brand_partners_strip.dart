import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/brand_storefront.dart';
import '../../theme/app_colors.dart';
import 'buy_section_header.dart';

/// Horizontal scroll of brand partner mini storefront hero cards.
/// Each card renders a miniature of the brand's storefront hero section,
/// respecting the brand's own visual identity (color, logo, tagline).
class BrandPartnersStrip extends StatelessWidget {
  final List<BrandStorefront> brands;
  final ValueChanged<BrandStorefront> onBrandTap;

  const BrandPartnersStrip({
    super.key,
    required this.brands,
    required this.onBrandTap,
  });

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BuySectionHeader(title: 'Brand Partners'),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: brands.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) =>
                _BrandHeroCard(brand: brands[index], onTap: onBrandTap),
          ),
        ),
      ],
    );
  }
}

class _BrandHeroCard extends StatelessWidget {
  final BrandStorefront brand;
  final ValueChanged<BrandStorefront> onTap;

  const _BrandHeroCard({required this.brand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final brandColor = brand.brandColor != null
        ? AppColors.parseHex(brand.brandColor!)
        : AppColors.primary;

    // Determine hero style — use accentColor/heroStyle if available,
    // otherwise fall back to brandColor gradient
    final heroStyle = brand.heroStyle;
    final hasHeroImage =
        heroStyle == HeroStyle.fullBleedImage && brand.heroImageUrl != null;

    return GestureDetector(
      onTap: () => onTap(brand),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: brand.isPremium
                ? AppColors.gold.withValues(alpha: 0.4)
                : AppColors.border.withValues(alpha: 0.5),
            width: brand.isPremium ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background: hero image or gradient
            if (hasHeroImage)
              CachedNetworkImage(
                imageUrl: brand.heroImageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, __) => _gradientBg(brandColor),
                errorWidget: (_, __, ___) => _gradientBg(brandColor),
              )
            else
              _gradientBg(brandColor),

            // Dark overlay for text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),

            // Content: logo + brand name
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: brand.logoPlacement == LogoPlacement.centered
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  _buildLogo(brandColor),
                  const Spacer(),
                  Text(
                    brand.brandName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  if (brand.tagline != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      brand.tagline!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gradientBg(Color brandColor) {
    final secondColor = brand.secondaryColor != null
        ? AppColors.parseHex(brand.secondaryColor!)
        : brandColor.withValues(alpha: 0.6);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [brandColor, secondColor],
        ),
      ),
    );
  }

  Widget _buildLogo(Color brandColor) {
    if (brand.brandLogoUrl != null && brand.brandLogoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: brand.brandLogoUrl!,
          width: 28,
          height: 28,
          fit: BoxFit.contain,
          placeholder: (_, __) => _logoFallback(brandColor),
          errorWidget: (_, __, ___) => _logoFallback(brandColor),
        ),
      );
    }
    return _logoFallback(brandColor);
  }

  Widget _logoFallback(Color brandColor) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          brand.brandName.isNotEmpty ? brand.brandName[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
