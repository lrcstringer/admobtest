import 'package:flutter/material.dart';

/// Theme-aware custom color tokens for values not covered by Material ThemeData.
///
/// Provides per-theme variants for tab gradients, wave overlays, nav colors,
/// and card styling. Access via [AppColors.themed(context)].
///
/// Per-tab overrides remain possible — individual screens can ignore these
/// defaults and hardcode their own values (e.g. Chat stays dark, Buy stays light).
class ThemedColors {
  final List<Color> tabGradient;
  final String? waveOverlay;
  final Color navBackground;
  final Color navInactive;
  final Color cardBorder;
  final BoxShadow? cardShadow;

  const ThemedColors._({
    required this.tabGradient,
    required this.waveOverlay,
    required this.navBackground,
    required this.navInactive,
    required this.cardBorder,
    required this.cardShadow,
  });

  static const ThemedColors dark = ThemedColors._(
    tabGradient: [Color(0xFF3451B8), Color(0xFF2C325C)],
    waveOverlay: null,
    navBackground: Color(0xFF1E2245),
    navInactive: Color(0xFF8899A6),
    cardBorder: Color(0xFF2A2E3D),
    cardShadow: null,
  );

  static const ThemedColors light = ThemedColors._(
    tabGradient: [Color(0xFFF5F7FA), Color(0xFFF5F7FA)],
    waveOverlay: null,
    navBackground: Color(0xFFFFFFFF),
    navInactive: Color(0xFF94A3B8),
    cardBorder: Color(0xFFE8ECF1),
    cardShadow: BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  );
}
