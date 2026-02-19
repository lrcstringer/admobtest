import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/ledger_account_model.dart';
import 'package:imalichat/domain/entities/ledger_account.dart';

void main() {
  group('LedgerAccountModel', () {
    /// Helper to build a complete valid JSON map for LedgerAccountModel.fromJson
    Map<String, dynamic> createValidJson({
      String id = 'user:user123',
      String type = 'user',
      String name = 'Test User Account',
      String? ownerId = 'user123',
      int balance = 10000,
      int allocatedBalance = 2000,
      String currency = 'TOKEN',
      String status = 'active',
      Map<String, dynamic> metadata = const {'tier': 'gold'},
      String createdAt = '2024-01-01T00:00:00.000',
      String updatedAt = '2024-06-15T12:30:00.000',
      int version = 3,
    }) {
      return {
        'id': id,
        'type': type,
        'name': name,
        'ownerId': ownerId,
        'balance': balance,
        'allocatedBalance': allocatedBalance,
        'currency': currency,
        'status': status,
        'metadata': metadata,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'version': version,
      };
    }

    group('fromJson', () {
      test('parses all fields correctly from complete JSON', () {
        final json = createValidJson();
        final model = LedgerAccountModel.fromJson(json);

        expect(model.id, equals('user:user123'));
        expect(model.type, equals(LedgerAccountType.user));
        expect(model.name, equals('Test User Account'));
        expect(model.ownerId, equals('user123'));
        expect(model.balance, equals(10000));
        expect(model.allocatedBalance, equals(2000));
        expect(model.currency, equals('TOKEN'));
        expect(model.status, equals(LedgerAccountStatus.active));
        expect(model.metadata, equals({'tier': 'gold'}));
        expect(model.createdAt, equals(DateTime(2024, 1, 1)));
        expect(model.updatedAt, equals(DateTime(2024, 6, 15, 12, 30)));
        expect(model.version, equals(3));
      });

      test('parses each of 8 account types correctly', () {
        final expectedTypes = {
          'system': LedgerAccountType.system,
          'pot': LedgerAccountType.pot,
          'user': LedgerAccountType.user,
          'supplier': LedgerAccountType.supplier,
          'cbook': LedgerAccountType.cbook,
          'client_subacc': LedgerAccountType.clientSubacc,
          'client': LedgerAccountType.client,
          'group': LedgerAccountType.group,
        };

        for (final entry in expectedTypes.entries) {
          final json = createValidJson(type: entry.key);
          final model = LedgerAccountModel.fromJson(json);

          expect(
            model.type,
            equals(entry.value),
            reason: 'Type string "${entry.key}" should map to ${entry.value}',
          );
        }
      });

      test('defaults to user for unknown account type', () {
        final json = createValidJson(type: 'nonexistent_type');
        final model = LedgerAccountModel.fromJson(json);

        expect(model.type, equals(LedgerAccountType.user));
      });

      test('parses each of 3 status strings correctly', () {
        final expectedStatuses = {
          'active': LedgerAccountStatus.active,
          'frozen': LedgerAccountStatus.frozen,
          'closed': LedgerAccountStatus.closed,
        };

        for (final entry in expectedStatuses.entries) {
          final json = createValidJson(status: entry.key);
          final model = LedgerAccountModel.fromJson(json);

          expect(
            model.status,
            equals(entry.value),
            reason: 'Status string "${entry.key}" should map to ${entry.value}',
          );
        }
      });

      test('defaults to active for unknown status', () {
        final json = createValidJson(status: 'suspended');
        final model = LedgerAccountModel.fromJson(json);

        expect(model.status, equals(LedgerAccountStatus.active));
      });

      test('handles legacy totalBalance field for allocatedBalance', () {
        final json = createValidJson();
        json.remove('allocatedBalance');
        json['totalBalance'] = 7500;

        final model = LedgerAccountModel.fromJson(json);

        expect(model.allocatedBalance, equals(7500));
      });

      test('defaults balance to 0 when null', () {
        final json = createValidJson();
        json['balance'] = null;

        final model = LedgerAccountModel.fromJson(json);

        expect(model.balance, equals(0));
      });
    });

    group('toEntity', () {
      test('converts all fields to LedgerAccount entity correctly', () {
        final json = createValidJson();
        final model = LedgerAccountModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity, isA<LedgerAccount>());
        expect(entity.id, equals('user:user123'));
        expect(entity.type, equals(LedgerAccountType.user));
        expect(entity.name, equals('Test User Account'));
        expect(entity.ownerId, equals('user123'));
        expect(entity.balance, equals(10000));
        expect(entity.allocatedBalance, equals(2000));
        expect(entity.currency, equals('TOKEN'));
        expect(entity.status, equals(LedgerAccountStatus.active));
        expect(entity.metadata, equals({'tier': 'gold'}));
        expect(entity.createdAt, equals(DateTime(2024, 1, 1)));
        expect(entity.updatedAt, equals(DateTime(2024, 6, 15, 12, 30)));
        expect(entity.version, equals(3));
      });
    });

    group('fromEntity', () {
      test('creates model preserving all entity fields', () {
        final entity = LedgerAccount(
          id: 'system:earn',
          type: LedgerAccountType.system,
          name: 'Earn Pool',
          ownerId: null,
          balance: 500000,
          allocatedBalance: 100000,
          currency: 'TOKEN',
          status: LedgerAccountStatus.active,
          metadata: const {'description': 'Main earn pool'},
          createdAt: DateTime(2024, 3, 15),
          updatedAt: DateTime(2024, 6, 20),
          version: 5,
        );

        final model = LedgerAccountModel.fromEntity(entity);

        expect(model.id, equals(entity.id));
        expect(model.type, equals(entity.type));
        expect(model.name, equals(entity.name));
        expect(model.ownerId, isNull);
        expect(model.balance, equals(entity.balance));
        expect(model.allocatedBalance, equals(entity.allocatedBalance));
        expect(model.currency, equals(entity.currency));
        expect(model.status, equals(entity.status));
        expect(model.metadata, equals(entity.metadata));
        expect(model.createdAt, equals(entity.createdAt));
        expect(model.updatedAt, equals(entity.updatedAt));
        expect(model.version, equals(entity.version));
      });
    });

    group('roundtrip', () {
      test('fromJson -> toEntity -> fromEntity preserves data', () {
        final json = createValidJson(
          id: 'client_subacc:brand_cola',
          type: 'client_subacc',
          name: 'Cola Brand Budget',
          ownerId: 'client_cola',
          balance: 250000,
          allocatedBalance: 50000,
          currency: 'TOKEN',
          status: 'frozen',
          metadata: const {'campaign': 'summer2024'},
          createdAt: '2024-02-10T08:00:00.000',
          updatedAt: '2024-07-20T16:45:00.000',
          version: 7,
        );

        final originalModel = LedgerAccountModel.fromJson(json);
        final entity = originalModel.toEntity();
        final roundtripModel = LedgerAccountModel.fromEntity(entity);

        expect(roundtripModel.id, equals(originalModel.id));
        expect(roundtripModel.type, equals(originalModel.type));
        expect(roundtripModel.name, equals(originalModel.name));
        expect(roundtripModel.ownerId, equals(originalModel.ownerId));
        expect(roundtripModel.balance, equals(originalModel.balance));
        expect(roundtripModel.allocatedBalance, equals(originalModel.allocatedBalance));
        expect(roundtripModel.currency, equals(originalModel.currency));
        expect(roundtripModel.status, equals(originalModel.status));
        expect(roundtripModel.metadata, equals(originalModel.metadata));
        expect(roundtripModel.createdAt, equals(originalModel.createdAt));
        expect(roundtripModel.updatedAt, equals(originalModel.updatedAt));
        expect(roundtripModel.version, equals(originalModel.version));
      });
    });
  });
}
