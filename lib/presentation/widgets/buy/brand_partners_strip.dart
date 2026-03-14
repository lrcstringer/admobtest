import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/brand_storefront.dart';
import '../../theme/app_colors.dart';
import 'brand_storefront_hero.dart';
import 'buy_section_header.dart';

/// Horizontal scroll of brand partner mini storefront hero cards.
///
/// Each card renders a pixel-accurate miniature of the brand's actual
/// storefront hero section via [BrandStorefrontHero] scaled down with
/// [FittedBox]. Falls back to a simplified card layout for brands that
/// have no hero image and no brand colour configured.
class BrandPartnersStrip extends StatelessWidget {
  final List<BrandStorefront> brands;
  final ValueChanged<BrandStorefront> onBrandTap;

  const BrandPartnersStrip({
    super.key,
    required this.brands,
    required this.onBrandTap,
  });

  /// Whether a brand has enough visual data for the live hero preview
  /// to render something meaningful.
  static bool _hasHeroData(BrandStorefront brand) {
    return brand.heroImageUrl != null ||
        brand.coverImageUrl != null ||
        brand.brandColor != null ||
        brand.accentColor != null;
  }

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
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return _hasHeroData(brand)
                  ? _BrandLiveHeroCard(brand: brand, onTap: onBrandTap)
                  : _BrandFallbackCard(brand: brand, onTap: onBrandTap);
            },
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Live Hero Card — scaled-down rendering of the actual storefront hero
// =============================================================================

class _BrandLiveHeroCard extends StatelessWidget {
  final BrandStorefront brand;
  final ValueChanged<BrandStorefront> onTap;

  const _BrandLiveHeroCard({required this.brand, required this.onTap});

  // The hero is rendered at this "virtual" size then scaled to fit the card.
  // Using the storefront's real proportions (full-width × 200px tall) ensures
  // the miniature is visually accurate.
  static const double _virtualWidth = 375;
  static const double _virtualHeight = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(brand),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: brand.isPremium
                ? AppColors.gold
                : AppColors.buyCardBorder.withValues(alpha: 0.5),
            width: brand.isPremium ? 2 : 1,
          ),
          boxShadow: brand.isPremium
              ? [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Scaled-down real hero section
            FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: _virtualWidth,
                height: _virtualHeight,
                child: BrandStorefrontHero(
                  storefront: brand,
                  height: _virtualHeight,
                  maxImageCacheWidth: 280,
                ),
              ),
            ),

            // Subtle dark gradient at bottom for brand name readability
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 44,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
            ),

            // Brand name overlay at bottom
            Positioned(
              left: 8,
              right: 8,
              bottom: 6,
              child: Text(
                brand.brandName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),

            // Premium verified badge
            if (brand.isPremium)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.goldGradient,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.verified_rounded,
                      size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Fallback Card — simplified layout for brands with minimal visual data
// =============================================================================

class _BrandFallbackCard extends StatelessWidget {
  final BrandStorefront brand;
  final ValueChanged<BrandStorefront> onTap;

  const _BrandFallbackCard({required this.brand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final brandColor = brand.brandColor != null
        ? AppColors.parseHex(brand.brandColor!)
        : AppColors.buyMarketplaceAccent;

    return GestureDetector(
      onTap: () => onTap(brand),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: brand.isPremium
                ? AppColors.gold
                : AppColors.buyCardBorder.withValues(alpha: 0.5),
            width: brand.isPremium ? 2 : 1,
          ),
          boxShadow: brand.isPremium
              ? [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    brandColor,
                    brandColor.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),

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
                crossAxisAlignment:
                    brand.logoPlacement == LogoPlacement.centered
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

  Widget _buildLogo(Color brandColor) {
    if (brand.brandLogoUrl != null && brand.brandLogoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: brand.brandLogoUrl!,
          width: 28,
          height: 28,
          fit: BoxFit.contain,
          placeholder: (_, _) => _logoFallback(brandColor),
          errorWidget: (_, _, _) => _logoFallback(brandColor),
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
