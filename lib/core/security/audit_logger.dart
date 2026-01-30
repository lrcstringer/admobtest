import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Comprehensive audit logging for security-sensitive operations
@lazySingleton
class AuditLogger {
  final FirebaseFirestore _firestore;
  final DeviceInfoPlugin _deviceInfo;

  // Cache device info to avoid repeated async calls
  Map<String, dynamic>? _cachedDeviceInfo;

  AuditLogger(
    this._firestore,
  ) : _deviceInfo = DeviceInfoPlugin();

  /// Log a security event
  Future<void> logSecurityEvent({
    required String userId,
    required SecurityEventType eventType,
    required String action,
    bool success = true,
    Map<String, dynamic>? metadata,
    String? errorMessage,
    RiskLevel? riskLevel,
  }) async {
    try {
      final deviceData = await _getDeviceInfo();
      final eventRef = _firestore.collection('auditLogs').doc();

      await eventRef.set({
        'id': eventRef.id,
        'userId': userId,
        'eventType': eventType.name,
        'action': action,
        'success': success,
        'metadata': metadata ?? {},
        'errorMessage': errorMessage,
        'riskLevel': riskLevel?.name ?? RiskLevel.low.name,
        'deviceInfo': deviceData,
        'timestamp': FieldValue.serverTimestamp(),
        'clientTimestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Failed to log security event: $e');
      // Don't throw - logging should not break the app
    }
  }

  /// Log authentication event
  Future<void> logAuthEvent({
    required String userId,
    required AuthAction action,
    bool success = true,
    String? errorMessage,
    String? ipAddress,
  }) async {
    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.authentication,
      action: action.name,
      success: success,
      errorMessage: errorMessage,
      metadata: {
        'ipAddress': ipAddress,
      },
      riskLevel: success ? RiskLevel.low : RiskLevel.medium,
    );
  }

  /// Log financial transaction
  Future<void> logFinancialEvent({
    required String userId,
    required FinancialAction action,
    required int amount,
    bool success = true,
    String? transactionId,
    String? errorMessage,
  }) async {
    final riskLevel = _calculateFinancialRisk(action, amount);

    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.financial,
      action: action.name,
      success: success,
      errorMessage: errorMessage,
      metadata: {
        'amount': amount,
        'transactionId': transactionId,
        'zarValue': amount * 0.01,
      },
      riskLevel: riskLevel,
    );
  }

  /// Log fraud detection event
  Future<void> logFraudEvent({
    required String userId,
    required String fraudType,
    required double riskScore,
    required Map<String, dynamic> indicators,
    bool blocked = false,
  }) async {
    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.fraud,
      action: fraudType,
      success: !blocked,
      metadata: {
        'riskScore': riskScore,
        'indicators': indicators,
        'blocked': blocked,
      },
      riskLevel: riskScore > 0.7 ? RiskLevel.critical : RiskLevel.high,
    );
  }

  /// Log data access event
  Future<void> logDataAccessEvent({
    required String userId,
    required String resourceType,
    required String resourceId,
    required DataAccessAction action,
  }) async {
    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.dataAccess,
      action: action.name,
      metadata: {
        'resourceType': resourceType,
        'resourceId': resourceId,
      },
      riskLevel: RiskLevel.low,
    );
  }

  /// Log system event
  Future<void> logSystemEvent({
    required String userId,
    required String action,
    Map<String, dynamic>? metadata,
  }) async {
    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.systemEvent,
      action: action,
      metadata: metadata,
      riskLevel: RiskLevel.low,
    );
  }

  /// Get audit logs for a user
  Future<List<AuditLogEntry>> getLogsForUser(
    String userId, {
    int limit = 50,
    SecurityEventType? eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('auditLogs')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (eventType != null) {
      query = query.where('eventType', isEqualTo: eventType.name);
    }

    if (startDate != null) {
      query = query.where(
        'timestamp',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }

    if (endDate != null) {
      query = query.where(
        'timestamp',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) => AuditLogEntry.fromFirestore(doc)).toList();
  }

  /// Get recent high-risk events for a user
  Future<List<AuditLogEntry>> getHighRiskEvents(
    String userId, {
    int limit = 20,
  }) async {
    final snapshot = await _firestore
        .collection('auditLogs')
        .where('userId', isEqualTo: userId)
        .where('riskLevel', whereIn: ['high', 'critical'])
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => AuditLogEntry.fromFirestore(doc)).toList();
  }

  /// Calculate financial risk level
  RiskLevel _calculateFinancialRisk(FinancialAction action, int amount) {
    if (action == FinancialAction.cashout) {
      if (amount >= 50000) return RiskLevel.critical;
      if (amount >= 10000) return RiskLevel.high;
      if (amount >= 5000) return RiskLevel.medium;
    }

    if (action == FinancialAction.transfer) {
      if (amount >= 10000) return RiskLevel.high;
      if (amount >= 1000) return RiskLevel.medium;
    }

    return RiskLevel.low;
  }

  /// Get device info (cached after first call)
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    if (_cachedDeviceInfo != null) {
      return _cachedDeviceInfo!;
    }

    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        _cachedDeviceInfo = {
          'platform': 'android',
          'model': info.model,
          'brand': info.brand,
          'sdkVersion': info.version.sdkInt,
          'isPhysicalDevice': info.isPhysicalDevice,
          'fingerprint': info.fingerprint,
        };
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        _cachedDeviceInfo = {
          'platform': 'ios',
          'model': info.model,
          'systemVersion': info.systemVersion,
          'isPhysicalDevice': info.isPhysicalDevice,
          'identifierForVendor': info.identifierForVendor,
        };
      } else {
        _cachedDeviceInfo = {'platform': 'unknown'};
      }
    } catch (e) {
      debugPrint('Failed to get device info: $e');
      _cachedDeviceInfo = {'platform': 'error', 'error': e.toString()};
    }

    return _cachedDeviceInfo!;
  }

  /// Clear cached device info (for testing)
  void clearCache() {
    _cachedDeviceInfo = null;
  }
}

