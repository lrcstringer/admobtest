// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CallEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallEventCopyWith<$Res> {
  factory $CallEventCopyWith(CallEvent value, $Res Function(CallEvent) then) =
      _$CallEventCopyWithImpl<$Res, CallEvent>;
}

/// @nodoc
class _$CallEventCopyWithImpl<$Res, $Val extends CallEvent>
    implements $CallEventCopyWith<$Res> {
  _$CallEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitiateCallImplCopyWith<$Res> {
  factory _$$InitiateCallImplCopyWith(
    _$InitiateCallImpl value,
    $Res Function(_$InitiateCallImpl) then,
  ) = __$$InitiateCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String conversationId,
    String recipientId,
    String recipientName,
    String? recipientAvatarUrl,
    CallType callType,
  });
}

/// @nodoc
class __$$InitiateCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$InitiateCallImpl>
    implements _$$InitiateCallImplCopyWith<$Res> {
  __$$InitiateCallImplCopyWithImpl(
    _$InitiateCallImpl _value,
    $Res Function(_$InitiateCallImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? recipientAvatarUrl = freezed,
    Object? callType = null,
  }) {
    return _then(
      _$InitiateCallImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientName: null == recipientName
            ? _value.recipientName
            : recipientName // ignore: cast_nullable_to_non_nullable
                  as String,
        recipientAvatarUrl: freezed == recipientAvatarUrl
            ? _value.recipientAvatarUrl
            : recipientAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        callType: null == callType
            ? _value.callType
            : callType // ignore: cast_nullable_to_non_nullable
                  as CallType,
      ),
    );
  }
}

/// @nodoc

class _$InitiateCallImpl with DiagnosticableTreeMixin implements _InitiateCall {
  const _$InitiateCallImpl({
    required this.conversationId,
    required this.recipientId,
    required this.recipientName,
    this.recipientAvatarUrl,
    this.callType = CallType.voice,
  });

