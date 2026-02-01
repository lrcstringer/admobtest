import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _allowAccess = true;
  bool _runInBackground = true;
  bool _notifications = true;
  bool _isLoading = false;

  Future<void> _onContinue() async {
    setState(() => _isLoading = true);

    try {
      // Request contacts permission if toggle is on
      if (_allowAccess) {
        await FlutterContacts.requestPermission(readonly: true);
      }

      // Request notification permission if toggle is on.
      // This is critical: without notification permission, the FCM token
      // is unavailable on iOS, which means device binding will fail and
      // the user will be stuck on OTP-only login permanently.
      if (_notifications) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    } catch (e) {
      debugPrint('Permission request failed (non-blocking): $e');
    }

    if (!mounted) return;

    // Retry device binding now that notification permission has been granted.
    // The initial bindDevice() call (fired after OTP verification) may have
    // failed because the FCM token was unavailable at that point.
    final authBloc = context.read<AuthBloc>();
    if (!authBloc.state.isDeviceBound) {
      authBloc.add(const AuthEvent.bindDevice());
    }

    context.go('/onboarding/success');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.25;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: Stack(
          children: [
            // Top Light Blue background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Top Light Blue.png',
                width: size.width,
                fit: BoxFit.fitWidth,
              ),
            ),

            // Main content
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    // Compact header: mascot + iMaliChat + tagline
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: mascotSize,
                      height: mascotSize,
                      child: Image.asset(
                        'assets/icons/iMaliCrown4.png',
                        width: mascotSize,
                        height: mascotSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/icons/ImaliFacewithText.png',
                            width: mascotSize,
                            height: mascotSize,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'iMaliChat',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Earn. Chat. Buy.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    // "Settings"
                    Text(
                      'Settings',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: 24),

                    // Permission toggles (scrollable for small screens)
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            _buildPermissionToggle(
                              title: 'Allow Access',
                              description:
                                  'To help us give you a great Chat experience, please allow iMali to access your contacts and media on your phone.',
                              value: _allowAccess,
                              onChanged: (value) =>
                                  setState(() => _allowAccess = value),
                            ),
                            const SizedBox(height: 20),
                            _buildPermissionToggle(
                              title: 'Run in the Background',
                              description:
                                  'iMali will operate in the background on your phone with unconstricted battery usage.',
                              value: _runInBackground,
                              onChanged: (value) =>
                                  setState(() => _runInBackground = value),
                            ),
                            const SizedBox(height: 20),
                            _buildPermissionToggle(
                              title: 'Notifications',
                              description:
                                  'Required for earning offers, login approvals on new devices, and security alerts. Without this, you will need to enter an OTP every time you sign in.',
                              value: _notifications,
                              onChanged: (value) =>
                                  setState(() => _notifications = value),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Continue button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _onContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                AppColors.primary.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ),

                    const OnboardingProgressIndicator(currentStep: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionToggle({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: AppColors.switchActive,
          inactiveThumbColor: AppColors.switchInactive,
          inactiveTrackColor: AppColors.switchTrackInactive,
        ),
      ],
    );
  }
}
