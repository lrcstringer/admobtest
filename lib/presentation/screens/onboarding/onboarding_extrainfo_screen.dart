import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';


class OnboardingExtraInfoScreen extends StatefulWidget {
  const OnboardingExtraInfoScreen({super.key});

  @override
  State<OnboardingExtraInfoScreen> createState() =>
      _OnboardingExtraInfoScreenState();
}

class _OnboardingExtraInfoScreenState extends State<OnboardingExtraInfoScreen> {
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedProvince;
  final _cityController = TextEditingController();
  bool _isLoading = false;

  static const List<String> _genderOptions = [
    'Female',
    'Male',
    'Non-binary',
    'Prefer not to say',
  ];

  static const List<String> _provinceOptions = [
    'Eastern Cape',
    'Free State',
    'Gauteng',
    'KwaZulu-Natal',
    'Limpopo',
    'Mpumalanga',
    'Northern Cape',
    'North West',
    'Western Cape',
  ];

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(1990, 7, 15),
      firstDate: DateTime(1940),
      lastDate: DateTime(now.year - 13, now.month, now.day),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColors.backgroundDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _onContinue() async {
    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) return;

    // Check if user filled in any optional fields
    final hasData = _selectedDate != null ||
        _selectedGender != null ||
        _selectedProvince != null ||
        _cityController.text.trim().isNotEmpty;

    if (!hasData) {
      // Nothing to save — go straight to success
      context.go('/onboarding/success');
      return;
    }

    setState(() => _isLoading = true);

    // Only save fields that the user actually filled in
    final userRepo = getIt<UserRepository>();
    final result = await userRepo.updateProfile(
      userId: authState.user!.id,
      dateOfBirth: _selectedDate,
      gender: _selectedGender,
      province: _selectedProvince,
      city: _cityController.text.trim().isNotEmpty
          ? _cityController.text.trim()
          : null,
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
        context.go('/onboarding/success');
      },
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: const TextStyle(color: AppColors.textHint)),
          isExpanded: true,
          dropdownColor: AppColors.surface,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
          icon: const Icon(Icons.arrow_drop_down,
              color: AppColors.textSecondary),
          items: items.map((item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.25;

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

                      // Scrollable form content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            children: [
                              // Explanatory text
                              Text(
                                'To better enable us to personalize earning opportunities and content for you, please consider providing the following optional information.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Birthday
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'When is your birthday?',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: _pickDate,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _selectedDate != null
                                              ? DateFormat('dd MMMM yyyy')
                                                  .format(_selectedDate!)
                                              : 'Select date',
                                          style: TextStyle(
                                            color: _selectedDate != null
                                                ? AppColors.textPrimary
                                                : AppColors.textHint,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.calendar_today,
                                          color: AppColors.textSecondary,
                                          size: 20),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Gender
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'What is your gender?',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildDropdown(
                                hint: 'Select gender',
                                value: _selectedGender,
                                items: _genderOptions,
                                onChanged: (v) =>
                                    setState(() => _selectedGender = v),
                              ),

                              const SizedBox(height: 16),

                              // Province
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'What province do you live in?',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildDropdown(
                                hint: 'Select province',
                                value: _selectedProvince,
                                items: _provinceOptions,
                                onChanged: (v) =>
                                    setState(() => _selectedProvince = v),
                              ),

                              const SizedBox(height: 16),

                              // City/Town
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'What town/city do you live in?',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextField(
                                  controller: _cityController,
                                  keyboardType: TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.words,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter town or city',
                                    hintStyle: TextStyle(
                                      color: AppColors.textHint,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),

                      // Continue button + progress indicator
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48, vertical: 16),
                        child: AppButton(
                          text: 'Continue',
                          onPressed: _isLoading ? null : _onContinue,
                          isLoading: _isLoading,
                        ),
                      ),

                      const OnboardingProgressIndicator(currentStep: 2),
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
