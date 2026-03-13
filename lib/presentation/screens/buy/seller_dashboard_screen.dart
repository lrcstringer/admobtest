import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/listing_status.dart';
import '../../../domain/enums/seller_level.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/buy/seller_level_badge.dart';

/// Seller dashboard screen with earnings, stats, and level progress (Spec §8.8).
class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // loadMyListings is auto-triggered after loadSellerPortal succeeds
    context.read<MarketplaceBloc>()
      .add(const MarketplaceEvent.loadSellerPortal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Seller Dashboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.buyDivider),
        ),
      ),
      body: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        builder: (context, state) {
          if (state.isLoadingSellerPortal) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buyMarketplaceAccent,
              ),
            );
          }

          final provider = state.currentSellerProfile;
          if (provider == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.storefront_outlined,
                      size: 48, color: AppColors.buyTextTertiary),
                  const SizedBox(height: 12),
                  const Text(
                    'Not registered as a seller',
                    style: TextStyle(
                      color: AppColors.buyTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        context.push('/buy/marketplace/register'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buyMarketplaceAccent,
                    ),
                    child: const Text('Register Now'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level & progress
                _LevelCard(
                  level: provider.sellerLevel,
                  completedOrders: provider.completedOrders,
                ),
                const SizedBox(height: 16),

                // Stats grid
                _StatsGrid(
                  completedOrders: provider.completedOrders,
                  totalEarnings: (state.sellerDashboard?.totalRevenue ?? 0.0).round(),
                  trustScore: provider.trustScore,
                  activeListings: state.myListings
                      .where((l) => l.isAvailable)
                      .length,
                ),
                const SizedBox(height: 16),

                // Quick actions
                _QuickActions(
                  onViewOrders: () =>
                      context.push('/buy/marketplace/orders'),
                  onCreateListing: () =>
                      context.push('/buy/marketplace/create-listing'),
                  onViewListings: () =>
                      context.push('/buy/my-listings'),
                ),
                const SizedBox(height: 16),

                // My listings summary
                if (state.myListings.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Listings',
                        style: TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${state.myListings.length} total',
                        style: const TextStyle(
                          color: AppColors.buyTextTertiary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...state.myListings.take(5).map((listing) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.buyCard,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                          border: Border.all(
                              color: AppColors.buyCardBorder, width: 0.5),
                        ),
                        child: InkWell(
                          onTap: () => context.push(
                              '/buy/marketplace/listing/${listing.id}'),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listing.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.buyTextPrimary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${listing.priceTokens} tokens · ${listing.viewCount} views',
                                      style: const TextStyle(
                                        color: AppColors.buyTextTertiary,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: listing.isAvailable
                                      ? AppColors.buySuccess
                                          .withValues(alpha: 0.1)
                                      : AppColors.buyChipBg,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  listing.status.displayName,
                                  style: TextStyle(
                                    color: listing.isAvailable
                                        ? AppColors.buySuccess
                                        : AppColors.buyTextTertiary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final SellerLevel? level;
  final int completedOrders;

  const _LevelCard({
    required this.level,
    required this.completedOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: SellerLevelProgress(
        level: level ?? SellerLevel.newSeller,
        completedOrders: completedOrders,
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final int completedOrders;
  final int totalEarnings;
  final double trustScore;
  final int activeListings;

  const _StatsGrid({
    required this.completedOrders,
    required this.totalEarnings,
    required this.trustScore,
    required this.activeListings,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.6,
      children: [
        _StatCard(
          label: 'Completed',
          value: '$completedOrders',
          icon: Icons.check_circle_outline,
          color: AppColors.buySuccess,
        ),
        _StatCard(
          label: 'Earnings',
          value: 'R${(totalEarnings / 100).toStringAsFixed(0)}',
          icon: Icons.account_balance_wallet_outlined,
          color: AppColors.buyMarketplaceAccent,
        ),
        _StatCard(
          label: 'Trust Score',
          value: trustScore.toStringAsFixed(1),
          icon: Icons.star_outline_rounded,
          color: AppColors.buyWarning,
        ),
        _StatCard(
          label: 'Active Listings',
          value: '$activeListings',
          icon: Icons.storefront_outlined,
          color: AppColors.buyTextSecondary,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.buyCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.buyTextTertiary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final VoidCallback onViewOrders;
  final VoidCallback onCreateListing;
  final VoidCallback onViewListings;

  const _QuickActions({
    required this.onViewOrders,
    required this.onCreateListing,
    required this.onViewListings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.receipt_long_outlined,
          label: 'Orders',
          onTap: onViewOrders,
        ),
        const SizedBox(width: 10),
        _ActionButton(
          icon: Icons.add_circle_outline,
          label: 'New Listing',
          onTap: onCreateListing,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.buyCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: AppColors.buyMarketplaceAccent),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.buyTextPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
