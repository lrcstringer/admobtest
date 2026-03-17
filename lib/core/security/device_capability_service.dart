import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

/// Authentication capability tiers, ordered by security strength.
enum AuthCapabilityTier {
  /// Tier 1: Biometric hardware available (fingerprint/face)
  biometric,

  /// Tier 2: No biometrics, but device screen lock is set (PIN/pattern/password)
  deviceCredential,

  /// Tier 3: No screen lock configured — requires in-app PIN
  inAppPin,

  /// Tier 4: Secure storage broken (rooted/compromised) — OTP only
  otpOnly,
}

/// Detects the device's authentication capability tier.
///
/// The tier determines which unlock method is used for session lock:
/// - Tier 1 (biometric): Fingerprint / Face
/// - Tier 2 (deviceCredential): OS PIN / Pattern / Password
/// - Tier 3 (inAppPin): In-app 4-6 digit PIN
/// - Tier 4 (otpOnly): OTP re-verification only
@lazySingleton
class DeviceCapabilityService {
  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;

  AuthCapabilityTier? _cachedTier;

  DeviceCapabilityService(
    this._localAuth,
    this._secureStorage,
  );

  /// Detect and return the device's authentication capability tier.
  /// Result is cached after first detection.
  Future<AuthCapabilityTier> detectCapabilityTier() async {
    if (_cachedTier != null) return _cachedTier!;

    _cachedTier = await _detectTier();
    return _cachedTier!;
  }

  /// Force re-detection (e.g., after user enables screen lock).
  Future<AuthCapabilityTier> refreshCapabilityTier() async {
    _cachedTier = null;
    return detectCapabilityTier();
  }

  Future<AuthCapabilityTier> _detectTier() async {
    // Check if secure storage is functional (Tier 4 check)
    if (!await _isSecureStorageFunctional()) {
      return AuthCapabilityTier.otpOnly;
    }

    // Check if biometrics are available (Tier 1 check)
    try {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (canCheckBiometrics) {
        final availableBiometrics = await _localAuth.getAvailableBiometrics();
        if (availableBiometrics.isNotEmpty) {
          return AuthCapabilityTier.biometric;
        }
      }
    } catch (e) {
    }

    // Check if device has screen lock configured (Tier 2 check)
    try {
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      if (isDeviceSupported) {
        return AuthCapabilityTier.deviceCredential;
      }
    } catch (e) {
    }

    // No biometrics, no screen lock → Tier 3 (in-app PIN)
    return AuthCapabilityTier.inAppPin;
  }

  /// Test if secure storage is writable (detects rooted/compromised devices).
  Future<bool> _isSecureStorageFunctional() async {
    try {
      const testKey = 'imali_secure_storage_test';
      const testValue = 'test_value';
      await _secureStorage.write(key: testKey, value: testValue);
      final readBack = await _secureStorage.read(key: testKey);
      await _secureStorage.delete(key: testKey);
      return readBack == testValue;
    } catch (e) {
      return false;
    }
  }
}
