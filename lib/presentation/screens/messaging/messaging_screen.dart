import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/community.dart';
import '../../../domain/entities/conversation.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/community/community_bloc.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation_actions/conversation_actions_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../../domain/enums/conversation_type.dart';
import '../../widgets/messaging/chat_background.dart';
import '../../widgets/messaging/community_list_tile.dart';
import '../../widgets/messaging/conversation_list_tile.dart';
import '../../widgets/pool/collection_room_list_tile.dart';
import 'contacts_tab.dart';

/// Unified inbox screen showing all P2P conversations and communities
/// sorted by last message timestamp.
///
/// Replaces the old [ChatScreen] for the Chat tab (Tab 2).
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

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() => _currentTab = _tabController.index);
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
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        context.read<AuthBloc>().state.user?.id ?? '';

    return BlocListener<ConversationActionsBloc, ConversationActionsState>(
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
      child: Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: _isSearching
          ? AppBar(
              backgroundColor: AppColors.chatAppBar,
              surfaceTintColor: Colors.transparent,
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
                decoration: const InputDecoration(
                  hintText: 'Search conversations...',
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
            )
          : IMaliAppBar(
              title: 'Chat',
              backgroundColor: AppColors.chatAppBar,
              extraActions: [
                IconButton(
                  icon:
                      const Icon(Icons.search, color: AppColors.textPrimary),
                  onPressed: () => _showSearch(context),
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                tabs: [
                  const Tab(text: 'Chats'),
                  BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, contactState) {
                      final count = contactState.pendingRequestCount;
                      return Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Contacts'),
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
                                  '$count',
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
                    },
                  ),
                ],
              ),
            ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 0: Chats
          _buildChatsTab(context, currentUserId),
          // Tab 1: Contacts
          const ContactsTab(),
        ],
      ),
      floatingActionButton: _currentTab == 0 ? _buildFAB(context) : null,
    ),
    );
  }

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
        return BlocBuilder<CommunityBloc, CommunityState>(
          builder: (context, commState) {
            return Stack(
              children: [
                const Positioned.fill(
                  child: ChatBackground(),
                ),
                Column(
                  children: [
                    // Quick Actions Bar
                    _buildQuickActions(context),
                    // Unified inbox list
                    Expanded(
                      child: _buildInboxList(
                        context,
                        convState,
                        commState,
                        currentUserId,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickAction(
            context,
            icon: Icons.send,
            label: 'Send',
            color: AppColors.primary,
            onTap: () => context.push('/wallet/send'),
          ),
          _buildQuickAction(
            context,
            icon: Icons.group_add,
            label: 'Community',
            color: AppColors.secondary,
            onTap: () => context.push('/chat/create-community'),
          ),
          _buildQuickAction(
            context,
            icon: Icons.qr_code,
            label: 'QR Code',
            color: AppColors.tertiary,
            onTap: () => _showQRCode(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusMd,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            AppSpacing.verticalXs,
            Text(label, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildInboxList(
    BuildContext context,
    ConversationState convState,
    CommunityState commState,
    String currentUserId,
  ) {
    // Show spinner until conversations have loaded at least once
    final convNotReady = convState.conversations.isEmpty &&
        (convState.status == ConversationStatus.initial ||
            convState.status == ConversationStatus.loading);

    if (convNotReady) {
      return const Center(child: CircularProgressIndicator());
    }

    // Build unified list items sorted by lastMessageAt
    final items = _buildUnifiedItems(convState, commState, currentUserId);

    if (items.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<ConversationBloc>()
            .add(const ConversationEvent.watchConversations());
        context
            .read<CommunityBloc>()
            .add(const CommunityEvent.loadUserCommunities());
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.chatSurface.withValues(alpha: 0.3),
          indent: 76, // aligns with text start (avatar + padding)
        ),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }

  List<Widget> _buildUnifiedItems(
    ConversationState convState,
    CommunityState commState,
    String currentUserId,
  ) {
    // Create sortable entries
    final entries = <_InboxEntry>[];

    for (final conv in convState.sortedConversations(currentUserId)) {
      if (conv.isArchivedFor(currentUserId)) continue;
      if (conv.isMessageRequestFor(currentUserId)) continue; // skip requests
      if (_searchQuery.isNotEmpty &&
          !conv
              .displayNameFor(currentUserId)
              .toLowerCase()
              .contains(_searchQuery)) {
        continue;
      }
      // Use special tile for collection room conversations
      final Widget tile;
      if (conv.type == ConversationType.collection &&
          conv.tokenPoolId != null) {
        tile = CollectionRoomListTile(
          conversation: conv,
          currentUserId: currentUserId,
          onTap: () {
            context.push('/chat/pool/${conv.tokenPoolId}');
          },
        );
      } else {
        tile = ConversationListTile(
          conversation: conv,
          currentUserId: currentUserId,
          onTap: () {
            context
                .read<ConversationBloc>()
                .add(ConversationEvent.selectConversation(conv.id));
            context.push('/chat/conversation/${conv.id}');
          },
          onLongPress: () => _showConversationOptions(context, conv),
        );
      }

      entries.add(_InboxEntry(
        sortTime: conv.lastMessageAt ?? conv.createdAt,
        isPinned: conv.isPinnedFor(currentUserId),
        widget: tile,
      ));
    }

    for (final comm in commState.activeCommunities) {
      if (_searchQuery.isNotEmpty &&
          !comm.name.toLowerCase().contains(_searchQuery)) {
        continue;
      }
      entries.add(_InboxEntry(
        sortTime: comm.lastMessageAt ?? comm.createdAt,
        isPinned: false,
        widget: CommunityListTile(
          community: comm,
          currentUserId: currentUserId,
          onTap: () => context.push('/chat/community/${comm.id}'),
          onLongPress: () => _showCommunityOptions(context, comm),
        ),
      ));
    }

    // Sort: pinned first, then by timestamp descending
    entries.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return b.sortTime.compareTo(a.sortTime);
    });

    final widgets = <Widget>[];

    // Message Requests row (when not searching)
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 80, color: AppColors.textHint),
            AppSpacing.verticalLg,
            Text(
              'No conversations yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Start a chat or create a community to get started',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXl,
            ElevatedButton.icon(
              onPressed: () => _showNewChatSheet(context),
              icon: const Icon(Icons.person_add),
              label: const Text('Start a Chat'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showNewChatSheet(context),
      child: const Icon(Icons.edit),
    );
  }

  void _showNewChatSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _NewChatOrCommunitySheet(
        onNewChat: () {
          Navigator.pop(context);
          context.push('/chat/new');
        },
        onNewCommunity: () {
          Navigator.pop(context);
          context.push('/chat/create-community');
        },
      ),
    );
  }

  void _showSearch(BuildContext context) {
    setState(() => _isSearching = true);
  }

  void _showQRCode(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('My QR Code'),
              subtitle: const Text('Let others scan to chat with you'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/home/qr-code', extra: {
                  'userId': currentUser?.id ?? '',
                  'displayName':
                      currentUser?.displayName ?? 'My QR Code',
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Scan QR Code'),
              subtitle: const Text('Scan someone\'s code to start chatting'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/scan');
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showConversationOptions(BuildContext context, Conversation conv) {
    final currentUserId =
        context.read<AuthBloc>().state.user?.id ?? '';

    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dragHandle(),
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
                Navigator.pop(ctx);
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
                Navigator.pop(ctx);
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
                Navigator.pop(ctx);
                context
                    .read<ConversationActionsBloc>()
                    .add(ConversationActionsEvent.archiveConversation(conv.id));
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showCommunityOptions(BuildContext context, Community comm) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dragHandle(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Community Info'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/chat/community/${comm.id}');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Leave Community'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmLeaveCommunity(context, comm);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
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

  Widget _dragHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.textHint,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// Helper for sorting unified inbox items.
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

/// Bottom sheet for creating a new chat or community.
class _NewChatOrCommunitySheet extends StatelessWidget {
  final VoidCallback onNewChat;
  final VoidCallback onNewCommunity;

  const _NewChatOrCommunitySheet({
    required this.onNewChat,
    required this.onNewCommunity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'New Conversation',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            AppSpacing.verticalMd,
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: AppColors.primary),
              ),
              title: const Text('New Chat'),
              subtitle: const Text('Send a message to a contact'),
              onTap: onNewChat,
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.group_add, color: AppColors.secondary),
              ),
              title: const Text('Create Community'),
              subtitle: const Text('Start a group or stokvel'),
              onTap: onNewCommunity,
            ),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }
}
