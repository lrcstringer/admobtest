// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationEvent()';
}


}

/// @nodoc
class $ConversationEventCopyWith<$Res>  {
$ConversationEventCopyWith(ConversationEvent _, $Res Function(ConversationEvent) __);
}


/// Adds pattern-matching-related methods to [ConversationEvent].
extension ConversationEventPatterns on ConversationEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _WatchConversations value)?  watchConversations,TResult Function( _ConversationsUpdated value)?  conversationsUpdated,TResult Function( _SelectConversation value)?  selectConversation,TResult Function( _GetOrCreateConversation value)?  getOrCreateConversation,TResult Function( _LoadMessages value)?  loadMessages,TResult Function( _MessagesUpdated value)?  messagesUpdated,TResult Function( _SendTextMessage value)?  sendTextMessage,TResult Function( _SendMediaMessage value)?  sendMediaMessage,TResult Function( _SendTokens value)?  sendTokens,TResult Function( _RequestTokens value)?  requestTokens,TResult Function( _SendTokensToUser value)?  sendTokensToUser,TResult Function( _AcceptTokenRequest value)?  acceptTokenRequest,TResult Function( _DeclineTokenRequest value)?  declineTokenRequest,TResult Function( _AcceptConversation value)?  acceptConversation,TResult Function( _UnreadCountUpdated value)?  unreadCountUpdated,TResult Function( _ClearChat value)?  clearChat,TResult Function( _RetryMessage value)?  retryMessage,TResult Function( _SetTyping value)?  setTyping,TResult Function( _TypingStateUpdated value)?  typingStateUpdated,TResult Function( _SearchMessages value)?  searchMessages,TResult Function( _ClearMessageSearch value)?  clearMessageSearch,TResult Function( _SetDisappearingMessages value)?  setDisappearingMessages,TResult Function( _ForwardMessage value)?  forwardMessage,TResult Function( _StreamError value)?  streamError,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchConversations() when watchConversations != null:
return watchConversations(_that);case _ConversationsUpdated() when conversationsUpdated != null:
return conversationsUpdated(_that);case _SelectConversation() when selectConversation != null:
return selectConversation(_that);case _GetOrCreateConversation() when getOrCreateConversation != null:
return getOrCreateConversation(_that);case _LoadMessages() when loadMessages != null:
return loadMessages(_that);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that);case _SendTokens() when sendTokens != null:
return sendTokens(_that);case _RequestTokens() when requestTokens != null:
return requestTokens(_that);case _SendTokensToUser() when sendTokensToUser != null:
return sendTokensToUser(_that);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that);case _AcceptConversation() when acceptConversation != null:
return acceptConversation(_that);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that);case _ClearChat() when clearChat != null:
return clearChat(_that);case _RetryMessage() when retryMessage != null:
return retryMessage(_that);case _SetTyping() when setTyping != null:
return setTyping(_that);case _TypingStateUpdated() when typingStateUpdated != null:
return typingStateUpdated(_that);case _SearchMessages() when searchMessages != null:
return searchMessages(_that);case _ClearMessageSearch() when clearMessageSearch != null:
return clearMessageSearch(_that);case _SetDisappearingMessages() when setDisappearingMessages != null:
return setDisappearingMessages(_that);case _ForwardMessage() when forwardMessage != null:
return forwardMessage(_that);case _StreamError() when streamError != null:
return streamError(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _WatchConversations value)  watchConversations,required TResult Function( _ConversationsUpdated value)  conversationsUpdated,required TResult Function( _SelectConversation value)  selectConversation,required TResult Function( _GetOrCreateConversation value)  getOrCreateConversation,required TResult Function( _LoadMessages value)  loadMessages,required TResult Function( _MessagesUpdated value)  messagesUpdated,required TResult Function( _SendTextMessage value)  sendTextMessage,required TResult Function( _SendMediaMessage value)  sendMediaMessage,required TResult Function( _SendTokens value)  sendTokens,required TResult Function( _RequestTokens value)  requestTokens,required TResult Function( _SendTokensToUser value)  sendTokensToUser,required TResult Function( _AcceptTokenRequest value)  acceptTokenRequest,required TResult Function( _DeclineTokenRequest value)  declineTokenRequest,required TResult Function( _AcceptConversation value)  acceptConversation,required TResult Function( _UnreadCountUpdated value)  unreadCountUpdated,required TResult Function( _ClearChat value)  clearChat,required TResult Function( _RetryMessage value)  retryMessage,required TResult Function( _SetTyping value)  setTyping,required TResult Function( _TypingStateUpdated value)  typingStateUpdated,required TResult Function( _SearchMessages value)  searchMessages,required TResult Function( _ClearMessageSearch value)  clearMessageSearch,required TResult Function( _SetDisappearingMessages value)  setDisappearingMessages,required TResult Function( _ForwardMessage value)  forwardMessage,required TResult Function( _StreamError value)  streamError,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _WatchConversations():
return watchConversations(_that);case _ConversationsUpdated():
return conversationsUpdated(_that);case _SelectConversation():
return selectConversation(_that);case _GetOrCreateConversation():
return getOrCreateConversation(_that);case _LoadMessages():
return loadMessages(_that);case _MessagesUpdated():
return messagesUpdated(_that);case _SendTextMessage():
return sendTextMessage(_that);case _SendMediaMessage():
return sendMediaMessage(_that);case _SendTokens():
return sendTokens(_that);case _RequestTokens():
return requestTokens(_that);case _SendTokensToUser():
return sendTokensToUser(_that);case _AcceptTokenRequest():
return acceptTokenRequest(_that);case _DeclineTokenRequest():
return declineTokenRequest(_that);case _AcceptConversation():
return acceptConversation(_that);case _UnreadCountUpdated():
return unreadCountUpdated(_that);case _ClearChat():
return clearChat(_that);case _RetryMessage():
return retryMessage(_that);case _SetTyping():
return setTyping(_that);case _TypingStateUpdated():
return typingStateUpdated(_that);case _SearchMessages():
return searchMessages(_that);case _ClearMessageSearch():
return clearMessageSearch(_that);case _SetDisappearingMessages():
return setDisappearingMessages(_that);case _ForwardMessage():
return forwardMessage(_that);case _StreamError():
return streamError(_that);case _ClearError():
return clearError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _WatchConversations value)?  watchConversations,TResult? Function( _ConversationsUpdated value)?  conversationsUpdated,TResult? Function( _SelectConversation value)?  selectConversation,TResult? Function( _GetOrCreateConversation value)?  getOrCreateConversation,TResult? Function( _LoadMessages value)?  loadMessages,TResult? Function( _MessagesUpdated value)?  messagesUpdated,TResult? Function( _SendTextMessage value)?  sendTextMessage,TResult? Function( _SendMediaMessage value)?  sendMediaMessage,TResult? Function( _SendTokens value)?  sendTokens,TResult? Function( _RequestTokens value)?  requestTokens,TResult? Function( _SendTokensToUser value)?  sendTokensToUser,TResult? Function( _AcceptTokenRequest value)?  acceptTokenRequest,TResult? Function( _DeclineTokenRequest value)?  declineTokenRequest,TResult? Function( _AcceptConversation value)?  acceptConversation,TResult? Function( _UnreadCountUpdated value)?  unreadCountUpdated,TResult? Function( _ClearChat value)?  clearChat,TResult? Function( _RetryMessage value)?  retryMessage,TResult? Function( _SetTyping value)?  setTyping,TResult? Function( _TypingStateUpdated value)?  typingStateUpdated,TResult? Function( _SearchMessages value)?  searchMessages,TResult? Function( _ClearMessageSearch value)?  clearMessageSearch,TResult? Function( _SetDisappearingMessages value)?  setDisappearingMessages,TResult? Function( _ForwardMessage value)?  forwardMessage,TResult? Function( _StreamError value)?  streamError,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _WatchConversations() when watchConversations != null:
return watchConversations(_that);case _ConversationsUpdated() when conversationsUpdated != null:
return conversationsUpdated(_that);case _SelectConversation() when selectConversation != null:
return selectConversation(_that);case _GetOrCreateConversation() when getOrCreateConversation != null:
return getOrCreateConversation(_that);case _LoadMessages() when loadMessages != null:
return loadMessages(_that);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that);case _SendTokens() when sendTokens != null:
return sendTokens(_that);case _RequestTokens() when requestTokens != null:
return requestTokens(_that);case _SendTokensToUser() when sendTokensToUser != null:
return sendTokensToUser(_that);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that);case _AcceptConversation() when acceptConversation != null:
return acceptConversation(_that);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that);case _ClearChat() when clearChat != null:
return clearChat(_that);case _RetryMessage() when retryMessage != null:
return retryMessage(_that);case _SetTyping() when setTyping != null:
return setTyping(_that);case _TypingStateUpdated() when typingStateUpdated != null:
return typingStateUpdated(_that);case _SearchMessages() when searchMessages != null:
return searchMessages(_that);case _ClearMessageSearch() when clearMessageSearch != null:
return clearMessageSearch(_that);case _SetDisappearingMessages() when setDisappearingMessages != null:
return setDisappearingMessages(_that);case _ForwardMessage() when forwardMessage != null:
return forwardMessage(_that);case _StreamError() when streamError != null:
return streamError(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  watchConversations,TResult Function( List<Conversation> conversations)?  conversationsUpdated,TResult Function( String id)?  selectConversation,TResult Function( String participantId)?  getOrCreateConversation,TResult Function( String conversationId,  int? limit,  DateTime? before)?  loadMessages,TResult Function( List<Message> messages)?  messagesUpdated,TResult Function( String conversationId,  String text,  String? replyToMessageId)?  sendTextMessage,TResult Function( String conversationId,  File mediaFile,  String mediaType,  String recipientId,  String? caption,  int? durationSeconds,  String? replyToMessageId,  File? thumbnailFile)?  sendMediaMessage,TResult Function( String conversationId,  String recipientId,  int amount,  String? message,  String? subAccountId)?  sendTokens,TResult Function( String conversationId,  String recipientId,  int amount,  String? message,  String? subAccountId)?  requestTokens,TResult Function( String recipientId,  int amount,  bool isSend,  String? message,  String? subAccountId)?  sendTokensToUser,TResult Function( String messageId,  String conversationId)?  acceptTokenRequest,TResult Function( String messageId,  String conversationId)?  declineTokenRequest,TResult Function( String conversationId)?  acceptConversation,TResult Function( int count)?  unreadCountUpdated,TResult Function( String conversationId)?  clearChat,TResult Function( String conversationId,  String messageId)?  retryMessage,TResult Function( String conversationId,  bool isTyping)?  setTyping,TResult Function( Map<String, bool> typingUsers)?  typingStateUpdated,TResult Function( String conversationId,  String query)?  searchMessages,TResult Function()?  clearMessageSearch,TResult Function( String conversationId,  Duration? duration)?  setDisappearingMessages,TResult Function( String sourceConversationId,  String sourceMessageId,  String targetConversationId)?  forwardMessage,TResult Function()?  streamError,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchConversations() when watchConversations != null:
return watchConversations();case _ConversationsUpdated() when conversationsUpdated != null:
return conversationsUpdated(_that.conversations);case _SelectConversation() when selectConversation != null:
return selectConversation(_that.id);case _GetOrCreateConversation() when getOrCreateConversation != null:
return getOrCreateConversation(_that.participantId);case _LoadMessages() when loadMessages != null:
return loadMessages(_that.conversationId,_that.limit,_that.before);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that.conversationId,_that.text,_that.replyToMessageId);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that.conversationId,_that.mediaFile,_that.mediaType,_that.recipientId,_that.caption,_that.durationSeconds,_that.replyToMessageId,_that.thumbnailFile);case _SendTokens() when sendTokens != null:
return sendTokens(_that.conversationId,_that.recipientId,_that.amount,_that.message,_that.subAccountId);case _RequestTokens() when requestTokens != null:
return requestTokens(_that.conversationId,_that.recipientId,_that.amount,_that.message,_that.subAccountId);case _SendTokensToUser() when sendTokensToUser != null:
return sendTokensToUser(_that.recipientId,_that.amount,_that.isSend,_that.message,_that.subAccountId);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that.messageId,_that.conversationId);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that.messageId,_that.conversationId);case _AcceptConversation() when acceptConversation != null:
return acceptConversation(_that.conversationId);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that.count);case _ClearChat() when clearChat != null:
return clearChat(_that.conversationId);case _RetryMessage() when retryMessage != null:
return retryMessage(_that.conversationId,_that.messageId);case _SetTyping() when setTyping != null:
return setTyping(_that.conversationId,_that.isTyping);case _TypingStateUpdated() when typingStateUpdated != null:
return typingStateUpdated(_that.typingUsers);case _SearchMessages() when searchMessages != null:
return searchMessages(_that.conversationId,_that.query);case _ClearMessageSearch() when clearMessageSearch != null:
return clearMessageSearch();case _SetDisappearingMessages() when setDisappearingMessages != null:
return setDisappearingMessages(_that.conversationId,_that.duration);case _ForwardMessage() when forwardMessage != null:
return forwardMessage(_that.sourceConversationId,_that.sourceMessageId,_that.targetConversationId);case _StreamError() when streamError != null:
return streamError();case _ClearError() when clearError != null:
return clearError();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  watchConversations,required TResult Function( List<Conversation> conversations)  conversationsUpdated,required TResult Function( String id)  selectConversation,required TResult Function( String participantId)  getOrCreateConversation,required TResult Function( String conversationId,  int? limit,  DateTime? before)  loadMessages,required TResult Function( List<Message> messages)  messagesUpdated,required TResult Function( String conversationId,  String text,  String? replyToMessageId)  sendTextMessage,required TResult Function( String conversationId,  File mediaFile,  String mediaType,  String recipientId,  String? caption,  int? durationSeconds,  String? replyToMessageId,  File? thumbnailFile)  sendMediaMessage,required TResult Function( String conversationId,  String recipientId,  int amount,  String? message,  String? subAccountId)  sendTokens,required TResult Function( String conversationId,  String recipientId,  int amount,  String? message,  String? subAccountId)  requestTokens,required TResult Function( String recipientId,  int amount,  bool isSend,  String? message,  String? subAccountId)  sendTokensToUser,required TResult Function( String messageId,  String conversationId)  acceptTokenRequest,required TResult Function( String messageId,  String conversationId)  declineTokenRequest,required TResult Function( String conversationId)  acceptConversation,required TResult Function( int count)  unreadCountUpdated,required TResult Function( String conversationId)  clearChat,required TResult Function( String conversationId,  String messageId)  retryMessage,required TResult Function( String conversationId,  bool isTyping)  setTyping,required TResult Function( Map<String, bool> typingUsers)  typingStateUpdated,required TResult Function( String conversationId,  String query)  searchMessages,required TResult Function()  clearMessageSearch,required TResult Function( String conversationId,  Duration? duration)  setDisappearingMessages,required TResult Function( String sourceConversationId,  String sourceMessageId,  String targetConversationId)  forwardMessage,required TResult Function()  streamError,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _WatchConversations():
return watchConversations();case _ConversationsUpdated():
return conversationsUpdated(_that.conversations);case _SelectConversation():
return selectConversation(_that.id);case _GetOrCreateConversation():
return getOrCreateConversation(_that.participantId);case _LoadMessages():
return loadMessages(_that.conversationId,_that.limit,_that.before);case _MessagesUpdated():
return messagesUpdated(_that.messages);case _SendTextMessage():
return sendTextMessage(_that.conversationId,_that.text,_that.replyToMessageId);case _SendMediaMessage():
return sendMediaMessage(_that.conversationId,_that.mediaFile,_that.mediaType,_that.recipientId,_that.caption,_that.durationSeconds,_that.replyToMessageId,_that.thumbnailFile);case _SendTokens():
return sendTokens(_that.conversationId,_that.recipientId,_that.amount,_that.message,_that.subAccountId);case _RequestTokens():
return requestTokens(_that.conversationId,_that.recipientId,_that.amount,_that.message,_that.subAccountId);case _SendTokensToUser():
return sendTokensToUser(_that.recipientId,_that.amount,_that.isSend,_that.message,_that.subAccountId);case _AcceptTokenRequest():
return acceptTokenRequest(_that.messageId,_that.conversationId);case _DeclineTokenRequest():
return declineTokenRequest(_that.messageId,_that.conversationId);case _AcceptConversation():
return acceptConversation(_that.conversationId);case _UnreadCountUpdated():
return unreadCountUpdated(_that.count);case _ClearChat():
return clearChat(_that.conversationId);case _RetryMessage():
return retryMessage(_that.conversationId,_that.messageId);case _SetTyping():
return setTyping(_that.conversationId,_that.isTyping);case _TypingStateUpdated():
return typingStateUpdated(_that.typingUsers);case _SearchMessages():
return searchMessages(_that.conversationId,_that.query);case _ClearMessageSearch():
return clearMessageSearch();case _SetDisappearingMessages():
return setDisappearingMessages(_that.conversationId,_that.duration);case _ForwardMessage():
return forwardMessage(_that.sourceConversationId,_that.sourceMessageId,_that.targetConversationId);case _StreamError():
return streamError();case _ClearError():
return clearError();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  watchConversations,TResult? Function( List<Conversation> conversations)?  conversationsUpdated,TResult? Function( String id)?  selectConversation,TResult? Function( String participantId)?  getOrCreateConversation,TResult? Function( String conversationId,  int? limit,  DateTime? before)?  loadMessages,TResult? Function( List<Message> messages)?  messagesUpdated,TResult? Function( String conversationId,  String text,  String? replyToMessageId)?  sendTextMessage,TResult? Function( String conversationId,  File mediaFile,  String mediaType,  String recipientId,  String? caption,  int? durationSeconds,  String? replyToMessageId,  File? thumbnailFile)?  sendMediaMessage,TResult? Function( String conversationId,  String recipientId,  int amount,  String? message,  String? subAccountId)?  sendTokens,TResult? Function( String conversationId,  String recipientId,  int amount,  String? message,  String? subAccountId)?  requestTokens,TResult? Function( String recipientId,  int amount,  bool isSend,  String? message,  String? subAccountId)?  sendTokensToUser,TResult? Function( String messageId,  String conversationId)?  acceptTokenRequest,TResult? Function( String messageId,  String conversationId)?  declineTokenRequest,TResult? Function( String conversationId)?  acceptConversation,TResult? Function( int count)?  unreadCountUpdated,TResult? Function( String conversationId)?  clearChat,TResult? Function( String conversationId,  String messageId)?  retryMessage,TResult? Function( String conversationId,  bool isTyping)?  setTyping,TResult? Function( Map<String, bool> typingUsers)?  typingStateUpdated,TResult? Function( String conversationId,  String query)?  searchMessages,TResult? Function()?  clearMessageSearch,TResult? Function( String conversationId,  Duration? duration)?  setDisappearingMessages,TResult? Function( String sourceConversationId,  String sourceMessageId,  String targetConversationId)?  forwardMessage,TResult? Function()?  streamError,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _WatchConversations() when watchConversations != null:
return watchConversations();case _ConversationsUpdated() when conversationsUpdated != null:
return conversationsUpdated(_that.conversations);case _SelectConversation() when selectConversation != null:
return selectConversation(_that.id);case _GetOrCreateConversation() when getOrCreateConversation != null:
return getOrCreateConversation(_that.participantId);case _LoadMessages() when loadMessages != null:
return loadMessages(_that.conversationId,_that.limit,_that.before);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that.conversationId,_that.text,_that.replyToMessageId);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that.conversationId,_that.mediaFile,_that.mediaType,_that.recipientId,_that.caption,_that.durationSeconds,_that.replyToMessageId,_that.thumbnailFile);case _SendTokens() when sendTokens != null:
return sendTokens(_that.conversationId,_that.recipientId,_that.amount,_that.message,_that.subAccountId);case _RequestTokens() when requestTokens != null:
return requestTokens(_that.conversationId,_that.recipientId,_that.amount,_that.message,_that.subAccountId);case _SendTokensToUser() when sendTokensToUser != null:
return sendTokensToUser(_that.recipientId,_that.amount,_that.isSend,_that.message,_that.subAccountId);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that.messageId,_that.conversationId);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that.messageId,_that.conversationId);case _AcceptConversation() when acceptConversation != null:
return acceptConversation(_that.conversationId);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that.count);case _ClearChat() when clearChat != null:
return clearChat(_that.conversationId);case _RetryMessage() when retryMessage != null:
return retryMessage(_that.conversationId,_that.messageId);case _SetTyping() when setTyping != null:
return setTyping(_that.conversationId,_that.isTyping);case _TypingStateUpdated() when typingStateUpdated != null:
return typingStateUpdated(_that.typingUsers);case _SearchMessages() when searchMessages != null:
return searchMessages(_that.conversationId,_that.query);case _ClearMessageSearch() when clearMessageSearch != null:
return clearMessageSearch();case _SetDisappearingMessages() when setDisappearingMessages != null:
return setDisappearingMessages(_that.conversationId,_that.duration);case _ForwardMessage() when forwardMessage != null:
return forwardMessage(_that.sourceConversationId,_that.sourceMessageId,_that.targetConversationId);case _StreamError() when streamError != null:
return streamError();case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _WatchConversations implements ConversationEvent {
  const _WatchConversations();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchConversations);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationEvent.watchConversations()';
}


}




