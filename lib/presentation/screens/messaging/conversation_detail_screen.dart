import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failures.dart';
import '../../../core/services/audio_playback_service.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/enums/call_status.dart';
import '../../../domain/enums/call_type.dart';
import '../../../domain/enums/conversation_type.dart';
import '../../../domain/enums/report_type.dart';
import '../../../domain/repositories/moderation_repository.dart';
import '../../blocs/call/call_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation_actions/conversation_actions_bloc.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/messaging/chat_background.dart';
import '../../widgets/messaging/date_separator.dart';
import '../../widgets/messaging/media_compose_screen.dart';
import '../../widgets/messaging/media_picker_widget.dart';
import '../../widgets/messaging/message_bubble.dart';
import '../../widgets/messaging/message_input_bar.dart';
import '../../widgets/messaging/forward_conversation_picker.dart';
import '../../widgets/messaging/message_search_bar.dart';
import '../../widgets/messaging/reaction_picker.dart';
import '../../widgets/messaging/token_actions_sheet.dart';
import '../../widgets/messaging/typing_indicator.dart';
import '../../widgets/messaging/video_message_recorder.dart';
import '../../widgets/messaging/voice_recorder_widget.dart';
import '../../widgets/moderation/report_sheet.dart';

/// P2P conversation detail screen showing messages and input bar.
///
/// Replaces the old [ChatDetailScreen].
class ConversationDetailScreen extends StatefulWidget {
  final String conversationId;

  const ConversationDetailScreen({super.key, required this.conversationId});

  @override
  State<ConversationDetailScreen> createState() =>
      _ConversationDetailScreenState();
}

