// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent()';
}


}

/// @nodoc
class $ChatEventCopyWith<$Res>  {
$ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}


/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadThreads value)?  loadThreads,TResult Function( _WatchThreads value)?  watchThreads,TResult Function( _ThreadsUpdated value)?  threadsUpdated,TResult Function( _SelectThread value)?  selectThread,TResult Function( _LoadMessages value)?  loadMessages,TResult Function( _WatchMessages value)?  watchMessages,TResult Function( _MessagesUpdated value)?  messagesUpdated,TResult Function( _SendTextMessage value)?  sendTextMessage,TResult Function( _SendTokens value)?  sendTokens,TResult Function( _RequestTokens value)?  requestTokens,TResult Function( _AcceptTokenRequest value)?  acceptTokenRequest,TResult Function( _DeclineTokenRequest value)?  declineTokenRequest,TResult Function( _MarkAsRead value)?  markAsRead,TResult Function( _TogglePinThread value)?  togglePinThread,TResult Function( _ToggleMuteThread value)?  toggleMuteThread,TResult Function( _ArchiveThread value)?  archiveThread,TResult Function( _GetOrCreateThread value)?  getOrCreateThread,TResult Function( _ClearError value)?  clearError,TResult Function( _UnreadCountUpdated value)?  unreadCountUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads(_that);case _WatchThreads() when watchThreads != null:
return watchThreads(_that);case _ThreadsUpdated() when threadsUpdated != null:
return threadsUpdated(_that);case _SelectThread() when selectThread != null:
return selectThread(_that);case _LoadMessages() when loadMessages != null:
return loadMessages(_that);case _WatchMessages() when watchMessages != null:
return watchMessages(_that);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that);case _SendTokens() when sendTokens != null:
return sendTokens(_that);case _RequestTokens() when requestTokens != null:
return requestTokens(_that);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that);case _MarkAsRead() when markAsRead != null:
return markAsRead(_that);case _TogglePinThread() when togglePinThread != null:
return togglePinThread(_that);case _ToggleMuteThread() when toggleMuteThread != null:
return toggleMuteThread(_that);case _ArchiveThread() when archiveThread != null:
return archiveThread(_that);case _GetOrCreateThread() when getOrCreateThread != null:
return getOrCreateThread(_that);case _ClearError() when clearError != null:
return clearError(_that);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadThreads value)  loadThreads,required TResult Function( _WatchThreads value)  watchThreads,required TResult Function( _ThreadsUpdated value)  threadsUpdated,required TResult Function( _SelectThread value)  selectThread,required TResult Function( _LoadMessages value)  loadMessages,required TResult Function( _WatchMessages value)  watchMessages,required TResult Function( _MessagesUpdated value)  messagesUpdated,required TResult Function( _SendTextMessage value)  sendTextMessage,required TResult Function( _SendTokens value)  sendTokens,required TResult Function( _RequestTokens value)  requestTokens,required TResult Function( _AcceptTokenRequest value)  acceptTokenRequest,required TResult Function( _DeclineTokenRequest value)  declineTokenRequest,required TResult Function( _MarkAsRead value)  markAsRead,required TResult Function( _TogglePinThread value)  togglePinThread,required TResult Function( _ToggleMuteThread value)  toggleMuteThread,required TResult Function( _ArchiveThread value)  archiveThread,required TResult Function( _GetOrCreateThread value)  getOrCreateThread,required TResult Function( _ClearError value)  clearError,required TResult Function( _UnreadCountUpdated value)  unreadCountUpdated,}){
final _that = this;
switch (_that) {
case _LoadThreads():
return loadThreads(_that);case _WatchThreads():
return watchThreads(_that);case _ThreadsUpdated():
return threadsUpdated(_that);case _SelectThread():
return selectThread(_that);case _LoadMessages():
return loadMessages(_that);case _WatchMessages():
return watchMessages(_that);case _MessagesUpdated():
return messagesUpdated(_that);case _SendTextMessage():
return sendTextMessage(_that);case _SendTokens():
return sendTokens(_that);case _RequestTokens():
return requestTokens(_that);case _AcceptTokenRequest():
return acceptTokenRequest(_that);case _DeclineTokenRequest():
return declineTokenRequest(_that);case _MarkAsRead():
return markAsRead(_that);case _TogglePinThread():
return togglePinThread(_that);case _ToggleMuteThread():
return toggleMuteThread(_that);case _ArchiveThread():
return archiveThread(_that);case _GetOrCreateThread():
return getOrCreateThread(_that);case _ClearError():
return clearError(_that);case _UnreadCountUpdated():
return unreadCountUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadThreads value)?  loadThreads,TResult? Function( _WatchThreads value)?  watchThreads,TResult? Function( _ThreadsUpdated value)?  threadsUpdated,TResult? Function( _SelectThread value)?  selectThread,TResult? Function( _LoadMessages value)?  loadMessages,TResult? Function( _WatchMessages value)?  watchMessages,TResult? Function( _MessagesUpdated value)?  messagesUpdated,TResult? Function( _SendTextMessage value)?  sendTextMessage,TResult? Function( _SendTokens value)?  sendTokens,TResult? Function( _RequestTokens value)?  requestTokens,TResult? Function( _AcceptTokenRequest value)?  acceptTokenRequest,TResult? Function( _DeclineTokenRequest value)?  declineTokenRequest,TResult? Function( _MarkAsRead value)?  markAsRead,TResult? Function( _TogglePinThread value)?  togglePinThread,TResult? Function( _ToggleMuteThread value)?  toggleMuteThread,TResult? Function( _ArchiveThread value)?  archiveThread,TResult? Function( _GetOrCreateThread value)?  getOrCreateThread,TResult? Function( _ClearError value)?  clearError,TResult? Function( _UnreadCountUpdated value)?  unreadCountUpdated,}){
final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads(_that);case _WatchThreads() when watchThreads != null:
return watchThreads(_that);case _ThreadsUpdated() when threadsUpdated != null:
return threadsUpdated(_that);case _SelectThread() when selectThread != null:
return selectThread(_that);case _LoadMessages() when loadMessages != null:
return loadMessages(_that);case _WatchMessages() when watchMessages != null:
return watchMessages(_that);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that);case _SendTokens() when sendTokens != null:
return sendTokens(_that);case _RequestTokens() when requestTokens != null:
return requestTokens(_that);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that);case _MarkAsRead() when markAsRead != null:
return markAsRead(_that);case _TogglePinThread() when togglePinThread != null:
return togglePinThread(_that);case _ToggleMuteThread() when toggleMuteThread != null:
return toggleMuteThread(_that);case _ArchiveThread() when archiveThread != null:
return archiveThread(_that);case _GetOrCreateThread() when getOrCreateThread != null:
return getOrCreateThread(_that);case _ClearError() when clearError != null:
return clearError(_that);case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadThreads,TResult Function()?  watchThreads,TResult Function( List<ChatThread> threads)?  threadsUpdated,TResult Function( String threadId)?  selectThread,TResult Function( String threadId,  int? limit,  DateTime? startAfter)?  loadMessages,TResult Function( String threadId,  int? limit)?  watchMessages,TResult Function( List<ChatCard> messages)?  messagesUpdated,TResult Function( String threadId,  String text)?  sendTextMessage,TResult Function( String threadId,  String recipientId,  int amount,  String? message)?  sendTokens,TResult Function( String threadId,  String recipientId,  int amount,  String? message)?  requestTokens,TResult Function( String cardId)?  acceptTokenRequest,TResult Function( String cardId)?  declineTokenRequest,TResult Function( String threadId,  List<String> messageIds)?  markAsRead,TResult Function( String threadId,  bool isPinned)?  togglePinThread,TResult Function( String threadId,  bool isMuted)?  toggleMuteThread,TResult Function( String threadId)?  archiveThread,TResult Function( String participantId)?  getOrCreateThread,TResult Function()?  clearError,TResult Function( int count)?  unreadCountUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads();case _WatchThreads() when watchThreads != null:
return watchThreads();case _ThreadsUpdated() when threadsUpdated != null:
return threadsUpdated(_that.threads);case _SelectThread() when selectThread != null:
return selectThread(_that.threadId);case _LoadMessages() when loadMessages != null:
return loadMessages(_that.threadId,_that.limit,_that.startAfter);case _WatchMessages() when watchMessages != null:
return watchMessages(_that.threadId,_that.limit);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that.threadId,_that.text);case _SendTokens() when sendTokens != null:
return sendTokens(_that.threadId,_that.recipientId,_that.amount,_that.message);case _RequestTokens() when requestTokens != null:
return requestTokens(_that.threadId,_that.recipientId,_that.amount,_that.message);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that.cardId);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that.cardId);case _MarkAsRead() when markAsRead != null:
return markAsRead(_that.threadId,_that.messageIds);case _TogglePinThread() when togglePinThread != null:
return togglePinThread(_that.threadId,_that.isPinned);case _ToggleMuteThread() when toggleMuteThread != null:
return toggleMuteThread(_that.threadId,_that.isMuted);case _ArchiveThread() when archiveThread != null:
return archiveThread(_that.threadId);case _GetOrCreateThread() when getOrCreateThread != null:
return getOrCreateThread(_that.participantId);case _ClearError() when clearError != null:
return clearError();case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadThreads,required TResult Function()  watchThreads,required TResult Function( List<ChatThread> threads)  threadsUpdated,required TResult Function( String threadId)  selectThread,required TResult Function( String threadId,  int? limit,  DateTime? startAfter)  loadMessages,required TResult Function( String threadId,  int? limit)  watchMessages,required TResult Function( List<ChatCard> messages)  messagesUpdated,required TResult Function( String threadId,  String text)  sendTextMessage,required TResult Function( String threadId,  String recipientId,  int amount,  String? message)  sendTokens,required TResult Function( String threadId,  String recipientId,  int amount,  String? message)  requestTokens,required TResult Function( String cardId)  acceptTokenRequest,required TResult Function( String cardId)  declineTokenRequest,required TResult Function( String threadId,  List<String> messageIds)  markAsRead,required TResult Function( String threadId,  bool isPinned)  togglePinThread,required TResult Function( String threadId,  bool isMuted)  toggleMuteThread,required TResult Function( String threadId)  archiveThread,required TResult Function( String participantId)  getOrCreateThread,required TResult Function()  clearError,required TResult Function( int count)  unreadCountUpdated,}) {final _that = this;
switch (_that) {
case _LoadThreads():
return loadThreads();case _WatchThreads():
return watchThreads();case _ThreadsUpdated():
return threadsUpdated(_that.threads);case _SelectThread():
return selectThread(_that.threadId);case _LoadMessages():
return loadMessages(_that.threadId,_that.limit,_that.startAfter);case _WatchMessages():
return watchMessages(_that.threadId,_that.limit);case _MessagesUpdated():
return messagesUpdated(_that.messages);case _SendTextMessage():
return sendTextMessage(_that.threadId,_that.text);case _SendTokens():
return sendTokens(_that.threadId,_that.recipientId,_that.amount,_that.message);case _RequestTokens():
return requestTokens(_that.threadId,_that.recipientId,_that.amount,_that.message);case _AcceptTokenRequest():
return acceptTokenRequest(_that.cardId);case _DeclineTokenRequest():
return declineTokenRequest(_that.cardId);case _MarkAsRead():
return markAsRead(_that.threadId,_that.messageIds);case _TogglePinThread():
return togglePinThread(_that.threadId,_that.isPinned);case _ToggleMuteThread():
return toggleMuteThread(_that.threadId,_that.isMuted);case _ArchiveThread():
return archiveThread(_that.threadId);case _GetOrCreateThread():
return getOrCreateThread(_that.participantId);case _ClearError():
return clearError();case _UnreadCountUpdated():
return unreadCountUpdated(_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadThreads,TResult? Function()?  watchThreads,TResult? Function( List<ChatThread> threads)?  threadsUpdated,TResult? Function( String threadId)?  selectThread,TResult? Function( String threadId,  int? limit,  DateTime? startAfter)?  loadMessages,TResult? Function( String threadId,  int? limit)?  watchMessages,TResult? Function( List<ChatCard> messages)?  messagesUpdated,TResult? Function( String threadId,  String text)?  sendTextMessage,TResult? Function( String threadId,  String recipientId,  int amount,  String? message)?  sendTokens,TResult? Function( String threadId,  String recipientId,  int amount,  String? message)?  requestTokens,TResult? Function( String cardId)?  acceptTokenRequest,TResult? Function( String cardId)?  declineTokenRequest,TResult? Function( String threadId,  List<String> messageIds)?  markAsRead,TResult? Function( String threadId,  bool isPinned)?  togglePinThread,TResult? Function( String threadId,  bool isMuted)?  toggleMuteThread,TResult? Function( String threadId)?  archiveThread,TResult? Function( String participantId)?  getOrCreateThread,TResult? Function()?  clearError,TResult? Function( int count)?  unreadCountUpdated,}) {final _that = this;
switch (_that) {
case _LoadThreads() when loadThreads != null:
return loadThreads();case _WatchThreads() when watchThreads != null:
return watchThreads();case _ThreadsUpdated() when threadsUpdated != null:
return threadsUpdated(_that.threads);case _SelectThread() when selectThread != null:
return selectThread(_that.threadId);case _LoadMessages() when loadMessages != null:
return loadMessages(_that.threadId,_that.limit,_that.startAfter);case _WatchMessages() when watchMessages != null:
return watchMessages(_that.threadId,_that.limit);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that.threadId,_that.text);case _SendTokens() when sendTokens != null:
return sendTokens(_that.threadId,_that.recipientId,_that.amount,_that.message);case _RequestTokens() when requestTokens != null:
return requestTokens(_that.threadId,_that.recipientId,_that.amount,_that.message);case _AcceptTokenRequest() when acceptTokenRequest != null:
return acceptTokenRequest(_that.cardId);case _DeclineTokenRequest() when declineTokenRequest != null:
return declineTokenRequest(_that.cardId);case _MarkAsRead() when markAsRead != null:
return markAsRead(_that.threadId,_that.messageIds);case _TogglePinThread() when togglePinThread != null:
return togglePinThread(_that.threadId,_that.isPinned);case _ToggleMuteThread() when toggleMuteThread != null:
return toggleMuteThread(_that.threadId,_that.isMuted);case _ArchiveThread() when archiveThread != null:
return archiveThread(_that.threadId);case _GetOrCreateThread() when getOrCreateThread != null:
return getOrCreateThread(_that.participantId);case _ClearError() when clearError != null:
return clearError();case _UnreadCountUpdated() when unreadCountUpdated != null:
return unreadCountUpdated(_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _LoadThreads implements ChatEvent {
  const _LoadThreads();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadThreads);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.loadThreads()';
}


}




/// @nodoc


class _WatchThreads implements ChatEvent {
  const _WatchThreads();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchThreads);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.watchThreads()';
}


}




