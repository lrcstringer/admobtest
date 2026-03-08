// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParticipantInfo _$ParticipantInfoFromJson(Map<String, dynamic> json) {
  return _ParticipantInfo.fromJson(json);
}

/// @nodoc
mixin _$ParticipantInfo {
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this ParticipantInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParticipantInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParticipantInfoCopyWith<ParticipantInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipantInfoCopyWith<$Res> {
  factory $ParticipantInfoCopyWith(
    ParticipantInfo value,
    $Res Function(ParticipantInfo) then,
  ) = _$ParticipantInfoCopyWithImpl<$Res, ParticipantInfo>;
  @useResult
  $Res call({String displayName, String? avatarUrl});
}

/// @nodoc
class _$ParticipantInfoCopyWithImpl<$Res, $Val extends ParticipantInfo>
    implements $ParticipantInfoCopyWith<$Res> {
  _$ParticipantInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParticipantInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? displayName = null, Object? avatarUrl = freezed}) {
    return _then(
      _value.copyWith(
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParticipantInfoImplCopyWith<$Res>
    implements $ParticipantInfoCopyWith<$Res> {
  factory _$$ParticipantInfoImplCopyWith(
    _$ParticipantInfoImpl value,
    $Res Function(_$ParticipantInfoImpl) then,
  ) = __$$ParticipantInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String displayName, String? avatarUrl});
}

/// @nodoc
class __$$ParticipantInfoImplCopyWithImpl<$Res>
    extends _$ParticipantInfoCopyWithImpl<$Res, _$ParticipantInfoImpl>
    implements _$$ParticipantInfoImplCopyWith<$Res> {
  __$$ParticipantInfoImplCopyWithImpl(
    _$ParticipantInfoImpl _value,
    $Res Function(_$ParticipantInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParticipantInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? displayName = null, Object? avatarUrl = freezed}) {
    return _then(
      _$ParticipantInfoImpl(
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParticipantInfoImpl implements _ParticipantInfo {
  const _$ParticipantInfoImpl({required this.displayName, this.avatarUrl});

  factory _$ParticipantInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipantInfoImplFromJson(json);

  @override
  final String displayName;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'ParticipantInfo(displayName: $displayName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipantInfoImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, displayName, avatarUrl);

  /// Create a copy of ParticipantInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipantInfoImplCopyWith<_$ParticipantInfoImpl> get copyWith =>
      __$$ParticipantInfoImplCopyWithImpl<_$ParticipantInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipantInfoImplToJson(this);
  }
}

abstract class _ParticipantInfo implements ParticipantInfo {
  const factory _ParticipantInfo({
    required final String displayName,
    final String? avatarUrl,
  }) = _$ParticipantInfoImpl;

  factory _ParticipantInfo.fromJson(Map<String, dynamic> json) =
      _$ParticipantInfoImpl.fromJson;

  @override
  String get displayName;
  @override
  String? get avatarUrl;

  /// Create a copy of ParticipantInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParticipantInfoImplCopyWith<_$ParticipantInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get id => throw _privateConstructorUsedError;
  ConversationType get type => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  Map<String, ParticipantInfo> get participants =>
      throw _privateConstructorUsedError; // Last message preview (for inbox list)
  String? get lastMessageId => throw _privateConstructorUsedError;
  String? get lastMessageText => throw _privateConstructorUsedError;
  String? get lastMessageSenderId => throw _privateConstructorUsedError;
  String? get lastMessageSenderName => throw _privateConstructorUsedError;
  String? get lastMessageType => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt =>
      throw _privateConstructorUsedError; // Per-user state
  Map<String, int> get unreadCounts => throw _privateConstructorUsedError;
  Map<String, bool> get archived => throw _privateConstructorUsedError;
  Map<String, bool> get pinned => throw _privateConstructorUsedError;
  Map<String, bool> get muted =>
      throw _privateConstructorUsedError; // E2EE: per-user encrypted last message previews
  Map<String, String> get lastMessageEncryptedPreviews =>
      throw _privateConstructorUsedError; // Per-user chat cleared timestamps
  Map<String, DateTime> get chatClearedAt =>
      throw _privateConstructorUsedError; // Per-user acceptance status (message request system)
  Map<String, bool> get accepted =>
      throw _privateConstructorUsedError; // E2EE: per-user session reset requested flags
  Map<String, bool> get sessionResetRequested =>
      throw _privateConstructorUsedError;

  /// Token pool ID (for collection-type conversations)
  String? get tokenPoolId => throw _privateConstructorUsedError;

  /// Pool title (denormalized for collection-type conversations)
  String? get poolTitle => throw _privateConstructorUsedError;

  /// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
  String? get poolMode => throw _privateConstructorUsedError;

  /// Disappearing messages duration. Null means off.
  Duration? get disappearingMessagesDuration =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
    Conversation value,
    $Res Function(Conversation) then,
  ) = _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call({
    String id,
    ConversationType type,
    List<String> participantIds,
    Map<String, ParticipantInfo> participants,
    String? lastMessageId,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    DateTime? lastMessageAt,
    Map<String, int> unreadCounts,
    Map<String, bool> archived,
    Map<String, bool> pinned,
    Map<String, bool> muted,
    Map<String, String> lastMessageEncryptedPreviews,
    Map<String, DateTime> chatClearedAt,
    Map<String, bool> accepted,
    Map<String, bool> sessionResetRequested,
    String? tokenPoolId,
    String? poolTitle,
    String? poolMode,
    Duration? disappearingMessagesDuration,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? participantIds = null,
    Object? participants = null,
    Object? lastMessageId = freezed,
    Object? lastMessageText = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSenderName = freezed,
    Object? lastMessageType = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = null,
    Object? archived = null,
    Object? pinned = null,
    Object? muted = null,
    Object? lastMessageEncryptedPreviews = null,
    Object? chatClearedAt = null,
    Object? accepted = null,
    Object? sessionResetRequested = null,
    Object? tokenPoolId = freezed,
    Object? poolTitle = freezed,
    Object? poolMode = freezed,
    Object? disappearingMessagesDuration = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ConversationType,
            participantIds: null == participantIds
                ? _value.participantIds
                : participantIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as Map<String, ParticipantInfo>,
            lastMessageId: freezed == lastMessageId
                ? _value.lastMessageId
                : lastMessageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageText: freezed == lastMessageText
                ? _value.lastMessageText
                : lastMessageText // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageSenderId: freezed == lastMessageSenderId
                ? _value.lastMessageSenderId
                : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageSenderName: freezed == lastMessageSenderName
                ? _value.lastMessageSenderName
                : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageType: freezed == lastMessageType
                ? _value.lastMessageType
                : lastMessageType // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAt: freezed == lastMessageAt
                ? _value.lastMessageAt
                : lastMessageAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            unreadCounts: null == unreadCounts
                ? _value.unreadCounts
                : unreadCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            archived: null == archived
                ? _value.archived
                : archived // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            pinned: null == pinned
                ? _value.pinned
                : pinned // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            muted: null == muted
                ? _value.muted
                : muted // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews
                ? _value.lastMessageEncryptedPreviews
                : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            chatClearedAt: null == chatClearedAt
                ? _value.chatClearedAt
                : chatClearedAt // ignore: cast_nullable_to_non_nullable
                      as Map<String, DateTime>,
            accepted: null == accepted
                ? _value.accepted
                : accepted // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            sessionResetRequested: null == sessionResetRequested
                ? _value.sessionResetRequested
                : sessionResetRequested // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            tokenPoolId: freezed == tokenPoolId
                ? _value.tokenPoolId
                : tokenPoolId // ignore: cast_nullable_to_non_nullable
                      as String?,
            poolTitle: freezed == poolTitle
                ? _value.poolTitle
                : poolTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            poolMode: freezed == poolMode
                ? _value.poolMode
                : poolMode // ignore: cast_nullable_to_non_nullable
                      as String?,
            disappearingMessagesDuration:
                freezed == disappearingMessagesDuration
                ? _value.disappearingMessagesDuration
                : disappearingMessagesDuration // ignore: cast_nullable_to_non_nullable
                      as Duration?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
    _$ConversationImpl value,
    $Res Function(_$ConversationImpl) then,
  ) = __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ConversationType type,
    List<String> participantIds,
    Map<String, ParticipantInfo> participants,
    String? lastMessageId,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    DateTime? lastMessageAt,
    Map<String, int> unreadCounts,
    Map<String, bool> archived,
    Map<String, bool> pinned,
    Map<String, bool> muted,
    Map<String, String> lastMessageEncryptedPreviews,
    Map<String, DateTime> chatClearedAt,
    Map<String, bool> accepted,
    Map<String, bool> sessionResetRequested,
    String? tokenPoolId,
    String? poolTitle,
    String? poolMode,
    Duration? disappearingMessagesDuration,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
    _$ConversationImpl _value,
    $Res Function(_$ConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? participantIds = null,
    Object? participants = null,
    Object? lastMessageId = freezed,
    Object? lastMessageText = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSenderName = freezed,
    Object? lastMessageType = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = null,
    Object? archived = null,
    Object? pinned = null,
    Object? muted = null,
    Object? lastMessageEncryptedPreviews = null,
    Object? chatClearedAt = null,
    Object? accepted = null,
    Object? sessionResetRequested = null,
    Object? tokenPoolId = freezed,
    Object? poolTitle = freezed,
    Object? poolMode = freezed,
    Object? disappearingMessagesDuration = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ConversationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ConversationType,
        participantIds: null == participantIds
            ? _value._participantIds
            : participantIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as Map<String, ParticipantInfo>,
        lastMessageId: freezed == lastMessageId
            ? _value.lastMessageId
            : lastMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageText: freezed == lastMessageText
            ? _value.lastMessageText
            : lastMessageText // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageSenderId: freezed == lastMessageSenderId
            ? _value.lastMessageSenderId
            : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageSenderName: freezed == lastMessageSenderName
            ? _value.lastMessageSenderName
            : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageType: freezed == lastMessageType
            ? _value.lastMessageType
            : lastMessageType // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAt: freezed == lastMessageAt
            ? _value.lastMessageAt
            : lastMessageAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        unreadCounts: null == unreadCounts
            ? _value._unreadCounts
            : unreadCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        archived: null == archived
            ? _value._archived
            : archived // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        pinned: null == pinned
            ? _value._pinned
            : pinned // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        muted: null == muted
            ? _value._muted
            : muted // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        lastMessageEncryptedPreviews: null == lastMessageEncryptedPreviews
            ? _value._lastMessageEncryptedPreviews
            : lastMessageEncryptedPreviews // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        chatClearedAt: null == chatClearedAt
            ? _value._chatClearedAt
            : chatClearedAt // ignore: cast_nullable_to_non_nullable
                  as Map<String, DateTime>,
        accepted: null == accepted
            ? _value._accepted
            : accepted // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        sessionResetRequested: null == sessionResetRequested
            ? _value._sessionResetRequested
            : sessionResetRequested // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        tokenPoolId: freezed == tokenPoolId
            ? _value.tokenPoolId
            : tokenPoolId // ignore: cast_nullable_to_non_nullable
                  as String?,
        poolTitle: freezed == poolTitle
            ? _value.poolTitle
            : poolTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        poolMode: freezed == poolMode
            ? _value.poolMode
            : poolMode // ignore: cast_nullable_to_non_nullable
                  as String?,
        disappearingMessagesDuration: freezed == disappearingMessagesDuration
            ? _value.disappearingMessagesDuration
            : disappearingMessagesDuration // ignore: cast_nullable_to_non_nullable
                  as Duration?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl extends _Conversation {
  const _$ConversationImpl({
    required this.id,
    required this.type,
    required final List<String> participantIds,
    required final Map<String, ParticipantInfo> participants,
    this.lastMessageId,
    this.lastMessageText,
    this.lastMessageSenderId,
    this.lastMessageSenderName,
    this.lastMessageType,
    this.lastMessageAt,
    required final Map<String, int> unreadCounts,
    required final Map<String, bool> archived,
    required final Map<String, bool> pinned,
    required final Map<String, bool> muted,
    final Map<String, String> lastMessageEncryptedPreviews = const {},
    final Map<String, DateTime> chatClearedAt = const {},
    final Map<String, bool> accepted = const {},
    final Map<String, bool> sessionResetRequested = const {},
    this.tokenPoolId,
    this.poolTitle,
    this.poolMode,
    this.disappearingMessagesDuration,
    required this.createdAt,
    this.updatedAt,
  }) : _participantIds = participantIds,
       _participants = participants,
       _unreadCounts = unreadCounts,
       _archived = archived,
       _pinned = pinned,
       _muted = muted,
       _lastMessageEncryptedPreviews = lastMessageEncryptedPreviews,
       _chatClearedAt = chatClearedAt,
       _accepted = accepted,
       _sessionResetRequested = sessionResetRequested,
       super._();

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String id;
  @override
  final ConversationType type;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  final Map<String, ParticipantInfo> _participants;
  @override
  Map<String, ParticipantInfo> get participants {
    if (_participants is EqualUnmodifiableMapView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_participants);
  }

  // Last message preview (for inbox list)
  @override
  final String? lastMessageId;
  @override
  final String? lastMessageText;
  @override
  final String? lastMessageSenderId;
  @override
  final String? lastMessageSenderName;
  @override
  final String? lastMessageType;
  @override
  final DateTime? lastMessageAt;
  // Per-user state
  final Map<String, int> _unreadCounts;
  // Per-user state
  @override
  Map<String, int> get unreadCounts {
    if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_unreadCounts);
  }

  final Map<String, bool> _archived;
  @override
  Map<String, bool> get archived {
    if (_archived is EqualUnmodifiableMapView) return _archived;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_archived);
  }

  final Map<String, bool> _pinned;
  @override
  Map<String, bool> get pinned {
    if (_pinned is EqualUnmodifiableMapView) return _pinned;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pinned);
  }

  final Map<String, bool> _muted;
  @override
  Map<String, bool> get muted {
    if (_muted is EqualUnmodifiableMapView) return _muted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_muted);
  }

  // E2EE: per-user encrypted last message previews
  final Map<String, String> _lastMessageEncryptedPreviews;
  // E2EE: per-user encrypted last message previews
  @override
  @JsonKey()
  Map<String, String> get lastMessageEncryptedPreviews {
    if (_lastMessageEncryptedPreviews is EqualUnmodifiableMapView)
      return _lastMessageEncryptedPreviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastMessageEncryptedPreviews);
  }

  // Per-user chat cleared timestamps
  final Map<String, DateTime> _chatClearedAt;
  // Per-user chat cleared timestamps
  @override
  @JsonKey()
  Map<String, DateTime> get chatClearedAt {
    if (_chatClearedAt is EqualUnmodifiableMapView) return _chatClearedAt;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_chatClearedAt);
  }

  // Per-user acceptance status (message request system)
  final Map<String, bool> _accepted;
  // Per-user acceptance status (message request system)
  @override
  @JsonKey()
  Map<String, bool> get accepted {
    if (_accepted is EqualUnmodifiableMapView) return _accepted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_accepted);
  }

  // E2EE: per-user session reset requested flags
  final Map<String, bool> _sessionResetRequested;
  // E2EE: per-user session reset requested flags
  @override
  @JsonKey()
  Map<String, bool> get sessionResetRequested {
    if (_sessionResetRequested is EqualUnmodifiableMapView)
      return _sessionResetRequested;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sessionResetRequested);
  }

  /// Token pool ID (for collection-type conversations)
  @override
  final String? tokenPoolId;

  /// Pool title (denormalized for collection-type conversations)
  @override
  final String? poolTitle;

  /// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
  @override
  final String? poolMode;

  /// Disappearing messages duration. Null means off.
  @override
  final Duration? disappearingMessagesDuration;
  // Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Conversation(id: $id, type: $type, participantIds: $participantIds, participants: $participants, lastMessageId: $lastMessageId, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, archived: $archived, pinned: $pinned, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, chatClearedAt: $chatClearedAt, accepted: $accepted, sessionResetRequested: $sessionResetRequested, tokenPoolId: $tokenPoolId, poolTitle: $poolTitle, poolMode: $poolMode, disappearingMessagesDuration: $disappearingMessagesDuration, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._participantIds,
              _participantIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            (identical(other.lastMessageId, lastMessageId) ||
                other.lastMessageId == lastMessageId) &&
            (identical(other.lastMessageText, lastMessageText) ||
                other.lastMessageText == lastMessageText) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(other.lastMessageSenderName, lastMessageSenderName) ||
                other.lastMessageSenderName == lastMessageSenderName) &&
            (identical(other.lastMessageType, lastMessageType) ||
                other.lastMessageType == lastMessageType) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            const DeepCollectionEquality().equals(
              other._unreadCounts,
              _unreadCounts,
            ) &&
            const DeepCollectionEquality().equals(other._archived, _archived) &&
            const DeepCollectionEquality().equals(other._pinned, _pinned) &&
            const DeepCollectionEquality().equals(other._muted, _muted) &&
            const DeepCollectionEquality().equals(
              other._lastMessageEncryptedPreviews,
              _lastMessageEncryptedPreviews,
            ) &&
            const DeepCollectionEquality().equals(
              other._chatClearedAt,
              _chatClearedAt,
            ) &&
            const DeepCollectionEquality().equals(other._accepted, _accepted) &&
            const DeepCollectionEquality().equals(
              other._sessionResetRequested,
              _sessionResetRequested,
            ) &&
            (identical(other.tokenPoolId, tokenPoolId) ||
                other.tokenPoolId == tokenPoolId) &&
            (identical(other.poolTitle, poolTitle) ||
                other.poolTitle == poolTitle) &&
            (identical(other.poolMode, poolMode) ||
                other.poolMode == poolMode) &&
            (identical(
                  other.disappearingMessagesDuration,
                  disappearingMessagesDuration,
                ) ||
                other.disappearingMessagesDuration ==
                    disappearingMessagesDuration) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    type,
    const DeepCollectionEquality().hash(_participantIds),
    const DeepCollectionEquality().hash(_participants),
    lastMessageId,
    lastMessageText,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageType,
    lastMessageAt,
    const DeepCollectionEquality().hash(_unreadCounts),
    const DeepCollectionEquality().hash(_archived),
    const DeepCollectionEquality().hash(_pinned),
    const DeepCollectionEquality().hash(_muted),
    const DeepCollectionEquality().hash(_lastMessageEncryptedPreviews),
    const DeepCollectionEquality().hash(_chatClearedAt),
    const DeepCollectionEquality().hash(_accepted),
    const DeepCollectionEquality().hash(_sessionResetRequested),
    tokenPoolId,
    poolTitle,
    poolMode,
    disappearingMessagesDuration,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(this);
  }
}

