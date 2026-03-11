// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_messaging_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityMessagingEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMessagingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent()';
}


}

/// @nodoc
class $CommunityMessagingEventCopyWith<$Res>  {
$CommunityMessagingEventCopyWith(CommunityMessagingEvent _, $Res Function(CommunityMessagingEvent) __);
}


/// Adds pattern-matching-related methods to [CommunityMessagingEvent].
extension CommunityMessagingEventPatterns on CommunityMessagingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadMessages value)?  loadMessages,TResult Function( _WatchMessages value)?  watchMessages,TResult Function( _MessagesUpdated value)?  messagesUpdated,TResult Function( _SendTextMessage value)?  sendTextMessage,TResult Function( _SendMediaMessage value)?  sendMediaMessage,TResult Function( _AddReaction value)?  addReaction,TResult Function( _RemoveReaction value)?  removeReaction,TResult Function( _MarkAsRead value)?  markAsRead,TResult Function( _LoadMore value)?  loadMore,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadMessages() when loadMessages != null:
return loadMessages(_that);case _WatchMessages() when watchMessages != null:
return watchMessages(_that);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that);case _AddReaction() when addReaction != null:
return addReaction(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _MarkAsRead() when markAsRead != null:
return markAsRead(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadMessages value)  loadMessages,required TResult Function( _WatchMessages value)  watchMessages,required TResult Function( _MessagesUpdated value)  messagesUpdated,required TResult Function( _SendTextMessage value)  sendTextMessage,required TResult Function( _SendMediaMessage value)  sendMediaMessage,required TResult Function( _AddReaction value)  addReaction,required TResult Function( _RemoveReaction value)  removeReaction,required TResult Function( _MarkAsRead value)  markAsRead,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _LoadMessages():
return loadMessages(_that);case _WatchMessages():
return watchMessages(_that);case _MessagesUpdated():
return messagesUpdated(_that);case _SendTextMessage():
return sendTextMessage(_that);case _SendMediaMessage():
return sendMediaMessage(_that);case _AddReaction():
return addReaction(_that);case _RemoveReaction():
return removeReaction(_that);case _MarkAsRead():
return markAsRead(_that);case _LoadMore():
return loadMore(_that);case _ClearError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadMessages value)?  loadMessages,TResult? Function( _WatchMessages value)?  watchMessages,TResult? Function( _MessagesUpdated value)?  messagesUpdated,TResult? Function( _SendTextMessage value)?  sendTextMessage,TResult? Function( _SendMediaMessage value)?  sendMediaMessage,TResult? Function( _AddReaction value)?  addReaction,TResult? Function( _RemoveReaction value)?  removeReaction,TResult? Function( _MarkAsRead value)?  markAsRead,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _LoadMessages() when loadMessages != null:
return loadMessages(_that);case _WatchMessages() when watchMessages != null:
return watchMessages(_that);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that);case _AddReaction() when addReaction != null:
return addReaction(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _MarkAsRead() when markAsRead != null:
return markAsRead(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? limit)?  loadMessages,TResult Function( int? limit)?  watchMessages,TResult Function( List<Message> messages)?  messagesUpdated,TResult Function( String text,  String? replyToMessageId)?  sendTextMessage,TResult Function( File mediaFile,  String mediaType,  String? caption,  int? durationSeconds,  File? thumbnailFile)?  sendMediaMessage,TResult Function( String messageId,  String emoji)?  addReaction,TResult Function( String messageId,  String emoji)?  removeReaction,TResult Function()?  markAsRead,TResult Function()?  loadMore,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadMessages() when loadMessages != null:
return loadMessages(_that.limit);case _WatchMessages() when watchMessages != null:
return watchMessages(_that.limit);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that.text,_that.replyToMessageId);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that.mediaFile,_that.mediaType,_that.caption,_that.durationSeconds,_that.thumbnailFile);case _AddReaction() when addReaction != null:
return addReaction(_that.messageId,_that.emoji);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.messageId,_that.emoji);case _MarkAsRead() when markAsRead != null:
return markAsRead();case _LoadMore() when loadMore != null:
return loadMore();case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? limit)  loadMessages,required TResult Function( int? limit)  watchMessages,required TResult Function( List<Message> messages)  messagesUpdated,required TResult Function( String text,  String? replyToMessageId)  sendTextMessage,required TResult Function( File mediaFile,  String mediaType,  String? caption,  int? durationSeconds,  File? thumbnailFile)  sendMediaMessage,required TResult Function( String messageId,  String emoji)  addReaction,required TResult Function( String messageId,  String emoji)  removeReaction,required TResult Function()  markAsRead,required TResult Function()  loadMore,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _LoadMessages():
return loadMessages(_that.limit);case _WatchMessages():
return watchMessages(_that.limit);case _MessagesUpdated():
return messagesUpdated(_that.messages);case _SendTextMessage():
return sendTextMessage(_that.text,_that.replyToMessageId);case _SendMediaMessage():
return sendMediaMessage(_that.mediaFile,_that.mediaType,_that.caption,_that.durationSeconds,_that.thumbnailFile);case _AddReaction():
return addReaction(_that.messageId,_that.emoji);case _RemoveReaction():
return removeReaction(_that.messageId,_that.emoji);case _MarkAsRead():
return markAsRead();case _LoadMore():
return loadMore();case _ClearError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? limit)?  loadMessages,TResult? Function( int? limit)?  watchMessages,TResult? Function( List<Message> messages)?  messagesUpdated,TResult? Function( String text,  String? replyToMessageId)?  sendTextMessage,TResult? Function( File mediaFile,  String mediaType,  String? caption,  int? durationSeconds,  File? thumbnailFile)?  sendMediaMessage,TResult? Function( String messageId,  String emoji)?  addReaction,TResult? Function( String messageId,  String emoji)?  removeReaction,TResult? Function()?  markAsRead,TResult? Function()?  loadMore,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _LoadMessages() when loadMessages != null:
return loadMessages(_that.limit);case _WatchMessages() when watchMessages != null:
return watchMessages(_that.limit);case _MessagesUpdated() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _SendTextMessage() when sendTextMessage != null:
return sendTextMessage(_that.text,_that.replyToMessageId);case _SendMediaMessage() when sendMediaMessage != null:
return sendMediaMessage(_that.mediaFile,_that.mediaType,_that.caption,_that.durationSeconds,_that.thumbnailFile);case _AddReaction() when addReaction != null:
return addReaction(_that.messageId,_that.emoji);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.messageId,_that.emoji);case _MarkAsRead() when markAsRead != null:
return markAsRead();case _LoadMore() when loadMore != null:
return loadMore();case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _LoadMessages with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _LoadMessages({this.limit});
  

 final  int? limit;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadMessagesCopyWith<_LoadMessages> get copyWith => __$LoadMessagesCopyWithImpl<_LoadMessages>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.loadMessages'))
    ..add(DiagnosticsProperty('limit', limit));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMessages&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,limit);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.loadMessages(limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$LoadMessagesCopyWith<$Res> implements $CommunityMessagingEventCopyWith<$Res> {
  factory _$LoadMessagesCopyWith(_LoadMessages value, $Res Function(_LoadMessages) _then) = __$LoadMessagesCopyWithImpl;
@useResult
$Res call({
 int? limit
});




}
/// @nodoc
class __$LoadMessagesCopyWithImpl<$Res>
    implements _$LoadMessagesCopyWith<$Res> {
  __$LoadMessagesCopyWithImpl(this._self, this._then);

  final _LoadMessages _self;
  final $Res Function(_LoadMessages) _then;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? limit = freezed,}) {
  return _then(_LoadMessages(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _WatchMessages with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _WatchMessages({this.limit});
  

 final  int? limit;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchMessagesCopyWith<_WatchMessages> get copyWith => __$WatchMessagesCopyWithImpl<_WatchMessages>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.watchMessages'))
    ..add(DiagnosticsProperty('limit', limit));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchMessages&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,limit);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.watchMessages(limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$WatchMessagesCopyWith<$Res> implements $CommunityMessagingEventCopyWith<$Res> {
  factory _$WatchMessagesCopyWith(_WatchMessages value, $Res Function(_WatchMessages) _then) = __$WatchMessagesCopyWithImpl;
@useResult
$Res call({
 int? limit
});




}
/// @nodoc
class __$WatchMessagesCopyWithImpl<$Res>
    implements _$WatchMessagesCopyWith<$Res> {
  __$WatchMessagesCopyWithImpl(this._self, this._then);

  final _WatchMessages _self;
  final $Res Function(_WatchMessages) _then;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? limit = freezed,}) {
  return _then(_WatchMessages(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _MessagesUpdated with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _MessagesUpdated(final  List<Message> messages): _messages = messages;
  

 final  List<Message> _messages;
 List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesUpdatedCopyWith<_MessagesUpdated> get copyWith => __$MessagesUpdatedCopyWithImpl<_MessagesUpdated>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.messagesUpdated'))
    ..add(DiagnosticsProperty('messages', messages));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesUpdated&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.messagesUpdated(messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$MessagesUpdatedCopyWith<$Res> implements $CommunityMessagingEventCopyWith<$Res> {
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

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(_MessagesUpdated(
null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,
  ));
}


}

/// @nodoc


class _SendTextMessage with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _SendTextMessage({required this.text, this.replyToMessageId});
  

 final  String text;
 final  String? replyToMessageId;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTextMessageCopyWith<_SendTextMessage> get copyWith => __$SendTextMessageCopyWithImpl<_SendTextMessage>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.sendTextMessage'))
    ..add(DiagnosticsProperty('text', text))..add(DiagnosticsProperty('replyToMessageId', replyToMessageId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendTextMessage&&(identical(other.text, text) || other.text == text)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId));
}


@override
int get hashCode => Object.hash(runtimeType,text,replyToMessageId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.sendTextMessage(text: $text, replyToMessageId: $replyToMessageId)';
}


}

/// @nodoc
abstract mixin class _$SendTextMessageCopyWith<$Res> implements $CommunityMessagingEventCopyWith<$Res> {
  factory _$SendTextMessageCopyWith(_SendTextMessage value, $Res Function(_SendTextMessage) _then) = __$SendTextMessageCopyWithImpl;
@useResult
$Res call({
 String text, String? replyToMessageId
});




}
/// @nodoc
class __$SendTextMessageCopyWithImpl<$Res>
    implements _$SendTextMessageCopyWith<$Res> {
  __$SendTextMessageCopyWithImpl(this._self, this._then);

  final _SendTextMessage _self;
  final $Res Function(_SendTextMessage) _then;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? replyToMessageId = freezed,}) {
  return _then(_SendTextMessage(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SendMediaMessage with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _SendMediaMessage({required this.mediaFile, required this.mediaType, this.caption, this.durationSeconds, this.thumbnailFile});
  

 final  File mediaFile;
 final  String mediaType;
 final  String? caption;
 final  int? durationSeconds;
 final  File? thumbnailFile;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendMediaMessageCopyWith<_SendMediaMessage> get copyWith => __$SendMediaMessageCopyWithImpl<_SendMediaMessage>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.sendMediaMessage'))
    ..add(DiagnosticsProperty('mediaFile', mediaFile))..add(DiagnosticsProperty('mediaType', mediaType))..add(DiagnosticsProperty('caption', caption))..add(DiagnosticsProperty('durationSeconds', durationSeconds))..add(DiagnosticsProperty('thumbnailFile', thumbnailFile));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendMediaMessage&&(identical(other.mediaFile, mediaFile) || other.mediaFile == mediaFile)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.thumbnailFile, thumbnailFile) || other.thumbnailFile == thumbnailFile));
}


@override
int get hashCode => Object.hash(runtimeType,mediaFile,mediaType,caption,durationSeconds,thumbnailFile);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.sendMediaMessage(mediaFile: $mediaFile, mediaType: $mediaType, caption: $caption, durationSeconds: $durationSeconds, thumbnailFile: $thumbnailFile)';
}


}

