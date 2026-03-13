import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/reward_item.dart';
import '../../../domain/enums/reward_enums.dart';
import '../../blocs/reward/reward_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/imali_app_bar.dart';

class RewardsListScreen extends StatefulWidget {
  const RewardsListScreen({super.key});

  @override
  State<RewardsListScreen> createState() => _RewardsListScreenState();
}

class _RewardsListScreenState extends State<RewardsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<RewardBloc>().add(const RewardEvent.refreshItems());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(
        title: 'My Rewards',
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Redeemed'),
            Tab(text: 'Expired'),
          ],
        ),
      ),
      body: BlocBuilder<RewardBloc, RewardState>(
                  builder: (context, state) {
                    if (state.status == RewardLoadStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == RewardLoadStatus.error) {
                      return _buildErrorState(context, state.errorMessage);
                    }

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildItemsList(context, state.activeItems, 'active'),
                        _buildItemsList(context, state.redeemedItems, 'redeemed'),
                        _buildItemsList(context, state.expiredItems, 'expired'),
                      ],
                    );
                  },
                ),
    );
  }

  Widget _buildItemsList(
    BuildContext context,
    List<RewardItem> items,
    String tabType,
  ) {
    if (items.isEmpty) {
      return _buildEmptyState(context, tabType);
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<RewardBloc>().add(const RewardEvent.refreshItems());
      },
      child: ListView.separated(
        padding: AppSpacing.pagePadding,
        itemCount: items.length,
        separatorBuilder: (_, _) => AppSpacing.verticalSm,
        itemBuilder: (context, index) => _buildRewardCard(context, items[index]),
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, RewardItem item) {
    return InkWell(
      onTap: () => context.go('/wallet/rewards/${item.id}'),
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Reward type icon
            _buildRewardTypeIcon(item),
            AppSpacing.horizontalMd,
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.campaignName ?? 'Reward',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.verticalXxs,
                  Text(
                    item.clientName ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  if (item.isUsable && item.expiresAt != null) ...[
                    AppSpacing.verticalXxs,
                    _buildExpiryInfo(context, item),
                  ],
                  if (item.status == RewardItemStatus.redeemed &&
                      item.redeemedAt != null) ...[
                    AppSpacing.verticalXxs,
                    Text(
                      'Used ${_formatDate(item.redeemedAt!)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ],
              ),
            ),
            // Status badge
            _buildStatusBadge(context, item),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardTypeIcon(RewardItem item) {
    final IconData icon;
    final Color color;

    switch (item.rewardType) {
      case RewardType.qrCode:
        icon = Icons.qr_code_2;
        color = AppColors.primary;
      case RewardType.voucherCode:
        icon = Icons.confirmation_number_outlined;
        color = AppColors.secondary;
      case RewardType.discountCode:
        icon = Icons.percent;
        color = AppColors.success;
      case RewardType.digitalContent:
        icon = Icons.download;
        color = AppColors.info;
      case null:
        icon = Icons.card_giftcard;
        color = AppColors.accent;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }

  Widget _buildExpiryInfo(BuildContext context, RewardItem item) {
    final hours = item.hoursUntilExpiry;
    final days = item.daysUntilExpiry;

    if (hours != null && hours < 24) {
      return Text(
        'Expires in ${hours}h',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
      );
    }

    if (days != null) {
      return Text(
        'Expires in $days day${days == 1 ? '' : 's'}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: days <= 3 ? AppColors.warning : AppColors.textTertiary,
            ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildStatusBadge(BuildContext context, RewardItem item) {
    final Color bgColor;
    final Color textColor;
    final String label;

    switch (item.status) {
      case RewardItemStatus.allocated:
        bgColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
        label = 'Active';
      case RewardItemStatus.redeemed:
        bgColor = AppColors.textSecondary.withValues(alpha: 0.15);
        textColor = AppColors.textSecondary;
        label = 'Used';
      case RewardItemStatus.expired:
        bgColor = AppColors.error.withValues(alpha: 0.15);
        textColor = AppColors.error;
        label = 'Expired';
      default:
        bgColor = AppColors.textTertiary.withValues(alpha: 0.15);
        textColor = AppColors.textTertiary;
        label = item.status.displayName;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String tabType) {
    final String title;
    final String subtitle;
    final IconData icon;

    switch (tabType) {
      case 'active':
        title = 'No active rewards';
        subtitle = 'Complete earn activities to unlock rewards!';
        icon = Icons.card_giftcard_outlined;
      case 'redeemed':
        title = 'No redeemed rewards';
        subtitle = 'Rewards you use will appear here';
        icon = Icons.check_circle_outline;
      case 'expired':
        title = 'No expired rewards';
        subtitle = 'Expired rewards will appear here';
        icon = Icons.timer_off_outlined;
      default:
        title = 'No rewards';
        subtitle = '';
        icon = Icons.card_giftcard_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textTertiary),
          AppSpacing.verticalMd,
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          AppSpacing.verticalXs,
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          AppSpacing.verticalMd,
          Text(
            message ?? 'Failed to load rewards',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalLg,
          AppButton(
            text: 'Retry',
            onPressed: () {
              context.read<RewardBloc>().add(const RewardEvent.loadItems());
            },
            isFullWidth: false,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
