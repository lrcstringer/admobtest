import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/moderation_repository.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/wave_background.dart';
import '../../widgets/messaging/date_separator.dart';
import '../../widgets/messaging/message_bubble.dart';
import '../../widgets/messaging/message_input_bar.dart';
import '../../widgets/messaging/reaction_picker.dart';

/// P2P conversation detail screen showing messages and input bar.
///
/// Replaces the old [ChatDetailScreen].
class ConversationDetailScreen extends StatefulWidget {
  final String conversationId;

  const ConversationDetailScreen({
    super.key,
    required this.conversationId,
  });

  @override
  State<ConversationDetailScreen> createState() =>
      _ConversationDetailScreenState();
}

class _ConversationDetailScreenState extends State<ConversationDetailScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context
        .read<ConversationBloc>()
        .add(ConversationEvent.selectConversation(widget.conversationId));
    context
        .read<ConversationBloc>()
        .add(ConversationEvent.markAsRead(widget.conversationId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        final conv = state.selectedConversation;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: conv != null
                ? Row(
                    children: [
                      _buildAppBarAvatar(context, conv, currentUserId),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          conv.displayNameFor(currentUserId),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                : const Text('Chat'),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showChatOptions(context, conv),
              ),
            ],
          ),
          body: WaveBackground(
            child: Column(
              children: [
                Expanded(
                  child: _buildMessageList(context, state, currentUserId),
                ),
                MessageInputBar(
                  controller: _messageController,
                  isSending: state.isSending,
                  onSend: () => _sendMessage(context),
                  onTokenAction: () =>
                      _showTokenActions(context, state, currentUserId),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBarAvatar(
    BuildContext context,
    Conversation conv,
    String currentUserId,
  ) {
    const double size = 36;
    const double radius = 4;
    final other = conv.getOtherParticipant(currentUserId);
    final initialsWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        conv.displayInitialsFor(currentUserId),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );

    if (other.avatarUrl != null && other.avatarUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: other.avatarUrl!,
        imageBuilder: (_, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, __) => initialsWidget,
        errorWidget: (_, __, ___) => initialsWidget,
      );
    }
    return initialsWidget;
  }

  Widget _buildMessageList(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) {
    if (state.messages.isEmpty && !state.hasLoadedMessages) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: AppColors.textHint),
            AppSpacing.verticalMd,
            Text(
              'No messages yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSpacing.verticalSm,
            Text(
              'Send a message or tokens to start the conversation',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Messages are newest-first from the API; reverse for the reversed ListView
    final messages = state.messages.reversed.toList();

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        if (!message.isVisibleTo(currentUserId)) {
          return const SizedBox.shrink();
        }

        final isMe = message.isSentBy(currentUserId);
        final showDate = index == messages.length - 1 ||
            !DateSeparator.isSameDay(
              messages[index].createdAt,
              messages[index + 1].createdAt,
            );

        return Column(
          children: [
            if (showDate) DateSeparator(date: message.createdAt),
            MessageBubble(
              message: message,
              isMe: isMe,
              currentUserId: currentUserId,
              avatarUrl: state.selectedConversation?.participants[message.senderId]?.avatarUrl,
              onLongPress: () => _onMessageLongPress(context, message),
              onTokenRequestAction: message.isTokenTransfer
                  ? (accepted) => _handleTokenRequestAction(
                        context, message, accepted)
                  : null,
            ),
          ],
        );
      },
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<ConversationBloc>().add(
          ConversationEvent.sendTextMessage(
            conversationId: widget.conversationId,
            text: text,
          ),
        );
    _messageController.clear();
  }

  void _onMessageLongPress(BuildContext context, Message message) {
    // Skip for already-deleted messages
    if (message.deletedForEveryone) return;

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
              leading: const Icon(Icons.emoji_emotions_outlined),
              title: const Text('React'),
              onTap: () {
                Navigator.pop(ctx);
                _showReactionPicker(context, message);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text('Delete for Everyone'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDeleteMessage(context, message.id);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showReactionPicker(BuildContext context, Message message) async {
    final bloc = context.read<ConversationBloc>();
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';
    final emoji = await showReactionPicker(context);
    if (emoji != null && mounted) {
      if (message.hasReacted(currentUserId, emoji)) {
        bloc.add(
          ConversationEvent.removeReaction(
            conversationId: widget.conversationId,
            messageId: message.id,
            emoji: emoji,
          ),
        );
      } else {
        bloc.add(
          ConversationEvent.addReaction(
            conversationId: widget.conversationId,
            messageId: message.id,
            emoji: emoji,
          ),
        );
      }
    }
  }

  void _handleTokenRequestAction(
    BuildContext context,
    Message message,
    bool accepted,
  ) {
    if (accepted) {
      context.read<ConversationBloc>().add(
            ConversationEvent.acceptTokenRequest(
              messageId: message.id,
              conversationId: widget.conversationId,
            ),
          );
    } else {
      context.read<ConversationBloc>().add(
            ConversationEvent.declineTokenRequest(
              messageId: message.id,
              conversationId: widget.conversationId,
            ),
          );
    }
  }

  void _showTokenActions(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    final recipientName =
        state.selectedConversation?.displayNameFor(currentUserId) ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _TokenActionsSheet(
        conversationId: widget.conversationId,
        recipientId: recipientId,
        recipientName: recipientName,
      ),
    );
  }

  void _showChatOptions(BuildContext context, Conversation? conv) {
    if (conv == null) return;
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

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
              leading: Icon(
                conv.isMutedFor(currentUserId)
                    ? Icons.volume_up
                    : Icons.volume_off,
              ),
              title: Text(
                conv.isMutedFor(currentUserId) ? 'Unmute Chat' : 'Mute Chat',
              ),
              onTap: () {
                Navigator.pop(ctx);
                context.read<ConversationBloc>().add(
                      ConversationEvent.toggleMute(
                        conversationId: conv.id,
                        muted: !conv.isMutedFor(currentUserId),
                      ),
                    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep_outlined,
                  color: AppColors.error),
              title: const Text('Clear Chat'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmClearChat(context, conv.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block_outlined, color: AppColors.error),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmBlockUser(
                  context,
                  conv.otherParticipantId(currentUserId),
                  conv.displayNameFor(currentUserId),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmClearChat(
    BuildContext context,
    String conversationId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text(
          'Clear all messages from your view? The other person will still have their copy.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    context.read<ConversationBloc>().add(
          ConversationEvent.clearChat(conversationId),
        );
  }

  Future<void> _confirmDeleteMessage(
    BuildContext context,
    String messageId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text(
          'This message will be deleted for everyone. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    context.read<ConversationBloc>().add(
          ConversationEvent.deleteMessageForEveryone(
            conversationId: widget.conversationId,
            messageId: messageId,
          ),
        );
  }

  Future<void> _confirmBlockUser(
    BuildContext context,
    String userId,
    String displayName,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Block User'),
        content: Text(
          'Block $displayName? You won\'t receive messages from them.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Block'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final result = await getIt<ModerationRepository>().blockUser(userId);
    if (!mounted) return;

    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to block user: ${failure.displayMessage}'),
          backgroundColor: AppColors.error,
        ),
      ),
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User blocked')),
        );
        context.go('/chat');
      },
    );
  }
}

/// Bottom sheet for sending or requesting tokens in a conversation.
class _TokenActionsSheet extends StatefulWidget {
  final String conversationId;
  final String recipientId;
  final String recipientName;

  const _TokenActionsSheet({
    required this.conversationId,
    required this.recipientId,
    required this.recipientName,
  });

  @override
  State<_TokenActionsSheet> createState() => _TokenActionsSheetState();
}

class _TokenActionsSheetState extends State<_TokenActionsSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isSending = true;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

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
            Row(
              children: [
                Expanded(child: _buildToggle(context, 'Send', Icons.send, true)),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildToggle(
                      context, 'Request', Icons.call_received, false),
                ),
              ],
            ),
            AppSpacing.verticalSm,
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(
                    '/chat/conversation/${widget.conversationId}/send-gift',
                    extra: {
                      'recipientId': widget.recipientId,
                      'recipientName': widget.recipientName,
                    },
                  );
                },
                icon: const Icon(Icons.card_giftcard),
                label: const Text('Send a Gift instead'),
              ),
            ),
            AppSpacing.verticalLg,
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (Tokens)',
                prefixIcon: const Icon(Icons.monetization_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
              ),
            ),
            AppSpacing.verticalMd,
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Add a note (optional)',
                prefixIcon: const Icon(Icons.note_outlined),
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
              ),
            ),
            AppSpacing.verticalLg,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isSending ? AppColors.success : AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(_isSending ? 'Send Tokens' : 'Request Tokens'),
              ),
            ),
            AppSpacing.verticalMd,
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(
    BuildContext context,
    String label,
    IconData icon,
    bool isSendMode,
  ) {
    final isSelected = _isSending == isSendMode;
    return InkWell(
      onTap: () => setState(() => _isSending = isSendMode),
      borderRadius: AppSpacing.borderRadiusMd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color:
                    isSelected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final note = _noteController.text.trim();

    if (_isSending) {
      context.read<ConversationBloc>().add(
            ConversationEvent.sendTokens(
              conversationId: widget.conversationId,
              recipientId: widget.recipientId,
              amount: amount,
              message: note.isEmpty ? null : note,
            ),
          );
    } else {
      context.read<ConversationBloc>().add(
            ConversationEvent.requestTokens(
              conversationId: widget.conversationId,
              recipientId: widget.recipientId,
              amount: amount,
              message: note.isEmpty ? null : note,
            ),
          );
    }

    Navigator.pop(context);
  }
}