/// @nodoc
abstract mixin class _$SendMediaMessageCopyWith<$Res> implements $CommunityMessagingEventCopyWith<$Res> {
  factory _$SendMediaMessageCopyWith(_SendMediaMessage value, $Res Function(_SendMediaMessage) _then) = __$SendMediaMessageCopyWithImpl;
@useResult
$Res call({
 File mediaFile, String mediaType, String? caption, int? durationSeconds, File? thumbnailFile
});




}
/// @nodoc
class __$SendMediaMessageCopyWithImpl<$Res>
    implements _$SendMediaMessageCopyWith<$Res> {
  __$SendMediaMessageCopyWithImpl(this._self, this._then);

  final _SendMediaMessage _self;
  final $Res Function(_SendMediaMessage) _then;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mediaFile = null,Object? mediaType = null,Object? caption = freezed,Object? durationSeconds = freezed,Object? thumbnailFile = freezed,}) {
  return _then(_SendMediaMessage(
mediaFile: null == mediaFile ? _self.mediaFile : mediaFile // ignore: cast_nullable_to_non_nullable
as File,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,thumbnailFile: freezed == thumbnailFile ? _self.thumbnailFile : thumbnailFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

/// @nodoc


class _AddReaction with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _AddReaction({required this.messageId, required this.emoji});
  

 final  String messageId;
 final  String emoji;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddReactionCopyWith<_AddReaction> get copyWith => __$AddReactionCopyWithImpl<_AddReaction>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.addReaction'))
    ..add(DiagnosticsProperty('messageId', messageId))..add(DiagnosticsProperty('emoji', emoji));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddReaction&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.emoji, emoji) || other.emoji == emoji));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,emoji);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.addReaction(messageId: $messageId, emoji: $emoji)';
}


}

