// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_messaging_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommunityMessagingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityMessagingEventCopyWith<$Res> {
  factory $CommunityMessagingEventCopyWith(
    CommunityMessagingEvent value,
    $Res Function(CommunityMessagingEvent) then,
  ) = _$CommunityMessagingEventCopyWithImpl<$Res, CommunityMessagingEvent>;
}

/// @nodoc
class _$CommunityMessagingEventCopyWithImpl<
  $Res,
  $Val extends CommunityMessagingEvent
>
    implements $CommunityMessagingEventCopyWith<$Res> {
  _$CommunityMessagingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadMessagesImplCopyWith<$Res> {
  factory _$$LoadMessagesImplCopyWith(
    _$LoadMessagesImpl value,
    $Res Function(_$LoadMessagesImpl) then,
  ) = __$$LoadMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? limit});
}

/// @nodoc
class __$$LoadMessagesImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$LoadMessagesImpl>
    implements _$$LoadMessagesImplCopyWith<$Res> {
  __$$LoadMessagesImplCopyWithImpl(
    _$LoadMessagesImpl _value,
    $Res Function(_$LoadMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? limit = freezed}) {
    return _then(
      _$LoadMessagesImpl(
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadMessagesImpl implements _LoadMessages {
  const _$LoadMessagesImpl({this.limit});

  @override
  final int? limit;

  @override
  String toString() {
    return 'CommunityMessagingEvent.loadMessages(limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMessagesImpl &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      __$$LoadMessagesImplCopyWithImpl<_$LoadMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return loadMessages(limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return loadMessages?.call(limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(this);
    }
    return orElse();
  }
}

abstract class _LoadMessages implements CommunityMessagingEvent {
  const factory _LoadMessages({final int? limit}) = _$LoadMessagesImpl;

  int? get limit;

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchMessagesImplCopyWith<$Res> {
  factory _$$WatchMessagesImplCopyWith(
    _$WatchMessagesImpl value,
    $Res Function(_$WatchMessagesImpl) then,
  ) = __$$WatchMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? limit});
}

/// @nodoc
class __$$WatchMessagesImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$WatchMessagesImpl>
    implements _$$WatchMessagesImplCopyWith<$Res> {
  __$$WatchMessagesImplCopyWithImpl(
    _$WatchMessagesImpl _value,
    $Res Function(_$WatchMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? limit = freezed}) {
    return _then(
      _$WatchMessagesImpl(
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$WatchMessagesImpl implements _WatchMessages {
  const _$WatchMessagesImpl({this.limit});

  @override
  final int? limit;

  @override
  String toString() {
    return 'CommunityMessagingEvent.watchMessages(limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchMessagesImpl &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchMessagesImplCopyWith<_$WatchMessagesImpl> get copyWith =>
      __$$WatchMessagesImplCopyWithImpl<_$WatchMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return watchMessages(limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return watchMessages?.call(limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchMessages != null) {
      return watchMessages(limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchMessages != null) {
      return watchMessages(this);
    }
    return orElse();
  }
}

abstract class _WatchMessages implements CommunityMessagingEvent {
  const factory _WatchMessages({final int? limit}) = _$WatchMessagesImpl;

  int? get limit;

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchMessagesImplCopyWith<_$WatchMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessagesUpdatedImplCopyWith<$Res> {
  factory _$$MessagesUpdatedImplCopyWith(
    _$MessagesUpdatedImpl value,
    $Res Function(_$MessagesUpdatedImpl) then,
  ) = __$$MessagesUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Message> messages});
}

/// @nodoc
class __$$MessagesUpdatedImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$MessagesUpdatedImpl>
    implements _$$MessagesUpdatedImplCopyWith<$Res> {
  __$$MessagesUpdatedImplCopyWithImpl(
    _$MessagesUpdatedImpl _value,
    $Res Function(_$MessagesUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _$MessagesUpdatedImpl(
        null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
      ),
    );
  }
}

/// @nodoc

class _$MessagesUpdatedImpl implements _MessagesUpdated {
  const _$MessagesUpdatedImpl(final List<Message> messages)
    : _messages = messages;

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'CommunityMessagingEvent.messagesUpdated(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesUpdatedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesUpdatedImplCopyWith<_$MessagesUpdatedImpl> get copyWith =>
      __$$MessagesUpdatedImplCopyWithImpl<_$MessagesUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return messagesUpdated(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return messagesUpdated?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (messagesUpdated != null) {
      return messagesUpdated(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return messagesUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return messagesUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (messagesUpdated != null) {
      return messagesUpdated(this);
    }
    return orElse();
  }
}

abstract class _MessagesUpdated implements CommunityMessagingEvent {
  const factory _MessagesUpdated(final List<Message> messages) =
      _$MessagesUpdatedImpl;

  List<Message> get messages;

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesUpdatedImplCopyWith<_$MessagesUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTextMessageImplCopyWith<$Res> {
  factory _$$SendTextMessageImplCopyWith(
    _$SendTextMessageImpl value,
    $Res Function(_$SendTextMessageImpl) then,
  ) = __$$SendTextMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text, String? replyToMessageId});
}

/// @nodoc
class __$$SendTextMessageImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$SendTextMessageImpl>
    implements _$$SendTextMessageImplCopyWith<$Res> {
  __$$SendTextMessageImplCopyWithImpl(
    _$SendTextMessageImpl _value,
    $Res Function(_$SendTextMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? replyToMessageId = freezed}) {
    return _then(
      _$SendTextMessageImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        replyToMessageId: freezed == replyToMessageId
            ? _value.replyToMessageId
            : replyToMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendTextMessageImpl implements _SendTextMessage {
  const _$SendTextMessageImpl({required this.text, this.replyToMessageId});

  @override
  final String text;
  @override
  final String? replyToMessageId;

  @override
  String toString() {
    return 'CommunityMessagingEvent.sendTextMessage(text: $text, replyToMessageId: $replyToMessageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTextMessageImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, replyToMessageId);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTextMessageImplCopyWith<_$SendTextMessageImpl> get copyWith =>
      __$$SendTextMessageImplCopyWithImpl<_$SendTextMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return sendTextMessage(text, replyToMessageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return sendTextMessage?.call(text, replyToMessageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (sendTextMessage != null) {
      return sendTextMessage(text, replyToMessageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendTextMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendTextMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (sendTextMessage != null) {
      return sendTextMessage(this);
    }
    return orElse();
  }
}

abstract class _SendTextMessage implements CommunityMessagingEvent {
  const factory _SendTextMessage({
    required final String text,
    final String? replyToMessageId,
  }) = _$SendTextMessageImpl;

  String get text;
  String? get replyToMessageId;

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTextMessageImplCopyWith<_$SendTextMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendMediaMessageImplCopyWith<$Res> {
  factory _$$SendMediaMessageImplCopyWith(
    _$SendMediaMessageImpl value,
    $Res Function(_$SendMediaMessageImpl) then,
  ) = __$$SendMediaMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    File mediaFile,
    String mediaType,
    String? caption,
    int? durationSeconds,
    File? thumbnailFile,
  });
}

/// @nodoc
class __$$SendMediaMessageImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$SendMediaMessageImpl>
    implements _$$SendMediaMessageImplCopyWith<$Res> {
  __$$SendMediaMessageImplCopyWithImpl(
    _$SendMediaMessageImpl _value,
    $Res Function(_$SendMediaMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaFile = null,
    Object? mediaType = null,
    Object? caption = freezed,
    Object? durationSeconds = freezed,
    Object? thumbnailFile = freezed,
  }) {
    return _then(
      _$SendMediaMessageImpl(
        mediaFile: null == mediaFile
            ? _value.mediaFile
            : mediaFile // ignore: cast_nullable_to_non_nullable
                  as File,
        mediaType: null == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                  as String,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationSeconds: freezed == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        thumbnailFile: freezed == thumbnailFile
            ? _value.thumbnailFile
            : thumbnailFile // ignore: cast_nullable_to_non_nullable
                  as File?,
      ),
    );
  }
}

/// @nodoc

class _$SendMediaMessageImpl implements _SendMediaMessage {
  const _$SendMediaMessageImpl({
    required this.mediaFile,
    required this.mediaType,
    this.caption,
    this.durationSeconds,
    this.thumbnailFile,
  });

  @override
  final File mediaFile;
  @override
  final String mediaType;
  @override
  final String? caption;
  @override
  final int? durationSeconds;
  @override
  final File? thumbnailFile;

  @override
  String toString() {
    return 'CommunityMessagingEvent.sendMediaMessage(mediaFile: $mediaFile, mediaType: $mediaType, caption: $caption, durationSeconds: $durationSeconds, thumbnailFile: $thumbnailFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMediaMessageImpl &&
            (identical(other.mediaFile, mediaFile) ||
                other.mediaFile == mediaFile) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.thumbnailFile, thumbnailFile) ||
                other.thumbnailFile == thumbnailFile));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    mediaFile,
    mediaType,
    caption,
    durationSeconds,
    thumbnailFile,
  );

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMediaMessageImplCopyWith<_$SendMediaMessageImpl> get copyWith =>
      __$$SendMediaMessageImplCopyWithImpl<_$SendMediaMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return sendMediaMessage(
      mediaFile,
      mediaType,
      caption,
      durationSeconds,
      thumbnailFile,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return sendMediaMessage?.call(
      mediaFile,
      mediaType,
      caption,
      durationSeconds,
      thumbnailFile,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (sendMediaMessage != null) {
      return sendMediaMessage(
        mediaFile,
        mediaType,
        caption,
        durationSeconds,
        thumbnailFile,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sendMediaMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sendMediaMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (sendMediaMessage != null) {
      return sendMediaMessage(this);
    }
    return orElse();
  }
}

abstract class _SendMediaMessage implements CommunityMessagingEvent {
  const factory _SendMediaMessage({
    required final File mediaFile,
    required final String mediaType,
    final String? caption,
    final int? durationSeconds,
    final File? thumbnailFile,
  }) = _$SendMediaMessageImpl;

  File get mediaFile;
  String get mediaType;
  String? get caption;
  int? get durationSeconds;
  File? get thumbnailFile;

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMediaMessageImplCopyWith<_$SendMediaMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddReactionImplCopyWith<$Res> {
  factory _$$AddReactionImplCopyWith(
    _$AddReactionImpl value,
    $Res Function(_$AddReactionImpl) then,
  ) = __$$AddReactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, String emoji});
}

/// @nodoc
class __$$AddReactionImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$AddReactionImpl>
    implements _$$AddReactionImplCopyWith<$Res> {
  __$$AddReactionImplCopyWithImpl(
    _$AddReactionImpl _value,
    $Res Function(_$AddReactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageId = null, Object? emoji = null}) {
    return _then(
      _$AddReactionImpl(
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
  const _$AddReactionImpl({required this.messageId, required this.emoji});

  @override
  final String messageId;
  @override
  final String emoji;

  @override
  String toString() {
    return 'CommunityMessagingEvent.addReaction(messageId: $messageId, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddReactionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, emoji);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddReactionImplCopyWith<_$AddReactionImpl> get copyWith =>
      __$$AddReactionImplCopyWithImpl<_$AddReactionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return addReaction(messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return addReaction?.call(messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (addReaction != null) {
      return addReaction(messageId, emoji);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return addReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return addReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (addReaction != null) {
      return addReaction(this);
    }
    return orElse();
  }
}

abstract class _AddReaction implements CommunityMessagingEvent {
  const factory _AddReaction({
    required final String messageId,
    required final String emoji,
  }) = _$AddReactionImpl;

  String get messageId;
  String get emoji;

  /// Create a copy of CommunityMessagingEvent
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
  $Res call({String messageId, String emoji});
}

/// @nodoc
class __$$RemoveReactionImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$RemoveReactionImpl>
    implements _$$RemoveReactionImplCopyWith<$Res> {
  __$$RemoveReactionImplCopyWithImpl(
    _$RemoveReactionImpl _value,
    $Res Function(_$RemoveReactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageId = null, Object? emoji = null}) {
    return _then(
      _$RemoveReactionImpl(
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
  const _$RemoveReactionImpl({required this.messageId, required this.emoji});

  @override
  final String messageId;
  @override
  final String emoji;

  @override
  String toString() {
    return 'CommunityMessagingEvent.removeReaction(messageId: $messageId, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveReactionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, emoji);

  /// Create a copy of CommunityMessagingEvent
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
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return removeReaction(messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return removeReaction?.call(messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (removeReaction != null) {
      return removeReaction(messageId, emoji);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return removeReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return removeReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (removeReaction != null) {
      return removeReaction(this);
    }
    return orElse();
  }
}

abstract class _RemoveReaction implements CommunityMessagingEvent {
  const factory _RemoveReaction({
    required final String messageId,
    required final String emoji,
  }) = _$RemoveReactionImpl;

  String get messageId;
  String get emoji;

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveReactionImplCopyWith<_$RemoveReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAsReadImplCopyWith<$Res> {
  factory _$$MarkAsReadImplCopyWith(
    _$MarkAsReadImpl value,
    $Res Function(_$MarkAsReadImpl) then,
  ) = __$$MarkAsReadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
    _$MarkAsReadImpl _value,
    $Res Function(_$MarkAsReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MarkAsReadImpl implements _MarkAsRead {
  const _$MarkAsReadImpl();

  @override
  String toString() {
    return 'CommunityMessagingEvent.markAsRead()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MarkAsReadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return markAsRead();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return markAsRead?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAsRead implements CommunityMessagingEvent {
  const factory _MarkAsRead() = _$MarkAsReadImpl;
}

/// @nodoc
abstract class _$$LoadMoreImplCopyWith<$Res> {
  factory _$$LoadMoreImplCopyWith(
    _$LoadMoreImpl value,
    $Res Function(_$LoadMoreImpl) then,
  ) = __$$LoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreImplCopyWithImpl<$Res>
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$LoadMoreImpl>
    implements _$$LoadMoreImplCopyWith<$Res> {
  __$$LoadMoreImplCopyWithImpl(
    _$LoadMoreImpl _value,
    $Res Function(_$LoadMoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreImpl implements _LoadMore {
  const _$LoadMoreImpl();

  @override
  String toString() {
    return 'CommunityMessagingEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class _LoadMore implements CommunityMessagingEvent {
  const factory _LoadMore() = _$LoadMoreImpl;
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
    extends _$CommunityMessagingEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'CommunityMessagingEvent.clearError()';
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
    required TResult Function(int? limit) loadMessages,
    required TResult Function(int? limit) watchMessages,
    required TResult Function(List<Message> messages) messagesUpdated,
    required TResult Function(String text, String? replyToMessageId)
    sendTextMessage,
    required TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )
    sendMediaMessage,
    required TResult Function(String messageId, String emoji) addReaction,
    required TResult Function(String messageId, String emoji) removeReaction,
    required TResult Function() markAsRead,
    required TResult Function() loadMore,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? limit)? loadMessages,
    TResult? Function(int? limit)? watchMessages,
    TResult? Function(List<Message> messages)? messagesUpdated,
    TResult? Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult? Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult? Function(String messageId, String emoji)? addReaction,
    TResult? Function(String messageId, String emoji)? removeReaction,
    TResult? Function()? markAsRead,
    TResult? Function()? loadMore,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? limit)? loadMessages,
    TResult Function(int? limit)? watchMessages,
    TResult Function(List<Message> messages)? messagesUpdated,
    TResult Function(String text, String? replyToMessageId)? sendTextMessage,
    TResult Function(
      File mediaFile,
      String mediaType,
      String? caption,
      int? durationSeconds,
      File? thumbnailFile,
    )?
    sendMediaMessage,
    TResult Function(String messageId, String emoji)? addReaction,
    TResult Function(String messageId, String emoji)? removeReaction,
    TResult Function()? markAsRead,
    TResult Function()? loadMore,
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
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_WatchMessages value) watchMessages,
    required TResult Function(_MessagesUpdated value) messagesUpdated,
    required TResult Function(_SendTextMessage value) sendTextMessage,
    required TResult Function(_SendMediaMessage value) sendMediaMessage,
    required TResult Function(_AddReaction value) addReaction,
    required TResult Function(_RemoveReaction value) removeReaction,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_WatchMessages value)? watchMessages,
    TResult? Function(_MessagesUpdated value)? messagesUpdated,
    TResult? Function(_SendTextMessage value)? sendTextMessage,
    TResult? Function(_SendMediaMessage value)? sendMediaMessage,
    TResult? Function(_AddReaction value)? addReaction,
    TResult? Function(_RemoveReaction value)? removeReaction,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_WatchMessages value)? watchMessages,
    TResult Function(_MessagesUpdated value)? messagesUpdated,
    TResult Function(_SendTextMessage value)? sendTextMessage,
    TResult Function(_SendMediaMessage value)? sendMediaMessage,
    TResult Function(_AddReaction value)? addReaction,
    TResult Function(_RemoveReaction value)? removeReaction,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements CommunityMessagingEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
mixin _$CommunityMessagingState {
  String get communityId => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CommunityMessagingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityMessagingStateCopyWith<CommunityMessagingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityMessagingStateCopyWith<$Res> {
  factory $CommunityMessagingStateCopyWith(
    CommunityMessagingState value,
    $Res Function(CommunityMessagingState) then,
  ) = _$CommunityMessagingStateCopyWithImpl<$Res, CommunityMessagingState>;
  @useResult
  $Res call({
    String communityId,
    List<Message> messages,
    bool isLoading,
    bool isSending,
    bool hasMore,
    String? errorMessage,
  });
}

/// @nodoc
class _$CommunityMessagingStateCopyWithImpl<
  $Res,
  $Val extends CommunityMessagingState
>
    implements $CommunityMessagingStateCopyWith<$Res> {
  _$CommunityMessagingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunityMessagingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? messages = null,
    Object? isLoading = null,
    Object? isSending = null,
    Object? hasMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            communityId: null == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<Message>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$CommunityMessagingStateImplCopyWith<$Res>
    implements $CommunityMessagingStateCopyWith<$Res> {
  factory _$$CommunityMessagingStateImplCopyWith(
    _$CommunityMessagingStateImpl value,
    $Res Function(_$CommunityMessagingStateImpl) then,
  ) = __$$CommunityMessagingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String communityId,
    List<Message> messages,
    bool isLoading,
    bool isSending,
    bool hasMore,
    String? errorMessage,
  });
}

/// @nodoc
class __$$CommunityMessagingStateImplCopyWithImpl<$Res>
    extends
        _$CommunityMessagingStateCopyWithImpl<
          $Res,
          _$CommunityMessagingStateImpl
        >
    implements _$$CommunityMessagingStateImplCopyWith<$Res> {
  __$$CommunityMessagingStateImplCopyWithImpl(
    _$CommunityMessagingStateImpl _value,
    $Res Function(_$CommunityMessagingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunityMessagingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? messages = null,
    Object? isLoading = null,
    Object? isSending = null,
    Object? hasMore = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CommunityMessagingStateImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CommunityMessagingStateImpl implements _CommunityMessagingState {
  const _$CommunityMessagingStateImpl({
    required this.communityId,
    final List<Message> messages = const [],
    this.isLoading = false,
    this.isSending = false,
    this.hasMore = false,
    this.errorMessage,
  }) : _messages = messages;

  @override
  final String communityId;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CommunityMessagingState(communityId: $communityId, messages: $messages, isLoading: $isLoading, isSending: $isSending, hasMore: $hasMore, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityMessagingStateImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    communityId,
    const DeepCollectionEquality().hash(_messages),
    isLoading,
    isSending,
    hasMore,
    errorMessage,
  );

  /// Create a copy of CommunityMessagingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityMessagingStateImplCopyWith<_$CommunityMessagingStateImpl>
  get copyWith =>
      __$$CommunityMessagingStateImplCopyWithImpl<
        _$CommunityMessagingStateImpl
      >(this, _$identity);
}

abstract class _CommunityMessagingState implements CommunityMessagingState {
  const factory _CommunityMessagingState({
    required final String communityId,
    final List<Message> messages,
    final bool isLoading,
    final bool isSending,
    final bool hasMore,
    final String? errorMessage,
  }) = _$CommunityMessagingStateImpl;

  @override
  String get communityId;
  @override
  List<Message> get messages;
  @override
  bool get isLoading;
  @override
  bool get isSending;
  @override
  bool get hasMore;
  @override
  String? get errorMessage;

  /// Create a copy of CommunityMessagingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityMessagingStateImplCopyWith<_$CommunityMessagingStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
