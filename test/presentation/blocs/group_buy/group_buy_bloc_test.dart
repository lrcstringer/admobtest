import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/group_buy.dart';
import 'package:imalichat/domain/entities/group_buy_contribution.dart';
import 'package:imalichat/domain/enums/group_buy_status.dart';
import 'package:imalichat/domain/repositories/group_buy_repository.dart';
import 'package:imalichat/presentation/blocs/group_buy/group_buy_bloc.dart';

class MockGroupBuyRepository extends Mock implements GroupBuyRepository {}

void main() {
  late MockGroupBuyRepository mockRepository;

  final tGroupBuy = GroupBuy(
    id: 'gb1',
    title: 'Test',
    description: 'A test group buy',
    organizerId: 'org1',
    targetAmount: 1000,
    currentAmount: 500,
    status: GroupBuyStatus.open,
    deadline: DateTime(2026, 6, 1),
    createdAt: DateTime(2026, 1, 1),
  );

  final tContribution = GroupBuyContribution(
    id: 'c1',
    userId: 'u1',
    userName: 'User One',
    amount: 100,
    contributedAt: DateTime(2026, 2, 1),
  );

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    mockRepository = MockGroupBuyRepository();
  });

  GroupBuyBloc buildBloc() => GroupBuyBloc(mockRepository);

  /// Stubs for the reload flow triggered after mutating operations.
  void stubReloadGroupBuy() {
    when(() => mockRepository.getGroupBuy(any()))
        .thenAnswer((_) async => Right(tGroupBuy));
    when(() => mockRepository.getContributions(any()))
        .thenAnswer((_) async => Right([tContribution]));
  }

  group('GroupBuyBloc', () {
    // ── Initial state ──────────────────────────────────────────────────

    test('initial state has all defaults', () {
      final bloc = buildBloc();
      expect(bloc.state, const GroupBuyState());
      expect(bloc.state.isLoading, false);
      expect(bloc.state.isLoadingList, false);
      expect(bloc.state.isLoadingDetail, false);
      expect(bloc.state.activeGroupBuys, isEmpty);
      expect(bloc.state.myGroupBuys, isEmpty);
      expect(bloc.state.hubGroupBuys, isEmpty);
      expect(bloc.state.selectedGroupBuy, isNull);
      expect(bloc.state.contributions, isEmpty);
      expect(bloc.state.isCreating, false);
      expect(bloc.state.isJoining, false);
      expect(bloc.state.isLeaving, false);
      expect(bloc.state.isSuggestingDeal, false);
      expect(bloc.state.isConfirmingCollection, false);
      expect(bloc.state.isCancelling, false);
      expect(bloc.state.isCompleting, false);
      expect(bloc.state.isUpdatingDelivery, false);
      expect(bloc.state.isExtendingDeadline, false);
      expect(bloc.state.successId, isNull);
      expect(bloc.state.successMessage, isNull);
      expect(bloc.state.shouldPopOnSuccess, false);
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    // ── LoadActiveGroupBuys ────────────────────────────────────────────

    group('LoadActiveGroupBuys', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits loading then loaded list on success',
        build: () {
          when(() => mockRepository.getActiveGroupBuys(
                communityId: any(named: 'communityId'),
              )).thenAnswer((_) async => Right([tGroupBuy]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadActiveGroupBuys()),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isLoadingList, 'isLoadingList', true)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingList, 'isLoadingList', false)
              .having((s) => s.activeGroupBuys, 'activeGroupBuys', [tGroupBuy]),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits loading then error on failure',
        build: () {
          when(() => mockRepository.getActiveGroupBuys(
                communityId: any(named: 'communityId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadActiveGroupBuys()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoadingList, 'isLoadingList', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingList, 'isLoadingList', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'passes communityId to repository',
        build: () {
          when(() => mockRepository.getActiveGroupBuys(
                communityId: any(named: 'communityId'),
              )).thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const GroupBuyEvent.loadActiveGroupBuys(communityId: 'comm1')),
        verify: (_) {
          verify(() => mockRepository.getActiveGroupBuys(communityId: 'comm1'))
              .called(1);
        },
      );
    });

    // ── LoadGroupBuy (parallel fetch) ──────────────────────────────────

    group('LoadGroupBuy', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'fetches groupBuy and contributions in parallel on success',
        build: () {
          when(() => mockRepository.getGroupBuy(any()))
              .thenAnswer((_) async => Right(tGroupBuy));
          when(() => mockRepository.getContributions(any()))
              .thenAnswer((_) async => Right([tContribution]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadGroupBuy('gb1')),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.selectedGroupBuy, 'selectedGroupBuy', tGroupBuy)
              .having(
                  (s) => s.contributions, 'contributions', [tContribution]),
        ],
        verify: (_) {
          verify(() => mockRepository.getGroupBuy('gb1')).called(1);
          verify(() => mockRepository.getContributions('gb1')).called(1);
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error when getGroupBuy fails (contributions ignored)',
        build: () {
          when(() => mockRepository.getGroupBuy(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          when(() => mockRepository.getContributions(any()))
              .thenAnswer((_) async => Right([tContribution]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadGroupBuy('gb1')),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull)
              .having((s) => s.selectedGroupBuy, 'selectedGroupBuy', isNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'falls back to empty contributions when getContributions fails',
        build: () {
          when(() => mockRepository.getGroupBuy(any()))
              .thenAnswer((_) async => Right(tGroupBuy));
          when(() => mockRepository.getContributions(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadGroupBuy('gb1')),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.selectedGroupBuy, 'selectedGroupBuy', tGroupBuy)
              .having((s) => s.contributions, 'contributions', isEmpty),
        ],
      );
    });

    // ── LoadMyGroupBuys ────────────────────────────────────────────────

    group('LoadMyGroupBuys', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits loading then loaded on success',
        build: () {
          when(() => mockRepository.getMyGroupBuys())
              .thenAnswer((_) async => Right([tGroupBuy]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadMyGroupBuys()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoadingList, 'isLoadingList', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingList, 'isLoadingList', false)
              .having((s) => s.myGroupBuys, 'myGroupBuys', [tGroupBuy]),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure',
        build: () {
          when(() => mockRepository.getMyGroupBuys())
              .thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadMyGroupBuys()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoadingList, 'isLoadingList', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingList, 'isLoadingList', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── LoadHubGroupBuys ───────────────────────────────────────────────

    group('LoadHubGroupBuys', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits loading then populated hubGroupBuys on success',
        build: () {
          when(() => mockRepository.getHubGroupBuys(
                userClusters: any(named: 'userClusters'),
              )).thenAnswer((_) async => Right([tGroupBuy]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(
            const GroupBuyEvent.loadHubGroupBuys(userClusters: ['jhb', 'cpt'])),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoadingList, 'isLoadingList', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingList, 'isLoadingList', false)
              .having((s) => s.hubGroupBuys, 'hubGroupBuys', [tGroupBuy]),
        ],
        verify: (_) {
          verify(() => mockRepository.getHubGroupBuys(
                userClusters: ['jhb', 'cpt'],
              )).called(1);
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure',
        build: () {
          when(() => mockRepository.getHubGroupBuys(
                userClusters: any(named: 'userClusters'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const GroupBuyEvent.loadHubGroupBuys()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLoadingList, 'isLoadingList', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingList, 'isLoadingList', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── CreateGroupBuy ─────────────────────────────────────────────────

    group('CreateGroupBuy', () {
      GroupBuyEvent createEvent() => GroupBuyEvent.createGroupBuy(
            title: 'Test',
            description: 'Desc',
            targetAmount: 1000,
            deadline: DateTime(2026, 4, 1),
          );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits creating then success with id',
        build: () {
          when(() => mockRepository.createGroupBuy(
                title: any(named: 'title'),
                description: any(named: 'description'),
                targetAmount: any(named: 'targetAmount'),
                deadline: any(named: 'deadline'),
                linkedListingId: any(named: 'linkedListingId'),
                minParticipants: any(named: 'minParticipants'),
                maxParticipants: any(named: 'maxParticipants'),
                imageUrl: any(named: 'imageUrl'),
                pricePerPerson: any(named: 'pricePerPerson'),
              )).thenAnswer((_) async => const Right('gb1'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(createEvent()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCreating, 'isCreating', true),
          isA<GroupBuyState>()
              .having((s) => s.isCreating, 'isCreating', false)
              .having((s) => s.successId, 'successId', 'gb1')
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure',
        build: () {
          when(() => mockRepository.createGroupBuy(
                title: any(named: 'title'),
                description: any(named: 'description'),
                targetAmount: any(named: 'targetAmount'),
                deadline: any(named: 'deadline'),
                linkedListingId: any(named: 'linkedListingId'),
                minParticipants: any(named: 'minParticipants'),
                maxParticipants: any(named: 'maxParticipants'),
                imageUrl: any(named: 'imageUrl'),
                pricePerPerson: any(named: 'pricePerPerson'),
              )).thenAnswer(
              (_) async => const Left(Failure.serverError(message: 'fail')));
          return buildBloc();
        },
        act: (bloc) => bloc.add(createEvent()),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCreating, 'isCreating', true),
          isA<GroupBuyState>()
              .having((s) => s.isCreating, 'isCreating', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent creates',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isCreating: true),
        act: (bloc) => bloc.add(createEvent()),
        expect: () => [],
      );
    });

    // ── JoinGroupBuy ───────────────────────────────────────────────────

    group('JoinGroupBuy', () {
      const joinEvent = GroupBuyEvent.joinGroupBuy(
        groupBuyId: 'gb1',
        amount: 100,
        walletId: 'w1',
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits joining then success',
        build: () {
          when(() => mockRepository.joinGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
                amount: any(named: 'amount'),
                walletId: any(named: 'walletId'),
                deliveryAddress: any(named: 'deliveryAddress'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(joinEvent),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isJoining, 'isJoining', true),
          isA<GroupBuyState>()
              .having((s) => s.isJoining, 'isJoining', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure',
        build: () {
          when(() => mockRepository.joinGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
                amount: any(named: 'amount'),
                walletId: any(named: 'walletId'),
                deliveryAddress: any(named: 'deliveryAddress'),
              )).thenAnswer(
              (_) async => const Left(Failure.insufficientBalance()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(joinEvent),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isJoining, 'isJoining', true),
          isA<GroupBuyState>()
              .having((s) => s.isJoining, 'isJoining', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent joins',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isJoining: true),
        act: (bloc) => bloc.add(joinEvent),
        expect: () => [],
      );
    });

    // ── LeaveGroupBuy ──────────────────────────────────────────────────

    group('LeaveGroupBuy', () {
      const leaveEvent = GroupBuyEvent.leaveGroupBuy(groupBuyId: 'gb1');

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits success with shouldPopOnSuccess on success',
        build: () {
          when(() => mockRepository.leaveGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(leaveEvent),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLeaving, 'isLeaving', true),
          isA<GroupBuyState>()
              .having((s) => s.isLeaving, 'isLeaving', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull)
              .having((s) => s.shouldPopOnSuccess, 'shouldPopOnSuccess', true),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure',
        build: () {
          when(() => mockRepository.leaveGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
              )).thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(leaveEvent),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isLeaving, 'isLeaving', true),
          isA<GroupBuyState>()
              .having((s) => s.isLeaving, 'isLeaving', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent leaves',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isLeaving: true),
        act: (bloc) => bloc.add(leaveEvent),
        expect: () => [],
      );
    });

    // ── SuggestDeal ────────────────────────────────────────────────────

    group('SuggestDeal', () {
      const suggestEvent = GroupBuyEvent.suggestDeal(
        description: 'Great deal',
        brandOrStore: 'TestStore',
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits suggesting then success with id',
        build: () {
          when(() => mockRepository.suggestGroupBuyDeal(
                description: any(named: 'description'),
                brandOrStore: any(named: 'brandOrStore'),
                estimatedPrice: any(named: 'estimatedPrice'),
                sourceUrl: any(named: 'sourceUrl'),
                imageUrl: any(named: 'imageUrl'),
                wantsToJoin: any(named: 'wantsToJoin'),
              )).thenAnswer((_) async => const Right('req1'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(suggestEvent),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isSuggestingDeal, 'isSuggestingDeal', true),
          isA<GroupBuyState>()
              .having((s) => s.isSuggestingDeal, 'isSuggestingDeal', false)
              .having((s) => s.successId, 'successId', 'req1')
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure',
        build: () {
          when(() => mockRepository.suggestGroupBuyDeal(
                description: any(named: 'description'),
                brandOrStore: any(named: 'brandOrStore'),
                estimatedPrice: any(named: 'estimatedPrice'),
                sourceUrl: any(named: 'sourceUrl'),
                imageUrl: any(named: 'imageUrl'),
                wantsToJoin: any(named: 'wantsToJoin'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(suggestEvent),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isSuggestingDeal, 'isSuggestingDeal', true),
          isA<GroupBuyState>()
              .having((s) => s.isSuggestingDeal, 'isSuggestingDeal', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent suggestions',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isSuggestingDeal: true),
        act: (bloc) => bloc.add(suggestEvent),
        expect: () => [],
      );
    });

    // ── ConfirmCollection ──────────────────────────────────────────────

    group('ConfirmCollection', () {
      const confirmEvent = GroupBuyEvent.confirmCollection(
        groupBuyId: 'gb1',
        contributionId: 'c1',
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits confirming then success and triggers reload',
        build: () {
          when(() => mockRepository.confirmCollection(
                groupBuyId: any(named: 'groupBuyId'),
                contributionId: any(named: 'contributionId'),
              )).thenAnswer((_) async => const Right(null));
          stubReloadGroupBuy();
          return buildBloc();
        },
        act: (bloc) => bloc.add(confirmEvent),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<GroupBuyState>().having(
              (s) => s.isConfirmingCollection, 'isConfirmingCollection', true),
          isA<GroupBuyState>()
              .having((s) => s.isConfirmingCollection,
                  'isConfirmingCollection', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
          // Reload triggered: loadGroupBuy
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.selectedGroupBuy, 'selectedGroupBuy', tGroupBuy),
        ],
        verify: (_) {
          verify(() => mockRepository.getGroupBuy('gb1')).called(1);
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure without triggering reload',
        build: () {
          when(() => mockRepository.confirmCollection(
                groupBuyId: any(named: 'groupBuyId'),
                contributionId: any(named: 'contributionId'),
              )).thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(confirmEvent),
        expect: () => [
          isA<GroupBuyState>().having(
              (s) => s.isConfirmingCollection, 'isConfirmingCollection', true),
          isA<GroupBuyState>()
              .having((s) => s.isConfirmingCollection,
                  'isConfirmingCollection', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getGroupBuy(any()));
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent confirms',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isConfirmingCollection: true),
        act: (bloc) => bloc.add(confirmEvent),
        expect: () => [],
      );
    });

    // ── CancelGroupBuy ─────────────────────────────────────────────────

    group('CancelGroupBuy', () {
      const cancelEvent = GroupBuyEvent.cancelGroupBuy(
        groupBuyId: 'gb1',
        reason: 'not enough interest',
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits cancelling then success',
        build: () {
          when(() => mockRepository.cancelGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
                reason: any(named: 'reason'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(cancelEvent),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCancelling, 'isCancelling', true),
          isA<GroupBuyState>()
              .having((s) => s.isCancelling, 'isCancelling', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure',
        build: () {
          when(() => mockRepository.cancelGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
                reason: any(named: 'reason'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(cancelEvent),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCancelling, 'isCancelling', true),
          isA<GroupBuyState>()
              .having((s) => s.isCancelling, 'isCancelling', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent cancels',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isCancelling: true),
        act: (bloc) => bloc.add(cancelEvent),
        expect: () => [],
      );
    });

    // ── CompleteGroupBuy ───────────────────────────────────────────────

    group('CompleteGroupBuy', () {
      const completeEvent = GroupBuyEvent.completeGroupBuy(groupBuyId: 'gb1');

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits completing then success and triggers reload',
        build: () {
          when(() => mockRepository.completeGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
              )).thenAnswer((_) async => const Right(null));
          stubReloadGroupBuy();
          return buildBloc();
        },
        act: (bloc) => bloc.add(completeEvent),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCompleting, 'isCompleting', true),
          isA<GroupBuyState>()
              .having((s) => s.isCompleting, 'isCompleting', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
          // Reload triggered
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.selectedGroupBuy, 'selectedGroupBuy', tGroupBuy),
        ],
        verify: (_) {
          verify(() => mockRepository.getGroupBuy('gb1')).called(1);
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure without triggering reload',
        build: () {
          when(() => mockRepository.completeGroupBuy(
                groupBuyId: any(named: 'groupBuyId'),
              )).thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(completeEvent),
        expect: () => [
          isA<GroupBuyState>().having((s) => s.isCompleting, 'isCompleting', true),
          isA<GroupBuyState>()
              .having((s) => s.isCompleting, 'isCompleting', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getGroupBuy(any()));
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent completes',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isCompleting: true),
        act: (bloc) => bloc.add(completeEvent),
        expect: () => [],
      );
    });

    // ── UpdateDeliveryStatus ───────────────────────────────────────────

    group('UpdateDeliveryStatus', () {
      const updateEvent = GroupBuyEvent.updateDeliveryStatus(
        groupBuyId: 'gb1',
        deliveryStatus: 'shipped',
        trackingInfo: 'TRACK-123',
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits updating then success and triggers reload',
        build: () {
          when(() => mockRepository.updateDeliveryStatus(
                groupBuyId: any(named: 'groupBuyId'),
                deliveryStatus: any(named: 'deliveryStatus'),
                trackingInfo: any(named: 'trackingInfo'),
              )).thenAnswer((_) async => const Right(null));
          stubReloadGroupBuy();
          return buildBloc();
        },
        act: (bloc) => bloc.add(updateEvent),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isUpdatingDelivery, 'isUpdatingDelivery', true),
          isA<GroupBuyState>()
              .having((s) => s.isUpdatingDelivery, 'isUpdatingDelivery', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
          // Reload triggered
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.selectedGroupBuy, 'selectedGroupBuy', tGroupBuy),
        ],
        verify: (_) {
          verify(() => mockRepository.getGroupBuy('gb1')).called(1);
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure without triggering reload',
        build: () {
          when(() => mockRepository.updateDeliveryStatus(
                groupBuyId: any(named: 'groupBuyId'),
                deliveryStatus: any(named: 'deliveryStatus'),
                trackingInfo: any(named: 'trackingInfo'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(updateEvent),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isUpdatingDelivery, 'isUpdatingDelivery', true),
          isA<GroupBuyState>()
              .having((s) => s.isUpdatingDelivery, 'isUpdatingDelivery', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getGroupBuy(any()));
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent delivery updates',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isUpdatingDelivery: true),
        act: (bloc) => bloc.add(updateEvent),
        expect: () => [],
      );
    });

    // ── ExtendDeadline ─────────────────────────────────────────────────

    group('ExtendDeadline', () {
      final extendEvent = GroupBuyEvent.extendDeadline(
        groupBuyId: 'gb1',
        newDeadline: DateTime(2026, 7, 1),
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits extending then success and triggers reload',
        build: () {
          when(() => mockRepository.extendDeadline(
                groupBuyId: any(named: 'groupBuyId'),
                newDeadline: any(named: 'newDeadline'),
              )).thenAnswer((_) async => const Right(null));
          stubReloadGroupBuy();
          return buildBloc();
        },
        act: (bloc) => bloc.add(extendEvent),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isExtendingDeadline, 'isExtendingDeadline', true),
          isA<GroupBuyState>()
              .having((s) => s.isExtendingDeadline, 'isExtendingDeadline', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
          // Reload triggered
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<GroupBuyState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.selectedGroupBuy, 'selectedGroupBuy', tGroupBuy),
        ],
        verify: (_) {
          verify(() => mockRepository.getGroupBuy('gb1')).called(1);
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'emits error on failure without triggering reload',
        build: () {
          when(() => mockRepository.extendDeadline(
                groupBuyId: any(named: 'groupBuyId'),
                newDeadline: any(named: 'newDeadline'),
              )).thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(extendEvent),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.isExtendingDeadline, 'isExtendingDeadline', true),
          isA<GroupBuyState>()
              .having((s) => s.isExtendingDeadline, 'isExtendingDeadline', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getGroupBuy(any()));
        },
      );

      blocTest<GroupBuyBloc, GroupBuyState>(
        'double-submit guard prevents concurrent deadline extensions',
        build: () => buildBloc(),
        seed: () => const GroupBuyState(isExtendingDeadline: true),
        act: (bloc) => bloc.add(extendEvent),
        expect: () => [],
      );
    });

    // ── ClearMessages ──────────────────────────────────────────────────

    group('ClearMessages', () {
      blocTest<GroupBuyBloc, GroupBuyState>(
        'clears all transient messages and flags',
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

      blocTest<GroupBuyBloc, GroupBuyState>(
        'preserves non-transient state when clearing messages',
        build: () => buildBloc(),
        seed: () => GroupBuyState(
          activeGroupBuys: [tGroupBuy],
          myGroupBuys: [tGroupBuy],
          selectedGroupBuy: tGroupBuy,
          errorMessage: 'err',
          successMessage: 'ok',
        ),
        act: (bloc) => bloc.add(const GroupBuyEvent.clearMessages()),
        expect: () => [
          isA<GroupBuyState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull)
              .having((s) => s.activeGroupBuys, 'activeGroupBuys', [tGroupBuy])
              .having((s) => s.myGroupBuys, 'myGroupBuys', [tGroupBuy])
              .having(
                  (s) => s.selectedGroupBuy, 'selectedGroupBuy', tGroupBuy),
        ],
      );
    });

    // ── isLoading getter ───────────────────────────────────────────────

    group('isLoading getter', () {
      test('returns true when isLoadingList is true', () {
        const state = GroupBuyState(isLoadingList: true);
        expect(state.isLoading, true);
      });

      test('returns true when isLoadingDetail is true', () {
        const state = GroupBuyState(isLoadingDetail: true);
        expect(state.isLoading, true);
      });

      test('returns true when both are true', () {
        const state = GroupBuyState(isLoadingList: true, isLoadingDetail: true);
        expect(state.isLoading, true);
      });

      test('returns false when neither is true', () {
        const state = GroupBuyState();
        expect(state.isLoading, false);
      });
    });
  });
}
