// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_actions_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversationActionsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationActionsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationActionsEvent()';
}


}

/// @nodoc
class $ConversationActionsEventCopyWith<$Res>  {
$ConversationActionsEventCopyWith(ConversationActionsEvent _, $Res Function(ConversationActionsEvent) __);
}


/// Adds pattern-matching-related methods to [ConversationActionsEvent].
extension ConversationActionsEventPatterns on ConversationActionsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _MarkAsRead value)?  markAsRead,TResult Function( _TogglePin value)?  togglePin,TResult Function( _ToggleMute value)?  toggleMute,TResult Function( _ArchiveConversation value)?  archiveConversation,TResult Function( _AddReaction value)?  addReaction,TResult Function( _RemoveReaction value)?  removeReaction,TResult Function( _DeleteMessageForEveryone value)?  deleteMessageForEveryone,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkAsRead() when markAsRead != null:
return markAsRead(_that);case _TogglePin() when togglePin != null:
return togglePin(_that);case _ToggleMute() when toggleMute != null:
return toggleMute(_that);case _ArchiveConversation() when archiveConversation != null:
return archiveConversation(_that);case _AddReaction() when addReaction != null:
return addReaction(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _DeleteMessageForEveryone() when deleteMessageForEveryone != null:
return deleteMessageForEveryone(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _MarkAsRead value)  markAsRead,required TResult Function( _TogglePin value)  togglePin,required TResult Function( _ToggleMute value)  toggleMute,required TResult Function( _ArchiveConversation value)  archiveConversation,required TResult Function( _AddReaction value)  addReaction,required TResult Function( _RemoveReaction value)  removeReaction,required TResult Function( _DeleteMessageForEveryone value)  deleteMessageForEveryone,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _MarkAsRead():
return markAsRead(_that);case _TogglePin():
return togglePin(_that);case _ToggleMute():
return toggleMute(_that);case _ArchiveConversation():
return archiveConversation(_that);case _AddReaction():
return addReaction(_that);case _RemoveReaction():
return removeReaction(_that);case _DeleteMessageForEveryone():
return deleteMessageForEveryone(_that);case _ClearError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _MarkAsRead value)?  markAsRead,TResult? Function( _TogglePin value)?  togglePin,TResult? Function( _ToggleMute value)?  toggleMute,TResult? Function( _ArchiveConversation value)?  archiveConversation,TResult? Function( _AddReaction value)?  addReaction,TResult? Function( _RemoveReaction value)?  removeReaction,TResult? Function( _DeleteMessageForEveryone value)?  deleteMessageForEveryone,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _MarkAsRead() when markAsRead != null:
return markAsRead(_that);case _TogglePin() when togglePin != null:
return togglePin(_that);case _ToggleMute() when toggleMute != null:
return toggleMute(_that);case _ArchiveConversation() when archiveConversation != null:
return archiveConversation(_that);case _AddReaction() when addReaction != null:
return addReaction(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _DeleteMessageForEveryone() when deleteMessageForEveryone != null:
return deleteMessageForEveryone(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String conversationId)?  markAsRead,TResult Function( String conversationId,  bool pinned)?  togglePin,TResult Function( String conversationId,  bool muted)?  toggleMute,TResult Function( String conversationId)?  archiveConversation,TResult Function( String conversationId,  String messageId,  String emoji)?  addReaction,TResult Function( String conversationId,  String messageId,  String emoji)?  removeReaction,TResult Function( String conversationId,  String messageId)?  deleteMessageForEveryone,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkAsRead() when markAsRead != null:
return markAsRead(_that.conversationId);case _TogglePin() when togglePin != null:
return togglePin(_that.conversationId,_that.pinned);case _ToggleMute() when toggleMute != null:
return toggleMute(_that.conversationId,_that.muted);case _ArchiveConversation() when archiveConversation != null:
return archiveConversation(_that.conversationId);case _AddReaction() when addReaction != null:
return addReaction(_that.conversationId,_that.messageId,_that.emoji);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.conversationId,_that.messageId,_that.emoji);case _DeleteMessageForEveryone() when deleteMessageForEveryone != null:
return deleteMessageForEveryone(_that.conversationId,_that.messageId);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String conversationId)  markAsRead,required TResult Function( String conversationId,  bool pinned)  togglePin,required TResult Function( String conversationId,  bool muted)  toggleMute,required TResult Function( String conversationId)  archiveConversation,required TResult Function( String conversationId,  String messageId,  String emoji)  addReaction,required TResult Function( String conversationId,  String messageId,  String emoji)  removeReaction,required TResult Function( String conversationId,  String messageId)  deleteMessageForEveryone,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _MarkAsRead():
return markAsRead(_that.conversationId);case _TogglePin():
return togglePin(_that.conversationId,_that.pinned);case _ToggleMute():
return toggleMute(_that.conversationId,_that.muted);case _ArchiveConversation():
return archiveConversation(_that.conversationId);case _AddReaction():
return addReaction(_that.conversationId,_that.messageId,_that.emoji);case _RemoveReaction():
return removeReaction(_that.conversationId,_that.messageId,_that.emoji);case _DeleteMessageForEveryone():
return deleteMessageForEveryone(_that.conversationId,_that.messageId);case _ClearError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String conversationId)?  markAsRead,TResult? Function( String conversationId,  bool pinned)?  togglePin,TResult? Function( String conversationId,  bool muted)?  toggleMute,TResult? Function( String conversationId)?  archiveConversation,TResult? Function( String conversationId,  String messageId,  String emoji)?  addReaction,TResult? Function( String conversationId,  String messageId,  String emoji)?  removeReaction,TResult? Function( String conversationId,  String messageId)?  deleteMessageForEveryone,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _MarkAsRead() when markAsRead != null:
return markAsRead(_that.conversationId);case _TogglePin() when togglePin != null:
return togglePin(_that.conversationId,_that.pinned);case _ToggleMute() when toggleMute != null:
return toggleMute(_that.conversationId,_that.muted);case _ArchiveConversation() when archiveConversation != null:
return archiveConversation(_that.conversationId);case _AddReaction() when addReaction != null:
return addReaction(_that.conversationId,_that.messageId,_that.emoji);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.conversationId,_that.messageId,_that.emoji);case _DeleteMessageForEveryone() when deleteMessageForEveryone != null:
return deleteMessageForEveryone(_that.conversationId,_that.messageId);case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _MarkAsRead implements ConversationActionsEvent {
  const _MarkAsRead(this.conversationId);
  

 final  String conversationId;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkAsReadCopyWith<_MarkAsRead> get copyWith => __$MarkAsReadCopyWithImpl<_MarkAsRead>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAsRead&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ConversationActionsEvent.markAsRead(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$MarkAsReadCopyWith<$Res> implements $ConversationActionsEventCopyWith<$Res> {
  factory _$MarkAsReadCopyWith(_MarkAsRead value, $Res Function(_MarkAsRead) _then) = __$MarkAsReadCopyWithImpl;
@useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class __$MarkAsReadCopyWithImpl<$Res>
    implements _$MarkAsReadCopyWith<$Res> {
  __$MarkAsReadCopyWithImpl(this._self, this._then);

  final _MarkAsRead _self;
  final $Res Function(_MarkAsRead) _then;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,}) {
  return _then(_MarkAsRead(
null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TogglePin implements ConversationActionsEvent {
  const _TogglePin({required this.conversationId, required this.pinned});
  

 final  String conversationId;
 final  bool pinned;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TogglePinCopyWith<_TogglePin> get copyWith => __$TogglePinCopyWithImpl<_TogglePin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TogglePin&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.pinned, pinned) || other.pinned == pinned));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,pinned);

@override
String toString() {
  return 'ConversationActionsEvent.togglePin(conversationId: $conversationId, pinned: $pinned)';
}


}

/// @nodoc
abstract mixin class _$TogglePinCopyWith<$Res> implements $ConversationActionsEventCopyWith<$Res> {
  factory _$TogglePinCopyWith(_TogglePin value, $Res Function(_TogglePin) _then) = __$TogglePinCopyWithImpl;
@useResult
$Res call({
 String conversationId, bool pinned
});




}
/// @nodoc
class __$TogglePinCopyWithImpl<$Res>
    implements _$TogglePinCopyWith<$Res> {
  __$TogglePinCopyWithImpl(this._self, this._then);

  final _TogglePin _self;
  final $Res Function(_TogglePin) _then;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? pinned = null,}) {
  return _then(_TogglePin(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleMute implements ConversationActionsEvent {
  const _ToggleMute({required this.conversationId, required this.muted});
  

 final  String conversationId;
 final  bool muted;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleMuteCopyWith<_ToggleMute> get copyWith => __$ToggleMuteCopyWithImpl<_ToggleMute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleMute&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.muted, muted) || other.muted == muted));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,muted);

