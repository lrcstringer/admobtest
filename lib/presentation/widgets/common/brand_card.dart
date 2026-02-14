import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Brand gradient families used across the app.
/// Each gradient has a semantic meaning:
/// - [logo]: Identity, portfolio, hero elements
/// - [pinkPurple]: Social, invites, creative, profile
/// - [cyanBlue]: Media, info, educational, surveys
/// - [goldOrange]: Tokens, rewards, earning, expression
/// - [none]: No gradient — flat surface card
enum BrandGradient {
  logo,
  pinkPurple,
  cyanBlue,
  goldOrange,
  none,
}

/// A card that applies the iMali brand color system:
/// - **Tier 2**: Optional thin gradient accent bar on top (3px)
/// - **Tier 3**: Optional subtle gradient tint on the background (5-8% opacity)
///
/// Usage:
/// ```dart
/// BrandCard(
///   gradient: BrandGradient.cyanBlue,
///   child: Text('Video Recording'),
/// )
/// ```
class BrandCard extends StatelessWidget {
  final BrandGradient gradient;
  final bool showAccentBar;
  final double tintOpacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const BrandCard({
    super.key,
    required this.gradient,
    this.showAccentBar = true,
    this.tintOpacity = 0.06,
    this.borderRadius,
    this.padding,
    required this.child,
  });

  /// Resolves the gradient enum to actual color stops.
  static List<Color> colorsFor(BrandGradient gradient) {
    switch (gradient) {
      case BrandGradient.logo:
        return AppColors.logoGradient;
      case BrandGradient.pinkPurple:
        return AppColors.primaryGradient;
      case BrandGradient.cyanBlue:
        return AppColors.secondaryGradient;
      case BrandGradient.goldOrange:
        return AppColors.tertiaryGradient;
      case BrandGradient.none:
        return const [Colors.transparent, Colors.transparent];
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppSpacing.borderRadiusLg;
    final colors = colorsFor(gradient);
    final isNone = gradient == BrandGradient.none;

    return Container(
      padding: padding ?? AppSpacing.cardPadding,
      decoration: BoxDecoration(
        gradient: !isNone && tintOpacity > 0
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.alphaBlend(
                    colors[0].withValues(alpha: tintOpacity),
                    AppColors.surface,
                  ),
                  Color.alphaBlend(
                    colors[1].withValues(alpha: tintOpacity * 0.5),
                    AppColors.surface,
                  ),
                ],
              )
            : null,
        color: isNone || tintOpacity <= 0 ? AppColors.surface : null,
        borderRadius: radius,
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
