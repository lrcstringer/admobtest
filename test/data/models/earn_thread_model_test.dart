import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/earn_thread_model.dart';
import 'package:imalichat/domain/entities/earn_thread.dart';
import 'package:imalichat/domain/entities/targeting_criteria.dart';

void main() {
  group('EarnThreadModel', () {
    Map<String, dynamic> createValidJson({
      Map<String, dynamic>? targeting,
      bool useTimestamps = false,
    }) {
      final now = DateTime.now();
      final createdAtValue =
          useTimestamps ? MockTimestamp.fromDate(now) : now.toIso8601String();
      final activeFromValue = useTimestamps
          ? MockTimestamp.fromDate(now.subtract(const Duration(days: 1)))
          : now.subtract(const Duration(days: 1)).toIso8601String();
      final activeToValue = useTimestamps
          ? MockTimestamp.fromDate(now.add(const Duration(days: 30)))
          : now.add(const Duration(days: 30)).toIso8601String();

      return {
        'id': 'thread_001',
        'clientId': 'client_001',
        'clientName': 'Test Client',
        'clientAvatarImage': 'https://example.com/avatar.png',
        'clientAvatarColor': '#FF5733',
        'title': 'Test Thread',
        'description': 'A test thread description',
        'isPinned': true,
        'isFeatured': true,
        'isActive': true,
        'activeFrom': activeFromValue,
        'activeTo': activeToValue,
        'tokenSourceSubAccountId': 'sub_001',
        'tokenDestAccountTypeId': 'dest_001',
        'availableOpportunities': 10,
        'completedOpportunities': 50,
        'completedUniqueUsers': 25,
        'createdAt': createdAtValue,
        'lastActivityAt': createdAtValue,
        if (targeting != null) 'targeting': targeting,
      };
    }

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createValidJson();
        final model = EarnThreadModel.fromJson(json);

        expect(model.id, equals('thread_001'));
        expect(model.clientId, equals('client_001'));
        expect(model.clientName, equals('Test Client'));
        expect(model.clientAvatarImage, equals('https://example.com/avatar.png'));
        expect(model.clientAvatarColor, equals('#FF5733'));
        expect(model.title, equals('Test Thread'));
        expect(model.description, equals('A test thread description'));
        expect(model.isPinned, isTrue);
        expect(model.isFeatured, isTrue);
        expect(model.isActive, isTrue);
        expect(model.tokenSourceSubAccountId, equals('sub_001'));
        expect(model.tokenDestAccountTypeId, equals('dest_001'));
        expect(model.availableOpportunities, equals(10));
        expect(model.completedOpportunities, equals(50));
        expect(model.completedUniqueUsers, equals(25));
      });

      test('handles legacy brandId fallback', () {
        final json = {
          'id': 'thread_001',
          'brandId': 'legacy_brand_001',
          'brandName': 'Legacy Brand',
          'title': 'Test',
          'isPinned': false,
          'isFeatured': false,
          'isActive': true,
          'availableOpportunities': 5,
          'completedOpportunities': 10,
          'createdAt': DateTime.now().toIso8601String(),
        };

        final model = EarnThreadModel.fromJson(json);

        expect(model.clientId, equals('legacy_brand_001'));
        expect(model.clientName, equals('Legacy Brand'));
      });

      test('prefers clientId over brandId', () {
        final json = {
          'id': 'thread_001',
          'clientId': 'client_001',
          'brandId': 'brand_001',
          'clientName': 'Client Name',
          'brandName': 'Brand Name',
          'title': 'Test',
          'isPinned': false,
          'isFeatured': false,
          'isActive': true,
          'availableOpportunities': 5,
          'completedOpportunities': 10,
          'createdAt': DateTime.now().toIso8601String(),
        };

        final model = EarnThreadModel.fromJson(json);

        expect(model.clientId, equals('client_001'));
        expect(model.clientName, equals('Client Name'));
      });

      test('handles legacy avatar field fallbacks', () {
        final json = {
          'id': 'thread_001',
          'clientId': 'client_001',
          'clientName': 'Test',
          'avatarImage': 'https://legacy.com/avatar.png',
          'avatarColor': '#123456',
          'title': 'Test',
          'isPinned': false,
          'isFeatured': false,
          'isActive': true,
          'availableOpportunities': 5,
          'completedOpportunities': 10,
          'createdAt': DateTime.now().toIso8601String(),
        };

        final model = EarnThreadModel.fromJson(json);

        expect(model.clientAvatarImage, equals('https://legacy.com/avatar.png'));
        expect(model.clientAvatarColor, equals('#123456'));
      });

      test('uses clientName/brandName as title fallback', () {
        final json = {
          'id': 'thread_001',
          'clientId': 'client_001',
          'clientName': 'Fallback Title',
          'isPinned': false,
          'isFeatured': false,
          'isActive': true,
          'availableOpportunities': 5,
          'completedOpportunities': 10,
          'createdAt': DateTime.now().toIso8601String(),
        };

        final model = EarnThreadModel.fromJson(json);

        expect(model.title, equals('Fallback Title'));
      });

      test('uses default values for missing optional fields', () {
        final json = {
          'id': 'thread_001',
          'title': 'Test',
          'createdAt': DateTime.now().toIso8601String(),
        };

        final model = EarnThreadModel.fromJson(json);

        expect(model.clientId, equals(''));
        expect(model.clientName, equals(''));
        expect(model.isPinned, isFalse);
        expect(model.isFeatured, isFalse);
        expect(model.isActive, isTrue);
        expect(model.availableOpportunities, equals(0));
        expect(model.completedOpportunities, equals(0));
        expect(model.completedUniqueUsers, equals(0));
      });

      test('parses ISO 8601 date strings', () {
        final json = createValidJson();
        final model = EarnThreadModel.fromJson(json);

        expect(model.createdAt, isA<DateTime>());
        expect(model.activeFrom, isA<DateTime>());
        expect(model.activeTo, isA<DateTime>());
        expect(model.lastActivityAt, isA<DateTime>());
      });

      test('handles null optional dates', () {
        final json = {
          'id': 'thread_001',
          'clientId': 'client_001',
          'clientName': 'Test',
          'title': 'Test',
          'isPinned': false,
          'isFeatured': false,
          'isActive': true,
          'availableOpportunities': 5,
          'completedOpportunities': 10,
          'createdAt': DateTime.now().toIso8601String(),
          'activeFrom': null,
          'activeTo': null,
          'lastActivityAt': null,
        };

        final model = EarnThreadModel.fromJson(json);

        expect(model.activeFrom, isNull);
        expect(model.activeTo, isNull);
        expect(model.lastActivityAt, isNull);
      });

      test('uses current date when createdAt is null', () {
        final beforeTest = DateTime.now();
        final json = {
          'id': 'thread_001',
          'clientId': 'client_001',
          'clientName': 'Test',
          'title': 'Test',
          'isPinned': false,
          'isFeatured': false,
          'isActive': true,
          'availableOpportunities': 5,
          'completedOpportunities': 10,
          'createdAt': null,
        };

        final model = EarnThreadModel.fromJson(json);
        final afterTest = DateTime.now();

        expect(model.createdAt.isAfter(beforeTest.subtract(const Duration(seconds: 1))), isTrue);
        expect(model.createdAt.isBefore(afterTest.add(const Duration(seconds: 1))), isTrue);
      });

      test('parses targeting map', () {
        final json = createValidJson(targeting: {
          'genders': ['male', 'female'],
          'ageMin': 18,
          'ageMax': 35,
          'provinces': ['gauteng', 'western_cape'],
        });

        final model = EarnThreadModel.fromJson(json);

        expect(model.targeting, isNotNull);
        expect(model.targeting!['genders'], equals(['male', 'female']));
        expect(model.targeting!['ageMin'], equals(18));
        expect(model.targeting!['provinces'], contains('gauteng'));
      });
    });

    group('toEntity', () {
      test('converts all fields to entity', () {
        final json = createValidJson();
        final model = EarnThreadModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.id, equals('thread_001'));
        expect(entity.clientId, equals('client_001'));
        expect(entity.clientName, equals('Test Client'));
        expect(entity.title, equals('Test Thread'));
        expect(entity.isPinned, isTrue);
        expect(entity.isFeatured, isTrue);
        expect(entity.isActive, isTrue);
        expect(entity.availableOpportunities, equals(10));
        expect(entity.completedOpportunities, equals(50));
        expect(entity.completedUniqueUsers, equals(25));
      });

      test('converts targeting criteria', () {
        final json = createValidJson(targeting: {
          'genders': ['male'],
          'ageMin': 21,
          'ageMax': 45,
        });
        final model = EarnThreadModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.targeting, isNotNull);
        expect(entity.targeting!.genders, contains('male'));
        expect(entity.targeting!.ageMin, equals(21));
        expect(entity.targeting!.ageMax, equals(45));
      });

      test('handles null targeting', () {
        final json = createValidJson();
        final model = EarnThreadModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.targeting, isNull);
      });

      test('preserves all date fields', () {
        final json = createValidJson();
        final model = EarnThreadModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.createdAt, equals(model.createdAt));
        expect(entity.activeFrom, equals(model.activeFrom));
        expect(entity.activeTo, equals(model.activeTo));
        expect(entity.lastActivityAt, equals(model.lastActivityAt));
      });
    });

    group('fromEntity', () {
      test('creates model from entity', () {
        final now = DateTime.now();
        final entity = EarnThread(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test Client',
          clientAvatarImage: 'https://example.com/img.png',
          clientAvatarColor: '#ABCDEF',
          title: 'Entity Thread',
          description: 'Description',
          isPinned: true,
          isFeatured: false,
          isActive: true,
          activeFrom: now.subtract(const Duration(days: 5)),
          activeTo: now.add(const Duration(days: 25)),
          tokenSourceSubAccountId: 'sub_123',
          tokenDestAccountTypeId: 'dest_456',
          availableOpportunities: 15,
          completedOpportunities: 75,
          completedUniqueUsers: 40,
          createdAt: now,
          lastActivityAt: now,
        );

        final model = EarnThreadModel.fromEntity(entity);

        expect(model.id, equals('thread_001'));
        expect(model.clientId, equals('client_001'));
        expect(model.clientName, equals('Test Client'));
        expect(model.title, equals('Entity Thread'));
        expect(model.isPinned, isTrue);
        expect(model.isFeatured, isFalse);
        expect(model.availableOpportunities, equals(15));
        expect(model.completedUniqueUsers, equals(40));
      });

      test('converts targeting to JSON map', () {
        final entity = EarnThread(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: DateTime.now(),
          targeting: TargetingCriteria(
            genders: ['female'],
            provinces: ['gauteng', 'kzn'],
            ageMin: 25,
          ),
        );

        final model = EarnThreadModel.fromEntity(entity);

        expect(model.targeting, isNotNull);
        expect(model.targeting!['genders'], contains('female'));
        expect(model.targeting!['provinces'], contains('gauteng'));
        expect(model.targeting!['ageMin'], equals(25));
      });

      test('handles null targeting', () {
        final entity = EarnThread(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: DateTime.now(),
        );

        final model = EarnThreadModel.fromEntity(entity);

        expect(model.targeting, isNull);
      });
    });

    group('toFirestoreJson', () {
      test('serializes all fields', () {
        final now = DateTime.now();
        final model = EarnThreadModel(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test Client',
          clientAvatarImage: 'https://example.com/avatar.png',
          clientAvatarColor: '#FF5733',
          title: 'Test Thread',
          description: 'Description',
          isPinned: true,
          isFeatured: true,
          isActive: true,
          activeFrom: now.subtract(const Duration(days: 1)),
          activeTo: now.add(const Duration(days: 30)),
          tokenSourceSubAccountId: 'sub_001',
          tokenDestAccountTypeId: 'dest_001',
          availableOpportunities: 10,
          completedOpportunities: 50,
          completedUniqueUsers: 25,
          createdAt: now,
          lastActivityAt: now,
          targeting: {'genders': ['male']},
        );

        final json = model.toFirestoreJson();

        expect(json['id'], equals('thread_001'));
        expect(json['clientId'], equals('client_001'));
        expect(json['clientName'], equals('Test Client'));
        expect(json['title'], equals('Test Thread'));
        expect(json['isPinned'], isTrue);
        expect(json['isFeatured'], isTrue);
        expect(json['availableOpportunities'], equals(10));
        expect(json['completedOpportunities'], equals(50));
        expect(json['completedUniqueUsers'], equals(25));
        expect(json['targeting'], isNotNull);
      });

      test('serializes null dates as null', () {
        final model = EarnThreadModel(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: DateTime.now(),
        );

        final json = model.toFirestoreJson();

        expect(json['activeFrom'], isNull);
        expect(json['activeTo'], isNull);
        expect(json['lastActivityAt'], isNull);
      });
    });

    group('equality', () {
      test('models with same values are equal', () {
        final now = DateTime.now();
        final model1 = EarnThreadModel(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: now,
        );
        final model2 = EarnThreadModel(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: now,
        );

        expect(model1, equals(model2));
      });

      test('models with different values are not equal', () {
        final now = DateTime.now();
        final model1 = EarnThreadModel(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: now,
        );
        final model2 = EarnThreadModel(
          id: 'thread_002',
          clientId: 'client_001',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: now,
        );

        expect(model1, isNot(equals(model2)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated values', () {
        final now = DateTime.now();
        final original = EarnThreadModel(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Original',
          title: 'Original Title',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 10,
          createdAt: now,
        );

        final updated = original.copyWith(
          clientName: 'Updated',
          isPinned: true,
          availableOpportunities: 15,
        );

        expect(updated.clientName, equals('Updated'));
        expect(updated.isPinned, isTrue);
        expect(updated.availableOpportunities, equals(15));
        expect(updated.id, equals(original.id));
        expect(updated.title, equals(original.title));
      });
    });

    group('roundtrip', () {
      test('entity -> model -> entity preserves data', () {
        final now = DateTime.now();
        final original = EarnThread(
          id: 'thread_001',
          clientId: 'client_001',
          clientName: 'Test Client',
          clientAvatarImage: 'https://example.com/img.png',
          clientAvatarColor: '#ABCDEF',
          title: 'Roundtrip Test',
          description: 'Description',
          isPinned: true,
          isFeatured: true,
          isActive: true,
          activeFrom: now.subtract(const Duration(days: 5)),
          activeTo: now.add(const Duration(days: 25)),
          availableOpportunities: 15,
          completedOpportunities: 75,
          completedUniqueUsers: 40,
          createdAt: now,
          targeting: TargetingCriteria(
            genders: ['male', 'female'],
            ageMin: 18,
            ageMax: 65,
          ),
        );

        final model = EarnThreadModel.fromEntity(original);
        final restored = model.toEntity();

        expect(restored.id, equals(original.id));
        expect(restored.clientId, equals(original.clientId));
        expect(restored.clientName, equals(original.clientName));
        expect(restored.title, equals(original.title));
        expect(restored.isPinned, equals(original.isPinned));
        expect(restored.availableOpportunities, equals(original.availableOpportunities));
        expect(restored.targeting?.genders, equals(original.targeting?.genders));
        expect(restored.targeting?.ageMin, equals(original.targeting?.ageMin));
      });
    });
  });
}

/// Mock Timestamp for testing (simulates Firestore Timestamp)
class MockTimestamp {
  final int seconds;
  final int nanoseconds;

  MockTimestamp(this.seconds, this.nanoseconds);

  factory MockTimestamp.fromDate(DateTime date) {
    final ms = date.millisecondsSinceEpoch;
    return MockTimestamp(ms ~/ 1000, (ms % 1000) * 1000000);
  }

  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(
      seconds * 1000 + (nanoseconds ~/ 1000000),
    );
  }
}
