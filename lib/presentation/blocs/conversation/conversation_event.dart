part of 'conversation_bloc.dart';

@freezed
class ConversationEvent with _$ConversationEvent {
  // =========================================================================
  // CONVERSATION LIST
  // =========================================================================

  /// Load all conversations (one-shot)
  const factory ConversationEvent.loadConversations() = _LoadConversations;

  /// Watch conversations for real-time inbox updates
  const factory ConversationEvent.watchConversations() = _WatchConversations;

  /// Conversations updated from stream
  const factory ConversationEvent.conversationsUpdated(
    List<Conversation> conversations,
  ) = _ConversationsUpdated;

  // =========================================================================
  // CONVERSATION SELECTION
  // =========================================================================

  /// Select a conversation and start watching its messages
  const factory ConversationEvent.selectConversation(String id) =
      _SelectConversation;

  /// Get or create a P2P conversation with another user
  const factory ConversationEvent.getOrCreateConversation(
    String participantId,
  ) = _GetOrCreateConversation;

  // =========================================================================
  // MESSAGES
  // =========================================================================

  /// Load messages (paginated, for scroll-back)
  const factory ConversationEvent.loadMessages({
    required String conversationId,
    int? limit,
    DateTime? before,
  }) = _LoadMessages;

  /// Watch messages for real-time updates
  const factory ConversationEvent.watchMessages({
    required String conversationId,
    int? limit,
  }) = _WatchMessages;

  /// Messages updated from stream
  const factory ConversationEvent.messagesUpdated(
    List<Message> messages,
  ) = _MessagesUpdated;

  /// Send a text message
  const factory ConversationEvent.sendTextMessage({
    required String conversationId,
    required String text,
    String? replyToMessageId,
  }) = _SendTextMessage;

  /// Send a media message (image or voice)
  const factory ConversationEvent.sendMediaMessage({
    required String conversationId,
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) = _SendMediaMessage;

  // =========================================================================
  // TOKEN OPERATIONS
  // =========================================================================

  /// Send tokens to another user in a conversation
  const factory ConversationEvent.sendTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
  }) = _SendTokens;

  /// Request tokens from another user in a conversation
  const factory ConversationEvent.requestTokens({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
  }) = _RequestTokens;

  /// Accept an incoming token request
  const factory ConversationEvent.acceptTokenRequest({
    required String messageId,
    required String conversationId,
  }) = _AcceptTokenRequest;

  /// Decline an incoming token request
  const factory ConversationEvent.declineTokenRequest({
    required String messageId,
    required String conversationId,
  }) = _DeclineTokenRequest;

  // =========================================================================
  // THREAD MANAGEMENT
  // =========================================================================

  /// Mark all messages as read
  const factory ConversationEvent.markAsRead(String conversationId) =
      _MarkAsRead;

  /// Pin or unpin a conversation
  const factory ConversationEvent.togglePin({
    required String conversationId,
    required bool pinned,
  }) = _TogglePin;

  /// Mute or unmute a conversation
  const factory ConversationEvent.toggleMute({
    required String conversationId,
    required bool muted,
  }) = _ToggleMute;

  /// Archive a conversation
  const factory ConversationEvent.archiveConversation(
    String conversationId,
  ) = _ArchiveConversation;

  // =========================================================================
  // REACTIONS
  // =========================================================================

  /// Add a reaction to a message
  const factory ConversationEvent.addReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) = _AddReaction;

  /// Remove a reaction from a message
  const factory ConversationEvent.removeReaction({
    required String conversationId,
    required String messageId,
    required String emoji,
  }) = _RemoveReaction;

  // =========================================================================
  // UNREAD COUNT
  // =========================================================================

  /// Total unread count updated (from stream)
  const factory ConversationEvent.unreadCountUpdated(int count) =
      _UnreadCountUpdated;

  // =========================================================================
  // MESSAGE DELETION
  // =========================================================================

  /// Delete a single message for everyone
  const factory ConversationEvent.deleteMessageForEveryone({
    required String conversationId,
    required String messageId,
  }) = _DeleteMessageForEveryone;

  /// Clear all messages from a conversation (for current user only)
  const factory ConversationEvent.clearChat(String conversationId) = _ClearChat;

  // =========================================================================
  // RETRY
  // =========================================================================

  /// Retry sending a failed message
  const factory ConversationEvent.retryMessage({
    required String conversationId,
    required String messageId,
  }) = _RetryMessage;

  // =========================================================================
  // USER SEARCH
  // =========================================================================

  /// Search users by display name or username
  const factory ConversationEvent.searchUsers(String query) = _SearchUsers;

  /// Clear search results
  const factory ConversationEvent.clearSearch() = _ClearSearch;

  // =========================================================================
  // UTILITY
  // =========================================================================

  /// Clear error state
  const factory ConversationEvent.clearError() = _ClearError;
}
