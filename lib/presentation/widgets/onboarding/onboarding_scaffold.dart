import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'page_indicator.dart';
import 'zawadi_logo.dart';

/// Common scaffold for onboarding screens with logo and page indicator
class OnboardingScaffold extends StatelessWidget {
  final Widget child;
  final int currentPage;
  final int totalPages;
  final bool showLogo;
  final double logoSize;
  final bool showBackButton;
  final VoidCallback? onBack;

  const OnboardingScaffold({
    super.key,
    required this.child,
    required this.currentPage,
    this.totalPages = 5,
    this.showLogo = true,
    this.logoSize = 100,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: SafeArea(
          child: Column(
            children: [
              // Top section with optional back button
              if (showBackButton)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimaryDark,
                      ),
                      onPressed: onBack,
                    ),
                  ),
                )
              else
                const SizedBox(height: 16),

              // Logo section
              if (showLogo) ...[
                AppSpacing.verticalLg,
                ZawadiLogo(size: logoSize),
                AppSpacing.verticalXl,
              ],

              // Main content
              Expanded(
                child: child,
              ),

              // Page indicator
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PageIndicator(
                  totalPages: totalPages,
                  currentPage: currentPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
