import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../error/failures.dart';
import '../../domain/entities/trusted_device.dart';
import '../../domain/repositories/device_repository.dart';
import '../services/media_recovery_service.dart';
import 'audit_logger.dart';
import 'keystore_service.dart';

/// Orchestrates device binding: keypair generation, metadata collection,
/// and server registration.
///
/// After successful OTP verification, this service binds the current device
/// by generating a cryptographic keypair and registering it server-side.
/// Failure does NOT block authentication — it degrades gracefully.
@lazySingleton
class DeviceBindingService {
  final KeystoreService _keystoreService;
  final DeviceRepository _deviceRepository;
  final FirebaseMessaging _firebaseMessaging;
  final FlutterSecureStorage _secureStorage;
  final AuditLogger _auditLogger;
  final MediaRecoveryService _mediaRecoveryService;
  final DeviceInfoPlugin _deviceInfo;

  static const _deviceIdKey = 'imali_bound_device_id';
  static const _deviceTrustedKey = 'imali_device_trusted';
  static const _userIdKey = 'imali_bound_user_id';

  DeviceBindingService(
    this._keystoreService,
    this._deviceRepository,
    this._firebaseMessaging,
    this._secureStorage,
    this._auditLogger,
    this._mediaRecoveryService,
  ) : _deviceInfo = DeviceInfoPlugin();

  /// Bind the current device for the given user.
  ///
  /// 1. Generate ECDSA keypair in hardware-backed storage
  /// 2. Collect device metadata and FCM token
  /// 3. Register with server via Cloud Function
  /// 4. Cache device ID locally
  ///
  /// Returns the registered [TrustedDevice] or a [Failure].
  /// This should be called after successful OTP verification.
  Future<Either<Failure, TrustedDevice>> bindCurrentDevice(
      String userId) async {
    try {
      // Step 1: Generate keypair
      final alias = KeystoreService.keyAlias(userId);
      final keyResult = await _keystoreService.generateKeyPair(alias);

      return keyResult.fold(
        (failure) {
          return Left(failure);
        },
        (keyGenResult) async {
          // Step 2: Collect device metadata
          final metadata = await _collectDeviceMetadata();
          final fcmToken = await _getFcmToken();

          if (fcmToken == null) {
            return const Left(
                Failure.unknown(message: 'FCM token unavailable'));
          }

          // Step 3: Register with server
          final result = await _deviceRepository.registerDevice(
            publicKeyPem: keyGenResult.publicKeyPem,
            fcmToken: fcmToken,
            platform: metadata['platform'] as String,
            deviceModel: metadata['model'] as String,
            osVersion: metadata['osVersion'] as String,
            appVersion: '1.0.0',
            manufacturer: metadata['manufacturer'] as String,
            hardwareBacked: keyGenResult.hardwareBacked,
            strongBox: keyGenResult.strongBox,
          );

          return result.fold(
            (failure) {
              return Left(failure);
            },
            (device) async {
              // Step 4: Cache locally
              await _cacheDeviceBinding(device.deviceId, userId);
              _auditLogger.logAuthEvent(
                userId: userId,
                action: AuthAction.deviceBound,
              );
              // Step 5: Initialize payload recovery (non-blocking).
              // CRITICAL: After init, ensure the TEE-wrapped blob is stored
              // on the device doc. On first install, initialize() may have run
              // before the device doc existed (race with E2EE key init), so
              // the blob would be missing — ensureBlobStored fixes this.
              _mediaRecoveryService.initialize().then((_) {
                return _mediaRecoveryService
                    .ensureBlobStored(device.deviceId);
              }).catchError((e) {
              });
              return Right(device);
            },
          );
        },
      );
    } catch (e) {
      _auditLogger.logAuthEvent(
        userId: userId,
        action: AuthAction.deviceBindingFailed,
        success: false,
        errorMessage: e.toString(),
      );
      return Left(Failure.unknown(message: 'Device binding failed: $e'));
    }
  }

  /// Check if the current device is trusted (local cache first, then server).
  Future<bool> isCurrentDeviceTrusted(String userId) async {
    // Fast path: check local cache
    try {
      final cachedTrusted = await _secureStorage.read(key: _deviceTrustedKey);
      if (cachedTrusted == 'true') {
        return true;
      }
    } catch (e) {
    }

    // Slow path: check server
    final deviceId = await getCachedDeviceId();
    if (deviceId == null) return false;

    final result = await _deviceRepository.isDeviceTrusted(deviceId);
    return result.fold(
      (_) => false,
      (isTrusted) {
        if (isTrusted) {
          _secureStorage.write(key: _deviceTrustedKey, value: 'true');
        }
        return isTrusted;
      },
    );
  }

  /// Get the cached device ID from secure storage.
  Future<String?> getCachedDeviceId() async {
    try {
      return await _secureStorage.read(key: _deviceIdKey);
    } catch (e) {
      return null;
    }
  }

  /// Alias for [getCachedDeviceId] — used by challenge approval flow.
  Future<String?> getStoredDeviceId() => getCachedDeviceId();

  /// Get the cached user ID from secure storage.
  Future<String?> getStoredUserId() async {
    try {
      return await _secureStorage.read(key: _userIdKey);
    } catch (e) {
      return null;
    }
  }

  /// Check if a keypair exists for the given user.
  Future<bool> hasKeypair(String userId) async {
    final alias = KeystoreService.keyAlias(userId);
    final result = await _keystoreService.hasKey(alias);
    return result.fold((_) => false, (hasKey) => hasKey);
  }

  /// Clear local device binding state (used on sign out).
  Future<void> clearBinding() async {
    try {
      await _mediaRecoveryService.clear();
      await _secureStorage.delete(key: _deviceIdKey);
      await _secureStorage.delete(key: _deviceTrustedKey);
      await _secureStorage.delete(key: _userIdKey);
    } catch (e) {
    }
  }

  /// Delete the hardware-backed ECDSA keypair for a given user.
  /// Called during account deletion to remove cryptographic material.
  Future<void> deleteKeypair(String userId) async {
    try {
      final alias = KeystoreService.keyAlias(userId);
      await _keystoreService.deleteKey(alias);
    } catch (e) {
    }
  }

  Future<void> _cacheDeviceBinding(String deviceId, String userId) async {
    try {
      await _secureStorage.write(key: _deviceIdKey, value: deviceId);
      await _secureStorage.write(key: _deviceTrustedKey, value: 'true');
      await _secureStorage.write(key: _userIdKey, value: userId);
    } catch (e) {
    }
  }

  Future<String?> _getFcmToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, String>> _collectDeviceMetadata() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return {
          'platform': 'android',
          'model': info.model,
          'manufacturer': info.manufacturer,
          'osVersion': 'Android ${info.version.release} (SDK ${info.version.sdkInt})',
        };
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return {
          'platform': 'ios',
          'model': info.model,
          'manufacturer': 'Apple',
          'osVersion': '${info.systemName} ${info.systemVersion}',
        };
      }
    } catch (e) {
    }

    return {
      'platform': Platform.operatingSystem,
      'model': 'unknown',
      'manufacturer': 'unknown',
      'osVersion': Platform.operatingSystemVersion,
    };
  }

}