/// @nodoc


class _ThreadsUpdated implements ChatEvent {
  const _ThreadsUpdated(final  List<ChatThread> threads): _threads = threads;
  

 final  List<ChatThread> _threads;
 List<ChatThread> get threads {
  if (_threads is EqualUnmodifiableListView) return _threads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_threads);
}


/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThreadsUpdatedCopyWith<_ThreadsUpdated> get copyWith => __$ThreadsUpdatedCopyWithImpl<_ThreadsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThreadsUpdated&&const DeepCollectionEquality().equals(other._threads, _threads));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_threads));

@override
String toString() {
  return 'ChatEvent.threadsUpdated(threads: $threads)';
}


}

/// @nodoc
abstract mixin class _$ThreadsUpdatedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$ThreadsUpdatedCopyWith(_ThreadsUpdated value, $Res Function(_ThreadsUpdated) _then) = __$ThreadsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<ChatThread> threads
});




}
/// @nodoc
class __$ThreadsUpdatedCopyWithImpl<$Res>
    implements _$ThreadsUpdatedCopyWith<$Res> {
  __$ThreadsUpdatedCopyWithImpl(this._self, this._then);

  final _ThreadsUpdated _self;
  final $Res Function(_ThreadsUpdated) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threads = null,}) {
  return _then(_ThreadsUpdated(
null == threads ? _self._threads : threads // ignore: cast_nullable_to_non_nullable
as List<ChatThread>,
  ));
}


}

