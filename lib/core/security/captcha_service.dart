import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

/// Service for CAPTCHA verification
/// Uses reCAPTCHA v3 for invisible verification
class CaptchaService {
  final FirebaseFunctions _functions;

  CaptchaService({
    FirebaseFunctions? functions,
  }) : _functions = functions ?? FirebaseFunctions.instanceFor(region: 'africa-south1');

  /// Risk actions that require CAPTCHA verification
  static const Set<String> _riskActions = {
    'cashout',
    'transfer_large', // Transfers > 1000 tokens
    'suspicious_login',
    'multiple_failed_attempts',
    'high_value_purchase',
  };

  /// Check if an action requires CAPTCHA
  bool requiresCaptcha(String action, {int? amount}) {
    if (_riskActions.contains(action)) {
      return true;
    }

    // Large transfers require verification
    if (action == 'transfer' && amount != null && amount > 1000) {
      return true;
    }

    // Large cashouts require verification
    if (action == 'cashout' && amount != null && amount > 5000) {
      return true;
    }

    return false;
  }

  /// Execute CAPTCHA verification for an action
  Future<CaptchaResult> verify({
    required String action,
    String? userId,
  }) async {
    try {
      // In production, use recaptcha_enterprise package
      // final token = await RecaptchaEnterprise.execute(
      //   _siteKey,
      //   action: action,
      // );

      // For development, simulate token generation
      const token = 'CAPTCHA_TOKEN_PLACEHOLDER';

      // Verify token with backend
      final callable = _functions.httpsCallable('verifyCaptcha');
      final response = await callable.call({
        'token': token,
        'action': action,
        'userId': userId,
      });

      final data = response.data as Map<String, dynamic>;

      return CaptchaResult(
        success: data['success'] ?? false,
        score: (data['score'] ?? 0.0).toDouble(),
        action: data['action'] ?? action,
        errorCodes: List<String>.from(data['error-codes'] ?? []),
      );
    } catch (e) {
      return CaptchaResult(
        success: false,
        score: 0.0,
        action: action,
        errorCodes: ['exception: $e'],
      );
    }
  }

  /// Check if a CAPTCHA score indicates bot behavior
  bool isBot(double score) {
    // reCAPTCHA v3 scores range from 0.0 (bot) to 1.0 (human)
    return score < 0.3;
  }

  /// Check if a CAPTCHA score indicates suspicious behavior
  bool isSuspicious(double score) {
    return score >= 0.3 && score < 0.5;
  }

  /// Check if a CAPTCHA score indicates likely human
  bool isHuman(double score) {
    return score >= 0.5;
  }

  /// Get action threshold - different actions may have different thresholds
  double getActionThreshold(String action) {
    switch (action) {
      case 'cashout':
        return 0.7; // Higher threshold for cashouts
      case 'transfer_large':
        return 0.6;
      case 'login':
        return 0.4;
      default:
        return 0.5;
    }
  }

  /// Verify and check against action-specific threshold
  Future<bool> verifyForAction({
    required String action,
    String? userId,
  }) async {
    final result = await verify(action: action, userId: userId);
    final threshold = getActionThreshold(action);
    return result.success && result.score >= threshold;
  }
}

/// Result of CAPTCHA verification
class CaptchaResult {
  final bool success;
  final double score;
  final String action;
  final List<String> errorCodes;

  CaptchaResult({
    required this.success,
    required this.score,
    required this.action,
    required this.errorCodes,
  });

  /// Whether the result indicates a human user
  bool get isHuman => success && score >= 0.5;

  /// Whether the result indicates bot behavior
  bool get isBot => !success || score < 0.3;

  /// Whether the result indicates suspicious behavior
  bool get isSuspicious => success && score >= 0.3 && score < 0.5;

  /// Risk level based on score
  CaptchaRiskLevel get riskLevel {
    if (isBot) return CaptchaRiskLevel.high;
    if (isSuspicious) return CaptchaRiskLevel.medium;
    return CaptchaRiskLevel.low;
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'score': score,
        'action': action,
        'errorCodes': errorCodes,
        'riskLevel': riskLevel.name,
      };

  @override
  String toString() =>
      'CaptchaResult(success: $success, score: $score, action: $action)';
}

/// Risk levels from CAPTCHA
enum CaptchaRiskLevel {
  low,
  medium,
  high,
}
