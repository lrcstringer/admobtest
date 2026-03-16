import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Settings'),
      body: ListView(
        children: [
          // Account section
          _buildSectionHeader(context, 'Account'),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () => context.push('/home/profile/edit'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            subtitle: 'Manage your phone number',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.verified_user_outlined,
            title: 'Verify Identity',
            subtitle: 'KYC verification for cashouts',
            onTap: () => context.push('/home/profile/kyc'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.download_outlined,
            title: 'Download My Data',
            subtitle: 'Export your data (POPIA/GDPR)',
            onTap: () => _exportUserData(context),
          ),
          const Divider(height: 1),

          // Preferences section
          _buildSectionHeader(context, 'Preferences'),
          _buildThemeSelector(context),
          _buildMenuItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () => context.push('/home/profile/notifications'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () {},
          ),
          const Divider(height: 1),

          // Security section
          _buildSectionHeader(context, 'Security'),
          _buildMenuItem(
            context,
            icon: Icons.lock_outline,
            title: 'Security',
            subtitle: 'PIN and biometrics',
            onTap: () => context.push('/home/profile/security'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
            onTap: () => context.push('/home/profile/privacy'),
          ),
          const Divider(height: 1),

          // Support section
          _buildSectionHeader(context, 'Support'),
          _buildMenuItem(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => context.push('/home/profile/help'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: 'About',
            onTap: () => context.push('/home/profile/about'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => context.push('/auth/terms-of-service'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            onTap: () => context.push('/auth/privacy-policy'),
          ),
          const Divider(height: 1),

          // Danger zone
          _buildSectionHeader(context, 'Danger Zone'),
          _buildMenuItem(
            context,
            icon: Icons.delete_outline,
            title: 'Delete Account',
            titleColor: AppColors.error,
            onTap: () => _showDeleteAccountDialog(context),
          ),

          AppSpacing.verticalXl,
        ],
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ListTile(
          leading: const Icon(Icons.palette_outlined),
          title: const Text('Appearance'),
          subtitle: SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(Icons.settings_suggest, size: 16),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.light_mode, size: 16),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.dark_mode, size: 16),
              ),
            ],
            selected: {state.themeMode},
            onSelectionChanged: (modes) {
              context
                  .read<ThemeBloc>()
                  .add(ThemeEvent.setThemeMode(modes.first));
            },
            showSelectedIcon: false,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        );
      },
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
    Color? titleColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: titleColor ?? AppColors.textPrimary),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  Future<void> _exportUserData(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await FirebaseFunctions.instanceFor(region: 'africa-south1')
          .httpsCallable('exportUserData')
          .call();

      // Dismiss loading
      if (context.mounted) Navigator.of(context).pop();

      final data = result.data as Map<String, dynamic>;
      final jsonString = const JsonEncoder.withIndent('  ').convert(data);

      await SharePlus.instance.share(
        ShareParams(text: jsonString, subject: 'iMaliChat Data Export'),
      );
    } on FirebaseFunctionsException catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Export failed. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
    // Capture the outer BLoC context before opening the dialog
    final authBloc = context.read<AuthBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: authBloc,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.unauthenticated) {
              // Account deleted — dialog will be dismissed by router redirect
              if (Navigator.of(dialogContext).canPop()) {
                Navigator.of(dialogContext).pop();
              }
            } else if (state.errorMessage != null && !state.isLoading) {
              // Deletion failed — close dialog and show error
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
                          child: Text('Deleting your account...'),
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
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(const AuthEvent.deleteAccount());
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
}
