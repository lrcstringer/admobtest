import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/brand_product.dart';
import '../../../domain/entities/brand_review.dart';
import '../../../domain/entities/brand_storefront.dart';
import '../../theme/app_colors.dart';
import '../common/brand_card.dart';
import 'brand_storefront_hero.dart';

/// Shared storefront body renderer.
///
/// Renders the full storefront body identically to the consumer screen,
/// without any BLoC dependency. Used in both:
/// - The consumer `BrandStorefrontScreen` (interactive: true)
/// - The admin builder's "App Preview" mode (interactive: false)
class StorefrontPreview extends StatefulWidget {
  final BrandStorefront storefront;
  final List<BrandProduct> products;
  final List<BrandReview> reviews;
  final bool isLoadingProducts;

  /// When false, taps/navigation/actions are disabled (admin preview).
  final bool interactive;

  /// Optional height override for the hero section.
  final double? heroHeight;

  /// Optional image cache width for scaled-down previews.
  final int? maxImageCacheWidth;

  const StorefrontPreview({
    super.key,
    required this.storefront,
    required this.products,
    this.reviews = const [],
    this.isLoadingProducts = false,
    this.interactive = true,
    this.heroHeight,
    this.maxImageCacheWidth,
  });

  @override
  State<StorefrontPreview> createState() => _StorefrontPreviewState();
}

class _StorefrontPreviewState extends State<StorefrontPreview> {
  bool _announcementDismissed = false;

  BrandStorefront get storefront => widget.storefront;

