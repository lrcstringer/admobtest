// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent()';
}


}

/// @nodoc
class $CallEventCopyWith<$Res>  {
$CallEventCopyWith(CallEvent _, $Res Function(CallEvent) __);
}


/// Adds pattern-matching-related methods to [CallEvent].
extension CallEventPatterns on CallEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InitiateCall value)?  initiateCall,TResult Function( _IncomingCall value)?  incomingCall,TResult Function( _AcceptCall value)?  acceptCall,TResult Function( _RejectCall value)?  rejectCall,TResult Function( _EndCall value)?  endCall,TResult Function( _ToggleMute value)?  toggleMute,TResult Function( _ToggleSpeaker value)?  toggleSpeaker,TResult Function( _ToggleVideo value)?  toggleVideo,TResult Function( _SwitchCamera value)?  switchCamera,TResult Function( _RequestVideoUpgrade value)?  requestVideoUpgrade,TResult Function( _RespondVideoUpgrade value)?  respondVideoUpgrade,TResult Function( _CallDocUpdated value)?  callDocUpdated,TResult Function( _IceConnectionStateChanged value)?  iceConnectionStateChanged,TResult Function( _CallTimerTick value)?  callTimerTick,TResult Function( _QualityChanged value)?  qualityChanged,TResult Function( _PerformIceRestart value)?  performIceRestart,TResult Function( _NetworkChanged value)?  networkChanged,TResult Function( _RemoteVideoStateChanged value)?  remoteVideoStateChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitiateCall() when initiateCall != null:
return initiateCall(_that);case _IncomingCall() when incomingCall != null:
return incomingCall(_that);case _AcceptCall() when acceptCall != null:
return acceptCall(_that);case _RejectCall() when rejectCall != null:
return rejectCall(_that);case _EndCall() when endCall != null:
return endCall(_that);case _ToggleMute() when toggleMute != null:
return toggleMute(_that);case _ToggleSpeaker() when toggleSpeaker != null:
return toggleSpeaker(_that);case _ToggleVideo() when toggleVideo != null:
return toggleVideo(_that);case _SwitchCamera() when switchCamera != null:
return switchCamera(_that);case _RequestVideoUpgrade() when requestVideoUpgrade != null:
return requestVideoUpgrade(_that);case _RespondVideoUpgrade() when respondVideoUpgrade != null:
return respondVideoUpgrade(_that);case _CallDocUpdated() when callDocUpdated != null:
return callDocUpdated(_that);case _IceConnectionStateChanged() when iceConnectionStateChanged != null:
return iceConnectionStateChanged(_that);case _CallTimerTick() when callTimerTick != null:
return callTimerTick(_that);case _QualityChanged() when qualityChanged != null:
return qualityChanged(_that);case _PerformIceRestart() when performIceRestart != null:
return performIceRestart(_that);case _NetworkChanged() when networkChanged != null:
return networkChanged(_that);case _RemoteVideoStateChanged() when remoteVideoStateChanged != null:
return remoteVideoStateChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InitiateCall value)  initiateCall,required TResult Function( _IncomingCall value)  incomingCall,required TResult Function( _AcceptCall value)  acceptCall,required TResult Function( _RejectCall value)  rejectCall,required TResult Function( _EndCall value)  endCall,required TResult Function( _ToggleMute value)  toggleMute,required TResult Function( _ToggleSpeaker value)  toggleSpeaker,required TResult Function( _ToggleVideo value)  toggleVideo,required TResult Function( _SwitchCamera value)  switchCamera,required TResult Function( _RequestVideoUpgrade value)  requestVideoUpgrade,required TResult Function( _RespondVideoUpgrade value)  respondVideoUpgrade,required TResult Function( _CallDocUpdated value)  callDocUpdated,required TResult Function( _IceConnectionStateChanged value)  iceConnectionStateChanged,required TResult Function( _CallTimerTick value)  callTimerTick,required TResult Function( _QualityChanged value)  qualityChanged,required TResult Function( _PerformIceRestart value)  performIceRestart,required TResult Function( _NetworkChanged value)  networkChanged,required TResult Function( _RemoteVideoStateChanged value)  remoteVideoStateChanged,}){
final _that = this;
switch (_that) {
case _InitiateCall():
return initiateCall(_that);case _IncomingCall():
return incomingCall(_that);case _AcceptCall():
return acceptCall(_that);case _RejectCall():
return rejectCall(_that);case _EndCall():
return endCall(_that);case _ToggleMute():
return toggleMute(_that);case _ToggleSpeaker():
return toggleSpeaker(_that);case _ToggleVideo():
return toggleVideo(_that);case _SwitchCamera():
return switchCamera(_that);case _RequestVideoUpgrade():
return requestVideoUpgrade(_that);case _RespondVideoUpgrade():
return respondVideoUpgrade(_that);case _CallDocUpdated():
return callDocUpdated(_that);case _IceConnectionStateChanged():
return iceConnectionStateChanged(_that);case _CallTimerTick():
return callTimerTick(_that);case _QualityChanged():
return qualityChanged(_that);case _PerformIceRestart():
return performIceRestart(_that);case _NetworkChanged():
return networkChanged(_that);case _RemoteVideoStateChanged():
return remoteVideoStateChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InitiateCall value)?  initiateCall,TResult? Function( _IncomingCall value)?  incomingCall,TResult? Function( _AcceptCall value)?  acceptCall,TResult? Function( _RejectCall value)?  rejectCall,TResult? Function( _EndCall value)?  endCall,TResult? Function( _ToggleMute value)?  toggleMute,TResult? Function( _ToggleSpeaker value)?  toggleSpeaker,TResult? Function( _ToggleVideo value)?  toggleVideo,TResult? Function( _SwitchCamera value)?  switchCamera,TResult? Function( _RequestVideoUpgrade value)?  requestVideoUpgrade,TResult? Function( _RespondVideoUpgrade value)?  respondVideoUpgrade,TResult? Function( _CallDocUpdated value)?  callDocUpdated,TResult? Function( _IceConnectionStateChanged value)?  iceConnectionStateChanged,TResult? Function( _CallTimerTick value)?  callTimerTick,TResult? Function( _QualityChanged value)?  qualityChanged,TResult? Function( _PerformIceRestart value)?  performIceRestart,TResult? Function( _NetworkChanged value)?  networkChanged,TResult? Function( _RemoteVideoStateChanged value)?  remoteVideoStateChanged,}){
final _that = this;
switch (_that) {
case _InitiateCall() when initiateCall != null:
return initiateCall(_that);case _IncomingCall() when incomingCall != null:
return incomingCall(_that);case _AcceptCall() when acceptCall != null:
return acceptCall(_that);case _RejectCall() when rejectCall != null:
return rejectCall(_that);case _EndCall() when endCall != null:
return endCall(_that);case _ToggleMute() when toggleMute != null:
return toggleMute(_that);case _ToggleSpeaker() when toggleSpeaker != null:
return toggleSpeaker(_that);case _ToggleVideo() when toggleVideo != null:
return toggleVideo(_that);case _SwitchCamera() when switchCamera != null:
return switchCamera(_that);case _RequestVideoUpgrade() when requestVideoUpgrade != null:
return requestVideoUpgrade(_that);case _RespondVideoUpgrade() when respondVideoUpgrade != null:
return respondVideoUpgrade(_that);case _CallDocUpdated() when callDocUpdated != null:
return callDocUpdated(_that);case _IceConnectionStateChanged() when iceConnectionStateChanged != null:
return iceConnectionStateChanged(_that);case _CallTimerTick() when callTimerTick != null:
return callTimerTick(_that);case _QualityChanged() when qualityChanged != null:
return qualityChanged(_that);case _PerformIceRestart() when performIceRestart != null:
return performIceRestart(_that);case _NetworkChanged() when networkChanged != null:
return networkChanged(_that);case _RemoteVideoStateChanged() when remoteVideoStateChanged != null:
return remoteVideoStateChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String conversationId,  String recipientId,  String recipientName,  String? recipientAvatarUrl,  CallType callType)?  initiateCall,TResult Function( String callId,  String callerName,  String? callerAvatarUrl,  CallType callType,  String conversationId,  String callerId)?  incomingCall,TResult Function()?  acceptCall,TResult Function()?  rejectCall,TResult Function()?  endCall,TResult Function()?  toggleMute,TResult Function()?  toggleSpeaker,TResult Function()?  toggleVideo,TResult Function()?  switchCamera,TResult Function()?  requestVideoUpgrade,TResult Function( bool accepted)?  respondVideoUpgrade,TResult Function( CallSession session)?  callDocUpdated,TResult Function( RTCIceConnectionState state)?  iceConnectionStateChanged,TResult Function()?  callTimerTick,TResult Function( ConnectionQuality quality)?  qualityChanged,TResult Function()?  performIceRestart,TResult Function( bool isConnected)?  networkChanged,TResult Function( bool enabled)?  remoteVideoStateChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitiateCall() when initiateCall != null:
return initiateCall(_that.conversationId,_that.recipientId,_that.recipientName,_that.recipientAvatarUrl,_that.callType);case _IncomingCall() when incomingCall != null:
return incomingCall(_that.callId,_that.callerName,_that.callerAvatarUrl,_that.callType,_that.conversationId,_that.callerId);case _AcceptCall() when acceptCall != null:
return acceptCall();case _RejectCall() when rejectCall != null:
return rejectCall();case _EndCall() when endCall != null:
return endCall();case _ToggleMute() when toggleMute != null:
return toggleMute();case _ToggleSpeaker() when toggleSpeaker != null:
return toggleSpeaker();case _ToggleVideo() when toggleVideo != null:
return toggleVideo();case _SwitchCamera() when switchCamera != null:
return switchCamera();case _RequestVideoUpgrade() when requestVideoUpgrade != null:
return requestVideoUpgrade();case _RespondVideoUpgrade() when respondVideoUpgrade != null:
return respondVideoUpgrade(_that.accepted);case _CallDocUpdated() when callDocUpdated != null:
return callDocUpdated(_that.session);case _IceConnectionStateChanged() when iceConnectionStateChanged != null:
return iceConnectionStateChanged(_that.state);case _CallTimerTick() when callTimerTick != null:
return callTimerTick();case _QualityChanged() when qualityChanged != null:
return qualityChanged(_that.quality);case _PerformIceRestart() when performIceRestart != null:
return performIceRestart();case _NetworkChanged() when networkChanged != null:
return networkChanged(_that.isConnected);case _RemoteVideoStateChanged() when remoteVideoStateChanged != null:
return remoteVideoStateChanged(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String conversationId,  String recipientId,  String recipientName,  String? recipientAvatarUrl,  CallType callType)  initiateCall,required TResult Function( String callId,  String callerName,  String? callerAvatarUrl,  CallType callType,  String conversationId,  String callerId)  incomingCall,required TResult Function()  acceptCall,required TResult Function()  rejectCall,required TResult Function()  endCall,required TResult Function()  toggleMute,required TResult Function()  toggleSpeaker,required TResult Function()  toggleVideo,required TResult Function()  switchCamera,required TResult Function()  requestVideoUpgrade,required TResult Function( bool accepted)  respondVideoUpgrade,required TResult Function( CallSession session)  callDocUpdated,required TResult Function( RTCIceConnectionState state)  iceConnectionStateChanged,required TResult Function()  callTimerTick,required TResult Function( ConnectionQuality quality)  qualityChanged,required TResult Function()  performIceRestart,required TResult Function( bool isConnected)  networkChanged,required TResult Function( bool enabled)  remoteVideoStateChanged,}) {final _that = this;
switch (_that) {
case _InitiateCall():
return initiateCall(_that.conversationId,_that.recipientId,_that.recipientName,_that.recipientAvatarUrl,_that.callType);case _IncomingCall():
return incomingCall(_that.callId,_that.callerName,_that.callerAvatarUrl,_that.callType,_that.conversationId,_that.callerId);case _AcceptCall():
return acceptCall();case _RejectCall():
return rejectCall();case _EndCall():
return endCall();case _ToggleMute():
return toggleMute();case _ToggleSpeaker():
return toggleSpeaker();case _ToggleVideo():
return toggleVideo();case _SwitchCamera():
return switchCamera();case _RequestVideoUpgrade():
return requestVideoUpgrade();case _RespondVideoUpgrade():
return respondVideoUpgrade(_that.accepted);case _CallDocUpdated():
return callDocUpdated(_that.session);case _IceConnectionStateChanged():
return iceConnectionStateChanged(_that.state);case _CallTimerTick():
return callTimerTick();case _QualityChanged():
return qualityChanged(_that.quality);case _PerformIceRestart():
return performIceRestart();case _NetworkChanged():
return networkChanged(_that.isConnected);case _RemoteVideoStateChanged():
return remoteVideoStateChanged(_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String conversationId,  String recipientId,  String recipientName,  String? recipientAvatarUrl,  CallType callType)?  initiateCall,TResult? Function( String callId,  String callerName,  String? callerAvatarUrl,  CallType callType,  String conversationId,  String callerId)?  incomingCall,TResult? Function()?  acceptCall,TResult? Function()?  rejectCall,TResult? Function()?  endCall,TResult? Function()?  toggleMute,TResult? Function()?  toggleSpeaker,TResult? Function()?  toggleVideo,TResult? Function()?  switchCamera,TResult? Function()?  requestVideoUpgrade,TResult? Function( bool accepted)?  respondVideoUpgrade,TResult? Function( CallSession session)?  callDocUpdated,TResult? Function( RTCIceConnectionState state)?  iceConnectionStateChanged,TResult? Function()?  callTimerTick,TResult? Function( ConnectionQuality quality)?  qualityChanged,TResult? Function()?  performIceRestart,TResult? Function( bool isConnected)?  networkChanged,TResult? Function( bool enabled)?  remoteVideoStateChanged,}) {final _that = this;
switch (_that) {
case _InitiateCall() when initiateCall != null:
return initiateCall(_that.conversationId,_that.recipientId,_that.recipientName,_that.recipientAvatarUrl,_that.callType);case _IncomingCall() when incomingCall != null:
return incomingCall(_that.callId,_that.callerName,_that.callerAvatarUrl,_that.callType,_that.conversationId,_that.callerId);case _AcceptCall() when acceptCall != null:
return acceptCall();case _RejectCall() when rejectCall != null:
return rejectCall();case _EndCall() when endCall != null:
return endCall();case _ToggleMute() when toggleMute != null:
return toggleMute();case _ToggleSpeaker() when toggleSpeaker != null:
return toggleSpeaker();case _ToggleVideo() when toggleVideo != null:
return toggleVideo();case _SwitchCamera() when switchCamera != null:
return switchCamera();case _RequestVideoUpgrade() when requestVideoUpgrade != null:
return requestVideoUpgrade();case _RespondVideoUpgrade() when respondVideoUpgrade != null:
return respondVideoUpgrade(_that.accepted);case _CallDocUpdated() when callDocUpdated != null:
return callDocUpdated(_that.session);case _IceConnectionStateChanged() when iceConnectionStateChanged != null:
return iceConnectionStateChanged(_that.state);case _CallTimerTick() when callTimerTick != null:
return callTimerTick();case _QualityChanged() when qualityChanged != null:
return qualityChanged(_that.quality);case _PerformIceRestart() when performIceRestart != null:
return performIceRestart();case _NetworkChanged() when networkChanged != null:
return networkChanged(_that.isConnected);case _RemoteVideoStateChanged() when remoteVideoStateChanged != null:
return remoteVideoStateChanged(_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _InitiateCall implements CallEvent {
  const _InitiateCall({required this.conversationId, required this.recipientId, required this.recipientName, this.recipientAvatarUrl, this.callType = CallType.voice});
  

 final  String conversationId;
 final  String recipientId;
 final  String recipientName;
 final  String? recipientAvatarUrl;
@JsonKey() final  CallType callType;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiateCallCopyWith<_InitiateCall> get copyWith => __$InitiateCallCopyWithImpl<_InitiateCall>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitiateCall&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.recipientAvatarUrl, recipientAvatarUrl) || other.recipientAvatarUrl == recipientAvatarUrl)&&(identical(other.callType, callType) || other.callType == callType));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,recipientId,recipientName,recipientAvatarUrl,callType);

