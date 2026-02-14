import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingSuccessScreen extends StatelessWidget {
  const OnboardingSuccessScreen({super.key});

  void _completeAndNavigate(BuildContext context, String route) {
    context.read<AuthBloc>().add(const AuthEvent.completeOnboarding());
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final photoSize = size.width * 0.28;
    final starsSize = size.width * 0.50;
    final crownSize = photoSize * 0.35;

    // TODO: Replace with actual user number from backend
    const userNumber = '85 674';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),

                // Stars background with user photo and crown overlay
                SizedBox(
                  width: starsSize,
                  height: starsSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Surrounding stars
                      Image.asset(
                        'assets/images/Surrounding stars.png',
                        width: starsSize,
                        height: starsSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: starsSize,
                            height: starsSize,
                          );
                        },
                      ),

                      // User photo frame
                      Container(
                        width: photoSize,
                        height: photoSize,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 3,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: const Center(
                            // TODO: Show user's uploaded photo if available
                            child: Icon(
                              Icons.person,
                              color: AppColors.textPrimary,
                              size: 48,
                            ),
                          ),
                        ),
                      ),

                      // Bronze crown at bottom center of photo
                      Positioned(
                        top: (starsSize / 2) + (photoSize / 2) - (crownSize / 2),
                        child: Image.asset(
                          'assets/images/crowns/BRONZE.png',
                          width: crownSize,
                          height: crownSize,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              width: crownSize,
                              height: crownSize,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // User's name
                Text(
                  // TODO: Replace with actual user name from onboarding data
                  'Your Name',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),

                const SizedBox(height: 2),

                // "BRONZE"
                Text(
                  'BRONZE',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                ),

                const SizedBox(height: 16),

                // "CONGRATS!"
                Text(
                  'CONGRATS!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 8),

                // "You're user number"
                Text(
                  "You're user number",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                ),

                const SizedBox(height: 4),

                // User number
                Text(
                  userNumber,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 16),

                // Early access text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'iMaliChat has early earning access for 100 000 people and you made the cut!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),

                const SizedBox(height: 12),

                // Upgrade text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Please upgrade your account to SILVER status to start earning today!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // "Upgrade Now" blue button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: AppButton(
                    text: 'Upgrade Now',
                    onPressed: () => _completeAndNavigate(context, '/home/upgrade-status'),
                    variant: AppButtonVariant.secondary,
                    size: AppButtonSize.large,
                  ),
                ),

                const SizedBox(height: 12),

                // "Continue" pink button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: AppButton(
                    text: 'Continue',
                    onPressed: () => _completeAndNavigate(context, '/home'),
                    size: AppButtonSize.large,
                  ),
                ),

                const SizedBox(height: 16),

                const OnboardingProgressIndicator(currentStep: 7),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
