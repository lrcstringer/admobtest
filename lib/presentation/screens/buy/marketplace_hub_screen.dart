import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/enums/marketplace_category.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/buy/marketplace_listing_card.dart';
import '../../widgets/buy/marketplace_search_bar.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

/// Main marketplace browsing screen with 5 sub-market tabs,
/// search bar, listing grid, and FAB for sellers.
class MarketplaceHubScreen extends StatefulWidget {
  const MarketplaceHubScreen({super.key});

  @override
  State<MarketplaceHubScreen> createState() => _MarketplaceHubScreenState();
}

class _MarketplaceHubScreenState extends State<MarketplaceHubScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _categories = MarketplaceCategory.values;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadCategory(_categories.first);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      _loadCategory(_categories[_tabController.index]);
    }
  }

  void _loadCategory(MarketplaceCategory category) {
    context.read<MarketplaceBloc>().add(
          MarketplaceEvent.loadListings(category: category.name),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(title: 'Intengiso'),
      body: Column(
        children: [
          // Category tabs
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: _categories
                  .map((c) => Tab(text: '${c.emoji} ${c.displayName}'))
                  .toList(),
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: MarketplaceSearchBar(
              onSearch: (query) {
                context
                    .read<MarketplaceBloc>()
                    .add(MarketplaceEvent.searchListings(query));
              },
              onClear: () {
                context
                    .read<MarketplaceBloc>()
                    .add(const MarketplaceEvent.clearSearch());
              },
            ),
          ),

          // Listing grid
          Expanded(
            child: BlocBuilder<MarketplaceBloc, MarketplaceState>(
              builder: (context, state) {
                if (state.isLoading && state.filteredListings.isEmpty) {
                  return _buildShimmerGrid();
                }

                if (state.errorMessage != null &&
                    state.filteredListings.isEmpty) {
                  return _buildError(state.errorMessage!);
                }

                if (state.filteredListings.isEmpty) {
                  return _buildEmpty(state.isSearching);
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.extentAfter < 200) {
                      context
                          .read<MarketplaceBloc>()
                          .add(const MarketplaceEvent.loadMore());
                    }
                    return false;
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: AppSpacing.sm,
                      mainAxisSpacing: AppSpacing.sm,
                    ),
                    itemCount: state.filteredListings.length +
                        (state.isLoadingMore ? 2 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.filteredListings.length) {
                        return _buildShimmerCard();
                      }

                      final listing = state.filteredListings[index];
                      return MarketplaceListingCard(
                        listing: listing,
                        onTap: () => context.push(
                          '/buy/marketplace/listing/${listing.id}',
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/buy/marketplace/create-listing'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.textOnPrimary),
        label: const Text(
          'Sell',
          style: TextStyle(color: AppColors.textOnPrimary),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.sm),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: 6,
      itemBuilder: (_, _) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: AppColors.surface,
      highlightColor: AppColors.surfaceElevated,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              text: 'Retry',
              variant: AppButtonVariant.outline,
              onPressed: () =>
                  _loadCategory(_categories[_tabController.index]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(bool isSearching) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSearching ? Icons.search_off : Icons.storefront_outlined,
              color: AppColors.textSecondary,
              size: 48,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              isSearching
                  ? 'No listings match your search'
                  : 'No listings yet in this category',
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
