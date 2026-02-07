import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

/// Shared AppBar for consistent branding across all screens.
/// Layout: [Back (auto)] | Title | [extraActions] | Notifications | Profile
class IMaliAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? extraActions;
  final PreferredSizeWidget? bottom;

  const IMaliAppBar({
    super.key,
    required this.title,
    this.extraActions,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    const mascot = Padding(
      padding: EdgeInsets.all(8),
      child: Image(
        image: AssetImage('assets/icons/elephantFinal1.png'),
        width: 32,
        height: 32,
      ),
    );

    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leadingWidth: canPop ? 88 : 48,
      leading: canPop
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: AppColors.textPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                mascot,
              ],
            )
          : mascot,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
      actions: [
        if (extraActions != null) ...extraActions!,
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notifications coming soon'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          tooltip: 'Notifications',
        ),
        IconButton(
          icon: const Icon(
            Icons.person_outline,
            color: AppColors.textSecondary,
          ),
          onPressed: () => context.push('/home/profile'),
          tooltip: 'Profile',
        ),
      ],
      bottom: bottom,
    );
  }
}
