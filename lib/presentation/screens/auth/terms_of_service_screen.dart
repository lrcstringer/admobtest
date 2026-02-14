import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.30;

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

                    // Title
                    Text(
                      'Terms of Service',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: 16),

                    // Scrollable terms content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Welcome to iMaliChat. These Terms of Service govern '
                          'your use of the iMaliChat application and services.\n\n'
                          '1. Acceptance of Terms\n'
                          'By accessing or using iMaliChat, you agree to be bound '
                          'by these Terms of Service. If you do not agree to these '
                          'terms, please do not use the application.\n\n'
                          '2. Eligibility\n'
                          'You must be at least 18 years of age to use iMaliChat. '
                          'By using the application, you represent and warrant that '
                          'you meet this age requirement.\n\n'
                          '3. Account Registration\n'
                          'You are responsible for maintaining the confidentiality '
                          'of your account credentials and for all activities that '
                          'occur under your account.\n\n'
                          '4. Earning and Tokens\n'
                          'Tokens earned through the application are subject to the '
                          'rules and conditions specified within the app. iMaliChat '
                          'reserves the right to modify earning opportunities at any '
                          'time.\n\n'
                          '5. Prohibited Conduct\n'
                          'You agree not to engage in any fraudulent activity, '
                          'create multiple accounts, or attempt to manipulate the '
                          'earning system.\n\n'
                          '6. Termination\n'
                          'iMaliChat reserves the right to suspend or terminate '
                          'your account at any time for violation of these terms.\n\n'
                          '7. Changes to Terms\n'
                          'We may update these Terms of Service from time to time. '
                          'Continued use of the application constitutes acceptance '
                          'of any changes.\n\n'
                          'Last updated: January 2026',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),

                    // Back button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 32),
                      child: AppButton(
                        text: 'Back',
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/auth/age-consent');
                          }
                        },
                        size: AppButtonSize.large,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
