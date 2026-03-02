import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

/// Firebase Analytics events for call reliability metrics.
@lazySingleton
class CallAnalyticsService {
  final FirebaseAnalytics _analytics;

  CallAnalyticsService(this._analytics);

  void logCallStarted({
    required String callId,
    required String callType,
    required bool isCaller,
    required bool hasTurn,
  }) {
    _analytics.logEvent(name: 'call_started', parameters: {
      'call_type': callType,
      'is_caller': isCaller.toString(),
      'has_turn': hasTurn.toString(),
    });
  }

  void logCallConnected({
    required String callId,
    required int setupDurationMs,
  }) {
    _analytics.logEvent(name: 'call_connected', parameters: {
      'setup_duration_ms': setupDurationMs,
    });
  }

  void logCallEnded({
    required String callId,
    required String endReason,
    required int durationSeconds,
    required int iceRestarts,
    required String finalQuality,
  }) {
    _analytics.logEvent(name: 'call_ended', parameters: {
      'end_reason': endReason,
      'duration_seconds': durationSeconds,
      'ice_restarts': iceRestarts,
      'final_quality': finalQuality,
    });
  }

  void logIceRestart({required String callId, required int attempt}) {
    _analytics.logEvent(name: 'call_ice_restart', parameters: {
      'attempt': attempt,
    });
  }

  void logCallFailed({required String callId, required String error}) {
    _analytics.logEvent(name: 'call_failed', parameters: {
      'error': error.length > 100 ? error.substring(0, 100) : error,
    });
  }
}
