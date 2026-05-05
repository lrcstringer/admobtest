import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/services/call_notification_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> with WidgetsBindingObserver {
  bool _pushEnabled = true;
  bool _emailEnabled = false;
  bool _transactionAlerts = true;
  bool _earnReminders = true;
  bool _potUpdates = true;
  bool _referralAlerts = true;
  bool _promotions = false;

  // null = loading, true/false = result
  bool? _canUseFullScreenIntent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkFullScreenIntent();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Re-check when returning from system settings.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _checkFullScreenIntent();
  }

  Future<void> _checkFullScreenIntent() async {
    if (!Platform.isAndroid) return;
    final granted = await CallNotificationService.canUseFullScreenIntent();
    if (mounted) setState(() => _canUseFullScreenIntent = granted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IMaliAppBar(title: 'Notifications'),
      body: ListView(
        children: [
          // General notifications
          _buildSectionHeader(context, 'General'),
          _buildSwitchTile(
            title: 'Push Notifications',
            subtitle: 'Receive notifications on your device',
            value: _pushEnabled,
            onChanged: (value) => setState(() => _pushEnabled = value),
          ),
          _buildSwitchTile(
            title: 'Email Notifications',
            subtitle: 'Receive notifications via email',
            value: _emailEnabled,
            onChanged: (value) => setState(() => _emailEnabled = value),
          ),
          const Divider(height: 1),

          // Transaction alerts
          _buildSectionHeader(context, 'Transactions'),
          _buildSwitchTile(
            title: 'Transaction Alerts',
            subtitle: 'Get notified for every transaction',
            value: _transactionAlerts,
            onChanged: (value) => setState(() => _transactionAlerts = value),
          ),
          const Divider(height: 1),

          // Activity notifications
          _buildSectionHeader(context, 'Activity'),
          _buildSwitchTile(
            title: 'Earn Reminders',
            subtitle: 'Reminders to watch ads and complete surveys',
            value: _earnReminders,
            onChanged: (value) => setState(() => _earnReminders = value),
          ),
          _buildSwitchTile(
            title: 'Pot Updates',
            subtitle: 'Updates on pot draws and winners',
            value: _potUpdates,
            onChanged: (value) => setState(() => _potUpdates = value),
          ),
          _buildSwitchTile(
            title: 'Referral Alerts',
            subtitle: 'When friends sign up using your code',
            value: _referralAlerts,
            onChanged: (value) => setState(() => _referralAlerts = value),
          ),
          const Divider(height: 1),

          // Marketing
          _buildSectionHeader(context, 'Marketing'),
          _buildSwitchTile(
            title: 'Promotions & Offers',
            subtitle: 'Special offers and promotional content',
            value: _promotions,
            onChanged: (value) => setState(() => _promotions = value),
          ),
          const Divider(height: 1),

          // Calls — Android 14+ only
          if (Platform.isAndroid && _canUseFullScreenIntent != null) ...[
            _buildSectionHeader(context, 'Calls'),
            _buildFullScreenIntentTile(context),
            const Divider(height: 1),
          ],

          AppSpacing.verticalXl,

          // Info text
          Padding(
            padding: AppSpacing.pagePadding,
            child: Text(
              'You can change your notification preferences at any time. Some notifications may still be sent for important account-related updates.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          AppSpacing.verticalXl,
        ],
      ),
    );
  }

  Widget _buildFullScreenIntentTile(BuildContext context) {
    final granted = _canUseFullScreenIntent ?? true;
    return ListTile(
      leading: Icon(
        granted ? Icons.call : Icons.call_outlined,
        color: granted ? AppColors.success : AppColors.warning,
      ),
      title: const Text('Lock screen call notifications'),
      subtitle: Text(
        granted
            ? 'Incoming calls appear on your lock screen'
            : 'Tap to allow incoming calls on your lock screen',
        style: TextStyle(
          color: granted ? AppColors.textSecondary : AppColors.warning,
          fontSize: 13,
        ),
      ),
      trailing: granted
          ? Icon(Icons.check_circle, color: AppColors.success, size: 20)
          : TextButton(
              onPressed: CallNotificationService.openFullScreenIntentSettings,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.warning,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: const Text('Allow'),
            ),
      onTap: granted
          ? null
          : CallNotificationService.openFullScreenIntentSettings,
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
}
