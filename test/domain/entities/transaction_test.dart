import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/transaction.dart';
import 'package:imalichat/domain/enums/transaction_type.dart';

void main() {
  group('Transaction', () {
    group('isCredit', () {
      test('returns true for earn transaction', () {
        final tx = Transaction(
          id: 'tx1',
          walletId: 'wallet1',
          type: TransactionType.earn,
          amount: 100,
          balanceAfter: 1100,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.isCredit, true);
        expect(tx.isDebit, false);
      });

      test('returns true for potWin transaction', () {
        final tx = Transaction(
          id: 'tx2',
          walletId: 'wallet1',
          type: TransactionType.potWin,
          amount: 1000,
          balanceAfter: 2000,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.isCredit, true);
      });

      test('returns true for p2pReceive transaction', () {
        final tx = Transaction(
          id: 'tx3',
          walletId: 'wallet1',
          type: TransactionType.p2pReceive,
          amount: 500,
          balanceAfter: 1500,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.isCredit, true);
      });

      test('returns true for referral transaction', () {
        final tx = Transaction(
          id: 'tx4',
          walletId: 'wallet1',
          type: TransactionType.referral,
          amount: 250,
          balanceAfter: 1250,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.isCredit, true);
      });
    });

    group('isDebit', () {
      test('returns true for p2pSend transaction', () {
        final tx = Transaction(
          id: 'tx5',
          walletId: 'wallet1',
          type: TransactionType.p2pSend,
          amount: 500,
          balanceAfter: 500,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.isDebit, true);
        expect(tx.isCredit, false);
      });

      test('returns true for cashout transaction', () {
        final tx = Transaction(
          id: 'tx6',
          walletId: 'wallet1',
          type: TransactionType.cashout,
          amount: 5000,
          balanceAfter: 0,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.isDebit, true);
      });

      test('returns true for purchase transaction', () {
        final tx = Transaction(
          id: 'tx7',
          walletId: 'wallet1',
          type: TransactionType.purchase,
          amount: 2000,
          balanceAfter: 3000,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.isDebit, true);
      });
    });

    group('signedAmount', () {
      test('returns positive for credit', () {
        final tx = Transaction(
          id: 'tx1',
          walletId: 'wallet1',
          type: TransactionType.earn,
          amount: 100,
          balanceAfter: 1100,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.signedAmount, 100);
      });

      test('returns negative for debit', () {
        final tx = Transaction(
          id: 'tx2',
          walletId: 'wallet1',
          type: TransactionType.p2pSend,
          amount: 500,
          balanceAfter: 500,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.signedAmount, -500);
      });
    });

    group('formattedAmount', () {
      test('formats credit with plus sign', () {
        final tx = Transaction(
          id: 'tx1',
          walletId: 'wallet1',
          type: TransactionType.earn,
          amount: 1000,
          balanceAfter: 2000,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.formattedAmount, startsWith('+'));
      });

      test('formats debit with minus sign', () {
        final tx = Transaction(
          id: 'tx2',
          walletId: 'wallet1',
          type: TransactionType.cashout,
          amount: 1000,
          balanceAfter: 1000,
          createdAt: DateTime(2024, 1, 1),
        );
        expect(tx.formattedAmount, startsWith('-'));
      });
    });
  });

  group('TransactionType', () {
    test('displayName returns correct values', () {
      expect(TransactionType.earn.displayName, 'Earned');
      expect(TransactionType.potWin.displayName, 'Pot Win');
      expect(TransactionType.p2pSend.displayName, 'Sent');
      expect(TransactionType.p2pReceive.displayName, 'Received');
      expect(TransactionType.cashout.displayName, 'Cashout');
      expect(TransactionType.referral.displayName, 'Referral Bonus');
      expect(TransactionType.purchase.displayName, 'Purchase');
    });
  });
}
