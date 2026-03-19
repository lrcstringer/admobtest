import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/brand_storefront.dart';
import '../../theme/app_colors.dart';

/// Shared hero section renderer for brand storefronts.
///
/// Used at full size on `BrandStorefrontScreen` and scaled down
/// inside `BrandPartnersStrip` cards for pixel-accurate previews.
///
/// [height] controls the hero height. Defaults to 200 for full-bleed
/// image and 160 for gradient style.
///
/// [maxImageCacheWidth] limits decoded image size in memory — set to
/// a small value (e.g. 280) when rendering inside a scaled-down card.
class BrandStorefrontHero extends StatelessWidget {
  final BrandStorefront storefront;
  final double? height;
  final int? maxImageCacheWidth;

  const BrandStorefrontHero({
    super.key,
    required this.storefront,
    this.height,
    this.maxImageCacheWidth,
  });

  @override
  Widget build(BuildContext context) {
    final heroImage = storefront.heroImageUrl ?? storefront.coverImageUrl;

    if (storefront.heroStyle == HeroStyle.fullBleedImage &&
        heroImage != null) {
      // When a fixed height is provided (e.g. miniature card previews),
      // use cover to fill the box. Otherwise let the image determine
      // its own height so nothing gets cropped.
      final fixedHeight = height;
      if (fixedHeight != null) {
        return SizedBox(
          height: fixedHeight,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: heroImage,
            fit: BoxFit.contain,
            memCacheWidth: maxImageCacheWidth,
            placeholder: (_, _) => Container(color: AppColors.buyCard),
            errorWidget: (_, _, _) => _GradientHero(
              storefront: storefront,
              height: fixedHeight,
            ),
          ),
        );
      }
      return CachedNetworkImage(
        imageUrl: heroImage,
        width: double.infinity,
        fit: BoxFit.fitWidth,
        memCacheWidth: maxImageCacheWidth,
        placeholder: (_, _) => const SizedBox(
          height: 200,
          child: ColoredBox(color: AppColors.buyCard),
        ),
        errorWidget: (_, _, _) => _GradientHero(
          storefront: storefront,
          height: 160,
        ),
      );
    }

    return _GradientHero(
      storefront: storefront,
      height: height ?? 160,
    );
  }
}

class _GradientHero extends StatelessWidget {
  final BrandStorefront storefront;
  final double height;

  const _GradientHero({
    required this.storefront,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.parseHex(
      storefront.brandColor ?? storefront.accentColor,
    );
    final secondaryColor = storefront.secondaryColor != null
        ? AppColors.parseHex(storefront.secondaryColor)
        : primaryColor.withValues(alpha: 0.6);

    final isCentered = storefront.logoPlacement == LogoPlacement.centered;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            if (storefront.brandLogoUrl != null)
              CachedNetworkImage(
                imageUrl: storefront.brandLogoUrl!,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
                errorWidget: (_, _, _) => _brandNameText(),
              )
            else
              _brandNameText(),
            if (storefront.tagline != null) ...[
              const SizedBox(height: 6),
              Text(
                storefront.tagline!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _brandNameText() {
    return Text(
      storefront.brandName,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
}
