import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/seller_level.dart';
import '../../../domain/entities/marketplace_provider.dart';
import '../../blocs/marketplace/marketplace_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Seller Portal — 4-state screen (Spec §8.2).
///
/// State A: Not registered → onboarding hero + CTA
/// State B: Active seller → earnings card, action cards, performance
/// State C: Suspended → warning + reason + contact support
/// State D: Banned → permanent removal notice
class SellerPortalScreen extends StatefulWidget {
  const SellerPortalScreen({super.key});

  @override
  State<SellerPortalScreen> createState() => _SellerPortalScreenState();
}

class _SellerPortalScreenState extends State<SellerPortalScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MarketplaceBloc>().add(const MarketplaceEvent.loadSellerPortal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buyBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.buyTextPrimary,
        title: const Text(
          'Seller Portal',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<MarketplaceBloc, MarketplaceState>(
        buildWhen: (prev, curr) =>
            prev.isLoadingSellerPortal != curr.isLoadingSellerPortal ||
            prev.currentSellerProfile != curr.currentSellerProfile,
        builder: (context, state) {
          if (state.isLoadingSellerPortal) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buyMarketplaceAccent,
              ),
            );
          }

          final provider = state.currentSellerProfile;

          // State A: Not registered
          if (provider == null) {
            return _NotRegisteredView(
              onStartSelling: () => context.push('/buy/marketplace/register'),
            );
          }

          // State D: Banned
          if (provider.isBanned) {
            return _BannedView(provider: provider);
          }

          // State C: Suspended
          if (provider.isSuspended) {
            return _SuspendedView(provider: provider);
          }

          // State B: Active seller
          return _ActiveSellerView(provider: provider);
        },
      ),
    );
  }
}

// ─── State A: Not Registered ───────────────────────────────────────────

class _NotRegisteredView extends StatelessWidget {
  final VoidCallback onStartSelling;

