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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return watchConversations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return watchConversations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchConversations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchConversations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return conversationsUpdated(conversations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return conversationsUpdated?.call(conversations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return conversationsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return conversationsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return selectConversation(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return selectConversation?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return selectConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return selectConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return getOrCreateConversation(participantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return getOrCreateConversation?.call(participantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return getOrCreateConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return getOrCreateConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return loadMessages(conversationId, limit, before);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return loadMessages?.call(conversationId, limit, before);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return messagesUpdated(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return messagesUpdated?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return messagesUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return messagesUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return sendTextMessage(conversationId, text, replyToMessageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return sendTextMessage?.call(conversationId, text, replyToMessageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendTextMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendTextMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    File mediaFile,
    String mediaType,
    String recipientId,
    String? caption,
    int? durationSeconds,
    String? replyToMessageId,
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
    Object? mediaFile = null,
    Object? mediaType = null,
    Object? recipientId = null,
    Object? caption = freezed,
    Object? durationSeconds = freezed,
    Object? replyToMessageId = freezed,
  }) {
    return _then(
      _$SendMediaMessageImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaFile: null == mediaFile
            ? _value.mediaFile
            : mediaFile // ignore: cast_nullable_to_non_nullable
                  as File,
        mediaType: null == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationSeconds: freezed == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        replyToMessageId: freezed == replyToMessageId
            ? _value.replyToMessageId
            : replyToMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendMediaMessageImpl implements _SendMediaMessage {
  const _$SendMediaMessageImpl({
    required this.conversationId,
    required this.mediaFile,
    required this.mediaType,
    required this.recipientId,
    this.caption,
    this.durationSeconds,
    this.replyToMessageId,
  });

  @override
  final String conversationId;
  @override
  final File mediaFile;
  @override
  final String mediaType;
  @override
  final String recipientId;
  @override
  final String? caption;
  @override
  final int? durationSeconds;
  @override
  final String? replyToMessageId;

  @override
  String toString() {
    return 'ConversationEvent.sendMediaMessage(conversationId: $conversationId, mediaFile: $mediaFile, mediaType: $mediaType, recipientId: $recipientId, caption: $caption, durationSeconds: $durationSeconds, replyToMessageId: $replyToMessageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMediaMessageImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.mediaFile, mediaFile) ||
                other.mediaFile == mediaFile) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    conversationId,
    mediaFile,
    mediaType,
    recipientId,
    caption,
    durationSeconds,
    replyToMessageId,
  );

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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return sendMediaMessage(
      conversationId,
      mediaFile,
      mediaType,
      recipientId,
      caption,
      durationSeconds,
      replyToMessageId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return sendMediaMessage?.call(
      conversationId,
      mediaFile,
      mediaType,
      recipientId,
      caption,
      durationSeconds,
      replyToMessageId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (sendMediaMessage != null) {
      return sendMediaMessage(
        conversationId,
        mediaFile,
        mediaType,
        recipientId,
        caption,
        durationSeconds,
        replyToMessageId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendMediaMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendMediaMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required final File mediaFile,
    required final String mediaType,
    required final String recipientId,
    final String? caption,
    final int? durationSeconds,
    final String? replyToMessageId,
  }) = _$SendMediaMessageImpl;

  String get conversationId;
  File get mediaFile;
  String get mediaType;
  String get recipientId;
  String? get caption;
  int? get durationSeconds;
  String? get replyToMessageId;

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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return sendTokens(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return sendTokens?.call(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return requestTokens(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return requestTokens?.call(conversationId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return requestTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return requestTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return acceptTokenRequest(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return acceptTokenRequest?.call(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return acceptTokenRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return acceptTokenRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return declineTokenRequest(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return declineTokenRequest?.call(messageId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return declineTokenRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return declineTokenRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
abstract class _$$AcceptConversationImplCopyWith<$Res> {
  factory _$$AcceptConversationImplCopyWith(
    _$AcceptConversationImpl value,
    $Res Function(_$AcceptConversationImpl) then,
  ) = __$$AcceptConversationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId});
}

/// @nodoc
class __$$AcceptConversationImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$AcceptConversationImpl>
    implements _$$AcceptConversationImplCopyWith<$Res> {
  __$$AcceptConversationImplCopyWithImpl(
    _$AcceptConversationImpl _value,
    $Res Function(_$AcceptConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null}) {
    return _then(
      _$AcceptConversationImpl(
        null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AcceptConversationImpl implements _AcceptConversation {
  const _$AcceptConversationImpl(this.conversationId);

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationEvent.acceptConversation(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptConversationImpl &&
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
  _$$AcceptConversationImplCopyWith<_$AcceptConversationImpl> get copyWith =>
      __$$AcceptConversationImplCopyWithImpl<_$AcceptConversationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return acceptConversation(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return acceptConversation?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (acceptConversation != null) {
      return acceptConversation(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return acceptConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return acceptConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (acceptConversation != null) {
      return acceptConversation(this);
    }
    return orElse();
  }
}

abstract class _AcceptConversation implements ConversationEvent {
  const factory _AcceptConversation(final String conversationId) =
      _$AcceptConversationImpl;

  String get conversationId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptConversationImplCopyWith<_$AcceptConversationImpl> get copyWith =>
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return unreadCountUpdated(count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return unreadCountUpdated?.call(count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return unreadCountUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return unreadCountUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return clearChat(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return clearChat?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearChat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearChat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return retryMessage(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return retryMessage?.call(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return retryMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return retryMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
abstract class _$$SetTypingImplCopyWith<$Res> {
  factory _$$SetTypingImplCopyWith(
    _$SetTypingImpl value,
    $Res Function(_$SetTypingImpl) then,
  ) = __$$SetTypingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, bool isTyping});
}

/// @nodoc
class __$$SetTypingImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SetTypingImpl>
    implements _$$SetTypingImplCopyWith<$Res> {
  __$$SetTypingImplCopyWithImpl(
    _$SetTypingImpl _value,
    $Res Function(_$SetTypingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? isTyping = null}) {
    return _then(
      _$SetTypingImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        isTyping: null == isTyping
            ? _value.isTyping
            : isTyping // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SetTypingImpl implements _SetTyping {
  const _$SetTypingImpl({required this.conversationId, required this.isTyping});

  @override
  final String conversationId;
  @override
  final bool isTyping;

  @override
  String toString() {
    return 'ConversationEvent.setTyping(conversationId: $conversationId, isTyping: $isTyping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetTypingImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, isTyping);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetTypingImplCopyWith<_$SetTypingImpl> get copyWith =>
      __$$SetTypingImplCopyWithImpl<_$SetTypingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return setTyping(conversationId, isTyping);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return setTyping?.call(conversationId, isTyping);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (setTyping != null) {
      return setTyping(conversationId, isTyping);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return setTyping(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return setTyping?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (setTyping != null) {
      return setTyping(this);
    }
    return orElse();
  }
}

abstract class _SetTyping implements ConversationEvent {
  const factory _SetTyping({
    required final String conversationId,
    required final bool isTyping,
  }) = _$SetTypingImpl;

  String get conversationId;
  bool get isTyping;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetTypingImplCopyWith<_$SetTypingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TypingStateUpdatedImplCopyWith<$Res> {
  factory _$$TypingStateUpdatedImplCopyWith(
    _$TypingStateUpdatedImpl value,
    $Res Function(_$TypingStateUpdatedImpl) then,
  ) = __$$TypingStateUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, bool> typingUsers});
}

/// @nodoc
class __$$TypingStateUpdatedImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$TypingStateUpdatedImpl>
    implements _$$TypingStateUpdatedImplCopyWith<$Res> {
  __$$TypingStateUpdatedImplCopyWithImpl(
    _$TypingStateUpdatedImpl _value,
    $Res Function(_$TypingStateUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? typingUsers = null}) {
    return _then(
      _$TypingStateUpdatedImpl(
        null == typingUsers
            ? _value._typingUsers
            : typingUsers // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
      ),
    );
  }
}

/// @nodoc

class _$TypingStateUpdatedImpl implements _TypingStateUpdated {
  const _$TypingStateUpdatedImpl(final Map<String, bool> typingUsers)
    : _typingUsers = typingUsers;

  final Map<String, bool> _typingUsers;
  @override
  Map<String, bool> get typingUsers {
    if (_typingUsers is EqualUnmodifiableMapView) return _typingUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_typingUsers);
  }

  @override
  String toString() {
    return 'ConversationEvent.typingStateUpdated(typingUsers: $typingUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypingStateUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._typingUsers,
              _typingUsers,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_typingUsers),
  );

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypingStateUpdatedImplCopyWith<_$TypingStateUpdatedImpl> get copyWith =>
      __$$TypingStateUpdatedImplCopyWithImpl<_$TypingStateUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return typingStateUpdated(typingUsers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return typingStateUpdated?.call(typingUsers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (typingStateUpdated != null) {
      return typingStateUpdated(typingUsers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return typingStateUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return typingStateUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (typingStateUpdated != null) {
      return typingStateUpdated(this);
    }
    return orElse();
  }
}

abstract class _TypingStateUpdated implements ConversationEvent {
  const factory _TypingStateUpdated(final Map<String, bool> typingUsers) =
      _$TypingStateUpdatedImpl;

  Map<String, bool> get typingUsers;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypingStateUpdatedImplCopyWith<_$TypingStateUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchMessagesImplCopyWith<$Res> {
  factory _$$SearchMessagesImplCopyWith(
    _$SearchMessagesImpl value,
    $Res Function(_$SearchMessagesImpl) then,
  ) = __$$SearchMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String query});
}

/// @nodoc
class __$$SearchMessagesImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SearchMessagesImpl>
    implements _$$SearchMessagesImplCopyWith<$Res> {
  __$$SearchMessagesImplCopyWithImpl(
    _$SearchMessagesImpl _value,
    $Res Function(_$SearchMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? query = null}) {
    return _then(
      _$SearchMessagesImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchMessagesImpl implements _SearchMessages {
  const _$SearchMessagesImpl({
    required this.conversationId,
    required this.query,
  });

  @override
  final String conversationId;
  @override
  final String query;

  @override
  String toString() {
    return 'ConversationEvent.searchMessages(conversationId: $conversationId, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchMessagesImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, query);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchMessagesImplCopyWith<_$SearchMessagesImpl> get copyWith =>
      __$$SearchMessagesImplCopyWithImpl<_$SearchMessagesImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return searchMessages(conversationId, query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return searchMessages?.call(conversationId, query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (searchMessages != null) {
      return searchMessages(conversationId, query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return searchMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return searchMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (searchMessages != null) {
      return searchMessages(this);
    }
    return orElse();
  }
}

abstract class _SearchMessages implements ConversationEvent {
  const factory _SearchMessages({
    required final String conversationId,
    required final String query,
  }) = _$SearchMessagesImpl;

  String get conversationId;
  String get query;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchMessagesImplCopyWith<_$SearchMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearMessageSearchImplCopyWith<$Res> {
  factory _$$ClearMessageSearchImplCopyWith(
    _$ClearMessageSearchImpl value,
    $Res Function(_$ClearMessageSearchImpl) then,
  ) = __$$ClearMessageSearchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearMessageSearchImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ClearMessageSearchImpl>
    implements _$$ClearMessageSearchImplCopyWith<$Res> {
  __$$ClearMessageSearchImplCopyWithImpl(
    _$ClearMessageSearchImpl _value,
    $Res Function(_$ClearMessageSearchImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearMessageSearchImpl implements _ClearMessageSearch {
  const _$ClearMessageSearchImpl();

  @override
  String toString() {
    return 'ConversationEvent.clearMessageSearch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearMessageSearchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return clearMessageSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return clearMessageSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearMessageSearch != null) {
      return clearMessageSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearMessageSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearMessageSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearMessageSearch != null) {
      return clearMessageSearch(this);
    }
    return orElse();
  }
}

abstract class _ClearMessageSearch implements ConversationEvent {
  const factory _ClearMessageSearch() = _$ClearMessageSearchImpl;
}

/// @nodoc
abstract class _$$SetDisappearingMessagesImplCopyWith<$Res> {
  factory _$$SetDisappearingMessagesImplCopyWith(
    _$SetDisappearingMessagesImpl value,
    $Res Function(_$SetDisappearingMessagesImpl) then,
  ) = __$$SetDisappearingMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, Duration? duration});
}

/// @nodoc
class __$$SetDisappearingMessagesImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$SetDisappearingMessagesImpl>
    implements _$$SetDisappearingMessagesImplCopyWith<$Res> {
  __$$SetDisappearingMessagesImplCopyWithImpl(
    _$SetDisappearingMessagesImpl _value,
    $Res Function(_$SetDisappearingMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? duration = freezed}) {
    return _then(
      _$SetDisappearingMessagesImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration?,
      ),
    );
  }
}

/// @nodoc

class _$SetDisappearingMessagesImpl implements _SetDisappearingMessages {
  const _$SetDisappearingMessagesImpl({
    required this.conversationId,
    required this.duration,
  });

  @override
  final String conversationId;
  @override
  final Duration? duration;

  @override
  String toString() {
    return 'ConversationEvent.setDisappearingMessages(conversationId: $conversationId, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetDisappearingMessagesImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, duration);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetDisappearingMessagesImplCopyWith<_$SetDisappearingMessagesImpl>
  get copyWith =>
      __$$SetDisappearingMessagesImplCopyWithImpl<
        _$SetDisappearingMessagesImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return setDisappearingMessages(conversationId, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return setDisappearingMessages?.call(conversationId, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (setDisappearingMessages != null) {
      return setDisappearingMessages(conversationId, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return setDisappearingMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return setDisappearingMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (setDisappearingMessages != null) {
      return setDisappearingMessages(this);
    }
    return orElse();
  }
}

abstract class _SetDisappearingMessages implements ConversationEvent {
  const factory _SetDisappearingMessages({
    required final String conversationId,
    required final Duration? duration,
  }) = _$SetDisappearingMessagesImpl;

  String get conversationId;
  Duration? get duration;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetDisappearingMessagesImplCopyWith<_$SetDisappearingMessagesImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForwardMessageImplCopyWith<$Res> {
  factory _$$ForwardMessageImplCopyWith(
    _$ForwardMessageImpl value,
    $Res Function(_$ForwardMessageImpl) then,
  ) = __$$ForwardMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String sourceConversationId,
    String sourceMessageId,
    String targetConversationId,
  });
}

/// @nodoc
class __$$ForwardMessageImplCopyWithImpl<$Res>
    extends _$ConversationEventCopyWithImpl<$Res, _$ForwardMessageImpl>
    implements _$$ForwardMessageImplCopyWith<$Res> {
  __$$ForwardMessageImplCopyWithImpl(
    _$ForwardMessageImpl _value,
    $Res Function(_$ForwardMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceConversationId = null,
    Object? sourceMessageId = null,
    Object? targetConversationId = null,
  }) {
    return _then(
      _$ForwardMessageImpl(
        sourceConversationId: null == sourceConversationId
            ? _value.sourceConversationId
            : sourceConversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceMessageId: null == sourceMessageId
            ? _value.sourceMessageId
            : sourceMessageId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetConversationId: null == targetConversationId
            ? _value.targetConversationId
            : targetConversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ForwardMessageImpl implements _ForwardMessage {
  const _$ForwardMessageImpl({
    required this.sourceConversationId,
    required this.sourceMessageId,
    required this.targetConversationId,
  });

  @override
  final String sourceConversationId;
  @override
  final String sourceMessageId;
  @override
  final String targetConversationId;

  @override
  String toString() {
    return 'ConversationEvent.forwardMessage(sourceConversationId: $sourceConversationId, sourceMessageId: $sourceMessageId, targetConversationId: $targetConversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForwardMessageImpl &&
            (identical(other.sourceConversationId, sourceConversationId) ||
                other.sourceConversationId == sourceConversationId) &&
            (identical(other.sourceMessageId, sourceMessageId) ||
                other.sourceMessageId == sourceMessageId) &&
            (identical(other.targetConversationId, targetConversationId) ||
                other.targetConversationId == targetConversationId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sourceConversationId,
    sourceMessageId,
    targetConversationId,
  );

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForwardMessageImplCopyWith<_$ForwardMessageImpl> get copyWith =>
      __$$ForwardMessageImplCopyWithImpl<_$ForwardMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return forwardMessage(
      sourceConversationId,
      sourceMessageId,
      targetConversationId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return forwardMessage?.call(
      sourceConversationId,
      sourceMessageId,
      targetConversationId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (forwardMessage != null) {
      return forwardMessage(
        sourceConversationId,
        sourceMessageId,
        targetConversationId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return forwardMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return forwardMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (forwardMessage != null) {
      return forwardMessage(this);
    }
    return orElse();
  }
}

abstract class _ForwardMessage implements ConversationEvent {
  const factory _ForwardMessage({
    required final String sourceConversationId,
    required final String sourceMessageId,
    required final String targetConversationId,
  }) = _$ForwardMessageImpl;

  String get sourceConversationId;
  String get sourceMessageId;
  String get targetConversationId;

  /// Create a copy of ConversationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForwardMessageImplCopyWith<_$ForwardMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )
    sendTextMessage,
    required TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    required TResult Function(String conversationId) acceptConversation,
    required TResult Function(int count) unreadCountUpdated,
    required TResult Function(String conversationId) clearChat,
    required TResult Function(String conversationId, String messageId)
    retryMessage,
    required TResult Function(String conversationId, bool isTyping) setTyping,
    required TResult Function(Map<String, bool> typingUsers) typingStateUpdated,
    required TResult Function(String conversationId, String query)
    searchMessages,
    required TResult Function() clearMessageSearch,
    required TResult Function(String conversationId, Duration? duration)
    setDisappearingMessages,
    required TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )
    forwardMessage,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? watchConversations,
    TResult? Function(List<Conversation> conversations)? conversationsUpdated,
    TResult? Function(String id)? selectConversation,
    TResult? Function(String participantId)? getOrCreateConversation,
    TResult? Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult? Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult? Function(String conversationId)? acceptConversation,
    TResult? Function(int count)? unreadCountUpdated,
    TResult? Function(String conversationId)? clearChat,
    TResult? Function(String conversationId, String messageId)? retryMessage,
    TResult? Function(String conversationId, bool isTyping)? setTyping,
    TResult? Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult? Function(String conversationId, String query)? searchMessages,
    TResult? Function()? clearMessageSearch,
    TResult? Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult? Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchConversations,
    TResult Function(List<Conversation> conversations)? conversationsUpdated,
    TResult Function(String id)? selectConversation,
    TResult Function(String participantId)? getOrCreateConversation,
    TResult Function(String conversationId, int? limit, DateTime? before)?
    loadMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(
      String conversationId,
      String text,
      String? replyToMessageId,
    )?
    sendTextMessage,
    TResult Function(
      String conversationId,
      File mediaFile,
      String mediaType,
      String recipientId,
      String? caption,
      int? durationSeconds,
      String? replyToMessageId,
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
    TResult Function(String conversationId)? acceptConversation,
    TResult Function(int count)? unreadCountUpdated,
    TResult Function(String conversationId)? clearChat,
    TResult Function(String conversationId, String messageId)? retryMessage,
    TResult Function(String conversationId, bool isTyping)? setTyping,
    TResult Function(Map<String, bool> typingUsers)? typingStateUpdated,
    TResult Function(String conversationId, String query)? searchMessages,
    TResult Function()? clearMessageSearch,
    TResult Function(String conversationId, Duration? duration)?
    setDisappearingMessages,
    TResult Function(
      String sourceConversationId,
      String sourceMessageId,
      String targetConversationId,
    )?
    forwardMessage,
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
    required TResult Function(_WatchConversations value) watchConversations,
    required TResult Function(_ConversationsUpdated value) conversationsUpdated,
    required TResult Function(_SelectConversation value) selectConversation,
    required TResult Function(_GetOrCreateConversation value)
    getOrCreateConversation,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_AcceptConversation value) acceptConversation,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
    required TResult Function(_ClearChat value) clearChat,
    required TResult Function(_RetryMessage value) retryMessage,
    required TResult Function(_SetTyping value) setTyping,
    required TResult Function(_TypingStateUpdated value) typingStateUpdated,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_ClearMessageSearch value) clearMessageSearch,
    required TResult Function(_SetDisappearingMessages value)
    setDisappearingMessages,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_WatchConversations value)? watchConversations,
    TResult? Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult? Function(_SelectConversation value)? selectConversation,
    TResult? Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_AcceptConversation value)? acceptConversation,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult? Function(_ClearChat value)? clearChat,
    TResult? Function(_RetryMessage value)? retryMessage,
    TResult? Function(_SetTyping value)? setTyping,
    TResult? Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult? Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchConversations value)? watchConversations,
    TResult Function(_ConversationsUpdated value)? conversationsUpdated,
    TResult Function(_SelectConversation value)? selectConversation,
    TResult Function(_GetOrCreateConversation value)? getOrCreateConversation,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_AcceptConversation value)? acceptConversation,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    TResult Function(_ClearChat value)? clearChat,
    TResult Function(_RetryMessage value)? retryMessage,
    TResult Function(_SetTyping value)? setTyping,
    TResult Function(_TypingStateUpdated value)? typingStateUpdated,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_ClearMessageSearch value)? clearMessageSearch,
    TResult Function(_SetDisappearingMessages value)? setDisappearingMessages,
    TResult Function(_ForwardMessage value)? forwardMessage,
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
  int get messageRequestCount => throw _privateConstructorUsedError;
  String? get errorMessage =>
      throw _privateConstructorUsedError; // Typing indicators
  Map<String, bool> get typingUsers =>
      throw _privateConstructorUsedError; // Message search
  List<Message> get messageSearchResults => throw _privateConstructorUsedError;
  bool get isSearchingMessages => throw _privateConstructorUsedError;
  String? get messageSearchQuery =>
      throw _privateConstructorUsedError; // Message forwarding
  bool get isForwarding => throw _privateConstructorUsedError;

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
    int messageRequestCount,
    String? errorMessage,
    Map<String, bool> typingUsers,
    List<Message> messageSearchResults,
    bool isSearchingMessages,
    String? messageSearchQuery,
    bool isForwarding,
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
    Object? messageRequestCount = null,
    Object? errorMessage = freezed,
    Object? typingUsers = null,
    Object? messageSearchResults = null,
    Object? isSearchingMessages = null,
    Object? messageSearchQuery = freezed,
    Object? isForwarding = null,
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
            messageRequestCount: null == messageRequestCount
                ? _value.messageRequestCount
                : messageRequestCount // ignore: cast_nullable_to_non_nullable
                      as int,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            typingUsers: null == typingUsers
                ? _value.typingUsers
                : typingUsers // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            messageSearchResults: null == messageSearchResults
                ? _value.messageSearchResults
                : messageSearchResults // ignore: cast_nullable_to_non_nullable
                      as List<Message>,
            isSearchingMessages: null == isSearchingMessages
                ? _value.isSearchingMessages
                : isSearchingMessages // ignore: cast_nullable_to_non_nullable
                      as bool,
            messageSearchQuery: freezed == messageSearchQuery
                ? _value.messageSearchQuery
                : messageSearchQuery // ignore: cast_nullable_to_non_nullable
                      as String?,
            isForwarding: null == isForwarding
                ? _value.isForwarding
                : isForwarding // ignore: cast_nullable_to_non_nullable
                      as bool,
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
    int messageRequestCount,
    String? errorMessage,
    Map<String, bool> typingUsers,
    List<Message> messageSearchResults,
    bool isSearchingMessages,
    String? messageSearchQuery,
    bool isForwarding,
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
    Object? messageRequestCount = null,
    Object? errorMessage = freezed,
    Object? typingUsers = null,
    Object? messageSearchResults = null,
    Object? isSearchingMessages = null,
    Object? messageSearchQuery = freezed,
    Object? isForwarding = null,
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
        messageRequestCount: null == messageRequestCount
            ? _value.messageRequestCount
            : messageRequestCount // ignore: cast_nullable_to_non_nullable
                  as int,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        typingUsers: null == typingUsers
            ? _value._typingUsers
            : typingUsers // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        messageSearchResults: null == messageSearchResults
            ? _value._messageSearchResults
            : messageSearchResults // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
        isSearchingMessages: null == isSearchingMessages
            ? _value.isSearchingMessages
            : isSearchingMessages // ignore: cast_nullable_to_non_nullable
                  as bool,
        messageSearchQuery: freezed == messageSearchQuery
            ? _value.messageSearchQuery
            : messageSearchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
        isForwarding: null == isForwarding
            ? _value.isForwarding
            : isForwarding // ignore: cast_nullable_to_non_nullable
                  as bool,
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
    this.messageRequestCount = 0,
    this.errorMessage,
    final Map<String, bool> typingUsers = const {},
    final List<Message> messageSearchResults = const [],
    this.isSearchingMessages = false,
    this.messageSearchQuery,
    this.isForwarding = false,
  }) : _conversations = conversations,
       _messages = messages,
       _typingUsers = typingUsers,
       _messageSearchResults = messageSearchResults,
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
  @override
  @JsonKey()
  final int messageRequestCount;
  @override
  final String? errorMessage;
  // Typing indicators
  final Map<String, bool> _typingUsers;
  // Typing indicators
  @override
  @JsonKey()
  Map<String, bool> get typingUsers {
    if (_typingUsers is EqualUnmodifiableMapView) return _typingUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_typingUsers);
  }

  // Message search
  final List<Message> _messageSearchResults;
  // Message search
  @override
  @JsonKey()
  List<Message> get messageSearchResults {
    if (_messageSearchResults is EqualUnmodifiableListView)
      return _messageSearchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messageSearchResults);
  }

  @override
  @JsonKey()
  final bool isSearchingMessages;
  @override
  final String? messageSearchQuery;
  // Message forwarding
  @override
  @JsonKey()
  final bool isForwarding;

  @override
  String toString() {
    return 'ConversationState(status: $status, conversations: $conversations, messages: $messages, selectedConversation: $selectedConversation, isLoadingMessages: $isLoadingMessages, hasLoadedMessages: $hasLoadedMessages, hasMoreMessages: $hasMoreMessages, isSending: $isSending, isClearingChat: $isClearingChat, totalUnreadCount: $totalUnreadCount, messageRequestCount: $messageRequestCount, errorMessage: $errorMessage, typingUsers: $typingUsers, messageSearchResults: $messageSearchResults, isSearchingMessages: $isSearchingMessages, messageSearchQuery: $messageSearchQuery, isForwarding: $isForwarding)';
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
            (identical(other.messageRequestCount, messageRequestCount) ||
                other.messageRequestCount == messageRequestCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._typingUsers,
              _typingUsers,
            ) &&
            const DeepCollectionEquality().equals(
              other._messageSearchResults,
              _messageSearchResults,
            ) &&
            (identical(other.isSearchingMessages, isSearchingMessages) ||
                other.isSearchingMessages == isSearchingMessages) &&
            (identical(other.messageSearchQuery, messageSearchQuery) ||
                other.messageSearchQuery == messageSearchQuery) &&
            (identical(other.isForwarding, isForwarding) ||
                other.isForwarding == isForwarding));
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
    messageRequestCount,
    errorMessage,
    const DeepCollectionEquality().hash(_typingUsers),
    const DeepCollectionEquality().hash(_messageSearchResults),
    isSearchingMessages,
    messageSearchQuery,
    isForwarding,
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
    final int messageRequestCount,
    final String? errorMessage,
    final Map<String, bool> typingUsers,
    final List<Message> messageSearchResults,
    final bool isSearchingMessages,
    final String? messageSearchQuery,
    final bool isForwarding,
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
  int get messageRequestCount;
  @override
  String? get errorMessage; // Typing indicators
  @override
  Map<String, bool> get typingUsers; // Message search
  @override
  List<Message> get messageSearchResults;
  @override
  bool get isSearchingMessages;
  @override
  String? get messageSearchQuery; // Message forwarding
  @override
  bool get isForwarding;

  /// Create a copy of ConversationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationStateImplCopyWith<_$ConversationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
