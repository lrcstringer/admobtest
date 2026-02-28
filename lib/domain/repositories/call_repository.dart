import '../entities/call_session.dart';
import '../enums/call_type.dart';

/// Repository interface for voice/video call operations.
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

  /// Watch the call document for real-time changes (SDP, status, etc.).
  Stream<CallSession> watchCall(String callId);

  /// Send SDP offer to Firestore.
  Future<void> sendOffer(String callId, Map<String, String> offer);

  /// Send SDP answer to Firestore.
  Future<void> sendAnswer(String callId, Map<String, String> answer);

  /// Send a local ICE candidate to Firestore.
  Future<void> sendIceCandidate(
    String callId,
    Map<String, dynamic> candidate, {
    required bool isCaller,
  });

  /// Watch remote ICE candidates from Firestore.
  Stream<Map<String, dynamic>> watchRemoteIceCandidates(
    String callId, {
    required bool isCaller,
  });

  /// Send heartbeat to indicate this peer is still alive.
  Future<void> sendHeartbeat(String callId, {required bool isCaller});

  /// Request a voice-to-video upgrade.
  Future<void> requestVideoUpgrade(String callId, String requesterId);

  /// Respond to a video upgrade request.
  Future<void> respondVideoUpgrade(String callId, bool accepted);
}
