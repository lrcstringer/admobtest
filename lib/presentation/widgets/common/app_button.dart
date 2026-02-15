import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, outline, text, danger }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final IconData? trailingIcon;
  final String? loadingText;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.trailingIcon,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = _getHeight();
    final textStyle = _getTextStyle(context);
    final isDisabled = onPressed == null || isLoading;

    Widget child = isLoading
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(_getLoadingColor()),
                ),
              ),
              if (loadingText != null) ...[
                SizedBox(width: AppSpacing.sm),
                Text(loadingText!, style: textStyle),
              ],
            ],
          )
        : Row(
            mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: _getIconSize()),
                SizedBox(width: AppSpacing.xs),
              ],
              Text(text, style: textStyle),
              if (trailingIcon != null) ...[
                SizedBox(width: AppSpacing.xs),
                Icon(trailingIcon, size: _getIconSize()),
              ],
            ],
          );

    switch (variant) {
      case AppButtonVariant.primary:
        return Container(
          width: isFullWidth ? double.infinity : null,
          height: buttonHeight,
          decoration: BoxDecoration(
            gradient: isDisabled
                ? null
                : const LinearGradient(colors: AppColors.primaryGradient),
            color: isDisabled
                ? AppColors.primary.withValues(alpha: 0.3)
                : null,
            borderRadius: AppSpacing.borderRadiusRound,
          ),
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              disabledForegroundColor:
                  AppColors.textOnPrimary.withValues(alpha: 0.5),
              minimumSize: isFullWidth ? null : Size(0, buttonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: AppSpacing.borderRadiusRound,
              ),
            ),
            child: child,
          ),
        );

      case AppButtonVariant.secondary:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.textOnSecondary,
              minimumSize: isFullWidth ? null : Size(0, buttonHeight),
            ),
            child: child,
          ),
        );

      case AppButtonVariant.outline:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: buttonHeight,
          child: OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: isFullWidth
                ? null
                : OutlinedButton.styleFrom(
                    minimumSize: Size(0, buttonHeight),
                  ),
            child: child,
          ),
        );

      case AppButtonVariant.text:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          child: child,
        );

      case AppButtonVariant.danger:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.textOnPrimary,
              minimumSize: isFullWidth ? null : Size(0, buttonHeight),
            ),
            child: child,
          ),
        );
    }
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return AppSpacing.buttonHeightSm;
      case AppButtonSize.medium:
        return AppSpacing.buttonHeightMd;
      case AppButtonSize.large:
        return AppSpacing.buttonHeightLg;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.labelLarge;
    switch (size) {
      case AppButtonSize.small:
        return baseStyle?.copyWith(fontSize: 12);
      case AppButtonSize.medium:
        return baseStyle?.copyWith(fontSize: 14);
      case AppButtonSize.large:
        return baseStyle?.copyWith(fontSize: 16);
    }
  }

  Color _getLoadingColor() {
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.secondary:
      case AppButtonVariant.danger:
        return AppColors.textOnPrimary;
      case AppButtonVariant.outline:
      case AppButtonVariant.text:
        return AppColors.primary;
    }
  }
}
