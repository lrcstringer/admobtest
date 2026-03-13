import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/referral/referral_bloc.dart';
import '../../blocs/wallet/wallet_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReferralBloc>().add(const ReferralEvent.loadStats());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;

        return Scaffold(
          appBar: const IMaliAppBar(title: 'Profile'),
          body: WaveBackground(
            child: ListView(
              children: [
                // Profile Header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
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
                              backgroundImage:
                                  user?.profile?.avatarUrl != null
                                      ? NetworkImage(
                                          user!.profile!.avatarUrl!)
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
                                  border: Border.all(
                                      color: Colors.white, width: 2),
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
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      AppSpacing.verticalMd,
                      // Stats row
                      BlocBuilder<WalletBloc, WalletState>(
                        builder: (context, walletState) {
                          return BlocBuilder<ReferralBloc, ReferralState>(
                            builder: (context, referralState) {
                              final totalEarned =
                                  walletState.totalTokensEarned;
                              final referralCount =
                                  referralState.stats?.totalReferrals ??
                                      0;

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  _buildStat(
                                    context,
                                    _formatNumber(totalEarned),
                                    'Tokens Earned',
                                    valueColor: AppColors.gold,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: AppColors.divider,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                  ),
                                  _buildStat(
                                    context,
                                    referralCount.toString(),
                                    'Referrals',
                                    valueColor: AppColors.primary,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: AppColors.divider,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                  ),
                                  _buildStat(context, '0', 'Pots Won',
                                      valueColor: AppColors.secondary),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Account section
                _buildSectionHeader(context, 'Account'),
                _buildMenuItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Name, avatar, details',
                  onTap: () => context.push('/home/profile/edit'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.contacts_outlined,
                  title: 'Contacts',
                  subtitle: 'Manage contacts and requests',
                  onTap: () => context.push('/home/profile/contacts'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.verified_user_outlined,
                  title: 'Verify Identity',
                  subtitle: 'KYC verification for cashouts',
                  onTap: () => context.push('/home/profile/kyc'),
                ),
                const Divider(height: 1),

                // Preferences section
                _buildSectionHeader(context, 'Preferences'),
                _buildMenuItem(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Manage notification preferences',
                  onTap: () =>
                      context.push('/home/profile/notifications'),
                ),
                const Divider(height: 1),

                // Security section
                _buildSectionHeader(context, 'Security'),
                _buildMenuItem(
                  context,
                  icon: Icons.lock_outline,
                  title: 'Security',
                  subtitle: 'PIN and biometric settings',
                  onTap: () =>
                      context.push('/home/profile/security'),
                ),
                const Divider(height: 1),

                // Support section
                _buildSectionHeader(context, 'Support'),
                _buildMenuItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  subtitle: 'FAQs and contact support',
                  onTap: () =>
                      context.push('/home/profile/help'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version and legal',
                  onTap: () =>
                      context.push('/home/profile/about'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () =>
                      context.push('/auth/terms-of-service'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  onTap: () =>
                      context.push('/auth/privacy-policy'),
                ),
                const Divider(height: 1),

                // Data & Privacy section
                _buildSectionHeader(context, 'Data & Privacy'),
                _buildMenuItem(
                  context,
                  icon: Icons.download_outlined,
                  title: 'Download My Data',
                  subtitle: 'Export your data (POPIA/GDPR)',
                  onTap: () => _exportUserData(context),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  onTap: () =>
                      _showDeleteAccountDialog(context),
                  isDestructive: true,
                ),
                const Divider(height: 1),

                // Sign Out
                _buildMenuItem(
                  context,
                  icon: Icons.logout,
                  title: 'Sign Out',
                  onTap: () => _showSignOutDialog(context),
                  isDestructive: true,
                ),
                AppSpacing.verticalXl,
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildStat(BuildContext context, String value, String label,
      {Color? valueColor}) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor ?? AppColors.primary,
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
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
          color:
              isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right,
          color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  // ---------------------------------------------------------------------------
  // Dialogs
  // ---------------------------------------------------------------------------

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
              context
                  .read<AuthBloc>()
                  .add(const AuthEvent.signOut());
            },
            style: TextButton.styleFrom(
                foregroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: authBloc,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.unauthenticated) {
              if (Navigator.of(dialogContext).canPop()) {
                Navigator.of(dialogContext).pop();
              }
            } else if (state.errorMessage != null &&
                !state.isLoading) {
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final isDeleting = state.isLoading;

            return AlertDialog(
              title: const Text('Delete Account'),
              content: isDeleting
                  ? const Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Expanded(
                          child:
                              Text('Deleting your account...'),
                        ),
                      ],
                    )
                  : const Text(
                      'Are you sure you want to delete your account? '
                      'This action cannot be undone. All your data including '
                      'tokens, transaction history, and referrals will be '
                      'permanently deleted.',
                    ),
              actions: isDeleting
                  ? []
                  : [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                              const AuthEvent.deleteAccount());
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.error),
                        child: const Text('Delete'),
                      ),
                    ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _exportUserData(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('exportUserData')
          .call();

      if (context.mounted) Navigator.of(context).pop();

      final data = result.data as Map<String, dynamic>;
      final jsonString =
          const JsonEncoder.withIndent('  ').convert(data);

      await SharePlus.instance.share(
          ShareParams(text: jsonString, subject: 'iMaliChat Data Export'));
    } on FirebaseFunctionsException catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                e.message ?? 'Export failed. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Something went wrong. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
