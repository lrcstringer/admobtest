part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const factory CallState({
    @Default(CallStatus.idle) CallStatus status,
    String? callId,
    String? conversationId,
    String? remoteUserId,
    String? remoteUserName,
    String? remoteUserAvatarUrl,
    @Default(CallType.voice) CallType callType,
    @Default(true) bool isCaller,
    @Default(true) bool isAudioEnabled,
    @Default(false) bool isVideoEnabled,
    @Default(false) bool isSpeakerOn,
    @Default(true) bool isFrontCamera,
    @Default(Duration.zero) Duration callDuration,
    @Default(ConnectionQuality.excellent) ConnectionQuality connectionQuality,
    // Video upgrade
    @Default(false) bool videoUpgradeRequested,
    String? videoUpgradeRequesterId,
    String? errorMessage,
  }) = _CallState;
}
