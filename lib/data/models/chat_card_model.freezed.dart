// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatCardModel {
  String get id => throw _privateConstructorUsedError;
  String get threadId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get textContent => throw _privateConstructorUsedError;
  int? get tokenAmount => throw _privateConstructorUsedError;
  String? get mediaUrl => throw _privateConstructorUsedError;
  String? get mediaType => throw _privateConstructorUsedError;
  String? get actionData => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime? get actionedAt => throw _privateConstructorUsedError;
  String? get recipientId => throw _privateConstructorUsedError;

  /// Create a copy of ChatCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatCardModelCopyWith<ChatCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCardModelCopyWith<$Res> {
  factory $ChatCardModelCopyWith(
    ChatCardModel value,
    $Res Function(ChatCardModel) then,
  ) = _$ChatCardModelCopyWithImpl<$Res, ChatCardModel>;
  @useResult
  $Res call({
    String id,
    String threadId,
    String senderId,
    String type,
    String status,
    String? textContent,
    int? tokenAmount,
    String? mediaUrl,
    String? mediaType,
    String? actionData,
    DateTime? expiresAt,
    DateTime createdAt,
    DateTime? readAt,
    DateTime? actionedAt,
    String? recipientId,
  });
}

/// @nodoc
class _$ChatCardModelCopyWithImpl<$Res, $Val extends ChatCardModel>
    implements $ChatCardModelCopyWith<$Res> {
  _$ChatCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? senderId = null,
    Object? type = null,
    Object? status = null,
    Object? textContent = freezed,
    Object? tokenAmount = freezed,
    Object? mediaUrl = freezed,
    Object? mediaType = freezed,
    Object? actionData = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? actionedAt = freezed,
    Object? recipientId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            threadId: null == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            textContent: freezed == textContent
                ? _value.textContent
                : textContent // ignore: cast_nullable_to_non_nullable
                      as String?,
            tokenAmount: freezed == tokenAmount
                ? _value.tokenAmount
                : tokenAmount // ignore: cast_nullable_to_non_nullable
                      as int?,
            mediaUrl: freezed == mediaUrl
                ? _value.mediaUrl
                : mediaUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            mediaType: freezed == mediaType
                ? _value.mediaType
                : mediaType // ignore: cast_nullable_to_non_nullable
                      as String?,
            actionData: freezed == actionData
                ? _value.actionData
                : actionData // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            readAt: freezed == readAt
                ? _value.readAt
                : readAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            actionedAt: freezed == actionedAt
                ? _value.actionedAt
                : actionedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            recipientId: freezed == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatCardModelImplCopyWith<$Res>
    implements $ChatCardModelCopyWith<$Res> {
  factory _$$ChatCardModelImplCopyWith(
    _$ChatCardModelImpl value,
    $Res Function(_$ChatCardModelImpl) then,
  ) = __$$ChatCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String threadId,
    String senderId,
    String type,
    String status,
    String? textContent,
    int? tokenAmount,
    String? mediaUrl,
    String? mediaType,
    String? actionData,
    DateTime? expiresAt,
    DateTime createdAt,
    DateTime? readAt,
    DateTime? actionedAt,
    String? recipientId,
  });
}

/// @nodoc
class __$$ChatCardModelImplCopyWithImpl<$Res>
    extends _$ChatCardModelCopyWithImpl<$Res, _$ChatCardModelImpl>
    implements _$$ChatCardModelImplCopyWith<$Res> {
  __$$ChatCardModelImplCopyWithImpl(
    _$ChatCardModelImpl _value,
    $Res Function(_$ChatCardModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? senderId = null,
    Object? type = null,
    Object? status = null,
    Object? textContent = freezed,
    Object? tokenAmount = freezed,
    Object? mediaUrl = freezed,
    Object? mediaType = freezed,
    Object? actionData = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? actionedAt = freezed,
    Object? recipientId = freezed,
  }) {
    return _then(
      _$ChatCardModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        textContent: freezed == textContent
            ? _value.textContent
            : textContent // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenAmount: freezed == tokenAmount
            ? _value.tokenAmount
            : tokenAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        mediaUrl: freezed == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        mediaType: freezed == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as String?,
        actionData: freezed == actionData
            ? _value.actionData
            : actionData // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        readAt: freezed == readAt
            ? _value.readAt
            : readAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        actionedAt: freezed == actionedAt
            ? _value.actionedAt
            : actionedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        recipientId: freezed == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatCardModelImpl extends _ChatCardModel {
  const _$ChatCardModelImpl({
    required this.id,
    required this.threadId,
    required this.senderId,
    required this.type,
    required this.status,
    this.textContent,
    this.tokenAmount,
    this.mediaUrl,
    this.mediaType,
    this.actionData,
    this.expiresAt,
    required this.createdAt,
    this.readAt,
    this.actionedAt,
    this.recipientId,
  }) : super._();

  @override
  final String id;
  @override
  final String threadId;
  @override
  final String senderId;
  @override
  final String type;
  @override
  final String status;
  @override
  final String? textContent;
  @override
  final int? tokenAmount;
  @override
  final String? mediaUrl;
  @override
  final String? mediaType;
  @override
  final String? actionData;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime? readAt;
  @override
  final DateTime? actionedAt;
  @override
  final String? recipientId;

  @override
  String toString() {
    return 'ChatCardModel(id: $id, threadId: $threadId, senderId: $senderId, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, mediaUrl: $mediaUrl, mediaType: $mediaType, actionData: $actionData, expiresAt: $expiresAt, createdAt: $createdAt, readAt: $readAt, actionedAt: $actionedAt, recipientId: $recipientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatCardModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.tokenAmount, tokenAmount) ||
                other.tokenAmount == tokenAmount) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.actionData, actionData) ||
                other.actionData == actionData) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.actionedAt, actionedAt) ||
                other.actionedAt == actionedAt) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    threadId,
    senderId,
    type,
    status,
    textContent,
    tokenAmount,
    mediaUrl,
    mediaType,
    actionData,
    expiresAt,
    createdAt,
    readAt,
    actionedAt,
    recipientId,
  );

  /// Create a copy of ChatCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatCardModelImplCopyWith<_$ChatCardModelImpl> get copyWith =>
      __$$ChatCardModelImplCopyWithImpl<_$ChatCardModelImpl>(this, _$identity);
}

abstract class _ChatCardModel extends ChatCardModel {
  const factory _ChatCardModel({
    required final String id,
    required final String threadId,
    required final String senderId,
    required final String type,
    required final String status,
    final String? textContent,
    final int? tokenAmount,
    final String? mediaUrl,
    final String? mediaType,
    final String? actionData,
    final DateTime? expiresAt,
    required final DateTime createdAt,
    final DateTime? readAt,
    final DateTime? actionedAt,
    final String? recipientId,
  }) = _$ChatCardModelImpl;
  const _ChatCardModel._() : super._();

  @override
  String get id;
  @override
  String get threadId;
  @override
  String get senderId;
  @override
  String get type;
  @override
  String get status;
  @override
  String? get textContent;
  @override
  int? get tokenAmount;
  @override
  String? get mediaUrl;
  @override
  String? get mediaType;
  @override
  String? get actionData;
  @override
  DateTime? get expiresAt;
  @override
  DateTime get createdAt;
  @override
  DateTime? get readAt;
  @override
  DateTime? get actionedAt;
  @override
  String? get recipientId;

  /// Create a copy of ChatCardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatCardModelImplCopyWith<_$ChatCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
