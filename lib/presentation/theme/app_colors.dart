import 'package:flutter/material.dart';

/// Application color palette - iMali Brand Design System
class AppColors {
  AppColors._();

  // ============ PRIMARY COLORS ============
  // Hot pink - Primary CTAs and active states
  static const Color primary = Color(0xFFFF328C);
  static const Color primaryLight = Color(0xFFFF5CA3);
  static const Color primaryDark = Color(0xFFCC2870);

  // ============ SECONDARY COLORS ============
  // Electric cyan - Secondary accents and highlights
  static const Color secondary = Color(0xFF08C2F4);
  static const Color secondaryLight = Color(0xFF40D1F7);
  static const Color secondaryDark = Color(0xFF069BC3);

  // ============ TERTIARY COLORS ============
  // Orange Bright - Wallet cards and accents
  static const Color tertiary = Color(0xFFFF9900);
  static const Color tertiaryLight = Color(0xFFFFB84D);
  static const Color tertiaryDark = Color(0xFFCC7A00);

  // ============ ACCENT COLORS ============
  // Blue - Modal backgrounds and special surfaces
  static const Color accent = Color(0xFF0974FF);
  static const Color accentLight = Color(0xFF4D9AFF);
  static const Color accentDark = Color(0xFF075DCC);

  // ============ BRAND COLORS ============
  // Purple - Used for gradients and special elements
  static const Color purple = Color(0xFFA011FF);
  static const Color purpleLight = Color(0xFFB84DFF);
  static const Color purpleDark = Color(0xFF800DCC);

  // Orange - Used for gradients and status
  static const Color orange = Color(0xFFFF6429);
  static const Color orangeLight = Color(0xFFFF8A5C);
  static const Color orangeDark = Color(0xFFCC5021);

  // Gold - Token colors and rewards
  static const Color gold = Color(0xFFFFB82C);
  static const Color goldLight = Color(0xFFFFCC66);
  static const Color goldDark = Color(0xFFCC9323);

  // ============ BACKGROUND COLORS ============
  // Deep dark - Main app background
  static const Color background = Color(0xFF0C1124);
  static const Color backgroundDark = Color(0xFF0C1124);
  static const Color backgroundLight = Color(0xFFF5F7FA);

