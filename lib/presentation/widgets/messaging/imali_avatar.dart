import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Unified rounded-square avatar used across all messaging screens.
///
/// Ensures consistent shape language (WeChat-style rounded squares)
/// throughout conversation lists, message bubbles, pickers, and sheets.
class IMaliAvatar extends StatelessWidget {
  final String? imageUrl;
  final String displayName;
  final double size;
  final double radius;

  /// Optional accent color for the initials fallback background.
  /// Defaults to [AppColors.primary].
  final Color? accentColor;

  /// Optional badge widget shown at bottom-right (e.g. group icon overlay).
  final Widget? badge;

  /// Whether to show an online indicator dot.
  final bool showOnlineIndicator;

  const IMaliAvatar({
    super.key,
    this.imageUrl,
    required this.displayName,
    this.size = 48,
    this.radius = 6,
    this.accentColor,
    this.badge,
    this.showOnlineIndicator = false,
  });

  /// Compact variant for message bubbles and app bars.
  const IMaliAvatar.small({
    super.key,
    this.imageUrl,
    required this.displayName,
    this.size = 36,
    this.radius = 4,
    this.accentColor,
    this.badge,
    this.showOnlineIndicator = false,
  });

  /// Tiny variant for inline use (search results, chips).
  const IMaliAvatar.mini({
    super.key,
    this.imageUrl,
    required this.displayName,
    this.size = 32,
    this.radius = 4,
    this.accentColor,
    this.badge,
    this.showOnlineIndicator = false,
  });

  Color get _color => accentColor ?? AppColors.primary;

  String get _initials {
    if (displayName.isEmpty) return '??';
    final words = displayName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return displayName.substring(0, displayName.length.clamp(0, 2)).toUpperCase();
  }

  double get _fontSize {
    if (size <= 32) return 11;
    if (size <= 36) return 12;
    if (size <= 48) return 15;
    return 18;
  }

  @override
  Widget build(BuildContext context) {
    final initialsWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: _fontSize,
          color: _color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Widget avatar;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatar = CachedNetworkImage(
        imageUrl: imageUrl!,
        httpHeaders: const {'Connection': 'keep-alive'},
        fadeInDuration: const Duration(milliseconds: 150),
        imageBuilder: (_, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, _) => initialsWidget,
        errorWidget: (_, _, _) => initialsWidget,
      );
    } else {
      avatar = initialsWidget;
    }

    if (badge != null || showOnlineIndicator) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          if (badge != null)
            Positioned(
              bottom: -2,
              right: -2,
              child: badge!,
            ),
          if (showOnlineIndicator)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.28,
                height: size * 0.28,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.chatBackground,
                    width: 1.5,
                  ),
                ),
              ),
            ),
        ],
      );
    }

    return avatar;
  }
}
