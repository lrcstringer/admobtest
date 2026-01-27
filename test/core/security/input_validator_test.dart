import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/security/input_validator.dart';

void main() {
  group('InputValidator', () {
    group('validatePhoneNumber', () {
      test('should validate correct SA phone numbers', () {
        expect(
          InputValidator.validatePhoneNumber('0612345678').isValid,
          isTrue,
        );
        expect(
          InputValidator.validatePhoneNumber('+27612345678').isValid,
          isTrue,
        );
        expect(
          InputValidator.validatePhoneNumber('0712345678').isValid,
          isTrue,
        );
        expect(
          InputValidator.validatePhoneNumber('0812345678').isValid,
          isTrue,
        );
      });

      test('should reject invalid phone numbers', () {
        expect(
          InputValidator.validatePhoneNumber('123').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePhoneNumber('0512345678').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePhoneNumber('+1234567890').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePhoneNumber('').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePhoneNumber(null).isValid,
          isFalse,
        );
      });

      test('should handle phone numbers with spaces and dashes', () {
        expect(
          InputValidator.validatePhoneNumber('061 234 5678').isValid,
          isTrue,
        );
        expect(
          InputValidator.validatePhoneNumber('061-234-5678').isValid,
          isTrue,
        );
      });
    });

    group('validateEmail', () {
      test('should validate correct email addresses', () {
        expect(
          InputValidator.validateEmail('test@example.com').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateEmail('user.name@domain.co.za').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateEmail('user+tag@example.org').isValid,
          isTrue,
        );
      });

      test('should reject invalid email addresses', () {
        expect(
          InputValidator.validateEmail('notanemail').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateEmail('@nodomain.com').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateEmail('user@').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateEmail('').isValid,
          isFalse,
        );
      });
    });

    group('validateDisplayName', () {
      test('should validate correct display names', () {
        expect(
          InputValidator.validateDisplayName('John Doe').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateDisplayName('Jane').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateDisplayName('AB').isValid,
          isTrue,
        );
      });

      test('should reject invalid display names', () {
        expect(
          InputValidator.validateDisplayName('A').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateDisplayName('').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateDisplayName('John123').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateDisplayName('John@Doe').isValid,
          isFalse,
        );
      });

      test('should reject names that are too long', () {
        final longName = 'A' * 51;
        expect(
          InputValidator.validateDisplayName(longName).isValid,
          isFalse,
        );
      });
    });

    group('validateReferralCode', () {
      test('should validate correct referral codes', () {
        expect(
          InputValidator.validateReferralCode('ABC123').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateReferralCode('IMALI2024').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateReferralCode('123456').isValid,
          isTrue,
        );
      });

      test('should reject invalid referral codes', () {
        expect(
          InputValidator.validateReferralCode('abc').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateReferralCode('AB').isValid,
          isFalse,
        );
        expect(
          InputValidator.validateReferralCode('abc-123').isValid,
          isFalse,
        );
      });
    });

    group('validatePin', () {
      test('should validate correct PINs', () {
        expect(
          InputValidator.validatePin('1357').isValid,
          isTrue,
        );
        expect(
          InputValidator.validatePin('83729').isValid,
          isTrue,
        );
        expect(
          InputValidator.validatePin('947162').isValid,
          isTrue,
        );
      });

      test('should reject weak PINs', () {
        expect(
          InputValidator.validatePin('1111').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePin('1234').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePin('0000').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePin('4321').isValid,
          isFalse,
        );
      });

      test('should reject invalid PIN formats', () {
        expect(
          InputValidator.validatePin('123').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePin('1234567').isValid,
          isFalse,
        );
        expect(
          InputValidator.validatePin('abcd').isValid,
          isFalse,
        );
      });
    });

    group('validateTokenAmount', () {
      test('should validate correct amounts', () {
        expect(
          InputValidator.validateTokenAmount(100).isValid,
          isTrue,
        );
        expect(
          InputValidator.validateTokenAmount(10000).isValid,
          isTrue,
        );
        expect(
          InputValidator.validateTokenAmount(1).isValid,
          isTrue,
        );
      });

      test('should reject invalid amounts', () {
        expect(
          InputValidator.validateTokenAmount(0).isValid,
          isFalse,
        );
        expect(
          InputValidator.validateTokenAmount(-100).isValid,
          isFalse,
        );
        expect(
          InputValidator.validateTokenAmount(null).isValid,
          isFalse,
        );
      });

      test('should respect max amount', () {
        expect(
          InputValidator.validateTokenAmount(1000, maxAmount: 500).isValid,
          isFalse,
        );
        expect(
          InputValidator.validateTokenAmount(500, maxAmount: 500).isValid,
          isTrue,
        );
      });

      test('should reject amounts over system maximum', () {
        expect(
          InputValidator.validateTokenAmount(20000000).isValid,
          isFalse,
        );
      });
    });

    group('validateMessage', () {
      test('should validate normal messages', () {
        expect(
          InputValidator.validateMessage('Hello, how are you?').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateMessage('').isValid,
          isTrue,
        );
        expect(
          InputValidator.validateMessage(null).isValid,
          isTrue,
        );
      });

      test('should reject messages that are too long', () {
        final longMessage = 'A' * 1001;
        expect(
          InputValidator.validateMessage(longMessage).isValid,
          isFalse,
        );
      });
    });
  });
}
