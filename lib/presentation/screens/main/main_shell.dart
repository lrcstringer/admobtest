import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/di/injection.dart';
import '../../../core/services/notification_service.dart';
import '../../blocs/community/community_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../../widgets/messaging/active_call_overlay.dart';

/// Main shell scaffold used by all primary app screens.
/// Provides the background color and custom bottom nav bar.
/// Individual screens provide their own AppBar via IMaliAppBar.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  /// SharedPreferences key for persisting the last active tab index.
  /// Used to restore the correct tab after Android process death.
  static const lastTabKey = 'last_active_tab';

  /// Tab root paths in branch order.
  static const tabPaths = ['/home', '/earn', '/chat', '/buy', '/wallet'];

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    // Combine unread counts from both conversation and community BLoCs
    final convUnread =
        context.watch<ConversationBloc>().state.totalUnreadCount;
    final commUnread = context.watch<CommunityBloc>().state.totalUnreadCount;
    final totalUnread = convUnread + commUnread;

    // Sync the launcher icon badge count (idempotent, cheap to call on rebuild)
    NotificationService.updateBadgeCount(totalUnread);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const ActiveCallOverlay(),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        chatUnreadCount: totalUnread,
        onTap: (index) {
          // Persist the selected tab so we can restore it after process death.
          getIt<SharedPreferences>().setInt(lastTabKey, index);
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
