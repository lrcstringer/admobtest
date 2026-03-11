// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_inbox_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarnInboxEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnInboxEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnInboxEvent()';
}


}

/// @nodoc
class $EarnInboxEventCopyWith<$Res>  {
$EarnInboxEventCopyWith(EarnInboxEvent _, $Res Function(EarnInboxEvent) __);
}


/// Adds pattern-matching-related methods to [EarnInboxEvent].
extension EarnInboxEventPatterns on EarnInboxEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadInbox value)?  loadInbox,TResult Function( _RefreshInbox value)?  refreshInbox,TResult Function( _ToggleClient value)?  toggleClient,TResult Function( _LoadNotifications value)?  loadNotifications,TResult Function( _MarkNotificationRead value)?  markNotificationRead,TResult Function( _MarkAllNotificationsRead value)?  markAllNotificationsRead,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadInbox() when loadInbox != null:
return loadInbox(_that);case _RefreshInbox() when refreshInbox != null:
return refreshInbox(_that);case _ToggleClient() when toggleClient != null:
return toggleClient(_that);case _LoadNotifications() when loadNotifications != null:
return loadNotifications(_that);case _MarkNotificationRead() when markNotificationRead != null:
return markNotificationRead(_that);case _MarkAllNotificationsRead() when markAllNotificationsRead != null:
return markAllNotificationsRead(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadInbox value)  loadInbox,required TResult Function( _RefreshInbox value)  refreshInbox,required TResult Function( _ToggleClient value)  toggleClient,required TResult Function( _LoadNotifications value)  loadNotifications,required TResult Function( _MarkNotificationRead value)  markNotificationRead,required TResult Function( _MarkAllNotificationsRead value)  markAllNotificationsRead,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _LoadInbox():
return loadInbox(_that);case _RefreshInbox():
return refreshInbox(_that);case _ToggleClient():
return toggleClient(_that);case _LoadNotifications():
return loadNotifications(_that);case _MarkNotificationRead():
return markNotificationRead(_that);case _MarkAllNotificationsRead():
return markAllNotificationsRead(_that);case _ClearError():
return clearError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadInbox value)?  loadInbox,TResult? Function( _RefreshInbox value)?  refreshInbox,TResult? Function( _ToggleClient value)?  toggleClient,TResult? Function( _LoadNotifications value)?  loadNotifications,TResult? Function( _MarkNotificationRead value)?  markNotificationRead,TResult? Function( _MarkAllNotificationsRead value)?  markAllNotificationsRead,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _LoadInbox() when loadInbox != null:
return loadInbox(_that);case _RefreshInbox() when refreshInbox != null:
return refreshInbox(_that);case _ToggleClient() when toggleClient != null:
return toggleClient(_that);case _LoadNotifications() when loadNotifications != null:
return loadNotifications(_that);case _MarkNotificationRead() when markNotificationRead != null:
return markNotificationRead(_that);case _MarkAllNotificationsRead() when markAllNotificationsRead != null:
return markAllNotificationsRead(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadInbox,TResult Function()?  refreshInbox,TResult Function( String clientId)?  toggleClient,TResult Function()?  loadNotifications,TResult Function( String notificationId)?  markNotificationRead,TResult Function()?  markAllNotificationsRead,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadInbox() when loadInbox != null:
return loadInbox();case _RefreshInbox() when refreshInbox != null:
return refreshInbox();case _ToggleClient() when toggleClient != null:
return toggleClient(_that.clientId);case _LoadNotifications() when loadNotifications != null:
return loadNotifications();case _MarkNotificationRead() when markNotificationRead != null:
return markNotificationRead(_that.notificationId);case _MarkAllNotificationsRead() when markAllNotificationsRead != null:
return markAllNotificationsRead();case _ClearError() when clearError != null:
return clearError();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadInbox,required TResult Function()  refreshInbox,required TResult Function( String clientId)  toggleClient,required TResult Function()  loadNotifications,required TResult Function( String notificationId)  markNotificationRead,required TResult Function()  markAllNotificationsRead,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _LoadInbox():
return loadInbox();case _RefreshInbox():
return refreshInbox();case _ToggleClient():
return toggleClient(_that.clientId);case _LoadNotifications():
return loadNotifications();case _MarkNotificationRead():
return markNotificationRead(_that.notificationId);case _MarkAllNotificationsRead():
return markAllNotificationsRead();case _ClearError():
return clearError();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadInbox,TResult? Function()?  refreshInbox,TResult? Function( String clientId)?  toggleClient,TResult? Function()?  loadNotifications,TResult? Function( String notificationId)?  markNotificationRead,TResult? Function()?  markAllNotificationsRead,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _LoadInbox() when loadInbox != null:
return loadInbox();case _RefreshInbox() when refreshInbox != null:
return refreshInbox();case _ToggleClient() when toggleClient != null:
return toggleClient(_that.clientId);case _LoadNotifications() when loadNotifications != null:
return loadNotifications();case _MarkNotificationRead() when markNotificationRead != null:
return markNotificationRead(_that.notificationId);case _MarkAllNotificationsRead() when markAllNotificationsRead != null:
return markAllNotificationsRead();case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _LoadInbox implements EarnInboxEvent {
  const _LoadInbox();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadInbox);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnInboxEvent.loadInbox()';
}


}




