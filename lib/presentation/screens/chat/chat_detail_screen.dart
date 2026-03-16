import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat_card.dart';
import '../../../domain/entities/chat_thread.dart';
import '../../../domain/enums/chat_card_type.dart';
import '../../../domain/enums/chat_card_status.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/common/tab_background.dart';

@Deprecated('Use ConversationDetailScreen instead. Will be removed in a future cleanup PR.')
class ChatDetailScreen extends StatefulWidget {
  final String threadId;

  const ChatDetailScreen({super.key, required this.threadId});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ChatEvent.selectThread(widget.threadId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        context.read<AuthBloc>().state.user?.id ?? '';

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final thread = state.selectedThread;

        return Scaffold(
          appBar: AppBar(
            title: thread != null
                ? Row(
                    children: [
                      _buildAppBarAvatar(context, thread),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              thread.displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Text('Chat'),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showChatOptions(context, thread),
              ),
            ],
          ),
          body: TabBackground(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.chatGradient,
            ),
            overlayAsset: null,
            child: Column(
              children: [
                Expanded(
                  child: _buildMessageList(context, state, currentUserId),
                ),
                _buildInputBar(context, state, currentUserId),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBarAvatar(BuildContext context, ChatThread thread) {
    final color = AppColors.parseHex(thread.avatarColor);

    final initialsWidget = CircleAvatar(
      radius: 18,
      backgroundColor: color.withValues(alpha: 0.2),
      child: Text(
        thread.displayInitials,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );

    if (thread.avatarUrl != null) {
      return CachedNetworkImage(
        imageUrl: thread.avatarUrl!,
        imageBuilder: (_, imageProvider) => CircleAvatar(
          radius: 18,
          backgroundImage: imageProvider,
        ),
        placeholder: (_, _) => initialsWidget,
        errorWidget: (_, _, _) => initialsWidget,
      );
    }

    return initialsWidget;
  }

  Widget _buildMessageList(
    BuildContext context,
    ChatState state,
    String currentUserId,
  ) {
    if (state.isLoadingMessages && state.messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppColors.textHint,
            ),
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

    // Messages are typically sorted newest first from the API
    final messages = state.messages.reversed.toList();

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMe = message.senderId == currentUserId;
        final showDate = index == messages.length - 1 ||
            !_isSameDay(
              messages[index].createdAt,
              messages[index + 1].createdAt,
            );

        return Column(
          children: [
            if (showDate) _buildDateSeparator(context, message.createdAt),
            _buildMessageBubble(context, message, isMe, currentUserId),
          ],
        );
      },
    );
  }

  Widget _buildDateSeparator(BuildContext context, DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _formatDateHeader(date),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    ChatCard message,
    bool isMe,
    String currentUserId,
  ) {
    if (message.type.isTokenRelated) {
      return _buildTokenCard(context, message, isMe, currentUserId);
    }

    if (message.type == ChatCardType.system) {
      return _buildSystemMessage(context, message);
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.textContent ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isMe ? Colors.white : AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isMe
                        ? Colors.white.withValues(alpha: 0.7)
                        : AppColors.textHint,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenCard(
    BuildContext context,
    ChatCard message,
    bool isMe,
    String currentUserId,
  ) {
    final isSend = message.type == ChatCardType.tokenSend;
    final isRequest = message.type == ChatCardType.tokenRequest;
    final canAction = isRequest &&
        message.recipientId == currentUserId &&
        message.status == ChatCardStatus.pending;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: isSend
              ? AppColors.success.withValues(alpha: 0.5)
              : AppColors.accent.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSend
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSend ? Icons.send : Icons.call_received,
                  color: isSend ? AppColors.success : AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSend
                          ? (isMe ? 'You sent' : 'Sent to you')
                          : (isMe ? 'You requested' : 'Request from'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    Text(
                      '${message.tokenAmount} Tokens',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSend ? AppColors.success : AppColors.accent,
                          ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(context, message.status),
            ],
          ),
          if (message.textContent?.isNotEmpty == true) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Text(
                message.textContent!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ],
          if (canAction) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context
                          .read<ChatBloc>()
                          .add(ChatEvent.declineTokenRequest(message.id));
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<ChatBloc>()
                          .add(ChatEvent.acceptTokenRequest(message.id));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                    ),
                    child: const Text('Pay'),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          Text(
            _formatTime(message.createdAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, ChatCardStatus status) {
    Color color;
    String text;

    switch (status) {
      case ChatCardStatus.pending:
        color = AppColors.warning;
        text = 'Pending';
        break;
      case ChatCardStatus.paid:
        color = AppColors.success;
        text = 'Paid';
        break;
      case ChatCardStatus.declined:
        color = AppColors.error;
        text = 'Declined';
        break;
      case ChatCardStatus.expired:
        color = AppColors.textSecondary;
        text = 'Expired';
        break;
      case ChatCardStatus.cancelled:
        color = AppColors.textSecondary;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildSystemMessage(BuildContext context, ChatCard message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.textContent ?? '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar(
    BuildContext context,
    ChatState state,
    String currentUserId,
  ) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_money),
            color: AppColors.primary,
            onPressed: () => _showTokenActionsSheet(context, state),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: state.isSending ? null : () => _sendMessage(context),
            icon: state.isSending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final state = context.read<ChatBloc>().state;
    if (state.selectedThread == null) return;

    context.read<ChatBloc>().add(ChatEvent.sendTextMessage(
          threadId: state.selectedThread!.id,
          text: text,
        ));

    _messageController.clear();
  }

  void _showTokenActionsSheet(BuildContext context, ChatState state) {
    if (state.selectedThread == null) return;

    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';
    final recipientId = state.getRecipientId(currentUserId);

    showModalBottomSheet(
      context: context,
      builder: (context) => TokenActionsSheet(
        threadId: state.selectedThread!.id,
        recipientId: recipientId ?? '',
      ),
    );
  }

  void _showChatOptions(BuildContext context, ChatThread? thread) {
    if (thread == null) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
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
                leading: const Icon(Icons.person_outline),
                title: const Text('View Profile'),
                onTap: () {
                  Navigator.pop(context);
                  // Profile navigation not yet wired
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
                leading: const Icon(Icons.block_outlined),
                title: const Text('Block User'),
                onTap: () {
                  Navigator.pop(context);
                  // Block user not yet wired
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (_isSameDay(date, now)) {
      return 'Today';
    } else if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      const days = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      return days[date.weekday - 1];
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class TokenActionsSheet extends StatefulWidget {
  final String threadId;
  final String recipientId;

  const TokenActionsSheet({
    super.key,
    required this.threadId,
    required this.recipientId,
  });

  @override
  State<TokenActionsSheet> createState() => _TokenActionsSheetState();
}

class _TokenActionsSheetState extends State<TokenActionsSheet> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
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
                Expanded(
                  child: _buildToggleButton(
                    context,
                    'Send',
                    Icons.send,
                    _isSending,
                    () => setState(() => _isSending = true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildToggleButton(
                    context,
                    'Request',
                    Icons.call_received,
                    !_isSending,
                    () => setState(() => _isSending = false),
                  ),
                ),
              ],
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
                onPressed: _submitAction,
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

  Widget _buildToggleButton(
    BuildContext context,
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
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
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color:
                        isSelected ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitAction() {
    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final note = _noteController.text.trim();

    if (_isSending) {
      context.read<ChatBloc>().add(ChatEvent.sendTokens(
            threadId: widget.threadId,
            recipientId: widget.recipientId,
            amount: amount,
            message: note.isEmpty ? null : note,
          ));
    } else {
      context.read<ChatBloc>().add(ChatEvent.requestTokens(
            threadId: widget.threadId,
            recipientId: widget.recipientId,
            amount: amount,
            message: note.isEmpty ? null : note,
          ));
    }

    Navigator.pop(context);
  }
}
