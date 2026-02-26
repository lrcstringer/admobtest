import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../domain/repositories/conversation_repository.dart';

part 'conversation_actions_event.dart';
part 'conversation_actions_state.dart';
part 'conversation_actions_bloc.freezed.dart';

/// Handles fire-and-forget conversation actions: pin, mute, archive,
/// mark as read, reactions, and message deletion.
///
/// These operations call the repository and only produce error state on failure.
/// Success results are picked up by the existing watch streams (Firestore
/// listeners automatically push the updated data).
///
/// Extracted from ConversationBloc to isolate side-effect-only operations
/// from state-heavy list/detail/sending concerns.
@injectable
class ConversationActionsBloc
    extends Bloc<ConversationActionsEvent, ConversationActionsState> {
  final ConversationRepository _conversationRepository;

  ConversationActionsBloc(this._conversationRepository)
      : super(const ConversationActionsState()) {
    on<_MarkAsRead>(_onMarkAsRead);
    on<_TogglePin>(_onTogglePin);
    on<_ToggleMute>(_onToggleMute);
    on<_ArchiveConversation>(_onArchiveConversation);
    on<_AddReaction>(_onAddReaction);
    on<_RemoveReaction>(_onRemoveReaction);
    on<_DeleteMessageForEveryone>(_onDeleteMessageForEveryone);
    on<_ClearError>(_onClearError);
  }

  Future<void> _onMarkAsRead(
    _MarkAsRead event,
    Emitter<ConversationActionsState> emit,
  ) async {
    final result = await _conversationRepository.markAsRead(
      conversationId: event.conversationId,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onTogglePin(
    _TogglePin event,
    Emitter<ConversationActionsState> emit,
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
    Emitter<ConversationActionsState> emit,
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
    Emitter<ConversationActionsState> emit,
  ) async {
    final result = await _conversationRepository
        .archiveConversation(event.conversationId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  Future<void> _onAddReaction(
    _AddReaction event,
    Emitter<ConversationActionsState> emit,
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
    Emitter<ConversationActionsState> emit,
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

  Future<void> _onDeleteMessageForEveryone(
    _DeleteMessageForEveryone event,
    Emitter<ConversationActionsState> emit,
  ) async {
    final result = await _conversationRepository.deleteMessageForEveryone(
      conversationId: event.conversationId,
      messageId: event.messageId,
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.displayMessage)),
      (_) {},
    );
  }

  void _onClearError(
    _ClearError event,
    Emitter<ConversationActionsState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }
}
