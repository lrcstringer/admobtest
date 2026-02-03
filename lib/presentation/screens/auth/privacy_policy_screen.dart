import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.25;

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
                      'Privacy Policy',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: 16),

                    // Scrollable privacy content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'iMaliChat is committed to protecting your privacy. '
                          'This Privacy Policy explains how we collect, use, and '
                          'safeguard your personal information.\n\n'
                          '1. Information We Collect\n'
                          'We collect information you provide directly, including '
                          'your phone number, name, date of birth, gender '
                          '(optional), and profile picture. We also collect usage '
                          'data to improve our services.\n\n'
                          '2. How We Use Your Information\n'
                          'We use your information to provide and improve our '
                          'services, personalise your experience, process earnings '
                          'and transactions, and communicate with you about offers '
                          'and updates.\n\n'
                          '3. Information Sharing\n'
                          'We do not sell your personal information. We may share '
                          'information with service providers who assist in '
                          'operating the application, or when required by law.\n\n'
                          '4. Data Security\n'
                          'We implement appropriate security measures to protect '
                          'your personal information against unauthorised access, '
                          'alteration, or destruction.\n\n'
                          '5. Data Retention\n'
                          'We retain your information for as long as your account '
                          'is active or as needed to provide services. You may '
                          'request deletion of your account and associated data.\n\n'
                          '6. Your Rights\n'
                          'In accordance with the Protection of Personal '
                          'Information Act (POPIA), you have the right to access, '
                          'correct, or delete your personal information.\n\n'
                          '7. Contact Us\n'
                          'If you have questions about this Privacy Policy, '
                          'please contact us through the app.\n\n'
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
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/auth/age-consent');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: const Color(0xFF0D1028),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        ),
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
