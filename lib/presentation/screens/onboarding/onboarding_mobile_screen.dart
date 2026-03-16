import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingMobileScreen extends StatefulWidget {
  const OnboardingMobileScreen({super.key});

  @override
  State<OnboardingMobileScreen> createState() =>
      _OnboardingMobileScreenState();
}

class _OnboardingMobileScreenState extends State<OnboardingMobileScreen> {
  final _phoneController = TextEditingController();
  String _selectedCountryCode = '+27';

  static const List<Map<String, String>> _countryCodes = [
    {'code': '+27', 'country': 'ZA', 'name': 'South Africa'},
    {'code': '+1', 'country': 'US', 'name': 'United States'},
    {'code': '+44', 'country': 'GB', 'name': 'United Kingdom'},
    {'code': '+61', 'country': 'AU', 'name': 'Australia'},
    {'code': '+86', 'country': 'CN', 'name': 'China'},
    {'code': '+91', 'country': 'IN', 'name': 'India'},
    {'code': '+49', 'country': 'DE', 'name': 'Germany'},
    {'code': '+33', 'country': 'FR', 'name': 'France'},
    {'code': '+81', 'country': 'JP', 'name': 'Japan'},
    {'code': '+55', 'country': 'BR', 'name': 'Brazil'},
    {'code': '+234', 'country': 'NG', 'name': 'Nigeria'},
    {'code': '+254', 'country': 'KE', 'name': 'Kenya'},
    {'code': '+255', 'country': 'TZ', 'name': 'Tanzania'},
    {'code': '+256', 'country': 'UG', 'name': 'Uganda'},
    {'code': '+260', 'country': 'ZM', 'name': 'Zambia'},
    {'code': '+263', 'country': 'ZW', 'name': 'Zimbabwe'},
    {'code': '+265', 'country': 'MW', 'name': 'Malawi'},
    {'code': '+267', 'country': 'BW', 'name': 'Botswana'},
    {'code': '+268', 'country': 'SZ', 'name': 'Eswatini'},
    {'code': '+266', 'country': 'LS', 'name': 'Lesotho'},
    {'code': '+258', 'country': 'MZ', 'name': 'Mozambique'},
    {'code': '+264', 'country': 'NA', 'name': 'Namibia'},
    {'code': '+7', 'country': 'RU', 'name': 'Russia'},
    {'code': '+82', 'country': 'KR', 'name': 'South Korea'},
    {'code': '+39', 'country': 'IT', 'name': 'Italy'},
    {'code': '+34', 'country': 'ES', 'name': 'Spain'},
    {'code': '+52', 'country': 'MX', 'name': 'Mexico'},
    {'code': '+62', 'country': 'ID', 'name': 'Indonesia'},
    {'code': '+60', 'country': 'MY', 'name': 'Malaysia'},
    {'code': '+63', 'country': 'PH', 'name': 'Philippines'},
    {'code': '+66', 'country': 'TH', 'name': 'Thailand'},
    {'code': '+84', 'country': 'VN', 'name': 'Vietnam'},
    {'code': '+20', 'country': 'EG', 'name': 'Egypt'},
    {'code': '+212', 'country': 'MA', 'name': 'Morocco'},
    {'code': '+233', 'country': 'GH', 'name': 'Ghana'},
    {'code': '+237', 'country': 'CM', 'name': 'Cameroon'},
    {'code': '+251', 'country': 'ET', 'name': 'Ethiopia'},
    {'code': '+971', 'country': 'AE', 'name': 'UAE'},
    {'code': '+966', 'country': 'SA', 'name': 'Saudi Arabia'},
    {'code': '+92', 'country': 'PK', 'name': 'Pakistan'},
    {'code': '+880', 'country': 'BD', 'name': 'Bangladesh'},
    {'code': '+90', 'country': 'TR', 'name': 'Turkey'},
    {'code': '+48', 'country': 'PL', 'name': 'Poland'},
    {'code': '+31', 'country': 'NL', 'name': 'Netherlands'},
    {'code': '+46', 'country': 'SE', 'name': 'Sweden'},
    {'code': '+47', 'country': 'NO', 'name': 'Norway'},
    {'code': '+45', 'country': 'DK', 'name': 'Denmark'},
    {'code': '+358', 'country': 'FI', 'name': 'Finland'},
    {'code': '+41', 'country': 'CH', 'name': 'Switzerland'},
    {'code': '+43', 'country': 'AT', 'name': 'Austria'},
    {'code': '+32', 'country': 'BE', 'name': 'Belgium'},
    {'code': '+351', 'country': 'PT', 'name': 'Portugal'},
    {'code': '+353', 'country': 'IE', 'name': 'Ireland'},
    {'code': '+64', 'country': 'NZ', 'name': 'New Zealand'},
    {'code': '+65', 'country': 'SG', 'name': 'Singapore'},
    {'code': '+852', 'country': 'HK', 'name': 'Hong Kong'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
              SizedBox(height: size.height * 0.08),

              // Mascot
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

              // Instruction text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Please enter your mobile number.\nThis will be your logon.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),

              const SizedBox(height: 24),

              // Phone number field with country code dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      // Country code dropdown
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCountryCode,
                            dropdownColor: Theme.of(context).colorScheme.surface,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.textSecondary,
                            ),
                            items: _countryCodes.map((country) {
                              return DropdownMenuItem<String>(
                                value: country['code'],
                                child: Text(
                                  '${country['country']} ${country['code']}',
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedCountryCode = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      // Divider
                      Container(
                        width: 1,
                        height: 24,
                        color: AppColors.textHint,
                      ),
                      // Phone number input
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Phone number',
                            hintStyle: TextStyle(
                              color: AppColors.textHint,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                child: AppButton(
                  text: 'Continue',
                  onPressed: () => context.go('/onboarding/mobile-otp'),
                ),
              ),

              const OnboardingProgressIndicator(currentStep: 3),
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
