import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

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
  final _otpController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerify() {
    if (_otpController.text.length != 6) {
      setState(() => _errorText = 'Please enter the complete code');
      return;
    }

    context.read<AuthBloc>().add(
          AuthEvent.verifyOtp(
            verificationId: widget.verificationId,
            otp: _otpController.text,
          ),
        );
  }

  void _onResend() {
    context.read<AuthBloc>().add(
          AuthEvent.resendOtp(phoneNumber: widget.phoneNumber),
        );
  }

  String _formatPhoneNumber(String phone) {
    // Format: +27 81 234 5678
    if (phone.startsWith('+27') && phone.length >= 12) {
      final number = phone.substring(3);
      return '+27 ${number.substring(0, 2)} ${number.substring(2, 5)} ${number.substring(5)}';
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
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/auth/phone'),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.verticalLg,
                  Text(
                    'Enter verification\ncode',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'We sent a 6-digit code to',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  Text(
                    _formatPhoneNumber(widget.phoneNumber),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  AppSpacing.verticalXxl,
                  PinCodeTextField(
                    appContext: context,
                    controller: _otpController,
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: AppSpacing.borderRadiusMd,
                      fieldHeight: 56,
                      fieldWidth: 48,
                      activeFillColor: AppColors.surface,
                      inactiveFillColor: AppColors.surface,
                      selectedFillColor: AppColors.surface,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.border,
                      selectedColor: AppColors.primary,
                    ),
                    enableActiveFill: true,
                    onChanged: (value) {
                      if (_errorText != null) {
                        setState(() => _errorText = null);
                      }
                    },
                    onCompleted: (_) => _onVerify(),
                  ),
                  if (_errorText != null) ...[
                    AppSpacing.verticalSm,
                    Text(
                      _errorText!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.error,
                          ),
                    ),
                  ],
                  AppSpacing.verticalLg,
                  Center(
                    child: state.resendCountdown > 0
                        ? Text(
                            'Resend code in ${state.resendCountdown}s',
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          )
                        : AppButton(
                            text: 'Resend Code',
                            variant: AppButtonVariant.text,
                            isFullWidth: false,
                            onPressed: _onResend,
                          ),
                  ),
                  const Spacer(),
                  AppButton(
                    text: 'Verify',
                    isLoading: state.isLoading,
                    onPressed:
                        _otpController.text.length == 6 ? _onVerify : null,
                  ),
                  AppSpacing.verticalLg,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
