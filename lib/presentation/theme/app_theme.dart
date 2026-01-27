import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Application theme configuration
class AppTheme {
  AppTheme._();

  /// Light theme
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: _lightColorScheme,
        textTheme: AppTypography.textTheme,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: _lightAppBarTheme,
        cardTheme: _lightCardTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _lightInputDecorationTheme,
        bottomNavigationBarTheme: _lightBottomNavTheme,
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
      );

  /// Dark theme
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
        inputDecorationTheme: _darkInputDecorationTheme,
        bottomNavigationBarTheme: _darkBottomNavTheme,
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
      );

  // Color schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryLight,
    tertiary: AppColors.accent,
    tertiaryContainer: AppColors.accentLight,
    surface: AppColors.surface,
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
    tertiary: AppColors.accent,
    tertiaryContainer: AppColors.accentDark,
    surface: AppColors.surfaceDark,
    error: AppColors.error,
    onPrimary: AppColors.textOnPrimary,
    onSecondary: AppColors.textOnSecondary,
    onSurface: AppColors.textPrimaryDark,
    onError: AppColors.textOnPrimary,
    outline: AppColors.borderDark,
  );

  // AppBar themes
  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: true,
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: true,
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.textPrimaryDark,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  // Card themes
  static CardThemeData get _lightCardTheme => CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        color: AppColors.card,
        surfaceTintColor: Colors.transparent,
      );

  static CardThemeData get _darkCardTheme => CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        color: AppColors.cardDark,
        surfaceTintColor: Colors.transparent,
      );

  // Button themes
  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
          disabledForegroundColor: AppColors.textOnPrimary.withValues(alpha: 0.7),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          textStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.primary.withValues(alpha: 0.5),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeightMd),
          padding: AppSpacing.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: AppSpacing.buttonPaddingSmall,
          textStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  // Input decoration themes
  static InputDecorationTheme get _lightInputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: AppSpacing.inputPadding,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Outfit',
          color: AppColors.textHint,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Outfit',
          color: AppColors.textSecondary,
        ),
        errorStyle: const TextStyle(
          fontFamily: 'Outfit',
          color: AppColors.error,
          fontSize: 12,
        ),
      );

  static InputDecorationTheme get _darkInputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: AppSpacing.inputPadding,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Outfit',
          color: AppColors.textSecondaryDark,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Outfit',
          color: AppColors.textSecondaryDark,
        ),
        errorStyle: const TextStyle(
          fontFamily: 'Outfit',
          color: AppColors.error,
          fontSize: 12,
        ),
      );

  // Bottom navigation bar themes
  static const BottomNavigationBarThemeData _lightBottomNavTheme =
      BottomNavigationBarThemeData(
    elevation: 8,
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondary,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  static const BottomNavigationBarThemeData _darkBottomNavTheme =
      BottomNavigationBarThemeData(
    elevation: 8,
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondaryDark,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  // FAB theme
  static FloatingActionButtonThemeData get _fabTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
      );

  // Divider themes
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

  // Chip themes
  static ChipThemeData get _lightChipTheme => ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primaryLight,
        disabledColor: AppColors.surface,
        labelStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
      );

  static ChipThemeData get _darkChipTheme => ChipThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedColor: AppColors.primaryDark,
        disabledColor: AppColors.surfaceDark,
        labelStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          color: AppColors.textPrimaryDark,
        ),
        side: const BorderSide(color: AppColors.borderDark),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusRound,
        ),
      );

  // SnackBar theme
  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: const TextStyle(
          fontFamily: 'Outfit',
          color: AppColors.textOnPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusSm,
        ),
      );

  // Dialog themes
  static DialogThemeData get _lightDialogTheme => DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
      );

  static DialogThemeData get _darkDialogTheme => DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
      );

  // Bottom sheet themes
  static BottomSheetThemeData get _lightBottomSheetTheme =>
      BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        modalBackgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
      );

  static BottomSheetThemeData get _darkBottomSheetTheme => BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        modalBackgroundColor: AppColors.surfaceDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
      );

  // List tile themes
  static const ListTileThemeData _lightListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    minLeadingWidth: AppSpacing.iconMd,
    horizontalTitleGap: AppSpacing.md,
  );

  static const ListTileThemeData _darkListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    minLeadingWidth: AppSpacing.iconMd,
    horizontalTitleGap: AppSpacing.md,
  );

  // Tab bar themes
  static TabBarThemeData get _lightTabBarTheme => TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );

  static TabBarThemeData get _darkTabBarTheme => TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondaryDark,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );

  // Progress indicator theme
  static const ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.divider,
    circularTrackColor: AppColors.divider,
  );

  // Switch theme
  static SwitchThemeData get _switchTheme => SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.divider;
        }),
      );

  // Checkbox theme
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

  // Radio theme
  static RadioThemeData get _radioTheme => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textSecondary;
        }),
      );
}
