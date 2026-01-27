import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricEnabled = false;
  bool _pinEnabled = false;
  bool _requirePinForTransactions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: ListView(
        children: [
          // PIN section
          _buildSectionHeader(context, 'PIN'),
          _buildSwitchTile(
            title: 'Enable PIN',
            subtitle: 'Require PIN to open the app',
            value: _pinEnabled,
            onChanged: (value) {
              if (value) {
                _showSetPinDialog();
              } else {
                setState(() => _pinEnabled = false);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Change PIN'),
            enabled: _pinEnabled,
            onTap: _pinEnabled ? _showChangePinDialog : null,
          ),
          const Divider(height: 1),

          // Biometrics section
          _buildSectionHeader(context, 'Biometrics'),
          _buildSwitchTile(
            title: 'Fingerprint / Face ID',
            subtitle: 'Use biometrics to unlock the app',
            value: _biometricEnabled,
            onChanged: (value) {
              setState(() => _biometricEnabled = value);
            },
          ),
          const Divider(height: 1),

          // Transaction security
          _buildSectionHeader(context, 'Transactions'),
          _buildSwitchTile(
            title: 'Require PIN for Transactions',
            subtitle: 'Confirm transactions with your PIN',
            value: _requirePinForTransactions,
            onChanged: (value) {
              setState(() => _requirePinForTransactions = value);
            },
          ),
          const Divider(height: 1),

          // Session
          _buildSectionHeader(context, 'Session'),
          ListTile(
            leading: const Icon(Icons.devices_outlined),
            title: const Text('Active Sessions'),
            subtitle: const Text('Manage your logged-in devices'),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.error),
            title: Text(
              'Sign Out All Devices',
              style: TextStyle(color: AppColors.error),
            ),
            onTap: _showSignOutAllDialog,
          ),

          AppSpacing.verticalXl,

          // Security tips
          Container(
            margin: AppSpacing.pagePadding,
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.shield_outlined, color: AppColors.info, size: 20),
                    AppSpacing.horizontalSm,
                    Text(
                      'Security Tips',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                AppSpacing.verticalSm,
                Text(
                  '• Never share your PIN with anyone\n'
                  '• Use a unique PIN that\'s hard to guess\n'
                  '• Enable biometrics for faster, secure access',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
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

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return null;
      }),
    );
  }

  void _showSetPinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a 4-digit PIN to secure your account.'),
            AppSpacing.verticalMd,
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Enter PIN',
                counterText: '',
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalSm,
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm PIN',
                counterText: '',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _pinEnabled = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PIN set successfully')),
              );
            },
            child: const Text('Set PIN'),
          ),
        ],
      ),
    );
  }

  void _showChangePinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current PIN',
                counterText: '',
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalSm,
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New PIN',
                counterText: '',
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalSm,
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New PIN',
                counterText: '',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PIN changed successfully')),
              );
            },
            child: const Text('Change PIN'),
          ),
        ],
      ),
    );
  }

  void _showSignOutAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out All Devices'),
        content: const Text(
          'This will sign you out from all devices. You will need to sign in again on each device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement sign out all devices
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Sign Out All'),
          ),
        ],
      ),
    );
  }
}
