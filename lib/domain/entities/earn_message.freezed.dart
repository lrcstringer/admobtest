// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarnMessage {

 String get id; String get threadId; String get userId; EarnMessageType get type; String get content; DateTime get createdAt; EarnMessageStatus? get status; Map<String, dynamic>? get metadata;/// For survey responses
 String? get questionId; dynamic get response;/// For ad interactions
 String? get adId; int? get watchDurationSeconds;/// Token amount earned from this message/action
 int? get tokensEarned;
/// Create a copy of EarnMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnMessageCopyWith<EarnMessage> get copyWith => _$EarnMessageCopyWithImpl<EarnMessage>(this as EarnMessage, _$identity);

  /// Serializes this EarnMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other.response, response)&&(identical(other.adId, adId) || other.adId == adId)&&(identical(other.watchDurationSeconds, watchDurationSeconds) || other.watchDurationSeconds == watchDurationSeconds)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,threadId,userId,type,content,createdAt,status,const DeepCollectionEquality().hash(metadata),questionId,const DeepCollectionEquality().hash(response),adId,watchDurationSeconds,tokensEarned);

@override
String toString() {
  return 'EarnMessage(id: $id, threadId: $threadId, userId: $userId, type: $type, content: $content, createdAt: $createdAt, status: $status, metadata: $metadata, questionId: $questionId, response: $response, adId: $adId, watchDurationSeconds: $watchDurationSeconds, tokensEarned: $tokensEarned)';
}


}

