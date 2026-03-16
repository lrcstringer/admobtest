import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingPictureScreen extends StatelessWidget {
  const OnboardingPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final frameSize = size.width * 0.35;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.themed(context).tabGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),

              // Profile picture frame
              Container(
                width: frameSize,
                height: frameSize,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.textPrimary,
                    size: 48,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // User's name placeholder
              Text(
                // Placeholder — wire to onboarding data when available
                'Your Name',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),

              const SizedBox(height: 24),

              // Gallery, Camera, Files buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gallery button
                  _ActionButton(
                    icon: Icons.photo_library_outlined,
                    onTap: () {
                      // Gallery picker not yet wired
                    },
                  ),
                  const SizedBox(width: 16),
                  // Camera/Shutter button (highlighted)
                  _ActionButton(
                    icon: Icons.camera_alt,
                    isHighlighted: true,
                    onTap: () {
                      // Camera capture not yet wired
                    },
                  ),
                  const SizedBox(width: 16),
                  // Files/Folders button
                  _ActionButton(
                    icon: Icons.folder_outlined,
                    onTap: () {
                      // File picker not yet wired
                    },
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.04),

              // "Please add your profile picture"
              Text(
                'Your profile picture',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),

              // Description text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Use your camera or select a photo from your phone to use as your profile picture.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),

              const SizedBox(height: 16),

              // "You can skip this step!"
              Text(
                'You can skip this step!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
              ),

              const Spacer(),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                child: AppButton(
                  text: 'Continue',
                  onPressed: () => context.go('/onboarding/success'),
                ),
              ),

              const OnboardingProgressIndicator(currentStep: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final bool isHighlighted;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    this.isHighlighted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: isHighlighted ? AppColors.primary : AppColors.surface,
          shape: BoxShape.circle,
          border: isHighlighted
              ? null
              : Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                ),
        ),
        child: Icon(
          icon,
          color: isHighlighted ? Colors.white : AppColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }
}