/// @nodoc
abstract mixin class _$AddReactionCopyWith<$Res> implements $CommunityMessagingEventCopyWith<$Res> {
  factory _$AddReactionCopyWith(_AddReaction value, $Res Function(_AddReaction) _then) = __$AddReactionCopyWithImpl;
@useResult
$Res call({
 String messageId, String emoji
});




}
/// @nodoc
class __$AddReactionCopyWithImpl<$Res>
    implements _$AddReactionCopyWith<$Res> {
  __$AddReactionCopyWithImpl(this._self, this._then);

  final _AddReaction _self;
  final $Res Function(_AddReaction) _then;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? emoji = null,}) {
  return _then(_AddReaction(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RemoveReaction with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _RemoveReaction({required this.messageId, required this.emoji});
  

 final  String messageId;
 final  String emoji;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveReactionCopyWith<_RemoveReaction> get copyWith => __$RemoveReactionCopyWithImpl<_RemoveReaction>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.removeReaction'))
    ..add(DiagnosticsProperty('messageId', messageId))..add(DiagnosticsProperty('emoji', emoji));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveReaction&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.emoji, emoji) || other.emoji == emoji));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,emoji);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.removeReaction(messageId: $messageId, emoji: $emoji)';
}


}

/// @nodoc
abstract mixin class _$RemoveReactionCopyWith<$Res> implements $CommunityMessagingEventCopyWith<$Res> {
  factory _$RemoveReactionCopyWith(_RemoveReaction value, $Res Function(_RemoveReaction) _then) = __$RemoveReactionCopyWithImpl;
@useResult
$Res call({
 String messageId, String emoji
});




}
/// @nodoc
class __$RemoveReactionCopyWithImpl<$Res>
    implements _$RemoveReactionCopyWith<$Res> {
  __$RemoveReactionCopyWithImpl(this._self, this._then);

  final _RemoveReaction _self;
  final $Res Function(_RemoveReaction) _then;

/// Create a copy of CommunityMessagingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? emoji = null,}) {
  return _then(_RemoveReaction(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MarkAsRead with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _MarkAsRead();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.markAsRead'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAsRead);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.markAsRead()';
}


}




/// @nodoc


class _LoadMore with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _LoadMore();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.loadMore'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.loadMore()';
}


}




