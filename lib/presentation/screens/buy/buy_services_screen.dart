import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entities/buy_category.dart';
import '../../../domain/entities/buy_regular.dart';
import '../../../domain/entities/featured_item.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/buy_tab/buy_tab_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/buy/cluster_picker_sheet.dart';
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

class BuyServicesScreen extends StatefulWidget {
  const BuyServicesScreen({super.key});

  @override
  State<BuyServicesScreen> createState() => _BuyServicesScreenState();
}

class _BuyServicesScreenState extends State<BuyServicesScreen> {
  final _scrollController = ScrollController();
  final _utilitiesGridKey = GlobalKey();

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.35, 1.0],
            colors: [
              AppColors.goldGradient[0].withValues(alpha: 0.25),
              AppColors.background,
              AppColors.background,
            ],
          ),
        ),
        child: BlocConsumer<BuyTabBloc, BuyTabState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.error,
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
              child: CustomScrollView(
                controller: _scrollController,
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

                  SliverToBoxAdapter(
                    child: BuySectionHeader(
                      key: _utilitiesGridKey,
                      title: 'Utilities',
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: _buildCategorySection(state),
                  ),

                  const SliverToBoxAdapter(child: BuyLayerDivider()),

                  // ── Layer 3: Intengiso Marketplace ──
                  SliverToBoxAdapter(
                    child: _buildMarketplaceEntry(state),
                  ),

                  const SliverToBoxAdapter(child: BuyLayerDivider()),

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
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.3)),
                  ),
                  child: const Center(
                    child: Text(
                      'No featured items for your community',
                      style: TextStyle(
                        color: AppColors.textTertiary,
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
      // No clusters selected — show only global items
      return items.where((i) => i.communityIds.isEmpty).toList();
    }
    return items.where((i) {
      if (i.communityIds.isEmpty) return true; // global
      return i.communityIds.any((c) => userClusters.contains(c));
    }).toList();
  }

  void _onFeaturedItemTap(FeaturedItem item) {
    final route = item.deepLinkRoute;
    if (route == null || route.isEmpty) return;

    if (route.startsWith('http://') || route.startsWith('https://')) {
      launchUrl(Uri.parse(route), mode: LaunchMode.externalApplication);
    } else {
      context.push(route);
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
              'quickBuyProviderId': regular.providerId,
              'quickBuyProductId': regular.productId,
              'quickBuyRecipient': regular.recipientNumber,
            },
          );
        },
        onRegularLongPress: (regular) => _showRegularOptionsSheet(regular),
        onAddTap: _scrollToUtilitiesGrid,
      ),
    );
  }

  void _scrollToUtilitiesGrid() {
    final keyContext = _utilitiesGridKey.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showRegularOptionsSheet(BuyRegular regular) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surfaceElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  regular.providerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  regular.isPinned
                      ? Icons.push_pin_outlined
                      : Icons.push_pin,
                  color: AppColors.primary,
                ),
                title: Text(
                  regular.isPinned ? 'Unpin from top' : 'Pin to top',
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<BuyTabBloc>().add(
                        BuyTabEvent.toggleRegularPin(
                          regularId: regular.id,
                          isPinned: !regular.isPinned,
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        regular.isPinned
                            ? '${regular.providerName} unpinned'
                            : '${regular.providerName} pinned to top',
                      ),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.delete_outline, color: AppColors.error),
                title: const Text(
                  'Remove from regulars',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<BuyTabBloc>().add(
                        BuyTabEvent.deleteRegular(
                          regularId: regular.id,
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('${regular.providerName} removed from regulars'),
                      backgroundColor: AppColors.textSecondary,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
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

    // VAS categories → existing provider flow
    if (category.purchaseCategoryMapping != null &&
        category.purchaseCategoryMapping!.isNotEmpty) {
      context.go(
        '/buy/category/${category.purchaseCategoryMapping}',
        extra: {'name': category.name, 'emoji': category.iconEmoji},
      );
      return;
    }

    // Marketplace categories → subcategory list
    context.go(
      '/buy/subcategories/${category.id}',
      extra: {
        'name': category.name,
        'emoji': category.iconEmoji,
        'subcategories': category.subcategories,
      },
    );
  }

  Widget _buildCategoryShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(8, (i) {
            // Vary widths to look natural
            final widths = [80.0, 100.0, 90.0, 110.0, 85.0, 95.0, 105.0, 75.0];
            return Container(
              width: widths[i],
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
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

  Widget _buildMarketplaceEntry(BuyTabState state) {
    final hasThumbnails = state.trendingThumbnails.isNotEmpty;
    final hasStats =
        state.marketplaceListingCount > 0 || state.marketplaceSellerCount > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: () => context.go('/buy/marketplace'),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.secondaryGradient,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnails row
                if (hasThumbnails)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: SizedBox(
                      height: 56,
                      child: Row(
                        children: state.trendingThumbnails
                            .take(3)
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                          return Transform.translate(
                            offset: Offset(-8.0 * entry.key, 0),
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  entry.value,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    color:
                                        Colors.white.withValues(alpha: 0.15),
                                    child: const Icon(Icons.image,
                                        color: Colors.white54, size: 20),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                // Title + subtitle
                const Text(
                  'Intengiso Marketplace',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Buy & sell in your community \u2014 with trust',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                // Stats pills
                if (hasStats)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        if (state.marketplaceListingCount > 0)
                          _buildStatPill(
                            '${state.marketplaceListingCount} listings',
                            Icons.storefront_rounded,
                          ),
                        if (state.marketplaceListingCount > 0 &&
                            state.marketplaceSellerCount > 0)
                          const SizedBox(width: 8),
                        if (state.marketplaceSellerCount > 0)
                          _buildStatPill(
                            '${state.marketplaceSellerCount} sellers',
                            Icons.people_rounded,
                          ),
                      ],
                    ),
                  ),
                // CTA button
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Explore Marketplace',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0974FF),
                      ),
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

  Widget _buildStatPill(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
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

          // Always show the group buys card
          GestureDetector(
            onTap: () => context.go('/buy/group-buys'),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6C3FC5), Color(0xFF9B59B6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child:
                                Text('\u{1F91D}', style: TextStyle(fontSize: 22)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hlangana Group Buys',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Pool tokens together for bigger discounts',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Browse Deals',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6C3FC5),
                          ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.primary, size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select your area',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'See group buy deals near you',
                  style: TextStyle(
                    color: AppColors.textSecondary,
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
            child: const Text('Set up'),
          ),
        ],
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
