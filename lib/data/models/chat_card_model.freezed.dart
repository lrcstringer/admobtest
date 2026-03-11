// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatCardModel {

 String get id; String get threadId; String get senderId; String get type; String get status; String? get textContent; int? get tokenAmount; String? get mediaUrl; String? get mediaType; String? get actionData; DateTime? get expiresAt; DateTime get createdAt; DateTime? get readAt; DateTime? get actionedAt; String? get recipientId;
/// Create a copy of ChatCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCardModelCopyWith<ChatCardModel> get copyWith => _$ChatCardModelCopyWithImpl<ChatCardModel>(this as ChatCardModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.actionData, actionData) || other.actionData == actionData)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId));
}


@override
int get hashCode => Object.hash(runtimeType,id,threadId,senderId,type,status,textContent,tokenAmount,mediaUrl,mediaType,actionData,expiresAt,createdAt,readAt,actionedAt,recipientId);

@override
String toString() {
  return 'ChatCardModel(id: $id, threadId: $threadId, senderId: $senderId, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, mediaUrl: $mediaUrl, mediaType: $mediaType, actionData: $actionData, expiresAt: $expiresAt, createdAt: $createdAt, readAt: $readAt, actionedAt: $actionedAt, recipientId: $recipientId)';
}


}

/// @nodoc
abstract mixin class $ChatCardModelCopyWith<$Res>  {
  factory $ChatCardModelCopyWith(ChatCardModel value, $Res Function(ChatCardModel) _then) = _$ChatCardModelCopyWithImpl;
@useResult
$Res call({
 String id, String threadId, String senderId, String type, String status, String? textContent, int? tokenAmount, String? mediaUrl, String? mediaType, String? actionData, DateTime? expiresAt, DateTime createdAt, DateTime? readAt, DateTime? actionedAt, String? recipientId
});




}
/// @nodoc
class _$ChatCardModelCopyWithImpl<$Res>
    implements $ChatCardModelCopyWith<$Res> {
  _$ChatCardModelCopyWithImpl(this._self, this._then);

  final ChatCardModel _self;
  final $Res Function(ChatCardModel) _then;

/// Create a copy of ChatCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? threadId = null,Object? senderId = null,Object? type = null,Object? status = null,Object? textContent = freezed,Object? tokenAmount = freezed,Object? mediaUrl = freezed,Object? mediaType = freezed,Object? actionData = freezed,Object? expiresAt = freezed,Object? createdAt = null,Object? readAt = freezed,Object? actionedAt = freezed,Object? recipientId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,tokenAmount: freezed == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,actionData: freezed == actionData ? _self.actionData : actionData // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatCardModel].
extension ChatCardModelPatterns on ChatCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatCardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatCardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatCardModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatCardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatCardModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatCardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String threadId,  String senderId,  String type,  String status,  String? textContent,  int? tokenAmount,  String? mediaUrl,  String? mediaType,  String? actionData,  DateTime? expiresAt,  DateTime createdAt,  DateTime? readAt,  DateTime? actionedAt,  String? recipientId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatCardModel() when $default != null:
return $default(_that.id,_that.threadId,_that.senderId,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.mediaUrl,_that.mediaType,_that.actionData,_that.expiresAt,_that.createdAt,_that.readAt,_that.actionedAt,_that.recipientId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String threadId,  String senderId,  String type,  String status,  String? textContent,  int? tokenAmount,  String? mediaUrl,  String? mediaType,  String? actionData,  DateTime? expiresAt,  DateTime createdAt,  DateTime? readAt,  DateTime? actionedAt,  String? recipientId)  $default,) {final _that = this;
switch (_that) {
case _ChatCardModel():
return $default(_that.id,_that.threadId,_that.senderId,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.mediaUrl,_that.mediaType,_that.actionData,_that.expiresAt,_that.createdAt,_that.readAt,_that.actionedAt,_that.recipientId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String threadId,  String senderId,  String type,  String status,  String? textContent,  int? tokenAmount,  String? mediaUrl,  String? mediaType,  String? actionData,  DateTime? expiresAt,  DateTime createdAt,  DateTime? readAt,  DateTime? actionedAt,  String? recipientId)?  $default,) {final _that = this;
switch (_that) {
case _ChatCardModel() when $default != null:
return $default(_that.id,_that.threadId,_that.senderId,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.mediaUrl,_that.mediaType,_that.actionData,_that.expiresAt,_that.createdAt,_that.readAt,_that.actionedAt,_that.recipientId);case _:
  return null;

}
}

}

/// @nodoc


class _ChatCardModel extends ChatCardModel {
  const _ChatCardModel({required this.id, required this.threadId, required this.senderId, required this.type, required this.status, this.textContent, this.tokenAmount, this.mediaUrl, this.mediaType, this.actionData, this.expiresAt, required this.createdAt, this.readAt, this.actionedAt, this.recipientId}): super._();
  

@override final  String id;
@override final  String threadId;
@override final  String senderId;
@override final  String type;
@override final  String status;
@override final  String? textContent;
@override final  int? tokenAmount;
@override final  String? mediaUrl;
@override final  String? mediaType;
@override final  String? actionData;
@override final  DateTime? expiresAt;
@override final  DateTime createdAt;
@override final  DateTime? readAt;
@override final  DateTime? actionedAt;
@override final  String? recipientId;

/// Create a copy of ChatCardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCardModelCopyWith<_ChatCardModel> get copyWith => __$ChatCardModelCopyWithImpl<_ChatCardModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.actionData, actionData) || other.actionData == actionData)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId));
}


@override
int get hashCode => Object.hash(runtimeType,id,threadId,senderId,type,status,textContent,tokenAmount,mediaUrl,mediaType,actionData,expiresAt,createdAt,readAt,actionedAt,recipientId);

@override
String toString() {
  return 'ChatCardModel(id: $id, threadId: $threadId, senderId: $senderId, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, mediaUrl: $mediaUrl, mediaType: $mediaType, actionData: $actionData, expiresAt: $expiresAt, createdAt: $createdAt, readAt: $readAt, actionedAt: $actionedAt, recipientId: $recipientId)';
}


}

/// @nodoc
abstract mixin class _$ChatCardModelCopyWith<$Res> implements $ChatCardModelCopyWith<$Res> {
  factory _$ChatCardModelCopyWith(_ChatCardModel value, $Res Function(_ChatCardModel) _then) = __$ChatCardModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String threadId, String senderId, String type, String status, String? textContent, int? tokenAmount, String? mediaUrl, String? mediaType, String? actionData, DateTime? expiresAt, DateTime createdAt, DateTime? readAt, DateTime? actionedAt, String? recipientId
});




}
/// @nodoc
class __$ChatCardModelCopyWithImpl<$Res>
    implements _$ChatCardModelCopyWith<$Res> {
  __$ChatCardModelCopyWithImpl(this._self, this._then);

  final _ChatCardModel _self;
  final $Res Function(_ChatCardModel) _then;

/// Create a copy of ChatCardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? threadId = null,Object? senderId = null,Object? type = null,Object? status = null,Object? textContent = freezed,Object? tokenAmount = freezed,Object? mediaUrl = freezed,Object? mediaType = freezed,Object? actionData = freezed,Object? expiresAt = freezed,Object? createdAt = null,Object? readAt = freezed,Object? actionedAt = freezed,Object? recipientId = freezed,}) {
  return _then(_ChatCardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,tokenAmount: freezed == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,actionData: freezed == actionData ? _self.actionData : actionData // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
