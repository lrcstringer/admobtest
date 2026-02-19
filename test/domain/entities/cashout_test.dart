import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/cashout.dart';
import 'package:imalichat/domain/enums/cashout_status.dart';

void main() {
  /// Helper that creates a [Cashout] with sensible defaults.
  /// Override only the fields you care about per test.
  Cashout makeCashout({
    CashoutStatus status = CashoutStatus.pending,
    CashoutMethod method = CashoutMethod.bankTransfer,
    double zarAmount = 50.0,
  }) {
    return Cashout(
      id: 'cashout-1',
      walletId: 'wallet-1',
      userId: 'user-1',
      tokenAmount: 5000,
      zarAmount: zarAmount,
      method: method,
      status: status,
      destinationDetails: '1234567890',
      createdAt: DateTime(2026, 1, 1),
    );
  }

  // ---------------------------------------------------------------------------
  // isPending
  // ---------------------------------------------------------------------------
  group('isPending', () {
    test('returns true when status is pending', () {
      final cashout = makeCashout(status: CashoutStatus.pending);
      expect(cashout.isPending, isTrue);
    });

    test('returns false when status is not pending', () {
      final cashout = makeCashout(status: CashoutStatus.processing);
      expect(cashout.isPending, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // isProcessing
  // ---------------------------------------------------------------------------
  group('isProcessing', () {
    test('returns true when status is processing', () {
      final cashout = makeCashout(status: CashoutStatus.processing);
      expect(cashout.isProcessing, isTrue);
    });

    test('returns false when status is not processing', () {
      final cashout = makeCashout(status: CashoutStatus.pending);
      expect(cashout.isProcessing, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // isComplete
  // ---------------------------------------------------------------------------
  group('isComplete', () {
    test('returns true when status is completed', () {
      final cashout = makeCashout(status: CashoutStatus.completed);
      expect(cashout.isComplete, isTrue);
    });

    test('returns false when status is not completed', () {
      final cashout = makeCashout(status: CashoutStatus.failed);
      expect(cashout.isComplete, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // isFailed
  // ---------------------------------------------------------------------------
  group('isFailed', () {
    test('returns true when status is failed', () {
      final cashout = makeCashout(status: CashoutStatus.failed);
      expect(cashout.isFailed, isTrue);
    });

    test('returns false when status is not failed', () {
      final cashout = makeCashout(status: CashoutStatus.completed);
      expect(cashout.isFailed, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // formattedZarAmount
  // ---------------------------------------------------------------------------
  group('formattedZarAmount', () {
    test('formats 50.0 as R50.00', () {
      final cashout = makeCashout(zarAmount: 50.0);
      expect(cashout.formattedZarAmount, 'R50.00');
    });

    test('formats 99.99 as R99.99', () {
      final cashout = makeCashout(zarAmount: 99.99);
      expect(cashout.formattedZarAmount, 'R99.99');
    });

    test('formats 0.0 as R0.00', () {
      final cashout = makeCashout(zarAmount: 0.0);
      expect(cashout.formattedZarAmount, 'R0.00');
    });
  });

  // ---------------------------------------------------------------------------
  // methodDisplayName
  // ---------------------------------------------------------------------------
  group('methodDisplayName', () {
    test('returns Bank Transfer for bankTransfer', () {
      final cashout = makeCashout(method: CashoutMethod.bankTransfer);
      expect(cashout.methodDisplayName, 'Bank Transfer');
    });

    test('returns E-Wallet for ewallet', () {
      final cashout = makeCashout(method: CashoutMethod.ewallet);
      expect(cashout.methodDisplayName, 'E-Wallet');
    });

    test('returns Airtime for airtime', () {
      final cashout = makeCashout(method: CashoutMethod.airtime);
      expect(cashout.methodDisplayName, 'Airtime');
    });

    test('returns Voucher for voucher', () {
      final cashout = makeCashout(method: CashoutMethod.voucher);
      expect(cashout.methodDisplayName, 'Voucher');
    });
  });

  // ---------------------------------------------------------------------------
  // statusDisplayName
  // ---------------------------------------------------------------------------
  group('statusDisplayName', () {
    test('returns Pending for pending', () {
      final cashout = makeCashout(status: CashoutStatus.pending);
      expect(cashout.statusDisplayName, 'Pending');
    });

    test('returns On Hold for onHold', () {
      final cashout = makeCashout(status: CashoutStatus.onHold);
      expect(cashout.statusDisplayName, 'On Hold');
    });

    test('returns Processing for processing', () {
      final cashout = makeCashout(status: CashoutStatus.processing);
      expect(cashout.statusDisplayName, 'Processing');
    });

    test('returns Completed for completed', () {
      final cashout = makeCashout(status: CashoutStatus.completed);
      expect(cashout.statusDisplayName, 'Completed');
    });

    test('returns Failed for failed', () {
      final cashout = makeCashout(status: CashoutStatus.failed);
      expect(cashout.statusDisplayName, 'Failed');
    });

    test('returns Cancelled for cancelled', () {
      final cashout = makeCashout(status: CashoutStatus.cancelled);
      expect(cashout.statusDisplayName, 'Cancelled');
    });
  });
}