/// @nodoc


class _SelectThread implements ChatEvent {
  const _SelectThread(this.threadId);
  

 final  String threadId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectThreadCopyWith<_SelectThread> get copyWith => __$SelectThreadCopyWithImpl<_SelectThread>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectThread&&(identical(other.threadId, threadId) || other.threadId == threadId));
}


@override
int get hashCode => Object.hash(runtimeType,threadId);

@override
String toString() {
  return 'ChatEvent.selectThread(threadId: $threadId)';
}


}

/// @nodoc
abstract mixin class _$SelectThreadCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$SelectThreadCopyWith(_SelectThread value, $Res Function(_SelectThread) _then) = __$SelectThreadCopyWithImpl;
@useResult
$Res call({
 String threadId
});




}
/// @nodoc
class __$SelectThreadCopyWithImpl<$Res>
    implements _$SelectThreadCopyWith<$Res> {
  __$SelectThreadCopyWithImpl(this._self, this._then);

  final _SelectThread _self;
  final $Res Function(_SelectThread) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,}) {
  return _then(_SelectThread(
null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadMessages implements ChatEvent {
  const _LoadMessages({required this.threadId, this.limit, this.startAfter});
  

 final  String threadId;
 final  int? limit;
 final  DateTime? startAfter;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadMessagesCopyWith<_LoadMessages> get copyWith => __$LoadMessagesCopyWithImpl<_LoadMessages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMessages&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.startAfter, startAfter) || other.startAfter == startAfter));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,limit,startAfter);

