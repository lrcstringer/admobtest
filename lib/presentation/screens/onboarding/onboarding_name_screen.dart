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
  final _firstNamesController = TextEditingController();
  final _surnameController = TextEditingController();
  final _displayNameController = TextEditingController();
  bool _isLoading = false;
  String _lastAutoSuggestion = '';

  @override
  void dispose() {
    _firstNamesController.dispose();
    _surnameController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _firstNamesController.text.trim().length >= 2 &&
      _surnameController.text.trim().length >= 2 &&
      _displayNameController.text.trim().length >= 2 &&
      !_isLoading;

  void _onFirstNameChanged(String value) {
    final trimmed = value.trim();
    final currentDisplay = _displayNameController.text.trim();
    if (currentDisplay.isEmpty || currentDisplay == _lastAutoSuggestion) {
      _displayNameController.text = trimmed;
      _lastAutoSuggestion = trimmed;
    }
    setState(() {});
  }

  Future<void> _onContinue() async {
    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) return;

    setState(() => _isLoading = true);

    final userRepo = getIt<UserRepository>();
    final result = await userRepo.updateProfile(
      userId: authState.user!.id,
      firstName: _firstNamesController.text.trim(),
      lastName: _surnameController.text.trim(),
      displayName: _displayNameController.text.trim(),
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
        context.go('/onboarding/extrainfo');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 50;
    final mascotSize = keyboardVisible ? 0.0 : size.width * 0.25;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    // Collapsible header: mascot + iMaliChat + tagline
                    // Hides when keyboard is visible to give more space for form fields
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: keyboardVisible ? 0 : null,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: keyboardVisible ? 0.0 : 1.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                          ],
                        ),
                      ),
                    ),

                    // Scrollable content area
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // "What is your name?"
                            Text(
                              'What is your name?',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),

                            const SizedBox(height: 24),

                            // First name(s) field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  controller: _firstNamesController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization:
                                      TextCapitalization.words,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'First name(s)',
                                    hintStyle: TextStyle(
                                      color: AppColors.textHint,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                  ),
                                  onChanged: _onFirstNameChanged,
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Surname field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  controller: _surnameController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization:
                                      TextCapitalization.words,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Surname',
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

                            const SizedBox(height: 12),

                            // Display name field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius:
                                          BorderRadius.circular(30),
                                    ),
                                    child: TextField(
                                      controller: _displayNameController,
                                      keyboardType: TextInputType.name,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'Display name',
                                        hintStyle: TextStyle(
                                          color: AppColors.textHint,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 16,
                                        ),
                                      ),
                                      onChanged: (_) => setState(() {}),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'This is how other iMaliChat users will know you',
                                    style: TextStyle(
                                      color: AppColors.textHint,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Pinned button + progress indicator
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _canContinue ? _onContinue : null,
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ),

                    const OnboardingProgressIndicator(currentStep: 0),
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
