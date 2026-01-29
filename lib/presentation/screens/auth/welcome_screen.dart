import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.monetization_on_outlined,
      title: 'Earn Tokens',
      description:
          'Watch videos, complete surveys, and earn tokens for your time and attention.',
    ),
    _OnboardingPage(
      icon: Icons.send_outlined,
      title: 'Send & Receive',
      description:
          'Send tokens to friends and family through chat. Request money with a tap.',
    ),
    _OnboardingPage(
      icon: Icons.emoji_events_outlined,
      title: 'Win Big in Pots',
      description:
          'Join daily, weekly, and monthly pots. Compete for bigger prizes!',
    ),
    _OnboardingPage(
      icon: Icons.account_balance_wallet_outlined,
      title: 'Cash Out',
      description:
          'Convert your tokens to real money. Cash out to your bank or mobile wallet.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _buildPage(context, page);
                },
              ),
            ),
            _buildPageIndicator(),
            AppSpacing.verticalLg,
            Padding(
              padding: AppSpacing.pageHorizontal,
              child: Column(
                children: [
                  AppButton(
                    text: _currentPage == _pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        context.go('/auth/phone');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                  AppSpacing.verticalMd,
                  if (_currentPage < _pages.length - 1)
                    AppButton(
                      text: 'Skip',
                      variant: AppButtonVariant.text,
                      onPressed: () => context.go('/auth/phone'),
                    ),
                ],
              ),
            ),
            AppSpacing.verticalXl,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, _OnboardingPage page) {
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.2),
                  AppColors.purple.withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 80,
              color: AppColors.primary,
            ),
          ),
          AppSpacing.verticalXxl,
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalMd,
          Text(
            page.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? AppColors.primary
                : AppColors.divider,
            borderRadius: AppSpacing.borderRadiusRound,
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String description;

  _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}
