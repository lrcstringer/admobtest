import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Remote datasource for call-related Cloud Function calls.
@lazySingleton
class CallRemoteDatasource {
  final FirebaseFunctions _functions;

  CallRemoteDatasource(this._functions);

  // TURN credential cache — credentials have 2hr TTL, we cache for 1hr
  Map<String, dynamic>? _cachedTurnCredentials;
  DateTime? _turnCredentialsCachedAt;
  static const _turnCacheDuration = Duration(hours: 1);

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

  /// Get TURN credentials from Cloud Function (cached for 1 hour).
  Future<Map<String, dynamic>> getTurnCredentials() async {
    if (_cachedTurnCredentials != null &&
        _turnCredentialsCachedAt != null &&
        DateTime.now().difference(_turnCredentialsCachedAt!) <
            _turnCacheDuration) {
      debugPrint('CallDatasource: returning cached TURN credentials');
      return _cachedTurnCredentials!;
    }

    final result = await _functions
        .httpsCallable('getTurnCredentials')
        .call<Map<String, dynamic>>({});
    _cachedTurnCredentials = result.data;
    _turnCredentialsCachedAt = DateTime.now();
    return result.data;
  }
}
