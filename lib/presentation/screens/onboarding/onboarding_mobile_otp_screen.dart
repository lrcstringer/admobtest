import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingMobileOtpScreen extends StatefulWidget {
  const OnboardingMobileOtpScreen({super.key});

  @override
  State<OnboardingMobileOtpScreen> createState() =>
      _OnboardingMobileOtpScreenState();
}

class _OnboardingMobileOtpScreenState
    extends State<OnboardingMobileOtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.25;

    // TODO: Replace with actual phone number passed from mobile screen
    const phoneNumber = '(+27) XXX XXXX';

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
              SizedBox(height: size.height * 0.08),

              // Mascot
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

              // "Verify your number"
              Text(
                'Verify your number',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),

              // "We sent a code to your number"
              Text(
                'We sent a code to your number',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),

              const SizedBox(height: 8),

              // Phone number + Change button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    phoneNumber,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => context.go('/onboarding/mobile'),
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 4 OTP input boxes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 56,
                      height: 64,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: AppColors.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.gold,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) => _onDigitChanged(index, value),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              // "Didn't receive your OTP code?" + Resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive your OTP code?",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement resend OTP logic
                    },
                    child: Text(
                      'Resend',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.go('/onboarding/picture'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: const Color(0xFF0D1028),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              const OnboardingProgressIndicator(currentStep: 4),
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
