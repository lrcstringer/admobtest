import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/security/step_up_auth_service.dart';
import 'package:imalichat/domain/entities/buy_order.dart';
import 'package:imalichat/domain/entities/marketplace_offer.dart';
import 'package:imalichat/domain/enums/offer_status.dart';
import 'package:imalichat/domain/enums/order_status.dart';
import 'package:imalichat/domain/repositories/marketplace_repository.dart';
import 'package:imalichat/presentation/blocs/order/order_bloc.dart';

class MockMarketplaceRepository extends Mock implements MarketplaceRepository {}

class MockStepUpAuthService extends Mock implements StepUpAuthService {}

void main() {
  late MockMarketplaceRepository mockRepository;
  late MockStepUpAuthService mockStepUpAuth;

  final now = DateTime(2026, 3, 13);

  final testOrder = BuyOrder(
    id: 'o1',
    buyerId: 'b1',
    buyerName: 'Buyer',
    sellerId: 's1',
    sellerName: 'Seller',
    listingId: 'l1',
    listingTitle: 'Test Listing',
    amount: 100,
    amountZar: 1.0,
    status: OrderStatus.pending,
    createdAt: now,
  );

  final fulfilledOrder = testOrder.copyWith(status: OrderStatus.fulfilled);

  final testOffer = MarketplaceOffer(
    id: 'of1',
    listingId: 'l1',
    buyerId: 'b1',
    sellerId: 's1',
    offerAmount: 50,
    originalPrice: 100,
    status: OfferStatus.pending,
    createdAt: now,
  );

  setUp(() {
    mockRepository = MockMarketplaceRepository();
    mockStepUpAuth = MockStepUpAuthService();
  });

  OrderBloc buildBloc() => OrderBloc(mockRepository, mockStepUpAuth);

  /// Helper: stub getOrder for refresh-after-mutation flows.
  void stubGetOrder([BuyOrder? order]) {
    when(() => mockRepository.getOrder(any()))
        .thenAnswer((_) async => Right(order ?? fulfilledOrder));
  }

  group('OrderBloc', () {
    // ─── Initial state ───────────────────────────────────────────────

    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state.isLoading, false);
      expect(bloc.state.isLoadingDetail, false);
      expect(bloc.state.isProcessing, false);
      expect(bloc.state.buyerOrders, isEmpty);
      expect(bloc.state.sellerOrders, isEmpty);
      expect(bloc.state.selectedOrder, isNull);
      expect(bloc.state.linkedOffer, isNull);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.successMessage, isNull);
      bloc.close();
    });

    // ─── LoadBuyerOrders ─────────────────────────────────────────────

    group('LoadBuyerOrders', () {
      blocTest<OrderBloc, OrderState>(
        'emits [loading, loaded] when getBuyerOrders succeeds',
        build: () {
          when(() => mockRepository.getBuyerOrders())
              .thenAnswer((_) async => Right([testOrder]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadBuyerOrders()),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.buyerOrders, 'buyerOrders', [testOrder]),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits empty list when no buyer orders exist',
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

    // ─── LoadSellerOrders ────────────────────────────────────────────

    group('LoadSellerOrders', () {
      blocTest<OrderBloc, OrderState>(
        'emits [loading, loaded] when getSellerOrders succeeds',
        build: () {
          when(() => mockRepository.getSellerOrders())
              .thenAnswer((_) async => Right([testOrder]));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadSellerOrders()),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.sellerOrders, 'sellerOrders', [testOrder]),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when getSellerOrders fails',
        build: () {
          when(() => mockRepository.getSellerOrders())
              .thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadSellerOrders()),
        expect: () => [
          isA<OrderState>().having((s) => s.isLoading, 'isLoading', true),
          isA<OrderState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ─── SelectOrder ─────────────────────────────────────────────────

    group('SelectOrder', () {
      blocTest<OrderBloc, OrderState>(
        'emits [loadingDetail, selectedOrder] when getOrder succeeds',
        build: () {
          when(() => mockRepository.getOrder('o1'))
              .thenAnswer((_) async => Right(testOrder));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.selectOrder('o1')),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true)
              .having((s) => s.selectedOrder, 'selectedOrder', isNull),
          isA<OrderState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.selectedOrder, 'selectedOrder', testOrder),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when getOrder fails',
        build: () {
          when(() => mockRepository.getOrder('o1'))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.selectOrder('o1')),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<OrderState>()
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'clears previously selected order before loading new one',
        build: () {
          when(() => mockRepository.getOrder('o2'))
              .thenAnswer((_) async => Right(testOrder));
          return buildBloc();
        },
        seed: () => OrderState(selectedOrder: testOrder),
        act: (bloc) => bloc.add(const OrderEvent.selectOrder('o2')),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', isNull)
              .having((s) => s.isLoadingDetail, 'isLoadingDetail', true),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', testOrder),
        ],
      );
    });

    // ─── BuyItem ─────────────────────────────────────────────────────

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
        'emits success when step-up is not required',
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
              .having((s) => s.successMessage, 'successMessage',
                  'Order placed successfully'),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success after passing biometric step-up',
        build: () {
          when(() => mockStepUpAuth.evaluateRequired(
                actionType: any(named: 'actionType'),
                amount: any(named: 'amount'),
                riskEvents: any(named: 'riskEvents'),
              )).thenReturn(StepUpResult.biometricVerified);
          when(() => mockStepUpAuth.performBiometricStepUp())
              .thenAnswer((_) async => StepUpResult.biometricVerified);
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
        'emits error when biometric step-up is cancelled',
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
              .having(
                  (s) => s.errorMessage, 'errorMessage', 'Authentication required'),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when biometric step-up fails',
        build: () {
          when(() => mockStepUpAuth.evaluateRequired(
                actionType: any(named: 'actionType'),
                amount: any(named: 'amount'),
                riskEvents: any(named: 'riskEvents'),
              )).thenReturn(StepUpResult.otpRequired);
          when(() => mockStepUpAuth.performBiometricStepUp())
              .thenAnswer((_) async => StepUpResult.failed);
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
              .having(
                  (s) => s.errorMessage, 'errorMessage', 'Authentication required'),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits device-settings error when biometric returns otpRequired',
        build: () {
          when(() => mockStepUpAuth.evaluateRequired(
                actionType: any(named: 'actionType'),
                amount: any(named: 'amount'),
                riskEvents: any(named: 'riskEvents'),
              )).thenReturn(StepUpResult.biometricVerified);
          when(() => mockStepUpAuth.performBiometricStepUp())
              .thenAnswer((_) async => StepUpResult.otpRequired);
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
              .having((s) => s.errorMessage, 'errorMessage',
                  contains('device settings')),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when buyItem repository call fails',
        build: () {
          when(() => mockStepUpAuth.evaluateRequired(
                actionType: any(named: 'actionType'),
                amount: any(named: 'amount'),
                riskEvents: any(named: 'riskEvents'),
              )).thenReturn(StepUpResult.notRequired);
          when(() => mockRepository.buyItem(
                listingId: any(named: 'listingId'),
                walletId: any(named: 'walletId'),
              )).thenAnswer(
              (_) async => const Left(Failure.insufficientBalance()));
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
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // ─── ConfirmFulfilment ───────────────────────────────────────────

    group('ConfirmFulfilment', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent confirms',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) =>
            bloc.add(const OrderEvent.confirmFulfilment('o1')),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success and refreshes selected order on success',
        build: () {
          when(() => mockRepository.confirmFulfilment(any()))
              .thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const OrderEvent.confirmFulfilment('o1')),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  'Marked as fulfilled'),
          // Refresh emits updated selectedOrder
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', fulfilledOrder),
        ],
        verify: (_) {
          verify(() => mockRepository.getOrder('o1')).called(1);
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when confirmFulfilment fails',
        build: () {
          when(() => mockRepository.confirmFulfilment(any()))
              .thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const OrderEvent.confirmFulfilment('o1')),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── ConfirmReceipt ──────────────────────────────────────────────

    group('ConfirmReceipt', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent confirms',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) =>
            bloc.add(const OrderEvent.confirmReceipt('o1')),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success and refreshes selected order on success',
        build: () {
          when(() => mockRepository.confirmReceipt(any()))
              .thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const OrderEvent.confirmReceipt('o1')),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  contains('Receipt confirmed')),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', fulfilledOrder),
        ],
        verify: (_) {
          verify(() => mockRepository.getOrder('o1')).called(1);
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when confirmReceipt fails',
        build: () {
          when(() => mockRepository.confirmReceipt(any()))
              .thenAnswer((_) async => const Left(Failure.timeout()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const OrderEvent.confirmReceipt('o1')),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── CancelOrder ─────────────────────────────────────────────────

    group('CancelOrder', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent cancels',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) =>
            bloc.add(const OrderEvent.cancelOrder('o1')),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success and refreshes selected order on success',
        build: () {
          when(() => mockRepository.cancelOrder(any()))
              .thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const OrderEvent.cancelOrder('o1')),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  contains('cancelled')),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', fulfilledOrder),
        ],
        verify: (_) {
          verify(() => mockRepository.getOrder('o1')).called(1);
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when cancelOrder fails',
        build: () {
          when(() => mockRepository.cancelOrder(any()))
              .thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const OrderEvent.cancelOrder('o1')),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── DisputeOrder ────────────────────────────────────────────────

    group('DisputeOrder', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent disputes',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.disputeOrder(
          orderId: 'o1',
          reason: 'Item not received',
        )),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success and refreshes selected order on success',
        build: () {
          when(() => mockRepository.disputeOrder(any(), any()))
              .thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.disputeOrder(
          orderId: 'o1',
          reason: 'Item not received',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  contains('Dispute raised')),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', fulfilledOrder),
        ],
        verify: (_) {
          verify(() => mockRepository.disputeOrder('o1', 'Item not received'))
              .called(1);
          verify(() => mockRepository.getOrder('o1')).called(1);
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when disputeOrder fails',
        build: () {
          when(() => mockRepository.disputeOrder(any(), any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.disputeOrder(
          orderId: 'o1',
          reason: 'Item not received',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── VouchForProvider ────────────────────────────────────────────

    group('VouchForProvider', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent vouches',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.vouchForProvider(
          providerId: 's1',
          orderId: 'o1',
          rating: 5,
          comment: 'Great seller',
        )),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success on successful vouch without refreshing order',
        build: () {
          when(() => mockRepository.vouchForProvider(
                providerId: any(named: 'providerId'),
                orderId: any(named: 'orderId'),
                rating: any(named: 'rating'),
                comment: any(named: 'comment'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.vouchForProvider(
          providerId: 's1',
          orderId: 'o1',
          rating: 5,
          comment: 'Great seller',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  contains('Vouch submitted')),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits success when comment is null',
        build: () {
          when(() => mockRepository.vouchForProvider(
                providerId: any(named: 'providerId'),
                orderId: any(named: 'orderId'),
                rating: any(named: 'rating'),
                comment: any(named: 'comment'),
              )).thenAnswer((_) async => const Right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.vouchForProvider(
          providerId: 's1',
          orderId: 'o1',
          rating: 3,
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage', isNotNull),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when vouchForProvider fails',
        build: () {
          when(() => mockRepository.vouchForProvider(
                providerId: any(named: 'providerId'),
                orderId: any(named: 'orderId'),
                rating: any(named: 'rating'),
                comment: any(named: 'comment'),
              )).thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.vouchForProvider(
          providerId: 's1',
          orderId: 'o1',
          rating: 5,
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── LoadLinkedOffer ─────────────────────────────────────────────

    group('LoadLinkedOffer', () {
      blocTest<OrderBloc, OrderState>(
        'emits linkedOffer when getOffer succeeds',
        build: () {
          when(() => mockRepository.getOffer(any()))
              .thenAnswer((_) async => Right(testOffer));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadLinkedOffer('of1')),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.linkedOffer, 'linkedOffer', testOffer),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'silently ignores failure (no error emitted)',
        build: () {
          when(() => mockRepository.getOffer(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.loadLinkedOffer('of1')),
        expect: () => [],
      );
    });

    // ─── RespondToDispute ────────────────────────────────────────────

    group('RespondToDispute', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent responses',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.respondToDispute(
          orderId: 'o1',
          response: 'I shipped it on time',
        )),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success and refreshes order on success',
        build: () {
          when(() => mockRepository.respondToDispute(
                orderId: any(named: 'orderId'),
                response: any(named: 'response'),
                photoUrls: any(named: 'photoUrls'),
                proposedResolution: any(named: 'proposedResolution'),
                proposedResolutionAmount:
                    any(named: 'proposedResolutionAmount'),
              )).thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.respondToDispute(
          orderId: 'o1',
          response: 'I shipped it on time',
          photoUrls: ['https://example.com/proof.jpg'],
          proposedResolution: 'partial_refund',
          proposedResolutionAmount: 50,
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  'Dispute response submitted'),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', fulfilledOrder),
        ],
        verify: (_) {
          verify(() => mockRepository.getOrder('o1')).called(1);
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when respondToDispute fails',
        build: () {
          when(() => mockRepository.respondToDispute(
                orderId: any(named: 'orderId'),
                response: any(named: 'response'),
                photoUrls: any(named: 'photoUrls'),
                proposedResolution: any(named: 'proposedResolution'),
                proposedResolutionAmount:
                    any(named: 'proposedResolutionAmount'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.respondToDispute(
          orderId: 'o1',
          response: 'I shipped it on time',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── AddDisputeEvidence ──────────────────────────────────────────

    group('AddDisputeEvidence', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent evidence uploads',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.addDisputeEvidence(
          orderId: 'o1',
          photoUrls: ['https://example.com/photo.jpg'],
        )),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success and refreshes order on success',
        build: () {
          when(() => mockRepository.addDisputeEvidence(
                orderId: any(named: 'orderId'),
                photoUrls: any(named: 'photoUrls'),
                additionalDetails: any(named: 'additionalDetails'),
              )).thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.addDisputeEvidence(
          orderId: 'o1',
          photoUrls: ['https://example.com/photo.jpg'],
          additionalDetails: 'Here is more proof',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  'Evidence added to dispute'),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', fulfilledOrder),
        ],
        verify: (_) {
          verify(() => mockRepository.getOrder('o1')).called(1);
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when addDisputeEvidence fails',
        build: () {
          when(() => mockRepository.addDisputeEvidence(
                orderId: any(named: 'orderId'),
                photoUrls: any(named: 'photoUrls'),
                additionalDetails: any(named: 'additionalDetails'),
              )).thenAnswer((_) async => const Left(Failure.serverError()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.addDisputeEvidence(
          orderId: 'o1',
          photoUrls: ['https://example.com/photo.jpg'],
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── ProposeResolution ───────────────────────────────────────────

    group('ProposeResolution', () {
      blocTest<OrderBloc, OrderState>(
        'double-submit guard prevents concurrent proposals',
        build: () => buildBloc(),
        seed: () => const OrderState(isProcessing: true),
        act: (bloc) => bloc.add(const OrderEvent.proposeResolution(
          orderId: 'o1',
          resolutionType: 'full_refund',
        )),
        expect: () => [],
      );

      blocTest<OrderBloc, OrderState>(
        'emits success and refreshes order on success',
        build: () {
          when(() => mockRepository.proposeResolution(
                orderId: any(named: 'orderId'),
                resolutionType: any(named: 'resolutionType'),
                refundAmount: any(named: 'refundAmount'),
              )).thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.proposeResolution(
          orderId: 'o1',
          resolutionType: 'partial_refund',
          refundAmount: 50,
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  'Resolution proposed'),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', fulfilledOrder),
        ],
        verify: (_) {
          verify(() => mockRepository.getOrder('o1')).called(1);
        },
      );

      blocTest<OrderBloc, OrderState>(
        'emits success with null refundAmount for full refund',
        build: () {
          when(() => mockRepository.proposeResolution(
                orderId: any(named: 'orderId'),
                resolutionType: any(named: 'resolutionType'),
                refundAmount: any(named: 'refundAmount'),
              )).thenAnswer((_) async => const Right(null));
          stubGetOrder();
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.proposeResolution(
          orderId: 'o1',
          resolutionType: 'full_refund',
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  'Resolution proposed'),
          isA<OrderState>()
              .having((s) => s.selectedOrder, 'selectedOrder', isNotNull),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'emits error when proposeResolution fails',
        build: () {
          when(() => mockRepository.proposeResolution(
                orderId: any(named: 'orderId'),
                resolutionType: any(named: 'resolutionType'),
                refundAmount: any(named: 'refundAmount'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const OrderEvent.proposeResolution(
          orderId: 'o1',
          resolutionType: 'partial_refund',
          refundAmount: 50,
        )),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.getOrder(any()));
        },
      );
    });

    // ─── ClearMessages ───────────────────────────────────────────────

    group('ClearMessages', () {
      blocTest<OrderBloc, OrderState>(
        'clears both error and success messages',
        build: () => buildBloc(),
        seed: () =>
            const OrderState(errorMessage: 'err', successMessage: 'ok'),
        act: (bloc) => bloc.add(const OrderEvent.clearMessages()),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull),
        ],
      );

      blocTest<OrderBloc, OrderState>(
        'no-op when messages are already null (still emits due to copyWith)',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(const OrderEvent.clearMessages()),
        expect: () => [
          isA<OrderState>()
              .having((s) => s.errorMessage, 'errorMessage', isNull)
              .having((s) => s.successMessage, 'successMessage', isNull),
        ],
      );
    });

    // ─── Refresh failure is silent ───────────────────────────────────

    group('_refreshSelectedOrder silent failure', () {
      blocTest<OrderBloc, OrderState>(
        'keeps success message even when refresh getOrder fails',
        build: () {
          when(() => mockRepository.confirmFulfilment(any()))
              .thenAnswer((_) async => const Right(null));
          when(() => mockRepository.getOrder(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return buildBloc();
        },
        act: (bloc) =>
            bloc.add(const OrderEvent.confirmFulfilment('o1')),
        expect: () => [
          isA<OrderState>().having((s) => s.isProcessing, 'isProcessing', true),
          isA<OrderState>()
              .having((s) => s.isProcessing, 'isProcessing', false)
              .having((s) => s.successMessage, 'successMessage',
                  'Marked as fulfilled'),
          // No additional state emitted — refresh failure is silent
        ],
      );
    });
  });
}
