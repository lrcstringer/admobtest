import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/community_repository.dart';

part 'community_messaging_bloc.freezed.dart';
part 'community_messaging_event.dart';
part 'community_messaging_state.dart';

/// Lightweight BLoC scoped per community detail screen.
///
/// Handles only community messaging — the parent [CommunityBloc]
/// handles membership, financials, and CRUD.
/// Created with a [communityId] and injected [CommunityRepository].
@injectable
class CommunityMessagingBloc
    extends Bloc<CommunityMessagingEvent, CommunityMessagingState> {
  final CommunityRepository _communityRepository;
  StreamSubscription? _messagesSubscription;

  CommunityMessagingBloc(
    this._communityRepository, {
    @factoryParam required String communityId,
  }) : super(CommunityMessagingState(communityId: communityId)) {
    on<_LoadMessages>(_onLoadMessages);
    on<_WatchMessages>(_onWatchMessages);
    on<_MessagesUpdated>(_onMessagesUpdated);
    on<_SendTextMessage>(_onSendTextMessage);
    on<_SendMediaMessage>(_onSendMediaMessage);
    on<_AddReaction>(_onAddReaction);
    on<_RemoveReaction>(_onRemoveReaction);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_LoadMore>(_onLoadMore);
    on<_ClearError>(_onClearError);
  }

  Future<void> _onLoadMessages(
    _LoadMessages event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _communityRepository.getMessages(
      communityId: state.communityId,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (messages) => emit(state.copyWith(
        isLoading: false,
        messages: messages,
        hasMore: messages.length >= (event.limit ?? 50),
      )),
    );
  }

  Future<void> _onWatchMessages(
    _WatchMessages event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    await _messagesSubscription?.cancel();
    _messagesSubscription = _communityRepository
        .watchMessages(communityId: state.communityId, limit: event.limit)
        .listen(
      (result) {
        result.fold(
          (failure) {},
          (messages) =>
              add(CommunityMessagingEvent.messagesUpdated(messages)),
        );
      },
    );
  }

  void _onMessagesUpdated(
    _MessagesUpdated event,
    Emitter<CommunityMessagingState> emit,
  ) {
    emit(state.copyWith(messages: event.messages));
  }

  Future<void> _onSendTextMessage(
    _SendTextMessage event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _communityRepository.sendTextMessage(
      communityId: state.communityId,
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
    Emitter<CommunityMessagingState> emit,
  ) async {
    emit(state.copyWith(isSending: true));

    final result = await _communityRepository.sendMediaMessage(
      communityId: state.communityId,
      mediaFile: event.mediaFile,
      mediaType: event.mediaType,
      caption: event.caption,
      durationSeconds: event.durationSeconds,
      thumbnailFile: event.thumbnailFile,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSending: false,
        errorMessage: failure.displayMessage,
      )),
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onAddReaction(
    _AddReaction event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    final result = await _communityRepository.addReaction(
      communityId: state.communityId,
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
    Emitter<CommunityMessagingState> emit,
  ) async {
    final result = await _communityRepository.removeReaction(
      communityId: state.communityId,
      messageId: event.messageId,
      emoji: event.emoji,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    // Mark all messages as read — fire and forget
    // The community unread count is managed by the parent CommunityBloc stream
  }

  Future<void> _onLoadMore(
    _LoadMore event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    if (!state.hasMore || state.isLoading) return;
    if (state.messages.isEmpty) return;

    emit(state.copyWith(isLoading: true));

    final oldestMessage = state.messages.last;
    final result = await _communityRepository.getMessages(
      communityId: state.communityId,
      limit: 50,
      before: oldestMessage.createdAt,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (olderMessages) => emit(state.copyWith(
        isLoading: false,
        messages: [...state.messages, ...olderMessages],
        hasMore: olderMessages.length >= 50,
      )),
    );
  }

  void _onClearError(
    _ClearError event,
    Emitter<CommunityMessagingState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
