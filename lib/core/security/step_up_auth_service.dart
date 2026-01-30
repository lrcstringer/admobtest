import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

import '../../domain/entities/risk_event.dart';
import 'audit_logger.dart';
import 'device_capability_service.dart';
import 'session_lock_service.dart';

/// Result of a step-up authentication request.
enum StepUpResult {
  /// No step-up needed — proceed normally.
  notRequired,

  /// Biometric/PIN verification succeeded.
  biometricVerified,

  /// OTP re-verification required — caller should navigate to step-up OTP screen.
  otpRequired,

  /// User cancelled the step-up prompt.
  cancelled,

  /// Step-up verification failed.
  failed,
}

/// Determines and performs step-up authentication based on risk level.
///
/// Decision matrix:
/// - Low risk → proceed (no step-up)
/// - Medium risk → biometric/PIN prompt
/// - High risk → full OTP re-verification
/// - Critical risk → block action, require OTP
@lazySingleton
class StepUpAuthService {
  final DeviceCapabilityService _capabilityService;
  final LocalAuthentication _localAuth;
  final SessionLockService _sessionLockService;
  final AuditLogger _auditLogger;

  String? _currentUserId;

  StepUpAuthService(
    this._capabilityService,
    this._localAuth,
    this._sessionLockService,
    this._auditLogger,
  );

  /// Set the current user ID for audit logging.
  void setUserId(String? userId) {
    _currentUserId = userId;
  }

  /// Determine the required step-up level for a given action.
  ///
  /// [actionType] describes what the user is trying to do.
  /// [amount] is the transaction amount (if applicable).
  /// [riskEvents] are any pending risk events for the user.
  StepUpResult evaluateRequired({
    required String actionType,
    double? amount,
    List<RiskEvent>? riskEvents,
  }) {
    // Check for pending high-severity risk events
    final hasPendingHighRisk = riskEvents?.any(
          (e) =>
              e.requiresAction &&
              (e.severity == RiskSeverity.high ||
                  e.severity == RiskSeverity.critical),
        ) ??
        false;

    if (hasPendingHighRisk) {
      _logStepUp(AuthAction.stepUpRequired, success: true);
      return StepUpResult.otpRequired;
    }

    // Check for pending medium-severity risk events
    final hasPendingMediumRisk = riskEvents?.any(
          (e) => e.requiresAction && e.severity == RiskSeverity.medium,
        ) ??
        false;

    if (hasPendingMediumRisk) {
      return StepUpResult.biometricVerified;
    }

    // Evaluate based on action type and amount
    switch (actionType) {
      case 'cashout':
      case 'large_transfer':
        if (amount != null && amount >= 5000) {
          return StepUpResult.otpRequired;
        }
        if (amount != null && amount >= 1000) {
          return StepUpResult.biometricVerified;
        }
        return StepUpResult.notRequired;

      case 'profile_change':
      case 'security_settings':
        return StepUpResult.biometricVerified;

      case 'device_revoke':
      case 'account_delete':
        return StepUpResult.otpRequired;

      default:
        return StepUpResult.notRequired;
    }
  }

  /// Perform biometric/PIN step-up verification.
  ///
  /// Returns [StepUpResult.biometricVerified] on success.
  /// Falls back to tier-appropriate unlock method.
  Future<StepUpResult> performBiometricStepUp() async {
    final tier = await _capabilityService.detectCapabilityTier();

    switch (tier) {
      case AuthCapabilityTier.biometric:
        return _attemptBiometric(biometricOnly: true);

      case AuthCapabilityTier.deviceCredential:
        return _attemptBiometric(biometricOnly: false);

      case AuthCapabilityTier.inAppPin:
        // For in-app PIN, the caller needs to show the PIN entry UI
        // and call verifyPinStepUp() separately
        return StepUpResult.otpRequired;

      case AuthCapabilityTier.otpOnly:
        return StepUpResult.otpRequired;
    }
  }

  /// Verify an in-app PIN for step-up auth (Tier 3 devices).
  Future<StepUpResult> verifyPinStepUp(String pin) async {
    final result = await _sessionLockService.attemptUnlock(pin: pin);

    switch (result) {
      case UnlockResult.success:
        return StepUpResult.biometricVerified;
      case UnlockResult.failed:
        return StepUpResult.failed;
      case UnlockResult.requiresFullReauth:
        return StepUpResult.otpRequired;
      case UnlockResult.cancelled:
        return StepUpResult.cancelled;
    }
  }

  Future<StepUpResult> _attemptBiometric({required bool biometricOnly}) async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Verify your identity to continue',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: biometricOnly,
        ),
      );

      if (authenticated) {
        _logStepUp(AuthAction.stepUpCompleted, success: true);
        return StepUpResult.biometricVerified;
      }
      _logStepUp(AuthAction.stepUpCompleted, success: false);
      return StepUpResult.cancelled;
    } catch (e) {
      debugPrint('Step-up biometric failed: $e');
      _logStepUp(AuthAction.stepUpCompleted,
          success: false, error: e.toString());
      return StepUpResult.failed;
    }
  }

  void _logStepUp(AuthAction action,
      {required bool success, String? error}) {
    final userId = _currentUserId;
    if (userId == null) return;
    _auditLogger.logAuthEvent(
      userId: userId,
      action: action,
      success: success,
      errorMessage: error,
    );
  }
}
