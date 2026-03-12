import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/security/step_up_auth_service.dart';
import '../../../domain/entities/purchase.dart';
import '../../../domain/entities/service_provider.dart';
import '../../../domain/repositories/purchase_repository.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';
part 'purchase_bloc.freezed.dart';

@injectable
class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final PurchaseRepository _purchaseRepository;
  final StepUpAuthService _stepUpAuthService;

  PurchaseBloc(this._purchaseRepository, this._stepUpAuthService)
      : super(const PurchaseState()) {
    on<_LoadProviders>(_onLoadProviders);
    on<_LoadProvidersByCategory>(_onLoadProvidersByCategory);
    on<_SelectCategory>(_onSelectCategory);
    on<_SelectProvider>(_onSelectProvider);
    on<_LoadProducts>(_onLoadProducts);
    on<_SelectProduct>(_onSelectProduct);
    on<_SetRecipientNumber>(_onSetRecipientNumber);
    on<_ValidateRecipient>(_onValidateRecipient);
    on<_MakePurchase>(_onMakePurchase);
    on<_LoadHistory>(_onLoadHistory);
    on<_LoadRecentRecipients>(_onLoadRecentRecipients);
    on<_SelectRecentRecipient>(_onSelectRecentRecipient);
    on<_ResetSelection>(_onResetSelection);
    on<_ClearError>(_onClearError);
    on<_ClearSuccess>(_onClearSuccess);
  }

  Future<void> _onLoadProviders(
    _LoadProviders event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoadingProviders: true));

    final result = await _purchaseRepository.getServiceProviders();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingProviders: false,
        errorMessage: failure.displayMessage,
      )),
      (providers) => emit(state.copyWith(
        isLoadingProviders: false,
        providers: providers,
      )),
    );
  }

  Future<void> _onLoadProvidersByCategory(
    _LoadProvidersByCategory event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoadingProviders: true));

    final result =
        await _purchaseRepository.getProvidersByCategory(event.category);
    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingProviders: false,
        errorMessage: failure.displayMessage,
      )),
      (providers) => emit(state.copyWith(
        isLoadingProviders: false,
        providers: providers,
        selectedCategory: event.category,
      )),
    );
  }

  void _onSelectCategory(
    _SelectCategory event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(
      selectedCategory: event.category,
      selectedProvider: null,
      selectedProduct: null,
      products: [],
    ));

    if (event.category != null) {
      add(PurchaseEvent.loadProvidersByCategory(event.category!));
    } else {
      add(const PurchaseEvent.loadProviders());
    }
  }

  void _onSelectProvider(
    _SelectProvider event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(
      selectedProvider: event.provider,
      selectedProduct: null,
      products: [],
    ));
    add(PurchaseEvent.loadProducts(event.provider.id));
    add(PurchaseEvent.loadRecentRecipients(
      category: event.provider.category,
    ));
  }

  Future<void> _onLoadProducts(
    _LoadProducts event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoadingProducts: true));

    final result = await _purchaseRepository.getProducts(event.providerId);
    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingProducts: false,
        errorMessage: failure.displayMessage,
      )),
      (products) => emit(state.copyWith(
        isLoadingProducts: false,
        products: products,
      )),
    );
  }

  void _onSelectProduct(
    _SelectProduct event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(selectedProduct: event.product));
  }

  void _onSetRecipientNumber(
    _SetRecipientNumber event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(
      recipientNumber: event.number,
      isRecipientValid: null,
    ));
  }

  Future<void> _onValidateRecipient(
    _ValidateRecipient event,
    Emitter<PurchaseState> emit,
  ) async {
    if (state.recipientNumber == null || state.recipientNumber!.isEmpty) {
      emit(state.copyWith(isRecipientValid: false));
      return;
    }

    emit(state.copyWith(isValidating: true));

    final category = state.selectedProvider?.category ?? PurchaseCategory.airtime;
    final result = await _purchaseRepository.validateRecipientNumber(
      number: state.recipientNumber!,
      category: category,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isValidating: false,
        isRecipientValid: false,
      )),
      (isValid) => emit(state.copyWith(
        isValidating: false,
        isRecipientValid: isValid,
      )),
    );
  }

  Future<void> _onMakePurchase(
    _MakePurchase event,
    Emitter<PurchaseState> emit,
  ) async {
    // Double-submit guard — prevent double-charging
    if (state.isPurchasing) return;

    if (state.selectedProduct == null || state.recipientNumber == null) {
      emit(state.copyWith(
        errorMessage: 'Please select a product and enter a recipient number',
      ));
      return;
    }

    // Block purchase if recipient hasn't been validated yet
    if (state.isRecipientValid != true) {
      emit(state.copyWith(
        errorMessage: 'Please validate the recipient number before purchasing',
      ));
      return;
    }

    emit(state.copyWith(isPurchasing: true));

    // Step-up auth before VAS purchase
    final stepUpRequired = _stepUpAuthService.evaluateRequired(
      actionType: 'vas_purchase',
    );
    if (stepUpRequired == StepUpResult.biometricVerified ||
        stepUpRequired == StepUpResult.otpRequired) {
      final authResult = await _stepUpAuthService.performBiometricStepUp();
      if (authResult == StepUpResult.cancelled ||
          authResult == StepUpResult.failed) {
        emit(state.copyWith(
          isPurchasing: false,
          errorMessage: 'Authentication required',
        ));
        return;
      }
    }

    final result = await _purchaseRepository.makePurchase(
      productId: state.selectedProduct!.id,
      recipientNumber: state.recipientNumber!,
      subAccountId: event.subAccountId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isPurchasing: false,
        errorMessage: failure.displayMessage,
      )),
      (purchase) => emit(state.copyWith(
        isPurchasing: false,
        lastPurchase: purchase,
        successMessage: 'Purchase successful! ${purchase.productName} sent to ${purchase.recipientNumber}',
        // Reset selection after successful purchase
        selectedProduct: null,
        recipientNumber: null,
        isRecipientValid: null,
      )),
    );
  }

  Future<void> _onLoadHistory(
    _LoadHistory event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(state.copyWith(isLoadingHistory: true));

    final result = await _purchaseRepository.getPurchaseHistory(
      category: event.category,
      limit: event.limit,
      startAfter: event.startAfter,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingHistory: false,
        errorMessage: failure.displayMessage,
      )),
      (purchases) {
        final allHistory = event.startAfter != null
            ? [...state.history, ...purchases]
            : purchases;
        emit(state.copyWith(
          isLoadingHistory: false,
          history: allHistory,
          hasMoreHistory: purchases.length >= (event.limit ?? 20),
        ));
      },
    );
  }

  Future<void> _onLoadRecentRecipients(
    _LoadRecentRecipients event,
    Emitter<PurchaseState> emit,
  ) async {
    final result = await _purchaseRepository.getRecentRecipients(
      category: event.category,
      limit: 5,
    );

    result.fold(
      (failure) {}, // Silently fail for recent recipients
      (recipients) => emit(state.copyWith(recentRecipients: recipients)),
    );
  }

  void _onSelectRecentRecipient(
    _SelectRecentRecipient event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(
      recipientNumber: event.number,
      isRecipientValid: true,
    ));
  }

  void _onResetSelection(
    _ResetSelection event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(
      selectedProvider: null,
      selectedProduct: null,
      products: [],
      recipientNumber: null,
      isRecipientValid: null,
      recentRecipients: [],
    ));
  }

  void _onClearError(
    _ClearError event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  void _onClearSuccess(
    _ClearSuccess event,
    Emitter<PurchaseState> emit,
  ) {
    emit(state.copyWith(successMessage: null));
  }
}
