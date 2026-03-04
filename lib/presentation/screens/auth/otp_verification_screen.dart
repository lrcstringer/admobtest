import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/numeric_keyboard.dart';

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

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with CodeAutoFill {
  String _otpDigits = '';
  String? _errorText;

  String get _otpCode => _otpDigits;

  bool get _isOtpComplete => _otpDigits.length == 4;

  @override
  void initState() {
    super.initState();
    debugPrint('OTP_DEBUG: initState — calling listenForCode()');
    listenForCode();
    SmsAutoFill().getAppSignature.then((sig) => debugPrint('OTP_DEBUG: App Hash: $sig'));
    debugPrint('OTP_DEBUG: listenForCode() called');
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  @override
  void codeUpdated() {
    debugPrint('OTP_DEBUG: codeUpdated() fired — raw code: $code');
    if (code != null) {
      final digits = _extractOtp(code!);
      debugPrint('OTP_DEBUG: extracted digits: $digits');
      if (digits != null && digits.length == 4) {
        setState(() {
          _otpDigits = digits;
          _errorText = null;
        });
        _onVerify();
      }
    }
  }

  String? _extractOtp(String sms) {
    final match = RegExp(r'\b(\d{4})\b').firstMatch(sms);
    return match?.group(1);
  }

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

    context.read<AuthBloc>().add(
          AuthEvent.verifyOtp(
            verificationId: widget.verificationId,
            otp: _otpCode,
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
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.30;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          setState(() => _errorText = state.errorMessage);
        }
        // For authenticated and onboardingRequired: the GoRouterRefreshStream
        // triggers a redirect re-evaluation. The router redirect navigates to
        // /home (authenticated) or the correct onboarding step (onboardingRequired).
      },
      builder: (context, state) {
        final isLoading = state.isLoading;

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.backgroundGradient,
              ),
            ),
            child: Stack(
              children: [
                // Top feather wave background image
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: size.height * 0.25,
                    ),
                    child: Image.asset(
                      'assets/images/wave_feather_fixed_r7.png',
                      width: size.width,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),

                // Main content
                Positioned.fill(
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Scrollable content
                        Expanded(
                          child: SingleChildScrollView(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.01),

                                // Mascot
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

                                // "iMaliChat"
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'iMali',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              color: AppColors.gold,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      TextSpan(
                                        text: 'Chat',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              color: AppColors.textPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 2),

                                // "Earn. Chat. Buy."
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

                                // Heading
                                Text(
                                  'Verify your number',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                ),
                                const SizedBox(height: 12),

                                // Subtext
                                Text(
                                  'We sent a code to your number',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                                const SizedBox(height: 4),

                                // Phone number with Change link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _formatPhoneNumber(widget.phoneNumber),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
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
                                const SizedBox(height: 32),

                                // OTP display boxes
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(4, (index) {
                                    final hasDigit =
                                        index < _otpDigits.length;
                                    final isCurrent =
                                        index == _otpDigits.length;

                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius:
                                            BorderRadius.circular(12),
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
                                                      color: AppColors
                                                          .textPrimary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              )
                                            : isCurrent
                                                ? Container(
                                                    width: 2,
                                                    height: 24,
                                                    color: AppColors
                                                        .inputBorderFocused,
                                                  )
                                                : null,
                                      ),
                                    );
                                  }),
                                ),

                                // Error text
                                if (_errorText != null) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    _errorText!,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.error,
                                        ),
                                  ),
                                ],
                                const SizedBox(height: 24),

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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don't receive your code? ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color:
                                                      AppColors.textSecondary,
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
                                                    color:
                                                        AppColors.secondary,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),

                        // Continue button — only visible when OTP complete
                        if (_isOtpComplete || isLoading)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 48, vertical: 8),
                            child: AppButton(
                              text: 'Continue',
                              onPressed: _onVerify,
                              isLoading: isLoading,
                              loadingText: 'Verifying OTP ...',
                              size: AppButtonSize.large,
                            ),
                          )
                        else
                          const SizedBox(height: 60),

                        // Custom numeric keyboard
                        NumericKeyboard(
                          onKeyPressed: _onKeyPressed,
                          onBackspace: _onBackspace,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