  // Surface colors for cards and elevated elements
  static const Color surface = Color(0xFF13161D);
  static const Color surfaceDark = Color(0xFF13161D);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFF1A1E2A);

  // Card backgrounds
  static const Color card = Color(0xFF13161D);
  static const Color cardDark = Color(0xFF13161D);
  static const Color cardElevated = Color(0xFF1E2233);

  // ============ TEXT COLORS ============
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8899A6);
  static const Color textTertiary = Color(0xFF5C6E7F);
  static const Color textHint = Color(0xFF4A5A6A);
  static const Color textOnPrimary = Color(0xFF0D1028);
  static const Color textOnSecondary = Color(0xFF0C1124);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF8899A6);

  // ============ STATUS COLORS ============
  static const Color success = Color(0xFF00E676);
  static const Color successLight = Color(0xFF69F0AE);
  static const Color successDark = Color(0xFF00C853);
  static const Color warning = Color(0xFFFF9900);
  static const Color warningLight = Color(0xFFFFB84D);
  static const Color warningDark = Color(0xFFCC7A00);
  static const Color error = Color(0xFFFF5252);
  static const Color errorLight = Color(0xFFFF8A80);
  static const Color errorDark = Color(0xFFD32F2F);
  static const Color info = Color(0xFF08C2F4);
  static const Color infoLight = Color(0xFF40D1F7);
  static const Color infoDark = Color(0xFF069BC3);

  // ============ TOKEN/MONEY COLORS ============
  static const Color tokenGold = Color(0xFFFFB82C);
  static const Color tokenSilver = Color(0xFFC0C0C0);
  static const Color tokenBronze = Color(0xFFCD7F32);
  static const Color money = Color(0xFF00E676);
  static const Color moneyNegative = Color(0xFFFF5252);

  // ============ NOTIFICATION BADGE COLORS ============
  static const Color badge = Color(0xFFFFB82C);
  static const Color badgeText = Color(0xFF0C1124);

  // ============ POT COLORS ============
  static const Color potActive = Color(0xFFFF328C);
  static const Color potPending = Color(0xFFFF9900);
  static const Color potCompleted = Color(0xFF08C2F4);
  static const Color potWinner = Color(0xFFFFB82C);

  // ============ WALLET CARD COLORS ============
  static const Color walletZawadi = Color(0xFFFF9900);
  static const Color walletPrimary = Color(0xFFFF328C);
  static const Color walletSecondary = Color(0xFF08C2F4);

  // ============ DIVIDERS & BORDERS ============
  static const Color divider = Color(0xFF1E2233);
  static const Color dividerDark = Color(0xFF1E2233);
  static const Color border = Color(0xFF2A2E3D);
  static const Color borderDark = Color(0xFF2A2E3D);
  static const Color borderFocused = Color(0xFFFF328C);

  // ============ SHIMMER COLORS ============
  static const Color shimmerBase = Color(0xFF13161D);
  static const Color shimmerHighlight = Color(0xFF1E2233);
  static const Color shimmerBaseDark = Color(0xFF13161D);
  static const Color shimmerHighlightDark = Color(0xFF1E2233);

  // ============ TOGGLE/SWITCH COLORS ============
  static const Color switchActive = Color(0xFFFF328C);
  static const Color switchInactive = Color(0xFF4A5A6A);
  static const Color switchTrackActive = Color(0x40FF328C);
  static const Color switchTrackInactive = Color(0xFF2A3A4A);

  // ============ BOTTOM NAV COLORS ============
  static const Color navActive = Color(0xFFFF328C);
  static const Color navInactive = Color(0xFF8899A6);
  static const Color navBackground = Color(0xFF0C1124);

  // ============ GRADIENTS ============
  // Background gradient (180deg, #142978 → #0C1124)
  static const List<Color> backgroundGradient = [
    Color(0xFF142978),
    Color(0xFF0C1124),
  ];

  // Logo gradient (90deg, #FF9900 → #FF328C)
  static const List<Color> logoGradient = [
    Color(0xFFFF9900),
    Color(0xFFFF328C),
  ];

  // Primary gradient (Pink-Purple: 90deg, #FF328C → #A011FF)
  static const List<Color> primaryGradient = [
    Color(0xFFFF328C),
    Color(0xFFA011FF),
  ];

  // Secondary gradient (Cyan-Blue: 90deg, #08C2F4 → #0974FF)
  static const List<Color> secondaryGradient = [
    Color(0xFF08C2F4),
    Color(0xFF0974FF),
  ];

  // Tertiary gradient (Gold-Orange: 90deg, #FFB82C → #FF6429)
  static const List<Color> tertiaryGradient = [
    Color(0xFFFFB82C),
    Color(0xFFFF6429),
  ];

  static const List<Color> goldGradient = [
    Color(0xFFFFB82C),
    Color(0xFFFF6429),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF142978),
    Color(0xFF0C1124),
  ];

  static const List<Color> modalGradient = [
    Color(0xFF0974FF),
    Color(0xFF075DCC),
  ];

  static const List<Color> walletCardGradient = [
    Color(0xFFFF9900),
    Color(0xFFFF328C),
  ];

  // ============ CHAT COLORS ============
  // Dark charcoal background for conversation screens (like WhatsApp/WeChat)
  static const Color chatBackground = Color(0xFF111111);
  static const Color chatAppBar = Color(0xFF1A0D12); // Dark with subtle pink undertone
  static const Color chatDoodle = Color(0xFF1A1A1A); // Very subtle pattern on dark bg

  // WeChat-style bright bubbles on dark background
  static const Color chatBubbleSent = Color(0xFF95EC69); // WeChat green
  static const Color chatBubbleReceived = Color(0xFF3A3A3C); // Mid grey
  static const Color chatBubbleText = Color(0xFF000000); // Black text on sent bubbles
  static const Color chatBubbleReceivedText = Color(0xFFFFFFFF); // White text on received bubbles
  static const Color chatBubbleTimestamp = Color(0xFF666666); // Grey timestamp on bubbles
  static const Color chatInputBackground = Color(0xFF13161D);
  static const Color chatTimestamp = Color(0xFF5C6E7F);

  // ============ INPUT COLORS ============
  static const Color inputBackground = Color(0xFF13161D);
  static const Color inputBorder = Color(0xFF2A2E3D);
  static const Color inputBorderFocused = Color(0xFFFF328C);
  static const Color inputFill = Color(0xFF0C1124);

  /// Safely parses a hex color string (e.g. '#FF328C') to a [Color].
  /// Returns [fallback] if the string is null or malformed.
  static Color parseHex(String? hex, {Color fallback = primary}) {
    if (hex == null || hex.isEmpty) return fallback;
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return fallback;
    }
  }
}
