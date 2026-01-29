import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/numeric_keyboard.dart';
import '../../widgets/onboarding/onboarding_widgets.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String _otpDigits = '';
  String? _errorText;

  String get _otpCode => _otpDigits;

  bool get _isOtpComplete => _otpDigits.length == 4;

  void _onKeyPressed(String key) {
    if (_otpDigits.length < 4) {
      setState(() {
        _otpDigits += key;
        _errorText = null;
      });

      // Auto-verify when complete
      if (_isOtpComplete) {
        _onVerify();
      }
    }
  }

  void _onBackspace() {
    if (_otpDigits.isNotEmpty) {
      setState(() {
        _otpDigits = _otpDigits.substring(0, _otpDigits.length - 1);
        _errorText = null;
      });
    }
  }

  void _onVerify() {
    if (!_isOtpComplete) {
      setState(() => _errorText = 'Please enter the complete code');
      return;
    }

    // Pad to 6 digits if needed (some backends expect 6)
    final otp = _otpCode.padRight(6, '0');

    context.read<AuthBloc>().add(
          AuthEvent.verifyOtp(
            verificationId: widget.verificationId,
            otp: otp,
          ),
        );
  }

  void _onResend() {
    context.read<AuthBloc>().add(
          AuthEvent.resendOtp(phoneNumber: widget.phoneNumber),
        );
  }

  void _onChangeNumber() {
    context.go('/auth/phone');
  }

  String _formatPhoneNumber(String phone) {
    // Format: (+27) 81 234 5678
    if (phone.startsWith('+27') && phone.length >= 12) {
      final number = phone.substring(3);
      return '(+27) ${number.substring(0, 2)} ${number.substring(2, 5)} ${number.substring(5)}';
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go('/home');
        } else if (state.status == AuthStatus.onboardingRequired) {
          context.go('/onboarding/terms');
        } else if (state.status == AuthStatus.error) {
          setState(() => _errorText = state.errorMessage);
        }
      },
      builder: (context, state) {
        return OnboardingScaffold(
          currentPage: 1,
          totalPages: 5,
          child: Column(
            children: [
              // Top content area
              Expanded(
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    children: [
                      AppSpacing.verticalLg,
                      // Heading
                      Text(
                        'Verify your number',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimaryDark,
                                ),
                      ),
                      AppSpacing.verticalMd,
                      // Subtext with phone number
                      Text(
                        'We sent a code to your number',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      AppSpacing.verticalXs,
                      // Phone number with Change link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _formatPhoneNumber(widget.phoneNumber),
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textPrimaryDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          AppSpacing.horizontalSm,
                          GestureDetector(
                            onTap: _onChangeNumber,
                            child: Text(
                              'Change',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.verticalXxl,
                      // OTP display boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          final hasDigit = index < _otpDigits.length;
                          final isCurrent = index == _otpDigits.length;

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.inputFill,
                              borderRadius: AppSpacing.borderRadiusMd,
                              border: Border.all(
                                color: isCurrent
                                    ? AppColors.inputBorderFocused
                                    : AppColors.inputBorder,
                                width: isCurrent ? 2 : 1,
                              ),
                            ),
                            child: Center(
                              child: hasDigit
                                  ? Text(
                                      _otpDigits[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: AppColors.textPrimaryDark,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )
                                  : isCurrent
                                      ? Container(
                                          width: 2,
                                          height: 24,
                                          color: AppColors.inputBorderFocused,
                                        )
                                      : null,
                            ),
                          );
                        }),
                      ),
                      // Error text
                      if (_errorText != null) ...[
                        AppSpacing.verticalMd,
                        Text(
                          _errorText!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.error,
                              ),
                        ),
                      ],
                      AppSpacing.verticalXl,
                      // Resend code link
                      state.resendCountdown > 0
                          ? Text(
                              'Resend code in ${state.resendCountdown}s',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't receive your code? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                                GestureDetector(
                                  onTap: _onResend,
                                  child: Text(
                                    'Resend',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              // Continue button (above keyboard)
              Padding(
                padding: AppSpacing.pagePadding.copyWith(top: 0, bottom: 16),
                child: AppButton(
                  text: 'Continue',
                  isLoading: state.isLoading,
                  onPressed: _isOtpComplete ? _onVerify : null,
                ),
              ),
              // Custom numeric keyboard
              SafeArea(
                top: false,
                child: NumericKeyboard(
                  onKeyPressed: _onKeyPressed,
                  onBackspace: _onBackspace,
                ),
              ),
              AppSpacing.verticalSm,
            ],
          ),
        );
      },
    );
  }
}
