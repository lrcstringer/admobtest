import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/chat_thread.dart';
import '../../../domain/entities/chat_card.dart';
import '../../../domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _threadsSubscription;
  StreamSubscription? _messagesSubscription;
  StreamSubscription? _unreadSubscription;

  ChatBloc(this._chatRepository) : super(const ChatState()) {
    on<_LoadThreads>(_onLoadThreads);
    on<_WatchThreads>(_onWatchThreads);
    on<_ThreadsUpdated>(_onThreadsUpdated);
    on<_SelectThread>(_onSelectThread);
    on<_LoadMessages>(_onLoadMessages);
    on<_WatchMessages>(_onWatchMessages);
    on<_MessagesUpdated>(_onMessagesUpdated);
    on<_SendTextMessage>(_onSendTextMessage);
    on<_SendTokens>(_onSendTokens);
    on<_RequestTokens>(_onRequestTokens);
    on<_AcceptTokenRequest>(_onAcceptTokenRequest);
    on<_DeclineTokenRequest>(_onDeclineTokenRequest);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_TogglePinThread>(_onTogglePinThread);
    on<_ToggleMuteThread>(_onToggleMuteThread);
    on<_ArchiveThread>(_onArchiveThread);
    on<_GetOrCreateThread>(_onGetOrCreateThread);
    on<_ClearError>(_onClearError);
    on<_UnreadCountUpdated>(_onUnreadCountUpdated);
  }

  Future<void> _onLoadThreads(
    _LoadThreads event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(status: ChatStatus.loading));

    final result = await _chatRepository.getChatThreads();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ChatStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (threads) => emit(state.copyWith(
        status: ChatStatus.success,
        threads: threads,
      )),
    );
  }

  Future<void> _onWatchThreads(
    _WatchThreads event,
    Emitter<ChatState> emit,
  ) async {
    await _threadsSubscription?.cancel();
    _threadsSubscription = _chatRepository.watchChatThreads().listen(
      (result) {
        result.fold(
          (failure) => add(ChatEvent.clearError()),
          (threads) => add(ChatEvent.threadsUpdated(threads)),
        );
      },
    );

    // Also watch unread count
    await _unreadSubscription?.cancel();
    _unreadSubscription = _chatRepository.watchTotalUnreadCount().listen(
      (result) {
        result.fold(
          (failure) {},
          (count) => add(ChatEvent.unreadCountUpdated(count)),
        );
      },
    );
  }

  void _onThreadsUpdated(
    _ThreadsUpdated event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(
      status: ChatStatus.success,
      threads: event.threads,
    ));
  }

  void _onUnreadCountUpdated(
    _UnreadCountUpdated event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(totalUnreadCount: event.count));
  }

  Future<void> _onSelectThread(
    _SelectThread event,
    Emitter<ChatState> emit,
  ) async {
    final thread = state.threads.firstWhere(
      (t) => t.id == event.threadId,
      orElse: () => state.threads.first,
    );
    emit(state.copyWith(selectedThread: thread, messages: []));

    // Load messages for the thread
    add(ChatEvent.watchMessages(threadId: event.threadId));
  }

  Future<void> _onLoadMessages(
    _LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isLoadingMessages: true));

    final result = await _chatRepository.getMessages(
      threadId: event.threadId,
      limit: event.limit,
      startAfter: event.startAfter,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingMessages: false,
        errorMessage: failure.displayMessage,
      )),
      (messages) {
        final allMessages = event.startAfter != null
            ? [...state.messages, ...messages]
            : messages;
        emit(state.copyWith(
          isLoadingMessages: false,
          messages: allMessages,
          hasMoreMessages: messages.length >= (event.limit ?? 50),
        ));
      },
    );
  }

  Future<void> _onWatchMessages(
    _WatchMessages event,
    Emitter<ChatState> emit,
  ) async {
    await _messagesSubscription?.cancel();
    _messagesSubscription = _chatRepository
        .watchMessages(threadId: event.threadId, limit: event.limit)
        .listen(
      (result) {
        result.fold(
          (failure) {},
          (messages) => add(ChatEvent.messagesUpdated(messages)),
        );
      },
    );
  }

  void _onMessagesUpdated(
    _MessagesUpdated event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(messages: event.messages));
  }

  Future<void> _onSendTextMessage(
    _SendTextMessage event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _chatRepository.sendTextMessage(
      threadId: event.threadId,
      text: event.text,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onSendTokens(
    _SendTokens event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _chatRepository.sendTokens(
      threadId: event.threadId,
      recipientId: event.recipientId,
      amount: event.amount,
      message: event.message,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (card) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onRequestTokens(
    _RequestTokens event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _chatRepository.requestTokens(
      threadId: event.threadId,
      recipientId: event.recipientId,
      amount: event.amount,
      message: event.message,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (card) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onAcceptTokenRequest(
    _AcceptTokenRequest event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _chatRepository.acceptTokenRequest(cardId: event.cardId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onDeclineTokenRequest(
    _DeclineTokenRequest event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _chatRepository.declineTokenRequest(cardId: event.cardId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<ChatState> emit,
  ) async {
    await _chatRepository.markAsRead(
      threadId: event.threadId,
      messageIds: event.messageIds,
    );
  }

  Future<void> _onTogglePinThread(
    _TogglePinThread event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _chatRepository.togglePinThread(
      threadId: event.threadId,
      isPinned: event.isPinned,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onToggleMuteThread(
    _ToggleMuteThread event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _chatRepository.toggleMuteThread(
      threadId: event.threadId,
      isMuted: event.isMuted,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onArchiveThread(
    _ArchiveThread event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _chatRepository.archiveThread(event.threadId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onGetOrCreateThread(
    _GetOrCreateThread event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(status: ChatStatus.loading));

    final result = await _chatRepository.getOrCreateThread(
      participantId: event.participantId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: ChatStatus.failure,
        errorMessage: failure.displayMessage,
      )),
      (thread) {
        emit(state.copyWith(
          status: ChatStatus.success,
          selectedThread: thread,
        ));
        // Start watching messages for the new thread
        add(ChatEvent.watchMessages(threadId: thread.id));
      },
    );
  }

  void _onClearError(
    _ClearError event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _threadsSubscription?.cancel();
    _messagesSubscription?.cancel();
    _unreadSubscription?.cancel();
    return super.close();
  }
}
