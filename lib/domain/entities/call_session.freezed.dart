// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallSession {

 String get callId; String get conversationId; String get callerId; String get calleeId; String get callerName; String? get callerAvatarUrl; CallType get callType; CallStatus get status;/// SDP offer from the caller: {type, sdp}.
 Map<String, String>? get offer;/// SDP answer from the callee: {type, sdp}.
 Map<String, String>? get answer;/// Video upgrade request state: 'pending' | 'accepted' | 'declined'.
 String? get videoUpgradeRequest; String? get videoUpgradeRequesterId; DateTime? get createdAt; DateTime? get answeredAt; DateTime? get endedAt; String? get endReason; int? get durationSeconds;
/// Create a copy of CallSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallSessionCopyWith<CallSession> get copyWith => _$CallSessionCopyWithImpl<CallSession>(this as CallSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallSession&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatarUrl, callerAvatarUrl) || other.callerAvatarUrl == callerAvatarUrl)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.offer, offer)&&const DeepCollectionEquality().equals(other.answer, answer)&&(identical(other.videoUpgradeRequest, videoUpgradeRequest) || other.videoUpgradeRequest == videoUpgradeRequest)&&(identical(other.videoUpgradeRequesterId, videoUpgradeRequesterId) || other.videoUpgradeRequesterId == videoUpgradeRequesterId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.endReason, endReason) || other.endReason == endReason)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,callId,conversationId,callerId,calleeId,callerName,callerAvatarUrl,callType,status,const DeepCollectionEquality().hash(offer),const DeepCollectionEquality().hash(answer),videoUpgradeRequest,videoUpgradeRequesterId,createdAt,answeredAt,endedAt,endReason,durationSeconds);

