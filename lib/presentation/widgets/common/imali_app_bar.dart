import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shared AppBar for consistent branding across all screens.
/// Layout: [Back (auto)] | Title | [extraActions] | Notifications | Profile
class IMaliAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? extraActions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const IMaliAppBar({
    super.key,
    required this.title,
    this.extraActions,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final onSurface = foregroundColor ?? Theme.of(context).colorScheme.onSurface;
    final onSurfaceVariant =
        foregroundColor?.withAlpha(179) ?? Theme.of(context).colorScheme.onSurfaceVariant;

    const mascot = Padding(
      padding: EdgeInsets.all(4),
      child: Image(
        image: AssetImage('assets/icons/iMaliCrown4.png'),
        width: 48,
        height: 48,
      ),
    );

    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leadingWidth: canPop ? 104 : 56,
      leading: canPop
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: onSurface),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                mascot,
              ],
            )
          : mascot,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
      ),
      centerTitle: true,
      actions: [
        if (extraActions != null) ...extraActions!,
        IconButton(
          icon: Icon(
            Icons.info_outline,
            color: onSurfaceVariant,
          ),
          onPressed: () => context.push('/home/profile/settings/help'),
          tooltip: 'Help',
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: onSurfaceVariant,
          ),
          onPressed: () {
            // Notifications screen not yet wired
          },
          tooltip: 'Notifications',
        ),
        IconButton(
          icon: Icon(
            Icons.person_outline,
            color: onSurfaceVariant,
          ),
          onPressed: () => context.push('/home/profile'),
          tooltip: 'Profile',
        ),
      ],
      bottom: bottom,
    );
  }
}
