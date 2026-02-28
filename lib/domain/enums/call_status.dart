/// Status of a voice/video call.
enum CallStatus {
  /// No active call.
  idle,

  /// Outgoing: waiting for answer; Incoming: ringing.
  ringing,

  /// ICE negotiation in progress.
  connecting,

  /// Media flowing — call is active.
  active,

  /// ICE disconnected, attempting restart.
  reconnecting,

  /// Call ended normally.
  ended,

  /// Ring timeout — callee never answered.
  missed,

  /// Callee rejected the call.
  declined,

  /// Caller hung up before callee answered.
  cancelled,

  /// Connection could not be established.
  failed,

  /// Callee is already on another call.
  busy,
}

/// Terminal statuses — call is over and cannot transition further.
const terminalCallStatuses = {
  CallStatus.ended,
  CallStatus.missed,
  CallStatus.declined,
  CallStatus.cancelled,
  CallStatus.failed,
  CallStatus.busy,
};
