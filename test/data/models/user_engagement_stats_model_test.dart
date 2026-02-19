import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/user_engagement_stats_model.dart';
import 'package:imalichat/domain/entities/user_engagement_stats.dart';

void main() {
  /// Helper to create a complete valid JSON map for UserEngagementStatsModel.
  Map<String, dynamic> createValidJson({
    String userId = 'user123',
    int currentStreak = 5,
    int longestStreak = 10,
    String? streakStartedAt = '2026-01-10T00:00:00.000Z',
    String? lastEarnedDate = '2026-02-17',
    int totalEngagementsCompleted = 50,
    int totalTokensEarned = 5000,
    String updatedAt = '2026-02-18T12:00:00.000Z',
  }) {
    return {
      'userId': userId,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      if (streakStartedAt != null) 'streakStartedAt': streakStartedAt,
      'lastEarnedDate': lastEarnedDate,
      'totalEngagementsCompleted': totalEngagementsCompleted,
      'totalTokensEarned': totalTokensEarned,
      'updatedAt': updatedAt,
    };
  }

  group('UserEngagementStatsModel', () {
    group('fromJson', () {
      test('parses all fields correctly from complete JSON', () {
        final json = createValidJson();
        final model = UserEngagementStatsModel.fromJson(json);

        expect(model.userId, equals('user123'));
        expect(model.currentStreak, equals(5));
        expect(model.longestStreak, equals(10));
        expect(model.streakStartedAt, isNotNull);
        expect(model.streakStartedAt, equals(DateTime.utc(2026, 1, 10)));
        expect(model.lastEarnedDate, equals('2026-02-17'));
        expect(model.totalEngagementsCompleted, equals(50));
        expect(model.totalTokensEarned, equals(5000));
        expect(model.updatedAt, equals(DateTime.utc(2026, 2, 18, 12)));
      });

      test('handles nullable DateTime fields (streakStartedAt can be null)', () {
        final json = createValidJson(streakStartedAt: null);
        // Remove the key entirely to test null handling
        json.remove('streakStartedAt');
        final model = UserEngagementStatsModel.fromJson(json);

        expect(model.streakStartedAt, isNull);
        expect(model.lastEarnedDate, isNotNull);
        // Other fields still parsed correctly
        expect(model.userId, equals('user123'));
        expect(model.currentStreak, equals(5));
      });
    });

    group('toEntity', () {
      test('converts all fields to UserEngagementStats entity correctly', () {
        final json = createValidJson();
        final model = UserEngagementStatsModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity, isA<UserEngagementStats>());
        expect(entity.userId, equals(model.userId));
        expect(entity.currentStreak, equals(model.currentStreak));
        expect(entity.longestStreak, equals(model.longestStreak));
        expect(entity.streakStartedAt, equals(model.streakStartedAt));
        expect(entity.lastEarnedDate, equals(model.lastEarnedDate));
        expect(
          entity.totalEngagementsCompleted,
          equals(model.totalEngagementsCompleted),
        );
        expect(entity.totalTokensEarned, equals(model.totalTokensEarned));
        expect(entity.updatedAt, equals(model.updatedAt));
        // Verify computed properties work on the resulting entity
        expect(entity.hasStreak, isTrue);
        expect(entity.streakMultiplier, equals(1.2)); // streak 5 -> Growing tier
        expect(entity.streakTierName, equals('Growing'));
      });
    });

    group('fromEntity', () {
      test('creates model from entity preserving all fields', () {
        final entity = UserEngagementStats(
          userId: 'user_abc',
          currentStreak: 8,
          longestStreak: 14,
          streakStartedAt: DateTime.utc(2026, 2, 10),
          lastEarnedDate: '2026-02-18',
          totalEngagementsCompleted: 80,
          totalTokensEarned: 8000,
          updatedAt: DateTime.utc(2026, 2, 18, 15, 30),
        );

        final model = UserEngagementStatsModel.fromEntity(entity);

        expect(model.userId, equals('user_abc'));
        expect(model.currentStreak, equals(8));
        expect(model.longestStreak, equals(14));
        expect(model.streakStartedAt, equals(DateTime.utc(2026, 2, 10)));
        expect(model.lastEarnedDate, equals('2026-02-18'));
        expect(model.totalEngagementsCompleted, equals(80));
        expect(model.totalTokensEarned, equals(8000));
        expect(model.updatedAt, equals(DateTime.utc(2026, 2, 18, 15, 30)));
      });
    });

    group('roundtrip', () {
      test('entity -> fromEntity -> toEntity preserves data', () {
        final original = UserEngagementStats(
          userId: 'roundtrip_user',
          currentStreak: 12,
          longestStreak: 20,
          streakStartedAt: DateTime.utc(2026, 2, 6),
          lastEarnedDate: '2026-02-18',
          totalEngagementsCompleted: 120,
          totalTokensEarned: 12000,
          updatedAt: DateTime.utc(2026, 2, 18, 10, 0),
        );

        final model = UserEngagementStatsModel.fromEntity(original);
        final roundtripped = model.toEntity();

        expect(roundtripped.userId, equals(original.userId));
        expect(roundtripped.currentStreak, equals(original.currentStreak));
        expect(roundtripped.longestStreak, equals(original.longestStreak));
        expect(roundtripped.streakStartedAt, equals(original.streakStartedAt));
        expect(roundtripped.lastEarnedDate, equals(original.lastEarnedDate));
        expect(
          roundtripped.totalEngagementsCompleted,
          equals(original.totalEngagementsCompleted),
        );
        expect(
          roundtripped.totalTokensEarned,
          equals(original.totalTokensEarned),
        );
        expect(roundtripped.updatedAt, equals(original.updatedAt));
      });

      test('handles entity with null optional fields', () {
        final original = UserEngagementStats(
          userId: 'null_fields_user',
          currentStreak: 0,
          longestStreak: 3,
          // streakStartedAt is null
          // lastEarnedDate is null
          totalEngagementsCompleted: 5,
          totalTokensEarned: 500,
          updatedAt: DateTime.utc(2026, 1, 15),
        );

        final model = UserEngagementStatsModel.fromEntity(original);
        final roundtripped = model.toEntity();

        expect(roundtripped.userId, equals(original.userId));
        expect(roundtripped.currentStreak, equals(0));
        expect(roundtripped.longestStreak, equals(3));
        expect(roundtripped.streakStartedAt, isNull);
        expect(roundtripped.lastEarnedDate, isNull);
        expect(roundtripped.totalEngagementsCompleted, equals(5));
        expect(roundtripped.totalTokensEarned, equals(500));
        expect(roundtripped.updatedAt, equals(original.updatedAt));
      });
    });

    group('edge cases', () {
      test('handles zero values for all numeric fields', () {
        final json = createValidJson(
          currentStreak: 0,
          longestStreak: 0,
          streakStartedAt: null,
          lastEarnedDate: null,
          totalEngagementsCompleted: 0,
          totalTokensEarned: 0,
        );
        // Remove keys that should be null/absent
        json.remove('streakStartedAt');

        final model = UserEngagementStatsModel.fromJson(json);

        expect(model.currentStreak, equals(0));
        expect(model.longestStreak, equals(0));
        expect(model.streakStartedAt, isNull);
        expect(model.lastEarnedDate, isNull);
        expect(model.totalEngagementsCompleted, equals(0));
        expect(model.totalTokensEarned, equals(0));

        // Verify entity computed properties for zero-streak case
        final entity = model.toEntity();
        expect(entity.hasStreak, isFalse);
        expect(entity.streakMultiplier, equals(1.0));
        expect(entity.streakTierName, equals('No streak'));
        expect(entity.multiplierDisplay, equals(''));
      });
    });
  });
}