@override
String toString() {
  return 'CallEvent.initiateCall(conversationId: $conversationId, recipientId: $recipientId, recipientName: $recipientName, recipientAvatarUrl: $recipientAvatarUrl, callType: $callType)';
}


}

/// @nodoc
abstract mixin class _$InitiateCallCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$InitiateCallCopyWith(_InitiateCall value, $Res Function(_InitiateCall) _then) = __$InitiateCallCopyWithImpl;
@useResult
$Res call({
 String conversationId, String recipientId, String recipientName, String? recipientAvatarUrl, CallType callType
});




}
/// @nodoc
class __$InitiateCallCopyWithImpl<$Res>
    implements _$InitiateCallCopyWith<$Res> {
  __$InitiateCallCopyWithImpl(this._self, this._then);

  final _InitiateCall _self;
  final $Res Function(_InitiateCall) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? recipientId = null,Object? recipientName = null,Object? recipientAvatarUrl = freezed,Object? callType = null,}) {
  return _then(_InitiateCall(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,recipientAvatarUrl: freezed == recipientAvatarUrl ? _self.recipientAvatarUrl : recipientAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,
  ));
}


}

/// @nodoc


class _IncomingCall implements CallEvent {
  const _IncomingCall({required this.callId, required this.callerName, this.callerAvatarUrl, required this.callType, required this.conversationId, required this.callerId});
  

