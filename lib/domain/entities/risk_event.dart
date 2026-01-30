import 'package:freezed_annotation/freezed_annotation.dart';

part 'risk_event.freezed.dart';

/// Types of risk events that can trigger step-up authentication.
enum RiskEventType {
  /// SIM card changed on the device.
  simChange,

  /// Login from a new geographic location.
  geoChange,

  /// Large financial transaction attempted.
  largeTransaction,

  /// Login from a new/unrecognized device.
  newDevice,

  /// Suspicious activity detected (e.g., multiple failed attempts).
  suspiciousActivity,
}

/// Severity levels for risk events.
enum RiskSeverity {
  /// Low risk — proceed normally, log event.
  low,

  /// Medium risk — require biometric or PIN confirmation.
  medium,

  /// High risk — require full OTP re-verification.
  high,

  /// Critical risk — block action and notify user.
  critical,
}

/// Status of a risk event.
enum RiskEventStatus {
  /// Event detected but not yet resolved.
  pending,

  /// Event resolved after step-up auth.
  resolved,

  /// Event dismissed by the system or admin.
  dismissed,
}

/// A risk event that may require step-up authentication.
@freezed
class RiskEvent with _$RiskEvent {
  const factory RiskEvent({
    required String eventId,
    required String userId,
    required RiskEventType type,
    required RiskSeverity severity,
    required RiskEventStatus status,
    required DateTime createdAt,
    String? deviceId,
    String? details,
    DateTime? resolvedAt,
  }) = _RiskEvent;

  const RiskEvent._();

  /// Whether this event requires user action.
  bool get requiresAction => status == RiskEventStatus.pending;

  /// Whether this event requires OTP verification.
  bool get requiresOtp =>
      severity == RiskSeverity.high || severity == RiskSeverity.critical;

  /// Whether this event requires biometric/PIN verification.
  bool get requiresBiometric => severity == RiskSeverity.medium;
}