/// @nodoc


class _ClearError with DiagnosticableTreeMixin implements CommunityMessagingEvent {
  const _ClearError();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingEvent.clearError'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingEvent.clearError()';
}


}




/// @nodoc
mixin _$CommunityMessagingState implements DiagnosticableTreeMixin {

 String get communityId; List<Message> get messages; bool get isLoading; bool get isSending; bool get hasMore; String? get errorMessage;
/// Create a copy of CommunityMessagingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityMessagingStateCopyWith<CommunityMessagingState> get copyWith => _$CommunityMessagingStateCopyWithImpl<CommunityMessagingState>(this as CommunityMessagingState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingState'))
    ..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('messages', messages))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSending', isSending))..add(DiagnosticsProperty('hasMore', hasMore))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMessagingState&&(identical(other.communityId, communityId) || other.communityId == communityId)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,const DeepCollectionEquality().hash(messages),isLoading,isSending,hasMore,errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingState(communityId: $communityId, messages: $messages, isLoading: $isLoading, isSending: $isSending, hasMore: $hasMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CommunityMessagingStateCopyWith<$Res>  {
  factory $CommunityMessagingStateCopyWith(CommunityMessagingState value, $Res Function(CommunityMessagingState) _then) = _$CommunityMessagingStateCopyWithImpl;
