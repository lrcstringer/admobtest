import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Checks the app version against a server-defined minimum.
///
/// Reads `config/app` doc from Firestore with field `minVersion` (e.g. "1.2.0").
/// Returns [VersionCheckResult] indicating whether the user must update.
@lazySingleton
class VersionEnforcementService {
  final FirebaseFirestore _firestore;

  VersionEnforcementService(this._firestore);

  Future<VersionCheckResult> check() async {
    try {
      final doc = await _firestore.collection('config').doc('app').get();
      if (!doc.exists) return VersionCheckResult.ok;

      final minVersionStr = doc.data()?['minVersion'] as String?;
      if (minVersionStr == null || minVersionStr.isEmpty) {
        return VersionCheckResult.ok;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      final current = _parseVersion(packageInfo.version);
      final minimum = _parseVersion(minVersionStr);

      if (current == null || minimum == null) return VersionCheckResult.ok;

      if (_isBelow(current, minimum)) {
        return VersionCheckResult.updateRequired;
      }

      return VersionCheckResult.ok;
    } catch (e) {
      debugPrint('[VersionCheck] Failed: $e — allowing app to continue');
      return VersionCheckResult.ok;
    }
  }

  List<int>? _parseVersion(String version) {
    final parts = version.split('.').map(int.tryParse).toList();
    if (parts.length < 3 || parts.any((p) => p == null)) return null;
    return parts.cast<int>();
  }

  bool _isBelow(List<int> current, List<int> minimum) {
    for (var i = 0; i < 3; i++) {
      if (current[i] < minimum[i]) return true;
      if (current[i] > minimum[i]) return false;
    }
    return false;
  }
}

enum VersionCheckResult { ok, updateRequired }
