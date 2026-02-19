import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/sub_account.dart';
import 'package:imalichat/domain/value_objects/token_amount.dart';

void main() {
  group('SubAccount', () {
    SubAccount createSubAccount({
      String? accountTypeId,
      int balance = 3000,
    }) {
      return SubAccount(
        id: 'sub1',
        userId: 'user123',
        accountTypeId: accountTypeId,
        name: 'Test Wallet',
        balance: balance,
        lifetimeCredits: 5000,
        lifetimeDebits: 2000,
        isActive: true,
        isDefault: true,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );
    }

    group('tokenBalance', () {
      test('returns TokenAmount with correct value for non-zero balance', () {
        final account = createSubAccount(balance: 3000);

        expect(account.tokenBalance, equals(const TokenAmount(3000)));
        expect(account.tokenBalance.value, 3000);
      });

      test('returns TokenAmount with zero value for zero balance', () {
        final account = createSubAccount(balance: 0);

        expect(account.tokenBalance, equals(const TokenAmount(0)));
        expect(account.tokenBalance.value, 0);
      });
    });

    group('balanceZar', () {
      test('converts 3000 tokens to R30.0', () {
        final account = createSubAccount(balance: 3000);

        expect(account.balanceZar, 30.0);
      });

      test('converts 0 tokens to R0.0', () {
        final account = createSubAccount(balance: 0);

        expect(account.balanceZar, 0.0);
      });

      test('converts 100 tokens to R1.0', () {
        final account = createSubAccount(balance: 100);

        expect(account.balanceZar, 1.0);
      });

      test('converts 1 token to R0.01', () {
        final account = createSubAccount(balance: 1);

        expect(account.balanceZar, 0.01);
      });
    });

    group('isRestricted', () {
      test('returns true when accountTypeId is not null', () {
        final account = createSubAccount(accountTypeId: 'brand-abc');

        expect(account.isRestricted, isTrue);
      });

      test('returns false when accountTypeId is null', () {
        final account = createSubAccount(accountTypeId: null);

        expect(account.isRestricted, isFalse);
      });
    });
  });
}
