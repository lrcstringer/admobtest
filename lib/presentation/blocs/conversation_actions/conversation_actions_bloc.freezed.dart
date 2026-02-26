// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_actions_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConversationActionsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationActionsEventCopyWith<$Res> {
  factory $ConversationActionsEventCopyWith(
    ConversationActionsEvent value,
    $Res Function(ConversationActionsEvent) then,
  ) = _$ConversationActionsEventCopyWithImpl<$Res, ConversationActionsEvent>;
}

/// @nodoc
class _$ConversationActionsEventCopyWithImpl<
  $Res,
  $Val extends ConversationActionsEvent
>
    implements $ConversationActionsEventCopyWith<$Res> {
  _$ConversationActionsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MarkAsReadImplCopyWith<$Res> {
  factory _$$MarkAsReadImplCopyWith(
    _$MarkAsReadImpl value,
    $Res Function(_$MarkAsReadImpl) then,
  ) = __$$MarkAsReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId});
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$ConversationActionsEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
    _$MarkAsReadImpl _value,
    $Res Function(_$MarkAsReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null}) {
    return _then(
      _$MarkAsReadImpl(
        null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MarkAsReadImpl implements _MarkAsRead {
  const _$MarkAsReadImpl(this.conversationId);

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationActionsEvent.markAsRead(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      __$$MarkAsReadImplCopyWithImpl<_$MarkAsReadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return markAsRead(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return markAsRead?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAsRead implements ConversationActionsEvent {
  const factory _MarkAsRead(final String conversationId) = _$MarkAsReadImpl;

  String get conversationId;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TogglePinImplCopyWith<$Res> {
  factory _$$TogglePinImplCopyWith(
    _$TogglePinImpl value,
    $Res Function(_$TogglePinImpl) then,
  ) = __$$TogglePinImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, bool pinned});
}

/// @nodoc
class __$$TogglePinImplCopyWithImpl<$Res>
    extends _$ConversationActionsEventCopyWithImpl<$Res, _$TogglePinImpl>
    implements _$$TogglePinImplCopyWith<$Res> {
  __$$TogglePinImplCopyWithImpl(
    _$TogglePinImpl _value,
    $Res Function(_$TogglePinImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? pinned = null}) {
    return _then(
      _$TogglePinImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        pinned: null == pinned
            ? _value.pinned
            : pinned // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TogglePinImpl implements _TogglePin {
  const _$TogglePinImpl({required this.conversationId, required this.pinned});

  @override
  final String conversationId;
  @override
  final bool pinned;

  @override
  String toString() {
    return 'ConversationActionsEvent.togglePin(conversationId: $conversationId, pinned: $pinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TogglePinImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.pinned, pinned) || other.pinned == pinned));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, pinned);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TogglePinImplCopyWith<_$TogglePinImpl> get copyWith =>
      __$$TogglePinImplCopyWithImpl<_$TogglePinImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return togglePin(conversationId, pinned);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return togglePin?.call(conversationId, pinned);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (togglePin != null) {
      return togglePin(conversationId, pinned);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return togglePin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return togglePin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (togglePin != null) {
      return togglePin(this);
    }
    return orElse();
  }
}

abstract class _TogglePin implements ConversationActionsEvent {
  const factory _TogglePin({
    required final String conversationId,
    required final bool pinned,
  }) = _$TogglePinImpl;

  String get conversationId;
  bool get pinned;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TogglePinImplCopyWith<_$TogglePinImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleMuteImplCopyWith<$Res> {
  factory _$$ToggleMuteImplCopyWith(
    _$ToggleMuteImpl value,
    $Res Function(_$ToggleMuteImpl) then,
  ) = __$$ToggleMuteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, bool muted});
}

/// @nodoc
class __$$ToggleMuteImplCopyWithImpl<$Res>
    extends _$ConversationActionsEventCopyWithImpl<$Res, _$ToggleMuteImpl>
    implements _$$ToggleMuteImplCopyWith<$Res> {
  __$$ToggleMuteImplCopyWithImpl(
    _$ToggleMuteImpl _value,
    $Res Function(_$ToggleMuteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? muted = null}) {
    return _then(
      _$ToggleMuteImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        muted: null == muted
            ? _value.muted
            : muted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ToggleMuteImpl implements _ToggleMute {
  const _$ToggleMuteImpl({required this.conversationId, required this.muted});

  @override
  final String conversationId;
  @override
  final bool muted;

  @override
  String toString() {
    return 'ConversationActionsEvent.toggleMute(conversationId: $conversationId, muted: $muted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleMuteImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, muted);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleMuteImplCopyWith<_$ToggleMuteImpl> get copyWith =>
      __$$ToggleMuteImplCopyWithImpl<_$ToggleMuteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return toggleMute(conversationId, muted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return toggleMute?.call(conversationId, muted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(conversationId, muted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return toggleMute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return toggleMute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(this);
    }
    return orElse();
  }
}

abstract class _ToggleMute implements ConversationActionsEvent {
  const factory _ToggleMute({
    required final String conversationId,
    required final bool muted,
  }) = _$ToggleMuteImpl;

  String get conversationId;
  bool get muted;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleMuteImplCopyWith<_$ToggleMuteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArchiveConversationImplCopyWith<$Res> {
  factory _$$ArchiveConversationImplCopyWith(
    _$ArchiveConversationImpl value,
    $Res Function(_$ArchiveConversationImpl) then,
  ) = __$$ArchiveConversationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId});
}

/// @nodoc
class __$$ArchiveConversationImplCopyWithImpl<$Res>
    extends
        _$ConversationActionsEventCopyWithImpl<$Res, _$ArchiveConversationImpl>
    implements _$$ArchiveConversationImplCopyWith<$Res> {
  __$$ArchiveConversationImplCopyWithImpl(
    _$ArchiveConversationImpl _value,
    $Res Function(_$ArchiveConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null}) {
    return _then(
      _$ArchiveConversationImpl(
        null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ArchiveConversationImpl implements _ArchiveConversation {
  const _$ArchiveConversationImpl(this.conversationId);

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ConversationActionsEvent.archiveConversation(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArchiveConversationImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArchiveConversationImplCopyWith<_$ArchiveConversationImpl> get copyWith =>
      __$$ArchiveConversationImplCopyWithImpl<_$ArchiveConversationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return archiveConversation(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return archiveConversation?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (archiveConversation != null) {
      return archiveConversation(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return archiveConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return archiveConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (archiveConversation != null) {
      return archiveConversation(this);
    }
    return orElse();
  }
}

abstract class _ArchiveConversation implements ConversationActionsEvent {
  const factory _ArchiveConversation(final String conversationId) =
      _$ArchiveConversationImpl;

  String get conversationId;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArchiveConversationImplCopyWith<_$ArchiveConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddReactionImplCopyWith<$Res> {
  factory _$$AddReactionImplCopyWith(
    _$AddReactionImpl value,
    $Res Function(_$AddReactionImpl) then,
  ) = __$$AddReactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String messageId, String emoji});
}

/// @nodoc
class __$$AddReactionImplCopyWithImpl<$Res>
    extends _$ConversationActionsEventCopyWithImpl<$Res, _$AddReactionImpl>
    implements _$$AddReactionImplCopyWith<$Res> {
  __$$AddReactionImplCopyWithImpl(
    _$AddReactionImpl _value,
    $Res Function(_$AddReactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? messageId = null,
    Object? emoji = null,
  }) {
    return _then(
      _$AddReactionImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AddReactionImpl implements _AddReaction {
  const _$AddReactionImpl({
    required this.conversationId,
    required this.messageId,
    required this.emoji,
  });

  @override
  final String conversationId;
  @override
  final String messageId;
  @override
  final String emoji;

  @override
  String toString() {
    return 'ConversationActionsEvent.addReaction(conversationId: $conversationId, messageId: $messageId, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddReactionImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, messageId, emoji);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddReactionImplCopyWith<_$AddReactionImpl> get copyWith =>
      __$$AddReactionImplCopyWithImpl<_$AddReactionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return addReaction(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return addReaction?.call(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (addReaction != null) {
      return addReaction(conversationId, messageId, emoji);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return addReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return addReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (addReaction != null) {
      return addReaction(this);
    }
    return orElse();
  }
}

abstract class _AddReaction implements ConversationActionsEvent {
  const factory _AddReaction({
    required final String conversationId,
    required final String messageId,
    required final String emoji,
  }) = _$AddReactionImpl;

  String get conversationId;
  String get messageId;
  String get emoji;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddReactionImplCopyWith<_$AddReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveReactionImplCopyWith<$Res> {
  factory _$$RemoveReactionImplCopyWith(
    _$RemoveReactionImpl value,
    $Res Function(_$RemoveReactionImpl) then,
  ) = __$$RemoveReactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String messageId, String emoji});
}

/// @nodoc
class __$$RemoveReactionImplCopyWithImpl<$Res>
    extends _$ConversationActionsEventCopyWithImpl<$Res, _$RemoveReactionImpl>
    implements _$$RemoveReactionImplCopyWith<$Res> {
  __$$RemoveReactionImplCopyWithImpl(
    _$RemoveReactionImpl _value,
    $Res Function(_$RemoveReactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? messageId = null,
    Object? emoji = null,
  }) {
    return _then(
      _$RemoveReactionImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveReactionImpl implements _RemoveReaction {
  const _$RemoveReactionImpl({
    required this.conversationId,
    required this.messageId,
    required this.emoji,
  });

  @override
  final String conversationId;
  @override
  final String messageId;
  @override
  final String emoji;

  @override
  String toString() {
    return 'ConversationActionsEvent.removeReaction(conversationId: $conversationId, messageId: $messageId, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveReactionImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, messageId, emoji);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveReactionImplCopyWith<_$RemoveReactionImpl> get copyWith =>
      __$$RemoveReactionImplCopyWithImpl<_$RemoveReactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return removeReaction(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return removeReaction?.call(conversationId, messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (removeReaction != null) {
      return removeReaction(conversationId, messageId, emoji);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return removeReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return removeReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (removeReaction != null) {
      return removeReaction(this);
    }
    return orElse();
  }
}

abstract class _RemoveReaction implements ConversationActionsEvent {
  const factory _RemoveReaction({
    required final String conversationId,
    required final String messageId,
    required final String emoji,
  }) = _$RemoveReactionImpl;

  String get conversationId;
  String get messageId;
  String get emoji;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveReactionImplCopyWith<_$RemoveReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteMessageForEveryoneImplCopyWith<$Res> {
  factory _$$DeleteMessageForEveryoneImplCopyWith(
    _$DeleteMessageForEveryoneImpl value,
    $Res Function(_$DeleteMessageForEveryoneImpl) then,
  ) = __$$DeleteMessageForEveryoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String messageId});
}

/// @nodoc
class __$$DeleteMessageForEveryoneImplCopyWithImpl<$Res>
    extends
        _$ConversationActionsEventCopyWithImpl<
          $Res,
          _$DeleteMessageForEveryoneImpl
        >
    implements _$$DeleteMessageForEveryoneImplCopyWith<$Res> {
  __$$DeleteMessageForEveryoneImplCopyWithImpl(
    _$DeleteMessageForEveryoneImpl _value,
    $Res Function(_$DeleteMessageForEveryoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? messageId = null}) {
    return _then(
      _$DeleteMessageForEveryoneImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        messageId: null == messageId
            ? _value.messageId
            : messageId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteMessageForEveryoneImpl implements _DeleteMessageForEveryone {
  const _$DeleteMessageForEveryoneImpl({
    required this.conversationId,
    required this.messageId,
  });

  @override
  final String conversationId;
  @override
  final String messageId;

  @override
  String toString() {
    return 'ConversationActionsEvent.deleteMessageForEveryone(conversationId: $conversationId, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteMessageForEveryoneImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, messageId);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteMessageForEveryoneImplCopyWith<_$DeleteMessageForEveryoneImpl>
  get copyWith =>
      __$$DeleteMessageForEveryoneImplCopyWithImpl<
        _$DeleteMessageForEveryoneImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return deleteMessageForEveryone(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return deleteMessageForEveryone?.call(conversationId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (deleteMessageForEveryone != null) {
      return deleteMessageForEveryone(conversationId, messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return deleteMessageForEveryone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return deleteMessageForEveryone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (deleteMessageForEveryone != null) {
      return deleteMessageForEveryone(this);
    }
    return orElse();
  }
}

abstract class _DeleteMessageForEveryone implements ConversationActionsEvent {
  const factory _DeleteMessageForEveryone({
    required final String conversationId,
    required final String messageId,
  }) = _$DeleteMessageForEveryoneImpl;

  String get conversationId;
  String get messageId;

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteMessageForEveryoneImplCopyWith<_$DeleteMessageForEveryoneImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$ConversationActionsEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'ConversationActionsEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) markAsRead,
    required TResult Function(String conversationId, bool pinned) togglePin,
    required TResult Function(String conversationId, bool muted) toggleMute,
    required TResult Function(String conversationId) archiveConversation,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    addReaction,
    required TResult Function(
      String conversationId,
      String messageId,
      String emoji,
    )
    removeReaction,
    required TResult Function(String conversationId, String messageId)
    deleteMessageForEveryone,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? markAsRead,
    TResult? Function(String conversationId, bool pinned)? togglePin,
    TResult? Function(String conversationId, bool muted)? toggleMute,
    TResult? Function(String conversationId)? archiveConversation,
    TResult? Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult? Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult? Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? markAsRead,
    TResult Function(String conversationId, bool pinned)? togglePin,
    TResult Function(String conversationId, bool muted)? toggleMute,
    TResult Function(String conversationId)? archiveConversation,
    TResult Function(String conversationId, String messageId, String emoji)?
    addReaction,
    TResult Function(String conversationId, String messageId, String emoji)?
    removeReaction,
    TResult Function(String conversationId, String messageId)?
    deleteMessageForEveryone,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_TogglePin value) togglePin,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ArchiveConversation value) archiveConversation,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_DeleteMessageForEveryone value)
    deleteMessageForEveryone,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_TogglePin value)? togglePin,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ArchiveConversation value)? archiveConversation,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_DeleteMessageForEveryone value)?
    deleteMessageForEveryone,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_TogglePin value)? togglePin,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ArchiveConversation value)? archiveConversation,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_DeleteMessageForEveryone value)? deleteMessageForEveryone,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements ConversationActionsEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
mixin _$ConversationActionsState {
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ConversationActionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationActionsStateCopyWith<ConversationActionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationActionsStateCopyWith<$Res> {
  factory $ConversationActionsStateCopyWith(
    ConversationActionsState value,
    $Res Function(ConversationActionsState) then,
  ) = _$ConversationActionsStateCopyWithImpl<$Res, ConversationActionsState>;
  @useResult
  $Res call({String? errorMessage});
}

/// @nodoc
class _$ConversationActionsStateCopyWithImpl<
  $Res,
  $Val extends ConversationActionsState
>
    implements $ConversationActionsStateCopyWith<$Res> {
  _$ConversationActionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationActionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = freezed}) {
    return _then(
      _value.copyWith(
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConversationActionsStateImplCopyWith<$Res>
    implements $ConversationActionsStateCopyWith<$Res> {
  factory _$$ConversationActionsStateImplCopyWith(
    _$ConversationActionsStateImpl value,
    $Res Function(_$ConversationActionsStateImpl) then,
  ) = __$$ConversationActionsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? errorMessage});
}

/// @nodoc
class __$$ConversationActionsStateImplCopyWithImpl<$Res>
    extends
        _$ConversationActionsStateCopyWithImpl<
          $Res,
          _$ConversationActionsStateImpl
        >
    implements _$$ConversationActionsStateImplCopyWith<$Res> {
  __$$ConversationActionsStateImplCopyWithImpl(
    _$ConversationActionsStateImpl _value,
    $Res Function(_$ConversationActionsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationActionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = freezed}) {
    return _then(
      _$ConversationActionsStateImpl(
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ConversationActionsStateImpl implements _ConversationActionsState {
  const _$ConversationActionsStateImpl({this.errorMessage});

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ConversationActionsState(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationActionsStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of ConversationActionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationActionsStateImplCopyWith<_$ConversationActionsStateImpl>
  get copyWith =>
      __$$ConversationActionsStateImplCopyWithImpl<
        _$ConversationActionsStateImpl
      >(this, _$identity);
}

abstract class _ConversationActionsState implements ConversationActionsState {
  const factory _ConversationActionsState({final String? errorMessage}) =
      _$ConversationActionsStateImpl;

  @override
  String? get errorMessage;

  /// Create a copy of ConversationActionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationActionsStateImplCopyWith<_$ConversationActionsStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
