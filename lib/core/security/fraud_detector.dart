/// Fraud Detection Service
/// Monitors and flags suspicious activity patterns
library;

import 'dart:collection';

class FraudDetector {
  final Map<String, UserActivityProfile> _userProfiles = {};
  final Queue<FraudAlert> _recentAlerts = Queue();

  // Thresholds for fraud detection
  static const int maxAlertsBeforeBlock = 5;
  static const int alertWindowHours = 24;
  static const int maxDailyEarnings = 100000; // 100k tokens = R1000
  static const int maxSingleTransfer = 50000; // 50k tokens = R500
  static const int maxDailyTransfers = 10;
  static const int maxDailyCashouts = 3;
  static const double suspiciousVelocityThreshold = 0.8; // 80% of limit

  /// Analyze earning activity for fraud patterns
  FraudCheckResult checkEarning({
    required String userId,
    required int amount,
    required String source,
  }) {
    final profile = _getOrCreateProfile(userId);
    final alerts = <String>[];

    // Check daily earnings limit
    final todayEarnings = profile.todayEarnings + amount;
    if (todayEarnings > maxDailyEarnings) {
      alerts.add('Daily earning limit exceeded');
    }

    // Check earning velocity (too fast)
    if (profile.recentEarnings.length >= 10) {
      final avgInterval = _calculateAverageInterval(profile.recentEarnings);
      if (avgInterval.inSeconds < 30) {
        alerts.add('Abnormally fast earning pattern detected');
      }
    }

    // Check for repeated same-source earnings
    final recentSameSources = profile.recentEarningSources
        .where((s) => s == source)
        .length;
    if (recentSameSources > 20) {
      alerts.add('Repeated earning from same source');
    }

    // Record activity
    profile.recordEarning(amount, source);

    // Generate result
    if (alerts.isNotEmpty) {
      _recordAlert(userId, 'earning', alerts);
      return FraudCheckResult(
        allowed: alerts.length < 2, // Allow if only 1 alert
        alerts: alerts,
        riskLevel: _calculateRiskLevel(alerts.length),
      );
    }

    return FraudCheckResult.allowed();
  }

  /// Analyze transfer activity for fraud patterns
  FraudCheckResult checkTransfer({
    required String userId,
    required String recipientId,
    required int amount,
  }) {
    final profile = _getOrCreateProfile(userId);
    final alerts = <String>[];

    // Check single transfer limit
    if (amount > maxSingleTransfer) {
      alerts.add('Transfer amount exceeds single transaction limit');
    }

    // Check daily transfer count
    if (profile.todayTransferCount >= maxDailyTransfers) {
      alerts.add('Daily transfer limit reached');
    }

    // Check for transfers to new recipients (fraud ring pattern)
    if (!profile.knownRecipients.contains(recipientId)) {
      if (profile.newRecipientsToday >= 5) {
        alerts.add('Too many transfers to new recipients');
      }
    }

    // Check for circular transfers (money laundering pattern)
    if (profile.recentTransferRecipients.contains(recipientId)) {
      final recipientProfile = _userProfiles[recipientId];
      if (recipientProfile != null &&
          recipientProfile.recentTransferRecipients.contains(userId)) {
        alerts.add('Potential circular transfer detected');
      }
    }

    // Check for splitting pattern (many small transfers)
    if (profile.todayTransferCount > 5 && amount < 1000) {
      alerts.add('Potential splitting pattern detected');
    }

    // Record activity
    profile.recordTransfer(recipientId, amount);

    if (alerts.isNotEmpty) {
      _recordAlert(userId, 'transfer', alerts);
      return FraudCheckResult(
        allowed: alerts.length < 2,
        alerts: alerts,
        riskLevel: _calculateRiskLevel(alerts.length),
      );
    }

    return FraudCheckResult.allowed();
  }

  /// Analyze cashout request for fraud patterns
  FraudCheckResult checkCashout({
    required String userId,
    required int amount,
    required int accountAge, // Days since account creation
  }) {
    final profile = _getOrCreateProfile(userId);
    final alerts = <String>[];

    // Check daily cashout limit
    if (profile.todayCashoutCount >= maxDailyCashouts) {
      alerts.add('Daily cashout limit reached');
    }

    // Check account age (new accounts cashing out quickly)
    if (accountAge < 7 && amount > 10000) {
      alerts.add('Large cashout from new account');
    }

    // Check cashout to earning ratio
    final lifetimeEarned = profile.lifetimeEarnings;
    if (lifetimeEarned > 0) {
      final cashoutRatio = amount / lifetimeEarned;
      if (cashoutRatio > 0.9) {
        alerts.add('Cashing out nearly entire balance');
      }
    }

    // Check for rapid cashout after large transfer received
    if (profile.lastLargeTransferReceived != null) {
      final timeSinceTransfer =
          DateTime.now().difference(profile.lastLargeTransferReceived!);
      if (timeSinceTransfer.inMinutes < 30 && amount > 5000) {
        alerts.add('Rapid cashout after receiving large transfer');
      }
    }

    // Record activity
    profile.recordCashout(amount);

    if (alerts.isNotEmpty) {
      _recordAlert(userId, 'cashout', alerts);
      return FraudCheckResult(
        allowed: alerts.length < 2,
        alerts: alerts,
        riskLevel: _calculateRiskLevel(alerts.length),
      );
    }

    return FraudCheckResult.allowed();
  }

