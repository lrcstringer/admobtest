import 'package:flutter/material.dart';

/// Application color palette
class AppColors {
  AppColors._();

  // Primary colors - iMali brand green
  static const Color primary = Color(0xFF00C853);
  static const Color primaryLight = Color(0xFF5EFC82);
  static const Color primaryDark = Color(0xFF009624);

  // Secondary colors - Gold/Yellow for rewards
  static const Color secondary = Color(0xFFFFD700);
  static const Color secondaryLight = Color(0xFFFFFF52);
  static const Color secondaryDark = Color(0xFFC7A600);

  // Accent colors
  static const Color accent = Color(0xFF2196F3);
  static const Color accentLight = Color(0xFF6EC6FF);
  static const Color accentDark = Color(0xFF0069C0);

  // Background colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2D2D);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3B3B3);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Token/Money related colors
  static const Color tokenGold = Color(0xFFFFD700);
  static const Color tokenSilver = Color(0xFFC0C0C0);
  static const Color tokenBronze = Color(0xFFCD7F32);
  static const Color money = Color(0xFF00C853);
  static const Color moneyNegative = Color(0xFFF44336);

  // Pot colors
  static const Color potActive = Color(0xFF00C853);
  static const Color potPending = Color(0xFFFF9800);
  static const Color potCompleted = Color(0xFF2196F3);

  // Dividers & borders
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF424242);

  // Shimmer colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF424242);
  static const Color shimmerHighlightDark = Color(0xFF616161);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF00C853),
    Color(0xFF69F0AE),
  ];

  static const List<Color> goldGradient = [
    Color(0xFFFFD700),
    Color(0xFFFFF176),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF1E1E1E),
    Color(0xFF2D2D2D),
  ];
}