/// @nodoc
abstract mixin class $EarnMessageCopyWith<$Res>  {
  factory $EarnMessageCopyWith(EarnMessage value, $Res Function(EarnMessage) _then) = _$EarnMessageCopyWithImpl;
@useResult
$Res call({
 String id, String threadId, String userId, EarnMessageType type, String content, DateTime createdAt, EarnMessageStatus? status, Map<String, dynamic>? metadata, String? questionId, dynamic response, String? adId, int? watchDurationSeconds, int? tokensEarned
});




}
/// @nodoc
class _$EarnMessageCopyWithImpl<$Res>
    implements $EarnMessageCopyWith<$Res> {
  _$EarnMessageCopyWithImpl(this._self, this._then);

  final EarnMessage _self;
  final $Res Function(EarnMessage) _then;

/// Create a copy of EarnMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? threadId = null,Object? userId = null,Object? type = null,Object? content = null,Object? createdAt = null,Object? status = freezed,Object? metadata = freezed,Object? questionId = freezed,Object? response = freezed,Object? adId = freezed,Object? watchDurationSeconds = freezed,Object? tokensEarned = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarnMessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarnMessageStatus?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,questionId: freezed == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String?,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,adId: freezed == adId ? _self.adId : adId // ignore: cast_nullable_to_non_nullable
as String?,watchDurationSeconds: freezed == watchDurationSeconds ? _self.watchDurationSeconds : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,tokensEarned: freezed == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarnMessage].
extension EarnMessagePatterns on EarnMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnMessage value)  $default,){
final _that = this;
switch (_that) {
case _EarnMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnMessage value)?  $default,){
final _that = this;
switch (_that) {
case _EarnMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String threadId,  String userId,  EarnMessageType type,  String content,  DateTime createdAt,  EarnMessageStatus? status,  Map<String, dynamic>? metadata,  String? questionId,  dynamic response,  String? adId,  int? watchDurationSeconds,  int? tokensEarned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnMessage() when $default != null:
return $default(_that.id,_that.threadId,_that.userId,_that.type,_that.content,_that.createdAt,_that.status,_that.metadata,_that.questionId,_that.response,_that.adId,_that.watchDurationSeconds,_that.tokensEarned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String threadId,  String userId,  EarnMessageType type,  String content,  DateTime createdAt,  EarnMessageStatus? status,  Map<String, dynamic>? metadata,  String? questionId,  dynamic response,  String? adId,  int? watchDurationSeconds,  int? tokensEarned)  $default,) {final _that = this;
switch (_that) {
case _EarnMessage():
return $default(_that.id,_that.threadId,_that.userId,_that.type,_that.content,_that.createdAt,_that.status,_that.metadata,_that.questionId,_that.response,_that.adId,_that.watchDurationSeconds,_that.tokensEarned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String threadId,  String userId,  EarnMessageType type,  String content,  DateTime createdAt,  EarnMessageStatus? status,  Map<String, dynamic>? metadata,  String? questionId,  dynamic response,  String? adId,  int? watchDurationSeconds,  int? tokensEarned)?  $default,) {final _that = this;
switch (_that) {
case _EarnMessage() when $default != null:
return $default(_that.id,_that.threadId,_that.userId,_that.type,_that.content,_that.createdAt,_that.status,_that.metadata,_that.questionId,_that.response,_that.adId,_that.watchDurationSeconds,_that.tokensEarned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarnMessage implements EarnMessage {
  const _EarnMessage({required this.id, required this.threadId, required this.userId, required this.type, required this.content, required this.createdAt, this.status, final  Map<String, dynamic>? metadata, this.questionId, this.response, this.adId, this.watchDurationSeconds, this.tokensEarned}): _metadata = metadata;
  factory _EarnMessage.fromJson(Map<String, dynamic> json) => _$EarnMessageFromJson(json);

@override final  String id;
@override final  String threadId;
@override final  String userId;
@override final  EarnMessageType type;
@override final  String content;
@override final  DateTime createdAt;
@override final  EarnMessageStatus? status;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// For survey responses
@override final  String? questionId;
@override final  dynamic response;
/// For ad interactions
@override final  String? adId;
@override final  int? watchDurationSeconds;
/// Token amount earned from this message/action
@override final  int? tokensEarned;

/// Create a copy of EarnMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnMessageCopyWith<_EarnMessage> get copyWith => __$EarnMessageCopyWithImpl<_EarnMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarnMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&const DeepCollectionEquality().equals(other.response, response)&&(identical(other.adId, adId) || other.adId == adId)&&(identical(other.watchDurationSeconds, watchDurationSeconds) || other.watchDurationSeconds == watchDurationSeconds)&&(identical(other.tokensEarned, tokensEarned) || other.tokensEarned == tokensEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,threadId,userId,type,content,createdAt,status,const DeepCollectionEquality().hash(_metadata),questionId,const DeepCollectionEquality().hash(response),adId,watchDurationSeconds,tokensEarned);

@override
String toString() {
  return 'EarnMessage(id: $id, threadId: $threadId, userId: $userId, type: $type, content: $content, createdAt: $createdAt, status: $status, metadata: $metadata, questionId: $questionId, response: $response, adId: $adId, watchDurationSeconds: $watchDurationSeconds, tokensEarned: $tokensEarned)';
}


}

/// @nodoc
abstract mixin class _$EarnMessageCopyWith<$Res> implements $EarnMessageCopyWith<$Res> {
  factory _$EarnMessageCopyWith(_EarnMessage value, $Res Function(_EarnMessage) _then) = __$EarnMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String threadId, String userId, EarnMessageType type, String content, DateTime createdAt, EarnMessageStatus? status, Map<String, dynamic>? metadata, String? questionId, dynamic response, String? adId, int? watchDurationSeconds, int? tokensEarned
});




}
/// @nodoc
class __$EarnMessageCopyWithImpl<$Res>
    implements _$EarnMessageCopyWith<$Res> {
  __$EarnMessageCopyWithImpl(this._self, this._then);

  final _EarnMessage _self;
  final $Res Function(_EarnMessage) _then;

/// Create a copy of EarnMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? threadId = null,Object? userId = null,Object? type = null,Object? content = null,Object? createdAt = null,Object? status = freezed,Object? metadata = freezed,Object? questionId = freezed,Object? response = freezed,Object? adId = freezed,Object? watchDurationSeconds = freezed,Object? tokensEarned = freezed,}) {
  return _then(_EarnMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarnMessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarnMessageStatus?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,questionId: freezed == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String?,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,adId: freezed == adId ? _self.adId : adId // ignore: cast_nullable_to_non_nullable
as String?,watchDurationSeconds: freezed == watchDurationSeconds ? _self.watchDurationSeconds : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,tokensEarned: freezed == tokensEarned ? _self.tokensEarned : tokensEarned // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
