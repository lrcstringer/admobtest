import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/fcm_challenge_handler.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/numeric_keyboard.dart';
import '../../widgets/onboarding/onboarding_widgets.dart';

class PhoneInputScreen extends StatefulWidget {
  final bool skipPushLogin;

  const PhoneInputScreen({super.key, this.skipPushLogin = false});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final _challengeHandler = GetIt.instance<FcmChallengeHandler>();

  String _phoneDigits = '';
  String? _errorText;
  bool _isPushLoginLoading = false;
  late final bool _skipPushLogin = widget.skipPushLogin;

  String _getFullPhoneNumber() {
    return '+27$_phoneDigits';
  }

  bool _isValidPhoneNumber() {
    return _phoneDigits.length >= 9;
  }

  Future<void> _onSubmit() async {
    if (!_isValidPhoneNumber()) {
      setState(() {
        _errorText = 'Please enter a valid phone number';
      });
      return;
    }

    setState(() => _errorText = null);

    final phoneNumber = _getFullPhoneNumber();

    // Try push login first (unless skipped)
    if (!_skipPushLogin) {
      setState(() => _isPushLoginLoading = true);

      final result = await _challengeHandler.requestLogin(phoneNumber);

      if (!mounted) return;

      if (result.hasTrustedDevice && result.challengeId != null) {
        setState(() => _isPushLoginLoading = false);
        // Navigate to push login waiting screen
        context.go('/auth/push-login', extra: {
          'challengeId': result.challengeId,
          'phoneNumber': phoneNumber,
        });
        return;
      }

      setState(() => _isPushLoginLoading = false);
    }

    // Fall back to OTP
    if (!mounted) return;
    context.read<AuthBloc>().add(
          AuthEvent.sendOtp(phoneNumber: phoneNumber),
        );
  }

  void _onKeyPressed(String key) {
    if (_phoneDigits.length < 9) {
      setState(() {
        _phoneDigits += key;
        _errorText = null;
      });
    }
  }

  void _onBackspace() {
    if (_phoneDigits.isNotEmpty) {
      setState(() {
        _phoneDigits = _phoneDigits.substring(0, _phoneDigits.length - 1);
        _errorText = null;
      });
    }
  }

  String _formatPhoneNumber(String digits) {
    // Format: XX XXX XXXX
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 5) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          context.go('/auth/otp', extra: {
            'verificationId': state.verificationId,
            'phoneNumber': _getFullPhoneNumber(),
          });
        } else if (state.status == AuthStatus.error) {
          setState(() => _errorText = state.errorMessage);
        }
      },
      builder: (context, state) {
        return OnboardingScaffold(
          currentPage: 0,
          totalPages: 5,
          child: Column(
            children: [
              // Top content area
              Expanded(
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Heading
                      Text(
                        'What is your mobile\nnumber?',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimaryDark,
                                ),
                      ),
                      AppSpacing.verticalLg,
                      // Phone input field (read-only, displays formatted number)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.inputFill,
                          borderRadius: AppSpacing.borderRadiusLg,
                          border: Border.all(
                            color: _phoneDigits.isNotEmpty
                                ? AppColors.inputBorderFocused
                                : AppColors.inputBorder,
                            width: _phoneDigits.isNotEmpty ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Phone icon
                            Icon(
                              Icons.phone_outlined,
                              color: AppColors.textSecondary,
                              size: 24,
                            ),
                            AppSpacing.horizontalMd,
                            // Country code prefix
                            Text(
                              '+27',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.textPrimaryDark,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            AppSpacing.horizontalSm,
                            // Phone number display
                            Expanded(
                              child: Text(
                                _phoneDigits.isEmpty
                                    ? '81 234 5678'
                                    : _formatPhoneNumber(_phoneDigits),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: _phoneDigits.isEmpty
                                          ? AppColors.textHint
                                          : AppColors.textPrimaryDark,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Error text
                      if (_errorText != null) ...[
                        AppSpacing.verticalSm,
                        Text(
                          _errorText!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.error,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Continue button (above keyboard)
              Padding(
                padding: AppSpacing.pagePadding.copyWith(top: 0, bottom: 12),
                child: AppButton(
                  text: 'Continue',
                  isLoading: state.isLoading || _isPushLoginLoading,
                  onPressed: _isValidPhoneNumber() ? _onSubmit : null,
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
            ],
          ),
        );
      },
    );
  }
}
