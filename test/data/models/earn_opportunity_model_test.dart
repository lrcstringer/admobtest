import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/earn_opportunity_model.dart';
import 'package:imalichat/domain/entities/earn_opportunity.dart';
import 'package:imalichat/domain/entities/targeting_criteria.dart';

// Mock Timestamp class to simulate Firestore Timestamps in tests
class MockTimestamp {
  final int seconds;
  final int nanoseconds;

  MockTimestamp(this.seconds, this.nanoseconds);

  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(
      seconds * 1000 + (nanoseconds ~/ 1000000),
    );
  }
}

void main() {
  group('SurveyQuestionModel', () {
    group('fromJson', () {
      test('parses all required fields', () {
        final json = {
          'id': 'q1',
          'text': 'What is your favorite color?',
          'options': ['Red', 'Blue', 'Green'],
          'orderIndex': 0,
        };

        final model = SurveyQuestionModel.fromJson(json);

        expect(model.id, equals('q1'));
        expect(model.text, equals('What is your favorite color?'));
        expect(model.options, equals(['Red', 'Blue', 'Green']));
        expect(model.orderIndex, equals(0));
        expect(model.isAttentionCheck, isFalse);
        expect(model.correctAnswer, isNull);
      });

      test('parses attention check fields', () {
        final json = {
          'id': 'q2',
          'text': 'Select the color blue',
          'options': ['Red', 'Blue', 'Green'],
          'orderIndex': 1,
          'isAttentionCheck': true,
          'correctAnswer': 'Blue',
        };

        final model = SurveyQuestionModel.fromJson(json);

        expect(model.isAttentionCheck, isTrue);
        expect(model.correctAnswer, equals('Blue'));
      });
    });

    group('toEntity', () {
      test('converts to SurveyQuestion entity', () {
        final model = SurveyQuestionModel(
          id: 'q1',
          text: 'Test question',
          questionType: 'single_select',
          options: ['A', 'B', 'C'],
          orderIndex: 0,
          isAttentionCheck: true,
          correctAnswer: 'A',
        );

        final entity = model.toEntity();

        expect(entity.id, equals('q1'));
        expect(entity.text, equals('Test question'));
        expect(entity.options, equals(['A', 'B', 'C']));
        expect(entity.orderIndex, equals(0));
        expect(entity.isAttentionCheck, isTrue);
        expect(entity.correctAnswer, equals('A'));
      });
    });

    group('fromEntity', () {
      test('creates model from entity', () {
        final entity = SurveyQuestion(
          id: 'q1',
          text: 'Test question',
          questionType: QuestionType.singleSelect,
          options: ['A', 'B'],
          orderIndex: 0,
        );

        final model = SurveyQuestionModel.fromEntity(entity);

        expect(model.id, equals(entity.id));
        expect(model.text, equals(entity.text));
        expect(model.options, equals(entity.options));
      });
    });

    group('toFirestoreJson', () {
      test('serializes all fields', () {
        final model = SurveyQuestionModel(
          id: 'q1',
          text: 'Test',
          questionType: 'single_select',
          options: ['A', 'B'],
          orderIndex: 0,
          isAttentionCheck: true,
          correctAnswer: 'A',
        );

        final json = model.toFirestoreJson();

        expect(json['id'], equals('q1'));
        expect(json['text'], equals('Test'));
        expect(json['options'], equals(['A', 'B']));
        expect(json['orderIndex'], equals(0));
        expect(json['isAttentionCheck'], isTrue);
        expect(json['correctAnswer'], equals('A'));
      });

      test('omits null optional fields', () {
        final model = SurveyQuestionModel(
          id: 'q1',
          text: 'Test',
          questionType: 'single_select',
          options: ['A', 'B'],
          orderIndex: 0,
        );

        final json = model.toFirestoreJson();

        expect(json.containsKey('isAttentionCheck'), isFalse);
        expect(json.containsKey('correctAnswer'), isFalse);
      });
    });
  });

  group('EarnOpportunityModel', () {
    Map<String, dynamic> createValidJson({
      String? earningType,
      String? mediaType,
      bool? bonusReward,
      String? bonusIntervalType,
      Map<String, dynamic>? targeting,
    }) {
      return {
        'id': 'opp_001',
        'threadId': 'thread_001',
        'title': 'Test Opportunity',
        'description': 'A test opportunity',
        'earningType': earningType ?? 'video',
        'tokenReward': 100,
        'streakPoints': 2,
        'mediaType': mediaType ?? 'video',
        'mediaUrl': 'https://example.com/video.mp4',
        'questions': [],
        'durationSeconds': 30,
        'expiresAt': '2024-12-31T23:59:59Z',
        'isActive': true,
        'clientId': 'client_001',
        'clientName': 'Test Client',
        'clientAvatarColor': '#FF5733',
        'campaignId': 'campaign_001',
        if (targeting != null) 'targeting': targeting,
        'bonusReward': bonusReward ?? false,
        'bonusRewardMultiplier': 2.0,
        'bonusIntervalType': bonusIntervalType,
        'bonusIntervalX': 5,
        'userEngagementStatus': 'completed',
        'userEngagementId': 'eng_001',
      };
    }

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createValidJson();
        final model = EarnOpportunityModel.fromJson(json);

        expect(model.id, equals('opp_001'));
        expect(model.threadId, equals('thread_001'));
        expect(model.title, equals('Test Opportunity'));
        expect(model.description, equals('A test opportunity'));
        expect(model.earningType, equals('video'));
        expect(model.tokenReward, equals(100));
        expect(model.streakPoints, equals(2));
        expect(model.mediaType, equals('video'));
        expect(model.mediaUrl, equals('https://example.com/video.mp4'));
        expect(model.durationSeconds, equals(30));
        expect(model.isActive, isTrue);
        expect(model.clientId, equals('client_001'));
        expect(model.clientName, equals('Test Client'));
        expect(model.bonusRewardMultiplier, equals(2.0));
      });

      test('handles legacy brandName fallback', () {
        final json = {
          'id': 'opp_001',
          'threadId': 'thread_001',
          'title': 'Test',
          'tokenReward': 100,
          'questions': [],
          'durationSeconds': 30,
          'brandName': 'Legacy Brand',
          'brandAvatarColor': '#123456',
        };

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.clientName, equals('Legacy Brand'));
        expect(model.clientAvatarColor, equals('#123456'));
      });

      test('prefers clientName over brandName', () {
        final json = {
          'id': 'opp_001',
          'threadId': 'thread_001',
          'title': 'Test',
          'tokenReward': 100,
          'questions': [],
          'durationSeconds': 30,
          'clientName': 'New Client',
          'brandName': 'Old Brand',
        };

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.clientName, equals('New Client'));
      });

      test('uses default values for missing optional fields', () {
        final json = {
          'id': 'opp_001',
          'threadId': 'thread_001',
          'title': 'Test',
          'tokenReward': 100,
          'durationSeconds': 30,
        };

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.earningType, equals('video'));
        expect(model.streakPoints, equals(1));
        expect(model.mediaType, equals('video'));
        expect(model.questions, isEmpty);
        expect(model.isActive, isTrue);
        expect(model.bonusReward, isFalse);
        expect(model.bonusRewardMultiplier, equals(1.0));
      });

      test('parses expiresAt from ISO string', () {
        final json = createValidJson();
        json['expiresAt'] = '2024-06-15T12:00:00Z';

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.expiresAt, isNotNull);
        expect(model.expiresAt!.year, equals(2024));
        expect(model.expiresAt!.month, equals(6));
        expect(model.expiresAt!.day, equals(15));
      });

      test('handles null expiresAt', () {
        final json = createValidJson();
        json['expiresAt'] = null;

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.expiresAt, isNull);
      });

      test('parses questions list', () {
        final json = createValidJson();
        json['questions'] = [
          {
            'id': 'q1',
            'text': 'Question 1',
            'options': ['A', 'B'],
            'orderIndex': 0,
          },
          {
            'id': 'q2',
            'text': 'Question 2',
            'options': ['X', 'Y', 'Z'],
            'orderIndex': 1,
          },
        ];

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.questions.length, equals(2));
        expect(model.questions[0].id, equals('q1'));
        expect(model.questions[1].options.length, equals(3));
      });

      test('parses targeting map', () {
        final json = createValidJson(targeting: {
          'genders': ['male', 'female'],
          'provinces': ['gauteng', 'western_cape'],
          'minAge': 18,
          'maxAge': 35,
        });

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.targeting, isNotNull);
        expect(model.targeting!['genders'], contains('male'));
        expect(model.targeting!['minAge'], equals(18));
      });

      test('parses bonus configuration', () {
        final json = createValidJson(
          bonusReward: true,
          bonusIntervalType: 'every_x',
        );

        final model = EarnOpportunityModel.fromJson(json);

        expect(model.bonusReward, isTrue);
        expect(model.bonusRewardMultiplier, equals(2.0));
        expect(model.bonusIntervalType, equals('every_x'));
        expect(model.bonusIntervalX, equals(5));
      });
    });

    group('toEntity', () {
      test('converts all fields to entity', () {
        final json = createValidJson(
          earningType: 'survey',
          mediaType: 'image',
          bonusReward: true,
          bonusIntervalType: 'random',
        );
        final model = EarnOpportunityModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.id, equals('opp_001'));
        expect(entity.threadId, equals('thread_001'));
        expect(entity.earningType, equals(EarningType.survey));
        expect(entity.mediaType, equals(MediaType.image));
        expect(entity.tokenReward, equals(100));
        expect(entity.bonusReward, isTrue);
        expect(entity.bonusIntervalType, equals(BonusIntervalType.random));
      });

      test('converts targeting criteria', () {
        final json = createValidJson(targeting: {
          'genders': ['male'],
          'ageMin': 21,
        });
        final model = EarnOpportunityModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.targeting, isNotNull);
        expect(entity.targeting!.genders, contains('male'));
        expect(entity.targeting!.ageMin, equals(21));
      });

      test('converts questions to entities', () {
        final json = createValidJson();
        json['questions'] = [
          {
            'id': 'q1',
            'text': 'Test Q',
            'options': ['A', 'B'],
            'orderIndex': 0,
          },
        ];
        final model = EarnOpportunityModel.fromJson(json);

        final entity = model.toEntity();

        expect(entity.questions.length, equals(1));
        expect(entity.questions[0].id, equals('q1'));
      });
    });

    group('fromEntity', () {
      test('creates model from entity', () {
        final entity = EarnOpportunity(
          id: 'opp_001',
          threadId: 'thread_001',
          title: 'Test',
          earningType: EarningType.survey,
          tokenReward: 150,
          streakPoints: 3,
          mediaType: MediaType.text,
          questions: [],
          durationSeconds: 60,
          isActive: true,
          bonusReward: true,
          bonusRewardMultiplier: 1.5,
          bonusIntervalType: BonusIntervalType.everyX,
          bonusIntervalX: 10,
        );

        final model = EarnOpportunityModel.fromEntity(entity);

        expect(model.id, equals('opp_001'));
        expect(model.earningType, equals('survey'));
        expect(model.mediaType, equals('text'));
        expect(model.tokenReward, equals(150));
        expect(model.bonusIntervalType, equals('every_x'));
        expect(model.bonusIntervalX, equals(10));
      });

      test('converts targeting to JSON map', () {
        final entity = EarnOpportunity(
          id: 'opp_001',
          threadId: 'thread_001',
          title: 'Test',
          earningType: EarningType.video,
          tokenReward: 100,
          mediaType: MediaType.video,
          questions: [],
          durationSeconds: 30,
          isActive: true,
          targeting: TargetingCriteria(
            genders: ['female'],
            provinces: ['gauteng'],
          ),
        );

        final model = EarnOpportunityModel.fromEntity(entity);

        expect(model.targeting, isNotNull);
        expect(model.targeting!['genders'], contains('female'));
      });
    });

    group('enum parsing', () {
      test('parses all earning types', () {
        for (final type in ['survey', 'video', 'poll', 'adVideo']) {
          final json = createValidJson(earningType: type);
          final model = EarnOpportunityModel.fromJson(json);
          final entity = model.toEntity();

          expect(entity.earningType.name, equals(type));
        }
      });

      test('maps legacy trivia and rating types to survey', () {
        for (final type in ['trivia', 'rating']) {
          final json = createValidJson(earningType: type);
          final model = EarnOpportunityModel.fromJson(json);
          final entity = model.toEntity();

          expect(entity.earningType, equals(EarningType.survey));
        }
      });

      test('defaults to video for unknown earning type', () {
        final json = createValidJson(earningType: 'unknown_type');
        final model = EarnOpportunityModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.earningType, equals(EarningType.video));
      });

      test('parses all media types', () {
        for (final type in ['video', 'image', 'text']) {
          final json = createValidJson(mediaType: type);
          final model = EarnOpportunityModel.fromJson(json);
          final entity = model.toEntity();

          expect(entity.mediaType.name, equals(type));
        }
      });

      test('defaults to video for unknown media type', () {
        final json = createValidJson(mediaType: 'unknown_media');
        final model = EarnOpportunityModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.mediaType, equals(MediaType.video));
      });

      test('parses bonus interval types', () {
        final randomJson = createValidJson(bonusIntervalType: 'random');
        final everyXJson = createValidJson(bonusIntervalType: 'every_x');

        final randomModel = EarnOpportunityModel.fromJson(randomJson);
        final everyXModel = EarnOpportunityModel.fromJson(everyXJson);

        expect(randomModel.toEntity().bonusIntervalType,
            equals(BonusIntervalType.random));
        expect(everyXModel.toEntity().bonusIntervalType,
            equals(BonusIntervalType.everyX));
      });

      test('returns null for unknown bonus interval type', () {
        final json = createValidJson(bonusIntervalType: 'unknown');
        final model = EarnOpportunityModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.bonusIntervalType, isNull);
      });

      test('returns null for null bonus interval type', () {
        final json = createValidJson(bonusIntervalType: null);
        final model = EarnOpportunityModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.bonusIntervalType, isNull);
      });
    });

    group('toFirestoreJson', () {
      test('serializes all fields', () {
        final model = EarnOpportunityModel(
          id: 'opp_001',
          threadId: 'thread_001',
          title: 'Test',
          earningType: 'survey',
          tokenReward: 100,
          streakPoints: 2,
          mediaType: 'video',
          questions: [],
          durationSeconds: 30,
          isActive: true,
          bonusReward: true,
          bonusRewardMultiplier: 1.5,
        );

        final json = model.toFirestoreJson();

        expect(json['id'], equals('opp_001'));
        expect(json['threadId'], equals('thread_001'));
        expect(json['title'], equals('Test'));
        expect(json['earningType'], equals('survey'));
        expect(json['tokenReward'], equals(100));
        expect(json['bonusReward'], isTrue);
        expect(json['bonusRewardMultiplier'], equals(1.5));
      });

      test('serializes questions', () {
        final model = EarnOpportunityModel(
          id: 'opp_001',
          threadId: 'thread_001',
          title: 'Test',
          earningType: 'survey',
          tokenReward: 100,
          mediaType: 'video',
          questions: [
            SurveyQuestionModel(
              id: 'q1',
              text: 'Test Q',
              questionType: 'single_select',
              options: ['A', 'B'],
              orderIndex: 0,
            ),
          ],
          durationSeconds: 30,
          isActive: true,
        );

        final json = model.toFirestoreJson();
        final questions = json['questions'] as List;

        expect(questions.length, equals(1));
        expect((questions[0] as Map)['id'], equals('q1'));
      });
    });

    group('equality', () {
      test('models with same values are equal', () {
        final model1 = EarnOpportunityModel(
          id: 'opp_001',
          threadId: 'thread_001',
          title: 'Test',
          earningType: 'video',
          tokenReward: 100,
          mediaType: 'video',
          questions: [],
          durationSeconds: 30,
          isActive: true,
        );
        final model2 = EarnOpportunityModel(
          id: 'opp_001',
          threadId: 'thread_001',
          title: 'Test',
          earningType: 'video',
          tokenReward: 100,
          mediaType: 'video',
          questions: [],
          durationSeconds: 30,
          isActive: true,
        );

        expect(model1, equals(model2));
      });
    });
  });
}
