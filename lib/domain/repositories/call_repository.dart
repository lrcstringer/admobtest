import '../enums/call_type.dart';

/// Repository interface for voice/video call operations.
///
/// SDP and ICE candidate signaling is handled directly by
/// [CallSignalingService] via RTDB — not through this repository.
abstract class CallRepository {
  /// Initiate a call via Cloud Function. Returns the callId.
  Future<String> initiateCall({
    required String conversationId,
    required String recipientId,
    required CallType callType,
  });

  /// Answer a ringing call via Cloud Function.
  Future<void> answerCall(String callId);

  /// End a call via Cloud Function. Idempotent — safe to call from both peers.
  Future<void> endCall(String callId, {String? reason});

  /// Get TURN credentials from Cloud Function.
  Future<Map<String, dynamic>> getTurnCredentials();
}
