import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/security/device_capability_service.dart';
import '../../../core/security/session_lock_service.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/numeric_keyboard.dart';

/// Full-screen session lock overlay.
///
/// Adapts UI based on the detected capability tier:
/// - Tier 1/2: "Tap to unlock" → triggers local_auth prompt
/// - Tier 3: PIN entry with NumericKeyboard
/// - Tier 4: "Session expired" → navigates to OTP flow
class SessionLockScreen extends StatefulWidget {
  const SessionLockScreen({super.key});

  @override
  State<SessionLockScreen> createState() => _SessionLockScreenState();
}

class _SessionLockScreenState extends State<SessionLockScreen> {
  final _sessionLockService = GetIt.instance<SessionLockService>();

  AuthCapabilityTier? _tier;
  String _pinEntry = '';
  int _remainingAttempts = 5;
  String? _errorMessage;
  bool _isUnlocking = false;

  @override
  void initState() {
    super.initState();
    _detectTierAndUnlock();
  }

  Future<void> _detectTierAndUnlock() async {
    final tier = await _sessionLockService.getCapabilityTier();
    setState(() => _tier = tier);

    // Auto-trigger for Tier 1/2
    if (tier == AuthCapabilityTier.biometric ||
        tier == AuthCapabilityTier.deviceCredential) {
      _attemptBiometricUnlock();
    } else if (tier == AuthCapabilityTier.otpOnly) {
      // Tier 4 — go directly to OTP
      _navigateToOtp();
    }

    // Tier 3 — wait for PIN entry
    if (tier == AuthCapabilityTier.inAppPin) {
      final remaining = await _sessionLockService.getRemainingPinAttempts();
      setState(() => _remainingAttempts = remaining);
    }
  }

  Future<void> _attemptBiometricUnlock() async {
    if (_isUnlocking) return;
    setState(() {
      _isUnlocking = true;
      _errorMessage = null;
    });

    final result = await _sessionLockService.attemptUnlock();

    if (!mounted) return;

    switch (result) {
      case UnlockResult.success:
        _sessionLockService.markUnlocked();
        context.read<AuthBloc>().add(const AuthEvent.unlockSession());
      case UnlockResult.cancelled:
        setState(() => _isUnlocking = false);
      case UnlockResult.failed:
        setState(() {
          _isUnlocking = false;
          _errorMessage = 'Unlock failed. Try again.';
        });
      case UnlockResult.requiresFullReauth:
        _navigateToOtp();
    }
  }

  Future<void> _attemptPinUnlock() async {
    if (_pinEntry.length < 4 || _isUnlocking) return;
    setState(() {
      _isUnlocking = true;
      _errorMessage = null;
    });

    final result = await _sessionLockService.attemptUnlock(pin: _pinEntry);

    if (!mounted) return;

    switch (result) {
      case UnlockResult.success:
        _sessionLockService.markUnlocked();
        context.read<AuthBloc>().add(const AuthEvent.unlockSession());
      case UnlockResult.failed:
        final remaining = await _sessionLockService.getRemainingPinAttempts();
        setState(() {
          _isUnlocking = false;
          _pinEntry = '';
          _remainingAttempts = remaining;
          _errorMessage = 'Incorrect PIN. $_remainingAttempts attempts remaining.';
        });
      case UnlockResult.requiresFullReauth:
        _navigateToOtp();
      case UnlockResult.cancelled:
        setState(() {
          _isUnlocking = false;
          _pinEntry = '';
        });
    }
  }

  void _navigateToOtp() {
    if (mounted) {
      context.read<AuthBloc>().add(const AuthEvent.forceReauth());
    }
  }

  void _signOut() {
    context.read<AuthBloc>().add(const AuthEvent.signOut());
  }

  void _onKeyPressed(String key) {
    if (_pinEntry.length < 6) {
      setState(() => _pinEntry = _pinEntry + key);

      // Auto-submit when PIN reaches expected length
      if (_pinEntry.length >= 4) {
        _attemptPinUnlock();
      }
    }
  }

  void _onBackspace() {
    if (_pinEntry.isNotEmpty) {
      setState(() => _pinEntry = _pinEntry.substring(0, _pinEntry.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const Spacer(flex: 2),

              // Logo
              Image.asset(
                'assets/icons/ImaliFacewithText.png',
                width: 80,
                height: 80,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Session Locked',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              _buildTierContent(),

              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],

              const Spacer(flex: 3),

              // Sign Out option
              TextButton(
                onPressed: _signOut,
                child: Text(
                  'Sign Out',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTierContent() {
    if (_tier == null) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    switch (_tier!) {
      case AuthCapabilityTier.biometric:
      case AuthCapabilityTier.deviceCredential:
        return _buildBiometricContent();
      case AuthCapabilityTier.inAppPin:
        return _buildPinContent();
      case AuthCapabilityTier.otpOnly:
        return _buildOtpOnlyContent();
    }
  }

  Widget _buildBiometricContent() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          'Tap to unlock with biometrics',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 32),
        _isUnlocking
            ? const CircularProgressIndicator(color: AppColors.primary)
            : IconButton(
                onPressed: _attemptBiometricUnlock,
                iconSize: 64,
                icon: const Icon(
                  Icons.fingerprint,
                  color: AppColors.primary,
                ),
              ),
      ],
    );
  }

  Widget _buildPinContent() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          'Enter your PIN to unlock',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 24),

        // PIN dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index < _pinEntry.length
                    ? AppColors.primary
                    : AppColors.surface,
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Numeric keyboard
        SizedBox(
          height: 280,
          child: NumericKeyboard(
            onKeyPressed: _onKeyPressed,
            onBackspace: _onBackspace,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpOnlyContent() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Your session has expired. Please verify your identity.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Verify Identity',
          onPressed: _navigateToOtp,
          isFullWidth: false,
        ),
      ],
    );
  }
}
