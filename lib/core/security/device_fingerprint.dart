/// Device Fingerprint Service
/// Tracks device information for security purposes
library;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceFingerprint {
  String? deviceId;
  String? platform;
  String? osVersion;
  String? appVersion;
  String? locale;
  bool? isEmulator;
  String? manufacturer;
  String? model;

  DeviceFingerprint({
    this.deviceId,
    this.platform,
    this.osVersion,
    this.appVersion,
    this.locale,
    this.isEmulator,
    this.manufacturer,
    this.model,
  });

  /// Generate fingerprint from current device using device_info_plus.
  static Future<DeviceFingerprint> generate() async {
    final deviceInfo = DeviceInfoPlugin();
    String? deviceId;
    String? manufacturer;
    String? model;
    bool isEmulator = false;

    try {
      if (!kIsWeb && Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        deviceId = info.id;
        manufacturer = info.manufacturer;
        model = info.model;
        isEmulator = !info.isPhysicalDevice;
      } else if (!kIsWeb && Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        deviceId = info.identifierForVendor;
        manufacturer = 'Apple';
        model = info.model;
        isEmulator = !info.isPhysicalDevice;
      }
    } catch (e) {
      debugPrint('Failed to get device info: $e');
    }

    return DeviceFingerprint(
      deviceId: deviceId ?? 'unknown_${DateTime.now().millisecondsSinceEpoch}',
      platform: _getPlatform(),
      osVersion: _getOsVersion(),
      appVersion: '1.0.0',
      locale: Platform.localeName,
      isEmulator: isEmulator,
      manufacturer: manufacturer,
      model: model,
    );
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

  /// Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'platform': platform,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'locale': locale,
      'isEmulator': isEmulator,
      'manufacturer': manufacturer,
      'model': model,
      'collectedAt': DateTime.now().toIso8601String(),
    };
  }

  /// Calculate fingerprint hash
  String get hash {
    final data = '$deviceId|$platform|$osVersion|$manufacturer|$model';
    return data.hashCode.toRadixString(16);
  }

  /// Check if device seems suspicious
  bool get isSuspicious {
    if (isEmulator == true) return true;
    if (deviceId == null || deviceId!.isEmpty) return true;
    return false;
  }
}

/// Device binding for account security
class DeviceBinding {
  final String userId;
  final String deviceId;
  final String deviceFingerprint;
  final DateTime boundAt;
  final bool isPrimary;

  DeviceBinding({
    required this.userId,
    required this.deviceId,
    required this.deviceFingerprint,
    required this.boundAt,
    this.isPrimary = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'deviceId': deviceId,
      'deviceFingerprint': deviceFingerprint,
      'boundAt': boundAt.toIso8601String(),
      'isPrimary': isPrimary,
    };
  }

  factory DeviceBinding.fromMap(Map<String, dynamic> map) {
    return DeviceBinding(
      userId: map['userId'] as String,
      deviceId: map['deviceId'] as String,
      deviceFingerprint: map['deviceFingerprint'] as String,
      boundAt: DateTime.parse(map['boundAt'] as String),
      isPrimary: map['isPrimary'] as bool? ?? false,
    );
  }
}
