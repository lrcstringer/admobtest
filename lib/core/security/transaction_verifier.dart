/// Transaction Verifier
/// Validates transactions before processing
library;

import '../error/failures.dart';

class TransactionVerifier {
  /// Verify earning transaction
  static TransactionVerification verifyEarning({
    required String userId,
    required int amount,
    required String source,
    required int currentBalance,
    required int todayEarned,
    required int dailyLimit,
  }) {
    final errors = <String>[];

    // Validate amount
    if (amount <= 0) {
      errors.add('Invalid earning amount');
    }

    if (amount > 10000) {
      errors.add('Single earning exceeds maximum (10000 tokens)');
    }

    // Check daily limit
    if (todayEarned + amount > dailyLimit) {
      errors.add('Would exceed daily earning limit');
    }

    // Validate source
    final validSources = ['ad_view', 'survey', 'referral', 'pot_win', 'bonus'];
    if (!validSources.contains(source)) {
      errors.add('Invalid earning source');
    }

    return TransactionVerification(
      isValid: errors.isEmpty,
      errors: errors,
      expectedNewBalance: currentBalance + amount,
    );
  }

  /// Verify transfer transaction
  static TransactionVerification verifyTransfer({
    required String senderId,
    required String recipientId,
    required int amount,
    required int senderBalance,
  }) {
    final errors = <String>[];

    // Validate parties
    if (senderId.isEmpty) {
      errors.add('Sender ID is required');
    }

    if (recipientId.isEmpty) {
      errors.add('Recipient ID is required');
    }

    if (senderId == recipientId) {
      errors.add('Cannot transfer to yourself');
    }

    // Validate amount
    if (amount <= 0) {
      errors.add('Transfer amount must be positive');
    }

    if (amount < 100) {
      errors.add('Minimum transfer is 100 tokens');
    }

    if (amount > 100000) {
      errors.add('Maximum transfer is 100,000 tokens');
    }

    // Check balance
    if (amount > senderBalance) {
      errors.add('Insufficient balance');
    }

    return TransactionVerification(
      isValid: errors.isEmpty,
      errors: errors,
      expectedNewBalance: senderBalance - amount,
    );
  }

  /// Verify cashout transaction
  static TransactionVerification verifyCashout({
    required String userId,
    required int tokenAmount,
    required int currentBalance,
    required int pendingCashout,
    required bool hasBankAccount,
  }) {
    final errors = <String>[];

    // Validate amount
    if (tokenAmount <= 0) {
      errors.add('Cashout amount must be positive');
    }

    // Minimum cashout (R50 = 5000 tokens)
    if (tokenAmount < 5000) {
      errors.add('Minimum cashout is 5000 tokens (R50)');
    }

    // Maximum cashout per transaction (R5000 = 500,000 tokens)
    if (tokenAmount > 500000) {
      errors.add('Maximum cashout is 500,000 tokens (R5000)');
    }

    // Check available balance (excluding pending)
    final availableBalance = currentBalance - pendingCashout;
    if (tokenAmount > availableBalance) {
      errors.add('Insufficient available balance');
    }

    // Check bank account
    if (!hasBankAccount) {
      errors.add('Bank account required for cashout');
    }

    // Calculate ZAR amount
    final zarAmount = tokenAmount * 0.01;

    return TransactionVerification(
      isValid: errors.isEmpty,
      errors: errors,
      expectedNewBalance: currentBalance,
      metadata: {'zarAmount': zarAmount},
    );
  }

  /// Verify purchase transaction
  static TransactionVerification verifyPurchase({
    required String userId,
    required int amount,
    required int currentBalance,
    required String productType,
  }) {
    final errors = <String>[];

    // Validate amount
    if (amount <= 0) {
      errors.add('Purchase amount must be positive');
    }

    // Check balance
    if (amount > currentBalance) {
      errors.add('Insufficient balance');
    }

    // Validate product type
    final validTypes = ['airtime', 'data', 'electricity'];
    if (!validTypes.contains(productType)) {
      errors.add('Invalid product type');
    }

    // Product-specific limits
    if (productType == 'airtime' && amount > 100000) {
      errors.add('Maximum airtime purchase is R1000');
    }

    if (productType == 'data' && amount > 200000) {
      errors.add('Maximum data purchase is R2000');
    }

    if (productType == 'electricity' && amount > 500000) {
      errors.add('Maximum electricity purchase is R5000');
    }

    return TransactionVerification(
      isValid: errors.isEmpty,
      errors: errors,
      expectedNewBalance: currentBalance - amount,
    );
  }

  /// Verify referral reward
  static TransactionVerification verifyReferralReward({
    required String referrerId,
    required String refereeId,
    required int referrerReward,
    required int refereeReward,
    required bool referralCodeValid,
    required bool refereeIsNew,
  }) {
    final errors = <String>[];

    // Validate parties
    if (referrerId == refereeId) {
      errors.add('Cannot refer yourself');
    }

    // Validate referral code
    if (!referralCodeValid) {
      errors.add('Invalid referral code');
    }

    // Check if referee is new user
    if (!refereeIsNew) {
      errors.add('Referral only valid for new users');
    }

    // Validate reward amounts
    if (referrerReward < 0 || referrerReward > 1000) {
      errors.add('Invalid referrer reward amount');
    }

    if (refereeReward < 0 || refereeReward > 500) {
      errors.add('Invalid referee reward amount');
    }

    return TransactionVerification(
      isValid: errors.isEmpty,
      errors: errors,
      metadata: {
        'referrerReward': referrerReward,
        'refereeReward': refereeReward,
      },
    );
  }

  /// Convert verification errors to Failure
  static Failure? toFailure(TransactionVerification verification) {
    if (verification.isValid) return null;

    final message = verification.errors.join('; ');

    // Map specific errors to failure types
    if (verification.errors.any((e) => e.contains('Insufficient'))) {
      return const Failure.insufficientBalance();
    }

    return Failure.serverError(message: message);
  }
}

/// Result of transaction verification
class TransactionVerification {
  final bool isValid;
  final List<String> errors;
  final int? expectedNewBalance;
  final Map<String, dynamic>? metadata;

  const TransactionVerification({
    required this.isValid,
    this.errors = const [],
    this.expectedNewBalance,
    this.metadata,
  });

  String get errorMessage => errors.join('; ');
}