 final  String callId;
 final  String callerName;
 final  String? callerAvatarUrl;
 final  CallType callType;
 final  String conversationId;
 final  String callerId;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomingCallCopyWith<_IncomingCall> get copyWith => __$IncomingCallCopyWithImpl<_IncomingCall>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomingCall&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatarUrl, callerAvatarUrl) || other.callerAvatarUrl == callerAvatarUrl)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.callerId, callerId) || other.callerId == callerId));
}


@override
int get hashCode => Object.hash(runtimeType,callId,callerName,callerAvatarUrl,callType,conversationId,callerId);

@override
String toString() {
  return 'CallEvent.incomingCall(callId: $callId, callerName: $callerName, callerAvatarUrl: $callerAvatarUrl, callType: $callType, conversationId: $conversationId, callerId: $callerId)';
}


}

/// @nodoc
abstract mixin class _$IncomingCallCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$IncomingCallCopyWith(_IncomingCall value, $Res Function(_IncomingCall) _then) = __$IncomingCallCopyWithImpl;
@useResult
$Res call({
 String callId, String callerName, String? callerAvatarUrl, CallType callType, String conversationId, String callerId
});




}
/// @nodoc
class __$IncomingCallCopyWithImpl<$Res>
    implements _$IncomingCallCopyWith<$Res> {
  __$IncomingCallCopyWithImpl(this._self, this._then);

  final _IncomingCall _self;
  final $Res Function(_IncomingCall) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? callerName = null,Object? callerAvatarUrl = freezed,Object? callType = null,Object? conversationId = null,Object? callerId = null,}) {
  return _then(_IncomingCall(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,callerName: null == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String,callerAvatarUrl: freezed == callerAvatarUrl ? _self.callerAvatarUrl : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,callerId: null == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AcceptCall implements CallEvent {
  const _AcceptCall();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptCall);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.acceptCall()';
}


}




/// @nodoc


class _RejectCall implements CallEvent {
  const _RejectCall();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RejectCall);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.rejectCall()';
}


}