/// @nodoc


class _ConversationsUpdated implements ConversationEvent {
  const _ConversationsUpdated(final  List<Conversation> conversations): _conversations = conversations;
  

 final  List<Conversation> _conversations;
 List<Conversation> get conversations {
  if (_conversations is EqualUnmodifiableListView) return _conversations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversations);
}


/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationsUpdatedCopyWith<_ConversationsUpdated> get copyWith => __$ConversationsUpdatedCopyWithImpl<_ConversationsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationsUpdated&&const DeepCollectionEquality().equals(other._conversations, _conversations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_conversations));

@override
String toString() {
  return 'ConversationEvent.conversationsUpdated(conversations: $conversations)';
}


}

/// @nodoc
abstract mixin class _$ConversationsUpdatedCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$ConversationsUpdatedCopyWith(_ConversationsUpdated value, $Res Function(_ConversationsUpdated) _then) = __$ConversationsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Conversation> conversations
});




}
/// @nodoc
class __$ConversationsUpdatedCopyWithImpl<$Res>
    implements _$ConversationsUpdatedCopyWith<$Res> {
  __$ConversationsUpdatedCopyWithImpl(this._self, this._then);

  final _ConversationsUpdated _self;
  final $Res Function(_ConversationsUpdated) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversations = null,}) {
  return _then(_ConversationsUpdated(
null == conversations ? _self._conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<Conversation>,
  ));
}


}

