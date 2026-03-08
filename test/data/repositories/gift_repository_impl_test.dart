import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/data/datasources/remote/gift_remote_datasource.dart';
import 'package:imalichat/data/models/gift_model.dart';
import 'package:imalichat/data/repositories/gift_repository_impl.dart';
import 'package:imalichat/domain/enums/gift_style.dart';

class MockGiftRemoteDataSource extends Mock implements GiftRemoteDataSource {}

void main() {
  late MockGiftRemoteDataSource mockDataSource;
  late GiftRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockGiftRemoteDataSource();
    repository = GiftRepositoryImpl(mockDataSource);
  });

  setUpAll(() {
    registerFallbackValue(GiftStyle.celebration);
  });

  // Helper to create a valid GiftModel
  GiftModel createModel({String id = 'gift_1'}) {
    return GiftModel(
      id: id,
      senderId: 'sender_1',
      senderName: 'Sender',
      recipientId: 'recipient_1',
      recipientName: 'Recipient',
      amount: 500,
      conversationId: 'conv_1',
      messageId: 'msg_1',
      message: 'Test',
      style: 'celebration',
      status: 'pending',
      createdAt: DateTime(2024, 6, 1),
      expiresAt: DateTime(2024, 6, 8),
    );
  }

  GiftStatsModel createStatsModel() {
    return const GiftStatsModel(
      totalSent: 5,
      totalReceived: 3,
      totalAmountSent: 2500,
      totalAmountReceived: 1500,
    );
  }

  // =========================================================================
  // SEND GIFT
  // =========================================================================

  group('sendGift', () {
    test('returns Right(Gift) on success', () async {
      when(() => mockDataSource.sendGift(
            recipientId: any(named: 'recipientId'),
            amount: any(named: 'amount'),
            message: any(named: 'message'),
            style: any(named: 'style'),
            conversationId: any(named: 'conversationId'),
            communityId: any(named: 'communityId'),
          )).thenAnswer((_) async => createModel());

      final result = await repository.sendGift(
        recipientId: 'recipient_1',
        amount: 500,
        message: 'Test',
        style: GiftStyle.celebration,
      );

      expect(result.isRight(), isTrue);
      result.fold((_) {}, (gift) => expect(gift.id, 'gift_1'));
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.sendGift(
            recipientId: any(named: 'recipientId'),
            amount: any(named: 'amount'),
            message: any(named: 'message'),
            style: any(named: 'style'),
            conversationId: any(named: 'conversationId'),
            communityId: any(named: 'communityId'),
          )).thenThrow(const AuthException(message: 'Not authenticated'));

      final result = await repository.sendGift(
        recipientId: 'recipient_1',
        amount: 500,
        message: 'Test',
        style: GiftStyle.celebration,
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockDataSource.sendGift(
            recipientId: any(named: 'recipientId'),
            amount: any(named: 'amount'),
            message: any(named: 'message'),
            style: any(named: 'style'),
            conversationId: any(named: 'conversationId'),
            communityId: any(named: 'communityId'),
          )).thenThrow(const ServerException(message: 'Server error'));

      final result = await repository.sendGift(
        recipientId: 'recipient_1',
        amount: 500,
        message: 'Test',
        style: GiftStyle.celebration,
      );

      expect(result.isLeft(), isTrue);
    });

    test('returns Left(serverError) on generic exception', () async {
      when(() => mockDataSource.sendGift(
            recipientId: any(named: 'recipientId'),
            amount: any(named: 'amount'),
            message: any(named: 'message'),
            style: any(named: 'style'),
            conversationId: any(named: 'conversationId'),
            communityId: any(named: 'communityId'),
          )).thenThrow(Exception('Unexpected'));

      final result = await repository.sendGift(
        recipientId: 'recipient_1',
        amount: 500,
        message: 'Test',
        style: GiftStyle.celebration,
      );

      expect(result.isLeft(), isTrue);
    });
  });

  // =========================================================================
  // OPEN GIFT
  // =========================================================================

  group('openGift', () {
    test('returns Right(Gift) on success', () async {
      when(() => mockDataSource.openGift(any()))
          .thenAnswer((_) async => createModel());

      final result = await repository.openGift('gift_1');

      expect(result.isRight(), isTrue);
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.openGift(any()))
          .thenThrow(const AuthException(message: 'Not authenticated'));

      final result = await repository.openGift('gift_1');

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockDataSource.openGift(any()))
          .thenThrow(const ServerException(message: 'Not found'));

      final result = await repository.openGift('gift_1');

      expect(result.isLeft(), isTrue);
    });
  });

  // =========================================================================
  // CLAIM GIFT
  // =========================================================================

  group('claimGift', () {
    test('returns Right(Gift) on success', () async {
      when(() => mockDataSource.claimGift(any()))
          .thenAnswer((_) async => createModel());

      final result = await repository.claimGift('gift_1');

      expect(result.isRight(), isTrue);
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.claimGift(any()))
          .thenThrow(const AuthException(message: 'Not authenticated'));

      final result = await repository.claimGift('gift_1');

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockDataSource.claimGift(any()))
          .thenThrow(const ServerException(message: 'Failed'));

      final result = await repository.claimGift('gift_1');

      expect(result.isLeft(), isTrue);
    });
  });

  // =========================================================================
  // GET SENT GIFTS
  // =========================================================================

  group('getSentGifts', () {
    test('returns Right(List<Gift>) on success', () async {
      when(() => mockDataSource.getSentGifts(limit: any(named: 'limit')))
          .thenAnswer((_) async => [createModel(), createModel(id: 'gift_2')]);

      final result = await repository.getSentGifts();

      expect(result.isRight(), isTrue);
      result.fold((_) {}, (gifts) => expect(gifts.length, 2));
    });

    test('returns empty list when no gifts', () async {
      when(() => mockDataSource.getSentGifts(limit: any(named: 'limit')))
          .thenAnswer((_) async => []);

      final result = await repository.getSentGifts();

      result.fold((_) {}, (gifts) => expect(gifts, isEmpty));
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.getSentGifts(limit: any(named: 'limit')))
          .thenThrow(const AuthException(message: 'Not authenticated'));

      final result = await repository.getSentGifts();

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // =========================================================================
  // GET RECEIVED GIFTS
  // =========================================================================

  group('getReceivedGifts', () {
    test('returns Right(List<Gift>) on success', () async {
      when(() => mockDataSource.getReceivedGifts(limit: any(named: 'limit')))
          .thenAnswer((_) async => [createModel()]);

      final result = await repository.getReceivedGifts();

      expect(result.isRight(), isTrue);
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockDataSource.getReceivedGifts(limit: any(named: 'limit')))
          .thenThrow(const ServerException(message: 'Error'));

      final result = await repository.getReceivedGifts();

      expect(result.isLeft(), isTrue);
    });
  });

  // =========================================================================
  // GET GIFT
  // =========================================================================

  group('getGift', () {
    test('returns Right(Gift) on success', () async {
      when(() => mockDataSource.getGift(any()))
          .thenAnswer((_) async => createModel());

      final result = await repository.getGift('gift_1');

      expect(result.isRight(), isTrue);
    });

    test('returns Left(serverError) when gift not found (null)', () async {
      when(() => mockDataSource.getGift(any()))
          .thenAnswer((_) async => null);

      final result = await repository.getGift('nonexistent');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (_) {},
      );
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.getGift(any()))
          .thenThrow(const AuthException(message: 'Not authenticated'));

      final result = await repository.getGift('gift_1');

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // =========================================================================
  // WATCH GIFT
  // =========================================================================

  group('watchGift', () {
    test('emits Right(Gift) on stream data', () async {
      when(() => mockDataSource.watchGift(any())).thenAnswer(
        (_) => Stream.value(createModel()),
      );

      final result = await repository.watchGift('gift_1').first;

      expect(result.isRight(), isTrue);
    });

    test('emits Left(unauthenticated) on AuthException in stream', () async {
      when(() => mockDataSource.watchGift(any())).thenAnswer(
        (_) => Stream<GiftModel>.error(
          const AuthException(message: 'Not authenticated'),
        ),
      );

      final result = await repository.watchGift('gift_1').first;

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('emits Left(serverError) on generic error in stream', () async {
      when(() => mockDataSource.watchGift(any())).thenAnswer(
        (_) => Stream<GiftModel>.error(Exception('Stream error')),
      );

      final result = await repository.watchGift('gift_1').first;

      expect(result.isLeft(), isTrue);
    });
  });

  // =========================================================================
  // GET GIFT STATS
  // =========================================================================

  group('getGiftStats', () {
    test('returns Right(GiftStats) on success', () async {
      when(() => mockDataSource.getGiftStats())
          .thenAnswer((_) async => createStatsModel());

      final result = await repository.getGiftStats();

      expect(result.isRight(), isTrue);
      result.fold((_) {}, (stats) {
        expect(stats.totalSent, 5);
        expect(stats.totalReceived, 3);
        expect(stats.totalAmountSent, 2500);
        expect(stats.totalAmountReceived, 1500);
      });
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.getGiftStats())
          .thenThrow(const AuthException(message: 'Not authenticated'));

      final result = await repository.getGiftStats();

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) on ServerException', () async {
      when(() => mockDataSource.getGiftStats())
          .thenThrow(const ServerException(message: 'Error'));

      final result = await repository.getGiftStats();

      expect(result.isLeft(), isTrue);
    });
  });
}
