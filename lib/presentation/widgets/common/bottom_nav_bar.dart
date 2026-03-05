import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

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
      assetPath: 'assets/botton_nav_bar_icons/Bottom Icon - Earn icon.png',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
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
              return _buildNavItem(item, isActive, index);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(_NavItem item, bool isActive, int index) {
    // Show badge for Chat tab (index 2) when there are unread messages
    final badgeCount = index == 2 ? chatUnreadCount : 0;

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
                    opacity: isActive ? 1.0 : 0.45,
                    child: Image.asset(
                      item.assetPath,
                      width: 28,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
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
                    ? AppColors.textPrimary
                    : AppColors.navInactive,
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
  final String assetPath;

  const _NavItem({
    required this.label,
    required this.assetPath,
  });
}