  /// Check if user should be blocked
  bool shouldBlockUser(String userId) {
    final recentAlerts = _recentAlerts
        .where((a) =>
            a.userId == userId &&
            a.timestamp.isAfter(
                DateTime.now().subtract(Duration(hours: alertWindowHours))))
        .length;

    return recentAlerts >= maxAlertsBeforeBlock;
  }

  /// Get user risk score (0-100)
  int getUserRiskScore(String userId) {
    final profile = _userProfiles[userId];
    if (profile == null) return 0;

    int score = 0;

    // Factor in alert count
    final alertCount = _recentAlerts
        .where((a) => a.userId == userId)
        .length;
    score += alertCount * 10;

    // Factor in activity patterns
    if (profile.todayEarnings > maxDailyEarnings * suspiciousVelocityThreshold) {
      score += 20;
    }

    if (profile.newRecipientsToday > 3) {
      score += 15;
    }

    return score.clamp(0, 100);
  }

  /// Reset daily counters (call at midnight)
  void resetDailyCounters() {
    for (final profile in _userProfiles.values) {
      profile.resetDaily();
    }

    // Clean old alerts
    final cutoff = DateTime.now().subtract(Duration(hours: alertWindowHours));
    _recentAlerts.removeWhere((a) => a.timestamp.isBefore(cutoff));
  }

  UserActivityProfile _getOrCreateProfile(String userId) {
    return _userProfiles.putIfAbsent(userId, () => UserActivityProfile(userId));
  }

  void _recordAlert(String userId, String type, List<String> reasons) {
    _recentAlerts.add(FraudAlert(
      userId: userId,
      type: type,
      reasons: reasons,
      timestamp: DateTime.now(),
    ));
  }

  Duration _calculateAverageInterval(List<DateTime> timestamps) {
    if (timestamps.length < 2) {
      return const Duration(hours: 1);
    }

    int totalMs = 0;
    for (int i = 1; i < timestamps.length; i++) {
      totalMs += timestamps[i].difference(timestamps[i - 1]).inMilliseconds;
    }

    return Duration(milliseconds: totalMs ~/ (timestamps.length - 1));
  }

  RiskLevel _calculateRiskLevel(int alertCount) {
    if (alertCount >= 3) return RiskLevel.high;
    if (alertCount >= 2) return RiskLevel.medium;
    return RiskLevel.low;
  }
}

/// User activity profile for fraud detection
class UserActivityProfile {
  final String userId;

  int todayEarnings = 0;
  int todayTransferCount = 0;
  int todayCashoutCount = 0;
  int newRecipientsToday = 0;
  int lifetimeEarnings = 0;

  final List<DateTime> recentEarnings = [];
  final List<String> recentEarningSources = [];
  final Set<String> knownRecipients = {};
  final List<String> recentTransferRecipients = [];
  DateTime? lastLargeTransferReceived;

  UserActivityProfile(this.userId);

  void recordEarning(int amount, String source) {
    todayEarnings += amount;
    lifetimeEarnings += amount;
    recentEarnings.add(DateTime.now());
    recentEarningSources.add(source);

    // Keep only last 50 records
    if (recentEarnings.length > 50) {
      recentEarnings.removeAt(0);
    }
    if (recentEarningSources.length > 50) {
      recentEarningSources.removeAt(0);
    }
  }

  void recordTransfer(String recipientId, int amount) {
    todayTransferCount++;

    if (!knownRecipients.contains(recipientId)) {
      knownRecipients.add(recipientId);
      newRecipientsToday++;
    }

    recentTransferRecipients.add(recipientId);
    if (recentTransferRecipients.length > 20) {
      recentTransferRecipients.removeAt(0);
    }
  }

  void recordTransferReceived(int amount) {
    if (amount > 5000) {
      lastLargeTransferReceived = DateTime.now();
    }
  }

  void recordCashout(int amount) {
    todayCashoutCount++;
  }

  void resetDaily() {
    todayEarnings = 0;
    todayTransferCount = 0;
    todayCashoutCount = 0;
    newRecipientsToday = 0;
  }
}

/// Result of a fraud check
class FraudCheckResult {
  final bool allowed;
  final List<String> alerts;
  final RiskLevel riskLevel;

  const FraudCheckResult({
    required this.allowed,
    this.alerts = const [],
    this.riskLevel = RiskLevel.low,
  });

  factory FraudCheckResult.allowed() {
    return const FraudCheckResult(allowed: true);
  }

  bool get hasAlerts => alerts.isNotEmpty;
}

/// Fraud alert record
class FraudAlert {
  final String userId;
  final String type;
  final List<String> reasons;
  final DateTime timestamp;

  const FraudAlert({
    required this.userId,
    required this.type,
    required this.reasons,
    required this.timestamp,
  });
}

/// Risk level enum
enum RiskLevel { low, medium, high }
