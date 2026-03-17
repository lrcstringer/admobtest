import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingGenderScreen extends StatefulWidget {
  const OnboardingGenderScreen({super.key});

  @override
  State<OnboardingGenderScreen> createState() => _OnboardingGenderScreenState();
}

class _OnboardingGenderScreenState extends State<OnboardingGenderScreen> {
  String? _selectedGender;

  static const List<String> _genderOptions = [
    'Female',
    'Male',
    'Non-binary',
    'Prefer not to say',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.25;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.themed(context).tabGradient,
          ),
        ),
        child: Stack(
          children: [

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
                                  color: Theme.of(context).colorScheme.onSurface,
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

                    // "Please select your gender"
                    Text(
                      'Please select your gender',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: 24),

                    // Gender dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedGender,
                            hint: Text(
                              'Select gender',
                              style: TextStyle(color: Theme.of(context).hintColor),
                            ),
                            isExpanded: true,
                            dropdownColor: Theme.of(context).colorScheme.surface,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            items: _genderOptions.map((gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'We request that you, optionally, share your gender to help us personalize earning opportunities and content for you.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Button + progress indicator
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                      child: AppButton(
                        text: 'Continue',
                        onPressed: () => context.go('/onboarding/birthday'),
                      ),
                    ),

                    const OnboardingProgressIndicator(currentStep: 1),
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