  @override
  final String conversationId;
  @override
  final String recipientId;
  @override
  final String recipientName;
  @override
  final String? recipientAvatarUrl;
  @override
  @JsonKey()
  final CallType callType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.initiateCall(conversationId: $conversationId, recipientId: $recipientId, recipientName: $recipientName, recipientAvatarUrl: $recipientAvatarUrl, callType: $callType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.initiateCall'))
      ..add(DiagnosticsProperty('conversationId', conversationId))
      ..add(DiagnosticsProperty('recipientId', recipientId))
      ..add(DiagnosticsProperty('recipientName', recipientName))
      ..add(DiagnosticsProperty('recipientAvatarUrl', recipientAvatarUrl))
      ..add(DiagnosticsProperty('callType', callType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateCallImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.recipientAvatarUrl, recipientAvatarUrl) ||
                other.recipientAvatarUrl == recipientAvatarUrl) &&
            (identical(other.callType, callType) ||
                other.callType == callType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    conversationId,
    recipientId,
    recipientName,
    recipientAvatarUrl,
    callType,
  );

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiateCallImplCopyWith<_$InitiateCallImpl> get copyWith =>
      __$$InitiateCallImplCopyWithImpl<_$InitiateCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return initiateCall(
      conversationId,
      recipientId,
      recipientName,
      recipientAvatarUrl,
      callType,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return initiateCall?.call(
      conversationId,
      recipientId,
      recipientName,
      recipientAvatarUrl,
      callType,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (initiateCall != null) {
      return initiateCall(
        conversationId,
        recipientId,
        recipientName,
        recipientAvatarUrl,
        callType,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return initiateCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return initiateCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (initiateCall != null) {
      return initiateCall(this);
    }
    return orElse();
  }
}

abstract class _InitiateCall implements CallEvent {
  const factory _InitiateCall({
    required final String conversationId,
    required final String recipientId,
    required final String recipientName,
    final String? recipientAvatarUrl,
    final CallType callType,
  }) = _$InitiateCallImpl;

  String get conversationId;
  String get recipientId;
  String get recipientName;
  String? get recipientAvatarUrl;
  CallType get callType;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitiateCallImplCopyWith<_$InitiateCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IncomingCallImplCopyWith<$Res> {
  factory _$$IncomingCallImplCopyWith(
    _$IncomingCallImpl value,
    $Res Function(_$IncomingCallImpl) then,
  ) = __$$IncomingCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String callId,
    String callerName,
    String? callerAvatarUrl,
    CallType callType,
    String conversationId,
    String callerId,
  });
}

/// @nodoc
class __$$IncomingCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$IncomingCallImpl>
    implements _$$IncomingCallImplCopyWith<$Res> {
  __$$IncomingCallImplCopyWithImpl(
    _$IncomingCallImpl _value,
    $Res Function(_$IncomingCallImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
    Object? callerName = null,
    Object? callerAvatarUrl = freezed,
    Object? callType = null,
    Object? conversationId = null,
    Object? callerId = null,
  }) {
    return _then(
      _$IncomingCallImpl(
        callId: null == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String,
        callerName: null == callerName
            ? _value.callerName
            : callerName // ignore: cast_nullable_to_non_nullable
                  as String,
        callerAvatarUrl: freezed == callerAvatarUrl
            ? _value.callerAvatarUrl
            : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        callType: null == callType
            ? _value.callType
            : callType // ignore: cast_nullable_to_non_nullable
                  as CallType,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        callerId: null == callerId
            ? _value.callerId
            : callerId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$IncomingCallImpl with DiagnosticableTreeMixin implements _IncomingCall {
  const _$IncomingCallImpl({
    required this.callId,
    required this.callerName,
    this.callerAvatarUrl,
    required this.callType,
    required this.conversationId,
    required this.callerId,
  });

  @override
  final String callId;
  @override
  final String callerName;
  @override
  final String? callerAvatarUrl;
  @override
  final CallType callType;
  @override
  final String conversationId;
  @override
  final String callerId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.incomingCall(callId: $callId, callerName: $callerName, callerAvatarUrl: $callerAvatarUrl, callType: $callType, conversationId: $conversationId, callerId: $callerId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.incomingCall'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callerName', callerName))
      ..add(DiagnosticsProperty('callerAvatarUrl', callerAvatarUrl))
      ..add(DiagnosticsProperty('callType', callType))
      ..add(DiagnosticsProperty('conversationId', conversationId))
      ..add(DiagnosticsProperty('callerId', callerId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomingCallImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callerName, callerName) ||
                other.callerName == callerName) &&
            (identical(other.callerAvatarUrl, callerAvatarUrl) ||
                other.callerAvatarUrl == callerAvatarUrl) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    callId,
    callerName,
    callerAvatarUrl,
    callType,
    conversationId,
    callerId,
  );

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomingCallImplCopyWith<_$IncomingCallImpl> get copyWith =>
      __$$IncomingCallImplCopyWithImpl<_$IncomingCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return incomingCall(
      callId,
      callerName,
      callerAvatarUrl,
      callType,
      conversationId,
      callerId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return incomingCall?.call(
      callId,
      callerName,
      callerAvatarUrl,
      callType,
      conversationId,
      callerId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (incomingCall != null) {
      return incomingCall(
        callId,
        callerName,
        callerAvatarUrl,
        callType,
        conversationId,
        callerId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return incomingCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return incomingCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (incomingCall != null) {
      return incomingCall(this);
    }
    return orElse();
  }
}

abstract class _IncomingCall implements CallEvent {
  const factory _IncomingCall({
    required final String callId,
    required final String callerName,
    final String? callerAvatarUrl,
    required final CallType callType,
    required final String conversationId,
    required final String callerId,
  }) = _$IncomingCallImpl;

  String get callId;
  String get callerName;
  String? get callerAvatarUrl;
  CallType get callType;
  String get conversationId;
  String get callerId;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncomingCallImplCopyWith<_$IncomingCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptCallImplCopyWith<$Res> {
  factory _$$AcceptCallImplCopyWith(
    _$AcceptCallImpl value,
    $Res Function(_$AcceptCallImpl) then,
  ) = __$$AcceptCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AcceptCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$AcceptCallImpl>
    implements _$$AcceptCallImplCopyWith<$Res> {
  __$$AcceptCallImplCopyWithImpl(
    _$AcceptCallImpl _value,
    $Res Function(_$AcceptCallImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AcceptCallImpl with DiagnosticableTreeMixin implements _AcceptCall {
  const _$AcceptCallImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.acceptCall()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.acceptCall'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AcceptCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return acceptCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return acceptCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (acceptCall != null) {
      return acceptCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return acceptCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return acceptCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (acceptCall != null) {
      return acceptCall(this);
    }
    return orElse();
  }
}

abstract class _AcceptCall implements CallEvent {
  const factory _AcceptCall() = _$AcceptCallImpl;
}

/// @nodoc
abstract class _$$RejectCallImplCopyWith<$Res> {
  factory _$$RejectCallImplCopyWith(
    _$RejectCallImpl value,
    $Res Function(_$RejectCallImpl) then,
  ) = __$$RejectCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RejectCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$RejectCallImpl>
    implements _$$RejectCallImplCopyWith<$Res> {
  __$$RejectCallImplCopyWithImpl(
    _$RejectCallImpl _value,
    $Res Function(_$RejectCallImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RejectCallImpl with DiagnosticableTreeMixin implements _RejectCall {
  const _$RejectCallImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.rejectCall()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.rejectCall'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RejectCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return rejectCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return rejectCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (rejectCall != null) {
      return rejectCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return rejectCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return rejectCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (rejectCall != null) {
      return rejectCall(this);
    }
    return orElse();
  }
}

abstract class _RejectCall implements CallEvent {
  const factory _RejectCall() = _$RejectCallImpl;
}

/// @nodoc
abstract class _$$EndCallImplCopyWith<$Res> {
  factory _$$EndCallImplCopyWith(
    _$EndCallImpl value,
    $Res Function(_$EndCallImpl) then,
  ) = __$$EndCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EndCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$EndCallImpl>
    implements _$$EndCallImplCopyWith<$Res> {
  __$$EndCallImplCopyWithImpl(
    _$EndCallImpl _value,
    $Res Function(_$EndCallImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EndCallImpl with DiagnosticableTreeMixin implements _EndCall {
  const _$EndCallImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.endCall()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.endCall'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EndCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return endCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return endCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (endCall != null) {
      return endCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return endCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return endCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (endCall != null) {
      return endCall(this);
    }
    return orElse();
  }
}

abstract class _EndCall implements CallEvent {
  const factory _EndCall() = _$EndCallImpl;
}

/// @nodoc
abstract class _$$ToggleMuteImplCopyWith<$Res> {
  factory _$$ToggleMuteImplCopyWith(
    _$ToggleMuteImpl value,
    $Res Function(_$ToggleMuteImpl) then,
  ) = __$$ToggleMuteImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleMuteImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$ToggleMuteImpl>
    implements _$$ToggleMuteImplCopyWith<$Res> {
  __$$ToggleMuteImplCopyWithImpl(
    _$ToggleMuteImpl _value,
    $Res Function(_$ToggleMuteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleMuteImpl with DiagnosticableTreeMixin implements _ToggleMute {
  const _$ToggleMuteImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.toggleMute()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.toggleMute'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleMuteImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return toggleMute();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return toggleMute?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return toggleMute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return toggleMute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(this);
    }
    return orElse();
  }
}

abstract class _ToggleMute implements CallEvent {
  const factory _ToggleMute() = _$ToggleMuteImpl;
}

/// @nodoc
abstract class _$$ToggleSpeakerImplCopyWith<$Res> {
  factory _$$ToggleSpeakerImplCopyWith(
    _$ToggleSpeakerImpl value,
    $Res Function(_$ToggleSpeakerImpl) then,
  ) = __$$ToggleSpeakerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleSpeakerImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$ToggleSpeakerImpl>
    implements _$$ToggleSpeakerImplCopyWith<$Res> {
  __$$ToggleSpeakerImplCopyWithImpl(
    _$ToggleSpeakerImpl _value,
    $Res Function(_$ToggleSpeakerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleSpeakerImpl
    with DiagnosticableTreeMixin
    implements _ToggleSpeaker {
  const _$ToggleSpeakerImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.toggleSpeaker()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.toggleSpeaker'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleSpeakerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return toggleSpeaker();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return toggleSpeaker?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (toggleSpeaker != null) {
      return toggleSpeaker();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return toggleSpeaker(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return toggleSpeaker?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (toggleSpeaker != null) {
      return toggleSpeaker(this);
    }
    return orElse();
  }
}

abstract class _ToggleSpeaker implements CallEvent {
  const factory _ToggleSpeaker() = _$ToggleSpeakerImpl;
}

/// @nodoc
abstract class _$$ToggleVideoImplCopyWith<$Res> {
  factory _$$ToggleVideoImplCopyWith(
    _$ToggleVideoImpl value,
    $Res Function(_$ToggleVideoImpl) then,
  ) = __$$ToggleVideoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleVideoImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$ToggleVideoImpl>
    implements _$$ToggleVideoImplCopyWith<$Res> {
  __$$ToggleVideoImplCopyWithImpl(
    _$ToggleVideoImpl _value,
    $Res Function(_$ToggleVideoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleVideoImpl with DiagnosticableTreeMixin implements _ToggleVideo {
  const _$ToggleVideoImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.toggleVideo()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.toggleVideo'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleVideoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return toggleVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return toggleVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (toggleVideo != null) {
      return toggleVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return toggleVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return toggleVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (toggleVideo != null) {
      return toggleVideo(this);
    }
    return orElse();
  }
}

abstract class _ToggleVideo implements CallEvent {
  const factory _ToggleVideo() = _$ToggleVideoImpl;
}

/// @nodoc
abstract class _$$SwitchCameraImplCopyWith<$Res> {
  factory _$$SwitchCameraImplCopyWith(
    _$SwitchCameraImpl value,
    $Res Function(_$SwitchCameraImpl) then,
  ) = __$$SwitchCameraImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SwitchCameraImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$SwitchCameraImpl>
    implements _$$SwitchCameraImplCopyWith<$Res> {
  __$$SwitchCameraImplCopyWithImpl(
    _$SwitchCameraImpl _value,
    $Res Function(_$SwitchCameraImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SwitchCameraImpl with DiagnosticableTreeMixin implements _SwitchCamera {
  const _$SwitchCameraImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.switchCamera()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.switchCamera'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SwitchCameraImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return switchCamera();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return switchCamera?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (switchCamera != null) {
      return switchCamera();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return switchCamera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return switchCamera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (switchCamera != null) {
      return switchCamera(this);
    }
    return orElse();
  }
}

abstract class _SwitchCamera implements CallEvent {
  const factory _SwitchCamera() = _$SwitchCameraImpl;
}

/// @nodoc
abstract class _$$RequestVideoUpgradeImplCopyWith<$Res> {
  factory _$$RequestVideoUpgradeImplCopyWith(
    _$RequestVideoUpgradeImpl value,
    $Res Function(_$RequestVideoUpgradeImpl) then,
  ) = __$$RequestVideoUpgradeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestVideoUpgradeImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$RequestVideoUpgradeImpl>
    implements _$$RequestVideoUpgradeImplCopyWith<$Res> {
  __$$RequestVideoUpgradeImplCopyWithImpl(
    _$RequestVideoUpgradeImpl _value,
    $Res Function(_$RequestVideoUpgradeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestVideoUpgradeImpl
    with DiagnosticableTreeMixin
    implements _RequestVideoUpgrade {
  const _$RequestVideoUpgradeImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.requestVideoUpgrade()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.requestVideoUpgrade'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestVideoUpgradeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return requestVideoUpgrade();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return requestVideoUpgrade?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (requestVideoUpgrade != null) {
      return requestVideoUpgrade();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return requestVideoUpgrade(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return requestVideoUpgrade?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (requestVideoUpgrade != null) {
      return requestVideoUpgrade(this);
    }
    return orElse();
  }
}

abstract class _RequestVideoUpgrade implements CallEvent {
  const factory _RequestVideoUpgrade() = _$RequestVideoUpgradeImpl;
}

/// @nodoc
abstract class _$$RespondVideoUpgradeImplCopyWith<$Res> {
  factory _$$RespondVideoUpgradeImplCopyWith(
    _$RespondVideoUpgradeImpl value,
    $Res Function(_$RespondVideoUpgradeImpl) then,
  ) = __$$RespondVideoUpgradeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool accepted});
}

/// @nodoc
class __$$RespondVideoUpgradeImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$RespondVideoUpgradeImpl>
    implements _$$RespondVideoUpgradeImplCopyWith<$Res> {
  __$$RespondVideoUpgradeImplCopyWithImpl(
    _$RespondVideoUpgradeImpl _value,
    $Res Function(_$RespondVideoUpgradeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accepted = null}) {
    return _then(
      _$RespondVideoUpgradeImpl(
        accepted: null == accepted
            ? _value.accepted
            : accepted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RespondVideoUpgradeImpl
    with DiagnosticableTreeMixin
    implements _RespondVideoUpgrade {
  const _$RespondVideoUpgradeImpl({required this.accepted});

  @override
  final bool accepted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.respondVideoUpgrade(accepted: $accepted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.respondVideoUpgrade'))
      ..add(DiagnosticsProperty('accepted', accepted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RespondVideoUpgradeImpl &&
            (identical(other.accepted, accepted) ||
                other.accepted == accepted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accepted);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RespondVideoUpgradeImplCopyWith<_$RespondVideoUpgradeImpl> get copyWith =>
      __$$RespondVideoUpgradeImplCopyWithImpl<_$RespondVideoUpgradeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return respondVideoUpgrade(accepted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return respondVideoUpgrade?.call(accepted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (respondVideoUpgrade != null) {
      return respondVideoUpgrade(accepted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return respondVideoUpgrade(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return respondVideoUpgrade?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (respondVideoUpgrade != null) {
      return respondVideoUpgrade(this);
    }
    return orElse();
  }
}

abstract class _RespondVideoUpgrade implements CallEvent {
  const factory _RespondVideoUpgrade({required final bool accepted}) =
      _$RespondVideoUpgradeImpl;

  bool get accepted;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RespondVideoUpgradeImplCopyWith<_$RespondVideoUpgradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CallDocUpdatedImplCopyWith<$Res> {
  factory _$$CallDocUpdatedImplCopyWith(
    _$CallDocUpdatedImpl value,
    $Res Function(_$CallDocUpdatedImpl) then,
  ) = __$$CallDocUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CallSession session});

  $CallSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$CallDocUpdatedImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CallDocUpdatedImpl>
    implements _$$CallDocUpdatedImplCopyWith<$Res> {
  __$$CallDocUpdatedImplCopyWithImpl(
    _$CallDocUpdatedImpl _value,
    $Res Function(_$CallDocUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? session = null}) {
    return _then(
      _$CallDocUpdatedImpl(
        null == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as CallSession,
      ),
    );
  }

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallSessionCopyWith<$Res> get session {
    return $CallSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$CallDocUpdatedImpl
    with DiagnosticableTreeMixin
    implements _CallDocUpdated {
  const _$CallDocUpdatedImpl(this.session);

  @override
  final CallSession session;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.callDocUpdated(session: $session)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.callDocUpdated'))
      ..add(DiagnosticsProperty('session', session));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallDocUpdatedImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallDocUpdatedImplCopyWith<_$CallDocUpdatedImpl> get copyWith =>
      __$$CallDocUpdatedImplCopyWithImpl<_$CallDocUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return callDocUpdated(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return callDocUpdated?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (callDocUpdated != null) {
      return callDocUpdated(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return callDocUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return callDocUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (callDocUpdated != null) {
      return callDocUpdated(this);
    }
    return orElse();
  }
}

abstract class _CallDocUpdated implements CallEvent {
  const factory _CallDocUpdated(final CallSession session) =
      _$CallDocUpdatedImpl;

  CallSession get session;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallDocUpdatedImplCopyWith<_$CallDocUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IceConnectionStateChangedImplCopyWith<$Res> {
  factory _$$IceConnectionStateChangedImplCopyWith(
    _$IceConnectionStateChangedImpl value,
    $Res Function(_$IceConnectionStateChangedImpl) then,
  ) = __$$IceConnectionStateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RTCIceConnectionState state});
}

/// @nodoc
class __$$IceConnectionStateChangedImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$IceConnectionStateChangedImpl>
    implements _$$IceConnectionStateChangedImplCopyWith<$Res> {
  __$$IceConnectionStateChangedImplCopyWithImpl(
    _$IceConnectionStateChangedImpl _value,
    $Res Function(_$IceConnectionStateChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? state = null}) {
    return _then(
      _$IceConnectionStateChangedImpl(
        null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as RTCIceConnectionState,
      ),
    );
  }
}

/// @nodoc

class _$IceConnectionStateChangedImpl
    with DiagnosticableTreeMixin
    implements _IceConnectionStateChanged {
  const _$IceConnectionStateChangedImpl(this.state);

  @override
  final RTCIceConnectionState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.iceConnectionStateChanged(state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.iceConnectionStateChanged'))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IceConnectionStateChangedImpl &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IceConnectionStateChangedImplCopyWith<_$IceConnectionStateChangedImpl>
  get copyWith =>
      __$$IceConnectionStateChangedImplCopyWithImpl<
        _$IceConnectionStateChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return iceConnectionStateChanged(state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return iceConnectionStateChanged?.call(state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (iceConnectionStateChanged != null) {
      return iceConnectionStateChanged(state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return iceConnectionStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return iceConnectionStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (iceConnectionStateChanged != null) {
      return iceConnectionStateChanged(this);
    }
    return orElse();
  }
}

abstract class _IceConnectionStateChanged implements CallEvent {
  const factory _IceConnectionStateChanged(final RTCIceConnectionState state) =
      _$IceConnectionStateChangedImpl;

  RTCIceConnectionState get state;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IceConnectionStateChangedImplCopyWith<_$IceConnectionStateChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CallTimerTickImplCopyWith<$Res> {
  factory _$$CallTimerTickImplCopyWith(
    _$CallTimerTickImpl value,
    $Res Function(_$CallTimerTickImpl) then,
  ) = __$$CallTimerTickImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CallTimerTickImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CallTimerTickImpl>
    implements _$$CallTimerTickImplCopyWith<$Res> {
  __$$CallTimerTickImplCopyWithImpl(
    _$CallTimerTickImpl _value,
    $Res Function(_$CallTimerTickImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CallTimerTickImpl
    with DiagnosticableTreeMixin
    implements _CallTimerTick {
  const _$CallTimerTickImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.callTimerTick()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'CallEvent.callTimerTick'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CallTimerTickImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return callTimerTick();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return callTimerTick?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (callTimerTick != null) {
      return callTimerTick();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return callTimerTick(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return callTimerTick?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (callTimerTick != null) {
      return callTimerTick(this);
    }
    return orElse();
  }
}

abstract class _CallTimerTick implements CallEvent {
  const factory _CallTimerTick() = _$CallTimerTickImpl;
}

/// @nodoc
abstract class _$$QualityChangedImplCopyWith<$Res> {
  factory _$$QualityChangedImplCopyWith(
    _$QualityChangedImpl value,
    $Res Function(_$QualityChangedImpl) then,
  ) = __$$QualityChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionQuality quality});
}

/// @nodoc
class __$$QualityChangedImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$QualityChangedImpl>
    implements _$$QualityChangedImplCopyWith<$Res> {
  __$$QualityChangedImplCopyWithImpl(
    _$QualityChangedImpl _value,
    $Res Function(_$QualityChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quality = null}) {
    return _then(
      _$QualityChangedImpl(
        null == quality
            ? _value.quality
            : quality // ignore: cast_nullable_to_non_nullable
                  as ConnectionQuality,
      ),
    );
  }
}

/// @nodoc

class _$QualityChangedImpl
    with DiagnosticableTreeMixin
    implements _QualityChanged {
  const _$QualityChangedImpl(this.quality);

  @override
  final ConnectionQuality quality;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.qualityChanged(quality: $quality)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.qualityChanged'))
      ..add(DiagnosticsProperty('quality', quality));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualityChangedImpl &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quality);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QualityChangedImplCopyWith<_$QualityChangedImpl> get copyWith =>
      __$$QualityChangedImplCopyWithImpl<_$QualityChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )
    initiateCall,
    required TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )
    incomingCall,
    required TResult Function() acceptCall,
    required TResult Function() rejectCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleSpeaker,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() requestVideoUpgrade,
    required TResult Function(bool accepted) respondVideoUpgrade,
    required TResult Function(CallSession session) callDocUpdated,
    required TResult Function(RTCIceConnectionState state)
    iceConnectionStateChanged,
    required TResult Function() callTimerTick,
    required TResult Function(ConnectionQuality quality) qualityChanged,
  }) {
    return qualityChanged(quality);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult? Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult? Function()? acceptCall,
    TResult? Function()? rejectCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleSpeaker,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? requestVideoUpgrade,
    TResult? Function(bool accepted)? respondVideoUpgrade,
    TResult? Function(CallSession session)? callDocUpdated,
    TResult? Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult? Function()? callTimerTick,
    TResult? Function(ConnectionQuality quality)? qualityChanged,
  }) {
    return qualityChanged?.call(quality);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String conversationId,
      String recipientId,
      String recipientName,
      String? recipientAvatarUrl,
      CallType callType,
    )?
    initiateCall,
    TResult Function(
      String callId,
      String callerName,
      String? callerAvatarUrl,
      CallType callType,
      String conversationId,
      String callerId,
    )?
    incomingCall,
    TResult Function()? acceptCall,
    TResult Function()? rejectCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleSpeaker,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? requestVideoUpgrade,
    TResult Function(bool accepted)? respondVideoUpgrade,
    TResult Function(CallSession session)? callDocUpdated,
    TResult Function(RTCIceConnectionState state)? iceConnectionStateChanged,
    TResult Function()? callTimerTick,
    TResult Function(ConnectionQuality quality)? qualityChanged,
    required TResult orElse(),
  }) {
    if (qualityChanged != null) {
      return qualityChanged(quality);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_AcceptCall value) acceptCall,
    required TResult Function(_RejectCall value) rejectCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_RequestVideoUpgrade value) requestVideoUpgrade,
    required TResult Function(_RespondVideoUpgrade value) respondVideoUpgrade,
    required TResult Function(_CallDocUpdated value) callDocUpdated,
    required TResult Function(_IceConnectionStateChanged value)
    iceConnectionStateChanged,
    required TResult Function(_CallTimerTick value) callTimerTick,
    required TResult Function(_QualityChanged value) qualityChanged,
  }) {
    return qualityChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_AcceptCall value)? acceptCall,
    TResult? Function(_RejectCall value)? rejectCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult? Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult? Function(_CallDocUpdated value)? callDocUpdated,
    TResult? Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult? Function(_CallTimerTick value)? callTimerTick,
    TResult? Function(_QualityChanged value)? qualityChanged,
  }) {
    return qualityChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_AcceptCall value)? acceptCall,
    TResult Function(_RejectCall value)? rejectCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_RequestVideoUpgrade value)? requestVideoUpgrade,
    TResult Function(_RespondVideoUpgrade value)? respondVideoUpgrade,
    TResult Function(_CallDocUpdated value)? callDocUpdated,
    TResult Function(_IceConnectionStateChanged value)?
    iceConnectionStateChanged,
    TResult Function(_CallTimerTick value)? callTimerTick,
    TResult Function(_QualityChanged value)? qualityChanged,
    required TResult orElse(),
  }) {
    if (qualityChanged != null) {
      return qualityChanged(this);
    }
    return orElse();
  }
}

abstract class _QualityChanged implements CallEvent {
  const factory _QualityChanged(final ConnectionQuality quality) =
      _$QualityChangedImpl;

  ConnectionQuality get quality;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QualityChangedImplCopyWith<_$QualityChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CallState {
  CallStatus get status => throw _privateConstructorUsedError;
  String? get callId => throw _privateConstructorUsedError;
  String? get conversationId => throw _privateConstructorUsedError;
  String? get remoteUserId => throw _privateConstructorUsedError;
  String? get remoteUserName => throw _privateConstructorUsedError;
  String? get remoteUserAvatarUrl => throw _privateConstructorUsedError;
  CallType get callType => throw _privateConstructorUsedError;
  bool get isCaller => throw _privateConstructorUsedError;
  bool get isAudioEnabled => throw _privateConstructorUsedError;
  bool get isVideoEnabled => throw _privateConstructorUsedError;
  bool get isSpeakerOn => throw _privateConstructorUsedError;
  bool get isFrontCamera => throw _privateConstructorUsedError;
  Duration get callDuration => throw _privateConstructorUsedError;
  ConnectionQuality get connectionQuality =>
      throw _privateConstructorUsedError; // Video upgrade
  bool get videoUpgradeRequested => throw _privateConstructorUsedError;
  String? get videoUpgradeRequesterId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallStateCopyWith<CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) then) =
      _$CallStateCopyWithImpl<$Res, CallState>;
  @useResult
  $Res call({
    CallStatus status,
    String? callId,
    String? conversationId,
    String? remoteUserId,
    String? remoteUserName,
    String? remoteUserAvatarUrl,
    CallType callType,
    bool isCaller,
    bool isAudioEnabled,
    bool isVideoEnabled,
    bool isSpeakerOn,
    bool isFrontCamera,
    Duration callDuration,
    ConnectionQuality connectionQuality,
    bool videoUpgradeRequested,
    String? videoUpgradeRequesterId,
    String? errorMessage,
  });
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res, $Val extends CallState>
    implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? callId = freezed,
    Object? conversationId = freezed,
    Object? remoteUserId = freezed,
    Object? remoteUserName = freezed,
    Object? remoteUserAvatarUrl = freezed,
    Object? callType = null,
    Object? isCaller = null,
    Object? isAudioEnabled = null,
    Object? isVideoEnabled = null,
    Object? isSpeakerOn = null,
    Object? isFrontCamera = null,
    Object? callDuration = null,
    Object? connectionQuality = null,
    Object? videoUpgradeRequested = null,
    Object? videoUpgradeRequesterId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CallStatus,
            callId: freezed == callId
                ? _value.callId
                : callId // ignore: cast_nullable_to_non_nullable
                      as String?,
            conversationId: freezed == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            remoteUserId: freezed == remoteUserId
                ? _value.remoteUserId
                : remoteUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            remoteUserName: freezed == remoteUserName
                ? _value.remoteUserName
                : remoteUserName // ignore: cast_nullable_to_non_nullable
                      as String?,
            remoteUserAvatarUrl: freezed == remoteUserAvatarUrl
                ? _value.remoteUserAvatarUrl
                : remoteUserAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            callType: null == callType
                ? _value.callType
                : callType // ignore: cast_nullable_to_non_nullable
                      as CallType,
            isCaller: null == isCaller
                ? _value.isCaller
                : isCaller // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAudioEnabled: null == isAudioEnabled
                ? _value.isAudioEnabled
                : isAudioEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isVideoEnabled: null == isVideoEnabled
                ? _value.isVideoEnabled
                : isVideoEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSpeakerOn: null == isSpeakerOn
                ? _value.isSpeakerOn
                : isSpeakerOn // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFrontCamera: null == isFrontCamera
                ? _value.isFrontCamera
                : isFrontCamera // ignore: cast_nullable_to_non_nullable
                      as bool,
            callDuration: null == callDuration
                ? _value.callDuration
                : callDuration // ignore: cast_nullable_to_non_nullable
                      as Duration,
            connectionQuality: null == connectionQuality
                ? _value.connectionQuality
                : connectionQuality // ignore: cast_nullable_to_non_nullable
                      as ConnectionQuality,
            videoUpgradeRequested: null == videoUpgradeRequested
                ? _value.videoUpgradeRequested
                : videoUpgradeRequested // ignore: cast_nullable_to_non_nullable
                      as bool,
            videoUpgradeRequesterId: freezed == videoUpgradeRequesterId
                ? _value.videoUpgradeRequesterId
                : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$CallStateImplCopyWith<$Res>
    implements $CallStateCopyWith<$Res> {
  factory _$$CallStateImplCopyWith(
    _$CallStateImpl value,
    $Res Function(_$CallStateImpl) then,
  ) = __$$CallStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CallStatus status,
    String? callId,
    String? conversationId,
    String? remoteUserId,
    String? remoteUserName,
    String? remoteUserAvatarUrl,
    CallType callType,
    bool isCaller,
    bool isAudioEnabled,
    bool isVideoEnabled,
    bool isSpeakerOn,
    bool isFrontCamera,
    Duration callDuration,
    ConnectionQuality connectionQuality,
    bool videoUpgradeRequested,
    String? videoUpgradeRequesterId,
    String? errorMessage,
  });
}

/// @nodoc
class __$$CallStateImplCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res, _$CallStateImpl>
    implements _$$CallStateImplCopyWith<$Res> {
  __$$CallStateImplCopyWithImpl(
    _$CallStateImpl _value,
    $Res Function(_$CallStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? callId = freezed,
    Object? conversationId = freezed,
    Object? remoteUserId = freezed,
    Object? remoteUserName = freezed,
    Object? remoteUserAvatarUrl = freezed,
    Object? callType = null,
    Object? isCaller = null,
    Object? isAudioEnabled = null,
    Object? isVideoEnabled = null,
    Object? isSpeakerOn = null,
    Object? isFrontCamera = null,
    Object? callDuration = null,
    Object? connectionQuality = null,
    Object? videoUpgradeRequested = null,
    Object? videoUpgradeRequesterId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CallStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CallStatus,
        callId: freezed == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String?,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        remoteUserId: freezed == remoteUserId
            ? _value.remoteUserId
            : remoteUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        remoteUserName: freezed == remoteUserName
            ? _value.remoteUserName
            : remoteUserName // ignore: cast_nullable_to_non_nullable
                  as String?,
        remoteUserAvatarUrl: freezed == remoteUserAvatarUrl
            ? _value.remoteUserAvatarUrl
            : remoteUserAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        callType: null == callType
            ? _value.callType
            : callType // ignore: cast_nullable_to_non_nullable
                  as CallType,
        isCaller: null == isCaller
            ? _value.isCaller
            : isCaller // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAudioEnabled: null == isAudioEnabled
            ? _value.isAudioEnabled
            : isAudioEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isVideoEnabled: null == isVideoEnabled
            ? _value.isVideoEnabled
            : isVideoEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSpeakerOn: null == isSpeakerOn
            ? _value.isSpeakerOn
            : isSpeakerOn // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFrontCamera: null == isFrontCamera
            ? _value.isFrontCamera
            : isFrontCamera // ignore: cast_nullable_to_non_nullable
                  as bool,
        callDuration: null == callDuration
            ? _value.callDuration
            : callDuration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        connectionQuality: null == connectionQuality
            ? _value.connectionQuality
            : connectionQuality // ignore: cast_nullable_to_non_nullable
                  as ConnectionQuality,
        videoUpgradeRequested: null == videoUpgradeRequested
            ? _value.videoUpgradeRequested
            : videoUpgradeRequested // ignore: cast_nullable_to_non_nullable
                  as bool,
        videoUpgradeRequesterId: freezed == videoUpgradeRequesterId
            ? _value.videoUpgradeRequesterId
            : videoUpgradeRequesterId // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CallStateImpl with DiagnosticableTreeMixin implements _CallState {
  const _$CallStateImpl({
    this.status = CallStatus.idle,
    this.callId,
    this.conversationId,
    this.remoteUserId,
    this.remoteUserName,
    this.remoteUserAvatarUrl,
    this.callType = CallType.voice,
    this.isCaller = true,
    this.isAudioEnabled = true,
    this.isVideoEnabled = false,
    this.isSpeakerOn = false,
    this.isFrontCamera = true,
    this.callDuration = Duration.zero,
    this.connectionQuality = ConnectionQuality.excellent,
    this.videoUpgradeRequested = false,
    this.videoUpgradeRequesterId,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final CallStatus status;
  @override
  final String? callId;
  @override
  final String? conversationId;
  @override
  final String? remoteUserId;
  @override
  final String? remoteUserName;
  @override
  final String? remoteUserAvatarUrl;
  @override
  @JsonKey()
  final CallType callType;
  @override
  @JsonKey()
  final bool isCaller;
  @override
  @JsonKey()
  final bool isAudioEnabled;
  @override
  @JsonKey()
  final bool isVideoEnabled;
  @override
  @JsonKey()
  final bool isSpeakerOn;
  @override
  @JsonKey()
  final bool isFrontCamera;
  @override
  @JsonKey()
  final Duration callDuration;
  @override
  @JsonKey()
  final ConnectionQuality connectionQuality;
  // Video upgrade
  @override
  @JsonKey()
  final bool videoUpgradeRequested;
  @override
  final String? videoUpgradeRequesterId;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallState(status: $status, callId: $callId, conversationId: $conversationId, remoteUserId: $remoteUserId, remoteUserName: $remoteUserName, remoteUserAvatarUrl: $remoteUserAvatarUrl, callType: $callType, isCaller: $isCaller, isAudioEnabled: $isAudioEnabled, isVideoEnabled: $isVideoEnabled, isSpeakerOn: $isSpeakerOn, isFrontCamera: $isFrontCamera, callDuration: $callDuration, connectionQuality: $connectionQuality, videoUpgradeRequested: $videoUpgradeRequested, videoUpgradeRequesterId: $videoUpgradeRequesterId, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('conversationId', conversationId))
      ..add(DiagnosticsProperty('remoteUserId', remoteUserId))
      ..add(DiagnosticsProperty('remoteUserName', remoteUserName))
      ..add(DiagnosticsProperty('remoteUserAvatarUrl', remoteUserAvatarUrl))
      ..add(DiagnosticsProperty('callType', callType))
      ..add(DiagnosticsProperty('isCaller', isCaller))
      ..add(DiagnosticsProperty('isAudioEnabled', isAudioEnabled))
      ..add(DiagnosticsProperty('isVideoEnabled', isVideoEnabled))
      ..add(DiagnosticsProperty('isSpeakerOn', isSpeakerOn))
      ..add(DiagnosticsProperty('isFrontCamera', isFrontCamera))
      ..add(DiagnosticsProperty('callDuration', callDuration))
      ..add(DiagnosticsProperty('connectionQuality', connectionQuality))
      ..add(DiagnosticsProperty('videoUpgradeRequested', videoUpgradeRequested))
      ..add(
        DiagnosticsProperty('videoUpgradeRequesterId', videoUpgradeRequesterId),
      )
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.remoteUserId, remoteUserId) ||
                other.remoteUserId == remoteUserId) &&
            (identical(other.remoteUserName, remoteUserName) ||
                other.remoteUserName == remoteUserName) &&
            (identical(other.remoteUserAvatarUrl, remoteUserAvatarUrl) ||
                other.remoteUserAvatarUrl == remoteUserAvatarUrl) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.isCaller, isCaller) ||
                other.isCaller == isCaller) &&
            (identical(other.isAudioEnabled, isAudioEnabled) ||
                other.isAudioEnabled == isAudioEnabled) &&
            (identical(other.isVideoEnabled, isVideoEnabled) ||
                other.isVideoEnabled == isVideoEnabled) &&
            (identical(other.isSpeakerOn, isSpeakerOn) ||
                other.isSpeakerOn == isSpeakerOn) &&
            (identical(other.isFrontCamera, isFrontCamera) ||
                other.isFrontCamera == isFrontCamera) &&
            (identical(other.callDuration, callDuration) ||
                other.callDuration == callDuration) &&
            (identical(other.connectionQuality, connectionQuality) ||
                other.connectionQuality == connectionQuality) &&
            (identical(other.videoUpgradeRequested, videoUpgradeRequested) ||
                other.videoUpgradeRequested == videoUpgradeRequested) &&
            (identical(
                  other.videoUpgradeRequesterId,
                  videoUpgradeRequesterId,
                ) ||
                other.videoUpgradeRequesterId == videoUpgradeRequesterId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    callId,
    conversationId,
    remoteUserId,
    remoteUserName,
    remoteUserAvatarUrl,
    callType,
    isCaller,
    isAudioEnabled,
    isVideoEnabled,
    isSpeakerOn,
    isFrontCamera,
    callDuration,
    connectionQuality,
    videoUpgradeRequested,
    videoUpgradeRequesterId,
    errorMessage,
  );

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      __$$CallStateImplCopyWithImpl<_$CallStateImpl>(this, _$identity);
}

abstract class _CallState implements CallState {
  const factory _CallState({
    final CallStatus status,
    final String? callId,
    final String? conversationId,
    final String? remoteUserId,
    final String? remoteUserName,
    final String? remoteUserAvatarUrl,
    final CallType callType,
    final bool isCaller,
    final bool isAudioEnabled,
    final bool isVideoEnabled,
    final bool isSpeakerOn,
    final bool isFrontCamera,
    final Duration callDuration,
    final ConnectionQuality connectionQuality,
    final bool videoUpgradeRequested,
    final String? videoUpgradeRequesterId,
    final String? errorMessage,
  }) = _$CallStateImpl;

  @override
  CallStatus get status;
  @override
  String? get callId;
  @override
  String? get conversationId;
  @override
  String? get remoteUserId;
  @override
  String? get remoteUserName;
  @override
  String? get remoteUserAvatarUrl;
  @override
  CallType get callType;
  @override
  bool get isCaller;
  @override
  bool get isAudioEnabled;
  @override
  bool get isVideoEnabled;
  @override
  bool get isSpeakerOn;
  @override
  bool get isFrontCamera;
  @override
  Duration get callDuration;
  @override
  ConnectionQuality get connectionQuality; // Video upgrade
  @override
  bool get videoUpgradeRequested;
  @override
  String? get videoUpgradeRequesterId;
  @override
  String? get errorMessage;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
