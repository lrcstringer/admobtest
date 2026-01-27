// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_thread_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatThreadModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get avatarColor => throw _privateConstructorUsedError;
  String? get lastMessagePreview => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ChatThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatThreadModelCopyWith<ChatThreadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatThreadModelCopyWith<$Res> {
  factory $ChatThreadModelCopyWith(
    ChatThreadModel value,
    $Res Function(ChatThreadModel) then,
  ) = _$ChatThreadModelCopyWithImpl<$Res, ChatThreadModel>;
  @useResult
  $Res call({
    String id,
    String type,
    List<String> participantIds,
    String displayName,
    String? avatarUrl,
    String? avatarColor,
    String? lastMessagePreview,
    DateTime? lastMessageAt,
    int unreadCount,
    bool isPinned,
    bool isMuted,
    bool isArchived,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ChatThreadModelCopyWithImpl<$Res, $Val extends ChatThreadModel>
    implements $ChatThreadModelCopyWith<$Res> {
  _$ChatThreadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? participantIds = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? lastMessagePreview = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = null,
    Object? isPinned = null,
    Object? isMuted = null,
    Object? isArchived = null,
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
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarColor: freezed == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessagePreview: freezed == lastMessagePreview
                ? _value.lastMessagePreview
                : lastMessagePreview // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAt: freezed == lastMessageAt
                ? _value.lastMessageAt
                : lastMessageAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMuted: null == isMuted
                ? _value.isMuted
                : isMuted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isArchived: null == isArchived
                ? _value.isArchived
                : isArchived // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$ChatThreadModelImplCopyWith<$Res>
    implements $ChatThreadModelCopyWith<$Res> {
  factory _$$ChatThreadModelImplCopyWith(
    _$ChatThreadModelImpl value,
    $Res Function(_$ChatThreadModelImpl) then,
  ) = __$$ChatThreadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    List<String> participantIds,
    String displayName,
    String? avatarUrl,
    String? avatarColor,
    String? lastMessagePreview,
    DateTime? lastMessageAt,
    int unreadCount,
    bool isPinned,
    bool isMuted,
    bool isArchived,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ChatThreadModelImplCopyWithImpl<$Res>
    extends _$ChatThreadModelCopyWithImpl<$Res, _$ChatThreadModelImpl>
    implements _$$ChatThreadModelImplCopyWith<$Res> {
  __$$ChatThreadModelImplCopyWithImpl(
    _$ChatThreadModelImpl _value,
    $Res Function(_$ChatThreadModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? participantIds = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? lastMessagePreview = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = null,
    Object? isPinned = null,
    Object? isMuted = null,
    Object? isArchived = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ChatThreadModelImpl(
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
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessagePreview: freezed == lastMessagePreview
            ? _value.lastMessagePreview
            : lastMessagePreview // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAt: freezed == lastMessageAt
            ? _value.lastMessageAt
            : lastMessageAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMuted: null == isMuted
            ? _value.isMuted
            : isMuted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isArchived: null == isArchived
            ? _value.isArchived
            : isArchived // ignore: cast_nullable_to_non_nullable
                  as bool,
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

class _$ChatThreadModelImpl extends _ChatThreadModel {
  const _$ChatThreadModelImpl({
    required this.id,
    required this.type,
    required final List<String> participantIds,
    required this.displayName,
    this.avatarUrl,
    this.avatarColor,
    this.lastMessagePreview,
    this.lastMessageAt,
    required this.unreadCount,
    required this.isPinned,
    required this.isMuted,
    required this.isArchived,
    required this.createdAt,
    this.updatedAt,
  }) : _participantIds = participantIds,
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

  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final String? avatarColor;
  @override
  final String? lastMessagePreview;
  @override
  final DateTime? lastMessageAt;
  @override
  final int unreadCount;
  @override
  final bool isPinned;
  @override
  final bool isMuted;
  @override
  final bool isArchived;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ChatThreadModel(id: $id, type: $type, participantIds: $participantIds, displayName: $displayName, avatarUrl: $avatarUrl, avatarColor: $avatarColor, lastMessagePreview: $lastMessagePreview, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, isPinned: $isPinned, isMuted: $isMuted, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatThreadModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._participantIds,
              _participantIds,
            ) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.lastMessagePreview, lastMessagePreview) ||
                other.lastMessagePreview == lastMessagePreview) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
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
    displayName,
    avatarUrl,
    avatarColor,
    lastMessagePreview,
    lastMessageAt,
    unreadCount,
    isPinned,
    isMuted,
    isArchived,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ChatThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatThreadModelImplCopyWith<_$ChatThreadModelImpl> get copyWith =>
      __$$ChatThreadModelImplCopyWithImpl<_$ChatThreadModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ChatThreadModel extends ChatThreadModel {
  const factory _ChatThreadModel({
    required final String id,
    required final String type,
    required final List<String> participantIds,
    required final String displayName,
    final String? avatarUrl,
    final String? avatarColor,
    final String? lastMessagePreview,
    final DateTime? lastMessageAt,
    required final int unreadCount,
    required final bool isPinned,
    required final bool isMuted,
    required final bool isArchived,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$ChatThreadModelImpl;
  const _ChatThreadModel._() : super._();

  @override
  String get id;
  @override
  String get type;
  @override
  List<String> get participantIds;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
  @override
  String? get avatarColor;
  @override
  String? get lastMessagePreview;
  @override
  DateTime? get lastMessageAt;
  @override
  int get unreadCount;
  @override
  bool get isPinned;
  @override
  bool get isMuted;
  @override
  bool get isArchived;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ChatThreadModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatThreadModelImplCopyWith<_$ChatThreadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
