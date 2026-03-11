// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageMedia {

 String get url; String? get thumbnailUrl; String get fileName; int get fileSize; String get mimeType; int? get duration; int? get width; int? get height;/// AES-256-GCM key used to encrypt the full media file (E2EE)
 String? get mediaKey;/// AES-256-GCM key used to encrypt the thumbnail (E2EE)
 String? get thumbKey;
/// Create a copy of MessageMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageMediaCopyWith<MessageMedia> get copyWith => _$MessageMediaCopyWithImpl<MessageMedia>(this as MessageMedia, _$identity);

  /// Serializes this MessageMedia to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageMedia&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.mediaKey, mediaKey) || other.mediaKey == mediaKey)&&(identical(other.thumbKey, thumbKey) || other.thumbKey == thumbKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,thumbnailUrl,fileName,fileSize,mimeType,duration,width,height,mediaKey,thumbKey);

@override
String toString() {
  return 'MessageMedia(url: $url, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, mimeType: $mimeType, duration: $duration, width: $width, height: $height, mediaKey: $mediaKey, thumbKey: $thumbKey)';
}


}

/// @nodoc
abstract mixin class $MessageMediaCopyWith<$Res>  {
  factory $MessageMediaCopyWith(MessageMedia value, $Res Function(MessageMedia) _then) = _$MessageMediaCopyWithImpl;
@useResult
$Res call({
 String url, String? thumbnailUrl, String fileName, int fileSize, String mimeType, int? duration, int? width, int? height, String? mediaKey, String? thumbKey
});




}
/// @nodoc
class _$MessageMediaCopyWithImpl<$Res>
    implements $MessageMediaCopyWith<$Res> {
  _$MessageMediaCopyWithImpl(this._self, this._then);

  final MessageMedia _self;
  final $Res Function(MessageMedia) _then;

/// Create a copy of MessageMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? thumbnailUrl = freezed,Object? fileName = null,Object? fileSize = null,Object? mimeType = null,Object? duration = freezed,Object? width = freezed,Object? height = freezed,Object? mediaKey = freezed,Object? thumbKey = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,mediaKey: freezed == mediaKey ? _self.mediaKey : mediaKey // ignore: cast_nullable_to_non_nullable
as String?,thumbKey: freezed == thumbKey ? _self.thumbKey : thumbKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageMedia].
extension MessageMediaPatterns on MessageMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageMedia value)  $default,){
final _that = this;
switch (_that) {
case _MessageMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageMedia value)?  $default,){
final _that = this;
switch (_that) {
case _MessageMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? thumbnailUrl,  String fileName,  int fileSize,  String mimeType,  int? duration,  int? width,  int? height,  String? mediaKey,  String? thumbKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageMedia() when $default != null:
return $default(_that.url,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.mimeType,_that.duration,_that.width,_that.height,_that.mediaKey,_that.thumbKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? thumbnailUrl,  String fileName,  int fileSize,  String mimeType,  int? duration,  int? width,  int? height,  String? mediaKey,  String? thumbKey)  $default,) {final _that = this;
switch (_that) {
case _MessageMedia():
return $default(_that.url,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.mimeType,_that.duration,_that.width,_that.height,_that.mediaKey,_that.thumbKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? thumbnailUrl,  String fileName,  int fileSize,  String mimeType,  int? duration,  int? width,  int? height,  String? mediaKey,  String? thumbKey)?  $default,) {final _that = this;
switch (_that) {
case _MessageMedia() when $default != null:
return $default(_that.url,_that.thumbnailUrl,_that.fileName,_that.fileSize,_that.mimeType,_that.duration,_that.width,_that.height,_that.mediaKey,_that.thumbKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageMedia implements MessageMedia {
  const _MessageMedia({required this.url, this.thumbnailUrl, required this.fileName, required this.fileSize, required this.mimeType, this.duration, this.width, this.height, this.mediaKey, this.thumbKey});
  factory _MessageMedia.fromJson(Map<String, dynamic> json) => _$MessageMediaFromJson(json);

@override final  String url;
@override final  String? thumbnailUrl;
@override final  String fileName;
@override final  int fileSize;
@override final  String mimeType;
@override final  int? duration;
@override final  int? width;
@override final  int? height;
/// AES-256-GCM key used to encrypt the full media file (E2EE)
@override final  String? mediaKey;
/// AES-256-GCM key used to encrypt the thumbnail (E2EE)
@override final  String? thumbKey;

/// Create a copy of MessageMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageMediaCopyWith<_MessageMedia> get copyWith => __$MessageMediaCopyWithImpl<_MessageMedia>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageMediaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageMedia&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.mediaKey, mediaKey) || other.mediaKey == mediaKey)&&(identical(other.thumbKey, thumbKey) || other.thumbKey == thumbKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,thumbnailUrl,fileName,fileSize,mimeType,duration,width,height,mediaKey,thumbKey);

@override
String toString() {
  return 'MessageMedia(url: $url, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, mimeType: $mimeType, duration: $duration, width: $width, height: $height, mediaKey: $mediaKey, thumbKey: $thumbKey)';
}


}

/// @nodoc
abstract mixin class _$MessageMediaCopyWith<$Res> implements $MessageMediaCopyWith<$Res> {
  factory _$MessageMediaCopyWith(_MessageMedia value, $Res Function(_MessageMedia) _then) = __$MessageMediaCopyWithImpl;
@override @useResult
$Res call({
 String url, String? thumbnailUrl, String fileName, int fileSize, String mimeType, int? duration, int? width, int? height, String? mediaKey, String? thumbKey
});




}
/// @nodoc
class __$MessageMediaCopyWithImpl<$Res>
    implements _$MessageMediaCopyWith<$Res> {
  __$MessageMediaCopyWithImpl(this._self, this._then);

  final _MessageMedia _self;
  final $Res Function(_MessageMedia) _then;

/// Create a copy of MessageMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? thumbnailUrl = freezed,Object? fileName = null,Object? fileSize = null,Object? mimeType = null,Object? duration = freezed,Object? width = freezed,Object? height = freezed,Object? mediaKey = freezed,Object? thumbKey = freezed,}) {
  return _then(_MessageMedia(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,mediaKey: freezed == mediaKey ? _self.mediaKey : mediaKey // ignore: cast_nullable_to_non_nullable
as String?,thumbKey: freezed == thumbKey ? _self.thumbKey : thumbKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MessageReply {

 String get messageId; String get senderName; String get text; String get type;
/// Create a copy of MessageReply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageReplyCopyWith<MessageReply> get copyWith => _$MessageReplyCopyWithImpl<MessageReply>(this as MessageReply, _$identity);

  /// Serializes this MessageReply to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageReply&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,senderName,text,type);

@override
String toString() {
  return 'MessageReply(messageId: $messageId, senderName: $senderName, text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class $MessageReplyCopyWith<$Res>  {
  factory $MessageReplyCopyWith(MessageReply value, $Res Function(MessageReply) _then) = _$MessageReplyCopyWithImpl;
@useResult
$Res call({
 String messageId, String senderName, String text, String type
});




}
/// @nodoc
class _$MessageReplyCopyWithImpl<$Res>
    implements $MessageReplyCopyWith<$Res> {
  _$MessageReplyCopyWithImpl(this._self, this._then);

  final MessageReply _self;
  final $Res Function(MessageReply) _then;

/// Create a copy of MessageReply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? senderName = null,Object? text = null,Object? type = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageReply].
extension MessageReplyPatterns on MessageReply {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageReply value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageReply() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageReply value)  $default,){
final _that = this;
switch (_that) {
case _MessageReply():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageReply value)?  $default,){
final _that = this;
switch (_that) {
case _MessageReply() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String messageId,  String senderName,  String text,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageReply() when $default != null:
return $default(_that.messageId,_that.senderName,_that.text,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String messageId,  String senderName,  String text,  String type)  $default,) {final _that = this;
switch (_that) {
case _MessageReply():
return $default(_that.messageId,_that.senderName,_that.text,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String messageId,  String senderName,  String text,  String type)?  $default,) {final _that = this;
switch (_that) {
case _MessageReply() when $default != null:
return $default(_that.messageId,_that.senderName,_that.text,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageReply implements MessageReply {
  const _MessageReply({required this.messageId, required this.senderName, required this.text, required this.type});
  factory _MessageReply.fromJson(Map<String, dynamic> json) => _$MessageReplyFromJson(json);

@override final  String messageId;
@override final  String senderName;
@override final  String text;
@override final  String type;

/// Create a copy of MessageReply
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageReplyCopyWith<_MessageReply> get copyWith => __$MessageReplyCopyWithImpl<_MessageReply>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageReplyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageReply&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,senderName,text,type);

@override
String toString() {
  return 'MessageReply(messageId: $messageId, senderName: $senderName, text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class _$MessageReplyCopyWith<$Res> implements $MessageReplyCopyWith<$Res> {
  factory _$MessageReplyCopyWith(_MessageReply value, $Res Function(_MessageReply) _then) = __$MessageReplyCopyWithImpl;
@override @useResult
$Res call({
 String messageId, String senderName, String text, String type
});




}
/// @nodoc
class __$MessageReplyCopyWithImpl<$Res>
    implements _$MessageReplyCopyWith<$Res> {
  __$MessageReplyCopyWithImpl(this._self, this._then);

  final _MessageReply _self;
  final $Res Function(_MessageReply) _then;

/// Create a copy of MessageReply
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? senderName = null,Object? text = null,Object? type = null,}) {
  return _then(_MessageReply(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GiftMessageData {

 String get giftId; int get amount; String get message; GiftStyle get style; GiftStatus get status; String? get recipientId; String? get recipientName; DateTime? get expiresAt;
/// Create a copy of GiftMessageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftMessageDataCopyWith<GiftMessageData> get copyWith => _$GiftMessageDataCopyWithImpl<GiftMessageData>(this as GiftMessageData, _$identity);

  /// Serializes this GiftMessageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftMessageData&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.status, status) || other.status == status)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftId,amount,message,style,status,recipientId,recipientName,expiresAt);

@override
String toString() {
  return 'GiftMessageData(giftId: $giftId, amount: $amount, message: $message, style: $style, status: $status, recipientId: $recipientId, recipientName: $recipientName, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $GiftMessageDataCopyWith<$Res>  {
  factory $GiftMessageDataCopyWith(GiftMessageData value, $Res Function(GiftMessageData) _then) = _$GiftMessageDataCopyWithImpl;
@useResult
$Res call({
 String giftId, int amount, String message, GiftStyle style, GiftStatus status, String? recipientId, String? recipientName, DateTime? expiresAt
});




}
/// @nodoc
class _$GiftMessageDataCopyWithImpl<$Res>
    implements $GiftMessageDataCopyWith<$Res> {
  _$GiftMessageDataCopyWithImpl(this._self, this._then);

  final GiftMessageData _self;
  final $Res Function(GiftMessageData) _then;

/// Create a copy of GiftMessageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? giftId = null,Object? amount = null,Object? message = null,Object? style = null,Object? status = null,Object? recipientId = freezed,Object? recipientName = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GiftStatus,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftMessageData].
extension GiftMessageDataPatterns on GiftMessageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftMessageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftMessageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftMessageData value)  $default,){
final _that = this;
switch (_that) {
case _GiftMessageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftMessageData value)?  $default,){
final _that = this;
switch (_that) {
case _GiftMessageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String giftId,  int amount,  String message,  GiftStyle style,  GiftStatus status,  String? recipientId,  String? recipientName,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftMessageData() when $default != null:
return $default(_that.giftId,_that.amount,_that.message,_that.style,_that.status,_that.recipientId,_that.recipientName,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String giftId,  int amount,  String message,  GiftStyle style,  GiftStatus status,  String? recipientId,  String? recipientName,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _GiftMessageData():
return $default(_that.giftId,_that.amount,_that.message,_that.style,_that.status,_that.recipientId,_that.recipientName,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String giftId,  int amount,  String message,  GiftStyle style,  GiftStatus status,  String? recipientId,  String? recipientName,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _GiftMessageData() when $default != null:
return $default(_that.giftId,_that.amount,_that.message,_that.style,_that.status,_that.recipientId,_that.recipientName,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftMessageData implements GiftMessageData {
  const _GiftMessageData({required this.giftId, required this.amount, required this.message, required this.style, required this.status, this.recipientId, this.recipientName, this.expiresAt});
  factory _GiftMessageData.fromJson(Map<String, dynamic> json) => _$GiftMessageDataFromJson(json);

@override final  String giftId;
@override final  int amount;
@override final  String message;
@override final  GiftStyle style;
@override final  GiftStatus status;
@override final  String? recipientId;
@override final  String? recipientName;
@override final  DateTime? expiresAt;

/// Create a copy of GiftMessageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftMessageDataCopyWith<_GiftMessageData> get copyWith => __$GiftMessageDataCopyWithImpl<_GiftMessageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftMessageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftMessageData&&(identical(other.giftId, giftId) || other.giftId == giftId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.status, status) || other.status == status)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftId,amount,message,style,status,recipientId,recipientName,expiresAt);

@override
String toString() {
  return 'GiftMessageData(giftId: $giftId, amount: $amount, message: $message, style: $style, status: $status, recipientId: $recipientId, recipientName: $recipientName, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$GiftMessageDataCopyWith<$Res> implements $GiftMessageDataCopyWith<$Res> {
  factory _$GiftMessageDataCopyWith(_GiftMessageData value, $Res Function(_GiftMessageData) _then) = __$GiftMessageDataCopyWithImpl;
@override @useResult
$Res call({
 String giftId, int amount, String message, GiftStyle style, GiftStatus status, String? recipientId, String? recipientName, DateTime? expiresAt
});




}
/// @nodoc
class __$GiftMessageDataCopyWithImpl<$Res>
    implements _$GiftMessageDataCopyWith<$Res> {
  __$GiftMessageDataCopyWithImpl(this._self, this._then);

  final _GiftMessageData _self;
  final $Res Function(_GiftMessageData) _then;

/// Create a copy of GiftMessageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? giftId = null,Object? amount = null,Object? message = null,Object? style = null,Object? status = null,Object? recipientId = freezed,Object? recipientName = freezed,Object? expiresAt = freezed,}) {
  return _then(_GiftMessageData(
giftId: null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GiftStatus,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TokenSprayMessageData {

 String get sprayId; String get recipientId; String get recipientName; String get occasion; int get currentTotal; int get contributorCount; SprayStatus get status; int? get targetAmount; DateTime get expiresAt;
/// Create a copy of TokenSprayMessageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenSprayMessageDataCopyWith<TokenSprayMessageData> get copyWith => _$TokenSprayMessageDataCopyWithImpl<TokenSprayMessageData>(this as TokenSprayMessageData, _$identity);

  /// Serializes this TokenSprayMessageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenSprayMessageData&&(identical(other.sprayId, sprayId) || other.sprayId == sprayId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.currentTotal, currentTotal) || other.currentTotal == currentTotal)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sprayId,recipientId,recipientName,occasion,currentTotal,contributorCount,status,targetAmount,expiresAt);

@override
String toString() {
  return 'TokenSprayMessageData(sprayId: $sprayId, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, currentTotal: $currentTotal, contributorCount: $contributorCount, status: $status, targetAmount: $targetAmount, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $TokenSprayMessageDataCopyWith<$Res>  {
  factory $TokenSprayMessageDataCopyWith(TokenSprayMessageData value, $Res Function(TokenSprayMessageData) _then) = _$TokenSprayMessageDataCopyWithImpl;
@useResult
$Res call({
 String sprayId, String recipientId, String recipientName, String occasion, int currentTotal, int contributorCount, SprayStatus status, int? targetAmount, DateTime expiresAt
});




}
/// @nodoc
class _$TokenSprayMessageDataCopyWithImpl<$Res>
    implements $TokenSprayMessageDataCopyWith<$Res> {
  _$TokenSprayMessageDataCopyWithImpl(this._self, this._then);

  final TokenSprayMessageData _self;
  final $Res Function(TokenSprayMessageData) _then;

/// Create a copy of TokenSprayMessageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sprayId = null,Object? recipientId = null,Object? recipientName = null,Object? occasion = null,Object? currentTotal = null,Object? contributorCount = null,Object? status = null,Object? targetAmount = freezed,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
sprayId: null == sprayId ? _self.sprayId : sprayId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as String,currentTotal: null == currentTotal ? _self.currentTotal : currentTotal // ignore: cast_nullable_to_non_nullable
as int,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SprayStatus,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenSprayMessageData].
extension TokenSprayMessageDataPatterns on TokenSprayMessageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenSprayMessageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenSprayMessageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenSprayMessageData value)  $default,){
final _that = this;
switch (_that) {
case _TokenSprayMessageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenSprayMessageData value)?  $default,){
final _that = this;
switch (_that) {
case _TokenSprayMessageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sprayId,  String recipientId,  String recipientName,  String occasion,  int currentTotal,  int contributorCount,  SprayStatus status,  int? targetAmount,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenSprayMessageData() when $default != null:
return $default(_that.sprayId,_that.recipientId,_that.recipientName,_that.occasion,_that.currentTotal,_that.contributorCount,_that.status,_that.targetAmount,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sprayId,  String recipientId,  String recipientName,  String occasion,  int currentTotal,  int contributorCount,  SprayStatus status,  int? targetAmount,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _TokenSprayMessageData():
return $default(_that.sprayId,_that.recipientId,_that.recipientName,_that.occasion,_that.currentTotal,_that.contributorCount,_that.status,_that.targetAmount,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sprayId,  String recipientId,  String recipientName,  String occasion,  int currentTotal,  int contributorCount,  SprayStatus status,  int? targetAmount,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _TokenSprayMessageData() when $default != null:
return $default(_that.sprayId,_that.recipientId,_that.recipientName,_that.occasion,_that.currentTotal,_that.contributorCount,_that.status,_that.targetAmount,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenSprayMessageData implements TokenSprayMessageData {
  const _TokenSprayMessageData({required this.sprayId, required this.recipientId, required this.recipientName, required this.occasion, required this.currentTotal, required this.contributorCount, required this.status, this.targetAmount, required this.expiresAt});
  factory _TokenSprayMessageData.fromJson(Map<String, dynamic> json) => _$TokenSprayMessageDataFromJson(json);

@override final  String sprayId;
@override final  String recipientId;
@override final  String recipientName;
@override final  String occasion;
@override final  int currentTotal;
@override final  int contributorCount;
@override final  SprayStatus status;
@override final  int? targetAmount;
@override final  DateTime expiresAt;

/// Create a copy of TokenSprayMessageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenSprayMessageDataCopyWith<_TokenSprayMessageData> get copyWith => __$TokenSprayMessageDataCopyWithImpl<_TokenSprayMessageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenSprayMessageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenSprayMessageData&&(identical(other.sprayId, sprayId) || other.sprayId == sprayId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.currentTotal, currentTotal) || other.currentTotal == currentTotal)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sprayId,recipientId,recipientName,occasion,currentTotal,contributorCount,status,targetAmount,expiresAt);

@override
String toString() {
  return 'TokenSprayMessageData(sprayId: $sprayId, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, currentTotal: $currentTotal, contributorCount: $contributorCount, status: $status, targetAmount: $targetAmount, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$TokenSprayMessageDataCopyWith<$Res> implements $TokenSprayMessageDataCopyWith<$Res> {
  factory _$TokenSprayMessageDataCopyWith(_TokenSprayMessageData value, $Res Function(_TokenSprayMessageData) _then) = __$TokenSprayMessageDataCopyWithImpl;
@override @useResult
$Res call({
 String sprayId, String recipientId, String recipientName, String occasion, int currentTotal, int contributorCount, SprayStatus status, int? targetAmount, DateTime expiresAt
});




}
/// @nodoc
class __$TokenSprayMessageDataCopyWithImpl<$Res>
    implements _$TokenSprayMessageDataCopyWith<$Res> {
  __$TokenSprayMessageDataCopyWithImpl(this._self, this._then);

  final _TokenSprayMessageData _self;
  final $Res Function(_TokenSprayMessageData) _then;

/// Create a copy of TokenSprayMessageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sprayId = null,Object? recipientId = null,Object? recipientName = null,Object? occasion = null,Object? currentTotal = null,Object? contributorCount = null,Object? status = null,Object? targetAmount = freezed,Object? expiresAt = null,}) {
  return _then(_TokenSprayMessageData(
sprayId: null == sprayId ? _self.sprayId : sprayId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as String,currentTotal: null == currentTotal ? _self.currentTotal : currentTotal // ignore: cast_nullable_to_non_nullable
as int,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SprayStatus,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$GroupGiftMessageData {

 String get poolId; int get amount; String get message; GiftStyle get style; String get organizerId; String get organizerName; int get contributorCount; List<String> get visibleContributorNames; int get anonymousCount; PoolStatus get status; DateTime? get expiresAt;
/// Create a copy of GroupGiftMessageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupGiftMessageDataCopyWith<GroupGiftMessageData> get copyWith => _$GroupGiftMessageDataCopyWithImpl<GroupGiftMessageData>(this as GroupGiftMessageData, _$identity);

  /// Serializes this GroupGiftMessageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupGiftMessageData&&(identical(other.poolId, poolId) || other.poolId == poolId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other.visibleContributorNames, visibleContributorNames)&&(identical(other.anonymousCount, anonymousCount) || other.anonymousCount == anonymousCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poolId,amount,message,style,organizerId,organizerName,contributorCount,const DeepCollectionEquality().hash(visibleContributorNames),anonymousCount,status,expiresAt);

@override
String toString() {
  return 'GroupGiftMessageData(poolId: $poolId, amount: $amount, message: $message, style: $style, organizerId: $organizerId, organizerName: $organizerName, contributorCount: $contributorCount, visibleContributorNames: $visibleContributorNames, anonymousCount: $anonymousCount, status: $status, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $GroupGiftMessageDataCopyWith<$Res>  {
  factory $GroupGiftMessageDataCopyWith(GroupGiftMessageData value, $Res Function(GroupGiftMessageData) _then) = _$GroupGiftMessageDataCopyWithImpl;
@useResult
$Res call({
 String poolId, int amount, String message, GiftStyle style, String organizerId, String organizerName, int contributorCount, List<String> visibleContributorNames, int anonymousCount, PoolStatus status, DateTime? expiresAt
});




}
/// @nodoc
class _$GroupGiftMessageDataCopyWithImpl<$Res>
    implements $GroupGiftMessageDataCopyWith<$Res> {
  _$GroupGiftMessageDataCopyWithImpl(this._self, this._then);

  final GroupGiftMessageData _self;
  final $Res Function(GroupGiftMessageData) _then;

/// Create a copy of GroupGiftMessageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? poolId = null,Object? amount = null,Object? message = null,Object? style = null,Object? organizerId = null,Object? organizerName = null,Object? contributorCount = null,Object? visibleContributorNames = null,Object? anonymousCount = null,Object? status = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
poolId: null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,visibleContributorNames: null == visibleContributorNames ? _self.visibleContributorNames : visibleContributorNames // ignore: cast_nullable_to_non_nullable
as List<String>,anonymousCount: null == anonymousCount ? _self.anonymousCount : anonymousCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PoolStatus,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupGiftMessageData].
extension GroupGiftMessageDataPatterns on GroupGiftMessageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupGiftMessageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupGiftMessageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupGiftMessageData value)  $default,){
final _that = this;
switch (_that) {
case _GroupGiftMessageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupGiftMessageData value)?  $default,){
final _that = this;
switch (_that) {
case _GroupGiftMessageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String poolId,  int amount,  String message,  GiftStyle style,  String organizerId,  String organizerName,  int contributorCount,  List<String> visibleContributorNames,  int anonymousCount,  PoolStatus status,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupGiftMessageData() when $default != null:
return $default(_that.poolId,_that.amount,_that.message,_that.style,_that.organizerId,_that.organizerName,_that.contributorCount,_that.visibleContributorNames,_that.anonymousCount,_that.status,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String poolId,  int amount,  String message,  GiftStyle style,  String organizerId,  String organizerName,  int contributorCount,  List<String> visibleContributorNames,  int anonymousCount,  PoolStatus status,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _GroupGiftMessageData():
return $default(_that.poolId,_that.amount,_that.message,_that.style,_that.organizerId,_that.organizerName,_that.contributorCount,_that.visibleContributorNames,_that.anonymousCount,_that.status,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String poolId,  int amount,  String message,  GiftStyle style,  String organizerId,  String organizerName,  int contributorCount,  List<String> visibleContributorNames,  int anonymousCount,  PoolStatus status,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupGiftMessageData() when $default != null:
return $default(_that.poolId,_that.amount,_that.message,_that.style,_that.organizerId,_that.organizerName,_that.contributorCount,_that.visibleContributorNames,_that.anonymousCount,_that.status,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupGiftMessageData implements GroupGiftMessageData {
  const _GroupGiftMessageData({required this.poolId, required this.amount, required this.message, required this.style, required this.organizerId, required this.organizerName, required this.contributorCount, final  List<String> visibleContributorNames = const [], this.anonymousCount = 0, required this.status, this.expiresAt}): _visibleContributorNames = visibleContributorNames;
  factory _GroupGiftMessageData.fromJson(Map<String, dynamic> json) => _$GroupGiftMessageDataFromJson(json);

@override final  String poolId;
@override final  int amount;
@override final  String message;
@override final  GiftStyle style;
@override final  String organizerId;
@override final  String organizerName;
@override final  int contributorCount;
 final  List<String> _visibleContributorNames;
@override@JsonKey() List<String> get visibleContributorNames {
  if (_visibleContributorNames is EqualUnmodifiableListView) return _visibleContributorNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleContributorNames);
}

@override@JsonKey() final  int anonymousCount;
@override final  PoolStatus status;
@override final  DateTime? expiresAt;

/// Create a copy of GroupGiftMessageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupGiftMessageDataCopyWith<_GroupGiftMessageData> get copyWith => __$GroupGiftMessageDataCopyWithImpl<_GroupGiftMessageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupGiftMessageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupGiftMessageData&&(identical(other.poolId, poolId) || other.poolId == poolId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other._visibleContributorNames, _visibleContributorNames)&&(identical(other.anonymousCount, anonymousCount) || other.anonymousCount == anonymousCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poolId,amount,message,style,organizerId,organizerName,contributorCount,const DeepCollectionEquality().hash(_visibleContributorNames),anonymousCount,status,expiresAt);

@override
String toString() {
  return 'GroupGiftMessageData(poolId: $poolId, amount: $amount, message: $message, style: $style, organizerId: $organizerId, organizerName: $organizerName, contributorCount: $contributorCount, visibleContributorNames: $visibleContributorNames, anonymousCount: $anonymousCount, status: $status, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$GroupGiftMessageDataCopyWith<$Res> implements $GroupGiftMessageDataCopyWith<$Res> {
  factory _$GroupGiftMessageDataCopyWith(_GroupGiftMessageData value, $Res Function(_GroupGiftMessageData) _then) = __$GroupGiftMessageDataCopyWithImpl;
@override @useResult
$Res call({
 String poolId, int amount, String message, GiftStyle style, String organizerId, String organizerName, int contributorCount, List<String> visibleContributorNames, int anonymousCount, PoolStatus status, DateTime? expiresAt
});




}
/// @nodoc
class __$GroupGiftMessageDataCopyWithImpl<$Res>
    implements _$GroupGiftMessageDataCopyWith<$Res> {
  __$GroupGiftMessageDataCopyWithImpl(this._self, this._then);

  final _GroupGiftMessageData _self;
  final $Res Function(_GroupGiftMessageData) _then;

/// Create a copy of GroupGiftMessageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? poolId = null,Object? amount = null,Object? message = null,Object? style = null,Object? organizerId = null,Object? organizerName = null,Object? contributorCount = null,Object? visibleContributorNames = null,Object? anonymousCount = null,Object? status = null,Object? expiresAt = freezed,}) {
  return _then(_GroupGiftMessageData(
poolId: null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,organizerName: null == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,visibleContributorNames: null == visibleContributorNames ? _self._visibleContributorNames : visibleContributorNames // ignore: cast_nullable_to_non_nullable
as List<String>,anonymousCount: null == anonymousCount ? _self.anonymousCount : anonymousCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PoolStatus,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ForwardedFrom {

 String get messageId; String get conversationId; String get senderName;
/// Create a copy of ForwardedFrom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForwardedFromCopyWith<ForwardedFrom> get copyWith => _$ForwardedFromCopyWithImpl<ForwardedFrom>(this as ForwardedFrom, _$identity);

  /// Serializes this ForwardedFrom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForwardedFrom&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderName, senderName) || other.senderName == senderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId,senderName);

@override
String toString() {
  return 'ForwardedFrom(messageId: $messageId, conversationId: $conversationId, senderName: $senderName)';
}


}

/// @nodoc
abstract mixin class $ForwardedFromCopyWith<$Res>  {
  factory $ForwardedFromCopyWith(ForwardedFrom value, $Res Function(ForwardedFrom) _then) = _$ForwardedFromCopyWithImpl;
@useResult
$Res call({
 String messageId, String conversationId, String senderName
});




}
/// @nodoc
class _$ForwardedFromCopyWithImpl<$Res>
    implements $ForwardedFromCopyWith<$Res> {
  _$ForwardedFromCopyWithImpl(this._self, this._then);

  final ForwardedFrom _self;
  final $Res Function(ForwardedFrom) _then;

/// Create a copy of ForwardedFrom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? conversationId = null,Object? senderName = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ForwardedFrom].
extension ForwardedFromPatterns on ForwardedFrom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForwardedFrom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForwardedFrom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForwardedFrom value)  $default,){
final _that = this;
switch (_that) {
case _ForwardedFrom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForwardedFrom value)?  $default,){
final _that = this;
switch (_that) {
case _ForwardedFrom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String messageId,  String conversationId,  String senderName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForwardedFrom() when $default != null:
return $default(_that.messageId,_that.conversationId,_that.senderName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String messageId,  String conversationId,  String senderName)  $default,) {final _that = this;
switch (_that) {
case _ForwardedFrom():
return $default(_that.messageId,_that.conversationId,_that.senderName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String messageId,  String conversationId,  String senderName)?  $default,) {final _that = this;
switch (_that) {
case _ForwardedFrom() when $default != null:
return $default(_that.messageId,_that.conversationId,_that.senderName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForwardedFrom implements ForwardedFrom {
  const _ForwardedFrom({required this.messageId, required this.conversationId, required this.senderName});
  factory _ForwardedFrom.fromJson(Map<String, dynamic> json) => _$ForwardedFromFromJson(json);

@override final  String messageId;
@override final  String conversationId;
@override final  String senderName;

/// Create a copy of ForwardedFrom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForwardedFromCopyWith<_ForwardedFrom> get copyWith => __$ForwardedFromCopyWithImpl<_ForwardedFrom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForwardedFromToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForwardedFrom&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderName, senderName) || other.senderName == senderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,conversationId,senderName);

@override
String toString() {
  return 'ForwardedFrom(messageId: $messageId, conversationId: $conversationId, senderName: $senderName)';
}


}

/// @nodoc
abstract mixin class _$ForwardedFromCopyWith<$Res> implements $ForwardedFromCopyWith<$Res> {
  factory _$ForwardedFromCopyWith(_ForwardedFrom value, $Res Function(_ForwardedFrom) _then) = __$ForwardedFromCopyWithImpl;
@override @useResult
$Res call({
 String messageId, String conversationId, String senderName
});




}
/// @nodoc
class __$ForwardedFromCopyWithImpl<$Res>
    implements _$ForwardedFromCopyWith<$Res> {
  __$ForwardedFromCopyWithImpl(this._self, this._then);

  final _ForwardedFrom _self;
  final $Res Function(_ForwardedFrom) _then;

/// Create a copy of ForwardedFrom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? conversationId = null,Object? senderName = null,}) {
  return _then(_ForwardedFrom(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$E2eeMetadata {

 String get protocol; String? get senderKeyChainId; int? get messageNumber; String? get dhPublicKey; int? get previousChainLength;/// HMAC-SHA256 sender authentication signature for sender-key messages.
 String? get signature;
/// Create a copy of E2eeMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$E2eeMetadataCopyWith<E2eeMetadata> get copyWith => _$E2eeMetadataCopyWithImpl<E2eeMetadata>(this as E2eeMetadata, _$identity);

  /// Serializes this E2eeMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is E2eeMetadata&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.senderKeyChainId, senderKeyChainId) || other.senderKeyChainId == senderKeyChainId)&&(identical(other.messageNumber, messageNumber) || other.messageNumber == messageNumber)&&(identical(other.dhPublicKey, dhPublicKey) || other.dhPublicKey == dhPublicKey)&&(identical(other.previousChainLength, previousChainLength) || other.previousChainLength == previousChainLength)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,protocol,senderKeyChainId,messageNumber,dhPublicKey,previousChainLength,signature);

@override
String toString() {
  return 'E2eeMetadata(protocol: $protocol, senderKeyChainId: $senderKeyChainId, messageNumber: $messageNumber, dhPublicKey: $dhPublicKey, previousChainLength: $previousChainLength, signature: $signature)';
}


}

/// @nodoc
abstract mixin class $E2eeMetadataCopyWith<$Res>  {
  factory $E2eeMetadataCopyWith(E2eeMetadata value, $Res Function(E2eeMetadata) _then) = _$E2eeMetadataCopyWithImpl;
@useResult
$Res call({
 String protocol, String? senderKeyChainId, int? messageNumber, String? dhPublicKey, int? previousChainLength, String? signature
});




}
/// @nodoc
class _$E2eeMetadataCopyWithImpl<$Res>
    implements $E2eeMetadataCopyWith<$Res> {
  _$E2eeMetadataCopyWithImpl(this._self, this._then);

  final E2eeMetadata _self;
  final $Res Function(E2eeMetadata) _then;

/// Create a copy of E2eeMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? protocol = null,Object? senderKeyChainId = freezed,Object? messageNumber = freezed,Object? dhPublicKey = freezed,Object? previousChainLength = freezed,Object? signature = freezed,}) {
  return _then(_self.copyWith(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,senderKeyChainId: freezed == senderKeyChainId ? _self.senderKeyChainId : senderKeyChainId // ignore: cast_nullable_to_non_nullable
as String?,messageNumber: freezed == messageNumber ? _self.messageNumber : messageNumber // ignore: cast_nullable_to_non_nullable
as int?,dhPublicKey: freezed == dhPublicKey ? _self.dhPublicKey : dhPublicKey // ignore: cast_nullable_to_non_nullable
as String?,previousChainLength: freezed == previousChainLength ? _self.previousChainLength : previousChainLength // ignore: cast_nullable_to_non_nullable
as int?,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [E2eeMetadata].
extension E2eeMetadataPatterns on E2eeMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _E2eeMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _E2eeMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _E2eeMetadata value)  $default,){
final _that = this;
switch (_that) {
case _E2eeMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _E2eeMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _E2eeMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String protocol,  String? senderKeyChainId,  int? messageNumber,  String? dhPublicKey,  int? previousChainLength,  String? signature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _E2eeMetadata() when $default != null:
return $default(_that.protocol,_that.senderKeyChainId,_that.messageNumber,_that.dhPublicKey,_that.previousChainLength,_that.signature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String protocol,  String? senderKeyChainId,  int? messageNumber,  String? dhPublicKey,  int? previousChainLength,  String? signature)  $default,) {final _that = this;
switch (_that) {
case _E2eeMetadata():
return $default(_that.protocol,_that.senderKeyChainId,_that.messageNumber,_that.dhPublicKey,_that.previousChainLength,_that.signature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String protocol,  String? senderKeyChainId,  int? messageNumber,  String? dhPublicKey,  int? previousChainLength,  String? signature)?  $default,) {final _that = this;
switch (_that) {
case _E2eeMetadata() when $default != null:
return $default(_that.protocol,_that.senderKeyChainId,_that.messageNumber,_that.dhPublicKey,_that.previousChainLength,_that.signature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _E2eeMetadata implements E2eeMetadata {
  const _E2eeMetadata({required this.protocol, this.senderKeyChainId, this.messageNumber, this.dhPublicKey, this.previousChainLength, this.signature});
  factory _E2eeMetadata.fromJson(Map<String, dynamic> json) => _$E2eeMetadataFromJson(json);

@override final  String protocol;
@override final  String? senderKeyChainId;
@override final  int? messageNumber;
@override final  String? dhPublicKey;
@override final  int? previousChainLength;
/// HMAC-SHA256 sender authentication signature for sender-key messages.
@override final  String? signature;

/// Create a copy of E2eeMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$E2eeMetadataCopyWith<_E2eeMetadata> get copyWith => __$E2eeMetadataCopyWithImpl<_E2eeMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$E2eeMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _E2eeMetadata&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.senderKeyChainId, senderKeyChainId) || other.senderKeyChainId == senderKeyChainId)&&(identical(other.messageNumber, messageNumber) || other.messageNumber == messageNumber)&&(identical(other.dhPublicKey, dhPublicKey) || other.dhPublicKey == dhPublicKey)&&(identical(other.previousChainLength, previousChainLength) || other.previousChainLength == previousChainLength)&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,protocol,senderKeyChainId,messageNumber,dhPublicKey,previousChainLength,signature);

@override
String toString() {
  return 'E2eeMetadata(protocol: $protocol, senderKeyChainId: $senderKeyChainId, messageNumber: $messageNumber, dhPublicKey: $dhPublicKey, previousChainLength: $previousChainLength, signature: $signature)';
}


}

/// @nodoc
abstract mixin class _$E2eeMetadataCopyWith<$Res> implements $E2eeMetadataCopyWith<$Res> {
  factory _$E2eeMetadataCopyWith(_E2eeMetadata value, $Res Function(_E2eeMetadata) _then) = __$E2eeMetadataCopyWithImpl;
@override @useResult
$Res call({
 String protocol, String? senderKeyChainId, int? messageNumber, String? dhPublicKey, int? previousChainLength, String? signature
});




}
/// @nodoc
class __$E2eeMetadataCopyWithImpl<$Res>
    implements _$E2eeMetadataCopyWith<$Res> {
  __$E2eeMetadataCopyWithImpl(this._self, this._then);

  final _E2eeMetadata _self;
  final $Res Function(_E2eeMetadata) _then;

/// Create a copy of E2eeMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? protocol = null,Object? senderKeyChainId = freezed,Object? messageNumber = freezed,Object? dhPublicKey = freezed,Object? previousChainLength = freezed,Object? signature = freezed,}) {
  return _then(_E2eeMetadata(
protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,senderKeyChainId: freezed == senderKeyChainId ? _self.senderKeyChainId : senderKeyChainId // ignore: cast_nullable_to_non_nullable
as String?,messageNumber: freezed == messageNumber ? _self.messageNumber : messageNumber // ignore: cast_nullable_to_non_nullable
as int?,dhPublicKey: freezed == dhPublicKey ? _self.dhPublicKey : dhPublicKey // ignore: cast_nullable_to_non_nullable
as String?,previousChainLength: freezed == previousChainLength ? _self.previousChainLength : previousChainLength // ignore: cast_nullable_to_non_nullable
as int?,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$X3dhHeader {

 String get identityKey; String get ephemeralKey; int? get oneTimePreKeyId;/// Integer ID of the signed pre-key used during X3DH.
/// Required for SPK grace period resolution after rotation.
 int? get signedPreKeyId;
/// Create a copy of X3dhHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$X3dhHeaderCopyWith<X3dhHeader> get copyWith => _$X3dhHeaderCopyWithImpl<X3dhHeader>(this as X3dhHeader, _$identity);

  /// Serializes this X3dhHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is X3dhHeader&&(identical(other.identityKey, identityKey) || other.identityKey == identityKey)&&(identical(other.ephemeralKey, ephemeralKey) || other.ephemeralKey == ephemeralKey)&&(identical(other.oneTimePreKeyId, oneTimePreKeyId) || other.oneTimePreKeyId == oneTimePreKeyId)&&(identical(other.signedPreKeyId, signedPreKeyId) || other.signedPreKeyId == signedPreKeyId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identityKey,ephemeralKey,oneTimePreKeyId,signedPreKeyId);

@override
String toString() {
  return 'X3dhHeader(identityKey: $identityKey, ephemeralKey: $ephemeralKey, oneTimePreKeyId: $oneTimePreKeyId, signedPreKeyId: $signedPreKeyId)';
}


}

/// @nodoc
abstract mixin class $X3dhHeaderCopyWith<$Res>  {
  factory $X3dhHeaderCopyWith(X3dhHeader value, $Res Function(X3dhHeader) _then) = _$X3dhHeaderCopyWithImpl;
@useResult
$Res call({
 String identityKey, String ephemeralKey, int? oneTimePreKeyId, int? signedPreKeyId
});




}
/// @nodoc
class _$X3dhHeaderCopyWithImpl<$Res>
    implements $X3dhHeaderCopyWith<$Res> {
  _$X3dhHeaderCopyWithImpl(this._self, this._then);

  final X3dhHeader _self;
  final $Res Function(X3dhHeader) _then;

/// Create a copy of X3dhHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identityKey = null,Object? ephemeralKey = null,Object? oneTimePreKeyId = freezed,Object? signedPreKeyId = freezed,}) {
  return _then(_self.copyWith(
identityKey: null == identityKey ? _self.identityKey : identityKey // ignore: cast_nullable_to_non_nullable
as String,ephemeralKey: null == ephemeralKey ? _self.ephemeralKey : ephemeralKey // ignore: cast_nullable_to_non_nullable
as String,oneTimePreKeyId: freezed == oneTimePreKeyId ? _self.oneTimePreKeyId : oneTimePreKeyId // ignore: cast_nullable_to_non_nullable
as int?,signedPreKeyId: freezed == signedPreKeyId ? _self.signedPreKeyId : signedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [X3dhHeader].
extension X3dhHeaderPatterns on X3dhHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _X3dhHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _X3dhHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _X3dhHeader value)  $default,){
final _that = this;
switch (_that) {
case _X3dhHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _X3dhHeader value)?  $default,){
final _that = this;
switch (_that) {
case _X3dhHeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identityKey,  String ephemeralKey,  int? oneTimePreKeyId,  int? signedPreKeyId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _X3dhHeader() when $default != null:
return $default(_that.identityKey,_that.ephemeralKey,_that.oneTimePreKeyId,_that.signedPreKeyId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identityKey,  String ephemeralKey,  int? oneTimePreKeyId,  int? signedPreKeyId)  $default,) {final _that = this;
switch (_that) {
case _X3dhHeader():
return $default(_that.identityKey,_that.ephemeralKey,_that.oneTimePreKeyId,_that.signedPreKeyId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identityKey,  String ephemeralKey,  int? oneTimePreKeyId,  int? signedPreKeyId)?  $default,) {final _that = this;
switch (_that) {
case _X3dhHeader() when $default != null:
return $default(_that.identityKey,_that.ephemeralKey,_that.oneTimePreKeyId,_that.signedPreKeyId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _X3dhHeader implements X3dhHeader {
  const _X3dhHeader({required this.identityKey, required this.ephemeralKey, this.oneTimePreKeyId, this.signedPreKeyId});
  factory _X3dhHeader.fromJson(Map<String, dynamic> json) => _$X3dhHeaderFromJson(json);

@override final  String identityKey;
@override final  String ephemeralKey;
@override final  int? oneTimePreKeyId;
/// Integer ID of the signed pre-key used during X3DH.
/// Required for SPK grace period resolution after rotation.
@override final  int? signedPreKeyId;

/// Create a copy of X3dhHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$X3dhHeaderCopyWith<_X3dhHeader> get copyWith => __$X3dhHeaderCopyWithImpl<_X3dhHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$X3dhHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _X3dhHeader&&(identical(other.identityKey, identityKey) || other.identityKey == identityKey)&&(identical(other.ephemeralKey, ephemeralKey) || other.ephemeralKey == ephemeralKey)&&(identical(other.oneTimePreKeyId, oneTimePreKeyId) || other.oneTimePreKeyId == oneTimePreKeyId)&&(identical(other.signedPreKeyId, signedPreKeyId) || other.signedPreKeyId == signedPreKeyId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identityKey,ephemeralKey,oneTimePreKeyId,signedPreKeyId);

@override
String toString() {
  return 'X3dhHeader(identityKey: $identityKey, ephemeralKey: $ephemeralKey, oneTimePreKeyId: $oneTimePreKeyId, signedPreKeyId: $signedPreKeyId)';
}


}

/// @nodoc
abstract mixin class _$X3dhHeaderCopyWith<$Res> implements $X3dhHeaderCopyWith<$Res> {
  factory _$X3dhHeaderCopyWith(_X3dhHeader value, $Res Function(_X3dhHeader) _then) = __$X3dhHeaderCopyWithImpl;
@override @useResult
$Res call({
 String identityKey, String ephemeralKey, int? oneTimePreKeyId, int? signedPreKeyId
});




}
/// @nodoc
class __$X3dhHeaderCopyWithImpl<$Res>
    implements _$X3dhHeaderCopyWith<$Res> {
  __$X3dhHeaderCopyWithImpl(this._self, this._then);

  final _X3dhHeader _self;
  final $Res Function(_X3dhHeader) _then;

/// Create a copy of X3dhHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identityKey = null,Object? ephemeralKey = null,Object? oneTimePreKeyId = freezed,Object? signedPreKeyId = freezed,}) {
  return _then(_X3dhHeader(
identityKey: null == identityKey ? _self.identityKey : identityKey // ignore: cast_nullable_to_non_nullable
as String,ephemeralKey: null == ephemeralKey ? _self.ephemeralKey : ephemeralKey // ignore: cast_nullable_to_non_nullable
as String,oneTimePreKeyId: freezed == oneTimePreKeyId ? _self.oneTimePreKeyId : oneTimePreKeyId // ignore: cast_nullable_to_non_nullable
as int?,signedPreKeyId: freezed == signedPreKeyId ? _self.signedPreKeyId : signedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Message {

 String get id;// Sender
 String get senderId; String get senderName; String? get senderAvatarUrl;// Content
 MessageType get type; MessageStatus get status; String? get textContent;// Token operations
 int? get tokenAmount; String? get recipientId; String? get ledgerJournalId;// Media
 MessageMedia? get media;// Interactions
 Map<String, List<String>> get reactions; MessageReply? get replyTo;// Read receipts & forwarding
 Map<String, DateTime> get readBy; ForwardedFrom? get forwardedFrom;// Gift & spray embedded data
 GiftMessageData? get gift; GroupGiftMessageData? get groupGift; TokenSprayMessageData? get tokenSpray;// Community-specific
 String? get communityId; String? get systemEventType; Map<String, dynamic>? get systemEventData;// E2EE (null when plaintext / E2EE not yet enabled)
 String? get ciphertext; E2eeMetadata? get e2ee; X3dhHeader? get x3dhHeader;// Timestamps
 DateTime get createdAt; DateTime? get expiresAt; DateTime? get actionedAt; DateTime? get deletedAt;// Deletion
 List<String> get deletedFor; bool get deletedForEveryone;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.ledgerJournalId, ledgerJournalId) || other.ledgerJournalId == ledgerJournalId)&&(identical(other.media, media) || other.media == media)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&const DeepCollectionEquality().equals(other.readBy, readBy)&&(identical(other.forwardedFrom, forwardedFrom) || other.forwardedFrom == forwardedFrom)&&(identical(other.gift, gift) || other.gift == gift)&&(identical(other.groupGift, groupGift) || other.groupGift == groupGift)&&(identical(other.tokenSpray, tokenSpray) || other.tokenSpray == tokenSpray)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.systemEventType, systemEventType) || other.systemEventType == systemEventType)&&const DeepCollectionEquality().equals(other.systemEventData, systemEventData)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&(identical(other.e2ee, e2ee) || other.e2ee == e2ee)&&(identical(other.x3dhHeader, x3dhHeader) || other.x3dhHeader == x3dhHeader)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&const DeepCollectionEquality().equals(other.deletedFor, deletedFor)&&(identical(other.deletedForEveryone, deletedForEveryone) || other.deletedForEveryone == deletedForEveryone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,senderId,senderName,senderAvatarUrl,type,status,textContent,tokenAmount,recipientId,ledgerJournalId,media,const DeepCollectionEquality().hash(reactions),replyTo,const DeepCollectionEquality().hash(readBy),forwardedFrom,gift,groupGift,tokenSpray,communityId,systemEventType,const DeepCollectionEquality().hash(systemEventData),ciphertext,e2ee,x3dhHeader,createdAt,expiresAt,actionedAt,deletedAt,const DeepCollectionEquality().hash(deletedFor),deletedForEveryone]);

@override
String toString() {
  return 'Message(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, recipientId: $recipientId, ledgerJournalId: $ledgerJournalId, media: $media, reactions: $reactions, replyTo: $replyTo, readBy: $readBy, forwardedFrom: $forwardedFrom, gift: $gift, groupGift: $groupGift, tokenSpray: $tokenSpray, communityId: $communityId, systemEventType: $systemEventType, systemEventData: $systemEventData, ciphertext: $ciphertext, e2ee: $e2ee, x3dhHeader: $x3dhHeader, createdAt: $createdAt, expiresAt: $expiresAt, actionedAt: $actionedAt, deletedAt: $deletedAt, deletedFor: $deletedFor, deletedForEveryone: $deletedForEveryone)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderName, String? senderAvatarUrl, MessageType type, MessageStatus status, String? textContent, int? tokenAmount, String? recipientId, String? ledgerJournalId, MessageMedia? media, Map<String, List<String>> reactions, MessageReply? replyTo, Map<String, DateTime> readBy, ForwardedFrom? forwardedFrom, GiftMessageData? gift, GroupGiftMessageData? groupGift, TokenSprayMessageData? tokenSpray, String? communityId, String? systemEventType, Map<String, dynamic>? systemEventData, String? ciphertext, E2eeMetadata? e2ee, X3dhHeader? x3dhHeader, DateTime createdAt, DateTime? expiresAt, DateTime? actionedAt, DateTime? deletedAt, List<String> deletedFor, bool deletedForEveryone
});


$MessageMediaCopyWith<$Res>? get media;$MessageReplyCopyWith<$Res>? get replyTo;$ForwardedFromCopyWith<$Res>? get forwardedFrom;$GiftMessageDataCopyWith<$Res>? get gift;$GroupGiftMessageDataCopyWith<$Res>? get groupGift;$TokenSprayMessageDataCopyWith<$Res>? get tokenSpray;$E2eeMetadataCopyWith<$Res>? get e2ee;$X3dhHeaderCopyWith<$Res>? get x3dhHeader;

}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? senderAvatarUrl = freezed,Object? type = null,Object? status = null,Object? textContent = freezed,Object? tokenAmount = freezed,Object? recipientId = freezed,Object? ledgerJournalId = freezed,Object? media = freezed,Object? reactions = null,Object? replyTo = freezed,Object? readBy = null,Object? forwardedFrom = freezed,Object? gift = freezed,Object? groupGift = freezed,Object? tokenSpray = freezed,Object? communityId = freezed,Object? systemEventType = freezed,Object? systemEventData = freezed,Object? ciphertext = freezed,Object? e2ee = freezed,Object? x3dhHeader = freezed,Object? createdAt = null,Object? expiresAt = freezed,Object? actionedAt = freezed,Object? deletedAt = freezed,Object? deletedFor = null,Object? deletedForEveryone = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,tokenAmount: freezed == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int?,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,ledgerJournalId: freezed == ledgerJournalId ? _self.ledgerJournalId : ledgerJournalId // ignore: cast_nullable_to_non_nullable
as String?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as MessageMedia?,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as MessageReply?,readBy: null == readBy ? _self.readBy : readBy // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,forwardedFrom: freezed == forwardedFrom ? _self.forwardedFrom : forwardedFrom // ignore: cast_nullable_to_non_nullable
as ForwardedFrom?,gift: freezed == gift ? _self.gift : gift // ignore: cast_nullable_to_non_nullable
as GiftMessageData?,groupGift: freezed == groupGift ? _self.groupGift : groupGift // ignore: cast_nullable_to_non_nullable
as GroupGiftMessageData?,tokenSpray: freezed == tokenSpray ? _self.tokenSpray : tokenSpray // ignore: cast_nullable_to_non_nullable
as TokenSprayMessageData?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,systemEventType: freezed == systemEventType ? _self.systemEventType : systemEventType // ignore: cast_nullable_to_non_nullable
as String?,systemEventData: freezed == systemEventData ? _self.systemEventData : systemEventData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ciphertext: freezed == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String?,e2ee: freezed == e2ee ? _self.e2ee : e2ee // ignore: cast_nullable_to_non_nullable
as E2eeMetadata?,x3dhHeader: freezed == x3dhHeader ? _self.x3dhHeader : x3dhHeader // ignore: cast_nullable_to_non_nullable
as X3dhHeader?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedFor: null == deletedFor ? _self.deletedFor : deletedFor // ignore: cast_nullable_to_non_nullable
as List<String>,deletedForEveryone: null == deletedForEveryone ? _self.deletedForEveryone : deletedForEveryone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageMediaCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $MessageMediaCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageReplyCopyWith<$Res>? get replyTo {
    if (_self.replyTo == null) {
    return null;
  }

  return $MessageReplyCopyWith<$Res>(_self.replyTo!, (value) {
    return _then(_self.copyWith(replyTo: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForwardedFromCopyWith<$Res>? get forwardedFrom {
    if (_self.forwardedFrom == null) {
    return null;
  }

  return $ForwardedFromCopyWith<$Res>(_self.forwardedFrom!, (value) {
    return _then(_self.copyWith(forwardedFrom: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftMessageDataCopyWith<$Res>? get gift {
    if (_self.gift == null) {
    return null;
  }

  return $GiftMessageDataCopyWith<$Res>(_self.gift!, (value) {
    return _then(_self.copyWith(gift: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupGiftMessageDataCopyWith<$Res>? get groupGift {
    if (_self.groupGift == null) {
    return null;
  }

  return $GroupGiftMessageDataCopyWith<$Res>(_self.groupGift!, (value) {
    return _then(_self.copyWith(groupGift: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenSprayMessageDataCopyWith<$Res>? get tokenSpray {
    if (_self.tokenSpray == null) {
    return null;
  }

  return $TokenSprayMessageDataCopyWith<$Res>(_self.tokenSpray!, (value) {
    return _then(_self.copyWith(tokenSpray: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$E2eeMetadataCopyWith<$Res>? get e2ee {
    if (_self.e2ee == null) {
    return null;
  }

  return $E2eeMetadataCopyWith<$Res>(_self.e2ee!, (value) {
    return _then(_self.copyWith(e2ee: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$X3dhHeaderCopyWith<$Res>? get x3dhHeader {
    if (_self.x3dhHeader == null) {
    return null;
  }

  return $X3dhHeaderCopyWith<$Res>(_self.x3dhHeader!, (value) {
    return _then(_self.copyWith(x3dhHeader: value));
  });
}
}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Message value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Message value)  $default,){
final _that = this;
switch (_that) {
case _Message():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Message value)?  $default,){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String? senderAvatarUrl,  MessageType type,  MessageStatus status,  String? textContent,  int? tokenAmount,  String? recipientId,  String? ledgerJournalId,  MessageMedia? media,  Map<String, List<String>> reactions,  MessageReply? replyTo,  Map<String, DateTime> readBy,  ForwardedFrom? forwardedFrom,  GiftMessageData? gift,  GroupGiftMessageData? groupGift,  TokenSprayMessageData? tokenSpray,  String? communityId,  String? systemEventType,  Map<String, dynamic>? systemEventData,  String? ciphertext,  E2eeMetadata? e2ee,  X3dhHeader? x3dhHeader,  DateTime createdAt,  DateTime? expiresAt,  DateTime? actionedAt,  DateTime? deletedAt,  List<String> deletedFor,  bool deletedForEveryone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatarUrl,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.recipientId,_that.ledgerJournalId,_that.media,_that.reactions,_that.replyTo,_that.readBy,_that.forwardedFrom,_that.gift,_that.groupGift,_that.tokenSpray,_that.communityId,_that.systemEventType,_that.systemEventData,_that.ciphertext,_that.e2ee,_that.x3dhHeader,_that.createdAt,_that.expiresAt,_that.actionedAt,_that.deletedAt,_that.deletedFor,_that.deletedForEveryone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String? senderAvatarUrl,  MessageType type,  MessageStatus status,  String? textContent,  int? tokenAmount,  String? recipientId,  String? ledgerJournalId,  MessageMedia? media,  Map<String, List<String>> reactions,  MessageReply? replyTo,  Map<String, DateTime> readBy,  ForwardedFrom? forwardedFrom,  GiftMessageData? gift,  GroupGiftMessageData? groupGift,  TokenSprayMessageData? tokenSpray,  String? communityId,  String? systemEventType,  Map<String, dynamic>? systemEventData,  String? ciphertext,  E2eeMetadata? e2ee,  X3dhHeader? x3dhHeader,  DateTime createdAt,  DateTime? expiresAt,  DateTime? actionedAt,  DateTime? deletedAt,  List<String> deletedFor,  bool deletedForEveryone)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatarUrl,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.recipientId,_that.ledgerJournalId,_that.media,_that.reactions,_that.replyTo,_that.readBy,_that.forwardedFrom,_that.gift,_that.groupGift,_that.tokenSpray,_that.communityId,_that.systemEventType,_that.systemEventData,_that.ciphertext,_that.e2ee,_that.x3dhHeader,_that.createdAt,_that.expiresAt,_that.actionedAt,_that.deletedAt,_that.deletedFor,_that.deletedForEveryone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderName,  String? senderAvatarUrl,  MessageType type,  MessageStatus status,  String? textContent,  int? tokenAmount,  String? recipientId,  String? ledgerJournalId,  MessageMedia? media,  Map<String, List<String>> reactions,  MessageReply? replyTo,  Map<String, DateTime> readBy,  ForwardedFrom? forwardedFrom,  GiftMessageData? gift,  GroupGiftMessageData? groupGift,  TokenSprayMessageData? tokenSpray,  String? communityId,  String? systemEventType,  Map<String, dynamic>? systemEventData,  String? ciphertext,  E2eeMetadata? e2ee,  X3dhHeader? x3dhHeader,  DateTime createdAt,  DateTime? expiresAt,  DateTime? actionedAt,  DateTime? deletedAt,  List<String> deletedFor,  bool deletedForEveryone)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatarUrl,_that.type,_that.status,_that.textContent,_that.tokenAmount,_that.recipientId,_that.ledgerJournalId,_that.media,_that.reactions,_that.replyTo,_that.readBy,_that.forwardedFrom,_that.gift,_that.groupGift,_that.tokenSpray,_that.communityId,_that.systemEventType,_that.systemEventData,_that.ciphertext,_that.e2ee,_that.x3dhHeader,_that.createdAt,_that.expiresAt,_that.actionedAt,_that.deletedAt,_that.deletedFor,_that.deletedForEveryone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Message extends Message {
  const _Message({required this.id, required this.senderId, required this.senderName, this.senderAvatarUrl, required this.type, required this.status, this.textContent, this.tokenAmount, this.recipientId, this.ledgerJournalId, this.media, final  Map<String, List<String>> reactions = const {}, this.replyTo, final  Map<String, DateTime> readBy = const {}, this.forwardedFrom, this.gift, this.groupGift, this.tokenSpray, this.communityId, this.systemEventType, final  Map<String, dynamic>? systemEventData, this.ciphertext, this.e2ee, this.x3dhHeader, required this.createdAt, this.expiresAt, this.actionedAt, this.deletedAt, final  List<String> deletedFor = const [], this.deletedForEveryone = false}): _reactions = reactions,_readBy = readBy,_systemEventData = systemEventData,_deletedFor = deletedFor,super._();
  factory _Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

@override final  String id;
// Sender
@override final  String senderId;
@override final  String senderName;
@override final  String? senderAvatarUrl;
// Content
@override final  MessageType type;
@override final  MessageStatus status;
@override final  String? textContent;
// Token operations
@override final  int? tokenAmount;
@override final  String? recipientId;
@override final  String? ledgerJournalId;
// Media
@override final  MessageMedia? media;
// Interactions
 final  Map<String, List<String>> _reactions;
// Interactions
@override@JsonKey() Map<String, List<String>> get reactions {
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactions);
}

@override final  MessageReply? replyTo;
// Read receipts & forwarding
 final  Map<String, DateTime> _readBy;
// Read receipts & forwarding
@override@JsonKey() Map<String, DateTime> get readBy {
  if (_readBy is EqualUnmodifiableMapView) return _readBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_readBy);
}

@override final  ForwardedFrom? forwardedFrom;
// Gift & spray embedded data
@override final  GiftMessageData? gift;
@override final  GroupGiftMessageData? groupGift;
@override final  TokenSprayMessageData? tokenSpray;
// Community-specific
@override final  String? communityId;
@override final  String? systemEventType;
 final  Map<String, dynamic>? _systemEventData;
@override Map<String, dynamic>? get systemEventData {
  final value = _systemEventData;
  if (value == null) return null;
  if (_systemEventData is EqualUnmodifiableMapView) return _systemEventData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// E2EE (null when plaintext / E2EE not yet enabled)
@override final  String? ciphertext;
@override final  E2eeMetadata? e2ee;
@override final  X3dhHeader? x3dhHeader;
// Timestamps
@override final  DateTime createdAt;
@override final  DateTime? expiresAt;
@override final  DateTime? actionedAt;
@override final  DateTime? deletedAt;
// Deletion
 final  List<String> _deletedFor;
// Deletion
@override@JsonKey() List<String> get deletedFor {
  if (_deletedFor is EqualUnmodifiableListView) return _deletedFor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deletedFor);
}

@override@JsonKey() final  bool deletedForEveryone;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCopyWith<_Message> get copyWith => __$MessageCopyWithImpl<_Message>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.textContent, textContent) || other.textContent == textContent)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.ledgerJournalId, ledgerJournalId) || other.ledgerJournalId == ledgerJournalId)&&(identical(other.media, media) || other.media == media)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&const DeepCollectionEquality().equals(other._readBy, _readBy)&&(identical(other.forwardedFrom, forwardedFrom) || other.forwardedFrom == forwardedFrom)&&(identical(other.gift, gift) || other.gift == gift)&&(identical(other.groupGift, groupGift) || other.groupGift == groupGift)&&(identical(other.tokenSpray, tokenSpray) || other.tokenSpray == tokenSpray)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.systemEventType, systemEventType) || other.systemEventType == systemEventType)&&const DeepCollectionEquality().equals(other._systemEventData, _systemEventData)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&(identical(other.e2ee, e2ee) || other.e2ee == e2ee)&&(identical(other.x3dhHeader, x3dhHeader) || other.x3dhHeader == x3dhHeader)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&const DeepCollectionEquality().equals(other._deletedFor, _deletedFor)&&(identical(other.deletedForEveryone, deletedForEveryone) || other.deletedForEveryone == deletedForEveryone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,senderId,senderName,senderAvatarUrl,type,status,textContent,tokenAmount,recipientId,ledgerJournalId,media,const DeepCollectionEquality().hash(_reactions),replyTo,const DeepCollectionEquality().hash(_readBy),forwardedFrom,gift,groupGift,tokenSpray,communityId,systemEventType,const DeepCollectionEquality().hash(_systemEventData),ciphertext,e2ee,x3dhHeader,createdAt,expiresAt,actionedAt,deletedAt,const DeepCollectionEquality().hash(_deletedFor),deletedForEveryone]);

@override
String toString() {
  return 'Message(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, recipientId: $recipientId, ledgerJournalId: $ledgerJournalId, media: $media, reactions: $reactions, replyTo: $replyTo, readBy: $readBy, forwardedFrom: $forwardedFrom, gift: $gift, groupGift: $groupGift, tokenSpray: $tokenSpray, communityId: $communityId, systemEventType: $systemEventType, systemEventData: $systemEventData, ciphertext: $ciphertext, e2ee: $e2ee, x3dhHeader: $x3dhHeader, createdAt: $createdAt, expiresAt: $expiresAt, actionedAt: $actionedAt, deletedAt: $deletedAt, deletedFor: $deletedFor, deletedForEveryone: $deletedForEveryone)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderName, String? senderAvatarUrl, MessageType type, MessageStatus status, String? textContent, int? tokenAmount, String? recipientId, String? ledgerJournalId, MessageMedia? media, Map<String, List<String>> reactions, MessageReply? replyTo, Map<String, DateTime> readBy, ForwardedFrom? forwardedFrom, GiftMessageData? gift, GroupGiftMessageData? groupGift, TokenSprayMessageData? tokenSpray, String? communityId, String? systemEventType, Map<String, dynamic>? systemEventData, String? ciphertext, E2eeMetadata? e2ee, X3dhHeader? x3dhHeader, DateTime createdAt, DateTime? expiresAt, DateTime? actionedAt, DateTime? deletedAt, List<String> deletedFor, bool deletedForEveryone
});


@override $MessageMediaCopyWith<$Res>? get media;@override $MessageReplyCopyWith<$Res>? get replyTo;@override $ForwardedFromCopyWith<$Res>? get forwardedFrom;@override $GiftMessageDataCopyWith<$Res>? get gift;@override $GroupGiftMessageDataCopyWith<$Res>? get groupGift;@override $TokenSprayMessageDataCopyWith<$Res>? get tokenSpray;@override $E2eeMetadataCopyWith<$Res>? get e2ee;@override $X3dhHeaderCopyWith<$Res>? get x3dhHeader;

}
/// @nodoc
class __$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? senderAvatarUrl = freezed,Object? type = null,Object? status = null,Object? textContent = freezed,Object? tokenAmount = freezed,Object? recipientId = freezed,Object? ledgerJournalId = freezed,Object? media = freezed,Object? reactions = null,Object? replyTo = freezed,Object? readBy = null,Object? forwardedFrom = freezed,Object? gift = freezed,Object? groupGift = freezed,Object? tokenSpray = freezed,Object? communityId = freezed,Object? systemEventType = freezed,Object? systemEventData = freezed,Object? ciphertext = freezed,Object? e2ee = freezed,Object? x3dhHeader = freezed,Object? createdAt = null,Object? expiresAt = freezed,Object? actionedAt = freezed,Object? deletedAt = freezed,Object? deletedFor = null,Object? deletedForEveryone = null,}) {
  return _then(_Message(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,textContent: freezed == textContent ? _self.textContent : textContent // ignore: cast_nullable_to_non_nullable
as String?,tokenAmount: freezed == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int?,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,ledgerJournalId: freezed == ledgerJournalId ? _self.ledgerJournalId : ledgerJournalId // ignore: cast_nullable_to_non_nullable
as String?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as MessageMedia?,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as MessageReply?,readBy: null == readBy ? _self._readBy : readBy // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,forwardedFrom: freezed == forwardedFrom ? _self.forwardedFrom : forwardedFrom // ignore: cast_nullable_to_non_nullable
as ForwardedFrom?,gift: freezed == gift ? _self.gift : gift // ignore: cast_nullable_to_non_nullable
as GiftMessageData?,groupGift: freezed == groupGift ? _self.groupGift : groupGift // ignore: cast_nullable_to_non_nullable
as GroupGiftMessageData?,tokenSpray: freezed == tokenSpray ? _self.tokenSpray : tokenSpray // ignore: cast_nullable_to_non_nullable
as TokenSprayMessageData?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,systemEventType: freezed == systemEventType ? _self.systemEventType : systemEventType // ignore: cast_nullable_to_non_nullable
as String?,systemEventData: freezed == systemEventData ? _self._systemEventData : systemEventData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ciphertext: freezed == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String?,e2ee: freezed == e2ee ? _self.e2ee : e2ee // ignore: cast_nullable_to_non_nullable
as E2eeMetadata?,x3dhHeader: freezed == x3dhHeader ? _self.x3dhHeader : x3dhHeader // ignore: cast_nullable_to_non_nullable
as X3dhHeader?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedFor: null == deletedFor ? _self._deletedFor : deletedFor // ignore: cast_nullable_to_non_nullable
as List<String>,deletedForEveryone: null == deletedForEveryone ? _self.deletedForEveryone : deletedForEveryone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageMediaCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $MessageMediaCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageReplyCopyWith<$Res>? get replyTo {
    if (_self.replyTo == null) {
    return null;
  }

  return $MessageReplyCopyWith<$Res>(_self.replyTo!, (value) {
    return _then(_self.copyWith(replyTo: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForwardedFromCopyWith<$Res>? get forwardedFrom {
    if (_self.forwardedFrom == null) {
    return null;
  }

  return $ForwardedFromCopyWith<$Res>(_self.forwardedFrom!, (value) {
    return _then(_self.copyWith(forwardedFrom: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftMessageDataCopyWith<$Res>? get gift {
    if (_self.gift == null) {
    return null;
  }

  return $GiftMessageDataCopyWith<$Res>(_self.gift!, (value) {
    return _then(_self.copyWith(gift: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupGiftMessageDataCopyWith<$Res>? get groupGift {
    if (_self.groupGift == null) {
    return null;
  }

  return $GroupGiftMessageDataCopyWith<$Res>(_self.groupGift!, (value) {
    return _then(_self.copyWith(groupGift: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenSprayMessageDataCopyWith<$Res>? get tokenSpray {
    if (_self.tokenSpray == null) {
    return null;
  }

  return $TokenSprayMessageDataCopyWith<$Res>(_self.tokenSpray!, (value) {
    return _then(_self.copyWith(tokenSpray: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$E2eeMetadataCopyWith<$Res>? get e2ee {
    if (_self.e2ee == null) {
    return null;
  }

  return $E2eeMetadataCopyWith<$Res>(_self.e2ee!, (value) {
    return _then(_self.copyWith(e2ee: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$X3dhHeaderCopyWith<$Res>? get x3dhHeader {
    if (_self.x3dhHeader == null) {
    return null;
  }

  return $X3dhHeaderCopyWith<$Res>(_self.x3dhHeader!, (value) {
    return _then(_self.copyWith(x3dhHeader: value));
  });
}
}

// dart format on
