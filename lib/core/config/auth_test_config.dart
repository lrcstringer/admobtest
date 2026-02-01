import 'package:flutter/foundation.dart';

/// Auth flow test modes for development.
///
/// Only active in debug builds (`kDebugMode`).
/// In release builds, always behaves as [AuthTestMode.normal].
enum AuthTestMode {
  /// Production behavior — biometric if available, else standard welcome.
  normal('NRM'),

  /// Always show biometric login UI (even if no device binding exists).
  forceBiometric('BIO'),

  /// Skip biometric, go straight to phone/OTP flow.
  forceOtp('OTP'),

  /// Skip biometric, force push login path (for multi-device testing).
  forcePushLogin('PUSH'),

  /// Always show fresh welcome screen (no returning user detection).
  forceWelcome('NEW');

  final String badge;
  const AuthTestMode(this.badge);
}

/// Global test configuration for the auth flow.
///
/// Only modifiable in debug builds. In release, [mode] always returns
/// [AuthTestMode.normal].
class AuthTestConfig {
  static AuthTestMode _mode = AuthTestMode.normal;

  static AuthTestMode get mode => kDebugMode ? _mode : AuthTestMode.normal;

  static set mode(AuthTestMode value) {
    if (kDebugMode) _mode = value;
  }

  /// Cycle to the next test mode. Returns the new mode.
  static AuthTestMode cycleMode() {
    if (!kDebugMode) return AuthTestMode.normal;
    final values = AuthTestMode.values;
    final nextIndex = (values.indexOf(_mode) + 1) % values.length;
    _mode = values[nextIndex];
    return _mode;
  }
}
