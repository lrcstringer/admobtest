import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/security/device_capability_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingSettingsScreen extends StatefulWidget {
  const OnboardingSettingsScreen({super.key});

  @override
  State<OnboardingSettingsScreen> createState() =>
      _OnboardingSettingsScreenState();
}

class _OnboardingSettingsScreenState extends State<OnboardingSettingsScreen> {
  final _capabilityService = GetIt.instance<DeviceCapabilityService>();

  bool _allowAccess = false;
  bool _runInBackground = false;
  bool _notifications = false;

  Future<void> _onContinue() async {
    final tier = await _capabilityService.detectCapabilityTier();
    if (!mounted) return;

    if (tier == AuthCapabilityTier.inAppPin) {
      // Tier 3: force PIN setup before completing onboarding
      context.go('/onboarding/pin-setup');
    } else {
      context.go('/onboarding/success');
    }
  }

  Future<void> _onToggleAllowAccess(bool val) async {
    if (val) {
      final granted = await FlutterContacts.requestPermission(readonly: true);
      if (mounted) setState(() => _allowAccess = granted);
    } else {
      setState(() => _allowAccess = false);
    }
  }

  Future<void> _onToggleNotifications(bool val) async {
    if (val) {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      final granted = settings.authorizationStatus ==
          AuthorizationStatus.authorized;
      if (mounted) setState(() => _notifications = granted);
    } else {
      setState(() => _notifications = false);
    }
  }

  void _onToggleRunInBackground(bool val) {
    // Background execution doesn't require a runtime permission on most devices.
    // On Android, battery optimization exemptions require user action in system settings.
    // We just record the preference here.
    setState(() => _runInBackground = val);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final avatarSize = size.width * 0.22;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),

              // Profile picture
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.asset(
                    'assets/images/Gear Settings.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.person,
                          color: AppColors.textPrimary,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // "Settings"
              Text(
                'Settings',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              SizedBox(height: size.height * 0.03),

              // Settings toggles
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      // Allow Access
                      _SettingsTile(
                        title: 'Allow Access',
                        description:
                            'To help us give you a great Chat experience, please allow iMaliChat to access your contacts and media on your phone.',
                        value: _allowAccess,
                        onChanged: _onToggleAllowAccess,
                      ),

                      const SizedBox(height: 24),

                      // Run in the Background
                      _SettingsTile(
                        title: 'Run in the Background',
                        description:
                            'iMaliChat will run in the background on your phone with unconstricted battery usage.',
                        value: _runInBackground,
                        onChanged: _onToggleRunInBackground,
                      ),

                      const SizedBox(height: 24),

                      // Notifications
                      _SettingsTile(
                        title: 'Notifications',
                        description:
                            'This will allow us to update you when you have new earning offers.',
                        value: _notifications,
                        onChanged: _onToggleNotifications,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: const Color(0xFF0D1028),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              const OnboardingProgressIndicator(currentStep: 6),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsTile({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: AppColors.primary,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: AppColors.textSecondary,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