@override
String toString() {
  return 'ChatEvent.loadMessages(threadId: $threadId, limit: $limit, startAfter: $startAfter)';
}


}

/// @nodoc
abstract mixin class _$LoadMessagesCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$LoadMessagesCopyWith(_LoadMessages value, $Res Function(_LoadMessages) _then) = __$LoadMessagesCopyWithImpl;
@useResult
$Res call({
 String threadId, int? limit, DateTime? startAfter
});




}
/// @nodoc
class __$LoadMessagesCopyWithImpl<$Res>
    implements _$LoadMessagesCopyWith<$Res> {
  __$LoadMessagesCopyWithImpl(this._self, this._then);

  final _LoadMessages _self;
  final $Res Function(_LoadMessages) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? limit = freezed,Object? startAfter = freezed,}) {
  return _then(_LoadMessages(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,startAfter: freezed == startAfter ? _self.startAfter : startAfter // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _WatchMessages implements ChatEvent {
  const _WatchMessages({required this.threadId, this.limit});
  

 final  String threadId;
 final  int? limit;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchMessagesCopyWith<_WatchMessages> get copyWith => __$WatchMessagesCopyWithImpl<_WatchMessages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchMessages&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,limit);

@override
String toString() {
  return 'ChatEvent.watchMessages(threadId: $threadId, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$WatchMessagesCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$WatchMessagesCopyWith(_WatchMessages value, $Res Function(_WatchMessages) _then) = __$WatchMessagesCopyWithImpl;
@useResult
$Res call({
 String threadId, int? limit
});




}
/// @nodoc
class __$WatchMessagesCopyWithImpl<$Res>
    implements _$WatchMessagesCopyWith<$Res> {
  __$WatchMessagesCopyWithImpl(this._self, this._then);

  final _WatchMessages _self;
  final $Res Function(_WatchMessages) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? limit = freezed,}) {
  return _then(_WatchMessages(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _MessagesUpdated implements ChatEvent {
  const _MessagesUpdated(final  List<ChatCard> messages): _messages = messages;
  

 final  List<ChatCard> _messages;
 List<ChatCard> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatEvent
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
  return 'ChatEvent.messagesUpdated(messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$MessagesUpdatedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$MessagesUpdatedCopyWith(_MessagesUpdated value, $Res Function(_MessagesUpdated) _then) = __$MessagesUpdatedCopyWithImpl;
@useResult
$Res call({
 List<ChatCard> messages
});




}
/// @nodoc
class __$MessagesUpdatedCopyWithImpl<$Res>
    implements _$MessagesUpdatedCopyWith<$Res> {
  __$MessagesUpdatedCopyWithImpl(this._self, this._then);

  final _MessagesUpdated _self;
  final $Res Function(_MessagesUpdated) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(_MessagesUpdated(
null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatCard>,
  ));
}


}

/// @nodoc


class _SendTextMessage implements ChatEvent {
  const _SendTextMessage({required this.threadId, required this.text});
  

 final  String threadId;
 final  String text;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTextMessageCopyWith<_SendTextMessage> get copyWith => __$SendTextMessageCopyWithImpl<_SendTextMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendTextMessage&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,text);

@override
String toString() {
  return 'ChatEvent.sendTextMessage(threadId: $threadId, text: $text)';
}


}

/// @nodoc
abstract mixin class _$SendTextMessageCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$SendTextMessageCopyWith(_SendTextMessage value, $Res Function(_SendTextMessage) _then) = __$SendTextMessageCopyWithImpl;
@useResult
$Res call({
 String threadId, String text
});




}
/// @nodoc
class __$SendTextMessageCopyWithImpl<$Res>
    implements _$SendTextMessageCopyWith<$Res> {
  __$SendTextMessageCopyWithImpl(this._self, this._then);

  final _SendTextMessage _self;
  final $Res Function(_SendTextMessage) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? text = null,}) {
  return _then(_SendTextMessage(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SendTokens implements ChatEvent {
  const _SendTokens({required this.threadId, required this.recipientId, required this.amount, this.message});
  

 final  String threadId;
 final  String recipientId;
 final  int amount;
 final  String? message;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTokensCopyWith<_SendTokens> get copyWith => __$SendTokensCopyWithImpl<_SendTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendTokens&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,recipientId,amount,message);

@override
String toString() {
  return 'ChatEvent.sendTokens(threadId: $threadId, recipientId: $recipientId, amount: $amount, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SendTokensCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$SendTokensCopyWith(_SendTokens value, $Res Function(_SendTokens) _then) = __$SendTokensCopyWithImpl;
@useResult
$Res call({
 String threadId, String recipientId, int amount, String? message
});




}
/// @nodoc
class __$SendTokensCopyWithImpl<$Res>
    implements _$SendTokensCopyWith<$Res> {
  __$SendTokensCopyWithImpl(this._self, this._then);

  final _SendTokens _self;
  final $Res Function(_SendTokens) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? recipientId = null,Object? amount = null,Object? message = freezed,}) {
  return _then(_SendTokens(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RequestTokens implements ChatEvent {
  const _RequestTokens({required this.threadId, required this.recipientId, required this.amount, this.message});
  

 final  String threadId;
 final  String recipientId;
 final  int amount;
 final  String? message;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestTokensCopyWith<_RequestTokens> get copyWith => __$RequestTokensCopyWithImpl<_RequestTokens>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestTokens&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,recipientId,amount,message);

@override
String toString() {
  return 'ChatEvent.requestTokens(threadId: $threadId, recipientId: $recipientId, amount: $amount, message: $message)';
}


}

/// @nodoc
abstract mixin class _$RequestTokensCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$RequestTokensCopyWith(_RequestTokens value, $Res Function(_RequestTokens) _then) = __$RequestTokensCopyWithImpl;
@useResult
$Res call({
 String threadId, String recipientId, int amount, String? message
});




}
/// @nodoc
class __$RequestTokensCopyWithImpl<$Res>
    implements _$RequestTokensCopyWith<$Res> {
  __$RequestTokensCopyWithImpl(this._self, this._then);

  final _RequestTokens _self;
  final $Res Function(_RequestTokens) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? recipientId = null,Object? amount = null,Object? message = freezed,}) {
  return _then(_RequestTokens(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AcceptTokenRequest implements ChatEvent {
  const _AcceptTokenRequest(this.cardId);
  

 final  String cardId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptTokenRequestCopyWith<_AcceptTokenRequest> get copyWith => __$AcceptTokenRequestCopyWithImpl<_AcceptTokenRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptTokenRequest&&(identical(other.cardId, cardId) || other.cardId == cardId));
}


@override
int get hashCode => Object.hash(runtimeType,cardId);

@override
String toString() {
  return 'ChatEvent.acceptTokenRequest(cardId: $cardId)';
}


}

/// @nodoc
abstract mixin class _$AcceptTokenRequestCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$AcceptTokenRequestCopyWith(_AcceptTokenRequest value, $Res Function(_AcceptTokenRequest) _then) = __$AcceptTokenRequestCopyWithImpl;
@useResult
$Res call({
 String cardId
});




}
/// @nodoc
class __$AcceptTokenRequestCopyWithImpl<$Res>
    implements _$AcceptTokenRequestCopyWith<$Res> {
  __$AcceptTokenRequestCopyWithImpl(this._self, this._then);

  final _AcceptTokenRequest _self;
  final $Res Function(_AcceptTokenRequest) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cardId = null,}) {
  return _then(_AcceptTokenRequest(
null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeclineTokenRequest implements ChatEvent {
  const _DeclineTokenRequest(this.cardId);
  

 final  String cardId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeclineTokenRequestCopyWith<_DeclineTokenRequest> get copyWith => __$DeclineTokenRequestCopyWithImpl<_DeclineTokenRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeclineTokenRequest&&(identical(other.cardId, cardId) || other.cardId == cardId));
}


@override
int get hashCode => Object.hash(runtimeType,cardId);

@override
String toString() {
  return 'ChatEvent.declineTokenRequest(cardId: $cardId)';
}


}

/// @nodoc
abstract mixin class _$DeclineTokenRequestCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$DeclineTokenRequestCopyWith(_DeclineTokenRequest value, $Res Function(_DeclineTokenRequest) _then) = __$DeclineTokenRequestCopyWithImpl;
@useResult
$Res call({
 String cardId
});




}
/// @nodoc
class __$DeclineTokenRequestCopyWithImpl<$Res>
    implements _$DeclineTokenRequestCopyWith<$Res> {
  __$DeclineTokenRequestCopyWithImpl(this._self, this._then);

  final _DeclineTokenRequest _self;
  final $Res Function(_DeclineTokenRequest) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cardId = null,}) {
  return _then(_DeclineTokenRequest(
null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MarkAsRead implements ChatEvent {
  const _MarkAsRead({required this.threadId, required final  List<String> messageIds}): _messageIds = messageIds;
  

 final  String threadId;
 final  List<String> _messageIds;
 List<String> get messageIds {
  if (_messageIds is EqualUnmodifiableListView) return _messageIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messageIds);
}


/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkAsReadCopyWith<_MarkAsRead> get copyWith => __$MarkAsReadCopyWithImpl<_MarkAsRead>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAsRead&&(identical(other.threadId, threadId) || other.threadId == threadId)&&const DeepCollectionEquality().equals(other._messageIds, _messageIds));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,const DeepCollectionEquality().hash(_messageIds));

@override
String toString() {
  return 'ChatEvent.markAsRead(threadId: $threadId, messageIds: $messageIds)';
}


}

