import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

import '../error/failures.dart';
import '../security/device_binding_service.dart';
import '../security/device_capability_service.dart';
import '../security/keystore_service.dart';

/// Result of a biometric login attempt.
enum BiometricLoginResult {
  success,
  cancelled,
  biometricFailed,
  signatureFailed,
  serverError,
  notAvailable,
}

/// Orchestrates biometric login for returning users on trusted devices.
///
/// Flow:
/// 1. Check if biometric login is available (local binding + device capability)
/// 2. Prompt biometric/device credential authentication
/// 3. Request a server-generated nonce
/// 4. Sign the nonce with the hardware-backed private key
/// 5. Verify with server and receive a custom auth token
@lazySingleton
class BiometricLoginService {
  final DeviceBindingService _deviceBindingService;
  final DeviceCapabilityService _capabilityService;
  final KeystoreService _keystoreService;
  final LocalAuthentication _localAuth;
  final FirebaseFunctions _functions;
  final FlutterSecureStorage _secureStorage;

  static const _displayNameKey = 'imali_cached_display_name';
  static const _lastAuthTimeKey = 'imali_last_auth_time';

  /// Maximum inactivity period before biometric login requires OTP step-up.
  /// After 7 days without any successful authentication, biometric login
  /// is disabled and the user must re-authenticate via OTP.
  static const inactivityThreshold = Duration(days: 7);

  BiometricLoginService(
    this._deviceBindingService,
    this._capabilityService,
    this._keystoreService,
    this._localAuth,
    this._functions,
    this._secureStorage,
  );

  /// Check if biometric login can be offered to the user.
  ///
  /// Returns true only if:
  /// - A device binding exists locally (deviceId + userId)
  /// - The device supports biometric or device credential authentication
  /// - The last successful authentication was within [inactivityThreshold]
  Future<bool> canUseBiometricLogin() async {
    try {
      final deviceId = await _deviceBindingService.getStoredDeviceId();
      final userId = await _deviceBindingService.getStoredUserId();

      if (deviceId == null || userId == null) {
        debugPrint('BiometricLogin: No local binding found.');
        return false;
      }

      // Check inactivity threshold
      if (await _isInactivityThresholdExceeded()) {
        debugPrint('BiometricLogin: Inactivity threshold exceeded, requiring OTP.');
        return false;
      }

      final tier = await _capabilityService.detectCapabilityTier();
      final supported = tier == AuthCapabilityTier.biometric ||
          tier == AuthCapabilityTier.deviceCredential;

      debugPrint('BiometricLogin: canUse=$supported (tier=$tier)');
      return supported;
    } catch (e) {
      debugPrint('BiometricLogin: canUseBiometricLogin error: $e');
      return false;
    }
  }

  /// Get the cached display name for the welcome-back greeting.
  Future<String?> getStoredDisplayName() async {
    try {
      return await _secureStorage.read(key: _displayNameKey);
    } catch (e) {
      debugPrint('BiometricLogin: Failed to read display name: $e');
      return null;
    }
  }

  /// Cache the user's display name for the next welcome-back screen.
  Future<void> cacheDisplayName(String displayName) async {
    try {
      await _secureStorage.write(key: _displayNameKey, value: displayName);
    } catch (e) {
      debugPrint('BiometricLogin: Failed to cache display name: $e');
    }
  }

  /// Clear the cached display name (e.g., on account deletion).
  Future<void> clearCachedDisplayName() async {
    try {
      await _secureStorage.delete(key: _displayNameKey);
    } catch (e) {
      debugPrint('BiometricLogin: Failed to clear display name: $e');
    }
  }

  /// Record a successful authentication (any method: OTP, biometric, push).
  ///
  /// Resets the inactivity timer so biometric login remains available.
  Future<void> recordSuccessfulAuth() async {
    try {
      final now = DateTime.now().toIso8601String();
      await _secureStorage.write(key: _lastAuthTimeKey, value: now);
    } catch (e) {
      debugPrint('BiometricLogin: Failed to record auth time: $e');
    }
  }

