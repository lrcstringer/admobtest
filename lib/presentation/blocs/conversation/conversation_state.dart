part of 'conversation_bloc.dart';

/// Loading status for the conversation list
enum ConversationStatus { initial, loading, loaded, error }

@freezed
class ConversationState with _$ConversationState {
  const factory ConversationState({
    @Default(ConversationStatus.initial) ConversationStatus status,
    @Default([]) List<Conversation> conversations,
    @Default([]) List<Message> messages,
    Conversation? selectedConversation,
    @Default(false) bool isLoadingMessages,
    @Default(false) bool hasLoadedMessages,
    @Default(false) bool hasMoreMessages,
    @Default(false) bool isSending,
    @Default(false) bool isClearingChat,
    @Default(0) int totalUnreadCount,
    @Default([]) List<UserSearchResult> searchResults,
    @Default(false) bool isSearching,
    @Default(0) int messageRequestCount,
    String? errorMessage,
  }) = _ConversationState;

  const ConversationState._();

  /// Conversations sorted: pinned first, then by lastMessageAt descending
  List<Conversation> sortedConversations(String currentUserId) {
    final sorted = List<Conversation>.from(conversations);
    sorted.sort((a, b) {
      final aPinned = a.isPinnedFor(currentUserId);
      final bPinned = b.isPinnedFor(currentUserId);
      if (aPinned != bPinned) return aPinned ? -1 : 1;
      final aTime = a.lastMessageAt ?? a.createdAt;
      final bTime = b.lastMessageAt ?? b.createdAt;
      return bTime.compareTo(aTime);
    });
    return sorted;
  }

  /// Get the other participant's ID from selected conversation
  String? getRecipientId(String currentUserId) {
    if (selectedConversation == null) return null;
    return selectedConversation!.participantIds
        .firstWhere((id) => id != currentUserId, orElse: () => '');
  }
}
