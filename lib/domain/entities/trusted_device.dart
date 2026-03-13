import 'package:freezed_annotation/freezed_annotation.dart';

part 'trusted_device.freezed.dart';
part 'trusted_device.g.dart';

/// Represents a trusted device registered for cryptographic authentication.
@freezed
abstract class TrustedDevice with _$TrustedDevice {
  const factory TrustedDevice({
    required String deviceId,
    required String userId,
    required String publicKeyPem,
    required String platform,
    required bool trusted,
    required bool revoked,
    required DateTime registeredAt,
    DateTime? lastUsedAt,
    String? fcmToken,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    String? manufacturer,
    bool? hardwareBacked,
    bool? strongBox,
  }) = _TrustedDevice;

  const TrustedDevice._();

  factory TrustedDevice.fromJson(Map<String, dynamic> json) =>
      _$TrustedDeviceFromJson(json);

  /// Whether this device is currently active and trusted.
  bool get isActive => trusted && !revoked;
}
