/// Security Service
/// Coordinates all security components
library;

import 'package:injectable/injectable.dart';

import 'fraud_detector.dart';
import 'input_validator.dart';
import 'rate_limiter.dart';
import 'transaction_verifier.dart';

@lazySingleton
class SecurityService {
  final RateLimiter _rateLimiter = RateLimiter();
  final FraudDetector _fraudDetector = FraudDetector();

  /// Check if an action is allowed (rate limit + fraud check)
  SecurityCheckResult checkAction({
    required String userId,
    required String action,
    Map<String, dynamic>? context,
  }) {
    // Check rate limit first
    if (!_rateLimiter.checkAndRecord(userId, action)) {
      final timeUntilReset = _rateLimiter.getTimeUntilReset(userId, action);
      return SecurityCheckResult.rateLimited(
        'Too many attempts. Please try again later.',
        timeUntilReset,
      );
    }

    // Check if user is blocked
    if (_fraudDetector.shouldBlockUser(userId)) {
      return SecurityCheckResult.blocked(
        'Account temporarily restricted due to suspicious activity.',
      );
    }

    return SecurityCheckResult.allowed();
  }

  /// Validate and check earning
  SecurityCheckResult checkEarning({
    required String userId,
    required int amount,
    required String source,
    required int currentBalance,
    required int todayEarned,
    required int dailyLimit,
  }) {
    // Rate limit check
    final rateCheck = checkAction(userId: userId, action: 'earn_$source');
    if (!rateCheck.allowed) return rateCheck;

    // Transaction verification
    final verification = TransactionVerifier.verifyEarning(
      userId: userId,
      amount: amount,
      source: source,
      currentBalance: currentBalance,
      todayEarned: todayEarned,
      dailyLimit: dailyLimit,
    );

    if (!verification.isValid) {
      return SecurityCheckResult.validationFailed(verification.errorMessage);
    }

    // Fraud check
    final fraudCheck = _fraudDetector.checkEarning(
      userId: userId,
      amount: amount,
      source: source,
    );

    if (!fraudCheck.allowed) {
      return SecurityCheckResult.fraudDetected(
        'Transaction flagged for review.',
        fraudCheck.alerts,
      );
    }

    return SecurityCheckResult.allowed();
  }

  /// Validate and check transfer
  SecurityCheckResult checkTransfer({
    required String senderId,
    required String recipientId,
    required int amount,
    required int senderBalance,
  }) {
    // Rate limit check
    final rateCheck = checkAction(userId: senderId, action: 'transfer');
    if (!rateCheck.allowed) return rateCheck;

    // Input validation
    final amountValidation =
        InputValidator.validateTokenAmount(amount, maxAmount: senderBalance);
    if (!amountValidation.isValid) {
      return SecurityCheckResult.validationFailed(
          amountValidation.errorMessage!);
    }

    // Transaction verification
    final verification = TransactionVerifier.verifyTransfer(
      senderId: senderId,
      recipientId: recipientId,
      amount: amount,
      senderBalance: senderBalance,
    );

    if (!verification.isValid) {
      return SecurityCheckResult.validationFailed(verification.errorMessage);
    }

    // Fraud check
    final fraudCheck = _fraudDetector.checkTransfer(
      userId: senderId,
      recipientId: recipientId,
      amount: amount,
    );

    if (!fraudCheck.allowed) {
      return SecurityCheckResult.fraudDetected(
        'Transfer flagged for review.',
        fraudCheck.alerts,
      );
    }

    return SecurityCheckResult.allowed();
  }

