import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/ledger_journal.dart';

void main() {
  group('LedgerJournal', () {
    // Helper
    LedgerJournal createJournal({
      int totalDebits = 100,
      int totalCredits = 100,
      LedgerJournalStatus status = LedgerJournalStatus.posted,
      List<LedgerEntry>? entries,
    }) {
      return LedgerJournal(
        id: 'journal1',
        idempotencyKey: 'key1',
        type: LedgerJournalType.earn,
        status: status,
        description: 'Test',
        entries: entries ?? [],
        totalDebits: totalDebits,
        totalCredits: totalCredits,
        initiatedBy: 'system',
        createdAt: DateTime(2024, 1, 1),
        postedAt: DateTime(2024, 1, 1),
      );
    }

    group('isBalanced', () {
      test('returns true when totalDebits equals totalCredits', () {
        final journal = createJournal(totalDebits: 500, totalCredits: 500);
        expect(journal.isBalanced, isTrue);
      });

      test('returns false when totalDebits differs from totalCredits', () {
        final journal = createJournal(totalDebits: 500, totalCredits: 300);
        expect(journal.isBalanced, isFalse);
      });
    });

    group('isReversed', () {
      test('returns true when status is reversed', () {
        final journal = createJournal(status: LedgerJournalStatus.reversed);
        expect(journal.isReversed, isTrue);
      });

      test('returns false when status is posted', () {
        final journal = createJournal(status: LedgerJournalStatus.posted);
        expect(journal.isReversed, isFalse);
      });

      test('returns false when status is pending', () {
        final journal = createJournal(status: LedgerJournalStatus.pending);
        expect(journal.isReversed, isFalse);
      });
    });

    group('isPosted', () {
      test('returns true when status is posted', () {
        final journal = createJournal(status: LedgerJournalStatus.posted);
        expect(journal.isPosted, isTrue);
      });

      test('returns false when status is pending', () {
        final journal = createJournal(status: LedgerJournalStatus.pending);
        expect(journal.isPosted, isFalse);
      });

      test('returns false when status is reversed', () {
        final journal = createJournal(status: LedgerJournalStatus.reversed);
        expect(journal.isPosted, isFalse);
      });

      test('returns false when status is failed', () {
        final journal = createJournal(status: LedgerJournalStatus.failed);
        expect(journal.isPosted, isFalse);
      });
    });

    group('LedgerEntry construction', () {
      test('stores all fields correctly', () {
        const entry = LedgerEntry(
          id: 'entry1',
          accountId: 'acc_user_123',
          entryType: LedgerEntryType.debit,
          amount: 250,
          balanceAfter: 750,
          description: 'Earn payout',
        );

        expect(entry.id, 'entry1');
        expect(entry.accountId, 'acc_user_123');
        expect(entry.entryType, LedgerEntryType.debit);
        expect(entry.amount, 250);
        expect(entry.balanceAfter, 750);
        expect(entry.description, 'Earn payout');
      });
    });

    group('LedgerJournal construction', () {
      test('stores entries list correctly', () {
        final entries = [
          const LedgerEntry(
            id: 'e1',
            accountId: 'acc_escrow',
            entryType: LedgerEntryType.debit,
            amount: 100,
            balanceAfter: 900,
          ),
          const LedgerEntry(
            id: 'e2',
            accountId: 'acc_user',
            entryType: LedgerEntryType.credit,
            amount: 100,
            balanceAfter: 200,
          ),
        ];

        final journal = createJournal(entries: entries);

        expect(journal.entries, hasLength(2));
        expect(journal.entries[0].id, 'e1');
        expect(journal.entries[0].entryType, LedgerEntryType.debit);
        expect(journal.entries[1].id, 'e2');
        expect(journal.entries[1].entryType, LedgerEntryType.credit);
      });
    });
  });
}
