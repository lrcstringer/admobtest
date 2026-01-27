import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final _phoneController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String _getFullPhoneNumber() {
    final digits = _phoneController.text.replaceAll(' ', '');
    return '+27$digits';
  }

  bool _isValidPhoneNumber() {
    final digits = _phoneController.text.replaceAll(' ', '');
    return digits.length >= 9;
  }

  void _onSubmit() {
    if (!_isValidPhoneNumber()) {
      setState(() {
        _errorText = 'Please enter a valid phone number';
      });
      return;
    }

    setState(() => _errorText = null);

    context.read<AuthBloc>().add(
          AuthEvent.sendOtp(phoneNumber: _getFullPhoneNumber()),
        );
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
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/welcome'),
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
                    'Enter your phone\nnumber',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'We\'ll send you a verification code to confirm your number.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  AppSpacing.verticalXxl,
                  AppPhoneTextField(
                    controller: _phoneController,
                    errorText: _errorText,
                    autofocus: true,
                    onChanged: (_) {
                      if (_errorText != null) {
                        setState(() => _errorText = null);
                      }
                    },
                    onSubmitted: (_) => _onSubmit(),
                  ),
                  AppSpacing.verticalMd,
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      AppSpacing.horizontalXs,
                      Expanded(
                        child: Text(
                          'Your phone number is protected and will only be used to verify your identity.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppButton(
                    text: 'Continue',
                    isLoading: state.isLoading,
                    onPressed: _isValidPhoneNumber() ? _onSubmit : null,
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
