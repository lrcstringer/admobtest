import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/ledger_account.dart';

void main() {
  group('LedgerAccount', () {
    // Helper to create test accounts with sensible defaults
    LedgerAccount createAccount({
      String id = 'user:user123',
      LedgerAccountType type = LedgerAccountType.user,
      int balance = 10000,
      int allocatedBalance = 0,
      LedgerAccountStatus status = LedgerAccountStatus.active,
    }) {
      return LedgerAccount(
        id: id,
        type: type,
        name: 'Test Account',
        ownerId: 'user123',
        balance: balance,
        allocatedBalance: allocatedBalance,
        status: status,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );
    }

    // ── isUserAccount ──────────────────────────────────────────────────

    group('isUserAccount', () {
      test('returns true for user type', () {
        final account = createAccount(type: LedgerAccountType.user);
        expect(account.isUserAccount, isTrue);
      });

      test('returns false for system type', () {
        final account = createAccount(type: LedgerAccountType.system);
        expect(account.isUserAccount, isFalse);
      });

      test('returns false for pot type', () {
        final account = createAccount(type: LedgerAccountType.pot);
        expect(account.isUserAccount, isFalse);
      });

      test('returns false for client type', () {
        final account = createAccount(type: LedgerAccountType.client);
        expect(account.isUserAccount, isFalse);
      });

      test('returns false for group type', () {
        final account = createAccount(type: LedgerAccountType.group);
        expect(account.isUserAccount, isFalse);
      });
    });

    // ── isActive ───────────────────────────────────────────────────────

    group('isActive', () {
      test('returns true for active status', () {
        final account = createAccount(status: LedgerAccountStatus.active);
        expect(account.isActive, isTrue);
      });

      test('returns false for frozen status', () {
        final account = createAccount(status: LedgerAccountStatus.frozen);
        expect(account.isActive, isFalse);
      });

      test('returns false for closed status', () {
        final account = createAccount(status: LedgerAccountStatus.closed);
        expect(account.isActive, isFalse);
      });
    });

    // ── mainWalletAvailable ────────────────────────────────────────────

    group('mainWalletAvailable', () {
      test('returns balance minus allocatedBalance', () {
        final account = createAccount(balance: 20000, allocatedBalance: 5000);
        expect(account.mainWalletAvailable, equals(15000));
      });

      test('returns full balance when allocatedBalance is 0', () {
        final account = createAccount(balance: 10000, allocatedBalance: 0);
        expect(account.mainWalletAvailable, equals(10000));
      });
    });

    // ── balanceZar (100 tokens = R1) ───────────────────────────────────

    group('balanceZar', () {
      test('converts 10000 tokens to R100.0', () {
        final account = createAccount(balance: 10000);
        expect(account.balanceZar, equals(100.0));
      });
    });

    // ── mainWalletAvailableZar ─────────────────────────────────────────

    group('mainWalletAvailableZar', () {
      test('converts available tokens to ZAR correctly', () {
        // (20000 - 5000) / 100 = R150.0
        final account = createAccount(balance: 20000, allocatedBalance: 5000);
        expect(account.mainWalletAvailableZar, equals(150.0));
      });
    });

    // ── userId ─────────────────────────────────────────────────────────

    group('userId', () {
      test('extracts user ID from user-prefixed account ID', () {
        final account = createAccount(id: 'user:user123');
        expect(account.userId, equals('user123'));
      });

      test('returns null for non-user account ID', () {
        final account = createAccount(id: 'system:earn');
        expect(account.userId, isNull);
      });
    });
  });
}
