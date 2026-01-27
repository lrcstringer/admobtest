// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventCopyWith<$Res> {
  factory $ChatEventCopyWith(ChatEvent value, $Res Function(ChatEvent) then) =
      _$ChatEventCopyWithImpl<$Res, ChatEvent>;
}

/// @nodoc
class _$ChatEventCopyWithImpl<$Res, $Val extends ChatEvent>
    implements $ChatEventCopyWith<$Res> {
  _$ChatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadThreadsImplCopyWith<$Res> {
  factory _$$LoadThreadsImplCopyWith(
    _$LoadThreadsImpl value,
    $Res Function(_$LoadThreadsImpl) then,
  ) = __$$LoadThreadsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadThreadsImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$LoadThreadsImpl>
    implements _$$LoadThreadsImplCopyWith<$Res> {
  __$$LoadThreadsImplCopyWithImpl(
    _$LoadThreadsImpl _value,
    $Res Function(_$LoadThreadsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadThreadsImpl implements _LoadThreads {
  const _$LoadThreadsImpl();

  @override
  String toString() {
    return 'ChatEvent.loadThreads()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadThreadsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return loadThreads();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return loadThreads?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (loadThreads != null) {
      return loadThreads();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return loadThreads(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return loadThreads?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (loadThreads != null) {
      return loadThreads(this);
    }
    return orElse();
  }
}

abstract class _LoadThreads implements ChatEvent {
  const factory _LoadThreads() = _$LoadThreadsImpl;
}

/// @nodoc
abstract class _$$WatchThreadsImplCopyWith<$Res> {
  factory _$$WatchThreadsImplCopyWith(
    _$WatchThreadsImpl value,
    $Res Function(_$WatchThreadsImpl) then,
  ) = __$$WatchThreadsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchThreadsImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$WatchThreadsImpl>
    implements _$$WatchThreadsImplCopyWith<$Res> {
  __$$WatchThreadsImplCopyWithImpl(
    _$WatchThreadsImpl _value,
    $Res Function(_$WatchThreadsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchThreadsImpl implements _WatchThreads {
  const _$WatchThreadsImpl();

  @override
  String toString() {
    return 'ChatEvent.watchThreads()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchThreadsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return watchThreads();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return watchThreads?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (watchThreads != null) {
      return watchThreads();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return watchThreads(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return watchThreads?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (watchThreads != null) {
      return watchThreads(this);
    }
    return orElse();
  }
}

abstract class _WatchThreads implements ChatEvent {
  const factory _WatchThreads() = _$WatchThreadsImpl;
}

/// @nodoc
abstract class _$$ThreadsUpdatedImplCopyWith<$Res> {
  factory _$$ThreadsUpdatedImplCopyWith(
    _$ThreadsUpdatedImpl value,
    $Res Function(_$ThreadsUpdatedImpl) then,
  ) = __$$ThreadsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ChatThread> threads});
}

/// @nodoc
class __$$ThreadsUpdatedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$ThreadsUpdatedImpl>
    implements _$$ThreadsUpdatedImplCopyWith<$Res> {
  __$$ThreadsUpdatedImplCopyWithImpl(
    _$ThreadsUpdatedImpl _value,
    $Res Function(_$ThreadsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threads = null}) {
    return _then(
      _$ThreadsUpdatedImpl(
        null == threads
            ? _value._threads
            : threads // ignore: cast_nullable_to_non_nullable
                  as List<ChatThread>,
      ),
    );
  }
}

/// @nodoc

class _$ThreadsUpdatedImpl implements _ThreadsUpdated {
  const _$ThreadsUpdatedImpl(final List<ChatThread> threads)
    : _threads = threads;

  final List<ChatThread> _threads;
  @override
  List<ChatThread> get threads {
    if (_threads is EqualUnmodifiableListView) return _threads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threads);
  }

  @override
  String toString() {
    return 'ChatEvent.threadsUpdated(threads: $threads)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._threads, _threads));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_threads));

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreadsUpdatedImplCopyWith<_$ThreadsUpdatedImpl> get copyWith =>
      __$$ThreadsUpdatedImplCopyWithImpl<_$ThreadsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return threadsUpdated(threads);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return threadsUpdated?.call(threads);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (threadsUpdated != null) {
      return threadsUpdated(threads);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return threadsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return threadsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (threadsUpdated != null) {
      return threadsUpdated(this);
    }
    return orElse();
  }
}

abstract class _ThreadsUpdated implements ChatEvent {
  const factory _ThreadsUpdated(final List<ChatThread> threads) =
      _$ThreadsUpdatedImpl;

  List<ChatThread> get threads;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThreadsUpdatedImplCopyWith<_$ThreadsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectThreadImplCopyWith<$Res> {
  factory _$$SelectThreadImplCopyWith(
    _$SelectThreadImpl value,
    $Res Function(_$SelectThreadImpl) then,
  ) = __$$SelectThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId});
}

/// @nodoc
class __$$SelectThreadImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$SelectThreadImpl>
    implements _$$SelectThreadImplCopyWith<$Res> {
  __$$SelectThreadImplCopyWithImpl(
    _$SelectThreadImpl _value,
    $Res Function(_$SelectThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null}) {
    return _then(
      _$SelectThreadImpl(
        null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectThreadImpl implements _SelectThread {
  const _$SelectThreadImpl(this.threadId);

  @override
  final String threadId;

  @override
  String toString() {
    return 'ChatEvent.selectThread(threadId: $threadId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectThreadImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectThreadImplCopyWith<_$SelectThreadImpl> get copyWith =>
      __$$SelectThreadImplCopyWithImpl<_$SelectThreadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return selectThread(threadId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return selectThread?.call(threadId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (selectThread != null) {
      return selectThread(threadId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return selectThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return selectThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (selectThread != null) {
      return selectThread(this);
    }
    return orElse();
  }
}

abstract class _SelectThread implements ChatEvent {
  const factory _SelectThread(final String threadId) = _$SelectThreadImpl;

  String get threadId;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectThreadImplCopyWith<_$SelectThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMessagesImplCopyWith<$Res> {
  factory _$$LoadMessagesImplCopyWith(
    _$LoadMessagesImpl value,
    $Res Function(_$LoadMessagesImpl) then,
  ) = __$$LoadMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId, int? limit, DateTime? startAfter});
}

/// @nodoc
class __$$LoadMessagesImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$LoadMessagesImpl>
    implements _$$LoadMessagesImplCopyWith<$Res> {
  __$$LoadMessagesImplCopyWithImpl(
    _$LoadMessagesImpl _value,
    $Res Function(_$LoadMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? limit = freezed,
    Object? startAfter = freezed,
  }) {
    return _then(
      _$LoadMessagesImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
        startAfter: freezed == startAfter
            ? _value.startAfter
            : startAfter // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$LoadMessagesImpl implements _LoadMessages {
  const _$LoadMessagesImpl({
    required this.threadId,
    this.limit,
    this.startAfter,
  });

  @override
  final String threadId;
  @override
  final int? limit;
  @override
  final DateTime? startAfter;

  @override
  String toString() {
    return 'ChatEvent.loadMessages(threadId: $threadId, limit: $limit, startAfter: $startAfter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMessagesImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.startAfter, startAfter) ||
                other.startAfter == startAfter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId, limit, startAfter);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      __$$LoadMessagesImplCopyWithImpl<_$LoadMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return loadMessages(threadId, limit, startAfter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return loadMessages?.call(threadId, limit, startAfter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(threadId, limit, startAfter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(this);
    }
    return orElse();
  }
}

abstract class _LoadMessages implements ChatEvent {
  const factory _LoadMessages({
    required final String threadId,
    final int? limit,
    final DateTime? startAfter,
  }) = _$LoadMessagesImpl;

  String get threadId;
  int? get limit;
  DateTime? get startAfter;

  /// Create a copy of ChatEvent
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
  $Res call({String threadId, int? limit});
}

/// @nodoc
class __$$WatchMessagesImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$WatchMessagesImpl>
    implements _$$WatchMessagesImplCopyWith<$Res> {
  __$$WatchMessagesImplCopyWithImpl(
    _$WatchMessagesImpl _value,
    $Res Function(_$WatchMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null, Object? limit = freezed}) {
    return _then(
      _$WatchMessagesImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
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
  const _$WatchMessagesImpl({required this.threadId, this.limit});

  @override
  final String threadId;
  @override
  final int? limit;

  @override
  String toString() {
    return 'ChatEvent.watchMessages(threadId: $threadId, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchMessagesImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId, limit);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchMessagesImplCopyWith<_$WatchMessagesImpl> get copyWith =>
      __$$WatchMessagesImplCopyWithImpl<_$WatchMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return watchMessages(threadId, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return watchMessages?.call(threadId, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (watchMessages != null) {
      return watchMessages(threadId, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return watchMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return watchMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (watchMessages != null) {
      return watchMessages(this);
    }
    return orElse();
  }
}

abstract class _WatchMessages implements ChatEvent {
  const factory _WatchMessages({
    required final String threadId,
    final int? limit,
  }) = _$WatchMessagesImpl;

  String get threadId;
  int? get limit;

  /// Create a copy of ChatEvent
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
  $Res call({List<ChatCard> messages});
}

/// @nodoc
class __$$MessagesUpdatedImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$MessagesUpdatedImpl>
    implements _$$MessagesUpdatedImplCopyWith<$Res> {
  __$$MessagesUpdatedImplCopyWithImpl(
    _$MessagesUpdatedImpl _value,
    $Res Function(_$MessagesUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _$MessagesUpdatedImpl(
        null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<ChatCard>,
      ),
    );
  }
}

/// @nodoc

class _$MessagesUpdatedImpl implements _MessagesUpdated {
  const _$MessagesUpdatedImpl(final List<ChatCard> messages)
    : _messages = messages;

  final List<ChatCard> _messages;
  @override
  List<ChatCard> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatEvent.messagesUpdated(messages: $messages)';
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

  /// Create a copy of ChatEvent
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
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return messagesUpdated(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return messagesUpdated?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
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
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return messagesUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return messagesUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (messagesUpdated != null) {
      return messagesUpdated(this);
    }
    return orElse();
  }
}

abstract class _MessagesUpdated implements ChatEvent {
  const factory _MessagesUpdated(final List<ChatCard> messages) =
      _$MessagesUpdatedImpl;

  List<ChatCard> get messages;

  /// Create a copy of ChatEvent
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
  $Res call({String threadId, String text});
}

/// @nodoc
class __$$SendTextMessageImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$SendTextMessageImpl>
    implements _$$SendTextMessageImplCopyWith<$Res> {
  __$$SendTextMessageImplCopyWithImpl(
    _$SendTextMessageImpl _value,
    $Res Function(_$SendTextMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null, Object? text = null}) {
    return _then(
      _$SendTextMessageImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SendTextMessageImpl implements _SendTextMessage {
  const _$SendTextMessageImpl({required this.threadId, required this.text});

  @override
  final String threadId;
  @override
  final String text;

  @override
  String toString() {
    return 'ChatEvent.sendTextMessage(threadId: $threadId, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTextMessageImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId, text);

  /// Create a copy of ChatEvent
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
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return sendTextMessage(threadId, text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return sendTextMessage?.call(threadId, text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (sendTextMessage != null) {
      return sendTextMessage(threadId, text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return sendTextMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return sendTextMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (sendTextMessage != null) {
      return sendTextMessage(this);
    }
    return orElse();
  }
}

abstract class _SendTextMessage implements ChatEvent {
  const factory _SendTextMessage({
    required final String threadId,
    required final String text,
  }) = _$SendTextMessageImpl;

  String get threadId;
  String get text;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTextMessageImplCopyWith<_$SendTextMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTokensImplCopyWith<$Res> {
  factory _$$SendTokensImplCopyWith(
    _$SendTokensImpl value,
    $Res Function(_$SendTokensImpl) then,
  ) = __$$SendTokensImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId, String recipientId, int amount, String? message});
}

/// @nodoc
class __$$SendTokensImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$SendTokensImpl>
    implements _$$SendTokensImplCopyWith<$Res> {
  __$$SendTokensImplCopyWithImpl(
    _$SendTokensImpl _value,
    $Res Function(_$SendTokensImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? recipientId = null,
    Object? amount = null,
    Object? message = freezed,
  }) {
    return _then(
      _$SendTokensImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
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
    required this.threadId,
    required this.recipientId,
    required this.amount,
    this.message,
  });

  @override
  final String threadId;
  @override
  final String recipientId;
  @override
  final int amount;
  @override
  final String? message;

  @override
  String toString() {
    return 'ChatEvent.sendTokens(threadId: $threadId, recipientId: $recipientId, amount: $amount, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTokensImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, threadId, recipientId, amount, message);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTokensImplCopyWith<_$SendTokensImpl> get copyWith =>
      __$$SendTokensImplCopyWithImpl<_$SendTokensImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return sendTokens(threadId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return sendTokens?.call(threadId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (sendTokens != null) {
      return sendTokens(threadId, recipientId, amount, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return sendTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return sendTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (sendTokens != null) {
      return sendTokens(this);
    }
    return orElse();
  }
}

abstract class _SendTokens implements ChatEvent {
  const factory _SendTokens({
    required final String threadId,
    required final String recipientId,
    required final int amount,
    final String? message,
  }) = _$SendTokensImpl;

  String get threadId;
  String get recipientId;
  int get amount;
  String? get message;

  /// Create a copy of ChatEvent
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
  $Res call({String threadId, String recipientId, int amount, String? message});
}

/// @nodoc
class __$$RequestTokensImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$RequestTokensImpl>
    implements _$$RequestTokensImplCopyWith<$Res> {
  __$$RequestTokensImplCopyWithImpl(
    _$RequestTokensImpl _value,
    $Res Function(_$RequestTokensImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? recipientId = null,
    Object? amount = null,
    Object? message = freezed,
  }) {
    return _then(
      _$RequestTokensImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
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
    required this.threadId,
    required this.recipientId,
    required this.amount,
    this.message,
  });

  @override
  final String threadId;
  @override
  final String recipientId;
  @override
  final int amount;
  @override
  final String? message;

  @override
  String toString() {
    return 'ChatEvent.requestTokens(threadId: $threadId, recipientId: $recipientId, amount: $amount, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestTokensImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, threadId, recipientId, amount, message);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestTokensImplCopyWith<_$RequestTokensImpl> get copyWith =>
      __$$RequestTokensImplCopyWithImpl<_$RequestTokensImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return requestTokens(threadId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return requestTokens?.call(threadId, recipientId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (requestTokens != null) {
      return requestTokens(threadId, recipientId, amount, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return requestTokens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return requestTokens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (requestTokens != null) {
      return requestTokens(this);
    }
    return orElse();
  }
}

abstract class _RequestTokens implements ChatEvent {
  const factory _RequestTokens({
    required final String threadId,
    required final String recipientId,
    required final int amount,
    final String? message,
  }) = _$RequestTokensImpl;

  String get threadId;
  String get recipientId;
  int get amount;
  String? get message;

  /// Create a copy of ChatEvent
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
  $Res call({String cardId});
}

/// @nodoc
class __$$AcceptTokenRequestImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$AcceptTokenRequestImpl>
    implements _$$AcceptTokenRequestImplCopyWith<$Res> {
  __$$AcceptTokenRequestImplCopyWithImpl(
    _$AcceptTokenRequestImpl _value,
    $Res Function(_$AcceptTokenRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cardId = null}) {
    return _then(
      _$AcceptTokenRequestImpl(
        null == cardId
            ? _value.cardId
            : cardId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AcceptTokenRequestImpl implements _AcceptTokenRequest {
  const _$AcceptTokenRequestImpl(this.cardId);

  @override
  final String cardId;

  @override
  String toString() {
    return 'ChatEvent.acceptTokenRequest(cardId: $cardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptTokenRequestImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId);

  /// Create a copy of ChatEvent
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
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return acceptTokenRequest(cardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return acceptTokenRequest?.call(cardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (acceptTokenRequest != null) {
      return acceptTokenRequest(cardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return acceptTokenRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return acceptTokenRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (acceptTokenRequest != null) {
      return acceptTokenRequest(this);
    }
    return orElse();
  }
}

abstract class _AcceptTokenRequest implements ChatEvent {
  const factory _AcceptTokenRequest(final String cardId) =
      _$AcceptTokenRequestImpl;

  String get cardId;

  /// Create a copy of ChatEvent
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
  $Res call({String cardId});
}

/// @nodoc
class __$$DeclineTokenRequestImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$DeclineTokenRequestImpl>
    implements _$$DeclineTokenRequestImplCopyWith<$Res> {
  __$$DeclineTokenRequestImplCopyWithImpl(
    _$DeclineTokenRequestImpl _value,
    $Res Function(_$DeclineTokenRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cardId = null}) {
    return _then(
      _$DeclineTokenRequestImpl(
        null == cardId
            ? _value.cardId
            : cardId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeclineTokenRequestImpl implements _DeclineTokenRequest {
  const _$DeclineTokenRequestImpl(this.cardId);

  @override
  final String cardId;

  @override
  String toString() {
    return 'ChatEvent.declineTokenRequest(cardId: $cardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeclineTokenRequestImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId);

  /// Create a copy of ChatEvent
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
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return declineTokenRequest(cardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return declineTokenRequest?.call(cardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (declineTokenRequest != null) {
      return declineTokenRequest(cardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return declineTokenRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return declineTokenRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (declineTokenRequest != null) {
      return declineTokenRequest(this);
    }
    return orElse();
  }
}

abstract class _DeclineTokenRequest implements ChatEvent {
  const factory _DeclineTokenRequest(final String cardId) =
      _$DeclineTokenRequestImpl;

  String get cardId;

  /// Create a copy of ChatEvent
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
  $Res call({String threadId, List<String> messageIds});
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
    _$MarkAsReadImpl _value,
    $Res Function(_$MarkAsReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null, Object? messageIds = null}) {
    return _then(
      _$MarkAsReadImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageIds: null == messageIds
            ? _value._messageIds
            : messageIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$MarkAsReadImpl implements _MarkAsRead {
  const _$MarkAsReadImpl({
    required this.threadId,
    required final List<String> messageIds,
  }) : _messageIds = messageIds;

  @override
  final String threadId;
  final List<String> _messageIds;
  @override
  List<String> get messageIds {
    if (_messageIds is EqualUnmodifiableListView) return _messageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messageIds);
  }

  @override
  String toString() {
    return 'ChatEvent.markAsRead(threadId: $threadId, messageIds: $messageIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            const DeepCollectionEquality().equals(
              other._messageIds,
              _messageIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    threadId,
    const DeepCollectionEquality().hash(_messageIds),
  );

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      __$$MarkAsReadImplCopyWithImpl<_$MarkAsReadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return markAsRead(threadId, messageIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return markAsRead?.call(threadId, messageIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(threadId, messageIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAsRead implements ChatEvent {
  const factory _MarkAsRead({
    required final String threadId,
    required final List<String> messageIds,
  }) = _$MarkAsReadImpl;

  String get threadId;
  List<String> get messageIds;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TogglePinThreadImplCopyWith<$Res> {
  factory _$$TogglePinThreadImplCopyWith(
    _$TogglePinThreadImpl value,
    $Res Function(_$TogglePinThreadImpl) then,
  ) = __$$TogglePinThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId, bool isPinned});
}

/// @nodoc
class __$$TogglePinThreadImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$TogglePinThreadImpl>
    implements _$$TogglePinThreadImplCopyWith<$Res> {
  __$$TogglePinThreadImplCopyWithImpl(
    _$TogglePinThreadImpl _value,
    $Res Function(_$TogglePinThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null, Object? isPinned = null}) {
    return _then(
      _$TogglePinThreadImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TogglePinThreadImpl implements _TogglePinThread {
  const _$TogglePinThreadImpl({required this.threadId, required this.isPinned});

  @override
  final String threadId;
  @override
  final bool isPinned;

  @override
  String toString() {
    return 'ChatEvent.togglePinThread(threadId: $threadId, isPinned: $isPinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TogglePinThreadImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId, isPinned);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TogglePinThreadImplCopyWith<_$TogglePinThreadImpl> get copyWith =>
      __$$TogglePinThreadImplCopyWithImpl<_$TogglePinThreadImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return togglePinThread(threadId, isPinned);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return togglePinThread?.call(threadId, isPinned);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (togglePinThread != null) {
      return togglePinThread(threadId, isPinned);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return togglePinThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return togglePinThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (togglePinThread != null) {
      return togglePinThread(this);
    }
    return orElse();
  }
}

abstract class _TogglePinThread implements ChatEvent {
  const factory _TogglePinThread({
    required final String threadId,
    required final bool isPinned,
  }) = _$TogglePinThreadImpl;

  String get threadId;
  bool get isPinned;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TogglePinThreadImplCopyWith<_$TogglePinThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleMuteThreadImplCopyWith<$Res> {
  factory _$$ToggleMuteThreadImplCopyWith(
    _$ToggleMuteThreadImpl value,
    $Res Function(_$ToggleMuteThreadImpl) then,
  ) = __$$ToggleMuteThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId, bool isMuted});
}

/// @nodoc
class __$$ToggleMuteThreadImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$ToggleMuteThreadImpl>
    implements _$$ToggleMuteThreadImplCopyWith<$Res> {
  __$$ToggleMuteThreadImplCopyWithImpl(
    _$ToggleMuteThreadImpl _value,
    $Res Function(_$ToggleMuteThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null, Object? isMuted = null}) {
    return _then(
      _$ToggleMuteThreadImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        isMuted: null == isMuted
            ? _value.isMuted
            : isMuted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ToggleMuteThreadImpl implements _ToggleMuteThread {
  const _$ToggleMuteThreadImpl({required this.threadId, required this.isMuted});

  @override
  final String threadId;
  @override
  final bool isMuted;

  @override
  String toString() {
    return 'ChatEvent.toggleMuteThread(threadId: $threadId, isMuted: $isMuted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleMuteThreadImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId, isMuted);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleMuteThreadImplCopyWith<_$ToggleMuteThreadImpl> get copyWith =>
      __$$ToggleMuteThreadImplCopyWithImpl<_$ToggleMuteThreadImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return toggleMuteThread(threadId, isMuted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return toggleMuteThread?.call(threadId, isMuted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (toggleMuteThread != null) {
      return toggleMuteThread(threadId, isMuted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return toggleMuteThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return toggleMuteThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (toggleMuteThread != null) {
      return toggleMuteThread(this);
    }
    return orElse();
  }
}

abstract class _ToggleMuteThread implements ChatEvent {
  const factory _ToggleMuteThread({
    required final String threadId,
    required final bool isMuted,
  }) = _$ToggleMuteThreadImpl;

  String get threadId;
  bool get isMuted;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleMuteThreadImplCopyWith<_$ToggleMuteThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArchiveThreadImplCopyWith<$Res> {
  factory _$$ArchiveThreadImplCopyWith(
    _$ArchiveThreadImpl value,
    $Res Function(_$ArchiveThreadImpl) then,
  ) = __$$ArchiveThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String threadId});
}

/// @nodoc
class __$$ArchiveThreadImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$ArchiveThreadImpl>
    implements _$$ArchiveThreadImplCopyWith<$Res> {
  __$$ArchiveThreadImplCopyWithImpl(
    _$ArchiveThreadImpl _value,
    $Res Function(_$ArchiveThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? threadId = null}) {
    return _then(
      _$ArchiveThreadImpl(
        null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ArchiveThreadImpl implements _ArchiveThread {
  const _$ArchiveThreadImpl(this.threadId);

  @override
  final String threadId;

  @override
  String toString() {
    return 'ChatEvent.archiveThread(threadId: $threadId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArchiveThreadImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, threadId);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArchiveThreadImplCopyWith<_$ArchiveThreadImpl> get copyWith =>
      __$$ArchiveThreadImplCopyWithImpl<_$ArchiveThreadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return archiveThread(threadId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return archiveThread?.call(threadId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (archiveThread != null) {
      return archiveThread(threadId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return archiveThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return archiveThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (archiveThread != null) {
      return archiveThread(this);
    }
    return orElse();
  }
}

abstract class _ArchiveThread implements ChatEvent {
  const factory _ArchiveThread(final String threadId) = _$ArchiveThreadImpl;

  String get threadId;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArchiveThreadImplCopyWith<_$ArchiveThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetOrCreateThreadImplCopyWith<$Res> {
  factory _$$GetOrCreateThreadImplCopyWith(
    _$GetOrCreateThreadImpl value,
    $Res Function(_$GetOrCreateThreadImpl) then,
  ) = __$$GetOrCreateThreadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String participantId});
}

/// @nodoc
class __$$GetOrCreateThreadImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$GetOrCreateThreadImpl>
    implements _$$GetOrCreateThreadImplCopyWith<$Res> {
  __$$GetOrCreateThreadImplCopyWithImpl(
    _$GetOrCreateThreadImpl _value,
    $Res Function(_$GetOrCreateThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? participantId = null}) {
    return _then(
      _$GetOrCreateThreadImpl(
        null == participantId
            ? _value.participantId
            : participantId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetOrCreateThreadImpl implements _GetOrCreateThread {
  const _$GetOrCreateThreadImpl(this.participantId);

  @override
  final String participantId;

  @override
  String toString() {
    return 'ChatEvent.getOrCreateThread(participantId: $participantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOrCreateThreadImpl &&
            (identical(other.participantId, participantId) ||
                other.participantId == participantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, participantId);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOrCreateThreadImplCopyWith<_$GetOrCreateThreadImpl> get copyWith =>
      __$$GetOrCreateThreadImplCopyWithImpl<_$GetOrCreateThreadImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return getOrCreateThread(participantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return getOrCreateThread?.call(participantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (getOrCreateThread != null) {
      return getOrCreateThread(participantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return getOrCreateThread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return getOrCreateThread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (getOrCreateThread != null) {
      return getOrCreateThread(this);
    }
    return orElse();
  }
}

abstract class _GetOrCreateThread implements ChatEvent {
  const factory _GetOrCreateThread(final String participantId) =
      _$GetOrCreateThreadImpl;

  String get participantId;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOrCreateThreadImplCopyWith<_$GetOrCreateThreadImpl> get copyWith =>
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
    extends _$ChatEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'ChatEvent.clearError()';
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
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
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
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements ChatEvent {
  const factory _ClearError() = _$ClearErrorImpl;
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
    extends _$ChatEventCopyWithImpl<$Res, _$UnreadCountUpdatedImpl>
    implements _$$UnreadCountUpdatedImplCopyWith<$Res> {
  __$$UnreadCountUpdatedImplCopyWithImpl(
    _$UnreadCountUpdatedImpl _value,
    $Res Function(_$UnreadCountUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatEvent
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
    return 'ChatEvent.unreadCountUpdated(count: $count)';
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

  /// Create a copy of ChatEvent
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
    required TResult Function() loadThreads,
    required TResult Function() watchThreads,
    required TResult Function(List<ChatThread> threads) threadsUpdated,
    required TResult Function(String threadId) selectThread,
    required TResult Function(String threadId, int? limit, DateTime? startAfter)
    loadMessages,
    required TResult Function(String threadId, int? limit) watchMessages,
    required TResult Function(List<ChatCard> messages) messagesUpdated,
    required TResult Function(String threadId, String text) sendTextMessage,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    sendTokens,
    required TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )
    requestTokens,
    required TResult Function(String cardId) acceptTokenRequest,
    required TResult Function(String cardId) declineTokenRequest,
    required TResult Function(String threadId, List<String> messageIds)
    markAsRead,
    required TResult Function(String threadId, bool isPinned) togglePinThread,
    required TResult Function(String threadId, bool isMuted) toggleMuteThread,
    required TResult Function(String threadId) archiveThread,
    required TResult Function(String participantId) getOrCreateThread,
    required TResult Function() clearError,
    required TResult Function(int count) unreadCountUpdated,
  }) {
    return unreadCountUpdated(count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadThreads,
    TResult? Function()? watchThreads,
    TResult? Function(List<ChatThread> threads)? threadsUpdated,
    TResult? Function(String threadId)? selectThread,
    TResult? Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult? Function(String threadId, int? limit)? watchMessages,
    TResult? Function(List<ChatCard> messages)? messagesUpdated,
    TResult? Function(String threadId, String text)? sendTextMessage,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult? Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult? Function(String cardId)? acceptTokenRequest,
    TResult? Function(String cardId)? declineTokenRequest,
    TResult? Function(String threadId, List<String> messageIds)? markAsRead,
    TResult? Function(String threadId, bool isPinned)? togglePinThread,
    TResult? Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult? Function(String threadId)? archiveThread,
    TResult? Function(String participantId)? getOrCreateThread,
    TResult? Function()? clearError,
    TResult? Function(int count)? unreadCountUpdated,
  }) {
    return unreadCountUpdated?.call(count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadThreads,
    TResult Function()? watchThreads,
    TResult Function(List<ChatThread> threads)? threadsUpdated,
    TResult Function(String threadId)? selectThread,
    TResult Function(String threadId, int? limit, DateTime? startAfter)?
    loadMessages,
    TResult Function(String threadId, int? limit)? watchMessages,
    TResult Function(List<ChatCard> messages)? messagesUpdated,
    TResult Function(String threadId, String text)? sendTextMessage,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    sendTokens,
    TResult Function(
      String threadId,
      String recipientId,
      int amount,
      String? message,
    )?
    requestTokens,
    TResult Function(String cardId)? acceptTokenRequest,
    TResult Function(String cardId)? declineTokenRequest,
    TResult Function(String threadId, List<String> messageIds)? markAsRead,
    TResult Function(String threadId, bool isPinned)? togglePinThread,
    TResult Function(String threadId, bool isMuted)? toggleMuteThread,
    TResult Function(String threadId)? archiveThread,
    TResult Function(String participantId)? getOrCreateThread,
    TResult Function()? clearError,
    TResult Function(int count)? unreadCountUpdated,
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
    required TResult Function(_LoadThreads value) loadThreads,
    required TResult Function(_WatchThreads value) watchThreads,
    required TResult Function(_ThreadsUpdated value) threadsUpdated,
    required TResult Function(_SelectThread value) selectThread,
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendTokens value) sendTokens,
    required TResult Function(_RequestTokens value) requestTokens,
    required TResult Function(_AcceptTokenRequest value) acceptTokenRequest,
    required TResult Function(_DeclineTokenRequest value) declineTokenRequest,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePinThread value) togglePinThread,
    required TResult Function(_ToggleMuteThread value) toggleMuteThread,
    required TResult Function(_ArchiveThread value) archiveThread,
    required TResult Function(_GetOrCreateThread value) getOrCreateThread,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_UnreadCountUpdated value) unreadCountUpdated,
  }) {
    return unreadCountUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadThreads value)? loadThreads,
    TResult? Function(_WatchThreads value)? watchThreads,
    TResult? Function(_ThreadsUpdated value)? threadsUpdated,
    TResult? Function(_SelectThread value)? selectThread,
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendTokens value)? sendTokens,
    TResult? Function(_RequestTokens value)? requestTokens,
    TResult? Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult? Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePinThread value)? togglePinThread,
    TResult? Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult? Function(_ArchiveThread value)? archiveThread,
    TResult? Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_UnreadCountUpdated value)? unreadCountUpdated,
  }) {
    return unreadCountUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadThreads value)? loadThreads,
    TResult Function(_WatchThreads value)? watchThreads,
    TResult Function(_ThreadsUpdated value)? threadsUpdated,
    TResult Function(_SelectThread value)? selectThread,
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendTokens value)? sendTokens,
    TResult Function(_RequestTokens value)? requestTokens,
    TResult Function(_AcceptTokenRequest value)? acceptTokenRequest,
    TResult Function(_DeclineTokenRequest value)? declineTokenRequest,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePinThread value)? togglePinThread,
    TResult Function(_ToggleMuteThread value)? toggleMuteThread,
    TResult Function(_ArchiveThread value)? archiveThread,
    TResult Function(_GetOrCreateThread value)? getOrCreateThread,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_UnreadCountUpdated value)? unreadCountUpdated,
    required TResult orElse(),
  }) {
    if (unreadCountUpdated != null) {
      return unreadCountUpdated(this);
    }
    return orElse();
  }
}

abstract class _UnreadCountUpdated implements ChatEvent {
  const factory _UnreadCountUpdated(final int count) = _$UnreadCountUpdatedImpl;

  int get count;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnreadCountUpdatedImplCopyWith<_$UnreadCountUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatState {
  ChatStatus get status => throw _privateConstructorUsedError;
  List<ChatThread> get threads => throw _privateConstructorUsedError;
  List<ChatCard> get messages => throw _privateConstructorUsedError;
  ChatThread? get selectedThread => throw _privateConstructorUsedError;
  bool get isLoadingMessages => throw _privateConstructorUsedError;
  bool get hasMoreMessages => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  int get totalUnreadCount => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call({
    ChatStatus status,
    List<ChatThread> threads,
    List<ChatCard> messages,
    ChatThread? selectedThread,
    bool isLoadingMessages,
    bool hasMoreMessages,
    bool isSending,
    int totalUnreadCount,
    String? errorMessage,
  });

  $ChatThreadCopyWith<$Res>? get selectedThread;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? threads = null,
    Object? messages = null,
    Object? selectedThread = freezed,
    Object? isLoadingMessages = null,
    Object? hasMoreMessages = null,
    Object? isSending = null,
    Object? totalUnreadCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ChatStatus,
            threads: null == threads
                ? _value.threads
                : threads // ignore: cast_nullable_to_non_nullable
                      as List<ChatThread>,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<ChatCard>,
            selectedThread: freezed == selectedThread
                ? _value.selectedThread
                : selectedThread // ignore: cast_nullable_to_non_nullable
                      as ChatThread?,
            isLoadingMessages: null == isLoadingMessages
                ? _value.isLoadingMessages
                : isLoadingMessages // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreMessages: null == hasMoreMessages
                ? _value.hasMoreMessages
                : hasMoreMessages // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalUnreadCount: null == totalUnreadCount
                ? _value.totalUnreadCount
                : totalUnreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatThreadCopyWith<$Res>? get selectedThread {
    if (_value.selectedThread == null) {
      return null;
    }

    return $ChatThreadCopyWith<$Res>(_value.selectedThread!, (value) {
      return _then(_value.copyWith(selectedThread: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
    _$ChatStateImpl value,
    $Res Function(_$ChatStateImpl) then,
  ) = __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ChatStatus status,
    List<ChatThread> threads,
    List<ChatCard> messages,
    ChatThread? selectedThread,
    bool isLoadingMessages,
    bool hasMoreMessages,
    bool isSending,
    int totalUnreadCount,
    String? errorMessage,
  });

  @override
  $ChatThreadCopyWith<$Res>? get selectedThread;
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
    _$ChatStateImpl _value,
    $Res Function(_$ChatStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? threads = null,
    Object? messages = null,
    Object? selectedThread = freezed,
    Object? isLoadingMessages = null,
    Object? hasMoreMessages = null,
    Object? isSending = null,
    Object? totalUnreadCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ChatStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ChatStatus,
        threads: null == threads
            ? _value._threads
            : threads // ignore: cast_nullable_to_non_nullable
                  as List<ChatThread>,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<ChatCard>,
        selectedThread: freezed == selectedThread
            ? _value.selectedThread
            : selectedThread // ignore: cast_nullable_to_non_nullable
                  as ChatThread?,
        isLoadingMessages: null == isLoadingMessages
            ? _value.isLoadingMessages
            : isLoadingMessages // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreMessages: null == hasMoreMessages
            ? _value.hasMoreMessages
            : hasMoreMessages // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalUnreadCount: null == totalUnreadCount
            ? _value.totalUnreadCount
            : totalUnreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatStateImpl extends _ChatState {
  const _$ChatStateImpl({
    this.status = ChatStatus.initial,
    final List<ChatThread> threads = const [],
    final List<ChatCard> messages = const [],
    this.selectedThread,
    this.isLoadingMessages = false,
    this.hasMoreMessages = false,
    this.isSending = false,
    this.totalUnreadCount = 0,
    this.errorMessage,
  }) : _threads = threads,
       _messages = messages,
       super._();

  @override
  @JsonKey()
  final ChatStatus status;
  final List<ChatThread> _threads;
  @override
  @JsonKey()
  List<ChatThread> get threads {
    if (_threads is EqualUnmodifiableListView) return _threads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threads);
  }

  final List<ChatCard> _messages;
  @override
  @JsonKey()
  List<ChatCard> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final ChatThread? selectedThread;
  @override
  @JsonKey()
  final bool isLoadingMessages;
  @override
  @JsonKey()
  final bool hasMoreMessages;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final int totalUnreadCount;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ChatState(status: $status, threads: $threads, messages: $messages, selectedThread: $selectedThread, isLoadingMessages: $isLoadingMessages, hasMoreMessages: $hasMoreMessages, isSending: $isSending, totalUnreadCount: $totalUnreadCount, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._threads, _threads) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.selectedThread, selectedThread) ||
                other.selectedThread == selectedThread) &&
            (identical(other.isLoadingMessages, isLoadingMessages) ||
                other.isLoadingMessages == isLoadingMessages) &&
            (identical(other.hasMoreMessages, hasMoreMessages) ||
                other.hasMoreMessages == hasMoreMessages) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.totalUnreadCount, totalUnreadCount) ||
                other.totalUnreadCount == totalUnreadCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_threads),
    const DeepCollectionEquality().hash(_messages),
    selectedThread,
    isLoadingMessages,
    hasMoreMessages,
    isSending,
    totalUnreadCount,
    errorMessage,
  );

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);
}

abstract class _ChatState extends ChatState {
  const factory _ChatState({
    final ChatStatus status,
    final List<ChatThread> threads,
    final List<ChatCard> messages,
    final ChatThread? selectedThread,
    final bool isLoadingMessages,
    final bool hasMoreMessages,
    final bool isSending,
    final int totalUnreadCount,
    final String? errorMessage,
  }) = _$ChatStateImpl;
  const _ChatState._() : super._();

  @override
  ChatStatus get status;
  @override
  List<ChatThread> get threads;
  @override
  List<ChatCard> get messages;
  @override
  ChatThread? get selectedThread;
  @override
  bool get isLoadingMessages;
  @override
  bool get hasMoreMessages;
  @override
  bool get isSending;
  @override
  int get totalUnreadCount;
  @override
  String? get errorMessage;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