/// Types of security events
enum SecurityEventType {
  authentication,
  financial,
  fraud,
  dataAccess,
  systemEvent,
}

/// Authentication actions
enum AuthAction {
  login,
  logout,
  register,
  passwordReset,
  otpVerification,
  otpResend,
  tokenRefresh,
  sessionExpired,
  accountLocked,
  deviceBound,
  deviceRevoked,
  deviceBindingFailed,
  sessionLock,
  sessionUnlockBiometric,
  sessionUnlockDeviceCredential,
  sessionUnlockPin,
  sessionUnlockFailed,
  pinSetup,
  pinChange,
  pushChallengeReceived,
  pushChallengeApproved,
  pushChallengeDenied,
  simChangeDetected,
  stepUpRequired,
  stepUpCompleted,
  newDeviceDetected,
}

/// Financial actions
enum FinancialAction {
  earn,
  cashout,
  transfer,
  purchase,
  potWin,
  referralBonus,
  refund,
}

/// Data access actions
enum DataAccessAction {
  read,
  create,
  update,
  delete,
  export,
  share,
}

/// Risk levels
enum RiskLevel {
  low,
  medium,
  high,
  critical,
}

/// Represents an audit log entry
class AuditLogEntry {
  final String id;
  final String userId;
  final SecurityEventType eventType;
  final String action;
  final bool success;
  final Map<String, dynamic> metadata;
  final String? errorMessage;
  final RiskLevel riskLevel;
  final Map<String, dynamic> deviceInfo;
  final DateTime timestamp;

  AuditLogEntry({
    required this.id,
    required this.userId,
    required this.eventType,
    required this.action,
    required this.success,
    required this.metadata,
    this.errorMessage,
    required this.riskLevel,
    required this.deviceInfo,
    required this.timestamp,
  });

  factory AuditLogEntry.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return AuditLogEntry(
      id: doc.id,
      userId: data['userId'] ?? '',
      eventType: SecurityEventType.values.firstWhere(
        (e) => e.name == data['eventType'],
        orElse: () => SecurityEventType.systemEvent,
      ),
      action: data['action'] ?? '',
      success: data['success'] ?? true,
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
      errorMessage: data['errorMessage'],
      riskLevel: RiskLevel.values.firstWhere(
        (e) => e.name == data['riskLevel'],
        orElse: () => RiskLevel.low,
      ),
      deviceInfo: Map<String, dynamic>.from(data['deviceInfo'] ?? {}),
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'eventType': eventType.name,
        'action': action,
        'success': success,
        'metadata': metadata,
        'errorMessage': errorMessage,
        'riskLevel': riskLevel.name,
        'deviceInfo': deviceInfo,
        'timestamp': timestamp.toIso8601String(),
      };
}
