import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Available chat wallpaper themes.
enum ChatThemeStyle {
  /// Default dark doodle pattern.
  defaultDoodle,
  /// Solid dark — no pattern.
  solidDark,
  /// Brand gradient (navy → deep background).
  brandGradient,
  /// Warm sunset tones.
  warmSunset,
  /// Cool ocean tones.
  coolOcean,
}

extension ChatThemeStyleX on ChatThemeStyle {
  String get displayName => switch (this) {
        ChatThemeStyle.defaultDoodle => 'Default',
        ChatThemeStyle.solidDark => 'Solid Dark',
        ChatThemeStyle.brandGradient => 'Brand',
        ChatThemeStyle.warmSunset => 'Sunset',
        ChatThemeStyle.coolOcean => 'Ocean',
      };

  IconData get icon => switch (this) {
        ChatThemeStyle.defaultDoodle => Icons.grid_on,
        ChatThemeStyle.solidDark => Icons.dark_mode,
        ChatThemeStyle.brandGradient => Icons.gradient,
        ChatThemeStyle.warmSunset => Icons.wb_sunny,
        ChatThemeStyle.coolOcean => Icons.water,
      };
}

/// Dark charcoal background with a subtle doodle pattern for conversation screens.
///
/// Supports multiple [ChatThemeStyle] wallpapers. Uses a tiling PNG image
/// of scattered chat-themed icons at low contrast for the default theme.
class ChatBackground extends StatelessWidget {
  final ChatThemeStyle theme;

  const ChatBackground({super.key, this.theme = ChatThemeStyle.defaultDoodle});

  @override
  Widget build(BuildContext context) {
    return switch (theme) {
      ChatThemeStyle.defaultDoodle => _buildDoodle(),
      ChatThemeStyle.solidDark => const DecoratedBox(
          decoration: BoxDecoration(color: AppColors.chatBackground),
          child: SizedBox.expand(),
        ),
      ChatThemeStyle.brandGradient => const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF142978), AppColors.chatBackground],
            ),
          ),
          child: SizedBox.expand(),
        ),
      ChatThemeStyle.warmSunset => const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2D1B0E), Color(0xFF1A0E08), Color(0xFF0E0806)],
            ),
          ),
          child: SizedBox.expand(),
        ),
      ChatThemeStyle.coolOcean => const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0B1929), Color(0xFF0A1520), Color(0xFF060E14)],
            ),
          ),
          child: SizedBox.expand(),
        ),
    };
  }

  Widget _buildDoodle() {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.chatBackground),
      child: Opacity(
        opacity: 0.2,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chat_doodle_bg.png'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}

/// Bottom sheet for selecting a chat wallpaper theme.
class ChatThemePicker extends StatelessWidget {
  final ChatThemeStyle current;
  final ValueChanged<ChatThemeStyle> onSelected;

  const ChatThemePicker({
    super.key,
    required this.current,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Chat Wallpaper',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ChatThemeStyle.values.map((style) {
                final isSelected = style == current;
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onSelected(style);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surfaceElevated,
                          border: isSelected
                              ? Border.all(color: AppColors.primary, width: 2)
                              : null,
                        ),
                        child: Icon(
                          style.icon,
                          color:
                              isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        style.displayName,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
