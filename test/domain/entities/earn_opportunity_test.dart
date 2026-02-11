import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/earn_opportunity.dart';

void main() {
  group('EarnOpportunity', () {
    EarnOpportunity createOpportunity({
      String id = 'opp_001',
      String threadId = 'thread_001',
      String title = 'Test Opportunity',
      EarningType earningType = EarningType.video,
      int tokenReward = 100,
      int streakPoints = 1,
      MediaType mediaType = MediaType.video,
      int durationSeconds = 30,
      bool isActive = true,
      DateTime? expiresAt,
      String? userEngagementStatus,
    }) {
      return EarnOpportunity(
        id: id,
        threadId: threadId,
        title: title,
        earningType: earningType,
        tokenReward: tokenReward,
        streakPoints: streakPoints,
        mediaType: mediaType,
        durationSeconds: durationSeconds,
        questions: const [],
        isActive: isActive,
        expiresAt: expiresAt,
        userEngagementStatus: userEngagementStatus,
      );
    }

    group('isExpired', () {
      test('returns false when expiresAt is null', () {
        final opp = createOpportunity(expiresAt: null);
        expect(opp.isExpired, isFalse);
      });

      test('returns false when expiresAt is in the future', () {
        final opp = createOpportunity(
          expiresAt: DateTime.now().add(const Duration(days: 1)),
        );
        expect(opp.isExpired, isFalse);
      });

      test('returns true when expiresAt is in the past', () {
        final opp = createOpportunity(
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        );
        expect(opp.isExpired, isTrue);
      });

      test('returns true when expiresAt is exactly now minus 1 second', () {
        final opp = createOpportunity(
          expiresAt: DateTime.now().subtract(const Duration(seconds: 1)),
        );
        expect(opp.isExpired, isTrue);
      });
    });

    group('isAvailable', () {
      test('returns true when isActive is true and not expired', () {
        final opp = createOpportunity(
          isActive: true,
          expiresAt: DateTime.now().add(const Duration(days: 1)),
        );
        expect(opp.isAvailable, isTrue);
      });

      test('returns false when isActive is false', () {
        final opp = createOpportunity(isActive: false);
        expect(opp.isAvailable, isFalse);
      });

      test('returns false when expired', () {
        final opp = createOpportunity(
          isActive: true,
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        );
        expect(opp.isAvailable, isFalse);
      });

      test('returns true when isActive and expiresAt is null', () {
        final opp = createOpportunity(isActive: true, expiresAt: null);
        expect(opp.isAvailable, isTrue);
      });
    });

    group('isCompletedByUser', () {
      test('returns true when userEngagementStatus is completed', () {
        final opp = createOpportunity(userEngagementStatus: 'completed');
        expect(opp.isCompletedByUser, isTrue);
      });

      test('returns false when userEngagementStatus is null', () {
        final opp = createOpportunity(userEngagementStatus: null);
        expect(opp.isCompletedByUser, isFalse);
      });

      test('returns false when userEngagementStatus is started', () {
        final opp = createOpportunity(userEngagementStatus: 'started');
        expect(opp.isCompletedByUser, isFalse);
      });

      test('returns false when userEngagementStatus is failed', () {
        final opp = createOpportunity(userEngagementStatus: 'failed');
        expect(opp.isCompletedByUser, isFalse);
      });
    });

    group('isInProgressByUser', () {
      test('returns true when userEngagementStatus is started', () {
        final opp = createOpportunity(userEngagementStatus: 'started');
        expect(opp.isInProgressByUser, isTrue);
      });

      test('returns true when userEngagementStatus is watching', () {
        final opp = createOpportunity(userEngagementStatus: 'watching');
        expect(opp.isInProgressByUser, isTrue);
      });

      test('returns true when userEngagementStatus is surveying', () {
        final opp = createOpportunity(userEngagementStatus: 'surveying');
        expect(opp.isInProgressByUser, isTrue);
      });

      test('returns false when userEngagementStatus is completed', () {
        final opp = createOpportunity(userEngagementStatus: 'completed');
        expect(opp.isInProgressByUser, isFalse);
      });

      test('returns false when userEngagementStatus is null', () {
        final opp = createOpportunity(userEngagementStatus: null);
        expect(opp.isInProgressByUser, isFalse);
      });

      test('returns false when userEngagementStatus is failed', () {
        final opp = createOpportunity(userEngagementStatus: 'failed');
        expect(opp.isInProgressByUser, isFalse);
      });

      test('returns false when userEngagementStatus is abandoned', () {
        final opp = createOpportunity(userEngagementStatus: 'abandoned');
        expect(opp.isInProgressByUser, isFalse);
      });
    });

    group('daysUntilExpiry', () {
      test('returns null when expiresAt is null', () {
        final opp = createOpportunity(expiresAt: null);
        expect(opp.daysUntilExpiry, isNull);
      });

      test('returns positive number when expiresAt is in the future', () {
        final opp = createOpportunity(
          expiresAt: DateTime.now().add(const Duration(days: 5)),
        );
        // Allow for small timing differences
        expect(opp.daysUntilExpiry, greaterThanOrEqualTo(4));
        expect(opp.daysUntilExpiry, lessThanOrEqualTo(5));
      });

      test('returns negative number when expiresAt is in the past', () {
        final opp = createOpportunity(
          expiresAt: DateTime.now().subtract(const Duration(days: 3)),
        );
        expect(opp.daysUntilExpiry, lessThanOrEqualTo(-2));
      });

      test('returns 0 for same day expiry', () {
        final opp = createOpportunity(
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );
        expect(opp.daysUntilExpiry, equals(0));
      });
    });

    group('formattedDuration', () {
      test('returns seconds only for less than 60 seconds', () {
        final opp = createOpportunity(durationSeconds: 30);
        expect(opp.formattedDuration, equals('30s'));
      });

      test('returns seconds only for exactly 59 seconds', () {
        final opp = createOpportunity(durationSeconds: 59);
        expect(opp.formattedDuration, equals('59s'));
      });

      test('returns minutes only for exact minute', () {
        final opp = createOpportunity(durationSeconds: 60);
        expect(opp.formattedDuration, equals('1m'));
      });

      test('returns minutes only for multiple exact minutes', () {
        final opp = createOpportunity(durationSeconds: 120);
        expect(opp.formattedDuration, equals('2m'));
      });

      test('returns minutes and seconds for mixed duration', () {
        final opp = createOpportunity(durationSeconds: 90);
        expect(opp.formattedDuration, equals('1m 30s'));
      });

      test('returns minutes and seconds for 2m 30s', () {
        final opp = createOpportunity(durationSeconds: 150);
        expect(opp.formattedDuration, equals('2m 30s'));
      });

      test('returns correct format for large durations', () {
        final opp = createOpportunity(durationSeconds: 3661);
        expect(opp.formattedDuration, equals('61m 1s'));
      });

      test('handles 0 seconds', () {
        final opp = createOpportunity(durationSeconds: 0);
        expect(opp.formattedDuration, equals('0s'));
      });
    });

    group('earningTypeLabel', () {
      test('returns Survey for survey type', () {
        final opp = createOpportunity(earningType: EarningType.survey);
        expect(opp.earningTypeLabel, equals('Survey'));
      });

      test('returns Video for video type', () {
        final opp = createOpportunity(earningType: EarningType.video);
        expect(opp.earningTypeLabel, equals('Video'));
      });

      test('returns Poll for poll type', () {
        final opp = createOpportunity(earningType: EarningType.poll);
        expect(opp.earningTypeLabel, equals('Poll'));
      });
    });

    group('default values', () {
      test('streakPoints defaults to 1', () {
        const opp = EarnOpportunity(
          id: 'opp',
          threadId: 'thread',
          title: 'Test',
          earningType: EarningType.video,
          tokenReward: 100,
          mediaType: MediaType.video,
          durationSeconds: 30,
          questions: [],
          isActive: true,
        );
        expect(opp.streakPoints, equals(1));
      });

      test('bonusReward defaults to false', () {
        const opp = EarnOpportunity(
          id: 'opp',
          threadId: 'thread',
          title: 'Test',
          earningType: EarningType.video,
          tokenReward: 100,
          mediaType: MediaType.video,
          durationSeconds: 30,
          questions: [],
          isActive: true,
        );
        expect(opp.bonusReward, isFalse);
      });

      test('bonusRewardMultiplier defaults to 1.0', () {
        const opp = EarnOpportunity(
          id: 'opp',
          threadId: 'thread',
          title: 'Test',
          earningType: EarningType.video,
          tokenReward: 100,
          mediaType: MediaType.video,
          durationSeconds: 30,
          questions: [],
          isActive: true,
        );
        expect(opp.bonusRewardMultiplier, equals(1.0));
      });
    });
  });

  group('SurveyQuestion', () {
    test('creates correctly with all fields', () {
      const question = SurveyQuestion(
        id: 'q1',
        text: 'What is 2+2?',
        questionType: QuestionType.singleSelect,
        options: ['3', '4', '5'],
        orderIndex: 0,
        isAttentionCheck: true,
        correctAnswer: '4',
      );

      expect(question.id, equals('q1'));
      expect(question.text, equals('What is 2+2?'));
      expect(question.options, equals(['3', '4', '5']));
      expect(question.orderIndex, equals(0));
      expect(question.isAttentionCheck, isTrue);
      expect(question.correctAnswer, equals('4'));
    });

    test('creates correctly with optional fields at defaults', () {
      const question = SurveyQuestion(
        id: 'q1',
        text: 'What color?',
        questionType: QuestionType.singleSelect,
        options: ['Red', 'Blue'],
        orderIndex: 1,
      );

      expect(question.isAttentionCheck, isFalse);
      expect(question.correctAnswer, isNull);
    });
  });
}
