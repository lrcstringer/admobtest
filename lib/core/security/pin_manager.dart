// ignore_for_file: empty_catches
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Manages the in-app PIN for Tier 3 devices (no biometrics, no screen lock).
///
/// PIN is stored as HMAC-SHA256 hash + salt in flutter_secure_storage.
/// The PIN itself never leaves the device and is never transmitted to the server.
@lazySingleton
class PinManager {
  final FlutterSecureStorage _secureStorage;

  static const _pinHashKey = 'imali_pin_hash';
  static const _pinSaltKey = 'imali_pin_salt';
  static const _pinFailedAttemptsKey = 'imali_pin_failed_attempts';
  static const _pinLockedUntilKey = 'imali_pin_locked_until';
  static const int maxFailedAttempts = 5;

  PinManager(this._secureStorage);

  /// Set a new PIN. Validates strength before storing.
  ///
  /// Returns `true` if PIN was set successfully, `false` if PIN is weak.
  Future<bool> setPin(String pin) async {
    if (!_isStrongPin(pin)) {
      return false;
    }

    final salt = _generateSalt();
    final hash = _hashPin(pin, salt);

    await _secureStorage.write(key: _pinHashKey, value: hash);
    await _secureStorage.write(key: _pinSaltKey, value: salt);
    await _resetFailedAttempts();

    return true;
  }

  /// Verify a PIN against the stored hash.
  ///
  /// Returns a [PinVerifyResult] indicating success, failure, or lockout.
  Future<PinVerifyResult> verifyPin(String pin) async {
    // Check if locked out
    final lockedUntilStr = await _secureStorage.read(key: _pinLockedUntilKey);
    if (lockedUntilStr != null) {
      final lockedUntil = DateTime.tryParse(lockedUntilStr);
      if (lockedUntil != null && DateTime.now().isBefore(lockedUntil)) {
        return PinVerifyResult.lockedOut;
      }
      // Lock period expired, reset
      await _resetFailedAttempts();
    }

    final storedHash = await _secureStorage.read(key: _pinHashKey);
    final storedSalt = await _secureStorage.read(key: _pinSaltKey);

    if (storedHash == null || storedSalt == null) {
      return PinVerifyResult.noPinSet;
    }

    final inputHash = _hashPin(pin, storedSalt);

    // Constant-time comparison to prevent timing attacks
    if (_constantTimeEquals(inputHash, storedHash)) {
      await _resetFailedAttempts();
      return PinVerifyResult.success;
    }

    // Increment failed attempts
    final failedAttempts = await _incrementFailedAttempts();
    final remaining = maxFailedAttempts - failedAttempts;

    if (remaining <= 0) {
      // Lock out — requires OTP re-auth
      return PinVerifyResult.lockedOut;
    }

    return PinVerifyResult.incorrect;
  }

  /// Check if a PIN has been set.
  Future<bool> isPinSet() async {
    try {
      final hash = await _secureStorage.read(key: _pinHashKey);
      return hash != null && hash.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Change PIN (verify old, set new).
  Future<bool> changePin(String oldPin, String newPin) async {
    final result = await verifyPin(oldPin);
    if (result != PinVerifyResult.success) {
      return false;
    }
    return setPin(newPin);
  }

  /// Get the number of remaining attempts before lockout.
  Future<int> getRemainingAttempts() async {
    final attemptsStr =
        await _secureStorage.read(key: _pinFailedAttemptsKey);
    final attempts = int.tryParse(attemptsStr ?? '0') ?? 0;
    return maxFailedAttempts - attempts;
  }

  /// Clear the PIN (used on account deletion/sign out).
  Future<void> clearPin() async {
    try {
      await _secureStorage.delete(key: _pinHashKey);
      await _secureStorage.delete(key: _pinSaltKey);
      await _resetFailedAttempts();
    } catch (e) {
    }
  }

  /// Validate PIN strength.
  ///
  /// Rejects:
  /// - PINs shorter than 4 or longer than 6 digits
  /// - All same digit (e.g., 1111, 0000)
  /// - Sequential ascending (1234, 2345)
  /// - Sequential descending (4321, 9876)
  bool _isStrongPin(String pin) {
    if (pin.length < 4 || pin.length > 6) return false;
    if (!RegExp(r'^\d+$').hasMatch(pin)) return false;

    // All same digit
    if (pin.split('').toSet().length == 1) return false;

    // Sequential ascending
    bool isAscending = true;
    for (int i = 1; i < pin.length; i++) {
      if (int.parse(pin[i]) != int.parse(pin[i - 1]) + 1) {
        isAscending = false;
        break;
      }
    }
    if (isAscending) return false;

    // Sequential descending
    bool isDescending = true;
    for (int i = 1; i < pin.length; i++) {
      if (int.parse(pin[i]) != int.parse(pin[i - 1]) - 1) {
        isDescending = false;
        break;
      }
    }
    if (isDescending) return false;

    return true;
  }

  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }

  String _hashPin(String pin, String salt) {
    final key = utf8.encode(salt);
    final data = utf8.encode(pin);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(data);
    return digest.toString();
  }

  /// Constant-time string comparison to prevent timing attacks.
  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }

  Future<int> _incrementFailedAttempts() async {
    final attemptsStr =
        await _secureStorage.read(key: _pinFailedAttemptsKey);
    final attempts = (int.tryParse(attemptsStr ?? '0') ?? 0) + 1;
    await _secureStorage.write(
        key: _pinFailedAttemptsKey, value: attempts.toString());

    if (attempts >= maxFailedAttempts) {
      // Lock for 30 minutes (or until OTP re-auth)
      final lockUntil =
          DateTime.now().add(const Duration(minutes: 30)).toIso8601String();
      await _secureStorage.write(key: _pinLockedUntilKey, value: lockUntil);
    }

    return attempts;
  }

  Future<void> _resetFailedAttempts() async {
    await _secureStorage.delete(key: _pinFailedAttemptsKey);
    await _secureStorage.delete(key: _pinLockedUntilKey);
  }
}

/// Result of a PIN verification attempt.
enum PinVerifyResult {
  /// PIN matches stored hash.
  success,

  /// PIN does not match. Check remaining attempts.
  incorrect,

  /// Too many failed attempts. Requires OTP re-auth.
  lockedOut,

  /// No PIN has been set yet.
  noPinSet,
}