/// @nodoc


class _SelectConversation implements ConversationEvent {
  const _SelectConversation(this.id);
  

 final  String id;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectConversationCopyWith<_SelectConversation> get copyWith => __$SelectConversationCopyWithImpl<_SelectConversation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectConversation&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ConversationEvent.selectConversation(id: $id)';
}


}

/// @nodoc
abstract mixin class _$SelectConversationCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SelectConversationCopyWith(_SelectConversation value, $Res Function(_SelectConversation) _then) = __$SelectConversationCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$SelectConversationCopyWithImpl<$Res>
    implements _$SelectConversationCopyWith<$Res> {
  __$SelectConversationCopyWithImpl(this._self, this._then);

  final _SelectConversation _self;
  final $Res Function(_SelectConversation) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_SelectConversation(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GetOrCreateConversation implements ConversationEvent {
  const _GetOrCreateConversation(this.participantId);
  

 final  String participantId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetOrCreateConversationCopyWith<_GetOrCreateConversation> get copyWith => __$GetOrCreateConversationCopyWithImpl<_GetOrCreateConversation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetOrCreateConversation&&(identical(other.participantId, participantId) || other.participantId == participantId));
}


@override
int get hashCode => Object.hash(runtimeType,participantId);

@override
String toString() {
  return 'ConversationEvent.getOrCreateConversation(participantId: $participantId)';
}


}

/// @nodoc
abstract mixin class _$GetOrCreateConversationCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$GetOrCreateConversationCopyWith(_GetOrCreateConversation value, $Res Function(_GetOrCreateConversation) _then) = __$GetOrCreateConversationCopyWithImpl;
@useResult
$Res call({
 String participantId
});




}
/// @nodoc
class __$GetOrCreateConversationCopyWithImpl<$Res>
    implements _$GetOrCreateConversationCopyWith<$Res> {
  __$GetOrCreateConversationCopyWithImpl(this._self, this._then);

  final _GetOrCreateConversation _self;
  final $Res Function(_GetOrCreateConversation) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? participantId = null,}) {
  return _then(_GetOrCreateConversation(
null == participantId ? _self.participantId : participantId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadMessages implements ConversationEvent {
  const _LoadMessages({required this.conversationId, this.limit, this.before});
  

 final  String conversationId;
 final  int? limit;
 final  DateTime? before;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadMessagesCopyWith<_LoadMessages> get copyWith => __$LoadMessagesCopyWithImpl<_LoadMessages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMessages&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.before, before) || other.before == before));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,limit,before);

@override
String toString() {
  return 'ConversationEvent.loadMessages(conversationId: $conversationId, limit: $limit, before: $before)';
}


}

