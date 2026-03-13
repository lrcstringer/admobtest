part of 'conversation_actions_bloc.dart';

@freezed
abstract class ConversationActionsEvent with _$ConversationActionsEvent {
  /// Mark all messages as read
  const factory ConversationActionsEvent.markAsRead(String conversationId) =
      _MarkAsRead;

  /// Pin or unpin a conversation
  const factory ConversationActionsEvent.togglePin({
    required String conversationId,
    required bool pinned,
  }) = _TogglePin;

  /// Mute or unmute a conversation
  const factory ConversationActionsEvent.toggleMute({
    required String conversationId,
    required bool muted,
  }) = _ToggleMute;

  /// Archive a conversation
  const factory ConversationActionsEvent.archiveConversation(
    String conversationId,
  ) = _ArchiveConversation;

  /// Add a reaction to a message
  const factory ConversationActionsEvent.addReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) = _AddReaction;

  /// Remove a reaction from a message
  const factory ConversationActionsEvent.removeReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) = _RemoveReaction;

  /// Delete a single message for everyone
  const factory ConversationActionsEvent.deleteMessageForEveryone({
    required String conversationId,
    required String messageId,
  }) = _DeleteMessageForEveryone;

  /// Clear error state
  const factory ConversationActionsEvent.clearError() = _ClearError;
}
