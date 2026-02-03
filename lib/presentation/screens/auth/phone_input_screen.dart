import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/fcm_challenge_handler.dart';
import '../../../core/utils/phone_utils.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/numeric_keyboard.dart';

class PhoneInputScreen extends StatefulWidget {
  final bool skipPushLogin;

  /// Optional E.164 phone number to pre-fill (e.g. "+27812345678").
  final String? initialPhoneNumber;

  const PhoneInputScreen({
    super.key,
    this.skipPushLogin = false,
    this.initialPhoneNumber,
  });

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final _challengeHandler = GetIt.instance<FcmChallengeHandler>();

  String _phoneDigits = '';
  String _selectedCountryCode = '+27';
  String? _errorText;
  bool _isPushLoginLoading = false;
  late final bool _skipPushLogin = widget.skipPushLogin;

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
  void initState() {
    super.initState();
    _prefillPhoneNumber();
  }

  /// Parse an E.164 phone number into country code + local digits.
  void _prefillPhoneNumber() {
    final phone = widget.initialPhoneNumber;
    if (phone == null || !phone.startsWith('+')) return;

    // Try to match the longest country code first (e.g. +852 before +8)
    String? matchedCode;
    for (final entry in _countryCodes) {
      final code = entry['code']!;
      if (phone.startsWith(code)) {
        if (matchedCode == null || code.length > matchedCode.length) {
          matchedCode = code;
        }
      }
    }

    if (matchedCode != null) {
      _selectedCountryCode = matchedCode;
      _phoneDigits = phone.substring(matchedCode.length);
    }
  }

  String? _getE164PhoneNumber() {
    return parseToE164(_phoneDigits, _selectedCountryCode);
  }

  bool _isValidPhoneNumber() {
    return _getE164PhoneNumber() != null;
  }

  Future<void> _onSubmit() async {
    final phoneNumber = _getE164PhoneNumber();
    if (phoneNumber == null) {
      setState(() {
        _errorText = 'Please enter a valid phone number';
      });
      return;
    }

    setState(() => _errorText = null);

    // Try push login first (unless skipped)
    if (!_skipPushLogin) {
      debugPrint('========================================');
      debugPrint('PUSH LOGIN: Attempting for $phoneNumber');
      debugPrint('========================================');
      setState(() => _isPushLoginLoading = true);

      final result = await _challengeHandler.requestLogin(phoneNumber);

      if (!mounted) return;

      debugPrint('========================================');
      debugPrint('PUSH LOGIN RESULT: hasTrustedDevice=${result.hasTrustedDevice}, challengeId=${result.challengeId}');
      debugPrint('========================================');

      if (result.hasTrustedDevice && result.challengeId != null) {
        setState(() => _isPushLoginLoading = false);
        // Navigate to push login waiting screen
        context.go('/auth/push-login', extra: {
          'challengeId': result.challengeId,
          'phoneNumber': phoneNumber,
        });
        return;
      }

      setState(() => _isPushLoginLoading = false);
    } else {
      debugPrint('========================================');
      debugPrint('PUSH LOGIN: Skipped (_skipPushLogin=true)');
      debugPrint('========================================');
    }

    // Fall back to OTP
    debugPrint('PUSH LOGIN: Falling back to SMS OTP');
    if (!mounted) return;
    context.read<AuthBloc>().add(
          AuthEvent.sendOtp(phoneNumber: phoneNumber),
        );
  }

  void _onKeyPressed(String key) {
    if (_phoneDigits.length < 15) {
      setState(() {
        _phoneDigits += key;
        _errorText = null;
      });
    }
  }

  void _onBackspace() {
    if (_phoneDigits.isNotEmpty) {
      setState(() {
        _phoneDigits = _phoneDigits.substring(0, _phoneDigits.length - 1);
        _errorText = null;
      });
    }
  }

  String _formatPhoneNumber(String digits) {
    // Format: XX XXX XXXX
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 5) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.25;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          context.go('/auth/otp', extra: {
            'verificationId': state.verificationId,
            'phoneNumber': _getE164PhoneNumber() ?? '',
          });
        } else if (state.status == AuthStatus.error) {
          setState(() => _errorText = state.errorMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state.isLoading || _isPushLoginLoading;

        return Scaffold(
          body: Container(
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
                        // Scrollable content
                        Expanded(
                          child: SingleChildScrollView(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.01),

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
                          Text(
                            'What is your mobile number?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),

                          const SizedBox(height: 20),

                          // Phone input field (read-only, displays formatted number)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: _phoneDigits.isNotEmpty
                                    ? AppColors.inputBorderFocused
                                    : AppColors.inputBorder,
                                width: _phoneDigits.isNotEmpty ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Country code dropdown
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedCountryCode,
                                    dropdownColor: AppColors.surface,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.textSecondary,
                                      size: 20,
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
                                          _phoneDigits = '';
                                          _errorText = null;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                // Divider
                                Container(
                                  width: 1,
                                  height: 24,
                                  color: AppColors.textHint,
                                ),
                                const SizedBox(width: 12),
                                // Phone number display
                                Expanded(
                                  child: Text(
                                    _phoneDigits.isEmpty
                                        ? '81 234 5678'
                                        : _formatPhoneNumber(_phoneDigits),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: _phoneDigits.isEmpty
                                              ? AppColors.textHint
                                              : AppColors.textPrimary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Error text
                          if (_errorText != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              _errorText!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.error,
                                  ),
                            ),
                          ],

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Continue button — only visible when phone is valid
                  if (_isValidPhoneNumber() || isLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _onSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: const Color(0xFF0D1028),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 60),

                        // Custom numeric keyboard
                        NumericKeyboard(
                          onKeyPressed: _onKeyPressed,
                          onBackspace: _onBackspace,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
