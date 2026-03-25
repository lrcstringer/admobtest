// ignore_for_file: empty_catches
/// Device Fingerprint Service
/// Tracks device information for fraud detection and security purposes.
/// All signals are collected within-app only (no cross-app tracking).
library;

import 'dart:convert';
import 'dart:io';
import 'dart:ui' show PlatformDispatcher;

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceFingerprint {
  // Core identifiers
  String? deviceId;
  String? platform;
  String? osVersion;
  String? appVersion;
  String? locale;
  bool? isEmulator;
  String? manufacturer;
  String? model;

  // Enhanced signals
  String? screenResolution;
  double? screenDensity;
  String? timezone;
  int? timezoneOffsetMinutes;
  String? networkType;
  int? batteryLevel;
  String? batteryState;
  int? systemMemoryMb;
  int? processorCount;

  DeviceFingerprint({
    this.deviceId,
    this.platform,
    this.osVersion,
    this.appVersion,
    this.locale,
    this.isEmulator,
    this.manufacturer,
    this.model,
    this.screenResolution,
    this.screenDensity,
    this.timezone,
    this.timezoneOffsetMinutes,
    this.networkType,
    this.batteryLevel,
    this.batteryState,
    this.systemMemoryMb,
    this.processorCount,
  });

  /// Generate fingerprint from current device.
  static Future<DeviceFingerprint> generate() async {
    final deviceInfo = DeviceInfoPlugin();
    String? deviceId;
    String? manufacturer;
    String? model;
    bool isEmulator = false;
    int? systemMemoryMb;

    try {
      if (!kIsWeb && Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        deviceId = info.id;
        manufacturer = info.manufacturer;
        model = info.model;
        isEmulator = !info.isPhysicalDevice;
        systemMemoryMb = info.systemFeatures.length; // proxy signal
      } else if (!kIsWeb && Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        deviceId = info.identifierForVendor;
        manufacturer = 'Apple';
        model = info.model;
        isEmulator = !info.isPhysicalDevice;
      }
    } catch (e) {
    }

    // Screen signals (no extra package needed)
    String? screenResolution;
    double? screenDensity;
    try {
      final display = PlatformDispatcher.instance.displays.firstOrNull;
      if (display != null) {
        final size = display.size;
        screenResolution =
            '${size.width.toInt()}x${size.height.toInt()}';
        screenDensity = display.devicePixelRatio;
      }
    } catch (e) {
    }

    // Timezone signals
    final now = DateTime.now();
    final timezone = now.timeZoneName;
    final timezoneOffsetMinutes = now.timeZoneOffset.inMinutes;

    // Network type
    String? networkType;
    try {
      final connectivity = Connectivity();
      final results = await connectivity.checkConnectivity();
      networkType = results
          .map((r) => r.name)
          .join(',');
    } catch (e) {
    }

    // Battery signals
    int? batteryLevel;
    String? batteryState;
    try {
      final battery = Battery();
      batteryLevel = await battery.batteryLevel;
      final state = await battery.batteryState;
      batteryState = state.name;
    } catch (e) {
    }

    return DeviceFingerprint(
      deviceId: deviceId ?? 'unknown_${now.millisecondsSinceEpoch}',
      platform: _getPlatform(),
      osVersion: _getOsVersion(),
      appVersion: '1.0.0',
      locale: Platform.localeName,
      isEmulator: isEmulator,
      manufacturer: manufacturer,
      model: model,
      screenResolution: screenResolution,
      screenDensity: screenDensity,
      timezone: timezone,
      timezoneOffsetMinutes: timezoneOffsetMinutes,
      networkType: networkType,
      batteryLevel: batteryLevel,
      batteryState: batteryState,
      systemMemoryMb: systemMemoryMb,
      processorCount: Platform.numberOfProcessors,
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
      'screenResolution': screenResolution,
      'screenDensity': screenDensity,
      'timezone': timezone,
      'timezoneOffsetMinutes': timezoneOffsetMinutes,
      'networkType': networkType,
      'batteryLevel': batteryLevel,
      'batteryState': batteryState,
      'processorCount': processorCount,
      'collectedAt': DateTime.now().toIso8601String(),
    };
  }

  /// SHA-256 fingerprint hash of stable device attributes.
  /// Excludes volatile signals (battery, network) that change between sessions.
  String get hash {
    final data = [
      deviceId,
      platform,
      osVersion,
      manufacturer,
      model,
      screenResolution,
      screenDensity?.toStringAsFixed(1),
      locale,
      processorCount?.toString(),
    ].join('|');
    return sha256.convert(utf8.encode(data)).toString();
  }

  /// Risk signals that indicate the device may be fraudulent or compromised.
  /// Returns a list of triggered risk signals (empty = clean).
  List<String> get riskSignals {
    final signals = <String>[];

    if (isEmulator == true) {
      signals.add('emulator_detected');
    }
    if (deviceId == null || deviceId!.isEmpty) {
      signals.add('missing_device_id');
    }

    // Fixed battery level is a strong emulator indicator —
    // real devices rarely sit at exactly 50% or 100% while not charging
    if (batteryLevel == 50 && batteryState != 'charging') {
      signals.add('suspicious_battery_fixed_50');
    }

    // Battery state "unknown" on a non-desktop platform suggests emulator
    if (batteryState == 'unknown' && platform != 'web') {
      signals.add('battery_state_unknown');
    }

    // South African timezone expected for iMali users (UTC+2)
    // Non-SAST timezone is a risk signal (not a block — users may travel)
    if (timezoneOffsetMinutes != null && timezoneOffsetMinutes != 120) {
      signals.add('non_sast_timezone');
    }

    // VPN-only connectivity is a soft risk signal
    if (networkType != null && networkType!.contains('vpn')) {
      signals.add('vpn_detected');
    }

    return signals;
  }

  /// Whether the device has any risk signals.
  bool get isSuspicious => riskSignals.isNotEmpty;

  /// Risk level: 0 = clean, 1 = low, 2 = medium, 3 = high
  int get riskLevel {
    final count = riskSignals.length;
    if (count == 0) return 0;
    if (count == 1) return 1;
    if (count <= 3) return 2;
    return 3;
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
