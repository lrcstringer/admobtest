import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _acceptedTerms = false;
  bool _acceptedPrivacy = false;

  bool get _canContinue => _acceptedTerms && _acceptedPrivacy;

  void _onContinue() {
    context.read<AuthBloc>().add(const AuthEvent.acceptTerms());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.user?.hasAcceptedTerms == true) {
          if (state.user?.hasCompletedOnboarding == true) {
            context.go('/home');
          } else {
            context.go('/onboarding/profile');
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.verticalXl,
                Text(
                  'Terms & Conditions',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                AppSpacing.verticalSm,
                Text(
                  'Please review and accept our terms to continue.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                AppSpacing.verticalXl,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection(
                          context,
                          'Terms of Service',
                          '''By using iMali, you agree to:

1. Be at least 18 years old or have parental consent
2. Provide accurate information when creating your account
3. Not engage in fraudulent activities
4. Complete earning activities honestly
5. Not share your account credentials

iMali reserves the right to suspend accounts that violate these terms.''',
                        ),
                        AppSpacing.verticalLg,
                        _buildSection(
                          context,
                          'Privacy Policy',
                          '''We collect and process your data to:

1. Verify your identity
2. Process your earnings and cashouts
3. Show you relevant earning opportunities
4. Prevent fraud and abuse
5. Improve our services

Your data is protected and never sold to third parties. You can request deletion of your data at any time.''',
                        ),
                        AppSpacing.verticalLg,
                        _buildSection(
                          context,
                          'Earnings & Cashout',
                          '''Important information about your tokens:

• 1 token = R0.01 ZAR
• Minimum cashout: 5,000 tokens (R50)
• Cashout waiting period: 7 days from signup
• Daily earning limits may apply
• Tokens expire after 12 months of inactivity''',
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.verticalLg,
                _buildCheckbox(
                  'I accept the Terms of Service',
                  _acceptedTerms,
                  (value) => setState(() => _acceptedTerms = value ?? false),
                ),
                AppSpacing.verticalSm,
                _buildCheckbox(
                  'I accept the Privacy Policy',
                  _acceptedPrivacy,
                  (value) => setState(() => _acceptedPrivacy = value ?? false),
                ),
                AppSpacing.verticalLg,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppButton(
                      text: 'Accept & Continue',
                      isLoading: state.isLoading,
                      onPressed: _canContinue ? _onContinue : null,
                    );
                  },
                ),
                AppSpacing.verticalMd,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          AppSpacing.verticalSm,
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: AppSpacing.borderRadiusSm,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
