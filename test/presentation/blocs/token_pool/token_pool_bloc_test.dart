import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/enums/pool_mode.dart';
import 'package:imalichat/domain/enums/gift_style.dart';
import 'package:imalichat/domain/repositories/token_pool_repository.dart';
import 'package:imalichat/presentation/blocs/token_pool/token_pool_bloc.dart';

import '../../../helpers/test_helpers.dart';

class MockTokenPoolRepository extends Mock implements TokenPoolRepository {}

void main() {
  late MockTokenPoolRepository mockRepo;

  setUp(() {
    mockRepo = MockTokenPoolRepository();
  });

  setUpAll(() {
    registerFallbackValue(PoolMode.sasaza);
    registerFallbackValue(GiftStyle.celebration);
  });

  final testPool = TestData.collectingSasazaPool;
  final sentPool = TestData.sentSasazaPool;
  final cancelledPool = TestData.cancelledPool;

  group('TokenPoolBloc', () {
    // ── Initial state ─────────────────────────────────────────────────

    test('initial state is correct', () {
      final bloc = TokenPoolBloc(mockRepo);
      expect(bloc.state.myPools, isEmpty);
      expect(bloc.state.activePool, isNull);
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.isCreating, isFalse);
      expect(bloc.state.isContributing, isFalse);
      expect(bloc.state.isSending, isFalse);
      expect(bloc.state.isDistributing, isFalse);
      expect(bloc.state.isCancelling, isFalse);
      expect(bloc.state.isClaiming, isFalse);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.successMessage, isNull);
      bloc.close();
    });

    // ── createPool ──────────────────────────────────────────────────

    group('createPool', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isCreating then activePool on success',
        build: () {
          when(() => mockRepo.createPool(
                mode: any(named: 'mode'),
                title: any(named: 'title'),
                message: any(named: 'message'),
                style: any(named: 'style'),
                recipientId: any(named: 'recipientId'),
                inviteeIds: any(named: 'inviteeIds'),
              )).thenAnswer((_) async => Right(testPool));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(TokenPoolEvent.createPool(
          mode: PoolMode.sasaza,
          title: 'Test',
          message: 'msg',
          style: GiftStyle.celebration,
          inviteeIds: const ['u1'],
        )),
        expect: () => [
          isA<TokenPoolState>()
              .having((s) => s.isCreating, 'isCreating', true)
              .having((s) => s.activePool, 'activePool', isNull),
          isA<TokenPoolState>()
              .having((s) => s.isCreating, 'isCreating', false)
              .having((s) => s.activePool, 'activePool', testPool)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isCreating then errorMessage on failure',
        build: () {
          when(() => mockRepo.createPool(
                mode: any(named: 'mode'),
                title: any(named: 'title'),
                message: any(named: 'message'),
                style: any(named: 'style'),
                recipientId: any(named: 'recipientId'),
                inviteeIds: any(named: 'inviteeIds'),
              )).thenAnswer((_) async =>
              const Left(Failure.serverError(message: 'Budget exceeded')));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(TokenPoolEvent.createPool(
          mode: PoolMode.sasaza,
          title: 'Test',
          message: 'msg',
          style: GiftStyle.celebration,
          inviteeIds: const ['u1'],
        )),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isCreating, 'isCreating', true),
          isA<TokenPoolState>()
              .having((s) => s.isCreating, 'isCreating', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'guard prevents duplicate createPool when already creating',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(isCreating: true),
        act: (bloc) => bloc.add(TokenPoolEvent.createPool(
          mode: PoolMode.sasaza,
          title: 'Test',
          message: 'msg',
          style: GiftStyle.celebration,
          inviteeIds: const ['u1'],
        )),
        expect: () => [],
      );
    });

    // ── contribute ──────────────────────────────────────────────────

    group('contribute', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isContributing then success on success',
        build: () {
          when(() => mockRepo.contribute(
                poolId: any(named: 'poolId'),
                amount: any(named: 'amount'),
                anonymous: any(named: 'anonymous'),
              )).thenAnswer((_) async => Right(testPool));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.contribute(
          poolId: 'p1',
          amount: 500,
          anonymous: false,
        )),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isContributing, 'isContributing', true),
          isA<TokenPoolState>()
              .having((s) => s.isContributing, 'isContributing', false)
              .having((s) => s.activePool, 'activePool', testPool)
              .having((s) => s.successMessage, 'successMessage', 'Contributed 500 tokens!'),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isContributing then errorMessage on failure',
        build: () {
          when(() => mockRepo.contribute(
                poolId: any(named: 'poolId'),
                amount: any(named: 'amount'),
                anonymous: any(named: 'anonymous'),
              )).thenAnswer((_) async =>
              const Left(Failure.serverError(message: 'Insufficient balance')));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.contribute(
          poolId: 'p1',
          amount: 500,
          anonymous: false,
        )),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isContributing, 'isContributing', true),
          isA<TokenPoolState>()
              .having((s) => s.isContributing, 'isContributing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'guard prevents duplicate contribute when already contributing',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(isContributing: true),
        act: (bloc) => bloc.add(const TokenPoolEvent.contribute(
          poolId: 'p1',
          amount: 500,
          anonymous: false,
        )),
        expect: () => [],
      );
    });

    // ── sendGroupGift ───────────────────────────────────────────────

    group('sendGroupGift', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isSending then success on success',
        build: () {
          when(() => mockRepo.sendGroupGift(any()))
              .thenAnswer((_) async => Right(sentPool));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.sendGroupGift('p1')),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isSending, 'isSending', true),
          isA<TokenPoolState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.successMessage, 'successMessage', 'Group Sasaza sent!'),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isSending then errorMessage on failure',
        build: () {
          when(() => mockRepo.sendGroupGift(any()))
              .thenAnswer((_) async => const Left(Failure.serverError(message: 'Failed')));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.sendGroupGift('p1')),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isSending, 'isSending', true),
          isA<TokenPoolState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'guard prevents duplicate send when already sending',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(isSending: true),
        act: (bloc) => bloc.add(const TokenPoolEvent.sendGroupGift('p1')),
        expect: () => [],
      );
    });

    // ── distributePool ──────────────────────────────────────────────

    group('distributePool', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isDistributing then success on success',
        build: () {
          when(() => mockRepo.distributePool(
                poolId: any(named: 'poolId'),
                payouts: any(named: 'payouts'),
              )).thenAnswer((_) async => Right(testPool));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.distributePool(
          poolId: 'p1',
          payouts: [{'userId': 'u1', 'amount': 5000}],
        )),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isDistributing, 'isDistributing', true),
          isA<TokenPoolState>()
              .having((s) => s.isDistributing, 'isDistributing', false)
              .having((s) => s.successMessage, 'successMessage', 'Pool distributed!'),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'guard prevents duplicate distribute when already distributing',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(isDistributing: true),
        act: (bloc) => bloc.add(const TokenPoolEvent.distributePool(
          poolId: 'p1',
          payouts: [{'userId': 'u1', 'amount': 5000}],
        )),
        expect: () => [],
      );
    });

    // ── cancelPool ──────────────────────────────────────────────────

    group('cancelPool', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isCancelling then success on success',
        build: () {
          when(() => mockRepo.cancelPool(any()))
              .thenAnswer((_) async => Right(cancelledPool));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.cancelPool('p1')),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isCancelling, 'isCancelling', true),
          isA<TokenPoolState>()
              .having((s) => s.isCancelling, 'isCancelling', false)
              .having((s) => s.successMessage, 'successMessage',
                  'Collection cancelled. Contributions refunded.'),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'guard prevents duplicate cancel when already cancelling',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(isCancelling: true),
        act: (bloc) => bloc.add(const TokenPoolEvent.cancelPool('p1')),
        expect: () => [],
      );
    });

    // ── openGroupGift ───────────────────────────────────────────────

    group('openGroupGift', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isLoading then activePool on success',
        build: () {
          when(() => mockRepo.openGroupGift(any()))
              .thenAnswer((_) async => Right(testPool));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.openGroupGift('p1')),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isLoading, 'isLoading', true),
          isA<TokenPoolState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.activePool, 'activePool', testPool),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isLoading then errorMessage on failure',
        build: () {
          when(() => mockRepo.openGroupGift(any()))
              .thenAnswer((_) async => const Left(Failure.serverError(message: 'Failed')));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.openGroupGift('p1')),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isLoading, 'isLoading', true),
          isA<TokenPoolState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'guard prevents duplicate open when already loading',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(isLoading: true),
        act: (bloc) => bloc.add(const TokenPoolEvent.openGroupGift('p1')),
        expect: () => [],
      );
    });

    // ── claimGroupGift ──────────────────────────────────────────────

    group('claimGroupGift', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isClaiming then success on success',
        build: () {
          when(() => mockRepo.claimGroupGift(any()))
              .thenAnswer((_) async => Right(testPool));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.claimGroupGift('p1')),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isClaiming, 'isClaiming', true),
          isA<TokenPoolState>()
              .having((s) => s.isClaiming, 'isClaiming', false)
              .having((s) => s.successMessage, 'successMessage', 'Group Sasaza claimed!'),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'guard prevents duplicate claim when already claiming',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(isClaiming: true),
        act: (bloc) => bloc.add(const TokenPoolEvent.claimGroupGift('p1')),
        expect: () => [],
      );
    });

    // ── watchPool ───────────────────────────────────────────────────

    group('watchPool', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'subscribes and emits poolUpdated events',
        build: () {
          when(() => mockRepo.watchPool(any())).thenAnswer((_) =>
              Stream.value(Right(testPool)));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.watchPool('p1')),
        wait: const Duration(milliseconds: 300),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.activePool, 'activePool', testPool),
        ],
      );
    });

    // ── poolUpdated ─────────────────────────────────────────────────

    group('poolUpdated', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits updated activePool',
        build: () => TokenPoolBloc(mockRepo),
        act: (bloc) => bloc.add(TokenPoolEvent.poolUpdated(testPool)),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.activePool, 'activePool', testPool),
        ],
      );
    });

    // ── loadMyPools ─────────────────────────────────────────────────

    group('loadMyPools', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isLoading then myPools on success',
        build: () {
          when(() => mockRepo.getMyPools())
              .thenAnswer((_) async => Right(TestData.tokenPoolList));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.loadMyPools()),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isLoading, 'isLoading', true),
          isA<TokenPoolState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.myPools.length, 'myPools.length', 3),
        ],
      );

      blocTest<TokenPoolBloc, TokenPoolState>(
        'emits isLoading then errorMessage on failure',
        build: () {
          when(() => mockRepo.getMyPools())
              .thenAnswer((_) async => const Left(Failure.unauthenticated()));
          return TokenPoolBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const TokenPoolEvent.loadMyPools()),
        expect: () => [
          isA<TokenPoolState>().having((s) => s.isLoading, 'isLoading', true),
          isA<TokenPoolState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── clearError ──────────────────────────────────────────────────

    group('clearError', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'clears errorMessage and successMessage',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => const TokenPoolState(
          errorMessage: 'oops',
          successMessage: 'yay',
        ),
        act: (bloc) => bloc.add(const TokenPoolEvent.clearError()),
        expect: () => [
          isA<TokenPoolState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull),
        ],
      );
    });

    // ── reset ───────────────────────────────────────────────────────

    group('reset', () {
      blocTest<TokenPoolBloc, TokenPoolState>(
        'clears activePool, errorMessage, and successMessage',
        build: () => TokenPoolBloc(mockRepo),
        seed: () => TokenPoolState(
          activePool: testPool,
          errorMessage: 'err',
          successMessage: 'ok',
        ),
        act: (bloc) => bloc.add(const TokenPoolEvent.reset()),
        expect: () => [
          isA<TokenPoolState>()
              .having((s) => s.activePool, 'activePool', isNull)
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull),
        ],
      );
    });

    // ── close ───────────────────────────────────────────────────────

    group('close', () {
      test('cancels subscription without errors', () async {
        when(() => mockRepo.watchPool(any())).thenAnswer((_) =>
            Stream.value(Right(testPool)));

        final bloc = TokenPoolBloc(mockRepo);
        bloc.add(const TokenPoolEvent.watchPool('p1'));
        await Future.delayed(const Duration(milliseconds: 100));
        await bloc.close();
        // No error means success
      });
    });
  });
}
