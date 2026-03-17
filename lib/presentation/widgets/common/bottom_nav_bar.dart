import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/themed_colors.dart';

/// Custom bottom navigation bar with brand gradient PNG icons.
/// Styled to match the iMali brand (not flat Material 3).
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  /// Unread badge count for the Chat tab (index 2).
  final int chatUnreadCount;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.chatUnreadCount = 0,
  });

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      assetPath: 'assets/botton_nav_bar_icons/Bottom Nav - Home icon.png',
    ),
    _NavItem(
      label: 'Earn',
      assetPath: 'assets/botton_nav_bar_icons/Bottom Nav - Cup2.png',
    ),
    _NavItem(
      label: 'Chat',
      assetPath: 'assets/botton_nav_bar_icons/Botton Nav - Chat icon.png',
    ),
    _NavItem(
      label: 'Buy',
      assetPath: 'assets/botton_nav_bar_icons/Bottom Nav - Buy icon.png',
    ),
    _NavItem(
      label: 'Wallet',
      assetPath: 'assets/botton_nav_bar_icons/Bottom Nav - Wallet icon.png',
    ),
  ];

  /// Buy tab always uses light chrome regardless of theme mode.
  static const _buyTabIndex = 3;
  /// Chat tab always uses dark chrome regardless of theme mode.
  static const _chatTabIndex = 2;

  @override
  Widget build(BuildContext context) {
    final themed = AppColors.themed(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBuyTab = currentIndex == _buyTabIndex;
    final isChatTab = currentIndex == _chatTabIndex;

    // Buy tab always white, Chat tab always dark, others follow theme.
    final Color navBg;
    if (isBuyTab) {
      navBg = const Color(0xFFFFFFFF);
    } else if (isChatTab) {
      navBg = ThemedColors.dark.navBackground;
    } else {
      navBg = themed.navBackground;
    }

    return Container(
      decoration: BoxDecoration(
        color: navBg,
        border: Border(
          top: BorderSide(
            color: isDark ? Theme.of(context).dividerColor : const Color(0xFFE8ECF1),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isActive = index == currentIndex;
              // Buy tab = always light icons, Chat tab = always dark icons
              final effectiveDark = isChatTab || (isDark && !isBuyTab);
              return _buildNavItem(
                context,
                item,
                isActive,
                index,
                isDark: effectiveDark,
                themed: themed,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    _NavItem item,
    bool isActive,
    int index, {
    required bool isDark,
    required ThemedColors themed,
  }) {
    // Show badge for Chat tab (index 2) when there are unread messages
    final badgeCount = index == 2 ? chatUnreadCount : 0;

    // PNG icons are gradient-colored — use them as-is in all modes.
    Widget buildIcon() {
      if (item.assetPath != null) {
        return Image.asset(
          item.assetPath!,
          width: 28,
          height: 28,
          fit: BoxFit.contain,
        );
      }
      return Icon(
        item.icon,
        size: 28,
      );
    }

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with optional glow + badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: isActive
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ],
                        )
                      : null,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isActive ? 1.0 : (isDark ? 0.45 : 0.7),
                    child: buildIcon(),
                  ),
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(minWidth: 18),
                      child: Text(
                        badgeCount > 99 ? '99+' : '$badgeCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              item.label,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
                    ? (isDark ? Theme.of(context).colorScheme.onSurface : const Color(0xFF1A1A2E))
                    : (isDark ? themed.navInactive : const Color(0xFF94A3B8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String? assetPath;
  final IconData? icon;

  const _NavItem({
    required this.label,
    this.assetPath,
    this.icon,
  }) : assert(assetPath != null || icon != null);
}
