import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/security/step_up_auth_service.dart';
import '../../../domain/entities/buy_order.dart';
import '../../../domain/entities/marketplace_offer.dart';
import '../../../domain/repositories/marketplace_repository.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

/// Handles marketplace order lifecycle (buy, confirm, dispute, vouch).
///
/// Intentionally depends on [MarketplaceRepository] because orders are a
/// first-class marketplace concept — the order entity, escrow flow, and
/// fulfilment confirmation all live within the marketplace bounded context.
@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final MarketplaceRepository _repository;
  final StepUpAuthService _stepUpAuthService;

  OrderBloc(this._repository, this._stepUpAuthService)
      : super(const OrderState()) {
    on<_LoadBuyerOrders>(_onLoadBuyerOrders);
    on<_LoadSellerOrders>(_onLoadSellerOrders);
    on<_SelectOrder>(_onSelectOrder);
    on<_BuyItem>(_onBuyItem);
    on<_ConfirmFulfilment>(_onConfirmFulfilment);
    on<_ConfirmReceipt>(_onConfirmReceipt);
    on<_CancelOrder>(_onCancelOrder);
    on<_DisputeOrder>(_onDisputeOrder);
    on<_VouchForProvider>(_onVouchForProvider);
    on<_LoadLinkedOffer>(_onLoadLinkedOffer);
    on<_ClearMessages>(_onClearMessages);
  }

  Future<void> _onLoadBuyerOrders(
    _LoadBuyerOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _repository.getBuyerOrders();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (orders) => emit(state.copyWith(
        isLoading: false,
        buyerOrders: orders,
      )),
    );
  }

  Future<void> _onLoadSellerOrders(
    _LoadSellerOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _repository.getSellerOrders();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      )),
      (orders) => emit(state.copyWith(
        isLoading: false,
        sellerOrders: orders,
      )),
    );
  }

  Future<void> _onSelectOrder(
    _SelectOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoadingDetail: true, selectedOrder: null));

    final result = await _repository.getOrder(event.orderId);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingDetail: false,
        errorMessage: failure.displayMessage,
      )),
      (order) => emit(state.copyWith(
        isLoadingDetail: false,
        selectedOrder: order,
      )),
    );
  }

  Future<void> _onBuyItem(
    _BuyItem event,
    Emitter<OrderState> emit,
  ) async {
    // Double-submit guard
    if (state.isProcessing) return;

    emit(state.copyWith(isProcessing: true, errorMessage: null));

    // Step-up auth before marketplace purchase
    final stepUpRequired = _stepUpAuthService.evaluateRequired(
      actionType: 'marketplace_purchase',
    );
    if (stepUpRequired == StepUpResult.biometricVerified ||
        stepUpRequired == StepUpResult.otpRequired) {
      final authResult = await _stepUpAuthService.performBiometricStepUp();
      if (authResult == StepUpResult.cancelled ||
          authResult == StepUpResult.failed) {
        emit(state.copyWith(
          isProcessing: false,
          errorMessage: 'Authentication required',
        ));
        return;
      }
      if (authResult == StepUpResult.otpRequired) {
        // Device lacks biometric capability. Direct user to enable device
        // security (PIN/pattern/fingerprint) in system settings before
        // retrying the purchase.
        emit(state.copyWith(
          isProcessing: false,
          errorMessage:
              'Identity verification required. Please enable biometric or screen lock in your device settings and try again.',
        ));
        return;
      }
    }

    final result = await _repository.buyItem(
      listingId: event.listingId,
      walletId: event.walletId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isProcessing: false,
        errorMessage: failure.displayMessage,
      )),
      (orderId) => emit(state.copyWith(
        isProcessing: false,
        successMessage: 'Order placed successfully',
      )),
    );
  }

  Future<void> _onConfirmFulfilment(
    _ConfirmFulfilment event,
    Emitter<OrderState> emit,
  ) async {
    if (state.isProcessing) return;
    emit(state.copyWith(isProcessing: true, errorMessage: null));

    final result = await _repository.confirmFulfilment(event.orderId);

    result.fold(
      (failure) => emit(state.copyWith(
        isProcessing: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isProcessing: false,
        successMessage: 'Marked as fulfilled',
      )),
    );

    if (result.isRight()) {
      await _refreshSelectedOrder(event.orderId, emit);
    }
  }

  Future<void> _onConfirmReceipt(
    _ConfirmReceipt event,
    Emitter<OrderState> emit,
  ) async {
    if (state.isProcessing) return;
    emit(state.copyWith(isProcessing: true, errorMessage: null));

    final result = await _repository.confirmReceipt(event.orderId);

    result.fold(
      (failure) => emit(state.copyWith(
        isProcessing: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isProcessing: false,
        successMessage: 'Receipt confirmed — payment released to seller',
      )),
    );

    if (result.isRight()) {
      await _refreshSelectedOrder(event.orderId, emit);
    }
  }

  Future<void> _onCancelOrder(
    _CancelOrder event,
    Emitter<OrderState> emit,
  ) async {
    if (state.isProcessing) return;
    emit(state.copyWith(isProcessing: true, errorMessage: null));

    final result = await _repository.cancelOrder(event.orderId);

    result.fold(
      (failure) => emit(state.copyWith(
        isProcessing: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isProcessing: false,
        successMessage: 'Order cancelled — tokens refunded',
      )),
    );

    if (result.isRight()) {
      await _refreshSelectedOrder(event.orderId, emit);
    }
  }

  Future<void> _onDisputeOrder(
    _DisputeOrder event,
    Emitter<OrderState> emit,
  ) async {
    if (state.isProcessing) return;
    emit(state.copyWith(isProcessing: true, errorMessage: null));

    final result = await _repository.disputeOrder(
      event.orderId,
      event.reason,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isProcessing: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isProcessing: false,
        successMessage: 'Dispute raised — an admin will review',
      )),
    );

    if (result.isRight()) {
      await _refreshSelectedOrder(event.orderId, emit);
    }
  }

  Future<void> _onVouchForProvider(
    _VouchForProvider event,
    Emitter<OrderState> emit,
  ) async {
    if (state.isProcessing) return;
    emit(state.copyWith(isProcessing: true, errorMessage: null));

    final result = await _repository.vouchForProvider(
      providerId: event.providerId,
      orderId: event.orderId,
      rating: event.rating,
      comment: event.comment,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isProcessing: false,
        errorMessage: failure.displayMessage,
      )),
      (_) => emit(state.copyWith(
        isProcessing: false,
        successMessage: 'Vouch submitted — thank you!',
      )),
    );
  }

  Future<void> _onLoadLinkedOffer(
    _LoadLinkedOffer event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _repository.getOffer(event.offerId);
    result.fold(
      (_) {}, // Non-critical — offer data is supplementary
      (offer) => emit(state.copyWith(linkedOffer: offer)),
    );
  }

  Future<void> _onClearMessages(
    _ClearMessages event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(
      errorMessage: null,
      successMessage: null,
    ));
  }

  /// Refresh the selected order from the server after a successful mutation
  /// to ensure the UI shows authoritative data (not stale optimistic state).
  Future<void> _refreshSelectedOrder(
    String orderId,
    Emitter<OrderState> emit,
  ) async {
    final result = await _repository.getOrder(orderId);
    result.fold(
      (_) {}, // Non-critical — keep existing optimistic update
      (order) => emit(state.copyWith(selectedOrder: order)),
    );
  }
}
