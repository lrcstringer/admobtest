// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MessageModel {
  String get id => throw _privateConstructorUsedError; // Sender
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String? get senderAvatarUrl => throw _privateConstructorUsedError; // Content
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get textContent =>
      throw _privateConstructorUsedError; // Token operations
  int? get tokenAmount => throw _privateConstructorUsedError;
  String? get recipientId => throw _privateConstructorUsedError;
  String? get ledgerJournalId => throw _privateConstructorUsedError; // Media
  Map<String, dynamic>? get media =>
      throw _privateConstructorUsedError; // Interactions
  Map<String, List<String>> get reactions => throw _privateConstructorUsedError;
  Map<String, dynamic>? get replyTo =>
      throw _privateConstructorUsedError; // Gift & spray embedded data
  Map<String, dynamic>? get gift => throw _privateConstructorUsedError;
  Map<String, dynamic>? get tokenSpray =>
      throw _privateConstructorUsedError; // Community-specific
  String? get communityId => throw _privateConstructorUsedError;
  String? get systemEventType => throw _privateConstructorUsedError;
  Map<String, dynamic>? get systemEventData =>
      throw _privateConstructorUsedError; // E2EE (null when plaintext / E2EE not yet enabled)
  String? get ciphertext => throw _privateConstructorUsedError;
  Map<String, dynamic>? get e2ee => throw _privateConstructorUsedError;
  Map<String, dynamic>? get x3dhHeader =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime? get actionedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError; // Deletion
  List<String> get deletedFor => throw _privateConstructorUsedError;
  bool get deletedForEveryone => throw _privateConstructorUsedError;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
    MessageModel value,
    $Res Function(MessageModel) then,
  ) = _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    String type,
    String status,
    String? textContent,
    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,
    Map<String, dynamic>? media,
    Map<String, List<String>> reactions,
    Map<String, dynamic>? replyTo,
    Map<String, dynamic>? gift,
    Map<String, dynamic>? tokenSpray,
    String? communityId,
    String? systemEventType,
    Map<String, dynamic>? systemEventData,
    String? ciphertext,
    Map<String, dynamic>? e2ee,
    Map<String, dynamic>? x3dhHeader,
    DateTime createdAt,
    DateTime? expiresAt,
    DateTime? actionedAt,
    DateTime? deletedAt,
    List<String> deletedFor,
    bool deletedForEveryone,
  });
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageModel
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
    Object? gift = freezed,
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
                      as Map<String, dynamic>?,
            reactions: null == reactions
                ? _value.reactions
                : reactions // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
            replyTo: freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            gift: freezed == gift
                ? _value.gift
                : gift // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            tokenSpray: freezed == tokenSpray
                ? _value.tokenSpray
                : tokenSpray // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
                      as Map<String, dynamic>?,
            x3dhHeader: freezed == x3dhHeader
                ? _value.x3dhHeader
                : x3dhHeader // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
    _$MessageModelImpl value,
    $Res Function(_$MessageModelImpl) then,
  ) = __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String? senderAvatarUrl,
    String type,
    String status,
    String? textContent,
    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,
    Map<String, dynamic>? media,
    Map<String, List<String>> reactions,
    Map<String, dynamic>? replyTo,
    Map<String, dynamic>? gift,
    Map<String, dynamic>? tokenSpray,
    String? communityId,
    String? systemEventType,
    Map<String, dynamic>? systemEventData,
    String? ciphertext,
    Map<String, dynamic>? e2ee,
    Map<String, dynamic>? x3dhHeader,
    DateTime createdAt,
    DateTime? expiresAt,
    DateTime? actionedAt,
    DateTime? deletedAt,
    List<String> deletedFor,
    bool deletedForEveryone,
  });
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
    _$MessageModelImpl _value,
    $Res Function(_$MessageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageModel
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
    Object? gift = freezed,
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
      _$MessageModelImpl(
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
        recipientId: freezed == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        ledgerJournalId: freezed == ledgerJournalId
            ? _value.ledgerJournalId
            : ledgerJournalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        media: freezed == media
            ? _value._media
            : media // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        reactions: null == reactions
            ? _value._reactions
            : reactions // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
        replyTo: freezed == replyTo
            ? _value._replyTo
            : replyTo // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        gift: freezed == gift
            ? _value._gift
            : gift // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        tokenSpray: freezed == tokenSpray
            ? _value._tokenSpray
            : tokenSpray // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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
            ? _value._e2ee
            : e2ee // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        x3dhHeader: freezed == x3dhHeader
            ? _value._x3dhHeader
            : x3dhHeader // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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

class _$MessageModelImpl extends _MessageModel {
  const _$MessageModelImpl({
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
    final Map<String, dynamic>? media,
    final Map<String, List<String>> reactions = const {},
    final Map<String, dynamic>? replyTo,
    final Map<String, dynamic>? gift,
    final Map<String, dynamic>? tokenSpray,
    this.communityId,
    this.systemEventType,
    final Map<String, dynamic>? systemEventData,
    this.ciphertext,
    final Map<String, dynamic>? e2ee,
    final Map<String, dynamic>? x3dhHeader,
    required this.createdAt,
    this.expiresAt,
    this.actionedAt,
    this.deletedAt,
    final List<String> deletedFor = const [],
    this.deletedForEveryone = false,
  }) : _media = media,
       _reactions = reactions,
       _replyTo = replyTo,
       _gift = gift,
       _tokenSpray = tokenSpray,
       _systemEventData = systemEventData,
       _e2ee = e2ee,
       _x3dhHeader = x3dhHeader,
       _deletedFor = deletedFor,
       super._();

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
  final String type;
  @override
  final String status;
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
  final Map<String, dynamic>? _media;
  // Media
  @override
  Map<String, dynamic>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableMapView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

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

  final Map<String, dynamic>? _replyTo;
  @override
  Map<String, dynamic>? get replyTo {
    final value = _replyTo;
    if (value == null) return null;
    if (_replyTo is EqualUnmodifiableMapView) return _replyTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Gift & spray embedded data
  final Map<String, dynamic>? _gift;
  // Gift & spray embedded data
  @override
  Map<String, dynamic>? get gift {
    final value = _gift;
    if (value == null) return null;
    if (_gift is EqualUnmodifiableMapView) return _gift;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _tokenSpray;
  @override
  Map<String, dynamic>? get tokenSpray {
    final value = _tokenSpray;
    if (value == null) return null;
    if (_tokenSpray is EqualUnmodifiableMapView) return _tokenSpray;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

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
  final Map<String, dynamic>? _e2ee;
  @override
  Map<String, dynamic>? get e2ee {
    final value = _e2ee;
    if (value == null) return null;
    if (_e2ee is EqualUnmodifiableMapView) return _e2ee;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _x3dhHeader;
  @override
  Map<String, dynamic>? get x3dhHeader {
    final value = _x3dhHeader;
    if (value == null) return null;
    if (_x3dhHeader is EqualUnmodifiableMapView) return _x3dhHeader;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

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
    return 'MessageModel(id: $id, senderId: $senderId, senderName: $senderName, senderAvatarUrl: $senderAvatarUrl, type: $type, status: $status, textContent: $textContent, tokenAmount: $tokenAmount, recipientId: $recipientId, ledgerJournalId: $ledgerJournalId, media: $media, reactions: $reactions, replyTo: $replyTo, gift: $gift, tokenSpray: $tokenSpray, communityId: $communityId, systemEventType: $systemEventType, systemEventData: $systemEventData, ciphertext: $ciphertext, e2ee: $e2ee, x3dhHeader: $x3dhHeader, createdAt: $createdAt, expiresAt: $expiresAt, actionedAt: $actionedAt, deletedAt: $deletedAt, deletedFor: $deletedFor, deletedForEveryone: $deletedForEveryone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
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
            const DeepCollectionEquality().equals(other._media, _media) &&
            const DeepCollectionEquality().equals(
              other._reactions,
              _reactions,
            ) &&
            const DeepCollectionEquality().equals(other._replyTo, _replyTo) &&
            const DeepCollectionEquality().equals(other._gift, _gift) &&
            const DeepCollectionEquality().equals(
              other._tokenSpray,
              _tokenSpray,
            ) &&
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
            const DeepCollectionEquality().equals(other._e2ee, _e2ee) &&
            const DeepCollectionEquality().equals(
              other._x3dhHeader,
              _x3dhHeader,
            ) &&
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
    const DeepCollectionEquality().hash(_media),
    const DeepCollectionEquality().hash(_reactions),
    const DeepCollectionEquality().hash(_replyTo),
    const DeepCollectionEquality().hash(_gift),
    const DeepCollectionEquality().hash(_tokenSpray),
    communityId,
    systemEventType,
    const DeepCollectionEquality().hash(_systemEventData),
    ciphertext,
    const DeepCollectionEquality().hash(_e2ee),
    const DeepCollectionEquality().hash(_x3dhHeader),
    createdAt,
    expiresAt,
    actionedAt,
    deletedAt,
    const DeepCollectionEquality().hash(_deletedFor),
    deletedForEveryone,
  ]);

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);
}

abstract class _MessageModel extends MessageModel {
  const factory _MessageModel({
    required final String id,
    required final String senderId,
    required final String senderName,
    final String? senderAvatarUrl,
    required final String type,
    required final String status,
    final String? textContent,
    final int? tokenAmount,
    final String? recipientId,
    final String? ledgerJournalId,
    final Map<String, dynamic>? media,
    final Map<String, List<String>> reactions,
    final Map<String, dynamic>? replyTo,
    final Map<String, dynamic>? gift,
    final Map<String, dynamic>? tokenSpray,
    final String? communityId,
    final String? systemEventType,
    final Map<String, dynamic>? systemEventData,
    final String? ciphertext,
    final Map<String, dynamic>? e2ee,
    final Map<String, dynamic>? x3dhHeader,
    required final DateTime createdAt,
    final DateTime? expiresAt,
    final DateTime? actionedAt,
    final DateTime? deletedAt,
    final List<String> deletedFor,
    final bool deletedForEveryone,
  }) = _$MessageModelImpl;
  const _MessageModel._() : super._();

  @override
  String get id; // Sender
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String? get senderAvatarUrl; // Content
  @override
  String get type;
  @override
  String get status;
  @override
  String? get textContent; // Token operations
  @override
  int? get tokenAmount;
  @override
  String? get recipientId;
  @override
  String? get ledgerJournalId; // Media
  @override
  Map<String, dynamic>? get media; // Interactions
  @override
  Map<String, List<String>> get reactions;
  @override
  Map<String, dynamic>? get replyTo; // Gift & spray embedded data
  @override
  Map<String, dynamic>? get gift;
  @override
  Map<String, dynamic>? get tokenSpray; // Community-specific
  @override
  String? get communityId;
  @override
  String? get systemEventType;
  @override
  Map<String, dynamic>? get systemEventData; // E2EE (null when plaintext / E2EE not yet enabled)
  @override
  String? get ciphertext;
  @override
  Map<String, dynamic>? get e2ee;
  @override
  Map<String, dynamic>? get x3dhHeader; // Timestamps
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

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
