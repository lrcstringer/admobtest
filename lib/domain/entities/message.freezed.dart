// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MessageMedia _$MessageMediaFromJson(Map<String, dynamic> json) {
  return _MessageMedia.fromJson(json);
}

/// @nodoc
mixin _$MessageMedia {
  String get url => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  /// AES-256-GCM key used to encrypt the full media file (E2EE)
  String? get mediaKey => throw _privateConstructorUsedError;

  /// AES-256-GCM key used to encrypt the thumbnail (E2EE)
  String? get thumbKey => throw _privateConstructorUsedError;

  /// Serializes this MessageMedia to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageMedia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageMediaCopyWith<MessageMedia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageMediaCopyWith<$Res> {
  factory $MessageMediaCopyWith(
    MessageMedia value,
    $Res Function(MessageMedia) then,
  ) = _$MessageMediaCopyWithImpl<$Res, MessageMedia>;
  @useResult
  $Res call({
    String url,
    String? thumbnailUrl,
    String fileName,
    int fileSize,
    String mimeType,
    int? duration,
    int? width,
    int? height,
    String? mediaKey,
    String? thumbKey,
  });
}

/// @nodoc
class _$MessageMediaCopyWithImpl<$Res, $Val extends MessageMedia>
    implements $MessageMediaCopyWith<$Res> {
  _$MessageMediaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageMedia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? fileName = null,
    Object? fileSize = null,
    Object? mimeType = null,
    Object? duration = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? mediaKey = freezed,
    Object? thumbKey = freezed,
  }) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            fileSize: null == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int,
            mimeType: null == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
            width: freezed == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int?,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
            mediaKey: freezed == mediaKey
                ? _value.mediaKey
                : mediaKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbKey: freezed == thumbKey
                ? _value.thumbKey
                : thumbKey // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageMediaImplCopyWith<$Res>
    implements $MessageMediaCopyWith<$Res> {
  factory _$$MessageMediaImplCopyWith(
    _$MessageMediaImpl value,
    $Res Function(_$MessageMediaImpl) then,
  ) = __$$MessageMediaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String url,
    String? thumbnailUrl,
    String fileName,
    int fileSize,
    String mimeType,
    int? duration,
    int? width,
    int? height,
    String? mediaKey,
    String? thumbKey,
  });
}