/// @nodoc
abstract mixin class _$MarkAsReadCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$MarkAsReadCopyWith(_MarkAsRead value, $Res Function(_MarkAsRead) _then) = __$MarkAsReadCopyWithImpl;
@useResult
$Res call({
 String threadId, List<String> messageIds
});




}
/// @nodoc
class __$MarkAsReadCopyWithImpl<$Res>
    implements _$MarkAsReadCopyWith<$Res> {
  __$MarkAsReadCopyWithImpl(this._self, this._then);

  final _MarkAsRead _self;
  final $Res Function(_MarkAsRead) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? messageIds = null,}) {
  return _then(_MarkAsRead(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,messageIds: null == messageIds ? _self._messageIds : messageIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _TogglePinThread implements ChatEvent {
  const _TogglePinThread({required this.threadId, required this.isPinned});
  

 final  String threadId;
 final  bool isPinned;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TogglePinThreadCopyWith<_TogglePinThread> get copyWith => __$TogglePinThreadCopyWithImpl<_TogglePinThread>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TogglePinThread&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,isPinned);

@override
String toString() {
  return 'ChatEvent.togglePinThread(threadId: $threadId, isPinned: $isPinned)';
}


}

/// @nodoc
abstract mixin class _$TogglePinThreadCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$TogglePinThreadCopyWith(_TogglePinThread value, $Res Function(_TogglePinThread) _then) = __$TogglePinThreadCopyWithImpl;
@useResult
$Res call({
 String threadId, bool isPinned
});




}
/// @nodoc
class __$TogglePinThreadCopyWithImpl<$Res>
    implements _$TogglePinThreadCopyWith<$Res> {
  __$TogglePinThreadCopyWithImpl(this._self, this._then);

  final _TogglePinThread _self;
  final $Res Function(_TogglePinThread) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? isPinned = null,}) {
  return _then(_TogglePinThread(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleMuteThread implements ChatEvent {
  const _ToggleMuteThread({required this.threadId, required this.isMuted});
  

 final  String threadId;
 final  bool isMuted;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleMuteThreadCopyWith<_ToggleMuteThread> get copyWith => __$ToggleMuteThreadCopyWithImpl<_ToggleMuteThread>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleMuteThread&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,isMuted);

@override
String toString() {
  return 'ChatEvent.toggleMuteThread(threadId: $threadId, isMuted: $isMuted)';
}


}

/// @nodoc
abstract mixin class _$ToggleMuteThreadCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$ToggleMuteThreadCopyWith(_ToggleMuteThread value, $Res Function(_ToggleMuteThread) _then) = __$ToggleMuteThreadCopyWithImpl;
@useResult
$Res call({
 String threadId, bool isMuted
});




}
/// @nodoc
class __$ToggleMuteThreadCopyWithImpl<$Res>
    implements _$ToggleMuteThreadCopyWith<$Res> {
  __$ToggleMuteThreadCopyWithImpl(this._self, this._then);

  final _ToggleMuteThread _self;
  final $Res Function(_ToggleMuteThread) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? isMuted = null,}) {
  return _then(_ToggleMuteThread(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ArchiveThread implements ChatEvent {
  const _ArchiveThread(this.threadId);
  

 final  String threadId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchiveThreadCopyWith<_ArchiveThread> get copyWith => __$ArchiveThreadCopyWithImpl<_ArchiveThread>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArchiveThread&&(identical(other.threadId, threadId) || other.threadId == threadId));
}


@override
int get hashCode => Object.hash(runtimeType,threadId);

@override
String toString() {
  return 'ChatEvent.archiveThread(threadId: $threadId)';
}


}

/// @nodoc
abstract mixin class _$ArchiveThreadCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$ArchiveThreadCopyWith(_ArchiveThread value, $Res Function(_ArchiveThread) _then) = __$ArchiveThreadCopyWithImpl;
@useResult
$Res call({
 String threadId
});




}
/// @nodoc
class __$ArchiveThreadCopyWithImpl<$Res>
    implements _$ArchiveThreadCopyWith<$Res> {
  __$ArchiveThreadCopyWithImpl(this._self, this._then);

  final _ArchiveThread _self;
  final $Res Function(_ArchiveThread) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? threadId = null,}) {
  return _then(_ArchiveThread(
null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GetOrCreateThread implements ChatEvent {
  const _GetOrCreateThread(this.participantId);
  

 final  String participantId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetOrCreateThreadCopyWith<_GetOrCreateThread> get copyWith => __$GetOrCreateThreadCopyWithImpl<_GetOrCreateThread>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetOrCreateThread&&(identical(other.participantId, participantId) || other.participantId == participantId));
}


@override
int get hashCode => Object.hash(runtimeType,participantId);

@override
String toString() {
  return 'ChatEvent.getOrCreateThread(participantId: $participantId)';
}


}

/// @nodoc
abstract mixin class _$GetOrCreateThreadCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$GetOrCreateThreadCopyWith(_GetOrCreateThread value, $Res Function(_GetOrCreateThread) _then) = __$GetOrCreateThreadCopyWithImpl;
@useResult
$Res call({
 String participantId
});




}
/// @nodoc
class __$GetOrCreateThreadCopyWithImpl<$Res>
    implements _$GetOrCreateThreadCopyWith<$Res> {
  __$GetOrCreateThreadCopyWithImpl(this._self, this._then);

  final _GetOrCreateThread _self;
  final $Res Function(_GetOrCreateThread) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? participantId = null,}) {
  return _then(_GetOrCreateThread(
null == participantId ? _self.participantId : participantId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearError implements ChatEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.clearError()';
}


}




/// @nodoc


class _UnreadCountUpdated implements ChatEvent {
  const _UnreadCountUpdated(this.count);
  

 final  int count;

/// Create a copy of ChatEvent
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
  return 'ChatEvent.unreadCountUpdated(count: $count)';
}


}

