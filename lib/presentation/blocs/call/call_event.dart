part of 'call_bloc.dart';

@freezed
class CallEvent with _$CallEvent {
  // ── Outgoing call ──
  const factory CallEvent.initiateCall({
    required String conversationId,
    required String recipientId,
    required String recipientName,
    String? recipientAvatarUrl,
    @Default(CallType.voice) CallType callType,
  }) = _InitiateCall;

  // ── Incoming call ──
  const factory CallEvent.incomingCall({
    required String callId,
    required String callerName,
    String? callerAvatarUrl,
    required CallType callType,
    required String conversationId,
    required String callerId,
  }) = _IncomingCall;

  // ── User actions ──
  const factory CallEvent.acceptCall() = _AcceptCall;
  const factory CallEvent.rejectCall() = _RejectCall;
  const factory CallEvent.endCall() = _EndCall;
  const factory CallEvent.toggleMute() = _ToggleMute;
  const factory CallEvent.toggleSpeaker() = _ToggleSpeaker;
  const factory CallEvent.toggleVideo() = _ToggleVideo;
  const factory CallEvent.switchCamera() = _SwitchCamera;
  const factory CallEvent.requestVideoUpgrade() = _RequestVideoUpgrade;
  const factory CallEvent.respondVideoUpgrade({required bool accepted}) =
      _RespondVideoUpgrade;

  // ── Internal (from signaling/WebRTC callbacks) ──
  const factory CallEvent.callDocUpdated(CallSession session) =
      _CallDocUpdated;
  const factory CallEvent.iceConnectionStateChanged(
      RTCIceConnectionState state) = _IceConnectionStateChanged;
  const factory CallEvent.callTimerTick() = _CallTimerTick;
  const factory CallEvent.qualityChanged(ConnectionQuality quality) =
      _QualityChanged;
}