abstract class _Conversation extends Conversation {
  const factory _Conversation({
    required final String id,
    required final ConversationType type,
    required final List<String> participantIds,
    required final Map<String, ParticipantInfo> participants,
    final String? lastMessageId,
    final String? lastMessageText,
    final String? lastMessageSenderId,
    final String? lastMessageSenderName,
    final String? lastMessageType,
    final DateTime? lastMessageAt,
    required final Map<String, int> unreadCounts,
    required final Map<String, bool> archived,
    required final Map<String, bool> pinned,
    required final Map<String, bool> muted,
    final Map<String, String> lastMessageEncryptedPreviews,
    final Map<String, DateTime> chatClearedAt,
    final Map<String, bool> accepted,
    final Map<String, bool> sessionResetRequested,
    final String? tokenPoolId,
    final String? poolTitle,
    final String? poolMode,
    final Duration? disappearingMessagesDuration,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$ConversationImpl;
  const _Conversation._() : super._();

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String get id;
  @override
  ConversationType get type;
  @override
  List<String> get participantIds;
  @override
  Map<String, ParticipantInfo> get participants; // Last message preview (for inbox list)
  @override
  String? get lastMessageId;
  @override
  String? get lastMessageText;
  @override
  String? get lastMessageSenderId;
  @override
  String? get lastMessageSenderName;
  @override
  String? get lastMessageType;
  @override
  DateTime? get lastMessageAt; // Per-user state
  @override
  Map<String, int> get unreadCounts;
  @override
  Map<String, bool> get archived;
  @override
  Map<String, bool> get pinned;
  @override
  Map<String, bool> get muted; // E2EE: per-user encrypted last message previews
  @override
  Map<String, String> get lastMessageEncryptedPreviews; // Per-user chat cleared timestamps
  @override
  Map<String, DateTime> get chatClearedAt; // Per-user acceptance status (message request system)
  @override
  Map<String, bool> get accepted; // E2EE: per-user session reset requested flags
  @override
  Map<String, bool> get sessionResetRequested;

  /// Token pool ID (for collection-type conversations)
  @override
  String? get tokenPoolId;

  /// Pool title (denormalized for collection-type conversations)
  @override
  String? get poolTitle;

  /// Pool mode: 'sasaza' or 'save' (denormalized for collection-type conversations)
  @override
  String? get poolMode;

  /// Disappearing messages duration. Null means off.
  @override
  Duration? get disappearingMessagesDuration; // Timestamps
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
