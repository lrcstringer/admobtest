import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Account section
          _buildSectionHeader(context, 'Account'),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () => context.push('/profile/edit'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            subtitle: 'Manage your phone number',
            onTap: () {},
          ),
          const Divider(height: 1),

          // Preferences section
          _buildSectionHeader(context, 'Preferences'),
          _buildMenuItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () => context.push('/profile/notifications'),
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
            onTap: () => context.push('/profile/security'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
            onTap: () {},
          ),
          const Divider(height: 1),

          // Support section
          _buildSectionHeader(context, 'Support'),
          _buildMenuItem(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => context.push('/profile/help'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: 'About',
            onTap: () => context.push('/profile/about'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            onTap: () {},
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

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone. All your data including tokens, transaction history, and referrals will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement delete account
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