/// @nodoc


class _RefreshInbox implements EarnInboxEvent {
  const _RefreshInbox();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshInbox);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnInboxEvent.refreshInbox()';
}


}




/// @nodoc


class _ToggleClient implements EarnInboxEvent {
  const _ToggleClient({required this.clientId});
  

 final  String clientId;

/// Create a copy of EarnInboxEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleClientCopyWith<_ToggleClient> get copyWith => __$ToggleClientCopyWithImpl<_ToggleClient>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleClient&&(identical(other.clientId, clientId) || other.clientId == clientId));
}


@override
int get hashCode => Object.hash(runtimeType,clientId);

@override
String toString() {
  return 'EarnInboxEvent.toggleClient(clientId: $clientId)';
}


}

/// @nodoc
abstract mixin class _$ToggleClientCopyWith<$Res> implements $EarnInboxEventCopyWith<$Res> {
  factory _$ToggleClientCopyWith(_ToggleClient value, $Res Function(_ToggleClient) _then) = __$ToggleClientCopyWithImpl;
@useResult
$Res call({
 String clientId
});




}
/// @nodoc
class __$ToggleClientCopyWithImpl<$Res>
    implements _$ToggleClientCopyWith<$Res> {
  __$ToggleClientCopyWithImpl(this._self, this._then);

  final _ToggleClient _self;
  final $Res Function(_ToggleClient) _then;

/// Create a copy of EarnInboxEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clientId = null,}) {
  return _then(_ToggleClient(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadNotifications implements EarnInboxEvent {
  const _LoadNotifications();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadNotifications);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnInboxEvent.loadNotifications()';
}


}




/// @nodoc


class _MarkNotificationRead implements EarnInboxEvent {
  const _MarkNotificationRead({required this.notificationId});
  

 final  String notificationId;

/// Create a copy of EarnInboxEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkNotificationReadCopyWith<_MarkNotificationRead> get copyWith => __$MarkNotificationReadCopyWithImpl<_MarkNotificationRead>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkNotificationRead&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString() {
  return 'EarnInboxEvent.markNotificationRead(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class _$MarkNotificationReadCopyWith<$Res> implements $EarnInboxEventCopyWith<$Res> {
  factory _$MarkNotificationReadCopyWith(_MarkNotificationRead value, $Res Function(_MarkNotificationRead) _then) = __$MarkNotificationReadCopyWithImpl;
@useResult
$Res call({
 String notificationId
});




}
/// @nodoc
class __$MarkNotificationReadCopyWithImpl<$Res>
    implements _$MarkNotificationReadCopyWith<$Res> {
  __$MarkNotificationReadCopyWithImpl(this._self, this._then);

  final _MarkNotificationRead _self;
  final $Res Function(_MarkNotificationRead) _then;

/// Create a copy of EarnInboxEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(_MarkNotificationRead(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MarkAllNotificationsRead implements EarnInboxEvent {
  const _MarkAllNotificationsRead();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAllNotificationsRead);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnInboxEvent.markAllNotificationsRead()';
}


}




