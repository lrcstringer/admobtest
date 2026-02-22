// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConversationModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>> get participants =>
      throw _privateConstructorUsedError; // Last message preview
  String? get lastMessageId => throw _privateConstructorUsedError;
  String? get lastMessageText => throw _privateConstructorUsedError;
  String? get lastMessageSenderId => throw _privateConstructorUsedError;
  String? get lastMessageSenderName => throw _privateConstructorUsedError;
  String? get lastMessageType => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt =>
      throw _privateConstructorUsedError; // Per-user state maps
  Map<String, int> get unreadCounts => throw _privateConstructorUsedError;
  Map<String, bool> get archived => throw _privateConstructorUsedError;
  Map<String, bool> get pinned => throw _privateConstructorUsedError;
  Map<String, bool> get muted =>
      throw _privateConstructorUsedError; // E2EE: per-user encrypted last message previews
  Map<String, String> get lastMessageEncryptedPreviews =>
      throw _privateConstructorUsedError; // Per-user chat cleared timestamps
  Map<String, DateTime> get chatClearedAt =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationModelCopyWith<ConversationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationModelCopyWith<$Res> {
  factory $ConversationModelCopyWith(
    ConversationModel value,
    $Res Function(ConversationModel) then,
  ) = _$ConversationModelCopyWithImpl<$Res, ConversationModel>;
  @useResult
  $Res call({
    String id,
    String type,
    List<String> participantIds,
    Map<String, Map<String, dynamic>> participants,
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
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ConversationModelCopyWithImpl<$Res, $Val extends ConversationModel>
    implements $ConversationModelCopyWith<$Res> {
  _$ConversationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationModel
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
                      as String,
            participantIds: null == participantIds
                ? _value.participantIds
                : participantIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as Map<String, Map<String, dynamic>>,
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
abstract class _$$ConversationModelImplCopyWith<$Res>
    implements $ConversationModelCopyWith<$Res> {
  factory _$$ConversationModelImplCopyWith(
    _$ConversationModelImpl value,
    $Res Function(_$ConversationModelImpl) then,
  ) = __$$ConversationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    List<String> participantIds,
    Map<String, Map<String, dynamic>> participants,
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
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ConversationModelImplCopyWithImpl<$Res>
    extends _$ConversationModelCopyWithImpl<$Res, _$ConversationModelImpl>
    implements _$$ConversationModelImplCopyWith<$Res> {
  __$$ConversationModelImplCopyWithImpl(
    _$ConversationModelImpl _value,
    $Res Function(_$ConversationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationModel
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
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ConversationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        participantIds: null == participantIds
            ? _value._participantIds
            : participantIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as Map<String, Map<String, dynamic>>,
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

class _$ConversationModelImpl extends _ConversationModel {
  const _$ConversationModelImpl({
    required this.id,
    required this.type,
    required final List<String> participantIds,
    required final Map<String, Map<String, dynamic>> participants,
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
       super._();

  @override
  final String id;
  @override
  final String type;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  final Map<String, Map<String, dynamic>> _participants;
  @override
  Map<String, Map<String, dynamic>> get participants {
    if (_participants is EqualUnmodifiableMapView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_participants);
  }

  // Last message preview
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
  // Per-user state maps
  final Map<String, int> _unreadCounts;
  // Per-user state maps
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

  // Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ConversationModel(id: $id, type: $type, participantIds: $participantIds, participants: $participants, lastMessageId: $lastMessageId, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, archived: $archived, pinned: $pinned, muted: $muted, lastMessageEncryptedPreviews: $lastMessageEncryptedPreviews, chatClearedAt: $chatClearedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationModelImpl &&
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
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
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
    createdAt,
    updatedAt,
  );

  /// Create a copy of ConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationModelImplCopyWith<_$ConversationModelImpl> get copyWith =>
      __$$ConversationModelImplCopyWithImpl<_$ConversationModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ConversationModel extends ConversationModel {
  const factory _ConversationModel({
    required final String id,
    required final String type,
    required final List<String> participantIds,
    required final Map<String, Map<String, dynamic>> participants,
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
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$ConversationModelImpl;
  const _ConversationModel._() : super._();

  @override
  String get id;
  @override
  String get type;
  @override
  List<String> get participantIds;
  @override
  Map<String, Map<String, dynamic>> get participants; // Last message preview
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
  DateTime? get lastMessageAt; // Per-user state maps
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
  Map<String, DateTime> get chatClearedAt; // Timestamps
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ConversationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationModelImplCopyWith<_$ConversationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
