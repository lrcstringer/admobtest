import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

/// Service for Google Play Integrity API
/// Verifies app and device integrity to prevent fraud
class PlayIntegrityService {
  final FirebaseFunctions _functions;
  final Uuid _uuid;

  PlayIntegrityService({
    FirebaseFunctions? functions,
    Uuid? uuid,
  })  : _functions = functions ?? FirebaseFunctions.instance,
        _uuid = uuid ?? const Uuid();

  /// Generate a nonce for integrity check
  String generateNonce() {
    return _uuid.v4();
  }

  /// Request an integrity verification
  /// This should be called on Android only
  Future<IntegrityResult> verifyIntegrity({
    String? nonce,
  }) async {
    // Generate nonce if not provided
    final requestNonce = nonce ?? generateNonce();

    if (!defaultTargetPlatform.isAndroid) {
      // iOS uses App Attest instead
      return IntegrityResult(
        isValid: true,
        verdict: IntegrityVerdict.valid,
        details: 'Non-Android platform',
        nonce: requestNonce,
      );
    }

    try {
      // In production, use the play_integrity plugin to get token
      // final integrityManager = IntegrityManager();
      // final token = await integrityManager.requestIntegrityToken(
      //   IntegrityTokenRequest(nonce: requestNonce)
      // );

      // For now, simulate token - in production this would be real
      const token = 'INTEGRITY_TOKEN_PLACEHOLDER';

      // Verify token with backend
      final response = await _verifyTokenWithBackend(
        token: token,
        nonce: requestNonce,
      );

      return response;
    } catch (e) {
      debugPrint('Play Integrity verification failed: $e');
      return IntegrityResult(
        isValid: false,
        verdict: IntegrityVerdict.error,
        details: e.toString(),
        nonce: requestNonce,
      );
    }
  }

  Future<IntegrityResult> _verifyTokenWithBackend({
    required String token,
    required String nonce,
  }) async {
    try {
      final callable = _functions.httpsCallable('verifyPlayIntegrity');
      final result = await callable.call({
        'token': token,
        'nonce': nonce,
      });

      final data = result.data as Map<String, dynamic>;

      return IntegrityResult(
        isValid: data['isValid'] ?? false,
        verdict: IntegrityVerdict.fromString(data['verdict']),
        details: data['details'] ?? '',
        nonce: nonce,
        deviceRecognition: DeviceRecognition.fromString(data['deviceRecognition']),
        appLicensing: AppLicensing.fromString(data['appLicensing']),
      );
    } catch (e) {
      debugPrint('Backend verification failed: $e');
      return IntegrityResult(
        isValid: false,
        verdict: IntegrityVerdict.error,
        details: e.toString(),
        nonce: nonce,
      );
    }
  }

  /// Check if the device passes minimum integrity requirements
  Future<bool> meetsMinimumRequirements() async {
    final result = await verifyIntegrity();
    return result.isValid &&
        result.verdict != IntegrityVerdict.failedBasic &&
        result.verdict != IntegrityVerdict.error;
  }
}

/// Result of an integrity check
class IntegrityResult {
  final bool isValid;
  final IntegrityVerdict verdict;
  final String details;
  final String nonce;
  final DeviceRecognition? deviceRecognition;
  final AppLicensing? appLicensing;

  IntegrityResult({
    required this.isValid,
    required this.verdict,
    required this.details,
    required this.nonce,
    this.deviceRecognition,
    this.appLicensing,
  });

  factory IntegrityResult.fromJson(Map<String, dynamic> json) {
    return IntegrityResult(
      isValid: json['isValid'] ?? false,
      verdict: IntegrityVerdict.fromString(json['verdict']),
      details: json['details'] ?? '',
      nonce: json['nonce'] ?? '',
      deviceRecognition: json['deviceRecognition'] != null
          ? DeviceRecognition.fromString(json['deviceRecognition'])
          : null,
      appLicensing: json['appLicensing'] != null
          ? AppLicensing.fromString(json['appLicensing'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'isValid': isValid,
        'verdict': verdict.name,
        'details': details,
        'nonce': nonce,
        'deviceRecognition': deviceRecognition?.name,
        'appLicensing': appLicensing?.name,
      };

  @override
  String toString() => jsonEncode(toJson());
}

/// Integrity verdict types
enum IntegrityVerdict {
  valid,
  failedBasic,
  failedDevice,
  failedStrong,
  error;

  static IntegrityVerdict fromString(String? value) {
    switch (value) {
      case 'MEETS_DEVICE_INTEGRITY':
      case 'valid':
        return IntegrityVerdict.valid;
      case 'MEETS_BASIC_INTEGRITY':
        return IntegrityVerdict.failedStrong;
      case 'failedDevice':
        return IntegrityVerdict.failedDevice;
      case 'failedBasic':
        return IntegrityVerdict.failedBasic;
      default:
        return IntegrityVerdict.error;
    }
  }
}

/// Device recognition levels
enum DeviceRecognition {
  meetsDeviceIntegrity,
  meetsBasicIntegrity,
  unknown;

  static DeviceRecognition fromString(String? value) {
    switch (value) {
      case 'MEETS_DEVICE_INTEGRITY':
        return DeviceRecognition.meetsDeviceIntegrity;
      case 'MEETS_BASIC_INTEGRITY':
        return DeviceRecognition.meetsBasicIntegrity;
      default:
        return DeviceRecognition.unknown;
    }
  }
}

/// App licensing status
enum AppLicensing {
  licensed,
  unlicensed,
  unevaluated;

  static AppLicensing fromString(String? value) {
    switch (value) {
      case 'LICENSED':
        return AppLicensing.licensed;
      case 'UNLICENSED':
        return AppLicensing.unlicensed;
      default:
        return AppLicensing.unevaluated;
    }
  }
}

/// Extension to check platform
extension TargetPlatformX on TargetPlatform {
  bool get isAndroid => this == TargetPlatform.android;
  bool get isIOS => this == TargetPlatform.iOS;
}