/// @nodoc
abstract mixin class _$UnreadCountUpdatedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
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

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_UnreadCountUpdated(
null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ChatState {

 ChatStatus get status; List<ChatThread> get threads; List<ChatCard> get messages; ChatThread? get selectedThread; bool get isLoadingMessages; bool get hasMoreMessages; bool get isSending; int get totalUnreadCount; String? get errorMessage;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.threads, threads)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.selectedThread, selectedThread) || other.selectedThread == selectedThread)&&(identical(other.isLoadingMessages, isLoadingMessages) || other.isLoadingMessages == isLoadingMessages)&&(identical(other.hasMoreMessages, hasMoreMessages) || other.hasMoreMessages == hasMoreMessages)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.totalUnreadCount, totalUnreadCount) || other.totalUnreadCount == totalUnreadCount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(threads),const DeepCollectionEquality().hash(messages),selectedThread,isLoadingMessages,hasMoreMessages,isSending,totalUnreadCount,errorMessage);

@override
String toString() {
  return 'ChatState(status: $status, threads: $threads, messages: $messages, selectedThread: $selectedThread, isLoadingMessages: $isLoadingMessages, hasMoreMessages: $hasMoreMessages, isSending: $isSending, totalUnreadCount: $totalUnreadCount, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 ChatStatus status, List<ChatThread> threads, List<ChatCard> messages, ChatThread? selectedThread, bool isLoadingMessages, bool hasMoreMessages, bool isSending, int totalUnreadCount, String? errorMessage
});


