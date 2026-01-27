import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/security/rate_limiter.dart';

void main() {
  group('RateLimiter', () {
    late RateLimiter rateLimiter;

    setUp(() {
      rateLimiter = RateLimiter();
    });

    test('should allow actions within rate limit', () {
      const userId = 'user123';
      const action = 'transfer';

      // Transfer limit is 10 per 5 minutes
      for (int i = 0; i < 10; i++) {
        expect(rateLimiter.checkAndRecord(userId, action), isTrue);
      }
    });

    test('should block actions exceeding rate limit', () {
      const userId = 'user123';
      const action = 'transfer';

      // Use up all allowed attempts
      for (int i = 0; i < 10; i++) {
        rateLimiter.checkAndRecord(userId, action);
      }

      // Next attempt should be blocked
      expect(rateLimiter.checkAndRecord(userId, action), isFalse);
    });

    test('should track different users independently', () {
      const user1 = 'user1';
      const user2 = 'user2';
      const action = 'transfer';

      // User 1 uses all attempts
      for (int i = 0; i < 10; i++) {
        rateLimiter.checkAndRecord(user1, action);
      }

      // User 2 should still be able to make requests
      expect(rateLimiter.checkAndRecord(user2, action), isTrue);
    });

    test('should track different actions independently', () {
      const userId = 'user123';

      // Use up transfer limit
      for (int i = 0; i < 10; i++) {
        rateLimiter.checkAndRecord(userId, 'transfer');
      }

      // Cashout action should still be available
      expect(rateLimiter.checkAndRecord(userId, 'cashout'), isTrue);
    });

    test('should return correct remaining attempts', () {
      const userId = 'user123';
      const action = 'transfer';

      // Use 5 attempts
      for (int i = 0; i < 5; i++) {
        rateLimiter.checkAndRecord(userId, action);
      }

      // Should have 5 remaining (10 - 5)
      expect(rateLimiter.getRemainingAttempts(userId, action), equals(5));
    });

    test('should allow unknown actions', () {
      const userId = 'user123';
      const action = 'unknown_action';

      // Unknown actions should always be allowed
      expect(rateLimiter.checkAndRecord(userId, action), isTrue);
      expect(rateLimiter.getRemainingAttempts(userId, action), equals(999));
    });

    test('should clear user data correctly', () {
      const userId = 'user123';
      const action = 'transfer';

      // Use some attempts
      for (int i = 0; i < 5; i++) {
        rateLimiter.checkAndRecord(userId, action);
      }

      // Clear user data
      rateLimiter.clearUserData(userId);

      // Should have full limit again
      expect(rateLimiter.getRemainingAttempts(userId, action), equals(10));
    });

    test('should clear all data correctly', () {
      rateLimiter.checkAndRecord('user1', 'transfer');
      rateLimiter.checkAndRecord('user2', 'cashout');

      rateLimiter.clearAll();

      expect(rateLimiter.getRemainingAttempts('user1', 'transfer'), equals(10));
      expect(rateLimiter.getRemainingAttempts('user2', 'cashout'), equals(3));
    });
  });

  group('RateLimitExceededException', () {
    test('should format message without retry time', () {
      const exception = RateLimitExceededException('transfer');
      expect(
        exception.toString(),
        contains('transfer'),
      );
      expect(
        exception.toString(),
        contains('try again later'),
      );
    });

    test('should format message with retry time', () {
      const exception = RateLimitExceededException(
        'transfer',
        Duration(minutes: 5),
      );
      expect(
        exception.toString(),
        contains('5 minutes'),
      );
    });
  });
}
