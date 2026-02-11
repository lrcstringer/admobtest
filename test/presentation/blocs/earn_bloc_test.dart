import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/data/services/admob_service.dart';
import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/domain/repositories/earn_repository.dart';
import 'package:imalichat/domain/value_objects/engagement_evidence.dart';
import 'package:imalichat/presentation/blocs/earn/earn_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockEarnRepository extends Mock implements EarnRepository {}

class MockAdMobService extends Mock implements AdMobService {}

class FakeEngagementEvidence extends Fake implements EngagementEvidence {}

class FakeEngagementAnswer extends Fake implements EngagementAnswer {}

void main() {
  late MockEarnRepository mockEarnRepository;
  late MockAdMobService mockAdMobService;
  late ValueNotifier<bool> isAdReadyNotifier;
  late ValueNotifier<bool> isLoadingNotifier;

  setUpAll(() {
    registerFallbackValue(FakeEngagementEvidence());
    registerFallbackValue(<EngagementAnswer>[]);
  });

  setUp(() {
    mockEarnRepository = MockEarnRepository();
    mockAdMobService = MockAdMobService();
    isAdReadyNotifier = ValueNotifier(false);
    isLoadingNotifier = ValueNotifier(false);

    // Setup default AdMobService mock behavior
    when(() => mockAdMobService.isAdReady).thenReturn(isAdReadyNotifier);
    when(() => mockAdMobService.isLoading).thenReturn(isLoadingNotifier);
    when(() => mockAdMobService.hasAdReady).thenReturn(false);
  });

  tearDown(() {
    isAdReadyNotifier.dispose();
    isLoadingNotifier.dispose();
  });

  group('EarnBloc', () {
    test('initial state is correct', () {
      final bloc = EarnBloc(mockEarnRepository, mockAdMobService);
      expect(bloc.state.status, EarnStatus.initial);
      expect(bloc.state.threads, isEmpty);
      expect(bloc.state.opportunities, isEmpty);
      expect(bloc.state.engagementPhase, EngagementPhase.idle);
      expect(bloc.state.dailyCompletions, equals(0));
      expect(bloc.state.dailyEarnCap, equals(30));
      expect(bloc.state.dailyLimitReached, isFalse);
      expect(bloc.state.hasActiveEngagement, isFalse);
      bloc.close();
    });

    group('LoadThreads', () {
      blocTest<EarnBloc, EarnState>(
        'emits [loading, loaded] when getEligibleThreads succeeds',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => Right(TestData.eligibleThreadsResult));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>().having((s) => s.status, 'status', EarnStatus.loading),
          isA<EarnState>()
              .having((s) => s.status, 'status', EarnStatus.loaded)
              .having((s) => s.threads, 'threads', TestData.earnThreadList)
              .having((s) => s.dailyCompletions, 'dailyCompletions', 5)
              .having((s) => s.dailyEarnCap, 'dailyEarnCap', 30)
              .having((s) => s.dailyLimitReached, 'dailyLimitReached', false),
        ],
        verify: (_) {
          verify(() => mockEarnRepository.getEligibleThreads()).called(1);
        },
      );

      blocTest<EarnBloc, EarnState>(
        'emits [loading, error] when getEligibleThreads fails',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>().having((s) => s.status, 'status', EarnStatus.loading),
          isA<EarnState>()
              .having((s) => s.status, 'status', EarnStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'calculates totalAvailableOpportunities correctly',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => Right(TestData.eligibleThreadsResult));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.totalAvailableOpportunities, 'totalAvailableOpportunities', 15),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'handles daily limit reached state',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => Right(TestData.dailyLimitReachedResult));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.dailyLimitReached, 'dailyLimitReached', true)
              .having((s) => s.dailyCompletions, 'dailyCompletions', 30),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'handles empty threads result',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => Right(TestData.emptyThreadsResult));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.threads, 'threads', isEmpty)
              .having((s) => s.totalAvailableOpportunities, 'totalAvailableOpportunities', 0),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'handles server error',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => const Left(Failure.serverError(message: 'Server unavailable')));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.status, 'status', EarnStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('SelectThread', () {
      blocTest<EarnBloc, EarnState>(
        'selects thread and triggers loadOpportunities',
        build: () {
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: any(named: 'threadId'),
              )).thenAnswer((_) async => Right(TestData.opportunityList));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(threads: TestData.earnThreadList),
        act: (bloc) => bloc.add(const EarnEvent.selectThread('earn_thread_1')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.selectedThread?.id, 'selectedThread.id', 'earn_thread_1')
              .having((s) => s.opportunitiesStatus, 'opportunitiesStatus', EarnStatus.loading),
          isA<EarnState>()
              .having((s) => s.opportunities, 'opportunities', TestData.opportunityList)
              .having((s) => s.opportunitiesStatus, 'opportunitiesStatus', EarnStatus.loaded),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'falls back to first thread when threadId not found',
        build: () {
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: any(named: 'threadId'),
              )).thenAnswer((_) async => const Right([]));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(threads: TestData.earnThreadList),
        act: (bloc) => bloc.add(const EarnEvent.selectThread('non_existent_id')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.selectedThread?.id, 'selectedThread.id', 'earn_thread_1'),
          isA<EarnState>(),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'clears opportunities on thread change',
        build: () {
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: any(named: 'threadId'),
              )).thenAnswer((_) async => Right(TestData.opportunityList));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          threads: TestData.earnThreadList,
          opportunities: TestData.opportunityList,
        ),
        act: (bloc) => bloc.add(const EarnEvent.selectThread('earn_thread_2')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.opportunities, 'opportunities', isEmpty)
              .having((s) => s.selectedThread?.id, 'selectedThread.id', 'earn_thread_2'),
          isA<EarnState>(),
        ],
      );
    });

    group('LoadOpportunities', () {
      blocTest<EarnBloc, EarnState>(
        'emits [loading, loaded] when getEligibleOpportunities succeeds',
        build: () {
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: 'thread_1',
              )).thenAnswer((_) async => Right(TestData.opportunityList));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadOpportunities(threadId: 'thread_1')),
        expect: () => [
          isA<EarnState>().having(
              (s) => s.opportunitiesStatus, 'opportunitiesStatus', EarnStatus.loading),
          isA<EarnState>()
              .having((s) => s.opportunitiesStatus, 'opportunitiesStatus', EarnStatus.loaded)
              .having((s) => s.opportunities, 'opportunities', TestData.opportunityList),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits error when getEligibleOpportunities fails',
        build: () {
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: 'thread_1',
              )).thenAnswer((_) async => const Left(Failure.serverError(message: 'Failed')));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadOpportunities(threadId: 'thread_1')),
        expect: () => [
          isA<EarnState>().having(
              (s) => s.opportunitiesStatus, 'opportunitiesStatus', EarnStatus.loading),
          isA<EarnState>()
              .having((s) => s.opportunitiesStatus, 'opportunitiesStatus', EarnStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'handles empty opportunities list',
        build: () {
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: 'thread_1',
              )).thenAnswer((_) async => const Right([]));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadOpportunities(threadId: 'thread_1')),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.opportunities, 'opportunities', isEmpty)
              .having((s) => s.opportunitiesStatus, 'opportunitiesStatus', EarnStatus.loaded),
        ],
      );
    });

    group('SelectOpportunity', () {
      blocTest<EarnBloc, EarnState>(
        'sets selectedOpportunity when getOpportunityById succeeds',
        build: () {
          when(() => mockEarnRepository.getOpportunityById('opp_video_1'))
              .thenAnswer((_) async => Right(TestData.videoOpportunity));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.selectOpportunity('opp_video_1')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.selectedOpportunity, 'selectedOpportunity', TestData.videoOpportunity),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'sets errorMessage when getOpportunityById fails',
        build: () {
          when(() => mockEarnRepository.getOpportunityById('opp_invalid'))
              .thenAnswer((_) async => const Left(Failure.unknown()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.selectOpportunity('opp_invalid')),
        expect: () => [
          isA<EarnState>().having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('StartEngagement', () {
      blocTest<EarnBloc, EarnState>(
        'emits [starting, watching] when startEngagement succeeds',
        build: () {
          when(() => mockEarnRepository.startEngagement(
                opportunityId: any(named: 'opportunityId'),
              )).thenAnswer((_) async => Right(TestData.inProgressEngagement));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.startEngagement(opportunityId: 'opp123')),
        expect: () => [
          isA<EarnState>().having(
            (s) => s.engagementPhase,
            'engagementPhase',
            EngagementPhase.starting,
          ),
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.watching)
              .having((s) => s.currentEngagement, 'currentEngagement', TestData.inProgressEngagement),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits [starting, failed] when daily cap reached',
        build: () {
          when(() => mockEarnRepository.startEngagement(
                opportunityId: any(named: 'opportunityId'),
              )).thenAnswer((_) async => const Left(Failure.dailyCapReached()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.startEngagement(opportunityId: 'opp123')),
        expect: () => [
          isA<EarnState>().having(
            (s) => s.engagementPhase,
            'engagementPhase',
            EngagementPhase.starting,
          ),
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.failed)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits [starting, failed] when budget depleted',
        build: () {
          when(() => mockEarnRepository.startEngagement(
                opportunityId: any(named: 'opportunityId'),
              )).thenAnswer((_) async => const Left(Failure.insufficientBalance()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.startEngagement(opportunityId: 'opp123')),
        expect: () => [
          isA<EarnState>().having(
            (s) => s.engagementPhase,
            'engagementPhase',
            EngagementPhase.starting,
          ),
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.failed),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits [starting, failed] on server error',
        build: () {
          when(() => mockEarnRepository.startEngagement(
                opportunityId: any(named: 'opportunityId'),
              )).thenAnswer((_) async => const Left(Failure.serverError(message: 'Failed')));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.startEngagement(opportunityId: 'opp123')),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.failed),
        ],
      );
    });

    group('UpdateWatchProgress', () {
      blocTest<EarnBloc, EarnState>(
        'updates engagement progress and stays in watching phase when not complete',
        build: () {
          final updatedEngagement = TestData.inProgressEngagement.copyWith(
            watchDurationSeconds: 20,
          );
          when(() => mockEarnRepository.updateEngagementProgress(
                engagementId: any(named: 'engagementId'),
                watchDurationSeconds: any(named: 'watchDurationSeconds'),
              )).thenAnswer((_) async => Right(updatedEngagement));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watching,
        ),
        act: (bloc) => bloc.add(const EarnEvent.updateWatchProgress(
          engagementId: 'engagement123',
          watchDurationSeconds: 20,
        )),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.watching)
              .having((s) => s.currentEngagement?.watchDurationSeconds, 'watchDuration', 20),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'transitions to surveying when watch requirement met',
        build: () {
          final completedWatchEngagement = TestData.inProgressEngagement.copyWith(
            watchDurationSeconds: 30,
          );
          when(() => mockEarnRepository.updateEngagementProgress(
                engagementId: any(named: 'engagementId'),
                watchDurationSeconds: any(named: 'watchDurationSeconds'),
              )).thenAnswer((_) async => Right(completedWatchEngagement));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watching,
        ),
        act: (bloc) => bloc.add(const EarnEvent.updateWatchProgress(
          engagementId: 'engagement123',
          watchDurationSeconds: 30,
        )),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.surveying)
              .having((s) => s.currentEngagement?.watchRequirementMet, 'watchRequirementMet', true),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'silently ignores progress update errors',
        build: () {
          when(() => mockEarnRepository.updateEngagementProgress(
                engagementId: any(named: 'engagementId'),
                watchDurationSeconds: any(named: 'watchDurationSeconds'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watching,
        ),
        act: (bloc) => bloc.add(const EarnEvent.updateWatchProgress(
          engagementId: 'engagement123',
          watchDurationSeconds: 20,
        )),
        expect: () => [],
      );
    });

    group('SubmitSurvey', () {
      final testAnswers = [
        EngagementAnswer(
          questionId: 'q1',
          questionType: 'single_select',
          selectedOption: 'A',
          answeredAt: DateTime.now(),
        ),
      ];

      blocTest<EarnBloc, EarnState>(
        'emits [submitting, completed] when submitSurvey succeeds',
        build: () {
          when(() => mockEarnRepository.submitSurvey(
                engagementId: any(named: 'engagementId'),
                answers: any(named: 'answers'),
                evidence: any(named: 'evidence'),
              )).thenAnswer((_) async => Right(TestData.completedEngagement));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.surveyingEngagement,
          engagementPhase: EngagementPhase.surveying,
        ),
        act: (bloc) => bloc.add(EarnEvent.submitSurvey(
          engagementId: 'engagement789',
          answers: testAnswers,
          evidence: TestData.testEvidence,
        )),
        expect: () => [
          isA<EarnState>().having(
            (s) => s.engagementPhase,
            'engagementPhase',
            EngagementPhase.submitting,
          ),
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.completed)
              .having((s) => s.currentEngagement?.tokensEarned, 'tokensEarned', 100),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits [submitting, failed] when submitSurvey fails',
        build: () {
          when(() => mockEarnRepository.submitSurvey(
                engagementId: any(named: 'engagementId'),
                answers: any(named: 'answers'),
                evidence: any(named: 'evidence'),
              )).thenAnswer((_) async => const Left(Failure.serverError(message: 'Invalid answers')));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.surveyingEngagement,
          engagementPhase: EngagementPhase.surveying,
        ),
        act: (bloc) => bloc.add(EarnEvent.submitSurvey(
          engagementId: 'engagement789',
          answers: testAnswers,
          evidence: TestData.testEvidence,
        )),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.failed)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits failed on network error',
        build: () {
          when(() => mockEarnRepository.submitSurvey(
                engagementId: any(named: 'engagementId'),
                answers: any(named: 'answers'),
                evidence: any(named: 'evidence'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.surveyingEngagement,
          engagementPhase: EngagementPhase.surveying,
        ),
        act: (bloc) => bloc.add(EarnEvent.submitSurvey(
          engagementId: 'engagement789',
          answers: testAnswers,
          evidence: TestData.testEvidence,
        )),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.failed),
        ],
      );
    });

    group('AbandonEngagement', () {
      blocTest<EarnBloc, EarnState>(
        'clears current engagement on abandon',
        build: () {
          when(() => mockEarnRepository.abandonEngagement(any()))
              .thenAnswer((_) async => const Right(null));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watching,
        ),
        act: (bloc) => bloc.add(const EarnEvent.abandonEngagement('engagement123')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.currentEngagement, 'currentEngagement', isNull)
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.abandoned),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'sets error on abandon failure',
        build: () {
          when(() => mockEarnRepository.abandonEngagement(any()))
              .thenAnswer((_) async => const Left(Failure.serverError(message: 'Failed')));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watching,
        ),
        act: (bloc) => bloc.add(const EarnEvent.abandonEngagement('engagement123')),
        expect: () => [
          isA<EarnState>().having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'can abandon from surveying phase',
        build: () {
          when(() => mockEarnRepository.abandonEngagement(any()))
              .thenAnswer((_) async => const Right(null));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          currentEngagement: TestData.surveyingEngagement,
          engagementPhase: EngagementPhase.surveying,
        ),
        act: (bloc) => bloc.add(const EarnEvent.abandonEngagement('engagement789')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.currentEngagement, 'currentEngagement', isNull)
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.abandoned),
        ],
      );
    });

    group('LoadHistory', () {
      blocTest<EarnBloc, EarnState>(
        'loads engagement history',
        build: () {
          when(() => mockEarnRepository.getEngagementHistory(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right(TestData.engagementHistoryList));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadHistory()),
        expect: () => [
          isA<EarnState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', true),
          isA<EarnState>()
              .having((s) => s.isLoadingHistory, 'isLoadingHistory', false)
              .having((s) => s.history, 'history', TestData.engagementHistoryList)
              .having((s) => s.hasMoreHistory, 'hasMoreHistory', false),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'sets hasMoreHistory true when history equals limit',
        build: () {
          final fullPage = List.generate(
            20,
            (i) => TestData.completedEngagement.copyWith(id: 'eng_$i'),
          );
          when(() => mockEarnRepository.getEngagementHistory(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right(fullPage));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadHistory()),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.hasMoreHistory, 'hasMoreHistory', true)
              .having((s) => s.lastHistoryTimestamp, 'lastHistoryTimestamp', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'handles empty history',
        build: () {
          when(() => mockEarnRepository.getEngagementHistory(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => const Right([]));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadHistory()),
        expect: () => [
          isA<EarnState>(),
          isA<EarnState>()
              .having((s) => s.history, 'history', isEmpty)
              .having((s) => s.hasMoreHistory, 'hasMoreHistory', false),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'sets error on failure',
        build: () {
          when(() => mockEarnRepository.getEngagementHistory(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadHistory()),
        expect: () => [
          isA<EarnState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', true),
          isA<EarnState>()
              .having((s) => s.isLoadingHistory, 'isLoadingHistory', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'respects custom limit',
        build: () {
          when(() => mockEarnRepository.getEngagementHistory(
                limit: 10,
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => const Right([]));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadHistory(limit: 10)),
        verify: (_) {
          verify(() => mockEarnRepository.getEngagementHistory(
                limit: 10,
                startAfter: null,
              )).called(1);
        },
      );
    });

    group('LoadMoreHistory', () {
      blocTest<EarnBloc, EarnState>(
        'does nothing when already loading',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => const EarnState(isLoadingHistory: true),
        act: (bloc) => bloc.add(const EarnEvent.loadMoreHistory()),
        expect: () => [],
      );

      blocTest<EarnBloc, EarnState>(
        'does nothing when no more history',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => const EarnState(hasMoreHistory: false),
        act: (bloc) => bloc.add(const EarnEvent.loadMoreHistory()),
        expect: () => [],
      );

      blocTest<EarnBloc, EarnState>(
        'appends new history to existing',
        build: () {
          final moreHistory = [
            TestData.completedEngagement.copyWith(
              id: 'eng_new_1',
              createdAt: DateTime(2024, 1, 10),
            ),
          ];
          when(() => mockEarnRepository.getEngagementHistory(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right(moreHistory));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          history: TestData.engagementHistoryList,
          hasMoreHistory: true,
          lastHistoryTimestamp: DateTime(2024, 1, 3),
        ),
        act: (bloc) => bloc.add(const EarnEvent.loadMoreHistory()),
        expect: () => [
          isA<EarnState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', true),
          isA<EarnState>()
              .having((s) => s.history.length, 'history.length', 4)
              .having((s) => s.isLoadingHistory, 'isLoadingHistory', false),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'uses lastHistoryTimestamp for pagination',
        build: () {
          when(() => mockEarnRepository.getEngagementHistory(
                limit: 20,
                startAfter: DateTime(2024, 1, 3),
              )).thenAnswer((_) async => const Right([]));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          history: TestData.engagementHistoryList,
          hasMoreHistory: true,
          lastHistoryTimestamp: DateTime(2024, 1, 3),
        ),
        act: (bloc) => bloc.add(const EarnEvent.loadMoreHistory()),
        verify: (_) {
          verify(() => mockEarnRepository.getEngagementHistory(
                limit: 20,
                startAfter: DateTime(2024, 1, 3),
              )).called(1);
        },
      );

      blocTest<EarnBloc, EarnState>(
        'ignores errors silently',
        build: () {
          when(() => mockEarnRepository.getEngagementHistory(
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          history: TestData.engagementHistoryList,
          hasMoreHistory: true,
          lastHistoryTimestamp: DateTime(2024, 1, 3),
        ),
        act: (bloc) => bloc.add(const EarnEvent.loadMoreHistory()),
        expect: () => [
          isA<EarnState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', true),
          isA<EarnState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', false),
        ],
      );
    });

    group('Refresh', () {
      blocTest<EarnBloc, EarnState>(
        'refreshes threads',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => Right(TestData.eligibleThreadsResult));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.refresh()),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.threads, 'threads', TestData.earnThreadList)
              .having((s) => s.dailyCompletions, 'dailyCompletions', 5),
        ],
        verify: (_) {
          verify(() => mockEarnRepository.getEligibleThreads()).called(1);
        },
      );

      blocTest<EarnBloc, EarnState>(
        'refreshes opportunities when thread is selected',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => Right(TestData.eligibleThreadsResult));
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: 'earn_thread_1',
              )).thenAnswer((_) async => Right(TestData.opportunityList));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          selectedThread: TestData.testEarnThread,
        ),
        act: (bloc) => bloc.add(const EarnEvent.refresh()),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.threads, 'threads', TestData.earnThreadList),
          isA<EarnState>()
              .having((s) => s.opportunities, 'opportunities', TestData.opportunityList),
        ],
        verify: (_) {
          verify(() => mockEarnRepository.getEligibleOpportunities(
                threadId: 'earn_thread_1',
              )).called(1);
        },
      );

      blocTest<EarnBloc, EarnState>(
        'sets error on threads refresh failure',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.refresh()),
        expect: () => [
          isA<EarnState>().having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'ignores opportunities refresh failure',
        build: () {
          when(() => mockEarnRepository.getEligibleThreads())
              .thenAnswer((_) async => Right(TestData.eligibleThreadsResult));
          when(() => mockEarnRepository.getEligibleOpportunities(
                threadId: any(named: 'threadId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        seed: () => EarnState(
          selectedThread: TestData.testEarnThread,
          opportunities: TestData.opportunityList,
        ),
        act: (bloc) => bloc.add(const EarnEvent.refresh()),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.threads, 'threads', TestData.earnThreadList)
              .having((s) => s.opportunities, 'opportunities', TestData.opportunityList),
        ],
      );
    });

    group('ClearError', () {
      blocTest<EarnBloc, EarnState>(
        'clears error message',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => const EarnState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const EarnEvent.clearError()),
        expect: () => [
          isA<EarnState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits no state when no error exists',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => const EarnState(),
        act: (bloc) => bloc.add(const EarnEvent.clearError()),
        expect: () => [],
      );
    });

    group('ResetEngagement', () {
      blocTest<EarnBloc, EarnState>(
        'resets engagement state',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          selectedOpportunity: TestData.videoOpportunity,
          engagementPhase: EngagementPhase.watching,
        ),
        act: (bloc) => bloc.add(const EarnEvent.resetEngagement()),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.currentEngagement, 'currentEngagement', isNull)
              .having((s) => s.selectedOpportunity, 'selectedOpportunity', isNull)
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.idle),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'can reset from completed state',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.completedEngagement,
          engagementPhase: EngagementPhase.completed,
        ),
        act: (bloc) => bloc.add(const EarnEvent.resetEngagement()),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.currentEngagement, 'currentEngagement', isNull)
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.idle),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'can reset from failed state',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.failedEngagement,
          engagementPhase: EngagementPhase.failed,
          errorMessage: 'Failed!',
        ),
        act: (bloc) => bloc.add(const EarnEvent.resetEngagement()),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.currentEngagement, 'currentEngagement', isNull)
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.idle),
        ],
      );
    });

    group('State computed properties', () {
      test('hasActiveEngagement returns true when watching', () {
        final state = EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watching,
        );
        expect(state.hasActiveEngagement, isTrue);
      });

      test('hasActiveEngagement returns true when surveying', () {
        final state = EarnState(
          currentEngagement: TestData.surveyingEngagement,
          engagementPhase: EngagementPhase.surveying,
        );
        expect(state.hasActiveEngagement, isTrue);
      });

      test('hasActiveEngagement returns false when idle', () {
        const state = EarnState(engagementPhase: EngagementPhase.idle);
        expect(state.hasActiveEngagement, isFalse);
      });

      test('hasActiveEngagement returns false when completed', () {
        final state = EarnState(
          currentEngagement: TestData.completedEngagement,
          engagementPhase: EngagementPhase.completed,
        );
        expect(state.hasActiveEngagement, isFalse);
      });

      test('completedCount returns correct count', () {
        final state = EarnState(history: TestData.engagementHistoryList);
        expect(state.completedCount, equals(3));
      });

      test('completedCount returns 0 for empty history', () {
        const state = EarnState();
        expect(state.completedCount, equals(0));
      });

      test('hasActiveEngagement returns true when watchingAd', () {
        final state = EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watchingAd,
        );
        expect(state.hasActiveEngagement, isTrue);
      });

      test('isAdMobOpportunity returns true for adVideo type', () {
        final state = EarnState(
          selectedOpportunity: TestData.adMobOpportunity,
        );
        expect(state.isAdMobOpportunity, isTrue);
      });

      test('isAdMobOpportunity returns false for video type', () {
        final state = EarnState(
          selectedOpportunity: TestData.videoOpportunity,
        );
        expect(state.isAdMobOpportunity, isFalse);
      });

      test('isAdMobOpportunity returns false when no opportunity selected', () {
        const state = EarnState();
        expect(state.isAdMobOpportunity, isFalse);
      });
    });

    group('LoadAdVideo', () {
      blocTest<EarnBloc, EarnState>(
        'emits [isAdLoading: true, isAdReady: true] when load succeeds',
        build: () {
          when(() => mockAdMobService.loadAdWithRetry())
              .thenAnswer((_) async => true);
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadAdVideo()),
        expect: () => [
          isA<EarnState>().having((s) => s.isAdLoading, 'isAdLoading', true),
          isA<EarnState>()
              .having((s) => s.isAdLoading, 'isAdLoading', false)
              .having((s) => s.isAdReady, 'isAdReady', true),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'emits [isAdLoading: true, isAdReady: false] when load fails',
        build: () {
          when(() => mockAdMobService.loadAdWithRetry())
              .thenAnswer((_) async => false);
          return EarnBloc(mockEarnRepository, mockAdMobService);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadAdVideo()),
        expect: () => [
          isA<EarnState>().having((s) => s.isAdLoading, 'isAdLoading', true),
          isA<EarnState>()
              .having((s) => s.isAdLoading, 'isAdLoading', false)
              .having((s) => s.isAdReady, 'isAdReady', false),
        ],
      );
    });

    group('AdVideoCompleted', () {
      blocTest<EarnBloc, EarnState>(
        'sets adTransactionId and transitions to surveying phase',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watchingAd,
        ),
        act: (bloc) => bloc.add(const EarnEvent.adVideoCompleted(
          transactionId: 'admob_txn_123',
          rewardAmount: 5,
        )),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.adTransactionId, 'adTransactionId', 'admob_txn_123')
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.surveying),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'preserves existing engagement when transitioning',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watchingAd,
          selectedOpportunity: TestData.adMobOpportunity,
        ),
        act: (bloc) => bloc.add(const EarnEvent.adVideoCompleted(
          transactionId: 'txn_456',
          rewardAmount: 5,
        )),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.currentEngagement, 'currentEngagement', isNotNull)
              .having((s) => s.selectedOpportunity, 'selectedOpportunity', isNotNull)
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.surveying),
        ],
      );
    });

    group('AdVideoFailed', () {
      blocTest<EarnBloc, EarnState>(
        'sets failed phase and error message',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watchingAd,
        ),
        act: (bloc) =>
            bloc.add(const EarnEvent.adVideoFailed(reason: 'Ad failed to show')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.failed)
              .having((s) => s.errorMessage, 'errorMessage', 'Ad failed to show')
              .having((s) => s.adTransactionId, 'adTransactionId', isNull),
        ],
      );

      blocTest<EarnBloc, EarnState>(
        'clears any existing adTransactionId on failure',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watchingAd,
          adTransactionId: 'previous_txn',
        ),
        act: (bloc) =>
            bloc.add(const EarnEvent.adVideoFailed(reason: 'User closed ad')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.adTransactionId, 'adTransactionId', isNull),
        ],
      );
    });

    group('ResetEngagement with AdMob', () {
      blocTest<EarnBloc, EarnState>(
        'clears adTransactionId on reset',
        build: () => EarnBloc(mockEarnRepository, mockAdMobService),
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
          engagementPhase: EngagementPhase.watchingAd,
          adTransactionId: 'txn_to_clear',
        ),
        act: (bloc) => bloc.add(const EarnEvent.resetEngagement()),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.adTransactionId, 'adTransactionId', isNull)
              .having((s) => s.engagementPhase, 'engagementPhase', EngagementPhase.idle),
        ],
      );
    });

    group('showAdVideo', () {
      test('delegates to AdMobService.showAd', () async {
        final expectedResult = AdRewardResult.success(
          transactionId: 'txn_123',
          rewardAmount: 5,
          rewardType: 'tokens',
        );
        when(() => mockAdMobService.showAd(userId: 'user123'))
            .thenAnswer((_) async => expectedResult);

        final bloc = EarnBloc(mockEarnRepository, mockAdMobService);
        final result = await bloc.showAdVideo('user123');

        expect(result.success, isTrue);
        expect(result.transactionId, 'txn_123');
        verify(() => mockAdMobService.showAd(userId: 'user123')).called(1);

        await bloc.close();
      });

      test('returns failure result from AdMobService', () async {
        final expectedResult = AdRewardResult.failure('No ad loaded');
        when(() => mockAdMobService.showAd(userId: 'user456'))
            .thenAnswer((_) async => expectedResult);

        final bloc = EarnBloc(mockEarnRepository, mockAdMobService);
        final result = await bloc.showAdVideo('user456');

        expect(result.success, isFalse);
        expect(result.errorMessage, 'No ad loaded');

        await bloc.close();
      });
    });

    group('AdMobService listener integration', () {
      test('updates state when isAdReady changes', () async {
        final bloc = EarnBloc(mockEarnRepository, mockAdMobService);

        // Initial state
        expect(bloc.state.isAdReady, isFalse);

        // Simulate ad becoming ready
        isAdReadyNotifier.value = true;
        await Future.delayed(Duration.zero); // Let listener fire

        expect(bloc.state.isAdReady, isTrue);

        await bloc.close();
      });

      test('updates state when isLoading changes', () async {
        final bloc = EarnBloc(mockEarnRepository, mockAdMobService);

        // Initial state
        expect(bloc.state.isAdLoading, isFalse);

        // Simulate loading start
        isLoadingNotifier.value = true;
        await Future.delayed(Duration.zero); // Let listener fire

        expect(bloc.state.isAdLoading, isTrue);

        await bloc.close();
      });

      test('does not emit after bloc is closed', () async {
        final bloc = EarnBloc(mockEarnRepository, mockAdMobService);
        await bloc.close();

        // This should not throw or emit
        isAdReadyNotifier.value = true;
        isLoadingNotifier.value = true;

        // No assertion needed - just verifying no exception
      });
    });
  });
}
