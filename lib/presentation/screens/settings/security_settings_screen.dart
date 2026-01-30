import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../core/security/pin_manager.dart';
import '../../../core/security/step_up_auth_service.dart';
import '../../../domain/entities/trusted_device.dart';
import '../../../domain/repositories/device_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
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
  bool _isLoadingSettings = true;

  late final PinManager _pinManager;

  @override
  void initState() {
    super.initState();
    _pinManager = getIt<PinManager>();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final pinSet = await _pinManager.isPinSet();
    if (mounted) {
      setState(() {
        _pinEnabled = pinSet;
        _isLoadingSettings = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingSettings) {
      return Scaffold(
        appBar: AppBar(title: const Text('Security')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
            onChanged: (value) async {
              if (!await _performStepUp()) return;
              if (value) {
                _showSetPinDialog();
              } else {
                await _pinManager.clearPin();
                if (mounted) setState(() => _pinEnabled = false);
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
            onChanged: (value) async {
              if (!await _performStepUp()) return;
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
            onChanged: (value) async {
              if (!await _performStepUp()) return;
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
            onTap: _showActiveSessionsSheet,
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
    final pinController = TextEditingController();
    final confirmController = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('Set PIN'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter a 4-6 digit PIN to secure your account.'),
              AppSpacing.verticalMd,
              TextField(
                controller: pinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Enter PIN',
                  counterText: '',
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalSm,
              TextField(
                controller: confirmController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Confirm PIN',
                  counterText: '',
                ),
                textAlign: TextAlign.center,
              ),
              if (errorText != null) ...[
                AppSpacing.verticalSm,
                Text(
                  errorText!,
                  style: TextStyle(color: AppColors.error, fontSize: 13),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final pin = pinController.text;
                final confirm = confirmController.text;

                if (pin.length < 4) {
                  setDialogState(() => errorText = 'PIN must be at least 4 digits');
                  return;
                }
                if (pin != confirm) {
                  setDialogState(() => errorText = 'PINs do not match');
                  return;
                }

                final success = await _pinManager.setPin(pin);
                if (!success) {
                  setDialogState(() =>
                      errorText = 'PIN is too weak. Avoid sequential or repeated digits.');
                  return;
                }

                if (dialogContext.mounted) Navigator.pop(dialogContext);
                if (mounted) {
                  setState(() => _pinEnabled = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('PIN set successfully'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              },
              child: const Text('Set PIN'),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePinDialog() {
    final currentPinController = TextEditingController();
    final newPinController = TextEditingController();
    final confirmPinController = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('Change PIN'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Current PIN',
                  counterText: '',
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalSm,
              TextField(
                controller: newPinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'New PIN',
                  counterText: '',
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.verticalSm,
              TextField(
                controller: confirmPinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Confirm New PIN',
                  counterText: '',
                ),
                textAlign: TextAlign.center,
              ),
              if (errorText != null) ...[
                AppSpacing.verticalSm,
                Text(
                  errorText!,
                  style: TextStyle(color: AppColors.error, fontSize: 13),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentPin = currentPinController.text;
                final newPin = newPinController.text;
                final confirmPin = confirmPinController.text;

                if (newPin.length < 4) {
                  setDialogState(() => errorText = 'New PIN must be at least 4 digits');
                  return;
                }
                if (newPin != confirmPin) {
                  setDialogState(() => errorText = 'New PINs do not match');
                  return;
                }

                final success = await _pinManager.changePin(currentPin, newPin);
                if (!success) {
                  setDialogState(() =>
                      errorText = 'Current PIN is incorrect or new PIN is too weak');
                  return;
                }

                if (dialogContext.mounted) Navigator.pop(dialogContext);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('PIN changed successfully'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              },
              child: const Text('Change PIN'),
            ),
          ],
        ),
      ),
    );
  }

  void _showActiveSessionsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        expand: false,
        builder: (_, scrollController) => _ActiveSessionsSheet(
          scrollController: scrollController,
        ),
      ),
    );
  }

  Future<void> _showSignOutAllDialog() async {
    if (!await _performStepUp()) return;

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sign Out All Devices'),
        content: const Text(
          'This will sign you out from all devices. You will need to sign in again on each device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              // Revoke all devices then sign out
              try {
                final deviceRepo = getIt<DeviceRepository>();
                final result = await deviceRepo.getUserDevices();
                result.fold(
                  (_) {},
                  (devices) async {
                    for (final device in devices) {
                      await deviceRepo.revokeDevice(device.deviceId);
                    }
                  },
                );
              } catch (_) {}
              if (mounted) {
                context.read<AuthBloc>().add(const AuthEvent.signOut());
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Sign Out All'),
          ),
        ],
      ),
    );
  }

  Future<bool> _performStepUp() async {
    final stepUpService = getIt<StepUpAuthService>();
    final result = stepUpService.evaluateRequired(
      actionType: 'security_settings',
    );

    if (result == StepUpResult.biometricVerified) {
      final biometricResult = await stepUpService.performBiometricStepUp();
      if (biometricResult == StepUpResult.cancelled ||
          biometricResult == StepUpResult.failed) {
        return false;
      }
      if (biometricResult == StepUpResult.otpRequired) {
        final otpPassed = await _navigateToStepUpOtp();
        return otpPassed == true;
      }
      return true;
    } else if (result == StepUpResult.otpRequired) {
      final otpPassed = await _navigateToStepUpOtp();
      return otpPassed == true;
    }

    return true; // notRequired
  }

  Future<bool?> _navigateToStepUpOtp() {
    final phoneNumber =
        context.read<AuthBloc>().state.user?.phoneNumber ?? '';
    return context.push<bool>(
      '/auth/step-up-otp',
      extra: {
        'phoneNumber': phoneNumber,
        'reason': 'Security settings changes require identity verification.',
      },
    );
  }
}

/// Bottom sheet showing the user's active/trusted devices.
class _ActiveSessionsSheet extends StatefulWidget {
  final ScrollController scrollController;

  const _ActiveSessionsSheet({required this.scrollController});

  @override
  State<_ActiveSessionsSheet> createState() => _ActiveSessionsSheetState();
}

class _ActiveSessionsSheetState extends State<_ActiveSessionsSheet> {
  List<TrustedDevice>? _devices;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    try {
      final deviceRepo = getIt<DeviceRepository>();
      final result = await deviceRepo.getUserDevices();
      if (!mounted) return;
      result.fold(
        (failure) => setState(() {
          _error = failure.displayMessage;
          _isLoading = false;
        }),
        (devices) => setState(() {
          _devices = devices;
          _isLoading = false;
        }),
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load devices';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textHint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Sessions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            AppSpacing.verticalMd,
            Text(_error!, style: TextStyle(color: AppColors.textSecondary)),
            AppSpacing.verticalMd,
            TextButton(onPressed: _loadDevices, child: const Text('Retry')),
          ],
        ),
      );
    }
    if (_devices == null || _devices!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.devices_outlined, size: 48, color: AppColors.textHint),
            AppSpacing.verticalMd,
            Text(
              'No registered devices',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _devices!.length,
      itemBuilder: (context, index) {
        final device = _devices![index];
        return _buildDeviceTile(device);
      },
    );
  }

  Widget _buildDeviceTile(TrustedDevice device) {
    final isActive = device.isActive;
    final icon = device.platform == 'ios' ? Icons.phone_iphone : Icons.phone_android;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isActive
            ? AppColors.success.withValues(alpha: 0.2)
            : AppColors.textHint.withValues(alpha: 0.2),
        child: Icon(
          icon,
          color: isActive ? AppColors.success : AppColors.textHint,
        ),
      ),
      title: Text(device.deviceModel ?? device.platform),
      subtitle: Text(
        isActive ? 'Active' : (device.revoked ? 'Revoked' : 'Inactive'),
        style: TextStyle(
          color: isActive ? AppColors.success : AppColors.textSecondary,
        ),
      ),
      trailing: isActive
          ? PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'revoke') {
                  final deviceRepo = getIt<DeviceRepository>();
                  await deviceRepo.revokeDevice(device.deviceId);
                  _loadDevices();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'revoke',
                  child: Text('Revoke Trust'),
                ),
              ],
            )
          : null,
    );
  }
}
