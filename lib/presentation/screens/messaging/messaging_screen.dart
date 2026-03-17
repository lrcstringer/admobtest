import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/community.dart';
import '../../../domain/entities/community_member.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/enums/conversation_type.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/community/community_bloc.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation_actions/conversation_actions_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/messaging/chat_background.dart';
import '../../widgets/messaging/community_list_tile.dart';
import '../../widgets/messaging/conversation_list_tile.dart';
import '../../widgets/messaging/quick_action_strip.dart';
import '../../widgets/messaging/imali_bottom_sheet.dart';
import '../../widgets/messaging/token_actions_sheet.dart';
import '../../blocs/token_pool/token_pool_bloc.dart';
import '../../widgets/pool/pool_list_tile.dart';

/// Messaging screen with three tabs: Chats, Communities, Contacts.
/// Each tab has a context-aware FAB with relevant actions.
class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen>
    with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  String _searchQuery = '';
  final _searchController = TextEditingController();
  late final TabController _tabController;
  int _currentTab = 0;
  bool _showActionStrip = true;
  String? _processingInviteAction;
  /// True when this screen initiated a community operation (accept/decline/leave).
  bool _pendingLocalCommunityOp = false;
  StreamSubscription<RemoteMessage>? _fcmSub;

  /// Global chat tab wallpaper theme (persisted via SharedPreferences).
  ChatThemeStyle _chatTabTheme = ChatThemeStyle.defaultDoodle;
  static const _chatTabThemeKey = 'chat_tab_wallpaper';

  @override
  void dispose() {
    _fcmSub?.cancel();
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadChatTabTheme();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        _currentTab = _tabController.index;
        // Clear search when switching tabs
        if (_isSearching) {
          _isSearching = false;
          _searchQuery = '';
          _searchController.clear();
        }
      });
      // Refresh collections when Collections tab is selected
      if (_tabController.index == 1) {
        context
            .read<TokenPoolBloc>()
            .add(const TokenPoolEvent.loadMyPools());
      }
      // Refresh pending invitations every time Communities tab is selected
      if (_tabController.index == 2) {
        context
            .read<CommunityBloc>()
            .add(const CommunityEvent.loadPendingInvitations());
      }
    });

    context
        .read<ConversationBloc>()
        .add(const ConversationEvent.watchConversations());
    context
        .read<CommunityBloc>()
        .add(const CommunityEvent.loadUserCommunities());
    context
        .read<CommunityBloc>()
        .add(const CommunityEvent.watchUserCommunities());
    context
        .read<CommunityBloc>()
        .add(const CommunityEvent.loadPendingInvitations());

    // Pre-load collections for the Collections tab
    context
        .read<TokenPoolBloc>()
        .add(const TokenPoolEvent.loadMyPools());

    // Start watching contacts and contact requests
    context
        .read<ContactBloc>()
        .add(const ContactEvent.watchContacts());
    context
        .read<ContactBloc>()
        .add(const ContactEvent.watchContactRequests());
    context
        .read<ContactBloc>()
        .add(const ContactEvent.loadFollowedBrands());
    context
        .read<ContactBloc>()
        .add(const ContactEvent.loadSuggestions());

    // Reload pending invitations when a community_invite FCM arrives
    _fcmSub = FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] == 'community_invite' && mounted) {
        context
            .read<CommunityBloc>()
            .add(const CommunityEvent.loadPendingInvitations());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        context.read<AuthBloc>().state.user?.id ?? '';

    return MultiBlocListener(
      listeners: [
        BlocListener<ConversationActionsBloc, ConversationActionsState>(
          listenWhen: (prev, curr) => curr.errorMessage != null && prev.errorMessage != curr.errorMessage,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<ConversationActionsBloc>().add(
                  const ConversationActionsEvent.clearError(),
                );
          },
        ),
        BlocListener<CommunityBloc, CommunityState>(
          listenWhen: (prev, curr) =>
              curr.operationStatus != prev.operationStatus &&
              (curr.operationStatus == CommunityOperationStatus.success ||
               curr.operationStatus == CommunityOperationStatus.failure),
          listener: (context, state) {
            // Only show snackbars for operations this screen initiated
            // (accept/decline/leave). Other screens handle their own feedback.
            if (!_pendingLocalCommunityOp) return;
            _pendingLocalCommunityOp = false;

            if (state.operationStatus == CommunityOperationStatus.success &&
                state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: AppColors.success,
                ),
              );
            } else if (state.operationStatus ==
                    CommunityOperationStatus.failure &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: _isSearching
          ? _buildSearchAppBar()
          : _buildMainAppBar(),
      body: Stack(
        children: [
          Positioned.fill(child: ChatBackground(theme: _chatTabTheme)),
          TabBarView(
            controller: _tabController,
            children: [
              _buildChatsTab(context, currentUserId),
              _buildCollectionsTab(context, currentUserId),
              _buildCommunitiesTab(context, currentUserId),
            ],
          ),
        ],
      ),
      floatingActionButton: _buildContextFAB(context),
    ),
    );
  }

  // =========================================================================
  // APP BAR
  // =========================================================================

  PreferredSizeWidget _buildSearchAppBar() {
    final hintText = switch (_currentTab) {
      1 => 'Search collections...',
      2 => 'Search communities...',
      _ => 'Search conversations...',
    };

    return AppBar(
      backgroundColor: AppColors.chatSurface,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(height: 0.5, color: const Color(0xFF252840)),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            _isSearching = false;
            _searchQuery = '';
            _searchController.clear();
          });
        },
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        onChanged: (query) {
          setState(() => _searchQuery = query.toLowerCase());
        },
      ),
      actions: [
        if (_searchController.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _searchController.clear();
              });
            },
          ),
      ],
    );
  }

  IMaliAppBar _buildMainAppBar() {
    return IMaliAppBar(
      title: 'Chat',
      backgroundColor: AppColors.chatSurface,
      bottomBorderColor: const Color(0xFF252840),
      extraActions: [
        IconButton(
          icon: const Icon(Icons.wallpaper_outlined, color: AppColors.textPrimary),
          tooltip: 'Chat Wallpaper',
          onPressed: () => _showWallpaperPicker(context),
        ),
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textPrimary),
          onPressed: () => setState(() => _isSearching = true),
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        // Pill-shaped filled indicator
        indicator: BoxDecoration(
          gradient: const LinearGradient(colors: AppColors.logoGradient),
          borderRadius: BorderRadius.circular(20),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: 0.3,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(20),
        tabs: [
          // Chats tab with unread badge
          BlocBuilder<ConversationBloc, ConversationState>(
            builder: (context, convState) {
              return _buildBadgedTab(
                  Icons.chat_bubble_rounded, 'Chats', convState.totalUnreadCount);
            },
          ),
          // Collections tab with active pool count badge
          BlocBuilder<TokenPoolBloc, TokenPoolState>(
            builder: (context, poolState) {
              final activeCount = poolState.myPools
                  .where((p) => p.isCollecting || p.isSent)
                  .length;
              return _buildBadgedTab(
                  Icons.savings_rounded, 'Collections', activeCount);
            },
          ),
          // Communities tab with unread + pending invites badge
          BlocBuilder<CommunityBloc, CommunityState>(
            builder: (context, commState) {
              final badgeCount = commState.totalUnreadCount +
                  commState.pendingInvitations.length;
              return _buildBadgedTab(
                  Icons.groups_rounded, 'Communities', badgeCount);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBadgedTab(IconData icon, String label, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // =========================================================================
  // CHATS TAB (Tab 0) — P2P Conversations only
  // =========================================================================

  Widget _buildChatsTab(BuildContext context, String currentUserId) {
    return BlocConsumer<ConversationBloc, ConversationState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
          context
              .read<ConversationBloc>()
              .add(const ConversationEvent.clearError());
        }
      },
      builder: (context, convState) {
        return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.reverse &&
                    _showActionStrip) {
                  setState(() => _showActionStrip = false);
                } else if (notification.direction == ScrollDirection.forward &&
                    !_showActionStrip) {
                  setState(() => _showActionStrip = true);
                }
                return false;
              },
              child: Column(
                children: [
                  QuickActionStrip(
                    visible: _showActionStrip,
                    onSasaza: () => context.push('/chat/sasaza'),
                    onGroupSave: () =>
                        context.push('/chat/create-group-save'),
                    onTokens: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const TokenActionsSheet(),
                      );
                    },
                    onGooiGooi: () => context.push('/chat/gooi'),
                  ),
                  Expanded(
                    child: _buildConversationList(
                        context, convState, currentUserId),
                  ),
                ],
              ),
            );
      },
    );
  }

  Widget _buildConversationList(
    BuildContext context,
    ConversationState convState,
    String currentUserId,
  ) {
    final convNotReady = convState.conversations.isEmpty &&
        (convState.status == ConversationStatus.initial ||
            convState.status == ConversationStatus.loading);

    if (convNotReady) {
      return const _InboxShimmer();
    }

    final items = _buildConversationItems(convState, currentUserId);

    if (items.isEmpty) {
      return _buildChatsEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<ConversationBloc>()
            .add(const ConversationEvent.watchConversations());
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.chatSurface.withValues(alpha: 0.3),
          indent: 76,
        ),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }

  List<Widget> _buildConversationItems(
    ConversationState convState,
    String currentUserId,
  ) {
    final entries = <_InboxEntry>[];

    for (final conv in convState.sortedConversations(currentUserId)) {
      if (conv.isArchivedFor(currentUserId)) continue;
      if (conv.isMessageRequestFor(currentUserId)) continue;
      // Collection rooms now live in the Collections tab
      if (conv.type == ConversationType.collection) continue;
      if (_searchQuery.isNotEmpty &&
          !conv
              .displayNameFor(currentUserId)
              .toLowerCase()
              .contains(_searchQuery)) {
        continue;
      }

      final isPinned = conv.isPinnedFor(currentUserId);
      final Widget tile;
      {
        tile = Dismissible(
          key: ValueKey('swipe_${conv.id}'),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              // Swipe left → archive
              context
                  .read<ConversationActionsBloc>()
                  .add(ConversationActionsEvent.archiveConversation(conv.id));
              return false; // don't remove from list; bloc handles it
            } else {
              // Swipe right → toggle pin
              context.read<ConversationActionsBloc>().add(
                    ConversationActionsEvent.togglePin(
                      conversationId: conv.id,
                      pinned: !isPinned,
                    ),
                  );
              return false;
            }
          },
          background: Container(
            color: AppColors.primary.withValues(alpha: 0.15),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24),
            child: Icon(
              isPinned ? Icons.push_pin_outlined : Icons.push_pin,
              color: AppColors.primary,
            ),
          ),
          secondaryBackground: Container(
            color: AppColors.textSecondary.withValues(alpha: 0.15),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: const Icon(
              Icons.archive_outlined,
              color: AppColors.textSecondary,
            ),
          ),
          child: ConversationListTile(
            conversation: conv,
            currentUserId: currentUserId,
            onTap: () {
              context
                  .read<ConversationBloc>()
                  .add(ConversationEvent.selectConversation(conv.id));
              context.push('/chat/conversation/${conv.id}');
            },
            onLongPress: () => _showConversationOptions(context, conv),
          ),
        );
      }

      entries.add(_InboxEntry(
        sortTime: conv.lastMessageAt ?? conv.createdAt,
        isPinned: conv.isPinnedFor(currentUserId),
        widget: tile,
      ));
    }

    entries.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return b.sortTime.compareTo(a.sortTime);
    });

    final widgets = <Widget>[];

    if (_searchQuery.isEmpty && convState.messageRequestCount > 0) {
      widgets.add(_buildMessageRequestsRow(context, convState.messageRequestCount));
    }

    widgets.addAll(entries.map((e) => e.widget));
    return widgets;
  }

  Widget _buildMessageRequestsRow(BuildContext context, int count) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.chat_outlined, color: AppColors.textSecondary),
      ),
      title: const Text(
        'Message Requests',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '$count pending',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '$count',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
      onTap: () => context.push('/chat/requests'),
    );
  }

  Widget _buildChatsEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated illustration: stacked speech bubbles
            Stack(
              alignment: Alignment.center,
              children: [
                // Background glow
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Overlapping speech bubble icons
                Positioned(
                  left: 0,
                  top: 10,
                  child: Icon(Icons.chat_bubble_rounded,
                      size: 48, color: AppColors.secondary.withValues(alpha: 0.3)),
                ),
                Positioned(
                  right: 0,
                  top: 10,
                  child: Icon(Icons.chat_bubble_rounded,
                      size: 48, color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                Icon(Icons.chat_bubble_outline_rounded,
                    size: 64, color: AppColors.primary.withValues(alpha: 0.7)),
              ],
            ),
            AppSpacing.verticalLg,
            Text(
              'Your conversations live here',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Send tokens, gifts, and messages to\nfriends and communities.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXl,
            ElevatedButton.icon(
              onPressed: () => _showChatsSheet(context),
              icon: const Icon(Icons.person_add),
              label: const Text('Start a Chat'),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // COLLECTIONS TAB (Tab 1) — Group Sasaza + Group Save pools
  // =========================================================================

  Widget _buildCollectionsTab(BuildContext context, String currentUserId) {
    return BlocBuilder<TokenPoolBloc, TokenPoolState>(
      builder: (context, poolState) {
        return _buildCollectionsList(context, poolState, currentUserId);
      },
    );
  }

  Widget _buildCollectionsList(
    BuildContext context,
    TokenPoolState poolState,
    String currentUserId,
  ) {
    if (poolState.isLoading && poolState.myPools.isEmpty) {
      return const _InboxShimmer();
    }

    final allPools = poolState.myPools;
    final filtered = _searchQuery.isEmpty
        ? allPools
        : allPools
            .where((p) => p.title.toLowerCase().contains(_searchQuery))
            .toList();

    final active =
        filtered.where((p) => p.isCollecting || p.isSent).toList();
    final completed = filtered
        .where((p) => p.isCompleted || p.isCancelled || p.isExpired)
        .toList();

    if (active.isEmpty && completed.isEmpty && _searchQuery.isEmpty) {
      return _buildCollectionsEmptyState(context);
    }

    if (active.isEmpty && completed.isEmpty) {
      return Center(
        child: Text(
          'No results for "$_searchQuery"',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<TokenPoolBloc>()
            .add(const TokenPoolEvent.loadMyPools());
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (active.isNotEmpty) ...[
            _buildSectionHeader(context, 'Active'),
            for (var i = 0; i < active.length; i++) ...[
              PoolListTile(
                pool: active[i],
                currentUserId: currentUserId,
                onTap: () => context.push('/chat/pool/${active[i].id}'),
              ),
              if (i < active.length - 1)
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.chatSurface.withValues(alpha: 0.3),
                  indent: 76,
                ),
            ],
          ],
          if (completed.isNotEmpty) ...[
            _buildSectionHeader(context, 'Completed'),
            for (var i = 0; i < completed.length; i++) ...[
              PoolListTile(
                pool: completed[i],
                currentUserId: currentUserId,
                onTap: () =>
                    context.push('/chat/pool/${completed[i].id}'),
              ),
              if (i < completed.length - 1)
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.chatSurface.withValues(alpha: 0.3),
                  indent: 76,
                ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
      ),
    );
  }

  Widget _buildCollectionsEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.savings_outlined, size: 80, color: AppColors.textHint),
            AppSpacing.verticalLg,
            Text(
              'No collections yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Start a Group Save or Group Sasaza to collect tokens together',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXl,
            ElevatedButton.icon(
              onPressed: () => context.push('/chat/create-group-save'),
              icon: const Icon(Icons.savings),
              label: const Text('Start a Group Save'),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // COMMUNITIES TAB (Tab 2)
  // =========================================================================

  Widget _buildCommunitiesTab(BuildContext context, String currentUserId) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, commState) {
        return _buildCommunitiesList(context, commState, currentUserId);
      },
    );
  }

  Widget _buildCommunitiesList(
    BuildContext context,
    CommunityState commState,
    String currentUserId,
  ) {
    if (commState.status == CommunityLoadingStatus.loading &&
        commState.communities.isEmpty) {
      return const _InboxShimmer();
    }

    final communities = commState.activeCommunities
        .where((comm) =>
            _searchQuery.isEmpty ||
            comm.name.toLowerCase().contains(_searchQuery))
        .toList()
      ..sort((a, b) {
        final aTime = a.lastMessageAt ?? a.createdAt;
        final bTime = b.lastMessageAt ?? b.createdAt;
        return bTime.compareTo(aTime);
      });

    final pendingInvites = commState.pendingInvitations;

    if (communities.isEmpty &&
        pendingInvites.isEmpty &&
        _searchQuery.isEmpty) {
      return _buildCommunitiesEmptyState(context);
    }

    if (communities.isEmpty && pendingInvites.isEmpty) {
      return Center(
        child: Text(
          'No results for "$_searchQuery"',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<CommunityBloc>()
            .add(const CommunityEvent.loadUserCommunities());
        context
            .read<CommunityBloc>()
            .add(const CommunityEvent.loadPendingInvitations());
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          // Pending invitations section
          if (pendingInvites.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                'Pending Invitations',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
            for (final invite in pendingInvites)
              _buildInvitationCard(context, invite),
            if (communities.isNotEmpty)
              Divider(
                height: 1,
                color: AppColors.chatSurface.withValues(alpha: 0.3),
              ),
          ],
          // Communities list
          for (var i = 0; i < communities.length; i++) ...[
            CommunityListTile(
              community: communities[i],
              currentUserId: currentUserId,
              onTap: () =>
                  context.push('/chat/community/${communities[i].id}'),
              onLongPress: () =>
                  _showCommunityOptions(context, communities[i]),
            ),
            if (i < communities.length - 1)
              Divider(
                height: 0.5,
                thickness: 0.5,
                color: AppColors.chatSurface.withValues(alpha: 0.3),
                indent: 76,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildInvitationCard(BuildContext context, CommunityMember invite) {
    // 8.15 Safe substring — clamp to avoid crash if ID is shorter than 8 chars
    final communityName = invite.communityName ??
        invite.communityId.substring(
            0, invite.communityId.length.clamp(0, 8));
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: avatar + community info
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  child:
                      const Icon(Icons.groups, color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        communityName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Invited as ${invite.roleDisplayName}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 8.3 + 8.10 Bottom row: Decline + Accept with per-button spinner
            StatefulBuilder(
              builder: (context, setLocalState) {
                // null = idle, 'accept' or 'decline' = which action is in progress
                return BlocBuilder<CommunityBloc, CommunityState>(
                  builder: (context, commState) {
                    final isProcessing = commState.operationStatus ==
                        CommunityOperationStatus.processing;
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isProcessing
                                ? null
                                : () {
                                    _pendingLocalCommunityOp = true;
                                    setLocalState(
                                        () => _processingInviteAction = 'decline');
                                    context.read<CommunityBloc>().add(
                                          CommunityEvent.declineInvitation(
                                              communityId: invite.communityId),
                                        );
                                  },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.error,
                              side: const BorderSide(color: AppColors.error),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              minimumSize: const Size(0, 40),
                            ),
                            child: isProcessing &&
                                    _processingInviteAction == 'decline'
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2))
                                : const Text('Decline'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isProcessing
                                ? null
                                : () {
                                    _pendingLocalCommunityOp = true;
                                    setLocalState(
                                        () => _processingInviteAction = 'accept');
                                    context.read<CommunityBloc>().add(
                                          CommunityEvent.acceptInvitation(
                                              communityId: invite.communityId),
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              minimumSize: const Size(0, 40),
                            ),
                            child: isProcessing &&
                                    _processingInviteAction == 'accept'
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white))
                                : const Text('Accept'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunitiesEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group_outlined, size: 80, color: AppColors.textHint),
            AppSpacing.verticalLg,
            Text(
              'No communities yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Create or join a community to get started',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXl,
            ElevatedButton.icon(
              onPressed: () => context.push('/chat/create-community'),
              icon: const Icon(Icons.group_add),
              label: const Text('Create Community'),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // CONTEXT-AWARE FAB
  // =========================================================================

  Widget _buildContextFAB(BuildContext context) {
    final IconData icon;
    switch (_currentTab) {
      case 0:
        icon = Icons.edit;
      case 1:
        icon = Icons.savings;
      case 2:
        icon = Icons.group_add;
      default:
        icon = Icons.add;
    }
    return FloatingActionButton(
      onPressed: () => _showFABSheet(context),
      child: Icon(icon),
    );
  }

  void _showFABSheet(BuildContext context) {
    switch (_currentTab) {
      case 0:
        _showChatsSheet(context);
      case 1:
        context.push('/chat/create-group-save');
      case 2:
        context.push('/chat/create-community');
    }
  }

  // =========================================================================
  // FAB BOTTOM SHEETS
  // =========================================================================

  Future<void> _loadChatTabTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_chatTabThemeKey);
    if (name != null && mounted) {
      final style = ChatThemeStyle.values.firstWhere(
        (s) => s.name == name,
        orElse: () => ChatThemeStyle.defaultDoodle,
      );
      if (style != _chatTabTheme) {
        setState(() => _chatTabTheme = style);
      }
    }
  }

  void _showWallpaperPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ChatThemePicker(
        current: _chatTabTheme,
        onSelected: (theme) async {
          setState(() => _chatTabTheme = theme);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_chatTabThemeKey, theme.name);
        },
      ),
    );
  }

  void _showChatsSheet(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user;
    showIMaliBottomSheet(
      context: context,
      title: 'New Conversation',
      children: [
            AppSpacing.verticalMd,
            _sheetOption(
              icon: Icons.person,
              color: AppColors.primary,
              title: 'New Chat',
              subtitle: 'Send a message to a contact',
              onTap: () {
                Navigator.pop(context);
                context.push('/chat/new');
              },
            ),
            _sheetOption(
              icon: Icons.qr_code,
              color: AppColors.tertiary,
              title: 'My QR Code',
              subtitle: 'Let others scan to chat with you',
              onTap: () {
                Navigator.pop(context);
                context.push('/home/qr-code', extra: {
                  'userId': currentUser?.id ?? '',
                  'displayName':
                      currentUser?.displayName ?? 'My QR Code',
                });
              },
            ),
            _sheetOption(
              icon: Icons.qr_code_scanner,
              color: AppColors.tertiary,
              title: 'Scan QR Code',
              subtitle: "Scan someone's code to start chatting",
              onTap: () {
                Navigator.pop(context);
                context.push('/scan');
              },
            ),
            AppSpacing.verticalLg,
      ],
    );
  }



  // =========================================================================
  // CONVERSATION & COMMUNITY OPTIONS
  // =========================================================================

  void _showConversationOptions(BuildContext context, Conversation conv) {
    final currentUserId =
        context.read<AuthBloc>().state.user?.id ?? '';

    showIMaliBottomSheet(
      context: context,
      children: [
            ListTile(
              leading: Icon(
                conv.isPinnedFor(currentUserId)
                    ? Icons.push_pin_outlined
                    : Icons.push_pin,
              ),
              title: Text(
                conv.isPinnedFor(currentUserId) ? 'Unpin Chat' : 'Pin Chat',
              ),
              onTap: () {
                Navigator.pop(context);
                context.read<ConversationActionsBloc>().add(
                      ConversationActionsEvent.togglePin(
                        conversationId: conv.id,
                        pinned: !conv.isPinnedFor(currentUserId),
                      ),
                    );
              },
            ),
            ListTile(
              leading: Icon(
                conv.isMutedFor(currentUserId)
                    ? Icons.volume_up
                    : Icons.volume_off,
              ),
              title: Text(
                conv.isMutedFor(currentUserId) ? 'Unmute' : 'Mute',
              ),
              onTap: () {
                Navigator.pop(context);
                context.read<ConversationActionsBloc>().add(
                      ConversationActionsEvent.toggleMute(
                        conversationId: conv.id,
                        muted: !conv.isMutedFor(currentUserId),
                      ),
                    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive_outlined),
              title: const Text('Archive'),
              onTap: () {
                Navigator.pop(context);
                context
                    .read<ConversationActionsBloc>()
                    .add(ConversationActionsEvent.archiveConversation(conv.id));
              },
            ),
      ],
    );
  }

  void _showCommunityOptions(BuildContext context, Community comm) {
    showIMaliBottomSheet(
      context: context,
      children: [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Community Info'),
              onTap: () {
                Navigator.pop(context);
                context.push('/chat/community/${comm.id}');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Leave Community'),
              onTap: () {
                Navigator.pop(context);
                _confirmLeaveCommunity(context, comm);
              },
            ),
      ],
    );
  }

  void _confirmLeaveCommunity(BuildContext context, Community comm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave Community?'),
        content: Text('Are you sure you want to leave "${comm.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _pendingLocalCommunityOp = true;
              context
                  .read<CommunityBloc>()
                  .add(CommunityEvent.leaveCommunity(communityId: comm.id));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // SHARED HELPERS
  // =========================================================================

  Widget _sheetOption({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

}

/// Helper for sorting inbox items by pinned + timestamp.
class _InboxEntry {
  final DateTime sortTime;
  final bool isPinned;
  final Widget widget;

  _InboxEntry({
    required this.sortTime,
    required this.isPinned,
    required this.widget,
  });
}

/// Skeleton shimmer placeholder for inbox loading state.
/// Structured placeholders feel 30-40% faster than spinners.
class _InboxShimmer extends StatelessWidget {
  const _InboxShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (_, _) => const _ShimmerTile(),
    );
  }
}

class _ShimmerTile extends StatefulWidget {
  const _ShimmerTile();

  @override
  State<_ShimmerTile> createState() => _ShimmerTileState();
}

class _ShimmerTileState extends State<_ShimmerTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) {
        final opacity = _animation.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              // Avatar placeholder
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.chatSurface.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name placeholder
                    Container(
                      width: 120,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.chatSurface.withValues(alpha: opacity),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Message preview placeholder
                    Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.chatSurface.withValues(alpha: opacity * 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Timestamp placeholder
              Container(
                width: 36,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.chatSurface.withValues(alpha: opacity * 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
