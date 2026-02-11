// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_inbox_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EarnInboxEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnInboxEventCopyWith<$Res> {
  factory $EarnInboxEventCopyWith(
    EarnInboxEvent value,
    $Res Function(EarnInboxEvent) then,
  ) = _$EarnInboxEventCopyWithImpl<$Res, EarnInboxEvent>;
}

/// @nodoc
class _$EarnInboxEventCopyWithImpl<$Res, $Val extends EarnInboxEvent>
    implements $EarnInboxEventCopyWith<$Res> {
  _$EarnInboxEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadInboxImplCopyWith<$Res> {
  factory _$$LoadInboxImplCopyWith(
    _$LoadInboxImpl value,
    $Res Function(_$LoadInboxImpl) then,
  ) = __$$LoadInboxImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadInboxImplCopyWithImpl<$Res>
    extends _$EarnInboxEventCopyWithImpl<$Res, _$LoadInboxImpl>
    implements _$$LoadInboxImplCopyWith<$Res> {
  __$$LoadInboxImplCopyWithImpl(
    _$LoadInboxImpl _value,
    $Res Function(_$LoadInboxImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadInboxImpl implements _LoadInbox {
  const _$LoadInboxImpl();

  @override
  String toString() {
    return 'EarnInboxEvent.loadInbox()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadInboxImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) {
    return loadInbox();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) {
    return loadInbox?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadInbox != null) {
      return loadInbox();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadInbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadInbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadInbox != null) {
      return loadInbox(this);
    }
    return orElse();
  }
}

abstract class _LoadInbox implements EarnInboxEvent {
  const factory _LoadInbox() = _$LoadInboxImpl;
}

/// @nodoc
abstract class _$$RefreshInboxImplCopyWith<$Res> {
  factory _$$RefreshInboxImplCopyWith(
    _$RefreshInboxImpl value,
    $Res Function(_$RefreshInboxImpl) then,
  ) = __$$RefreshInboxImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshInboxImplCopyWithImpl<$Res>
    extends _$EarnInboxEventCopyWithImpl<$Res, _$RefreshInboxImpl>
    implements _$$RefreshInboxImplCopyWith<$Res> {
  __$$RefreshInboxImplCopyWithImpl(
    _$RefreshInboxImpl _value,
    $Res Function(_$RefreshInboxImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshInboxImpl implements _RefreshInbox {
  const _$RefreshInboxImpl();

  @override
  String toString() {
    return 'EarnInboxEvent.refreshInbox()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshInboxImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) {
    return refreshInbox();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) {
    return refreshInbox?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (refreshInbox != null) {
      return refreshInbox();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) {
    return refreshInbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return refreshInbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (refreshInbox != null) {
      return refreshInbox(this);
    }
    return orElse();
  }
}

abstract class _RefreshInbox implements EarnInboxEvent {
  const factory _RefreshInbox() = _$RefreshInboxImpl;
}

/// @nodoc
abstract class _$$ToggleClientImplCopyWith<$Res> {
  factory _$$ToggleClientImplCopyWith(
    _$ToggleClientImpl value,
    $Res Function(_$ToggleClientImpl) then,
  ) = __$$ToggleClientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId});
}

/// @nodoc
class __$$ToggleClientImplCopyWithImpl<$Res>
    extends _$EarnInboxEventCopyWithImpl<$Res, _$ToggleClientImpl>
    implements _$$ToggleClientImplCopyWith<$Res> {
  __$$ToggleClientImplCopyWithImpl(
    _$ToggleClientImpl _value,
    $Res Function(_$ToggleClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = null}) {
    return _then(
      _$ToggleClientImpl(
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ToggleClientImpl implements _ToggleClient {
  const _$ToggleClientImpl({required this.clientId});

  @override
  final String clientId;

  @override
  String toString() {
    return 'EarnInboxEvent.toggleClient(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleClientImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleClientImplCopyWith<_$ToggleClientImpl> get copyWith =>
      __$$ToggleClientImplCopyWithImpl<_$ToggleClientImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) {
    return toggleClient(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) {
    return toggleClient?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (toggleClient != null) {
      return toggleClient(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) {
    return toggleClient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return toggleClient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (toggleClient != null) {
      return toggleClient(this);
    }
    return orElse();
  }
}

abstract class _ToggleClient implements EarnInboxEvent {
  const factory _ToggleClient({required final String clientId}) =
      _$ToggleClientImpl;

  String get clientId;

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleClientImplCopyWith<_$ToggleClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNotificationsImplCopyWith<$Res> {
  factory _$$LoadNotificationsImplCopyWith(
    _$LoadNotificationsImpl value,
    $Res Function(_$LoadNotificationsImpl) then,
  ) = __$$LoadNotificationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNotificationsImplCopyWithImpl<$Res>
    extends _$EarnInboxEventCopyWithImpl<$Res, _$LoadNotificationsImpl>
    implements _$$LoadNotificationsImplCopyWith<$Res> {
  __$$LoadNotificationsImplCopyWithImpl(
    _$LoadNotificationsImpl _value,
    $Res Function(_$LoadNotificationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNotificationsImpl implements _LoadNotifications {
  const _$LoadNotificationsImpl();

  @override
  String toString() {
    return 'EarnInboxEvent.loadNotifications()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadNotificationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) {
    return loadNotifications();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) {
    return loadNotifications?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadNotifications != null) {
      return loadNotifications();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadNotifications(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadNotifications?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadNotifications != null) {
      return loadNotifications(this);
    }
    return orElse();
  }
}

abstract class _LoadNotifications implements EarnInboxEvent {
  const factory _LoadNotifications() = _$LoadNotificationsImpl;
}

/// @nodoc
abstract class _$$MarkNotificationReadImplCopyWith<$Res> {
  factory _$$MarkNotificationReadImplCopyWith(
    _$MarkNotificationReadImpl value,
    $Res Function(_$MarkNotificationReadImpl) then,
  ) = __$$MarkNotificationReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String notificationId});
}

/// @nodoc
class __$$MarkNotificationReadImplCopyWithImpl<$Res>
    extends _$EarnInboxEventCopyWithImpl<$Res, _$MarkNotificationReadImpl>
    implements _$$MarkNotificationReadImplCopyWith<$Res> {
  __$$MarkNotificationReadImplCopyWithImpl(
    _$MarkNotificationReadImpl _value,
    $Res Function(_$MarkNotificationReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notificationId = null}) {
    return _then(
      _$MarkNotificationReadImpl(
        notificationId: null == notificationId
            ? _value.notificationId
            : notificationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MarkNotificationReadImpl implements _MarkNotificationRead {
  const _$MarkNotificationReadImpl({required this.notificationId});

  @override
  final String notificationId;

  @override
  String toString() {
    return 'EarnInboxEvent.markNotificationRead(notificationId: $notificationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkNotificationReadImpl &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, notificationId);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkNotificationReadImplCopyWith<_$MarkNotificationReadImpl>
  get copyWith =>
      __$$MarkNotificationReadImplCopyWithImpl<_$MarkNotificationReadImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) {
    return markNotificationRead(notificationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) {
    return markNotificationRead?.call(notificationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (markNotificationRead != null) {
      return markNotificationRead(notificationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) {
    return markNotificationRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return markNotificationRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (markNotificationRead != null) {
      return markNotificationRead(this);
    }
    return orElse();
  }
}

abstract class _MarkNotificationRead implements EarnInboxEvent {
  const factory _MarkNotificationRead({required final String notificationId}) =
      _$MarkNotificationReadImpl;

  String get notificationId;

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkNotificationReadImplCopyWith<_$MarkNotificationReadImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAllNotificationsReadImplCopyWith<$Res> {
  factory _$$MarkAllNotificationsReadImplCopyWith(
    _$MarkAllNotificationsReadImpl value,
    $Res Function(_$MarkAllNotificationsReadImpl) then,
  ) = __$$MarkAllNotificationsReadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MarkAllNotificationsReadImplCopyWithImpl<$Res>
    extends _$EarnInboxEventCopyWithImpl<$Res, _$MarkAllNotificationsReadImpl>
    implements _$$MarkAllNotificationsReadImplCopyWith<$Res> {
  __$$MarkAllNotificationsReadImplCopyWithImpl(
    _$MarkAllNotificationsReadImpl _value,
    $Res Function(_$MarkAllNotificationsReadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MarkAllNotificationsReadImpl implements _MarkAllNotificationsRead {
  const _$MarkAllNotificationsReadImpl();

  @override
  String toString() {
    return 'EarnInboxEvent.markAllNotificationsRead()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAllNotificationsReadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) {
    return markAllNotificationsRead();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) {
    return markAllNotificationsRead?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (markAllNotificationsRead != null) {
      return markAllNotificationsRead();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) {
    return markAllNotificationsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return markAllNotificationsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (markAllNotificationsRead != null) {
      return markAllNotificationsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAllNotificationsRead implements EarnInboxEvent {
  const factory _MarkAllNotificationsRead() = _$MarkAllNotificationsReadImpl;
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
    extends _$EarnInboxEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'EarnInboxEvent.clearError()';
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
    required TResult Function() loadInbox,
    required TResult Function() refreshInbox,
    required TResult Function(String clientId) toggleClient,
    required TResult Function() loadNotifications,
    required TResult Function(String notificationId) markNotificationRead,
    required TResult Function() markAllNotificationsRead,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInbox,
    TResult? Function()? refreshInbox,
    TResult? Function(String clientId)? toggleClient,
    TResult? Function()? loadNotifications,
    TResult? Function(String notificationId)? markNotificationRead,
    TResult? Function()? markAllNotificationsRead,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInbox,
    TResult Function()? refreshInbox,
    TResult Function(String clientId)? toggleClient,
    TResult Function()? loadNotifications,
    TResult Function(String notificationId)? markNotificationRead,
    TResult Function()? markAllNotificationsRead,
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
    required TResult Function(_LoadInbox value) loadInbox,
    required TResult Function(_RefreshInbox value) refreshInbox,
    required TResult Function(_ToggleClient value) toggleClient,
    required TResult Function(_LoadNotifications value) loadNotifications,
    required TResult Function(_MarkNotificationRead value) markNotificationRead,
    required TResult Function(_MarkAllNotificationsRead value)
    markAllNotificationsRead,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInbox value)? loadInbox,
    TResult? Function(_RefreshInbox value)? refreshInbox,
    TResult? Function(_ToggleClient value)? toggleClient,
    TResult? Function(_LoadNotifications value)? loadNotifications,
    TResult? Function(_MarkNotificationRead value)? markNotificationRead,
    TResult? Function(_MarkAllNotificationsRead value)?
    markAllNotificationsRead,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInbox value)? loadInbox,
    TResult Function(_RefreshInbox value)? refreshInbox,
    TResult Function(_ToggleClient value)? toggleClient,
    TResult Function(_LoadNotifications value)? loadNotifications,
    TResult Function(_MarkNotificationRead value)? markNotificationRead,
    TResult Function(_MarkAllNotificationsRead value)? markAllNotificationsRead,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements EarnInboxEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
mixin _$EarnInboxState {
  EarnInboxStatus get status => throw _privateConstructorUsedError;
  List<InboxClient> get clients => throw _privateConstructorUsedError;
  String? get expandedClientId => throw _privateConstructorUsedError;
  List<EarnNotification> get notifications =>
      throw _privateConstructorUsedError;
  int get unreadNotificationCount => throw _privateConstructorUsedError;
  bool get isLoadingNotifications => throw _privateConstructorUsedError;
  int get dailyCompletions => throw _privateConstructorUsedError;
  int get dailyEarnCap => throw _privateConstructorUsedError;
  bool get dailyLimitReached => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of EarnInboxState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarnInboxStateCopyWith<EarnInboxState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnInboxStateCopyWith<$Res> {
  factory $EarnInboxStateCopyWith(
    EarnInboxState value,
    $Res Function(EarnInboxState) then,
  ) = _$EarnInboxStateCopyWithImpl<$Res, EarnInboxState>;
  @useResult
  $Res call({
    EarnInboxStatus status,
    List<InboxClient> clients,
    String? expandedClientId,
    List<EarnNotification> notifications,
    int unreadNotificationCount,
    bool isLoadingNotifications,
    int dailyCompletions,
    int dailyEarnCap,
    bool dailyLimitReached,
    String? errorMessage,
  });
}

/// @nodoc
class _$EarnInboxStateCopyWithImpl<$Res, $Val extends EarnInboxState>
    implements $EarnInboxStateCopyWith<$Res> {
  _$EarnInboxStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnInboxState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? clients = null,
    Object? expandedClientId = freezed,
    Object? notifications = null,
    Object? unreadNotificationCount = null,
    Object? isLoadingNotifications = null,
    Object? dailyCompletions = null,
    Object? dailyEarnCap = null,
    Object? dailyLimitReached = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as EarnInboxStatus,
            clients: null == clients
                ? _value.clients
                : clients // ignore: cast_nullable_to_non_nullable
                      as List<InboxClient>,
            expandedClientId: freezed == expandedClientId
                ? _value.expandedClientId
                : expandedClientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            notifications: null == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as List<EarnNotification>,
            unreadNotificationCount: null == unreadNotificationCount
                ? _value.unreadNotificationCount
                : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isLoadingNotifications: null == isLoadingNotifications
                ? _value.isLoadingNotifications
                : isLoadingNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            dailyCompletions: null == dailyCompletions
                ? _value.dailyCompletions
                : dailyCompletions // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyEarnCap: null == dailyEarnCap
                ? _value.dailyEarnCap
                : dailyEarnCap // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyLimitReached: null == dailyLimitReached
                ? _value.dailyLimitReached
                : dailyLimitReached // ignore: cast_nullable_to_non_nullable
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
abstract class _$$EarnInboxStateImplCopyWith<$Res>
    implements $EarnInboxStateCopyWith<$Res> {
  factory _$$EarnInboxStateImplCopyWith(
    _$EarnInboxStateImpl value,
    $Res Function(_$EarnInboxStateImpl) then,
  ) = __$$EarnInboxStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EarnInboxStatus status,
    List<InboxClient> clients,
    String? expandedClientId,
    List<EarnNotification> notifications,
    int unreadNotificationCount,
    bool isLoadingNotifications,
    int dailyCompletions,
    int dailyEarnCap,
    bool dailyLimitReached,
    String? errorMessage,
  });
}

/// @nodoc
class __$$EarnInboxStateImplCopyWithImpl<$Res>
    extends _$EarnInboxStateCopyWithImpl<$Res, _$EarnInboxStateImpl>
    implements _$$EarnInboxStateImplCopyWith<$Res> {
  __$$EarnInboxStateImplCopyWithImpl(
    _$EarnInboxStateImpl _value,
    $Res Function(_$EarnInboxStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnInboxState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? clients = null,
    Object? expandedClientId = freezed,
    Object? notifications = null,
    Object? unreadNotificationCount = null,
    Object? isLoadingNotifications = null,
    Object? dailyCompletions = null,
    Object? dailyEarnCap = null,
    Object? dailyLimitReached = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$EarnInboxStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as EarnInboxStatus,
        clients: null == clients
            ? _value._clients
            : clients // ignore: cast_nullable_to_non_nullable
                  as List<InboxClient>,
        expandedClientId: freezed == expandedClientId
            ? _value.expandedClientId
            : expandedClientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        notifications: null == notifications
            ? _value._notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as List<EarnNotification>,
        unreadNotificationCount: null == unreadNotificationCount
            ? _value.unreadNotificationCount
            : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoadingNotifications: null == isLoadingNotifications
            ? _value.isLoadingNotifications
            : isLoadingNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        dailyCompletions: null == dailyCompletions
            ? _value.dailyCompletions
            : dailyCompletions // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyEarnCap: null == dailyEarnCap
            ? _value.dailyEarnCap
            : dailyEarnCap // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyLimitReached: null == dailyLimitReached
            ? _value.dailyLimitReached
            : dailyLimitReached // ignore: cast_nullable_to_non_nullable
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

class _$EarnInboxStateImpl extends _EarnInboxState {
  const _$EarnInboxStateImpl({
    this.status = EarnInboxStatus.initial,
    final List<InboxClient> clients = const [],
    this.expandedClientId,
    final List<EarnNotification> notifications = const [],
    this.unreadNotificationCount = 0,
    this.isLoadingNotifications = false,
    this.dailyCompletions = 0,
    this.dailyEarnCap = 30,
    this.dailyLimitReached = false,
    this.errorMessage,
  }) : _clients = clients,
       _notifications = notifications,
       super._();

  @override
  @JsonKey()
  final EarnInboxStatus status;
  final List<InboxClient> _clients;
  @override
  @JsonKey()
  List<InboxClient> get clients {
    if (_clients is EqualUnmodifiableListView) return _clients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clients);
  }

  @override
  final String? expandedClientId;
  final List<EarnNotification> _notifications;
  @override
  @JsonKey()
  List<EarnNotification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  @JsonKey()
  final int unreadNotificationCount;
  @override
  @JsonKey()
  final bool isLoadingNotifications;
  @override
  @JsonKey()
  final int dailyCompletions;
  @override
  @JsonKey()
  final int dailyEarnCap;
  @override
  @JsonKey()
  final bool dailyLimitReached;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'EarnInboxState(status: $status, clients: $clients, expandedClientId: $expandedClientId, notifications: $notifications, unreadNotificationCount: $unreadNotificationCount, isLoadingNotifications: $isLoadingNotifications, dailyCompletions: $dailyCompletions, dailyEarnCap: $dailyEarnCap, dailyLimitReached: $dailyLimitReached, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarnInboxStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            (identical(other.expandedClientId, expandedClientId) ||
                other.expandedClientId == expandedClientId) &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(
                  other.unreadNotificationCount,
                  unreadNotificationCount,
                ) ||
                other.unreadNotificationCount == unreadNotificationCount) &&
            (identical(other.isLoadingNotifications, isLoadingNotifications) ||
                other.isLoadingNotifications == isLoadingNotifications) &&
            (identical(other.dailyCompletions, dailyCompletions) ||
                other.dailyCompletions == dailyCompletions) &&
            (identical(other.dailyEarnCap, dailyEarnCap) ||
                other.dailyEarnCap == dailyEarnCap) &&
            (identical(other.dailyLimitReached, dailyLimitReached) ||
                other.dailyLimitReached == dailyLimitReached) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_clients),
    expandedClientId,
    const DeepCollectionEquality().hash(_notifications),
    unreadNotificationCount,
    isLoadingNotifications,
    dailyCompletions,
    dailyEarnCap,
    dailyLimitReached,
    errorMessage,
  );

  /// Create a copy of EarnInboxState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarnInboxStateImplCopyWith<_$EarnInboxStateImpl> get copyWith =>
      __$$EarnInboxStateImplCopyWithImpl<_$EarnInboxStateImpl>(
        this,
        _$identity,
      );
}

abstract class _EarnInboxState extends EarnInboxState {
  const factory _EarnInboxState({
    final EarnInboxStatus status,
    final List<InboxClient> clients,
    final String? expandedClientId,
    final List<EarnNotification> notifications,
    final int unreadNotificationCount,
    final bool isLoadingNotifications,
    final int dailyCompletions,
    final int dailyEarnCap,
    final bool dailyLimitReached,
    final String? errorMessage,
  }) = _$EarnInboxStateImpl;
  const _EarnInboxState._() : super._();

  @override
  EarnInboxStatus get status;
  @override
  List<InboxClient> get clients;
  @override
  String? get expandedClientId;
  @override
  List<EarnNotification> get notifications;
  @override
  int get unreadNotificationCount;
  @override
  bool get isLoadingNotifications;
  @override
  int get dailyCompletions;
  @override
  int get dailyEarnCap;
  @override
  bool get dailyLimitReached;
  @override
  String? get errorMessage;

  /// Create a copy of EarnInboxState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarnInboxStateImplCopyWith<_$EarnInboxStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
