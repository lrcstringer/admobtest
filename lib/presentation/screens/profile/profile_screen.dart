import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/referral/referral_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load referral stats for the profile
    context.read<ReferralBloc>().add(const ReferralEvent.loadStats());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => context.push('/home/profile/settings'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: AppSpacing.cardPaddingLarge,
                  color: AppColors.surface,
                  child: Column(
                    children: [
                      // Avatar with edit button
                      GestureDetector(
                        onTap: () => context.push('/home/profile/edit'),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.primary,
                              backgroundImage: user?.profile?.avatarUrl != null
                                  ? NetworkImage(user!.profile!.avatarUrl!)
                                  : null,
                              child: user?.profile?.avatarUrl == null
                                  ? Text(
                                      user?.initials ?? 'U',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            color: AppColors.textOnPrimary,
                                          ),
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.verticalMd,
                      Text(
                        user?.displayName ?? 'User',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (user?.profile?.username != null) ...[
                        AppSpacing.verticalXs,
                        Text(
                          '@${user!.profile!.username}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                      AppSpacing.verticalMd,
                      // Stats row with real data
                      BlocBuilder<WalletBloc, WalletState>(
                        builder: (context, walletState) {
                          return BlocBuilder<ReferralBloc, ReferralState>(
                            builder: (context, referralState) {
                              final totalEarned =
                                  walletState.wallet?.lifetimeEarned ?? 0;
                              final referralCount =
                                  referralState.stats?.totalReferrals ?? 0;

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildStat(
                                    context,
                                    _formatNumber(totalEarned),
                                    'Tokens Earned',
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: AppColors.divider,
                                    margin: const EdgeInsets.symmetric(horizontal: 24),
                                  ),
                                  _buildStat(
                                    context,
                                    referralCount.toString(),
                                    'Referrals',
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: AppColors.divider,
                                    margin: const EdgeInsets.symmetric(horizontal: 24),
                                  ),
                                  _buildStat(context, '0', 'Pots Won'),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalMd,

                // Quick Actions
                Container(
                  color: AppColors.surface,
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context,
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Wallet',
                        subtitle: 'View balance and transactions',
                        onTap: () => context.push('/wallet/transactions'),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.shopping_bag_outlined,
                        title: 'Buy Services',
                        subtitle: 'Airtime, data, electricity & more',
                        onTap: () => context.push('/buy'),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.people_outline,
                        title: 'Referrals',
                        subtitle: 'Invite friends and earn',
                        onTap: () => context.push('/home/profile/referrals'),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalMd,

                // Settings Section
                Container(
                  color: AppColors.surface,
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context,
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        onTap: () => context.push('/home/profile/notifications'),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.security_outlined,
                        title: 'Security',
                        subtitle: 'PIN and biometric settings',
                        onTap: () => context.push('/home/profile/security'),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        subtitle: 'FAQs and contact support',
                        onTap: () => context.push('/home/profile/help'),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.info_outline,
                        title: 'About',
                        subtitle: 'App version and legal',
                        onTap: () => context.push('/home/profile/about'),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalMd,

                // Sign Out
                Container(
                  color: AppColors.surface,
                  child: _buildMenuItem(
                    context,
                    icon: Icons.logout,
                    title: 'Sign Out',
                    subtitle: 'Sign out of your account',
                    onTap: () {
                      _showSignOutDialog(context);
                    },
                    isDestructive: true,
                  ),
                ),
                AppSpacing.verticalXl,
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildStat(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.textPrimary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(const AuthEvent.signOut());
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