  @override
  Widget build(BuildContext context) {
    final useSectionOrder = storefront.sectionOrder.isNotEmpty;
    final now = DateTime.now();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BrandStorefrontHero(
            storefront: storefront,
            height: widget.heroHeight,
            maxImageCacheWidth: widget.maxImageCacheWidth,
          ),
        ),
        SliverToBoxAdapter(
          child: _buildBrandHeader(context),
        ),
        if (useSectionOrder)
          ...storefront.sectionOrder
              .where((type) {
                final settings = storefront.sectionSettings[type.name];
                final visible = settings?.isVisible ?? true;
                debugPrint('[Preview] section=${type.name} '
                    'hasSettings=${settings != null} visible=$visible');
                return visible;
              })
              .map(
                (type) => SliverToBoxAdapter(
                  child: _buildSectionByType(context, type, now),
                ),
              )
        else
          ...(storefront.sections.where((s) => s.isVisible).toList()
                ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)))
              .map(
            (section) => SliverToBoxAdapter(
              child: _buildLegacySection(context, section),
            ),
          ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }

  // ─── Brand Header ────────────────────────────────────────

  Widget _buildBrandHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (storefront.brandLogoUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: storefront.brandLogoUrl!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            storefront.brandName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.buyTextPrimary,
                            ),
                          ),
                        ),
                        ...storefront.trustBadges.take(2).map(
                              (badge) => Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: _buildTrustBadge(badge),
                              ),
                            ),
                      ],
                    ),
                    if (storefront.tagline != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        storefront.tagline!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.buyTextSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          // Rating row
          if (storefront.averageRating != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                ...List.generate(5, (i) {
                  final starValue = i + 1;
                  final rating = storefront.averageRating!;
                  return Icon(
                    starValue <= rating
                        ? Icons.star
                        : starValue - 0.5 <= rating
                            ? Icons.star_half
                            : Icons.star_border,
                    size: 16,
                    color: AppColors.gold,
                  );
                }),
                const SizedBox(width: 6),
                Text(
                  storefront.averageRating!.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buyTextPrimary,
                  ),
                ),
                if (storefront.ratingCount != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    '(${storefront.ratingCount})',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.buyTextTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ],
          // Chat button
          if (storefront.showChatButton && widget.interactive) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.push(
                  '/chat/brand/${storefront.brandId}',
                ),
                icon: const Icon(Icons.chat_bubble_outline, size: 18),
                label: const Text('Chat with Brand'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.buyMarketplaceAccent,
                  side:
                      const BorderSide(color: AppColors.buyMarketplaceAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrustBadge(TrustBadge badge) {
    IconData icon;
    Color color;
    switch (badge) {
      case TrustBadge.verified:
        icon = Icons.verified;
        color = AppColors.buyMarketplaceAccent;
      case TrustBadge.topSeller:
        icon = Icons.emoji_events;
        color = AppColors.gold;
      case TrustBadge.localBusiness:
        icon = Icons.location_on;
        color = AppColors.buySuccess;
      case TrustBadge.newBrand:
        icon = Icons.fiber_new;
        color = AppColors.info;
    }
    return Icon(icon, size: 18, color: color);
  }

  // ─── Section Router ──────────────────────────────────────

  Widget _buildSectionByType(
    BuildContext context,
    StorefrontSectionType type,
    DateTime now,
  ) {
    switch (type) {
      case StorefrontSectionType.quickActions:
        return _buildQuickActions(context);
      case StorefrontSectionType.featuredProducts:
        return _buildFeaturedProducts(context);
      case StorefrontSectionType.products:
        return _buildProducts(context);
      case StorefrontSectionType.banner:
        return _buildBanner(context);
      case StorefrontSectionType.promotions:
        return _buildPromotions(now);
      case StorefrontSectionType.gallery:
        return _buildGallery();
      case StorefrontSectionType.reviews:
        return _buildReviews();
      case StorefrontSectionType.about:
        return _buildAbout();
      case StorefrontSectionType.socialLinks:
        return _buildSocialLinks();
      case StorefrontSectionType.announcementBar:
        return _buildAnnouncementBar();
      case StorefrontSectionType.videoShowcase:
        return _buildVideoShowcase();
      case StorefrontSectionType.couponCenter:
        return _buildCouponCenter(now);
      case StorefrontSectionType.faq:
        return _buildFaq();
      case StorefrontSectionType.testimonials:
        return _buildTestimonials();
      case StorefrontSectionType.locationCard:
        return _buildLocationCard();
      case StorefrontSectionType.divider:
        return _buildDivider();
      case StorefrontSectionType.richText:
        return _buildRichText();
    }
  }

  // ─── Quick Actions ───────────────────────────────────────

  Widget _buildQuickActions(BuildContext context) {
    if (storefront.quickActions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Quick Actions'),
          Row(
            children: storefront.quickActions
                .take(4)
                .map((action) => Expanded(
                      child: _buildActionButton(
                        context,
                        emoji: action.iconEmoji,
                        label: action.label,
                        deepLink: action.deepLink,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String emoji,
    required String label,
    required String deepLink,
  }) {
    return GestureDetector(
      onTap: widget.interactive
          ? () {
              if (deepLink.startsWith('http://') ||
                  deepLink.startsWith('https://')) {
                _launchUrl(deepLink);
              } else if (deepLink.startsWith('/')) {
                try {
                  context.push(deepLink);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to open this link')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid link')),
                );
              }
            }
          : null,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.buyCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.buyCardBorder.withValues(alpha: 0.5),
              ),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.buyTextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Featured Products (horizontal scroll) ───────────────

  Widget _buildFeaturedProducts(BuildContext context) {
    final featured =
        widget.products.where((p) => p.isFeatured && p.isActive).toList();

    if (widget.isLoadingProducts && featured.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SizedBox(
          height: 180,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (featured.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Featured',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.buyTextPrimary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: featured.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) =>
                  _buildProductCard(context, featured[index], width: 160),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Products (grid) ─────────────────────────────────────

  Widget _buildProducts(BuildContext context) {
    final allProducts = widget.products.where((p) => p.isActive).toList();

    if (widget.isLoadingProducts && allProducts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SizedBox(
          height: 120,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (allProducts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Products (${allProducts.length})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.buyTextPrimary,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: allProducts.length,
            itemBuilder: (context, index) =>
                _buildProductCard(context, allProducts[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, BrandProduct product,
      {double? width}) {
    return GestureDetector(
      onTap: widget.interactive
          ? () => context.push(
                '/buy/brand/${product.brandId}/product/${product.id}',
                extra: product,
              )
          : null,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.buyCardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: product.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: product.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => Container(
                          color: AppColors.buyShimmerBase,
                        ),
                        errorWidget: (_, _, _) => Container(
                          color: AppColors.buyCard,
                          child: const Icon(Icons.image_outlined,
                              color: AppColors.buyTextTertiary),
                        ),
                      )
                    : Container(
                        color: AppColors.buyCard,
                        child: const Icon(Icons.shopping_bag_outlined,
                            color: AppColors.buyTextTertiary, size: 32),
                      ),
              ),
            ),
            // Product info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buyTextPrimary,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${product.priceTokens} tokens',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.buyMarketplaceAccent,
                          ),
                        ),
                        const Spacer(),
                        if (!product.isInStock)
                          const Text(
                            'Out of stock',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.buyError,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                    if (product.category != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        product.category!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.buyTextTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Banner ──────────────────────────────────────────────

  Widget _buildBanner(BuildContext context) {
    if (storefront.bannerImageUrl == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: widget.interactive && storefront.bannerDeepLink != null
            ? () {
                final link = storefront.bannerDeepLink!;
                if (link.startsWith('http://') || link.startsWith('https://')) {
                  _launchUrl(link);
                } else {
                  context.push(link);
                }
              }
            : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: storefront.bannerImageUrl!,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            placeholder: (_, _) => Container(
              height: 100,
              color: AppColors.buyCard,
            ),
            errorWidget: (_, _, _) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  // ─── Promotions ──────────────────────────────────────────

  Widget _buildPromotions(DateTime now) {
    final activePromos = storefront.promotions
        .where((p) => p.expiresAt == null || p.expiresAt!.isAfter(now))
        .toList();
    if (activePromos.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Promotions'),
          ...activePromos.map((promo) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: BrandCard(
                  gradient: BrandGradient.goldOrange,
                  tintOpacity: 0.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buyTextPrimary,
                        ),
                      ),
                      if (promo.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          promo.description!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.buyTextSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  // ─── Gallery ─────────────────────────────────────────────

  Widget _buildGallery() {
    if (storefront.galleryImageUrls.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _SectionTitle('Gallery'),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: storefront.galleryImageUrls.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: storefront.galleryImageUrls[index],
                    width: 180,
                    height: 140,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      width: 180,
                      color: AppColors.buyCard,
                    ),
                    errorWidget: (_, _, _) => Container(
                      width: 180,
                      color: AppColors.buyCard,
                      child: const Icon(Icons.broken_image,
                          color: AppColors.buyTextTertiary),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─── Reviews ─────────────────────────────────────────────

  Widget _buildReviews() {
    final allVisible = widget.reviews.where((r) => r.isVisible).toList();

    if ((storefront.ratingCount == null || storefront.ratingCount == 0) &&
        allVisible.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayedReviews = allVisible.take(10).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary card
          if (storefront.ratingCount != null && storefront.ratingCount! > 0)
            BrandCard(
              gradient: BrandGradient.none,
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        storefront.averageRating?.toStringAsFixed(1) ?? '\u2014',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.buyTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${storefront.ratingCount} reviews',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.buyTextTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < (storefront.averageRating ?? 0).round()
                              ? Icons.star
                              : Icons.star_border,
                          size: 20,
                          color: AppColors.gold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Review cards
          if (displayedReviews.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...displayedReviews.map(_buildReviewCard),
          ],

          // Write a Review button (only in interactive mode)
          if (widget.interactive) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.rate_review_outlined, size: 18),
                label: const Text('Write a Review'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.buyMarketplaceAccent,
                  side:
                      const BorderSide(color: AppColors.buyMarketplaceAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: null, // Handled by consumer screen's BLoC
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewCard(BrandReview review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.buyCardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      AppColors.buyMarketplaceAccent.withValues(alpha: 0.15),
                  child: Text(
                    review.userName.isNotEmpty
                        ? review.userName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: AppColors.buyMarketplaceAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    review.userName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.buyTextPrimary,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < review.overallRating.round()
                          ? Icons.star
                          : Icons.star_border,
                      size: 14,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ],
            ),
            if (review.comment != null && review.comment!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                review.comment!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.buyTextSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ─── About ───────────────────────────────────────────────

  Widget _buildAbout() {
    if (storefront.description == null && storefront.establishedYear == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: BrandCard(
        gradient: BrandGradient.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle('About'),
            if (storefront.description != null) ...[
              Text(
                storefront.description!,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.buyTextSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (storefront.establishedYear != null)
              _buildInfoRow(
                Icons.calendar_today,
                'Est. ${storefront.establishedYear}',
              ),
          ],
        ),
      ),
    );
  }

  // ─── Social Links ────────────────────────────────────────

  Widget _buildSocialLinks() {
    if (storefront.socialLinks.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Follow Us'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: storefront.socialLinks.entries.map((entry) {
              return GestureDetector(
                onTap: widget.interactive
                    ? () => _launchUrl(entry.value)
                    : null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.buyCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.buyCardBorder.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _socialIcon(entry.key),
                        size: 16,
                        color: AppColors.buyTextSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _socialLabel(entry.key),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buyTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── Announcement Bar ──────────────────────────────────

  Widget _buildAnnouncementBar() {
    final text = storefront.announcementText;
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    if (_announcementDismissed) return const SizedBox.shrink();

    final deepLink = storefront.announcementDeepLink;

    return GestureDetector(
      onTap: widget.interactive && deepLink != null && deepLink.isNotEmpty
          ? () {
              if (deepLink.startsWith('http://') ||
                  deepLink.startsWith('https://')) {
                _launchUrl(deepLink);
              } else if (deepLink.startsWith('/')) {
                context.push(deepLink);
              }
            }
          : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: AppColors.parseHex(storefront.accentColor),
        child: Row(
          children: [
            const Icon(Icons.campaign, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (storefront.announcementDismissible && widget.interactive)
              GestureDetector(
                onTap: () => setState(() => _announcementDismissed = true),
                child:
                    const Icon(Icons.close, color: Colors.white70, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  // ─── Video Showcase ──────────────────────────────────────

  Widget _buildVideoShowcase() {
    final videos = storefront.showcaseVideos;
    if (videos.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Videos'),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final video = videos[index];
                return Container(
                  width: 260,
                  decoration: BoxDecoration(
                    color: AppColors.buyCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color:
                            AppColors.buyCardBorder.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (video.thumbnailUrl != null)
                                CachedNetworkImage(
                                  imageUrl: video.thumbnailUrl!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (_, _) => Container(
                                      color: AppColors.buyShimmerBase),
                                  errorWidget: (_, _, _) => Container(
                                      color: AppColors.buyShimmerBase),
                                )
                              else
                                Container(color: AppColors.buyShimmerBase),
                              const Center(
                                child: Icon(Icons.play_circle_fill,
                                    size: 48, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          video.title ?? '',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─── Coupon Center ───────────────────────────────────────

  Widget _buildCouponCenter(DateTime now) {
    final coupons = storefront.coupons
        .where((c) => c.isActive != false)
        .where((c) => c.expiresAt == null || c.expiresAt!.isAfter(now))
        .toList();
    if (coupons.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Coupons & Deals'),
          const SizedBox(height: 8),
          ...coupons.map((coupon) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (AppColors.parseHex(storefront.accentColor))
                        .withValues(alpha: 0.1),
                    AppColors.buyCard,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (AppColors.parseHex(storefront.accentColor))
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.local_offer,
                      color: AppColors.parseHex(storefront.accentColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coupon.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        if (coupon.description != null)
                          Text(
                            coupon.description!,
                            style: const TextStyle(
                                color: AppColors.buyTextSecondary,
                                fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (coupon.maxClaims != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            '${(coupon.maxClaims! - coupon.claimCount).clamp(0, coupon.maxClaims!)} of ${coupon.maxClaims} claims remaining',
                            style: TextStyle(
                              color:
                                  (coupon.maxClaims! - coupon.claimCount) <= 5
                                      ? AppColors.buyError
                                      : AppColors.buyTextTertiary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Claim button — disabled in non-interactive mode
                  TextButton(
                    onPressed: null, // Claiming handled by BLoC in consumer
                    child: Text(widget.interactive ? 'Claim' : 'Claim'),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── FAQ ─────────────────────────────────────────────────

  Widget _buildFaq() {
    final items = storefront.faqItems;
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('FAQ'),
          const SizedBox(height: 8),
          ...items.map((faq) {
            return ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(bottom: 12),
              title: Text(
                faq.question,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.buyTextPrimary,
                ),
              ),
              children: [
                Text(
                  faq.answer,
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ─── Testimonials ────────────────────────────────────────

  Widget _buildTestimonials() {
    final reviewIds = storefront.testimonialReviewIds;
    if (reviewIds.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle('What People Say'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
              ),
              child: const Center(
                child: Text(
                  'No testimonials yet',
                  style: TextStyle(
                      color: AppColors.buyTextTertiary, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final testimonialReviews = widget.reviews
        .where((r) => reviewIds.contains(r.id) && r.isVisible)
        .toList();

    if (testimonialReviews.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('What People Say'),
          const SizedBox(height: 8),
          ...testimonialReviews.map(_buildReviewCard),
        ],
      ),
    );
  }

  // ─── Location Card ───────────────────────────────────────

  Widget _buildLocationCard() {
    final locations = storefront.locations;
    if (locations.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Locations'),
          const SizedBox(height: 8),
          ...locations.map((loc) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on,
                      color: AppColors.buyTextSecondary, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        Text(
                          loc.address,
                          style: const TextStyle(
                              color: AppColors.buyTextSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Divider ─────────────────────────────────────────────

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Divider(color: AppColors.buyCardBorder, thickness: 0.5),
    );
  }

  // ─── Rich Text ───────────────────────────────────────────

  Widget _buildRichText() {
    final blocks = storefront.richTextBlocks;
    if (blocks.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: blocks.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              entry.value,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: AppColors.buyTextPrimary,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ─── Legacy Section Router ───────────────────────────────

  Widget _buildLegacySection(BuildContext context, StorefrontSection section) {
    switch (section.type) {
      case 'hero':
        return _buildLegacyHero(section);
      case 'quick_actions':
        return _buildLegacyQuickActions(context, section);
      case 'product_grid':
        return _buildLegacyProductGrid(context, section);
      case 'about':
        return _buildLegacyAbout(section);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLegacyHero(StorefrontSection section) {
    final imageUrl = section.data['imageUrl'] as String?;
    final title = section.data['title'] as String? ?? section.title ?? '';
    final subtitle = section.data['subtitle'] as String?;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: BrandCard(
        gradient: BrandGradient.goldOrange,
        tintOpacity: 0.10,
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              if (imageUrl != null)
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const SizedBox(height: 120),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.buyTextPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.buyTextSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegacyQuickActions(
      BuildContext context, StorefrontSection section) {
    final actions = (section.data['actions'] as List<dynamic>?) ?? [];
    if (actions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.title != null && section.title!.isNotEmpty)
            _SectionTitle(section.title!),
          Row(
            children: actions
                .take(4)
                .map((action) {
                  final a = action as Map<String, dynamic>;
                  return Expanded(
                    child: GestureDetector(
                      onTap: widget.interactive && a['deepLink'] != null
                          ? () {
                              final link = a['deepLink'] as String;
                              if (link.startsWith('http://') ||
                                  link.startsWith('https://')) {
                                _launchUrl(link);
                              } else {
                                context.push(link);
                              }
                            }
                          : null,
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.buyCard,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.buyCardBorder
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                a['icon'] as String? ?? '\u{1F4E6}',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            a['label'] as String? ?? '',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.buyTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegacyProductGrid(
      BuildContext context, StorefrontSection section) {
    final products = (section.data['products'] as List<dynamic>?) ?? [];
    if (products.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.title != null && section.title!.isNotEmpty)
            _SectionTitle(section.title!),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index] as Map<String, dynamic>;
              final name = p['name'] as String? ?? '';
              final price = (p['price'] as num?)?.toInt() ?? 0;
              final imageUrl = p['imageUrl'] as String?;
              final deepLink = p['deepLink'] as String?;

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.buyCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.buyCardBorder.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: SizedBox(
                          width: double.infinity,
                          child: imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (_, _) =>
                                      Container(color: AppColors.buyCard),
                                  errorWidget: (_, _, _) => Container(
                                    color: AppColors.buyCard,
                                    child: const Icon(Icons.image,
                                        color: AppColors.buyTextTertiary),
                                  ),
                                )
                              : Container(
                                  color: AppColors.buyCard,
                                  child: const Icon(Icons.shopping_bag,
                                      color: AppColors.buyTextTertiary),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buyTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.toll,
                                      size: 14, color: AppColors.gold),
                                  const SizedBox(width: 3),
                                  Text(
                                    '$price',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                ],
                              ),
                              if (widget.interactive && deepLink != null)
                                GestureDetector(
                                  onTap: () {
                                    if (deepLink.startsWith('http://') ||
                                        deepLink.startsWith('https://')) {
                                      _launchUrl(deepLink);
                                    } else {
                                      context.push(deepLink);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.buyMarketplaceAccent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Buy',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textOnPrimary,
                                      ),
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
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegacyAbout(StorefrontSection section) {
    final description = section.data['description'] as String?;
    final address = section.data['address'] as String?;
    final phone = section.data['phone'] as String?;
    final hours = section.data['hours'] as String?;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: BrandCard(
        gradient: BrandGradient.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.title != null && section.title!.isNotEmpty)
              _SectionTitle(section.title!),
            if (description != null) ...[
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.buyTextSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (address != null) _buildInfoRow(Icons.location_on, address),
            if (phone != null) _buildInfoRow(Icons.phone, phone),
            if (hours != null) _buildInfoRow(Icons.access_time, hours),
          ],
        ),
      ),
    );
  }

  // ─── Helpers ─────────────────────────────────────────────

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.buyTextTertiary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.buyTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _socialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'whatsapp':
        return Icons.chat;
      case 'instagram':
        return Icons.camera_alt;
      case 'facebook':
        return Icons.facebook;
      case 'website':
        return Icons.language;
      case 'tiktok':
        return Icons.music_note;
      case 'x':
        return Icons.alternate_email;
      case 'youtube':
        return Icons.play_circle;
      default:
        return Icons.link;
    }
  }

  String _socialLabel(String platform) {
    switch (platform.toLowerCase()) {
      case 'whatsapp':
        return 'WhatsApp';
      case 'instagram':
        return 'Instagram';
      case 'facebook':
        return 'Facebook';
      case 'website':
        return 'Website';
      case 'tiktok':
        return 'TikTok';
      case 'x':
        return 'X';
      case 'youtube':
        return 'YouTube';
      default:
        return platform;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (_) {
        // Silently fail
      }
    }
  }
}

// ─── Reusable Section Title ──────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.buyTextPrimary,
        ),
      ),
    );
  }
}
