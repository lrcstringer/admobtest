import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/earn_repository.dart';
import 'package:imalichat/presentation/blocs/earn/earn_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockEarnRepository extends Mock implements EarnRepository {}

void main() {
  late MockEarnRepository mockEarnRepository;

  setUp(() {
    mockEarnRepository = MockEarnRepository();
  });

  group('EarnBloc', () {
    test('initial state is correct', () {
      final bloc = EarnBloc(mockEarnRepository);
      expect(bloc.state.status, EarnStatus.initial);
      expect(bloc.state.threads, isEmpty);
      expect(bloc.state.engagementPhase, EngagementPhase.idle);
      bloc.close();
    });

    group('LoadThreads', () {
      blocTest<EarnBloc, EarnState>(
        'emits [loading, loaded] when getEarnThreads succeeds',
        build: () {
          when(() => mockEarnRepository.getEarnThreads())
              .thenAnswer((_) async => Right(TestData.earnThreadList));
          when(() => mockEarnRepository.watchEarnThreads())
              .thenAnswer((_) => Stream.value(Right(TestData.earnThreadList)));
          return EarnBloc(mockEarnRepository);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>().having((s) => s.status, 'status', EarnStatus.loading),
          isA<EarnState>()
              .having((s) => s.status, 'status', EarnStatus.loaded)
              .having((s) => s.threads, 'threads', TestData.earnThreadList),
        ],
        verify: (_) {
          verify(() => mockEarnRepository.getEarnThreads()).called(1);
        },
      );

      blocTest<EarnBloc, EarnState>(
        'emits [loading, error] when getEarnThreads fails',
        build: () {
          when(() => mockEarnRepository.getEarnThreads())
              .thenAnswer((_) async => const Left(Failure.network()));
          return EarnBloc(mockEarnRepository);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadThreads()),
        expect: () => [
          isA<EarnState>().having((s) => s.status, 'status', EarnStatus.loading),
          isA<EarnState>()
              .having((s) => s.status, 'status', EarnStatus.error)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('SelectThread', () {
      blocTest<EarnBloc, EarnState>(
        'selects thread and loads opportunities',
        build: () {
          when(() => mockEarnRepository.getOpportunities(
                threadId: any(named: 'threadId'),
                activeOnly: any(named: 'activeOnly'),
              )).thenAnswer((_) async => const Right([]));
          return EarnBloc(mockEarnRepository);
        },
        seed: () => EarnState(threads: TestData.earnThreadList),
        act: (bloc) => bloc.add(const EarnEvent.selectThread('earn_thread_1')),
        expect: () => [
          isA<EarnState>()
              .having((s) => s.selectedThread?.id, 'selectedThread.id', 'earn_thread_1')
              .having((s) => s.opportunities, 'opportunities', isEmpty),
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
          return EarnBloc(mockEarnRepository);
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
        'emits [starting, failed] when startEngagement fails',
        build: () {
          when(() => mockEarnRepository.startEngagement(
                opportunityId: any(named: 'opportunityId'),
              )).thenAnswer((_) async => const Left(Failure.dailyCapReached()));
          return EarnBloc(mockEarnRepository);
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
    });

    group('UpdateWatchProgress', () {
      blocTest<EarnBloc, EarnState>(
        'updates engagement progress and transitions to surveying when complete',
        build: () {
          final completedEngagement = TestData.inProgressEngagement.copyWith(
            watchDurationSeconds: 30,
          );
          when(() => mockEarnRepository.updateEngagementProgress(
                engagementId: any(named: 'engagementId'),
                watchDurationSeconds: any(named: 'watchDurationSeconds'),
              )).thenAnswer((_) async => Right(completedEngagement));
          return EarnBloc(mockEarnRepository);
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
    });

    group('AbandonEngagement', () {
      blocTest<EarnBloc, EarnState>(
        'clears current engagement on abandon',
        build: () {
          when(() => mockEarnRepository.abandonEngagement(any()))
              .thenAnswer((_) async => const Right(null));
          return EarnBloc(mockEarnRepository);
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
    });

    group('LoadHistory', () {
      blocTest<EarnBloc, EarnState>(
        'loads engagement history',
        build: () {
          when(() => mockEarnRepository.getEngagementHistory(
                limit: any(named: 'limit'),
              )).thenAnswer((_) async => Right(TestData.engagementList));
          return EarnBloc(mockEarnRepository);
        },
        act: (bloc) => bloc.add(const EarnEvent.loadHistory()),
        expect: () => [
          isA<EarnState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', true),
          isA<EarnState>()
              .having((s) => s.isLoadingHistory, 'isLoadingHistory', false)
              .having((s) => s.history, 'history', TestData.engagementList),
        ],
      );
    });

    group('LoadMoreHistory', () {
      blocTest<EarnBloc, EarnState>(
        'does nothing when already loading',
        build: () => EarnBloc(mockEarnRepository),
        seed: () => const EarnState(isLoadingHistory: true),
        act: (bloc) => bloc.add(const EarnEvent.loadMoreHistory()),
        expect: () => [],
      );

      blocTest<EarnBloc, EarnState>(
        'does nothing when no more history',
        build: () => EarnBloc(mockEarnRepository),
        seed: () => const EarnState(hasMoreHistory: false),
        act: (bloc) => bloc.add(const EarnEvent.loadMoreHistory()),
        expect: () => [],
      );
    });

    group('ThreadsUpdated', () {
      blocTest<EarnBloc, EarnState>(
        'updates threads in state',
        build: () => EarnBloc(mockEarnRepository),
        act: (bloc) => bloc.add(EarnEvent.threadsUpdated(TestData.earnThreadList)),
        expect: () => [
          isA<EarnState>().having((s) => s.threads, 'threads', TestData.earnThreadList),
        ],
      );
    });

    group('ClearError', () {
      blocTest<EarnBloc, EarnState>(
        'clears error message',
        build: () => EarnBloc(mockEarnRepository),
        seed: () => const EarnState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const EarnEvent.clearError()),
        expect: () => [
          isA<EarnState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    group('ResetEngagement', () {
      blocTest<EarnBloc, EarnState>(
        'resets engagement state',
        build: () => EarnBloc(mockEarnRepository),
        seed: () => EarnState(
          currentEngagement: TestData.inProgressEngagement,
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
    });
  });
}
