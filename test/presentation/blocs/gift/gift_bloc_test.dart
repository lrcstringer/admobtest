import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/enums/gift_style.dart';
import 'package:imalichat/domain/repositories/gift_repository.dart';
import 'package:imalichat/presentation/blocs/gift/gift_bloc.dart';

import '../../../helpers/test_helpers.dart';

class MockGiftRepository extends Mock implements GiftRepository {}

void main() {
  late MockGiftRepository mockRepo;

  setUp(() {
    mockRepo = MockGiftRepository();
  });

  setUpAll(() {
    registerFallbackValue(GiftStyle.celebration);
  });

  final pendingGift = TestData.pendingGift;
  final openedGift = TestData.openedGift;
  final claimedGift = TestData.claimedGift;
  final testStats = TestData.testGiftStats;

  group('GiftBloc', () {
    // ── Initial state ─────────────────────────────────────────────────

    test('initial state is correct', () {
      final bloc = GiftBloc(mockRepo);
      expect(bloc.state.sentGifts, isEmpty);
      expect(bloc.state.receivedGifts, isEmpty);
      expect(bloc.state.activeGift, isNull);
      expect(bloc.state.stats, isNull);
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.isSending, isFalse);
      expect(bloc.state.isClaiming, isFalse);
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    // ── sendGift ──────────────────────────────────────────────────────

    group('sendGift', () {
      blocTest<GiftBloc, GiftState>(
        'emits isSending then activeGift on success',
        build: () {
          when(() => mockRepo.sendGift(
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
                style: any(named: 'style'),
                conversationId: any(named: 'conversationId'),
                communityId: any(named: 'communityId'),
              )).thenAnswer((_) async => Right(pendingGift));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(GiftEvent.sendGift(
          recipientId: 'recipient_1',
          amount: 500,
          message: 'Happy birthday!',
          style: GiftStyle.birthday,
        )),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.isSending, 'isSending', true)
              .having((s) => s.activeGift, 'activeGift', isNull)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<GiftState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.activeGift, 'activeGift', pendingGift),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'emits isSending then errorMessage on failure',
        build: () {
          when(() => mockRepo.sendGift(
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
                style: any(named: 'style'),
                conversationId: any(named: 'conversationId'),
                communityId: any(named: 'communityId'),
              )).thenAnswer(
            (_) async => const Left(Failure.insufficientBalance()),
          );
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(GiftEvent.sendGift(
          recipientId: 'recipient_1',
          amount: 500,
          message: 'Test',
          style: GiftStyle.celebration,
        )),
        expect: () => [
          isA<GiftState>().having((s) => s.isSending, 'isSending', true),
          isA<GiftState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'guards against duplicate sends when isSending is true',
        build: () => GiftBloc(mockRepo),
        seed: () => const GiftState(isSending: true),
        act: (bloc) => bloc.add(GiftEvent.sendGift(
          recipientId: 'r',
          amount: 100,
          message: 'x',
          style: GiftStyle.celebration,
        )),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRepo.sendGift(
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
                style: any(named: 'style'),
                conversationId: any(named: 'conversationId'),
                communityId: any(named: 'communityId'),
              ));
        },
      );
    });

    // ── openGift ─────────────────────────────────────────────────────

    group('openGift', () {
      blocTest<GiftBloc, GiftState>(
        'emits isLoading then activeGift on success',
        build: () {
          when(() => mockRepo.openGift(any()))
              .thenAnswer((_) async => Right(openedGift));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.openGift('gift_1')),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.activeGift, 'activeGift', isNull)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.activeGift, 'activeGift', openedGift),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'emits isLoading then errorMessage on failure',
        build: () {
          when(() => mockRepo.openGift(any()))
              .thenAnswer((_) async => const Left(Failure.unauthenticated()));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.openGift('gift_1')),
        expect: () => [
          isA<GiftState>().having((s) => s.isLoading, 'isLoading', true),
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'guards against duplicate opens when isLoading is true',
        build: () => GiftBloc(mockRepo),
        seed: () => const GiftState(isLoading: true),
        act: (bloc) => bloc.add(const GiftEvent.openGift('gift_1')),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRepo.openGift(any()));
        },
      );
    });

    // ── claimGift ────────────────────────────────────────────────────

    group('claimGift', () {
      blocTest<GiftBloc, GiftState>(
        'emits isClaiming then activeGift on success',
        build: () {
          when(() => mockRepo.claimGift(any()))
              .thenAnswer((_) async => Right(claimedGift));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.claimGift('gift_1')),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.isClaiming, 'isClaiming', true)
              .having((s) => s.activeGift, 'activeGift', isNull)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<GiftState>()
              .having((s) => s.isClaiming, 'isClaiming', false)
              .having((s) => s.activeGift, 'activeGift', claimedGift),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'emits isClaiming then errorMessage on failure',
        build: () {
          when(() => mockRepo.claimGift(any())).thenAnswer(
            (_) async => const Left(
              Failure.serverError(message: 'Failed to transfer tokens'),
            ),
          );
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.claimGift('gift_1')),
        expect: () => [
          isA<GiftState>().having((s) => s.isClaiming, 'isClaiming', true),
          isA<GiftState>()
              .having((s) => s.isClaiming, 'isClaiming', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'guards against duplicate claims when isClaiming is true',
        build: () => GiftBloc(mockRepo),
        seed: () => const GiftState(isClaiming: true),
        act: (bloc) => bloc.add(const GiftEvent.claimGift('gift_1')),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRepo.claimGift(any()));
        },
      );
    });

    // ── loadSentGifts ────────────────────────────────────────────────

    group('loadSentGifts', () {
      blocTest<GiftBloc, GiftState>(
        'emits isLoading then sentGifts on success',
        build: () {
          when(() => mockRepo.getSentGifts(limit: any(named: 'limit')))
              .thenAnswer((_) async => Right([pendingGift, openedGift]));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.loadSentGifts()),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.sentGifts.length, 'sentGifts.length', 2),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'emits isLoading then errorMessage on failure',
        build: () {
          when(() => mockRepo.getSentGifts(limit: any(named: 'limit')))
              .thenAnswer(
                  (_) async => const Left(Failure.unauthenticated()));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.loadSentGifts()),
        expect: () => [
          isA<GiftState>().having((s) => s.isLoading, 'isLoading', true),
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── loadReceivedGifts ────────────────────────────────────────────

    group('loadReceivedGifts', () {
      blocTest<GiftBloc, GiftState>(
        'emits isLoading then receivedGifts on success',
        build: () {
          when(() => mockRepo.getReceivedGifts(limit: any(named: 'limit')))
              .thenAnswer((_) async => Right([pendingGift]));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.loadReceivedGifts()),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having(
                  (s) => s.receivedGifts.length, 'receivedGifts.length', 1),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'emits isLoading then errorMessage on failure',
        build: () {
          when(() => mockRepo.getReceivedGifts(limit: any(named: 'limit')))
              .thenAnswer((_) async =>
                  const Left(Failure.serverError(message: 'Server error')));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.loadReceivedGifts()),
        expect: () => [
          isA<GiftState>().having((s) => s.isLoading, 'isLoading', true),
          isA<GiftState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── watchGift ────────────────────────────────────────────────────

    group('watchGift', () {
      blocTest<GiftBloc, GiftState>(
        'starts subscription and updates activeGift on stream data',
        build: () {
          when(() => mockRepo.watchGift(any())).thenAnswer(
            (_) => Stream.value(Right(openedGift)),
          );
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.watchGift('gift_1')),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.activeGift, 'activeGift', openedGift),
        ],
      );
    });

    // ── giftUpdated ──────────────────────────────────────────────────

    group('giftUpdated', () {
      blocTest<GiftBloc, GiftState>(
        'updates activeGift when IDs match',
        build: () => GiftBloc(mockRepo),
        seed: () => GiftState(activeGift: pendingGift),
        act: (bloc) => bloc.add(GiftEvent.giftUpdated(openedGift)),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.activeGift, 'activeGift', openedGift),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'updates activeGift when current activeGift is null',
        build: () => GiftBloc(mockRepo),
        act: (bloc) => bloc.add(GiftEvent.giftUpdated(pendingGift)),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.activeGift, 'activeGift', pendingGift),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'ignores update when activeGift ID does not match',
        build: () => GiftBloc(mockRepo),
        seed: () => GiftState(activeGift: pendingGift),
        act: (bloc) => bloc.add(GiftEvent.giftUpdated(
          pendingGift.copyWith(id: 'different_gift_id'),
        )),
        expect: () => [],
      );
    });

    // ── loadGiftStats ────────────────────────────────────────────────

    group('loadGiftStats', () {
      blocTest<GiftBloc, GiftState>(
        'emits stats on success',
        build: () {
          when(() => mockRepo.getGiftStats())
              .thenAnswer((_) async => Right(testStats));
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.loadGiftStats()),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.stats, 'stats', testStats),
        ],
      );

      blocTest<GiftBloc, GiftState>(
        'emits errorMessage on failure',
        build: () {
          when(() => mockRepo.getGiftStats()).thenAnswer(
            (_) async => const Left(Failure.unauthenticated()),
          );
          return GiftBloc(mockRepo);
        },
        act: (bloc) => bloc.add(const GiftEvent.loadGiftStats()),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ── clearError ───────────────────────────────────────────────────

    group('clearError', () {
      blocTest<GiftBloc, GiftState>(
        'clears errorMessage',
        build: () => GiftBloc(mockRepo),
        seed: () => const GiftState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const GiftEvent.clearError()),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    // ── reset ────────────────────────────────────────────────────────

    group('reset', () {
      blocTest<GiftBloc, GiftState>(
        'clears activeGift and errorMessage',
        build: () => GiftBloc(mockRepo),
        seed: () => GiftState(
          activeGift: pendingGift,
          errorMessage: 'Some error',
        ),
        act: (bloc) => bloc.add(const GiftEvent.reset()),
        expect: () => [
          isA<GiftState>()
              .having((s) => s.activeGift, 'activeGift', isNull)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    // ── close ────────────────────────────────────────────────────────

    test('cancels subscription on close', () async {
      when(() => mockRepo.watchGift(any())).thenAnswer(
        (_) => Stream.periodic(
          const Duration(milliseconds: 50),
          (_) => Right(pendingGift),
        ),
      );

      final bloc = GiftBloc(mockRepo);
      bloc.add(const GiftEvent.watchGift('gift_1'));
      await Future.delayed(const Duration(milliseconds: 100));
      await bloc.close();

      // After close, adding events should not cause issues
      // (subscription is cancelled, no further emissions)
    });
  });
}
