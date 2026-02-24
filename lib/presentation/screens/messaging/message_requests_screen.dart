import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/conversation.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../widgets/messaging/chat_background.dart';
import '../../widgets/messaging/conversation_list_tile.dart';

/// Screen showing all unaccepted conversation requests.
///
/// Users can tap into a conversation to read messages, then
/// Accept / Block / Report via the banner in [ConversationDetailScreen].
class MessageRequestsScreen extends StatelessWidget {
  const MessageRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.chatAppBar,
        surfaceTintColor: Colors.transparent,
        title: const Text('Message Requests'),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: ChatBackground(),
          ),
          BlocBuilder<ConversationBloc, ConversationState>(
            builder: (context, state) {
              final requests = state.conversations
                  .where((c) =>
                      c.isMessageRequestFor(currentUserId) &&
                      !c.isArchivedFor(currentUserId))
                  .toList()
                ..sort((a, b) {
                  final aTime = a.lastMessageAt ?? a.createdAt;
                  final bTime = b.lastMessageAt ?? b.createdAt;
                  return bTime.compareTo(aTime);
                });

              if (requests.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mark_chat_read_outlined,
                        size: 64,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No message requests',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: requests.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: AppColors.chatSurface.withValues(alpha: 0.3),
                  indent: 76,
                ),
                itemBuilder: (context, index) {
                  final conv = requests[index];
                  return ConversationListTile(
                    conversation: conv,
                    currentUserId: currentUserId,
                    onTap: () {
                      context.read<ConversationBloc>().add(
                            ConversationEvent.selectConversation(conv.id),
                          );
                      context.push('/chat/conversation/${conv.id}');
                    },
                    onLongPress: () =>
                        _showRequestOptions(context, conv, currentUserId),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showRequestOptions(
    BuildContext context,
    Conversation conv,
    String currentUserId,
  ) {
    final senderName = conv.displayNameFor(currentUserId);

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
              leading: const Icon(Icons.check_circle_outline,
                  color: AppColors.success),
              title: const Text('Accept'),
              subtitle: Text('Allow $senderName to message you'),
              onTap: () {
                Navigator.pop(ctx);
                context.read<ConversationBloc>().add(
                      ConversationEvent.acceptConversation(conv.id),
                    );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.archive_outlined, color: AppColors.warning),
              title: const Text('Archive'),
              subtitle: const Text('Move to archived chats'),
              onTap: () {
                Navigator.pop(ctx);
                context.read<ConversationBloc>().add(
                      ConversationEvent.archiveConversation(conv.id),
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
