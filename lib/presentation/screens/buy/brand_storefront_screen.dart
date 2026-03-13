import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/brand_product.dart';
import '../../../domain/entities/brand_review.dart';
import '../../../domain/entities/brand_storefront.dart';
import '../../blocs/brand_storefront/brand_storefront_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/brand_card.dart';

class BrandStorefrontScreen extends StatelessWidget {
  final String storefrontId;
  final String? orderId;

  const BrandStorefrontScreen({
    super.key,
    required this.storefrontId,
    this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<BrandStorefrontBloc>()
        ..add(BrandStorefrontEvent.loadStorefront(
          storefrontId,
          orderId: orderId,
        )),
      child: BlocListener<BrandStorefrontBloc, BrandStorefrontState>(
        listenWhen: (prev, curr) =>
            prev.storefront == null && curr.storefront != null,
        listener: (context, state) {
          context
              .read<BrandStorefrontBloc>()
              .add(BrandStorefrontEvent.recordView(storefrontId));
        },
        child: const _BrandStorefrontBody(),
      ),
    );
  }
}

class _BrandStorefrontBody extends StatefulWidget {
  const _BrandStorefrontBody();

  @override
  State<_BrandStorefrontBody> createState() => _BrandStorefrontBodyState();
}

class _BrandStorefrontBodyState extends State<_BrandStorefrontBody> {
  bool _announcementDismissed = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandStorefrontBloc, BrandStorefrontState>(
      listenWhen: (prev, curr) =>
          (prev.errorMessage != curr.errorMessage &&
              curr.errorMessage != null &&
              curr.storefront != null) ||
          (prev.lastClaimedCouponCode != curr.lastClaimedCouponCode &&
              curr.lastClaimedCouponCode != null),
      listener: (context, state) {
        if (state.lastClaimedCouponCode != null &&
            state.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Coupon claimed: ${state.lastClaimedCouponCode}'),
              backgroundColor: AppColors.buySuccess,
            ),
          );
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.buyError,
            ),
          );
        }
      },
      builder: (context, state) {
        final storefront = state.storefront;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: Text(
              storefront?.brandName ?? 'Brand',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.buyBackground,
            elevation: 0,
            actions: [
              if (storefront != null)
                IconButton(
                  icon: state.isTogglingFollow
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.buyTextSecondary,
                          ),
                        )
                      : Icon(
                          state.isFollowing
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: state.isFollowing
                              ? AppColors.buyError
                              : AppColors.buyTextSecondary,
                        ),
                  onPressed: state.isTogglingFollow
                      ? null
                      : () => context
                          .read<BrandStorefrontBloc>()
                          .add(BrandStorefrontEvent.toggleFollow(
                            storefront.brandId,
                          )),
                ),
            ],
          ),
          backgroundColor: AppColors.buyBackground,
          body: state.isLoading
              ? _buildLoading()
              : storefront != null
                  ? _buildStorefront(context, storefront)
                  : state.errorMessage != null
                      ? _buildError(context, state.errorMessage!)
                      : _buildError(context, 'Storefront not found'),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: AppColors.buyShimmerBase,
      highlightColor: AppColors.buyShimmerHigh,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.buyCard,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.buyCard,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.buyCard,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.buyError, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.buyTextSecondary,
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'Go Back',
              onPressed: () => context.pop(),
              variant: AppButtonVariant.outline,
              size: AppButtonSize.small,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorefront(BuildContext context, BrandStorefront storefront) {
    final useSectionOrder = storefront.sectionOrder.isNotEmpty;
    final now = DateTime.now();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildHero(storefront),
        ),

        SliverToBoxAdapter(
          child: _buildBrandHeader(context, storefront),
        ),

        if (useSectionOrder)
          ...storefront.sectionOrder.map(
            (type) => SliverToBoxAdapter(
              child: _buildSectionByType(context, type, storefront, now),
            ),
          )
        else
          ...(storefront.sections.where((s) => s.isVisible).toList()
                ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)))
              .map(
            (section) => SliverToBoxAdapter(
              child: _buildLegacySection(context, section, storefront),
            ),
          ),

        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }

  // ─── Hero ──────────────────────────────────────────────────

  Widget _buildHero(BrandStorefront storefront) {
    final heroImage = storefront.heroImageUrl ?? storefront.coverImageUrl;

    if (storefront.heroStyle == HeroStyle.fullBleedImage &&
        heroImage != null) {
      return SizedBox(
        height: 200,
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: heroImage,
          fit: BoxFit.cover,
          placeholder: (_, _) => Container(color: AppColors.buyCard),
          errorWidget: (_, _, _) => _buildGradientHero(storefront),
        ),
      );
    }

    return _buildGradientHero(storefront);
  }

  Widget _buildGradientHero(BrandStorefront storefront) {
    final primaryColor = AppColors.parseHex(
      storefront.brandColor ?? storefront.accentColor,
    );
    final secondaryColor = storefront.secondaryColor != null
        ? AppColors.parseHex(storefront.secondaryColor)
        : primaryColor.withValues(alpha: 0.6);

    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: storefront.brandLogoUrl != null
            ? CachedNetworkImage(
                imageUrl: storefront.brandLogoUrl!,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
                errorWidget: (_, _, _) => Text(
                  storefront.brandName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                storefront.brandName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  // ─── Brand Header ────────────────────────────────────────

  Widget _buildBrandHeader(BuildContext context, BrandStorefront storefront) {
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
          // Chat button — visible only when brand enables it
          if (storefront.showChatButton) ...[
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
                  side: const BorderSide(color: AppColors.buyMarketplaceAccent),
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
    BrandStorefront storefront,
    DateTime now,
  ) {
    switch (type) {
      case StorefrontSectionType.quickActions:
        return _buildQuickActions(context, storefront);
      case StorefrontSectionType.featuredProducts:
        return _buildFeaturedProducts(context, storefront);
      case StorefrontSectionType.products:
        return _buildProducts(context, storefront);
      case StorefrontSectionType.banner:
        return _buildBanner(context, storefront);
      case StorefrontSectionType.promotions:
        return _buildPromotions(storefront, now);
      case StorefrontSectionType.gallery:
        return _buildGallery(storefront);
      case StorefrontSectionType.reviews:
        return _buildReviews(context, storefront);
      case StorefrontSectionType.about:
        return _buildAbout(storefront);
      case StorefrontSectionType.socialLinks:
        return _buildSocialLinks(storefront);
      case StorefrontSectionType.announcementBar:
        return _buildAnnouncementBar(storefront);
      case StorefrontSectionType.videoShowcase:
        return _buildVideoShowcase(storefront);
      case StorefrontSectionType.couponCenter:
        return _buildCouponCenter(context, storefront, now);
      case StorefrontSectionType.faq:
        return _buildFaq(storefront);
      case StorefrontSectionType.testimonials:
        return _buildTestimonials(storefront);
      case StorefrontSectionType.locationCard:
        return _buildLocationCard(storefront);
      case StorefrontSectionType.divider:
        return _buildDivider();
      case StorefrontSectionType.richText:
        return _buildRichText(storefront);
    }
  }

  // ─── Quick Actions ───────────────────────────────────────

  Widget _buildQuickActions(BuildContext context, BrandStorefront storefront) {
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
      onTap: () {
        if (deepLink.startsWith('/')) {
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
      },
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

  Widget _buildFeaturedProducts(
      BuildContext context, BrandStorefront storefront) {
    final state = context.watch<BrandStorefrontBloc>().state;
    final featured =
        state.products.where((p) => p.isFeatured && p.isActive).toList();

    if (state.isLoadingProducts && featured.isEmpty) {
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
            height: 200,
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

  Widget _buildProducts(BuildContext context, BrandStorefront storefront) {
    final state = context.watch<BrandStorefrontBloc>().state;
    final allProducts =
        state.products.where((p) => p.isActive).toList();

    if (state.isLoadingProducts && allProducts.isEmpty) {
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
      onTap: () {
        // Navigate to product detail using brand and product IDs
        context.push(
          '/buy/brand/${product.brandId}/product/${product.id}',
          extra: product,
        );
      },
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

  Widget _buildBanner(BuildContext context, BrandStorefront storefront) {
    if (storefront.bannerImageUrl == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: storefront.bannerDeepLink != null
            ? () => context.push(storefront.bannerDeepLink!)
            : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: storefront.bannerImageUrl!,
            width: double.infinity,
            height: 100,
            fit: BoxFit.cover,
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

  Widget _buildPromotions(BrandStorefront storefront, DateTime now) {
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

  Widget _buildGallery(BrandStorefront storefront) {
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

  Widget _buildReviews(BuildContext context, BrandStorefront storefront) {
    final orderId =
        context.read<BrandStorefrontBloc>().state.eligibleReviewOrderId;
    return _PaginatedReviewsSection(
      storefront: storefront,
      orderId: orderId,
      onWriteReview: orderId != null
          ? () => _showReviewBottomSheet(context, storefront.brandId,
              orderId: orderId)
          : null,
      buildReviewCard: _buildReviewCard,
    );
  }

  void _showReviewBottomSheet(
    BuildContext context,
    String brandId, {
    required String orderId,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.buyCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<BrandStorefrontBloc>(),
        child: _ReviewSubmissionSheet(
          brandId: brandId,
          orderId: orderId,
        ),
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

  Widget _buildAbout(BrandStorefront storefront) {
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

  Widget _buildSocialLinks(BrandStorefront storefront) {
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
                onTap: () => _launchUrl(entry.value),
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

  Widget _buildAnnouncementBar(BrandStorefront storefront) {
    final text = storefront.announcementText;
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    if (_announcementDismissed) return const SizedBox.shrink();

    return Container(
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
          if (storefront.announcementDismissible)
            GestureDetector(
              onTap: () => setState(() => _announcementDismissed = true),
              child: const Icon(Icons.close, color: Colors.white70, size: 16),
            ),
        ],
      ),
    );
  }

  // ─── Video Showcase ──────────────────────────────────────

  Widget _buildVideoShowcase(BrandStorefront storefront) {
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
                    border: Border.all(color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (video.thumbnailUrl != null)
                                CachedNetworkImage(
                                  imageUrl: video.thumbnailUrl!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (_, _) => Container(color: AppColors.buyShimmerBase),
                                  errorWidget: (_, _, _) => Container(color: AppColors.buyShimmerBase),
                                )
                              else
                                Container(color: AppColors.buyShimmerBase),
                              const Center(
                                child: Icon(Icons.play_circle_fill, size: 48, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          video.title ?? '',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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

  Widget _buildCouponCenter(
      BuildContext context, BrandStorefront storefront, DateTime now) {
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
                    (AppColors.parseHex(storefront.accentColor)).withValues(alpha: 0.1),
                    AppColors.buyCard,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (AppColors.parseHex(storefront.accentColor)).withValues(alpha: 0.15),
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
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        if (coupon.description != null)
                          Text(
                            coupon.description!,
                            style: const TextStyle(color: AppColors.buyTextSecondary, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        // Show remaining claims
                        if (coupon.maxClaims != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            '${(coupon.maxClaims! - coupon.claimCount).clamp(0, coupon.maxClaims!)} of ${coupon.maxClaims} claims remaining',
                            style: TextStyle(
                              color: (coupon.maxClaims! - coupon.claimCount) <= 5
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
                  BlocBuilder<BrandStorefrontBloc, BrandStorefrontState>(
                    buildWhen: (prev, curr) =>
                        prev.isClaimingCoupon != curr.isClaimingCoupon ||
                        prev.claimedCouponIds != curr.claimedCouponIds,
                    builder: (context, state) {
                      final isClaimed = state.claimedCouponIds.contains(coupon.id);
                      return TextButton(
                        onPressed: isClaimed || state.isClaimingCoupon
                            ? null
                            : () {
                                context.read<BrandStorefrontBloc>().add(
                                      BrandStorefrontEvent.claimCoupon(
                                        storefrontId: storefront.id,
                                        couponId: coupon.id,
                                        couponCode: coupon.code,
                                      ),
                                    );
                              },
                        child: Text(isClaimed ? 'Claimed' : 'Claim'),
                      );
                    },
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

  Widget _buildFaq(BrandStorefront storefront) {
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

  Widget _buildTestimonials(BrandStorefront storefront) {
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
                border:
                    Border.all(color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
              ),
              child: const Center(
                child: Text(
                  'No testimonials yet',
                  style:
                      TextStyle(color: AppColors.buyTextTertiary, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<BrandStorefrontBloc, BrandStorefrontState>(
      buildWhen: (prev, curr) => prev.reviews != curr.reviews,
      builder: (context, state) {
        final testimonialReviews = state.reviews
            .where((r) => reviewIds.contains(r.id) && r.isVisible)
            .toList();

        if (testimonialReviews.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionTitle('What People Say'),
              const SizedBox(height: 8),
              ...testimonialReviews.map((review) => _buildReviewCard(review)),
            ],
          ),
        );
      },
    );
  }

  // ─── Location Card ───────────────────────────────────────

  Widget _buildLocationCard(BrandStorefront storefront) {
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
                border: Border.all(color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.buyTextSecondary, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.name,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        Text(
                          loc.address,
                          style: const TextStyle(color: AppColors.buyTextSecondary, fontSize: 12),
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

  Widget _buildRichText(BrandStorefront storefront) {
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

  Widget _buildLegacySection(
    BuildContext context,
    StorefrontSection section,
    BrandStorefront storefront,
  ) {
    switch (section.type) {
      case 'hero':
        return _StorefrontHeroSection(section: section);
      case 'quick_actions':
        return _StorefrontQuickActionsLegacy(section: section);
      case 'product_grid':
        return _StorefrontProductGridLegacy(section: section);
      case 'about':
        return _StorefrontAboutLegacy(section: section);
      default:
        return const SizedBox.shrink();
    }
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
        // Silently fail — URL may be malformed or no handler available
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

// ─── Legacy Section Widgets (backward compat) ────────────────

class _StorefrontHeroSection extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontHeroSection({required this.section});

  @override
  Widget build(BuildContext context) {
    final imageUrl = section.data['imageUrl'] as String?;
    final title = section.data['title'] as String? ?? section.title ?? '';
    final subtitle = section.data['subtitle'] as String?;
    final ctaText = section.data['ctaText'] as String?;
    final ctaDeepLink = section.data['ctaDeepLink'] as String?;

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
                    if (ctaText != null && ctaDeepLink != null) ...[
                      const SizedBox(height: 10),
                      AppButton(
                        text: ctaText,
                        onPressed: () => context.push(ctaDeepLink),
                        size: AppButtonSize.small,
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
}

class _StorefrontQuickActionsLegacy extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontQuickActionsLegacy({required this.section});

  @override
  Widget build(BuildContext context) {
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
                      onTap: a['deepLink'] != null
                          ? () => context.push(a['deepLink'] as String)
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
                              child: Text(
                                a['icon'] as String? ?? '📦',
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
}

class _StorefrontProductGridLegacy extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontProductGridLegacy({required this.section});

  @override
  Widget build(BuildContext context) {
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
                              if (deepLink != null)
                                GestureDetector(
                                  onTap: () => context.push(deepLink),
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
}

class _StorefrontAboutLegacy extends StatelessWidget {
  final StorefrontSection section;
  const _StorefrontAboutLegacy({required this.section});

  @override
  Widget build(BuildContext context) {
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
}

// ─── Review Submission Bottom Sheet ───────────────────────

/// Paginated reviews section: shows first 10, then "Load more" in batches of 10.
class _PaginatedReviewsSection extends StatefulWidget {
  final BrandStorefront storefront;
  final String? orderId;
  final VoidCallback? onWriteReview;
  final Widget Function(BrandReview) buildReviewCard;

  const _PaginatedReviewsSection({
    required this.storefront,
    this.orderId,
    this.onWriteReview,
    required this.buildReviewCard,
  });

  @override
  State<_PaginatedReviewsSection> createState() =>
      _PaginatedReviewsSectionState();
}

class _PaginatedReviewsSectionState extends State<_PaginatedReviewsSection> {
  static const _pageSize = 10;
  int _visibleCount = _pageSize;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BrandStorefrontBloc>().state;
    final allVisible = state.reviews.where((r) => r.isVisible).toList();
    final storefront = widget.storefront;

    if ((storefront.ratingCount == null || storefront.ratingCount == 0) &&
        allVisible.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayedReviews = allVisible.take(_visibleCount).toList();
    final hasMore = allVisible.length > _visibleCount;

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

          // Review cards (paginated)
          if (displayedReviews.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...displayedReviews.map(widget.buildReviewCard),
          ],

          // "Load more" button
          if (hasMore) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () =>
                    setState(() => _visibleCount += _pageSize),
                child: Text(
                  'Show more reviews (${(allVisible.length - _visibleCount).clamp(0, allVisible.length)} remaining)',
                  style: const TextStyle(
                    color: AppColors.buyMarketplaceAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],

          // Write a Review button
          const SizedBox(height: 12),
          Tooltip(
            message: widget.onWriteReview == null
                ? 'Purchase an item to leave a review'
                : '',
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.rate_review_outlined, size: 18),
                label: const Text('Write a Review'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.buyMarketplaceAccent,
                  side: const BorderSide(color: AppColors.buyMarketplaceAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: widget.onWriteReview,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewSubmissionSheet extends StatefulWidget {
  final String brandId;
  final String orderId;

  const _ReviewSubmissionSheet({
    required this.brandId,
    required this.orderId,
  });

  @override
  State<_ReviewSubmissionSheet> createState() => _ReviewSubmissionSheetState();
}

class _ReviewSubmissionSheetState extends State<_ReviewSubmissionSheet> {
  int _qualityRating = 0;
  int _valueRating = 0;
  int _serviceRating = 0;
  final _commentController = TextEditingController();
  bool _hasListenedForSuccess = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _qualityRating > 0 && _valueRating > 0 && _serviceRating > 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BrandStorefrontBloc, BrandStorefrontState>(
      listenWhen: (prev, curr) =>
          prev.isSubmittingReview && !curr.isSubmittingReview,
      listener: (context, state) {
        if (_hasListenedForSuccess) return;
        if (state.reviewSubmitSuccess) {
          _hasListenedForSuccess = true;
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review submitted successfully'),
              backgroundColor: AppColors.buySuccess,
            ),
          );
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.buyError,
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.buyCardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Title
              const Text(
                'Write a Review',
                style: TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Quality rating
              _buildStarRow('Quality', _qualityRating, (v) {
                setState(() => _qualityRating = v);
              }),
              const SizedBox(height: AppSpacing.md),

              // Value rating
              _buildStarRow('Value', _valueRating, (v) {
                setState(() => _valueRating = v);
              }),
              const SizedBox(height: AppSpacing.md),

              // Service rating
              _buildStarRow('Service', _serviceRating, (v) {
                setState(() => _serviceRating = v);
              }),
              const SizedBox(height: AppSpacing.lg),

              // Comment field
              TextField(
                controller: _commentController,
                maxLength: 500,
                maxLines: 3,
                style: const TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Add a comment (optional)',
                  hintStyle: const TextStyle(color: AppColors.buyTextTertiary),
                  filled: true,
                  fillColor: AppColors.buyCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyCardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyCardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: const BorderSide(color: AppColors.buyMarketplaceAccent),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Action buttons
              BlocBuilder<BrandStorefrontBloc, BrandStorefrontState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: state.isSubmittingReview
                              ? null
                              : () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.buyTextSecondary,
                            side: const BorderSide(color: AppColors.buyCardBorder),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isValid &&
                                  !state.isSubmittingReview &&
                                  !state.reviewSubmitSuccess
                              ? _onSubmit
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buyMarketplaceAccent,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                AppColors.buyMarketplaceAccent.withValues(alpha: 0.4),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                          ),
                          child: state.isSubmittingReview
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Submit'),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRow(
    String label,
    int currentRating,
    ValueChanged<int> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        ...List.generate(5, (i) {
          final starIndex = i + 1;
          return GestureDetector(
            onTap: () => onChanged(starIndex),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                starIndex <= currentRating ? Icons.star : Icons.star_border,
                color: AppColors.gold,
                size: 28,
              ),
            ),
          );
        }),
      ],
    );
  }

  void _onSubmit() {
    if (!_isValid) return;

    context.read<BrandStorefrontBloc>().add(
          BrandStorefrontEvent.submitReview(
            brandId: widget.brandId,
            orderId: widget.orderId,
            qualityRating: _qualityRating,
            valueRating: _valueRating,
            serviceRating: _serviceRating,
            comment: _commentController.text.trim().isEmpty
                ? null
                : _commentController.text.trim(),
          ),
        );
  }
}