  /// Validate and check cashout
  SecurityCheckResult checkCashout({
    required String userId,
    required int tokenAmount,
    required int currentBalance,
    required int pendingCashout,
    required bool hasBankAccount,
    required int accountAgeDays,
  }) {
    // Rate limit check
    final rateCheck = checkAction(userId: userId, action: 'cashout');
    if (!rateCheck.allowed) return rateCheck;

    // Transaction verification
    final verification = TransactionVerifier.verifyCashout(
      userId: userId,
      tokenAmount: tokenAmount,
      currentBalance: currentBalance,
      pendingCashout: pendingCashout,
      hasBankAccount: hasBankAccount,
    );

    if (!verification.isValid) {
      return SecurityCheckResult.validationFailed(verification.errorMessage);
    }

    // Fraud check
    final fraudCheck = _fraudDetector.checkCashout(
      userId: userId,
      amount: tokenAmount,
      accountAge: accountAgeDays,
    );

    if (!fraudCheck.allowed) {
      return SecurityCheckResult.fraudDetected(
        'Cashout flagged for review.',
        fraudCheck.alerts,
      );
    }

    return SecurityCheckResult.allowed();
  }

  /// Validate and check purchase
  SecurityCheckResult checkPurchase({
    required String userId,
    required int amount,
    required int currentBalance,
    required String productType,
  }) {
    // Rate limit check
    final rateCheck = checkAction(userId: userId, action: 'purchase');
    if (!rateCheck.allowed) return rateCheck;

    // Transaction verification
    final verification = TransactionVerifier.verifyPurchase(
      userId: userId,
      amount: amount,
      currentBalance: currentBalance,
      productType: productType,
    );

    if (!verification.isValid) {
      return SecurityCheckResult.validationFailed(verification.errorMessage);
    }

    return SecurityCheckResult.allowed();
  }

  /// Validate referral code application
  SecurityCheckResult checkReferralApplication({
    required String userId,
    required String referralCode,
  }) {
    // Rate limit check
    final rateCheck = checkAction(userId: userId, action: 'referral_apply');
    if (!rateCheck.allowed) return rateCheck;

    // Input validation
    final codeValidation = InputValidator.validateReferralCode(referralCode);
    if (!codeValidation.isValid) {
      return SecurityCheckResult.validationFailed(codeValidation.errorMessage!);
    }

    return SecurityCheckResult.allowed();
  }

  /// Get user risk score
  int getUserRiskScore(String userId) {
    return _fraudDetector.getUserRiskScore(userId);
  }

  /// Reset daily counters (call at midnight)
  void resetDailyCounters() {
    _fraudDetector.resetDailyCounters();
  }

  /// Clear user data on logout
  void clearUserData(String userId) {
    _rateLimiter.clearUserData(userId);
  }
}

/// Result of a security check
class SecurityCheckResult {
  final bool allowed;
  final SecurityCheckFailureReason? failureReason;
  final String? message;
  final Duration? retryAfter;
  final List<String>? alerts;

  const SecurityCheckResult._({
    required this.allowed,
    this.failureReason,
    this.message,
    this.retryAfter,
    this.alerts,
  });

  factory SecurityCheckResult.allowed() {
    return const SecurityCheckResult._(allowed: true);
  }

  factory SecurityCheckResult.rateLimited(String message, Duration? retryAfter) {
    return SecurityCheckResult._(
      allowed: false,
      failureReason: SecurityCheckFailureReason.rateLimited,
      message: message,
      retryAfter: retryAfter,
    );
  }

  factory SecurityCheckResult.blocked(String message) {
    return SecurityCheckResult._(
      allowed: false,
      failureReason: SecurityCheckFailureReason.blocked,
      message: message,
    );
  }

  factory SecurityCheckResult.validationFailed(String message) {
    return SecurityCheckResult._(
      allowed: false,
      failureReason: SecurityCheckFailureReason.validationFailed,
      message: message,
    );
  }

  factory SecurityCheckResult.fraudDetected(String message, List<String> alerts) {
    return SecurityCheckResult._(
      allowed: false,
      failureReason: SecurityCheckFailureReason.fraudDetected,
      message: message,
      alerts: alerts,
    );
  }
}

/// Reasons for security check failure
enum SecurityCheckFailureReason {
  rateLimited,
  blocked,
  validationFailed,
  fraudDetected,
}
