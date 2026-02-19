import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/user_profile.dart';

void main() {
  group('UserProfile', () {
    UserProfile createProfile({
      String displayName = 'TestUser',
      String? username = 'testuser',
      String? avatarUrl,
      String? avatarColor,
      String? gender = 'male',
      DateTime? dateOfBirth,
      String? province,
      String? city,
      String? firstName,
      String? lastName,
      List<String>? languages,
      List<String>? interests,
      bool rewardConsent = false,
    }) {
      return UserProfile(
        displayName: displayName,
        username: username,
        avatarUrl: avatarUrl,
        avatarColor: avatarColor,
        gender: gender,
        dateOfBirth: dateOfBirth ?? DateTime(2000, 6, 15),
        province: province,
        city: city,
        firstName: firstName,
        lastName: lastName,
        languages: languages,
        interests: interests,
        rewardConsent: rewardConsent,
      );
    }

    group('fullName', () {
      test('returns "firstName lastName" when both are set', () {
        final profile = createProfile(
          firstName: 'John',
          lastName: 'Doe',
          displayName: 'johndoe',
        );
        expect(profile.fullName, equals('John Doe'));
      });

      test('returns displayName when both firstName and lastName are null', () {
        final profile = createProfile(
          firstName: null,
          lastName: null,
          displayName: 'CoolUser',
        );
        expect(profile.fullName, equals('CoolUser'));
      });

      test('returns displayName when only firstName is set', () {
        final profile = createProfile(
          firstName: 'John',
          lastName: null,
          displayName: 'johndoe',
        );
        expect(profile.fullName, equals('johndoe'));
      });

      test('returns displayName when only lastName is set', () {
        final profile = createProfile(
          firstName: null,
          lastName: 'Doe',
          displayName: 'johndoe',
        );
        expect(profile.fullName, equals('johndoe'));
      });
    });

    group('age', () {
      test('calculates correct age when birthday has passed this year', () {
        final now = DateTime.now();
        // Birthday well in the past this year
        final dob = DateTime(now.year - 25, 1, 1);
        final profile = createProfile(dateOfBirth: dob);
        // By any date after Jan 1, age should be 25
        expect(profile.age, equals(25));
      });

      test('returns null when dateOfBirth is null', () {
        final profile = UserProfile(
          displayName: 'TestUser',
          username: 'test',
          gender: 'male',
          dateOfBirth: null,
        );
        expect(profile.age, isNull);
      });

      test('subtracts one year when birthday has not happened yet this year',
          () {
        final now = DateTime.now();
        // Set birthday to December 31 of the birth year so it hasn't happened yet
        // unless today is Dec 31
        final dob = DateTime(now.year - 20, 12, 31);
        final profile = createProfile(dateOfBirth: dob);

        if (now.month < 12 || (now.month == 12 && now.day < 31)) {
          expect(profile.age, equals(19));
        } else {
          expect(profile.age, equals(20));
        }
      });

      test('returns correct age when birthday is today', () {
        final now = DateTime.now();
        final dob = DateTime(now.year - 30, now.month, now.day);
        final profile = createProfile(dateOfBirth: dob);
        expect(profile.age, equals(30));
      });
    });

    group('isComplete', () {
      test('returns true when all required fields are present', () {
        final profile = createProfile(
          displayName: 'TestUser',
          username: 'testuser',
          gender: 'male',
          dateOfBirth: DateTime(2000, 6, 15),
        );
        expect(profile.isComplete, isTrue);
      });

      test('returns false when username is null', () {
        final profile = createProfile(
          displayName: 'TestUser',
          username: null,
          gender: 'male',
          dateOfBirth: DateTime(2000, 6, 15),
        );
        expect(profile.isComplete, isFalse);
      });

      test('returns false when gender is null', () {
        final profile = createProfile(
          displayName: 'TestUser',
          username: 'testuser',
          gender: null,
          dateOfBirth: DateTime(2000, 6, 15),
        );
        expect(profile.isComplete, isFalse);
      });

      test('returns false when dateOfBirth is null', () {
        final profile = UserProfile(
          displayName: 'TestUser',
          username: 'testuser',
          gender: 'male',
          dateOfBirth: null,
        );
        expect(profile.isComplete, isFalse);
      });

      test('returns false when displayName is empty', () {
        final profile = createProfile(
          displayName: '',
          username: 'testuser',
          gender: 'male',
          dateOfBirth: DateTime(2000, 6, 15),
        );
        expect(profile.isComplete, isFalse);
      });
    });

    group('construction', () {
      test('rewardConsent defaults to false', () {
        final profile = UserProfile(displayName: 'Test');
        expect(profile.rewardConsent, isFalse);
      });

      test('languages defaults to null', () {
        final profile = UserProfile(displayName: 'Test');
        expect(profile.languages, isNull);
      });

      test('interests defaults to null', () {
        final profile = UserProfile(displayName: 'Test');
        expect(profile.interests, isNull);
      });

      test('constructs with all fields populated', () {
        final dob = DateTime(1995, 3, 20);
        final profile = UserProfile(
          displayName: 'FullUser',
          username: 'fulluser',
          avatarUrl: 'https://example.com/avatar.png',
          avatarColor: '#FF5733',
          gender: 'female',
          dateOfBirth: dob,
          province: 'Gauteng',
          city: 'Johannesburg',
          firstName: 'Jane',
          lastName: 'Smith',
          languages: ['en', 'zu'],
          interests: ['sports', 'tech'],
          rewardConsent: true,
        );

        expect(profile.displayName, equals('FullUser'));
        expect(profile.username, equals('fulluser'));
        expect(profile.avatarUrl, equals('https://example.com/avatar.png'));
        expect(profile.avatarColor, equals('#FF5733'));
        expect(profile.gender, equals('female'));
        expect(profile.dateOfBirth, equals(dob));
        expect(profile.province, equals('Gauteng'));
        expect(profile.city, equals('Johannesburg'));
        expect(profile.firstName, equals('Jane'));
        expect(profile.lastName, equals('Smith'));
        expect(profile.languages, equals(['en', 'zu']));
        expect(profile.interests, equals(['sports', 'tech']));
        expect(profile.rewardConsent, isTrue);
      });

      test('copyWith preserves all fields when no overrides given', () {
        final dob = DateTime(1990, 7, 10);
        final original = UserProfile(
          displayName: 'Original',
          username: 'orig',
          avatarUrl: 'https://img.test/a.png',
          avatarColor: '#000000',
          gender: 'male',
          dateOfBirth: dob,
          province: 'Western Cape',
          city: 'Cape Town',
          firstName: 'Bob',
          lastName: 'Jones',
          languages: ['en'],
          interests: ['music'],
          rewardConsent: true,
        );

        final copy = original.copyWith();

        expect(copy.displayName, equals(original.displayName));
        expect(copy.username, equals(original.username));
        expect(copy.avatarUrl, equals(original.avatarUrl));
        expect(copy.avatarColor, equals(original.avatarColor));
        expect(copy.gender, equals(original.gender));
        expect(copy.dateOfBirth, equals(original.dateOfBirth));
        expect(copy.province, equals(original.province));
        expect(copy.city, equals(original.city));
        expect(copy.firstName, equals(original.firstName));
        expect(copy.lastName, equals(original.lastName));
        expect(copy.languages, equals(original.languages));
        expect(copy.interests, equals(original.interests));
        expect(copy.rewardConsent, equals(original.rewardConsent));
      });

      test('copyWith overrides specific fields', () {
        final original = createProfile(
          displayName: 'Original',
          username: 'orig',
          rewardConsent: false,
        );

        final updated = original.copyWith(
          displayName: 'Updated',
          rewardConsent: true,
        );

        expect(updated.displayName, equals('Updated'));
        expect(updated.rewardConsent, isTrue);
        expect(updated.username, equals(original.username));
        expect(updated.gender, equals(original.gender));
      });
    });

    group('fromJson', () {
      test('round-trips with minimal fields', () {
        final profile = UserProfile(displayName: 'JsonTest');
        final json = profile.toJson();
        final restored = UserProfile.fromJson(json);

        expect(restored.displayName, equals('JsonTest'));
        expect(restored.rewardConsent, isFalse);
        expect(restored.username, isNull);
      });

      test('round-trips with all fields populated', () {
        final profile = UserProfile(
          displayName: 'FullJson',
          username: 'fulljson',
          avatarUrl: 'https://img.test/b.png',
          avatarColor: '#AABBCC',
          gender: 'female',
          dateOfBirth: DateTime(1998, 11, 25),
          province: 'KwaZulu-Natal',
          city: 'Durban',
          firstName: 'Alice',
          lastName: 'Nkosi',
          languages: ['en', 'zu', 'xh'],
          interests: ['finance', 'education'],
          rewardConsent: true,
        );

        final json = profile.toJson();
        final restored = UserProfile.fromJson(json);

        expect(restored.displayName, equals('FullJson'));
        expect(restored.username, equals('fulljson'));
        expect(restored.gender, equals('female'));
        expect(restored.firstName, equals('Alice'));
        expect(restored.lastName, equals('Nkosi'));
        expect(restored.languages, equals(['en', 'zu', 'xh']));
        expect(restored.interests, equals(['finance', 'education']));
        expect(restored.rewardConsent, isTrue);
        expect(restored.province, equals('KwaZulu-Natal'));
        expect(restored.city, equals('Durban'));
      });

      test('deserializes from a manual Map', () {
        final json = <String, dynamic>{
          'displayName': 'MapUser',
          'username': 'mapuser',
          'gender': 'male',
          'rewardConsent': true,
          'languages': ['en'],
          'interests': ['sports'],
        };

        final profile = UserProfile.fromJson(json);

        expect(profile.displayName, equals('MapUser'));
        expect(profile.username, equals('mapuser'));
        expect(profile.gender, equals('male'));
        expect(profile.rewardConsent, isTrue);
        expect(profile.languages, equals(['en']));
        expect(profile.interests, equals(['sports']));
        expect(profile.dateOfBirth, isNull);
        expect(profile.avatarUrl, isNull);
      });
    });
  });
}
