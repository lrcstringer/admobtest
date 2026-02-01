import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_progress_indicator.dart';

class OnboardingBirthdayScreen extends StatefulWidget {
  const OnboardingBirthdayScreen({super.key});

  @override
  State<OnboardingBirthdayScreen> createState() =>
      _OnboardingBirthdayScreenState();
}

class _OnboardingBirthdayScreenState extends State<OnboardingBirthdayScreen> {
  late final FixedExtentScrollController _dayController;
  late final FixedExtentScrollController _monthController;
  late final FixedExtentScrollController _yearController;

  // Default to 15 July 1990
  int _selectedDay = 15;
  int _selectedMonth = 7;
  int _selectedYear = 1990;
  bool _isLoading = false;

  static const int _startYear = 1940;
  static const int _endYear = 2010;

  @override
  void initState() {
    super.initState();
    _dayController = FixedExtentScrollController(initialItem: _selectedDay - 1);
    _monthController =
        FixedExtentScrollController(initialItem: _selectedMonth - 1);
    _yearController =
        FixedExtentScrollController(initialItem: _selectedYear - _startYear);
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  int _daysInMonth(int month, int year) {
    if (month == 2) {
      final isLeap =
          (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return isLeap ? 29 : 28;
    }
    if ([4, 6, 9, 11].contains(month)) return 30;
    return 31;
  }

  Future<void> _onContinue() async {
    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) return;

    setState(() => _isLoading = true);

    final dateOfBirth = DateTime(_selectedYear, _selectedMonth, _selectedDay);

    final userRepo = getIt<UserRepository>();
    final result = await userRepo.updateProfile(
      userId: authState.user!.id,
      dateOfBirth: dateOfBirth,
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
        context.go('/onboarding/picture');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mascotSize = size.width * 0.25;
    final maxDay = _daysInMonth(_selectedMonth, _selectedYear);

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
            // Top Light Blue background image
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
                    Text(
                      'iMaliChat',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
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

                    // "Cool! When is your birthday?"
                    Text(
                      'Cool! When is your birthday?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    const SizedBox(height: 16),

                    // Date picker wheels
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Stack(
                          children: [
                            // Selection highlight band
                            Center(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: AppColors.textSecondary
                                          .withValues(alpha: 0.3),
                                    ),
                                    bottom: BorderSide(
                                      color: AppColors.textSecondary
                                          .withValues(alpha: 0.3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // Day wheel
                                Expanded(
                                  child: ListWheelScrollView.useDelegate(
                                    controller: _dayController,
                                    itemExtent: 40,
                                    physics:
                                        const FixedExtentScrollPhysics(),
                                    diameterRatio: 1.5,
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _selectedDay = index + 1;
                                      });
                                    },
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      childCount: maxDay,
                                      builder: (context, index) {
                                        final day = index + 1;
                                        final isSelected =
                                            day == _selectedDay;
                                        return Center(
                                          child: Text(
                                            '$day',
                                            style: TextStyle(
                                              color: isSelected
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                              fontSize:
                                                  isSelected ? 20 : 16,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // Month wheel
                                Expanded(
                                  child: ListWheelScrollView.useDelegate(
                                    controller: _monthController,
                                    itemExtent: 40,
                                    physics:
                                        const FixedExtentScrollPhysics(),
                                    diameterRatio: 1.5,
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _selectedMonth = index + 1;
                                        final maxD = _daysInMonth(
                                            _selectedMonth,
                                            _selectedYear);
                                        if (_selectedDay > maxD) {
                                          _selectedDay = maxD;
                                          _dayController
                                              .jumpToItem(_selectedDay - 1);
                                        }
                                      });
                                    },
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      childCount: 12,
                                      builder: (context, index) {
                                        final month = index + 1;
                                        final isSelected =
                                            month == _selectedMonth;
                                        return Center(
                                          child: Text(
                                            month
                                                .toString()
                                                .padLeft(2, '0'),
                                            style: TextStyle(
                                              color: isSelected
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                              fontSize:
                                                  isSelected ? 20 : 16,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // Year wheel
                                Expanded(
                                  child: ListWheelScrollView.useDelegate(
                                    controller: _yearController,
                                    itemExtent: 40,
                                    physics:
                                        const FixedExtentScrollPhysics(),
                                    diameterRatio: 1.5,
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _selectedYear =
                                            _startYear + index;
                                        final maxD = _daysInMonth(
                                            _selectedMonth,
                                            _selectedYear);
                                        if (_selectedDay > maxD) {
                                          _selectedDay = maxD;
                                          _dayController
                                              .jumpToItem(_selectedDay - 1);
                                        }
                                      });
                                    },
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      childCount:
                                          _endYear - _startYear + 1,
                                      builder: (context, index) {
                                        final year =
                                            _startYear + index;
                                        final isSelected =
                                            year == _selectedYear;
                                        return Center(
                                          child: Text(
                                            '$year',
                                            style: TextStyle(
                                              color: isSelected
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                              fontSize:
                                                  isSelected ? 20 : 16,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'We require your date of birth to verify you meet the minimum age requirement and to personalize content.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _onContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
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
