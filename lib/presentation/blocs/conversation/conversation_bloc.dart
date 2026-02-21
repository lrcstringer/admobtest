import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';
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

  ConversationBloc(this._conversationRepository)
      : super(const ConversationState()) {
    // Conversation list
    on<_LoadConversations>(_onLoadConversations);
    on<_WatchConversations>(_onWatchConversations);
    on<_ConversationsUpdated>(_onConversationsUpdated);

    // Selection
    on<_SelectConversation>(_onSelectConversation);
    on<_GetOrCreateConversation>(_onGetOrCreateConversation);

    // Messages
    on<_LoadMessages>(_onLoadMessages);
    on<_WatchMessages>(_onWatchMessages);
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

    // Utility
    on<_ClearError>(_onClearError);
  }

  // ===========================================================================
  // CONVERSATION LIST HANDLERS
  // ===========================================================================

  Future<void> _onLoadConversations(
    _LoadConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(status: ConversationStatus.loading));

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
  }

  Future<void> _onWatchConversations(
    _WatchConversations event,
    Emitter<ConversationState> emit,
  ) async {
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
    );

    // Also watch total unread count for tab badge
    await _unreadSubscription?.cancel();
    _unreadSubscription =
        _conversationRepository.watchTotalUnreadCount().listen(
      (result) {
        result.fold(
          (failure) {},
          (count) => add(ConversationEvent.unreadCountUpdated(count)),
        );
      },
    );
  }

  void _onConversationsUpdated(
    _ConversationsUpdated event,
    Emitter<ConversationState> emit,
  ) {
    // Also refresh selectedConversation if it exists in the updated list,
    // so detail screen picks up freshly-healed participant data (e.g. avatarUrl).
    Conversation? refreshedSelected;
    if (state.selectedConversation != null) {
      try {
        refreshedSelected = event.conversations.firstWhere(
          (c) => c.id == state.selectedConversation!.id,
        );
      } catch (_) {
        // Selected conversation no longer in the list; keep as-is
      }
    }

    emit(state.copyWith(
      status: ConversationStatus.loaded,
      conversations: event.conversations,
      selectedConversation: refreshedSelected ?? state.selectedConversation,
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
    Conversation? conversation;
    try {
      conversation = state.conversations.firstWhere(
        (c) => c.id == event.id,
      );
    } catch (_) {
      // Conversation not in list yet — ignore silently
    }

    if (conversation == null) return;

    emit(state.copyWith(
      selectedConversation: conversation,
      messages: [],
      hasLoadedMessages: false,
    ));

    // Start watching messages for this conversation
    add(ConversationEvent.watchMessages(conversationId: event.id));
  }

  Future<void> _onGetOrCreateConversation(
    _GetOrCreateConversation event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(status: ConversationStatus.loading));

    final result = await _conversationRepository.getOrCreateConversation(
      participantId: event.participantId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: ConversationStatus.error,
        errorMessage: failure.displayMessage,
      )),
      (conversation) {
        emit(state.copyWith(
          status: ConversationStatus.loaded,
          selectedConversation: conversation,
        ));
        // Start watching messages for the new/existing conversation
        add(ConversationEvent.watchMessages(conversationId: conversation.id));
      },
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

  Future<void> _onWatchMessages(
    _WatchMessages event,
    Emitter<ConversationState> emit,
  ) async {
    await _messagesSubscription?.cancel();
    _messagesSubscription = _conversationRepository
        .watchMessages(conversationId: event.conversationId, limit: event.limit)
        .listen(
      (result) {
        result.fold(
          (failure) {},
          (messages) => add(ConversationEvent.messagesUpdated(messages)),
        );
      },
    );
  }

  void _onMessagesUpdated(
    _MessagesUpdated event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(messages: event.messages, hasLoadedMessages: true));
  }

  Future<void> _onSendTextMessage(
    _SendTextMessage event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _conversationRepository.sendTextMessage(
      conversationId: event.conversationId,
      text: event.text,
      replyToMessageId: event.replyToMessageId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onSendMediaMessage(
    _SendMediaMessage event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _conversationRepository.sendMediaMessage(
      conversationId: event.conversationId,
      mediaUrl: event.mediaUrl,
      mediaType: event.mediaType,
      caption: event.caption,
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
    if (failedMessage.hasMedia && failedMessage.media != null) {
      add(ConversationEvent.sendMediaMessage(
        conversationId: event.conversationId,
        mediaUrl: failedMessage.media!.url,
        mediaType: failedMessage.media!.mimeType,
        caption: failedMessage.textContent,
      ));
    } else {
      add(ConversationEvent.sendTextMessage(
        conversationId: event.conversationId,
        text: failedMessage.textContent ?? '',
      ));
    }
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

  @override
  Future<void> close() {
    _conversationsSubscription?.cancel();
    _messagesSubscription?.cancel();
    _unreadSubscription?.cancel();
    return super.close();
  }
}
