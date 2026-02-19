import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/ledger_journal_model.dart';
import 'package:imalichat/domain/entities/ledger_journal.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Map<String, dynamic> createEntryJson({
    String id = 'entry_1',
    String accountId = 'user:user123',
    String entryType = 'credit',
    int amount = 100,
    int balanceAfter = 10100,
    String? description = 'Earned tokens',
  }) {
    return {
      'id': id,
      'accountId': accountId,
      'entryType': entryType,
      'amount': amount,
      'balanceAfter': balanceAfter,
      if (description != null) 'description': description,
    };
  }

  Map<String, dynamic> createJournalJson({
    String id = 'journal_001',
    String idempotencyKey = 'earn-user123-20240101-001',
    String type = 'earn',
    String status = 'posted',
    String description = 'Watched ad',
    List<Map<String, dynamic>>? entries,
    int totalDebits = 100,
    int totalCredits = 100,
    String? referenceType = 'engagement',
    String? referenceId = 'eng_001',
    String initiatedBy = 'system',
    String? approvedBy,
    String? createdAt = '2024-06-15T10:30:00.000Z',
    String? postedAt = '2024-06-15T10:30:01.000Z',
    String? reversedAt,
    String? reversedBy,
    String? reversalJournalId,
    String? originalJournalId,
    Map<String, dynamic>? metadata,
  }) {
    return {
      'id': id,
      'idempotencyKey': idempotencyKey,
      'type': type,
      'status': status,
      'description': description,
      'entries': entries ??
          [
            createEntryJson(
              id: 'entry_cr',
              accountId: 'user:user123',
              entryType: 'credit',
              amount: 100,
              balanceAfter: 10100,
            ),
            createEntryJson(
              id: 'entry_dr',
              accountId: 'system:earn',
              entryType: 'debit',
              amount: 100,
              balanceAfter: 0,
            ),
          ],
      'totalDebits': totalDebits,
      'totalCredits': totalCredits,
      if (referenceType != null) 'referenceType': referenceType,
      if (referenceId != null) 'referenceId': referenceId,
      'initiatedBy': initiatedBy,
      if (approvedBy != null) 'approvedBy': approvedBy,
      if (createdAt != null) 'createdAt': createdAt,
      if (postedAt != null) 'postedAt': postedAt,
      if (reversedAt != null) 'reversedAt': reversedAt,
      if (reversedBy != null) 'reversedBy': reversedBy,
      if (reversalJournalId != null) 'reversalJournalId': reversalJournalId,
      if (originalJournalId != null) 'originalJournalId': originalJournalId,
      if (metadata != null) 'metadata': metadata,
    };
  }

  // ---------------------------------------------------------------------------
  // LedgerEntryModel
  // ---------------------------------------------------------------------------

  group('LedgerEntryModel', () {
    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createEntryJson(
          id: 'entry_42',
          accountId: 'user:abc',
          entryType: 'credit',
          amount: 250,
          balanceAfter: 5000,
          description: 'Bonus reward',
        );

        final model = LedgerEntryModel.fromJson(json);

        expect(model.id, equals('entry_42'));
        expect(model.accountId, equals('user:abc'));
        expect(model.entryType, equals(LedgerEntryType.credit));
        expect(model.amount, equals(250));
        expect(model.balanceAfter, equals(5000));
        expect(model.description, equals('Bonus reward'));
      });

      test('parses debit entry type', () {
        final json = createEntryJson(entryType: 'debit');
        final model = LedgerEntryModel.fromJson(json);

        expect(model.entryType, equals(LedgerEntryType.debit));
      });

      test('parses credit entry type', () {
        final json = createEntryJson(entryType: 'credit');
        final model = LedgerEntryModel.fromJson(json);

        expect(model.entryType, equals(LedgerEntryType.credit));
      });

      test('defaults to debit for unknown entry type', () {
        final json = createEntryJson(entryType: 'unknown_type');
        final model = LedgerEntryModel.fromJson(json);

        expect(model.entryType, equals(LedgerEntryType.debit));
      });
    });

    group('toEntity', () {
      test('converts correctly to LedgerEntry', () {
        final json = createEntryJson(
          id: 'entry_99',
          accountId: 'system:pot',
          entryType: 'credit',
          amount: 500,
          balanceAfter: 12000,
          description: 'Pot win',
        );
        final model = LedgerEntryModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity, isA<LedgerEntry>());
        expect(entity.id, equals('entry_99'));
        expect(entity.accountId, equals('system:pot'));
        expect(entity.entryType, equals(LedgerEntryType.credit));
        expect(entity.amount, equals(500));
        expect(entity.balanceAfter, equals(12000));
        expect(entity.description, equals('Pot win'));
      });
    });
  });

  // ---------------------------------------------------------------------------
  // LedgerJournalModel
  // ---------------------------------------------------------------------------

  group('LedgerJournalModel', () {
    group('fromJson', () {
      test('parses all fields correctly from complete JSON', () {
        final json = createJournalJson(
          id: 'j_full',
          idempotencyKey: 'key-full-001',
          type: 'earn',
          status: 'posted',
          description: 'Full journal',
          totalDebits: 200,
          totalCredits: 200,
          referenceType: 'engagement',
          referenceId: 'eng_full',
          initiatedBy: 'system',
          approvedBy: 'admin_1',
          createdAt: '2024-06-15T10:00:00.000Z',
          postedAt: '2024-06-15T10:00:01.000Z',
          reversedAt: '2024-06-16T08:00:00.000Z',
          reversedBy: 'admin_2',
          reversalJournalId: 'j_reversal',
          originalJournalId: 'j_original',
          metadata: {'source': 'test', 'version': 2},
        );

        final model = LedgerJournalModel.fromJson(json);

        expect(model.id, equals('j_full'));
        expect(model.idempotencyKey, equals('key-full-001'));
        expect(model.type, equals(LedgerJournalType.earn));
        expect(model.status, equals(LedgerJournalStatus.posted));
        expect(model.description, equals('Full journal'));
        expect(model.totalDebits, equals(200));
        expect(model.totalCredits, equals(200));
        expect(model.referenceType, equals(LedgerReferenceType.engagement));
        expect(model.referenceId, equals('eng_full'));
        expect(model.initiatedBy, equals('system'));
        expect(model.approvedBy, equals('admin_1'));
        expect(model.reversedBy, equals('admin_2'));
        expect(model.reversalJournalId, equals('j_reversal'));
        expect(model.originalJournalId, equals('j_original'));
        expect(model.metadata, equals({'source': 'test', 'version': 2}));
      });

      test('parses entries list correctly', () {
        final json = createJournalJson(
          entries: [
            createEntryJson(id: 'e1', entryType: 'debit', amount: 300),
            createEntryJson(id: 'e2', entryType: 'credit', amount: 300),
            createEntryJson(id: 'e3', entryType: 'debit', amount: 50),
          ],
        );

        final model = LedgerJournalModel.fromJson(json);

        expect(model.entries, hasLength(3));
        expect(model.entries[0].id, equals('e1'));
        expect(model.entries[0].entryType, equals(LedgerEntryType.debit));
        expect(model.entries[1].id, equals('e2'));
        expect(model.entries[1].entryType, equals(LedgerEntryType.credit));
        expect(model.entries[2].id, equals('e3'));
      });

      test('handles empty entries list', () {
        final json = createJournalJson(entries: []);
        final model = LedgerJournalModel.fromJson(json);

        expect(model.entries, isEmpty);
      });

      test('parses all 14 journal types', () {
        // Map of JSON string -> expected enum value
        final typeMap = <String, LedgerJournalType>{
          'earn': LedgerJournalType.earn,
          'potContribution': LedgerJournalType.potContribution,
          'potWin': LedgerJournalType.potWin,
          'purchase': LedgerJournalType.purchase,
          'referralReward': LedgerJournalType.referralReward,
          'p2pTransfer': LedgerJournalType.p2pTransfer,
          'cashoutInitiate': LedgerJournalType.cashoutInitiate,
          'cashoutComplete': LedgerJournalType.cashoutComplete,
          'cashoutFailed': LedgerJournalType.cashoutFailed,
          'reversal': LedgerJournalType.reversal,
          'adjustment': LedgerJournalType.adjustment,
          'clientFund': LedgerJournalType.clientFund,
          'clientRefund': LedgerJournalType.clientRefund,
          'subaccFund': LedgerJournalType.subaccFund,
        };

        for (final entry in typeMap.entries) {
          final json = createJournalJson(type: entry.key);
          final model = LedgerJournalModel.fromJson(json);

          expect(
            model.type,
            equals(entry.value),
            reason: 'type "${entry.key}" should parse to ${entry.value}',
          );
        }
      });

      test('defaults to earn for unknown journal type', () {
        final json = createJournalJson(type: 'nonexistent_type');
        final model = LedgerJournalModel.fromJson(json);

        expect(model.type, equals(LedgerJournalType.earn));
      });

      test('parses all 4 journal statuses', () {
        final statusMap = <String, LedgerJournalStatus>{
          'pending': LedgerJournalStatus.pending,
          'posted': LedgerJournalStatus.posted,
          'failed': LedgerJournalStatus.failed,
          'reversed': LedgerJournalStatus.reversed,
        };

        for (final entry in statusMap.entries) {
          final json = createJournalJson(status: entry.key);
          final model = LedgerJournalModel.fromJson(json);

          expect(
            model.status,
            equals(entry.value),
            reason: 'status "${entry.key}" should parse to ${entry.value}',
          );
        }
      });

      test('defaults to pending for unknown status', () {
        final json = createJournalJson(status: 'unknown_status');
        final model = LedgerJournalModel.fromJson(json);

        expect(model.status, equals(LedgerJournalStatus.pending));
      });

      test('parses all 8 reference types', () {
        final refMap = <String, LedgerReferenceType>{
          'engagement': LedgerReferenceType.engagement,
          'purchase': LedgerReferenceType.purchase,
          'referral': LedgerReferenceType.referral,
          'transfer': LedgerReferenceType.transfer,
          'cashout': LedgerReferenceType.cashout,
          'potDraw': LedgerReferenceType.potDraw,
          'potEntry': LedgerReferenceType.potEntry,
          'client_fund': LedgerReferenceType.clientFund,
        };

        for (final entry in refMap.entries) {
          final json = createJournalJson(referenceType: entry.key);
          final model = LedgerJournalModel.fromJson(json);

          expect(
            model.referenceType,
            equals(entry.value),
            reason:
                'referenceType "${entry.key}" should parse to ${entry.value}',
          );
        }
      });

      test('returns null for unknown reference type', () {
        final json = createJournalJson(referenceType: 'bogus_ref');
        final model = LedgerJournalModel.fromJson(json);

        expect(model.referenceType, isNull);
      });

      test('handles null DateTimes without crashing', () {
        final json = createJournalJson(
          createdAt: null,
          postedAt: null,
          reversedAt: null,
        );

        // Should not throw — _parseDateTime returns DateTime.now() for null
        final model = LedgerJournalModel.fromJson(json);

        expect(model.createdAt, isA<DateTime>());
        expect(model.postedAt, isNull);
        expect(model.reversedAt, isNull);
      });

      test('handles missing optional fields gracefully', () {
        // Minimal JSON with only required-ish fields
        final json = <String, dynamic>{
          'id': 'j_minimal',
          'entries': <Map<String, dynamic>>[],
        };

        final model = LedgerJournalModel.fromJson(json);

        expect(model.id, equals('j_minimal'));
        expect(model.idempotencyKey, equals(''));
        expect(model.type, equals(LedgerJournalType.earn));
        expect(model.status, equals(LedgerJournalStatus.pending));
        expect(model.description, equals(''));
        expect(model.entries, isEmpty);
        expect(model.totalDebits, equals(0));
        expect(model.totalCredits, equals(0));
        expect(model.referenceType, isNull);
        expect(model.referenceId, isNull);
        expect(model.initiatedBy, equals('system'));
        expect(model.approvedBy, isNull);
        expect(model.metadata, isEmpty);
      });
    });

    group('toEntity', () {
      test('converts all fields including nested entries to LedgerJournal', () {
        final json = createJournalJson(
          id: 'j_entity',
          idempotencyKey: 'key-entity',
          type: 'potWin',
          status: 'posted',
          description: 'Daily pot win',
          totalDebits: 10000,
          totalCredits: 10000,
          referenceType: 'potDraw',
          referenceId: 'pot_daily_001',
          initiatedBy: 'system',
          createdAt: '2024-07-01T12:00:00.000Z',
          postedAt: '2024-07-01T12:00:01.000Z',
          metadata: {'drawId': 'draw_42'},
          entries: [
            createEntryJson(
              id: 'e_credit',
              accountId: 'user:winner',
              entryType: 'credit',
              amount: 10000,
              balanceAfter: 20000,
              description: 'Pot win credit',
            ),
            createEntryJson(
              id: 'e_debit',
              accountId: 'system:pot',
              entryType: 'debit',
              amount: 10000,
              balanceAfter: 0,
              description: 'Pot win debit',
            ),
          ],
        );

        final model = LedgerJournalModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity, isA<LedgerJournal>());
        expect(entity.id, equals('j_entity'));
        expect(entity.idempotencyKey, equals('key-entity'));
        expect(entity.type, equals(LedgerJournalType.potWin));
        expect(entity.status, equals(LedgerJournalStatus.posted));
        expect(entity.description, equals('Daily pot win'));
        expect(entity.totalDebits, equals(10000));
        expect(entity.totalCredits, equals(10000));
        expect(entity.referenceType, equals(LedgerReferenceType.potDraw));
        expect(entity.referenceId, equals('pot_daily_001'));
        expect(entity.initiatedBy, equals('system'));
        expect(entity.metadata, equals({'drawId': 'draw_42'}));

        // Nested entries
        expect(entity.entries, hasLength(2));
        expect(entity.entries[0], isA<LedgerEntry>());
        expect(entity.entries[0].id, equals('e_credit'));
        expect(entity.entries[0].entryType, equals(LedgerEntryType.credit));
        expect(entity.entries[0].amount, equals(10000));
        expect(entity.entries[1].id, equals('e_debit'));
        expect(entity.entries[1].entryType, equals(LedgerEntryType.debit));

        // Entity helpers
        expect(entity.isBalanced, isTrue);
        expect(entity.isPosted, isTrue);
        expect(entity.isReversed, isFalse);
      });
    });

    group('roundtrip', () {
      test('fromJson then toEntity preserves data integrity', () {
        final json = createJournalJson(
          id: 'j_roundtrip',
          idempotencyKey: 'rt-key-001',
          type: 'cashoutInitiate',
          status: 'posted',
          description: 'Cashout to bank',
          totalDebits: 5000,
          totalCredits: 5000,
          referenceType: 'cashout',
          referenceId: 'co_001',
          initiatedBy: 'user123',
          approvedBy: 'admin_x',
          createdAt: '2024-08-10T09:00:00.000Z',
          postedAt: '2024-08-10T09:00:05.000Z',
          metadata: {'bankRef': 'BNK-999'},
          entries: [
            createEntryJson(
              id: 'rt_dr',
              accountId: 'user:user123',
              entryType: 'debit',
              amount: 5000,
              balanceAfter: 5000,
              description: 'Cashout debit',
            ),
            createEntryJson(
              id: 'rt_cr',
              accountId: 'system:cashout',
              entryType: 'credit',
              amount: 5000,
              balanceAfter: 5000,
              description: 'Cashout credit',
            ),
          ],
        );

        final model = LedgerJournalModel.fromJson(json);
        final entity = model.toEntity();

        // Verify all scalar fields survived the trip
        expect(entity.id, equals(json['id']));
        expect(entity.idempotencyKey, equals(json['idempotencyKey']));
        expect(entity.type, equals(LedgerJournalType.cashoutInitiate));
        expect(entity.status, equals(LedgerJournalStatus.posted));
        expect(entity.description, equals(json['description']));
        expect(entity.totalDebits, equals(json['totalDebits']));
        expect(entity.totalCredits, equals(json['totalCredits']));
        expect(entity.referenceType, equals(LedgerReferenceType.cashout));
        expect(entity.referenceId, equals(json['referenceId']));
        expect(entity.initiatedBy, equals(json['initiatedBy']));
        expect(entity.metadata, equals({'bankRef': 'BNK-999'}));

        // Verify nested entries survived
        expect(entity.entries, hasLength(2));
        expect(entity.entries[0].id, equals('rt_dr'));
        expect(entity.entries[0].entryType, equals(LedgerEntryType.debit));
        expect(entity.entries[0].amount, equals(5000));
        expect(entity.entries[1].id, equals('rt_cr'));
        expect(entity.entries[1].entryType, equals(LedgerEntryType.credit));
        expect(entity.entries[1].amount, equals(5000));

        // Verify DateTime fields parsed from ISO strings
        expect(entity.createdAt, equals(DateTime.parse('2024-08-10T09:00:00.000Z')));
        expect(entity.postedAt, equals(DateTime.parse('2024-08-10T09:00:05.000Z')));
      });
    });
  });
}
