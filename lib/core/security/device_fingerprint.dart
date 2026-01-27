/// Device Fingerprint Service
/// Tracks device information for security purposes
library;

import 'dart:io';

import 'package:flutter/foundation.dart';

class DeviceFingerprint {
  String? deviceId;
  String? platform;
  String? osVersion;
  String? appVersion;
  String? locale;
  bool? isEmulator;

  DeviceFingerprint({
    this.deviceId,
    this.platform,
    this.osVersion,
    this.appVersion,
    this.locale,
    this.isEmulator,
  });

  /// Generate fingerprint from current device
  static Future<DeviceFingerprint> generate() async {
    return DeviceFingerprint(
      deviceId: await _getDeviceId(),
      platform: _getPlatform(),
      osVersion: _getOsVersion(),
      appVersion: '1.0.0', // Would come from package_info_plus
      locale: Platform.localeName,
      isEmulator: await _checkIsEmulator(),
    );
  }

  static Future<String> _getDeviceId() async {
    // In production, use device_info_plus package
    // This is a placeholder implementation
    return 'device_${DateTime.now().millisecondsSinceEpoch}';
  }

  static String _getPlatform() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return 'unknown';
  }

  static String _getOsVersion() {
    return Platform.operatingSystemVersion;
  }

  static Future<bool> _checkIsEmulator() async {
    // In production, implement proper emulator detection
    // For now, return false
    return false;
  }

  /// Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'platform': platform,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'locale': locale,
      'isEmulator': isEmulator,
      'collectedAt': DateTime.now().toIso8601String(),
    };
  }

  /// Calculate fingerprint hash
  String get hash {
    final data = '$deviceId|$platform|$osVersion';
    return data.hashCode.toRadixString(16);
  }

  /// Check if device seems suspicious
  bool get isSuspicious {
    // Flag if emulator
    if (isEmulator == true) return true;

    // Flag if no device ID
    if (deviceId == null || deviceId!.isEmpty) return true;

    return false;
  }
}

/// Device binding for account security
class DeviceBinding {
  final String oddienceUserId;
  final String deviceId;
  final String deviceFingerprint;
  final DateTime boundAt;
  final bool isPrimary;

  DeviceBinding({
    required this.oddienceUserId,
    required this.deviceId,
    required this.deviceFingerprint,
    required this.boundAt,
    this.isPrimary = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'oddienceUserId': oddienceUserId,
      'deviceId': deviceId,
      'deviceFingerprint': deviceFingerprint,
      'boundAt': boundAt.toIso8601String(),
      'isPrimary': isPrimary,
    };
  }

  factory DeviceBinding.fromMap(Map<String, dynamic> map) {
    return DeviceBinding(
      oddienceUserId: map['oddienceUserId'] as String,
      deviceId: map['deviceId'] as String,
      deviceFingerprint: map['deviceFingerprint'] as String,
      boundAt: DateTime.parse(map['boundAt'] as String),
      isPrimary: map['isPrimary'] as bool? ?? false,
    );
  }
}
