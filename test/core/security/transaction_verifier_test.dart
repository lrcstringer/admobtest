import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/security/transaction_verifier.dart';

void main() {
  group('TransactionVerifier', () {
    group('verifyEarning', () {
      test('should verify valid earning transaction', () {
        final result = TransactionVerifier.verifyEarning(
          userId: 'user123',
          amount: 100,
          source: 'ad_view',
          currentBalance: 1000,
          todayEarned: 500,
          dailyLimit: 10000,
        );

        expect(result.isValid, isTrue);
        expect(result.expectedNewBalance, equals(1100));
      });

      test('should reject negative earning amount', () {
        final result = TransactionVerifier.verifyEarning(
          userId: 'user123',
          amount: -100,
          source: 'ad_view',
          currentBalance: 1000,
          todayEarned: 0,
          dailyLimit: 10000,
        );

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Invalid earning amount'));
      });

      test('should reject amount exceeding single earning max', () {
        final result = TransactionVerifier.verifyEarning(
          userId: 'user123',
          amount: 15000,
          source: 'ad_view',
          currentBalance: 1000,
          todayEarned: 0,
          dailyLimit: 100000,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('exceeds maximum'));
      });

      test('should reject earning that exceeds daily limit', () {
        final result = TransactionVerifier.verifyEarning(
          userId: 'user123',
          amount: 5000,
          source: 'ad_view',
          currentBalance: 1000,
          todayEarned: 8000,
          dailyLimit: 10000,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('daily earning limit'));
      });

      test('should reject invalid earning source', () {
        final result = TransactionVerifier.verifyEarning(
          userId: 'user123',
          amount: 100,
          source: 'invalid_source',
          currentBalance: 1000,
          todayEarned: 0,
          dailyLimit: 10000,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Invalid earning source'));
      });
    });

    group('verifyTransfer', () {
      test('should verify valid transfer', () {
        final result = TransactionVerifier.verifyTransfer(
          senderId: 'sender123',
          recipientId: 'recipient456',
          amount: 500,
          senderBalance: 1000,
        );

        expect(result.isValid, isTrue);
        expect(result.expectedNewBalance, equals(500));
      });

      test('should reject transfer to self', () {
        final result = TransactionVerifier.verifyTransfer(
          senderId: 'user123',
          recipientId: 'user123',
          amount: 500,
          senderBalance: 1000,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('yourself'));
      });

      test('should reject insufficient balance', () {
        final result = TransactionVerifier.verifyTransfer(
          senderId: 'sender123',
          recipientId: 'recipient456',
          amount: 5000,
          senderBalance: 1000,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Insufficient balance'));
      });

      test('should reject transfer below minimum', () {
        final result = TransactionVerifier.verifyTransfer(
          senderId: 'sender123',
          recipientId: 'recipient456',
          amount: 50,
          senderBalance: 1000,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Minimum transfer'));
      });

      test('should reject transfer above maximum', () {
        final result = TransactionVerifier.verifyTransfer(
          senderId: 'sender123',
          recipientId: 'recipient456',
          amount: 200000,
          senderBalance: 500000,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Maximum transfer'));
      });
    });

    group('verifyCashout', () {
      test('should verify valid cashout', () {
        final result = TransactionVerifier.verifyCashout(
          userId: 'user123',
          tokenAmount: 10000,
          currentBalance: 50000,
          pendingCashout: 0,
          hasBankAccount: true,
        );

        expect(result.isValid, isTrue);
        expect(result.metadata?['zarAmount'], equals(100.0)); // 10000 * 0.01
      });

      test('should reject cashout below minimum', () {
        final result = TransactionVerifier.verifyCashout(
          userId: 'user123',
          tokenAmount: 1000,
          currentBalance: 50000,
          pendingCashout: 0,
          hasBankAccount: true,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Minimum cashout'));
      });

      test('should reject cashout without bank account', () {
        final result = TransactionVerifier.verifyCashout(
          userId: 'user123',
          tokenAmount: 10000,
          currentBalance: 50000,
          pendingCashout: 0,
          hasBankAccount: false,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Bank account required'));
      });

      test('should consider pending cashout in balance check', () {
        final result = TransactionVerifier.verifyCashout(
          userId: 'user123',
          tokenAmount: 40000,
          currentBalance: 50000,
          pendingCashout: 20000,
          hasBankAccount: true,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Insufficient available balance'));
      });
    });

    group('verifyPurchase', () {
      test('should verify valid purchase', () {
        final result = TransactionVerifier.verifyPurchase(
          userId: 'user123',
          amount: 5000,
          currentBalance: 10000,
          productType: 'airtime',
        );

        expect(result.isValid, isTrue);
        expect(result.expectedNewBalance, equals(5000));
      });

      test('should reject invalid product type', () {
        final result = TransactionVerifier.verifyPurchase(
          userId: 'user123',
          amount: 5000,
          currentBalance: 10000,
          productType: 'invalid_type',
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Invalid product type'));
      });

      test('should reject insufficient balance', () {
        final result = TransactionVerifier.verifyPurchase(
          userId: 'user123',
          amount: 15000,
          currentBalance: 10000,
          productType: 'airtime',
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Insufficient balance'));
      });

      test('should enforce airtime purchase limit', () {
        final result = TransactionVerifier.verifyPurchase(
          userId: 'user123',
          amount: 150000,
          currentBalance: 500000,
          productType: 'airtime',
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Maximum airtime'));
      });
    });

    group('verifyReferralReward', () {
      test('should verify valid referral', () {
        final result = TransactionVerifier.verifyReferralReward(
          referrerId: 'referrer123',
          refereeId: 'referee456',
          referrerReward: 100,
          refereeReward: 50,
          referralCodeValid: true,
          refereeIsNew: true,
        );

        expect(result.isValid, isTrue);
      });

      test('should reject self-referral', () {
        final result = TransactionVerifier.verifyReferralReward(
          referrerId: 'user123',
          refereeId: 'user123',
          referrerReward: 100,
          refereeReward: 50,
          referralCodeValid: true,
          refereeIsNew: true,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('yourself'));
      });

      test('should reject invalid referral code', () {
        final result = TransactionVerifier.verifyReferralReward(
          referrerId: 'referrer123',
          refereeId: 'referee456',
          referrerReward: 100,
          refereeReward: 50,
          referralCodeValid: false,
          refereeIsNew: true,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('Invalid referral code'));
      });

      test('should reject referral for existing user', () {
        final result = TransactionVerifier.verifyReferralReward(
          referrerId: 'referrer123',
          refereeId: 'referee456',
          referrerReward: 100,
          refereeReward: 50,
          referralCodeValid: true,
          refereeIsNew: false,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('new users'));
      });
    });
  });
}
