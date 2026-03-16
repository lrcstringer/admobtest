import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/numeric_keyboard.dart';

/// Step-up OTP verification screen for high-risk operations.
///
/// Calls the sendOtp / verifyOtp Cloud Functions directly so the global
/// AuthBloc state is never mutated. This prevents the router from
/// redirecting away while the user is verifying their identity.
class StepUpOtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String reason;

  const StepUpOtpScreen({
    super.key,
    required this.phoneNumber,
    this.reason = 'This action requires identity verification.',
  });

  @override
  State<StepUpOtpScreen> createState() => _StepUpOtpScreenState();
}

class _StepUpOtpScreenState extends State<StepUpOtpScreen>
    with CodeAutoFill {
  String _otpCode = '';
  String? _errorMessage;
  bool _isLoading = false;
  bool _otpSent = false;
  int _resendCountdown = 0;
  Timer? _countdownTimer;

  late final FirebaseFunctions _functions;

  @override
  void initState() {
    super.initState();
    _functions = GetIt.instance<FirebaseFunctions>();
    listenForCode();
    _sendOtp();
  }

  @override
  void dispose() {
    cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  void codeUpdated() {
    if (code != null && _otpSent) {
      final digits = _extractOtp(code!);
      if (digits != null && digits.length == 4) {
        setState(() {
          _otpCode = digits;
          _errorMessage = null;
        });
        _verifyOtp();
      }
    }
  }

  String? _extractOtp(String sms) {
    final match = RegExp(r'\b(\d{4})\b').firstMatch(sms);
    return match?.group(1);
  }

  Future<void> _sendOtp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final callable = _functions.httpsCallable('sendOtp');
      final result = await callable.call<Map<String, dynamic>>({
        'phoneNumber': widget.phoneNumber,
      });

      final data = result.data;
      debugPrint('StepUpOtp: sendOtp response: $data');

      if (data['success'] != true) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _errorMessage =
              data['message'] as String? ?? 'Failed to send code';
        });
        return;
      }

      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _otpSent = true;
      });
      _startResendCountdown();
    } catch (e) {
      debugPrint('StepUpOtp: sendOtp error: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to send verification code. Please try again.';
      });
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpCode.length < 4) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final callable = _functions.httpsCallable('verifyOtp');
      final result = await callable.call<Map<String, dynamic>>({
        'phoneNumber': widget.phoneNumber,
        'code': _otpCode,
      });

      final data = result.data;
      if (data['success'] != true) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _errorMessage =
              data['message'] as String? ?? 'Verification failed';
          _otpCode = '';
        });
        return;
      }

      // OTP verified — we do NOT sign in again (user is already authenticated).
      // Just pop with true to indicate step-up succeeded.
      if (!mounted) return;
      context.pop(true);
    } catch (e) {
      debugPrint('StepUpOtp: verifyOtp error: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Verification failed. Please try again.';
        _otpCode = '';
      });
    }
  }

  void _onKeyPressed(String key) {
    if (_otpCode.length < 4) {
      setState(() {
        _otpCode += key;
        _errorMessage = null;
      });

      if (_otpCode.length == 4) {
        _verifyOtp();
      }
    }
  }

  void _onBackspace() {
    if (_otpCode.isNotEmpty) {
      setState(() {
        _otpCode = _otpCode.substring(0, _otpCode.length - 1);
        _errorMessage = null;
      });
    }
  }

  void _startResendCountdown() {
    _countdownTimer?.cancel();
    setState(() => _resendCountdown = 60);

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  void _onCancel() {
    context.pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.themed(context).tabGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Shield icon
              const Icon(
                Icons.verified_user_outlined,
                size: 64,
                color: AppColors.primary,
              ),

              const SizedBox(height: 20),

              Text(
                'Verify Your Identity',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  widget.reason,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),

              const SizedBox(height: 8),

              if (_otpSent)
                Text(
                  'Code sent to ${_maskPhoneNumber(widget.phoneNumber)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),

              const SizedBox(height: 24),

              // OTP dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index < _otpCode.length
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

              if (_isLoading && !_otpSent)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),

              const SizedBox(height: 16),

              // Resend button
              if (_otpSent)
                TextButton(
                  onPressed: _resendCountdown > 0 ? null : _sendOtp,
                  child: Text(
                    _resendCountdown > 0
                        ? 'Resend in ${_resendCountdown}s'
                        : 'Resend Code',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _resendCountdown > 0
                              ? AppColors.textSecondary
                              : AppColors.primary,
                        ),
                  ),
                ),

              const Spacer(flex: 1),

              // Numeric keyboard
              if (_otpSent)
                SizedBox(
                  height: 280,
                  child: NumericKeyboard(
                    onKeyPressed: _onKeyPressed,
                    onBackspace: _onBackspace,
                  ),
                ),

              // Cancel button
              TextButton(
                onPressed: _onCancel,
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _maskPhoneNumber(String phone) {
    if (phone.length < 6) return phone;
    return '${phone.substring(0, 4)}****${phone.substring(phone.length - 2)}';
  }
}
