import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/reward_item.dart';
import '../../../domain/entities/sub_account.dart';
import '../../../domain/enums/reward_enums.dart';
import '../../blocs/reward/reward_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _rewardsUiEnabled = true;

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(const WalletEvent.loadLedger());
    context.read<RewardBloc>().add(const RewardEvent.loadItems());
    _loadRewardFlag();
  }

  void _navigateToRewards(BuildContext context) {
    context.go('/wallet/rewards');
  }

  Future<void> _loadRewardFlag() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('platformSettings')
          .doc('rewards')
          .get();
      if (!mounted) return;
      if (doc.exists && doc.data()?['rewardsWalletUiEnabled'] == false) {
        setState(() => _rewardsUiEnabled = false);
      }
    } catch (_) {}
  }

  void _showCreateWalletDialog(BuildContext context) {
    final nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create Wallet'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Wallet Name',
              hintText: 'e.g. Savings, Groceries',
            ),
            maxLength: 30,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Name is required';
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          BlocBuilder<WalletBloc, WalletState>(
            builder: (ctx, state) => FilledButton(
              onPressed: state.isTransferring
                  ? null
                  : () {
                      if (!formKey.currentState!.validate()) return;
                      context.read<WalletBloc>().add(
                            WalletEvent.createUserWallet(
                              name: nameController.text.trim(),
                            ),
                          );
                      Navigator.of(dialogContext).pop();
                    },
              child: state.isTransferring
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Wallet'),
      body: BlocListener<WalletBloc, WalletState>(
        listenWhen: (prev, curr) =>
            prev.successMessage != curr.successMessage ||
            prev.errorMessage != curr.errorMessage,
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success,
              ),
            );
            context.read<WalletBloc>().add(const WalletEvent.clearMessages());
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<WalletBloc>().add(const WalletEvent.clearMessages());
          }
        },
        child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          final isLoading = state.status == WalletStatus.loading;

          return RefreshIndicator(
          onRefresh: () async {
            context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
            context.read<RewardBloc>().add(const RewardEvent.refreshItems());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: WaveBackground(
              child: Padding(
                padding: AppSpacing.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Portfolio balance card
                    _buildPortfolioCard(context, state, isLoading),
                    AppSpacing.verticalXl,

                    // My Wallets section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Wallets',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, size: 24),
                          tooltip: 'Create Wallet',
                          onPressed: () => _showCreateWalletDialog(context),
                        ),
                      ],
                    ),
                    AppSpacing.verticalMd,

                    // Wallet cards — always show main wallet first
                    if (isLoading && state.subAccounts.isEmpty && state.ledgerAccount == null)
                      _buildLoadingWallets()
                    else ...[
                      // Main wallet card (always present)
                      _buildWalletCard(
                        context,
                        SubAccount(
                          id: 'main',
                          userId: '',
                          name: 'Main Wallet',
                          balance: state.mainWalletAvailable,
                          lifetimeCredits: 0,
                          lifetimeDebits: 0,
                          isActive: true,
                          isDefault: true,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      ),
                      // User-created and brand sub-accounts
                      ...state.subAccounts.map(
                        (sa) => _buildWalletCard(context, sa),
                      ),
                    ],

                    AppSpacing.verticalXl,

                    // My Rewards section
                    _buildRewardsSection(context),
                  ],
                ),
              ),
            ),
          ),
        );
        },
      ),
      ),
    );
  }

  Widget _buildPortfolioCard(
    BuildContext context,
    WalletState state,
    bool isLoading,
  ) {
    return BlocBuilder<RewardBloc, RewardState>(
      builder: (context, rewardState) {
        final activeRewards = rewardState.activeCount;
        final walletCount = state.subAccounts.length + 1;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.logoGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppSpacing.borderRadiusLg,
          ),
          child: Row(
            children: [
              // Left: label + wallet/reward counts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portfolio Balance',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      [
                        '$walletCount wallet${walletCount == 1 ? '' : 's'}',
                        if (_rewardsUiEnabled && activeRewards > 0)
                          '$activeRewards reward${activeRewards == 1 ? '' : 's'}',
                      ].join('  ·  '),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ),
              // Right: token count + ZAR
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isLoading)
                    const SizedBox(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  else
                    Text(
                      '${state.balance} tokens',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    'R${state.balanceZar.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRewardsSection(BuildContext context) {
    if (!_rewardsUiEnabled) return const SizedBox.shrink();

    return BlocBuilder<RewardBloc, RewardState>(
      builder: (context, rewardState) {
        // Hide during initial load
        if (rewardState.status == RewardLoadStatus.initial ||
            rewardState.status == RewardLoadStatus.loading) {
          return const SizedBox.shrink();
        }

        // Show error state with retry instead of empty state
        if (rewardState.status == RewardLoadStatus.error) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Rewards',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              AppSpacing.verticalMd,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: Text(
                        'Could not load rewards',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context
                          .read<RewardBloc>()
                          .add(const RewardEvent.loadItems()),
                      child: Text(
                        'Retry',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalLg,
            ],
          );
        }

        final activeItems = rewardState.activeItems;
        final totalItems = rewardState.items.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Rewards',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (totalItems > 0)
                  GestureDetector(
                    onTap: () => _navigateToRewards(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All ($totalItems)',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            AppSpacing.verticalMd,

            // Active reward items (up to 3)
            if (activeItems.isNotEmpty) ...[
              ...activeItems.take(3).map(
                    (item) => _buildCompactRewardCard(context, item),
                  ),
              if (activeItems.length > 3)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => _navigateToRewards(context),
                      child: Text(
                        'See ${activeItems.length - 3} more',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  ),
                ),
            ] else if (totalItems > 0)
              // Has redeemed/expired but no active
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.card_giftcard_outlined,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: Text(
                        'No active rewards',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _navigateToRewards(context),
                      child: Text(
                        'View history',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  ],
                ),
              )
            else
              // No items at all
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.card_giftcard_outlined,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: Text(
                        'Complete earn activities to unlock rewards',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                      ),
                    ),
                  ],
                ),
              ),

            AppSpacing.verticalLg,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.campaignName ?? 'Reward',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.clientName != null)
                      Text(
                        item.clientName!,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              _buildCompactExpiryBadge(context, item),
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

  Widget _buildCompactExpiryBadge(BuildContext context, RewardItem item) {
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

  Widget _buildWalletCard(BuildContext context, SubAccount subAccount) {
    final accentColor = subAccount.isDefault
        ? AppColors.walletPrimary
        : subAccount.isRestricted
            ? AppColors.walletZawadi
            : AppColors.walletSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.go('/wallet/detail/${subAccount.id}'),
        borderRadius: AppSpacing.borderRadiusMd,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.alphaBlend(
                  accentColor.withValues(alpha: 0.03),
                  AppColors.surface,
                ),
                AppColors.surface,
              ],
            ),
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              // Accent stripe
              Container(
                width: 4,
                height: 80,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      // Wallet icon
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          subAccount.isDefault
                              ? Icons.account_balance_wallet
                              : subAccount.isRestricted
                                  ? Icons.storefront
                                  : Icons.savings_outlined,
                          color: accentColor,
                          size: 20,
                        ),
                      ),
                      AppSpacing.horizontalMd,
                      // Name and type
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subAccount.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            AppSpacing.verticalXxs,
                            Text(
                              subAccount.isDefault
                                  ? 'Main Wallet'
                                  : subAccount.isRestricted
                                      ? 'Brand Wallet'
                                      : 'Custom Wallet',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      // Balance
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${subAccount.balance}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'R${subAccount.balanceZar.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      AppSpacing.horizontalSm,
                      Icon(
                        Icons.chevron_right,
                        color: AppColors.textTertiary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWallets() {
    return Column(
      children: List.generate(
        2,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ),
    );
  }
}
