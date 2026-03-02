part of 'community_messaging_bloc.dart';

@freezed
class CommunityMessagingEvent with _$CommunityMessagingEvent {
  /// Load messages (paginated, for scroll-back)
  const factory CommunityMessagingEvent.loadMessages({int? limit}) =
      _LoadMessages;

  /// Watch messages for real-time updates
  const factory CommunityMessagingEvent.watchMessages({int? limit}) =
      _WatchMessages;

  /// Messages updated from stream
  const factory CommunityMessagingEvent.messagesUpdated(
    List<Message> messages,
  ) = _MessagesUpdated;

  /// Send a text message
  const factory CommunityMessagingEvent.sendTextMessage({
    required String text,
    String? replyToMessageId,
  }) = _SendTextMessage;

  /// Send a media message (image, voice, video, or document)
  const factory CommunityMessagingEvent.sendMediaMessage({
    required File mediaFile,
    required String mediaType,
    String? caption,
    int? durationSeconds,
    File? thumbnailFile,
  }) = _SendMediaMessage;

  /// Add a reaction to a message
  const factory CommunityMessagingEvent.addReaction({
    required String messageId,
    required String emoji,
  }) = _AddReaction;

  /// Remove a reaction from a message
  const factory CommunityMessagingEvent.removeReaction({
    required String messageId,
    required String emoji,
  }) = _RemoveReaction;

  /// Mark messages as read
  const factory CommunityMessagingEvent.markAsRead() = _MarkAsRead;

  /// Load older messages (pagination)
  const factory CommunityMessagingEvent.loadMore() = _LoadMore;

  /// Clear error state
  const factory CommunityMessagingEvent.clearError() = _ClearError;
}
