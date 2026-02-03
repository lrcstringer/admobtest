// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EarnMessage _$EarnMessageFromJson(Map<String, dynamic> json) {
  return _EarnMessage.fromJson(json);
}

/// @nodoc
mixin _$EarnMessage {
  String get id => throw _privateConstructorUsedError;
  String get threadId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  EarnMessageType get type => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  EarnMessageStatus? get status => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// For survey responses
  String? get questionId => throw _privateConstructorUsedError;
  dynamic get response => throw _privateConstructorUsedError;

  /// For ad interactions
  String? get adId => throw _privateConstructorUsedError;
  int? get watchDurationSeconds => throw _privateConstructorUsedError;

  /// Token amount earned from this message/action
  int? get tokensEarned => throw _privateConstructorUsedError;

  /// Serializes this EarnMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarnMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarnMessageCopyWith<EarnMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnMessageCopyWith<$Res> {
  factory $EarnMessageCopyWith(
    EarnMessage value,
    $Res Function(EarnMessage) then,
  ) = _$EarnMessageCopyWithImpl<$Res, EarnMessage>;
  @useResult
  $Res call({
    String id,
    String threadId,
    String userId,
    EarnMessageType type,
    String content,
    DateTime createdAt,
    EarnMessageStatus? status,
    Map<String, dynamic>? metadata,
    String? questionId,
    dynamic response,
    String? adId,
    int? watchDurationSeconds,
    int? tokensEarned,
  });
}

/// @nodoc
class _$EarnMessageCopyWithImpl<$Res, $Val extends EarnMessage>
    implements $EarnMessageCopyWith<$Res> {
  _$EarnMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? userId = null,
    Object? type = null,
    Object? content = null,
    Object? createdAt = null,
    Object? status = freezed,
    Object? metadata = freezed,
    Object? questionId = freezed,
    Object? response = freezed,
    Object? adId = freezed,
    Object? watchDurationSeconds = freezed,
    Object? tokensEarned = freezed,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as EarnMessageType,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as EarnMessageStatus?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            questionId: freezed == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            response: freezed == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            adId: freezed == adId
                ? _value.adId
                : adId // ignore: cast_nullable_to_non_nullable
                      as String?,
            watchDurationSeconds: freezed == watchDurationSeconds
                ? _value.watchDurationSeconds
                : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            tokensEarned: freezed == tokensEarned
                ? _value.tokensEarned
                : tokensEarned // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarnMessageImplCopyWith<$Res>
    implements $EarnMessageCopyWith<$Res> {
  factory _$$EarnMessageImplCopyWith(
    _$EarnMessageImpl value,
    $Res Function(_$EarnMessageImpl) then,
  ) = __$$EarnMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String threadId,
    String userId,
    EarnMessageType type,
    String content,
    DateTime createdAt,
    EarnMessageStatus? status,
    Map<String, dynamic>? metadata,
    String? questionId,
    dynamic response,
    String? adId,
    int? watchDurationSeconds,
    int? tokensEarned,
  });
}

/// @nodoc
class __$$EarnMessageImplCopyWithImpl<$Res>
    extends _$EarnMessageCopyWithImpl<$Res, _$EarnMessageImpl>
    implements _$$EarnMessageImplCopyWith<$Res> {
  __$$EarnMessageImplCopyWithImpl(
    _$EarnMessageImpl _value,
    $Res Function(_$EarnMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? threadId = null,
    Object? userId = null,
    Object? type = null,
    Object? content = null,
    Object? createdAt = null,
    Object? status = freezed,
    Object? metadata = freezed,
    Object? questionId = freezed,
    Object? response = freezed,
    Object? adId = freezed,
    Object? watchDurationSeconds = freezed,
    Object? tokensEarned = freezed,
  }) {
    return _then(
      _$EarnMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as EarnMessageType,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as EarnMessageStatus?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        questionId: freezed == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        response: freezed == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        adId: freezed == adId
            ? _value.adId
            : adId // ignore: cast_nullable_to_non_nullable
                  as String?,
        watchDurationSeconds: freezed == watchDurationSeconds
            ? _value.watchDurationSeconds
            : watchDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        tokensEarned: freezed == tokensEarned
            ? _value.tokensEarned
            : tokensEarned // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarnMessageImpl implements _EarnMessage {
  const _$EarnMessageImpl({
    required this.id,
    required this.threadId,
    required this.userId,
    required this.type,
    required this.content,
    required this.createdAt,
    this.status,
    final Map<String, dynamic>? metadata,
    this.questionId,
    this.response,
    this.adId,
    this.watchDurationSeconds,
    this.tokensEarned,
  }) : _metadata = metadata;

  factory _$EarnMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarnMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String threadId;
  @override
  final String userId;
  @override
  final EarnMessageType type;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final EarnMessageStatus? status;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// For survey responses
  @override
  final String? questionId;
  @override
  final dynamic response;

  /// For ad interactions
  @override
  final String? adId;
  @override
  final int? watchDurationSeconds;

  /// Token amount earned from this message/action
  @override
  final int? tokensEarned;

  @override
  String toString() {
    return 'EarnMessage(id: $id, threadId: $threadId, userId: $userId, type: $type, content: $content, createdAt: $createdAt, status: $status, metadata: $metadata, questionId: $questionId, response: $response, adId: $adId, watchDurationSeconds: $watchDurationSeconds, tokensEarned: $tokensEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarnMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            const DeepCollectionEquality().equals(other.response, response) &&
            (identical(other.adId, adId) || other.adId == adId) &&
            (identical(other.watchDurationSeconds, watchDurationSeconds) ||
                other.watchDurationSeconds == watchDurationSeconds) &&
            (identical(other.tokensEarned, tokensEarned) ||
                other.tokensEarned == tokensEarned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    threadId,
    userId,
    type,
    content,
    createdAt,
    status,
    const DeepCollectionEquality().hash(_metadata),
    questionId,
    const DeepCollectionEquality().hash(response),
    adId,
    watchDurationSeconds,
    tokensEarned,
  );

  /// Create a copy of EarnMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarnMessageImplCopyWith<_$EarnMessageImpl> get copyWith =>
      __$$EarnMessageImplCopyWithImpl<_$EarnMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarnMessageImplToJson(this);
  }
}

abstract class _EarnMessage implements EarnMessage {
  const factory _EarnMessage({
    required final String id,
    required final String threadId,
    required final String userId,
    required final EarnMessageType type,
    required final String content,
    required final DateTime createdAt,
    final EarnMessageStatus? status,
    final Map<String, dynamic>? metadata,
    final String? questionId,
    final dynamic response,
    final String? adId,
    final int? watchDurationSeconds,
    final int? tokensEarned,
  }) = _$EarnMessageImpl;

  factory _EarnMessage.fromJson(Map<String, dynamic> json) =
      _$EarnMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get threadId;
  @override
  String get userId;
  @override
  EarnMessageType get type;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  EarnMessageStatus? get status;
  @override
  Map<String, dynamic>? get metadata;

  /// For survey responses
  @override
  String? get questionId;
  @override
  dynamic get response;

  /// For ad interactions
  @override
  String? get adId;
  @override
  int? get watchDurationSeconds;

  /// Token amount earned from this message/action
  @override
  int? get tokensEarned;

  /// Create a copy of EarnMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarnMessageImplCopyWith<_$EarnMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
