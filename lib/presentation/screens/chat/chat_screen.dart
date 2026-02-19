import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/chat_thread.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/imali_app_bar.dart';
import '../../widgets/common/wave_background.dart';

@Deprecated('Use MessagingScreen instead. Will be removed in a future cleanup PR.')
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(const ChatEvent.loadThreads());
    context.read<ChatBloc>().add(const ChatEvent.watchThreads());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMaliAppBar(
        title: 'Chat',
        extraActions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.person_add_outlined, color: AppColors.textPrimary),
            onPressed: () => _showNewChatDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
            context.read<ChatBloc>().add(const ChatEvent.clearError());
          }
        },
        builder: (context, state) {
          return WaveBackground(
            child: Column(
              children: [
                // Quick Actions
                Container(
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.alphaBlend(
                          AppColors.logoGradient[0].withValues(alpha: 0.06),
                          AppColors.surface,
                        ),
                        Color.alphaBlend(
                          AppColors.logoGradient[1].withValues(alpha: 0.03),
                          AppColors.surface,
                        ),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickAction(
                        context,
                        icon: Icons.send,
                        label: 'Send',
                        color: AppColors.primary,
                        onTap: () => _showSendTokensDialog(context),
                      ),
                      _buildQuickAction(
                        context,
                        icon: Icons.call_received,
                        label: 'Request',
                        color: AppColors.accent,
                        onTap: () => _showRequestTokensDialog(context),
                      ),
                      _buildQuickAction(
                        context,
                        icon: Icons.qr_code,
                        label: 'QR Code',
                        color: AppColors.secondary,
                        onTap: () => _showQRCode(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Thread List or Empty State
                Expanded(
                  child: _buildContent(context, state),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewChatDialog(context),
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ChatState state) {
    if (state.status == ChatStatus.loading && state.threads.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.threads.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ChatBloc>().add(const ChatEvent.loadThreads());
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.sortedThreads.length,
        itemBuilder: (context, index) {
          final thread = state.sortedThreads[index];
          return _buildThreadItem(context, thread);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: AppColors.textHint,
            ),
            AppSpacing.verticalLg,
            Text(
              'No conversations yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Start sending or requesting tokens from friends',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXl,
            ElevatedButton.icon(
              onPressed: () => _showNewChatDialog(context),
              icon: const Icon(Icons.person_add),
              label: const Text('Start a Chat'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThreadItem(BuildContext context, ChatThread thread) {
    return Dismissible(
      key: Key(thread.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.archive, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await _showArchiveConfirmDialog(context, thread);
      },
      onDismissed: (direction) {
        context.read<ChatBloc>().add(ChatEvent.archiveThread(thread.id));
      },
      child: ListTile(
        onTap: () => _navigateToChat(context, thread),
        onLongPress: () => _showThreadOptions(context, thread),
        leading: _buildAvatar(context, thread),
        title: Row(
          children: [
            Expanded(
              child: Text(
                thread.displayName,
                style: thread.hasUnread
                    ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        )
                    : null,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (thread.isPinned)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.push_pin,
                  size: 14,
                  color: AppColors.primary,
                ),
              ),
            if (thread.isMuted)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.volume_off,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
        subtitle: thread.lastMessagePreview != null
            ? Text(
                thread.lastMessagePreview!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: thread.hasUnread
                    ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        )
                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
              )
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (thread.lastMessageAt != null)
              Text(
                _formatDate(thread.lastMessageAt!),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: thread.hasUnread
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
              ),
            if (thread.unreadCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  thread.unreadCount > 99 ? '99+' : '${thread.unreadCount}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, ChatThread thread) {
    final color = AppColors.parseHex(thread.avatarColor);

    final initialsWidget = CircleAvatar(
      radius: 24,
      backgroundColor: color.withValues(alpha: 0.2),
      child: Text(
        thread.displayInitials,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );

    if (thread.avatarUrl != null) {
      return CachedNetworkImage(
        imageUrl: thread.avatarUrl!,
        imageBuilder: (_, imageProvider) => CircleAvatar(
          radius: 24,
          backgroundImage: imageProvider,
        ),
        placeholder: (_, __) => initialsWidget,
        errorWidget: (_, __, ___) => initialsWidget,
      );
    }

    return initialsWidget;
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
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChat(BuildContext context, ChatThread thread) {
    context.read<ChatBloc>().add(ChatEvent.selectThread(thread.id));
    context.push('/chat/${thread.id}');
  }

  void _showSearchDialog(BuildContext context) {
    // TODO: Implement search
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search coming soon')),
    );
  }

  void _showNewChatDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const NewChatSheet(),
    );
  }

  void _showSendTokensDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const SendTokensSheet(),
    );
  }

  void _showRequestTokensDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const RequestTokensSheet(),
    );
  }

  void _showQRCode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const QRCodeSheet(),
    );
  }

  void _showThreadOptions(BuildContext context, ChatThread thread) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThreadOptionsSheet(thread: thread),
    );
  }

  Future<bool?> _showArchiveConfirmDialog(
    BuildContext context,
    ChatThread thread,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Archive Chat'),
        content: Text('Archive chat with ${thread.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Archive'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      final hour = date.hour.toString().padLeft(2, '0');
      final minute = date.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[date.weekday - 1];
    }
    return '${date.day}/${date.month}';
  }
}

// ============== Bottom Sheet Components ==============

class NewChatSheet extends StatelessWidget {
  const NewChatSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Chat',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 64,
                        color: AppColors.textHint,
                      ),
                      AppSpacing.verticalMd,
                      Text(
                        'Search for a user by phone or username',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SendTokensSheet extends StatelessWidget {
  const SendTokensSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Send Tokens',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSpacing.verticalLg,
            Text(
              'Select a contact to send tokens',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalXl,
          ],
        ),
      ),
    );
  }
}

class RequestTokensSheet extends StatelessWidget {
  const RequestTokensSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Request Tokens',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSpacing.verticalLg,
            Text(
              'Select a contact to request tokens from',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalXl,
          ],
        ),
      ),
    );
  }
}

class QRCodeSheet extends StatelessWidget {
  const QRCodeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Your QR Code',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            AppSpacing.verticalLg,
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Icon(
                  Icons.qr_code_2,
                  size: 150,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            AppSpacing.verticalMd,
            Text(
              'Let others scan to send you tokens',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalLg,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement scan QR
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Scan QR'),
                ),
                AppSpacing.horizontalMd,
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement share QR
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }
}

class ThreadOptionsSheet extends StatelessWidget {
  final ChatThread thread;

  const ThreadOptionsSheet({super.key, required this.thread});

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
            ListTile(
              leading: Icon(
                thread.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
              ),
              title: Text(thread.isPinned ? 'Unpin Chat' : 'Pin Chat'),
              onTap: () {
                Navigator.pop(context);
                context.read<ChatBloc>().add(
                      ChatEvent.togglePinThread(
                        threadId: thread.id,
                        isPinned: !thread.isPinned,
                      ),
                    );
              },
            ),
            ListTile(
              leading: Icon(
                thread.isMuted ? Icons.volume_up : Icons.volume_off,
              ),
              title: Text(thread.isMuted ? 'Unmute Chat' : 'Mute Chat'),
              onTap: () {
                Navigator.pop(context);
                context.read<ChatBloc>().add(
                      ChatEvent.toggleMuteThread(
                        threadId: thread.id,
                        isMuted: !thread.isMuted,
                      ),
                    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive_outlined),
              title: const Text('Archive Chat'),
              onTap: () {
                Navigator.pop(context);
                context.read<ChatBloc>().add(
                      ChatEvent.archiveThread(thread.id),
                    );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
