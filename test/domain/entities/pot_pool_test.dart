import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/pot_pool.dart';
import 'package:imalichat/domain/enums/pot_type.dart';

void main() {
  group('PotPool', () {
    late PotPool activePot;
    late PotPool distributedPot;

    setUp(() {
      activePot = PotPool(
        id: 'pot123',
        type: PotType.daily,
        totalTokens: 50000,
        participantCount: 1000,
        periodStart: DateTime(2024, 1, 1),
        periodEnd: DateTime.now().add(const Duration(hours: 2)),
        isActive: true,
        isDistributed: false,
        createdAt: DateTime(2024, 1, 1),
      );

      distributedPot = PotPool(
        id: 'pot456',
        type: PotType.weekly,
        totalTokens: 250000,
        participantCount: 5000,
        periodStart: DateTime(2024, 1, 1),
        periodEnd: DateTime(2024, 1, 7),
        isActive: false,
        isDistributed: true,
        distributedAt: DateTime(2024, 1, 7),
        winners: const [
          PotWinner(
            oddienceUserId: 'user1',
            displayName: 'Winner 1',
            rank: 1,
            tokensWon: 125000,
            percentage: 50.0,
          ),
        ],
        createdAt: DateTime(2024, 1, 1),
      );
    });

    group('timeRemaining', () {
      test('returns positive duration when pot is still active', () {
        expect(activePot.timeRemaining.isNegative, false);
        expect(activePot.timeRemaining.inSeconds, greaterThan(0));
      });

      test('returns Duration.zero when period has ended', () {
        final endedPot = activePot.copyWith(
          periodEnd: DateTime(2020, 1, 1),
        );
        expect(endedPot.timeRemaining, Duration.zero);
      });
    });

    group('isClosingSoon', () {
      test('returns true when less than 1 hour remaining', () {
        final closingSoon = activePot.copyWith(
          periodEnd: DateTime.now().add(const Duration(minutes: 30)),
        );
        expect(closingSoon.isClosingSoon, true);
      });

      test('returns false when more than 1 hour remaining', () {
        expect(activePot.isClosingSoon, false);
      });

      test('returns false when already ended', () {
        final ended = activePot.copyWith(
          periodEnd: DateTime(2020, 1, 1),
        );
        expect(ended.isClosingSoon, false);
      });
    });

    group('formattedTotal', () {
      test('formats token total with commas', () {
        expect(activePot.formattedTotal, contains('50,000'));
        expect(activePot.formattedTotal, contains('tokens'));
      });

      test('formats large numbers correctly', () {
        final largePot = activePot.copyWith(totalTokens: 1000000);
        expect(largePot.formattedTotal, contains('1,000,000'));
      });
    });

    group('periodLabel', () {
      test('returns correct label for daily pot', () {
        expect(activePot.periodLabel, 'Daily Pot');
      });

      test('returns correct label for weekly pot', () {
        expect(distributedPot.periodLabel, 'Weekly Pot');
      });
    });
  });

  group('PotWinner', () {
    test('stores all values correctly', () {
      const winner = PotWinner(
        oddienceUserId: 'user123',
        displayName: 'Test User',
        username: 'testuser',
        rank: 1,
        tokensWon: 25000,
        percentage: 50.0,
      );

      expect(winner.oddienceUserId, 'user123');
      expect(winner.displayName, 'Test User');
      expect(winner.username, 'testuser');
      expect(winner.rank, 1);
      expect(winner.tokensWon, 25000);
      expect(winner.percentage, 50.0);
    });
  });

  group('PotType', () {
    test('isDaily returns correct value', () {
      expect(PotType.daily.isDaily, true);
      expect(PotType.weekly.isDaily, false);
    });

    test('isWeekly returns correct value', () {
      expect(PotType.weekly.isWeekly, true);
      expect(PotType.daily.isWeekly, false);
    });

    test('displayName returns correct values', () {
      expect(PotType.daily.displayName, 'Daily Pot');
      expect(PotType.weekly.displayName, 'Weekly Pot');
    });

    test('topWinners returns correct count', () {
      expect(PotType.daily.topWinners, 5);
      expect(PotType.weekly.topWinners, 10);
    });
  });
}
