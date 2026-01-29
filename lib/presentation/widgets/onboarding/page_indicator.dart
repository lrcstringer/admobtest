import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Page indicator dots for onboarding screens
class PageIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final double dotSize;
  final double spacing;

  const PageIndicator({
    super.key,
    required this.totalPages,
    required this.currentPage,
    this.dotSize = 8,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppColors.primary
                : AppColors.textSecondary.withValues(alpha: 0.3),
          ),
        );
      }),
    );
  }
}
