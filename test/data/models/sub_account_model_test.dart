import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/sub_account_model.dart';
import 'package:imalichat/domain/entities/sub_account.dart';

import '../../helpers/test_helpers.dart';

void main() {
  // ---------- helpers ----------

  /// Builds a valid unrestricted sub-account JSON map.
  /// [accountTypeId] can be supplied to create a restricted variant.
  Map<String, dynamic> buildJson({String? accountTypeId}) {
    return {
      'id': 'sub_default',
      'userId': 'user123',
      if (accountTypeId != null) 'accountTypeId': accountTypeId,
      'name': 'My Savings',
      'balance': 3000,
      'lifetimeCredits': 5000,
      'lifetimeDebits': 2000,
      'isActive': true,
      'isDefault': true,
      'createdAt': '2024-01-01T00:00:00.000',
      'updatedAt': '2024-01-01T00:00:00.000',
    };
  }

  // ---------- fromJson ----------

  group('SubAccountModel', () {
    group('fromJson', () {
      test('parses all fields correctly (unrestricted, accountTypeId null)', () {
        final json = buildJson();
        final model = SubAccountModel.fromJson(json);

        expect(model.id, equals('sub_default'));
        expect(model.userId, equals('user123'));
        expect(model.accountTypeId, isNull);
        expect(model.name, equals('My Savings'));
        expect(model.balance, equals(3000));
        expect(model.lifetimeCredits, equals(5000));
        expect(model.lifetimeDebits, equals(2000));
        expect(model.isActive, isTrue);
        expect(model.isDefault, isTrue);
        expect(model.createdAt, equals(DateTime(2024, 1, 1)));
        expect(model.updatedAt, equals(DateTime(2024, 1, 1)));
      });

      test('parses restricted sub-account (accountTypeId present)', () {
        final json = buildJson(accountTypeId: 'brand_cola');
        final model = SubAccountModel.fromJson(json);

        expect(model.accountTypeId, equals('brand_cola'));
        expect(model.name, equals('My Savings'));
      });
    });

    // ---------- toEntity ----------

    group('toEntity', () {
      test('converts unrestricted model to SubAccount entity correctly', () {
        final model = SubAccountModel.fromJson(buildJson());
        final entity = model.toEntity();

        expect(entity, isA<SubAccount>());
        expect(entity.id, equals('sub_default'));
        expect(entity.userId, equals('user123'));
        expect(entity.accountTypeId, isNull);
        expect(entity.name, equals('My Savings'));
        expect(entity.balance, equals(3000));
        expect(entity.lifetimeCredits, equals(5000));
        expect(entity.lifetimeDebits, equals(2000));
        expect(entity.isActive, isTrue);
        expect(entity.isDefault, isTrue);
        expect(entity.createdAt, equals(DateTime(2024, 1, 1)));
        expect(entity.updatedAt, equals(DateTime(2024, 1, 1)));
        // entity-specific getters
        expect(entity.isRestricted, isFalse);
      });

      test('converts restricted model preserving accountTypeId', () {
        final model = SubAccountModel.fromJson(
          buildJson(accountTypeId: 'brand_cola'),
        );
        final entity = model.toEntity();

        expect(entity.accountTypeId, equals('brand_cola'));
        expect(entity.isRestricted, isTrue);
      });
    });

    // ---------- fromEntity ----------

    group('fromEntity', () {
      test('creates model from entity preserving all fields', () {
        final entity = TestData.brandSubAccount;
        final model = SubAccountModel.fromEntity(entity);

        expect(model.id, equals(entity.id));
        expect(model.userId, equals(entity.userId));
        expect(model.accountTypeId, equals(entity.accountTypeId));
        expect(model.name, equals(entity.name));
        expect(model.balance, equals(entity.balance));
        expect(model.lifetimeCredits, equals(entity.lifetimeCredits));
        expect(model.lifetimeDebits, equals(entity.lifetimeDebits));
        expect(model.isActive, equals(entity.isActive));
        expect(model.isDefault, equals(entity.isDefault));
        expect(model.createdAt, equals(entity.createdAt));
        expect(model.updatedAt, equals(entity.updatedAt));
      });
    });

    // ---------- roundtrip ----------

    group('roundtrip', () {
      test('entity -> fromEntity -> toEntity preserves data for unrestricted', () {
        final original = TestData.defaultSubAccount;
        final roundtripped = SubAccountModel.fromEntity(original).toEntity();

        expect(roundtripped.id, equals(original.id));
        expect(roundtripped.userId, equals(original.userId));
        expect(roundtripped.accountTypeId, isNull);
        expect(roundtripped.name, equals(original.name));
        expect(roundtripped.balance, equals(original.balance));
        expect(roundtripped.lifetimeCredits, equals(original.lifetimeCredits));
        expect(roundtripped.lifetimeDebits, equals(original.lifetimeDebits));
        expect(roundtripped.isActive, equals(original.isActive));
        expect(roundtripped.isDefault, equals(original.isDefault));
        expect(roundtripped.createdAt, equals(original.createdAt));
        expect(roundtripped.updatedAt, equals(original.updatedAt));
      });

      test('entity -> fromEntity -> toEntity preserves data for restricted (brand)', () {
        final original = TestData.brandSubAccount;
        final roundtripped = SubAccountModel.fromEntity(original).toEntity();

        expect(roundtripped.id, equals(original.id));
        expect(roundtripped.userId, equals(original.userId));
        expect(roundtripped.accountTypeId, equals('brand_cola'));
        expect(roundtripped.name, equals(original.name));
        expect(roundtripped.balance, equals(original.balance));
        expect(roundtripped.lifetimeCredits, equals(original.lifetimeCredits));
        expect(roundtripped.lifetimeDebits, equals(original.lifetimeDebits));
        expect(roundtripped.isActive, equals(original.isActive));
        expect(roundtripped.isDefault, equals(original.isDefault));
        expect(roundtripped.createdAt, equals(original.createdAt));
        expect(roundtripped.updatedAt, equals(original.updatedAt));
        expect(roundtripped.isRestricted, isTrue);
      });
    });

    // ---------- edge cases ----------

    group('edge cases', () {
      test('handles zero balance correctly', () {
        final json = buildJson()
          ..['balance'] = 0
          ..['lifetimeCredits'] = 0
          ..['lifetimeDebits'] = 0;

        final model = SubAccountModel.fromJson(json);

        expect(model.balance, equals(0));
        expect(model.lifetimeCredits, equals(0));
        expect(model.lifetimeDebits, equals(0));

        final entity = model.toEntity();
        expect(entity.balance, equals(0));
        expect(entity.tokenBalance.value, equals(0));
      });
    });
  });
}
