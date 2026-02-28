import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

/// Remote datasource for call-related Cloud Function calls.
@lazySingleton
class CallRemoteDatasource {
  final FirebaseFunctions _functions;

  CallRemoteDatasource(this._functions);

  /// Create a call via Cloud Function. Returns the callId.
  Future<String> initiateCall({
    required String conversationId,
    required String recipientId,
    required String callType,
  }) async {
    final result = await _functions.httpsCallable('initiateCall').call<Map<String, dynamic>>({
      'conversationId': conversationId,
      'recipientId': recipientId,
      'callType': callType,
    });
    return result.data['callId'] as String;
  }

  /// Answer a ringing call via Cloud Function.
  Future<void> answerCall(String callId) async {
    await _functions.httpsCallable('answerCall').call<Map<String, dynamic>>({
      'callId': callId,
    });
  }

  /// End a call via Cloud Function. Idempotent.
  Future<void> endCall(String callId, {String? reason}) async {
    await _functions.httpsCallable('endCall').call<Map<String, dynamic>>({
      'callId': callId,
      if (reason != null) 'reason': reason,
    });
  }

  /// Get TURN credentials from Cloud Function.
  Future<Map<String, dynamic>> getTurnCredentials() async {
    final result = await _functions
        .httpsCallable('getTurnCredentials')
        .call<Map<String, dynamic>>({});
    return result.data;
  }
}
