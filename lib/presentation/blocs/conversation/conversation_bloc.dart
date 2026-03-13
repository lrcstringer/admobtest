import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/enums/conversation_type.dart';
import '../../../domain/enums/message_status.dart';
import '../../../domain/enums/message_type.dart';
import '../../../domain/repositories/conversation_repository.dart';

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
    on<_SendTokensToUser>(_onSendTokensToUser);
    on<_AcceptTokenRequest>(_onAcceptTokenRequest);
    on<_DeclineTokenRequest>(_onDeclineTokenRequest);

    // Thread management (markAsRead, togglePin, toggleMute, archiveConversation
    // moved to ConversationActionsBloc)

    // Message requests
    on<_AcceptConversation>(_onAcceptConversation);

    // Reactions (addReaction, removeReaction moved to ConversationActionsBloc)
    // Message deletion (deleteMessageForEveryone moved to ConversationActionsBloc)
    on<_ClearChat>(_onClearChat);

    // Unread
    on<_UnreadCountUpdated>(_onUnreadCountUpdated);

    // Retry
    on<_RetryMessage>(_onRetryMessage);

    // User search (searchUsers, clearSearch moved to UserSearchBloc)

    // Typing indicators
    on<_SetTyping>(_onSetTyping);
    on<_TypingStateUpdated>(_onTypingStateUpdated);

    // Message search
    on<_SearchMessages>(_onSearchMessages);
    on<_ClearMessageSearch>(_onClearMessageSearch);

    // Disappearing messages
    on<_SetDisappearingMessages>(_onSetDisappearingMessages);

    // Message forwarding
    on<_ForwardMessage>(_onForwardMessage);

    // Stream health
    on<_StreamError>(_onStreamError);

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
    // Only show loading spinner if we don't already have conversations.
    // On re-dispatches (app resume, pull-to-refresh), keep showing the
    // existing list while the fresh read completes in the background.
    if (state.conversations.isEmpty) {
      emit(state.copyWith(status: ConversationStatus.loading));
    }

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
          (failure) => add(const ConversationEvent.streamError()),
          (conversations) {
            if (state.hasStreamError) add(const ConversationEvent.clearError());
            add(ConversationEvent.conversationsUpdated(conversations));
          },
        );
      },
      onError: (_) => add(const ConversationEvent.streamError()),
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

    emit(state.copyWith(
      selectedConversation: conversation,
      messages: initialMessages,
      hasLoadedMessages: true, // ALWAYS true — spinner stops here, deterministically
      // If local DB was empty, the background sync may still be fetching and
      // decrypting messages from Firestore. Show a syncing indicator instead
      // of the premature "No messages yet" empty state.
      isSyncingMessages: initialMessages.isEmpty,
    ));

    // 3. Subscribe to watch stream — real-time updates from here on
    await _messagesSubscription?.cancel();
    _messagesSubscription = _conversationRepository
        .watchMessages(conversationId: event.id)
        .listen(
      (result) {
        result.fold(
          (failure) => add(const ConversationEvent.streamError()),
          (messages) => add(ConversationEvent.messagesUpdated(messages)),
        );
      },
      onError: (_) => add(const ConversationEvent.streamError()),
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
    // Single source of truth: local DB stream delivers all messages
    // (including optimistic pending messages inserted by OutgoingMessageQueue).
    emit(state.copyWith(
      messages: event.messages,
      hasLoadedMessages: true,
      // Clear syncing indicator once messages arrive from the sync service
      isSyncingMessages: false,
    ));
  }

  Future<void> _onSendTextMessage(
    _SendTextMessage event,
    Emitter<ConversationState> emit,
  ) async {
    // Guard: empty messages should never be sent
    if (event.text.trim().isEmpty) return;

    // Guard: E2EE is only defined for P2P conversations
    final selectedConv = state.selectedConversation;
    if (selectedConv != null && selectedConv.type != ConversationType.p2p) return;

    // Derive recipientId from state to skip the redundant Firestore read
    final currentUserId = _conversationRepository.currentUserId ?? '';
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

    // The queue inserts an optimistic message into local DB → the watch
    // stream delivers it to _onMessagesUpdated automatically.
    final result = await _conversationRepository.sendTextMessage(
      conversationId: event.conversationId,
      text: event.text,
      replyToMessageId: event.replyToMessageId,
      recipientId: recipientId,
    );

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onSendMediaMessage(
    _SendMediaMessage event,
    Emitter<ConversationState> emit,
  ) async {
    // Guard: E2EE is only defined for P2P conversations
    final conv = state.selectedConversation;
    if (conv == null || conv.type != ConversationType.p2p) return;

    // Derive recipientId from state
    final currentUserId = _conversationRepository.currentUserId ?? '';
    final recipientId = conv.participantIds.cast<String?>().firstWhere(
      (id) => id != currentUserId,
      orElse: () => null,
    );
    if (recipientId == null || recipientId.isEmpty) return;

    emit(state.copyWith(isSending: true));

    // The queue inserts an optimistic message into local DB → the watch
    // stream delivers it to _onMessagesUpdated automatically.
    final result = await _conversationRepository.sendMediaMessage(
      conversationId: event.conversationId,
      mediaFile: event.mediaFile,
      mediaType: event.mediaType,
      recipientId: recipientId,
      caption: event.caption,
      durationSeconds: event.durationSeconds,
      replyToMessageId: event.replyToMessageId,
      thumbnailFile: event.thumbnailFile,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(isSending: false)),
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
      subAccountId: event.subAccountId,
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
      subAccountId: event.subAccountId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onSendTokensToUser(
    _SendTokensToUser event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    // 1. Get or create conversation with the recipient
    final convResult = await _conversationRepository.getOrCreateConversation(
      participantId: event.recipientId,
    );

    final conversation = convResult.fold(
      (failure) {
        emit(state.copyWith(
          isSending: false,
          errorMessage: failure.displayMessage,
        ));
        return null;
      },
      (conv) => conv,
    );
    if (conversation == null) return;

    // 2. Send or request tokens in that conversation
    if (event.isSend) {
      final result = await _conversationRepository.sendTokens(
        conversationId: conversation.id,
        recipientId: event.recipientId,
        amount: event.amount,
        message: event.message,
        subAccountId: event.subAccountId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
          isSending: false,
          errorMessage: failure.displayMessage,
        )),
        (message) => emit(state.copyWith(isSending: false)),
      );
    } else {
      final result = await _conversationRepository.requestTokens(
        conversationId: conversation.id,
        recipientId: event.recipientId,
        amount: event.amount,
        message: event.message,
        subAccountId: event.subAccountId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
          isSending: false,
          errorMessage: failure.displayMessage,
        )),
        (message) => emit(state.copyWith(isSending: false)),
      );
    }
  }

  Future<void> _onAcceptTokenRequest(
    _AcceptTokenRequest event,
    Emitter<ConversationState> emit,
  ) async {
    // Optimistically update message status so buttons disappear immediately
    final updatedMessages = state.messages.map((m) {
      if (m.id == event.messageId) {
        return m.copyWith(status: MessageStatus.paid);
      }
      return m;
    }).toList();
    emit(state.copyWith(messages: updatedMessages));

    final result = await _conversationRepository.acceptTokenRequest(
      messageId: event.messageId,
      conversationId: event.conversationId,
    );
    result.fold(
      (failure) {
        // Revert optimistic update on failure
        final revertedMessages = state.messages.map((m) {
          if (m.id == event.messageId) {
            return m.copyWith(status: MessageStatus.pending);
          }
          return m;
        }).toList();
        emit(state.copyWith(
          messages: revertedMessages,
          errorMessage: failure.displayMessage,
        ));
      },
      (_) {},
    );
  }

  Future<void> _onDeclineTokenRequest(
    _DeclineTokenRequest event,
    Emitter<ConversationState> emit,
  ) async {
    // Optimistically update message status so buttons disappear immediately
    final updatedMessages = state.messages.map((m) {
      if (m.id == event.messageId) {
        return m.copyWith(status: MessageStatus.declined);
      }
      return m;
    }).toList();
    emit(state.copyWith(messages: updatedMessages));

    final result = await _conversationRepository.declineTokenRequest(
      messageId: event.messageId,
      conversationId: event.conversationId,
    );
    result.fold(
      (failure) {
        // Revert optimistic update on failure
        final revertedMessages = state.messages.map((m) {
          if (m.id == event.messageId) {
            return m.copyWith(status: MessageStatus.pending);
          }
          return m;
        }).toList();
        emit(state.copyWith(
          messages: revertedMessages,
          errorMessage: failure.displayMessage,
        ));
      },
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
  // RETRY
  // ===========================================================================

  Future<void> _onRetryMessage(
    _RetryMessage event,
    Emitter<ConversationState> emit,
  ) async {
    // Delegate to the OutgoingMessageQueue via the repository.
    // The queue re-processes the pending message (preserves plaintext).
    final result = await _conversationRepository.retryMessage(event.messageId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  // ===========================================================================
  // UTILITY
  // ===========================================================================

  void _onStreamError(
    _StreamError event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(hasStreamError: true));
  }

  void _onClearError(
    _ClearError event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(errorMessage: null, hasStreamError: false));
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
  // DISAPPEARING MESSAGES
  // ===========================================================================

  Future<void> _onSetDisappearingMessages(
    _SetDisappearingMessages event,
    Emitter<ConversationState> emit,
  ) async {
    final result = await _conversationRepository.setDisappearingMessages(
      conversationId: event.conversationId,
      duration: event.duration,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {
        // Optimistically update selectedConversation
        if (state.selectedConversation?.id == event.conversationId) {
          emit(state.copyWith(
            selectedConversation: state.selectedConversation!.copyWith(
              disappearingMessagesDuration: event.duration,
            ),
          ));
        }
      },
    );
  }

  // ===========================================================================
  // MESSAGE FORWARDING
  // ===========================================================================

  Future<void> _onForwardMessage(
    _ForwardMessage event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isForwarding: true));

    // Extract decrypted plaintext so the repository can re-encrypt it
    // for the target conversation's recipient (E2EE forward fix).
    String? plaintextContent;
    try {
      final msg =
          state.messages.firstWhere((m) => m.id == event.sourceMessageId);
      if (msg.type == MessageType.text) {
        plaintextContent = msg.textContent;
      } else if (msg.media != null) {
        final m = msg.media!;
        final mediaMap = <String, dynamic>{
          'url': m.url,
          'mediaKey': m.mediaKey,
          'thumbKey': m.thumbKey,
          'fileName': m.fileName,
          'fileSize': m.fileSize,
          'mimeType': m.mimeType,
          if (m.duration != null) 'duration': m.duration,
          if (m.width != null) 'width': m.width,
          if (m.height != null) 'height': m.height,
          if (m.thumbnailUrl != null) 'thumbnailUrl': m.thumbnailUrl,
        };
        plaintextContent = jsonEncode({
          if (msg.textContent != null) 'text': msg.textContent,
          'media': mediaMap,
        });
      }
    } catch (_) {
      // Message not in current state — CF will use the server copy
    }

    final result = await _conversationRepository.forwardMessage(
      sourceConversationId: event.sourceConversationId,
      sourceMessageId: event.sourceMessageId,
      targetConversationId: event.targetConversationId,
      plaintextContent: plaintextContent,
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
