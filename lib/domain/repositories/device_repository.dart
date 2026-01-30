import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/trusted_device.dart';

/// Repository interface for device trust management.
///
/// All write operations are performed server-side via Cloud Functions.
/// Client can only read device data for the authenticated user.
abstract class DeviceRepository {
  /// Register the current device as trusted.
  ///
  /// Sends the public key, FCM token, and device metadata to the server.
  /// The server stores the device record and returns the device ID.
  Future<Either<Failure, TrustedDevice>> registerDevice({
    required String publicKeyPem,
    required String fcmToken,
    required String platform,
    required String deviceModel,
    required String osVersion,
    required String appVersion,
    required String manufacturer,
    required bool hardwareBacked,
    required bool strongBox,
  });

  /// Check if the current device is trusted for the authenticated user.
  Future<Either<Failure, bool>> isDeviceTrusted(String deviceId);

  /// Get all trusted devices for the authenticated user.
  Future<Either<Failure, List<TrustedDevice>>> getUserDevices();

  /// Revoke a device's trust status.
  ///
  /// This is a server-side operation that marks the device as revoked.
  Future<Either<Failure, void>> revokeDevice(String deviceId);

  /// Update the FCM token for a registered device.
  Future<Either<Failure, void>> updateFcmToken({
    required String deviceId,
    required String fcmToken,
  });
}
