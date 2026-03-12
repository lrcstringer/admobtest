import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/marketplace_listing.dart';
import '../../../domain/enums/listing_status.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// My Listings screen — seller's listing management (Spec §8.2).
///
/// Filter chips: All / Active / Paused / Expired / Sold with counts.
/// Listing management cards with context-aware action buttons.
/// Stale listing nudge after 3+ renewals with <10 views.
class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  ListingStatus? _activeFilter;

  @override
  void initState() {
    super.initState();
    context.read<MarketplaceBloc>().add(const MarketplaceEvent.loadMyListings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Listings',
          style: TextStyle(
            color: AppColors.buyTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.buyTextPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/buy/marketplace/create-listing'),
        backgroundColor: AppColors.buyMarketplaceAccent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'New Listing',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        buildWhen: (prev, curr) =>
            prev.isLoadingMyListings != curr.isLoadingMyListings ||
            prev.myListings != curr.myListings,
        builder: (context, state) {
          if (state.isLoadingMyListings) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buyMarketplaceAccent,
              ),
            );
          }

          final allListings = state.myListings;
          if (allListings.isEmpty) {
            return _EmptyState();
          }

          final filtered = _activeFilter == null
              ? allListings
              : allListings
                  .where((l) => l.status == _activeFilter)
                  .toList();

          return Column(
            children: [
              // Filter chips
              _FilterChips(
                allListings: allListings,
                activeFilter: _activeFilter,
                onFilterChanged: (filter) =>
                    setState(() => _activeFilter = filter),
              ),

              // Listing cards
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          'No ${_activeFilter?.displayName.toLowerCase() ?? ''} listings',
                          style: const TextStyle(
                            color: AppColors.buyTextTertiary,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          return _ListingManagementCard(
                            listing: filtered[index],
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
}

// ─── Filter Chips ──────────────────────────────────────────────────────

class _FilterChips extends StatelessWidget {
  final List<MarketplaceListing> allListings;
  final ListingStatus? activeFilter;
  final ValueChanged<ListingStatus?> onFilterChanged;

  const _FilterChips({
    required this.allListings,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final counts = <ListingStatus?, int>{null: allListings.length};
    for (final status in ListingStatus.values) {
      final count = allListings.where((l) => l.status == status).length;
      if (count > 0) counts[status] = count;
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Row(
          children: [
            _FilterChip(
              label: 'All',
              count: counts[null] ?? 0,
              isActive: activeFilter == null,
              onTap: () => onFilterChanged(null),
            ),
            ...ListingStatus.values
                .where((s) => counts.containsKey(s))
                .map((status) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: _FilterChip(
                        label: status.displayName,
                        count: counts[status]!,
                        isActive: activeFilter == status,
                        onTap: () => onFilterChanged(status),
                        color: _statusColor(status),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Color _statusColor(ListingStatus status) {
    switch (status) {
      case ListingStatus.active:
        return AppColors.buySuccess;
      case ListingStatus.paused:
        return AppColors.buyWarning;
      case ListingStatus.expired:
        return AppColors.buyTextTertiary;
      case ListingStatus.flagged:
        return AppColors.buyError;
      case ListingStatus.removed:
        return AppColors.buyError;
      case ListingStatus.sold:
        return AppColors.buyMarketplaceAccent;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? AppColors.buyMarketplaceAccent;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.1)
              : AppColors.buyChipBg,
          borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
          border: Border.all(
            color: isActive ? activeColor : AppColors.buyChipBorder,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : AppColors.buyTextSecondary,
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: isActive
                    ? activeColor.withValues(alpha: 0.2)
                    : AppColors.buyDivider,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: isActive ? activeColor : AppColors.buyTextTertiary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Listing Management Card ───────────────────────────────────────────

class _ListingManagementCard extends StatelessWidget {
  final MarketplaceListing listing;

  const _ListingManagementCard({required this.listing});

  @override
  Widget build(BuildContext context) {
    final isStale =
        listing.renewalCount >= 3 && listing.viewCount < 10;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          // Main card content
          InkWell(
            onTap: () => context.push('/buy/marketplace/listing/${listing.id}'),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: _buildThumbnail(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + status pill
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                listing.title,
                                style: const TextStyle(
                                  color: AppColors.buyTextPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _StatusPill(status: listing.status),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Price
                        Text(
                          listing.formattedZarPrice,
                          style: const TextStyle(
                            color: AppColors.buyTextPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Stats row
                        Row(
                          children: [
                            _StatChip(
                              icon: Icons.visibility_outlined,
                              value: '${listing.viewCount}',
                            ),
                            const SizedBox(width: 12),
                            _StatChip(
                              icon: Icons.favorite_border,
                              value: '${listing.favouriteCount}',
                            ),
                            if (listing.expiresAt != null) ...[
                              const SizedBox(width: 12),
                              _StatChip(
                                icon: Icons.access_time_rounded,
                                value: _daysRemaining(listing.expiresAt!),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stale listing nudge
          if (isStale && listing.status == ListingStatus.active)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: 8),
              color: AppColors.buyWarning.withValues(alpha: 0.08),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline_rounded,
                      size: 16, color: AppColors.buyWarning),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'This listing isn\'t getting much attention. '
                      'Try updating your photos or lowering the price.',
                      style: TextStyle(
                        color: AppColors.buyWarning,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Context-aware action buttons
          _ActionButtons(listing: listing),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    final url = listing.thumbnailUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, _) =>
            Container(color: AppColors.buyShimmerBase),
        errorWidget: (_, _, _) => Container(
          color: AppColors.buyShimmerBase,
          child: const Icon(Icons.image_not_supported_outlined,
              size: 20, color: AppColors.buyTextTertiary),
        ),
      );
    }
    return Container(
      color: AppColors.buyShimmerBase,
      child: const Icon(Icons.storefront_outlined,
          size: 24, color: AppColors.buyTextTertiary),
    );
  }

  String _daysRemaining(DateTime expiresAt) {
    final days = expiresAt.difference(DateTime.now()).inDays;
    if (days <= 0) return 'Expired';
    if (days == 1) return '1 day';
    return '$days days';
  }
}

class _StatusPill extends StatelessWidget {
  final ListingStatus status;

  const _StatusPill({required this.status});

  Color get _color {
    switch (status) {
      case ListingStatus.active:
        return AppColors.buySuccess;
      case ListingStatus.paused:
        return AppColors.buyWarning;
      case ListingStatus.expired:
        return AppColors.buyTextTertiary;
      case ListingStatus.flagged:
        return AppColors.buyError;
      case ListingStatus.removed:
        return AppColors.buyError;
      case ListingStatus.sold:
        return AppColors.buyMarketplaceAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: _color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatChip({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.buyTextTertiary),
        const SizedBox(width: 3),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.buyTextTertiary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─── Context-aware Action Buttons ──────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final MarketplaceListing listing;

  const _ActionButtons({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: 6),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.buyDivider, width: 0.5),
        ),
      ),
      child: Row(
        children: _buildActions(context),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    switch (listing.status) {
      case ListingStatus.active:
        return [
          _SmallActionButton(
            label: 'Edit',
            icon: Icons.edit_outlined,
            onTap: () =>
                context.push('/buy/edit-listing/${listing.id}'),
          ),
          const SizedBox(width: 8),
          _SmallActionButton(
            label: 'Pause',
            icon: Icons.pause_circle_outline_rounded,
            onTap: () {
              // TODO(Phase 3.27): Wire pause listing CF
            },
          ),
          const Spacer(),
          _SmallActionButton(
            label: 'Share',
            icon: Icons.share_outlined,
            onTap: () {
              // TODO(Phase 3.27): Wire share listing
            },
          ),
        ];

      case ListingStatus.paused:
        return [
          _SmallActionButton(
            label: 'Resume',
            icon: Icons.play_circle_outline_rounded,
            color: AppColors.buySuccess,
            onTap: () {
              // TODO(Phase 3.27): Wire resume listing CF
            },
          ),
          const SizedBox(width: 8),
          _SmallActionButton(
            label: 'Edit',
            icon: Icons.edit_outlined,
            onTap: () =>
                context.push('/buy/edit-listing/${listing.id}'),
          ),
        ];

      case ListingStatus.expired:
        return [
          _SmallActionButton(
            label: 'Renew',
            icon: Icons.refresh_rounded,
            color: AppColors.buySuccess,
            onTap: () {
              // TODO(Phase 3.19): Wire renew listing CF
            },
          ),
          const SizedBox(width: 8),
          _SmallActionButton(
            label: 'Edit',
            icon: Icons.edit_outlined,
            onTap: () =>
                context.push('/buy/edit-listing/${listing.id}'),
          ),
        ];

      case ListingStatus.sold:
        return [
          _SmallActionButton(
            label: 'Relist',
            icon: Icons.replay_rounded,
            color: AppColors.buyMarketplaceAccent,
            onTap: () {
              // TODO(Phase 3.27): Wire relist as new listing
            },
          ),
        ];

      case ListingStatus.flagged:
        return [
          const Icon(Icons.warning_amber_rounded,
              size: 16, color: AppColors.buyWarning),
          const SizedBox(width: 4),
          const Expanded(
            child: Text(
              'This listing was flagged for review',
              style: TextStyle(
                color: AppColors.buyWarning,
                fontSize: 11,
              ),
            ),
          ),
        ];

      case ListingStatus.removed:
        return [
          const Icon(Icons.block_rounded,
              size: 16, color: AppColors.buyError),
          const SizedBox(width: 4),
          const Expanded(
            child: Text(
              'This listing has been removed',
              style: TextStyle(
                color: AppColors.buyError,
                fontSize: 11,
              ),
            ),
          ),
        ];
    }
  }
}

class _SmallActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _SmallActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.buyTextSecondary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: c),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Empty State ───────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 36,
                color: AppColors.buyMarketplaceAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'No listings yet',
              style: TextStyle(
                color: AppColors.buyTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Create your first listing to start selling.\nSnap a photo and set a price — it\'s that easy.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.buyTextSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: () => context.push('/buy/marketplace/create-listing'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create Listing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buyMarketplaceAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMd),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
