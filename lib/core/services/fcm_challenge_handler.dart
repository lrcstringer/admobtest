import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../error/failures.dart';
import '../security/keystore_service.dart';

/// Result of a push login attempt.
enum PushLoginResult {
  /// Challenge was approved and custom token returned.
  approved,

  /// Challenge was denied by the user.
  denied,

  /// Challenge expired before being acted upon.
  expired,

  /// An error occurred during the push login flow.
  error,
}

/// Handles incoming FCM push authentication challenges and provides
/// methods for the push login flow.
@lazySingleton
class FcmChallengeHandler {
  final FirebaseMessaging _messaging;
  final FirebaseFunctions _functions;
  final KeystoreService _keystoreService;

  StreamSubscription<RemoteMessage>? _foregroundSubscription;

  /// Stream controller for incoming challenges (used by UI to show approval screen).
  final _challengeController = StreamController<Map<String, dynamic>>.broadcast();

  /// Stream of incoming auth challenges.
  Stream<Map<String, dynamic>> get challengeStream => _challengeController.stream;

  FcmChallengeHandler(
    this._messaging,
    this._functions,
    this._keystoreService,
  );

  /// Start listening for incoming FCM messages with auth challenges.
  void startListening() {
    _foregroundSubscription?.cancel();
    _foregroundSubscription = FirebaseMessaging.onMessage.listen(_handleMessage);
    debugPrint('========================================');
    debugPrint('FCM CHALLENGE HANDLER: startListening() active');
    debugPrint('========================================');
  }

  /// Stop listening for FCM messages.
  void stopListening() {
    _foregroundSubscription?.cancel();
    _foregroundSubscription = null;
  }

  void _handleMessage(RemoteMessage message) {
    debugPrint('========================================');
    debugPrint('FCM MESSAGE RECEIVED (foreground):');
    debugPrint('  data keys: ${message.data.keys.toList()}');
    debugPrint('  data: ${message.data}');
    debugPrint('  notification title: ${message.notification?.title}');
    debugPrint('========================================');
    final data = message.data;
    if (data['type'] == 'auth_challenge') {
      debugPrint('FCM: Auth challenge detected, challengeId=${data['challengeId']}');
      debugPrint('FCM: nonce present=${data['nonce'] != null}');
      _challengeController.add(data);
    } else {
      debugPrint('FCM: Not an auth_challenge message, type=${data['type']}');
    }
  }

  /// Request a push-based login for a phone number.
  ///
  /// Returns the challengeId if a trusted device exists, or null if the
  /// user should fall back to OTP.
  Future<({String? challengeId, bool hasTrustedDevice})> requestLogin(
    String phoneNumber,
  ) async {
    try {
      final callable = _functions.httpsCallable('loginRequest');
      final result = await callable.call<Map<String, dynamic>>({
        'phoneNumber': phoneNumber,
      });

      final data = result.data;
      return (
        challengeId: data['challengeId'] as String?,
        hasTrustedDevice: data['hasTrustedDevice'] as bool? ?? false,
      );
    } catch (e) {
      debugPrint('Push login request failed: $e');
      return (challengeId: null, hasTrustedDevice: false);
    }
  }

  /// Poll for challenge status updates via Cloud Function.
  ///
  /// Returns a stream that polls every 3 seconds until the challenge
  /// is resolved (approved, denied, or expired). Uses a Cloud Function
  /// instead of Firestore snapshots because the requesting client is
  /// not yet authenticated.
  Stream<({String status, String? customToken, String? nonce})>
      watchChallengeStatus(String challengeId) async* {
    const pollInterval = Duration(seconds: 3);
    const maxPolls = 65; // ~195 seconds, slightly over 3-minute expiry

    for (int i = 0; i < maxPolls; i++) {
      try {
        final callable = _functions.httpsCallable('checkChallengeStatus');
        final result = await callable.call<Map<String, dynamic>>({
          'challengeId': challengeId,
        });

        final data = result.data;
        final status = data['status'] as String? ?? 'pending';
        final customToken = data['customToken'] as String?;

        yield (status: status, customToken: customToken, nonce: null);

        // Stop polling once resolved
        if (status != 'pending') return;
      } catch (e) {
        debugPrint('Challenge status poll error: $e');
        yield (status: 'error', customToken: null, nonce: null);
        return;
      }

      await Future<void>.delayed(pollInterval);
    }

    // Timed out
    yield (status: 'expired', customToken: null, nonce: null);
  }

  /// Approve a challenge by signing the nonce with the device's private key.
  ///
  /// Returns the custom auth token on success, or null on failure.
  Future<String?> approveChallenge({
    required String challengeId,
    required String nonce,
    required String deviceId,
    required String userId,
  }) async {
    try {
      // Sign the nonce with the device's private key
      final alias = KeystoreService.keyAlias(userId);
      final signResult = await _keystoreService.sign(alias, nonce);

      return signResult.fold(
        (failure) {
          debugPrint('Failed to sign nonce: ${failure.displayMessage}');
          return null;
        },
        (signature) async {
          // Submit approval to server
          final callable = _functions.httpsCallable('approveLogin');
          final result = await callable.call<Map<String, dynamic>>({
            'challengeId': challengeId,
            'signedNonce': signature,
            'deviceId': deviceId,
          });

          return result.data['customToken'] as String?;
        },
      );
    } catch (e) {
      debugPrint('Challenge approval failed: $e');
      return null;
    }
  }

  /// Deny a challenge.
  Future<bool> denyChallenge(String challengeId) async {
    try {
      final callable = _functions.httpsCallable('denyLogin');
      await callable.call<Map<String, dynamic>>({
        'challengeId': challengeId,
      });
      return true;
    } catch (e) {
      debugPrint('Challenge denial failed: $e');
      return false;
    }
  }

  /// Get the current FCM token for this device.
  Future<String?> getFcmToken() {
    return _messaging.getToken();
  }

  /// Dispose resources.
  void dispose() {
    stopListening();
    _challengeController.close();
  }
}
