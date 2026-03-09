import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/buy_category.dart';
import '../../../domain/entities/featured_item.dart';
import '../../blocs/buy_tab/buy_tab_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/buy/brand_partners_strip.dart';
import '../../widgets/buy/buy_category_grid.dart';
import '../../widgets/buy/buy_layer_divider.dart';
import '../../widgets/buy/buy_offline_banner.dart';
import '../../widgets/buy/buy_section_header.dart';
import '../../widgets/buy/featured_carousel.dart';
import '../../widgets/buy/my_regulars_dock.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/brand_card.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class BuyServicesScreen extends StatefulWidget {
  const BuyServicesScreen({super.key});

  @override
  State<BuyServicesScreen> createState() => _BuyServicesScreenState();
}

class _BuyServicesScreenState extends State<BuyServicesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BuyTabBloc>().add(const BuyTabEvent.loadBuyTab());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(
        title: 'Buy',
        extraActions: [
          IconButton(
            icon: const Icon(Icons.history, color: AppColors.textPrimary),
            onPressed: () => context.go('/buy/history'),
            tooltip: 'Purchase history',
          ),
        ],
      ),
      body: WaveBackground(
        child: BlocBuilder<BuyTabBloc, BuyTabState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<BuyTabBloc>()
                    .add(const BuyTabEvent.refreshBuyTab());
                await context.read<BuyTabBloc>().stream.firstWhere(
                      (s) => !s.isLoading,
                    );
              },
              color: AppColors.primary,
              child: CustomScrollView(
                slivers: [
                  // Offline banner
                  if (state.isOffline)
                    SliverToBoxAdapter(
                      child:
                          BuyOfflineBanner(lastSyncedAt: state.lastSyncedAt),
                    ),

                  // ── Layer 1: Featured ──
                  _buildLayer1(state),

                  const SliverToBoxAdapter(child: BuyLayerDivider()),

                  // ── Layer 2: Utilities Hub ──
                  _buildMyRegulars(state),

                  const SliverToBoxAdapter(
                    child: BuySectionHeader(title: 'Utilities'),
                  ),

                  SliverToBoxAdapter(
                    child: _buildCategorySection(state),
                  ),

                  const SliverToBoxAdapter(child: BuyLayerDivider()),

                  // ── Layer 3: Intengiso Marketplace ──
                  SliverToBoxAdapter(
                    child: _buildMarketplaceEntry(),
                  ),

                  const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ─── Layer 1: Featured Carousel + Brand Partners ─────────

  Widget _buildLayer1(BuyTabState state) {
    final hasFeatured = state.featuredItems.isNotEmpty;
    final hasBrands = state.brandPartners.isNotEmpty;

    // If nothing in Layer 1, hide it entirely (no empty carousel)
    if (!hasFeatured && !hasBrands && !state.isLoading) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        // Loading shimmer for Layer 1
        if (state.isLoading && !hasFeatured && !hasBrands)
          _buildFeaturedShimmer(),

        // Featured carousel
        if (hasFeatured)
          FeaturedCarousel(
            items: state.featuredItems,
            onItemTap: _onFeaturedItemTap,
          ),

        // Brand partners strip
        if (hasBrands)
          BrandPartnersStrip(
            brands: state.brandPartners,
            onBrandTap: (brand) => context.go('/buy/brand/${brand.id}'),
          ),
      ]),
    );
  }

  void _onFeaturedItemTap(FeaturedItem item) {
    if (item.deepLinkRoute != null && item.deepLinkRoute!.isNotEmpty) {
      context.go(item.deepLinkRoute!);
    }
  }

  Widget _buildFeaturedShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ─── Layer 2: My Regulars ────────────────────────────────

  Widget _buildMyRegulars(BuyTabState state) {
    if (state.regulars.isEmpty) {
      return const SliverToBoxAdapter(child: MyRegularsEmptyDock());
    }

    return SliverToBoxAdapter(
      child: MyRegularsDock(
        regulars: state.regulars,
        onRegularTap: (regular) {
          // Quick-buy: navigate to category with pre-filled data
          final routeId =
              regular.purchaseCategoryMapping ?? regular.providerId;
          context.go(
            '/buy/category/$routeId',
            extra: {
              'name': regular.providerName,
              'emoji': regular.categoryEmoji ?? '📦',
              'quickBuyRegularId': regular.id,
            },
          );
        },
        onRegularLongPress: (_) {
          // Pin/unpin regulars — future enhancement
        },
        onAddTap: () {
          // Scroll focus to utilities grid
        },
      ),
    );
  }

  // ─── Category Section ────────────────────────────────────

  Widget _buildCategorySection(BuyTabState state) {
    if (state.isLoading && state.categories.isEmpty) {
      return _buildCategoryShimmer();
    }

    if (state.errorMessage != null && state.categories.isEmpty) {
      return _buildErrorState(state.errorMessage!);
    }

    if (state.categories.isEmpty) {
      return _buildEmptyState();
    }

    return BuyCategoryGrid(
      categories: state.categories,
      onCategoryTap: _onCategoryTap,
    );
  }

  void _onCategoryTap(BuyCategory category) {
    if (category.isComingSoon) return;
    final routeId = category.purchaseCategoryMapping ?? category.id;
    context.go(
      '/buy/category/$routeId',
      extra: {'name': category.name, 'emoji': category.iconEmoji},
    );
  }

  Widget _buildCategoryShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Wrap(
          spacing: 12,
          runSpacing: 16,
          children: List.generate(8, (_) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 24 - 36) / 4,
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 56,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BrandCard(
        gradient: BrandGradient.none,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 40),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Retry',
                onPressed: () => context
                    .read<BuyTabBloc>()
                    .add(const BuyTabEvent.refreshBuyTab()),
                variant: AppButtonVariant.outline,
                size: AppButtonSize.small,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Layer 3: Marketplace Entry ─────────────────────────

  Widget _buildMarketplaceEntry() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: () => context.go('/buy/marketplace'),
        child: BrandCard(
          gradient: BrandGradient.cyanBlue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intengiso Marketplace',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Buy & sell in your community \u2014 with trust',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white70,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 48,
            color: AppColors.textTertiary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'No categories available',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            text: 'Retry',
            onPressed: () => context
                .read<BuyTabBloc>()
                .add(const BuyTabEvent.refreshBuyTab()),
            variant: AppButtonVariant.outline,
            size: AppButtonSize.small,
          ),
        ],
      ),
    );
  }
}
