import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/step_up_auth_service.dart';
import 'package:imalichat/domain/repositories/marketplace_repository.dart';
import 'package:imalichat/presentation/blocs/order/order_bloc.dart';

class MockMarketplaceRepository extends Mock implements MarketplaceRepository {}
class MockStepUpAuthService extends Mock implements StepUpAuthService {}

void main() {
  late MockMarketplaceRepository mockRepository;
  late MockStepUpAuthService mockStepUpAuth;

  setUp(() {
    mockRepository = MockMarketplaceRepository();
    mockStepUpAuth = MockStepUpAuthService();
  });

  OrderBloc buildBloc() => OrderBloc(mockRepository, mockStepUpAuth);

  group('OrderBloc', () {
    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state.isLoading, false);
      expect(bloc.state.isProcessing, false);
      expect(bloc.state.buyerOrders, isEmpty);
      expect(bloc.state.sellerOrders, isEmpty);
      bloc.close();
    });

    group('LoadBuyerOrders', () {
      blocTest<OrderBloc, OrderState>(
        'emits [loading, loaded] when getBuyerOrders succeeds',
        build: () {
          when(() => mockRepository.getBuyerOrders())
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadBuyerOrders()),
        expect: () => [
          isA<OrderState>().having((s) => s.isLoading, 'isLoading', true),
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.buyerOrders, 'buyerOrders', isEmpty),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when getBuyerOrders fails',
        build: () {
          when(() => mockRepository.getBuyerOrders())
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadBuyerOrders()),
        expect: () => [
          isA<OrderState>().having((s) => s.isLoading, 'isLoading', true),
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('LoadSellerOrders', () {
      blocTest<OrderBloc, OrderState>(
        'emits [loading, loaded] when getSellerOrders succeeds',
        build: () {
          when(() => mockRepository.getSellerOrders())
              .thenAnswer((_) async => const Right([]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadSellerOrders()),
        expect: () => [
          isA<OrderState>().having((s) => s.isLoading, 'isLoading', true),
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.sellerOrders, 'sellerOrders', isEmpty),
        ],
      );
    });

    group('BuyItem', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent buys',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.buyItem(
          listingId: 'l1',
          walletId: 'w1',
        )),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success when buy succeeds with no step-up required',
        build: () {
          when(() => mockStepUpAuth.evaluateRequired(
            actionType: any(named: 'actionType'),
            amount: any(named: 'amount'),
            riskEvents: any(named: 'riskEvents'),
          )).thenReturn(StepUpResult.notRequired);
          when(() => mockRepository.buyItem(
            listingId: any(named: 'listingId'),
            walletId: any(named: 'walletId'),
          )).thenAnswer((_) async => const Right('order1'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.buyItem(
          listingId: 'l1',
          walletId: 'w1',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when step-up auth is cancelled',
        build: () {
          when(() => mockStepUpAuth.evaluateRequired(
            actionType: any(named: 'actionType'),
            amount: any(named: 'amount'),
            riskEvents: any(named: 'riskEvents'),
          )).thenReturn(StepUpResult.biometricVerified);
          when(() => mockStepUpAuth.performBiometricStepUp())
              .thenAnswer((_) async => StepUpResult.cancelled);
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.buyItem(
          listingId: 'l1',
          walletId: 'w1',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', 'Authentication required'),
        ],
      );
    });

    group('ConfirmFulfilment', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent confirms',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.confirmFulfilment('o1')),
        expect: () => [],
      );
    });

    group('ConfirmReceipt', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent confirms',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.confirmReceipt('o1')),
        expect: () => [],
      );
    });

    group('ClearMessages', () {
      blocTest<OrderBloc, OrderState>(
        'clears all messages',
        build: () => buildBloc(),
        seed: () => const OrderState(errorMessage: 'err', successMessage: 'ok'),
        act: (bloc) => bloc.add(const OrderEvent.clearMessages()),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull),
        ],
      );
    });
  });
}
