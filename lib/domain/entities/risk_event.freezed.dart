// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RiskEvent {

 String get eventId; String get userId; RiskEventType get type; RiskSeverity get severity; RiskEventStatus get status; DateTime get createdAt; String? get deviceId; String? get details; DateTime? get resolvedAt;
/// Create a copy of RiskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiskEventCopyWith<RiskEvent> get copyWith => _$RiskEventCopyWithImpl<RiskEvent>(this as RiskEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiskEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.details, details) || other.details == details)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,userId,type,severity,status,createdAt,deviceId,details,resolvedAt);

@override
String toString() {
  return 'RiskEvent(eventId: $eventId, userId: $userId, type: $type, severity: $severity, status: $status, createdAt: $createdAt, deviceId: $deviceId, details: $details, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $RiskEventCopyWith<$Res>  {
  factory $RiskEventCopyWith(RiskEvent value, $Res Function(RiskEvent) _then) = _$RiskEventCopyWithImpl;
@useResult
$Res call({
 String eventId, String userId, RiskEventType type, RiskSeverity severity, RiskEventStatus status, DateTime createdAt, String? deviceId, String? details, DateTime? resolvedAt
});




}
/// @nodoc
class _$RiskEventCopyWithImpl<$Res>
    implements $RiskEventCopyWith<$Res> {
  _$RiskEventCopyWithImpl(this._self, this._then);

  final RiskEvent _self;
  final $Res Function(RiskEvent) _then;

/// Create a copy of RiskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? userId = null,Object? type = null,Object? severity = null,Object? status = null,Object? createdAt = null,Object? deviceId = freezed,Object? details = freezed,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RiskEventType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as RiskSeverity,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RiskEventStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RiskEvent].
extension RiskEventPatterns on RiskEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiskEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiskEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiskEvent value)  $default,){
final _that = this;
switch (_that) {
case _RiskEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiskEvent value)?  $default,){
final _that = this;
switch (_that) {
case _RiskEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String userId,  RiskEventType type,  RiskSeverity severity,  RiskEventStatus status,  DateTime createdAt,  String? deviceId,  String? details,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiskEvent() when $default != null:
return $default(_that.eventId,_that.userId,_that.type,_that.severity,_that.status,_that.createdAt,_that.deviceId,_that.details,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String userId,  RiskEventType type,  RiskSeverity severity,  RiskEventStatus status,  DateTime createdAt,  String? deviceId,  String? details,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _RiskEvent():
return $default(_that.eventId,_that.userId,_that.type,_that.severity,_that.status,_that.createdAt,_that.deviceId,_that.details,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String userId,  RiskEventType type,  RiskSeverity severity,  RiskEventStatus status,  DateTime createdAt,  String? deviceId,  String? details,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _RiskEvent() when $default != null:
return $default(_that.eventId,_that.userId,_that.type,_that.severity,_that.status,_that.createdAt,_that.deviceId,_that.details,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc


class _RiskEvent extends RiskEvent {
  const _RiskEvent({required this.eventId, required this.userId, required this.type, required this.severity, required this.status, required this.createdAt, this.deviceId, this.details, this.resolvedAt}): super._();
  

@override final  String eventId;
@override final  String userId;
@override final  RiskEventType type;
@override final  RiskSeverity severity;
@override final  RiskEventStatus status;
@override final  DateTime createdAt;
@override final  String? deviceId;
@override final  String? details;
@override final  DateTime? resolvedAt;

/// Create a copy of RiskEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiskEventCopyWith<_RiskEvent> get copyWith => __$RiskEventCopyWithImpl<_RiskEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiskEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.details, details) || other.details == details)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,userId,type,severity,status,createdAt,deviceId,details,resolvedAt);

@override
String toString() {
  return 'RiskEvent(eventId: $eventId, userId: $userId, type: $type, severity: $severity, status: $status, createdAt: $createdAt, deviceId: $deviceId, details: $details, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$RiskEventCopyWith<$Res> implements $RiskEventCopyWith<$Res> {
  factory _$RiskEventCopyWith(_RiskEvent value, $Res Function(_RiskEvent) _then) = __$RiskEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String userId, RiskEventType type, RiskSeverity severity, RiskEventStatus status, DateTime createdAt, String? deviceId, String? details, DateTime? resolvedAt
});




}
/// @nodoc
class __$RiskEventCopyWithImpl<$Res>
    implements _$RiskEventCopyWith<$Res> {
  __$RiskEventCopyWithImpl(this._self, this._then);

  final _RiskEvent _self;
  final $Res Function(_RiskEvent) _then;

/// Create a copy of RiskEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? userId = null,Object? type = null,Object? severity = null,Object? status = null,Object? createdAt = null,Object? deviceId = freezed,Object? details = freezed,Object? resolvedAt = freezed,}) {
  return _then(_RiskEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RiskEventType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as RiskSeverity,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RiskEventStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
