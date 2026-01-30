import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.40;

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
            // Layer 1: Blue wave at the top (behind light blue)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: size.height * 0.60,
                width: size.width,
                child: Image.asset(
                  'assets/images/Top Blue Wave.png',
                  width: size.width,
                  height: size.height * 0.60,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // Layer 2: Light blue wave overlaying dark blue at the top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Top Light Blue.png',
                width: size.width,
                fit: BoxFit.fitWidth,
              ),
            ),

            // Layer 3: Yellow wave at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Bottom Yellow2.png',
                width: size.width,
                fit: BoxFit.fitWidth,
              ),
            ),

            // Layer 4: Main content
            Positioned.fill(
              child: SafeArea(
                child: SingleChildScrollView(
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

                      SizedBox(height: size.height * 0.04),

                      // Phone number field with country code dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
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
                                    dropdownColor: AppColors.surface,
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

                      const SizedBox(height: 16),

                      // Password field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppColors.textSecondary,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: AppColors.textHint,
                            ),
                            filled: true,
                            fillColor: AppColors.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // "Forgot password?"
                      GestureDetector(
                        onTap: () => context.go('/auth/login/forgot-password'),
                        child: Text(
                          'Forgot password?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      // "Login" button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implement login logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
