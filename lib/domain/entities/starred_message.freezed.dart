// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'starred_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StarredMessage {

 String get messageId; String get conversationId; DateTime get starredAt; String get senderName; String get messageType; String? get messagePreview;
/// Create a copy of StarredMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StarredMessageCopyWith<StarredMessage> get copyWith => _$StarredMessageCopyWithImpl<StarredMessage>(this as StarredMessage, _$identity);

  /// Serializes this StarredMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StarredMessage&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.starredAt, starredAt) || other.starredAt == starredAt)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.messagePreview, messagePreview) || other.messagePreview == messagePreview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId,starredAt,senderName,messageType,messagePreview);

@override
String toString() {
  return 'StarredMessage(messageId: $messageId, conversationId: $conversationId, starredAt: $starredAt, senderName: $senderName, messageType: $messageType, messagePreview: $messagePreview)';
}


}

/// @nodoc
abstract mixin class $StarredMessageCopyWith<$Res>  {
  factory $StarredMessageCopyWith(StarredMessage value, $Res Function(StarredMessage) _then) = _$StarredMessageCopyWithImpl;
@useResult
$Res call({
 String messageId, String conversationId, DateTime starredAt, String senderName, String messageType, String? messagePreview
});




}
/// @nodoc
class _$StarredMessageCopyWithImpl<$Res>
    implements $StarredMessageCopyWith<$Res> {
  _$StarredMessageCopyWithImpl(this._self, this._then);

  final StarredMessage _self;
  final $Res Function(StarredMessage) _then;

/// Create a copy of StarredMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? conversationId = null,Object? starredAt = null,Object? senderName = null,Object? messageType = null,Object? messagePreview = freezed,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,starredAt: null == starredAt ? _self.starredAt : starredAt // ignore: cast_nullable_to_non_nullable
as DateTime,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,messagePreview: freezed == messagePreview ? _self.messagePreview : messagePreview // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StarredMessage].
extension StarredMessagePatterns on StarredMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StarredMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StarredMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StarredMessage value)  $default,){
final _that = this;
switch (_that) {
case _StarredMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StarredMessage value)?  $default,){
final _that = this;
switch (_that) {
case _StarredMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String messageId,  String conversationId,  DateTime starredAt,  String senderName,  String messageType,  String? messagePreview)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StarredMessage() when $default != null:
return $default(_that.messageId,_that.conversationId,_that.starredAt,_that.senderName,_that.messageType,_that.messagePreview);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String messageId,  String conversationId,  DateTime starredAt,  String senderName,  String messageType,  String? messagePreview)  $default,) {final _that = this;
switch (_that) {
case _StarredMessage():
return $default(_that.messageId,_that.conversationId,_that.starredAt,_that.senderName,_that.messageType,_that.messagePreview);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String messageId,  String conversationId,  DateTime starredAt,  String senderName,  String messageType,  String? messagePreview)?  $default,) {final _that = this;
switch (_that) {
case _StarredMessage() when $default != null:
return $default(_that.messageId,_that.conversationId,_that.starredAt,_that.senderName,_that.messageType,_that.messagePreview);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StarredMessage implements StarredMessage {
  const _StarredMessage({required this.messageId, required this.conversationId, required this.starredAt, required this.senderName, required this.messageType, this.messagePreview});
  factory _StarredMessage.fromJson(Map<String, dynamic> json) => _$StarredMessageFromJson(json);

@override final  String messageId;
@override final  String conversationId;
@override final  DateTime starredAt;
@override final  String senderName;
@override final  String messageType;
@override final  String? messagePreview;

/// Create a copy of StarredMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StarredMessageCopyWith<_StarredMessage> get copyWith => __$StarredMessageCopyWithImpl<_StarredMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StarredMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StarredMessage&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.starredAt, starredAt) || other.starredAt == starredAt)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.messagePreview, messagePreview) || other.messagePreview == messagePreview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId,starredAt,senderName,messageType,messagePreview);

@override
String toString() {
  return 'StarredMessage(messageId: $messageId, conversationId: $conversationId, starredAt: $starredAt, senderName: $senderName, messageType: $messageType, messagePreview: $messagePreview)';
}


}

/// @nodoc
abstract mixin class _$StarredMessageCopyWith<$Res> implements $StarredMessageCopyWith<$Res> {
  factory _$StarredMessageCopyWith(_StarredMessage value, $Res Function(_StarredMessage) _then) = __$StarredMessageCopyWithImpl;
@override @useResult
$Res call({
 String messageId, String conversationId, DateTime starredAt, String senderName, String messageType, String? messagePreview
});




}
/// @nodoc
class __$StarredMessageCopyWithImpl<$Res>
    implements _$StarredMessageCopyWith<$Res> {
  __$StarredMessageCopyWithImpl(this._self, this._then);

  final _StarredMessage _self;
  final $Res Function(_StarredMessage) _then;

/// Create a copy of StarredMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? conversationId = null,Object? starredAt = null,Object? senderName = null,Object? messageType = null,Object? messagePreview = freezed,}) {
  return _then(_StarredMessage(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,starredAt: null == starredAt ? _self.starredAt : starredAt // ignore: cast_nullable_to_non_nullable
as DateTime,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,messageType: null == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String,messagePreview: freezed == messagePreview ? _self.messagePreview : messagePreview // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
