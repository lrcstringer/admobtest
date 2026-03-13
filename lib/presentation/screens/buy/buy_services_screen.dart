import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/buy_category.dart';
import '../../../domain/entities/featured_item.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/buy_tab/buy_tab_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/buy/cluster_picker_sheet.dart';
import '../../widgets/buy/brand_partners_strip.dart';
import '../../widgets/buy/buy_category_grid.dart';
import '../../widgets/buy/buy_offline_banner.dart';
import '../../widgets/buy/buy_section_header.dart';
import '../../widgets/buy/featured_carousel.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

class BuyServicesScreen extends StatefulWidget {
  const BuyServicesScreen({super.key});

  @override
  State<BuyServicesScreen> createState() => _BuyServicesScreenState();
}

class _BuyServicesScreenState extends State<BuyServicesScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BuyTabBloc>().add(const BuyTabEvent.loadBuyTab());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
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
      body: BlocConsumer<BuyTabBloc, BuyTabState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.buyError,
              ),
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              final bloc = context.read<BuyTabBloc>();
              bloc.add(const BuyTabEvent.refreshBuyTab());
              await bloc.stream
                  .firstWhere((s) => !s.isRefreshing)
                  .timeout(
                    const Duration(seconds: 10),
                    onTimeout: () => bloc.state,
                  );
            },
            color: AppColors.primary,
            backgroundColor: AppColors.buyCard,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Offline banner
                if (state.isOffline)
                  SliverToBoxAdapter(
                    child:
                        BuyOfflineBanner(lastSyncedAt: state.lastSyncedAt),
                  ),

                // ── Layer 1: Featured + Brand Partners ──
                _buildLayer1(state),

                // Layer divider: 1px line + 16px padding
                const SliverToBoxAdapter(child: _BuyLayerDivider()),

                // ── Layer 2: Utilities ──
                SliverToBoxAdapter(
                  child: BuySectionHeader(title: 'Utilities'),
                ),

                SliverToBoxAdapter(
                  child: _buildCategorySection(state),
                ),

                const SliverToBoxAdapter(child: _BuyLayerDivider()),

                // ── Layer 3: Marketplace + Group Buys ──
                SliverToBoxAdapter(
                  child: _buildMarketplaceEntry(),
                ),

                const SliverToBoxAdapter(child: _BuyLayerDivider()),

                // ── Layer 4: Hlangana Group Buys ──
                SliverToBoxAdapter(
                  child: _buildGroupBuysHub(),
                ),

                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          );
        },
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

        // Featured carousel (only currently active items, filtered by community)
        if (hasFeatured)
          Builder(builder: (context) {
            final now = DateTime.now();
            final communityFiltered = _filterFeaturedByCommunity(
              state.featuredItems
                  .where((i) => i.isCurrentlyActiveAt(now))
                  .toList(),
            );
            if (communityFiltered.isEmpty) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.buyCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.buyCardBorder.withValues(alpha: 0.3)),
                  ),
                  child: const Center(
                    child: Text(
                      'No featured items for your community',
                      style: TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            }
            return FeaturedCarousel(
              items: communityFiltered,
              onItemTap: _onFeaturedItemTap,
            );
          }),

        // Brand partners strip
        if (hasBrands)
          BrandPartnersStrip(
            brands: state.brandPartners,
            onBrandTap: (brand) => context.go('/buy/brand/${brand.id}'),
          ),
      ]),
    );
  }

  /// Filter featured items by user's community clusters.
  /// Items with empty communityIds are global and always shown.
  List<FeaturedItem> _filterFeaturedByCommunity(List<FeaturedItem> items) {
    final userClusters =
        context.read<AuthBloc>().state.user?.profile?.selectedClusters ?? [];
    if (userClusters.isEmpty) {
      // No clusters selected → show global items (empty communityIds)
      // plus all community-targeted items (user hasn't opted into filtering)
      return items;
    }
    return items.where((i) {
      if (i.communityIds.isEmpty) return true;
      return i.communityIds.any((c) => userClusters.contains(c));
    }).toList();
  }

  Future<void> _onFeaturedItemTap(FeaturedItem item) async {
    final route = item.deepLinkRoute;
    if (route == null || route.isEmpty) return;

    if (route.startsWith('http://') || route.startsWith('https://')) {
      final uri = Uri.tryParse(route);
      if (uri != null) {
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } on Exception {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not open link'),
                backgroundColor: AppColors.buyError,
              ),
            );
          }
        }
      }
    } else {
      context.push(route);
    }
  }

  Widget _buildFeaturedShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: AppColors.buyShimmerBase,
        highlightColor: AppColors.buyShimmerHigh,
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.buyCard,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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

    // All categories go to BuyCategoryScreen via purchaseCategoryMapping
    if (category.purchaseCategoryMapping != null &&
        category.purchaseCategoryMapping!.isNotEmpty) {
      context.go(
        '/buy/category/${category.purchaseCategoryMapping}',
        extra: {'name': category.name, 'emoji': category.iconEmoji},
      );
      return;
    }

    // Fallback for categories without mapping
    context.go(
      '/buy/category/${category.id}',
      extra: {'name': category.name, 'emoji': category.iconEmoji},
    );
  }

  Widget _buildCategoryShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: AppColors.buyShimmerBase,
        highlightColor: AppColors.buyShimmerHigh,
        child: Wrap(
          spacing: 6,
          runSpacing: 6,
          children: List.generate(10, (i) {
            final widths = [72.0, 64.0, 58.0, 78.0, 66.0, 82.0, 70.0, 60.0, 74.0, 68.0];
            return Container(
              width: widths[i],
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.buyCard,
                borderRadius: BorderRadius.circular(8),
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
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.buyCardBorder),
          boxShadow: const [
            BoxShadow(
              color: AppColors.buyShadow,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(Icons.error_outline,
                color: AppColors.buyError, size: 40),
            const SizedBox(height: 12),
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
    );
  }

  // ─── Layer 3: Marketplace Entry (Option B — Elevated Hero) ───

  Widget _buildMarketplaceEntry() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: () => context.go('/buy/marketplace'),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.buyMarketplaceAccent.withValues(alpha: 0.06),
                AppColors.buyCard,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.buyCardBorder),
            boxShadow: [
              BoxShadow(
                color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
              const BoxShadow(
                color: AppColors.buyShadow,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Left accent bar (gold → amber gradient)
                Container(
                  width: 4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.buyMarketplaceAccent,
                        AppColors.buyMarketplaceAccentDark,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Marketplace logo
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                'assets/images/intengisomarketplace.png',
                                width: 112,
                                height: 112,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Intengiso',
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                      fontFeatures: const [
                                        FontFeature.enable('smcp'),
                                      ],
                                      letterSpacing: 0.5,
                                      color: AppColors.buyTextPrimary,
                                    ),
                                  ),
                                  const Text(
                                    'Marketplace',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.buyTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'Buy & sell in your community \u2014 with trust',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.buyTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // Full-width CTA button (gold → amber gradient)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.buyMarketplaceAccent,
                                AppColors.buyMarketplaceAccentDark,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Explore Marketplace \u2192',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Layer 4: Hlangana Group Buys Hub ─────────────────

  Widget _buildGroupBuysHub() {
    final user = context.read<AuthBloc>().state.user;
    final hasClusters = (user?.profile?.selectedClusters ?? []).isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Show opt-in prompt if no clusters selected
          if (!hasClusters) _buildClusterOptIn(),

          // Group buys card — white with green accent
          GestureDetector(
            onTap: () => context.go('/buy/group-buys'),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.buyGroupBuyAccent.withValues(alpha: 0.02),
                    AppColors.buyCard,
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.buyCardBorder),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.buyShadow,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    // Left accent bar (green)
                    Container(
                      width: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.buyGroupBuyAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                        ),
                      ),
                    ),
                    // Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Group Buys logo
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    'assets/images/hlanganibuyergroup.png',
                                    width: 112,
                                    height: 112,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hlangana',
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w800,
                                          fontFeatures: const [
                                            FontFeature.enable('smcp'),
                                          ],
                                          letterSpacing: 0.5,
                                          color: AppColors.buyTextPrimary,
                                        ),
                                      ),
                                      const Text(
                                        'Group Buys',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.buyTextPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Pool tokens together for bigger discounts',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.buyTextSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            // CTA button (green)
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.buyGroupBuyAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Browse Deals',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClusterOptIn() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.buyCardBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.buyShadow,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Green accent bar — ties to Hlangana card below
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: AppColors.buyGroupBuyAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: AppColors.buyGroupBuyAccent, size: 28),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select your area',
                            style: TextStyle(
                              color: AppColors.buyTextPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'See group buy deals near you',
                            style: TextStyle(
                              color: AppColors.buyTextSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final result = await ClusterPickerSheet.show(context);
                        if (result != null && result.isNotEmpty && mounted) {
                          context.read<ProfileBloc>().add(
                                ProfileEvent.updateProfile(
                                  selectedClusters: result,
                                ),
                              );
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.buyGroupBuyAccent,
                      ),
                      child: const Text('Set up'),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            color: AppColors.buyTextTertiary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'No categories available',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.buyTextSecondary,
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

/// Layer divider: 1px line with 16px padding above and below.
class _BuyLayerDivider extends StatelessWidget {
  const _BuyLayerDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        width: double.infinity,
        color: AppColors.buyDivider,
      ),
    );
  }
}
