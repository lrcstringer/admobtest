import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/security/pin_manager.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/numeric_keyboard.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

/// PIN setup screen shown during onboarding for Tier 3 devices
/// (devices without biometric hardware and no screen lock configured).
///
/// Requires the user to create and confirm a 4-6 digit PIN.
/// This PIN is used for session unlock instead of biometrics.
class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final _pinManager = GetIt.instance<PinManager>();

  String _pin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  String? _errorMessage;
  bool _isSaving = false;

  void _onKeyPressed(String key) {
    setState(() {
      _errorMessage = null;
      if (_isConfirming) {
        if (_confirmPin.length < 6) {
          _confirmPin += key;
          if (_confirmPin.length >= 4) {
            _tryConfirm();
          }
        }
      } else {
        if (_pin.length < 6) {
          _pin += key;
        }
      }
    });
  }

  void _onBackspace() {
    setState(() {
      _errorMessage = null;
      if (_isConfirming) {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        }
      } else {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      }
    });
  }

  void _onContinue() {
    if (_pin.length < 4) {
      setState(() => _errorMessage = 'PIN must be at least 4 digits.');
      return;
    }

    setState(() {
      _isConfirming = true;
      _errorMessage = null;
    });
  }

  Future<void> _tryConfirm() async {
    if (_confirmPin != _pin) {
      setState(() {
        _errorMessage = 'PINs do not match. Please try again.';
        _confirmPin = '';
      });
      return;
    }

    setState(() => _isSaving = true);

    final success = await _pinManager.setPin(_pin);

    if (!mounted) return;

    if (success) {
      context.go('/onboarding/success');
    } else {
      setState(() {
        _isSaving = false;
        _isConfirming = false;
        _pin = '';
        _confirmPin = '';
        _errorMessage =
            'PIN is too weak. Avoid sequential or repeated digits.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentPin = _isConfirming ? _confirmPin : _pin;

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

              // Lock icon
              const Icon(
                Icons.lock_outline,
                size: 56,
                color: AppColors.primary,
              ),

              const SizedBox(height: 16),

              Text(
                _isConfirming ? 'Confirm Your PIN' : 'Create a PIN',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _isConfirming
                      ? 'Enter your PIN again to confirm.'
                      : 'Create a 4-6 digit PIN to secure your account.\nThis will be used to unlock the app.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
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
                      color: index < currentPin.length
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

              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],

              const Spacer(),

              // Numeric keyboard
              SizedBox(
                height: 220,
                child: NumericKeyboard(
                  onKeyPressed: _onKeyPressed,
                  onBackspace: _onBackspace,
                  keyHeight: 44,
                ),
              ),

              // Continue button (only in first entry phase)
              if (!_isConfirming)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48, vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _pin.length >= 4 ? _onContinue : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: const Color(0xFF0D1028),
                        disabledBackgroundColor:
                            AppColors.primary.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

              if (_isConfirming && _isSaving)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),

              const OnboardingProgressIndicator(currentStep: 7),

              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