$ChatThreadCopyWith<$Res>? get selectedThread;

}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? threads = null,Object? messages = null,Object? selectedThread = freezed,Object? isLoadingMessages = null,Object? hasMoreMessages = null,Object? isSending = null,Object? totalUnreadCount = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatStatus,threads: null == threads ? _self.threads : threads // ignore: cast_nullable_to_non_nullable
as List<ChatThread>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatCard>,selectedThread: freezed == selectedThread ? _self.selectedThread : selectedThread // ignore: cast_nullable_to_non_nullable
as ChatThread?,isLoadingMessages: null == isLoadingMessages ? _self.isLoadingMessages : isLoadingMessages // ignore: cast_nullable_to_non_nullable
as bool,hasMoreMessages: null == hasMoreMessages ? _self.hasMoreMessages : hasMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,totalUnreadCount: null == totalUnreadCount ? _self.totalUnreadCount : totalUnreadCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatThreadCopyWith<$Res>? get selectedThread {
    if (_self.selectedThread == null) {
    return null;
  }

  return $ChatThreadCopyWith<$Res>(_self.selectedThread!, (value) {
    return _then(_self.copyWith(selectedThread: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatStatus status,  List<ChatThread> threads,  List<ChatCard> messages,  ChatThread? selectedThread,  bool isLoadingMessages,  bool hasMoreMessages,  bool isSending,  int totalUnreadCount,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.status,_that.threads,_that.messages,_that.selectedThread,_that.isLoadingMessages,_that.hasMoreMessages,_that.isSending,_that.totalUnreadCount,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatStatus status,  List<ChatThread> threads,  List<ChatCard> messages,  ChatThread? selectedThread,  bool isLoadingMessages,  bool hasMoreMessages,  bool isSending,  int totalUnreadCount,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.status,_that.threads,_that.messages,_that.selectedThread,_that.isLoadingMessages,_that.hasMoreMessages,_that.isSending,_that.totalUnreadCount,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatStatus status,  List<ChatThread> threads,  List<ChatCard> messages,  ChatThread? selectedThread,  bool isLoadingMessages,  bool hasMoreMessages,  bool isSending,  int totalUnreadCount,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.status,_that.threads,_that.messages,_that.selectedThread,_that.isLoadingMessages,_that.hasMoreMessages,_that.isSending,_that.totalUnreadCount,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState extends ChatState {
  const _ChatState({this.status = ChatStatus.initial, final  List<ChatThread> threads = const [], final  List<ChatCard> messages = const [], this.selectedThread, this.isLoadingMessages = false, this.hasMoreMessages = false, this.isSending = false, this.totalUnreadCount = 0, this.errorMessage}): _threads = threads,_messages = messages,super._();
  

@override@JsonKey() final  ChatStatus status;
 final  List<ChatThread> _threads;
@override@JsonKey() List<ChatThread> get threads {
  if (_threads is EqualUnmodifiableListView) return _threads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_threads);
}

 final  List<ChatCard> _messages;
@override@JsonKey() List<ChatCard> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  ChatThread? selectedThread;
@override@JsonKey() final  bool isLoadingMessages;
@override@JsonKey() final  bool hasMoreMessages;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  int totalUnreadCount;
@override final  String? errorMessage;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._threads, _threads)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.selectedThread, selectedThread) || other.selectedThread == selectedThread)&&(identical(other.isLoadingMessages, isLoadingMessages) || other.isLoadingMessages == isLoadingMessages)&&(identical(other.hasMoreMessages, hasMoreMessages) || other.hasMoreMessages == hasMoreMessages)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.totalUnreadCount, totalUnreadCount) || other.totalUnreadCount == totalUnreadCount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_threads),const DeepCollectionEquality().hash(_messages),selectedThread,isLoadingMessages,hasMoreMessages,isSending,totalUnreadCount,errorMessage);

