import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

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

  static const _simHashKey = 'imali_sim_hash';

  SimChangeDetector(
    this._keystoreService,
    this._secureStorage,
  );

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
          debugPrint('SIM check: failed to read SIM info: $failure');
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
            debugPrint('SIM change detected: operator info changed');
            return SimCheckResult.changed;
          }

          return SimCheckResult.noChange;
        },
      );
    } catch (e) {
      debugPrint('SIM check error: $e');
      return SimCheckResult.unavailable;
    }
  }

  /// Clear stored SIM hash (used on sign out).
  Future<void> clearStoredHash() async {
    try {
      await _secureStorage.delete(key: _simHashKey);
    } catch (e) {
      debugPrint('Failed to clear SIM hash: $e');
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
      debugPrint('Failed to read stored SIM hash: $e');
      return null;
    }
  }

  Future<void> _storeHash(String hash) async {
    try {
      await _secureStorage.write(key: _simHashKey, value: hash);
    } catch (e) {
      debugPrint('Failed to store SIM hash: $e');
    }
  }
}