@useResult
$Res call({
 String communityId, List<Message> messages, bool isLoading, bool isSending, bool hasMore, String? errorMessage
});




}
/// @nodoc
class _$CommunityMessagingStateCopyWithImpl<$Res>
    implements $CommunityMessagingStateCopyWith<$Res> {
  _$CommunityMessagingStateCopyWithImpl(this._self, this._then);

  final CommunityMessagingState _self;
  final $Res Function(CommunityMessagingState) _then;

/// Create a copy of CommunityMessagingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communityId = null,Object? messages = null,Object? isLoading = null,Object? isSending = null,Object? hasMore = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityMessagingState].
extension CommunityMessagingStatePatterns on CommunityMessagingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityMessagingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityMessagingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityMessagingState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityMessagingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityMessagingState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityMessagingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String communityId,  List<Message> messages,  bool isLoading,  bool isSending,  bool hasMore,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityMessagingState() when $default != null:
return $default(_that.communityId,_that.messages,_that.isLoading,_that.isSending,_that.hasMore,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String communityId,  List<Message> messages,  bool isLoading,  bool isSending,  bool hasMore,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CommunityMessagingState():
return $default(_that.communityId,_that.messages,_that.isLoading,_that.isSending,_that.hasMore,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String communityId,  List<Message> messages,  bool isLoading,  bool isSending,  bool hasMore,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CommunityMessagingState() when $default != null:
return $default(_that.communityId,_that.messages,_that.isLoading,_that.isSending,_that.hasMore,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityMessagingState with DiagnosticableTreeMixin implements CommunityMessagingState {
  const _CommunityMessagingState({required this.communityId, final  List<Message> messages = const [], this.isLoading = false, this.isSending = false, this.hasMore = false, this.errorMessage}): _messages = messages;
  

@override final  String communityId;
 final  List<Message> _messages;
@override@JsonKey() List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  bool hasMore;
@override final  String? errorMessage;

/// Create a copy of CommunityMessagingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityMessagingStateCopyWith<_CommunityMessagingState> get copyWith => __$CommunityMessagingStateCopyWithImpl<_CommunityMessagingState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CommunityMessagingState'))
    ..add(DiagnosticsProperty('communityId', communityId))..add(DiagnosticsProperty('messages', messages))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSending', isSending))..add(DiagnosticsProperty('hasMore', hasMore))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityMessagingState&&(identical(other.communityId, communityId) || other.communityId == communityId)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,const DeepCollectionEquality().hash(_messages),isLoading,isSending,hasMore,errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CommunityMessagingState(communityId: $communityId, messages: $messages, isLoading: $isLoading, isSending: $isSending, hasMore: $hasMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CommunityMessagingStateCopyWith<$Res> implements $CommunityMessagingStateCopyWith<$Res> {
  factory _$CommunityMessagingStateCopyWith(_CommunityMessagingState value, $Res Function(_CommunityMessagingState) _then) = __$CommunityMessagingStateCopyWithImpl;
@override @useResult
$Res call({
 String communityId, List<Message> messages, bool isLoading, bool isSending, bool hasMore, String? errorMessage
});




}
/// @nodoc
class __$CommunityMessagingStateCopyWithImpl<$Res>
    implements _$CommunityMessagingStateCopyWith<$Res> {
  __$CommunityMessagingStateCopyWithImpl(this._self, this._then);

  final _CommunityMessagingState _self;
  final $Res Function(_CommunityMessagingState) _then;

/// Create a copy of CommunityMessagingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? messages = null,Object? isLoading = null,Object? isSending = null,Object? hasMore = null,Object? errorMessage = freezed,}) {
  return _then(_CommunityMessagingState(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
