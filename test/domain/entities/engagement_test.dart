import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/domain/enums/engagement_status.dart';

void main() {
  group('Engagement', () {
    late Engagement inProgressEngagement;
    late Engagement completedEngagement;
    late Engagement failedEngagement;

    setUp(() {
      inProgressEngagement = Engagement(
        id: 'eng123',
        oddienceUserId: 'user123',
        oddienceCampaignId: 'camp123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.watching,
        startedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 15,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
      );

      completedEngagement = Engagement(
        id: 'eng456',
        oddienceUserId: 'user123',
        oddienceCampaignId: 'camp123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.completed,
        startedAt: DateTime(2024, 1, 1),
        completedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 30,
        requiredDurationSeconds: 30,
        answers: [
          EngagementAnswer(
            questionId: 'q1',
            selectedOption: 'A',
            answeredAt: DateTime(2024, 1, 1),
            isCorrect: true,
          ),
        ],
        tokensEarned: 100,
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
      );

      failedEngagement = Engagement(
        id: 'eng789',
        oddienceUserId: 'user123',
        oddienceCampaignId: 'camp123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.failed,
        startedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 10,
        requiredDurationSeconds: 30,
        answers: const [],
        failureReason: 'Incomplete viewing',
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
      );
    });

    group('isComplete', () {
      test('returns true for completed status', () {
        expect(completedEngagement.isComplete, true);
      });

      test('returns false for watching status', () {
        expect(inProgressEngagement.isComplete, false);
      });

      test('returns false for failed status', () {
        expect(failedEngagement.isComplete, false);
      });
    });

    group('isInProgress', () {
      test('returns true for watching status', () {
        expect(inProgressEngagement.isInProgress, true);
      });

      test('returns true for started status', () {
        final started = inProgressEngagement.copyWith(status: EngagementStatus.started);
        expect(started.isInProgress, true);
      });

      test('returns true for surveying status', () {
        final surveying = inProgressEngagement.copyWith(status: EngagementStatus.surveying);
        expect(surveying.isInProgress, true);
      });

      test('returns false for completed status', () {
        expect(completedEngagement.isInProgress, false);
      });
    });

    group('isFailed', () {
      test('returns true for failed status', () {
        expect(failedEngagement.isFailed, true);
      });

      test('returns false for completed status', () {
        expect(completedEngagement.isFailed, false);
      });
    });

    group('watchProgress', () {
      test('calculates correct progress percentage', () {
        expect(inProgressEngagement.watchProgress, 0.5); // 15/30
      });

      test('returns 1.0 when watch duration meets requirement', () {
        expect(completedEngagement.watchProgress, 1.0);
      });

      test('clamps to 1.0 when over requirement', () {
        final overWatched = inProgressEngagement.copyWith(watchDurationSeconds: 60);
        expect(overWatched.watchProgress, 1.0);
      });

      test('returns 1.0 when required is 0', () {
        final noRequirement = inProgressEngagement.copyWith(requiredDurationSeconds: 0);
        expect(noRequirement.watchProgress, 1.0);
      });
    });

    group('watchRequirementMet', () {
      test('returns true when duration meets requirement', () {
        expect(completedEngagement.watchRequirementMet, true);
      });

      test('returns false when duration below requirement', () {
        expect(inProgressEngagement.watchRequirementMet, false);
      });

      test('returns true when duration exceeds requirement', () {
        final overWatched = inProgressEngagement.copyWith(watchDurationSeconds: 60);
        expect(overWatched.watchRequirementMet, true);
      });
    });
  });

  group('EngagementAnswer', () {
    test('stores all values correctly', () {
      final answer = EngagementAnswer(
        questionId: 'q1',
        selectedOption: 'B',
        answeredAt: DateTime(2024, 1, 1),
        isCorrect: true,
      );

      expect(answer.questionId, 'q1');
      expect(answer.selectedOption, 'B');
      expect(answer.isCorrect, true);
    });
  });

  group('EngagementStatus', () {
    test('isComplete returns true for completed and rewarded', () {
      expect(EngagementStatus.completed.isComplete, true);
      expect(EngagementStatus.rewarded.isComplete, true);
      expect(EngagementStatus.watching.isComplete, false);
    });

    test('isInProgress returns true for active states', () {
      expect(EngagementStatus.started.isInProgress, true);
      expect(EngagementStatus.watching.isInProgress, true);
      expect(EngagementStatus.surveying.isInProgress, true);
      expect(EngagementStatus.completed.isInProgress, false);
    });

    test('isFailed returns true for failure states', () {
      expect(EngagementStatus.failed.isFailed, true);
      expect(EngagementStatus.abandoned.isFailed, true);
      expect(EngagementStatus.rejected.isFailed, true);
      expect(EngagementStatus.completed.isFailed, false);
    });

    test('canSubmitSurvey returns true only for surveying', () {
      expect(EngagementStatus.surveying.canSubmitSurvey, true);
      expect(EngagementStatus.watching.canSubmitSurvey, false);
    });

    test('displayName returns human-readable strings', () {
      expect(EngagementStatus.started.displayName, 'Started');
      expect(EngagementStatus.watching.displayName, 'Watching');
      expect(EngagementStatus.surveying.displayName, 'Answering Survey');
      expect(EngagementStatus.completed.displayName, 'Completed');
    });
  });
}