/// @nodoc


class _ClearError implements EarnInboxEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EarnInboxEvent.clearError()';
}


}




/// @nodoc
mixin _$EarnInboxState {

 EarnInboxStatus get status; List<InboxClient> get clients; String? get expandedClientId; List<EarnNotification> get notifications; int get unreadNotificationCount; bool get isLoadingNotifications; int get dailyCompletions; int get dailyEarnCap; bool get dailyLimitReached; String? get errorMessage;
/// Create a copy of EarnInboxState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnInboxStateCopyWith<EarnInboxState> get copyWith => _$EarnInboxStateCopyWithImpl<EarnInboxState>(this as EarnInboxState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnInboxState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.clients, clients)&&(identical(other.expandedClientId, expandedClientId) || other.expandedClientId == expandedClientId)&&const DeepCollectionEquality().equals(other.notifications, notifications)&&(identical(other.unreadNotificationCount, unreadNotificationCount) || other.unreadNotificationCount == unreadNotificationCount)&&(identical(other.isLoadingNotifications, isLoadingNotifications) || other.isLoadingNotifications == isLoadingNotifications)&&(identical(other.dailyCompletions, dailyCompletions) || other.dailyCompletions == dailyCompletions)&&(identical(other.dailyEarnCap, dailyEarnCap) || other.dailyEarnCap == dailyEarnCap)&&(identical(other.dailyLimitReached, dailyLimitReached) || other.dailyLimitReached == dailyLimitReached)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(clients),expandedClientId,const DeepCollectionEquality().hash(notifications),unreadNotificationCount,isLoadingNotifications,dailyCompletions,dailyEarnCap,dailyLimitReached,errorMessage);

@override
String toString() {
  return 'EarnInboxState(status: $status, clients: $clients, expandedClientId: $expandedClientId, notifications: $notifications, unreadNotificationCount: $unreadNotificationCount, isLoadingNotifications: $isLoadingNotifications, dailyCompletions: $dailyCompletions, dailyEarnCap: $dailyEarnCap, dailyLimitReached: $dailyLimitReached, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $EarnInboxStateCopyWith<$Res>  {
  factory $EarnInboxStateCopyWith(EarnInboxState value, $Res Function(EarnInboxState) _then) = _$EarnInboxStateCopyWithImpl;
@useResult
$Res call({
 EarnInboxStatus status, List<InboxClient> clients, String? expandedClientId, List<EarnNotification> notifications, int unreadNotificationCount, bool isLoadingNotifications, int dailyCompletions, int dailyEarnCap, bool dailyLimitReached, String? errorMessage
});




}
/// @nodoc
class _$EarnInboxStateCopyWithImpl<$Res>
    implements $EarnInboxStateCopyWith<$Res> {
  _$EarnInboxStateCopyWithImpl(this._self, this._then);

  final EarnInboxState _self;
  final $Res Function(EarnInboxState) _then;

/// Create a copy of EarnInboxState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? clients = null,Object? expandedClientId = freezed,Object? notifications = null,Object? unreadNotificationCount = null,Object? isLoadingNotifications = null,Object? dailyCompletions = null,Object? dailyEarnCap = null,Object? dailyLimitReached = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarnInboxStatus,clients: null == clients ? _self.clients : clients // ignore: cast_nullable_to_non_nullable
as List<InboxClient>,expandedClientId: freezed == expandedClientId ? _self.expandedClientId : expandedClientId // ignore: cast_nullable_to_non_nullable
as String?,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<EarnNotification>,unreadNotificationCount: null == unreadNotificationCount ? _self.unreadNotificationCount : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingNotifications: null == isLoadingNotifications ? _self.isLoadingNotifications : isLoadingNotifications // ignore: cast_nullable_to_non_nullable
as bool,dailyCompletions: null == dailyCompletions ? _self.dailyCompletions : dailyCompletions // ignore: cast_nullable_to_non_nullable
as int,dailyEarnCap: null == dailyEarnCap ? _self.dailyEarnCap : dailyEarnCap // ignore: cast_nullable_to_non_nullable
as int,dailyLimitReached: null == dailyLimitReached ? _self.dailyLimitReached : dailyLimitReached // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarnInboxState].
extension EarnInboxStatePatterns on EarnInboxState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnInboxState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnInboxState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnInboxState value)  $default,){
final _that = this;
switch (_that) {
case _EarnInboxState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnInboxState value)?  $default,){
final _that = this;
switch (_that) {
case _EarnInboxState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarnInboxStatus status,  List<InboxClient> clients,  String? expandedClientId,  List<EarnNotification> notifications,  int unreadNotificationCount,  bool isLoadingNotifications,  int dailyCompletions,  int dailyEarnCap,  bool dailyLimitReached,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarnInboxState() when $default != null:
return $default(_that.status,_that.clients,_that.expandedClientId,_that.notifications,_that.unreadNotificationCount,_that.isLoadingNotifications,_that.dailyCompletions,_that.dailyEarnCap,_that.dailyLimitReached,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarnInboxStatus status,  List<InboxClient> clients,  String? expandedClientId,  List<EarnNotification> notifications,  int unreadNotificationCount,  bool isLoadingNotifications,  int dailyCompletions,  int dailyEarnCap,  bool dailyLimitReached,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _EarnInboxState():
return $default(_that.status,_that.clients,_that.expandedClientId,_that.notifications,_that.unreadNotificationCount,_that.isLoadingNotifications,_that.dailyCompletions,_that.dailyEarnCap,_that.dailyLimitReached,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarnInboxStatus status,  List<InboxClient> clients,  String? expandedClientId,  List<EarnNotification> notifications,  int unreadNotificationCount,  bool isLoadingNotifications,  int dailyCompletions,  int dailyEarnCap,  bool dailyLimitReached,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _EarnInboxState() when $default != null:
return $default(_that.status,_that.clients,_that.expandedClientId,_that.notifications,_that.unreadNotificationCount,_that.isLoadingNotifications,_that.dailyCompletions,_that.dailyEarnCap,_that.dailyLimitReached,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EarnInboxState extends EarnInboxState {
  const _EarnInboxState({this.status = EarnInboxStatus.initial, final  List<InboxClient> clients = const [], this.expandedClientId, final  List<EarnNotification> notifications = const [], this.unreadNotificationCount = 0, this.isLoadingNotifications = false, this.dailyCompletions = 0, this.dailyEarnCap = 30, this.dailyLimitReached = false, this.errorMessage}): _clients = clients,_notifications = notifications,super._();
  

@override@JsonKey() final  EarnInboxStatus status;
 final  List<InboxClient> _clients;
@override@JsonKey() List<InboxClient> get clients {
  if (_clients is EqualUnmodifiableListView) return _clients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clients);
}

@override final  String? expandedClientId;
 final  List<EarnNotification> _notifications;
@override@JsonKey() List<EarnNotification> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}

@override@JsonKey() final  int unreadNotificationCount;
@override@JsonKey() final  bool isLoadingNotifications;
@override@JsonKey() final  int dailyCompletions;
@override@JsonKey() final  int dailyEarnCap;
@override@JsonKey() final  bool dailyLimitReached;
@override final  String? errorMessage;

/// Create a copy of EarnInboxState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnInboxStateCopyWith<_EarnInboxState> get copyWith => __$EarnInboxStateCopyWithImpl<_EarnInboxState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnInboxState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._clients, _clients)&&(identical(other.expandedClientId, expandedClientId) || other.expandedClientId == expandedClientId)&&const DeepCollectionEquality().equals(other._notifications, _notifications)&&(identical(other.unreadNotificationCount, unreadNotificationCount) || other.unreadNotificationCount == unreadNotificationCount)&&(identical(other.isLoadingNotifications, isLoadingNotifications) || other.isLoadingNotifications == isLoadingNotifications)&&(identical(other.dailyCompletions, dailyCompletions) || other.dailyCompletions == dailyCompletions)&&(identical(other.dailyEarnCap, dailyEarnCap) || other.dailyEarnCap == dailyEarnCap)&&(identical(other.dailyLimitReached, dailyLimitReached) || other.dailyLimitReached == dailyLimitReached)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_clients),expandedClientId,const DeepCollectionEquality().hash(_notifications),unreadNotificationCount,isLoadingNotifications,dailyCompletions,dailyEarnCap,dailyLimitReached,errorMessage);

@override
String toString() {
  return 'EarnInboxState(status: $status, clients: $clients, expandedClientId: $expandedClientId, notifications: $notifications, unreadNotificationCount: $unreadNotificationCount, isLoadingNotifications: $isLoadingNotifications, dailyCompletions: $dailyCompletions, dailyEarnCap: $dailyEarnCap, dailyLimitReached: $dailyLimitReached, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$EarnInboxStateCopyWith<$Res> implements $EarnInboxStateCopyWith<$Res> {
  factory _$EarnInboxStateCopyWith(_EarnInboxState value, $Res Function(_EarnInboxState) _then) = __$EarnInboxStateCopyWithImpl;
@override @useResult
$Res call({
 EarnInboxStatus status, List<InboxClient> clients, String? expandedClientId, List<EarnNotification> notifications, int unreadNotificationCount, bool isLoadingNotifications, int dailyCompletions, int dailyEarnCap, bool dailyLimitReached, String? errorMessage
});




}
/// @nodoc
class __$EarnInboxStateCopyWithImpl<$Res>
    implements _$EarnInboxStateCopyWith<$Res> {
  __$EarnInboxStateCopyWithImpl(this._self, this._then);

  final _EarnInboxState _self;
  final $Res Function(_EarnInboxState) _then;

/// Create a copy of EarnInboxState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? clients = null,Object? expandedClientId = freezed,Object? notifications = null,Object? unreadNotificationCount = null,Object? isLoadingNotifications = null,Object? dailyCompletions = null,Object? dailyEarnCap = null,Object? dailyLimitReached = null,Object? errorMessage = freezed,}) {
  return _then(_EarnInboxState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarnInboxStatus,clients: null == clients ? _self._clients : clients // ignore: cast_nullable_to_non_nullable
as List<InboxClient>,expandedClientId: freezed == expandedClientId ? _self.expandedClientId : expandedClientId // ignore: cast_nullable_to_non_nullable
as String?,notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<EarnNotification>,unreadNotificationCount: null == unreadNotificationCount ? _self.unreadNotificationCount : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
as int,isLoadingNotifications: null == isLoadingNotifications ? _self.isLoadingNotifications : isLoadingNotifications // ignore: cast_nullable_to_non_nullable
as bool,dailyCompletions: null == dailyCompletions ? _self.dailyCompletions : dailyCompletions // ignore: cast_nullable_to_non_nullable
as int,dailyEarnCap: null == dailyEarnCap ? _self.dailyEarnCap : dailyEarnCap // ignore: cast_nullable_to_non_nullable
as int,dailyLimitReached: null == dailyLimitReached ? _self.dailyLimitReached : dailyLimitReached // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
