import 'package:flutter/material.dart';

/// Application color palette
abstract class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFFFF338A);
  static const Color primaryLight = Color(0xFFFF6AAB);
  static const Color primaryDark = Color(0xFFCC2A6E);

  // Secondary (Accent) - Yellow/Gold
  static const Color secondary = Color(0xFFFFC107);
  static const Color secondaryLight = Color(0xFFFFD54F);
  static const Color secondaryDark = Color(0xFFFFA000);

  // Background Colors
  static const Color background = Color(0xFF0B1929);
  static const Color backgroundLight = Color(0xFF0F2744);
  static const Color card = Color(0xFF132D4A);
  static const Color cardLight = Color(0xFF1A3A5C);

  // Surface Colors
  static const Color surface = Color(0xFF132D4A);
  static const Color surfaceVariant = Color(0xFF1A3A5C);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF4B5563);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color warning = Color(0xFFF97316);
  static const Color warningLight = Color(0xFFFB923C);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);

  // Pot Theme Colors
  static const Color dailyPot = Color(0xFFFFC107);
  static const Color dailyPotLight = Color(0xFFFFD54F);
  static const Color weeklyPot = Color(0xFFA855F7);
  static const Color weeklyPotLight = Color(0xFFC084FC);

  // Transaction Type Colors
  static const Color earnColor = Color(0xFF10B981);
  static const Color potWinColor = Color(0xFFFFC107);
  static const Color p2pColor = Color(0xFF3B82F6);
  static const Color cashoutColor = Color(0xFFA855F7);
  static const Color purchaseColor = Color(0xFFEC4899);

  // Borders & Dividers
  static const Color border = Color(0x1AFFFFFF); // white/10
  static const Color borderLight = Color(0x0DFFFFFF); // white/5
  static const Color divider = Color(0x1AFFFFFF);

  // Overlays
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x40000000); // 25% black

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFF6B9D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, Color(0xFFFFD54F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0B2A55), Color(0xFF05152A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0F2744), background],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient dailyPotGradient = LinearGradient(
    colors: [Color(0x33FFC107), Color(0x1AFF9800)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient weeklyPotGradient = LinearGradient(
    colors: [Color(0x33A855F7), Color(0x1AEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient airtimeGradient = LinearGradient(
    colors: [Color(0x661E3A5F), Color(0x330F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient electricityGradient = LinearGradient(
    colors: [Color(0x66422006), Color(0x33451A03)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static const Color shadowPrimary = Color(0x4DFF338A);
  static const Color shadowDark = Color(0x40000000);

  // Token Gold (used in price displays)
  static const Color tokenGold = Color(0xFFFFC107);

  // ── Buy Tab Light Theme Tokens (Spec §2) ──

  // Backgrounds
  static const Color buyBackground = Color(0xFFF5F7FA);
  static const Color buyCard = Color(0xFFFFFFFF);
  static const Color buyCardBorder = Color(0xFFE8ECF1);
  static const Color buyDivider = Color(0xFFEAECF0);
  static const Color buyChipBg = Color(0xFFF1F5F9);
  static const Color buyChipBorder = Color(0xFFE2E8F0);
  static const Color buyShadow = Color(0x0D000000); // rgba(0,0,0,0.05)

  // Text
  static const Color buyTextPrimary = Color(0xFF1A1A2E);
  static const Color buyTextSecondary = Color(0xFF64748B);
  static const Color buyTextTertiary = Color(0xFF94A3B8);

  // Status
  static const Color buyError = Color(0xFFDC2626);
  static const Color buyWarning = Color(0xFFF59E0B);
  static const Color buySuccess = Color(0xFF059669);

  // Feature Accents
  static const Color buyGroupBuyAccent = Color(0xFF059669);
  static const Color buyGroupBuyAccentLight = Color(0xFF10B981);
  static const Color buyMarketplaceAccent = Color(0xFF08C2F4);
  static const Color buyMarketplaceAccentDark = Color(0xFF0974FF);

  // Offline Banner
  static const Color buyOfflineBg = Color(0xFFFFF8E1);
  static const Color buyOfflineBorder = Color(0xFFFFE082);
  static const Color buyOfflineText = Color(0xFFB45309);

  // Shimmer
  static const Color buyShimmerBase = Color(0xFFE2E8F0);
  static const Color buyShimmerHigh = Color(0xFFF1F5F9);
}
