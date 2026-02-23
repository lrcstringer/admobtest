import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/enums/message_status.dart';
import '../../../domain/enums/message_type.dart';
import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/value_objects/user_search_result.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';
part 'conversation_bloc.freezed.dart';

@injectable
class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository _conversationRepository;
  StreamSubscription? _conversationsSubscription;
  StreamSubscription? _messagesSubscription;
  StreamSubscription? _unreadSubscription;
  StreamSubscription? _typingSubscription;
  Timer? _typingDebounce;

  /// IDs of optimistic messages that haven't been confirmed by the server stream yet.
  /// Used by _onMessagesUpdated to keep optimistic messages visible during stream emissions.
  final Set<String> _pendingOptimisticIds = {};

  ConversationBloc(this._conversationRepository)
      : super(const ConversationState()) {
    // Conversation list
    on<_WatchConversations>(_onWatchConversations);
    on<_ConversationsUpdated>(_onConversationsUpdated);

    // Selection
    on<_SelectConversation>(_onSelectConversation);
    on<_GetOrCreateConversation>(_onGetOrCreateConversation);

    // Messages
    on<_LoadMessages>(_onLoadMessages);
    on<_MessagesUpdated>(_onMessagesUpdated);
    on<_SendTextMessage>(_onSendTextMessage);
    on<_SendMediaMessage>(_onSendMediaMessage);

    // Token operations
    on<_SendTokens>(_onSendTokens);
    on<_RequestTokens>(_onRequestTokens);
    on<_AcceptTokenRequest>(_onAcceptTokenRequest);
    on<_DeclineTokenRequest>(_onDeclineTokenRequest);

    // Thread management
    on<_MarkAsRead>(_onMarkAsRead);
    on<_TogglePin>(_onTogglePin);
    on<_ToggleMute>(_onToggleMute);
    on<_ArchiveConversation>(_onArchiveConversation);

    // Message requests
    on<_AcceptConversation>(_onAcceptConversation);

    // Reactions
    on<_AddReaction>(_onAddReaction);
    on<_RemoveReaction>(_onRemoveReaction);

    // Message deletion
    on<_DeleteMessageForEveryone>(_onDeleteMessageForEveryone);
    on<_ClearChat>(_onClearChat);

    // Unread
    on<_UnreadCountUpdated>(_onUnreadCountUpdated);

    // Retry
    on<_RetryMessage>(_onRetryMessage);

    // User search
    on<_SearchUsers>(_onSearchUsers);
    on<_ClearSearch>(_onClearSearch);

    // Typing indicators
    on<_SetTyping>(_onSetTyping);
    on<_TypingStateUpdated>(_onTypingStateUpdated);

    // Message search
    on<_SearchMessages>(_onSearchMessages);
    on<_ClearMessageSearch>(_onClearMessageSearch);

    // Message forwarding
    on<_ForwardMessage>(_onForwardMessage);

    // Utility
    on<_ClearError>(_onClearError);
  }

  // ===========================================================================
  // CONVERSATION LIST HANDLERS
  // ===========================================================================

  Future<void> _onWatchConversations(
    _WatchConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(status: ConversationStatus.loading));

    // 1. Immediate one-shot load from local DB (deterministic)
    final result = await _conversationRepository.getConversations();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ConversationStatus.error,
        errorMessage: failure.displayMessage,
      )),
      (conversations) => emit(state.copyWith(
        status: ConversationStatus.loaded,
        conversations: conversations,
      )),
    );

    // 2. Subscribe to watch stream for real-time updates
    await _conversationsSubscription?.cancel();
    _conversationsSubscription =
        _conversationRepository.watchConversations().listen(
      (result) {
        result.fold(
          (failure) {},
          (conversations) =>
              add(ConversationEvent.conversationsUpdated(conversations)),
        );
      },
      onError: (_) {},
    );

    // 3. Watch total unread count for tab badge
    await _unreadSubscription?.cancel();
    _unreadSubscription =
        _conversationRepository.watchTotalUnreadCount().listen(
      (result) {
        result.fold(
          (failure) {},
          (count) => add(ConversationEvent.unreadCountUpdated(count)),
        );
      },
      onError: (_) {},
    );
  }

  void _onConversationsUpdated(
    _ConversationsUpdated event,
    Emitter<ConversationState> emit,
  ) {
    final userId = _conversationRepository.currentUserId ?? '';

    // Merge accepted status: if a conversation was optimistically accepted
    // locally (accepted[userId]=true) but the incoming stream still has the
    // old value (accepted[userId]=false), preserve the local accepted state.
    // This prevents the brief UI flicker where the banner reappears.
    final mergedConversations = event.conversations.map((incoming) {
      if (userId.isEmpty) return incoming;
      final existing = state.conversations.cast<Conversation?>().firstWhere(
        (c) => c?.id == incoming.id,
        orElse: () => null,
      );
      if (existing != null &&
          existing.isAcceptedFor(userId) &&
          !incoming.isAcceptedFor(userId)) {
        // Preserve the local accepted=true (server hasn't caught up yet)
        return incoming.copyWith(
          accepted: {...incoming.accepted, userId: true},
        );
      }
      return incoming;
    }).toList();

    // Refresh selectedConversation if it exists in the updated list,
    // so detail screen picks up freshly-healed participant data (e.g. avatarUrl).
    Conversation? refreshedSelected;
    if (state.selectedConversation != null) {
      try {
        refreshedSelected = mergedConversations.firstWhere(
          (c) => c.id == state.selectedConversation!.id,
        );
      } catch (_) {
        // Selected conversation no longer in the list; keep as-is
      }
    }

    // Compute message request count from the merged list
    final requestCount = userId.isNotEmpty
        ? mergedConversations
            .where((c) => c.isMessageRequestFor(userId))
            .length
        : 0;

    emit(state.copyWith(
      status: ConversationStatus.loaded,
      conversations: mergedConversations,
      selectedConversation: refreshedSelected ?? state.selectedConversation,
      messageRequestCount: requestCount,
    ));
  }

  void _onUnreadCountUpdated(
    _UnreadCountUpdated event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(totalUnreadCount: event.count));
  }

  // ===========================================================================
  // SELECTION HANDLERS
  // ===========================================================================

  Future<void> _onSelectConversation(
    _SelectConversation event,
    Emitter<ConversationState> emit,
  ) async {
    // 1. Find conversation — local state first, then repo (local DB → Firestore)
    Conversation? conversation;
    try {
      conversation = state.conversations.firstWhere((c) => c.id == event.id);
    } catch (_) {}

    if (conversation == null) {
      final result =
          await _conversationRepository.getConversationById(event.id);
      result.fold(
        (failure) => emit(state.copyWith(
          hasLoadedMessages: true,
          errorMessage: failure.displayMessage,
        )),
        (conv) => conversation = conv,
      );
    }
    if (conversation == null) return;

    // 2. One-shot load of messages from local DB
    final msgResult = await _conversationRepository.getMessages(
      conversationId: event.id,
    );
    final initialMessages = msgResult.fold(
      (failure) => <Message>[],
      (messages) => messages,
    );

    _pendingOptimisticIds.clear();
    emit(state.copyWith(
      selectedConversation: conversation,
      messages: initialMessages,
      hasLoadedMessages: true, // ALWAYS true — spinner stops here, deterministically
    ));

    // 3. Subscribe to watch stream — real-time updates from here on
    await _messagesSubscription?.cancel();
    _messagesSubscription = _conversationRepository
        .watchMessages(conversationId: event.id)
        .listen(
      (result) {
        result.fold(
          (failure) {},
          (messages) => add(ConversationEvent.messagesUpdated(messages)),
        );
      },
      onError: (_) {},
    );

    // 4. Subscribe to typing indicators
    await _typingSubscription?.cancel();
    _typingSubscription = _conversationRepository
        .watchTypingState(conversationId: event.id)
        .listen(
      (typingUsers) => add(ConversationEvent.typingStateUpdated(typingUsers)),
      onError: (_) {},
    );
  }

  Future<void> _onGetOrCreateConversation(
    _GetOrCreateConversation event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(status: ConversationStatus.loading));

    final result = await _conversationRepository.getOrCreateConversation(
      participantId: event.participantId,
    );

    Conversation? conversation;
    result.fold(
      (failure) => emit(state.copyWith(
        status: ConversationStatus.error,
        errorMessage: failure.displayMessage,
      )),
      (conv) => conversation = conv,
    );

    if (conversation == null) return;

    // Load initial messages (may be empty for brand-new conversations)
    final msgResult = await _conversationRepository.getMessages(
      conversationId: conversation!.id,
    );
    final initialMessages = msgResult.fold(
      (failure) => <Message>[],
      (messages) => messages,
    );

    _pendingOptimisticIds.clear();
    emit(state.copyWith(
      status: ConversationStatus.loaded,
      selectedConversation: conversation,
      messages: initialMessages,
      hasLoadedMessages: true,
    ));

    // Subscribe to watch stream for real-time updates
    await _messagesSubscription?.cancel();
    _messagesSubscription = _conversationRepository
        .watchMessages(conversationId: conversation!.id)
        .listen(
      (result) {
        result.fold(
          (failure) {},
          (messages) => add(ConversationEvent.messagesUpdated(messages)),
        );
      },
      onError: (_) {},
    );
  }

  // ===========================================================================
  // MESSAGE HANDLERS
  // ===========================================================================

  Future<void> _onLoadMessages(
    _LoadMessages event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isLoadingMessages: true));

    final result = await _conversationRepository.getMessages(
      conversationId: event.conversationId,
      limit: event.limit,
      before: event.before,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingMessages: false,
        hasLoadedMessages: true,
        errorMessage: failure.displayMessage,
      )),
      (messages) {
        final allMessages = event.before != null
            ? [...state.messages, ...messages]
            : messages;
        emit(state.copyWith(
          isLoadingMessages: false,
          hasLoadedMessages: true,
          messages: allMessages,
          hasMoreMessages: messages.length >= (event.limit ?? 50),
        ));
      },
    );
  }

  void _onMessagesUpdated(
    _MessagesUpdated event,
    Emitter<ConversationState> emit,
  ) {
    if (_pendingOptimisticIds.isNotEmpty) {
      final optimistics = state.messages
          .where((m) => _pendingOptimisticIds.contains(m.id))
          .toList();
      if (optimistics.isNotEmpty) {
        // Check if any optimistic has been superseded by a real server message
        // (Firestore listener may deliver the real message before the repository
        // HTTP response returns). Match by sender + text content.
        final resolvedIds = <String>{};
        final usedRealIds = <String>{};
        for (final opt in optimistics) {
          final realMatch = event.messages.cast<Message?>().firstWhere(
            (m) =>
                m != null &&
                !usedRealIds.contains(m.id) &&
                m.senderId == opt.senderId &&
                m.textContent == opt.textContent &&
                m.textContent != null &&
                m.textContent!.isNotEmpty &&
                !m.id.startsWith('optimistic_'),
            orElse: () => null,
          );
          if (realMatch != null) {
            resolvedIds.add(opt.id);
            usedRealIds.add(realMatch.id);
          }
        }
        _pendingOptimisticIds.removeAll(resolvedIds);

        // Keep only unresolved optimistics
        final unresolved = optimistics
            .where((m) => !resolvedIds.contains(m.id))
            .toList();
        if (unresolved.isNotEmpty) {
          final filtered = event.messages
              .where((m) => !_pendingOptimisticIds.contains(m.id))
              .toList();
          emit(state.copyWith(
            messages: [...unresolved, ...filtered],
            hasLoadedMessages: true,
          ));
          return;
        }
      }
    }
    emit(state.copyWith(messages: event.messages, hasLoadedMessages: true));
  }

  Future<void> _onSendTextMessage(
    _SendTextMessage event,
    Emitter<ConversationState> emit,
  ) async {
    // --- Optimistic UI: show the message IMMEDIATELY ---
    final currentUserId = _conversationRepository.currentUserId ?? '';
    final optimisticId = 'optimistic_${DateTime.now().millisecondsSinceEpoch}';
    final optimisticMessage = Message(
      id: optimisticId,
      senderId: currentUserId,
      senderName: '',
      type: MessageType.text,
      status: MessageStatus.sending,
      textContent: event.text,
      createdAt: DateTime.now(),
    );

    _pendingOptimisticIds.add(optimisticId);

    // Insert at the start (newest-first order) and clear sending flag
    // so the input bar is immediately available for the next message.
    emit(state.copyWith(
      messages: [optimisticMessage, ...state.messages],
    ));

    // --- Send in background ---
    // Derive recipientId from state to skip the redundant Firestore read
    String? recipientId;
    final conv = state.selectedConversation;
    if (conv != null && currentUserId.isNotEmpty) {
      final match = conv.participantIds.cast<String?>().firstWhere(
        (id) => id != currentUserId,
        orElse: () => null,
      );
      if (match != null && match.isNotEmpty) {
        recipientId = match;
      }
    }

    final result = await _conversationRepository.sendTextMessage(
      conversationId: event.conversationId,
      text: event.text,
      replyToMessageId: event.replyToMessageId,
      recipientId: recipientId,
    );

    _pendingOptimisticIds.remove(optimisticId);

    result.fold(
      (failure) {
        // Mark the optimistic message as failed
        final updated = state.messages.map((m) {
          if (m.id == optimisticId) {
            return m.copyWith(status: MessageStatus.failed);
          }
          return m;
        }).toList();
        emit(state.copyWith(
          messages: updated,
          errorMessage: failure.displayMessage,
        ));
      },
      (serverMessage) {
        // Replace optimistic with the real message and deduplicate by ID.
        // The stream may have already delivered the real message before
        // this callback runs, so we need to prevent [msg, msg] duplicates.
        final seen = <String>{};
        final updated = <Message>[];
        for (final m in state.messages) {
          final msg = m.id == optimisticId ? serverMessage : m;
          if (seen.add(msg.id)) updated.add(msg);
        }
        emit(state.copyWith(messages: updated));
      },
    );
  }

  Future<void> _onSendMediaMessage(
    _SendMediaMessage event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _conversationRepository.sendMediaMessage(
      conversationId: event.conversationId,
      mediaFile: event.mediaFile,
      mediaType: event.mediaType,
      recipientId: event.recipientId,
      caption: event.caption,
      durationSeconds: event.durationSeconds,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  // ===========================================================================
  // TOKEN OPERATION HANDLERS
  // ===========================================================================

  Future<void> _onSendTokens(
    _SendTokens event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _conversationRepository.sendTokens(
      conversationId: event.conversationId,
      recipientId: event.recipientId,
      amount: event.amount,
      message: event.message,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onRequestTokens(
    _RequestTokens event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _conversationRepository.requestTokens(
      conversationId: event.conversationId,
      recipientId: event.recipientId,
      amount: event.amount,
      message: event.message,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onAcceptTokenRequest(
    _AcceptTokenRequest event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.acceptTokenRequest(
      messageId: event.messageId,
      conversationId: event.conversationId,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onDeclineTokenRequest(
    _DeclineTokenRequest event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.declineTokenRequest(
      messageId: event.messageId,
      conversationId: event.conversationId,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  // ===========================================================================
  // THREAD MANAGEMENT HANDLERS
  // ===========================================================================

  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<ConversationState> emit,
  ) async {
    await _conversationRepository.markAsRead(
      conversationId: event.conversationId,
    );
  }

  Future<void> _onTogglePin(
    _TogglePin event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.togglePin(
      conversationId: event.conversationId,
      pinned: event.pinned,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onToggleMute(
    _ToggleMute event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.toggleMute(
      conversationId: event.conversationId,
      muted: event.muted,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onArchiveConversation(
    _ArchiveConversation event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository
        .archiveConversation(event.conversationId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  // ===========================================================================
  // MESSAGE REQUEST HANDLERS
  // ===========================================================================

  Future<void> _onAcceptConversation(
    _AcceptConversation event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.acceptConversation(
      conversationId: event.conversationId,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {
        final userId = _conversationRepository.currentUserId ?? '';
        if (userId.isEmpty) return;

        // Optimistically update the conversation in the main list too,
        // so the stream can't reverse the accepted flag with stale data.
        final updatedConversations = state.conversations.map((c) {
          if (c.id == event.conversationId) {
            return c.copyWith(
              accepted: {...c.accepted, userId: true},
            );
          }
          return c;
        }).toList();

        // Update selectedConversation if it matches (remove banner immediately)
        final updatedSelected =
            state.selectedConversation?.id == event.conversationId
                ? state.selectedConversation!.copyWith(
                    accepted: {
                      ...state.selectedConversation!.accepted,
                      userId: true,
                    },
                  )
                : state.selectedConversation;

        emit(state.copyWith(
          conversations: updatedConversations,
          selectedConversation: updatedSelected,
          messageRequestCount:
              (state.messageRequestCount - 1).clamp(0, 999999),
        ));
      },
    );
  }

  // ===========================================================================
  // MESSAGE DELETION HANDLERS
  // ===========================================================================

  Future<void> _onDeleteMessageForEveryone(
    _DeleteMessageForEveryone event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.deleteMessageForEveryone(
      conversationId: event.conversationId,
      messageId: event.messageId,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {}, // watchMessages stream auto-updates the message list
    );
  }

  Future<void> _onClearChat(
    _ClearChat event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isClearingChat: true));

    final result = await _conversationRepository.clearChat(
      conversationId: event.conversationId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isClearingChat: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isClearingChat: false,
        messages: [], // Clear local messages immediately
      )),
    );
  }

  // ===========================================================================
  // REACTION HANDLERS
  // ===========================================================================

  Future<void> _onAddReaction(
    _AddReaction event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.addReaction(
      conversationId: event.conversationId,
      messageId: event.messageId,
      emoji: event.emoji,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onRemoveReaction(
    _RemoveReaction event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.removeReaction(
      conversationId: event.conversationId,
      messageId: event.messageId,
      emoji: event.emoji,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  // ===========================================================================
  // RETRY
  // ===========================================================================

  Future<void> _onRetryMessage(
    _RetryMessage event,
    Emitter<ConversationState> emit,
  ) async {
    // Find the failed message in current messages list
    Message? failedMessage;
    try {
      failedMessage = state.messages.firstWhere(
        (m) => m.id == event.messageId,
      );
    } catch (_) {
      // Message not found — nothing to retry
      return;
    }

    // Re-send based on message type
    if (failedMessage.hasMedia) {
      // Media messages are E2EE — can't retry without the original file.
      // The user must re-select the file from their device.
      emit(state.copyWith(
        errorMessage: 'Cannot retry media messages. Please re-attach the file.',
      ));
      return;
    }
    add(ConversationEvent.sendTextMessage(
      conversationId: event.conversationId,
      text: failedMessage.textContent ?? '',
    ));
  }

  // ===========================================================================
  // USER SEARCH
  // ===========================================================================

  Future<void> _onSearchUsers(
    _SearchUsers event,
    Emitter<ConversationState> emit,
  ) async {
    if (event.query.length < 2) {
      emit(state.copyWith(searchResults: [], isSearching: false));
      return;
    }

    emit(state.copyWith(isSearching: true));

    final result = await _conversationRepository.searchUsers(event.query);
    result.fold(
      (failure) => emit(state.copyWith(
        isSearching: false,
        searchResults: [],
      )),
      (users) => emit(state.copyWith(
        isSearching: false,
        searchResults: users,
      )),
    );
  }

  void _onClearSearch(
    _ClearSearch event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(searchResults: [], isSearching: false));
  }

  // ===========================================================================
  // UTILITY
  // ===========================================================================

  void _onClearError(
    _ClearError event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  // ===========================================================================
  // TYPING INDICATOR HANDLERS
  // ===========================================================================

  Future<void> _onSetTyping(
    _SetTyping event,
    Emitter<ConversationState> emit,
  ) async {
    // Debounce: only send isTyping=true once every 3 seconds
    _typingDebounce?.cancel();
    if (event.isTyping) {
      await _conversationRepository.setTyping(
        conversationId: event.conversationId,
        isTyping: true,
      );
      // Auto-clear after 4 seconds of no further typing events
      _typingDebounce = Timer(const Duration(seconds: 4), () {
        _conversationRepository.setTyping(
          conversationId: event.conversationId,
          isTyping: false,
        );
      });
    } else {
      await _conversationRepository.setTyping(
        conversationId: event.conversationId,
        isTyping: false,
      );
    }
  }

  void _onTypingStateUpdated(
    _TypingStateUpdated event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(typingUsers: event.typingUsers));
  }

  // ===========================================================================
  // MESSAGE SEARCH HANDLERS
  // ===========================================================================

  Future<void> _onSearchMessages(
    _SearchMessages event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(
      isSearchingMessages: true,
      messageSearchQuery: event.query,
    ));

    final result = await _conversationRepository.searchMessages(
      conversationId: event.conversationId,
      query: event.query,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSearchingMessages: false,
        messageSearchResults: [],
      )),
      (messages) => emit(state.copyWith(
        isSearchingMessages: false,
        messageSearchResults: messages,
      )),
    );
  }

  void _onClearMessageSearch(
    _ClearMessageSearch event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(
      messageSearchResults: [],
      isSearchingMessages: false,
      messageSearchQuery: null,
    ));
  }

  // ===========================================================================
  // MESSAGE FORWARDING HANDLERS
  // ===========================================================================

  Future<void> _onForwardMessage(
    _ForwardMessage event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isForwarding: true));

    final result = await _conversationRepository.forwardMessage(
      sourceConversationId: event.sourceConversationId,
      sourceMessageId: event.sourceMessageId,
      targetConversationId: event.targetConversationId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isForwarding: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(isForwarding: false)),
    );
  }

  @override
  Future<void> close() {
    _conversationsSubscription?.cancel();
    _messagesSubscription?.cancel();
    _unreadSubscription?.cancel();
    _typingSubscription?.cancel();
    _typingDebounce?.cancel();
    return super.close();
  }
}
