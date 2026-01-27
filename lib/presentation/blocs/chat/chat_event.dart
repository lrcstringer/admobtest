part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  /// Load all chat threads
  const factory ChatEvent.loadThreads() = _LoadThreads;

  /// Watch chat threads for real-time updates
  const factory ChatEvent.watchThreads() = _WatchThreads;

  /// Threads updated from stream
  const factory ChatEvent.threadsUpdated(List<ChatThread> threads) = _ThreadsUpdated;

  /// Select a thread
  const factory ChatEvent.selectThread(String threadId) = _SelectThread;

  /// Load messages for a thread
  const factory ChatEvent.loadMessages({
    required String threadId,
    int? limit,
    DateTime? startAfter,
  }) = _LoadMessages;

  /// Watch messages for real-time updates
  const factory ChatEvent.watchMessages({
    required String threadId,
    int? limit,
  }) = _WatchMessages;

  /// Messages updated from stream
  const factory ChatEvent.messagesUpdated(List<ChatCard> messages) = _MessagesUpdated;

  /// Send a text message
  const factory ChatEvent.sendTextMessage({
    required String threadId,
    required String text,
  }) = _SendTextMessage;

  /// Send tokens to someone
  const factory ChatEvent.sendTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  }) = _SendTokens;

  /// Request tokens from someone
  const factory ChatEvent.requestTokens({
    required String threadId,
    required String recipientId,
    required int amount,
    String? message,
  }) = _RequestTokens;

  /// Accept a token request
  const factory ChatEvent.acceptTokenRequest(String cardId) = _AcceptTokenRequest;

  /// Decline a token request
  const factory ChatEvent.declineTokenRequest(String cardId) = _DeclineTokenRequest;

  /// Mark messages as read
  const factory ChatEvent.markAsRead({
    required String threadId,
    required List<String> messageIds,
  }) = _MarkAsRead;

  /// Pin/unpin a thread
  const factory ChatEvent.togglePinThread({
    required String threadId,
    required bool isPinned,
  }) = _TogglePinThread;

  /// Mute/unmute a thread
  const factory ChatEvent.toggleMuteThread({
    required String threadId,
    required bool isMuted,
  }) = _ToggleMuteThread;

  /// Archive a thread
  const factory ChatEvent.archiveThread(String threadId) = _ArchiveThread;

  /// Get or create a thread with a user
  const factory ChatEvent.getOrCreateThread(String participantId) = _GetOrCreateThread;

  /// Clear error
  const factory ChatEvent.clearError() = _ClearError;

  /// Unread count updated
  const factory ChatEvent.unreadCountUpdated(int count) = _UnreadCountUpdated;
}
