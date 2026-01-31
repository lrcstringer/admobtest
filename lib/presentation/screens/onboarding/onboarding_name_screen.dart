import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingNameScreen extends StatefulWidget {
  const OnboardingNameScreen({super.key});

  @override
  State<OnboardingNameScreen> createState() => _OnboardingNameScreenState();
}

class _OnboardingNameScreenState extends State<OnboardingNameScreen> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _nameController.text.trim().length >= 2 && !_isLoading;

  Future<void> _onContinue() async {
    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) return;

    setState(() => _isLoading = true);

    final userRepo = getIt<UserRepository>();
    final result = await userRepo.updateProfile(
      userId: authState.user!.id,
      displayName: _nameController.text.trim(),
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.displayMessage),
            backgroundColor: Colors.red,
          ),
        );
      },
      (_) {
        context.go('/onboarding/birthday');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.40;

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
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),

              // Mascot face
              SizedBox(
                width: mascotSize,
                height: mascotSize,
                child: Image.asset(
                  'assets/logo-assets/mascot-bubbles-512.png',
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

              SizedBox(height: size.height * 0.01),

              // "iMaliChat"
              Text(
                'iMaliChat',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),

              // "Earn. Chat. Buy."
              Text(
                'Earn. Chat. Buy.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
              ),

              SizedBox(height: size.height * 0.05),

              // "What is your name?"
              Text(
                'What is your name?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),

              const SizedBox(height: 24),

              // Name input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: AppColors.textHint,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _canContinue ? _onContinue : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ),

              const OnboardingProgressIndicator(currentStep: 0),
            ],
          ),
        ),
      ),
    );
  }
}
