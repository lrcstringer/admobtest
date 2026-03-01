import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/data/datasources/remote/token_pool_remote_datasource.dart';
import 'package:imalichat/data/models/token_pool_model.dart';
import 'package:imalichat/data/repositories/token_pool_repository_impl.dart';
import 'package:imalichat/domain/enums/pool_mode.dart';
import 'package:imalichat/domain/enums/gift_style.dart';

class MockTokenPoolRemoteDataSource extends Mock
    implements TokenPoolRemoteDataSource {}

TokenPoolModel _createPoolModel({String id = 'pool_1'}) {
  return TokenPoolModel(
    id: id,
    mode: 'sasaza',
    status: 'collecting',
    organizerId: 'user123',
    organizerName: 'Organizer',
    conversationId: 'conv_1',
    title: 'Test Pool',
    style: 'celebration',
    totalAmount: 5000,
    createdAt: DateTime(2024, 6, 1),
    updatedAt: DateTime(2024, 6, 1),
    groupAccountId: 'group:pool_1',
  );
}

void main() {
  late MockTokenPoolRemoteDataSource mockDataSource;
  late TokenPoolRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockTokenPoolRemoteDataSource();
    repository = TokenPoolRepositoryImpl(mockDataSource);
  });

  // Register fallback values
  setUpAll(() {
    registerFallbackValue(PoolMode.sasaza);
    registerFallbackValue(GiftStyle.celebration);
  });

  group('TokenPoolRepositoryImpl', () {
    // ── createPool ──────────────────────────────────────────────────

    group('createPool', () {
      test('returns Right(entity) when datasource returns model', () async {
        when(() => mockDataSource.createPool(
              mode: any(named: 'mode'),
              title: any(named: 'title'),
              message: any(named: 'message'),
              style: any(named: 'style'),
              recipientId: any(named: 'recipientId'),
              inviteeIds: any(named: 'inviteeIds'),
            )).thenAnswer((_) async => _createPoolModel());

        final result = await repository.createPool(
          mode: PoolMode.sasaza,
          title: 'Test',
          message: 'msg',
          style: GiftStyle.celebration,
          inviteeIds: ['u1'],
        );

        expect(result.isRight(), isTrue);
        result.fold((_) {}, (pool) => expect(pool.id, 'pool_1'));
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.createPool(
              mode: any(named: 'mode'),
              title: any(named: 'title'),
              message: any(named: 'message'),
              style: any(named: 'style'),
              recipientId: any(named: 'recipientId'),
              inviteeIds: any(named: 'inviteeIds'),
            )).thenThrow(const AuthException(message: 'Not authenticated'));

        final result = await repository.createPool(
          mode: PoolMode.sasaza,
          title: 'Test',
          message: 'msg',
          style: GiftStyle.celebration,
          inviteeIds: ['u1'],
        );

        expect(result, const Left(Failure.unauthenticated()));
      });

      test('returns Left(serverError) on ServerException', () async {
        when(() => mockDataSource.createPool(
              mode: any(named: 'mode'),
              title: any(named: 'title'),
              message: any(named: 'message'),
              style: any(named: 'style'),
              recipientId: any(named: 'recipientId'),
              inviteeIds: any(named: 'inviteeIds'),
            )).thenThrow(const ServerException(message: 'Server error'));

        final result = await repository.createPool(
          mode: PoolMode.sasaza,
          title: 'Test',
          message: 'msg',
          style: GiftStyle.celebration,
          inviteeIds: ['u1'],
        );

        expect(result.isLeft(), isTrue);
      });

      test('returns Left(serverError) on generic exception', () async {
        when(() => mockDataSource.createPool(
              mode: any(named: 'mode'),
              title: any(named: 'title'),
              message: any(named: 'message'),
              style: any(named: 'style'),
              recipientId: any(named: 'recipientId'),
              inviteeIds: any(named: 'inviteeIds'),
            )).thenThrow(Exception('Unexpected'));

        final result = await repository.createPool(
          mode: PoolMode.sasaza,
          title: 'Test',
          message: 'msg',
          style: GiftStyle.celebration,
          inviteeIds: ['u1'],
        );

        expect(result.isLeft(), isTrue);
      });
    });

    // ── contribute ──────────────────────────────────────────────────

    group('contribute', () {
      test('returns Right(entity) on success', () async {
        when(() => mockDataSource.contribute(
              poolId: any(named: 'poolId'),
              amount: any(named: 'amount'),
              anonymous: any(named: 'anonymous'),
            )).thenAnswer((_) async => _createPoolModel());

        final result = await repository.contribute(
          poolId: 'p1',
          amount: 100,
          anonymous: false,
        );

        expect(result.isRight(), isTrue);
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.contribute(
              poolId: any(named: 'poolId'),
              amount: any(named: 'amount'),
              anonymous: any(named: 'anonymous'),
            )).thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.contribute(
          poolId: 'p1',
          amount: 100,
          anonymous: false,
        );

        expect(result, const Left(Failure.unauthenticated()));
      });

      test('returns Left(serverError) on ServerException', () async {
        when(() => mockDataSource.contribute(
              poolId: any(named: 'poolId'),
              amount: any(named: 'amount'),
              anonymous: any(named: 'anonymous'),
            )).thenThrow(const ServerException(message: 'Balance low'));

        final result = await repository.contribute(
          poolId: 'p1',
          amount: 100,
          anonymous: false,
        );

        expect(result.isLeft(), isTrue);
      });
    });

    // ── sendGroupGift ───────────────────────────────────────────────

    group('sendGroupGift', () {
      test('returns Right(entity) on success', () async {
        when(() => mockDataSource.sendGroupGift(any()))
            .thenAnswer((_) async => _createPoolModel());

        final result = await repository.sendGroupGift('p1');
        expect(result.isRight(), isTrue);
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.sendGroupGift(any()))
            .thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.sendGroupGift('p1');
        expect(result, const Left(Failure.unauthenticated()));
      });

      test('returns Left(serverError) on ServerException', () async {
        when(() => mockDataSource.sendGroupGift(any()))
            .thenThrow(const ServerException(message: 'Error'));

        final result = await repository.sendGroupGift('p1');
        expect(result.isLeft(), isTrue);
      });
    });

    // ── distributePool ──────────────────────────────────────────────

    group('distributePool', () {
      test('returns Right(entity) on success', () async {
        when(() => mockDataSource.distributePool(
              poolId: any(named: 'poolId'),
              payouts: any(named: 'payouts'),
            )).thenAnswer((_) async => _createPoolModel());

        final result = await repository.distributePool(
          poolId: 'p1',
          payouts: [{'userId': 'u1', 'amount': 5000}],
        );

        expect(result.isRight(), isTrue);
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.distributePool(
              poolId: any(named: 'poolId'),
              payouts: any(named: 'payouts'),
            )).thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.distributePool(
          poolId: 'p1',
          payouts: [{'userId': 'u1', 'amount': 5000}],
        );

        expect(result, const Left(Failure.unauthenticated()));
      });
    });

    // ── cancelPool ──────────────────────────────────────────────────

    group('cancelPool', () {
      test('returns Right(entity) on success', () async {
        when(() => mockDataSource.cancelPool(any()))
            .thenAnswer((_) async => _createPoolModel());

        final result = await repository.cancelPool('p1');
        expect(result.isRight(), isTrue);
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.cancelPool(any()))
            .thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.cancelPool('p1');
        expect(result, const Left(Failure.unauthenticated()));
      });
    });

    // ── openGroupGift ───────────────────────────────────────────────

    group('openGroupGift', () {
      test('returns Right(entity) on success', () async {
        when(() => mockDataSource.openGroupGift(any()))
            .thenAnswer((_) async => _createPoolModel());

        final result = await repository.openGroupGift('p1');
        expect(result.isRight(), isTrue);
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.openGroupGift(any()))
            .thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.openGroupGift('p1');
        expect(result, const Left(Failure.unauthenticated()));
      });
    });

    // ── claimGroupGift ──────────────────────────────────────────────

    group('claimGroupGift', () {
      test('returns Right(entity) on success', () async {
        when(() => mockDataSource.claimGroupGift(any()))
            .thenAnswer((_) async => _createPoolModel());

        final result = await repository.claimGroupGift('p1');
        expect(result.isRight(), isTrue);
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.claimGroupGift(any()))
            .thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.claimGroupGift('p1');
        expect(result, const Left(Failure.unauthenticated()));
      });
    });

    // ── getPool ─────────────────────────────────────────────────────

    group('getPool', () {
      test('returns Right(entity) when datasource returns model', () async {
        when(() => mockDataSource.getPool(any()))
            .thenAnswer((_) async => _createPoolModel());

        final result = await repository.getPool('p1');
        expect(result.isRight(), isTrue);
      });

      test('returns Left(serverError) when datasource returns null', () async {
        when(() => mockDataSource.getPool(any()))
            .thenAnswer((_) async => null);

        final result = await repository.getPool('missing');
        expect(result.isLeft(), isTrue);
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.getPool(any()))
            .thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.getPool('p1');
        expect(result, const Left(Failure.unauthenticated()));
      });
    });

    // ── getMyPools ──────────────────────────────────────────────────

    group('getMyPools', () {
      test('returns Right(list) when datasource returns models', () async {
        when(() => mockDataSource.getMyPools()).thenAnswer(
          (_) async => [_createPoolModel(id: 'p1'), _createPoolModel(id: 'p2')],
        );

        final result = await repository.getMyPools();
        expect(result.isRight(), isTrue);
        result.fold((_) {}, (pools) => expect(pools.length, 2));
      });

      test('returns Right(empty) when datasource returns empty', () async {
        when(() => mockDataSource.getMyPools())
            .thenAnswer((_) async => []);

        final result = await repository.getMyPools();
        expect(result.isRight(), isTrue);
        result.fold((_) {}, (pools) => expect(pools, isEmpty));
      });

      test('returns Left(unauthenticated) on AuthException', () async {
        when(() => mockDataSource.getMyPools())
            .thenThrow(const AuthException(message: 'Unauth'));

        final result = await repository.getMyPools();
        expect(result, const Left(Failure.unauthenticated()));
      });
    });

    // ── watchPool ───────────────────────────────────────────────────

    group('watchPool', () {
      test('emits Right(entity) for each model from datasource stream', () async {
        final controller = StreamController<TokenPoolModel>();
        when(() => mockDataSource.watchPool(any()))
            .thenAnswer((_) => controller.stream);

        final results = <Either>[];
        final sub = repository.watchPool('p1').listen(results.add);

        controller.add(_createPoolModel());
        controller.add(_createPoolModel(id: 'p2'));
        await Future.delayed(const Duration(milliseconds: 50));

        expect(results.length, 2);
        expect(results[0].isRight(), isTrue);
        expect(results[1].isRight(), isTrue);

        await sub.cancel();
        await controller.close();
      });

      test('emits Left(unauthenticated) when stream throws AuthException', () async {
        final controller = StreamController<TokenPoolModel>();
        when(() => mockDataSource.watchPool(any()))
            .thenAnswer((_) => controller.stream);

        final results = <Either>[];
        final sub = repository.watchPool('p1').listen(results.add);

        controller.addError(const AuthException(message: 'Unauth'));
        await Future.delayed(const Duration(milliseconds: 50));

        expect(results.length, 1);
        expect(results[0], const Left(Failure.unauthenticated()));

        await sub.cancel();
        await controller.close();
      });

      test('emits Left(serverError) when stream throws generic error', () async {
        final controller = StreamController<TokenPoolModel>();
        when(() => mockDataSource.watchPool(any()))
            .thenAnswer((_) => controller.stream);

        final results = <Either>[];
        final sub = repository.watchPool('p1').listen(results.add);

        controller.addError(Exception('Network error'));
        await Future.delayed(const Duration(milliseconds: 50));

        expect(results.length, 1);
        expect(results[0].isLeft(), isTrue);

        await sub.cancel();
        await controller.close();
      });
    });
  });
}