@override
String toString() {
  return 'ChatState(status: $status, threads: $threads, messages: $messages, selectedThread: $selectedThread, isLoadingMessages: $isLoadingMessages, hasMoreMessages: $hasMoreMessages, isSending: $isSending, totalUnreadCount: $totalUnreadCount, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 ChatStatus status, List<ChatThread> threads, List<ChatCard> messages, ChatThread? selectedThread, bool isLoadingMessages, bool hasMoreMessages, bool isSending, int totalUnreadCount, String? errorMessage
});


@override $ChatThreadCopyWith<$Res>? get selectedThread;

}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? threads = null,Object? messages = null,Object? selectedThread = freezed,Object? isLoadingMessages = null,Object? hasMoreMessages = null,Object? isSending = null,Object? totalUnreadCount = null,Object? errorMessage = freezed,}) {
  return _then(_ChatState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatStatus,threads: null == threads ? _self._threads : threads // ignore: cast_nullable_to_non_nullable
as List<ChatThread>,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatCard>,selectedThread: freezed == selectedThread ? _self.selectedThread : selectedThread // ignore: cast_nullable_to_non_nullable
as ChatThread?,isLoadingMessages: null == isLoadingMessages ? _self.isLoadingMessages : isLoadingMessages // ignore: cast_nullable_to_non_nullable
as bool,hasMoreMessages: null == hasMoreMessages ? _self.hasMoreMessages : hasMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,totalUnreadCount: null == totalUnreadCount ? _self.totalUnreadCount : totalUnreadCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatThreadCopyWith<$Res>? get selectedThread {
    if (_self.selectedThread == null) {
    return null;
  }

  return $ChatThreadCopyWith<$Res>(_self.selectedThread!, (value) {
    return _then(_self.copyWith(selectedThread: value));
  });
}
}

// dart format on
