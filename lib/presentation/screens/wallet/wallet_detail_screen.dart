import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/ledger_journal.dart';
import '../../../domain/entities/reward_item.dart';
import '../../../domain/entities/sub_account.dart';
import '../../../domain/enums/reward_enums.dart';
import '../../blocs/reward/reward_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class WalletDetailScreen extends StatelessWidget {
  final String subAccountId;

  const WalletDetailScreen({super.key, required this.subAccountId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final subAccount = state.subAccounts
            .where((sa) => sa.id == subAccountId)
            .firstOrNull;

        if (subAccount == null) {
          return Scaffold(
            appBar: IMaliAppBar(title: 'Wallet'),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final accentColor = subAccount.isDefault
            ? AppColors.walletPrimary
            : subAccount.isRestricted
                ? AppColors.walletZawadi
                : AppColors.walletSecondary;

        return Scaffold(
          appBar: IMaliAppBar(title: subAccount.name),
          body: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<WalletBloc>()
                  .add(const WalletEvent.refreshLedger());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: WaveBackground(
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Balance card
                      _buildBalanceCard(context, subAccount, accentColor),
                      AppSpacing.verticalXl,

                      // Action buttons
                      _buildActionButtons(context, subAccount, accentColor),
                      AppSpacing.verticalXl,

                      // Brand rewards section (only for brand wallets)
                      if (subAccount.isRestricted)
                        _buildBrandRewards(context, subAccount),

                      // Recent transactions header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Transactions',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          TextButton(
                            onPressed: () =>
                                context.go('/wallet/transactions'),
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      AppSpacing.verticalMd,

                      // Recent transactions
                      _buildRecentTransactions(context, state),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBalanceCard(
    BuildContext context,
    SubAccount subAccount,
    Color accentColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColor, accentColor.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusLg,
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            subAccount.isDefault
                ? Icons.account_balance_wallet
                : Icons.storefront,
            color: Colors.white.withValues(alpha: 0.8),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            subAccount.isDefault ? 'Main Wallet' : 'Brand Wallet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
          ),
          const Spacer(),
          Text(
            '${subAccount.balance} tokens',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 8),
          Text(
            '= R${subAccount.balanceZar.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    SubAccount subAccount,
    Color accentColor,
  ) {
    return BlocBuilder<RewardBloc, RewardState>(
      builder: (context, rewardState) {
        // For brand wallets, find matching rewards
        final brandRewards = subAccount.isRestricted
            ? _getBrandRewards(rewardState, subAccount.name)
            : <RewardItem>[];

        return Row(
          children: [
            // Send button (only for unrestricted wallets)
            if (!subAccount.isRestricted)
              Expanded(
                child: _buildActionButton(
                  context,
                  icon: Icons.send,
                  label: 'Send',
                  color: AppColors.secondary,
                  onTap: () => context.go(
                    '/wallet/send',
                    extra: {'subAccountId': subAccount.id},
                  ),
                ),
              ),
            if (!subAccount.isRestricted) AppSpacing.horizontalMd,

            // Cash Out button (only for default unrestricted)
            if (subAccount.isDefault)
              Expanded(
                child: _buildActionButton(
                  context,
                  icon: Icons.arrow_upward,
                  label: 'Cash Out',
                  color: AppColors.success,
                  onTap: () => context.go('/wallet/withdraw'),
                ),
              ),

            // Rewards or Use Tokens button (for brand wallets)
            if (subAccount.isRestricted)
              Expanded(
                child: brandRewards.isNotEmpty
                    ? _buildActionButton(
                        context,
                        icon: Icons.card_giftcard,
                        label: 'Rewards (${brandRewards.length})',
                        color: accentColor,
                        onTap: () => context.go('/wallet/rewards'),
                      )
                    : _buildActionButton(
                        context,
                        icon: Icons.storefront,
                        label: 'Use Tokens',
                        color: accentColor,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Brand token redemption coming soon'),
                            ),
                          );
                        },
                      ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            AppSpacing.verticalSm,
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get reward items matching this brand wallet's name (case-insensitive)
  List<RewardItem> _getBrandRewards(RewardState rewardState, String walletName) {
    final normalizedName = walletName.trim().toLowerCase();
    return rewardState.activeItems
        .where((item) =>
            item.clientName != null &&
            item.clientName!.trim().toLowerCase() == normalizedName)
        .toList();
  }

  Widget _buildBrandRewards(BuildContext context, SubAccount subAccount) {
    return BlocBuilder<RewardBloc, RewardState>(
      builder: (context, rewardState) {
        final brandRewards = _getBrandRewards(rewardState, subAccount.name);

        if (brandRewards.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Brand Rewards',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                GestureDetector(
                  onTap: () => context.go('/wallet/rewards'),
                  child: Text(
                    'View All',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            AppSpacing.verticalMd,
            ...brandRewards.take(3).map(
                  (item) => _buildCompactRewardCard(context, item),
                ),
            AppSpacing.verticalXl,
          ],
        );
      },
    );
  }

  Widget _buildCompactRewardCard(BuildContext context, RewardItem item) {
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => context.go('/wallet/rewards/${item.id}'),
        borderRadius: AppSpacing.borderRadiusMd,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              AppSpacing.horizontalMd,
              Expanded(
                child: Text(
                  item.campaignName ?? 'Reward',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildExpiryBadge(context, item),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: AppColors.textTertiary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpiryBadge(BuildContext context, RewardItem item) {
    if (item.expiresAt == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Active',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
        ),
      );
    }

    final hours = item.hoursUntilExpiry;
    final days = item.daysUntilExpiry;

    if (hours != null && hours < 24) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${hours}h left',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
        ),
      );
    }

    if (days != null) {
      final isUrgent = days <= 3;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: (isUrgent ? AppColors.warning : AppColors.success)
              .withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${days}d left',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isUrgent ? AppColors.warning : AppColors.success,
                fontWeight: FontWeight.w600,
              ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildRecentTransactions(BuildContext context, WalletState state) {
    if (state.ledgerJournals.isEmpty) {
      return Container(
        width: double.infinity,
        padding: AppSpacing.cardPaddingLarge,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            AppSpacing.verticalMd,
            Text(
              'No transactions yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: state.ledgerJournals.take(5).map((journal) {
        return _buildJournalItem(context, journal, state.ledgerAccount?.id);
      }).toList(),
    );
  }

  Widget _buildJournalItem(
    BuildContext context,
    LedgerJournal journal,
    String? userAccountId,
  ) {
    final userEntry = userAccountId != null
        ? journal.entries
            .where((e) => e.accountId == userAccountId)
            .firstOrNull
        : null;

    final isPositive = userEntry?.entryType == LedgerEntryType.credit;
    final amount = userEntry?.amount ?? journal.totalCredits;

    return Container(
      padding: AppSpacing.cardPadding,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isPositive
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPositive ? Icons.add : Icons.remove,
              color: isPositive ? AppColors.success : AppColors.error,
              size: 16,
            ),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  journal.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  _formatDate(journal.postedAt ?? journal.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : '-'}$amount',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isPositive ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      if (diff.inHours == 0) return '${diff.inMinutes}m ago';
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}
