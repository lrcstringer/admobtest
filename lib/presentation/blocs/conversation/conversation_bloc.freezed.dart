// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConversationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationEventCopyWith<$Res> {
  factory $ConversationEventCopyWith(
    ConversationEvent value,
    $Res Function(ConversationEvent) then,
  ) = _$ConversationEventCopyWithImpl<$Res, ConversationEvent>;
}

/// @nodoc
class _$ConversationEventCopyWithImpl<$Res, $Val extends ConversationEvent>
    implements $ConversationEventCopyWith<$Res> {
  _$ConversationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadConversationsImplCopyWith<$Res> {
  factory _$$LoadConversationsImplCopyWith(
    _$LoadConversationsImpl value,
    $Res Function(_$LoadConversationsImpl) then,
  ) = __$$LoadConversationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadConversationsImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$LoadConversationsImpl>
    implements _$$LoadConversationsImplCopyWith<$Res> {
  __$$LoadConversationsImplCopyWithImpl(
    _$LoadConversationsImpl _value,
    $Res Function(_$LoadConversationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadConversationsImpl implements _LoadConversations {
  const _$LoadConversationsImpl();

  @override
  String toString() {
    return 'ConversationEvent.loadConversations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadConversationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return loadConversations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return loadConversations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadConversations != null) {
      return loadConversations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadConversations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadConversations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadConversations != null) {
      return loadConversations(this);
    }
    return orElse();
  }
}

abstract class _LoadConversations implements ConversationEvent {
  const factory _LoadConversations() = _$LoadConversationsImpl;
}

/// @nodoc
abstract class _$$WatchConversationsImplCopyWith<$Res> {
  factory _$$WatchConversationsImplCopyWith(
    _$WatchConversationsImpl value,
    $Res Function(_$WatchConversationsImpl) then,
  ) = __$$WatchConversationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchConversationsImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$WatchConversationsImpl>
    implements _$$WatchConversationsImplCopyWith<$Res> {
  __$$WatchConversationsImplCopyWithImpl(
    _$WatchConversationsImpl _value,
    $Res Function(_$WatchConversationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchConversationsImpl implements _WatchConversations {
  const _$WatchConversationsImpl();

  @override
  String toString() {
    return 'ConversationEvent.watchConversations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchConversationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return watchConversations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return watchConversations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchConversations != null) {
      return watchConversations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchConversations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchConversations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchConversations != null) {
      return watchConversations(this);
    }
    return orElse();
  }
}

abstract class _WatchConversations implements ConversationEvent {
  const factory _WatchConversations() = _$WatchConversationsImpl;
}

/// @nodoc
abstract class _$$ConversationsUpdatedImplCopyWith<$Res> {
  factory _$$ConversationsUpdatedImplCopyWith(
    _$ConversationsUpdatedImpl value,
    $Res Function(_$ConversationsUpdatedImpl) then,
  ) = __$$ConversationsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Conversation> conversations});
}

/// @nodoc
class __$$ConversationsUpdatedImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ConversationsUpdatedImpl>
    implements _$$ConversationsUpdatedImplCopyWith<$Res> {
  __$$ConversationsUpdatedImplCopyWithImpl(
    _$ConversationsUpdatedImpl _value,
    $Res Function(_$ConversationsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversations = null}) {
    return _then(
      _$ConversationsUpdatedImpl(
        null == conversations
            ? _value._conversations
            : conversations // ignore: cast_nullable_to_non_nullable
                  as List<Conversation>,
      ),
    );
  }
}

/// @nodoc

class _$ConversationsUpdatedImpl implements _ConversationsUpdated {
  const _$ConversationsUpdatedImpl(final List<Conversation> conversations)
    : _conversations = conversations;

  final List<Conversation> _conversations;
  @override
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  String toString() {
    return 'ConversationEvent.conversationsUpdated(conversations: $conversations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationsUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_conversations),
  );

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationsUpdatedImplCopyWith<_$ConversationsUpdatedImpl>
  get copyWith =>
      __$$ConversationsUpdatedImplCopyWithImpl<_$ConversationsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return conversationsUpdated(conversations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return conversationsUpdated?.call(conversations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (conversationsUpdated != null) {
      return conversationsUpdated(conversations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return conversationsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return conversationsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (conversationsUpdated != null) {
      return conversationsUpdated(this);
    }
    return orElse();
  }
}

abstract class _ConversationsUpdated implements ConversationEvent {
  const factory _ConversationsUpdated(final List<Conversation> conversations) =
      _$ConversationsUpdatedImpl;

  List<Conversation> get conversations;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationsUpdatedImplCopyWith<_$ConversationsUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectConversationImplCopyWith<$Res> {
  factory _$$SelectConversationImplCopyWith(
    _$SelectConversationImpl value,
    $Res Function(_$SelectConversationImpl) then,
  ) = __$$SelectConversationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$SelectConversationImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SelectConversationImpl>
    implements _$$SelectConversationImplCopyWith<$Res> {
  __$$SelectConversationImplCopyWithImpl(
    _$SelectConversationImpl _value,
    $Res Function(_$SelectConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$SelectConversationImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectConversationImpl implements _SelectConversation {
  const _$SelectConversationImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'ConversationEvent.selectConversation(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectConversationImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectConversationImplCopyWith<_$SelectConversationImpl> get copyWith =>
      __$$SelectConversationImplCopyWithImpl<_$SelectConversationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return selectConversation(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return selectConversation?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (selectConversation != null) {
      return selectConversation(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return selectConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return selectConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (selectConversation != null) {
      return selectConversation(this);
    }
    return orElse();
  }
}

abstract class _SelectConversation implements ConversationEvent {
  const factory _SelectConversation(final String id) = _$SelectConversationImpl;

  String get id;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectConversationImplCopyWith<_$SelectConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetOrCreateConversationImplCopyWith<$Res> {
  factory _$$GetOrCreateConversationImplCopyWith(
    _$GetOrCreateConversationImpl value,
    $Res Function(_$GetOrCreateConversationImpl) then,
  ) = __$$GetOrCreateConversationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String participantId});
}

/// @nodoc
class __$$GetOrCreateConversationImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$GetOrCreateConversationImpl>
    implements _$$GetOrCreateConversationImplCopyWith<$Res> {
  __$$GetOrCreateConversationImplCopyWithImpl(
    _$GetOrCreateConversationImpl _value,
    $Res Function(_$GetOrCreateConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? participantId = null}) {
    return _then(
      _$GetOrCreateConversationImpl(
        null == participantId
            ? _value.participantId
            : participantId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetOrCreateConversationImpl implements _GetOrCreateConversation {
  const _$GetOrCreateConversationImpl(this.participantId);

  @override
  final String participantId;

  @override
  String toString() {
    return 'ConversationEvent.getOrCreateConversation(participantId: $participantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOrCreateConversationImpl &&
            (identical(other.participantId, participantId) ||
                other.participantId == participantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, participantId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOrCreateConversationImplCopyWith<_$GetOrCreateConversationImpl>
  get copyWith =>
      __$$GetOrCreateConversationImplCopyWithImpl<
        _$GetOrCreateConversationImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return getOrCreateConversation(participantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return getOrCreateConversation?.call(participantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (getOrCreateConversation != null) {
      return getOrCreateConversation(participantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return getOrCreateConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return getOrCreateConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (getOrCreateConversation != null) {
      return getOrCreateConversation(this);
    }
    return orElse();
  }
}

abstract class _GetOrCreateConversation implements ConversationEvent {
  const factory _GetOrCreateConversation(final String participantId) =
      _$GetOrCreateConversationImpl;

  String get participantId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOrCreateConversationImplCopyWith<_$GetOrCreateConversationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMessagesImplCopyWith<$Res> {
  factory _$$LoadMessagesImplCopyWith(
    _$LoadMessagesImpl value,
    $Res Function(_$LoadMessagesImpl) then,
  ) = __$$LoadMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, int? limit, DateTime? before});
}

/// @nodoc
class __$$LoadMessagesImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$LoadMessagesImpl>
    implements _$$LoadMessagesImplCopyWith<$Res> {
  __$$LoadMessagesImplCopyWithImpl(
    _$LoadMessagesImpl _value,
    $Res Function(_$LoadMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? limit = freezed,
    Object? before = freezed,
  }) {
    return _then(
      _$LoadMessagesImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
        before: freezed == before
            ? _value.before
            : before // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$LoadMessagesImpl implements _LoadMessages {
  const _$LoadMessagesImpl({
    required this.conversationId,
    this.limit,
    this.before,
  });

  @override
  final String conversationId;
  @override
  final int? limit;
  @override
  final DateTime? before;

  @override
  String toString() {
    return 'ConversationEvent.loadMessages(conversationId: $conversationId, limit: $limit, before: $before)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMessagesImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.before, before) || other.before == before));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, limit, before);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      __$$LoadMessagesImplCopyWithImpl<_$LoadMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return loadMessages(conversationId, limit, before);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return loadMessages?.call(conversationId, limit, before);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(conversationId, limit, before);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(this);
    }
    return orElse();
  }
}

abstract class _LoadMessages implements ConversationEvent {
  const factory _LoadMessages({
    required final String conversationId,
    final int? limit,
    final DateTime? before,
  }) = _$LoadMessagesImpl;

  String get conversationId;
  int? get limit;
  DateTime? get before;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchMessagesImplCopyWith<$Res> {
  factory _$$WatchMessagesImplCopyWith(
    _$WatchMessagesImpl value,
    $Res Function(_$WatchMessagesImpl) then,
  ) = __$$WatchMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, int? limit});
}

/// @nodoc
class __$$WatchMessagesImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$WatchMessagesImpl>
    implements _$$WatchMessagesImplCopyWith<$Res> {
  __$$WatchMessagesImplCopyWithImpl(
    _$WatchMessagesImpl _value,
    $Res Function(_$WatchMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? limit = freezed}) {
    return _then(
      _$WatchMessagesImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$WatchMessagesImpl implements _WatchMessages {
  const _$WatchMessagesImpl({required this.conversationId, this.limit});

  @override
  final String conversationId;
  @override
  final int? limit;

  @override
  String toString() {
    return 'ConversationEvent.watchMessages(conversationId: $conversationId, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchMessagesImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, limit);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchMessagesImplCopyWith<_$WatchMessagesImpl> get copyWith =>
      __$$WatchMessagesImplCopyWithImpl<_$WatchMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return watchMessages(conversationId, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return watchMessages?.call(conversationId, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchMessages != null) {
      return watchMessages(conversationId, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchMessages != null) {
      return watchMessages(this);
    }
    return orElse();
  }
}

abstract class _WatchMessages implements ConversationEvent {
  const factory _WatchMessages({
    required final String conversationId,
    final int? limit,
  }) = _$WatchMessagesImpl;

  String get conversationId;
  int? get limit;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchMessagesImplCopyWith<_$WatchMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessagesUpdatedImplCopyWith<$Res> {
  factory _$$MessagesUpdatedImplCopyWith(
    _$MessagesUpdatedImpl value,
    $Res Function(_$MessagesUpdatedImpl) then,
  ) = __$$MessagesUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Message> messages});
}

/// @nodoc
class __$$MessagesUpdatedImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$MessagesUpdatedImpl>
    implements _$$MessagesUpdatedImplCopyWith<$Res> {
  __$$MessagesUpdatedImplCopyWithImpl(
    _$MessagesUpdatedImpl _value,
    $Res Function(_$MessagesUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _$MessagesUpdatedImpl(
        null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
      ),
    );
  }
}

/// @nodoc

class _$MessagesUpdatedImpl implements _MessagesUpdated {
  const _$MessagesUpdatedImpl(final List<Message> messages)
    : _messages = messages;

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ConversationEvent.messagesUpdated(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesUpdatedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesUpdatedImplCopyWith<_$MessagesUpdatedImpl> get copyWith =>
      __$$MessagesUpdatedImplCopyWithImpl<_$MessagesUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return messagesUpdated(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return messagesUpdated?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (messagesUpdated != null) {
      return messagesUpdated(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return messagesUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return messagesUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (messagesUpdated != null) {
      return messagesUpdated(this);
    }
    return orElse();
  }
}

abstract class _MessagesUpdated implements ConversationEvent {
  const factory _MessagesUpdated(final List<Message> messages) =
      _$MessagesUpdatedImpl;

  List<Message> get messages;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesUpdatedImplCopyWith<_$MessagesUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTextMessageImplCopyWith<$Res> {
  factory _$$SendTextMessageImplCopyWith(
    _$SendTextMessageImpl value,
    $Res Function(_$SendTextMessageImpl) then,
  ) = __$$SendTextMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String text, String? replyToMessageId});
}

/// @nodoc
class __$$SendTextMessageImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SendTextMessageImpl>
    implements _$$SendTextMessageImplCopyWith<$Res> {
  __$$SendTextMessageImplCopyWithImpl(
    _$SendTextMessageImpl _value,
    $Res Function(_$SendTextMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? text = null,
    Object? replyToMessageId = freezed,
  }) {
    return _then(
      _$SendTextMessageImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        replyToMessageId: freezed == replyToMessageId
            ? _value.replyToMessageId
            : replyToMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendTextMessageImpl implements _SendTextMessage {
  const _$SendTextMessageImpl({
    required this.conversationId,
    required this.text,
    this.replyToMessageId,
  });

  @override
  final String conversationId;
  @override
  final String text;
  @override
  final String? replyToMessageId;

  @override
  String toString() {
    return 'ConversationEvent.sendTextMessage(conversationId: $conversationId, text: $text, replyToMessageId: $replyToMessageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTextMessageImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, text, replyToMessageId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTextMessageImplCopyWith<_$SendTextMessageImpl> get copyWith =>
      __$$SendTextMessageImplCopyWithImpl<_$SendTextMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return sendTextMessage(conversationId, text, replyToMessageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return sendTextMessage?.call(conversationId, text, replyToMessageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (sendTextMessage != null) {
      return sendTextMessage(conversationId, text, replyToMessageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendTextMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendTextMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (sendTextMessage != null) {
      return sendTextMessage(this);
    }
    return orElse();
  }
}

abstract class _SendTextMessage implements ConversationEvent {
  const factory _SendTextMessage({
    required final String conversationId,
    required final String text,
    final String? replyToMessageId,
  }) = _$SendTextMessageImpl;

  String get conversationId;
  String get text;
  String? get replyToMessageId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTextMessageImplCopyWith<_$SendTextMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendMediaMessageImplCopyWith<$Res> {
  factory _$$SendMediaMessageImplCopyWith(
    _$SendMediaMessageImpl value,
    $Res Function(_$SendMediaMessageImpl) then,
  ) = __$$SendMediaMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String conversationId,
    String mediaUrl,
    String mediaType,
    String? caption,
  });
}

/// @nodoc
class __$$SendMediaMessageImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SendMediaMessageImpl>
    implements _$$SendMediaMessageImplCopyWith<$Res> {
  __$$SendMediaMessageImplCopyWithImpl(
    _$SendMediaMessageImpl _value,
    $Res Function(_$SendMediaMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? mediaUrl = null,
    Object? mediaType = null,
    Object? caption = freezed,
  }) {
    return _then(
      _$SendMediaMessageImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaUrl: null == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaType: null == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as String,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendMediaMessageImpl implements _SendMediaMessage {
  const _$SendMediaMessageImpl({
    required this.conversationId,
    required this.mediaUrl,
    required this.mediaType,
    this.caption,
  });

  @override
  final String conversationId;
  @override
  final String mediaUrl;
  @override
  final String mediaType;
  @override
  final String? caption;

  @override
  String toString() {
    return 'ConversationEvent.sendMediaMessage(conversationId: $conversationId, mediaUrl: $mediaUrl, mediaType: $mediaType, caption: $caption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMediaMessageImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.caption, caption) || other.caption == caption));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, mediaUrl, mediaType, caption);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMediaMessageImplCopyWith<_$SendMediaMessageImpl> get copyWith =>
      __$$SendMediaMessageImplCopyWithImpl<_$SendMediaMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return sendMediaMessage(conversationId, mediaUrl, mediaType, caption);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return sendMediaMessage?.call(conversationId, mediaUrl, mediaType, caption);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (sendMediaMessage != null) {
      return sendMediaMessage(conversationId, mediaUrl, mediaType, caption);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendMediaMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendMediaMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (sendMediaMessage != null) {
      return sendMediaMessage(this);
    }
    return orElse();
  }
}

abstract class _SendMediaMessage implements ConversationEvent {
  const factory _SendMediaMessage({
    required final String conversationId,
    required final String mediaUrl,
    required final String mediaType,
    final String? caption,
  }) = _$SendMediaMessageImpl;

  String get conversationId;
  String get mediaUrl;
  String get mediaType;
  String? get caption;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMediaMessageImplCopyWith<_$SendMediaMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTokensImplCopyWith<$Res> {
  factory _$$SendTokensImplCopyWith(
    _$SendTokensImpl value,
    $Res Function(_$SendTokensImpl) then,
  ) = __$$SendTokensImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String conversationId,
    String recipientId,
    int amount,
    String? message,
  });
}

/// @nodoc
class __$$SendTokensImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SendTokensImpl>
    implements _$$SendTokensImplCopyWith<$Res> {
  __$$SendTokensImplCopyWithImpl(
    _$SendTokensImpl _value,
    $Res Function(_$SendTokensImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? recipientId = null,
    Object? amount = null,
    Object? message = freezed,
  }) {
    return _then(
      _$SendTokensImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendTokensImpl implements _SendTokens {
  const _$SendTokensImpl({
    required this.conversationId,
    required this.recipientId,
    required this.amount,
    this.message,
  });

  @override
  final String conversationId;
  @override
  final String recipientId;
  @override
  final int amount;
  @override
  final String? message;

  @override
  String toString() {
    return 'ConversationEvent.sendTokens(conversationId: $conversationId, recipientId: $recipientId, amount: $amount, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTokensImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, recipientId, amount, message);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTokensImplCopyWith<_$SendTokensImpl> get copyWith =>
      __$$SendTokensImplCopyWithImpl<_$SendTokensImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return sendTokens(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return sendTokens?.call(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (sendTokens != null) {
      return sendTokens(conversationId, recipientId, amount, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (sendTokens != null) {
      return sendTokens(this);
    }
    return orElse();
  }
}

abstract class _SendTokens implements ConversationEvent {
  const factory _SendTokens({
    required final String conversationId,
    required final String recipientId,
    required final int amount,
    final String? message,
  }) = _$SendTokensImpl;

  String get conversationId;
  String get recipientId;
  int get amount;
  String? get message;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTokensImplCopyWith<_$SendTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestTokensImplCopyWith<$Res> {
  factory _$$RequestTokensImplCopyWith(
    _$RequestTokensImpl value,
    $Res Function(_$RequestTokensImpl) then,
  ) = __$$RequestTokensImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String conversationId,
    String recipientId,
    int amount,
    String? message,
  });
}

/// @nodoc
class __$$RequestTokensImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$RequestTokensImpl>
    implements _$$RequestTokensImplCopyWith<$Res> {
  __$$RequestTokensImplCopyWithImpl(
    _$RequestTokensImpl _value,
    $Res Function(_$RequestTokensImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? recipientId = null,
    Object? amount = null,
    Object? message = freezed,
  }) {
    return _then(
      _$RequestTokensImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RequestTokensImpl implements _RequestTokens {
  const _$RequestTokensImpl({
    required this.conversationId,
    required this.recipientId,
    required this.amount,
    this.message,
  });

  @override
  final String conversationId;
  @override
  final String recipientId;
  @override
  final int amount;
  @override
  final String? message;

  @override
  String toString() {
    return 'ConversationEvent.requestTokens(conversationId: $conversationId, recipientId: $recipientId, amount: $amount, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestTokensImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, recipientId, amount, message);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestTokensImplCopyWith<_$RequestTokensImpl> get copyWith =>
      __$$RequestTokensImplCopyWithImpl<_$RequestTokensImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return requestTokens(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return requestTokens?.call(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (requestTokens != null) {
      return requestTokens(conversationId, recipientId, amount, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return requestTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return requestTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (requestTokens != null) {
      return requestTokens(this);
    }
    return orElse();
  }
}

abstract class _RequestTokens implements ConversationEvent {
  const factory _RequestTokens({
    required final String conversationId,
    required final String recipientId,
    required final int amount,
    final String? message,
  }) = _$RequestTokensImpl;

  String get conversationId;
  String get recipientId;
  int get amount;
  String? get message;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestTokensImplCopyWith<_$RequestTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptTokenRequestImplCopyWith<$Res> {
  factory _$$AcceptTokenRequestImplCopyWith(
    _$AcceptTokenRequestImpl value,
    $Res Function(_$AcceptTokenRequestImpl) then,
  ) = __$$AcceptTokenRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, String conversationId});
}

/// @nodoc
class __$$AcceptTokenRequestImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$AcceptTokenRequestImpl>
    implements _$$AcceptTokenRequestImplCopyWith<$Res> {
  __$$AcceptTokenRequestImplCopyWithImpl(
    _$AcceptTokenRequestImpl _value,
    $Res Function(_$AcceptTokenRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageId = null, Object? conversationId = null}) {
    return _then(
      _$AcceptTokenRequestImpl(
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AcceptTokenRequestImpl implements _AcceptTokenRequest {
  const _$AcceptTokenRequestImpl({
    required this.messageId,
    required this.conversationId,
  });

  @override
  final String messageId;
  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationEvent.acceptTokenRequest(messageId: $messageId, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptTokenRequestImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, conversationId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptTokenRequestImplCopyWith<_$AcceptTokenRequestImpl> get copyWith =>
      __$$AcceptTokenRequestImplCopyWithImpl<_$AcceptTokenRequestImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return acceptTokenRequest(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return acceptTokenRequest?.call(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (acceptTokenRequest != null) {
      return acceptTokenRequest(messageId, conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return acceptTokenRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return acceptTokenRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (acceptTokenRequest != null) {
      return acceptTokenRequest(this);
    }
    return orElse();
  }
}

abstract class _AcceptTokenRequest implements ConversationEvent {
  const factory _AcceptTokenRequest({
    required final String messageId,
    required final String conversationId,
  }) = _$AcceptTokenRequestImpl;

  String get messageId;
  String get conversationId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptTokenRequestImplCopyWith<_$AcceptTokenRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeclineTokenRequestImplCopyWith<$Res> {
  factory _$$DeclineTokenRequestImplCopyWith(
    _$DeclineTokenRequestImpl value,
    $Res Function(_$DeclineTokenRequestImpl) then,
  ) = __$$DeclineTokenRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, String conversationId});
}

/// @nodoc
class __$$DeclineTokenRequestImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$DeclineTokenRequestImpl>
    implements _$$DeclineTokenRequestImplCopyWith<$Res> {
  __$$DeclineTokenRequestImplCopyWithImpl(
    _$DeclineTokenRequestImpl _value,
    $Res Function(_$DeclineTokenRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageId = null, Object? conversationId = null}) {
    return _then(
      _$DeclineTokenRequestImpl(
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeclineTokenRequestImpl implements _DeclineTokenRequest {
  const _$DeclineTokenRequestImpl({
    required this.messageId,
    required this.conversationId,
  });

  @override
  final String messageId;
  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationEvent.declineTokenRequest(messageId: $messageId, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeclineTokenRequestImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, conversationId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeclineTokenRequestImplCopyWith<_$DeclineTokenRequestImpl> get copyWith =>
      __$$DeclineTokenRequestImplCopyWithImpl<_$DeclineTokenRequestImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return declineTokenRequest(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return declineTokenRequest?.call(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (declineTokenRequest != null) {
      return declineTokenRequest(messageId, conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return declineTokenRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return declineTokenRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (declineTokenRequest != null) {
      return declineTokenRequest(this);
    }
    return orElse();
  }
}

abstract class _DeclineTokenRequest implements ConversationEvent {
  const factory _DeclineTokenRequest({
    required final String messageId,
    required final String conversationId,
  }) = _$DeclineTokenRequestImpl;

  String get messageId;
  String get conversationId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeclineTokenRequestImplCopyWith<_$DeclineTokenRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAsReadImplCopyWith<$Res> {
  factory _$$MarkAsReadImplCopyWith(
    _$MarkAsReadImpl value,
    $Res Function(_$MarkAsReadImpl) then,
  ) = __$$MarkAsReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId});
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
    _$MarkAsReadImpl _value,
    $Res Function(_$MarkAsReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null}) {
    return _then(
      _$MarkAsReadImpl(
        null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MarkAsReadImpl implements _MarkAsRead {
  const _$MarkAsReadImpl(this.conversationId);

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationEvent.markAsRead(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      __$$MarkAsReadImplCopyWithImpl<_$MarkAsReadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return markAsRead(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return markAsRead?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAsRead implements ConversationEvent {
  const factory _MarkAsRead(final String conversationId) = _$MarkAsReadImpl;

  String get conversationId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TogglePinImplCopyWith<$Res> {
  factory _$$TogglePinImplCopyWith(
    _$TogglePinImpl value,
    $Res Function(_$TogglePinImpl) then,
  ) = __$$TogglePinImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, bool pinned});
}

/// @nodoc
class __$$TogglePinImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$TogglePinImpl>
    implements _$$TogglePinImplCopyWith<$Res> {
  __$$TogglePinImplCopyWithImpl(
    _$TogglePinImpl _value,
    $Res Function(_$TogglePinImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? pinned = null}) {
    return _then(
      _$TogglePinImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        pinned: null == pinned
            ? _value.pinned
            : pinned // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TogglePinImpl implements _TogglePin {
  const _$TogglePinImpl({required this.conversationId, required this.pinned});

  @override
  final String conversationId;
  @override
  final bool pinned;

  @override
  String toString() {
    return 'ConversationEvent.togglePin(conversationId: $conversationId, pinned: $pinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TogglePinImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.pinned, pinned) || other.pinned == pinned));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, pinned);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TogglePinImplCopyWith<_$TogglePinImpl> get copyWith =>
      __$$TogglePinImplCopyWithImpl<_$TogglePinImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return togglePin(conversationId, pinned);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return togglePin?.call(conversationId, pinned);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (togglePin != null) {
      return togglePin(conversationId, pinned);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return togglePin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return togglePin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (togglePin != null) {
      return togglePin(this);
    }
    return orElse();
  }
}

abstract class _TogglePin implements ConversationEvent {
  const factory _TogglePin({
    required final String conversationId,
    required final bool pinned,
  }) = _$TogglePinImpl;

  String get conversationId;
  bool get pinned;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TogglePinImplCopyWith<_$TogglePinImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleMuteImplCopyWith<$Res> {
  factory _$$ToggleMuteImplCopyWith(
    _$ToggleMuteImpl value,
    $Res Function(_$ToggleMuteImpl) then,
  ) = __$$ToggleMuteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, bool muted});
}

/// @nodoc
class __$$ToggleMuteImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ToggleMuteImpl>
    implements _$$ToggleMuteImplCopyWith<$Res> {
  __$$ToggleMuteImplCopyWithImpl(
    _$ToggleMuteImpl _value,
    $Res Function(_$ToggleMuteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? muted = null}) {
    return _then(
      _$ToggleMuteImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        muted: null == muted
            ? _value.muted
            : muted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ToggleMuteImpl implements _ToggleMute {
  const _$ToggleMuteImpl({required this.conversationId, required this.muted});

  @override
  final String conversationId;
  @override
  final bool muted;

  @override
  String toString() {
    return 'ConversationEvent.toggleMute(conversationId: $conversationId, muted: $muted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleMuteImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, muted);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleMuteImplCopyWith<_$ToggleMuteImpl> get copyWith =>
      __$$ToggleMuteImplCopyWithImpl<_$ToggleMuteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return toggleMute(conversationId, muted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return toggleMute?.call(conversationId, muted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(conversationId, muted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return toggleMute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return toggleMute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(this);
    }
    return orElse();
  }
}

abstract class _ToggleMute implements ConversationEvent {
  const factory _ToggleMute({
    required final String conversationId,
    required final bool muted,
  }) = _$ToggleMuteImpl;

  String get conversationId;
  bool get muted;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleMuteImplCopyWith<_$ToggleMuteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArchiveConversationImplCopyWith<$Res> {
  factory _$$ArchiveConversationImplCopyWith(
    _$ArchiveConversationImpl value,
    $Res Function(_$ArchiveConversationImpl) then,
  ) = __$$ArchiveConversationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId});
}

/// @nodoc
class __$$ArchiveConversationImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ArchiveConversationImpl>
    implements _$$ArchiveConversationImplCopyWith<$Res> {
  __$$ArchiveConversationImplCopyWithImpl(
    _$ArchiveConversationImpl _value,
    $Res Function(_$ArchiveConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null}) {
    return _then(
      _$ArchiveConversationImpl(
        null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ArchiveConversationImpl implements _ArchiveConversation {
  const _$ArchiveConversationImpl(this.conversationId);

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationEvent.archiveConversation(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArchiveConversationImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArchiveConversationImplCopyWith<_$ArchiveConversationImpl> get copyWith =>
      __$$ArchiveConversationImplCopyWithImpl<_$ArchiveConversationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return archiveConversation(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return archiveConversation?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (archiveConversation != null) {
      return archiveConversation(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return archiveConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return archiveConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (archiveConversation != null) {
      return archiveConversation(this);
    }
    return orElse();
  }
}

abstract class _ArchiveConversation implements ConversationEvent {
  const factory _ArchiveConversation(final String conversationId) =
      _$ArchiveConversationImpl;

  String get conversationId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArchiveConversationImplCopyWith<_$ArchiveConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddReactionImplCopyWith<$Res> {
  factory _$$AddReactionImplCopyWith(
    _$AddReactionImpl value,
    $Res Function(_$AddReactionImpl) then,
  ) = __$$AddReactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String messageId, String emoji});
}

/// @nodoc
class __$$AddReactionImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$AddReactionImpl>
    implements _$$AddReactionImplCopyWith<$Res> {
  __$$AddReactionImplCopyWithImpl(
    _$AddReactionImpl _value,
    $Res Function(_$AddReactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? messageId = null,
    Object? emoji = null,
  }) {
    return _then(
      _$AddReactionImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AddReactionImpl implements _AddReaction {
  const _$AddReactionImpl({
    required this.conversationId,
    required this.messageId,
    required this.emoji,
  });

  @override
  final String conversationId;
  @override
  final String messageId;
  @override
  final String emoji;

  @override
  String toString() {
    return 'ConversationEvent.addReaction(conversationId: $conversationId, messageId: $messageId, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddReactionImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, messageId, emoji);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddReactionImplCopyWith<_$AddReactionImpl> get copyWith =>
      __$$AddReactionImplCopyWithImpl<_$AddReactionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return addReaction(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return addReaction?.call(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (addReaction != null) {
      return addReaction(conversationId, messageId, emoji);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return addReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return addReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (addReaction != null) {
      return addReaction(this);
    }
    return orElse();
  }
}

abstract class _AddReaction implements ConversationEvent {
  const factory _AddReaction({
    required final String conversationId,
    required final String messageId,
    required final String emoji,
  }) = _$AddReactionImpl;

  String get conversationId;
  String get messageId;
  String get emoji;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddReactionImplCopyWith<_$AddReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveReactionImplCopyWith<$Res> {
  factory _$$RemoveReactionImplCopyWith(
    _$RemoveReactionImpl value,
    $Res Function(_$RemoveReactionImpl) then,
  ) = __$$RemoveReactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String messageId, String emoji});
}

/// @nodoc
class __$$RemoveReactionImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$RemoveReactionImpl>
    implements _$$RemoveReactionImplCopyWith<$Res> {
  __$$RemoveReactionImplCopyWithImpl(
    _$RemoveReactionImpl _value,
    $Res Function(_$RemoveReactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? messageId = null,
    Object? emoji = null,
  }) {
    return _then(
      _$RemoveReactionImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveReactionImpl implements _RemoveReaction {
  const _$RemoveReactionImpl({
    required this.conversationId,
    required this.messageId,
    required this.emoji,
  });

  @override
  final String conversationId;
  @override
  final String messageId;
  @override
  final String emoji;

  @override
  String toString() {
    return 'ConversationEvent.removeReaction(conversationId: $conversationId, messageId: $messageId, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveReactionImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, messageId, emoji);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveReactionImplCopyWith<_$RemoveReactionImpl> get copyWith =>
      __$$RemoveReactionImplCopyWithImpl<_$RemoveReactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return removeReaction(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return removeReaction?.call(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (removeReaction != null) {
      return removeReaction(conversationId, messageId, emoji);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return removeReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return removeReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (removeReaction != null) {
      return removeReaction(this);
    }
    return orElse();
  }
}

abstract class _RemoveReaction implements ConversationEvent {
  const factory _RemoveReaction({
    required final String conversationId,
    required final String messageId,
    required final String emoji,
  }) = _$RemoveReactionImpl;

  String get conversationId;
  String get messageId;
  String get emoji;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveReactionImplCopyWith<_$RemoveReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnreadCountUpdatedImplCopyWith<$Res> {
  factory _$$UnreadCountUpdatedImplCopyWith(
    _$UnreadCountUpdatedImpl value,
    $Res Function(_$UnreadCountUpdatedImpl) then,
  ) = __$$UnreadCountUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int count});
}

/// @nodoc
class __$$UnreadCountUpdatedImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$UnreadCountUpdatedImpl>
    implements _$$UnreadCountUpdatedImplCopyWith<$Res> {
  __$$UnreadCountUpdatedImplCopyWithImpl(
    _$UnreadCountUpdatedImpl _value,
    $Res Function(_$UnreadCountUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? count = null}) {
    return _then(
      _$UnreadCountUpdatedImpl(
        null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$UnreadCountUpdatedImpl implements _UnreadCountUpdated {
  const _$UnreadCountUpdatedImpl(this.count);

  @override
  final int count;

  @override
  String toString() {
    return 'ConversationEvent.unreadCountUpdated(count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnreadCountUpdatedImpl &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnreadCountUpdatedImplCopyWith<_$UnreadCountUpdatedImpl> get copyWith =>
      __$$UnreadCountUpdatedImplCopyWithImpl<_$UnreadCountUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return unreadCountUpdated(count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return unreadCountUpdated?.call(count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (unreadCountUpdated != null) {
      return unreadCountUpdated(count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return unreadCountUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return unreadCountUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (unreadCountUpdated != null) {
      return unreadCountUpdated(this);
    }
    return orElse();
  }
}

abstract class _UnreadCountUpdated implements ConversationEvent {
  const factory _UnreadCountUpdated(final int count) = _$UnreadCountUpdatedImpl;

  int get count;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnreadCountUpdatedImplCopyWith<_$UnreadCountUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteMessageForEveryoneImplCopyWith<$Res> {
  factory _$$DeleteMessageForEveryoneImplCopyWith(
    _$DeleteMessageForEveryoneImpl value,
    $Res Function(_$DeleteMessageForEveryoneImpl) then,
  ) = __$$DeleteMessageForEveryoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String messageId});
}

/// @nodoc
class __$$DeleteMessageForEveryoneImplCopyWithImpl<$Res>
    extends
        _$ConversationEventCopyWithImpl<$Res, _$DeleteMessageForEveryoneImpl>
    implements _$$DeleteMessageForEveryoneImplCopyWith<$Res> {
  __$$DeleteMessageForEveryoneImplCopyWithImpl(
    _$DeleteMessageForEveryoneImpl _value,
    $Res Function(_$DeleteMessageForEveryoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? messageId = null}) {
    return _then(
      _$DeleteMessageForEveryoneImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteMessageForEveryoneImpl implements _DeleteMessageForEveryone {
  const _$DeleteMessageForEveryoneImpl({
    required this.conversationId,
    required this.messageId,
  });

  @override
  final String conversationId;
  @override
  final String messageId;

  @override
  String toString() {
    return 'ConversationEvent.deleteMessageForEveryone(conversationId: $conversationId, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteMessageForEveryoneImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, messageId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteMessageForEveryoneImplCopyWith<_$DeleteMessageForEveryoneImpl>
  get copyWith =>
      __$$DeleteMessageForEveryoneImplCopyWithImpl<
        _$DeleteMessageForEveryoneImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return deleteMessageForEveryone(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return deleteMessageForEveryone?.call(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (deleteMessageForEveryone != null) {
      return deleteMessageForEveryone(conversationId, messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return deleteMessageForEveryone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return deleteMessageForEveryone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (deleteMessageForEveryone != null) {
      return deleteMessageForEveryone(this);
    }
    return orElse();
  }
}

abstract class _DeleteMessageForEveryone implements ConversationEvent {
  const factory _DeleteMessageForEveryone({
    required final String conversationId,
    required final String messageId,
  }) = _$DeleteMessageForEveryoneImpl;

  String get conversationId;
  String get messageId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteMessageForEveryoneImplCopyWith<_$DeleteMessageForEveryoneImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearChatImplCopyWith<$Res> {
  factory _$$ClearChatImplCopyWith(
    _$ClearChatImpl value,
    $Res Function(_$ClearChatImpl) then,
  ) = __$$ClearChatImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId});
}

/// @nodoc
class __$$ClearChatImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ClearChatImpl>
    implements _$$ClearChatImplCopyWith<$Res> {
  __$$ClearChatImplCopyWithImpl(
    _$ClearChatImpl _value,
    $Res Function(_$ClearChatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null}) {
    return _then(
      _$ClearChatImpl(
        null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ClearChatImpl implements _ClearChat {
  const _$ClearChatImpl(this.conversationId);

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationEvent.clearChat(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClearChatImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClearChatImplCopyWith<_$ClearChatImpl> get copyWith =>
      __$$ClearChatImplCopyWithImpl<_$ClearChatImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return clearChat(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return clearChat?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearChat != null) {
      return clearChat(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearChat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearChat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearChat != null) {
      return clearChat(this);
    }
    return orElse();
  }
}

abstract class _ClearChat implements ConversationEvent {
  const factory _ClearChat(final String conversationId) = _$ClearChatImpl;

  String get conversationId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClearChatImplCopyWith<_$ClearChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RetryMessageImplCopyWith<$Res> {
  factory _$$RetryMessageImplCopyWith(
    _$RetryMessageImpl value,
    $Res Function(_$RetryMessageImpl) then,
  ) = __$$RetryMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String messageId});
}

/// @nodoc
class __$$RetryMessageImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$RetryMessageImpl>
    implements _$$RetryMessageImplCopyWith<$Res> {
  __$$RetryMessageImplCopyWithImpl(
    _$RetryMessageImpl _value,
    $Res Function(_$RetryMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? messageId = null}) {
    return _then(
      _$RetryMessageImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RetryMessageImpl implements _RetryMessage {
  const _$RetryMessageImpl({
    required this.conversationId,
    required this.messageId,
  });

  @override
  final String conversationId;
  @override
  final String messageId;

  @override
  String toString() {
    return 'ConversationEvent.retryMessage(conversationId: $conversationId, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RetryMessageImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, messageId);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RetryMessageImplCopyWith<_$RetryMessageImpl> get copyWith =>
      __$$RetryMessageImplCopyWithImpl<_$RetryMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return retryMessage(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return retryMessage?.call(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (retryMessage != null) {
      return retryMessage(conversationId, messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return retryMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return retryMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (retryMessage != null) {
      return retryMessage(this);
    }
    return orElse();
  }
}

abstract class _RetryMessage implements ConversationEvent {
  const factory _RetryMessage({
    required final String conversationId,
    required final String messageId,
  }) = _$RetryMessageImpl;

  String get conversationId;
  String get messageId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RetryMessageImplCopyWith<_$RetryMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchUsersImplCopyWith<$Res> {
  factory _$$SearchUsersImplCopyWith(
    _$SearchUsersImpl value,
    $Res Function(_$SearchUsersImpl) then,
  ) = __$$SearchUsersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchUsersImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SearchUsersImpl>
    implements _$$SearchUsersImplCopyWith<$Res> {
  __$$SearchUsersImplCopyWithImpl(
    _$SearchUsersImpl _value,
    $Res Function(_$SearchUsersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchUsersImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchUsersImpl implements _SearchUsers {
  const _$SearchUsersImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ConversationEvent.searchUsers(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchUsersImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchUsersImplCopyWith<_$SearchUsersImpl> get copyWith =>
      __$$SearchUsersImplCopyWithImpl<_$SearchUsersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return searchUsers(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return searchUsers?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (searchUsers != null) {
      return searchUsers(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return searchUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return searchUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (searchUsers != null) {
      return searchUsers(this);
    }
    return orElse();
  }
}

abstract class _SearchUsers implements ConversationEvent {
  const factory _SearchUsers(final String query) = _$SearchUsersImpl;

  String get query;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchUsersImplCopyWith<_$SearchUsersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSearchImplCopyWith<$Res> {
  factory _$$ClearSearchImplCopyWith(
    _$ClearSearchImpl value,
    $Res Function(_$ClearSearchImpl) then,
  ) = __$$ClearSearchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ClearSearchImpl>
    implements _$$ClearSearchImplCopyWith<$Res> {
  __$$ClearSearchImplCopyWithImpl(
    _$ClearSearchImpl _value,
    $Res Function(_$ClearSearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchImpl implements _ClearSearch {
  const _$ClearSearchImpl();

  @override
  String toString() {
    return 'ConversationEvent.clearSearch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSearchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return clearSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return clearSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch(this);
    }
    return orElse();
  }
}

abstract class _ClearSearch implements ConversationEvent {
  const factory _ClearSearch() = _$ClearSearchImpl;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'ConversationEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadConversations,
    required TResult Function() watchConversations,
    required TResult Function(List<Conversation> conversations)
    conversationsUpdated,
    required TResult Function(String id) selectConversation,
    required TResult Function(String participantId) getOrCreateConversation,
    required TResult Function(
      String conversationId,
      int? limit,
      DateTime? before,
    )
    loadMessages,
    required TResult Function(String conversationId, int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )
    sendMediaMessage,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String messageId, String conversationId)
    acceptTokenRequest,
    required TResult Function(String messageId, String conversationId)
    declineTokenRequest,
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String query) searchUsers,
    required TResult Function() clearSearch,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadConversations,
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(String conversationId, int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult? Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String query)? searchUsers,
    TResult? Function()? clearSearch,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadConversations,
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(String conversationId, int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      String mediaUrl,
      String mediaType,
      String? caption,
    )?
    sendMediaMessage,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String conversationId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String messageId, String conversationId)?
    acceptTokenRequest,
    TResult Function(String messageId, String conversationId)?
    declineTokenRequest,
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String query)? searchUsers,
    TResult Function()? clearSearch,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadConversations value) loadConversations,
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_ClearSearch value) clearSearch,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadConversations value)? loadConversations,
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_ClearSearch value)? clearSearch,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadConversations value)? loadConversations,
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_ClearSearch value)? clearSearch,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements ConversationEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
mixin _$ConversationState {
  ConversationStatus get status => throw _privateConstructorUsedError;
  List<Conversation> get conversations => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  Conversation? get selectedConversation => throw _privateConstructorUsedError;
  bool get isLoadingMessages => throw _privateConstructorUsedError;
  bool get hasLoadedMessages => throw _privateConstructorUsedError;
  bool get hasMoreMessages => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  bool get isClearingChat => throw _privateConstructorUsedError;
  int get totalUnreadCount => throw _privateConstructorUsedError;
  List<UserSearchResult> get searchResults =>
      throw _privateConstructorUsedError;
  bool get isSearching => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ConversationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationStateCopyWith<ConversationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationStateCopyWith<$Res> {
  factory $ConversationStateCopyWith(
    ConversationState value,
    $Res Function(ConversationState) then,
  ) = _$ConversationStateCopyWithImpl<$Res, ConversationState>;
  @useResult
  $Res call({
    ConversationStatus status,
    List<Conversation> conversations,
    List<Message> messages,
    Conversation? selectedConversation,
    bool isLoadingMessages,
    bool hasLoadedMessages,
    bool hasMoreMessages,
    bool isSending,
    bool isClearingChat,
    int totalUnreadCount,
    List<UserSearchResult> searchResults,
    bool isSearching,
    String? errorMessage,
  });

  $ConversationCopyWith<$Res>? get selectedConversation;
}

/// @nodoc
class _$ConversationStateCopyWithImpl<$Res, $Val extends ConversationState>
    implements $ConversationStateCopyWith<$Res> {
  _$ConversationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conversations = null,
    Object? messages = null,
    Object? selectedConversation = freezed,
    Object? isLoadingMessages = null,
    Object? hasLoadedMessages = null,
    Object? hasMoreMessages = null,
    Object? isSending = null,
    Object? isClearingChat = null,
    Object? totalUnreadCount = null,
    Object? searchResults = null,
    Object? isSearching = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ConversationStatus,
            conversations: null == conversations
                ? _value.conversations
                : conversations // ignore: cast_nullable_to_non_nullable
                      as List<Conversation>,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<Message>,
            selectedConversation: freezed == selectedConversation
                ? _value.selectedConversation
                : selectedConversation // ignore: cast_nullable_to_non_nullable
                      as Conversation?,
            isLoadingMessages: null == isLoadingMessages
                ? _value.isLoadingMessages
                : isLoadingMessages // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasLoadedMessages: null == hasLoadedMessages
                ? _value.hasLoadedMessages
                : hasLoadedMessages // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreMessages: null == hasMoreMessages
                ? _value.hasMoreMessages
                : hasMoreMessages // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            isClearingChat: null == isClearingChat
                ? _value.isClearingChat
                : isClearingChat // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalUnreadCount: null == totalUnreadCount
                ? _value.totalUnreadCount
                : totalUnreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            searchResults: null == searchResults
                ? _value.searchResults
                : searchResults // ignore: cast_nullable_to_non_nullable
                      as List<UserSearchResult>,
            isSearching: null == isSearching
                ? _value.isSearching
                : isSearching // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ConversationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<$Res>? get selectedConversation {
    if (_value.selectedConversation == null) {
      return null;
    }

    return $ConversationCopyWith<$Res>(_value.selectedConversation!, (value) {
      return _then(_value.copyWith(selectedConversation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationStateImplCopyWith<$Res>
    implements $ConversationStateCopyWith<$Res> {
  factory _$$ConversationStateImplCopyWith(
    _$ConversationStateImpl value,
    $Res Function(_$ConversationStateImpl) then,
  ) = __$$ConversationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ConversationStatus status,
    List<Conversation> conversations,
    List<Message> messages,
    Conversation? selectedConversation,
    bool isLoadingMessages,
    bool hasLoadedMessages,
    bool hasMoreMessages,
    bool isSending,
    bool isClearingChat,
    int totalUnreadCount,
    List<UserSearchResult> searchResults,
    bool isSearching,
    String? errorMessage,
  });

  @override
  $ConversationCopyWith<$Res>? get selectedConversation;
}

/// @nodoc
class __$$ConversationStateImplCopyWithImpl<$Res>
    extends _$ConversationStateCopyWithImpl<$Res, _$ConversationStateImpl>
    implements _$$ConversationStateImplCopyWith<$Res> {
  __$$ConversationStateImplCopyWithImpl(
    _$ConversationStateImpl _value,
    $Res Function(_$ConversationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conversations = null,
    Object? messages = null,
    Object? selectedConversation = freezed,
    Object? isLoadingMessages = null,
    Object? hasLoadedMessages = null,
    Object? hasMoreMessages = null,
    Object? isSending = null,
    Object? isClearingChat = null,
    Object? totalUnreadCount = null,
    Object? searchResults = null,
    Object? isSearching = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ConversationStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ConversationStatus,
        conversations: null == conversations
            ? _value._conversations
            : conversations // ignore: cast_nullable_to_non_nullable
                  as List<Conversation>,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
        selectedConversation: freezed == selectedConversation
            ? _value.selectedConversation
            : selectedConversation // ignore: cast_nullable_to_non_nullable
                  as Conversation?,
        isLoadingMessages: null == isLoadingMessages
            ? _value.isLoadingMessages
            : isLoadingMessages // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasLoadedMessages: null == hasLoadedMessages
            ? _value.hasLoadedMessages
            : hasLoadedMessages // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreMessages: null == hasMoreMessages
            ? _value.hasMoreMessages
            : hasMoreMessages // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        isClearingChat: null == isClearingChat
            ? _value.isClearingChat
            : isClearingChat // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalUnreadCount: null == totalUnreadCount
            ? _value.totalUnreadCount
            : totalUnreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        searchResults: null == searchResults
            ? _value._searchResults
            : searchResults // ignore: cast_nullable_to_non_nullable
                  as List<UserSearchResult>,
        isSearching: null == isSearching
            ? _value.isSearching
            : isSearching // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ConversationStateImpl extends _ConversationState {
  const _$ConversationStateImpl({
    this.status = ConversationStatus.initial,
    final List<Conversation> conversations = const [],
    final List<Message> messages = const [],
    this.selectedConversation,
    this.isLoadingMessages = false,
    this.hasLoadedMessages = false,
    this.hasMoreMessages = false,
    this.isSending = false,
    this.isClearingChat = false,
    this.totalUnreadCount = 0,
    final List<UserSearchResult> searchResults = const [],
    this.isSearching = false,
    this.errorMessage,
  }) : _conversations = conversations,
       _messages = messages,
       _searchResults = searchResults,
       super._();

  @override
  @JsonKey()
  final ConversationStatus status;
  final List<Conversation> _conversations;
  @override
  @JsonKey()
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final Conversation? selectedConversation;
  @override
  @JsonKey()
  final bool isLoadingMessages;
  @override
  @JsonKey()
  final bool hasLoadedMessages;
  @override
  @JsonKey()
  final bool hasMoreMessages;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool isClearingChat;
  @override
  @JsonKey()
  final int totalUnreadCount;
  final List<UserSearchResult> _searchResults;
  @override
  @JsonKey()
  List<UserSearchResult> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  @JsonKey()
  final bool isSearching;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ConversationState(status: $status, conversations: $conversations, messages: $messages, selectedConversation: $selectedConversation, isLoadingMessages: $isLoadingMessages, hasLoadedMessages: $hasLoadedMessages, hasMoreMessages: $hasMoreMessages, isSending: $isSending, isClearingChat: $isClearingChat, totalUnreadCount: $totalUnreadCount, searchResults: $searchResults, isSearching: $isSearching, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.selectedConversation, selectedConversation) ||
                other.selectedConversation == selectedConversation) &&
            (identical(other.isLoadingMessages, isLoadingMessages) ||
                other.isLoadingMessages == isLoadingMessages) &&
            (identical(other.hasLoadedMessages, hasLoadedMessages) ||
                other.hasLoadedMessages == hasLoadedMessages) &&
            (identical(other.hasMoreMessages, hasMoreMessages) ||
                other.hasMoreMessages == hasMoreMessages) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isClearingChat, isClearingChat) ||
                other.isClearingChat == isClearingChat) &&
            (identical(other.totalUnreadCount, totalUnreadCount) ||
                other.totalUnreadCount == totalUnreadCount) &&
            const DeepCollectionEquality().equals(
              other._searchResults,
              _searchResults,
            ) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_conversations),
    const DeepCollectionEquality().hash(_messages),
    selectedConversation,
    isLoadingMessages,
    hasLoadedMessages,
    hasMoreMessages,
    isSending,
    isClearingChat,
    totalUnreadCount,
    const DeepCollectionEquality().hash(_searchResults),
    isSearching,
    errorMessage,
  );

  /// Create a copy of ConversationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationStateImplCopyWith<_$ConversationStateImpl> get copyWith =>
      __$$ConversationStateImplCopyWithImpl<_$ConversationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ConversationState extends ConversationState {
  const factory _ConversationState({
    final ConversationStatus status,
    final List<Conversation> conversations,
    final List<Message> messages,
    final Conversation? selectedConversation,
    final bool isLoadingMessages,
    final bool hasLoadedMessages,
    final bool hasMoreMessages,
    final bool isSending,
    final bool isClearingChat,
    final int totalUnreadCount,
    final List<UserSearchResult> searchResults,
    final bool isSearching,
    final String? errorMessage,
  }) = _$ConversationStateImpl;
  const _ConversationState._() : super._();

  @override
  ConversationStatus get status;
  @override
  List<Conversation> get conversations;
  @override
  List<Message> get messages;
  @override
  Conversation? get selectedConversation;
  @override
  bool get isLoadingMessages;
  @override
  bool get hasLoadedMessages;
  @override
  bool get hasMoreMessages;
  @override
  bool get isSending;
  @override
  bool get isClearingChat;
  @override
  int get totalUnreadCount;
  @override
  List<UserSearchResult> get searchResults;
  @override
  bool get isSearching;
  @override
  String? get errorMessage;

  /// Create a copy of ConversationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationStateImplCopyWith<_$ConversationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
