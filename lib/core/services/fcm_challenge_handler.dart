import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final KeystoreService _keystoreService;

  StreamSubscription<RemoteMessage>? _foregroundSubscription;

  /// Stream controller for incoming challenges (used by UI to show approval screen).
  final _challengeController = StreamController<Map<String, dynamic>>.broadcast();

  /// Stream of incoming auth challenges.
  Stream<Map<String, dynamic>> get challengeStream => _challengeController.stream;

  FcmChallengeHandler(
    this._messaging,
    this._firestore,
    this._functions,
    this._keystoreService,
  );

  /// Start listening for incoming FCM messages with auth challenges.
  void startListening() {
    _foregroundSubscription?.cancel();
    _foregroundSubscription = FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  /// Stop listening for FCM messages.
  void stopListening() {
    _foregroundSubscription?.cancel();
    _foregroundSubscription = null;
  }

  void _handleMessage(RemoteMessage message) {
    final data = message.data;
    if (data['type'] == 'auth_challenge') {
      debugPrint('FCM: Received auth challenge ${data['challengeId']}');
      _challengeController.add(data);
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

  /// Listen for real-time challenge status updates via Firestore.
  ///
  /// Returns a stream of challenge status strings ('pending', 'approved', 'denied', 'expired').
  Stream<String> watchChallengeStatus(String challengeId) {
    return _firestore
        .collection('authChallenges')
        .doc(challengeId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return 'expired';
      final data = snapshot.data()!;
      return data['status'] as String? ?? 'pending';
    });
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
