import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/sub_account.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/wave_background.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(const WalletEvent.loadLedger());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final isLoading = state.status == WalletStatus.loading;

        return RefreshIndicator(
          onRefresh: () async {
            context.read<WalletBloc>().add(const WalletEvent.refreshLedger());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: WaveBackground(
              child: Padding(
                padding: AppSpacing.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Portfolio total card
                    _buildPortfolioCard(context, state, isLoading),
                    AppSpacing.verticalXl,

                    // Quick actions row
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionCard(
                            context,
                            icon: Icons.arrow_upward,
                            label: 'Cash Out',
                            color: AppColors.success,
                            onTap: () => context.go('/wallet/withdraw'),
                          ),
                        ),
                        AppSpacing.horizontalMd,
                        Expanded(
                          child: _buildActionCard(
                            context,
                            icon: Icons.history,
                            label: 'History',
                            color: AppColors.secondary,
                            onTap: () => context.go('/wallet/transactions'),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalXl,

                    // Wallets section header
                    Text(
                      'My Wallets',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    AppSpacing.verticalMd,

                    // Wallet cards
                    if (isLoading && state.subAccounts.isEmpty)
                      _buildLoadingWallets()
                    else if (state.subAccounts.isEmpty)
                      _buildEmptyWallets(context)
                    else
                      ...state.subAccounts.map(
                        (sa) => _buildWalletCard(context, sa),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPortfolioCard(
    BuildContext context,
    WalletState state,
    bool isLoading,
  ) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.logoGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusLg,
        boxShadow: [
          BoxShadow(
            color: AppColors.tertiary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Balance',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
          ),
          AppSpacing.verticalSm,
          if (isLoading)
            const SizedBox(
              height: 48,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            )
          else
            Text(
              '${state.portfolioBalance}',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          AppSpacing.verticalXs,
          Text(
            '= R${state.portfolioBalanceZar.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
          ),
          AppSpacing.verticalSm,
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white.withValues(alpha: 0.7),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                '${state.subAccounts.length} wallet${state.subAccounts.length == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
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
            color: AppColors.surface,
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
                              : Icons.storefront,
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
                                  : 'Brand Wallet',
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

  Widget _buildEmptyWallets(BuildContext context) {
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
            Icons.account_balance_wallet_outlined,
            size: 48,
            color: AppColors.textSecondary,
          ),
          AppSpacing.verticalMd,
          Text(
            'No wallets yet',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          AppSpacing.verticalXs,
          Text(
            'Start earning tokens to see your wallets here',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
