import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/user_engagement_stats.dart';

void main() {
  UserEngagementStats createStats({int currentStreak = 0}) {
    return UserEngagementStats(
      userId: 'user123',
      currentStreak: currentStreak,
      longestStreak: currentStreak,
      totalEngagementsCompleted: 10,
      totalTokensEarned: 1000,
      updatedAt: DateTime(2024, 1, 1),
    );
  }

  group('streakMultiplier', () {
    test('returns 1.0 for streak of 0', () {
      expect(createStats(currentStreak: 0).streakMultiplier, 1.0);
    });

    test('returns 1.0 for streak of 1', () {
      expect(createStats(currentStreak: 1).streakMultiplier, 1.0);
    });

    test('returns 1.0 for streak of 2', () {
      expect(createStats(currentStreak: 2).streakMultiplier, 1.0);
    });

    test('returns 1.2 for streak of 3', () {
      expect(createStats(currentStreak: 3).streakMultiplier, 1.2);
    });

    test('returns 1.2 for streak of 6', () {
      expect(createStats(currentStreak: 6).streakMultiplier, 1.2);
    });

    test('returns 1.35 for streak of 7', () {
      expect(createStats(currentStreak: 7).streakMultiplier, 1.35);
    });

    test('returns 1.35 for streak of 9', () {
      expect(createStats(currentStreak: 9).streakMultiplier, 1.35);
    });

    test('returns 1.5 for streak of 10', () {
      expect(createStats(currentStreak: 10).streakMultiplier, 1.5);
    });

    test('returns 1.5 for streak of 100', () {
      expect(createStats(currentStreak: 100).streakMultiplier, 1.5);
    });
  });

  group('hasStreak', () {
    test('returns false for streak of 0', () {
      expect(createStats(currentStreak: 0).hasStreak, isFalse);
    });

    test('returns true for streak of 1', () {
      expect(createStats(currentStreak: 1).hasStreak, isTrue);
    });
  });

  group('streakTierName', () {
    test('returns "No streak" for streak of 0', () {
      expect(createStats(currentStreak: 0).streakTierName, 'No streak');
    });

    test('returns "Starter" for streak of 1', () {
      expect(createStats(currentStreak: 1).streakTierName, 'Starter');
    });

    test('returns "Starter" for streak of 2', () {
      expect(createStats(currentStreak: 2).streakTierName, 'Starter');
    });

    test('returns "Growing" for streak of 3', () {
      expect(createStats(currentStreak: 3).streakTierName, 'Growing');
    });

    test('returns "Growing" for streak of 6', () {
      expect(createStats(currentStreak: 6).streakTierName, 'Growing');
    });

    test('returns "Strong" for streak of 7', () {
      expect(createStats(currentStreak: 7).streakTierName, 'Strong');
    });

    test('returns "Strong" for streak of 9', () {
      expect(createStats(currentStreak: 9).streakTierName, 'Strong');
    });

    test('returns "Master" for streak of 10', () {
      expect(createStats(currentStreak: 10).streakTierName, 'Master');
    });
  });

  group('multiplierDisplay', () {
    test('returns empty string for streak of 0', () {
      expect(createStats(currentStreak: 0).multiplierDisplay, '');
    });

    test('returns empty string for streak of 2', () {
      expect(createStats(currentStreak: 2).multiplierDisplay, '');
    });

    test('returns "+20%" for streak of 3', () {
      expect(createStats(currentStreak: 3).multiplierDisplay, '+20%');
    });

    test('returns "+20%" for streak of 6', () {
      expect(createStats(currentStreak: 6).multiplierDisplay, '+20%');
    });

    test('returns "+35%" for streak of 7', () {
      expect(createStats(currentStreak: 7).multiplierDisplay, '+35%');
    });

    test('returns "+35%" for streak of 9', () {
      expect(createStats(currentStreak: 9).multiplierDisplay, '+35%');
    });

    test('returns "+50%" for streak of 10', () {
      expect(createStats(currentStreak: 10).multiplierDisplay, '+50%');
    });

    test('returns "+50%" for streak of 100', () {
      expect(createStats(currentStreak: 100).multiplierDisplay, '+50%');
    });
  });

  group('empty factory', () {
    test('creates zeroed stats with correct userId', () {
      final stats = UserEngagementStats.empty('test-user');

      expect(stats.userId, 'test-user');
      expect(stats.currentStreak, 0);
      expect(stats.longestStreak, 0);
      expect(stats.totalEngagementsCompleted, 0);
      expect(stats.totalTokensEarned, 0);
      expect(stats.updatedAt, isNotNull);
      expect(stats.streakStartedAt, isNull);
      expect(stats.lastEarnedDate, isNull);
    });
  });
}
