import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Application typography styles - iMali Brand Design System
/// Font: Plus Jakarta Sans (weights 300-800)
/// Brand type scale: Hero 48/700, H1 32/700, H2 24/600, H3 18/600,
/// Body 15/400, Caption 13/500, Overline 11/600, Token Balance 42/700
class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'Plus Jakarta Sans';
  static const String _fontFamilyMono = 'monospace';

  // ============ LIGHT THEME TEXT STYLES ============

  static TextTheme get textTheme => const TextTheme(
        // Hero / Display Large: 48px Bold -1% tracking
        displayLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.48, // -1%
          color: AppColors.textPrimary,
        ),
        // Display Medium: 45px
        displayMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.45,
          color: AppColors.textPrimary,
        ),
        // Display Small: 36px
        displaySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.36,
          color: AppColors.textPrimary,
        ),
        // H1: 32px Bold -0.5% tracking
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.16, // -0.5%
          color: AppColors.textPrimary,
        ),
        // H2: 24px SemiBold
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        // H3: 18px SemiBold
        headlineSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        // Title Large: 22px SemiBold
        titleLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        // Title Medium: 16px Medium
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: AppColors.textPrimary,
        ),
        // Title Small: 14px Medium
        titleSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.textPrimary,
        ),
        // Body Large: 15px Regular, line-height 1.6
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: AppColors.textPrimary,
        ),
        // Body Medium: 14px Regular
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.textPrimary,
        ),
        // Body Small: 12px Regular
        bodySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.textSecondary,
        ),
        // Label Large: 14px Medium
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.textPrimary,
        ),
        // Caption: 13px Medium, 0.5% tracking
        labelMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.065, // 0.5%
          color: AppColors.textPrimary,
        ),
        // Overline: 11px SemiBold, 5% tracking (UPPERCASE)
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.55, // 5%
          color: AppColors.textSecondary,
        ),
      );

  // ============ DARK THEME TEXT STYLES ============

  static TextTheme get darkTextTheme => const TextTheme(
        displayLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.48,
          color: AppColors.textPrimaryDark,
        ),
        displayMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.45,
          color: AppColors.textPrimaryDark,
        ),
        displaySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.36,
          color: AppColors.textPrimaryDark,
        ),
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.16,
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
        ),
        titleLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
        ),
        titleMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: AppColors.textPrimaryDark,
        ),
        titleSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.textPrimaryDark,
        ),
        bodySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.textSecondaryDark,
        ),
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.textPrimaryDark,
        ),
        labelMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.065,
          color: AppColors.textPrimaryDark,
        ),
        labelSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.55,
          color: AppColors.textSecondaryDark,
        ),
      );

  // ============ CUSTOM TEXT STYLES ============

  /// Token balance display - Brand gold, 42px Bold -1% tracking
  static const TextStyle tokenAmount = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.tokenGold,
  );

  /// Large token amount - For wallet hero displays (Token Balance scale)
  static const TextStyle tokenAmountLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 42,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.42, // -1%
    color: AppColors.tokenGold,
  );

  /// Money amount display - Green color for ZAR values
  static const TextStyle moneyAmount = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.money,
  );

  /// Large balance display
  static const TextStyle balanceLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  /// Extra large balance - For main wallet display
  static const TextStyle balanceXLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.48, // -1%
    color: AppColors.textPrimaryDark,
  );

  /// Countdown timer display
  static const TextStyle countdownTimer = TextStyle(
    fontFamily: _fontFamilyMono,
    fontSize: 48,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  /// Wallet card title
  static const TextStyle walletCardTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  /// Wallet card balance
  static const TextStyle walletCardBalance = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  /// Navigation label
  static const TextStyle navLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.navInactive,
  );

  /// Navigation label active
  static const TextStyle navLabelActive = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.navActive,
  );

  /// Badge text
  static const TextStyle badge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.badgeText,
  );

  /// Chat message text - Body scale (15px)
  static const TextStyle chatMessage = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
    height: 1.6,
  );

  /// Chat timestamp
  static const TextStyle chatTimestamp = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.chatTimestamp,
  );

  /// Section header - H3 scale (18px SemiBold)
  static const TextStyle sectionHeader = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  /// Settings item title
  static const TextStyle settingsTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );

  /// Settings item subtitle
  static const TextStyle settingsSubtitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /// Button text - Primary (SemiBold 600)
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
  );

  /// Button text - Secondary
  static const TextStyle buttonSecondary = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textPrimaryDark,
  );

  /// Hint text
  static const TextStyle hint = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  /// Link text - Cyan accent
  static const TextStyle link = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.secondary,
  );

  /// Error text
  static const TextStyle error = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  /// Success text
  static const TextStyle success = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.success,
  );

  /// Caption text - 13px Medium, 0.5% tracking
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.065,
    color: AppColors.textSecondary,
  );

  /// Overline text - 11px SemiBold, 5% tracking (UPPERCASE)
  static const TextStyle overline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.55,
    color: AppColors.textSecondary,
  );
}
