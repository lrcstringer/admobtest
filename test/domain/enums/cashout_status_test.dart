import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/enums/cashout_status.dart';

void main() {
  group('CashoutStatus', () {
    // ---------------------------------------------------------------
    // isPending
    // ---------------------------------------------------------------
    group('isPending', () {
      test('returns true for pending', () {
        expect(CashoutStatus.pending.isPending, isTrue);
      });

      test('returns true for onHold', () {
        expect(CashoutStatus.onHold.isPending, isTrue);
      });

      test('returns false for processing', () {
        expect(CashoutStatus.processing.isPending, isFalse);
      });

      test('returns false for completed', () {
        expect(CashoutStatus.completed.isPending, isFalse);
      });

      test('returns false for failed', () {
        expect(CashoutStatus.failed.isPending, isFalse);
      });

      test('returns false for cancelled', () {
        expect(CashoutStatus.cancelled.isPending, isFalse);
      });
    });

    // ---------------------------------------------------------------
    // isProcessing
    // ---------------------------------------------------------------
    group('isProcessing', () {
      test('returns true only for processing', () {
        expect(CashoutStatus.processing.isProcessing, isTrue);
      });

      test('returns false for all other statuses', () {
        final others = CashoutStatus.values
            .where((s) => s != CashoutStatus.processing);
        for (final status in others) {
          expect(status.isProcessing, isFalse,
              reason: '${status.name} should not be isProcessing');
        }
      });
    });

    // ---------------------------------------------------------------
    // isComplete
    // ---------------------------------------------------------------
    group('isComplete', () {
      test('returns true only for completed', () {
        expect(CashoutStatus.completed.isComplete, isTrue);
      });

      test('returns false for all other statuses', () {
        final others = CashoutStatus.values
            .where((s) => s != CashoutStatus.completed);
        for (final status in others) {
          expect(status.isComplete, isFalse,
              reason: '${status.name} should not be isComplete');
        }
      });
    });

    // ---------------------------------------------------------------
    // isFailed
    // ---------------------------------------------------------------
    group('isFailed', () {
      test('returns true only for failed', () {
        expect(CashoutStatus.failed.isFailed, isTrue);
      });

      test('returns false for all other statuses', () {
        final others =
            CashoutStatus.values.where((s) => s != CashoutStatus.failed);
        for (final status in others) {
          expect(status.isFailed, isFalse,
              reason: '${status.name} should not be isFailed');
        }
      });
    });

    // ---------------------------------------------------------------
    // displayName
    // ---------------------------------------------------------------
    group('displayName', () {
      test('returns correct display name for every status', () {
        expect(CashoutStatus.pending.displayName, 'Pending');
        expect(CashoutStatus.onHold.displayName, 'On Hold');
        expect(CashoutStatus.processing.displayName, 'Processing');
        expect(CashoutStatus.completed.displayName, 'Completed');
        expect(CashoutStatus.failed.displayName, 'Failed');
        expect(CashoutStatus.cancelled.displayName, 'Cancelled');
      });
    });
  });
}
