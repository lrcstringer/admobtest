import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

import 'device_capability_service.dart';
import 'pin_manager.dart';

/// Result of checking whether the session needs to be locked.
enum SessionLockResult {
  /// No lock needed (app was in background briefly).
  noLockNeeded,

  /// Session lock required — use tier-appropriate unlock.
  sessionLockRequired,

  /// Full re-authentication required (OTP) — too long in background.
  fullReauthRequired,
}

/// Result of an unlock attempt.
enum UnlockResult {
  /// Unlock succeeded.
  success,

  /// Unlock failed (wrong PIN, biometric rejected, etc.).
  failed,

  /// Requires full OTP re-authentication (lockout or Tier 4).
  requiresFullReauth,

  /// User cancelled the unlock prompt.
  cancelled,
}

/// Manages app session locking based on background duration.
///
/// Timeouts:
/// - 30 seconds background → tier-appropriate session lock
/// - 5 minutes background → full OTP re-auth regardless of tier
@lazySingleton
class SessionLockService {
  final DeviceCapabilityService _capabilityService;
  final LocalAuthentication _localAuth;
  final PinManager _pinManager;

  DateTime? _backgroundTimestamp;
  bool _isLocked = false;

  static const _sessionLockDuration = Duration(seconds: 30);
  static const _fullReauthDuration = Duration(minutes: 5);

  SessionLockService(
    this._capabilityService,
    this._localAuth,
    this._pinManager,
  );

  /// Whether the session is currently locked.
  bool get isLocked => _isLocked;

  /// Call when app goes to background.
  void onAppPaused() {
    _backgroundTimestamp = DateTime.now();
    debugPrint('Session: app paused at $_backgroundTimestamp');
  }

  /// Call when app returns to foreground.
  ///
  /// Returns the required lock action based on background duration.
  SessionLockResult onAppResumed() {
    if (_backgroundTimestamp == null) {
      return SessionLockResult.noLockNeeded;
    }

    final elapsed = DateTime.now().difference(_backgroundTimestamp!);
    _backgroundTimestamp = null;

    if (elapsed >= _fullReauthDuration) {
      _isLocked = true;
      debugPrint('Session: full re-auth required (${elapsed.inSeconds}s)');
      return SessionLockResult.fullReauthRequired;
    }

    if (elapsed >= _sessionLockDuration) {
      _isLocked = true;
      debugPrint('Session: lock required (${elapsed.inSeconds}s)');
      return SessionLockResult.sessionLockRequired;
    }

    debugPrint('Session: no lock needed (${elapsed.inSeconds}s)');
    return SessionLockResult.noLockNeeded;
  }

  /// Attempt to unlock the session using the tier-appropriate method.
  ///
  /// For Tier 3 (in-app PIN), pass the [pin] parameter.
  /// For Tier 1/2 (biometric/device credential), [pin] is ignored.
  Future<UnlockResult> attemptUnlock({String? pin}) async {
    final tier = await _capabilityService.detectCapabilityTier();

    switch (tier) {
      case AuthCapabilityTier.biometric:
        return _attemptBiometricUnlock();

      case AuthCapabilityTier.deviceCredential:
        return _attemptDeviceCredentialUnlock();

      case AuthCapabilityTier.inAppPin:
        if (pin == null) return UnlockResult.failed;
        return _attemptPinUnlock(pin);

      case AuthCapabilityTier.otpOnly:
        return UnlockResult.requiresFullReauth;
    }
  }

  /// Mark the session as unlocked.
  void markUnlocked() {
    _isLocked = false;
    _backgroundTimestamp = null;
  }

  /// Force lock the session (e.g., when SIM change is detected).
  void forceLock() {
    _isLocked = true;
  }

  /// Get remaining PIN attempts (for Tier 3 UI).
  Future<int> getRemainingPinAttempts() {
    return _pinManager.getRemainingAttempts();
  }

  /// Get the current capability tier.
  Future<AuthCapabilityTier> getCapabilityTier() {
    return _capabilityService.detectCapabilityTier();
  }

  Future<UnlockResult> _attemptBiometricUnlock() async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Unlock iMaliChat',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        _isLocked = false;
        return UnlockResult.success;
      }

      // Biometric failed — fall back to device credential
      return _attemptDeviceCredentialUnlock();
    } catch (e) {
      debugPrint('Biometric unlock failed: $e');
      // Fall back to device credential
      return _attemptDeviceCredentialUnlock();
    }
  }

  Future<UnlockResult> _attemptDeviceCredentialUnlock() async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Unlock iMaliChat',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (authenticated) {
        _isLocked = false;
        return UnlockResult.success;
      }

      return UnlockResult.cancelled;
    } catch (e) {
      debugPrint('Device credential unlock failed: $e');
      return UnlockResult.failed;
    }
  }

  Future<UnlockResult> _attemptPinUnlock(String pin) async {
    final result = await _pinManager.verifyPin(pin);

    switch (result) {
      case PinVerifyResult.success:
        _isLocked = false;
        return UnlockResult.success;

      case PinVerifyResult.incorrect:
        return UnlockResult.failed;

      case PinVerifyResult.lockedOut:
        return UnlockResult.requiresFullReauth;

      case PinVerifyResult.noPinSet:
        return UnlockResult.requiresFullReauth;
    }
  }
}
