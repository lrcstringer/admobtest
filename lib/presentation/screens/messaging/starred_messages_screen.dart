import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/starred_message.dart';
import '../../../domain/repositories/conversation_repository.dart';
import '../../../core/di/injection.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Displays all starred/bookmarked messages across conversations.
///
/// Grouped by conversation, sorted by starredAt descending.
/// Tapping a message navigates to the conversation and scrolls to it.
class StarredMessagesScreen extends StatefulWidget {
  const StarredMessagesScreen({super.key});

  @override
  State<StarredMessagesScreen> createState() => _StarredMessagesScreenState();
}

class _StarredMessagesScreenState extends State<StarredMessagesScreen> {
  late Future<List<StarredMessage>> _starredFuture;

  @override
  void initState() {
    super.initState();
    _starredFuture = _loadStarredMessages();
  }

  Future<List<StarredMessage>> _loadStarredMessages() async {
    final repo = getIt<ConversationRepository>();
    final result = await repo.getAllStarredMessages();
    return result.fold(
      (_) => <StarredMessage>[],
      (messages) => messages,
    );
  }

  void _refresh() {
    setState(() {
      _starredFuture = _loadStarredMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Starred Messages',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: FutureBuilder<List<StarredMessage>>(
        future: _starredFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data ?? [];

          if (messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_outline_rounded,
                    size: 64,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'No starred messages',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Long-press a message and tap Star\nto bookmark it here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textHint,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: messages.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, color: AppColors.divider),
              itemBuilder: (context, index) {
                final starred = messages[index];
                return _StarredMessageTile(
                  starred: starred,
                  onTap: () {
                    context.push('/chat/conversation/${starred.conversationId}');
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _StarredMessageTile extends StatelessWidget {
  final StarredMessage starred;
  final VoidCallback onTap;

  const _StarredMessageTile({
    required this.starred,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final preview = starred.messagePreview ?? starred.messageType;
    final timeAgo = _formatTimeAgo(starred.starredAt);

    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: AppColors.primaryLight,
        child: Icon(Icons.star_rounded, color: AppColors.primary),
      ),
      title: Text(
        starred.senderName,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        preview,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        timeAgo,
        style: const TextStyle(
          color: AppColors.textHint,
          fontSize: 12,
        ),
      ),
      onTap: onTap,
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
