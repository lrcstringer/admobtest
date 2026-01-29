import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Application theme configuration - iMali Brand Design System
class AppTheme {
  AppTheme._();

  /// Light theme (kept for compatibility, app is dark-first)
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: _lightColorScheme,
        textTheme: AppTypography.textTheme,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        appBarTheme: _lightAppBarTheme,
        cardTheme: _lightCardTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        filledButtonTheme: _filledButtonTheme,
        inputDecorationTheme: _lightInputDecorationTheme,
        bottomNavigationBarTheme: _lightBottomNavTheme,
        navigationBarTheme: _lightNavigationBarTheme,
        floatingActionButtonTheme: _fabTheme,
        dividerTheme: _lightDividerTheme,
        chipTheme: _lightChipTheme,
        snackBarTheme: _snackBarTheme,
        dialogTheme: _lightDialogTheme,
        bottomSheetTheme: _lightBottomSheetTheme,
        listTileTheme: _lightListTileTheme,
        tabBarTheme: _lightTabBarTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        switchTheme: _switchTheme,
        checkboxTheme: _checkboxTheme,
        radioTheme: _radioTheme,
        iconTheme: _lightIconTheme,
        badgeTheme: _badgeTheme,
      );

  /// Dark theme (Primary theme for iMali design)
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: _darkColorScheme,
        textTheme: AppTypography.darkTextTheme,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        appBarTheme: _darkAppBarTheme,
        cardTheme: _darkCardTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        filledButtonTheme: _filledButtonTheme,
        inputDecorationTheme: _darkInputDecorationTheme,
        bottomNavigationBarTheme: _darkBottomNavTheme,
        navigationBarTheme: _darkNavigationBarTheme,
        floatingActionButtonTheme: _fabTheme,
        dividerTheme: _darkDividerTheme,
        chipTheme: _darkChipTheme,
        snackBarTheme: _snackBarTheme,
        dialogTheme: _darkDialogTheme,
        bottomSheetTheme: _darkBottomSheetTheme,
        listTileTheme: _darkListTileTheme,
        tabBarTheme: _darkTabBarTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        switchTheme: _switchTheme,
        checkboxTheme: _checkboxTheme,
        radioTheme: _radioTheme,
        iconTheme: _darkIconTheme,
        badgeTheme: _badgeTheme,
      );

  // ============ COLOR SCHEMES ============

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryLight,
    tertiary: AppColors.tertiary,
    tertiaryContainer: AppColors.tertiaryLight,
    surface: AppColors.surfaceLight,
    error: AppColors.error,
    onPrimary: AppColors.textOnPrimary,
    onSecondary: AppColors.textOnSecondary,
    onSurface: AppColors.textPrimary,
    onError: AppColors.textOnPrimary,
    outline: AppColors.border,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryDark,
    tertiary: AppColors.tertiary,
    tertiaryContainer: AppColors.tertiaryDark,
    surface: AppColors.surfaceDark,
    error: AppColors.error,
    onPrimary: AppColors.textOnPrimary,
    onSecondary: AppColors.textOnSecondary,
    onSurface: AppColors.textPrimaryDark,
    onError: AppColors.textOnPrimary,
    outline: AppColors.borderDark,
  );

  // ============ APP BAR THEMES ============

  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textPrimary,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textPrimaryDark,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
  );

  // ============ CARD THEMES ============

  static CardThemeData get _lightCardTheme => CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
        color: AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
      );

  static CardThemeData get _darkCardTheme => CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
        color: AppColors.cardDark,
        surfaceTintColor: Colors.transparent,
      );

  // ============ BUTTON THEMES ============

  /// Primary elevated button - Pill shaped with brand pink background
  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
          disabledForegroundColor: AppColors.textOnPrimary.withValues(alpha: 0.5),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusRound, // Pill shape
          ),
          textStyle: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  /// Outlined button - Pill shaped with pink border
  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.primary.withValues(alpha: 0.3),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusRound, // Pill shape
          ),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  /// Text button
  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: AppSpacing.buttonPaddingSmall,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusRound,
          ),
          textStyle: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  /// Filled button - For secondary actions
  static FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          disabledBackgroundColor: AppColors.surface.withValues(alpha: 0.3),
          disabledForegroundColor: AppColors.textPrimary.withValues(alpha: 0.5),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusRound,
          ),
          textStyle: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  // ============ INPUT DECORATION THEMES ============

  static InputDecorationTheme get _lightInputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: AppSpacing.inputPadding,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.textHint,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.textSecondary,
        ),
        errorStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.error,
          fontSize: 12,
        ),
      );

  static InputDecorationTheme get _darkInputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding: AppSpacing.inputPadding,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.inputBorderFocused, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.textHint,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.textSecondary,
        ),
        errorStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.error,
          fontSize: 12,
        ),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
      );

  // ============ BOTTOM NAVIGATION THEMES ============

  static const BottomNavigationBarThemeData _lightBottomNavTheme =
      BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.surfaceLight,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondary,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  static const BottomNavigationBarThemeData _darkBottomNavTheme =
      BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.navBackground,
    selectedItemColor: AppColors.navActive,
    unselectedItemColor: AppColors.navInactive,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  // Navigation Bar (Material 3)
  static NavigationBarThemeData get _lightNavigationBarTheme =>
      NavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: AppColors.primary.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            );
          }
          return const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary, size: 24);
          }
          return const IconThemeData(color: AppColors.textSecondary, size: 24);
        }),
      );

  static NavigationBarThemeData get _darkNavigationBarTheme =>
      NavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.navBackground,
        indicatorColor: AppColors.navActive.withValues(alpha: 0.2),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.navActive,
            );
          }
          return const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.navInactive,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.navActive, size: 24);
          }
          return const IconThemeData(color: AppColors.navInactive, size: 24);
        }),
      );

  // ============ FAB THEME ============

  static FloatingActionButtonThemeData get _fabTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
      );

  // ============ DIVIDER THEMES ============

  static const DividerThemeData _lightDividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: 1,
  );

  static const DividerThemeData _darkDividerTheme = DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 1,
    space: 1,
  );

  // ============ CHIP THEMES ============

  static ChipThemeData get _lightChipTheme => ChipThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedColor: AppColors.primaryLight,
        disabledColor: AppColors.surfaceLight,
        labelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  static ChipThemeData get _darkChipTheme => ChipThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        disabledColor: AppColors.surfaceDark,
        labelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          color: AppColors.textPrimaryDark,
        ),
        side: const BorderSide(color: AppColors.borderDark),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  // ============ SNACKBAR THEME ============

  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.surface,
        contentTextStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        actionTextColor: AppColors.primary,
      );

  // ============ DIALOG THEMES ============

  static DialogThemeData get _lightDialogTheme => DialogThemeData(
        backgroundColor: AppColors.surfaceLight,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
      );

  static DialogThemeData get _darkDialogTheme => DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
        surfaceTintColor: Colors.transparent,
      );

  // ============ BOTTOM SHEET THEMES ============

  static BottomSheetThemeData get _lightBottomSheetTheme =>
      BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        modalBackgroundColor: AppColors.surfaceLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
        dragHandleColor: AppColors.textHint,
        dragHandleSize: const Size(40, 4),
      );

  static BottomSheetThemeData get _darkBottomSheetTheme => BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        modalBackgroundColor: AppColors.surfaceDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
        dragHandleColor: AppColors.textSecondary,
        dragHandleSize: const Size(40, 4),
        surfaceTintColor: Colors.transparent,
      );

  // ============ LIST TILE THEMES ============

  static const ListTileThemeData _lightListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    minLeadingWidth: AppSpacing.iconMd,
    horizontalTitleGap: AppSpacing.md,
    iconColor: AppColors.textSecondary,
    textColor: AppColors.textPrimary,
  );

  static const ListTileThemeData _darkListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    minLeadingWidth: AppSpacing.iconMd,
    horizontalTitleGap: AppSpacing.md,
    iconColor: AppColors.textSecondary,
    textColor: AppColors.textPrimaryDark,
  );

  // ============ TAB BAR THEMES ============

  static TabBarThemeData get _lightTabBarTheme => TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );

  static TabBarThemeData get _darkTabBarTheme => TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondaryDark,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );

  // ============ PROGRESS INDICATOR THEME ============

  static const ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.divider,
    circularTrackColor: AppColors.divider,
  );

  // ============ SWITCH THEME ============

  static SwitchThemeData get _switchTheme => SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.textOnPrimary;
          }
          return AppColors.switchInactive;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.switchActive;
          }
          return AppColors.switchTrackInactive;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return AppColors.switchTrackInactive;
        }),
      );

  // ============ CHECKBOX THEME ============

  static CheckboxThemeData get _checkboxTheme => CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        side: const BorderSide(color: AppColors.textSecondary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
        ),
      );

  // ============ RADIO THEME ============

  static RadioThemeData get _radioTheme => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textSecondary;
        }),
      );

  // ============ ICON THEMES ============

  static const IconThemeData _lightIconTheme = IconThemeData(
    color: AppColors.textPrimary,
    size: 24,
  );

  static const IconThemeData _darkIconTheme = IconThemeData(
    color: AppColors.textPrimaryDark,
    size: 24,
  );

  // ============ BADGE THEME ============

  static const BadgeThemeData _badgeTheme = BadgeThemeData(
    backgroundColor: AppColors.badge,
    textColor: AppColors.badgeText,
    textStyle: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
  );

  // ============ CUSTOM BUTTON STYLES ============

  /// Secondary button style (surface colored, pill shaped)
  static ButtonStyle get secondaryButtonStyle => ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );

  /// Accent button style (cyan colored, pill shaped)
  static ButtonStyle get accentButtonStyle => ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textOnSecondary,
        minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );

  /// Small button style
  static ButtonStyle get smallButtonStyle => ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        minimumSize: const Size(0, AppSpacing.buttonHeightSm),
        padding: AppSpacing.buttonPaddingSmall,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );

  /// Ghost button style (transparent with primary text)
  static ButtonStyle get ghostButtonStyle => TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: AppSpacing.buttonPaddingSmall,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );

  /// Modal action button style (for bottom sheet CTAs)
  static ButtonStyle get modalActionButtonStyle => ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textOnPrimary,
        minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );
}
