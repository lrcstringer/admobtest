import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/call_status.dart';
import '../enums/call_type.dart';

part 'call_session.freezed.dart';

/// Domain entity representing a voice/video call session.
///
/// No JSON serialization — that lives in the data layer model.
@freezed
abstract class CallSession with _$CallSession {
  const factory CallSession({
    required String callId,
    required String conversationId,
    required String callerId,
    required String calleeId,
    required String callerName,
    String? callerAvatarUrl,
    required CallType callType,
    required CallStatus status,

    /// SDP offer from the caller: {type, sdp}.
    Map<String, String>? offer,

    /// SDP answer from the callee: {type, sdp}.
    Map<String, String>? answer,

    /// Video upgrade request state: 'pending' | 'accepted' | 'declined'.
    String? videoUpgradeRequest,
    String? videoUpgradeRequesterId,

    DateTime? createdAt,
    DateTime? answeredAt,
    DateTime? endedAt,
    String? endReason,
    int? durationSeconds,
  }) = _CallSession;
}