/// @nodoc
abstract mixin class _$LoadMessagesCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$LoadMessagesCopyWith(_LoadMessages value, $Res Function(_LoadMessages) _then) = __$LoadMessagesCopyWithImpl;
@useResult
$Res call({
 String conversationId, int? limit, DateTime? before
});




}
/// @nodoc
class __$LoadMessagesCopyWithImpl<$Res>
    implements _$LoadMessagesCopyWith<$Res> {
  __$LoadMessagesCopyWithImpl(this._self, this._then);

  final _LoadMessages _self;
  final $Res Function(_LoadMessages) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? limit = freezed,Object? before = freezed,}) {
  return _then(_LoadMessages(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,before: freezed == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _MessagesUpdated implements ConversationEvent {
  const _MessagesUpdated(final  List<Message> messages): _messages = messages;
  

 final  List<Message> _messages;
 List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesUpdatedCopyWith<_MessagesUpdated> get copyWith => __$MessagesUpdatedCopyWithImpl<_MessagesUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesUpdated&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ConversationEvent.messagesUpdated(messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$MessagesUpdatedCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$MessagesUpdatedCopyWith(_MessagesUpdated value, $Res Function(_MessagesUpdated) _then) = __$MessagesUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Message> messages
});




}
/// @nodoc
class __$MessagesUpdatedCopyWithImpl<$Res>
    implements _$MessagesUpdatedCopyWith<$Res> {
  __$MessagesUpdatedCopyWithImpl(this._self, this._then);

  final _MessagesUpdated _self;
  final $Res Function(_MessagesUpdated) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(_MessagesUpdated(
null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,
  ));
}


}

/// @nodoc


class _SendTextMessage implements ConversationEvent {
  const _SendTextMessage({required this.conversationId, required this.text, this.replyToMessageId});
  

 final  String conversationId;
 final  String text;
 final  String? replyToMessageId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTextMessageCopyWith<_SendTextMessage> get copyWith => __$SendTextMessageCopyWithImpl<_SendTextMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendTextMessage&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.text, text) || other.text == text)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,text,replyToMessageId);

@override
String toString() {
  return 'ConversationEvent.sendTextMessage(conversationId: $conversationId, text: $text, replyToMessageId: $replyToMessageId)';
}


}

/// @nodoc
abstract mixin class _$SendTextMessageCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SendTextMessageCopyWith(_SendTextMessage value, $Res Function(_SendTextMessage) _then) = __$SendTextMessageCopyWithImpl;
@useResult
$Res call({
 String conversationId, String text, String? replyToMessageId
});




}
/// @nodoc
class __$SendTextMessageCopyWithImpl<$Res>
    implements _$SendTextMessageCopyWith<$Res> {
  __$SendTextMessageCopyWithImpl(this._self, this._then);

  final _SendTextMessage _self;
  final $Res Function(_SendTextMessage) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? text = null,Object? replyToMessageId = freezed,}) {
  return _then(_SendTextMessage(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SendMediaMessage implements ConversationEvent {
  const _SendMediaMessage({required this.conversationId, required this.mediaFile, required this.mediaType, required this.recipientId, this.caption, this.durationSeconds, this.replyToMessageId, this.thumbnailFile});
  

 final  String conversationId;
 final  File mediaFile;
 final  String mediaType;
 final  String recipientId;
 final  String? caption;
 final  int? durationSeconds;
 final  String? replyToMessageId;
 final  File? thumbnailFile;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendMediaMessageCopyWith<_SendMediaMessage> get copyWith => __$SendMediaMessageCopyWithImpl<_SendMediaMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendMediaMessage&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.mediaFile, mediaFile) || other.mediaFile == mediaFile)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.thumbnailFile, thumbnailFile) || other.thumbnailFile == thumbnailFile));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,mediaFile,mediaType,recipientId,caption,durationSeconds,replyToMessageId,thumbnailFile);

@override
String toString() {
  return 'ConversationEvent.sendMediaMessage(conversationId: $conversationId, mediaFile: $mediaFile, mediaType: $mediaType, recipientId: $recipientId, caption: $caption, durationSeconds: $durationSeconds, replyToMessageId: $replyToMessageId, thumbnailFile: $thumbnailFile)';
}


}