  const _NotRegisteredView({required this.onStartSelling});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),

          // Hero illustration
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.storefront_rounded,
              size: 56,
              color: AppColors.buyMarketplaceAccent,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          const Text(
            'Start Selling on iMali',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Turn your skills and products into income.\nIt only takes a minute to get started.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // How it works — 3 steps
          _HowItWorksStep(
            index: 1,
            icon: Icons.person_add_rounded,
            title: 'Create your seller profile',
            subtitle: 'Choose a display name and pick your categories.',
          ),
          const SizedBox(height: AppSpacing.md),
          _HowItWorksStep(
            index: 2,
            icon: Icons.camera_alt_rounded,
            title: 'List your first item',
            subtitle: 'Snap a photo, set a price, and publish instantly.',
          ),
          const SizedBox(height: AppSpacing.md),
          _HowItWorksStep(
            index: 3,
            icon: Icons.account_balance_wallet_rounded,
            title: 'Get paid safely',
            subtitle: 'Payments are held in escrow until the buyer confirms.',
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Category preview chips
          const Text(
            'Popular categories',
            style: TextStyle(
              color: AppColors.buyTextTertiary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: const [
              _CategoryPreviewChip('Food & Drinks', Icons.restaurant_rounded),
              _CategoryPreviewChip('Beauty', Icons.spa_rounded),
              _CategoryPreviewChip('Fix & Repair', Icons.build_rounded),
              _CategoryPreviewChip('Clothing', Icons.checkroom_rounded),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),

          // CTA
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onStartSelling,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buyMarketplaceAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Start Selling',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _HowItWorksStep extends StatelessWidget {
  final int index;
  final IconData icon;
  final String title;
  final String subtitle;

  const _HowItWorksStep({
    required this.index,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.buyMarketplaceAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(icon, size: 20, color: AppColors.buyMarketplaceAccent),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.buyTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.buyTextSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPreviewChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CategoryPreviewChip(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.buyChipBg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        border: Border.all(color: AppColors.buyChipBorder, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.buyTextSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── State B: Active Seller ────────────────────────────────────────────

class _ActiveSellerView extends StatelessWidget {
  final MarketplaceProvider provider;

  const _ActiveSellerView({required this.provider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seller profile header
          _SellerProfileHeader(provider: provider),
          const SizedBox(height: AppSpacing.md),

          // Earnings card
          _EarningsCard(provider: provider),
          const SizedBox(height: AppSpacing.md),

          // Quick action cards row
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _QuickActionsRow(provider: provider),
          const SizedBox(height: AppSpacing.lg),

          // Performance snapshot
          const Text(
            'Performance',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PerformanceSnapshot(provider: provider),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _SellerProfileHeader extends StatelessWidget {
  final MarketplaceProvider provider;

  const _SellerProfileHeader({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor:
                AppColors.buyMarketplaceAccent.withValues(alpha: 0.1),
            backgroundImage: provider.photoUrl != null
                ? NetworkImage(provider.photoUrl!)
                : null,
            child: provider.photoUrl == null
                ? const Icon(Icons.person,
                    size: 28, color: AppColors.buyMarketplaceAccent)
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        provider.displayName,
                        style: const TextStyle(
                          color: AppColors.buyTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (provider.effectiveVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified,
                          size: 16, color: AppColors.buyMarketplaceAccent),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                _SellerLevelBadge(level: provider.sellerLevel),
              ],
            ),
          ),
          // Edit profile
          IconButton(
            icon: const Icon(Icons.edit_outlined,
                size: 20, color: AppColors.buyTextTertiary),
            onPressed: () =>
                context.push('/buy/marketplace/edit-profile'),
          ),
        ],
      ),
    );
  }
}

class _SellerLevelBadge extends StatelessWidget {
  final SellerLevel level;

  const _SellerLevelBadge({required this.level});

  Color get _color {
    switch (level) {
      case SellerLevel.newSeller:
        return AppColors.buyTextTertiary;
      case SellerLevel.active:
        return AppColors.buyMarketplaceAccent;
      case SellerLevel.trusted:
        return AppColors.buySuccess;
      case SellerLevel.star:
        return const Color(0xFFFFB82C); // gold
    }
  }

  IconData get _icon {
    switch (level) {
      case SellerLevel.newSeller:
        return Icons.fiber_new_rounded;
      case SellerLevel.active:
        return Icons.trending_up_rounded;
      case SellerLevel.trusted:
        return Icons.verified_user_rounded;
      case SellerLevel.star:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(_icon, size: 14, color: _color),
        const SizedBox(width: 3),
        Text(
          level.displayName,
          style: TextStyle(
            color: _color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _EarningsCard extends StatelessWidget {
  final MarketplaceProvider provider;

  const _EarningsCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceBloc, MarketplaceState>(
      buildWhen: (prev, curr) => prev.sellerDashboard != curr.sellerDashboard,
      builder: (context, state) {
        final dashboard = state.sellerDashboard;
        final totalRevenue = dashboard?.totalRevenue ?? 0.0;
        final revenueZar = totalRevenue / 100;

        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.buyMarketplaceAccent,
                AppColors.buyMarketplaceAccentDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Earnings',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                    ),
                    child: Text(
                      '${provider.completedOrders} sales',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'R${revenueZar.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                provider.completedOrders > 0
                    ? '${dashboard?.totalOrders ?? 0} total orders'
                    : 'Earnings shown after first completed order',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  final MarketplaceProvider provider;

  const _QuickActionsRow({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.add_circle_outline_rounded,
            label: 'New Listing',
            onTap: () => context.push('/buy/marketplace/create-listing'),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ActionCard(
            icon: Icons.list_alt_rounded,
            label: 'My Listings',
            onTap: () => context.push('/buy/my-listings'),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _ActionCard(
            icon: Icons.receipt_long_rounded,
            label: 'Orders',
            onTap: () => context.push('/buy/marketplace/orders'),
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: AppColors.buyMarketplaceAccent),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.buyTextPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PerformanceSnapshot extends StatelessWidget {
  final MarketplaceProvider provider;

  const _PerformanceSnapshot({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.buyCardBorder, width: 0.5),
      ),
      child: Column(
        children: [
          _StatRow(
            label: 'Trust Score',
            value: provider.trustScore > 0
                ? '${provider.trustScore.toStringAsFixed(1)} / 5.0'
                : 'No reviews yet',
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFFFB82C),
          ),
          const Divider(height: 24, color: AppColors.buyDivider),
          _StatRow(
            label: 'Completed Orders',
            value: '${provider.completedOrders}',
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.buySuccess,
          ),
          const Divider(height: 24, color: AppColors.buyDivider),
          _StatRow(
            label: 'Vouches',
            value: '${provider.vouchCount}',
            icon: Icons.thumb_up_rounded,
            iconColor: AppColors.buyMarketplaceAccent,
          ),
          if (provider.avgResponseTimeHrs != null) ...[
            const Divider(height: 24, color: AppColors.buyDivider),
            _StatRow(
              label: 'Avg Response Time',
              value: _formatResponseTime(provider.avgResponseTimeHrs!),
              icon: Icons.access_time_rounded,
              iconColor: AppColors.buyTextSecondary,
            ),
          ],
          if (provider.disputeRate > 0) ...[
            const Divider(height: 24, color: AppColors.buyDivider),
            _StatRow(
              label: 'Dispute Rate',
              value: '${(provider.disputeRate * 100).toStringAsFixed(1)}%',
              icon: Icons.warning_amber_rounded,
              iconColor: provider.disputeRate > 0.1
                  ? AppColors.buyError
                  : AppColors.buyWarning,
            ),
          ],
        ],
      ),
    );
  }

  String _formatResponseTime(double hours) {
    if (hours < 1) {
      return '${(hours * 60).round()} min';
    } else if (hours < 24) {
      return '${hours.toStringAsFixed(1)} hrs';
    } else {
      return '${(hours / 24).toStringAsFixed(1)} days';
    }
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 13,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.buyTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ─── State C: Suspended ────────────────────────────────────────────────

class _SuspendedView extends StatelessWidget {
  final MarketplaceProvider provider;

  const _SuspendedView({required this.provider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // Warning icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.buyWarning.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 40,
              color: AppColors.buyWarning,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          const Text(
            'Account Suspended',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          Text(
            'Your seller account has been temporarily suspended.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Reason card
          if (provider.suspensionReason != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.buyWarning.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(
                  color: AppColors.buyWarning.withValues(alpha: 0.3),
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reason',
                    style: TextStyle(
                      color: AppColors.buyTextTertiary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    provider.suspensionReason!,
                    style: const TextStyle(
                      color: AppColors.buyTextPrimary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

          if (provider.suspendedAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Suspended on ${_formatDate(provider.suspendedAt!)}',
              style: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xxl),

          // Contact support
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Contact Support',
                      style: TextStyle(
                        color: AppColors.buyTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: const Text(
                      'For help with your suspended account, please email us at support@imalichat.app with your account details and we will respond within 24 hours.',
                      style: TextStyle(
                        color: AppColors.buyTextSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.support_agent_rounded, size: 20),
              label: const Text('Contact Support'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.buyMarketplaceAccent,
                side: const BorderSide(color: AppColors.buyMarketplaceAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

// ─── State D: Banned ───────────────────────────────────────────────────

class _BannedView extends StatelessWidget {
  final MarketplaceProvider provider;

  const _BannedView({required this.provider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // Ban icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.buyError.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.block_rounded,
              size: 40,
              color: AppColors.buyError,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          const Text(
            'Account Permanently Removed',
            style: TextStyle(
              color: AppColors.buyTextPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          const Text(
            'Your seller account has been permanently removed due to '
            'repeated policy violations. You can no longer sell on iMali.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.buyTextSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          if (provider.bannedAt != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              'Effective ${_formatDate(provider.bannedAt!)}',
              style: const TextStyle(
                color: AppColors.buyTextTertiary,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xxl),

          // Info card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.buyError.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: AppColors.buyError.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 18, color: AppColors.buyError),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Any pending orders have been refunded to buyers. '
                    'Your listing data has been archived.',
                    style: TextStyle(
                      color: AppColors.buyTextSecondary,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