/// @nodoc


class _EndCall implements CallEvent {
  const _EndCall();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EndCall);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.endCall()';
}


}




/// @nodoc


class _ToggleMute implements CallEvent {
  const _ToggleMute();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleMute);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.toggleMute()';
}


}




/// @nodoc


class _ToggleSpeaker implements CallEvent {
  const _ToggleSpeaker();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleSpeaker);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.toggleSpeaker()';
}


}




/// @nodoc


class _ToggleVideo implements CallEvent {
  const _ToggleVideo();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleVideo);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.toggleVideo()';
}


}




/// @nodoc


class _SwitchCamera implements CallEvent {
  const _SwitchCamera();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwitchCamera);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.switchCamera()';
}


}




/// @nodoc


class _RequestVideoUpgrade implements CallEvent {
  const _RequestVideoUpgrade();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestVideoUpgrade);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.requestVideoUpgrade()';
}


}




/// @nodoc


class _RespondVideoUpgrade implements CallEvent {
  const _RespondVideoUpgrade({required this.accepted});
  

 final  bool accepted;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RespondVideoUpgradeCopyWith<_RespondVideoUpgrade> get copyWith => __$RespondVideoUpgradeCopyWithImpl<_RespondVideoUpgrade>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RespondVideoUpgrade&&(identical(other.accepted, accepted) || other.accepted == accepted));
}


@override
int get hashCode => Object.hash(runtimeType,accepted);

@override
String toString() {
  return 'CallEvent.respondVideoUpgrade(accepted: $accepted)';
}


}

