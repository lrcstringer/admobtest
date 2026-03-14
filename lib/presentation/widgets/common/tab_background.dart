import 'package:flutter/material.dart';

/// Configurable per-tab background widget.
///
/// Provides two optional layers:
///  1. **Base fill** — a solid [color] or a [gradient] painted behind everything.
///  2. **Overlay image** — an optional asset (e.g. wave PNG) composited on top
///     of the base fill but behind the [child] content.
///
/// Usage:
/// ```dart
/// TabBackground(
///   gradient: AppColors.homeGradient,
///   overlayAsset: 'assets/images/wave_feather_fixed_r7.png',
///   child: content,
/// )
/// ```
///
/// For a plain solid background, pass only [color]:
/// ```dart
/// TabBackground(color: AppColors.buyBackground, child: content)
/// ```
class TabBackground extends StatelessWidget {
  final Widget child;

  /// Solid base color. Ignored if [gradient] is provided.
  final Color? color;

  /// Gradient base fill. Takes precedence over [color].
  final Gradient? gradient;

  /// Optional overlay image asset path (e.g. wave PNG).
  final String? overlayAsset;

  /// Scale factor for the overlay image. Defaults to 1.2.
  final double overlayScale;

  const TabBackground({
    super.key,
    required this.child,
    this.color,
    this.gradient,
    this.overlayAsset,
    this.overlayScale = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    // No layers — just return the child directly.
    if (color == null && gradient == null && overlayAsset == null) {
      return child;
    }

    return Stack(
      children: [
        // Layer 1: base fill (gradient or solid color)
        if (gradient != null)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: gradient),
            ),
          )
        else if (color != null)
          Positioned.fill(
            child: ColoredBox(color: color!),
          ),

        // Layer 2: overlay image
        if (overlayAsset != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: overlayScale,
              alignment: Alignment.topCenter,
              child: Image.asset(
                overlayAsset!,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

        // Layer 3: actual content
        child,
      ],
    );
  }
}