  /// Check if the inactivity threshold has been exceeded.
  ///
  /// Returns true if there is no recorded auth time (first install or
  /// cleared storage) or if the last auth was longer ago than
  /// [inactivityThreshold].
  Future<bool> _isInactivityThresholdExceeded() async {
    try {
      final stored = await _secureStorage.read(key: _lastAuthTimeKey);
      if (stored == null) {
        // No recorded auth — binding was created before this feature existed,
        // or storage was cleared. Treat as expired to force one OTP cycle.
        return true;
      }
      final lastAuth = DateTime.tryParse(stored);
      if (lastAuth == null) return true;
      return DateTime.now().difference(lastAuth) > inactivityThreshold;
    } catch (e) {
      debugPrint('BiometricLogin: Failed to read auth time: $e');
      return true; // Fail safe: require OTP
    }
  }

  /// Attempt biometric login.
  ///
  /// Returns the custom auth token on success, or a [Failure] on error.
  ///
  /// Flow:
  /// 1. Prompt biometric/device credential
  /// 2. Request nonce from server
  /// 3. Sign nonce with hardware key
  /// 4. Verify signature with server → get custom token
  Future<Either<Failure, String>> attemptBiometricLogin() async {
    final deviceId = await _deviceBindingService.getStoredDeviceId();
    final userId = await _deviceBindingService.getStoredUserId();

    if (deviceId == null || userId == null) {
      return const Left(Failure.deviceNotTrusted());
    }

    // Step 1: Biometric/device credential prompt
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Sign in to iMali',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allow PIN/pattern fallback
        ),
      );

      if (!authenticated) {
        debugPrint('BiometricLogin: User cancelled biometric prompt.');
        return const Left(Failure.auth(message: 'Authentication cancelled'));
      }
    } catch (e) {
      debugPrint('BiometricLogin: Biometric prompt error: $e');
      return Left(Failure.auth(message: 'Biometric authentication failed: $e'));
    }

    // Step 2: Request nonce from server
    final String challengeId;
    final String nonce;
    try {
      final callable = _functions.httpsCallable('requestBiometricChallenge');
      final result = await callable.call<Map<String, dynamic>>({
        'deviceId': deviceId,
      });

      challengeId = result.data['challengeId'] as String;
      nonce = result.data['nonce'] as String;
    } on FirebaseFunctionsException catch (e) {
      debugPrint('BiometricLogin: Challenge request failed: ${e.code} ${e.message}');
      return Left(Failure.serverError(
        code: e.code,
        message: e.message ?? 'Failed to request challenge',
      ));
    } catch (e) {
      debugPrint('BiometricLogin: Challenge request error: $e');
      return Left(Failure.unknown(message: 'Challenge request failed: $e'));
    }

    // Step 3: Sign nonce with hardware key
    final alias = KeystoreService.keyAlias(userId);
    final signResult = await _keystoreService.sign(alias, nonce);

    String? signature;
    signResult.fold(
      (failure) {
        debugPrint('BiometricLogin: Nonce signing failed: ${failure.displayMessage}');
      },
      (sig) {
        signature = sig;
      },
    );

    if (signature == null) {
      return Left(signResult.fold(
        (failure) => failure,
        (_) => const Failure.unknown(message: 'Signing returned null'),
      ));
    }

    // Step 4: Verify signature with server
    try {
      final callable = _functions.httpsCallable('verifyBiometricChallenge');
      final result = await callable.call<Map<String, dynamic>>({
        'challengeId': challengeId,
        'signedNonce': signature,
        'deviceId': deviceId,
      });

      final customToken = result.data['customToken'] as String?;
      if (customToken == null) {
        return const Left(Failure.auth(message: 'No token returned'));
      }

      debugPrint('BiometricLogin: Success — custom token received.');
      return Right(customToken);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('BiometricLogin: Verification failed: ${e.code} ${e.message}');
      return Left(Failure.serverError(
        code: e.code,
        message: e.message ?? 'Verification failed',
      ));
    } catch (e) {
      debugPrint('BiometricLogin: Verification error: $e');
      return Left(Failure.unknown(message: 'Verification failed: $e'));
    }
  }
}
