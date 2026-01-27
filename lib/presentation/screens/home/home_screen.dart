import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load wallet when screen initializes
    context.read<WalletBloc>().add(const WalletEvent.loadWallet());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;

        return BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('iMali'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<WalletBloc>().add(const WalletEvent.loadWallet());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting
                      Text(
                        'Hello, ${user?.displayName ?? 'User'}!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      AppSpacing.verticalXs,
                      Text(
                        'Ready to earn?',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      AppSpacing.verticalLg,

                      // Balance Card
                      _buildBalanceCard(context, walletState),
                      AppSpacing.verticalLg,

                      // Quick Actions
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      AppSpacing.verticalMd,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildQuickAction(
                            context,
                            Icons.play_circle_outline,
                            'Earn',
                            () => context.go('/earn'),
                          ),
                          _buildQuickAction(
                            context,
                            Icons.send_outlined,
                            'Send',
                            () => context.go('/chat'),
                          ),
                          _buildQuickAction(
                            context,
                            Icons.request_page_outlined,
                            'Request',
                            () => context.go('/chat'),
                          ),
                          _buildQuickAction(
                            context,
                            Icons.account_balance_wallet_outlined,
                            'Cashout',
                            () => context.go('/home/cashout'),
                          ),
                        ],
                      ),
                      AppSpacing.verticalXl,

                      // Start Earning
                      Text(
                        'Start Earning',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      AppSpacing.verticalMd,
                      _buildEarnCard(
                        context,
                        'Watch Videos',
                        'Earn 10-50 tokens per video',
                        Icons.smart_display_outlined,
                        () => context.go('/earn'),
                      ),
                      AppSpacing.verticalMd,
                      _buildEarnCard(
                        context,
                        'Complete Surveys',
                        'Earn 100-500 tokens per survey',
                        Icons.quiz_outlined,
                        () => context.go('/earn'),
                      ),
                      AppSpacing.verticalXl,

                      // Recent Transactions
                      if (walletState.transactions.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Activity',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            TextButton(
                              onPressed: () => context.go('/home/transactions'),
                              child: const Text('See All'),
                            ),
                          ],
                        ),
                        AppSpacing.verticalSm,
                        ...walletState.transactions.take(3).map(
                              (tx) => _buildTransactionItem(context, tx),
                            ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBalanceCard(BuildContext context, WalletState walletState) {
    final isLoading = walletState.status == WalletStatus.loading;
    final balance = walletState.balance;
    final balanceZar = walletState.balanceZar;

    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPaddingLarge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSpacing.borderRadiusLg,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Balance',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.2),
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.monetization_on,
                      size: 14,
                      color: AppColors.tokenGold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Tokens',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.verticalSm,
          if (isLoading)
            const SizedBox(
              height: 40,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.textOnPrimary,
                  strokeWidth: 2,
                ),
              ),
            )
          else
            Text(
              '$balance Tokens',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          AppSpacing.verticalXs,
          Text(
            '= R${balanceZar.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                ),
          ),
          if (walletState.canCashout) ...[
            AppSpacing.verticalMd,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.go('/home/cashout'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textOnPrimary,
                  side: BorderSide(color: AppColors.textOnPrimary.withValues(alpha: 0.5)),
                ),
                child: const Text('Cash Out'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          AppSpacing.verticalXs,
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildEarnCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.2),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Icon(icon, color: AppColors.secondaryDark, size: 28),
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, dynamic tx) {
    final isPositive = tx.amount > 0;

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
                  tx.description ?? tx.type.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  _formatDate(tx.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : ''}${tx.amount}',
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
      if (diff.inHours == 0) {
        return '${diff.inMinutes}m ago';
      }
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}
