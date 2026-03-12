import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/saved_listing.dart';
import '../../../domain/enums/listing_status.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Saved / favourited items screen (Spec §8.18).
///
/// Shows a grid of favourited listings with sort options,
/// stale item handling (greyed out overlay), and empty state.
class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

enum _SavedSort { newest, oldest, priceLow, priceHigh }

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  _SavedSort _sort = _SavedSort.newest;

  @override
  void initState() {
    super.initState();
    context.read<MarketplaceBloc>().add(
          const MarketplaceEvent.loadSavedItems(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        backgroundColor: AppColors.buyCard,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.buyTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Saved Items',
          style: TextStyle(
            color: AppColors.buyTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.buyDivider,
          ),
        ),
      ),
      body: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        builder: (context, state) {
          if (state.isLoadingSaved) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buyMarketplaceAccent,
              ),
            );
          }

          final items = _sorted(state.savedItems);

          if (items.isEmpty) return _buildEmptyState();

          return Column(
            children: [
              // Sort bar
              _SortBar(
                active: _sort,
                count: items.length,
                onChanged: (s) => setState(() => _sort = s),
              ),

              // Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return _SavedItemCard(
                      item: item,
                      onTap: () => context.push('/buy/marketplace/listing/${item.listingId}'),
                      onRemove: () {
                        context.read<MarketplaceBloc>().add(
                              MarketplaceEvent.toggleFavourite(item.listingId),
                            );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<SavedListing> _sorted(List<SavedListing> items) {
    final sorted = [...items];
    switch (_sort) {
      case _SavedSort.newest:
        sorted.sort((a, b) => b.savedAt.compareTo(a.savedAt));
      case _SavedSort.oldest:
        sorted.sort((a, b) => a.savedAt.compareTo(b.savedAt));
      case _SavedSort.priceLow:
        sorted.sort((a, b) =>
            (a.listingPrice ?? 0).compareTo(b.listingPrice ?? 0));
      case _SavedSort.priceHigh:
        sorted.sort((a, b) =>
            (b.listingPrice ?? 0).compareTo(a.listingPrice ?? 0));
    }
    return sorted;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 64,
            color: AppColors.buyTextTertiary.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          const Text(
            'No saved items yet',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the heart on listings you like\nto save them here',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.buyTextTertiary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.buyMarketplaceAccent,
            ),
            child: const Text('Browse Marketplace'),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────
// Sort Bar
// ────────────────────────────────────────────

class _SortBar extends StatelessWidget {
  final _SavedSort active;
  final int count;
  final ValueChanged<_SavedSort> onChanged;

  const _SortBar({
    required this.active,
    required this.count,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.buyCard,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(
            '$count saved',
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          ...(_SavedSort.values.map((s) => Padding(
                padding: const EdgeInsets.only(left: 4),
                child: _SortChip(
                  label: _labelFor(s),
                  isActive: active == s,
                  onTap: () => onChanged(s),
                ),
              ))),
        ],
      ),
    );
  }

  String _labelFor(_SavedSort s) {
    switch (s) {
      case _SavedSort.newest:
        return 'Newest';
      case _SavedSort.oldest:
        return 'Oldest';
      case _SavedSort.priceLow:
        return 'Price ↑';
      case _SavedSort.priceHigh:
        return 'Price ↓';
    }
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.buyMarketplaceAccent.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? AppColors.buyMarketplaceAccent
                : AppColors.buyCardBorder,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive
                ? AppColors.buyMarketplaceAccent
                : AppColors.buyTextTertiary,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────
// Saved Item Card
// ────────────────────────────────────────────

class _SavedItemCard extends StatelessWidget {
  final SavedListing item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _SavedItemCard({
    required this.item,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isStale = item.isStale;

    return GestureDetector(
      onTap: isStale ? () => _showStaleSheet(context) : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.buyCard,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.buyShadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + stale overlay + heart
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Thumbnail
                  item.listingThumbnailUrl != null
                      ? CachedNetworkImage(
                          imageUrl: item.listingThumbnailUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, _) =>
                              Container(color: AppColors.buyShimmerBase),
                          errorWidget: (_, _, _) => Container(
                            color: AppColors.buyShimmerBase,
                            child: const Icon(Icons.image_not_supported_outlined,
                                color: AppColors.buyTextTertiary, size: 32),
                          ),
                        )
                      : Container(
                          color: AppColors.buyShimmerBase,
                          child: const Icon(Icons.storefront_outlined,
                              color: AppColors.buyTextTertiary, size: 32),
                        ),

                  // Stale overlay
                  if (isStale)
                    Container(
                      color: Colors.black.withValues(alpha: 0.5),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _staleLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Heart (remove) button
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.buyShadow,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          size: 16,
                          color: AppColors.buyError,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.listingPrice != null)
                    Text(
                      'R${(item.listingPrice! / 100).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isStale
                            ? AppColors.buyTextTertiary
                            : AppColors.buyTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    item.listingTitle ?? 'Untitled',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isStale
                          ? AppColors.buyTextTertiary
                          : AppColors.buyTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                  if (item.sellerName != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.sellerName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.buyTextTertiary,
                        fontSize: 10,
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

  String get _staleLabel {
    switch (item.listingStatus) {
      case ListingStatus.sold:
        return 'Sold';
      case ListingStatus.paused:
        return 'Paused';
      case ListingStatus.expired:
        return 'Expired';
      default:
        return 'Unavailable';
    }
  }

  void _showStaleSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.buyCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.buyDivider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.info_outline_rounded,
              size: 40,
              color: AppColors.buyWarning,
            ),
            const SizedBox(height: 12),
            Text(
              'This item is ${_staleLabel.toLowerCase()}',
              style: const TextStyle(
                color: AppColors.buyTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'It\'s no longer available for purchase.',
              style: TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onRemove();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.buyTextSecondary,
                      side: const BorderSide(color: AppColors.buyCardBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                    ),
                    child: const Text('Remove'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.push('/buy');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buyMarketplaceAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                    ),
                    child: const Text('See Similar'),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }
}
