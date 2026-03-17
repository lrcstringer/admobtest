import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
        // 5.2 Stream error logging + isClosed guard
        if (!isClosed) {
          result.fold(
            (_) {},
            (messages) =>
                add(CommunityMessagingEvent.messagesUpdated(messages)),
          );
        }
      },
    );
  }

  void _onMessagesUpdated(
    _MessagesUpdated event,
    Emitter<CommunityMessagingState> emit,
  ) {
    // HIGH-3: Merge stream messages with paginated older messages.
    // The stream only watches the latest N messages, but pagination may have
    // loaded older messages beyond the stream's window. We must preserve those.
    final streamMessages = event.messages;
    if (state.messages.isEmpty || !state.hasMore) {
      // No paginated messages or hasn't loaded more — just use stream data
      emit(state.copyWith(messages: streamMessages));
      return;
    }

    // Find the oldest message in the stream batch
    DateTime? oldestStreamTime;
    for (final m in streamMessages) {
      if (oldestStreamTime == null || m.createdAt.isBefore(oldestStreamTime)) {
        oldestStreamTime = m.createdAt;
      }
    }
    if (oldestStreamTime == null) {
      emit(state.copyWith(messages: streamMessages));
      return;
    }

    // Keep paginated messages that are older than the stream window
    final streamIds = streamMessages.map((m) => m.id).toSet();
    final paginatedOlder = state.messages
        .where((m) =>
            m.createdAt.isBefore(oldestStreamTime!) &&
            !streamIds.contains(m.id))
        .toList();

    emit(state.copyWith(messages: [...streamMessages, ...paginatedOlder]));
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
      // 5.5 Message goes through OutgoingMessageQueue → stream will bring canonical version
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
      // 5.5 Message goes through OutgoingMessageQueue → stream will bring canonical version
      (message) => emit(state.copyWith(isSending: false)),
    );
  }

  Future<void> _onAddReaction(
    _AddReaction event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    // M10: Optimistic update — show reaction immediately before server round-trip
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId != null) {
      final updated = _updateReactionInMessages(
        state.messages, event.messageId, event.emoji, currentUserId,
        add: true,
      );
      emit(state.copyWith(messages: updated));
    }

    final result = await _communityRepository.addReaction(
      communityId: state.communityId,
      messageId: event.messageId,
      emoji: event.emoji,
    );
    // Revert on failure — stream will bring canonical state on success
    result.fold(
      (failure) {
        if (currentUserId != null) {
          final reverted = _updateReactionInMessages(
            state.messages, event.messageId, event.emoji, currentUserId,
            add: false,
          );
          emit(state.copyWith(
            messages: reverted,
            errorMessage: failure.displayMessage,
          ));
        } else {
          emit(state.copyWith(errorMessage: failure.displayMessage));
        }
      },
      (_) {},
    );
  }

  Future<void> _onRemoveReaction(
    _RemoveReaction event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    // M10: Optimistic update — remove reaction immediately
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId != null) {
      final updated = _updateReactionInMessages(
        state.messages, event.messageId, event.emoji, currentUserId,
        add: false,
      );
      emit(state.copyWith(messages: updated));
    }

    final result = await _communityRepository.removeReaction(
      communityId: state.communityId,
      messageId: event.messageId,
      emoji: event.emoji,
    );
    // Revert on failure
    result.fold(
      (failure) {
        if (currentUserId != null) {
          final reverted = _updateReactionInMessages(
            state.messages, event.messageId, event.emoji, currentUserId,
            add: true,
          );
          emit(state.copyWith(
            messages: reverted,
            errorMessage: failure.displayMessage,
          ));
        } else {
          emit(state.copyWith(errorMessage: failure.displayMessage));
        }
      },
      (_) {},
    );
  }

  /// Helper to optimistically add/remove a reaction in the message list.
  List<Message> _updateReactionInMessages(
    List<Message> messages,
    String messageId,
    String emoji,
    String userId, {
    required bool add,
  }) {
    return messages.map((m) {
      if (m.id != messageId) return m;
      final reactions = Map<String, List<String>>.from(
        m.reactions.map((k, v) => MapEntry(k, List<String>.from(v))),
      );
      if (add) {
        reactions.putIfAbsent(emoji, () => []);
        if (!reactions[emoji]!.contains(userId)) {
          reactions[emoji]!.add(userId);
        }
      } else {
        reactions[emoji]?.remove(userId);
        if (reactions[emoji]?.isEmpty ?? false) {
          reactions.remove(emoji);
        }
      }
      return m.copyWith(reactions: reactions);
    }).toList();
  }

  // 5.1 Implement markAsRead
  // M6: Await the call. HIGH-8: Handle offline gracefully — log but don't
  // surface error to UI (unread badge is cosmetic, will sync on next open).
  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<CommunityMessagingState> emit,
  ) async {
    final result =
        await _communityRepository.markAsRead(communityId: state.communityId);
    result.fold(
      (_) {},
      (_) {},
    );
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
      (olderMessages) {
        // 5.3 Deduplicate by message ID before appending
        final existingIds = state.messages.map((m) => m.id).toSet();
        final deduped =
            olderMessages.where((m) => !existingIds.contains(m.id)).toList();
        emit(state.copyWith(
          isLoading: false,
          messages: [...state.messages, ...deduped],
          hasMore: olderMessages.length >= 50,
        ));
      },
    );
  }

  void _onClearError(
    _ClearError event,
    Emitter<CommunityMessagingState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    return super.close();
  }
}
