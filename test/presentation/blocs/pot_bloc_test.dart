import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/enums/pot_type.dart';
import 'package:imalichat/domain/repositories/gamification_repository.dart';
import 'package:imalichat/presentation/blocs/pot/pot_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockGamificationRepository extends Mock implements GamificationRepository {}

void main() {
  late MockGamificationRepository mockGamificationRepository;

  setUpAll(() {
    registerFallbackValue(PotType.daily);
  });

  setUp(() {
    mockGamificationRepository = MockGamificationRepository();
  });

  group('PotBloc', () {
    test('initial state is correct', () {
      final bloc = PotBloc(mockGamificationRepository);
      expect(bloc.state.dailyPot, isNull);
      expect(bloc.state.weeklyPot, isNull);
      expect(bloc.state.leaderboard, isEmpty);
      expect(bloc.state.selectedPotType, PotType.daily);
      bloc.close();
    });

    group('LoadDailyPot', () {
      blocTest<PotBloc, PotState>(
        'emits [loading, loaded] when getCurrentDailyPot succeeds',
        build: () {
          when(() => mockGamificationRepository.getCurrentDailyPot())
              .thenAnswer((_) async => Right(TestData.dailyPot));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.loadDailyPot()),
        expect: () => [
          isA<PotState>().having((s) => s.isLoadingDaily, 'isLoadingDaily', true),
          isA<PotState>()
              .having((s) => s.isLoadingDaily, 'isLoadingDaily', false)
              .having((s) => s.dailyPot, 'dailyPot', TestData.dailyPot),
        ],
      );

      blocTest<PotBloc, PotState>(
        'emits [loading, error] when getCurrentDailyPot fails',
        build: () {
          when(() => mockGamificationRepository.getCurrentDailyPot())
              .thenAnswer((_) async => const Left(Failure.network()));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.loadDailyPot()),
        expect: () => [
          isA<PotState>().having((s) => s.isLoadingDaily, 'isLoadingDaily', true),
          isA<PotState>()
              .having((s) => s.isLoadingDaily, 'isLoadingDaily', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('LoadWeeklyPot', () {
      blocTest<PotBloc, PotState>(
        'emits [loading, loaded] when getCurrentWeeklyPot succeeds',
        build: () {
          when(() => mockGamificationRepository.getCurrentWeeklyPot())
              .thenAnswer((_) async => Right(TestData.weeklyPot));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.loadWeeklyPot()),
        expect: () => [
          isA<PotState>().having((s) => s.isLoadingWeekly, 'isLoadingWeekly', true),
          isA<PotState>()
              .having((s) => s.isLoadingWeekly, 'isLoadingWeekly', false)
              .having((s) => s.weeklyPot, 'weeklyPot', TestData.weeklyPot),
        ],
      );
    });

    group('LoadLeaderboard', () {
      blocTest<PotBloc, PotState>(
        'loads daily leaderboard successfully',
        build: () {
          when(() => mockGamificationRepository.getDailyLeaderboard(limit: any(named: 'limit')))
              .thenAnswer((_) async => const Right([]));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.loadLeaderboard(type: PotType.daily)),
        expect: () => [
          isA<PotState>().having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', true),
          isA<PotState>()
              .having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', false)
              .having((s) => s.leaderboard, 'leaderboard', isEmpty),
        ],
      );

      blocTest<PotBloc, PotState>(
        'loads weekly leaderboard successfully',
        build: () {
          when(() => mockGamificationRepository.getWeeklyLeaderboard(limit: any(named: 'limit')))
              .thenAnswer((_) async => const Right([]));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.loadLeaderboard(type: PotType.weekly)),
        expect: () => [
          isA<PotState>().having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', true),
          isA<PotState>()
              .having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', false)
              .having((s) => s.leaderboard, 'leaderboard', isEmpty),
        ],
      );
    });

    group('DailyPotUpdated', () {
      blocTest<PotBloc, PotState>(
        'updates daily pot in state',
        build: () => PotBloc(mockGamificationRepository),
        act: (bloc) => bloc.add(PotEvent.dailyPotUpdated(TestData.dailyPot)),
        expect: () => [
          isA<PotState>().having((s) => s.dailyPot, 'dailyPot', TestData.dailyPot),
        ],
      );
    });

    group('WeeklyPotUpdated', () {
      blocTest<PotBloc, PotState>(
        'updates weekly pot in state',
        build: () => PotBloc(mockGamificationRepository),
        act: (bloc) => bloc.add(PotEvent.weeklyPotUpdated(TestData.weeklyPot)),
        expect: () => [
          isA<PotState>().having((s) => s.weeklyPot, 'weeklyPot', TestData.weeklyPot),
        ],
      );
    });

    group('CheckEligibility', () {
      blocTest<PotBloc, PotState>(
        'checks eligibility for both pot types',
        build: () {
          when(() => mockGamificationRepository.isEligibleForPot(PotType.daily))
              .thenAnswer((_) async => const Right(true));
          when(() => mockGamificationRepository.isEligibleForPot(PotType.weekly))
              .thenAnswer((_) async => const Right(false));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.checkEligibility()),
        expect: () => [
          isA<PotState>()
              .having((s) => s.isDailyEligible, 'isDailyEligible', true)
              .having((s) => s.isWeeklyEligible, 'isWeeklyEligible', false),
        ],
      );
    });

    group('SelectPotType', () {
      blocTest<PotBloc, PotState>(
        'selects pot type and loads leaderboard and user score',
        build: () {
          when(() => mockGamificationRepository.getWeeklyLeaderboard(limit: any(named: 'limit')))
              .thenAnswer((_) async => const Right([]));
          when(() => mockGamificationRepository.getCurrentUserScore(PotType.weekly))
              .thenAnswer((_) async => Right(TestData.testUserScore));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.selectPotType(PotType.weekly)),
        expect: () => [
          isA<PotState>().having((s) => s.selectedPotType, 'selectedPotType', PotType.weekly),
          isA<PotState>().having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', true),
          isA<PotState>().having((s) => s.isLoadingLeaderboard, 'isLoadingLeaderboard', false),
          isA<PotState>().having((s) => s.currentUserScore, 'currentUserScore', TestData.testUserScore),
        ],
      );
    });

    group('LoadPotHistory', () {
      blocTest<PotBloc, PotState>(
        'loads pot history successfully',
        build: () {
          when(() => mockGamificationRepository.getPotHistory(
                type: any(named: 'type'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) async => const Right([]));
          return PotBloc(mockGamificationRepository);
        },
        act: (bloc) => bloc.add(const PotEvent.loadPotHistory(type: PotType.daily)),
        expect: () => [
          isA<PotState>().having((s) => s.isLoadingHistory, 'isLoadingHistory', true),
          isA<PotState>()
              .having((s) => s.isLoadingHistory, 'isLoadingHistory', false)
              .having((s) => s.potHistory, 'potHistory', isEmpty),
        ],
      );
    });

    group('ClearError', () {
      blocTest<PotBloc, PotState>(
        'clears error message',
        build: () => PotBloc(mockGamificationRepository),
        seed: () => const PotState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const PotEvent.clearError()),
        expect: () => [
          isA<PotState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });
  });
}
