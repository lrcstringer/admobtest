import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/cashout_model.dart';
import 'package:imalichat/domain/enums/cashout_status.dart';

void main() {
  group('CashoutModel.fromJson', () {
    Map<String, dynamic> createValidJson({
      String? walletId,
      bool includeWalletId = true,
    }) {
      return {
        'id': 'co_001',
        if (includeWalletId && walletId != null) 'walletId': walletId,
        'userId': 'user_001',
        'tokenAmount': 5000,
        'zarAmount': 50.0,
        'method': 'bankTransfer',
        'status': 'pending',
        'destinationDetails': '****1234',
        'createdAt': '2026-02-16T10:00:00.000Z',
      };
    }

    test('parses walletId when present', () {
      final json = createValidJson(walletId: 'user:user_001');
      final model = CashoutModel.fromJson(json);

      expect(model.walletId, equals('user:user_001'));
    });

    test('falls back to user:{userId} when walletId is null', () {
      final json = createValidJson()..remove('walletId');
      final model = CashoutModel.fromJson(json);

      expect(model.walletId, equals('user:user_001'));
    });

    test('falls back to user:{userId} when walletId is missing entirely', () {
      final json = createValidJson(includeWalletId: false);
      final model = CashoutModel.fromJson(json);

      expect(model.walletId, equals('user:user_001'));
    });

    test('parses all required fields correctly', () {
      final json = createValidJson(walletId: 'user:user_001');
      final model = CashoutModel.fromJson(json);

      expect(model.id, equals('co_001'));
      expect(model.userId, equals('user_001'));
      expect(model.tokenAmount, equals(5000));
      expect(model.zarAmount, equals(50.0));
      expect(model.method, equals('bankTransfer'));
      expect(model.status, equals('pending'));
      expect(model.destinationDetails, equals('****1234'));
    });

    test('parses bank details from nested bankDetails object', () {
      final json = createValidJson(walletId: 'user:user_001')
        ..['bankDetails'] = {
          'method': 'bankTransfer',
          'destinationDetails': 'FNB ****5678',
          'bankName': 'First National Bank',
          'accountNumber': '62012345678',
          'accountHolderName': 'John Doe',
        };

      final model = CashoutModel.fromJson(json);

      expect(model.bankName, equals('First National Bank'));
      expect(model.accountNumber, equals('62012345678'));
      expect(model.accountHolderName, equals('John Doe'));
      expect(model.destinationDetails, equals('FNB ****5678'));
    });

    test('prefers bankDetails over flat fields for backward compatibility', () {
      final json = createValidJson(walletId: 'user:user_001')
        ..['bankName'] = 'Old Bank'
        ..['bankDetails'] = {
          'bankName': 'New Bank',
        };

      final model = CashoutModel.fromJson(json);

      expect(model.bankName, equals('New Bank'));
    });

    test('falls back to flat fields when bankDetails is null', () {
      final json = createValidJson(walletId: 'user:user_001')
        ..['bankName'] = 'Flat Bank'
        ..['accountNumber'] = '11111111';

      final model = CashoutModel.fromJson(json);

      expect(model.bankName, equals('Flat Bank'));
      expect(model.accountNumber, equals('11111111'));
    });

    test('handles optional DateTime fields (null)', () {
      final json = createValidJson(walletId: 'user:user_001');
      final model = CashoutModel.fromJson(json);

      expect(model.processedAt, isNull);
      expect(model.completedAt, isNull);
      expect(model.failedAt, isNull);
    });

    test('parses DateTime fields from ISO strings', () {
      final json = createValidJson(walletId: 'user:user_001')
        ..['processedAt'] = '2026-02-16T11:00:00.000Z'
        ..['completedAt'] = '2026-02-16T12:00:00.000Z';

      final model = CashoutModel.fromJson(json);

      expect(model.processedAt, isNotNull);
      expect(model.completedAt, isNotNull);
    });

    test('toEntity correctly converts method and status strings to enums', () {
      final json = createValidJson(walletId: 'user:user_001');
      final model = CashoutModel.fromJson(json);
      final entity = model.toEntity();

      expect(entity.status, equals(CashoutStatus.pending));
    });

    test('toEntity handles all cashout statuses', () {
      for (final status in ['pending', 'onHold', 'processing', 'completed', 'failed', 'cancelled']) {
        final json = createValidJson(walletId: 'user:user_001')..['status'] = status;
        final model = CashoutModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.status.name, equals(status));
      }
    });

    test('defaults to bankTransfer method when method is missing', () {
      final json = createValidJson(walletId: 'user:user_001')..remove('method');
      final model = CashoutModel.fromJson(json);

      expect(model.method, equals('bankTransfer'));
    });

    test('defaults to empty string for destinationDetails when missing', () {
      final json = createValidJson(walletId: 'user:user_001')
        ..remove('destinationDetails');
      final model = CashoutModel.fromJson(json);

      expect(model.destinationDetails, equals(''));
    });
  });

  group('CashoutModel.toFirestoreJson', () {
    test('serializes timestamps correctly', () {
      final model = CashoutModel(
        id: 'co_001',
        walletId: 'user:user_001',
        userId: 'user_001',
        tokenAmount: 5000,
        zarAmount: 50.0,
        method: 'bankTransfer',
        status: 'pending',
        destinationDetails: '****1234',
        createdAt: DateTime.utc(2026, 2, 16, 10, 0),
      );

      final json = model.toFirestoreJson();

      expect(json['walletId'], equals('user:user_001'));
      expect(json['tokenAmount'], equals(5000));
      expect(json.containsKey('processedAt'), isFalse); // null fields excluded
    });

    test('excludes null optional fields', () {
      final model = CashoutModel(
        id: 'co_001',
        walletId: 'user:user_001',
        userId: 'user_001',
        tokenAmount: 5000,
        zarAmount: 50.0,
        method: 'bankTransfer',
        status: 'pending',
        destinationDetails: '****1234',
        createdAt: DateTime.utc(2026, 2, 16),
      );

      final json = model.toFirestoreJson();

      expect(json.containsKey('bankName'), isFalse);
      expect(json.containsKey('accountNumber'), isFalse);
      expect(json.containsKey('reference'), isFalse);
      expect(json.containsKey('failureReason'), isFalse);
    });
  });

  group('CashoutModel roundtrip', () {
    test('fromEntity → toEntity preserves all fields', () {
      final json = {
        'id': 'co_roundtrip',
        'walletId': 'user:u001',
        'userId': 'u001',
        'tokenAmount': 10000,
        'zarAmount': 100.0,
        'method': 'ewallet',
        'status': 'completed',
        'destinationDetails': '+27123456789',
        'mobileNumber': '+27123456789',
        'reference': 'REF001',
        'createdAt': '2026-01-01T00:00:00.000Z',
        'completedAt': '2026-01-01T01:00:00.000Z',
      };

      final model = CashoutModel.fromJson(json);
      final entity = model.toEntity();
      final backToModel = CashoutModel.fromEntity(entity);

      expect(backToModel.id, equals(model.id));
      expect(backToModel.walletId, equals(model.walletId));
      expect(backToModel.userId, equals(model.userId));
      expect(backToModel.tokenAmount, equals(model.tokenAmount));
      expect(backToModel.zarAmount, equals(model.zarAmount));
      expect(backToModel.method, equals(model.method));
      expect(backToModel.status, equals(model.status));
      expect(backToModel.mobileNumber, equals(model.mobileNumber));
      expect(backToModel.reference, equals(model.reference));
    });
  });
}
