import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

/// Service for Google Play Integrity API
/// Verifies app and device integrity to prevent fraud
///
/// On Android: requests a real integrity token from the Play Integrity API
/// via a native method channel, then optionally verifies it server-side.
/// On non-Android platforms: returns null gracefully (iOS uses App Attest
/// via Firebase App Check instead).
///
/// Tokens are cached for [_cacheTtl] to avoid blocking callers with the
/// 3-10 second Google Play Services network round-trip on every call.
/// Call [warmUp] early (e.g. when a send-gift screen opens) so that a
/// fresh token is already available when the user taps "Send".
@lazySingleton
class PlayIntegrityService {
  final FirebaseFunctions _functions;
  final Uuid _uuid = const Uuid();

  static const _channel = MethodChannel('com.imali.chat/play_integrity');

  /// How long a cached token remains valid.
  static const _cacheTtl = Duration(minutes: 5);

  /// Max wait when fetching a token without a specific nonce (advisory mode).
  /// Most Cloud Functions use Play Integrity in fire-and-forget advisory mode,
  /// so a missing token is acceptable. Prevents 3-10s blocking on cache miss.
  static const _advisoryTimeout = Duration(milliseconds: 500);

  /// Cached token + timestamp.
  String? _cachedToken;
  DateTime? _cachedAt;

  /// Guards against concurrent warm-up calls.
  Future<String?>? _pendingFetch;

  PlayIntegrityService(this._functions);

  /// Generate a nonce for integrity check
  String generateNonce() {
    return _uuid.v4();
  }

  /// Pre-fetch an integrity token in the background so it's ready
  /// when needed. Call this when opening screens that will send
  /// financial transactions (gift composer, claim screens, etc.).
  ///
  /// Safe to call multiple times — deduplicates concurrent requests.
  void warmUp() {
    if (!defaultTargetPlatform.isAndroid) return;
    // Already have a valid cached token — nothing to do.
    if (_isCacheValid) return;
    // Already fetching — piggy-back on the in-flight request.
    if (_pendingFetch != null) return;
    // Fire-and-forget; errors are swallowed (logged inside _fetchAndCache).
    _fetchAndCache();
  }

  bool get _isCacheValid =>
      _cachedToken != null &&
      _cachedAt != null &&
      DateTime.now().difference(_cachedAt!) < _cacheTtl;

  /// Get a raw Play Integrity token string for passing to Cloud Functions.
  ///
  /// Returns the cached token if still valid, otherwise fetches a fresh one.
  /// Returns `null` on non-Android platforms or if the request fails.
  ///
  /// When no [nonce] is provided (advisory mode), the fetch is capped at
  /// [_advisoryTimeout] to avoid blocking callers for 3-10s. Most Cloud
  /// Functions use Play Integrity in fire-and-forget advisory mode, so a
  /// missing token is acceptable.
  Future<String?> getIntegrityToken({String? nonce}) async {
    if (!defaultTargetPlatform.isAndroid) {
      return null;
    }

    // When a specific nonce is required (e.g. for server-side verification),
    // we must fetch a fresh token — the nonce is baked into the token.
    if (nonce != null) {
      return _fetchFresh(nonce: nonce);
    }

    // Return cached token if still valid.
    if (_isCacheValid) return _cachedToken;

    // If a fetch is already in flight, await it instead of starting another.
    // Cap at _advisoryTimeout so callers aren't blocked for 3-10s.
    final future = _pendingFetch ?? _fetchAndCache();
    return future.timeout(_advisoryTimeout, onTimeout: () => null);
  }

  /// Fetches a fresh token with an auto-generated nonce and caches it.
  Future<String?> _fetchAndCache() {
    final future = _fetchFresh().then((token) {
      if (token != null) {
        _cachedToken = token;
        _cachedAt = DateTime.now();
      }
      _pendingFetch = null;
      return token;
    }).catchError((Object e) {
      _pendingFetch = null;
      return null;
    });
    _pendingFetch = future;
    return future;
  }

  /// Performs the actual native call. Does NOT cache (caller decides).
  Future<String?> _fetchFresh({String? nonce}) async {
    final requestNonce = nonce ?? generateNonce();
    try {
      final encodedNonce = base64Encode(utf8.encode(requestNonce));
      final token = await _channel.invokeMethod<String>(
        'requestIntegrityToken',
        {'nonce': encodedNonce},
      );
      return token;
    } on PlatformException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Request an integrity verification with full server-side decoding.
  ///
  /// Gets a token from the Play Integrity API, sends it to the backend
  /// Cloud Function for decoding, and returns the parsed verdict.
  Future<IntegrityResult> verifyIntegrity({String? nonce}) async {
    final requestNonce = nonce ?? generateNonce();

    if (!defaultTargetPlatform.isAndroid) {
      // iOS uses App Attest via Firebase App Check instead
      return IntegrityResult(
        isValid: true,
        verdict: IntegrityVerdict.valid,
        details: 'Non-Android platform',
        nonce: requestNonce,
      );
    }

    try {
      final token = await getIntegrityToken(nonce: requestNonce);

      if (token == null) {
        return IntegrityResult(
          isValid: false,
          verdict: IntegrityVerdict.error,
          details: 'Failed to obtain integrity token',
          nonce: requestNonce,
        );
      }

      // Verify token with backend
      return await _verifyTokenWithBackend(
        token: token,
        nonce: requestNonce,
      );
    } catch (e) {
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
        deviceRecognition:
            DeviceRecognition.fromString(data['deviceRecognition']),
        appLicensing: AppLicensing.fromString(data['appLicensing']),
      );
    } catch (e) {
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
      case 'MEETS_STRONG_INTEGRITY':
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
