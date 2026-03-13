import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/buy/trust_badge.dart';
import '../../widgets/buy/vouch_list.dart';
import '../../widgets/common/app_button.dart';

/// Provider profile screen showing trust info, listings, and vouches.
class MarketplaceProviderProfileScreen extends StatefulWidget {
  final String providerId;

  const MarketplaceProviderProfileScreen({
    super.key,
    required this.providerId,
  });

  @override
  State<MarketplaceProviderProfileScreen> createState() =>
      _MarketplaceProviderProfileScreenState();
}

class _MarketplaceProviderProfileScreenState
    extends State<MarketplaceProviderProfileScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<MarketplaceBloc>();
    bloc.add(MarketplaceEvent.loadProviderProfile(widget.providerId));
    bloc.add(MarketplaceEvent.loadProviderVouches(widget.providerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        title: const Text('Provider'),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.flag_outlined),
            onPressed: () => context.push(
              '/buy/marketplace/report/provider/${widget.providerId}',
            ),
          ),
        ],
      ),
      body: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        builder: (context, state) {
          if (state.isLoadingProvider && state.selectedProvider == null) {
            return _buildShimmer();
          }

          final provider = state.selectedProvider;
          if (provider == null) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Provider not found',
                style: const TextStyle(color: AppColors.buyTextSecondary),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  color: AppColors.buyCard,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.buyCard,
                        backgroundImage: provider.photoUrl != null
                            ? CachedNetworkImageProvider(provider.photoUrl!)
                            : null,
                        child: provider.photoUrl == null
                            ? Text(
                                provider.displayName.isNotEmpty
                                    ? provider.displayName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  color: AppColors.buyTextPrimary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.displayName,
                              style: const TextStyle(
                                color: AppColors.buyTextPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            TrustBadge(
                              score: provider.trustScore,
                              isVerified: provider.effectiveVerified,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats row
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      _buildStat(
                        '${provider.completedOrders}',
                        'Orders',
                        Icons.shopping_bag_outlined,
                      ),
                      _buildStat(
                        '${provider.vouchCount}',
                        'Vouches',
                        Icons.thumb_up_outlined,
                      ),
                      _buildStat(
                        provider.trustScore.toStringAsFixed(1),
                        'Rating',
                        Icons.star_outline_rounded,
                      ),
                    ],
                  ),
                ),

                // Bio
                if (provider.bio != null && provider.bio!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                            color: AppColors.buyTextPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          provider.bio!,
                          style: const TextStyle(
                            color: AppColors.buyTextSecondary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: AppSpacing.lg),

                // Services
                if (provider.servicesDescription != null &&
                    provider.servicesDescription!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Services',
                          style: TextStyle(
                            color: AppColors.buyTextPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          provider.servicesDescription!,
                          style: const TextStyle(
                            color: AppColors.buyTextSecondary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: AppSpacing.lg),

                // Vouches
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: const Text(
                    'Vouches',
                    style: TextStyle(
                      color: AppColors.buyTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                VouchList(vouches: state.providerVouches),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: const BoxDecoration(
          color: AppColors.buyCard,
          border: Border(
            top: BorderSide(color: AppColors.buyCardBorder, width: 0.5),
          ),
        ),
        child: SafeArea(
          child: AppButton(
            text: 'Contact',
            variant: AppButtonVariant.primary,
            isFullWidth: true,
            onPressed: () {
              final provider = context.read<MarketplaceBloc>().state.selectedProvider;
              if (provider == null) return;
              context.push(
                '/chat/conversation/${provider.userId}',
                extra: {
                  'recipientName': provider.displayName,
                  'context': 'marketplace_provider',
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.buyMarketplaceAccent, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.buyCard,
      highlightColor: AppColors.buyCard,
      child: Column(
        children: [
          Container(height: 100, color: AppColors.buyCard),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 20, width: 150, color: AppColors.buyCard),
                const SizedBox(height: 12),
                Container(height: 60, color: AppColors.buyCard),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