@override
String toString() {
  return 'ConversationActionsEvent.toggleMute(conversationId: $conversationId, muted: $muted)';
}


}

/// @nodoc
abstract mixin class _$ToggleMuteCopyWith<$Res> implements $ConversationActionsEventCopyWith<$Res> {
  factory _$ToggleMuteCopyWith(_ToggleMute value, $Res Function(_ToggleMute) _then) = __$ToggleMuteCopyWithImpl;
@useResult
$Res call({
 String conversationId, bool muted
});




}
/// @nodoc
class __$ToggleMuteCopyWithImpl<$Res>
    implements _$ToggleMuteCopyWith<$Res> {
  __$ToggleMuteCopyWithImpl(this._self, this._then);

  final _ToggleMute _self;
  final $Res Function(_ToggleMute) _then;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? muted = null,}) {
  return _then(_ToggleMute(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ArchiveConversation implements ConversationActionsEvent {
  const _ArchiveConversation(this.conversationId);
  

 final  String conversationId;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchiveConversationCopyWith<_ArchiveConversation> get copyWith => __$ArchiveConversationCopyWithImpl<_ArchiveConversation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArchiveConversation&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ConversationActionsEvent.archiveConversation(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$ArchiveConversationCopyWith<$Res> implements $ConversationActionsEventCopyWith<$Res> {
  factory _$ArchiveConversationCopyWith(_ArchiveConversation value, $Res Function(_ArchiveConversation) _then) = __$ArchiveConversationCopyWithImpl;
@useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class __$ArchiveConversationCopyWithImpl<$Res>
    implements _$ArchiveConversationCopyWith<$Res> {
  __$ArchiveConversationCopyWithImpl(this._self, this._then);

  final _ArchiveConversation _self;
  final $Res Function(_ArchiveConversation) _then;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,}) {
  return _then(_ArchiveConversation(
null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AddReaction implements ConversationActionsEvent {
  const _AddReaction({required this.conversationId, required this.messageId, required this.emoji});
  

 final  String conversationId;
 final  String messageId;
 final  String emoji;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddReactionCopyWith<_AddReaction> get copyWith => __$AddReactionCopyWithImpl<_AddReaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddReaction&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.emoji, emoji) || other.emoji == emoji));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,messageId,emoji);

@override
String toString() {
  return 'ConversationActionsEvent.addReaction(conversationId: $conversationId, messageId: $messageId, emoji: $emoji)';
}


}

/// @nodoc
abstract mixin class _$AddReactionCopyWith<$Res> implements $ConversationActionsEventCopyWith<$Res> {
  factory _$AddReactionCopyWith(_AddReaction value, $Res Function(_AddReaction) _then) = __$AddReactionCopyWithImpl;
@useResult
$Res call({
 String conversationId, String messageId, String emoji
});




}
/// @nodoc
class __$AddReactionCopyWithImpl<$Res>
    implements _$AddReactionCopyWith<$Res> {
  __$AddReactionCopyWithImpl(this._self, this._then);

  final _AddReaction _self;
  final $Res Function(_AddReaction) _then;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? messageId = null,Object? emoji = null,}) {
  return _then(_AddReaction(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RemoveReaction implements ConversationActionsEvent {
  const _RemoveReaction({required this.conversationId, required this.messageId, required this.emoji});
  

 final  String conversationId;
 final  String messageId;
 final  String emoji;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveReactionCopyWith<_RemoveReaction> get copyWith => __$RemoveReactionCopyWithImpl<_RemoveReaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveReaction&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.emoji, emoji) || other.emoji == emoji));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,messageId,emoji);

@override
String toString() {
  return 'ConversationActionsEvent.removeReaction(conversationId: $conversationId, messageId: $messageId, emoji: $emoji)';
}


}

/// @nodoc
abstract mixin class _$RemoveReactionCopyWith<$Res> implements $ConversationActionsEventCopyWith<$Res> {
  factory _$RemoveReactionCopyWith(_RemoveReaction value, $Res Function(_RemoveReaction) _then) = __$RemoveReactionCopyWithImpl;
@useResult
$Res call({
 String conversationId, String messageId, String emoji
});




}
/// @nodoc
class __$RemoveReactionCopyWithImpl<$Res>
    implements _$RemoveReactionCopyWith<$Res> {
  __$RemoveReactionCopyWithImpl(this._self, this._then);

  final _RemoveReaction _self;
  final $Res Function(_RemoveReaction) _then;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? messageId = null,Object? emoji = null,}) {
  return _then(_RemoveReaction(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeleteMessageForEveryone implements ConversationActionsEvent {
  const _DeleteMessageForEveryone({required this.conversationId, required this.messageId});
  

 final  String conversationId;
 final  String messageId;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteMessageForEveryoneCopyWith<_DeleteMessageForEveryone> get copyWith => __$DeleteMessageForEveryoneCopyWithImpl<_DeleteMessageForEveryone>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteMessageForEveryone&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,messageId);

@override
String toString() {
  return 'ConversationActionsEvent.deleteMessageForEveryone(conversationId: $conversationId, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class _$DeleteMessageForEveryoneCopyWith<$Res> implements $ConversationActionsEventCopyWith<$Res> {
  factory _$DeleteMessageForEveryoneCopyWith(_DeleteMessageForEveryone value, $Res Function(_DeleteMessageForEveryone) _then) = __$DeleteMessageForEveryoneCopyWithImpl;
@useResult
$Res call({
 String conversationId, String messageId
});




}
/// @nodoc
class __$DeleteMessageForEveryoneCopyWithImpl<$Res>
    implements _$DeleteMessageForEveryoneCopyWith<$Res> {
  __$DeleteMessageForEveryoneCopyWithImpl(this._self, this._then);

  final _DeleteMessageForEveryone _self;
  final $Res Function(_DeleteMessageForEveryone) _then;

/// Create a copy of ConversationActionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? messageId = null,}) {
  return _then(_DeleteMessageForEveryone(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearError implements ConversationActionsEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConversationActionsEvent.clearError()';
}


}




/// @nodoc
mixin _$ConversationActionsState {

 String? get errorMessage;
/// Create a copy of ConversationActionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationActionsStateCopyWith<ConversationActionsState> get copyWith => _$ConversationActionsStateCopyWithImpl<ConversationActionsState>(this as ConversationActionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationActionsState&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'ConversationActionsState(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ConversationActionsStateCopyWith<$Res>  {
  factory $ConversationActionsStateCopyWith(ConversationActionsState value, $Res Function(ConversationActionsState) _then) = _$ConversationActionsStateCopyWithImpl;
@useResult
$Res call({
 String? errorMessage
});




}
/// @nodoc
class _$ConversationActionsStateCopyWithImpl<$Res>
    implements $ConversationActionsStateCopyWith<$Res> {
  _$ConversationActionsStateCopyWithImpl(this._self, this._then);

  final ConversationActionsState _self;
  final $Res Function(ConversationActionsState) _then;

/// Create a copy of ConversationActionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationActionsState].
extension ConversationActionsStatePatterns on ConversationActionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationActionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationActionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationActionsState value)  $default,){
final _that = this;
switch (_that) {
case _ConversationActionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationActionsState value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationActionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationActionsState() when $default != null:
return $default(_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ConversationActionsState():
return $default(_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ConversationActionsState() when $default != null:
return $default(_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ConversationActionsState implements ConversationActionsState {
  const _ConversationActionsState({this.errorMessage});
  

@override final  String? errorMessage;

/// Create a copy of ConversationActionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationActionsStateCopyWith<_ConversationActionsState> get copyWith => __$ConversationActionsStateCopyWithImpl<_ConversationActionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationActionsState&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'ConversationActionsState(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ConversationActionsStateCopyWith<$Res> implements $ConversationActionsStateCopyWith<$Res> {
  factory _$ConversationActionsStateCopyWith(_ConversationActionsState value, $Res Function(_ConversationActionsState) _then) = __$ConversationActionsStateCopyWithImpl;
@override @useResult
$Res call({
 String? errorMessage
});




}
/// @nodoc
class __$ConversationActionsStateCopyWithImpl<$Res>
    implements _$ConversationActionsStateCopyWith<$Res> {
  __$ConversationActionsStateCopyWithImpl(this._self, this._then);

  final _ConversationActionsState _self;
  final $Res Function(_ConversationActionsState) _then;

/// Create a copy of ConversationActionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMessage = freezed,}) {
  return _then(_ConversationActionsState(
errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