/// @nodoc
abstract mixin class _$RespondVideoUpgradeCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$RespondVideoUpgradeCopyWith(_RespondVideoUpgrade value, $Res Function(_RespondVideoUpgrade) _then) = __$RespondVideoUpgradeCopyWithImpl;
@useResult
$Res call({
 bool accepted
});




}
/// @nodoc
class __$RespondVideoUpgradeCopyWithImpl<$Res>
    implements _$RespondVideoUpgradeCopyWith<$Res> {
  __$RespondVideoUpgradeCopyWithImpl(this._self, this._then);

  final _RespondVideoUpgrade _self;
  final $Res Function(_RespondVideoUpgrade) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accepted = null,}) {
  return _then(_RespondVideoUpgrade(
accepted: null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _CallDocUpdated implements CallEvent {
  const _CallDocUpdated(this.session);
  

 final  CallSession session;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallDocUpdatedCopyWith<_CallDocUpdated> get copyWith => __$CallDocUpdatedCopyWithImpl<_CallDocUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallDocUpdated&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'CallEvent.callDocUpdated(session: $session)';
}


}

/// @nodoc
abstract mixin class _$CallDocUpdatedCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$CallDocUpdatedCopyWith(_CallDocUpdated value, $Res Function(_CallDocUpdated) _then) = __$CallDocUpdatedCopyWithImpl;
@useResult
$Res call({
 CallSession session
});


$CallSessionCopyWith<$Res> get session;

}
/// @nodoc
class __$CallDocUpdatedCopyWithImpl<$Res>
    implements _$CallDocUpdatedCopyWith<$Res> {
  __$CallDocUpdatedCopyWithImpl(this._self, this._then);

  final _CallDocUpdated _self;
  final $Res Function(_CallDocUpdated) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(_CallDocUpdated(
null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as CallSession,
  ));
}

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallSessionCopyWith<$Res> get session {
  
  return $CallSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

/// @nodoc


class _IceConnectionStateChanged implements CallEvent {
  const _IceConnectionStateChanged(this.state);
  

 final  RTCIceConnectionState state;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IceConnectionStateChangedCopyWith<_IceConnectionStateChanged> get copyWith => __$IceConnectionStateChangedCopyWithImpl<_IceConnectionStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IceConnectionStateChanged&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'CallEvent.iceConnectionStateChanged(state: $state)';
}


}

/// @nodoc
abstract mixin class _$IceConnectionStateChangedCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$IceConnectionStateChangedCopyWith(_IceConnectionStateChanged value, $Res Function(_IceConnectionStateChanged) _then) = __$IceConnectionStateChangedCopyWithImpl;
@useResult
$Res call({
 RTCIceConnectionState state
});




}
/// @nodoc
class __$IceConnectionStateChangedCopyWithImpl<$Res>
    implements _$IceConnectionStateChangedCopyWith<$Res> {
  __$IceConnectionStateChangedCopyWithImpl(this._self, this._then);

  final _IceConnectionStateChanged _self;
  final $Res Function(_IceConnectionStateChanged) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(_IceConnectionStateChanged(
null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RTCIceConnectionState,
  ));
}


}

/// @nodoc


class _CallTimerTick implements CallEvent {
  const _CallTimerTick();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallTimerTick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.callTimerTick()';
}


}




/// @nodoc


class _QualityChanged implements CallEvent {
  const _QualityChanged(this.quality);
  

 final  ConnectionQuality quality;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QualityChangedCopyWith<_QualityChanged> get copyWith => __$QualityChangedCopyWithImpl<_QualityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualityChanged&&(identical(other.quality, quality) || other.quality == quality));
}


@override
int get hashCode => Object.hash(runtimeType,quality);

@override
String toString() {
  return 'CallEvent.qualityChanged(quality: $quality)';
}


}

/// @nodoc
abstract mixin class _$QualityChangedCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$QualityChangedCopyWith(_QualityChanged value, $Res Function(_QualityChanged) _then) = __$QualityChangedCopyWithImpl;
@useResult
$Res call({
 ConnectionQuality quality
});




}
/// @nodoc
class __$QualityChangedCopyWithImpl<$Res>
    implements _$QualityChangedCopyWith<$Res> {
  __$QualityChangedCopyWithImpl(this._self, this._then);

  final _QualityChanged _self;
  final $Res Function(_QualityChanged) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quality = null,}) {
  return _then(_QualityChanged(
null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as ConnectionQuality,
  ));
}


}

/// @nodoc


class _PerformIceRestart implements CallEvent {
  const _PerformIceRestart();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformIceRestart);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallEvent.performIceRestart()';
}


}




/// @nodoc


class _NetworkChanged implements CallEvent {
  const _NetworkChanged({required this.isConnected});
  

 final  bool isConnected;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkChangedCopyWith<_NetworkChanged> get copyWith => __$NetworkChangedCopyWithImpl<_NetworkChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkChanged&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected);

@override
String toString() {
  return 'CallEvent.networkChanged(isConnected: $isConnected)';
}


}