class _ConversationDetailScreenState extends State<ConversationDetailScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSearchOpen = false;

  @override
  void initState() {
    super.initState();
    context.read<ConversationBloc>().add(
      ConversationEvent.selectConversation(widget.conversationId),
    );
    context.read<ConversationActionsBloc>().add(
      ConversationActionsEvent.markAsRead(widget.conversationId),
    );
  }

  @override
  void dispose() {
    // Clear typing state when leaving
    context.read<ConversationBloc>().add(
      ConversationEvent.setTyping(
        conversationId: widget.conversationId,
        isTyping: false,
      ),
    );
    _messageController.dispose();
    _scrollController.dispose();
    getIt<AudioPlaybackService>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    return BlocListener<ConversationActionsBloc, ConversationActionsState>(
      listenWhen: (prev, curr) =>
          curr.errorMessage != null && prev.errorMessage != curr.errorMessage,
      listener: (context, actionsState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(actionsState.errorMessage!),
            backgroundColor: AppColors.error,
          ),
        );
        context.read<ConversationActionsBloc>().add(
          const ConversationActionsEvent.clearError(),
        );
      },
      child: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          final conv = state.selectedConversation;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.chatAppBar,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              title: conv != null
                  ? Row(
                      children: [
                        _buildAppBarAvatar(context, conv, currentUserId),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  conv.displayNameFor(currentUserId),
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (conv.hasDisappearingMessages) ...[
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.timer_outlined,
                                  size: 16,
                                  color: AppColors.accent,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Text('Chat'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() => _isSearchOpen = !_isSearchOpen);
                    if (!_isSearchOpen) {
                      context.read<ConversationBloc>().add(
                        const ConversationEvent.clearMessageSearch(),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showChatOptions(context, conv),
                ),
              ],
            ),
            body: Stack(
              children: [
                const Positioned.fill(child: ChatBackground()),
                Column(
                  children: [
                    // Search bar
                    if (_isSearchOpen)
                      MessageSearchBar(
                        resultCount: state.messageSearchResults.length,
                        onSearch: (query) {
                          context.read<ConversationBloc>().add(
                            ConversationEvent.searchMessages(
                              conversationId: widget.conversationId,
                              query: query,
                            ),
                          );
                        },
                        onClose: () {
                          setState(() => _isSearchOpen = false);
                          context.read<ConversationBloc>().add(
                            const ConversationEvent.clearMessageSearch(),
                          );
                        },
                      ),
                    // Message request banner
                    if (conv != null && conv.isMessageRequestFor(currentUserId))
                      _buildMessageRequestBanner(context, conv, currentUserId),
                    Expanded(
                      child: _buildMessageList(context, state, currentUserId),
                    ),
                    // Typing indicator
                    if (state.typingUsers.isNotEmpty)
                      TypingIndicator(
                        typingNames: state.typingUsers.keys
                            .map(
                              (uid) =>
                                  conv?.participants[uid]?.displayName ??
                                  'Someone',
                            )
                            .toList(),
                      ),
                    MessageInputBar(
                      controller: _messageController,
                      isSending: state.isSending,
                      onSend: () => _sendMessage(context),
                      onMediaAttachment:
                          conv != null &&
                              conv.isMessageRequestFor(currentUserId)
                          ? null
                          : () =>
                                _showMediaPicker(context, state, currentUserId),
                      onAttachment:
                          conv != null &&
                              conv.isMessageRequestFor(currentUserId)
                          ? null
                          : () => _showActionPicker(
                              context,
                              state,
                              currentUserId,
                            ),
                      onTypingChanged: (isTyping) {
                        context.read<ConversationBloc>().add(
                          ConversationEvent.setTyping(
                            conversationId: widget.conversationId,
                            isTyping: isTyping,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
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
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppColors.textHint,
            ),
            AppSpacing.verticalMd,
            Text(
              'No messages yet',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            AppSpacing.verticalSm,
            Text(
              'Send a message or tokens to start the conversation',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textHint),
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
        if (!message.isVisibleTo(currentUserId) || message.isExpired) {
          return const SizedBox.shrink();
        }

        final isMe = message.isSentBy(currentUserId);
        final showDate =
            index == messages.length - 1 ||
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
              avatarUrl: state
                  .selectedConversation
                  ?.participants[message.senderId]
                  ?.avatarUrl,
              highlightQuery: state.messageSearchQuery,
              onLongPress: () => _onMessageLongPress(context, message, state),
              onTokenRequestAction: message.isTokenTransfer
                  ? (accepted) =>
                        _handleTokenRequestAction(context, message, accepted)
                  : null,
              onImageTap: message.hasMedia && message.media != null
                  ? () => context.push(
                      '/chat/conversation/${widget.conversationId}/image-viewer',
                      extra: {
                        'messageId': message.id,
                        'imageUrl': message.media!.url,
                        'mediaKeyBase64': message.media!.mediaKey,
                      },
                    )
                  : null,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessageRequestBanner(
    BuildContext context,
    Conversation conv,
    String currentUserId,
  ) {
    final senderName = conv.displayNameFor(currentUserId);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.chatSurface,
        border: Border(bottom: BorderSide(color: AppColors.chatSurface)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$senderName wants to message you',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          AppSpacing.verticalXs,
          Text(
            'Replying will accept this message request',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
          AppSpacing.verticalSm,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<ConversationBloc>().add(
                      ConversationEvent.acceptConversation(conv.id),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text('Accept'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _confirmBlockUser(
                    context,
                    conv.otherParticipantId(currentUserId),
                    senderName,
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: const Text('Block'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMediaPicker(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    showMediaPicker(
      context,
      onMediaSelected: (result) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) => MediaComposeScreen(
              mediaFile: result.file,
              mediaType: result.mediaType,
              onSend: (caption) {
                context.read<ConversationBloc>().add(
                  ConversationEvent.sendMediaMessage(
                    conversationId: widget.conversationId,
                    mediaFile: result.file,
                    mediaType: result.mediaType,
                    recipientId: recipientId,
                    caption: caption,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showActionPicker(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    final conv = state.selectedConversation;
    final isP2P = conv != null && conv.type == ConversationType.p2p;

    showActionPicker(
      context,
      onVoiceNoteRequested: () =>
          _openVoiceRecorder(context, state, currentUserId),
      onVideoNoteRequested: () =>
          _openVideoRecorder(context, state, currentUserId),
      onVoiceCallRequested: isP2P
          ? () => _initiateCall(context, conv, currentUserId, CallType.voice)
          : null,
      onVideoCallRequested: isP2P
          ? () => _initiateCall(context, conv, currentUserId, CallType.video)
          : null,
      onSasazaRequested: () {
        final recipientName =
            state.selectedConversation?.displayNameFor(currentUserId) ?? '';
        context.push(
          '/chat/sasaza',
          extra: {
            'recipientId': recipientId,
            'recipientName': recipientName,
            'conversationId': widget.conversationId,
          },
        );
      },
      onTokenAction: () => _showTokenActions(context, state, currentUserId),
    );
  }

  void _openVoiceRecorder(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      pageBuilder: (ctx, _, __) => VoiceRecorderWidget(
        onRecordingComplete: (result) {
          Navigator.of(ctx).pop();
          context.read<ConversationBloc>().add(
            ConversationEvent.sendMediaMessage(
              conversationId: widget.conversationId,
              mediaFile: result.file,
              mediaType: 'audio/m4a',
              recipientId: recipientId,
              durationSeconds: result.durationSeconds,
            ),
          );
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void _openVideoRecorder(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      pageBuilder: (ctx, _, __) => VideoMessageRecorder(
        onRecordingComplete: (result) {
          Navigator.of(ctx).pop();
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (_) => MediaComposeScreen(
                mediaFile: result.videoFile,
                mediaType: 'video/mp4',
                thumbnailFile: result.thumbnailFile,
                durationSeconds: result.durationSeconds,
                onSend: (caption) {
                  context.read<ConversationBloc>().add(
                    ConversationEvent.sendMediaMessage(
                      conversationId: widget.conversationId,
                      mediaFile: result.videoFile,
                      mediaType: 'video/mp4',
                      recipientId: recipientId,
                      durationSeconds: result.durationSeconds,
                      thumbnailFile: result.thumbnailFile,
                      caption: caption,
                    ),
                  );
                },
              ),
            ),
          );
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final bloc = context.read<ConversationBloc>();
    bloc.add(
      ConversationEvent.sendTextMessage(
        conversationId: widget.conversationId,
        text: text,
      ),
    );
    // Clear typing state on send
    bloc.add(
      ConversationEvent.setTyping(
        conversationId: widget.conversationId,
        isTyping: false,
      ),
    );
    _messageController.clear();
  }

  void _onMessageLongPress(
    BuildContext context,
    Message message,
    ConversationState state,
  ) {
    // Skip for already-deleted messages
    if (message.deletedForEveryone) return;
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
              leading: const Icon(Icons.emoji_emotions_outlined),
              title: const Text('React'),
              onTap: () {
                Navigator.pop(ctx);
                _showReactionPicker(context, message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shortcut_outlined),
              title: const Text('Forward'),
              onTap: () {
                Navigator.pop(ctx);
                _forwardMessage(context, message, state, currentUserId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
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

  Future<void> _forwardMessage(
    BuildContext context,
    Message message,
    ConversationState state,
    String currentUserId,
  ) async {
    final targetConvId = await ForwardConversationPicker.show(
      context: context,
      conversations: state.conversations,
      currentUserId: currentUserId,
    );

    if (targetConvId != null && mounted) {
      context.read<ConversationBloc>().add(
        ConversationEvent.forwardMessage(
          sourceConversationId: widget.conversationId,
          sourceMessageId: message.id,
          targetConversationId: targetConvId,
        ),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Message forwarded')));
    }
  }

  void _showReactionPicker(BuildContext context, Message message) async {
    final actionsBloc = context.read<ConversationActionsBloc>();
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';
    final emoji = await showReactionPicker(context);
    if (emoji != null && mounted) {
      if (message.hasReacted(currentUserId, emoji)) {
        actionsBloc.add(
          ConversationActionsEvent.removeReaction(
            conversationId: widget.conversationId,
            messageId: message.id,
            emoji: emoji,
          ),
        );
      } else {
        actionsBloc.add(
          ConversationActionsEvent.addReaction(
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
      builder: (ctx) => TokenActionsSheet(
        conversationId: widget.conversationId,
        recipientId: recipientId,
        recipientName: recipientName,
      ),
    );
  }

  void _initiateCall(
    BuildContext context,
    Conversation conv,
    String currentUserId,
    CallType callType,
  ) {
    try {
      final recipientId = conv.otherParticipantId(currentUserId);
      final recipientInfo = conv.getOtherParticipant(currentUserId);

      final callBloc = context.read<CallBloc>();
      final router = GoRouter.of(context);
      final conversationId = widget.conversationId;

      debugPrint(
        '_initiateCall: recipientId=$recipientId, '
        'callType=$callType, conversationId=$conversationId',
      );

      // Listen once for the callId to be set on state, then navigate with it
      late final StreamSubscription<CallState> sub;
      sub = callBloc.stream.listen((state) {
        if (state.callId != null) {
          sub.cancel();
          if (mounted) {
            router.push(
              '/chat/conversation/$conversationId/call/${state.callId}',
              extra: {'isVideo': callType == CallType.video},
            );
          }
        } else if (state.status == CallStatus.failed) {
          sub.cancel();
          debugPrint(
            '_initiateCall: FAILED — '
            '${state.errorMessage ?? 'unknown error'}',
          );
        } else if (state.status == CallStatus.idle) {
          sub.cancel();
        }
      });

      // Dispatch call initiation event
      callBloc.add(
        CallEvent.initiateCall(
          conversationId: widget.conversationId,
          recipientId: recipientId,
          recipientName: recipientInfo.displayName,
          recipientAvatarUrl: recipientInfo.avatarUrl,
          callType: callType,
        ),
      );
    } catch (e) {
      debugPrint('_initiateCall: ERROR: $e');
    }
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
                context.read<ConversationActionsBloc>().add(
                  ConversationActionsEvent.toggleMute(
                    conversationId: conv.id,
                    muted: !conv.isMutedFor(currentUserId),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                conv.hasDisappearingMessages
                    ? Icons.timer
                    : Icons.timer_outlined,
                color: conv.hasDisappearingMessages ? AppColors.accent : null,
              ),
              title: Text(
                conv.hasDisappearingMessages
                    ? 'Disappearing messages (${conv.disappearingMessagesLabel})'
                    : 'Disappearing messages',
              ),
              subtitle: conv.hasDisappearingMessages ? null : const Text('Off'),
              onTap: () {
                Navigator.pop(ctx);
                _showDisappearingMessagesDialog(context, conv);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_sweep_outlined,
                color: AppColors.error,
              ),
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
            ListTile(
              leading: const Icon(Icons.flag_outlined, color: AppColors.error),
              title: const Text('Report User'),
              onTap: () {
                Navigator.pop(ctx);
                _reportUser(
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

  void _showDisappearingMessagesDialog(
    BuildContext context,
    Conversation conv,
  ) {
    final currentDuration = conv.disappearingMessagesDuration;

    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textHint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Disappearing Messages',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'New messages will disappear after the selected time. '
                'This does not affect existing messages.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 8),
            _buildDurationOption(ctx, 'Off', null, currentDuration),
            _buildDurationOption(
              ctx,
              '24 hours',
              const Duration(hours: 24),
              currentDuration,
            ),
            _buildDurationOption(
              ctx,
              '7 days',
              const Duration(days: 7),
              currentDuration,
            ),
            _buildDurationOption(
              ctx,
              '90 days',
              const Duration(days: 90),
              currentDuration,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationOption(
    BuildContext ctx,
    String label,
    Duration? duration,
    Duration? currentDuration,
  ) {
    final isSelected = duration == currentDuration;
    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : null,
      onTap: () {
        Navigator.pop(ctx);
        if (!isSelected) {
          context.read<ConversationBloc>().add(
            ConversationEvent.setDisappearingMessages(
              conversationId: widget.conversationId,
              duration: duration,
            ),
          );
        }
      },
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

    context.read<ConversationActionsBloc>().add(
      ConversationActionsEvent.deleteMessageForEveryone(
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User blocked')));
        context.go('/chat');
      },
    );
  }

  void _reportUser(BuildContext context, String userId, String displayName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ReportSheet(
        targetName: displayName,
        onSubmit: (reason, additionalInfo) async {
          final result = await getIt<ModerationRepository>().submitReport(
            type: ReportType.user,
            targetId: userId,
            reason: reason,
            additionalInfo: additionalInfo,
          );
          if (!mounted) return;
          result.fold(
            (failure) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to submit report: ${failure.displayMessage}',
                ),
                backgroundColor: AppColors.error,
              ),
            ),
            (_) => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Report submitted'))),
          );
        },
      ),
    );
  }
}

