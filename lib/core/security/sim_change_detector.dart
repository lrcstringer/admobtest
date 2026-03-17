import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'audit_logger.dart';
import 'keystore_service.dart';

/// Result of a SIM change check.
enum SimCheckResult {
  /// No change detected.
  noChange,

  /// SIM has changed since last check.
  changed,

  /// First check — no previous SIM data stored.
  firstCheck,

  /// Unable to read SIM info (e.g., no SIM, no permission).
  unavailable,
}

/// Detects SIM card changes by comparing the current operator info
/// against a stored hash.
///
/// Uses operator name (no special permission required) rather than
/// ICCID (which requires READ_PHONE_STATE on Android).
@lazySingleton
class SimChangeDetector {
  final KeystoreService _keystoreService;
  final FlutterSecureStorage _secureStorage;
  final AuditLogger _auditLogger;
  final FirebaseFunctions _functions;

  static const _simHashKey = 'imali_sim_hash';

  String? _currentUserId;

  SimChangeDetector(
    this._keystoreService,
    this._secureStorage,
    this._auditLogger,
    this._functions,
  );

  /// Set the current user ID for audit logging and risk event creation.
  void setUserId(String? userId) {
    _currentUserId = userId;
  }

  /// Check if the SIM has changed since the last check.
  ///
  /// On first run, stores the current SIM hash and returns [SimCheckResult.firstCheck].
  /// On subsequent runs, compares hashes and returns [SimCheckResult.changed]
  /// or [SimCheckResult.noChange].
  Future<SimCheckResult> checkForSimChange() async {
    try {
      final simInfoResult = await _keystoreService.getSimInfo();

      return simInfoResult.fold(
        (failure) {
          return SimCheckResult.unavailable;
        },
        (simInfo) async {
          if (!simInfo.available ||
              (simInfo.operatorName.isEmpty && simInfo.simCountryIso.isEmpty)) {
            return SimCheckResult.unavailable;
          }

          // Create hash of SIM identity
          final currentHash = _hashSimInfo(
            simInfo.operatorName,
            simInfo.simCountryIso,
          );

          // Read stored hash
          final storedHash = await _readStoredHash();

          if (storedHash == null) {
            // First check — store and return
            await _storeHash(currentHash);
            return SimCheckResult.firstCheck;
          }

          if (currentHash != storedHash) {
            // SIM changed — update stored hash
            await _storeHash(currentHash);
            _onSimChanged();
            return SimCheckResult.changed;
          }

          return SimCheckResult.noChange;
        },
      );
    } catch (e) {
      return SimCheckResult.unavailable;
    }
  }

  /// Clear stored SIM hash (used on sign out).
  Future<void> clearStoredHash() async {
    try {
      await _secureStorage.delete(key: _simHashKey);
    } catch (e) {
    }
  }

  String _hashSimInfo(String operatorName, String countryCode) {
    final input = '$operatorName:$countryCode';
    return sha256.convert(utf8.encode(input)).toString();
  }

  Future<String?> _readStoredHash() async {
    try {
      return await _secureStorage.read(key: _simHashKey);
    } catch (e) {
      return null;
    }
  }

  Future<void> _storeHash(String hash) async {
    try {
      await _secureStorage.write(key: _simHashKey, value: hash);
    } catch (e) {
    }
  }

  /// Called when SIM change is detected. Logs audit event and creates
  /// a server-side risk event via Cloud Function.
  void _onSimChanged() {
    final userId = _currentUserId;
    if (userId == null) return;

    // Log audit event
    _auditLogger.logAuthEvent(
      userId: userId,
      action: AuthAction.simChangeDetected,
    );

    // Create server-side risk event
    _createSimChangeRiskEvent(userId);
  }

  Future<void> _createSimChangeRiskEvent(String userId) async {
    try {
      final callable = _functions.httpsCallable('createRiskEvent');
      await callable.call<Map<String, dynamic>>({
        'type': 'simChange',
        'severity': 'high',
        'details': 'SIM card change detected on device',
      });
    } catch (e) {
    }
  }
}