@override
String toString() {
  return 'CallSession(callId: $callId, conversationId: $conversationId, callerId: $callerId, calleeId: $calleeId, callerName: $callerName, callerAvatarUrl: $callerAvatarUrl, callType: $callType, status: $status, offer: $offer, answer: $answer, videoUpgradeRequest: $videoUpgradeRequest, videoUpgradeRequesterId: $videoUpgradeRequesterId, createdAt: $createdAt, answeredAt: $answeredAt, endedAt: $endedAt, endReason: $endReason, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallSessionCopyWith<$Res>  {
  factory $CallSessionCopyWith(CallSession value, $Res Function(CallSession) _then) = _$CallSessionCopyWithImpl;
@useResult
$Res call({
 String callId, String conversationId, String callerId, String calleeId, String callerName, String? callerAvatarUrl, CallType callType, CallStatus status, Map<String, String>? offer, Map<String, String>? answer, String? videoUpgradeRequest, String? videoUpgradeRequesterId, DateTime? createdAt, DateTime? answeredAt, DateTime? endedAt, String? endReason, int? durationSeconds
});




}
/// @nodoc
class _$CallSessionCopyWithImpl<$Res>
    implements $CallSessionCopyWith<$Res> {
  _$CallSessionCopyWithImpl(this._self, this._then);

  final CallSession _self;
  final $Res Function(CallSession) _then;

/// Create a copy of CallSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? conversationId = null,Object? callerId = null,Object? calleeId = null,Object? callerName = null,Object? callerAvatarUrl = freezed,Object? callType = null,Object? status = null,Object? offer = freezed,Object? answer = freezed,Object? videoUpgradeRequest = freezed,Object? videoUpgradeRequesterId = freezed,Object? createdAt = freezed,Object? answeredAt = freezed,Object? endedAt = freezed,Object? endReason = freezed,Object? durationSeconds = freezed,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String,calleeId: null == calleeId ? _self.calleeId : calleeId // ignore: cast_nullable_to_non_nullable
as String,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatarUrl: freezed == callerAvatarUrl ? _self.callerAvatarUrl : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,offer: freezed == offer ? _self.offer : offer // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,videoUpgradeRequest: freezed == videoUpgradeRequest ? _self.videoUpgradeRequest : videoUpgradeRequest // ignore: cast_nullable_to_non_nullable
as String?,videoUpgradeRequesterId: freezed == videoUpgradeRequesterId ? _self.videoUpgradeRequesterId : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,answeredAt: freezed == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endReason: freezed == endReason ? _self.endReason : endReason // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallSession].
extension CallSessionPatterns on CallSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallSession value)  $default,){
final _that = this;
switch (_that) {
case _CallSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallSession value)?  $default,){
final _that = this;
switch (_that) {
case _CallSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  String conversationId,  String callerId,  String calleeId,  String callerName,  String? callerAvatarUrl,  CallType callType,  CallStatus status,  Map<String, String>? offer,  Map<String, String>? answer,  String? videoUpgradeRequest,  String? videoUpgradeRequesterId,  DateTime? createdAt,  DateTime? answeredAt,  DateTime? endedAt,  String? endReason,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallSession() when $default != null:
return $default(_that.callId,_that.conversationId,_that.callerId,_that.calleeId,_that.callerName,_that.callerAvatarUrl,_that.callType,_that.status,_that.offer,_that.answer,_that.videoUpgradeRequest,_that.videoUpgradeRequesterId,_that.createdAt,_that.answeredAt,_that.endedAt,_that.endReason,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  String conversationId,  String callerId,  String calleeId,  String callerName,  String? callerAvatarUrl,  CallType callType,  CallStatus status,  Map<String, String>? offer,  Map<String, String>? answer,  String? videoUpgradeRequest,  String? videoUpgradeRequesterId,  DateTime? createdAt,  DateTime? answeredAt,  DateTime? endedAt,  String? endReason,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallSession():
return $default(_that.callId,_that.conversationId,_that.callerId,_that.calleeId,_that.callerName,_that.callerAvatarUrl,_that.callType,_that.status,_that.offer,_that.answer,_that.videoUpgradeRequest,_that.videoUpgradeRequesterId,_that.createdAt,_that.answeredAt,_that.endedAt,_that.endReason,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  String conversationId,  String callerId,  String calleeId,  String callerName,  String? callerAvatarUrl,  CallType callType,  CallStatus status,  Map<String, String>? offer,  Map<String, String>? answer,  String? videoUpgradeRequest,  String? videoUpgradeRequesterId,  DateTime? createdAt,  DateTime? answeredAt,  DateTime? endedAt,  String? endReason,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallSession() when $default != null:
return $default(_that.callId,_that.conversationId,_that.callerId,_that.calleeId,_that.callerName,_that.callerAvatarUrl,_that.callType,_that.status,_that.offer,_that.answer,_that.videoUpgradeRequest,_that.videoUpgradeRequesterId,_that.createdAt,_that.answeredAt,_that.endedAt,_that.endReason,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _CallSession implements CallSession {
  const _CallSession({required this.callId, required this.conversationId, required this.callerId, required this.calleeId, required this.callerName, this.callerAvatarUrl, required this.callType, required this.status, final  Map<String, String>? offer, final  Map<String, String>? answer, this.videoUpgradeRequest, this.videoUpgradeRequesterId, this.createdAt, this.answeredAt, this.endedAt, this.endReason, this.durationSeconds}): _offer = offer,_answer = answer;
  

@override final  String callId;
@override final  String conversationId;
@override final  String callerId;
@override final  String calleeId;
@override final  String callerName;
@override final  String? callerAvatarUrl;
@override final  CallType callType;
@override final  CallStatus status;
/// SDP offer from the caller: {type, sdp}.
 final  Map<String, String>? _offer;
/// SDP offer from the caller: {type, sdp}.
@override Map<String, String>? get offer {
  final value = _offer;
  if (value == null) return null;
  if (_offer is EqualUnmodifiableMapView) return _offer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// SDP answer from the callee: {type, sdp}.
 final  Map<String, String>? _answer;
/// SDP answer from the callee: {type, sdp}.
@override Map<String, String>? get answer {
  final value = _answer;
  if (value == null) return null;
  if (_answer is EqualUnmodifiableMapView) return _answer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Video upgrade request state: 'pending' | 'accepted' | 'declined'.
@override final  String? videoUpgradeRequest;
@override final  String? videoUpgradeRequesterId;
@override final  DateTime? createdAt;
@override final  DateTime? answeredAt;
@override final  DateTime? endedAt;
@override final  String? endReason;
@override final  int? durationSeconds;

/// Create a copy of CallSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallSessionCopyWith<_CallSession> get copyWith => __$CallSessionCopyWithImpl<_CallSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallSession&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatarUrl, callerAvatarUrl) || other.callerAvatarUrl == callerAvatarUrl)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._offer, _offer)&&const DeepCollectionEquality().equals(other._answer, _answer)&&(identical(other.videoUpgradeRequest, videoUpgradeRequest) || other.videoUpgradeRequest == videoUpgradeRequest)&&(identical(other.videoUpgradeRequesterId, videoUpgradeRequesterId) || other.videoUpgradeRequesterId == videoUpgradeRequesterId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.endReason, endReason) || other.endReason == endReason)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,callId,conversationId,callerId,calleeId,callerName,callerAvatarUrl,callType,status,const DeepCollectionEquality().hash(_offer),const DeepCollectionEquality().hash(_answer),videoUpgradeRequest,videoUpgradeRequesterId,createdAt,answeredAt,endedAt,endReason,durationSeconds);

@override
String toString() {
  return 'CallSession(callId: $callId, conversationId: $conversationId, callerId: $callerId, calleeId: $calleeId, callerName: $callerName, callerAvatarUrl: $callerAvatarUrl, callType: $callType, status: $status, offer: $offer, answer: $answer, videoUpgradeRequest: $videoUpgradeRequest, videoUpgradeRequesterId: $videoUpgradeRequesterId, createdAt: $createdAt, answeredAt: $answeredAt, endedAt: $endedAt, endReason: $endReason, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallSessionCopyWith<$Res> implements $CallSessionCopyWith<$Res> {
  factory _$CallSessionCopyWith(_CallSession value, $Res Function(_CallSession) _then) = __$CallSessionCopyWithImpl;
@override @useResult
$Res call({
 String callId, String conversationId, String callerId, String calleeId, String callerName, String? callerAvatarUrl, CallType callType, CallStatus status, Map<String, String>? offer, Map<String, String>? answer, String? videoUpgradeRequest, String? videoUpgradeRequesterId, DateTime? createdAt, DateTime? answeredAt, DateTime? endedAt, String? endReason, int? durationSeconds
});




}
/// @nodoc
class __$CallSessionCopyWithImpl<$Res>
    implements _$CallSessionCopyWith<$Res> {
  __$CallSessionCopyWithImpl(this._self, this._then);

  final _CallSession _self;
  final $Res Function(_CallSession) _then;

/// Create a copy of CallSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? conversationId = null,Object? callerId = null,Object? calleeId = null,Object? callerName = null,Object? callerAvatarUrl = freezed,Object? callType = null,Object? status = null,Object? offer = freezed,Object? answer = freezed,Object? videoUpgradeRequest = freezed,Object? videoUpgradeRequesterId = freezed,Object? createdAt = freezed,Object? answeredAt = freezed,Object? endedAt = freezed,Object? endReason = freezed,Object? durationSeconds = freezed,}) {
  return _then(_CallSession(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String,calleeId: null == calleeId ? _self.calleeId : calleeId // ignore: cast_nullable_to_non_nullable
as String,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatarUrl: freezed == callerAvatarUrl ? _self.callerAvatarUrl : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,offer: freezed == offer ? _self._offer : offer // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,answer: freezed == answer ? _self._answer : answer // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,videoUpgradeRequest: freezed == videoUpgradeRequest ? _self.videoUpgradeRequest : videoUpgradeRequest // ignore: cast_nullable_to_non_nullable
as String?,videoUpgradeRequesterId: freezed == videoUpgradeRequesterId ? _self.videoUpgradeRequesterId : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,answeredAt: freezed == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endReason: freezed == endReason ? _self.endReason : endReason // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
