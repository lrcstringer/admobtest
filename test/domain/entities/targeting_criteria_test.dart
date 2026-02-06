import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/targeting_criteria.dart';

void main() {
  group('TargetingCriteria', () {
    group('isEmpty', () {
      test('returns true when all fields are null', () {
        const criteria = TargetingCriteria();
        expect(criteria.isEmpty, isTrue);
      });

      test('returns true when lists are empty', () {
        const criteria = TargetingCriteria(
          genders: [],
          provinces: [],
          cities: [],
          languages: [],
          interests: [],
          devicePlatforms: [],
          engagementLevel: [],
        );
        expect(criteria.isEmpty, isTrue);
      });

      test('returns false when genders is populated', () {
        const criteria = TargetingCriteria(genders: ['male']);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when ageMin is set', () {
        const criteria = TargetingCriteria(ageMin: 18);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when ageMax is set', () {
        const criteria = TargetingCriteria(ageMax: 35);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when provinces is populated', () {
        const criteria = TargetingCriteria(provinces: ['gauteng']);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when cities is populated', () {
        const criteria = TargetingCriteria(cities: ['johannesburg']);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when languages is populated', () {
        const criteria = TargetingCriteria(languages: ['english', 'zulu']);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when interests is populated', () {
        const criteria = TargetingCriteria(interests: ['sports', 'music']);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when devicePlatforms is populated', () {
        const criteria = TargetingCriteria(devicePlatforms: ['android']);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when accountAgeMinDays is set', () {
        const criteria = TargetingCriteria(accountAgeMinDays: 7);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when accountAgeMaxDays is set', () {
        const criteria = TargetingCriteria(accountAgeMaxDays: 30);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when engagementLevel is populated', () {
        const criteria = TargetingCriteria(engagementLevel: ['active']);
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when previousBrandInteraction is set', () {
        const criteria = TargetingCriteria(previousBrandInteraction: 'include');
        expect(criteria.isEmpty, isFalse);
      });

      test('returns false when maxAudience is set', () {
        const criteria = TargetingCriteria(maxAudience: 1000);
        expect(criteria.isEmpty, isFalse);
      });
    });

    group('summary', () {
      test('returns "All users" when empty', () {
        const criteria = TargetingCriteria();
        expect(criteria.summary, equals('All users'));
      });

      test('shows gender count', () {
        const criteria = TargetingCriteria(genders: ['male', 'female']);
        expect(criteria.summary, contains('2 gender(s)'));
      });

      test('shows age range when both min and max set', () {
        const criteria = TargetingCriteria(ageMin: 18, ageMax: 35);
        expect(criteria.summary, contains('Age 18-35'));
      });

      test('shows age min+ when only min set', () {
        const criteria = TargetingCriteria(ageMin: 21);
        expect(criteria.summary, contains('Age 21+'));
      });

      test('shows age <max when only max set', () {
        const criteria = TargetingCriteria(ageMax: 25);
        expect(criteria.summary, contains('Age <25'));
      });

      test('shows province count', () {
        const criteria = TargetingCriteria(provinces: ['gauteng', 'western_cape', 'kwazulu_natal']);
        expect(criteria.summary, contains('3 province(s)'));
      });

      test('shows city count', () {
        const criteria = TargetingCriteria(cities: ['johannesburg', 'cape_town']);
        expect(criteria.summary, contains('2 city/cities'));
      });

      test('shows language count', () {
        const criteria = TargetingCriteria(languages: ['english']);
        expect(criteria.summary, contains('1 language(s)'));
      });

      test('shows interest count', () {
        const criteria = TargetingCriteria(interests: ['sports', 'music', 'gaming']);
        expect(criteria.summary, contains('3 interest(s)'));
      });

      test('shows device platforms joined', () {
        const criteria = TargetingCriteria(devicePlatforms: ['android', 'ios']);
        expect(criteria.summary, contains('android/ios'));
      });

      test('shows engagement levels joined', () {
        const criteria = TargetingCriteria(engagementLevel: ['new', 'active']);
        expect(criteria.summary, contains('new/active users'));
      });

      test('shows "Returning only" for include previousBrandInteraction', () {
        const criteria = TargetingCriteria(previousBrandInteraction: 'include');
        expect(criteria.summary, contains('Returning only'));
      });

      test('shows "New users only" for exclude previousBrandInteraction', () {
        const criteria = TargetingCriteria(previousBrandInteraction: 'exclude');
        expect(criteria.summary, contains('New users only'));
      });

      test('shows max audience', () {
        const criteria = TargetingCriteria(maxAudience: 5000);
        expect(criteria.summary, contains('Max 5000 users'));
      });

      test('combines multiple criteria with commas', () {
        const criteria = TargetingCriteria(
          genders: ['male'],
          ageMin: 18,
          ageMax: 35,
          provinces: ['gauteng'],
        );
        final summary = criteria.summary;
        expect(summary, contains('1 gender(s)'));
        expect(summary, contains('Age 18-35'));
        expect(summary, contains('1 province(s)'));
        expect(summary, contains(', '));
      });
    });

    group('equality', () {
      test('two empty criteria are equal', () {
        const criteria1 = TargetingCriteria();
        const criteria2 = TargetingCriteria();
        expect(criteria1, equals(criteria2));
      });

      test('criteria with same values are equal', () {
        const criteria1 = TargetingCriteria(
          genders: ['male'],
          ageMin: 18,
          ageMax: 35,
        );
        const criteria2 = TargetingCriteria(
          genders: ['male'],
          ageMin: 18,
          ageMax: 35,
        );
        expect(criteria1, equals(criteria2));
      });

      test('criteria with different values are not equal', () {
        const criteria1 = TargetingCriteria(ageMin: 18);
        const criteria2 = TargetingCriteria(ageMin: 21);
        expect(criteria1, isNot(equals(criteria2)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated values', () {
        const original = TargetingCriteria(
          genders: ['male'],
          ageMin: 18,
        );
        final updated = original.copyWith(ageMax: 35);

        expect(updated.genders, equals(['male']));
        expect(updated.ageMin, equals(18));
        expect(updated.ageMax, equals(35));
      });

      test('can clear values with explicit null', () {
        const original = TargetingCriteria(ageMin: 18);
        // Note: Freezed copyWith requires explicit null handling
        final updated = original.copyWith(ageMin: null);
        expect(updated.ageMin, isNull);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'genders': ['male', 'female'],
          'ageMin': 18,
          'ageMax': 35,
          'provinces': ['gauteng'],
          'cities': ['johannesburg'],
          'languages': ['english'],
          'interests': ['sports'],
          'devicePlatforms': ['android'],
          'accountAgeMinDays': 7,
          'accountAgeMaxDays': 365,
          'engagementLevel': ['active'],
          'previousBrandInteraction': 'include',
          'maxAudience': 1000,
        };

        final criteria = TargetingCriteria.fromJson(json);

        expect(criteria.genders, equals(['male', 'female']));
        expect(criteria.ageMin, equals(18));
        expect(criteria.ageMax, equals(35));
        expect(criteria.provinces, equals(['gauteng']));
        expect(criteria.cities, equals(['johannesburg']));
        expect(criteria.languages, equals(['english']));
        expect(criteria.interests, equals(['sports']));
        expect(criteria.devicePlatforms, equals(['android']));
        expect(criteria.accountAgeMinDays, equals(7));
        expect(criteria.accountAgeMaxDays, equals(365));
        expect(criteria.engagementLevel, equals(['active']));
        expect(criteria.previousBrandInteraction, equals('include'));
        expect(criteria.maxAudience, equals(1000));
      });

      test('handles empty JSON', () {
        final criteria = TargetingCriteria.fromJson({});
        expect(criteria.isEmpty, isTrue);
      });

      test('handles partial JSON', () {
        final json = {
          'genders': ['female'],
          'ageMin': 21,
        };

        final criteria = TargetingCriteria.fromJson(json);

        expect(criteria.genders, equals(['female']));
        expect(criteria.ageMin, equals(21));
        expect(criteria.ageMax, isNull);
        expect(criteria.provinces, isNull);
      });
    });

    group('toJson', () {
      test('serializes all fields', () {
        const criteria = TargetingCriteria(
          genders: ['male'],
          ageMin: 18,
          ageMax: 35,
          provinces: ['gauteng'],
          maxAudience: 500,
        );

        final json = criteria.toJson();

        expect(json['genders'], equals(['male']));
        expect(json['ageMin'], equals(18));
        expect(json['ageMax'], equals(35));
        expect(json['provinces'], equals(['gauteng']));
        expect(json['maxAudience'], equals(500));
      });

      test('roundtrip preserves data', () {
        const original = TargetingCriteria(
          genders: ['female'],
          ageMin: 25,
          ageMax: 45,
          languages: ['zulu', 'xhosa'],
          previousBrandInteraction: 'exclude',
        );

        final json = original.toJson();
        final restored = TargetingCriteria.fromJson(json);

        expect(restored, equals(original));
      });
    });
  });
}
