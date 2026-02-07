import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

class AgeConsentScreen extends StatefulWidget {
  const AgeConsentScreen({super.key});

  @override
  State<AgeConsentScreen> createState() => _AgeConsentScreenState();
}

class _AgeConsentScreenState extends State<AgeConsentScreen> {
  bool _isOver18 = false;

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
                        'assets/icons/elephantFinal2.png',
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

                    SizedBox(height: size.height * 0.05),

                    // "Are you 18 or over?"
                    Text(
                      'Are you 18 or over?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: 32),

                    // Confirmation toggle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'I confirm that I am 18 years of age or older',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Switch(
                            value: _isOver18,
                            onChanged: (value) {
                              setState(() => _isOver18 = value);
                            },
                            activeThumbColor: Colors.white,
                            activeTrackColor: AppColors.switchActive,
                            inactiveThumbColor: AppColors.switchInactive,
                            inactiveTrackColor: AppColors.switchTrackInactive,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Terms and Privacy text with links
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                          children: [
                            const TextSpan(
                              text: 'By continuing, you agree to our ',
                            ),
                            TextSpan(
                              text: 'Terms of Service',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textPrimary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/auth/terms-of-service');
                                },
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textPrimary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/auth/privacy-policy');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Continue button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed:
                              _isOver18 ? () => context.go('/auth/phone') : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: const Color(0xFF0D1028),
                            disabledBackgroundColor:
                                AppColors.primary.withValues(alpha: 0.5),
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
