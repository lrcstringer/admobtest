import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/engagement_model.dart';
import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/domain/enums/engagement_status.dart';
import 'package:imalichat/domain/value_objects/engagement_evidence.dart';

void main() {
  group('EngagementAnswerModel', () {
    group('fromJson', () {
      test('parses all fields from ISO string dates', () {
        final json = {
          'questionId': 'q1',
          'selectedOption': 'Option A',
          'answeredAt': '2024-01-15T10:30:00Z',
          'isCorrect': true,
        };

        final model = EngagementAnswerModel.fromJson(json);

        expect(model.questionId, equals('q1'));
        expect(model.selectedOption, equals('Option A'));
        expect(model.answeredAt.year, equals(2024));
        expect(model.answeredAt.month, equals(1));
        expect(model.isCorrect, isTrue);
      });

      test('handles null isCorrect', () {
        final json = {
          'questionId': 'q1',
          'selectedOption': 'Option B',
          'answeredAt': '2024-01-15T10:30:00Z',
        };

        final model = EngagementAnswerModel.fromJson(json);

        expect(model.isCorrect, isNull);
      });
    });

    group('toEntity', () {
      test('converts to EngagementAnswer entity', () {
        final now = DateTime.now();
        final model = EngagementAnswerModel(
          questionId: 'q1',
          selectedOption: 'Answer',
          answeredAt: now,
          isCorrect: false,
        );

        final entity = model.toEntity();

        expect(entity.questionId, equals('q1'));
        expect(entity.selectedOption, equals('Answer'));
        expect(entity.answeredAt, equals(now));
        expect(entity.isCorrect, isFalse);
      });
    });

    group('fromEntity', () {
      test('creates model from entity', () {
        final now = DateTime.now();
        final entity = EngagementAnswer(
          questionId: 'q2',
          selectedOption: 'Selected',
          answeredAt: now,
          isCorrect: true,
        );

        final model = EngagementAnswerModel.fromEntity(entity);

        expect(model.questionId, equals('q2'));
        expect(model.selectedOption, equals('Selected'));
        expect(model.isCorrect, isTrue);
      });
    });

    group('toFirestoreJson', () {
      test('serializes all fields', () {
        final now = DateTime.now();
        final model = EngagementAnswerModel(
          questionId: 'q1',
          selectedOption: 'Answer',
          answeredAt: now,
          isCorrect: true,
        );

        final json = model.toFirestoreJson();

        expect(json['questionId'], equals('q1'));
        expect(json['selectedOption'], equals('Answer'));
        expect(json['isCorrect'], isTrue);
        expect(json.containsKey('answeredAt'), isTrue);
      });

      test('omits null isCorrect', () {
        final model = EngagementAnswerModel(
          questionId: 'q1',
          selectedOption: 'Answer',
          answeredAt: DateTime.now(),
        );

        final json = model.toFirestoreJson();

        expect(json.containsKey('isCorrect'), isFalse);
      });
    });
  });

  group('EngagementEvidenceModel', () {
    Map<String, dynamic> createValidEvidenceJson() {
      return {
        'deviceFingerprint': 'device_123',
        'integrityToken': 'token_abc',
        'watchDurationMs': 30000,
        'videoSeeked': false,
        'screenVisible': true,
        'appInForeground': true,
        'surveyResponseTimesMs': [1500, 2000, 1800],
        'videoStartedAt': '2024-01-15T10:00:00Z',
        'surveySubmittedAt': '2024-01-15T10:01:00Z',
        'clientAttentionScore': 0.95,
      };
    }

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createValidEvidenceJson();

        final model = EngagementEvidenceModel.fromJson(json);

        expect(model.deviceFingerprint, equals('device_123'));
        expect(model.integrityToken, equals('token_abc'));
        expect(model.watchDurationMs, equals(30000));
        expect(model.videoSeeked, isFalse);
        expect(model.screenVisible, isTrue);
        expect(model.appInForeground, isTrue);
        expect(model.surveyResponseTimesMs, equals([1500, 2000, 1800]));
        expect(model.clientAttentionScore, equals(0.95));
      });

      test('handles null optional fields', () {
        final json = {
          'deviceFingerprint': 'device_123',
          'watchDurationMs': 30000,
          'videoSeeked': false,
          'screenVisible': true,
          'appInForeground': true,
          'surveyResponseTimesMs': [1500],
          'videoStartedAt': '2024-01-15T10:00:00Z',
          'surveySubmittedAt': '2024-01-15T10:01:00Z',
        };

        final model = EngagementEvidenceModel.fromJson(json);

        expect(model.integrityToken, isNull);
        expect(model.clientAttentionScore, isNull);
      });
    });

    group('toEntity', () {
      test('converts to EngagementEvidence entity', () {
        final json = createValidEvidenceJson();
        final model = EngagementEvidenceModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.deviceFingerprint, equals('device_123'));
        expect(entity.integrityToken, equals('token_abc'));
        expect(entity.watchDurationMs, equals(30000));
        expect(entity.videoSeeked, isFalse);
        expect(entity.screenVisible, isTrue);
        expect(entity.appInForeground, isTrue);
        expect(entity.surveyResponseTimesMs, equals([1500, 2000, 1800]));
        expect(entity.clientAttentionScore, equals(0.95));
      });
    });

    group('fromEntity', () {
      test('creates model from entity', () {
        final now = DateTime.now();
        final entity = EngagementEvidence(
          deviceFingerprint: 'fp_123',
          integrityToken: 'int_456',
          watchDurationMs: 45000,
          videoSeeked: true,
          screenVisible: false,
          appInForeground: true,
          surveyResponseTimesMs: [1000, 2000],
          videoStartedAt: now,
          surveySubmittedAt: now.add(const Duration(minutes: 1)),
          clientAttentionScore: 0.85,
        );

        final model = EngagementEvidenceModel.fromEntity(entity);

        expect(model.deviceFingerprint, equals('fp_123'));
        expect(model.videoSeeked, isTrue);
        expect(model.screenVisible, isFalse);
        expect(model.clientAttentionScore, equals(0.85));
      });
    });

    group('toFirestoreJson', () {
      test('serializes all fields', () {
        final now = DateTime.now();
        final model = EngagementEvidenceModel(
          deviceFingerprint: 'device_123',
          integrityToken: 'token_abc',
          watchDurationMs: 30000,
          videoSeeked: false,
          screenVisible: true,
          appInForeground: true,
          surveyResponseTimesMs: [1500, 2000],
          videoStartedAt: now,
          surveySubmittedAt: now.add(const Duration(minutes: 1)),
          clientAttentionScore: 0.95,
        );

        final json = model.toFirestoreJson();

        expect(json['deviceFingerprint'], equals('device_123'));
        expect(json['integrityToken'], equals('token_abc'));
        expect(json['watchDurationMs'], equals(30000));
        expect(json['videoSeeked'], isFalse);
        expect(json['screenVisible'], isTrue);
        expect(json['appInForeground'], isTrue);
        expect(json['surveyResponseTimesMs'], equals([1500, 2000]));
        expect(json['clientAttentionScore'], equals(0.95));
      });

      test('omits null optional fields', () {
        final now = DateTime.now();
        final model = EngagementEvidenceModel(
          deviceFingerprint: 'device_123',
          watchDurationMs: 30000,
          videoSeeked: false,
          screenVisible: true,
          appInForeground: true,
          surveyResponseTimesMs: [1500],
          videoStartedAt: now,
          surveySubmittedAt: now,
        );

        final json = model.toFirestoreJson();

        expect(json.containsKey('integrityToken'), isFalse);
        expect(json.containsKey('clientAttentionScore'), isFalse);
      });
    });
  });

  group('EngagementModel', () {
    Map<String, dynamic> createValidEngagementJson({
      String status = 'started',
      bool includeEvidence = false,
      bool includeAnswers = false,
    }) {
      final now = DateTime.now();
      return {
        'id': 'eng_001',
        'userId': 'user_001',
        'audienceCampaignId': 'campaign_001',
        'earnOpportunityId': 'opp_001',
        'status': status,
        'startedAt': now.toIso8601String(),
        'completedAt': status == 'completed' ? now.add(const Duration(minutes: 2)).toIso8601String() : null,
        'watchDurationSeconds': 30,
        'requiredDurationSeconds': 30,
        'answers': includeAnswers
            ? [
                {
                  'questionId': 'q1',
                  'selectedOption': 'A',
                  'answeredAt': now.add(const Duration(seconds: 45)).toIso8601String(),
                },
              ]
            : [],
        'evidence': includeEvidence
            ? {
                'deviceFingerprint': 'device_123',
                'watchDurationMs': 30000,
                'videoSeeked': false,
                'screenVisible': true,
                'appInForeground': true,
                'surveyResponseTimesMs': [1500],
                'videoStartedAt': now.toIso8601String(),
                'surveySubmittedAt': now.add(const Duration(minutes: 1)).toIso8601String(),
              }
            : null,
        'tokensEarned': status == 'completed' ? 100 : null,
        'failureReason': status == 'failed' ? 'Video not watched fully' : null,
        'attemptNumber': 1,
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
        'threadId': 'thread_001',
        'clientId': 'client_001',
        'streakDayAtCompletion': status == 'completed' ? 5 : null,
        'multiplierApplied': status == 'completed' ? 1.2 : null,
      };
    }

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createValidEngagementJson(status: 'completed', includeEvidence: true);

        final model = EngagementModel.fromJson(json);

        expect(model.id, equals('eng_001'));
        expect(model.userId, equals('user_001'));
        expect(model.audienceCampaignId, equals('campaign_001'));
        expect(model.earnOpportunityId, equals('opp_001'));
        expect(model.status, equals('completed'));
        expect(model.watchDurationSeconds, equals(30));
        expect(model.requiredDurationSeconds, equals(30));
        expect(model.attemptNumber, equals(1));
        expect(model.threadId, equals('thread_001'));
        expect(model.clientId, equals('client_001'));
        expect(model.tokensEarned, equals(100));
        expect(model.streakDayAtCompletion, equals(5));
        expect(model.multiplierApplied, equals(1.2));
      });

      test('parses answers list', () {
        final json = createValidEngagementJson(includeAnswers: true);

        final model = EngagementModel.fromJson(json);

        expect(model.answers.length, equals(1));
        expect(model.answers[0].questionId, equals('q1'));
        expect(model.answers[0].selectedOption, equals('A'));
      });

      test('parses evidence object', () {
        final json = createValidEngagementJson(includeEvidence: true);

        final model = EngagementModel.fromJson(json);

        expect(model.evidence, isNotNull);
        expect(model.evidence!.deviceFingerprint, equals('device_123'));
        expect(model.evidence!.watchDurationMs, equals(30000));
        expect(model.evidence!.videoSeeked, isFalse);
      });

      test('handles null optional fields', () {
        final json = {
          'id': 'eng_001',
          'userId': 'user_001',
          'audienceCampaignId': 'campaign_001',
          'earnOpportunityId': 'opp_001',
          'status': 'started',
          'startedAt': DateTime.now().toIso8601String(),
          'requiredDurationSeconds': 30,
          'createdAt': DateTime.now().toIso8601String(),
        };

        final model = EngagementModel.fromJson(json);

        expect(model.completedAt, isNull);
        expect(model.watchDurationSeconds, equals(0));
        expect(model.answers, isEmpty);
        expect(model.evidence, isNull);
        expect(model.tokensEarned, isNull);
        expect(model.failureReason, isNull);
        expect(model.attemptNumber, equals(1));
        expect(model.updatedAt, isNull);
        expect(model.threadId, isNull);
        expect(model.clientId, isNull);
        expect(model.streakDayAtCompletion, isNull);
        expect(model.multiplierApplied, isNull);
      });

      test('parses failureReason for failed status', () {
        final json = createValidEngagementJson(status: 'failed');

        final model = EngagementModel.fromJson(json);

        expect(model.status, equals('failed'));
        expect(model.failureReason, equals('Video not watched fully'));
      });
    });

    group('status parsing', () {
      test('parses all valid status values', () {
        final statuses = [
          'started',
          'watching',
          'surveying',
          'completed',
          'failed',
          'abandoned',
          'rewarded',
          'rejected',
        ];

        for (final status in statuses) {
          final json = createValidEngagementJson(status: status);
          final model = EngagementModel.fromJson(json);
          final entity = model.toEntity();

          expect(entity.status.name, equals(status));
        }
      });

      test('defaults to started for unknown status', () {
        final json = createValidEngagementJson();
        json['status'] = 'unknown_status';

        final model = EngagementModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.status, equals(EngagementStatus.started));
      });
    });

    group('toEntity', () {
      test('converts all fields to entity', () {
        final json = createValidEngagementJson(
          status: 'completed',
          includeEvidence: true,
          includeAnswers: true,
        );
        final model = EngagementModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.id, equals('eng_001'));
        expect(entity.userId, equals('user_001'));
        expect(entity.audienceCampaignId, equals('campaign_001'));
        expect(entity.earnOpportunityId, equals('opp_001'));
        expect(entity.status, equals(EngagementStatus.completed));
        expect(entity.watchDurationSeconds, equals(30));
        expect(entity.answers.length, equals(1));
        expect(entity.evidence, isNotNull);
        expect(entity.tokensEarned, equals(100));
        expect(entity.threadId, equals('thread_001'));
        expect(entity.clientId, equals('client_001'));
        expect(entity.streakDayAtCompletion, equals(5));
        expect(entity.multiplierApplied, equals(1.2));
      });

      test('converts answers to entities', () {
        final json = createValidEngagementJson(includeAnswers: true);
        final model = EngagementModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.answers.length, equals(1));
        expect(entity.answers[0].questionId, equals('q1'));
      });

      test('converts evidence to entity', () {
        final json = createValidEngagementJson(includeEvidence: true);
        final model = EngagementModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.evidence, isNotNull);
        expect(entity.evidence!.deviceFingerprint, equals('device_123'));
      });

      test('handles null evidence', () {
        final json = createValidEngagementJson(includeEvidence: false);
        final model = EngagementModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.evidence, isNull);
      });
    });

    group('fromEntity', () {
      test('creates model from entity', () {
        final now = DateTime.now();
        final entity = Engagement(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: EngagementStatus.watching,
          startedAt: now,
          watchDurationSeconds: 15,
          requiredDurationSeconds: 30,
          answers: [],
          attemptNumber: 2,
          createdAt: now,
          threadId: 'thread_001',
          clientId: 'client_001',
        );

        final model = EngagementModel.fromEntity(entity);

        expect(model.id, equals('eng_001'));
        expect(model.status, equals('watching'));
        expect(model.watchDurationSeconds, equals(15));
        expect(model.attemptNumber, equals(2));
        expect(model.threadId, equals('thread_001'));
      });

      test('converts answers from entities', () {
        final now = DateTime.now();
        final entity = Engagement(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: EngagementStatus.surveying,
          startedAt: now,
          watchDurationSeconds: 30,
          requiredDurationSeconds: 30,
          answers: [
            EngagementAnswer(
              questionId: 'q1',
              selectedOption: 'Option A',
              answeredAt: now,
              isCorrect: true,
            ),
            EngagementAnswer(
              questionId: 'q2',
              selectedOption: 'Option B',
              answeredAt: now,
            ),
          ],
          attemptNumber: 1,
          createdAt: now,
        );

        final model = EngagementModel.fromEntity(entity);

        expect(model.answers.length, equals(2));
        expect(model.answers[0].questionId, equals('q1'));
        expect(model.answers[0].isCorrect, isTrue);
        expect(model.answers[1].isCorrect, isNull);
      });

      test('converts evidence from entity', () {
        final now = DateTime.now();
        final entity = Engagement(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: EngagementStatus.completed,
          startedAt: now,
          completedAt: now.add(const Duration(minutes: 2)),
          watchDurationSeconds: 30,
          requiredDurationSeconds: 30,
          answers: [],
          evidence: EngagementEvidence(
            deviceFingerprint: 'device_abc',
            watchDurationMs: 30000,
            videoSeeked: false,
            screenVisible: true,
            appInForeground: true,
            surveyResponseTimesMs: [1500, 2000],
            videoStartedAt: now,
            surveySubmittedAt: now.add(const Duration(minutes: 1)),
          ),
          tokensEarned: 100,
          attemptNumber: 1,
          createdAt: now,
          streakDayAtCompletion: 7,
          multiplierApplied: 1.35,
        );

        final model = EngagementModel.fromEntity(entity);

        expect(model.evidence, isNotNull);
        expect(model.evidence!.deviceFingerprint, equals('device_abc'));
        expect(model.evidence!.watchDurationMs, equals(30000));
        expect(model.tokensEarned, equals(100));
        expect(model.streakDayAtCompletion, equals(7));
        expect(model.multiplierApplied, equals(1.35));
      });

      test('handles null evidence', () {
        final now = DateTime.now();
        final entity = Engagement(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: EngagementStatus.started,
          startedAt: now,
          watchDurationSeconds: 0,
          requiredDurationSeconds: 30,
          answers: [],
          attemptNumber: 1,
          createdAt: now,
        );

        final model = EngagementModel.fromEntity(entity);

        expect(model.evidence, isNull);
      });
    });

    group('toFirestoreJson', () {
      test('serializes all fields', () {
        final now = DateTime.now();
        final model = EngagementModel(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: 'completed',
          startedAt: now,
          completedAt: now.add(const Duration(minutes: 2)),
          watchDurationSeconds: 30,
          requiredDurationSeconds: 30,
          answers: [],
          tokensEarned: 100,
          attemptNumber: 1,
          createdAt: now,
          updatedAt: now,
          threadId: 'thread_001',
          clientId: 'client_001',
          streakDayAtCompletion: 5,
          multiplierApplied: 1.2,
        );

        final json = model.toFirestoreJson();

        expect(json['userId'], equals('user_001'));
        expect(json['audienceCampaignId'], equals('campaign_001'));
        expect(json['earnOpportunityId'], equals('opp_001'));
        expect(json['status'], equals('completed'));
        expect(json['watchDurationSeconds'], equals(30));
        expect(json['tokensEarned'], equals(100));
        expect(json['attemptNumber'], equals(1));
        expect(json['threadId'], equals('thread_001'));
        expect(json['clientId'], equals('client_001'));
        expect(json['streakDayAtCompletion'], equals(5));
        expect(json['multiplierApplied'], equals(1.2));
      });

      test('serializes answers list', () {
        final now = DateTime.now();
        final model = EngagementModel(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: 'surveying',
          startedAt: now,
          watchDurationSeconds: 30,
          requiredDurationSeconds: 30,
          answers: [
            EngagementAnswerModel(
              questionId: 'q1',
              selectedOption: 'A',
              answeredAt: now,
            ),
          ],
          attemptNumber: 1,
          createdAt: now,
        );

        final json = model.toFirestoreJson();
        final answers = json['answers'] as List;

        expect(answers.length, equals(1));
        expect((answers[0] as Map)['questionId'], equals('q1'));
      });

      test('serializes evidence object', () {
        final now = DateTime.now();
        final model = EngagementModel(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: 'completed',
          startedAt: now,
          watchDurationSeconds: 30,
          requiredDurationSeconds: 30,
          answers: [],
          evidence: EngagementEvidenceModel(
            deviceFingerprint: 'device_123',
            watchDurationMs: 30000,
            videoSeeked: false,
            screenVisible: true,
            appInForeground: true,
            surveyResponseTimesMs: [1500],
            videoStartedAt: now,
            surveySubmittedAt: now,
          ),
          attemptNumber: 1,
          createdAt: now,
        );

        final json = model.toFirestoreJson();

        expect(json.containsKey('evidence'), isTrue);
        expect((json['evidence'] as Map)['deviceFingerprint'], equals('device_123'));
      });

      test('omits null optional fields', () {
        final now = DateTime.now();
        final model = EngagementModel(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: 'started',
          startedAt: now,
          watchDurationSeconds: 0,
          requiredDurationSeconds: 30,
          answers: [],
          attemptNumber: 1,
          createdAt: now,
        );

        final json = model.toFirestoreJson();

        expect(json.containsKey('completedAt'), isFalse);
        expect(json.containsKey('evidence'), isFalse);
        expect(json.containsKey('tokensEarned'), isFalse);
        expect(json.containsKey('failureReason'), isFalse);
        expect(json.containsKey('updatedAt'), isFalse);
        expect(json.containsKey('threadId'), isFalse);
        expect(json.containsKey('clientId'), isFalse);
        expect(json.containsKey('streakDayAtCompletion'), isFalse);
        expect(json.containsKey('multiplierApplied'), isFalse);
      });
    });

    group('equality', () {
      test('models with same values are equal', () {
        final now = DateTime.now();
        final model1 = EngagementModel(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: 'started',
          startedAt: now,
          watchDurationSeconds: 0,
          requiredDurationSeconds: 30,
          answers: [],
          attemptNumber: 1,
          createdAt: now,
        );
        final model2 = EngagementModel(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: 'started',
          startedAt: now,
          watchDurationSeconds: 0,
          requiredDurationSeconds: 30,
          answers: [],
          attemptNumber: 1,
          createdAt: now,
        );

        expect(model1, equals(model2));
      });
    });

    group('roundtrip', () {
      test('entity -> model -> entity preserves data', () {
        final now = DateTime.now();
        final original = Engagement(
          id: 'eng_001',
          userId: 'user_001',
          audienceCampaignId: 'campaign_001',
          earnOpportunityId: 'opp_001',
          status: EngagementStatus.completed,
          startedAt: now,
          completedAt: now.add(const Duration(minutes: 2)),
          watchDurationSeconds: 30,
          requiredDurationSeconds: 30,
          answers: [
            EngagementAnswer(
              questionId: 'q1',
              selectedOption: 'A',
              answeredAt: now.add(const Duration(seconds: 45)),
              isCorrect: true,
            ),
          ],
          evidence: EngagementEvidence(
            deviceFingerprint: 'device_123',
            watchDurationMs: 30000,
            videoSeeked: false,
            screenVisible: true,
            appInForeground: true,
            surveyResponseTimesMs: [1500, 2000],
            videoStartedAt: now,
            surveySubmittedAt: now.add(const Duration(minutes: 1)),
          ),
          tokensEarned: 100,
          attemptNumber: 1,
          createdAt: now,
          updatedAt: now,
          threadId: 'thread_001',
          clientId: 'client_001',
          streakDayAtCompletion: 7,
          multiplierApplied: 1.35,
        );

        final model = EngagementModel.fromEntity(original);
        final restored = model.toEntity();

        expect(restored.id, equals(original.id));
        expect(restored.userId, equals(original.userId));
        expect(restored.status, equals(original.status));
        expect(restored.watchDurationSeconds, equals(original.watchDurationSeconds));
        expect(restored.answers.length, equals(original.answers.length));
        expect(restored.answers[0].questionId, equals(original.answers[0].questionId));
        expect(restored.evidence?.deviceFingerprint, equals(original.evidence?.deviceFingerprint));
        expect(restored.tokensEarned, equals(original.tokensEarned));
        expect(restored.threadId, equals(original.threadId));
        expect(restored.streakDayAtCompletion, equals(original.streakDayAtCompletion));
        expect(restored.multiplierApplied, equals(original.multiplierApplied));
      });
    });
  });
}
