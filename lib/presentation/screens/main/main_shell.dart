import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/community/community_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../widgets/common/bottom_nav_bar.dart';

/// Main shell scaffold used by all primary app screens.
/// Provides the background color and custom bottom nav bar.
/// Individual screens provide their own AppBar via IMaliAppBar.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        chatUnreadCount: totalUnread,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
