part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, success, failure }

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(ChatStatus.initial) ChatStatus status,
    @Default([]) List<ChatThread> threads,
    @Default([]) List<ChatCard> messages,
    ChatThread? selectedThread,
    @Default(false) bool isLoadingMessages,
    @Default(false) bool hasMoreMessages,
    @Default(false) bool isSending,
    @Default(0) int totalUnreadCount,
    String? errorMessage,
  }) = _ChatState;

  const ChatState._();

  /// Get pinned threads first, then sorted by last message
  List<ChatThread> get sortedThreads {
    final pinned = threads.where((t) => t.isPinned).toList();
    final unpinned = threads.where((t) => !t.isPinned).toList();
    return [...pinned, ...unpinned];
  }

  /// Get recipient ID from current thread (for P2P chats)
  String? getRecipientId(String currentUserId) {
    if (selectedThread == null) return null;
    return selectedThread!.participantIds
        .firstWhere((id) => id != currentUserId, orElse: () => '');
  }
}