/// @nodoc
abstract mixin class _$SendMediaMessageCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SendMediaMessageCopyWith(_SendMediaMessage value, $Res Function(_SendMediaMessage) _then) = __$SendMediaMessageCopyWithImpl;
@useResult
$Res call({
 String conversationId, File mediaFile, String mediaType, String recipientId, String? caption, int? durationSeconds, String? replyToMessageId, File? thumbnailFile
});




}
/// @nodoc
class __$SendMediaMessageCopyWithImpl<$Res>
    implements _$SendMediaMessageCopyWith<$Res> {
  __$SendMediaMessageCopyWithImpl(this._self, this._then);

  final _SendMediaMessage _self;
  final $Res Function(_SendMediaMessage) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? mediaFile = null,Object? mediaType = null,Object? recipientId = null,Object? caption = freezed,Object? durationSeconds = freezed,Object? replyToMessageId = freezed,Object? thumbnailFile = freezed,}) {
  return _then(_SendMediaMessage(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,mediaFile: null == mediaFile ? _self.mediaFile : mediaFile // ignore: cast_nullable_to_non_nullable
as File,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,thumbnailFile: freezed == thumbnailFile ? _self.thumbnailFile : thumbnailFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

/// @nodoc


class _SendTokens implements ConversationEvent {
  const _SendTokens({required this.conversationId, required this.recipientId, required this.amount, this.message, this.subAccountId});
  

 final  String conversationId;
 final  String recipientId;
 final  int amount;
 final  String? message;
 final  String? subAccountId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTokensCopyWith<_SendTokens> get copyWith => __$SendTokensCopyWithImpl<_SendTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendTokens&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message)&&(identical(other.subAccountId, subAccountId) || other.subAccountId == subAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,recipientId,amount,message,subAccountId);

@override
String toString() {
  return 'ConversationEvent.sendTokens(conversationId: $conversationId, recipientId: $recipientId, amount: $amount, message: $message, subAccountId: $subAccountId)';
}


}

/// @nodoc
abstract mixin class _$SendTokensCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SendTokensCopyWith(_SendTokens value, $Res Function(_SendTokens) _then) = __$SendTokensCopyWithImpl;
@useResult
$Res call({
 String conversationId, String recipientId, int amount, String? message, String? subAccountId
});




}
/// @nodoc
class __$SendTokensCopyWithImpl<$Res>
    implements _$SendTokensCopyWith<$Res> {
  __$SendTokensCopyWithImpl(this._self, this._then);

  final _SendTokens _self;
  final $Res Function(_SendTokens) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? recipientId = null,Object? amount = null,Object? message = freezed,Object? subAccountId = freezed,}) {
  return _then(_SendTokens(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,subAccountId: freezed == subAccountId ? _self.subAccountId : subAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RequestTokens implements ConversationEvent {
  const _RequestTokens({required this.conversationId, required this.recipientId, required this.amount, this.message, this.subAccountId});
  

 final  String conversationId;
 final  String recipientId;
 final  int amount;
 final  String? message;
 final  String? subAccountId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestTokensCopyWith<_RequestTokens> get copyWith => __$RequestTokensCopyWithImpl<_RequestTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestTokens&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message)&&(identical(other.subAccountId, subAccountId) || other.subAccountId == subAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,recipientId,amount,message,subAccountId);

@override
String toString() {
  return 'ConversationEvent.requestTokens(conversationId: $conversationId, recipientId: $recipientId, amount: $amount, message: $message, subAccountId: $subAccountId)';
}


}

/// @nodoc
abstract mixin class _$RequestTokensCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$RequestTokensCopyWith(_RequestTokens value, $Res Function(_RequestTokens) _then) = __$RequestTokensCopyWithImpl;
@useResult
$Res call({
 String conversationId, String recipientId, int amount, String? message, String? subAccountId
});




}
/// @nodoc
class __$RequestTokensCopyWithImpl<$Res>
    implements _$RequestTokensCopyWith<$Res> {
  __$RequestTokensCopyWithImpl(this._self, this._then);

  final _RequestTokens _self;
  final $Res Function(_RequestTokens) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? recipientId = null,Object? amount = null,Object? message = freezed,Object? subAccountId = freezed,}) {
  return _then(_RequestTokens(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,subAccountId: freezed == subAccountId ? _self.subAccountId : subAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SendTokensToUser implements ConversationEvent {
  const _SendTokensToUser({required this.recipientId, required this.amount, required this.isSend, this.message, this.subAccountId});
  

 final  String recipientId;
 final  int amount;
 final  bool isSend;
 final  String? message;
 final  String? subAccountId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTokensToUserCopyWith<_SendTokensToUser> get copyWith => __$SendTokensToUserCopyWithImpl<_SendTokensToUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendTokensToUser&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isSend, isSend) || other.isSend == isSend)&&(identical(other.message, message) || other.message == message)&&(identical(other.subAccountId, subAccountId) || other.subAccountId == subAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,recipientId,amount,isSend,message,subAccountId);

@override
String toString() {
  return 'ConversationEvent.sendTokensToUser(recipientId: $recipientId, amount: $amount, isSend: $isSend, message: $message, subAccountId: $subAccountId)';
}


}

/// @nodoc
abstract mixin class _$SendTokensToUserCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SendTokensToUserCopyWith(_SendTokensToUser value, $Res Function(_SendTokensToUser) _then) = __$SendTokensToUserCopyWithImpl;
@useResult
$Res call({
 String recipientId, int amount, bool isSend, String? message, String? subAccountId
});




}
/// @nodoc
class __$SendTokensToUserCopyWithImpl<$Res>
    implements _$SendTokensToUserCopyWith<$Res> {
  __$SendTokensToUserCopyWithImpl(this._self, this._then);

  final _SendTokensToUser _self;
  final $Res Function(_SendTokensToUser) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recipientId = null,Object? amount = null,Object? isSend = null,Object? message = freezed,Object? subAccountId = freezed,}) {
  return _then(_SendTokensToUser(
recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,isSend: null == isSend ? _self.isSend : isSend // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,subAccountId: freezed == subAccountId ? _self.subAccountId : subAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AcceptTokenRequest implements ConversationEvent {
  const _AcceptTokenRequest({required this.messageId, required this.conversationId});
  

 final  String messageId;
 final  String conversationId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptTokenRequestCopyWith<_AcceptTokenRequest> get copyWith => __$AcceptTokenRequestCopyWithImpl<_AcceptTokenRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptTokenRequest&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId);

@override
String toString() {
  return 'ConversationEvent.acceptTokenRequest(messageId: $messageId, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$AcceptTokenRequestCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$AcceptTokenRequestCopyWith(_AcceptTokenRequest value, $Res Function(_AcceptTokenRequest) _then) = __$AcceptTokenRequestCopyWithImpl;
@useResult
$Res call({
 String messageId, String conversationId
});




}
/// @nodoc
class __$AcceptTokenRequestCopyWithImpl<$Res>
    implements _$AcceptTokenRequestCopyWith<$Res> {
  __$AcceptTokenRequestCopyWithImpl(this._self, this._then);

  final _AcceptTokenRequest _self;
  final $Res Function(_AcceptTokenRequest) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? conversationId = null,}) {
  return _then(_AcceptTokenRequest(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeclineTokenRequest implements ConversationEvent {
  const _DeclineTokenRequest({required this.messageId, required this.conversationId});
  

 final  String messageId;
 final  String conversationId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclineTokenRequestCopyWith<_DeclineTokenRequest> get copyWith => __$DeclineTokenRequestCopyWithImpl<_DeclineTokenRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclineTokenRequest&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId);

@override
String toString() {
  return 'ConversationEvent.declineTokenRequest(messageId: $messageId, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$DeclineTokenRequestCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$DeclineTokenRequestCopyWith(_DeclineTokenRequest value, $Res Function(_DeclineTokenRequest) _then) = __$DeclineTokenRequestCopyWithImpl;
@useResult
$Res call({
 String messageId, String conversationId
});




}
/// @nodoc
class __$DeclineTokenRequestCopyWithImpl<$Res>
    implements _$DeclineTokenRequestCopyWith<$Res> {
  __$DeclineTokenRequestCopyWithImpl(this._self, this._then);

  final _DeclineTokenRequest _self;
  final $Res Function(_DeclineTokenRequest) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? conversationId = null,}) {
  return _then(_DeclineTokenRequest(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AcceptConversation implements ConversationEvent {
  const _AcceptConversation(this.conversationId);
  

 final  String conversationId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptConversationCopyWith<_AcceptConversation> get copyWith => __$AcceptConversationCopyWithImpl<_AcceptConversation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptConversation&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ConversationEvent.acceptConversation(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$AcceptConversationCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$AcceptConversationCopyWith(_AcceptConversation value, $Res Function(_AcceptConversation) _then) = __$AcceptConversationCopyWithImpl;
@useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class __$AcceptConversationCopyWithImpl<$Res>
    implements _$AcceptConversationCopyWith<$Res> {
  __$AcceptConversationCopyWithImpl(this._self, this._then);

  final _AcceptConversation _self;
  final $Res Function(_AcceptConversation) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,}) {
  return _then(_AcceptConversation(
null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UnreadCountUpdated implements ConversationEvent {
  const _UnreadCountUpdated(this.count);
  

 final  int count;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnreadCountUpdatedCopyWith<_UnreadCountUpdated> get copyWith => __$UnreadCountUpdatedCopyWithImpl<_UnreadCountUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnreadCountUpdated&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'ConversationEvent.unreadCountUpdated(count: $count)';
}


}

/// @nodoc
abstract mixin class _$UnreadCountUpdatedCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$UnreadCountUpdatedCopyWith(_UnreadCountUpdated value, $Res Function(_UnreadCountUpdated) _then) = __$UnreadCountUpdatedCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class __$UnreadCountUpdatedCopyWithImpl<$Res>
    implements _$UnreadCountUpdatedCopyWith<$Res> {
  __$UnreadCountUpdatedCopyWithImpl(this._self, this._then);

  final _UnreadCountUpdated _self;
  final $Res Function(_UnreadCountUpdated) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_UnreadCountUpdated(
null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ClearChat implements ConversationEvent {
  const _ClearChat(this.conversationId);
  

 final  String conversationId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClearChatCopyWith<_ClearChat> get copyWith => __$ClearChatCopyWithImpl<_ClearChat>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearChat&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ConversationEvent.clearChat(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$ClearChatCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$ClearChatCopyWith(_ClearChat value, $Res Function(_ClearChat) _then) = __$ClearChatCopyWithImpl;
@useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class __$ClearChatCopyWithImpl<$Res>
    implements _$ClearChatCopyWith<$Res> {
  __$ClearChatCopyWithImpl(this._self, this._then);

  final _ClearChat _self;
  final $Res Function(_ClearChat) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,}) {
  return _then(_ClearChat(
null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RetryMessage implements ConversationEvent {
  const _RetryMessage({required this.conversationId, required this.messageId});
  

 final  String conversationId;
 final  String messageId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryMessageCopyWith<_RetryMessage> get copyWith => __$RetryMessageCopyWithImpl<_RetryMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryMessage&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,messageId);

@override
String toString() {
  return 'ConversationEvent.retryMessage(conversationId: $conversationId, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class _$RetryMessageCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$RetryMessageCopyWith(_RetryMessage value, $Res Function(_RetryMessage) _then) = __$RetryMessageCopyWithImpl;
@useResult
$Res call({
 String conversationId, String messageId
});




}
/// @nodoc
class __$RetryMessageCopyWithImpl<$Res>
    implements _$RetryMessageCopyWith<$Res> {
  __$RetryMessageCopyWithImpl(this._self, this._then);

  final _RetryMessage _self;
  final $Res Function(_RetryMessage) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? messageId = null,}) {
  return _then(_RetryMessage(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SetTyping implements ConversationEvent {
  const _SetTyping({required this.conversationId, required this.isTyping});
  

 final  String conversationId;
 final  bool isTyping;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetTypingCopyWith<_SetTyping> get copyWith => __$SetTypingCopyWithImpl<_SetTyping>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetTyping&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.isTyping, isTyping) || other.isTyping == isTyping));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,isTyping);

@override
String toString() {
  return 'ConversationEvent.setTyping(conversationId: $conversationId, isTyping: $isTyping)';
}


}

/// @nodoc
abstract mixin class _$SetTypingCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SetTypingCopyWith(_SetTyping value, $Res Function(_SetTyping) _then) = __$SetTypingCopyWithImpl;
@useResult
$Res call({
 String conversationId, bool isTyping
});




}
/// @nodoc
class __$SetTypingCopyWithImpl<$Res>
    implements _$SetTypingCopyWith<$Res> {
  __$SetTypingCopyWithImpl(this._self, this._then);

  final _SetTyping _self;
  final $Res Function(_SetTyping) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? isTyping = null,}) {
  return _then(_SetTyping(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,isTyping: null == isTyping ? _self.isTyping : isTyping // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _TypingStateUpdated implements ConversationEvent {
  const _TypingStateUpdated(final  Map<String, bool> typingUsers): _typingUsers = typingUsers;
  

 final  Map<String, bool> _typingUsers;
 Map<String, bool> get typingUsers {
  if (_typingUsers is EqualUnmodifiableMapView) return _typingUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_typingUsers);
}


/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypingStateUpdatedCopyWith<_TypingStateUpdated> get copyWith => __$TypingStateUpdatedCopyWithImpl<_TypingStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypingStateUpdated&&const DeepCollectionEquality().equals(other._typingUsers, _typingUsers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_typingUsers));

@override
String toString() {
  return 'ConversationEvent.typingStateUpdated(typingUsers: $typingUsers)';
}


}

/// @nodoc
abstract mixin class _$TypingStateUpdatedCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$TypingStateUpdatedCopyWith(_TypingStateUpdated value, $Res Function(_TypingStateUpdated) _then) = __$TypingStateUpdatedCopyWithImpl;
@useResult
$Res call({
 Map<String, bool> typingUsers
});




}
/// @nodoc
class __$TypingStateUpdatedCopyWithImpl<$Res>
    implements _$TypingStateUpdatedCopyWith<$Res> {
  __$TypingStateUpdatedCopyWithImpl(this._self, this._then);

  final _TypingStateUpdated _self;
  final $Res Function(_TypingStateUpdated) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? typingUsers = null,}) {
  return _then(_TypingStateUpdated(
null == typingUsers ? _self._typingUsers : typingUsers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}


}

/// @nodoc


class _SearchMessages implements ConversationEvent {
  const _SearchMessages({required this.conversationId, required this.query});
  

 final  String conversationId;
 final  String query;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchMessagesCopyWith<_SearchMessages> get copyWith => __$SearchMessagesCopyWithImpl<_SearchMessages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchMessages&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,query);

@override
String toString() {
  return 'ConversationEvent.searchMessages(conversationId: $conversationId, query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchMessagesCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SearchMessagesCopyWith(_SearchMessages value, $Res Function(_SearchMessages) _then) = __$SearchMessagesCopyWithImpl;
@useResult
$Res call({
 String conversationId, String query
});




}
/// @nodoc
class __$SearchMessagesCopyWithImpl<$Res>
    implements _$SearchMessagesCopyWith<$Res> {
  __$SearchMessagesCopyWithImpl(this._self, this._then);

  final _SearchMessages _self;
  final $Res Function(_SearchMessages) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? query = null,}) {
  return _then(_SearchMessages(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearMessageSearch implements ConversationEvent {
  const _ClearMessageSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearMessageSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationEvent.clearMessageSearch()';
}


}




/// @nodoc


class _SetDisappearingMessages implements ConversationEvent {
  const _SetDisappearingMessages({required this.conversationId, required this.duration});
  

 final  String conversationId;
 final  Duration? duration;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetDisappearingMessagesCopyWith<_SetDisappearingMessages> get copyWith => __$SetDisappearingMessagesCopyWithImpl<_SetDisappearingMessages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetDisappearingMessages&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,duration);

@override
String toString() {
  return 'ConversationEvent.setDisappearingMessages(conversationId: $conversationId, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$SetDisappearingMessagesCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$SetDisappearingMessagesCopyWith(_SetDisappearingMessages value, $Res Function(_SetDisappearingMessages) _then) = __$SetDisappearingMessagesCopyWithImpl;
@useResult
$Res call({
 String conversationId, Duration? duration
});




}
/// @nodoc
class __$SetDisappearingMessagesCopyWithImpl<$Res>
    implements _$SetDisappearingMessagesCopyWith<$Res> {
  __$SetDisappearingMessagesCopyWithImpl(this._self, this._then);

  final _SetDisappearingMessages _self;
  final $Res Function(_SetDisappearingMessages) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? duration = freezed,}) {
  return _then(_SetDisappearingMessages(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

/// @nodoc


class _ForwardMessage implements ConversationEvent {
  const _ForwardMessage({required this.sourceConversationId, required this.sourceMessageId, required this.targetConversationId});
  

 final  String sourceConversationId;
 final  String sourceMessageId;
 final  String targetConversationId;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForwardMessageCopyWith<_ForwardMessage> get copyWith => __$ForwardMessageCopyWithImpl<_ForwardMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForwardMessage&&(identical(other.sourceConversationId, sourceConversationId) || other.sourceConversationId == sourceConversationId)&&(identical(other.sourceMessageId, sourceMessageId) || other.sourceMessageId == sourceMessageId)&&(identical(other.targetConversationId, targetConversationId) || other.targetConversationId == targetConversationId));
}


@override
int get hashCode => Object.hash(runtimeType,sourceConversationId,sourceMessageId,targetConversationId);

@override
String toString() {
  return 'ConversationEvent.forwardMessage(sourceConversationId: $sourceConversationId, sourceMessageId: $sourceMessageId, targetConversationId: $targetConversationId)';
}


}

/// @nodoc
abstract mixin class _$ForwardMessageCopyWith<$Res> implements $ConversationEventCopyWith<$Res> {
  factory _$ForwardMessageCopyWith(_ForwardMessage value, $Res Function(_ForwardMessage) _then) = __$ForwardMessageCopyWithImpl;
@useResult
$Res call({
 String sourceConversationId, String sourceMessageId, String targetConversationId
});




}
/// @nodoc
class __$ForwardMessageCopyWithImpl<$Res>
    implements _$ForwardMessageCopyWith<$Res> {
  __$ForwardMessageCopyWithImpl(this._self, this._then);

  final _ForwardMessage _self;
  final $Res Function(_ForwardMessage) _then;

/// Create a copy of ConversationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sourceConversationId = null,Object? sourceMessageId = null,Object? targetConversationId = null,}) {
  return _then(_ForwardMessage(
sourceConversationId: null == sourceConversationId ? _self.sourceConversationId : sourceConversationId // ignore: cast_nullable_to_non_nullable
as String,sourceMessageId: null == sourceMessageId ? _self.sourceMessageId : sourceMessageId // ignore: cast_nullable_to_non_nullable
as String,targetConversationId: null == targetConversationId ? _self.targetConversationId : targetConversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _StreamError implements ConversationEvent {
  const _StreamError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreamError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationEvent.streamError()';
}


}




/// @nodoc


class _ClearError implements ConversationEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationEvent.clearError()';
}


}




/// @nodoc
mixin _$ConversationState {

 ConversationStatus get status; List<Conversation> get conversations; List<Message> get messages; Conversation? get selectedConversation; bool get isLoadingMessages; bool get hasLoadedMessages; bool get isSyncingMessages; bool get hasMoreMessages; bool get isSending; bool get isClearingChat; int get totalUnreadCount; int get messageRequestCount; String? get errorMessage;// Typing indicators
 Map<String, bool> get typingUsers;// Message search
 List<Message> get messageSearchResults; bool get isSearchingMessages; String? get messageSearchQuery;// Message forwarding
 bool get isForwarding;// Stream health — surfaces connection errors as a dismissable banner
 bool get hasStreamError;
/// Create a copy of ConversationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationStateCopyWith<ConversationState> get copyWith => _$ConversationStateCopyWithImpl<ConversationState>(this as ConversationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.conversations, conversations)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.selectedConversation, selectedConversation) || other.selectedConversation == selectedConversation)&&(identical(other.isLoadingMessages, isLoadingMessages) || other.isLoadingMessages == isLoadingMessages)&&(identical(other.hasLoadedMessages, hasLoadedMessages) || other.hasLoadedMessages == hasLoadedMessages)&&(identical(other.isSyncingMessages, isSyncingMessages) || other.isSyncingMessages == isSyncingMessages)&&(identical(other.hasMoreMessages, hasMoreMessages) || other.hasMoreMessages == hasMoreMessages)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.isClearingChat, isClearingChat) || other.isClearingChat == isClearingChat)&&(identical(other.totalUnreadCount, totalUnreadCount) || other.totalUnreadCount == totalUnreadCount)&&(identical(other.messageRequestCount, messageRequestCount) || other.messageRequestCount == messageRequestCount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.typingUsers, typingUsers)&&const DeepCollectionEquality().equals(other.messageSearchResults, messageSearchResults)&&(identical(other.isSearchingMessages, isSearchingMessages) || other.isSearchingMessages == isSearchingMessages)&&(identical(other.messageSearchQuery, messageSearchQuery) || other.messageSearchQuery == messageSearchQuery)&&(identical(other.isForwarding, isForwarding) || other.isForwarding == isForwarding)&&(identical(other.hasStreamError, hasStreamError) || other.hasStreamError == hasStreamError));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,const DeepCollectionEquality().hash(conversations),const DeepCollectionEquality().hash(messages),selectedConversation,isLoadingMessages,hasLoadedMessages,isSyncingMessages,hasMoreMessages,isSending,isClearingChat,totalUnreadCount,messageRequestCount,errorMessage,const DeepCollectionEquality().hash(typingUsers),const DeepCollectionEquality().hash(messageSearchResults),isSearchingMessages,messageSearchQuery,isForwarding,hasStreamError]);

@override
String toString() {
  return 'ConversationState(status: $status, conversations: $conversations, messages: $messages, selectedConversation: $selectedConversation, isLoadingMessages: $isLoadingMessages, hasLoadedMessages: $hasLoadedMessages, isSyncingMessages: $isSyncingMessages, hasMoreMessages: $hasMoreMessages, isSending: $isSending, isClearingChat: $isClearingChat, totalUnreadCount: $totalUnreadCount, messageRequestCount: $messageRequestCount, errorMessage: $errorMessage, typingUsers: $typingUsers, messageSearchResults: $messageSearchResults, isSearchingMessages: $isSearchingMessages, messageSearchQuery: $messageSearchQuery, isForwarding: $isForwarding, hasStreamError: $hasStreamError)';
}


}

/// @nodoc
abstract mixin class $ConversationStateCopyWith<$Res>  {
  factory $ConversationStateCopyWith(ConversationState value, $Res Function(ConversationState) _then) = _$ConversationStateCopyWithImpl;
@useResult
$Res call({
 ConversationStatus status, List<Conversation> conversations, List<Message> messages, Conversation? selectedConversation, bool isLoadingMessages, bool hasLoadedMessages, bool isSyncingMessages, bool hasMoreMessages, bool isSending, bool isClearingChat, int totalUnreadCount, int messageRequestCount, String? errorMessage, Map<String, bool> typingUsers, List<Message> messageSearchResults, bool isSearchingMessages, String? messageSearchQuery, bool isForwarding, bool hasStreamError
});


$ConversationCopyWith<$Res>? get selectedConversation;

}
/// @nodoc
class _$ConversationStateCopyWithImpl<$Res>
    implements $ConversationStateCopyWith<$Res> {
  _$ConversationStateCopyWithImpl(this._self, this._then);

  final ConversationState _self;
  final $Res Function(ConversationState) _then;

/// Create a copy of ConversationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? conversations = null,Object? messages = null,Object? selectedConversation = freezed,Object? isLoadingMessages = null,Object? hasLoadedMessages = null,Object? isSyncingMessages = null,Object? hasMoreMessages = null,Object? isSending = null,Object? isClearingChat = null,Object? totalUnreadCount = null,Object? messageRequestCount = null,Object? errorMessage = freezed,Object? typingUsers = null,Object? messageSearchResults = null,Object? isSearchingMessages = null,Object? messageSearchQuery = freezed,Object? isForwarding = null,Object? hasStreamError = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConversationStatus,conversations: null == conversations ? _self.conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<Conversation>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,selectedConversation: freezed == selectedConversation ? _self.selectedConversation : selectedConversation // ignore: cast_nullable_to_non_nullable
as Conversation?,isLoadingMessages: null == isLoadingMessages ? _self.isLoadingMessages : isLoadingMessages // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedMessages: null == hasLoadedMessages ? _self.hasLoadedMessages : hasLoadedMessages // ignore: cast_nullable_to_non_nullable
as bool,isSyncingMessages: null == isSyncingMessages ? _self.isSyncingMessages : isSyncingMessages // ignore: cast_nullable_to_non_nullable
as bool,hasMoreMessages: null == hasMoreMessages ? _self.hasMoreMessages : hasMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,isClearingChat: null == isClearingChat ? _self.isClearingChat : isClearingChat // ignore: cast_nullable_to_non_nullable
as bool,totalUnreadCount: null == totalUnreadCount ? _self.totalUnreadCount : totalUnreadCount // ignore: cast_nullable_to_non_nullable
as int,messageRequestCount: null == messageRequestCount ? _self.messageRequestCount : messageRequestCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,typingUsers: null == typingUsers ? _self.typingUsers : typingUsers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,messageSearchResults: null == messageSearchResults ? _self.messageSearchResults : messageSearchResults // ignore: cast_nullable_to_non_nullable
as List<Message>,isSearchingMessages: null == isSearchingMessages ? _self.isSearchingMessages : isSearchingMessages // ignore: cast_nullable_to_non_nullable
as bool,messageSearchQuery: freezed == messageSearchQuery ? _self.messageSearchQuery : messageSearchQuery // ignore: cast_nullable_to_non_nullable
as String?,isForwarding: null == isForwarding ? _self.isForwarding : isForwarding // ignore: cast_nullable_to_non_nullable
as bool,hasStreamError: null == hasStreamError ? _self.hasStreamError : hasStreamError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversationCopyWith<$Res>? get selectedConversation {
    if (_self.selectedConversation == null) {
    return null;
  }

  return $ConversationCopyWith<$Res>(_self.selectedConversation!, (value) {
    return _then(_self.copyWith(selectedConversation: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConversationState].
extension ConversationStatePatterns on ConversationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationState value)  $default,){
final _that = this;
switch (_that) {
case _ConversationState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationState value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConversationStatus status,  List<Conversation> conversations,  List<Message> messages,  Conversation? selectedConversation,  bool isLoadingMessages,  bool hasLoadedMessages,  bool isSyncingMessages,  bool hasMoreMessages,  bool isSending,  bool isClearingChat,  int totalUnreadCount,  int messageRequestCount,  String? errorMessage,  Map<String, bool> typingUsers,  List<Message> messageSearchResults,  bool isSearchingMessages,  String? messageSearchQuery,  bool isForwarding,  bool hasStreamError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationState() when $default != null:
return $default(_that.status,_that.conversations,_that.messages,_that.selectedConversation,_that.isLoadingMessages,_that.hasLoadedMessages,_that.isSyncingMessages,_that.hasMoreMessages,_that.isSending,_that.isClearingChat,_that.totalUnreadCount,_that.messageRequestCount,_that.errorMessage,_that.typingUsers,_that.messageSearchResults,_that.isSearchingMessages,_that.messageSearchQuery,_that.isForwarding,_that.hasStreamError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConversationStatus status,  List<Conversation> conversations,  List<Message> messages,  Conversation? selectedConversation,  bool isLoadingMessages,  bool hasLoadedMessages,  bool isSyncingMessages,  bool hasMoreMessages,  bool isSending,  bool isClearingChat,  int totalUnreadCount,  int messageRequestCount,  String? errorMessage,  Map<String, bool> typingUsers,  List<Message> messageSearchResults,  bool isSearchingMessages,  String? messageSearchQuery,  bool isForwarding,  bool hasStreamError)  $default,) {final _that = this;
switch (_that) {
case _ConversationState():
return $default(_that.status,_that.conversations,_that.messages,_that.selectedConversation,_that.isLoadingMessages,_that.hasLoadedMessages,_that.isSyncingMessages,_that.hasMoreMessages,_that.isSending,_that.isClearingChat,_that.totalUnreadCount,_that.messageRequestCount,_that.errorMessage,_that.typingUsers,_that.messageSearchResults,_that.isSearchingMessages,_that.messageSearchQuery,_that.isForwarding,_that.hasStreamError);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConversationStatus status,  List<Conversation> conversations,  List<Message> messages,  Conversation? selectedConversation,  bool isLoadingMessages,  bool hasLoadedMessages,  bool isSyncingMessages,  bool hasMoreMessages,  bool isSending,  bool isClearingChat,  int totalUnreadCount,  int messageRequestCount,  String? errorMessage,  Map<String, bool> typingUsers,  List<Message> messageSearchResults,  bool isSearchingMessages,  String? messageSearchQuery,  bool isForwarding,  bool hasStreamError)?  $default,) {final _that = this;
switch (_that) {
case _ConversationState() when $default != null:
return $default(_that.status,_that.conversations,_that.messages,_that.selectedConversation,_that.isLoadingMessages,_that.hasLoadedMessages,_that.isSyncingMessages,_that.hasMoreMessages,_that.isSending,_that.isClearingChat,_that.totalUnreadCount,_that.messageRequestCount,_that.errorMessage,_that.typingUsers,_that.messageSearchResults,_that.isSearchingMessages,_that.messageSearchQuery,_that.isForwarding,_that.hasStreamError);case _:
  return null;

}
}

}

/// @nodoc


class _ConversationState extends ConversationState {
  const _ConversationState({this.status = ConversationStatus.initial, final  List<Conversation> conversations = const [], final  List<Message> messages = const [], this.selectedConversation, this.isLoadingMessages = false, this.hasLoadedMessages = false, this.isSyncingMessages = false, this.hasMoreMessages = false, this.isSending = false, this.isClearingChat = false, this.totalUnreadCount = 0, this.messageRequestCount = 0, this.errorMessage, final  Map<String, bool> typingUsers = const {}, final  List<Message> messageSearchResults = const [], this.isSearchingMessages = false, this.messageSearchQuery, this.isForwarding = false, this.hasStreamError = false}): _conversations = conversations,_messages = messages,_typingUsers = typingUsers,_messageSearchResults = messageSearchResults,super._();
  

@override@JsonKey() final  ConversationStatus status;
 final  List<Conversation> _conversations;
@override@JsonKey() List<Conversation> get conversations {
  if (_conversations is EqualUnmodifiableListView) return _conversations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversations);
}

 final  List<Message> _messages;
@override@JsonKey() List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  Conversation? selectedConversation;
@override@JsonKey() final  bool isLoadingMessages;
@override@JsonKey() final  bool hasLoadedMessages;
@override@JsonKey() final  bool isSyncingMessages;
@override@JsonKey() final  bool hasMoreMessages;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  bool isClearingChat;
@override@JsonKey() final  int totalUnreadCount;
@override@JsonKey() final  int messageRequestCount;
@override final  String? errorMessage;
// Typing indicators
 final  Map<String, bool> _typingUsers;
// Typing indicators
@override@JsonKey() Map<String, bool> get typingUsers {
  if (_typingUsers is EqualUnmodifiableMapView) return _typingUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_typingUsers);
}

// Message search
 final  List<Message> _messageSearchResults;
// Message search
@override@JsonKey() List<Message> get messageSearchResults {
  if (_messageSearchResults is EqualUnmodifiableListView) return _messageSearchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messageSearchResults);
}

@override@JsonKey() final  bool isSearchingMessages;
@override final  String? messageSearchQuery;
// Message forwarding
@override@JsonKey() final  bool isForwarding;
// Stream health — surfaces connection errors as a dismissable banner
@override@JsonKey() final  bool hasStreamError;

/// Create a copy of ConversationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationStateCopyWith<_ConversationState> get copyWith => __$ConversationStateCopyWithImpl<_ConversationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._conversations, _conversations)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.selectedConversation, selectedConversation) || other.selectedConversation == selectedConversation)&&(identical(other.isLoadingMessages, isLoadingMessages) || other.isLoadingMessages == isLoadingMessages)&&(identical(other.hasLoadedMessages, hasLoadedMessages) || other.hasLoadedMessages == hasLoadedMessages)&&(identical(other.isSyncingMessages, isSyncingMessages) || other.isSyncingMessages == isSyncingMessages)&&(identical(other.hasMoreMessages, hasMoreMessages) || other.hasMoreMessages == hasMoreMessages)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.isClearingChat, isClearingChat) || other.isClearingChat == isClearingChat)&&(identical(other.totalUnreadCount, totalUnreadCount) || other.totalUnreadCount == totalUnreadCount)&&(identical(other.messageRequestCount, messageRequestCount) || other.messageRequestCount == messageRequestCount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._typingUsers, _typingUsers)&&const DeepCollectionEquality().equals(other._messageSearchResults, _messageSearchResults)&&(identical(other.isSearchingMessages, isSearchingMessages) || other.isSearchingMessages == isSearchingMessages)&&(identical(other.messageSearchQuery, messageSearchQuery) || other.messageSearchQuery == messageSearchQuery)&&(identical(other.isForwarding, isForwarding) || other.isForwarding == isForwarding)&&(identical(other.hasStreamError, hasStreamError) || other.hasStreamError == hasStreamError));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,const DeepCollectionEquality().hash(_conversations),const DeepCollectionEquality().hash(_messages),selectedConversation,isLoadingMessages,hasLoadedMessages,isSyncingMessages,hasMoreMessages,isSending,isClearingChat,totalUnreadCount,messageRequestCount,errorMessage,const DeepCollectionEquality().hash(_typingUsers),const DeepCollectionEquality().hash(_messageSearchResults),isSearchingMessages,messageSearchQuery,isForwarding,hasStreamError]);

@override
String toString() {
  return 'ConversationState(status: $status, conversations: $conversations, messages: $messages, selectedConversation: $selectedConversation, isLoadingMessages: $isLoadingMessages, hasLoadedMessages: $hasLoadedMessages, isSyncingMessages: $isSyncingMessages, hasMoreMessages: $hasMoreMessages, isSending: $isSending, isClearingChat: $isClearingChat, totalUnreadCount: $totalUnreadCount, messageRequestCount: $messageRequestCount, errorMessage: $errorMessage, typingUsers: $typingUsers, messageSearchResults: $messageSearchResults, isSearchingMessages: $isSearchingMessages, messageSearchQuery: $messageSearchQuery, isForwarding: $isForwarding, hasStreamError: $hasStreamError)';
}


}

/// @nodoc
abstract mixin class _$ConversationStateCopyWith<$Res> implements $ConversationStateCopyWith<$Res> {
  factory _$ConversationStateCopyWith(_ConversationState value, $Res Function(_ConversationState) _then) = __$ConversationStateCopyWithImpl;
@override @useResult
$Res call({
 ConversationStatus status, List<Conversation> conversations, List<Message> messages, Conversation? selectedConversation, bool isLoadingMessages, bool hasLoadedMessages, bool isSyncingMessages, bool hasMoreMessages, bool isSending, bool isClearingChat, int totalUnreadCount, int messageRequestCount, String? errorMessage, Map<String, bool> typingUsers, List<Message> messageSearchResults, bool isSearchingMessages, String? messageSearchQuery, bool isForwarding, bool hasStreamError
});


@override $ConversationCopyWith<$Res>? get selectedConversation;

}
/// @nodoc
class __$ConversationStateCopyWithImpl<$Res>
    implements _$ConversationStateCopyWith<$Res> {
  __$ConversationStateCopyWithImpl(this._self, this._then);

  final _ConversationState _self;
  final $Res Function(_ConversationState) _then;

/// Create a copy of ConversationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? conversations = null,Object? messages = null,Object? selectedConversation = freezed,Object? isLoadingMessages = null,Object? hasLoadedMessages = null,Object? isSyncingMessages = null,Object? hasMoreMessages = null,Object? isSending = null,Object? isClearingChat = null,Object? totalUnreadCount = null,Object? messageRequestCount = null,Object? errorMessage = freezed,Object? typingUsers = null,Object? messageSearchResults = null,Object? isSearchingMessages = null,Object? messageSearchQuery = freezed,Object? isForwarding = null,Object? hasStreamError = null,}) {
  return _then(_ConversationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConversationStatus,conversations: null == conversations ? _self._conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<Conversation>,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,selectedConversation: freezed == selectedConversation ? _self.selectedConversation : selectedConversation // ignore: cast_nullable_to_non_nullable
as Conversation?,isLoadingMessages: null == isLoadingMessages ? _self.isLoadingMessages : isLoadingMessages // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedMessages: null == hasLoadedMessages ? _self.hasLoadedMessages : hasLoadedMessages // ignore: cast_nullable_to_non_nullable
as bool,isSyncingMessages: null == isSyncingMessages ? _self.isSyncingMessages : isSyncingMessages // ignore: cast_nullable_to_non_nullable
as bool,hasMoreMessages: null == hasMoreMessages ? _self.hasMoreMessages : hasMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,isClearingChat: null == isClearingChat ? _self.isClearingChat : isClearingChat // ignore: cast_nullable_to_non_nullable
as bool,totalUnreadCount: null == totalUnreadCount ? _self.totalUnreadCount : totalUnreadCount // ignore: cast_nullable_to_non_nullable
as int,messageRequestCount: null == messageRequestCount ? _self.messageRequestCount : messageRequestCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,typingUsers: null == typingUsers ? _self._typingUsers : typingUsers // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,messageSearchResults: null == messageSearchResults ? _self._messageSearchResults : messageSearchResults // ignore: cast_nullable_to_non_nullable
as List<Message>,isSearchingMessages: null == isSearchingMessages ? _self.isSearchingMessages : isSearchingMessages // ignore: cast_nullable_to_non_nullable
as bool,messageSearchQuery: freezed == messageSearchQuery ? _self.messageSearchQuery : messageSearchQuery // ignore: cast_nullable_to_non_nullable
as String?,isForwarding: null == isForwarding ? _self.isForwarding : isForwarding // ignore: cast_nullable_to_non_nullable
as bool,hasStreamError: null == hasStreamError ? _self.hasStreamError : hasStreamError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ConversationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversationCopyWith<$Res>? get selectedConversation {
    if (_self.selectedConversation == null) {
    return null;
  }

  return $ConversationCopyWith<$Res>(_self.selectedConversation!, (value) {
    return _then(_self.copyWith(selectedConversation: value));
  });
}
}

// dart format on