/// @nodoc
abstract mixin class _$NetworkChangedCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$NetworkChangedCopyWith(_NetworkChanged value, $Res Function(_NetworkChanged) _then) = __$NetworkChangedCopyWithImpl;
@useResult
$Res call({
 bool isConnected
});




}
/// @nodoc
class __$NetworkChangedCopyWithImpl<$Res>
    implements _$NetworkChangedCopyWith<$Res> {
  __$NetworkChangedCopyWithImpl(this._self, this._then);

  final _NetworkChanged _self;
  final $Res Function(_NetworkChanged) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isConnected = null,}) {
  return _then(_NetworkChanged(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _RemoteVideoStateChanged implements CallEvent {
  const _RemoteVideoStateChanged({required this.enabled});
  

 final  bool enabled;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteVideoStateChangedCopyWith<_RemoteVideoStateChanged> get copyWith => __$RemoteVideoStateChangedCopyWithImpl<_RemoteVideoStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteVideoStateChanged&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'CallEvent.remoteVideoStateChanged(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$RemoteVideoStateChangedCopyWith<$Res> implements $CallEventCopyWith<$Res> {
  factory _$RemoteVideoStateChangedCopyWith(_RemoteVideoStateChanged value, $Res Function(_RemoteVideoStateChanged) _then) = __$RemoteVideoStateChangedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$RemoteVideoStateChangedCopyWithImpl<$Res>
    implements _$RemoteVideoStateChangedCopyWith<$Res> {
  __$RemoteVideoStateChangedCopyWithImpl(this._self, this._then);

  final _RemoteVideoStateChanged _self;
  final $Res Function(_RemoteVideoStateChanged) _then;

/// Create a copy of CallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_RemoteVideoStateChanged(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CallState {

 CallStatus get status; String? get callId; String? get conversationId; String? get remoteUserId; String? get remoteUserName; String? get remoteUserAvatarUrl; CallType get callType; bool get isCaller; bool get isAudioEnabled; bool get isVideoEnabled; bool get isSpeakerOn; bool get isFrontCamera; bool get isRemoteVideoEnabled; Duration get callDuration; ConnectionQuality get connectionQuality;// Video upgrade
 bool get videoUpgradeRequested; String? get videoUpgradeRequesterId; String? get errorMessage;
/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallStateCopyWith<CallState> get copyWith => _$CallStateCopyWithImpl<CallState>(this as CallState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallState&&(identical(other.status, status) || other.status == status)&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.remoteUserName, remoteUserName) || other.remoteUserName == remoteUserName)&&(identical(other.remoteUserAvatarUrl, remoteUserAvatarUrl) || other.remoteUserAvatarUrl == remoteUserAvatarUrl)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.isCaller, isCaller) || other.isCaller == isCaller)&&(identical(other.isAudioEnabled, isAudioEnabled) || other.isAudioEnabled == isAudioEnabled)&&(identical(other.isVideoEnabled, isVideoEnabled) || other.isVideoEnabled == isVideoEnabled)&&(identical(other.isSpeakerOn, isSpeakerOn) || other.isSpeakerOn == isSpeakerOn)&&(identical(other.isFrontCamera, isFrontCamera) || other.isFrontCamera == isFrontCamera)&&(identical(other.isRemoteVideoEnabled, isRemoteVideoEnabled) || other.isRemoteVideoEnabled == isRemoteVideoEnabled)&&(identical(other.callDuration, callDuration) || other.callDuration == callDuration)&&(identical(other.connectionQuality, connectionQuality) || other.connectionQuality == connectionQuality)&&(identical(other.videoUpgradeRequested, videoUpgradeRequested) || other.videoUpgradeRequested == videoUpgradeRequested)&&(identical(other.videoUpgradeRequesterId, videoUpgradeRequesterId) || other.videoUpgradeRequesterId == videoUpgradeRequesterId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,callId,conversationId,remoteUserId,remoteUserName,remoteUserAvatarUrl,callType,isCaller,isAudioEnabled,isVideoEnabled,isSpeakerOn,isFrontCamera,isRemoteVideoEnabled,callDuration,connectionQuality,videoUpgradeRequested,videoUpgradeRequesterId,errorMessage);

@override
String toString() {
  return 'CallState(status: $status, callId: $callId, conversationId: $conversationId, remoteUserId: $remoteUserId, remoteUserName: $remoteUserName, remoteUserAvatarUrl: $remoteUserAvatarUrl, callType: $callType, isCaller: $isCaller, isAudioEnabled: $isAudioEnabled, isVideoEnabled: $isVideoEnabled, isSpeakerOn: $isSpeakerOn, isFrontCamera: $isFrontCamera, isRemoteVideoEnabled: $isRemoteVideoEnabled, callDuration: $callDuration, connectionQuality: $connectionQuality, videoUpgradeRequested: $videoUpgradeRequested, videoUpgradeRequesterId: $videoUpgradeRequesterId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CallStateCopyWith<$Res>  {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) _then) = _$CallStateCopyWithImpl;
@useResult
$Res call({
 CallStatus status, String? callId, String? conversationId, String? remoteUserId, String? remoteUserName, String? remoteUserAvatarUrl, CallType callType, bool isCaller, bool isAudioEnabled, bool isVideoEnabled, bool isSpeakerOn, bool isFrontCamera, bool isRemoteVideoEnabled, Duration callDuration, ConnectionQuality connectionQuality, bool videoUpgradeRequested, String? videoUpgradeRequesterId, String? errorMessage
});




}
/// @nodoc
class _$CallStateCopyWithImpl<$Res>
    implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._self, this._then);

  final CallState _self;
  final $Res Function(CallState) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? callId = freezed,Object? conversationId = freezed,Object? remoteUserId = freezed,Object? remoteUserName = freezed,Object? remoteUserAvatarUrl = freezed,Object? callType = null,Object? isCaller = null,Object? isAudioEnabled = null,Object? isVideoEnabled = null,Object? isSpeakerOn = null,Object? isFrontCamera = null,Object? isRemoteVideoEnabled = null,Object? callDuration = null,Object? connectionQuality = null,Object? videoUpgradeRequested = null,Object? videoUpgradeRequesterId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,callId: freezed == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,remoteUserId: freezed == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String?,remoteUserName: freezed == remoteUserName ? _self.remoteUserName : remoteUserName // ignore: cast_nullable_to_non_nullable
as String?,remoteUserAvatarUrl: freezed == remoteUserAvatarUrl ? _self.remoteUserAvatarUrl : remoteUserAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,isCaller: null == isCaller ? _self.isCaller : isCaller // ignore: cast_nullable_to_non_nullable
as bool,isAudioEnabled: null == isAudioEnabled ? _self.isAudioEnabled : isAudioEnabled // ignore: cast_nullable_to_non_nullable
as bool,isVideoEnabled: null == isVideoEnabled ? _self.isVideoEnabled : isVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSpeakerOn: null == isSpeakerOn ? _self.isSpeakerOn : isSpeakerOn // ignore: cast_nullable_to_non_nullable
as bool,isFrontCamera: null == isFrontCamera ? _self.isFrontCamera : isFrontCamera // ignore: cast_nullable_to_non_nullable
as bool,isRemoteVideoEnabled: null == isRemoteVideoEnabled ? _self.isRemoteVideoEnabled : isRemoteVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,callDuration: null == callDuration ? _self.callDuration : callDuration // ignore: cast_nullable_to_non_nullable
as Duration,connectionQuality: null == connectionQuality ? _self.connectionQuality : connectionQuality // ignore: cast_nullable_to_non_nullable
as ConnectionQuality,videoUpgradeRequested: null == videoUpgradeRequested ? _self.videoUpgradeRequested : videoUpgradeRequested // ignore: cast_nullable_to_non_nullable
as bool,videoUpgradeRequesterId: freezed == videoUpgradeRequesterId ? _self.videoUpgradeRequesterId : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallState].
extension CallStatePatterns on CallState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallState value)  $default,){
final _that = this;
switch (_that) {
case _CallState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallState value)?  $default,){
final _that = this;
switch (_that) {
case _CallState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CallStatus status,  String? callId,  String? conversationId,  String? remoteUserId,  String? remoteUserName,  String? remoteUserAvatarUrl,  CallType callType,  bool isCaller,  bool isAudioEnabled,  bool isVideoEnabled,  bool isSpeakerOn,  bool isFrontCamera,  bool isRemoteVideoEnabled,  Duration callDuration,  ConnectionQuality connectionQuality,  bool videoUpgradeRequested,  String? videoUpgradeRequesterId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallState() when $default != null:
return $default(_that.status,_that.callId,_that.conversationId,_that.remoteUserId,_that.remoteUserName,_that.remoteUserAvatarUrl,_that.callType,_that.isCaller,_that.isAudioEnabled,_that.isVideoEnabled,_that.isSpeakerOn,_that.isFrontCamera,_that.isRemoteVideoEnabled,_that.callDuration,_that.connectionQuality,_that.videoUpgradeRequested,_that.videoUpgradeRequesterId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CallStatus status,  String? callId,  String? conversationId,  String? remoteUserId,  String? remoteUserName,  String? remoteUserAvatarUrl,  CallType callType,  bool isCaller,  bool isAudioEnabled,  bool isVideoEnabled,  bool isSpeakerOn,  bool isFrontCamera,  bool isRemoteVideoEnabled,  Duration callDuration,  ConnectionQuality connectionQuality,  bool videoUpgradeRequested,  String? videoUpgradeRequesterId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CallState():
return $default(_that.status,_that.callId,_that.conversationId,_that.remoteUserId,_that.remoteUserName,_that.remoteUserAvatarUrl,_that.callType,_that.isCaller,_that.isAudioEnabled,_that.isVideoEnabled,_that.isSpeakerOn,_that.isFrontCamera,_that.isRemoteVideoEnabled,_that.callDuration,_that.connectionQuality,_that.videoUpgradeRequested,_that.videoUpgradeRequesterId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CallStatus status,  String? callId,  String? conversationId,  String? remoteUserId,  String? remoteUserName,  String? remoteUserAvatarUrl,  CallType callType,  bool isCaller,  bool isAudioEnabled,  bool isVideoEnabled,  bool isSpeakerOn,  bool isFrontCamera,  bool isRemoteVideoEnabled,  Duration callDuration,  ConnectionQuality connectionQuality,  bool videoUpgradeRequested,  String? videoUpgradeRequesterId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CallState() when $default != null:
return $default(_that.status,_that.callId,_that.conversationId,_that.remoteUserId,_that.remoteUserName,_that.remoteUserAvatarUrl,_that.callType,_that.isCaller,_that.isAudioEnabled,_that.isVideoEnabled,_that.isSpeakerOn,_that.isFrontCamera,_that.isRemoteVideoEnabled,_that.callDuration,_that.connectionQuality,_that.videoUpgradeRequested,_that.videoUpgradeRequesterId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CallState implements CallState {
  const _CallState({this.status = CallStatus.idle, this.callId, this.conversationId, this.remoteUserId, this.remoteUserName, this.remoteUserAvatarUrl, this.callType = CallType.voice, this.isCaller = true, this.isAudioEnabled = true, this.isVideoEnabled = false, this.isSpeakerOn = false, this.isFrontCamera = true, this.isRemoteVideoEnabled = false, this.callDuration = Duration.zero, this.connectionQuality = ConnectionQuality.excellent, this.videoUpgradeRequested = false, this.videoUpgradeRequesterId, this.errorMessage});
  

@override@JsonKey() final  CallStatus status;
@override final  String? callId;
@override final  String? conversationId;
@override final  String? remoteUserId;
@override final  String? remoteUserName;
@override final  String? remoteUserAvatarUrl;
@override@JsonKey() final  CallType callType;
@override@JsonKey() final  bool isCaller;
@override@JsonKey() final  bool isAudioEnabled;
@override@JsonKey() final  bool isVideoEnabled;
@override@JsonKey() final  bool isSpeakerOn;
@override@JsonKey() final  bool isFrontCamera;
@override@JsonKey() final  bool isRemoteVideoEnabled;
@override@JsonKey() final  Duration callDuration;
@override@JsonKey() final  ConnectionQuality connectionQuality;
// Video upgrade
@override@JsonKey() final  bool videoUpgradeRequested;
@override final  String? videoUpgradeRequesterId;
@override final  String? errorMessage;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallStateCopyWith<_CallState> get copyWith => __$CallStateCopyWithImpl<_CallState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallState&&(identical(other.status, status) || other.status == status)&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.remoteUserId, remoteUserId) || other.remoteUserId == remoteUserId)&&(identical(other.remoteUserName, remoteUserName) || other.remoteUserName == remoteUserName)&&(identical(other.remoteUserAvatarUrl, remoteUserAvatarUrl) || other.remoteUserAvatarUrl == remoteUserAvatarUrl)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.isCaller, isCaller) || other.isCaller == isCaller)&&(identical(other.isAudioEnabled, isAudioEnabled) || other.isAudioEnabled == isAudioEnabled)&&(identical(other.isVideoEnabled, isVideoEnabled) || other.isVideoEnabled == isVideoEnabled)&&(identical(other.isSpeakerOn, isSpeakerOn) || other.isSpeakerOn == isSpeakerOn)&&(identical(other.isFrontCamera, isFrontCamera) || other.isFrontCamera == isFrontCamera)&&(identical(other.isRemoteVideoEnabled, isRemoteVideoEnabled) || other.isRemoteVideoEnabled == isRemoteVideoEnabled)&&(identical(other.callDuration, callDuration) || other.callDuration == callDuration)&&(identical(other.connectionQuality, connectionQuality) || other.connectionQuality == connectionQuality)&&(identical(other.videoUpgradeRequested, videoUpgradeRequested) || other.videoUpgradeRequested == videoUpgradeRequested)&&(identical(other.videoUpgradeRequesterId, videoUpgradeRequesterId) || other.videoUpgradeRequesterId == videoUpgradeRequesterId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,callId,conversationId,remoteUserId,remoteUserName,remoteUserAvatarUrl,callType,isCaller,isAudioEnabled,isVideoEnabled,isSpeakerOn,isFrontCamera,isRemoteVideoEnabled,callDuration,connectionQuality,videoUpgradeRequested,videoUpgradeRequesterId,errorMessage);

@override
String toString() {
  return 'CallState(status: $status, callId: $callId, conversationId: $conversationId, remoteUserId: $remoteUserId, remoteUserName: $remoteUserName, remoteUserAvatarUrl: $remoteUserAvatarUrl, callType: $callType, isCaller: $isCaller, isAudioEnabled: $isAudioEnabled, isVideoEnabled: $isVideoEnabled, isSpeakerOn: $isSpeakerOn, isFrontCamera: $isFrontCamera, isRemoteVideoEnabled: $isRemoteVideoEnabled, callDuration: $callDuration, connectionQuality: $connectionQuality, videoUpgradeRequested: $videoUpgradeRequested, videoUpgradeRequesterId: $videoUpgradeRequesterId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CallStateCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$CallStateCopyWith(_CallState value, $Res Function(_CallState) _then) = __$CallStateCopyWithImpl;
@override @useResult
$Res call({
 CallStatus status, String? callId, String? conversationId, String? remoteUserId, String? remoteUserName, String? remoteUserAvatarUrl, CallType callType, bool isCaller, bool isAudioEnabled, bool isVideoEnabled, bool isSpeakerOn, bool isFrontCamera, bool isRemoteVideoEnabled, Duration callDuration, ConnectionQuality connectionQuality, bool videoUpgradeRequested, String? videoUpgradeRequesterId, String? errorMessage
});




}
/// @nodoc
class __$CallStateCopyWithImpl<$Res>
    implements _$CallStateCopyWith<$Res> {
  __$CallStateCopyWithImpl(this._self, this._then);

  final _CallState _self;
  final $Res Function(_CallState) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? callId = freezed,Object? conversationId = freezed,Object? remoteUserId = freezed,Object? remoteUserName = freezed,Object? remoteUserAvatarUrl = freezed,Object? callType = null,Object? isCaller = null,Object? isAudioEnabled = null,Object? isVideoEnabled = null,Object? isSpeakerOn = null,Object? isFrontCamera = null,Object? isRemoteVideoEnabled = null,Object? callDuration = null,Object? connectionQuality = null,Object? videoUpgradeRequested = null,Object? videoUpgradeRequesterId = freezed,Object? errorMessage = freezed,}) {
  return _then(_CallState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CallStatus,callId: freezed == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,remoteUserId: freezed == remoteUserId ? _self.remoteUserId : remoteUserId // ignore: cast_nullable_to_non_nullable
as String?,remoteUserName: freezed == remoteUserName ? _self.remoteUserName : remoteUserName // ignore: cast_nullable_to_non_nullable
as String?,remoteUserAvatarUrl: freezed == remoteUserAvatarUrl ? _self.remoteUserAvatarUrl : remoteUserAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,isCaller: null == isCaller ? _self.isCaller : isCaller // ignore: cast_nullable_to_non_nullable
as bool,isAudioEnabled: null == isAudioEnabled ? _self.isAudioEnabled : isAudioEnabled // ignore: cast_nullable_to_non_nullable
as bool,isVideoEnabled: null == isVideoEnabled ? _self.isVideoEnabled : isVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSpeakerOn: null == isSpeakerOn ? _self.isSpeakerOn : isSpeakerOn // ignore: cast_nullable_to_non_nullable
as bool,isFrontCamera: null == isFrontCamera ? _self.isFrontCamera : isFrontCamera // ignore: cast_nullable_to_non_nullable
as bool,isRemoteVideoEnabled: null == isRemoteVideoEnabled ? _self.isRemoteVideoEnabled : isRemoteVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,callDuration: null == callDuration ? _self.callDuration : callDuration // ignore: cast_nullable_to_non_nullable
as Duration,connectionQuality: null == connectionQuality ? _self.connectionQuality : connectionQuality // ignore: cast_nullable_to_non_nullable
as ConnectionQuality,videoUpgradeRequested: null == videoUpgradeRequested ? _self.videoUpgradeRequested : videoUpgradeRequested // ignore: cast_nullable_to_non_nullable
as bool,videoUpgradeRequesterId: freezed == videoUpgradeRequesterId ? _self.videoUpgradeRequesterId : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
