import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/group_buy_repository.dart';
import 'package:imalichat/presentation/blocs/group_buy/group_buy_bloc.dart';

class MockGroupBuyRepository extends Mock implements GroupBuyRepository {}

void main() {
  late MockGroupBuyRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    mockRepository = MockGroupBuyRepository();
  });

  GroupBuyBloc buildBloc() => GroupBuyBloc(mockRepository);

  group('GroupBuyBloc', () {
    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state.isLoading, false);
      expect(bloc.state.activeGroupBuys, isEmpty);
      expect(bloc.state.myGroupBuys, isEmpty);
      expect(bloc.state.isCreating, false);
      expect(bloc.state.isJoining, false);
      bloc.close();
    });

    group('LoadActiveGroupBuys', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits [loading, loaded] when succeeds',
        build: () {
          when(() => mockRepository.getActiveGroupBuys(
            communityId: any(named: 'communityId'),
          )).thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadActiveGroupBuys()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoading, 'isLoading', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.activeGroupBuys, 'activeGroupBuys', isEmpty),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error when fails',
        build: () {
          when(() => mockRepository.getActiveGroupBuys(
            communityId: any(named: 'communityId'),
          )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadActiveGroupBuys()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoading, 'isLoading', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('LoadMyGroupBuys', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits [loading, loaded] when succeeds',
        build: () {
          when(() => mockRepository.getMyGroupBuys())
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadMyGroupBuys()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoading, 'isLoading', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.myGroupBuys, 'myGroupBuys', isEmpty),
        ],
      );
    });

    group('CreateGroupBuy', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent creates',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isCreating: true),
        act: (bloc) => bloc.add(GroupBuyEvent.createGroupBuy(
          title: 'Test',
          description: 'Desc',
          targetAmount: 1000,
          deadline: DateTime(2026, 4, 1),
        )),
        expect: () => [],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits success when create succeeds',
        build: () {
          when(() => mockRepository.createGroupBuy(
            title: any(named: 'title'),
            description: any(named: 'description'),
            targetAmount: any(named: 'targetAmount'),
            deadline: any(named: 'deadline'),
            linkedListingId: any(named: 'linkedListingId'),
            minParticipants: any(named: 'minParticipants'),
            maxParticipants: any(named: 'maxParticipants'),
          )).thenAnswer((_) async => const Right('gb1'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(GroupBuyEvent.createGroupBuy(
          title: 'Test',
          description: 'Desc',
          targetAmount: 1000,
          deadline: DateTime(2026, 4, 1),
        )),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCreating, 'isCreating', true),
          isA<GroupBuyState>()
              .having((s) => s.isCreating, 'isCreating', false)
              .having((s) => s.successId, 'successId', 'gb1')
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );
    });

    group('JoinGroupBuy', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent joins',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isJoining: true),
        act: (bloc) => bloc.add(const GroupBuyEvent.joinGroupBuy(
          groupBuyId: 'gb1',
          amount: 100,
          walletId: 'w1',
        )),
        expect: () => [],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits success when join succeeds',
        build: () {
          when(() => mockRepository.joinGroupBuy(
            groupBuyId: any(named: 'groupBuyId'),
            amount: any(named: 'amount'),
            walletId: any(named: 'walletId'),
          )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.joinGroupBuy(
          groupBuyId: 'gb1',
          amount: 100,
          walletId: 'w1',
        )),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isJoining, 'isJoining', true),
          isA<GroupBuyState>()
              .having((s) => s.isJoining, 'isJoining', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );
    });

    group('LeaveGroupBuy', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent leaves',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isLeaving: true),
        act: (bloc) => bloc.add(const GroupBuyEvent.leaveGroupBuy(groupBuyId: 'gb1')),
        expect: () => [],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits success with shouldPop when leave succeeds',
        build: () {
          when(() => mockRepository.leaveGroupBuy(
            groupBuyId: any(named: 'groupBuyId'),
          )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.leaveGroupBuy(groupBuyId: 'gb1')),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLeaving, 'isLeaving', true),
          isA<GroupBuyState>()
              .having((s) => s.isLeaving, 'isLeaving', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull)
              .having((s) => s.shouldPopOnSuccess, 'shouldPopOnSuccess', true),
        ],
      );
    });

    group('CompleteGroupBuy', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent completes',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isCompleting: true),
        act: (bloc) => bloc.add(const GroupBuyEvent.completeGroupBuy(groupBuyId: 'gb1')),
        expect: () => [],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits success and reloads on complete',
        build: () {
          when(() => mockRepository.completeGroupBuy(
            groupBuyId: any(named: 'groupBuyId'),
          )).thenAnswer((_) async => const Right(null));
          when(() => mockRepository.getGroupBuy(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          when(() => mockRepository.getContributions(any()))
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.completeGroupBuy(groupBuyId: 'gb1')),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCompleting, 'isCompleting', true),
          isA<GroupBuyState>()
              .having((s) => s.isCompleting, 'isCompleting', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
          // Reload triggered
          isA<GroupBuyState>().having((s) => s.isLoading, 'isLoading', true),
          isA<GroupBuyState>(),
        ],
      );
    });

    group('CancelGroupBuy', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent cancels',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isCancelling: true),
        act: (bloc) => bloc.add(const GroupBuyEvent.cancelGroupBuy(groupBuyId: 'gb1')),
        expect: () => [],
      );
    });

    group('SuggestDeal', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent suggestions',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isSuggestingDeal: true),
        act: (bloc) => bloc.add(const GroupBuyEvent.suggestDeal(
          description: 'Great deal',
          brandOrStore: 'TestStore',
        )),
        expect: () => [],
      );
    });

    group('ClearMessages', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'clears all messages and flags',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(
          errorMessage: 'err',
          successMessage: 'ok',
          successId: 'id',
          shouldPopOnSuccess: true,
        ),
        act: (bloc) => bloc.add(const GroupBuyEvent.clearMessages()),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull)
              .having((s) => s.successId, 'successId', isNull)
              .having((s) => s.shouldPopOnSuccess, 'shouldPopOnSuccess', false),
        ],
      );
    });
  });
}