/// @nodoc
class __$$MessageMediaImplCopyWithImpl<$Res>
    extends _$MessageMediaCopyWithImpl<$Res, _$MessageMediaImpl>
    implements _$$MessageMediaImplCopyWith<$Res> {
  __$$MessageMediaImplCopyWithImpl(
    _$MessageMediaImpl _value,
    $Res Function(_$MessageMediaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageMedia
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? fileName = null,
    Object? fileSize = null,
    Object? mimeType = null,
    Object? duration = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? mediaKey = freezed,
    Object? thumbKey = freezed,
  }) {
    return _then(
      _$MessageMediaImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        fileSize: null == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int,
        mimeType: null == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
        width: freezed == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        mediaKey: freezed == mediaKey
            ? _value.mediaKey
            : mediaKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbKey: freezed == thumbKey
            ? _value.thumbKey
            : thumbKey // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageMediaImpl implements _MessageMedia {
  const _$MessageMediaImpl({
    required this.url,
    this.thumbnailUrl,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    this.duration,
    this.width,
    this.height,
    this.mediaKey,
    this.thumbKey,
  });

  factory _$MessageMediaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageMediaImplFromJson(json);

  @override
  final String url;
  @override
  final String? thumbnailUrl;
  @override
  final String fileName;
  @override
  final int fileSize;
  @override
  final String mimeType;
  @override
  final int? duration;
  @override
  final int? width;
  @override
  final int? height;

  /// AES-256-GCM key used to encrypt the full media file (E2EE)
  @override
  final String? mediaKey;

  /// AES-256-GCM key used to encrypt the thumbnail (E2EE)
  @override
  final String? thumbKey;

  @override
  String toString() {
    return 'MessageMedia(url: $url, thumbnailUrl: $thumbnailUrl, fileName: $fileName, fileSize: $fileSize, mimeType: $mimeType, duration: $duration, width: $width, height: $height, mediaKey: $mediaKey, thumbKey: $thumbKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageMediaImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.mediaKey, mediaKey) ||
                other.mediaKey == mediaKey) &&
            (identical(other.thumbKey, thumbKey) ||
                other.thumbKey == thumbKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    url,
    thumbnailUrl,
    fileName,
    fileSize,
    mimeType,
    duration,
    width,
    height,
    mediaKey,
    thumbKey,
  );

  /// Create a copy of MessageMedia
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageMediaImplCopyWith<_$MessageMediaImpl> get copyWith =>
      __$$MessageMediaImplCopyWithImpl<_$MessageMediaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageMediaImplToJson(this);
  }
}

abstract class _MessageMedia implements MessageMedia {
  const factory _MessageMedia({
    required final String url,
    final String? thumbnailUrl,
    required final String fileName,
    required final int fileSize,
    required final String mimeType,
    final int? duration,
    final int? width,
    final int? height,
    final String? mediaKey,
    final String? thumbKey,
  }) = _$MessageMediaImpl;

  factory _MessageMedia.fromJson(Map<String, dynamic> json) =
      _$MessageMediaImpl.fromJson;

  @override
  String get url;
  @override
  String? get thumbnailUrl;
  @override
  String get fileName;
  @override
  int get fileSize;
  @override
  String get mimeType;
  @override
  int? get duration;
  @override
  int? get width;
  @override
  int? get height;

  /// AES-256-GCM key used to encrypt the full media file (E2EE)
  @override
  String? get mediaKey;

  /// AES-256-GCM key used to encrypt the thumbnail (E2EE)
  @override
  String? get thumbKey;

  /// Create a copy of MessageMedia
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageMediaImplCopyWith<_$MessageMediaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageReply _$MessageReplyFromJson(Map<String, dynamic> json) {
  return _MessageReply.fromJson(json);
}

/// @nodoc
mixin _$MessageReply {
  String get messageId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this MessageReply to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageReplyCopyWith<MessageReply> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageReplyCopyWith<$Res> {
  factory $MessageReplyCopyWith(
    MessageReply value,
    $Res Function(MessageReply) then,
  ) = _$MessageReplyCopyWithImpl<$Res, MessageReply>;
  @useResult
  $Res call({String messageId, String senderName, String text, String type});
}

/// @nodoc
class _$MessageReplyCopyWithImpl<$Res, $Val extends MessageReply>
    implements $MessageReplyCopyWith<$Res> {
  _$MessageReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? senderName = null,
    Object? text = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            messageId: null == messageId
                ? _value.messageId
                : messageId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageReplyImplCopyWith<$Res>
    implements $MessageReplyCopyWith<$Res> {
  factory _$$MessageReplyImplCopyWith(
    _$MessageReplyImpl value,
    $Res Function(_$MessageReplyImpl) then,
  ) = __$$MessageReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String messageId, String senderName, String text, String type});
}

/// @nodoc
class __$$MessageReplyImplCopyWithImpl<$Res>
    extends _$MessageReplyCopyWithImpl<$Res, _$MessageReplyImpl>
    implements _$$MessageReplyImplCopyWith<$Res> {
  __$$MessageReplyImplCopyWithImpl(
    _$MessageReplyImpl _value,
    $Res Function(_$MessageReplyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? senderName = null,
    Object? text = null,
    Object? type = null,
  }) {
    return _then(
      _$MessageReplyImpl(
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageReplyImpl implements _MessageReply {
  const _$MessageReplyImpl({
    required this.messageId,
    required this.senderName,
    required this.text,
    required this.type,
  });

  factory _$MessageReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageReplyImplFromJson(json);

  @override
  final String messageId;
  @override
  final String senderName;
  @override
  final String text;
  @override
  final String type;

  @override
  String toString() {
    return 'MessageReply(messageId: $messageId, senderName: $senderName, text: $text, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageReplyImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, messageId, senderName, text, type);

  /// Create a copy of MessageReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageReplyImplCopyWith<_$MessageReplyImpl> get copyWith =>
      __$$MessageReplyImplCopyWithImpl<_$MessageReplyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageReplyImplToJson(this);
  }
}

abstract class _MessageReply implements MessageReply {
  const factory _MessageReply({
    required final String messageId,
    required final String senderName,
    required final String text,
    required final String type,
  }) = _$MessageReplyImpl;

  factory _MessageReply.fromJson(Map<String, dynamic> json) =
      _$MessageReplyImpl.fromJson;

  @override
  String get messageId;
  @override
  String get senderName;
  @override
  String get text;
  @override
  String get type;

  /// Create a copy of MessageReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageReplyImplCopyWith<_$MessageReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GiftMessageData _$GiftMessageDataFromJson(Map<String, dynamic> json) {
  return _GiftMessageData.fromJson(json);
}

/// @nodoc
mixin _$GiftMessageData {
  String get giftId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  GiftStyle get style => throw _privateConstructorUsedError;
  GiftStatus get status => throw _privateConstructorUsedError;
  String? get recipientId => throw _privateConstructorUsedError;
  String? get recipientName => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this GiftMessageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftMessageDataCopyWith<GiftMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftMessageDataCopyWith<$Res> {
  factory $GiftMessageDataCopyWith(
    GiftMessageData value,
    $Res Function(GiftMessageData) then,
  ) = _$GiftMessageDataCopyWithImpl<$Res, GiftMessageData>;
  @useResult
  $Res call({
    String giftId,
    int amount,
    String message,
    GiftStyle style,
    GiftStatus status,
    String? recipientId,
    String? recipientName,
    DateTime? expiresAt,
  });
}

/// @nodoc
class _$GiftMessageDataCopyWithImpl<$Res, $Val extends GiftMessageData>
    implements $GiftMessageDataCopyWith<$Res> {
  _$GiftMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? giftId = null,
    Object? amount = null,
    Object? message = null,
    Object? style = null,
    Object? status = null,
    Object? recipientId = freezed,
    Object? recipientName = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            giftId: null == giftId
                ? _value.giftId
                : giftId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            style: null == style
                ? _value.style
                : style // ignore: cast_nullable_to_non_nullable
                      as GiftStyle,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GiftStatus,
            recipientId: freezed == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            recipientName: freezed == recipientName
                ? _value.recipientName
                : recipientName // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GiftMessageDataImplCopyWith<$Res>
    implements $GiftMessageDataCopyWith<$Res> {
  factory _$$GiftMessageDataImplCopyWith(
    _$GiftMessageDataImpl value,
    $Res Function(_$GiftMessageDataImpl) then,
  ) = __$$GiftMessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String giftId,
    int amount,
    String message,
    GiftStyle style,
    GiftStatus status,
    String? recipientId,
    String? recipientName,
    DateTime? expiresAt,
  });
}

/// @nodoc
class __$$GiftMessageDataImplCopyWithImpl<$Res>
    extends _$GiftMessageDataCopyWithImpl<$Res, _$GiftMessageDataImpl>
    implements _$$GiftMessageDataImplCopyWith<$Res> {
  __$$GiftMessageDataImplCopyWithImpl(
    _$GiftMessageDataImpl _value,
    $Res Function(_$GiftMessageDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? giftId = null,
    Object? amount = null,
    Object? message = null,
    Object? style = null,
    Object? status = null,
    Object? recipientId = freezed,
    Object? recipientName = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _$GiftMessageDataImpl(
        giftId: null == giftId
            ? _value.giftId
            : giftId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        style: null == style
            ? _value.style
            : style // ignore: cast_nullable_to_non_nullable
                  as GiftStyle,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GiftStatus,
        recipientId: freezed == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        recipientName: freezed == recipientName
            ? _value.recipientName
            : recipientName // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftMessageDataImpl implements _GiftMessageData {
  const _$GiftMessageDataImpl({
    required this.giftId,
    required this.amount,
    required this.message,
    required this.style,
    required this.status,
    this.recipientId,
    this.recipientName,
    this.expiresAt,
  });

  factory _$GiftMessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftMessageDataImplFromJson(json);

  @override
  final String giftId;
  @override
  final int amount;
  @override
  final String message;
  @override
  final GiftStyle style;
  @override
  final GiftStatus status;
  @override
  final String? recipientId;
  @override
  final String? recipientName;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'GiftMessageData(giftId: $giftId, amount: $amount, message: $message, style: $style, status: $status, recipientId: $recipientId, recipientName: $recipientName, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftMessageDataImpl &&
            (identical(other.giftId, giftId) || other.giftId == giftId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    giftId,
    amount,
    message,
    style,
    status,
    recipientId,
    recipientName,
    expiresAt,
  );

  /// Create a copy of GiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftMessageDataImplCopyWith<_$GiftMessageDataImpl> get copyWith =>
      __$$GiftMessageDataImplCopyWithImpl<_$GiftMessageDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftMessageDataImplToJson(this);
  }
}

abstract class _GiftMessageData implements GiftMessageData {
  const factory _GiftMessageData({
    required final String giftId,
    required final int amount,
    required final String message,
    required final GiftStyle style,
    required final GiftStatus status,
    final String? recipientId,
    final String? recipientName,
    final DateTime? expiresAt,
  }) = _$GiftMessageDataImpl;

  factory _GiftMessageData.fromJson(Map<String, dynamic> json) =
      _$GiftMessageDataImpl.fromJson;

  @override
  String get giftId;
  @override
  int get amount;
  @override
  String get message;
  @override
  GiftStyle get style;
  @override
  GiftStatus get status;
  @override
  String? get recipientId;
  @override
  String? get recipientName;
  @override
  DateTime? get expiresAt;

  /// Create a copy of GiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftMessageDataImplCopyWith<_$GiftMessageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenSprayMessageData _$TokenSprayMessageDataFromJson(
  Map<String, dynamic> json,
) {
  return _TokenSprayMessageData.fromJson(json);
}

/// @nodoc
mixin _$TokenSprayMessageData {
  String get sprayId => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;
  String get recipientName => throw _privateConstructorUsedError;
  String get occasion => throw _privateConstructorUsedError;
  int get currentTotal => throw _privateConstructorUsedError;
  int get contributorCount => throw _privateConstructorUsedError;
  SprayStatus get status => throw _privateConstructorUsedError;
  int? get targetAmount => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this TokenSprayMessageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenSprayMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenSprayMessageDataCopyWith<TokenSprayMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenSprayMessageDataCopyWith<$Res> {
  factory $TokenSprayMessageDataCopyWith(
    TokenSprayMessageData value,
    $Res Function(TokenSprayMessageData) then,
  ) = _$TokenSprayMessageDataCopyWithImpl<$Res, TokenSprayMessageData>;
  @useResult
  $Res call({
    String sprayId,
    String recipientId,
    String recipientName,
    String occasion,
    int currentTotal,
    int contributorCount,
    SprayStatus status,
    int? targetAmount,
    DateTime expiresAt,
  });
}

/// @nodoc
class _$TokenSprayMessageDataCopyWithImpl<
  $Res,
  $Val extends TokenSprayMessageData
>
    implements $TokenSprayMessageDataCopyWith<$Res> {
  _$TokenSprayMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenSprayMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sprayId = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? occasion = null,
    Object? currentTotal = null,
    Object? contributorCount = null,
    Object? status = null,
    Object? targetAmount = freezed,
    Object? expiresAt = null,
  }) {
    return _then(
      _value.copyWith(
            sprayId: null == sprayId
                ? _value.sprayId
                : sprayId // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientId: null == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                      as String,
            recipientName: null == recipientName
                ? _value.recipientName
                : recipientName // ignore: cast_nullable_to_non_nullable
                      as String,
            occasion: null == occasion
                ? _value.occasion
                : occasion // ignore: cast_nullable_to_non_nullable
                      as String,
            currentTotal: null == currentTotal
                ? _value.currentTotal
                : currentTotal // ignore: cast_nullable_to_non_nullable
                      as int,
            contributorCount: null == contributorCount
                ? _value.contributorCount
                : contributorCount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SprayStatus,
            targetAmount: freezed == targetAmount
                ? _value.targetAmount
                : targetAmount // ignore: cast_nullable_to_non_nullable
                      as int?,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenSprayMessageDataImplCopyWith<$Res>
    implements $TokenSprayMessageDataCopyWith<$Res> {
  factory _$$TokenSprayMessageDataImplCopyWith(
    _$TokenSprayMessageDataImpl value,
    $Res Function(_$TokenSprayMessageDataImpl) then,
  ) = __$$TokenSprayMessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sprayId,
    String recipientId,
    String recipientName,
    String occasion,
    int currentTotal,
    int contributorCount,
    SprayStatus status,
    int? targetAmount,
    DateTime expiresAt,
  });
}

/// @nodoc
class __$$TokenSprayMessageDataImplCopyWithImpl<$Res>
    extends
        _$TokenSprayMessageDataCopyWithImpl<$Res, _$TokenSprayMessageDataImpl>
    implements _$$TokenSprayMessageDataImplCopyWith<$Res> {
  __$$TokenSprayMessageDataImplCopyWithImpl(
    _$TokenSprayMessageDataImpl _value,
    $Res Function(_$TokenSprayMessageDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sprayId = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? occasion = null,
    Object? currentTotal = null,
    Object? contributorCount = null,
    Object? status = null,
    Object? targetAmount = freezed,
    Object? expiresAt = null,
  }) {
    return _then(
      _$TokenSprayMessageDataImpl(
        sprayId: null == sprayId
            ? _value.sprayId
            : sprayId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientName: null == recipientName
            ? _value.recipientName
            : recipientName // ignore: cast_nullable_to_non_nullable
                  as String,
        occasion: null == occasion
            ? _value.occasion
            : occasion // ignore: cast_nullable_to_non_nullable
                  as String,
        currentTotal: null == currentTotal
            ? _value.currentTotal
            : currentTotal // ignore: cast_nullable_to_non_nullable
                  as int,
        contributorCount: null == contributorCount
            ? _value.contributorCount
            : contributorCount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SprayStatus,
        targetAmount: freezed == targetAmount
            ? _value.targetAmount
            : targetAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenSprayMessageDataImpl implements _TokenSprayMessageData {
  const _$TokenSprayMessageDataImpl({
    required this.sprayId,
    required this.recipientId,
    required this.recipientName,
    required this.occasion,
    required this.currentTotal,
    required this.contributorCount,
    required this.status,
    this.targetAmount,
    required this.expiresAt,
  });

  factory _$TokenSprayMessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenSprayMessageDataImplFromJson(json);

  @override
  final String sprayId;
  @override
  final String recipientId;
  @override
  final String recipientName;
  @override
  final String occasion;
  @override
  final int currentTotal;
  @override
  final int contributorCount;
  @override
  final SprayStatus status;
  @override
  final int? targetAmount;
  @override
  final DateTime expiresAt;

  @override
  String toString() {
    return 'TokenSprayMessageData(sprayId: $sprayId, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, currentTotal: $currentTotal, contributorCount: $contributorCount, status: $status, targetAmount: $targetAmount, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenSprayMessageDataImpl &&
            (identical(other.sprayId, sprayId) || other.sprayId == sprayId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.occasion, occasion) ||
                other.occasion == occasion) &&
            (identical(other.currentTotal, currentTotal) ||
                other.currentTotal == currentTotal) &&
            (identical(other.contributorCount, contributorCount) ||
                other.contributorCount == contributorCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sprayId,
    recipientId,
    recipientName,
    occasion,
    currentTotal,
    contributorCount,
    status,
    targetAmount,
    expiresAt,
  );

  /// Create a copy of TokenSprayMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenSprayMessageDataImplCopyWith<_$TokenSprayMessageDataImpl>
  get copyWith =>
      __$$TokenSprayMessageDataImplCopyWithImpl<_$TokenSprayMessageDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenSprayMessageDataImplToJson(this);
  }
}

abstract class _TokenSprayMessageData implements TokenSprayMessageData {
  const factory _TokenSprayMessageData({
    required final String sprayId,
    required final String recipientId,
    required final String recipientName,
    required final String occasion,
    required final int currentTotal,
    required final int contributorCount,
    required final SprayStatus status,
    final int? targetAmount,
    required final DateTime expiresAt,
  }) = _$TokenSprayMessageDataImpl;

  factory _TokenSprayMessageData.fromJson(Map<String, dynamic> json) =
      _$TokenSprayMessageDataImpl.fromJson;

  @override
  String get sprayId;
  @override
  String get recipientId;
  @override
  String get recipientName;
  @override
  String get occasion;
  @override
  int get currentTotal;
  @override
  int get contributorCount;
  @override
  SprayStatus get status;
  @override
  int? get targetAmount;
  @override
  DateTime get expiresAt;

  /// Create a copy of TokenSprayMessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenSprayMessageDataImplCopyWith<_$TokenSprayMessageDataImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GroupGiftMessageData _$GroupGiftMessageDataFromJson(Map<String, dynamic> json) {
  return _GroupGiftMessageData.fromJson(json);
}

/// @nodoc
mixin _$GroupGiftMessageData {
  String get poolId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  GiftStyle get style => throw _privateConstructorUsedError;
  String get organizerId => throw _privateConstructorUsedError;
  String get organizerName => throw _privateConstructorUsedError;
  int get contributorCount => throw _privateConstructorUsedError;
  List<String> get visibleContributorNames =>
      throw _privateConstructorUsedError;
  int get anonymousCount => throw _privateConstructorUsedError;
  PoolStatus get status => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this GroupGiftMessageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupGiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupGiftMessageDataCopyWith<GroupGiftMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupGiftMessageDataCopyWith<$Res> {
  factory $GroupGiftMessageDataCopyWith(
    GroupGiftMessageData value,
    $Res Function(GroupGiftMessageData) then,
  ) = _$GroupGiftMessageDataCopyWithImpl<$Res, GroupGiftMessageData>;
  @useResult
  $Res call({
    String poolId,
    int amount,
    String message,
    GiftStyle style,
    String organizerId,
    String organizerName,
    int contributorCount,
    List<String> visibleContributorNames,
    int anonymousCount,
    PoolStatus status,
    DateTime? expiresAt,
  });
}

/// @nodoc
class _$GroupGiftMessageDataCopyWithImpl<
  $Res,
  $Val extends GroupGiftMessageData
>
    implements $GroupGiftMessageDataCopyWith<$Res> {
  _$GroupGiftMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupGiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolId = null,
    Object? amount = null,
    Object? message = null,
    Object? style = null,
    Object? organizerId = null,
    Object? organizerName = null,
    Object? contributorCount = null,
    Object? visibleContributorNames = null,
    Object? anonymousCount = null,
    Object? status = null,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            poolId: null == poolId
                ? _value.poolId
                : poolId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            style: null == style
                ? _value.style
                : style // ignore: cast_nullable_to_non_nullable
                      as GiftStyle,
            organizerId: null == organizerId
                ? _value.organizerId
                : organizerId // ignore: cast_nullable_to_non_nullable
                      as String,
            organizerName: null == organizerName
                ? _value.organizerName
                : organizerName // ignore: cast_nullable_to_non_nullable
                      as String,
            contributorCount: null == contributorCount
                ? _value.contributorCount
                : contributorCount // ignore: cast_nullable_to_non_nullable
                      as int,
            visibleContributorNames: null == visibleContributorNames
                ? _value.visibleContributorNames
                : visibleContributorNames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            anonymousCount: null == anonymousCount
                ? _value.anonymousCount
                : anonymousCount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PoolStatus,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupGiftMessageDataImplCopyWith<$Res>
    implements $GroupGiftMessageDataCopyWith<$Res> {
  factory _$$GroupGiftMessageDataImplCopyWith(
    _$GroupGiftMessageDataImpl value,
    $Res Function(_$GroupGiftMessageDataImpl) then,
  ) = __$$GroupGiftMessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String poolId,
    int amount,
    String message,
    GiftStyle style,
    String organizerId,
    String organizerName,
    int contributorCount,
    List<String> visibleContributorNames,
    int anonymousCount,
    PoolStatus status,
    DateTime? expiresAt,
  });
}

/// @nodoc
class __$$GroupGiftMessageDataImplCopyWithImpl<$Res>
    extends _$GroupGiftMessageDataCopyWithImpl<$Res, _$GroupGiftMessageDataImpl>
    implements _$$GroupGiftMessageDataImplCopyWith<$Res> {
  __$$GroupGiftMessageDataImplCopyWithImpl(
    _$GroupGiftMessageDataImpl _value,
    $Res Function(_$GroupGiftMessageDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupGiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolId = null,
    Object? amount = null,
    Object? message = null,
    Object? style = null,
    Object? organizerId = null,
    Object? organizerName = null,
    Object? contributorCount = null,
    Object? visibleContributorNames = null,
    Object? anonymousCount = null,
    Object? status = null,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _$GroupGiftMessageDataImpl(
        poolId: null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        style: null == style
            ? _value.style
            : style // ignore: cast_nullable_to_non_nullable
                  as GiftStyle,
        organizerId: null == organizerId
            ? _value.organizerId
            : organizerId // ignore: cast_nullable_to_non_nullable
                  as String,
        organizerName: null == organizerName
            ? _value.organizerName
            : organizerName // ignore: cast_nullable_to_non_nullable
                  as String,
        contributorCount: null == contributorCount
            ? _value.contributorCount
            : contributorCount // ignore: cast_nullable_to_non_nullable
                  as int,
        visibleContributorNames: null == visibleContributorNames
            ? _value._visibleContributorNames
            : visibleContributorNames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        anonymousCount: null == anonymousCount
            ? _value.anonymousCount
            : anonymousCount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PoolStatus,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupGiftMessageDataImpl implements _GroupGiftMessageData {
  const _$GroupGiftMessageDataImpl({
    required this.poolId,
    required this.amount,
    required this.message,
    required this.style,
    required this.organizerId,
    required this.organizerName,
    required this.contributorCount,
    final List<String> visibleContributorNames = const [],
    this.anonymousCount = 0,
    required this.status,
    this.expiresAt,
  }) : _visibleContributorNames = visibleContributorNames;

  factory _$GroupGiftMessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupGiftMessageDataImplFromJson(json);

  @override
  final String poolId;
  @override
  final int amount;
  @override
  final String message;
  @override
  final GiftStyle style;
  @override
  final String organizerId;
  @override
  final String organizerName;
  @override
  final int contributorCount;
  final List<String> _visibleContributorNames;
  @override
  @JsonKey()
  List<String> get visibleContributorNames {
    if (_visibleContributorNames is EqualUnmodifiableListView)
      return _visibleContributorNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleContributorNames);
  }

  @override
  @JsonKey()
  final int anonymousCount;
  @override
  final PoolStatus status;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'GroupGiftMessageData(poolId: $poolId, amount: $amount, message: $message, style: $style, organizerId: $organizerId, organizerName: $organizerName, contributorCount: $contributorCount, visibleContributorNames: $visibleContributorNames, anonymousCount: $anonymousCount, status: $status, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupGiftMessageDataImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.organizerName, organizerName) ||
                other.organizerName == organizerName) &&
            (identical(other.contributorCount, contributorCount) ||
                other.contributorCount == contributorCount) &&
            const DeepCollectionEquality().equals(
              other._visibleContributorNames,
              _visibleContributorNames,
            ) &&
            (identical(other.anonymousCount, anonymousCount) ||
                other.anonymousCount == anonymousCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    poolId,
    amount,
    message,
    style,
    organizerId,
    organizerName,
    contributorCount,
    const DeepCollectionEquality().hash(_visibleContributorNames),
    anonymousCount,
    status,
    expiresAt,
  );

  /// Create a copy of GroupGiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupGiftMessageDataImplCopyWith<_$GroupGiftMessageDataImpl>
  get copyWith =>
      __$$GroupGiftMessageDataImplCopyWithImpl<_$GroupGiftMessageDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupGiftMessageDataImplToJson(this);
  }
}

abstract class _GroupGiftMessageData implements GroupGiftMessageData {
  const factory _GroupGiftMessageData({
    required final String poolId,
    required final int amount,
    required final String message,
    required final GiftStyle style,
    required final String organizerId,
    required final String organizerName,
    required final int contributorCount,
    final List<String> visibleContributorNames,
    final int anonymousCount,
    required final PoolStatus status,
    final DateTime? expiresAt,
  }) = _$GroupGiftMessageDataImpl;

  factory _GroupGiftMessageData.fromJson(Map<String, dynamic> json) =
      _$GroupGiftMessageDataImpl.fromJson;

  @override
  String get poolId;
  @override
  int get amount;
  @override
  String get message;
  @override
  GiftStyle get style;
  @override
  String get organizerId;
  @override
  String get organizerName;
  @override
  int get contributorCount;
  @override
  List<String> get visibleContributorNames;
  @override
  int get anonymousCount;
  @override
  PoolStatus get status;
  @override
  DateTime? get expiresAt;

  /// Create a copy of GroupGiftMessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupGiftMessageDataImplCopyWith<_$GroupGiftMessageDataImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ForwardedFrom _$ForwardedFromFromJson(Map<String, dynamic> json) {
  return _ForwardedFrom.fromJson(json);
}

/// @nodoc
mixin _$ForwardedFrom {
  String get messageId => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;

  /// Serializes this ForwardedFrom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForwardedFrom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForwardedFromCopyWith<ForwardedFrom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForwardedFromCopyWith<$Res> {
  factory $ForwardedFromCopyWith(
    ForwardedFrom value,
    $Res Function(ForwardedFrom) then,
  ) = _$ForwardedFromCopyWithImpl<$Res, ForwardedFrom>;
  @useResult
  $Res call({String messageId, String conversationId, String senderName});
}

/// @nodoc
class _$ForwardedFromCopyWithImpl<$Res, $Val extends ForwardedFrom>
    implements $ForwardedFromCopyWith<$Res> {
  _$ForwardedFromCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForwardedFrom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? conversationId = null,
    Object? senderName = null,
  }) {
    return _then(
      _value.copyWith(
            messageId: null == messageId
                ? _value.messageId
                : messageId // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForwardedFromImplCopyWith<$Res>
    implements $ForwardedFromCopyWith<$Res> {
  factory _$$ForwardedFromImplCopyWith(
    _$ForwardedFromImpl value,
    $Res Function(_$ForwardedFromImpl) then,
  ) = __$$ForwardedFromImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String messageId, String conversationId, String senderName});
}

/// @nodoc
class __$$ForwardedFromImplCopyWithImpl<$Res>
    extends _$ForwardedFromCopyWithImpl<$Res, _$ForwardedFromImpl>
    implements _$$ForwardedFromImplCopyWith<$Res> {
  __$$ForwardedFromImplCopyWithImpl(
    _$ForwardedFromImpl _value,
    $Res Function(_$ForwardedFromImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForwardedFrom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? conversationId = null,
    Object? senderName = null,
  }) {
    return _then(
      _$ForwardedFromImpl(
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForwardedFromImpl implements _ForwardedFrom {
  const _$ForwardedFromImpl({
    required this.messageId,
    required this.conversationId,
    required this.senderName,
  });

  factory _$ForwardedFromImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForwardedFromImplFromJson(json);

  @override
  final String messageId;
  @override
  final String conversationId;
  @override
  final String senderName;

  @override
  String toString() {
    return 'ForwardedFrom(messageId: $messageId, conversationId: $conversationId, senderName: $senderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForwardedFromImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, messageId, conversationId, senderName);

  /// Create a copy of ForwardedFrom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForwardedFromImplCopyWith<_$ForwardedFromImpl> get copyWith =>
      __$$ForwardedFromImplCopyWithImpl<_$ForwardedFromImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForwardedFromImplToJson(this);
  }
}

abstract class _ForwardedFrom implements ForwardedFrom {
  const factory _ForwardedFrom({
    required final String messageId,
    required final String conversationId,
    required final String senderName,
  }) = _$ForwardedFromImpl;

  factory _ForwardedFrom.fromJson(Map<String, dynamic> json) =
      _$ForwardedFromImpl.fromJson;

  @override
  String get messageId;
  @override
  String get conversationId;
  @override
  String get senderName;

  /// Create a copy of ForwardedFrom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForwardedFromImplCopyWith<_$ForwardedFromImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

E2eeMetadata _$E2eeMetadataFromJson(Map<String, dynamic> json) {
  return _E2eeMetadata.fromJson(json);
}

/// @nodoc
mixin _$E2eeMetadata {
  String get protocol => throw _privateConstructorUsedError;
  String? get senderKeyChainId => throw _privateConstructorUsedError;
  int? get messageNumber => throw _privateConstructorUsedError;
  String? get dhPublicKey => throw _privateConstructorUsedError;
  int? get previousChainLength => throw _privateConstructorUsedError;

  /// HMAC-SHA256 sender authentication signature for sender-key messages.
  String? get signature => throw _privateConstructorUsedError;

  /// Serializes this E2eeMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of E2eeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $E2eeMetadataCopyWith<E2eeMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $E2eeMetadataCopyWith<$Res> {
  factory $E2eeMetadataCopyWith(
    E2eeMetadata value,
    $Res Function(E2eeMetadata) then,
  ) = _$E2eeMetadataCopyWithImpl<$Res, E2eeMetadata>;
  @useResult
  $Res call({
    String protocol,
    String? senderKeyChainId,
    int? messageNumber,
    String? dhPublicKey,
    int? previousChainLength,
    String? signature,
  });
}

/// @nodoc
class _$E2eeMetadataCopyWithImpl<$Res, $Val extends E2eeMetadata>
    implements $E2eeMetadataCopyWith<$Res> {
  _$E2eeMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of E2eeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protocol = null,
    Object? senderKeyChainId = freezed,
    Object? messageNumber = freezed,
    Object? dhPublicKey = freezed,
    Object? previousChainLength = freezed,
    Object? signature = freezed,
  }) {
    return _then(
      _value.copyWith(
            protocol: null == protocol
                ? _value.protocol
                : protocol // ignore: cast_nullable_to_non_nullable
                      as String,
            senderKeyChainId: freezed == senderKeyChainId
                ? _value.senderKeyChainId
                : senderKeyChainId // ignore: cast_nullable_to_non_nullable
                      as String?,
            messageNumber: freezed == messageNumber
                ? _value.messageNumber
                : messageNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            dhPublicKey: freezed == dhPublicKey
                ? _value.dhPublicKey
                : dhPublicKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            previousChainLength: freezed == previousChainLength
                ? _value.previousChainLength
                : previousChainLength // ignore: cast_nullable_to_non_nullable
                      as int?,
            signature: freezed == signature
                ? _value.signature
                : signature // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$E2eeMetadataImplCopyWith<$Res>
    implements $E2eeMetadataCopyWith<$Res> {
  factory _$$E2eeMetadataImplCopyWith(
    _$E2eeMetadataImpl value,
    $Res Function(_$E2eeMetadataImpl) then,
  ) = __$$E2eeMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String protocol,
    String? senderKeyChainId,
    int? messageNumber,
    String? dhPublicKey,
    int? previousChainLength,
    String? signature,
  });
}

/// @nodoc
class __$$E2eeMetadataImplCopyWithImpl<$Res>
    extends _$E2eeMetadataCopyWithImpl<$Res, _$E2eeMetadataImpl>
    implements _$$E2eeMetadataImplCopyWith<$Res> {
  __$$E2eeMetadataImplCopyWithImpl(
    _$E2eeMetadataImpl _value,
    $Res Function(_$E2eeMetadataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of E2eeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protocol = null,
    Object? senderKeyChainId = freezed,
    Object? messageNumber = freezed,
    Object? dhPublicKey = freezed,
    Object? previousChainLength = freezed,
    Object? signature = freezed,
  }) {
    return _then(
      _$E2eeMetadataImpl(
        protocol: null == protocol
            ? _value.protocol
            : protocol // ignore: cast_nullable_to_non_nullable
                  as String,
        senderKeyChainId: freezed == senderKeyChainId
            ? _value.senderKeyChainId
            : senderKeyChainId // ignore: cast_nullable_to_non_nullable
                  as String?,
        messageNumber: freezed == messageNumber
            ? _value.messageNumber
            : messageNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        dhPublicKey: freezed == dhPublicKey
            ? _value.dhPublicKey
            : dhPublicKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        previousChainLength: freezed == previousChainLength
            ? _value.previousChainLength
            : previousChainLength // ignore: cast_nullable_to_non_nullable
                  as int?,
        signature: freezed == signature
            ? _value.signature
            : signature // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$E2eeMetadataImpl implements _E2eeMetadata {
  const _$E2eeMetadataImpl({
    required this.protocol,
    this.senderKeyChainId,
    this.messageNumber,
    this.dhPublicKey,
    this.previousChainLength,
    this.signature,
  });

  factory _$E2eeMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$E2eeMetadataImplFromJson(json);

  @override
  final String protocol;
  @override
  final String? senderKeyChainId;
  @override
  final int? messageNumber;
  @override
  final String? dhPublicKey;
  @override
  final int? previousChainLength;

  /// HMAC-SHA256 sender authentication signature for sender-key messages.
  @override
  final String? signature;

  @override
  String toString() {
    return 'E2eeMetadata(protocol: $protocol, senderKeyChainId: $senderKeyChainId, messageNumber: $messageNumber, dhPublicKey: $dhPublicKey, previousChainLength: $previousChainLength, signature: $signature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$E2eeMetadataImpl &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.senderKeyChainId, senderKeyChainId) ||
                other.senderKeyChainId == senderKeyChainId) &&
            (identical(other.messageNumber, messageNumber) ||
                other.messageNumber == messageNumber) &&
            (identical(other.dhPublicKey, dhPublicKey) ||
                other.dhPublicKey == dhPublicKey) &&
            (identical(other.previousChainLength, previousChainLength) ||
                other.previousChainLength == previousChainLength) &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    protocol,
    senderKeyChainId,
    messageNumber,
    dhPublicKey,
    previousChainLength,
    signature,
  );

  /// Create a copy of E2eeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$E2eeMetadataImplCopyWith<_$E2eeMetadataImpl> get copyWith =>
      __$$E2eeMetadataImplCopyWithImpl<_$E2eeMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$E2eeMetadataImplToJson(this);
  }
}

abstract class _E2eeMetadata implements E2eeMetadata {
  const factory _E2eeMetadata({
    required final String protocol,
    final String? senderKeyChainId,
    final int? messageNumber,
    final String? dhPublicKey,
    final int? previousChainLength,
    final String? signature,
  }) = _$E2eeMetadataImpl;

  factory _E2eeMetadata.fromJson(Map<String, dynamic> json) =
      _$E2eeMetadataImpl.fromJson;

  @override
  String get protocol;
  @override
  String? get senderKeyChainId;
  @override
  int? get messageNumber;
  @override
  String? get dhPublicKey;
  @override
  int? get previousChainLength;

  /// HMAC-SHA256 sender authentication signature for sender-key messages.
  @override
  String? get signature;

  /// Create a copy of E2eeMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$E2eeMetadataImplCopyWith<_$E2eeMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

X3dhHeader _$X3dhHeaderFromJson(Map<String, dynamic> json) {
  return _X3dhHeader.fromJson(json);
}

/// @nodoc
mixin _$X3dhHeader {
  String get identityKey => throw _privateConstructorUsedError;
  String get ephemeralKey => throw _privateConstructorUsedError;
  int? get oneTimePreKeyId => throw _privateConstructorUsedError;

  /// Integer ID of the signed pre-key used during X3DH.
  /// Required for SPK grace period resolution after rotation.
  int? get signedPreKeyId => throw _privateConstructorUsedError;

  /// Serializes this X3dhHeader to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of X3dhHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $X3dhHeaderCopyWith<X3dhHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $X3dhHeaderCopyWith<$Res> {
  factory $X3dhHeaderCopyWith(
    X3dhHeader value,
    $Res Function(X3dhHeader) then,
  ) = _$X3dhHeaderCopyWithImpl<$Res, X3dhHeader>;
  @useResult
  $Res call({
    String identityKey,
    String ephemeralKey,
    int? oneTimePreKeyId,
    int? signedPreKeyId,
  });
}

/// @nodoc
class _$X3dhHeaderCopyWithImpl<$Res, $Val extends X3dhHeader>
    implements $X3dhHeaderCopyWith<$Res> {
  _$X3dhHeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of X3dhHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityKey = null,
    Object? ephemeralKey = null,
    Object? oneTimePreKeyId = freezed,
    Object? signedPreKeyId = freezed,
  }) {
    return _then(
      _value.copyWith(
            identityKey: null == identityKey
                ? _value.identityKey
                : identityKey // ignore: cast_nullable_to_non_nullable
                      as String,
            ephemeralKey: null == ephemeralKey
                ? _value.ephemeralKey
                : ephemeralKey // ignore: cast_nullable_to_non_nullable
                      as String,
            oneTimePreKeyId: freezed == oneTimePreKeyId
                ? _value.oneTimePreKeyId
                : oneTimePreKeyId // ignore: cast_nullable_to_non_nullable
                      as int?,
            signedPreKeyId: freezed == signedPreKeyId
                ? _value.signedPreKeyId
                : signedPreKeyId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$X3dhHeaderImplCopyWith<$Res>
    implements $X3dhHeaderCopyWith<$Res> {
  factory _$$X3dhHeaderImplCopyWith(
    _$X3dhHeaderImpl value,
    $Res Function(_$X3dhHeaderImpl) then,
  ) = __$$X3dhHeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String identityKey,
    String ephemeralKey,
    int? oneTimePreKeyId,
    int? signedPreKeyId,
  });
}

/// @nodoc
class __$$X3dhHeaderImplCopyWithImpl<$Res>
    extends _$X3dhHeaderCopyWithImpl<$Res, _$X3dhHeaderImpl>
    implements _$$X3dhHeaderImplCopyWith<$Res> {
  __$$X3dhHeaderImplCopyWithImpl(
    _$X3dhHeaderImpl _value,
    $Res Function(_$X3dhHeaderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of X3dhHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityKey = null,
    Object? ephemeralKey = null,
    Object? oneTimePreKeyId = freezed,
    Object? signedPreKeyId = freezed,
  }) {
    return _then(
      _$X3dhHeaderImpl(
        identityKey: null == identityKey
            ? _value.identityKey
            : identityKey // ignore: cast_nullable_to_non_nullable
                  as String,
        ephemeralKey: null == ephemeralKey
            ? _value.ephemeralKey
            : ephemeralKey // ignore: cast_nullable_to_non_nullable
                  as String,
        oneTimePreKeyId: freezed == oneTimePreKeyId
            ? _value.oneTimePreKeyId
            : oneTimePreKeyId // ignore: cast_nullable_to_non_nullable
                  as int?,
        signedPreKeyId: freezed == signedPreKeyId
            ? _value.signedPreKeyId
            : signedPreKeyId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$X3dhHeaderImpl implements _X3dhHeader {
  const _$X3dhHeaderImpl({
    required this.identityKey,
    required this.ephemeralKey,
    this.oneTimePreKeyId,
    this.signedPreKeyId,
  });

  factory _$X3dhHeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$X3dhHeaderImplFromJson(json);

  @override
  final String identityKey;
  @override
  final String ephemeralKey;
  @override
  final int? oneTimePreKeyId;

  /// Integer ID of the signed pre-key used during X3DH.
  /// Required for SPK grace period resolution after rotation.
  @override
  final int? signedPreKeyId;

  @override
  String toString() {
    return 'X3dhHeader(identityKey: $identityKey, ephemeralKey: $ephemeralKey, oneTimePreKeyId: $oneTimePreKeyId, signedPreKeyId: $signedPreKeyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$X3dhHeaderImpl &&
            (identical(other.identityKey, identityKey) ||
                other.identityKey == identityKey) &&
            (identical(other.ephemeralKey, ephemeralKey) ||
                other.ephemeralKey == ephemeralKey) &&
            (identical(other.oneTimePreKeyId, oneTimePreKeyId) ||
                other.oneTimePreKeyId == oneTimePreKeyId) &&
            (identical(other.signedPreKeyId, signedPreKeyId) ||
                other.signedPreKeyId == signedPreKeyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityKey,
    ephemeralKey,
    oneTimePreKeyId,
    signedPreKeyId,
  );

  /// Create a copy of X3dhHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$X3dhHeaderImplCopyWith<_$X3dhHeaderImpl> get copyWith =>
      __$$X3dhHeaderImplCopyWithImpl<_$X3dhHeaderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$X3dhHeaderImplToJson(this);
  }
}

abstract class _X3dhHeader implements X3dhHeader {
  const factory _X3dhHeader({
    required final String identityKey,
    required final String ephemeralKey,
    final int? oneTimePreKeyId,
    final int? signedPreKeyId,
  }) = _$X3dhHeaderImpl;

  factory _X3dhHeader.fromJson(Map<String, dynamic> json) =
      _$X3dhHeaderImpl.fromJson;

  @override
  String get identityKey;
  @override
  String get ephemeralKey;
  @override
  int? get oneTimePreKeyId;

  /// Integer ID of the signed pre-key used during X3DH.
  /// Required for SPK grace period resolution after rotation.
  @override
  int? get signedPreKeyId;

  /// Create a copy of X3dhHeader
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$X3dhHeaderImplCopyWith<_$X3dhHeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get id => throw _privateConstructorUsedError; // Sender
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String? get senderAvatarUrl => throw _privateConstructorUsedError; // Content
  MessageType get type => throw _privateConstructorUsedError;
  MessageStatus get status => throw _privateConstructorUsedError;
  String? get textContent =>
      throw _privateConstructorUsedError; // Token operations
  int? get tokenAmount => throw _privateConstructorUsedError;
  String? get recipientId => throw _privateConstructorUsedError;
  String? get ledgerJournalId => throw _privateConstructorUsedError; // Media
  MessageMedia? get media => throw _privateConstructorUsedError; // Interactions
  Map<String, List<String>> get reactions => throw _privateConstructorUsedError;
  MessageReply? get replyTo =>
      throw _privateConstructorUsedError; // Read receipts & forwarding
  Map<String, DateTime> get readBy => throw _privateConstructorUsedError;
  ForwardedFrom? get forwardedFrom =>
      throw _privateConstructorUsedError; // Gift & spray embedded data
  GiftMessageData? get gift => throw _privateConstructorUsedError;
  GroupGiftMessageData? get groupGift => throw _privateConstructorUsedError;
  TokenSprayMessageData? get tokenSpray =>
      throw _privateConstructorUsedError; // Community-specific
  String? get communityId => throw _privateConstructorUsedError;
  String? get systemEventType => throw _privateConstructorUsedError;
  Map<String, dynamic>? get systemEventData =>
      throw _privateConstructorUsedError; // E2EE (null when plaintext / E2EE not yet enabled)
  String? get ciphertext => throw _privateConstructorUsedError;
  E2eeMetadata? get e2ee => throw _privateConstructorUsedError;
  X3dhHeader? get x3dhHeader =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime? get actionedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError; // Deletion
  List<String> get deletedFor => throw _privateConstructorUsedError;
  bool get deletedForEveryone => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    MessageType type,
    MessageStatus status,
    String? textContent,
    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,
    MessageMedia? media,
    Map<String, List<String>> reactions,
    MessageReply? replyTo,
    Map<String, DateTime> readBy,
    ForwardedFrom? forwardedFrom,
    GiftMessageData? gift,
    GroupGiftMessageData? groupGift,
    TokenSprayMessageData? tokenSpray,
    String? communityId,
    String? systemEventType,
    Map<String, dynamic>? systemEventData,
    String? ciphertext,
    E2eeMetadata? e2ee,
    X3dhHeader? x3dhHeader,
    DateTime createdAt,
    DateTime? expiresAt,
    DateTime? actionedAt,
    DateTime? deletedAt,
    List<String> deletedFor,
    bool deletedForEveryone,
  });

  $MessageMediaCopyWith<$Res>? get media;
  $MessageReplyCopyWith<$Res>? get replyTo;
  $ForwardedFromCopyWith<$Res>? get forwardedFrom;
  $GiftMessageDataCopyWith<$Res>? get gift;
  $GroupGiftMessageDataCopyWith<$Res>? get groupGift;
  $TokenSprayMessageDataCopyWith<$Res>? get tokenSpray;
  $E2eeMetadataCopyWith<$Res>? get e2ee;
  $X3dhHeaderCopyWith<$Res>? get x3dhHeader;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatarUrl = freezed,
    Object? type = null,
    Object? status = null,
    Object? textContent = freezed,
    Object? tokenAmount = freezed,
    Object? recipientId = freezed,
    Object? ledgerJournalId = freezed,
    Object? media = freezed,
    Object? reactions = null,
    Object? replyTo = freezed,
    Object? readBy = null,
    Object? forwardedFrom = freezed,
    Object? gift = freezed,
    Object? groupGift = freezed,
    Object? tokenSpray = freezed,
    Object? communityId = freezed,
    Object? systemEventType = freezed,
    Object? systemEventData = freezed,
    Object? ciphertext = freezed,
    Object? e2ee = freezed,
    Object? x3dhHeader = freezed,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? actionedAt = freezed,
    Object? deletedAt = freezed,
    Object? deletedFor = null,
    Object? deletedForEveryone = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderAvatarUrl: freezed == senderAvatarUrl
                ? _value.senderAvatarUrl
                : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as MessageType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as MessageStatus,
            textContent: freezed == textContent
                ? _value.textContent
                : textContent // ignore: cast_nullable_to_non_nullable
                      as String?,
            tokenAmount: freezed == tokenAmount
                ? _value.tokenAmount
                : tokenAmount // ignore: cast_nullable_to_non_nullable
                      as int?,
            recipientId: freezed == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            ledgerJournalId: freezed == ledgerJournalId
                ? _value.ledgerJournalId
                : ledgerJournalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            media: freezed == media
                ? _value.media
                : media // ignore: cast_nullable_to_non_nullable
                      as MessageMedia?,
            reactions: null == reactions
                ? _value.reactions
                : reactions // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
            replyTo: freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                      as MessageReply?,
            readBy: null == readBy
                ? _value.readBy
                : readBy // ignore: cast_nullable_to_non_nullable
                      as Map<String, DateTime>,
            forwardedFrom: freezed == forwardedFrom
                ? _value.forwardedFrom
                : forwardedFrom // ignore: cast_nullable_to_non_nullable
                      as ForwardedFrom?,
            gift: freezed == gift
                ? _value.gift
                : gift // ignore: cast_nullable_to_non_nullable
                      as GiftMessageData?,
            groupGift: freezed == groupGift
                ? _value.groupGift
                : groupGift // ignore: cast_nullable_to_non_nullable
                      as GroupGiftMessageData?,
            tokenSpray: freezed == tokenSpray
                ? _value.tokenSpray
                : tokenSpray // ignore: cast_nullable_to_non_nullable
                      as TokenSprayMessageData?,
            communityId: freezed == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            systemEventType: freezed == systemEventType
                ? _value.systemEventType
                : systemEventType // ignore: cast_nullable_to_non_nullable
                      as String?,
            systemEventData: freezed == systemEventData
                ? _value.systemEventData
                : systemEventData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            ciphertext: freezed == ciphertext
                ? _value.ciphertext
                : ciphertext // ignore: cast_nullable_to_non_nullable
                      as String?,
            e2ee: freezed == e2ee
                ? _value.e2ee
                : e2ee // ignore: cast_nullable_to_non_nullable
                      as E2eeMetadata?,
            x3dhHeader: freezed == x3dhHeader
                ? _value.x3dhHeader
                : x3dhHeader // ignore: cast_nullable_to_non_nullable
                      as X3dhHeader?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            actionedAt: freezed == actionedAt
                ? _value.actionedAt
                : actionedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            deletedFor: null == deletedFor
                ? _value.deletedFor
                : deletedFor // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            deletedForEveryone: null == deletedForEveryone
                ? _value.deletedForEveryone
                : deletedForEveryone // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageMediaCopyWith<$Res>? get media {
    if (_value.media == null) {
      return null;
    }

    return $MessageMediaCopyWith<$Res>(_value.media!, (value) {
      return _then(_value.copyWith(media: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageReplyCopyWith<$Res>? get replyTo {
    if (_value.replyTo == null) {
      return null;
    }

    return $MessageReplyCopyWith<$Res>(_value.replyTo!, (value) {
      return _then(_value.copyWith(replyTo: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForwardedFromCopyWith<$Res>? get forwardedFrom {
    if (_value.forwardedFrom == null) {
      return null;
    }

    return $ForwardedFromCopyWith<$Res>(_value.forwardedFrom!, (value) {
      return _then(_value.copyWith(forwardedFrom: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GiftMessageDataCopyWith<$Res>? get gift {
    if (_value.gift == null) {
      return null;
    }

    return $GiftMessageDataCopyWith<$Res>(_value.gift!, (value) {
      return _then(_value.copyWith(gift: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupGiftMessageDataCopyWith<$Res>? get groupGift {
    if (_value.groupGift == null) {
      return null;
    }

    return $GroupGiftMessageDataCopyWith<$Res>(_value.groupGift!, (value) {
      return _then(_value.copyWith(groupGift: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenSprayMessageDataCopyWith<$Res>? get tokenSpray {
    if (_value.tokenSpray == null) {
      return null;
    }

    return $TokenSprayMessageDataCopyWith<$Res>(_value.tokenSpray!, (value) {
      return _then(_value.copyWith(tokenSpray: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $E2eeMetadataCopyWith<$Res>? get e2ee {
    if (_value.e2ee == null) {
      return null;
    }

    return $E2eeMetadataCopyWith<$Res>(_value.e2ee!, (value) {
      return _then(_value.copyWith(e2ee: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $X3dhHeaderCopyWith<$Res>? get x3dhHeader {
    if (_value.x3dhHeader == null) {
      return null;
    }

    return $X3dhHeaderCopyWith<$Res>(_value.x3dhHeader!, (value) {
      return _then(_value.copyWith(x3dhHeader: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
    _$MessageImpl value,
    $Res Function(_$MessageImpl) then,
  ) = __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    MessageType type,
    MessageStatus status,
    String? textContent,
    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,
    MessageMedia? media,
    Map<String, List<String>> reactions,
    MessageReply? replyTo,
    Map<String, DateTime> readBy,
    ForwardedFrom? forwardedFrom,
    GiftMessageData? gift,
    GroupGiftMessageData? groupGift,
    TokenSprayMessageData? tokenSpray,
    String? communityId,
    String? systemEventType,
    Map<String, dynamic>? systemEventData,
    String? ciphertext,
    E2eeMetadata? e2ee,
    X3dhHeader? x3dhHeader,
    DateTime createdAt,
    DateTime? expiresAt,
    DateTime? actionedAt,
    DateTime? deletedAt,
    List<String> deletedFor,
    bool deletedForEveryone,
  });

  @override
  $MessageMediaCopyWith<$Res>? get media;
  @override
  $MessageReplyCopyWith<$Res>? get replyTo;
  @override
  $ForwardedFromCopyWith<$Res>? get forwardedFrom;
  @override
  $GiftMessageDataCopyWith<$Res>? get gift;
  @override
  $GroupGiftMessageDataCopyWith<$Res>? get groupGift;
  @override
  $TokenSprayMessageDataCopyWith<$Res>? get tokenSpray;
  @override
  $E2eeMetadataCopyWith<$Res>? get e2ee;
  @override
  $X3dhHeaderCopyWith<$Res>? get x3dhHeader;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
    _$MessageImpl _value,
    $Res Function(_$MessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatarUrl = freezed,
    Object? type = null,
    Object? status = null,
    Object? textContent = freezed,
    Object? tokenAmount = freezed,
    Object? recipientId = freezed,
    Object? ledgerJournalId = freezed,
    Object? media = freezed,
    Object? reactions = null,
    Object? replyTo = freezed,
    Object? readBy = null,
    Object? forwardedFrom = freezed,
    Object? gift = freezed,
    Object? groupGift = freezed,
    Object? tokenSpray = freezed,
    Object? communityId = freezed,
    Object? systemEventType = freezed,
    Object? systemEventData = freezed,
    Object? ciphertext = freezed,
    Object? e2ee = freezed,
    Object? x3dhHeader = freezed,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? actionedAt = freezed,
    Object? deletedAt = freezed,
    Object? deletedFor = null,
    Object? deletedForEveryone = null,
  }) {
    return _then(
      _$MessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderAvatarUrl: freezed == senderAvatarUrl
            ? _value.senderAvatarUrl
            : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as MessageType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as MessageStatus,
        textContent: freezed == textContent
            ? _value.textContent
            : textContent // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenAmount: freezed == tokenAmount
            ? _value.tokenAmount
            : tokenAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        recipientId: freezed == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        ledgerJournalId: freezed == ledgerJournalId
            ? _value.ledgerJournalId
            : ledgerJournalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        media: freezed == media
            ? _value.media
            : media // ignore: cast_nullable_to_non_nullable
                  as MessageMedia?,
        reactions: null == reactions
            ? _value._reactions
            : reactions // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
        replyTo: freezed == replyTo
            ? _value.replyTo
            : replyTo // ignore: cast_nullable_to_non_nullable
                  as MessageReply?,
        readBy: null == readBy
            ? _value._readBy
            : readBy // ignore: cast_nullable_to_non_nullable
                  as Map<String, DateTime>,
        forwardedFrom: freezed == forwardedFrom
            ? _value.forwardedFrom
            : forwardedFrom // ignore: cast_nullable_to_non_nullable
                  as ForwardedFrom?,
        gift: freezed == gift
            ? _value.gift
            : gift // ignore: cast_nullable_to_non_nullable
                  as GiftMessageData?,
        groupGift: freezed == groupGift
            ? _value.groupGift
            : groupGift // ignore: cast_nullable_to_non_nullable
                  as GroupGiftMessageData?,
        tokenSpray: freezed == tokenSpray
            ? _value.tokenSpray
            : tokenSpray // ignore: cast_nullable_to_non_nullable
                  as TokenSprayMessageData?,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        systemEventType: freezed == systemEventType
            ? _value.systemEventType
            : systemEventType // ignore: cast_nullable_to_non_nullable
                  as String?,
        systemEventData: freezed == systemEventData
            ? _value._systemEventData
            : systemEventData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        ciphertext: freezed == ciphertext
            ? _value.ciphertext
            : ciphertext // ignore: cast_nullable_to_non_nullable
                  as String?,
        e2ee: freezed == e2ee
            ? _value.e2ee
            : e2ee // ignore: cast_nullable_to_non_nullable
                  as E2eeMetadata?,
        x3dhHeader: freezed == x3dhHeader
            ? _value.x3dhHeader
            : x3dhHeader // ignore: cast_nullable_to_non_nullable
                  as X3dhHeader?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        actionedAt: freezed == actionedAt
            ? _value.actionedAt
            : actionedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        deletedFor: null == deletedFor
            ? _value._deletedFor
            : deletedFor // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        deletedForEveryone: null == deletedForEveryone
            ? _value.deletedForEveryone
            : deletedForEveryone // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl extends _Message {
  const _$MessageImpl({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    required this.type,
    required this.status,
    this.textContent,
    this.tokenAmount,
    this.recipientId,
    this.ledgerJournalId,
    this.media,
    final Map<String, List<String>> reactions = const {},
    this.replyTo,
    final Map<String, DateTime> readBy = const {},
    this.forwardedFrom,
    this.gift,
    this.groupGift,
    this.tokenSpray,
    this.communityId,
    this.systemEventType,
    final Map<String, dynamic>? systemEventData,
    this.ciphertext,
    this.e2ee,
    this.x3dhHeader,
    required this.createdAt,
    this.expiresAt,
    this.actionedAt,
    this.deletedAt,
    final List<String> deletedFor = const [],
    this.deletedForEveryone = false,
  }) : _reactions = reactions,
       _readBy = readBy,
       _systemEventData = systemEventData,
       _deletedFor = deletedFor,
       super._();

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String id;
  // Sender
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String? senderAvatarUrl;
  // Content
  @override
  final MessageType type;
  @override
  final MessageStatus status;
  @override
  final String? textContent;
  // Token operations
  @override
  final int? tokenAmount;
  @override
  final String? recipientId;
  @override
  final String? ledgerJournalId;
  // Media
  @override
  final MessageMedia? media;
  // Interactions
  final Map<String, List<String>> _reactions;
  // Interactions
  @override
  @JsonKey()
  Map<String, List<String>> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  @override
  final MessageReply? replyTo;
  // Read receipts & forwarding
  final Map<String, DateTime> _readBy;
  // Read receipts & forwarding
  @override
  @JsonKey()
  Map<String, DateTime> get readBy {
    if (_readBy is EqualUnmodifiableMapView) return _readBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_readBy);
  }

  @override
  final ForwardedFrom? forwardedFrom;
  // Gift & spray embedded data
  @override
  final GiftMessageData? gift;
  @override
  final GroupGiftMessageData? groupGift;
  @override
  final TokenSprayMessageData? tokenSpray;
  // Community-specific
  @override
  final String? communityId;
  @override
  final String? systemEventType;
  final Map<String, dynamic>? _systemEventData;
  @override
  Map<String, dynamic>? get systemEventData {
    final value = _systemEventData;
    if (value == null) return null;
    if (_systemEventData is EqualUnmodifiableMapView) return _systemEventData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // E2EE (null when plaintext / E2EE not yet enabled)
  @override
  final String? ciphertext;
  @override
  final E2eeMetadata? e2ee;
  @override
  final X3dhHeader? x3dhHeader;
  // Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? actionedAt;
  @override
  final DateTime? deletedAt;
  // Deletion
  final List<String> _deletedFor;
  // Deletion
  @override
  @JsonKey()
  List<String> get deletedFor {
    if (_deletedFor is EqualUnmodifiableListView) return _deletedFor;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deletedFor);
  }

  @override
  @JsonKey()
  final bool deletedForEveryone;

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, recipientId: $recipientId, ledgerJournalId: $ledgerJournalId, media: $media, reactions: $reactions, replyTo: $replyTo, readBy: $readBy, forwardedFrom: $forwardedFrom, gift: $gift, groupGift: $groupGift, tokenSpray: $tokenSpray, communityId: $communityId, systemEventType: $systemEventType, systemEventData: $systemEventData, ciphertext: $ciphertext, e2ee: $e2ee, x3dhHeader: $x3dhHeader, createdAt: $createdAt, expiresAt: $expiresAt, actionedAt: $actionedAt, deletedAt: $deletedAt, deletedFor: $deletedFor, deletedForEveryone: $deletedForEveryone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.tokenAmount, tokenAmount) ||
                other.tokenAmount == tokenAmount) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.ledgerJournalId, ledgerJournalId) ||
                other.ledgerJournalId == ledgerJournalId) &&
            (identical(other.media, media) || other.media == media) &&
            const DeepCollectionEquality().equals(
              other._reactions,
              _reactions,
            ) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            const DeepCollectionEquality().equals(other._readBy, _readBy) &&
            (identical(other.forwardedFrom, forwardedFrom) ||
                other.forwardedFrom == forwardedFrom) &&
            (identical(other.gift, gift) || other.gift == gift) &&
            (identical(other.groupGift, groupGift) ||
                other.groupGift == groupGift) &&
            (identical(other.tokenSpray, tokenSpray) ||
                other.tokenSpray == tokenSpray) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.systemEventType, systemEventType) ||
                other.systemEventType == systemEventType) &&
            const DeepCollectionEquality().equals(
              other._systemEventData,
              _systemEventData,
            ) &&
            (identical(other.ciphertext, ciphertext) ||
                other.ciphertext == ciphertext) &&
            (identical(other.e2ee, e2ee) || other.e2ee == e2ee) &&
            (identical(other.x3dhHeader, x3dhHeader) ||
                other.x3dhHeader == x3dhHeader) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.actionedAt, actionedAt) ||
                other.actionedAt == actionedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            const DeepCollectionEquality().equals(
              other._deletedFor,
              _deletedFor,
            ) &&
            (identical(other.deletedForEveryone, deletedForEveryone) ||
                other.deletedForEveryone == deletedForEveryone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    senderId,
    senderName,
    senderAvatarUrl,
    type,
    status,
    textContent,
    tokenAmount,
    recipientId,
    ledgerJournalId,
    media,
    const DeepCollectionEquality().hash(_reactions),
    replyTo,
    const DeepCollectionEquality().hash(_readBy),
    forwardedFrom,
    gift,
    groupGift,
    tokenSpray,
    communityId,
    systemEventType,
    const DeepCollectionEquality().hash(_systemEventData),
    ciphertext,
    e2ee,
    x3dhHeader,
    createdAt,
    expiresAt,
    actionedAt,
    deletedAt,
    const DeepCollectionEquality().hash(_deletedFor),
    deletedForEveryone,
  ]);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(this);
  }
}

abstract class _Message extends Message {
  const factory _Message({
    required final String id,
    required final String senderId,
    required final String senderName,
    final String? senderAvatarUrl,
    required final MessageType type,
    required final MessageStatus status,
    final String? textContent,
    final int? tokenAmount,
    final String? recipientId,
    final String? ledgerJournalId,
    final MessageMedia? media,
    final Map<String, List<String>> reactions,
    final MessageReply? replyTo,
    final Map<String, DateTime> readBy,
    final ForwardedFrom? forwardedFrom,
    final GiftMessageData? gift,
    final GroupGiftMessageData? groupGift,
    final TokenSprayMessageData? tokenSpray,
    final String? communityId,
    final String? systemEventType,
    final Map<String, dynamic>? systemEventData,
    final String? ciphertext,
    final E2eeMetadata? e2ee,
    final X3dhHeader? x3dhHeader,
    required final DateTime createdAt,
    final DateTime? expiresAt,
    final DateTime? actionedAt,
    final DateTime? deletedAt,
    final List<String> deletedFor,
    final bool deletedForEveryone,
  }) = _$MessageImpl;
  const _Message._() : super._();

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get id; // Sender
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String? get senderAvatarUrl; // Content
  @override
  MessageType get type;
  @override
  MessageStatus get status;
  @override
  String? get textContent; // Token operations
  @override
  int? get tokenAmount;
  @override
  String? get recipientId;
  @override
  String? get ledgerJournalId; // Media
  @override
  MessageMedia? get media; // Interactions
  @override
  Map<String, List<String>> get reactions;
  @override
  MessageReply? get replyTo; // Read receipts & forwarding
  @override
  Map<String, DateTime> get readBy;
  @override
  ForwardedFrom? get forwardedFrom; // Gift & spray embedded data
  @override
  GiftMessageData? get gift;
  @override
  GroupGiftMessageData? get groupGift;
  @override
  TokenSprayMessageData? get tokenSpray; // Community-specific
  @override
  String? get communityId;
  @override
  String? get systemEventType;
  @override
  Map<String, dynamic>? get systemEventData; // E2EE (null when plaintext / E2EE not yet enabled)
  @override
  String? get ciphertext;
  @override
  E2eeMetadata? get e2ee;
  @override
  X3dhHeader? get x3dhHeader; // Timestamps
  @override
  DateTime get createdAt;
  @override
  DateTime? get expiresAt;
  @override
  DateTime? get actionedAt;
  @override
  DateTime? get deletedAt; // Deletion
  @override
  List<String> get deletedFor;
  @override
  bool get deletedForEveryone;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
