import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/security/secure_clipboard.dart';
import '../../../core/di/injection.dart';
import '../../../data/datasources/local/app_database.dart';
import '../../../core/utils/chat_date_formatter.dart';
import '../../../core/error/failures.dart';
import '../../../core/services/audio_playback_service.dart';
import '../../../core/services/conversation_export_service.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/enums/call_status.dart';
import '../../../domain/enums/call_type.dart';
import '../../../domain/enums/conversation_type.dart';
import '../../../domain/enums/message_status.dart';
import '../../../domain/enums/report_type.dart';
import '../../../domain/repositories/moderation_repository.dart';
import '../../blocs/call/call_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/conversation/conversation_bloc.dart';
import '../../blocs/conversation_actions/conversation_actions_bloc.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/messaging/chat_background.dart' show ChatBackground, ChatThemePicker, ChatThemeStyle;
import '../../widgets/messaging/imali_bottom_sheet.dart';
import '../../widgets/messaging/date_separator.dart';
import '../../widgets/messaging/media_compose_screen.dart';
import '../../widgets/messaging/media_picker_widget.dart';
import '../../widgets/messaging/message_bubble.dart';
import '../../widgets/messaging/message_input_bar.dart';
import '../../widgets/messaging/forward_conversation_picker.dart';
import '../../widgets/messaging/message_search_bar.dart';
import '../../widgets/messaging/message_context_menu.dart';
import '../../widgets/messaging/token_actions_sheet.dart';
import '../../widgets/messaging/typing_indicator.dart';
import '../../widgets/messaging/video_message_recorder.dart';
import '../../widgets/messaging/voice_recorder_widget.dart';
import '../../widgets/buy/listing_context_header.dart';
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

  /// Multi-select mode state.
  bool _isMultiSelectMode = false;
  final Set<String> _selectedMessageIds = {};

  /// Current chat wallpaper theme.
  ChatThemeStyle _chatTheme = ChatThemeStyle.defaultDoodle;

  /// True when user has scrolled up away from the newest messages.
  bool _isScrolledUp = false;

  /// Count of new messages received while user is scrolled up.
  int _newMessageCount = 0;

  /// Previous message count — used to detect new arrivals.
  int _previousMessageCount = 0;

  /// Sticky date header — the date currently visible at the top of the message list.
  DateTime? _stickyDate;

  /// Whether the sticky header should be visible (hidden when not scrolled).
  bool _stickyDateVisible = false;

  /// Timer to auto-hide the sticky date header after scrolling stops.
  Timer? _stickyDateTimer;

  /// Initial unread count captured on screen open (before markAsRead clears it).
  int? _initialUnreadCount;

  /// Temporarily highlighted message ID (for scroll-to-reply flash).
  String? _highlightedMessageId;

  @override
  void initState() {
    super.initState();
    _loadChatTheme();
    _scrollController.addListener(_onScroll);
    context.read<ConversationBloc>().add(
      ConversationEvent.selectConversation(widget.conversationId),
    );
    context.read<ConversationActionsBloc>().add(
      ConversationActionsEvent.markAsRead(widget.conversationId),
    );
  }

  void _onScroll() {
    // In a reverse ListView, offset 0 = bottom (newest). Scrolled up = offset > threshold.
    final isUp = _scrollController.hasClients &&
        _scrollController.offset > 150;
    if (isUp != _isScrolledUp) {
      setState(() {
        _isScrolledUp = isUp;
        if (!isUp) _newMessageCount = 0;
      });
    }

    // Show sticky date header while actively scrolling
    _stickyDateTimer?.cancel();
    if (!_stickyDateVisible && _scrollController.offset > 10) {
      setState(() => _stickyDateVisible = true);
    }
    _stickyDateTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _stickyDateVisible = false);
    });
  }

  /// Estimate which message date is visible at the top of the viewport.
  void _updateStickyDate(List<Message> messages, ScrollNotification notification) {
    if (messages.isEmpty) return;
    // In a reverse list, higher scroll offset = older messages (higher index).
    // Estimate top-visible index from scroll offset and average item height (~70px).
    final viewportHeight = notification.metrics.viewportDimension;
    final offset = notification.metrics.pixels;
    const estimatedItemHeight = 70.0;
    final topIndex = ((offset + viewportHeight) / estimatedItemHeight)
        .floor()
        .clamp(0, messages.length - 1);
    final topDate = messages[topIndex].createdAt;
    if (_stickyDate == null || !DateSeparator.isSameDay(_stickyDate!, topDate)) {
      setState(() => _stickyDate = topDate);
    }
  }

  /// Scroll to a specific message by ID and briefly highlight it.
  void _scrollToMessage(String messageId, List<Message> messages) {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;

    // In a reverse ListView, the pixel offset for index i is approximately i * estimatedItemHeight.
    const estimatedItemHeight = 70.0;
    final targetOffset = index * estimatedItemHeight;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    // Flash highlight
    setState(() => _highlightedMessageId = messageId);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _highlightedMessageId = null);
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    setState(() {
      _isScrolledUp = false;
      _newMessageCount = 0;
    });
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
    _stickyDateTimer?.cancel();
    _messageController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    getIt<AudioPlaybackService>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    return BlocListener<ConversationBloc, ConversationState>(
      listenWhen: (prev, curr) => curr.messages.length != prev.messages.length,
      listener: (context, convState) {
        final newCount = convState.messages.length;
        if (newCount > _previousMessageCount && _isScrolledUp) {
          setState(() {
            _newMessageCount += newCount - _previousMessageCount;
          });
        } else if (!_isScrolledUp && _scrollController.hasClients) {
          // Auto-scroll to bottom for new messages when user is at bottom
        }
        _previousMessageCount = newCount;
      },
      child: BlocListener<ConversationActionsBloc, ConversationActionsState>(
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

          // Capture initial unread count once (before markAsRead zeroes it).
          if (_initialUnreadCount == null && conv != null) {
            _initialUnreadCount = conv.unreadCountFor(currentUserId);
          }

          return Scaffold(
            appBar: _isMultiSelectMode
                ? AppBar(
                    backgroundColor: AppColors.chatSurface,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    shape: const Border(bottom: BorderSide(color: Color(0xFF252840), width: 0.5)),
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() {
                        _isMultiSelectMode = false;
                        _selectedMessageIds.clear();
                      }),
                    ),
                    title: Text('${_selectedMessageIds.length} selected'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: _selectedMessageIds.isEmpty
                            ? null
                            : () {
                                for (final id in _selectedMessageIds) {
                                  context.read<ConversationActionsBloc>().add(
                                    ConversationActionsEvent
                                        .deleteMessageForEveryone(
                                      conversationId: widget.conversationId,
                                      messageId: id,
                                    ),
                                  );
                                }
                                setState(() {
                                  _isMultiSelectMode = false;
                                  _selectedMessageIds.clear();
                                });
                              },
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: _selectedMessageIds.isEmpty
                            ? null
                            : () {
                                final texts = state.messages
                                    .where((m) =>
                                        _selectedMessageIds.contains(m.id) &&
                                        m.textContent != null)
                                    .map((m) => m.textContent!)
                                    .join('\n');
                                SecureClipboard.copy(texts);
                                setState(() {
                                  _isMultiSelectMode = false;
                                  _selectedMessageIds.clear();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Copied to clipboard')),
                                );
                              },
                      ),
                    ],
                  )
                : AppBar(
                    backgroundColor: AppColors.chatSurface,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    shape: const Border(bottom: BorderSide(color: Color(0xFF252840), width: 0.5)),
                    title: conv != null
                        ? Row(
                            children: [
                              _buildAppBarAvatar(
                                  context, conv, currentUserId),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        conv.displayNameFor(currentUserId),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
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
                Positioned.fill(child: ChatBackground(theme: _chatTheme)),
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
                    // Stream error retry banner
                    if (state.hasStreamError)
                      Material(
                        color: AppColors.error.withValues(alpha: 0.1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.cloud_off,
                                  size: 18, color: AppColors.error),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Connection lost. Messages may be outdated.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColors.error),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<ConversationBloc>().add(
                                        const ConversationEvent.clearError(),
                                      );
                                  context.read<ConversationBloc>().add(
                                        ConversationEvent.selectConversation(
                                            widget.conversationId),
                                      );
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Message request banner
                    if (conv != null && conv.isMessageRequestFor(currentUserId))
                      _buildMessageRequestBanner(context, conv, currentUserId),
                    // Marketplace listing context header
                    if (conv != null && conv.isMarketplaceConversation)
                      ListingContextHeader(
                        title: conv.marketplaceListingTitle ?? 'Listing',
                        thumbnailUrl: conv.marketplaceListingThumbnailUrl,
                        formattedPrice: conv.marketplaceListingPrice != null
                            ? '${conv.marketplaceListingPrice} tokens'
                            : '',
                        onTap: () {
                          if (conv.marketplaceListingId != null) {
                            context.go(
                              '/buy/marketplace/listing/${conv.marketplaceListingId}',
                            );
                          }
                        },
                      ),
                    Expanded(
                      child: Stack(
                        children: [
                          _buildMessageList(context, state, currentUserId),
                          // Floating sticky date header (WhatsApp-style)
                          if (_stickyDate != null)
                            Positioned(
                              top: 8,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: AnimatedOpacity(
                                  opacity: _stickyDateVisible ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.chatSurface,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      ChatDateFormatter.formatDateHeader(_stickyDate!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColors.textSecondary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // "New messages ↓" floating pill
                          if (_isScrolledUp && _newMessageCount > 0)
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: _scrollToBottom,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '$_newMessageCount new message${_newMessageCount > 1 ? 's' : ''} ↓',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppColors.textOnPrimary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // Scroll-to-bottom button (when scrolled up but no new messages)
                          if (_isScrolledUp && _newMessageCount == 0)
                            Positioned(
                              bottom: 8,
                              right: 16,
                              child: FloatingActionButton.small(
                                onPressed: _scrollToBottom,
                                backgroundColor: AppColors.chatSurface,
                                child: const Icon(Icons.keyboard_arrow_down,
                                    color: AppColors.textPrimary),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Quick reply suggestions (shown when no text entered and few messages)
                    if (_messageController.text.isEmpty &&
                        state.messages.length <= 2 &&
                        state.messages.isNotEmpty &&
                        !state.messages.first.isSentBy(currentUserId))
                      _QuickReplySuggestions(
                        onSuggestionTap: (text) {
                          _messageController.text = text;
                          _sendMessage(context);
                        },
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
        fadeInDuration: const Duration(milliseconds: 150),
        imageBuilder: (_, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, _) => initialsWidget,
        errorWidget: (_, _, _) => initialsWidget,
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
      return _buildMessageListShimmer();
    }

    if (state.messages.isEmpty) {
      // Show syncing indicator while background sync fetches and decrypts
      // messages from Firestore (e.g. after reinstall).
      if (state.isSyncingMessages) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              AppSpacing.verticalMd,
              Text(
                'Syncing messages...',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        );
      }

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

    // Messages are newest-first from the DB. With reverse:true, index 0
    // renders at the bottom — so newest messages appear at the bottom (WhatsApp style).
    final messages = state.messages;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _updateStickyDate(messages, notification);
        return false;
      },
      child: ListView.builder(
      controller: _scrollController,
      reverse: true,
      addAutomaticKeepAlives: false,
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

        // Unread divider: show above the oldest unread message.
        // In reversed list, unread msgs are indices 0..(unread-1).
        // The divider sits at the boundary = index (unread - 1).
        final unread = _initialUnreadCount ?? 0;
        final showUnreadDivider =
            unread > 0 && !isMe && index == unread - 1;

        final otherName = state.selectedConversation
            ?.getOtherParticipant(currentUserId)
            .displayName;

        // Message clustering: hide avatar/tail for consecutive same-sender messages.
        // Since list is reversed, index-1 is the NEXT message chronologically.
        final nextMsg = index > 0 ? messages[index - 1] : null;
        final showTail = nextMsg == null ||
            nextMsg.senderId != message.senderId ||
            nextMsg.isSystem ||
            !DateSeparator.isSameDay(message.createdAt, nextMsg.createdAt);
        final showAvatar = showTail; // avatar on last message of cluster

        final isSelected = _selectedMessageIds.contains(message.id);
        final isHighlighted = _highlightedMessageId == message.id;

        final bubble = GestureDetector(
          onTap: _isMultiSelectMode
              ? () => setState(() {
                    if (isSelected) {
                      _selectedMessageIds.remove(message.id);
                      if (_selectedMessageIds.isEmpty) {
                        _isMultiSelectMode = false;
                      }
                    } else {
                      _selectedMessageIds.add(message.id);
                    }
                  })
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : isHighlighted
                    ? AppColors.accent.withValues(alpha: 0.15)
                    : Colors.transparent,
            child: Column(
              key: ValueKey(message.id),
              children: [
                if (showUnreadDivider)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const Expanded(child: Divider(color: AppColors.primary, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '$unread new message${unread > 1 ? 's' : ''}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: AppColors.primary, thickness: 1)),
                      ],
                    ),
                  ),
                if (showDate) DateSeparator(date: message.createdAt),
                MessageBubble(
                  message: message,
                  isMe: isMe,
                  currentUserId: currentUserId,
                  avatarUrl: state
                      .selectedConversation
                      ?.participants[message.senderId]
                      ?.avatarUrl,
                  otherUserName: otherName,
                  highlightQuery: state.messageSearchQuery,
                  showAvatar: showAvatar,
                  showTail: showTail,
                  onLongPress: _isMultiSelectMode
                      ? null
                      : () => _onMessageLongPress(context, message, state),
                  onSwipeReply: _isMultiSelectMode
                      ? null
                      : (msg) => _startReply(msg),
                  onDoubleTapReact: _isMultiSelectMode
                      ? null
                      : (msg) => _quickToggleReaction(context, msg),
                  onTokenRequestAction: message.isTokenTransfer
                      ? (accepted) =>
                            _handleTokenRequestAction(context, message, accepted)
                      : null,
                  onReplyTap: message.replyTo != null
                      ? () => _scrollToMessage(
                            message.replyTo!.messageId,
                            state.messages,
                          )
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
            ),
          ),
        );

        // Subtle slide-up animation for optimistic (just-sent) messages
        if (isMe && message.status == MessageStatus.sending && index == 0) {
          return TweenAnimationBuilder<Offset>(
            tween: Tween(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            builder: (_, offset, child) => FractionalTranslation(
              translation: offset,
              child: child,
            ),
            child: bubble,
          );
        }

        // Fade+slide animation for newly received messages
        if (!isMe && index == 0) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            builder: (_, value, child) => Opacity(
              opacity: value,
              child: FractionalTranslation(
                translation: Offset(0, 0.1 * (1.0 - value)),
                child: child,
              ),
            ),
            child: bubble,
          );
        }

        return bubble;
      },
    ),
    );
  }

  Widget _buildMessageListShimmer() {
    return ListView.builder(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: 6,
      itemBuilder: (context, index) {
        final isMe = index.isEven;
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: _ShimmerBubble(isMe: isMe),
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

  void _openMediaCompose(
    BuildContext context,
    String recipientId,
    MediaPickerResult result,
  ) {
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
  }

  Future<void> _pickFromCamera(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) async {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null && context.mounted) {
      _openMediaCompose(
        context,
        recipientId,
        MediaPickerResult(file: File(image.path), mediaType: 'image'),
      );
    }
  }

  Future<void> _pickFromGallery(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) async {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (image != null && context.mounted) {
      _openMediaCompose(
        context,
        recipientId,
        MediaPickerResult(file: File(image.path), mediaType: 'image'),
      );
    }
  }

  Future<void> _pickDocument(
    BuildContext context,
    ConversationState state,
    String currentUserId,
  ) async {
    final recipientId = state.getRecipientId(currentUserId);
    if (recipientId == null || recipientId.isEmpty) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'csv',
        'zip',
      ],
      allowMultiple: false,
    );
    if (result != null &&
        result.files.isNotEmpty &&
        result.files.first.path != null &&
        context.mounted) {
      _openMediaCompose(
        context,
        recipientId,
        MediaPickerResult(
          file: File(result.files.first.path!),
          mediaType: 'document',
        ),
      );
    }
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
      onCameraRequested: () => _pickFromCamera(context, state, currentUserId),
      onGalleryRequested: () => _pickFromGallery(context, state, currentUserId),
      onDocumentRequested: () =>
          _pickDocument(context, state, currentUserId),
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
      pageBuilder: (ctx, _, _) => VoiceRecorderWidget(
        onRecordingComplete: (result) {
          Navigator.of(ctx).pop();
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (_) => MediaComposeScreen(
                mediaFile: result.file,
                mediaType: 'audio/m4a',
                durationSeconds: result.durationSeconds,
                onSend: (caption) {
                  context.read<ConversationBloc>().add(
                    ConversationEvent.sendMediaMessage(
                      conversationId: widget.conversationId,
                      mediaFile: result.file,
                      mediaType: 'audio/m4a',
                      recipientId: recipientId,
                      durationSeconds: result.durationSeconds,
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
      pageBuilder: (ctx, _, _) => VideoMessageRecorder(
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

  void _startReply(Message message) {
    // Reply-indicator UI will be built in a follow-up pass.
  }

  void _startEdit(Message message) {
    _messageController.text = message.textContent ?? '';
  }

  /// Quick-toggle ❤️ reaction on double-tap (no context menu).
  void _quickToggleReaction(BuildContext context, Message msg) {
    const emoji = '❤️';
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';
    final actionsBloc = context.read<ConversationActionsBloc>();
    HapticFeedback.lightImpact();

    if (msg.hasReacted(currentUserId, emoji)) {
      actionsBloc.add(ConversationActionsEvent.removeReaction(
        conversationId: widget.conversationId,
        messageId: msg.id,
        emoji: emoji,
      ));
    } else {
      actionsBloc.add(ConversationActionsEvent.addReaction(
        conversationId: widget.conversationId,
        messageId: msg.id,
        emoji: emoji,
      ));
    }
  }

  void _onMessageLongPress(
    BuildContext context,
    Message message,
    ConversationState state,
  ) {
    if (message.deletedForEveryone) return;
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';
    final isMe = message.isSentBy(currentUserId);
    final conv = state.selectedConversation;
    final convType = conv?.type ?? ConversationType.p2p;

    showMessageContextMenu(
      context: context,
      message: message,
      isMe: isMe,
      currentUserId: currentUserId,
      conversationType: convType,
      onReact: (msg, emoji) {
        final actionsBloc = context.read<ConversationActionsBloc>();
        if (msg.hasReacted(currentUserId, emoji)) {
          actionsBloc.add(ConversationActionsEvent.removeReaction(
            conversationId: widget.conversationId,
            messageId: msg.id,
            emoji: emoji,
          ));
        } else {
          actionsBloc.add(ConversationActionsEvent.addReaction(
            conversationId: widget.conversationId,
            messageId: msg.id,
            emoji: emoji,
          ));
        }
      },
      onReply: (msg) => _startReply(msg),
      onCopy: (msg) {
        if (msg.textContent != null) {
          SecureClipboard.copy(msg.textContent!);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Copied to clipboard')),
          );
        }
      },
      onForward: (msg) => _forwardMessage(context, msg, state, currentUserId),
      onEdit: (msg) => _startEdit(msg),
      onDeleteForMe: (msg) {
        context.read<ConversationActionsBloc>().add(
          ConversationActionsEvent.deleteMessageForEveryone(
            conversationId: widget.conversationId,
            messageId: msg.id,
          ),
        );
      },
      onDeleteForEveryone: (msg) => _confirmDeleteMessage(context, msg.id),
      onSelect: () {
        setState(() {
          _isMultiSelectMode = true;
          _selectedMessageIds.add(message.id);
        });
      },
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

    if (targetConvId != null && context.mounted) {
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
    } catch (_) {
    }
  }

  void _showChatOptions(BuildContext context, Conversation? conv) {
    if (conv == null) return;
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';

    showIMaliBottomSheet(
      context: context,
      children: [
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
                Navigator.pop(context);
                _showDisappearingMessagesDialog(context, conv);
              },
            ),
            ListTile(
              leading: Icon(Icons.auto_awesome, color: AppColors.secondary),
              title: const Text('AI Summary'),
              subtitle: const Text('Coming soon'),
              enabled: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.wallpaper_outlined),
              title: const Text('Chat Wallpaper'),
              onTap: () {
                Navigator.pop(context);
                _showWallpaperPicker(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.ios_share_outlined),
              title: const Text('Export Chat'),
              onTap: () {
                Navigator.pop(context);
                _showExportOptions(context, conv);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_sweep_outlined,
                color: AppColors.error,
              ),
              title: const Text('Clear Chat'),
              onTap: () {
                Navigator.pop(context);
                _confirmClearChat(context, conv.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block_outlined, color: AppColors.error),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
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
                Navigator.pop(context);
                _reportUser(
                  context,
                  conv.otherParticipantId(currentUserId),
                  conv.displayNameFor(currentUserId),
                );
              },
            ),
      ],
    );
  }

  /// Key used by the messaging tab to persist the global wallpaper.
  static const _globalThemeKey = 'chat_tab_wallpaper';

  Future<void> _loadChatTheme() async {
    // Per-conversation theme takes priority; fall back to the global tab wallpaper.
    final name = await getIt<AppDatabase>().getChatTheme(widget.conversationId);
    final String effectiveName;
    if (name != null) {
      effectiveName = name;
    } else {
      final prefs = await SharedPreferences.getInstance();
      effectiveName = prefs.getString(_globalThemeKey) ?? 'defaultDoodle';
    }
    final style = ChatThemeStyle.values.firstWhere(
      (s) => s.name == effectiveName,
      orElse: () => ChatThemeStyle.defaultDoodle,
    );
    if (mounted && style != _chatTheme) {
      setState(() => _chatTheme = style);
    }
  }

  void _showWallpaperPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ChatThemePicker(
        current: _chatTheme,
        onSelected: (theme) {
          setState(() => _chatTheme = theme);
          getIt<AppDatabase>().setChatTheme(widget.conversationId, theme.name);
        },
      ),
    );
  }

  void _showExportOptions(BuildContext context, Conversation conv) {
    final currentUserId = context.read<AuthBloc>().state.user?.id ?? '';
    final convName = conv.displayNameFor(currentUserId);

    showIMaliBottomSheet(
      context: context,
      title: 'Export Chat',
      children: [
            ListTile(
              leading: const Icon(Icons.text_snippet_outlined),
              title: const Text('Without Media'),
              subtitle: const Text('Export as text file'),
              onTap: () {
                Navigator.pop(context);
                _exportChat(
                  context,
                  conversationId: conv.id,
                  conversationName: convName,
                  currentUserId: currentUserId,
                  withMedia: false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_media_outlined),
              title: const Text('Include Media'),
              subtitle:
                  const Text('Export as ZIP with photos, videos & documents'),
              onTap: () {
                Navigator.pop(context);
                _exportChat(
                  context,
                  conversationId: conv.id,
                  conversationName: convName,
                  currentUserId: currentUserId,
                  withMedia: true,
                );
              },
            ),
      ],
    );
  }

  Future<void> _exportChat(
    BuildContext context, {
    required String conversationId,
    required String conversationName,
    required String currentUserId,
    required bool withMedia,
  }) async {
    final exportService = getIt<ConversationExportService>();
    final messenger = ScaffoldMessenger.of(context);

    try {
      if (!withMedia) {
        // Text-only: quick export with loading overlay
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );

        final file = await exportService.exportAsText(
          conversationId: conversationId,
          conversationName: conversationName,
          currentUserId: currentUserId,
        );

        if (context.mounted) Navigator.of(context).pop(); // dismiss loader
        await SharePlus.instance.share(
          ShareParams(
            files: [file],
            subject: 'iMaliChat \u2014 $conversationName',
          ),
        );
      } else {
        // With media: progress dialog
        final progress = ValueNotifier<(int, int)>((0, 0));

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ValueListenableBuilder<(int, int)>(
            valueListenable: progress,
            builder: (_, value, _) {
              final (completed, total) = value;
              final fraction = total > 0 ? completed / total : 0.0;
              return AlertDialog(
                title: const Text('Exporting chat...'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(value: fraction),
                    const SizedBox(height: 12),
                    Text(
                      total > 0
                          ? '$completed of $total media files'
                          : 'Preparing...',
                    ),
                  ],
                ),
              );
            },
          ),
        );

        final file = await exportService.exportWithMedia(
          conversationId: conversationId,
          conversationName: conversationName,
          currentUserId: currentUserId,
          onProgress: (completed, total) {
            progress.value = (completed, total);
          },
        );

        if (context.mounted) Navigator.of(context).pop(); // dismiss dialog
        progress.dispose();

        await SharePlus.instance.share(
          ShareParams(
            files: [file],
            subject: 'iMaliChat \u2014 $conversationName',
          ),
        );
      }
    } on ExportException catch (e) {
      if (context.mounted) {
        // Dismiss any open dialog
        Navigator.of(context).popUntil((route) => route is! DialogRoute);
      }
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route is! DialogRoute);
      }
      messenger.showSnackBar(
        const SnackBar(content: Text('Failed to export chat')),
      );
    }
  }

  void _showDisappearingMessagesDialog(
    BuildContext context,
    Conversation conv,
  ) {
    final currentDuration = conv.disappearingMessagesDuration;

    showIMaliBottomSheet(
      context: context,
      title: 'Disappearing Messages',
      children: [
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
            _buildDurationOption(context, 'Off', null, currentDuration),
            _buildDurationOption(
              context,
              '24 hours',
              const Duration(hours: 24),
              currentDuration,
            ),
            _buildDurationOption(
              context,
              '7 days',
              const Duration(days: 7),
              currentDuration,
            ),
            _buildDurationOption(
              context,
              '90 days',
              const Duration(days: 90),
              currentDuration,
            ),
      ],
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

    if (confirmed != true || !context.mounted) return;

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

    if (confirmed != true || !context.mounted) return;

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

/// Horizontal row of quick-reply chip suggestions above the input bar.
class _QuickReplySuggestions extends StatelessWidget {
  final ValueChanged<String> onSuggestionTap;

  const _QuickReplySuggestions({required this.onSuggestionTap});

  static const _suggestions = ['Hi!', 'Thanks!', 'Sure', 'On my way', 'Got it'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _suggestions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final text = _suggestions[index];
          return ActionChip(
            label: Text(text),
            labelStyle: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: AppColors.chatSurface,
            side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
            onPressed: () => onSuggestionTap(text),
          );
        },
      ),
    );
  }
}

/// Animated shimmer bubble placeholder for message list loading state.
class _ShimmerBubble extends StatefulWidget {
  final bool isMe;
  const _ShimmerBubble({required this.isMe});

  @override
  State<_ShimmerBubble> createState() => _ShimmerBubbleState();
}

class _ShimmerBubbleState extends State<_ShimmerBubble>
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
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            width: widget.isMe ? 200 : 160,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.chatSurface.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

